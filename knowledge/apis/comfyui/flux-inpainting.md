---
type: api
title: ComfyUI Flux inpainting pipeline
description: DGX Spark tattoo removal — API, worker, ComfyUI, MinIO, Flux service
tags: [comfyui, flux, dgx, gpu, inpainting]
timestamp: 2026-07-04T16:00:00Z
---

# ComfyUI Flux inpainting pipeline

Used in [tattoo_video_removal](https://github.com/dpav02/tattoo_video_removal) on DGX Spark.

## Architecture

- **API** (FastAPI) — upload, job orchestration
- **Worker** — GPU job queue, calls ComfyUI/Flux
- **MinIO** — S3-compatible object storage for inputs/outputs
- **web/** — Next.js 16 upload UI

## Deploy

- Sync via git to DGX checkout; post-pull verification script
- Auth env: `HF_TOKEN`, `CIVITAI_API_KEY` only
- spark_ops manages live stack on `edgexpert-84c0`

## Gotchas

- **GPU memory** — batch size and resolution limits per model
- **ComfyUI workflow JSON** — node IDs must match installed custom nodes
- **Job status** — poll or webhook; don't block HTTP on long inference

## Related

- Global AGENTS.md DGX deploy sequence
- [Observability](../../practices/observability.md) for worker logs
