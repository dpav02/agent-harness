---
name: Ornith Base Template V5 Overlay
overview: Overlay Prisma's fixed_chat_template-v5.jinja onto ornith-base (one variable) and re-run tool-eval hardmode seed 42. Target closing Structured Output 67% / Hard Mode 77% gaps (86 vs 91 bar). If >=91, executor-class quality at ~79 tok/s.
todos:
  - id: wire-template
    content: Add ORNITH_BASE_CHAT_TEMPLATE support to ornith-base-serve.sh + unit; deploy to DGX
    status: pending
  - id: swap-smoke
    content: Swap to ornith-base with v5 template; smoke one tool-call request
    status: pending
  - id: tool-eval-v5
    content: Run tool-eval --seed 42 --hardmode on ornith-base+v5; save artifacts
    status: pending
  - id: restore-decide
    content: Restore Prisma; score vs 86 baseline and 91 bar; harness smoke if >=91
    status: pending
  - id: document-v5
    content: Write overlay summary, update runbook + routing docs, commit both repos, sync VPS
    status: pending
isProject: false
---
# Ornith-base + template-v5 overlay experiment

## Hypothesis

Ornith-base scored 86/100 with its stock template; Prisma Tier 1 scored 91/100 with fixed_chat_template-v5.jinja. Both templates share the identical Qwen3.6 base (same tool-call XML format, same chat tokens) — v5 adds discipline blocks the stock template lacks:

| v5 addition | Targets ornith-base weakness |
|-------------|------------------------------|
| OUTPUT_DISCIPLINE | Structured Output 67% (worst category) |
| TASK_COMPLETION + MULTI_TURN_STATE | Multi-Step Chains 75%, Hard Mode 77% |
| PARAMETER_DISCIPLINE | Missing-parameter fail (TC-75) |
| SECURITY + UNTRUSTED_TOOL_DATA wrap | Safety 88% headroom |
| RECOVERY | TC-80 rollback fail |
| Think auto-close before tool_call | Format edge cases |

## Steps

1. Wire `ORNITH_BASE_CHAT_TEMPLATE` env into `spark/ornith-base-serve.sh` (mount + `--chat-template` + `--default-chat-template-kwargs '{"preserve_thinking": true}'`); set in systemd unit; deploy to DGX
2. Swap `to-ornith-base`; smoke one tool-call request
3. `tool_eval_bench --seed 42 --hardmode` (~10-15 min at ornith speed)
4. Restore Prisma; decide: >=91 promote path (harness smoke), 87-90 fast-alternative upgrade, <=86 revert template
5. Document in runs/ + runbook + routing; commit both repos; sync VPS

## Decision table

| Outcome | Action |
|---------|--------|
| >= 91 | Harness smoke, consider promotion to default executor (2.2x speed) |
| 87-90 | Keep Prisma default; ornith-base+v5 = preferred fast alternative |
| <= 86 | Revert to stock template; v5 gains are Prisma-specific |

## Constraints

- One vLLM service at a time; restore Prisma unless promotion decided
- Same seed/hardmode/bench version for comparability
- Prisma config frozen (control)
