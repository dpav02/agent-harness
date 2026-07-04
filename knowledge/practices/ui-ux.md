---
type: practice
title: UI/UX
description: Visual hierarchy, information architecture, cognitive load, emotional tone
tags: [ux, ui, accessibility, hierarchy]
timestamp: 2026-07-04T16:00:00Z
resource: https://vercel.com/docs/agent-resources/skills
---

# UI/UX

From Vercel web-interface-guidelines and critique/impeccable skill patterns.

## Visual hierarchy

- One primary action per view; scannable headings (size/weight contrast)
- Group related controls; whitespace separates sections
- P0: broken mobile layout, unreadable contrast, missing form labels
- P1: weak hierarchy, cramped spacing, spec tone mismatch
- P2: polish, minor spacing — backlog unless blocking AC

## Cognitive load

- Progressive disclosure: show essentials first, details on demand
- Max 2 delight moments per feature (success, empty, or error) — behavior not libraries
- Avoid dashboard sprawl unless spec requires it

## Information architecture

- Clear nav labels; current location obvious
- Error messages: what happened + what to do next
- Empty states: explain value and next step

## Accessibility defaults

- Semantic HTML (`main`, `nav`, `button` vs div click handlers)
- Focus visible; logical tab order
- Color not sole indicator of state

## Related

- [Frontend design](frontend-design.md)
- [frontend-review skill](../../hermes/skills/frontend-review/SKILL.md)
