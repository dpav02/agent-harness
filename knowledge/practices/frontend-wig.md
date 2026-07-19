---
type: practice
title: Frontend Web Interface Guidelines
description: Mechanical UI correctness — a11y, focus, forms, nav, touch, intl, images, content
tags: [frontend, accessibility, forms, wig, a11y]
timestamp: 2026-07-19T00:00:00Z
resource: https://vercel.com/docs/agent-resources/skills
---

# Web Interface Guidelines

Mechanical checklist for correct, accessible UI. Load when touching forms, a11y, focus, or interactive controls.

## Accessibility

- Icon-only buttons: `aria-label`. Form controls: `<label>` or `aria-label`.
- `<button>` for actions, `<a>`/`<Link>` for navigation — not `div`+`onClick`.
- Images: meaningful `alt`, or `alt=""` + `aria-hidden="true"` if decorative.
- Toasts/validation: `aria-live="polite"`. Semantic HTML before ARIA.
- Headings hierarchical; skip link to main; `scroll-margin-top` on anchors.
- Color is never the sole indicator of state.

## Focus

- Visible focus: `focus-visible:ring-*` or equivalent. Never `outline-none` without a replacement.
- Prefer `:focus-visible` over `:focus` on click targets; `:focus-within` for compound controls.

## Forms

- `autocomplete` + meaningful `name`; correct `type`/`inputmode`.
- Never block paste. Labels clickable (`htmlFor` or wrap). `spellCheck={false}` on emails/codes/usernames.
- Submit enabled until the request starts; spinner during submit. Errors inline; focus the first error on submit.
- Placeholders end with `…` and show an example pattern. Warn before navigation with unsaved changes.

## Navigation and state

- URL reflects filters/tabs/pagination/expanded panels (query params / nuqs). Deep-link stateful UI.
- Real links for navigation. Destructive actions: confirm or undo — never immediate silent delete.

## Touch and interaction

- 44px min touch targets on product controls. `touch-action: manipulation`; intentional tap highlight.
- `overscroll-behavior: contain` in modals/drawers/sheets.
- `autoFocus` sparingly — desktop, single primary field; avoid on mobile.

## Intl and hydration

- Dates/times `Intl.DateTimeFormat`; money/numbers `Intl.NumberFormat` — no hardcoded formats.
- Code tokens / brand names: `translate="no"`. Controlled inputs need `onChange`.
- Guard date rendering against hydration mismatch.

## Images and performance

- Explicit `width`/`height` (CLS); lazy below the fold. Lists >50 items: virtualize or `content-visibility`.
- No layout reads in render (`getBoundingClientRect`, `offsetHeight`). `preconnect` for asset domains.

## Content and hardening

- Long text: `truncate`, `line-clamp-*`, `break-words`. Anticipate short / average / very long input.
- Empty/loading/error states explicit on every changed flow. Slow/failed API paths handled, not swallowed.
- i18n: leave room for longer strings.

## Related

- [UI/UX](ui-ux.md)
- [Frontend React/Next](frontend-react.md)
- [Frontend Tailwind](frontend-tailwind.md)
