---
type: practice
title: Frontend React and Next.js
description: React rules, Next App Router, render/data performance, component architecture
tags: [frontend, react, nextjs, performance, components]
timestamp: 2026-07-19T00:00:00Z
resource: https://vercel.com/docs/agent-resources/skills
---

# React and Next.js

Load when writing React components, Next App Router code, or fixing render/data performance.

## React (any stack)

- One main component per file; named exports when the codebase does.
- Rules of Hooks; clean up subscriptions/timers/abort. Derive state — don't sync derived state in `useEffect`.
- Avoid prop drilling past 2–3 levels. Semantic elements before `div`+`onClick`.

## Performance

1. **No fetch waterfalls** — batch with `Promise.all`; Server Components / server data layer over `useEffect` fetch on App Router.
2. **Server-side data** — fetch on the server; `React.cache()` for deduped server fetches.
3. **Structure** — small focused components; composition over deep prop trees.
4. **Rendering** — `React.memo`/`useMemo` only when measured; prefer decomposition.
5. **State** — server state (TanStack Query/SWR) vs local UI state; don't sync derived state.
6. **Bundle** — route-level splitting; avoid heavy client imports on critical paths.
7. **Lists** — stable keys; virtualize long lists.
8. **Advanced** — `useTransition` for non-blocking updates when appropriate.

## Component architecture

- **Primitive → component → block → template** — don't skip layers when the repo uses them.
- **shadcn/Radix:** reuse `components/ui/` — don't hand-roll Dialog/Select. `asChild` + composition.
- Semantic HTML first; data attributes for styling when that's the repo pattern.

## Next.js App Router (when repo uses it)

- `"use client"` only where hooks/browser APIs require it.
- `next/navigation` not `next/router`. `metadata`/`generateMetadata` not `next/head`.
- `next/image`, `next/font` when the project already uses them.
- Await async `cookies`, `headers`, `params` per the current Next version.

## Related

- [Frontend Tailwind](frontend-tailwind.md)
- [Frontend WIG](frontend-wig.md)
- [Testing](testing.md)
