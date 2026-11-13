import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile, readdir, lstat } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

// Package integrity only. Creative behavior is evaluated with director-cases.json.
const packageRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const skillsRoot = path.join(packageRoot, 'skills');
const skillName = 'contentfactory-director';
const skillRoot = path.join(skillsRoot, skillName);
const args = process.argv.slice(2);
assert(args.length === 0 || (args.length === 2 && args[0] === '--installed'),
  'Usage: node validate-director.mjs [--installed /path/to/contentfactory-director]');
const installedRoot = args.length ? path.resolve(args[1]) : null;
const digest = (data) => createHash('sha256').update(data).digest('hex');
const inside = (root, target) => {
  const relative = path.relative(root, target);
  return relative !== '..' && !relative.startsWith(`..${path.sep}`) && !path.isAbsolute(relative);
};

async function filesIn(directory) {
  const files = [];
  for (const entry of await readdir(directory, { withFileTypes: true })) {
    assert(!entry.isSymbolicLink(), `Symlink is not packaged: ${entry.name}`);
    const target = path.join(directory, entry.name);
    if (entry.isDirectory()) files.push(...await filesIn(target));
    else {
      assert(entry.isFile(), `Unsupported resource: ${target}`);
      files.push(target);
    }
  }
  return files.sort();
}

const manifest = (await readFile(path.join(packageRoot, 'manifest.tsv'), 'utf8')).trimEnd().split('\n');
assert.match(manifest[0], /^version\t\d+\.\d+\.\d+$/);
const packaged = new Map();
for (const record of manifest.slice(1)) {
  const [kind, expected, relative, extra] = record.split('\t');
  assert(kind === 'file' && extra === undefined, 'Malformed manifest record');
  assert.match(expected, /^[a-f0-9]{64}$/);
  assert.match(relative, /^[a-z0-9-]+\/[A-Za-z0-9_./-]+$/);
  assert(!relative.split('/').some((segment) => !segment || segment === '.' || segment === '..'),
    `Unsafe manifest path: ${relative}`);
  assert(!packaged.has(relative), `Duplicate manifest path: ${relative}`);
  const target = path.resolve(skillsRoot, relative);
  assert(inside(skillsRoot, target));
  assert((await lstat(target)).isFile(), `Not a file: ${relative}`);
  assert.equal(digest(await readFile(target)), expected, `Digest mismatch: ${relative}`);
  packaged.set(relative, expected);
}

const files = await filesIn(skillRoot);
let references = 0;
for (const file of files) {
  const relative = path.relative(skillsRoot, file).split(path.sep).join('/');
  assert(packaged.has(relative), `Unpackaged resource: ${relative}`);
  const bytes = await readFile(file);
  const content = new TextDecoder('utf-8', { fatal: true }).decode(bytes);
  assert(!content.includes('\r'), `Use LF for stable package digests: ${relative}`);
  assert(!/^\s*\[TODO:[^\n]*\]\s*$/m.test(content), `Unfinished scaffold: ${relative}`);
  if (file.endsWith('.md')) {
    for (const match of content.matchAll(/\[[^\]]+\]\(([^)]+)\)/g)) {
      const link = match[1];
      if (/^(https?:|mailto:|#)/.test(link)) continue;
      const target = path.resolve(path.dirname(file), link.split('#')[0]);
      assert(inside(skillsRoot, target), `Reference escapes package: ${link}`);
      const targetRelative = path.relative(skillsRoot, target).split(path.sep).join('/');
      assert(packaged.has(targetRelative), `Reference absent from manifest: ${link}`);
      assert((await lstat(target)).isFile(), `Broken reference: ${link}`);
      references++;
    }
  }
  if (installedRoot) {
    const target = path.join(installedRoot, path.relative(skillRoot, file));
    assert.equal(digest(await readFile(target)), digest(bytes), `Installed mismatch: ${relative}`);
  }
}
if (installedRoot) assert.equal((await filesIn(installedRoot)).length, files.length,
  'Installed folder has unexpected resources');

const entrypoint = await readFile(path.join(skillRoot, 'SKILL.md'), 'utf8');
const frontmatter = entrypoint.match(/^---\n([\s\S]*?)\n---\n/);
assert(frontmatter, 'Missing frontmatter');
// The shared native format intentionally uses only two simple YAML scalars.
const lines = frontmatter[1].split('\n');
assert.equal(lines.length, 2, 'Shared skill must use only name and description');
assert.equal(lines[0], `name: ${skillName}`);
assert.match(lines[1], /^description: [^<>\n]+$/);
const description = lines[1].slice('description: '.length);
assert(description.length > 0 && description.length <= 1024 && !description.includes(': '),
  'Description must remain an unambiguous portable YAML scalar');
const metadata = await readFile(path.join(skillRoot, 'agents/openai.yaml'), 'utf8');
const displayDescription = metadata.match(/short_description: "([^"]+)"/);
assert(displayDescription && displayDescription[1].length >= 25 && displayDescription[1].length <= 64);
assert(metadata.includes(`$${skillName}`), 'Default prompt must invoke the skill');

const corpus = JSON.parse(await readFile(path.join(packageRoot, 'tests/director-cases.json'), 'utf8'));
assert.equal(corpus.version, 1);
assert(Array.isArray(corpus.cases) && corpus.cases.length > 0);
const ids = new Set();
for (const scenario of corpus.cases) {
  assert(typeof scenario.id === 'string' && !ids.has(scenario.id), 'Duplicate/missing scenario ID');
  ids.add(scenario.id);
  assert(typeof scenario.request === 'string' && scenario.request.trim());
  assert(Array.isArray(scenario.criteria) && scenario.criteria.length > 0);
  assert(scenario.criteria.every((criterion) => typeof criterion === 'string' && criterion.trim()));
}

console.log(JSON.stringify({ status: 'PASS', version: manifest[0].split('\t')[1],
  skill: skillName, resources: files.length, localReferences: references,
  manifestFilesVerified: packaged.size, behavioralCasesDefined: ids.size,
  installedCompared: Boolean(installedRoot),
  scope: 'Static package integrity; no claim of behavioral or media quality.' }, null, 2));
