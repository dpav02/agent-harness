#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OPENCODE_DIR="${HOME}/.config/opencode"
CURSOR_RULES_DIR="${HOME}/.cursor/rules"
USE_LINK=0

if [[ "${1:-}" == "--link" ]]; then
    USE_LINK=1
elif [[ -n "${1:-}" ]]; then
    printf '[ERROR] Unknown option: %s\n' "$1" >&2
    printf 'Usage: %s [--link]\n' "$(basename "$0")" >&2
    exit 1
fi

# Domain files moved to skills/ — remove stale always-on copies if present
STALE_DOMAIN_FILES=(
  backend-agents.md
  database-agents.md
  aws-agents.md
  docker-agents.md
  messaging-agents.md
  backend-ts-agents.md
  observability-agents.md
  resilience-agents.md
  frontend-agents.md
)

install_file() {
    local src="$1"
    local dest="$2"
    if [[ "${USE_LINK}" == "1" ]]; then
        ln -sf "${src}" "${dest}"
    else
        cp "${src}" "${dest}"
    fi
}

mkdir -p "$OPENCODE_DIR" "$CURSOR_RULES_DIR" "$OPENCODE_DIR/skills"

if [[ "${USE_LINK}" == "1" ]]; then
    echo "Symlinking OpenCode rules → $OPENCODE_DIR"
else
    echo "Installing OpenCode rules → $OPENCODE_DIR"
fi

install_file "$ROOT/opencode/AGENTS.md" "$OPENCODE_DIR/AGENTS.md"
install_file "$ROOT/opencode/workflow-agents.md" "$OPENCODE_DIR/workflow-agents.md"
install_file "$ROOT/opencode/testing-agents.md" "$OPENCODE_DIR/testing-agents.md"
install_file "$ROOT/opencode/opencode.jsonc" "$OPENCODE_DIR/opencode.jsonc"

if [[ "${USE_LINK}" == "1" ]]; then
    echo "Symlinking OpenCode skills → $OPENCODE_DIR/skills/"
else
    echo "Installing OpenCode skills → $OPENCODE_DIR/skills/"
fi

for skill_dir in "$ROOT/opencode/skills/"*/; do
    skill_name="$(basename "$skill_dir")"
    mkdir -p "$OPENCODE_DIR/skills/$skill_name"
    install_file "$skill_dir/SKILL.md" "$OPENCODE_DIR/skills/$skill_name/SKILL.md"
done

for stale in "${STALE_DOMAIN_FILES[@]}"; do
    rm -f "$OPENCODE_DIR/$stale"
done
rm -f "$OPENCODE_DIR/"*.bak

if [[ "${USE_LINK}" == "1" ]]; then
    echo "Symlinking Cursor rules → $CURSOR_RULES_DIR"
else
    echo "Installing Cursor rules → $CURSOR_RULES_DIR"
fi

for rule in "$ROOT/cursor/"*.mdc; do
    install_file "$rule" "$CURSOR_RULES_DIR/$(basename "$rule")"
done

echo "Done. Verify OpenCode: opencode debug config"
echo "Always-on size: wc -c ~/.config/opencode/AGENTS.md ~/.config/opencode/workflow-agents.md ~/.config/opencode/testing-agents.md"
if [[ "${USE_LINK}" == "1" ]]; then
    echo "Symlink source: $ROOT"
fi
