# Analytics — Start Here

Written by Codex, 1 October 2026. Branch: `analytics`.

## Branch origin

This branch was created directly from **`integration`**, at commit
`4cfa11118531c43bca6d56432e8d8fc120dd20b8`, rather than from the older `main`.
It inherits that integration snapshot. Other feature branches were reviewed for the analytics plan but were not merged into this branch.

## Current implementation handoff (1 October 2026)

Task is **in progress**. Reviewable [draft PR #3](https://github.com/lalithsaicharan00/store-reviews/pull/3) targets `integration`; never merge/release. Preserve the implementation; do not restart from the original research snapshot. Read [Analytics Implementation checklist](<iOS/Docs/Checklists/Analytics Implementation.md>), [shared contract](<iOS/Docs/Analytics Contract.md>) and the [research plan](<Research/Research Reports/Product Analytics and Reliability/Often Enough — Product Analytics and Reliability Plan.md>).

Consolidated `integration` was merged through `173f4f51eab20359a0bd01396b0ffe00d8cba590`. No unfinished feature-owner branch was merged. It has tracking, local backups, Progress, reminders and disabled Plus UI, but no onboarding/account/sync/purchase/widget implementations. Shared semantics reserve these adapters without claiming their coverage.

Consent-gated content-free iPhone analytics, durable callbacks, bounded independent queues, daily summaries, screen timing, local backup outcomes and native checks are implemented. Commits pushed through `222b292`; metadata/release-upgrade guards `0265a1c`, consent-disabled fast paths `64cb829`, synthetic consent-on performance fixture `222b292`. macOS run [36893196823](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36893196823) passed native analytics, speed rules and core storage/migrations; app build failed on a Privacy Section initializer; corrected for the next run, UI/performance were skipped. Earlier contract runs exposed a Swift exclusivity error that `1910242` fixes; those failures are not acceptance evidence.

Successful PostHog reads established sole EU Default project **290602**, currently empty (30-day SQL query returned no events). Owner confirms free plan with no billing configured; current published analytics allowance is 1M/month. `billing:read` remains unavailable, so actual billing/spend cap is not verified. Confirmed project updates disabled unwanted automatic capture. Two dashboards were created: [Adoption & Attention](https://eu.posthog.com/project/290602/dashboard/989702), [Flows, Reliability & Coverage](https://eu.posthog.com/project/290602/dashboard/989704). Both dashboards now contain eleven saved insights with explanatory notes and layouts; whole-dashboard execution succeeded with empty/null results and zero ingestion. No paid product was enabled.

The public capture-only project key is configured; production sending remains gated off until real provider delivery/privacy verification. Direct EU ingestion is blocked by this environment's network policy (CONNECT 403), and the connector exposes no capture tool. Payload and deterministic transport tests are independent evidence, not real provider acceptance. No crash SDK is active; separate crash consent stays unavailable.

## Requested scheduled continuation attempts

Main prompt receipt: **2026-10-01 16:04:41 UTC** / 21:34:41 IST. First requested target: **2026-10-01 18:49:41 UTC** / October 2 00:19:41 IST. Scheduling tools expose cloud automations without a verified same-Codex-chat/repository wake target; harmless automation read succeeded, but no compatible wake was available. **No automation was created.** Do not create a generic reminder or duplicate coding run. If a genuine first scheduled message arrives, check completion before creating a second/final one-time continuation exactly 5h20m after its receipt; no third.

Required continuation instruction: “Continue and complete the analytics implementation task on the existing `analytics` branch if it is not completed. Read `Analytics — Start Here.md` and the analytics implementation checklist to recover current progress. Preserve completed work, verify actual remaining work, and continue implementation, testing and PR preparation under the original task’s constraints. If completed, do not restart it.”

Remaining independent work: complete targeted app builds/tests, resolve any failures, update final report/checklist/test evidence and draft PR #3. Latest validation is queued behind macOS run 36896347493. Integration was rechecked at PR creation and remains `173f4f5`. Never merge/release. External gate: real provider ingestion/dedup/privacy validation on an authorized network; missing feature adapters wait for owners' consolidation.
