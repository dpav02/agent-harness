# Database agents (OpenCode / Ornith)

Data modeling, SQL, ORMs, migrations — Postgres, MySQL, DuckDB; Django, SQLAlchemy, Alembic.

## Local-LLM guardrails for DB work

- Before editing a model, **grep** table/column name across repo **and** existing migrations.
- Never combine schema change + data backfill + constraint enforcement in **one** migration unless the table is tiny.
- When unsure which ORM loader to use, **state relationship cardinality** (1:1, N:1, 1:N, N:M) then pick from the cheat sheet below.
- After queryset changes, **run or describe** query-count verification (django-debug-toolbar, SQL echo, test assertion).
- **DuckDB:** never point the main OLTP write path at DuckDB — analytics only.

## Context: greenfield vs existing

- Extend project models, migrations, query patterns. No ORM/engine swap unprompted.
- Greenfield: 3NF first; PK strategy and audit columns before table one.

## Universal data modeling

- **3NF first** — denormalize only after measured join bottleneck.
- Junction tables for M:N; FK constraints in DB.
- **PKs:** Postgres `BIGSERIAL`; cross-DB UUIDs prefer **UUID v7**. MySQL `BIGINT UNSIGNED AUTO_INCREMENT`.
- **`created_at`, `updated_at`** UTC on every table.
- Soft deletes: `deleted_at` + filter in every query.
- Smallest correct types; JSONB/JSON for flexible metadata only — promote hot filter paths to columns.
- Index from **actual query patterns**; index FK columns.
- Additive evolution: expand → backfill → contract.

## Engine roles

| Engine | Role | Rules |
|--------|------|-------|
| **PostgreSQL** | OLTP | FK, `timestamptz`, `CREATE INDEX CONCURRENTLY`, `NOT VALID` then validate |
| **MySQL InnoDB** | OLTP | `utf8mb4`, explicit FKs, `BIGINT UNSIGNED AUTO_INCREMENT` |
| **DuckDB** | OLAP | Single-writer; query templates not raw SQL; timeouts; isolated worker |

**Hybrid:** Postgres/MySQL writes; DuckDB analytics via batch/CDC — no heavy `GROUP BY` on OLTP primary.

## N+1 prevention

| Relationship | Django | SQLAlchemy 2.x |
|--------------|--------|----------------|
| FK / OneToOne | `select_related('author')` | `joinedload(Model.author)` |
| Reverse FK / M2M | `prefetch_related('tags')` | `selectinload(Model.tags)` |
| Filtered/nested | `Prefetch('comments', queryset=…)` | chained `.options(...)` |
| Block lazy (dev) | query logging | `raiseload()` |

- Eager load at queryset construction — not in templates/serializers.
- `select_related` on M2M = silent failure in Django; large collections → `selectinload` not `joinedload`.
- `only()` / `defer()` for list views; aggregates in SQL not Python.

## Django

- Explicit `related_name`; `transaction.atomic()` for multi-step writes.
- Separate schema vs data migrations; `apps.get_model()` in `RunPython`; batch backfills; `atomic = False` for long migrations.
- Avoid signals that block `bulk_create` / `update()`.
- PKs in service functions when instance not needed.

## SQLAlchemy + Alembic

- Review every autogenerate — never ship blind.
- **Expand → backfill → contract:**
  1. Add nullable column
  2. Deploy dual-write if renaming
  3. Backfill (separate revision, chunked)
  4. Add NOT NULL / FK after backfill
  5. Deploy read-new-only
  6. Drop old column
- Separate DDL from DML revisions.
- Postgres: `CREATE INDEX CONCURRENTLY`; FK `NOT VALID` then validate.
- Test upgrade + downgrade in CI when supported.

## Migration checklist

- [ ] No table locks / full rewrites in autogen SQL
- [ ] Backfill batched separately
- [ ] Compatible with deployed app version
- [ ] Indexes on new FK/filter columns
- [ ] Grep’d renamed/dropped columns
- [ ] Downgrade tested or marked non-reversible

## Prisma

- `schema.prisma` is source of truth; `prisma migrate dev` / `deploy`.
- Both sides of relations with explicit `@relation`.
- `select` / `include` intentionally — N+1 rules apply (`include` = eager load).
- `$transaction` for multi-step writes.
- `$queryRaw` tagged templates only — no string-interpolated user input.
- Repos: SparkCatch, `scheduled-media`.

## Defer to repo

Django vs Alembic vs Prisma, SQLite in tests, raw SQL — use what the project chose.
