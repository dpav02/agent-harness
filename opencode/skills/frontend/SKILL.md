---
name: frontend
description: Use when building or editing UI, React/Next components, Tailwind CSS, accessibility, forms, layout, or frontend performance.
---

# Frontend agents (OpenCode / Ornith)

Frontend craft, WIG, React/Next perf, Tailwind v4.

## Deep reference

Load **knowledge-lookup** → [frontend-design](~/dev/agent-harness/knowledge/practices/frontend-design.md), [ui-ux](~/dev/agent-harness/knowledge/practices/ui-ux.md) before greenfield UI work.

## Ornith guardrails

- One UI concern per turn when possible (layout, then states, then a11y).
- Run build/lint on touched frontend paths before claiming done.
- Component tests: follow **`testing-agents.md`** — smallest test command first.

## Context: greenfield vs existing product

- **Existing codebase:** Extend components, tokens, patterns. No unprompted visual redesign.
- **Greenfield:** Confirm audience, use case, brand tone when missing. Read `.impeccable.md` or repo `DESIGN.md` / `PRODUCT.md` when present.
- **AI slop check:** Push away from generic AI output (purple-on-dark, identical card grids, Inter-only greenfield, centered-everything).

## Design thinking (greenfield)

Before coding UI, commit to direction:

- **Purpose** — who uses this and why?
- **Tone** — pick a deliberate aesthetic (minimal, editorial, utilitarian, bold) — not default SaaS chrome.
- **Constraints** — framework, a11y, performance, existing tokens.
- **Differentiation** — one memorable choice; intentional asymmetry or typography beats template layouts.

## Typography and type

- Clear hierarchy; fluid sizing (`clamp`) where appropriate.
- Avoid Inter/Roboto/Arial as whole greenfield identity — defer to repo fonts when set.
- Tabular figures for money/metrics. No monospace for "tech vibe" alone.
- `…` not `...`; curly quotes in prose; `text-wrap: balance` on headings; `tabular-nums` on number columns.

## Color and theme

- Cohesive palette; dominant + accent beats timid equal weight.
- OKLCH / tokens / `color-mix` when stack supports it.
- No gray-on-color washout; no pure `#000`/`#fff` when tokens exist.
- Reject clichéd AI palette (neon-on-dark, gradient text on metrics) unless brand requires it.
- Dark mode: `color-scheme: dark` on `html`; theme-color meta matches background.

## Layout and space

- Rhythm: tight groups, clear separations; not identical padding everywhere.
- Intentional asymmetry over center-everything; container queries for component responsiveness.
- No card wrapping everything; no nested cards; no identical icon+title+body grids.
- Flex/grid children that truncate: **`min-w-0`**. Full-bleed: `env(safe-area-inset-*)`.

## Motion

- Animate **transform** and **opacity** only — not width/height/margin transitions.
- Natural deceleration (ease-out); no bounce/elastic defaults on product UI.
- **`prefers-reduced-motion`** — reduced variant or disable.
- No `transition: all` — list properties explicitly.
- One orchestrated entrance beats scattered trivial animations.

## Interaction and UX writing

- Progressive disclosure; empty/error states that teach next step.
- Button hierarchy: not everything primary — ghost, secondary, links.
- Active voice; specific button labels ("Save API Key" not "Continue").
- Errors: what happened + what to do next. Loading: "Saving…" with ellipsis.

## Web Interface Guidelines (inlined)

### Accessibility

- Icon-only buttons: `aria-label`. Form controls: `<label>` or `aria-label`.
- Interactive: keyboard handlers where needed; `<button>` for actions, `<a>`/`<Link>` for navigation.
- Images: meaningful `alt` or `alt=""` if decorative. Decorative icons: `aria-hidden="true"`.
- Toasts/validation: `aria-live="polite"`. Semantic HTML before ARIA soup.
- Headings hierarchical; skip link to main content; `scroll-margin-top` on heading anchors.

### Focus

- Visible focus: `focus-visible:ring-*` or equivalent.
- Never `outline-none` without focus replacement.
- Prefer `:focus-visible` over `:focus` on click targets.
- `:focus-within` for compound controls.

### Forms

- `autocomplete` and meaningful `name`; correct `type` / `inputmode`.
- Never block paste. Labels clickable (`htmlFor` or wrap control).
- `spellCheck={false}` on emails, codes, usernames.
- Submit enabled until request starts; spinner during submit.
- Errors inline; focus first error on submit.
- Placeholders end with `…` and show example pattern.
- Warn before navigation with unsaved changes.

### Navigation and state

- URL reflects filters, tabs, pagination, expanded panels (query params / nuqs).
- Real links for navigation — not `div` + `onClick`.
- Deep-link stateful UI. Destructive actions: confirm or undo — not immediate silent delete.

### Touch and interaction

- **44px** min touch targets on product UI controls.
- `touch-action: manipulation`. Intentional tap highlight.
- `overscroll-behavior: contain` in modals/drawers/sheets.
- `autoFocus` sparingly — desktop, single primary field; avoid on mobile.

### Intl and hydration

- Dates/times: `Intl.DateTimeFormat`. Money/numbers: `Intl.NumberFormat` — no hardcoded formats.
- Code tokens / brand names: `translate="no"`.
- Controlled inputs need `onChange`. Guard date rendering against hydration mismatch.

### Images and performance (UI)

- Explicit `width`/`height` on images (CLS). Lazy below fold.
- Lists >50 items: virtualize or `content-visibility`.
- No layout reads in render (`getBoundingClientRect`, `offsetHeight` in render path).
- `preconnect` for CDN/asset domains when applicable.

### Content handling

- Long text: `truncate`, `line-clamp-*`, `break-words`. Empty states explicit.
- Anticipate short, average, very long user input.

## React / Next performance (inlined)

1. **No fetch waterfalls** — batch with `Promise.all`; Server Components / server data layer over `useEffect` fetch when repo uses App Router.
2. **Server-side data** — fetch on server; `React.cache()` for deduped server fetches when applicable.
3. **Component structure** — small focused components; composition over deep prop trees.
4. **Rendering** — `React.memo`/`useMemo` only when measured; prefer decomposition.
5. **State** — server state (TanStack Query/SWR) vs local UI state; don't sync derived state in `useEffect`.
6. **Bundle** — route-level splitting; avoid heavy client imports on critical paths.
7. **Lists** — stable keys; virtualize long lists.
8. **Advanced** — `useTransition` for non-blocking updates when appropriate.

## Component architecture

- **Primitive → component → block → template** — don't skip layers when repo uses them.
- **shadcn/Radix:** reuse `components/ui/` — don't hand-roll Dialog/Select. `asChild` + composition.
- Semantic HTML first; data attributes for styling when repo pattern uses them.

## Styling stack (Tailwind when present)

- Utilities in `className`; **no** inline `style={{}}` except dynamic values utilities can't express.
- **Tailwind v4:** `@theme inline`; `@plugin` for plugins; `:root`/`.dark` **outside** `@layer base`; in `@layer base` use `var(--token)`. No `tailwind.config.ts` unless repo already uses one. No `tailwindcss-animate`, no `tw-animate-css`, no container-queries plugin (built-in v4).
- Repeat clusters **≥3×** → component or `@apply` — don't `@apply` whole components if it hides responsive variants.
- Mobile-first; theme-aware classes (`bg-background`, `text-foreground`).

## CSS / non-Tailwind repos

- Match project tokens and CSS modules conventions.
- No inline styles when utilities/tokens exist.

## Hardening

- Overflow, loading/empty/error states, i18n room for longer strings.
- Slow/failed API paths handled explicitly.

## React (any stack)

- One main component per file; named exports when codebase does.
- Rules of Hooks; cleanup subscriptions/timers/abort.
- Derive state; avoid prop drilling past 2–3 levels.
- a11y: semantic elements before `div`+`onClick`; meaningful `alt`.

## Next.js App Router (when repo uses it)

- `"use client"` only where hooks/browser APIs require it.
- `next/navigation` not `next/router`. `metadata` / `generateMetadata` not `next/head`.
- `next/image`, `next/font` when project already uses them.
- Await async `cookies`, `headers`, `params` per current Next version.

## Pre-ship UI checklist

Before claiming UI work done:

- [ ] Contrast, focus visible, keyboard operable on changed surfaces
- [ ] Loading, empty, error states on changed flows
- [ ] Responsive — critical actions reachable on small screens
- [ ] No AI slop tells (gradient text, identical card grid, side-stripe borders)
- [ ] Long strings / translations don't break layout (`min-w-0`, truncate/clamp)
- [ ] Build/lint passes; component tests per **`testing-agents.md`** when behavior changed

## Defer to repo

Extend existing design system, TanStack Query/SWR/RSC patterns, and component APIs — don't rip out working stack choices.
