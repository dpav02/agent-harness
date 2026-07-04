---
name: fix-loop
description: Bounded fix iteration for tester stage — read failure, minimal fix, re-run checks, exit after 3 attempts.
---

# fix-loop

Use during **execute-spec** when the task packet's `check_command` fails (scoped — not general chat).

## Loop (max 3 iterations)

Track iteration count explicitly in your reasoning (1, 2, 3).

```
while iteration < 3:
  1. Run check_command from task packet — capture full failure output
  2. If exit 0 → mark AC done, halt for approval
  3. Classify failure:
     - test-only (assertion, fixture, mock) → fix allowed
     - production bug → mark AC failed, halt (user resume/retry)
     - env/tooling (missing dep, wrong path) → mark AC failed with exact error
  4. Apply minimal fix for test-only issues only
  5. Re-run check; increment iteration
```

After iteration 3 with still-red checks → mark AC `failed`, halt (no auto-retry) with:
- Last command output (last 40 lines)
- What was tried each iteration
- Whether failure is test-only or needs implementer

## Allowed tester edits

- Test files (`tests/`, `*.test.ts`, `*_test.py`, etc.)
- Test config (`conftest.py`, vitest setup)
- Snapshots if spec allows

## Forbidden without block

- Production source changes (src/, lib/, app code)
- Dependency adds (`package.json`, `pyproject.toml`) — spec/planner must authorize
- Disabling tests or skipping checks to force green

## Exit conditions

| Outcome | Action |
|---------|--------|
| Checks green | Mark AC done, halt |
| Test-only fix needed, loop < 3 | Continue loop |
| Production fix needed | Mark AC failed, halt — user resume/retry |
| Loop exhausted (3 fails) | Mark AC failed with structured summary |
| Ambiguous failure | Mark AC failed; do not guess |

## Do not

- Restart from scratch (delete code and rewrite)
- Mark complete with failing checks
- Run checks once and block without attempting test-only fixes when clearly test-side
