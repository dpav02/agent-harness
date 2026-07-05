# Workflow agents (OpenCode / Ornith)

Cross-cutting discipline — ponytail, execution, debugging. Loads every session.

## Execution

- **Real environment** — run commands and fix issues here; don't only tell the user what to run.
- **Read before acting** — open files; don't assume contents or test output from memory.
- **Smallest diff** — no drive-by refactors; match repo naming, types, imports, doc style.

## Debugging

- Reproduce → gather evidence (stack trace, smallest failing command).
- Compare with a **working** path in the same codebase.
- Form **one** hypothesis; fix the source, not the symptom.
- Stop stacking patches; re-read architecture if stuck.
- Regression test or minimal repro before speculative edits.

## CI / honesty

- Don't claim CI green or ready to merge without running relevant **local** checks when possible.
- Use remote CI logs for real failures — no hand-waving.

## Ponytail ladder (before writing code)

Stop at the first rung that holds:

1. **YAGNI** — does this need to exist at all?
2. **Already in codebase?** — reuse, don't rewrite
3. **Stdlib?** — use it
4. **Native platform feature?** — use it
5. **Installed dependency?** — use it
6. **One line?** — one line
7. **Only then** — write the minimum that works

The ladder runs **after** you understand the problem: read the task, trace the real flow, then climb.

**Bug fix = root cause:** grep every caller of the function you touch; fix the shared function once.

- No abstractions that weren't explicitly requested.
- No new dependency if avoidable.
- Deletion over addition. Boring over clever. Fewest files possible.
- Mark intentional shortcuts with `ponytail:` — name the ceiling and upgrade path.

**Not lazy about:** understanding the problem, trust-boundary validation, error handling, security, accessibility, hardware calibration, anything explicitly requested.

Non-trivial logic leaves **one runnable check** behind (test or minimal repro). Trivial one-liners need no ceremony.

## Behavior changes

Follow **`testing-agents.md`** for RED-GREEN-REFACTOR on new behavior, bug fixes, and refactors.

## OpenCode / local LLM guardrails

- One logical change per turn when possible.
- **Emit exactly one tool call per assistant turn — never batch reads.** Parallel
  tool-call bursts trigger the vLLM qwen3_xml streaming-parser bug (multiple
  `<function=...>` in one `<tool_call>` → corrupt deltas → OpenCode session
  death, `Expected 'function.name' to be a string`). Measured at ~7%/burst
  (vllm#43713).
- Context budget — prefer editing 1–3 files per task.
- Load domain **skills** (see `AGENTS.md`) when the task needs specialized rules — don't guess domain conventions.
- Spark/DGX defaults and auth env names from global `AGENTS.md` still apply.
