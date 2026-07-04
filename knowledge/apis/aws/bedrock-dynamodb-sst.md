---
type: api
title: AWS Bedrock DynamoDB SST
description: jobpriced stack — Bedrock multi-model routing, DynamoDB, SST Ion, Lambda SSE
tags: [aws, bedrock, dynamodb, sst, lambda]
timestamp: 2026-07-04T16:00:00Z
resource: https://docs.aws.amazon.com/bedrock/
---

# AWS Bedrock, DynamoDB, SST (jobpriced)

Used in [jobpriced](https://github.com/dpav02/jobpriced) monorepo.

## SST Ion

- Infrastructure in `infra/`; `sst deploy` for stages
- Lambda + API Gateway; Cognito auth; S3 assets; DynamoDB tables

## Bedrock

- Multi-model routing in API layer (Claude, etc.)
- Streaming responses via Lambda → API Gateway SSE to web PWA
- IAM: Lambda execution role needs `bedrock:InvokeModel` on specific model ARNs

## DynamoDB

- Single-table or entity-per-table per project conventions
- GSIs for query patterns; avoid scans in hot paths
- Conditional writes for optimistic concurrency

## Other services

- **Transcribe** — voice intake for estimates
- **SES** — transactional email
- **Stripe** — billing webhooks (verify signature)

## Gotchas

- **Cold start** — keep Lambda bundles small; connection reuse for AWS SDK
- **SSE timeout** — API Gateway 29s limit; chunk heartbeats for long LLM streams
- **Secrets** — SSM/Secrets Manager; never in client bundle

## Related

- [backend-ts skill](../../opencode/skills/backend-ts/SKILL.md)
- [Security](../../practices/security.md)
