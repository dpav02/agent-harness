---
name: execute-spec
description: Execute one acceptance criterion from .harness/task-packet.md — TDD, check_command, fail-stop, halt for approval. Use ONLY when task packet exists or user says execute-spec/resume/retry.
---

# Execute spec (consumer)

**Scoped activation:** only when `.harness/task-packet.md` exists OR user says `execute-spec`, `resume`, or `retry`. Do not apply to general chat.

## Start

1. Read `.harness/task-packet.md` frontmatter and criterion table
2. Load **ornith-guardrails** and **knowledge-lookup** if domain APIs involved
3. Pick target AC:
   - `execute-spec` / `resume`: first `pending` AC (or `in-progress` if resuming)
   - `retry`: first `failed` AC — reset its git changes if partial work exists

## Per AC session

1. Set AC status → `in-progress` in packet
2. Read AC + test path only (not whole spec unless needed)
3. **tdd-lite:** failing test first for new behavior
4. Minimal implementation (ponytail)
5. Run AC test path, then packet `check_command`
6. On **green:** set AC → `done`, report summary, **halt** (wait for human approval)
7. On **red after 3 fix attempts:** set AC → `failed`, write notes, **halt** — no auto-retry

## Fail-stop

- Never silently retry failed AC
- User must say `resume` (with hint) or `retry` (fresh attempt)
- Apply **verification-before-completion** — fresh command output this session

## Budget

- Max 3 fix iterations per AC (fix-loop)
- Prefer 1–3 files edited
- Complete immediately when green — do not re-verify (ornith-guardrails)

## Commands

| User says | Action |
|-----------|--------|
| execute-spec | Next pending AC |
| resume | Continue failed/in-progress with user hint |
| retry | Re-attempt failed AC from clean state |

## Related

- [spec-handoff](~/dev/agent-harness/knowledge/workflows/spec-handoff.md)
- [quality-gates](~/dev/agent-harness/knowledge/workflows/quality-gates.md)
