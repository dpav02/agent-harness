---
type: api
title: Polymarket CLOB client
description: py-clob-client order placement, API keys, CLOB endpoints, common gotchas
tags: [polymarket, clob, trading, python]
timestamp: 2026-07-04T16:00:00Z
resource: https://docs.polymarket.com/
---

# Polymarket CLOB client

Used in [polymarket-trader](https://github.com/dpav02/polymarket-trader).

## Client

- Python: `py-clob-client` (`ClobClient`)
- Requires API key + secret + passphrase from Polymarket builder profile
- Base URL: production CLOB API (see project config)

## Order flow

1. Resolve market `token_id` / condition ID from Gamma or CLOB metadata
2. Build limit order with price, size, side (BUY/SELL)
3. Sign and post via client; handle `INVALID_ORDER`, insufficient balance

## Gotchas (small models hallucinate these)

- **Tick size** and **min size** vary per market — read market metadata
- **USDC allowance** on Polygon required before sell orders
- Weather markets: ensemble forecast timing vs market resolution window
- Paper vs live: project may gate live trading behind env flag

## Rate limits

- Respect HTTP 429; exponential backoff ([Resilience](../../practices/resilience.md))
- WebSocket for fills where available vs polling

## Related

- [Hyperliquid WebSocket](../hyperliquid/websocket-api.md) — sibling market in polymarket-trader
