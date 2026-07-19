---
name: frontend
description: Use when building or editing UI, React/Next components, Tailwind CSS, accessibility, forms, layout, or frontend performance.
---

# Frontend (OpenCode / Ornith)

Router + gates. Load the **one** knowledge slice your task needs via `knowledge-lookup` — do not pull the whole bundle.

## Gates (every frontend turn)

- One UI concern per turn (layout → states → a11y).
- Run build/lint on touched paths before claiming done; component tests per **`testing-agents.md`** (smallest command first).
- AI-slop quick check: no gradient text, identical card grids, side-stripe borders, Inter-only greenfield, centered-everything.
- Existing codebase: extend components/tokens/patterns — no unprompted visual redesign.

## Load the slice you need

| Task | Read |
|------|------|
| Greenfield look, typography, color, motion, anti-slop | `knowledge/practices/frontend-design.md` |
| Hierarchy, cognitive load, IA, UX copy | `knowledge/practices/ui-ux.md` |
| a11y, forms, focus, touch, intl, images | `knowledge/practices/frontend-wig.md` |
| React, Next App Router, perf, components | `knowledge/practices/frontend-react.md` |
| Tailwind v4, styling, CSS, layout mechanics | `knowledge/practices/frontend-tailwind.md` |

Absolute path on VPS: `~/dev/agent-harness/knowledge/practices/`.

## Pre-ship checklist

Before claiming UI work done:

- [ ] Contrast, focus visible, keyboard operable on changed surfaces
- [ ] Loading, empty, error states on changed flows
- [ ] Responsive — critical actions reachable on small screens
- [ ] No AI slop tells (gradient text, identical card grid, side-stripe borders)
- [ ] Long strings / translations don't break layout (`min-w-0`, truncate/clamp)
- [ ] Build/lint passes; component tests per **`testing-agents.md`** when behavior changed

## Defer to repo

Extend the existing design system, query patterns (TanStack Query/SWR/RSC), and component APIs — don't rip out working stack choices.
