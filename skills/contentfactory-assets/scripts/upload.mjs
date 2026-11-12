#!/usr/bin/env node
// File transport only: MCP owns authorization, preparation and receipt recovery.
import { createHash } from 'node:crypto';
import { open } from 'node:fs/promises';
import { request as httpsRequest } from 'node:https';
import { basename } from 'node:path';
import { pathToFileURL } from 'node:url';
import { parseArgs } from 'node:util';

const resource = 'https://content-factory.art/mcp';
const inputLimit = 16 * 1024;
const receiptLimit = 1024 * 1024;
const transferMilliseconds = 60 * 60 * 1000;
const idleMilliseconds = 60 * 1000;
const safeInteger = value => Number.isSafeInteger(Number(value)) && Number(value) > 0;
class TransferError extends Error {}
const fail = message => { throw new TransferError(message); };

async function hash(file, maximum) {
  const before = await file.stat();
  if (!before.isFile() || !safeInteger(maximum) || before.size < 1 || before.size > Number(maximum)) {
    fail('Source must be a nonempty regular file within the discovered upload limit.');
  }
  const digest = createHash('sha256');
  const buffer = Buffer.alloc(256 * 1024);
  let size = 0;
  while (size <= before.size) {
    const { bytesRead } = await file.read(buffer, 0, Math.min(buffer.length, before.size + 1 - size), size);
    if (!bytesRead) break;
    size += bytesRead;
    digest.update(buffer.subarray(0, bytesRead));
  }
  const after = await file.stat();
  if (size !== before.size || size !== after.size || before.mtimeMs !== after.mtimeMs) {
    fail('Source changed while hashing; no bytes sent.');
  }
  return { size, sha256: digest.digest('hex') };
}

export async function inspect(path, metadata, maximum) {
  const file = await open(path, 'r');
  try {
    const digest = await hash(file, maximum);
    return { projectId: metadata.projectId, name: metadata.name, filename: basename(path),
      contentType: metadata.contentType, sizeBytes: String(digest.size), sha256: digest.sha256,
      idempotencyKey: metadata.idempotencyKey };
  } finally { await file.close(); }
}

function target(ticket, endpoint) {
  let url, expected;
  try { url = new URL(ticket.url); expected = new URL(endpoint); }
  catch { fail('Invalid upload ticket.'); }
  if (expected.protocol !== 'https:' || expected.username || expected.password || expected.search || expected.hash ||
      url.origin !== expected.origin || url.pathname !== `${expected.pathname}/transfer` ||
      url.username || url.password || url.hash || [...url.searchParams.keys()].join() !== 'ticket' ||
      !url.searchParams.get('ticket') || ticket.method !== 'POST' ||
      !safeInteger(ticket.maximumBytes) || !Number.isFinite(Date.parse(ticket.expiresAt)) ||
      Date.parse(ticket.expiresAt) <= Date.now()) fail('Invalid, expired or foreign upload ticket.');
  return url;
}

// Endpoint injection is for isolated HTTPS fixtures; the CLI is pinned above.
export async function send(path, ticket, command, endpoint = resource, transport = httpsRequest) {
  target(ticket, endpoint);
  const file = await open(path, 'r');
  try {
    const digest = await hash(file, ticket.maximumBytes);
    if (digest.size !== Number(command.sizeBytes) || digest.sha256 !== command.sha256 ||
        basename(path) !== command.filename) fail('Source changed since preparation; no bytes sent.');
    const url = target(ticket, endpoint);
    const asset = await new Promise((resolve, reject) => {
      const controller = new AbortController();
      const deadline = setTimeout(() => controller.abort(), transferMilliseconds);
      const body = file.createReadStream({ start: 0, end: digest.size - 1, autoClose: false });
      const req = transport(url, { method: 'POST', signal: controller.signal,
        headers: { 'Content-Length': String(digest.size), 'Content-Type': command.contentType } });
      const stop = () => { clearTimeout(deadline); body.destroy(); };
      const denied = () => { stop(); req.destroy(); reject(new TransferError('Upload failed; recover with asset_upload_get before retrying.')); };
      req.setTimeout(idleMilliseconds, denied);
      req.on('error', denied);
      body.on('error', denied);
      req.on('response', response => {
        if (response.statusCode !== 200) {
          const code = response.statusCode;
          response.destroy(); stop(); req.destroy();
          reject(new TransferError(`Upload returned HTTP ${code}; recover with asset_upload_get before retrying.`));
          return;
        }
        const chunks = [];
        let size = 0;
        response.on('data', chunk => {
          size += chunk.length;
          if (size > receiptLimit) { response.destroy(); denied(); return; }
          chunks.push(chunk);
        });
        response.on('error', denied);
        response.on('aborted', denied);
        response.on('end', () => {
          stop();
          try { resolve(JSON.parse(Buffer.concat(chunks).toString('utf8'))); }
          catch { reject(new TransferError('Invalid upload receipt; recover with asset_upload_get.')); }
        });
      });
      body.pipe(req);
    });
    const stored = asset?.files?.[0];
    if (!asset?.id || asset.projectId !== command.projectId || asset.files?.length !== 1 ||
        !stored?.id || stored.filename !== command.filename || stored.contentType !== command.contentType ||
        Number(stored.sizeBytes) !== digest.size || stored.sha256 !== digest.sha256) {
      fail('Upload receipt mismatch; recover with asset_upload_get.');
    }
    return asset;
  } finally { await file.close(); }
}

async function input() {
  if (process.stdin.isTTY) fail('Pipe the prepared JSON ticket on stdin; never put tickets in command arguments or shell history.');
  const chunks = [];
  let size = 0;
  for await (const chunk of process.stdin) {
    size += chunk.length;
    if (size > inputLimit) fail('Upload ticket input exceeds limit.');
    chunks.push(chunk);
  }
  try { return JSON.parse(Buffer.concat(chunks).toString('utf8')); }
  catch { fail('Invalid upload ticket input.'); }
}

async function main() {
  const command = process.argv[2];
  if (command === '--help') {
    console.log('inspect --file PATH --project ID --name NAME --content-type MIME --idempotency-key KEY --maximum-bytes DISCOVERED_LIMIT\nsend --file PATH (stdin: {"ticket": MCP_TICKET, "request": INSPECT_RESULT})');
    return;
  }
  let values;
  try { ({ values } = parseArgs({ args: process.argv.slice(3), options: Object.fromEntries(
    ['file', 'project', 'name', 'content-type', 'idempotency-key', 'maximum-bytes'].map(key => [key, { type: 'string' }])) })); }
  catch { fail('Invalid arguments; use --help.'); }
  if (!values.file) fail('--file is required.');
  let result;
  if (command === 'inspect') {
    if (['project', 'name', 'content-type', 'idempotency-key', 'maximum-bytes'].some(key => !values[key])) fail('Missing inspect metadata; use --help.');
    result = await inspect(values.file, { projectId: values.project, name: values.name,
      contentType: values['content-type'], idempotencyKey: values['idempotency-key'] }, values['maximum-bytes']);
  } else if (command === 'send') {
    const envelope = await input();
    // Both installed MCP audiences are pinned; a ticket never chooses another host.
    let endpoint = resource;
    try {
      if (new URL(envelope.ticket.url).pathname === '/mcp/media/transfer') endpoint += '/media';
    } catch { fail('Invalid upload ticket.'); }
    result = await send(values.file, envelope.ticket, envelope.request, endpoint);
  } else fail('Command required: inspect or send.');
  console.log(JSON.stringify(result));
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch(error => {
    // Only fixed application messages are safe. Node/OpenSSL/fs errors may carry URLs or paths.
    console.error(error instanceof TransferError ? error.message : 'File transfer failed; recover with asset_upload_get before retrying.');
    process.exitCode = 1;
  });
}
