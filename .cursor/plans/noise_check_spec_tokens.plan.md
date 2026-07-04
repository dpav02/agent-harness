---
name: Noise Check + Spec Tokens
overview: Two experiments in one swap cycle. (1) ornith-base speculative tokens 6 -> 11 throughput test (AEON card claims ~120 tok/s vs our ~79 at n=6; output-lossless, throughput bench only). (2) Prisma Tier 1 tool-eval repeat run, identical config, to measure run-to-run noise on the 91/100 score that anchors all routing decisions.
todos:
  - id: ornith-spec11
    content: Swap to ornith-base with NUM_SPECULATIVE_TOKENS=11 drop-in; run throughput bench; compare vs 78.8 tok/s baseline
    status: pending
  - id: restore-prisma-2
    content: Remove drop-in (or keep if n=11 wins), restore Prisma, verify serving
    status: pending
  - id: prisma-repeat
    content: Re-run Prisma Tier 1 tool-eval seed 42 hardmode (identical config); record score for variance estimate
    status: pending
  - id: document-noise
    content: Update runbook + routing docs with spec-token result and noise bounds; commit both repos, sync VPS
    status: pending
isProject: false
---
# Noise check + ornith-base spec tokens

## Experiment 1 — ornith-base num_speculative_tokens 6 -> 11

- DFlash drafts are verified by the base model: output identical, only acceptance/speed changes. No quality re-test needed.
- Method: systemd drop-in `ORNITH_BASE_NUM_SPECULATIVE_TOKENS=11`, swap `to-ornith-base`, run `spark-ornith-benchmark --concurrency 1 --repeat 3 --max-tokens 256 --temperature 0`.
- Baseline: 78.8 tok/s median, TTFT 130 ms (n=6, Jul 4).
- Decision: if n=11 median > n=6 median by >10%, make 11 the unit default (update spark/systemd/ornith-base-inference.service + runbook). Else revert.

## Experiment 2 — Prisma Tier 1 tool-eval repeat (noise bounds)

- All routing decisions assume 91 vs 86 is a real 5-point gap; n=1 per config so far.
- Method: identical rerun — Prisma Tier 1 (DFlash on), tool_eval_bench seed 42 hardmode, v2.0.7, from Mac.
- Interpretation:
  - Repeat 90-92: gap is real, rankings stand.
  - Repeat 87-89: gap may be ~2-3 points, note wider error bars; ornith-base speed argument strengthens.
  - Repeat <=86: rankings unreliable, need n=3 averaging before further decisions.

## Order (one swap cycle, ~1.5 h)

1. Drop-in n=11, swap to ornith-base (~8 min warm boot), throughput bench (~2 min)
2. Restore Prisma (~3 min), decide drop-in fate
3. Prisma tool-eval repeat (~30 min at Tier 1 speed)
4. Docs + commit (~10 min)

## Constraints

- One vLLM service at a time; Prisma restored at end
- Same bench versions/settings as prior runs for comparability
- Production must end on Prisma Tier 1 regardless of results
