---
type: practice
title: Frontend design
description: Production UI craft — distinctive design, anti-slop, Tailwind v4, component patterns
tags: [frontend, react, tailwind, design, ui]
timestamp: 2026-07-04T16:00:00Z
resource: https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md
---

# Frontend design

Distilled from Anthropic frontend-design skill, Vercel agent-resources, and devshop frontend-craft/review skills.

## Core principles

1. **Match spec tone** — read Design direction in task packet; do not invent a different product aesthetic
2. **Anti-AI-slop** — avoid centered single-card hero as entire app, purple gradient soup, Inter-only generic SaaS, decorative blobs without purpose
3. **Real states** — empty, loading, error for every user workflow; not just happy path
4. **One polished workflow** over many shallow components

## Stack defaults (this workspace)

- React 19 + Vite + Tailwind v4
- Utilities in `className`; `@theme inline` for tokens; no inline styles except dynamic values
- Prefer template Tailwind stack; no shadcn/MUI unless spec authorizes

## Layout hardening

- Flex/grid children that truncate: `min-w-0`
- Long strings: wrap or truncate; accessible tooltips only when needed
- Buttons/links: visible accessible names — not icon-only without `aria-label`

## Responsive and a11y

- Mobile-first; test sm/md breakpoints
- WCAG AA default: keyboard nav, form labels, contrast on risky UI
- Respect `prefers-reduced-motion` for interaction tests

## Testing UI

- Test user workflows from acceptance criteria, not only "renders without crash"
- Prefer Testing Library: `getByRole`, `getByLabelText`, `getByText`

## Related

- [UI/UX](ui-ux.md)
- [Testing](testing.md)
- [frontend-craft skill](../../hermes/skills/frontend-craft/SKILL.md)
