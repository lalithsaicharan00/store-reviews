# Analytics — Start Here

Written by Codex, 1 October 2026. Branch: `analytics`.

## Branch origin

This branch was created directly from **`integration`**, at commit
`4cfa11118531c43bca6d56432e8d8fc120dd20b8`, rather than from the older `main`.
It inherits that integration snapshot. Other feature branches were reviewed for the analytics plan but were not merged into this branch.

## Current implementation handoff (1 October 2026)

Task is **in progress**. Reviewable [draft PR #3](https://github.com/lalithsaicharan00/store-reviews/pull/3) targets `integration`; never merge/release. Preserve the implementation; do not restart from the original research snapshot. Read [Analytics Implementation checklist](<iOS/Docs/Checklists/Analytics Implementation.md>), [shared contract](<iOS/Docs/Analytics Contract.md>) and the [research plan](<Research/Research Reports/Product Analytics and Reliability/Often Enough — Product Analytics and Reliability Plan.md>).

Consolidated `integration` is now merged through **`eff1e14ce0503ce255800fcc58f75a32415cef6b`** (analytics merge `df73109`). Real onboarding, Help/About, iPhone Home/Lock widgets and Often Enough bundle IDs landed. Their consent-gated adapters are now added and require fresh native verification. Accounts, sync and verified StoreKit purchases have not landed; do not merge unfinished owner branches or invent their coverage.

Consent-gated content-free iPhone analytics, durable callbacks, bounded independent queues, daily summaries, screen timing, onboarding, Help and widget adapters are implemented. Latest implementation is **`7b05a66`** (Release/beta delivery policy), following `7aa5c02` (native exclusivity and macOS Bash baseline fixes). Final macOS run is [36911869018](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36911869018), queued behind [36911212496](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36911212496). The latter passed native/core/Debug app+widget build, all 14 targeted UI tests and the corrected consent-off baseline; five consent-on profiling scenarios remain running. Final validation additionally compiles Release and tests sandbox-channel exclusion. Earlier 783950a run passed 71 native checks, core/build and all nine UI tests; its consent-on perf missed targets. Merged heads 5e3f6f2/f0d1b7e passed expanded native checks/provider smoke but failed on the initializer-only `idea` reference; neither validates app/UI/performance. The latest run tests actual onboarding/widgets and compares same-build consent off/on. Preserve completed work and diagnose actual failures.

Successful PostHog reads established sole EU Default project **290602**. Production cohort is empty; synthetic development records are verified separately. Owner confirms free plan/no billing configured; published allowance is 1M/month, planning ceiling 700k. `billing:read` is unavailable, so actual billing/spend cap is not API-verified. Confirmed settings disabled automatic capture. Two dashboards exist: [Adoption & Attention](https://eu.posthog.com/project/290602/dashboard/989702), [Flows, Reliability & Coverage](https://eu.posthog.com/project/290602/dashboard/989704). Fourteen saved queries, coverage notes and layouts are updated and whole-dashboard execution succeeded. Large repeated-scan UNION queries were too busy; single-scan tuple expansions now execute successfully. The monthly tile observes eight stored synthetic records; that is not authoritative ingress/billable usage. No paid service was enabled.

The public capture-only project key is configured; production sending remains gated off pending final native UI/performance acceptance. This workspace cannot reach EU ingestion (CONNECT 403), but the authorized macOS integration test succeeded. Actual PostHog rows verified two synthetic development records sent twice retained one row per UUID, `propertyless` person mode, profiles/geoip disabled and allowlisted fields only. Production records remain absent. No crash SDK is active; separate crash consent stays unavailable.

## Requested scheduled continuation attempts

Main prompt receipt: **2026-10-01 16:04:41 UTC** / 21:34:41 IST. First requested target: **2026-10-01 18:49:41 UTC** / October 2 00:19:41 IST. Scheduling tools expose cloud automations without a verified same-Codex-chat/repository wake target; harmless automation read succeeded, but no compatible wake was available. **No automation was created.** Do not create a generic reminder or duplicate coding run. If a genuine first scheduled message arrives, check completion before creating a second/final one-time continuation exactly 5h20m after its receipt; no third.

Required continuation instruction: “Continue and complete the analytics implementation task on the existing `analytics` branch if it is not completed. Read `Analytics — Start Here.md` and the analytics implementation checklist to recover current progress. Preserve completed work, verify actual remaining work, and continue implementation, testing and PR preparation under the original task’s constraints. If completed, do not restart it.”

Remaining independent work: inspect final native build/UI/performance, resolve real failures, finish provider coverage-v2 updates/validation, update report/checklist/PR #3 and determine release configuration gate. Production currently remains false. Accounts, sync and verified StoreKit purchase/entitlement restore do not exist in consolidated integration; their typed contract and rejection tests do not claim working adapters. No active crash collector exists; crash diagnostics and symbols wait for that owner. Scheduling remains unsupported as documented above. Never merge/release.


### Consolidated feature recovery — 17:59 UTC

Merged actual integration onboarding/widgets/identity, resolved four conflicts preserving analytics, and added: suggestion creation provenance; first-run/replay steps and terminal outcomes; observed post-consent activation provenance; widget durable/retry guards; content-free deep-link and extension paging counters; consent-mirrored, excluded-from-backup bounded paging mailbox; daily WidgetCenter kind/family inventory with placement unknown; privacy/default-source state and widget publication reliability. No widget item IDs, names, selected configuration, page keys or values enter analytics. Mailbox counts can be lost on termination and old-day counts are dropped; coverage stays incomplete. Native tests extended; telemetry timestamp formatting now uses a reusable Sendable format style to pass strengthened consolidated speed rules. Next: push tagged native build/tests/performance, inspect failures and actual provider rows, refresh dashboards/report and PR. Production remains gated false until verification.


### Validation recovery — 00:30 IST Oct 2 / 19:00 UTC Oct 1

Final tagged code 6634a28 is pushed. Final run 36909868629 is queued; intermediate 8e93786 run 36909127104 was automatically superseded, not a second coding chat. Native run 36907293697 passed app/widget build and targeted UI, but its consent-off baseline timed out/failed; consent-on measurement still running. Do not infer performance acceptance from UI success. Read completed job 110520917140 logs and fix the actual measurement failure before final validation. Both EU dashboards (14 saved queries) refreshed successfully; source JSON preserves IDs, definitions, caveats and provider evidence. PR #3 description updated, still draft. No automation exists; requested first target passed without a supported scheduled message, so no second/third schedule should be manufactured.


### Current recovery checkpoint — 00:55 IST Oct 2 / 19:25 UTC Oct 1

No new coding chat/automation exists. First requested time has passed without a compatible wake; do not fabricate a second schedule. Native baseline issue was macOS Bash 3.2 empty-array expansion, not an app stall; corrected in 7aa5c02. Both current off/on modes actually launch the same build. The 6634a28 run failed optional-ledger exclusivity before app tests; corrected with previous-loss snapshot, and current 7aa5c02 native/UI pass confirms it. Final code 7b05a66 adds explicit Release channel, TestFlight sandbox→beta exclusion and a Release build step, keeping production false. All independent implementation is preserved; remaining work is final Release/native/performance evidence, handoff/report/PR readiness. Exact launch dependencies are in the checklist; unavailable account/sync/StoreKit/crash features are not implemented or fabricated. Latest provider reads show ten development rows, no production rows and zero person profiles; dashboards’ fourteen saved queries execute successfully.
