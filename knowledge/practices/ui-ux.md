---
type: practice
title: UI/UX
description: Visual hierarchy, information architecture, cognitive load, UX writing
tags: [ux, ui, accessibility, hierarchy, copy]
timestamp: 2026-07-19T00:00:00Z
resource: https://vercel.com/docs/agent-resources/skills
---

# UI/UX

UX judgment for any UI task. From Vercel web-interface-guidelines and critique/impeccable patterns.

## Visual hierarchy

- One primary action per view; scannable headings (size/weight contrast).
- Group related controls; whitespace separates sections.
- P0: broken mobile layout, unreadable contrast, missing form labels.
- P1: weak hierarchy, cramped spacing, spec tone mismatch.
- P2: polish, minor spacing — backlog unless blocking an AC.

## Cognitive load

- Progressive disclosure: essentials first, details on demand.
- Max 2 delight moments per feature (success/empty/error) — behavior, not libraries.
- Avoid dashboard sprawl unless the spec requires it.

## Information architecture

- Clear nav labels; current location obvious. Deep-link stateful UI.
- Error messages: what happened + what to do next. Empty states: explain the value and the next step.

## Interaction and UX writing

- Button hierarchy: not everything primary — ghost, secondary, links.
- Active voice; specific labels ("Save API Key" not "Continue"). Same verb through the flow ("Publish" → "Published").
- Errors don't apologize and aren't vague. Loading: "Saving…" with an ellipsis.

## Accessibility defaults

- Semantic HTML (`main`, `nav`, `button` vs div click handlers). Focus visible; logical tab order.
- Color not the sole indicator of state. Deep a11y/forms mechanics: [Frontend WIG](frontend-wig.md).

## Related

- [Frontend design](frontend-design.md)
- [Frontend WIG](frontend-wig.md)
