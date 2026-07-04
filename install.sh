#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OPENCODE_DIR="${HOME}/.config/opencode"
CURSOR_RULES_DIR="${HOME}/.cursor/rules"
HERMES_DIR="${HOME}/.hermes"
USE_LINK=0
TARGET="all"
SSH_HOST="${HERMES_SSH_HOST:-root@hetzner-vps}"

usage() {
  printf 'Usage: %s [--link] [--target opencode|cursor|hermes|all]\n' "$(basename "$0")"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --link) USE_LINK=1; shift ;;
    --target)
      TARGET="${2:-}"
      [[ -n "$TARGET" ]] || usage
      shift 2
      ;;
    -h|--help) usage ;;
    *) printf '[ERROR] Unknown option: %s\n' "$1" >&2; usage ;;
  esac
done

STALE_DOMAIN_FILES=(
  backend-agents.md database-agents.md aws-agents.md docker-agents.md
  messaging-agents.md backend-ts-agents.md observability-agents.md
  resilience-agents.md frontend-agents.md
)

install_file() {
  local src="$1" dest="$2"
  if [[ "${USE_LINK}" == "1" ]]; then
    ln -sf "${src}" "${dest}"
  else
    cp "${src}" "${dest}"
  fi
}

install_opencode() {
  mkdir -p "$OPENCODE_DIR" "$OPENCODE_DIR/skills"
  echo "Installing OpenCode → $OPENCODE_DIR"
  install_file "$ROOT/opencode/AGENTS.md" "$OPENCODE_DIR/AGENTS.md"
  install_file "$ROOT/opencode/workflow-agents.md" "$OPENCODE_DIR/workflow-agents.md"
  install_file "$ROOT/opencode/testing-agents.md" "$OPENCODE_DIR/testing-agents.md"
  install_file "$ROOT/opencode/planning-spec-driven.md" "$OPENCODE_DIR/planning-spec-driven.md"
  install_file "$ROOT/opencode/opencode.jsonc" "$OPENCODE_DIR/opencode.jsonc"
  for skill_dir in "$ROOT/opencode/skills/"*/; do
    skill_name="$(basename "$skill_dir")"
    mkdir -p "$OPENCODE_DIR/skills/$skill_name"
    install_file "$skill_dir/SKILL.md" "$OPENCODE_DIR/skills/$skill_name/SKILL.md"
  done
  for stale in "${STALE_DOMAIN_FILES[@]}"; do
    rm -f "$OPENCODE_DIR/$stale"
  done
  rm -f "$OPENCODE_DIR/"*.bak
}

install_cursor() {
  mkdir -p "$CURSOR_RULES_DIR"
  echo "Installing Cursor → $CURSOR_RULES_DIR"
  for rule in "$ROOT/cursor/"*.mdc; do
    install_file "$rule" "$CURSOR_RULES_DIR/$(basename "$rule")"
  done
}

install_hermes_local() {
  mkdir -p "$HERMES_DIR/skills"
  echo "Installing Hermes → $HERMES_DIR"
  install_file "$ROOT/hermes/SOUL.md" "$HERMES_DIR/SOUL.md"
  for skill_dir in "$ROOT/hermes/skills/"*/; do
    skill_name="$(basename "$skill_dir")"
    mkdir -p "$HERMES_DIR/skills/$skill_name"
    install_file "$skill_dir/SKILL.md" "$HERMES_DIR/skills/$skill_name/SKILL.md"
  done
  echo "Knowledge bundle: ensure $ROOT/knowledge is at ~/dev/agent-harness/knowledge (git pull)"
}

install_hermes_remote() {
  echo "Deploying Hermes skills to $SSH_HOST via git pull + local install"
  ssh -o BatchMode=yes "$SSH_HOST" "set -euo pipefail
    cd ~/dev/agent-harness && git pull --ff-only
    ./install.sh --target hermes ${USE_LINK:+--link}
  "
}

case "$TARGET" in
  opencode) install_opencode ;;
  cursor) install_cursor ;;
  hermes)
    if [[ "$(hostname -s 2>/dev/null || hostname)" == *"hetzner"* ]] || [[ -d "$HERMES_DIR/hermes-agent" ]]; then
      install_hermes_local
    else
      install_hermes_remote
    fi
    ;;
  all)
    install_opencode
    install_cursor
    if [[ -d "$HERMES_DIR" ]] || [[ "${INSTALL_HERMES_LOCAL:-}" == "1" ]]; then
      install_hermes_local
    fi
    ;;
  *) printf '[ERROR] Unknown target: %s\n' "$TARGET" >&2; usage ;;
esac

echo "Done."
[[ "$TARGET" == "opencode" || "$TARGET" == "all" ]] && echo "Verify OpenCode: opencode debug config"
[[ "$TARGET" == "hermes" ]] && echo "Verify Hermes: hermes skills list (or restart gateway if needed)"
