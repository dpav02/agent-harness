---
name: frontend-spec
description: Planner skill for UI projects — Design direction section and UI acceptance criteria in docs/spec.md.
---

# Frontend Spec (planner)

Use when the worktree is a **React/UI project** (`package.json` includes `react` or `react-dom`).

Add to `docs/spec.md` after **Goal** and before or within **Acceptance criteria**:

## Design direction (UI projects only)

```markdown
## Design direction

- **Audience + context:** who uses this and where (desktop, mobile, both)
- **Brand tone:** pick one specific direction (e.g. "clinical calm", "playful utility") — not "modern and clean"
- **Anti-references:** what to avoid (e.g. generic SaaS dashboard, centered card hero)
- **Responsive:** mobile-first; note key breakpoints if non-default
- **A11y:** WCAG AA default — keyboard, labels, contrast called out in AC if risky
- **Delight moments:** max 2 (success, empty, or error) — describe behavior, not libraries
```

## UI acceptance criteria

- **Stack:** user-facing UI is **React/Vite only** (`web/` or repo root with `package.json` + `react`). Never specify Python `http.server`, stdlib HTML, Flask, or FastAPI for browser UI in devshop pipelines.
- Include at least one criterion testable via component test or `devshop-check.sh` that covers layout/responsive or a11y when UI is primary deliverable.
- Reference **Test paths** for `npm test`, lint, build.

## Dependencies

- Do not add UI component libraries unless spec explicitly requires and table row justifies.
- Prefer template Tailwind v4 stack.

## Done when

`docs/spec.md` includes Design direction for UI projects; `kanban_complete` (gate commits spec).
