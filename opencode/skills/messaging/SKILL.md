---
name: messaging
description: Use when working with Celery, RabbitMQ, SQS, Kafka, message queues, async task workers, or event-driven consumers.
---

# Messaging agents (OpenCode / Ornith)

Celery, RabbitMQ, SQS, Kafka — queues, consumers, idempotency.

## Local-LLM guardrails

- Before adding a queue/broker, state **delivery guarantee + idempotency strategy** in one sentence.
- Never introduce Kafka or RabbitMQ without user ask **unless repo already uses it**.
- One consumer/task change per turn when possible.

## When to use which

| Need | Prefer |
|------|--------|
| Python background jobs | Celery + Redis/Rabbit |
| AMQP routing, on-prem | RabbitMQ |
| AWS serverless | SQS (+ Lambda) |
| Event stream, replay | Kafka |

Don't add Kafka for low-volume simple tasks.

## Universal

- At-least-once default — idempotent consumers.
- Idempotency key = business key, not message ID.
- DLQ + alerts; no infinite requeue.
- Pass IDs not objects in Celery payloads.

## Celery

- `task_acks_late=True`, `task_reject_on_worker_lost=True`, `worker_prefetch_multiplier=1`.
- Django: `transaction.on_commit()` before enqueue.
- Finite retries + backoff; separate priority queues.

## RabbitMQ

- Quorum queues; manual ack; prefetch 10–50 (1 if ordered).
- DLX + delivery limit; max-length + TTL on queues.

## SQS

- Visibility ≥ 3–6× processing time; DLQ maxReceiveCount 3–5.
- FIFO still needs idempotent handlers.

## Kafka

- `enable.idempotence=true`, `acks=all`; `enable.auto.commit=false`.
- `read_committed` for transactional producers.
- Transactional outbox for external DB/HTTP side effects.

## Defer to repo

Use the broker the project already chose.
