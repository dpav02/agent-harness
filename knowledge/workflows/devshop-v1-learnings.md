---
type: postmortem
title: Devshop v1 pipeline learnings
description: Evidence from 79 devshop runs on hetzner-vps — why v1 failed and what v2 must avoid
tags: [devshop, hermes, ornith, qwen, pipeline, postmortem]
timestamp: 2026-07-04T16:00:00Z
---

# Devshop v1 postmortem

Harvested from `~/.hermes/devshop-runs/` (79 runs), `index.jsonl`, teardown scripts, and mined agent transcripts on hetzner-vps. V1 was torn down via `teardown-v1-devshop.sh` (removed kanban, profiles, watchdog, `~/spark/devshop-*.sh` scripts).

## What v1 was

Autonomous multi-stage pipeline: planner → implementer (per AC) → tester → reviewer, orchestrated via Hermes kanban board, stage profiles (`planner`, `implementer`, `tester`, `orchestrator`), and a watchdog that re-queued failed tasks.

## Outcomes (index.jsonl sample, Jul 2026)

| Pattern | Evidence |
|---------|----------|
| Runs that opened PRs | Several `outcome: pr_opened` on devshop-sandbox, sol-wallet-scanner |
| Runs stuck mid-pipeline | Many `outcome: spec_committed` with `finalized: false` — spec written, implementation never finished |
| Token burn | Single run: **221M tokens**, $0.22; another: **217M tokens**, $10.38 for spec-only; multi-AC run: 52M tokens |
| Blocked runs | `health: blocked`, `outcome: blocked` after 221M tokens in 98 seconds |
| Verify zombie runs | Multiple `verify-greenfield` / `verify-zombie` runs with `outcome: unknown`, never finalized |

**User verdict:** quality was poor, sessions looped and got stuck, crash loops and retries burned money, and pipeline rules blocked normal Telegram chat.

## Root cause 1 — autonomous retry loops (cost burn)

- Watchdog (`devshop-pipeline-watchdog`, `implement-watchdog`) re-claimed tasks after protocol violations
- `#1 crash`: agent exited without calling `kanban_complete`/`kanban_block` after checks were already green — session kept re-verifying until stall ([ornith-guardrails](../models/ornith-35b-guardrails.md))
- `python -c` one-liners stalled ~60s per attempt (100+ wasted turns in transcripts) before denial
- Tester piped passing checks through `grep` for strings that never appear → 10+ minute loops until watchdog kill
- **v2 fix:** fail-stop, never auto-retry; explicit `resume`/`retry` only; one AC per session; human gate between criteria

## Root cause 2 — globally loaded pipeline rules (over-restrictiveness)

- Devshop skills and kanban workflow loaded for all Hermes sessions, including casual Telegram prompts
- Users reported prompts refused as "outside the pipeline"
- **v2 fix:** pipeline skills activate only when a [task packet](spec-handoff.md) is present; `SOUL.md` stays general-purpose

## Root cause 3 — quality / model mismatch

- Small model (Qwen3.6-27B / Ornith) did planning, implementation, and testing in fresh contexts with minimal handoff
- Specs committed (`spec_committed`) but implementation stages failed or never ran to completion
- Implementer stage consumed highest tokens (117k+ in weekly report) with mixed results
- **v2 fix:** Opus/Cursor writes task packets; small model executes one criterion at a time with explicit test paths

## What to keep from v1 (harvested into repo)

| Asset | Location |
|-------|----------|
| Evidence-mined local model guardrails | [ornith-guardrails](../../hermes/skills/ornith-guardrails/SKILL.md) |
| Acceptance-criteria spec format | [planner-spec](../../hermes/skills/planner-spec/SKILL.md) → [spec-handoff](spec-handoff.md) |
| Bounded fix iteration | [fix-loop](../../hermes/skills/fix-loop/SKILL.md) |
| TDD discipline | [tdd-lite](../../hermes/skills/tdd-lite/SKILL.md) |
| Verify-before-done | [verification-before-completion](../../hermes/skills/verification-before-completion/SKILL.md) |
| Frontend spec/craft/review | [frontend-spec](../../hermes/skills/frontend-spec/SKILL.md), [frontend-craft](../../hermes/skills/frontend-craft/SKILL.md), [frontend-review](../../hermes/skills/frontend-review/SKILL.md) |

## v2 design constraints (non-negotiable)

1. **Fail-stop:** failure writes state to packet and halts — no watchdog, no silent retry
2. **Supervised:** human approves between acceptance criteria
3. **Scoped:** pipeline skills only when executing a packet
4. **Parameterized checks:** `check_command` in packet replaces deleted `~/spark/devshop-check.sh`

## Sources

- VPS: `~/.hermes/devshop-runs/index.jsonl`, `teardown-v1-devshop.sh`, `skills.disabled-devshop/`
- Weekly report: `devshop-runs/reports/weekly-2026-W26.md` (implementer highest token stage)
