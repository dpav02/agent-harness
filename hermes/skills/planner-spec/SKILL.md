---
name: planner-spec
description: Write .harness/task-packet.md (or docs/spec.md) with acceptance criteria, live package discovery, and documented dependency justification. Use with planner-packet for harness v2.
---

# Planner Spec

Use when writing specs for **planner-packet** or legacy docs/spec.md. Prefer `.harness/task-packet.md` format per knowledge/workflows/spec-handoff.md.

## Front-end policy (mandatory)

If the feature needs a **browser UI** (any front-end AC, dashboard, HTML page, local web UI):

1. Spec must require **React/Vite** (`web/` subdirectory on Python repos, or `--stack react-vite` for greenfield).
2. **Never** write Dependencies/Out of scope lines that forbid React or mandate "standard-library HTTP/HTML" for the UI.
3. Apply **frontend-spec** for Design direction and UI acceptance criteria.
4. Test paths for UI ACs must live under `web/` (e.g. `web/src/...`, `npm test` in `web/`).

Python API/backend-only features on `python-pytest` stacks do not need React unless they expose a user-facing browser UI.

Required sections:

1. **Goal** — one paragraph, user-visible outcome
2. **Acceptance criteria** — numbered, each testable by the packet's `check_command`
3. **Test paths** — exact commands or test file paths per criterion
4. **Dependencies** — required table if proposing any new package (see below)
5. **Out of scope** — explicit exclusions to prevent scope creep
6. **Design direction** — UI/React projects only (see **frontend-spec** skill)
7. **Milestones** — optional; required when epic-sized (see below)

### Acceptance criteria limits

- **Standard tier:** target **5–8** numbered ACs. Each AC is one testable outcome, not a sub-project.
- **ACs are atomic and dependency-ordered.** Each AC covers exactly one behavior. AC *n* may depend only on ACs `1..n-1`, never on a later AC. The pipeline implements ACs strictly in order, one per fresh-context worker session — AC *n*'s implementer only sees the spec and the git history left by ACs `1..n-1`, not this spec's other framing or any implicit forward reference. If two ACs are tightly coupled and can't be ordered (each needs the other to make sense), merge them into one AC.
- **Prefer splitting past 12 ACs**, but AC count alone is no longer a hard stop — per-AC mode auto-chunks each AC into its own implement task, so a well-ordered 10–12 AC spec ships fine in one pipeline. Split into separate launches when the feature actually spans **independent subsystems or repos** (not just "many ACs"):
  - Write **Out of scope** with explicit “Phase 2” items deferred to a **separate pipeline launch**.
  - In the Goal preamble, state: `Launch recommendation: run N separate devshop-pipeline-launch.sh calls` with draft prompts for each phase.
- Map every AC to an exact **Test path** (file or command). Prefer listing **file paths** over vague “add tests” — implementer reads less of the repo.
- Use **unique** pytest class names per file (`TestFoo` once per module). Duplicate class names shadow earlier tests.
- When an AC has a non-obvious failure mode (empty input, boundary value, concurrent write, network timeout, etc.), add it as a sub-bullet under that AC mapped to its own Test path — an edge case is a note on an existing AC, not a new AC. Do not add edge-case sub-bullets for ACs where the only failure mode is "the feature doesn't work."
- The pipeline already implements one AC per fresh-context task by default (chunk=1) — you do **not** need a Milestones section just to get per-AC isolation. Only add one to group several tightly related ACs into a coarser unit (see below).

### Milestones (optional — group ACs into coarser units)

By default each AC gets its own `Implement: AC<n>` task. Add a **Milestones** section only when you want to bundle a contiguous range of ACs into a single implement task instead — e.g. a handful of ACs that are trivial or must land in the same commit to make sense.

Add after Acceptance criteria:

```markdown
Planner mode: milestones

## Milestones

### M1 — Core layer (AC 1–3)
Brief scope for this slice.

### M2 — API surface (AC 4–6)
...
```

Rules:

- Each milestone covers a **contiguous AC range** with no gaps or overlaps.
- Milestones are **sequential** — M2 assumes M1 is done, same fresh-context-per-unit handoff as per-AC mode.
- If you cannot define clean milestones, **do not** use this mode — leave ACs ungrouped and let per-AC mode handle them individually.

### Dependencies (required if adding any)

| Package | Why needed | Alternatives rejected | Discovery source |
|---------|------------|----------------------|------------------|
| ...     | ...        | ...                  | npm/PyPI/docs URL |

## Package discovery rules

1. Read existing `package.json`, `package-lock.json`, `pyproject.toml`, or lockfiles **before** proposing deps.
2. Default to template/stdlib deps already in the worktree — do not add libraries for convenience.
3. When a dependency is plausible, **live discover** version and API (web search, npm/PyPI registry, official docs). Never rely on training memory for package names, versions, or APIs.
4. Every new dependency needs a row in the Dependencies table with a real discovery source URL.
5. If no new deps: write `None — template deps only.`

## UI projects

When `package.json` includes `react` or `react-dom`, apply **frontend-spec** for Design direction and UI acceptance criteria.

When `docs/spec.md` mentions a front-end but the worktree is Python-only, the pipeline scaffolds `web/` from the react-vite template before implement — planner must still write UI ACs for `web/`, not `src/.../frontend.py`.

## Planner tiers

Task body includes `Planner tier:` — follow it:

- **standard** — single frontier model; routine feature spec
- **fusion** — greenfield / multi-package / security-sensitive; use web search heavily for architecture and dependency decisions

## Epic-sized prompts

If the feature prompt is clearly an epic (many **independent subsystems**, “build entire app”, DB + API + UI + auth all in one prompt) — not just a long list of ACs:

1. **Prefer Tier 1 — phased launches:** propose 2–3 separate `devshop-pipeline-launch.sh` commands (Phase 1, Phase 2, …) and wait for user confirmation on **Phase 1 only**.
2. **Do not** launch one mega-pipeline hoping the planner will absorb everything.
3. A high AC count by itself is **not** a reason to split — per-AC mode implements each AC in its own fresh-context task by default. Write a normal ordered spec instead.
4. If the user insists on one PR for a genuinely multi-subsystem epic, tell them to ask for `--milestones` on launch and write a **Milestones** section grouping ACs by subsystem.

Example phased split (do not launch all at once):

```
Phase 1: ~/spark/devshop-pipeline-launch.sh --project sol-scanner "SQLite schema + discovery core"
Phase 2 (after phase 1 PR): ~/spark/devshop-pipeline-launch.sh --project sol-scanner --force-new "Stdlib HTTP UI for wallet list"
```

## Done when

1. Spec file exists with all required sections (`.harness/task-packet.md` preferred)
2. Ready for human review — planner does not implement code or run full test suites
