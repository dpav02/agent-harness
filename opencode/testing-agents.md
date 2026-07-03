# Testing agents (OpenCode / Ornith)

TDD, test quality, meaningful assertions. Loads every session — follow for all behavior changes.

## Ornith guardrails

- Run **smallest test command first** (`uv run pytest path::test`, `npm test -- path`, `vitest run path`).
- **One test + one behavior change** per turn when possible.
- On RED: paste failure output — confirm it's **behavioral**, not import/setup.
- On GREEN: report exit code + pass count.
- No tautological tests to pad coverage.

## When to TDD

- New behavior, bug fixes (regression first), refactors (characterization tests).
- Defer on pure config/static/low-risk glue if integration test suffices.

## Ponytail lens for tests

- Don't test what compiler/types already guarantee.
- One high-signal test > five trivial tests.
- Non-trivial logic **must** have a test that fails if behavior breaks.
- Prefer integration over mock maze when clearer.

## Red-Green-Refactor

1. **RED** — fail on missing/wrong behavior (not ImportError/typo).
2. **GREEN** — minimal pass.
3. **REFACTOR** — only while green.

Invalid RED: fix stub/setup until assertion fails for the right reason.

## Damn good tests

- Observable behavior at public surface (API, return value, UI text/role, DB state).
- Names like specs: `rejects_when_inventory_zero`.
- One behavior per test; AAA; explicit expected values.
- Edge cases on auth, payments, permissions, data integrity.

## Anti-patterns (reject)

- `assert True`, `1==1`, mock-existence checks.
- Private methods, internal call order, snapshot-only.
- Mock setup longer than test; >2 mocks → simplify design.
- `sleep()`; shared mutable state; happy-path-only on critical logic.
- Test breaks on refactor but behavior unchanged → test is wrong.

## Mocking

- External boundaries only: HTTP, DB, queue, filesystem, clock, cloud SDK.
- Patch at use site; fakes over deep trees.
- Assert mock mattered or remove it.

## Python

- pytest; parametrize boundaries; regression per bug.
- Query-count on hot list endpoints when repo supports it.

## TypeScript / UI

- Vitest/Jest; mock AWS in unit tests only.
- Testing Library: `getByRole` / `getByLabelText` first.
- User-visible outcomes, not component internals.

## Done checklist

- [ ] RED for expected business reason
- [ ] GREEN on targeted test + nearby suite
- [ ] Exit code reported
- [ ] No coverage theater
