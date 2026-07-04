---
type: api
title: Jupiter and pump.fun
description: Solana DEX aggregation, pump.fun bonding curve, meme coin discovery
tags: [solana, jupiter, pump.fun, dex]
timestamp: 2026-07-04T16:00:00Z
resource: https://station.jup.ag/docs/
---

# Jupiter and pump.fun

## Jupiter

- Swap API: quote → swap transaction → sign → send
- Slippage bps parameter required
- Route may split across Raydium, Orca, etc.

## pump.fun

- Bonding curve launches; migrate to Raydium at threshold
- PumpPortal WebSocket for new token events (sol-wallet-scanner)
- Parser must handle program-specific account layout

## Discovery workflow (sol-wallet-scanner)

1. DexScreener trending OR seed wallet list
2. Score traders by win rate, hold time, bot heuristics
3. Rank UI in React + FastAPI backend

## Gotchas

- **Slot time** — txs confirm in ~400ms blocks; don't assume instant finality
- **Fake volume** — filter wash trading via holder concentration
- Jupiter API version changes — verify against project lockfile/docs
