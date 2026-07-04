---
name: ornith-guardrails
description: Failure-pattern guardrails for local Qwen/Ornith models during execute-spec sessions — distilled from mined transcript evidence.
---

# ornith-guardrails

Local-model-specific habits that have caused real pipeline failures on this box. Evidence: mined `~/.hermes/profiles/{implementer,tester}/logs/agent.log` + kanban `task_runs` history — see the Ornith quality report. These are not generic best practices; each rule maps to an observed, repeated failure.

## 1. Complete immediately once checks are green — do not re-verify

The #1 recurring crash in devshop v1 followed sessions that kept re-reading files, re-running `git status`, or re-checking already-confirmed state after tests already passed. The longer a session runs past the point where checks are green, the higher the chance the next turn stalls.

**Rule:** the instant the task packet's `check_command` exits 0 and `git status --porcelain` is empty, mark the AC `done` in `.harness/task-packet.md` and **halt** (execute-spec). Do not:
- Re-read files you already wrote to "double check."
- Re-run the test suite a second time "to be sure."
- Explore the workspace further looking for more to do.

If you genuinely have more required work, finish it in the same pass — don't declare done, look around, then loop.

## 2. Never use `python -c` / `python3 -c` inline snippets

These require manual approval in this sandbox and stall for ~60s before being denied — this was the single most common wasted turn in mined transcripts (100+ occurrences). Same applies to any single-shot interpreter one-liner (`node -e`, `ruby -e`, etc.).

**Instead:** write a small scratch script with `write_file` (e.g. `/tmp/check.py`) and run it with `uv run python /tmp/check.py`, or add an assertion to the real test file and run it through `test-run`.

## 3. A "warning:" line in tool stderr is not necessarily a failure

`uv run` frequently prints `warning: Skipping installation of entry points (project.scripts)...` to stderr on every invocation for this project template — it does not mean the command failed. Before concluding a command failed, check the actual exit code and the test/build result, not just whether stderr is non-empty.

## 4. Keep tool-call JSON arguments strictly valid

Malformed tool-call arguments get auto-repaired by the harness, but each repair is a wasted round trip. Common breakage: unbalanced braces/brackets and unescaped quotes inside string values (e.g. `search_files` patterns, `patch` content). Double-check bracket/quote balance before emitting a tool call, especially for multi-line string arguments.

## 5. Trust a clean exit code — don't grep a passing check for a string that will never appear

Observed live: a tester session ran `uv run ty check ... | grep "<worktree-path>" -B1 -A8` in a loop for 10+ minutes. `ty check` had already printed `All checks passed!`, but the worktree path never appears in clean output, so the grep kept returning nothing and the session treated "empty grep result" as "unconfirmed" instead of "nothing to report." The watchdog had to kill and reclaim the task twice.

**Rule:** when a check command prints an explicit pass line (`All checks passed!`, `passed`, exit 0) run it plain and read that signal directly. Do not pipe a known-good check through `grep` for a specific string (a path, a filename, an error keyword) as your only success criterion — an empty grep match on a passing check is not a failure signal, it just means the string isn't in the output.
