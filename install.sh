#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OPENCODE_DIR="${HOME}/.config/opencode"
CURSOR_RULES_DIR="${HOME}/.cursor/rules"

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

mkdir -p "$OPENCODE_DIR" "$CURSOR_RULES_DIR" "$OPENCODE_DIR/skills"

echo "Installing OpenCode rules → $OPENCODE_DIR"
cp "$ROOT/opencode/AGENTS.md" "$OPENCODE_DIR/"
cp "$ROOT/opencode/workflow-agents.md" "$OPENCODE_DIR/"
cp "$ROOT/opencode/testing-agents.md" "$OPENCODE_DIR/"
cp "$ROOT/opencode/opencode.jsonc" "$OPENCODE_DIR/"

echo "Installing OpenCode skills → $OPENCODE_DIR/skills/"
for skill_dir in "$ROOT/opencode/skills/"*/; do
  skill_name="$(basename "$skill_dir")"
  mkdir -p "$OPENCODE_DIR/skills/$skill_name"
  cp "$skill_dir/SKILL.md" "$OPENCODE_DIR/skills/$skill_name/"
done

for stale in "${STALE_DOMAIN_FILES[@]}"; do
  rm -f "$OPENCODE_DIR/$stale"
done
rm -f "$OPENCODE_DIR/"*.bak

echo "Installing Cursor rules → $CURSOR_RULES_DIR"
cp "$ROOT/cursor/"*.mdc "$CURSOR_RULES_DIR/"

echo "Done. Verify OpenCode: opencode debug config"
echo "Always-on size: wc -c ~/.config/opencode/AGENTS.md ~/.config/opencode/workflow-agents.md ~/.config/opencode/testing-agents.md"
