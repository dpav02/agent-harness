---
type: practice
title: Security
description: Trust boundaries, secrets, auth, input validation for agent-written code
tags: [security, auth, secrets, validation]
timestamp: 2026-07-04T16:00:00Z
---

# Security

Minimum bar for production-grade agent output.

## Trust boundaries

- Validate all external input at API edge (schema, types, length limits)
- Never trust client-side validation alone
- SQL/NoSQL: parameterized queries; no string concatenation

## Secrets

- Env vars only; never commit keys
- Canonical names in this workspace: `HF_TOKEN`, `CIVITAI_API_KEY` — no aliases
- Redact secrets in logs and error reports

## Auth

- Session/JWT/Cognito patterns per repo; don't roll custom crypto
- Principle of least privilege for IAM (Lambda, boto3)

## Dependencies

- Pin versions; audit new packages in task packet Dependencies table
- No `eval`, no `pickle` on untrusted data

## Related

- [API design](api-design.md)
- [AWS APIs](../apis/aws/bedrock-dynamodb-sst.md)
