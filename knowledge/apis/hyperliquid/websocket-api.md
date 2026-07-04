---
type: api
title: Hyperliquid WebSocket API
description: BTC/ETH microstructure, L2 book, hyperliquid-python-sdk patterns
tags: [hyperliquid, websocket, trading, crypto]
timestamp: 2026-07-04T16:00:00Z
resource: https://hyperliquid.gitbook.io/hyperliquid-docs/for-developers/api
---

# Hyperliquid WebSocket API

Used in polymarket-trader for BTC/ETH microstructure **paper** trading research.

## SDK

- Python: `hyperliquid-python-sdk`
- REST for account info; WebSocket for live L2/trades

## WebSocket subscriptions

- `l2Book` — bid/ask levels
- `trades` — public prints
- Reconnect with backoff; snapshot on reconnect

## Paper trading discipline

- Separate paper PnL from live Polymarket paths
- Log all signals with timestamp for replay

## Gotchas

- **Asset index** vs symbol string — use SDK constants
- **Funding rates** on perps vs spot — GMX research is separate path in repo
- Network disconnect during volatile periods — circuit breaker on stale book data

## Related

- [Polymarket CLOB](../polymarket/clob-client.md)
