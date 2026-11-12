#!/bin/sh
set -eu

repo=$(CDPATH='' cd -- "$(dirname "$0")/.." && pwd)
test_root=$(mktemp -d "${TMPDIR:-/tmp}/contentfactory-grok-test.XXXXXXXX")
trap 'rm -rf "$test_root"' EXIT
trap 'exit 130' HUP INT TERM
export HOME="$test_root/profile"
export GROK_HOME="$test_root/custom-grok-home"
export CF_TEST_SOURCE="$repo"
mkdir -p "$test_root/bin" "$HOME"
export PATH="$test_root/bin:$PATH"

# Replace the download and external CLI boundaries, exercising the real shell
# installer, manifest checks, transactional file writes and connection routing.
cat > "$test_root/bin/curl" <<'CURL'
#!/bin/sh
set -eu
url=''
destination=''
while [ "$#" -gt 0 ]; do
  case "$1" in
    -o) destination=$2; shift 2 ;;
    https://*) url=$1; shift ;;
    *) shift ;;
  esac
done
relative=${url#https://raw.githubusercontent.com/ContentFactoryAIArt/Skills/main/}
[ "$relative" != "$url" ] && [ -n "$destination" ]
cp "$CF_TEST_SOURCE/$relative" "$destination"
CURL
cat > "$test_root/bin/grok" <<'GROK'
#!/bin/sh
set -eu
mkdir -p "$GROK_HOME"
printf '%s\n' "$*" >> "$GROK_HOME/test-calls"
case "$*" in
  'mcp list')
    [ ! -f "$GROK_HOME/test-list-failure" ] || exit 1
    if [ -f "$GROK_HOME/test-list" ]; then cat "$GROK_HOME/test-list"; fi ;;
  'mcp add --transport http --scope user content-factory https://content-factory.art/mcp')
    printf '%s\n' '  content-factory: https://content-factory.art/mcp' > "$GROK_HOME/test-list" ;;
  *) echo 'Unexpected Grok invocation.' >&2; exit 1 ;;
esac
GROK
chmod +x "$test_root/bin/curl" "$test_root/bin/grok"
cd "$test_root"

run_install() { sh "$repo/install/install.sh" --agent grok "$@"; }
verify_files() {
  tab=$(printf '\t')
  tail -n +2 "$repo/manifest.tsv" | while IFS="$tab" read -r kind expected relative; do
    actual=$(sha256sum "$GROK_HOME/skills/$relative" | awk '{print $1}')
    [ "$actual" = "$expected" ] || { echo 'Installed file differs from manifest.' >&2; exit 1; }
  done
  cmp "$repo/manifest.tsv" "$GROK_HOME/.contentfactory/manifest.tsv"
}

run_install
verify_files
grep -Fx 'mcp add --transport http --scope user content-factory https://content-factory.art/mcp' "$GROK_HOME/test-calls" >/dev/null

# A disabled/customized same-named server must survive repeat installation.
printf '%s\n' '  content-factory: https://example.invalid/custom-mcp (disabled)' > "$GROK_HOME/test-list"
before=$(sha256sum "$GROK_HOME/test-list")
run_install
[ "$(sha256sum "$GROK_HOME/test-list")" = "$before" ]
[ "$(grep -c '^mcp add ' "$GROK_HOME/test-calls")" -eq 1 ]
calls=$(wc -l < "$GROK_HOME/test-calls")
run_install --check
run_install --install-only
[ "$(wc -l < "$GROK_HOME/test-calls")" -eq "$calls" ]

printf '\nLocal customization.\n' >> "$GROK_HOME/skills/contentfactory/SKILL.md"
before=$(sha256sum "$GROK_HOME/skills/contentfactory/SKILL.md")
if run_install --install-only > "$test_root/conflict-output" 2>&1; then
  echo 'Expected a local customization conflict.' >&2; exit 1
fi
grep -F 'Locally changed or missing managed file:' "$test_root/conflict-output" >/dev/null
[ "$(sha256sum "$GROK_HOME/skills/contentfactory/SKILL.md")" = "$before" ]

export GROK_HOME="$test_root/second-grok-home"
run_install --install-only
verify_files
[ ! -f "$GROK_HOME/test-calls" ]
touch "$GROK_HOME/test-list-failure"
if run_install > "$test_root/list-failure-output" 2>&1; then
  echo 'Expected native list failure to stop connection setup.' >&2; exit 1
fi
grep -F 'Grok could not list connections' "$test_root/list-failure-output" >/dev/null
[ ! -f "$GROK_HOME/test-list" ]

# The Grok branch preserves existing agents' install-only entry points.
for agent in codex claude opencode; do
  sh "$repo/install/install.sh" --agent "$agent" --install-only
done
[ -f "$HOME/.agents/skills/contentfactory/SKILL.md" ]
[ -f "$HOME/.claude/skills/contentfactory/SKILL.md" ]
[ -f "$HOME/.config/opencode/skills/contentfactory/SKILL.md" ]
echo 'PASS shell installer, registration arguments, reruns, check, local conflicts, profiles and existing agents.'
