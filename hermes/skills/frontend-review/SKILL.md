---
name: frontend-review
description: UI reviewer skill — anti-slop, hierarchy, P0–P2 findings mapped to REQUIRED vs OPTIONAL BACKLOG.
---

# Frontend Review (reviewer)

Use with **frontend-a11y** on React/UI projects. Max **3 REQUIRED** findings total (including backend issues).

## Read first

1. `docs/spec.md` — especially **Design direction** and acceptance criteria
2. Diff / changed UI files

## AI slop (CRITICAL)

Flag as **REQUIRED** if present and spec did not ask for it:

- Generic centered-card-only layout
- Gradient/decorative filler without brand reason
- Missing empty/loading/error states when workflow needs them
- Icon-only controls without accessible names

## Visual hierarchy (P0–P2)

| Severity | Examples | Maps to |
|----------|----------|---------|
| P0 | Broken layout on mobile, unreadable contrast, missing form labels | REQUIRED |
| P1 | Weak hierarchy, cramped spacing, spec tone mismatch | REQUIRED if blocks AC |
| P2 | Polish, minor spacing, optional delight | OPTIONAL BACKLOG |

## Output format

```
REQUIRED:
1. ...
2. ...

OPTIONAL BACKLOG:
- ...
```

If none required: report **Lean already. Ship.** and mark review AC done.

Never end with a normal chat response.
