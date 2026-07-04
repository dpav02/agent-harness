---
type: api
title: Solana RPC and Helius
description: Solana JSON-RPC, Helius enhanced APIs, wallet profiling patterns
tags: [solana, helius, rpc, blockchain]
timestamp: 2026-07-04T16:00:00Z
resource: https://docs.helius.dev/
---

# Solana RPC and Helius

Used in [sol-wallet-scanner](https://github.com/dpav02/sol-wallet-scanner).

## RPC basics

- JSON-RPC: `getSignaturesForAddress`, `getTransaction`, `getTokenAccountsByOwner`
- Commitment: `confirmed` for indexer; `finalized` for accounting
- Rate limits: use Helius or dedicated RPC; public RPC throttles aggressively

## Helius

- Enhanced transaction parsing, DAS API for NFTs/tokens
- Webhooks for address activity (optional)
- API key in env; never commit

## Wallet profiling patterns

- Seed list → expand via counterparties in parsed txs
- Filter bot/MEV signatures (high frequency, known program IDs)
- PnL verification: optional Birdeye API cross-check

## Gotchas

- **Token decimals** — always normalize before comparing amounts
- **Associated token accounts** — wallet may hold multiple ATAs per mint
- **Pump.fun / Raydium** program IDs for meme coin routing — see [Jupiter and pump.fun](jupiter-pump.md)

## Related

- [Resilience](../../practices/resilience.md) — RPC retry policy
