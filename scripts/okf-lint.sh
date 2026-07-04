#!/usr/bin/env bash
# OKF bundle lint — frontmatter, links, index presence
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KNOW="${ROOT}/knowledge"
ERR=0

fail() { printf '[FAIL] %s\n' "$1" >&2; ERR=1; }
ok() { printf '[OK] %s\n' "$1"; }

while IFS= read -r -d '' dir; do
  rel="${dir#${KNOW}/}"
  [[ "$rel" == "" ]] && continue
  if [[ ! -f "${dir}/index.md" ]]; then
    count=$(find "$dir" -maxdepth 1 -name '*.md' ! -name 'index.md' | wc -l | tr -d ' ')
    [[ "$count" -gt 0 ]] || fail "empty dir without index: knowledge/${rel}"
  fi
done < <(find "$KNOW" -type d -print0)

while IFS= read -r -d '' f; do
  base=$(basename "$f")
  [[ "$base" == "index.md" || "$base" == "log.md" ]] && continue
  if ! grep -q '^type:' "$f" 2>/dev/null; then
    fail "missing type frontmatter: ${f#${ROOT}/}"
  fi
done < <(find "$KNOW" -name '*.md' -print0)

if ! grep -q 'okf_version' "${KNOW}/index.md"; then
  fail "knowledge/index.md missing okf_version"
fi

# Resolve markdown links relative to each source file; only check targets inside knowledge/
while IFS= read -r -d '' f; do
  dir=$(dirname "$f")
  while IFS= read -r link; do
    [[ -z "$link" ]] && continue
    [[ "$link" =~ ^https?:// ]] && continue
    [[ "$link" =~ ^# ]] && continue
    link="${link%%#*}"
    target=$(cd "$dir" && cd "$(dirname "$link")" 2>/dev/null && pwd)/$(basename "$link") 2>/dev/null || true
    if [[ -z "$target" ]]; then
      target=$(cd "$dir" && realpath -m "$link" 2>/dev/null || echo "")
    fi
    [[ -z "$target" ]] && continue
    case "$target" in
      "${KNOW}"/*)
        if [[ ! -f "$target" ]]; then
          fail "broken link in ${f#${ROOT}/}: $link"
        fi
        ;;
      *) ;; # links outside bundle (hermes/, opencode/) are allowed
    esac
  done < <(grep -oE '\[[^]]*\]\([^)]+\)' "$f" | sed -E 's/\[[^]]*\]\(([^)]+)\)/\1/' || true)
done < <(find "$KNOW" -name '*.md' -print0)

if [[ "$ERR" -eq 0 ]]; then
  ok "OKF bundle lint passed"
  exit 0
fi
exit 1
