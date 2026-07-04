---
name: verification-before-completion
description: Require fresh evidence before claiming tests pass, bug fixed, or ready to ship. Use during execute-spec or when verifying work.
---

# Verification Before Completion

Any success claim needs **fresh evidence from this session**.

## Gate

1. Identify the exact claim.
2. Identify the command that proves it — `check_command` from `.harness/task-packet.md` or AC-specific test path.
3. Run that command **now**.
4. Read exit code and output.
5. Report precisely; mark AC done only on proven green.

If the command failed, did not run, or env is missing — mark failed or fix; never imply success.

## Reporting

- Good: `Ran check_command (uv run pytest -q): exit 0, 12 passed.`
- Bad: `Should be fixed now.`
- Good: `Failed: exit 1 — TypeError in test_foo line 42.`

## Traps

- Stale output from an earlier run in the same task
- Lint green ≠ tests green
- Code inspection without running checks

## Related

- [quality-gates](~/dev/agent-harness/knowledge/workflows/quality-gates.md)
- **execute-spec** skill for halt-after-verify behavior
