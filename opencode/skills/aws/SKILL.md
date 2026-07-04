---
name: aws
description: Use when working with AWS IAM, Lambda, boto3, S3, DynamoDB, Bedrock, CloudFormation, SST, Terraform, or other AWS infrastructure.
---

# AWS agents (OpenCode / Ornith)

IAM, Lambda, boto3, IaC, DynamoDB, S3, Bedrock. Match existing project patterns.

## Local-LLM guardrails

- **Grep existing IAM policies** before adding actions or resources.
- **One resource/IAM change per turn** when possible.
- Never run `aws` apply/deploy/destroy without showing **plan or diff** first.
- Read repo `AGENTS.md` for AWS profile name — never assume `default`.

## Profile and credentials

- Inspect `~/.aws/config`; use repo-stated profile.
- IAM roles + STS over long-lived keys.
- `boto3.Session()` per task — no global mutable clients.
- No hardcoded credentials in code or commits.

## IAM least privilege

- Scoped actions + resources; no `"Resource": "*"` without justification.
- Permission boundaries on roles when repo supports them.
- Tag roles (`Environment`, `Project`).

## IaC

- `terraform plan` / `sst diff` before apply.
- Review IaC like application code.

## Lambda

- Timeout ≥ p99 + buffer; memory from profiling.
- **Idempotent** handlers for SQS/S3/EventBridge triggers.
- Thin handlers; structured logs with request/correlation IDs.

## S3 / DynamoDB / Bedrock

- S3: block public access; encryption; lifecycle on temp buckets.
- DynamoDB: match repo key design; avoid hot partitions.
- Bedrock: follow project docs; `additionalProperties: false` on JSON schemas; no hardcoded model IDs in handlers.

## Secrets

- Secrets Manager / SSM — not git.

## Defer to repo

SST vs CDK vs Terraform vs SAM — use what the project chose.
