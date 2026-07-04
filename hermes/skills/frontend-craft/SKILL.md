---
name: frontend-craft
description: Composite implementer skill for React/Vite UI — anti-slop, spec design direction, Tailwind v4, a11y basics, hardening. Replaces frontend-design-pass.
---

# Frontend Craft (implementer)

Use on React/Vite devshop implement and UI review-fix tasks.

## Read spec first

1. **Goal** and **Acceptance criteria** — each criterion needs a test path.
2. **Design direction** (UI projects) — audience, tone, anti-references, responsive targets, a11y level, delight moments. Match spec; do not invent a different product.

## Product defaults

- Build what the spec asks. No auth, dashboards, routing, or APIs unless specified.
- One polished workflow over many shallow components.
- Local state first; localStorage only if spec requires persistence.

## Anti-AI-slop (required)

Do **not**:

- Centered single-card hero as the entire app
- Purple/blue gradient soup, decorative blobs, glassmorphism for its own sake
- Inter/Roboto-only generic SaaS look without spec direction
- Novelty motion, parallax, or animation libraries unless spec authorizes
- shadcn/MUI/Chakra or other component libraries — Tailwind utilities only

Do:

- Clear visual hierarchy (one primary action, scannable headings)
- Real empty, loading, and error states
- Semantic HTML, labeled forms, visible focus
- Responsive layout (mobile-first; test at sm/md breakpoints)

## Tailwind v4

Follow **tailwind-v4** skill: utilities in `className`, `@theme inline`, no inline styles except dynamic values.

## Layout hardening

- Flex/grid children that truncate: `min-w-0`
- Long strings: wrap or truncate with accessible tooltips only when needed
- Buttons and links: clear accessible names (not icon-only without `aria-label`)

## Tests

- Test the **user workflow** from acceptance criteria, not only "renders without crash"
- Run packet `check_command` before marking AC done

## Done when

Checks pass, git clean, AC marked done or failed with exact blocker.
