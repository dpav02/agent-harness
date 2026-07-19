---
type: practice
title: Frontend design
description: Distinctive UI craft — design direction, typography, color, motion, anti-slop
tags: [frontend, design, typography, color, motion, ui]
timestamp: 2026-07-19T00:00:00Z
resource: https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md
---

# Frontend design

Distinctive visual craft. Load for greenfield UI, redesigns, or any "make this look intentional" task.

## Core principles

1. **Match spec tone** — read Design direction in the task packet; do not invent a different aesthetic.
2. **Real states** — empty, loading, error for every workflow, not just the happy path.
3. **One polished workflow** over many shallow components.

## Design direction (greenfield — commit before coding)

- **Purpose** — who uses this and why.
- **Tone** — deliberate aesthetic (minimal, editorial, utilitarian, bold), not default SaaS chrome.
- **Constraints** — framework, a11y, performance, existing tokens.
- **Differentiation** — one memorable choice; intentional asymmetry or typography beats template layouts.
- Existing codebase: extend components/tokens/patterns — no unprompted redesign. Read `.impeccable.md` / `DESIGN.md` / `PRODUCT.md` when present.

## Anti-AI-slop

Bans (the fingerprints of generated work):

- Gradient text (`background-clip: text`); side-stripe accent borders (>1px on one side).
- Identical icon+title+body card grids; card-wrapping everything; nested cards.
- Purple-on-dark / neon-on-dark / cyan-on-dark palette; dark mode with glowing accents as the default.
- Centered-everything; a single centered hero card as the whole app.
- Inter/Roboto/Arial as a greenfield identity; decorative blobs; hand-drawn/sketchy SVG.
- Tiny uppercase tracked eyebrow above every section; 01/02/03 numbered scaffolding as default.

## Typography

- Clear hierarchy; fluid sizing (`clamp`) where appropriate; `text-wrap: balance` on headings, `pretty` on prose.
- Pair a distinctive display font with a refined body; avoid overused defaults as a greenfield identity — defer to repo fonts when set.
- Display heading ceiling ~6rem; letter-spacing floor ≥ -0.04em. Body line length 65–75ch.
- Tabular figures (`tabular-nums`) for money/metrics. No monospace for "tech vibe" alone.
- `…` not `...`; curly quotes in prose.

## Color and theme

- Pick a strategy first: restrained (neutrals + one accent ≤10%), committed (one color 30–60%), full palette (3–4 roles), or drenched.
- OKLCH / tokens / `color-mix` when the stack supports it.
- No gray-on-color washout; no pure `#000`/`#fff` when tokens exist — always tint. Nudge neutrals 0.005–0.015 chroma toward the brand hue.
- Reject the clichéd AI palette unless the brand requires it.
- Dark mode: `color-scheme: dark` on `html`; theme-color meta matches background.

## Motion

- Animate **transform** and **opacity** only — not width/height/margin.
- Natural deceleration (ease-out); no bounce/elastic on product UI. No `transition: all` — list properties explicitly.
- `prefers-reduced-motion`: reduced variant or disable — not optional.
- One orchestrated entrance beats scattered trivial animations; staggering one list is fine.

## Layout rhythm

- Tight groups, clear separations — not identical padding everywhere.
- Intentional asymmetry over center-everything; container queries for component responsiveness.
- Flex for 1D, grid for 2D; `repeat(auto-fit, minmax(280px, 1fr))` for breakpoint-free grids.

## Related

- [UI/UX](ui-ux.md)
- [Frontend WIG](frontend-wig.md)
- [Frontend Tailwind](frontend-tailwind.md)
