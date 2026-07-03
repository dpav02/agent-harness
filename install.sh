#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OPENCODE_DIR="${HOME}/.config/opencode"
CURSOR_RULES_DIR="${HOME}/.cursor/rules"

mkdir -p "$OPENCODE_DIR" "$CURSOR_RULES_DIR"

echo "Installing OpenCode rules → $OPENCODE_DIR"
cp "$ROOT/opencode/"*.md "$OPENCODE_DIR/"
cp "$ROOT/opencode/opencode.jsonc" "$OPENCODE_DIR/"

echo "Installing Cursor rules → $CURSOR_RULES_DIR"
cp "$ROOT/cursor/"*.mdc "$CURSOR_RULES_DIR/"

echo "Done. Verify OpenCode: opencode debug config"
