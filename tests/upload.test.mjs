import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { mkdtemp, rm, writeFile } from 'node:fs/promises';
import { createServer, request } from 'node:http';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { test } from 'node:test';
import { inspect, send } from '../skills/contentfactory-assets/scripts/upload.mjs';

test('stream exact bytes, omit OAuth, verify owner receipt and refuse redirects', async t => {
  const directory = await mkdtemp(join(tmpdir(), 'cf-upload-'));
  t.after(() => rm(directory, { recursive: true, force: true }));
  const path = join(directory, 'fixture.wav');
  const bytes = Buffer.alloc(1024 * 1024, 31);
  await writeFile(path, bytes, { mode: 0o600 });
  const command = await inspect(path, { projectId: 'project', name: 'fixture', contentType: 'audio/wav', idempotencyKey: 'key' }, bytes.length);
  assert.equal(command.sha256, createHash('sha256').update(bytes).digest('hex'));
  const asset = { id: 'asset', projectId: 'project', files: [{ id: 'file', ...command }] };
  let calls = 0, status = 200, damage = false;
  const server = createServer(async (req, res) => {
    calls++;
    assert.equal(req.headers.authorization, undefined);
    assert.equal(req.headers['content-length'], String(bytes.length));
    const hash = createHash('sha256');
    for await (const chunk of req) hash.update(chunk);
    assert.equal(hash.digest('hex'), command.sha256);
    res.writeHead(status, { 'Content-Type': 'application/json', Location: 'https://untrusted.invalid/private-ticket' });
    res.end(JSON.stringify(damage ? { ...asset, files: [] } : asset));
  });
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  t.after(() => new Promise(resolve => server.close(resolve)));
  const endpoint = 'https://resource.example/mcp';
  const ticket = { url: endpoint + '/transfer?ticket=private-ticket', method: 'POST',
    maximumBytes: bytes.length, expiresAt: new Date(Date.now() + 60000).toISOString() };
  // Isolated transport enters a real listener; production CLI cannot change its origin.
  const transport = (url, options) => request(`http://127.0.0.1:${server.address().port}${url.pathname}${url.search}`, options);
  assert.deepEqual(await send(path, ticket, command, endpoint, transport), asset);
  for (const change of [
    { url: 'https://untrusted.invalid/mcp/transfer?ticket=private-ticket' },
    { url: endpoint + '/transfer?ticket=private-ticket&ticket=again' },
    { url: endpoint + '/transfer?ticket=private-ticket#fragment' },
    { url: endpoint + '/other?ticket=private-ticket' },
    { expiresAt: new Date(0).toISOString() }, { method: 'GET' }, { maximumBytes: 1 }
  ]) {
    await assert.rejects(send(path, { ...ticket, ...change }, command, endpoint, transport), error => !error.message.includes('private-ticket'));
  }
  assert.equal(calls, 1, 'invalid tickets never open a connection');
  await assert.rejects(send(path, ticket, { ...command, sha256: '0'.repeat(64) }, endpoint, transport));
  assert.equal(calls, 1, 'changed source metadata is refused before network admission');
  status = 302;
  await assert.rejects(send(path, ticket, command, endpoint, transport), /HTTP 302/);
  assert.equal(calls, 2, 'redirect was not followed');
  status = 200; damage = true;
  await assert.rejects(send(path, ticket, command, endpoint, transport), /receipt mismatch/);
});

test('inspection applies discovered limits without consuming an unbounded source', async t => {
  const directory = await mkdtemp(join(tmpdir(), 'cf-inspect-'));
  t.after(() => rm(directory, { recursive: true, force: true }));
  const path = join(directory, 'fixture.wav');
  await writeFile(path, 'source');
  for (const maximum of [0, -1, 2, Infinity, Number.MAX_SAFE_INTEGER + 1]) {
    await assert.rejects(inspect(path, {}, maximum));
  }
});
