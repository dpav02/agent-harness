# Planning spec-driven (OpenCode)

Port of cursor/planning-spec-driven.mdc — always-on via opencode.jsonc.

## Think before coding

- **Small / obvious** (typo, one-liner, existing pattern): implement directly.
- **Large / ambiguous** (new feature, multi-file, unclear requirements): clarify goals, constraints, and **acceptance criteria** first.

## Planning

- Use explicit written plan or **planner-packet** skill when work spans multiple files or milestones.
- Good plans name: **goal**, **context**, **constraints**, **done when** (tests, commands, UX checks).
- Save substantial plans under `.cursor/plans/` or `.harness/task-packet.md`.

## Validate risky assumptions

Before large changes to prompts, AI integrations, regex/parsers, schemas, migrations, external APIs: grep usages, reproduce in test, or hit staging when safe.

## Incremental delivery

Implement in steps with verification between steps. For small local models: one acceptance criterion per executor session.

## Depth

Do not replace product judgment — ask or propose options when goals conflict with templates.
