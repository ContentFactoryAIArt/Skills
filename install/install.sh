#!/bin/sh
set -eu

# Installs the manifest-owned ContentFactory skills without changing other skills.
base='https://raw.githubusercontent.com/ContentFactoryAIArt/Skills/main'
endpoint='https://content-factory.art/mcp'
server='content-factory'
agent=''
check=0
install_only=0
while [ "$#" -gt 0 ]; do
  case "$1" in
    --agent) [ "$#" -ge 2 ] || { echo 'Missing agent.' >&2; exit 2; }; agent=$2; shift 2 ;;
    --check) check=1; shift ;;
    --install-only) install_only=1; shift ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done
case "$agent" in
  codex) root="$HOME/.agents/skills"; cli=codex ;;
  claude) root="$HOME/.claude/skills"; cli=claude ;;
  opencode) root="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills"; cli=opencode ;;
  *) echo 'Use --agent codex, claude or opencode.' >&2; exit 2 ;;
esac
command -v curl >/dev/null 2>&1 || { echo 'curl is required.' >&2; exit 1; }
if command -v sha256sum >/dev/null 2>&1; then
  hash_file() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
  hash_file() { shasum -a 256 "$1" | awk '{print $1}'; }
else
  echo 'sha256sum or shasum is required.' >&2; exit 1
fi
tmp=$(mktemp -d "${TMPDIR:-/tmp}/contentfactory.XXXXXXXX")
transaction=0
lock=''
cleanup() {
  status=$?
  trap - EXIT HUP INT TERM
  if [ "$transaction" -eq 1 ]; then
    set +e
    recover_failed=0
    while IFS="$(printf '\t')" read -r kind expected relative; do
      [ -n "$relative" ] || continue
      target="$root/$relative"
      old=$(awk -F '\t' -v p="$relative" '$3==p {print $2}' "$tmp/old-records")
      if [ -f "$target" ] && [ "$(hash_file "$target")" = "$expected" ]; then
        if [ -n "$old" ]; then cp "$tmp/backup/$relative" "$target" || recover_failed=1
        else rm -f "$target" || recover_failed=1; fi
      elif [ -n "$old" ] && [ ! -e "$target" ]; then
        mkdir -p "$(dirname "$target")" && cp "$tmp/backup/$relative" "$target" || recover_failed=1
      elif [ -n "$old" ] && [ -f "$target" ] && [ "$(hash_file "$target")" = "$old" ]; then :
      elif [ -z "$old" ] && [ ! -e "$target" ]; then :
      else recover_failed=1; fi
    done < "$tmp/new-records"
    while IFS="$(printf '\t')" read -r kind expected relative; do
      [ -n "$relative" ] || continue
      if ! awk -F '\t' -v p="$relative" '$3==p {found=1} END {exit !found}' "$tmp/new-records"; then
        target="$root/$relative"
        if [ ! -e "$target" ]; then mkdir -p "$(dirname "$target")" && cp "$tmp/backup/$relative" "$target" || recover_failed=1
        elif [ ! -f "$target" ] || [ "$(hash_file "$target")" != "$expected" ]; then recover_failed=1; fi
      fi
    done < "$tmp/old-records"
    if [ -f "$tmp/previous-manifest" ]; then cp "$tmp/previous-manifest" "$state" || recover_failed=1
    else rm -f "$state" || recover_failed=1; fi
    if [ "$recover_failed" -ne 0 ]; then echo "Automatic recovery was incomplete; backups are in $tmp and the lock remains at $lock" >&2; exit "$status"; fi
    echo 'Installation was interrupted; previous managed files were restored.' >&2
  fi
  [ -z "$lock" ] || rm -f "$lock"
  rm -rf "$tmp"
  exit "$status"
}
trap cleanup EXIT
trap 'exit 130' HUP INT TERM
fetch() { curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 90 --max-filesize 10485760 "$1" -o "$2"; }
fetch "$base/manifest.tsv" "$tmp/manifest" || { echo 'Could not download the published skills manifest.' >&2; exit 1; }

# Each path is a skill directory and a relative file path. Do not permit paths
# that can escape the skills root or aliases that bypass duplicate detection.
validate_manifest() {
  awk -F '\t' '
    NR == 1 { if (NF != 2 || $1 != "version" || $2 !~ /^[0-9]+\.[0-9]+\.[0-9]+$/) exit 1; next }
    { if (NF != 3 || $1 != "file" || length($2) != 64 || $2 ~ /[^a-f0-9]/) exit 1;
      n = split($3, p, "/"); if (n < 2 || p[1] !~ /^[a-z0-9]+(-[a-z0-9]+)*$/) exit 1;
      for (i=2; i<=n; i++) if (p[i] == "." || p[i] == ".." || p[i] !~ /^[A-Za-z0-9_.-]+$/) exit 1;
      if (seen[$3]++) exit 1; count++ }
    END { if (NR < 2 || !count) exit 1 }
  ' "$1"
}
validate_manifest "$tmp/manifest" || { echo 'The published manifest is invalid.' >&2; exit 1; }
check_path() {
  path=$1
  while [ "$path" != / ] && [ "$path" != . ] && [ -n "$path" ]; do
    [ ! -L "$path" ] || { echo 'Symbolic links are not supported in installation paths.' >&2; exit 1; }
    path=$(dirname "$path")
  done
}
state="$HOME/.contentfactory/skills/$agent/manifest.tsv"
check_path "$root"
check_path "$state"
lockdir="$HOME/.contentfactory/locks"
check_path "$lockdir"
mkdir -p "$lockdir"
lock_path="$lockdir/$agent.lock"
if ! (set -C; : > "$lock_path") 2>/dev/null; then
  echo "Another installation may be running. After confirming it stopped, inspect $lock_path for its temporary backup location, recover any interrupted update, remove the lock, and retry." >&2
  exit 1
fi
lock=$lock_path
printf '%s\n' "$tmp" > "$lock"
if [ -e "$state" ]; then
  [ -f "$state" ] && [ ! -L "$state" ] && validate_manifest "$state" || { echo 'The installed manifest is invalid; no files changed.' >&2; exit 1; }
fi
version=$(awk -F '\t' 'NR==1 {print $2}' "$tmp/manifest")
mkdir -p "$tmp/files"
tab=$(printf '\t')
tail -n +2 "$tmp/manifest" > "$tmp/new-records"
if [ -f "$state" ]; then tail -n +2 "$state" > "$tmp/old-records"; else : > "$tmp/old-records"; fi

# Verify every previously managed file before replacing or removing any file.
while IFS="$tab" read -r kind expected relative; do
  [ -n "$relative" ] || continue
  target="$root/$relative"
  check_path "$target"
  [ -f "$target" ] && [ "$(hash_file "$target")" = "$expected" ] || { echo "Locally changed or missing managed file: $relative; no update applied." >&2; exit 1; }
done < "$tmp/old-records"
if [ "$check" -eq 1 ]; then
  if [ ! -f "$state" ]; then echo "Not installed; available version: $version"
  elif cmp -s "$state" "$tmp/manifest"; then echo "Installed files are current: $version"
  else echo "An update is available: $version"; fi
  exit 0
fi
while IFS="$tab" read -r kind expected relative; do
  [ -n "$relative" ] || continue
  target="$root/$relative"
  check_path "$target"
  old=$(awk -F '\t' -v p="$relative" '$3==p {print $2}' "$tmp/old-records")
  if [ -e "$target" ] && [ -z "$old" ]; then
    echo "Unmanaged file conflicts: $relative; no update applied." >&2; exit 1
  fi
  mkdir -p "$tmp/files/$(dirname "$relative")"
  fetch "$base/skills/$relative" "$tmp/files/$relative" || { echo "Download failed: $relative" >&2; exit 1; }
  [ "$(hash_file "$tmp/files/$relative")" = "$expected" ] || { echo "Checksum mismatch: $relative" >&2; exit 1; }
done < "$tmp/new-records"

while IFS="$tab" read -r kind expected relative; do
  [ -n "$relative" ] || continue
  mkdir -p "$tmp/backup/$(dirname "$relative")"
  cp "$root/$relative" "$tmp/backup/$relative"
done < "$tmp/old-records"
[ ! -f "$state" ] || cp "$state" "$tmp/previous-manifest"
mkdir -p "$root" "$(dirname "$state")"
transaction=1
while IFS="$tab" read -r kind expected relative; do
  [ -n "$relative" ] || continue
  mkdir -p "$root/$(dirname "$relative")"
  staged=$(mktemp "$root/$(dirname "$relative")/.contentfactory.XXXXXXXX")
  cp "$tmp/files/$relative" "$staged"
  mv -f "$staged" "$root/$relative"
done < "$tmp/new-records"
while IFS="$tab" read -r kind expected relative; do
  [ -n "$relative" ] || continue
  if ! awk -F '\t' -v p="$relative" '$3==p {found=1} END {exit !found}' "$tmp/new-records"; then rm -- "$root/$relative"; fi
done < "$tmp/old-records"
state_new=$(mktemp "$(dirname "$state")/.manifest.XXXXXXXX")
cp "$tmp/manifest" "$state_new"
mv -f "$state_new" "$state"
transaction=0
echo "Installed ContentFactory skills version $version for $agent."
[ "$install_only" -eq 0 ] || exit 0
command -v "$cli" >/dev/null 2>&1 || { echo "Install $cli, then rerun this installer to connect MCP." >&2; exit 1; }
native_login() {
  if [ -t 1 ] && ( : </dev/tty ) 2>/dev/null; then
    echo 'Continue sign-in in the native agent and browser.'
    if ! "$@" </dev/tty; then
      echo "Sign-in did not complete. Retry: $*" >&2; return 1
    fi
  else
    echo "To sign in, run: $*"
  fi
}
if [ "$agent" = opencode ]; then
  # V1 writes its add command to global config; V2 requires --global.
  help=$($cli mcp add --help 2>&1 || true)
  case "$help" in *--url*) ;; *) echo 'OpenCode does not support noninteractive URL configuration; no connection was changed.' >&2; exit 1 ;; esac
  case "$help" in
    *--global*) opencode_global=1 ;;
    *)
      version=$($cli --version 2>/dev/null || true)
      if ! printf '%s\n' "$version" | awk '/^1\.[0-9]+\.[0-9]+$/ {ok=1} END {exit !ok}'; then
        echo 'Unsupported OpenCode version; no connection was changed.' >&2; exit 1
      fi
      opencode_global=0 ;;
  esac
  listing=$($cli mcp list 2>/dev/null) || { echo 'OpenCode could not list connections; no configuration was changed.' >&2; exit 1; }
  if printf '%s\n' "$listing" | grep -F "$server" >/dev/null; then
    echo "An MCP server named $server may already exist; it was not changed. Review it with opencode mcp list." >&2
    exit 1
  fi
  if [ "$opencode_global" -eq 1 ]; then
    "$cli" mcp add "$server" --global --url "$endpoint"
  else
    "$cli" mcp add "$server" --url "$endpoint"
  fi
  native_login "$cli" mcp auth "$server"
  echo 'Connection and authentication are verified by your next MCP call.'
  exit 0
fi
if [ "$agent" = codex ]; then
  set -- mcp get "$server" --json
else
  set -- mcp get "$server"
fi
if diagnostic=$("$cli" "$@" 2>&1 >/dev/null); then
  echo "An MCP server named $server already exists; it was not changed. Check its endpoint and sign-in in $cli."
  exit 0
fi
if [ "$agent" = codex ]; then
  if ! printf '%s\n' "$diagnostic" | awk -v expected="Error: No MCP server named '$server' found." '
    /^WARNING: proceeding, even though we could not create PATH aliases:/ {next}
    {if ($0 != expected || found) exit 1; found=1}
    END {if (!found) exit 1}
  '; then
    echo 'Codex returned an unexpected inspection error; no connection was changed.' >&2; exit 1
  fi
else
  expected="No MCP server named \"$server\". Run \`claude mcp add\` to add one."
  if [ "$diagnostic" != "$expected" ]; then
    echo 'Claude returned an unexpected inspection error; no connection was changed.' >&2; exit 1
  fi
fi
echo "Adding the $server MCP server. Complete authorization using your agent's native sign-in."
if [ "$agent" = codex ]; then
  "$cli" mcp add "$server" --url "$endpoint" --oauth-client-registration dcr --oauth-resource "$endpoint"
  native_login "$cli" mcp login "$server" --oauth-client-registration dcr
else
  "$cli" mcp add --transport http "$server" --scope user "$endpoint"
  native_login "$cli" mcp login "$server"
fi
echo 'Connection and authentication are verified by your next MCP call.'
