---
type: practice
title: Frontend Tailwind and styling
description: Tailwind v4 rules, styling stack conventions, CSS, layout mechanics
tags: [frontend, tailwind, css, styling]
timestamp: 2026-07-19T00:00:00Z
---

# Tailwind and styling

Load when writing Tailwind, CSS, or theme/token code.

## Stack defaults (this workspace)

- React 19 + Vite + Tailwind v4. Utilities in `className`; no inline `style={{}}` except dynamic values utilities can't express.
- Prefer the template Tailwind stack; no shadcn/MUI unless the spec authorizes.

## Tailwind v4

- `@theme inline` for tokens; `@plugin` for plugins. No `tailwind.config.ts` unless the repo already has one.
- `:root`/`.dark` **outside** `@layer base`; in `@layer base` use `var(--token)` (no double-wrapping).
- Wrap color values with `hsl()`/OKLCH in `:root`/`.dark`. Map vars to utilities via `@theme inline { --color-x: var(--x); }`.
- No `tailwindcss-animate`, no `tw-animate-css`, no container-queries plugin (built-in in v4).
- Repeat clusters **≥3×** → component or `@apply` — don't `@apply` whole components (hides responsive variants).
- Mobile-first; theme-aware classes (`bg-background`, `text-foreground`).

## Layout mechanics

- Flex/grid children that truncate: **`min-w-0`**. Full-bleed: `env(safe-area-inset-*)`.
- Long strings: wrap or truncate; accessible tooltips only when needed.
- Semantic z-index scale (dropdown → sticky → modal → toast → tooltip); never arbitrary `9999`.

## CSS / non-Tailwind repos

- Match project tokens and CSS-module conventions. No inline styles when utilities/tokens exist.

## Related

- [Frontend design](frontend-design.md)
- [Frontend React/Next](frontend-react.md)
