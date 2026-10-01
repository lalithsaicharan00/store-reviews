# Analytics — Start Here

Written by Codex, 1 October 2026. Branch: `analytics`.

## Branch origin

This branch was created directly from **`integration`**, at commit
`4cfa11118531c43bca6d56432e8d8fc120dd20b8`, rather than from the older `main`.
It inherits that integration snapshot. Other feature branches were reviewed for the analytics plan but were not merged into this branch.

## Current implementation handoff (1 October 2026)

Task is **in progress**. Reviewable [draft PR #3](https://github.com/lalithsaicharan00/store-reviews/pull/3) targets `integration`; never merge/release. Preserve the implementation; do not restart from the original research snapshot. Read [Analytics Implementation checklist](<iOS/Docs/Checklists/Analytics Implementation.md>), [shared contract](<iOS/Docs/Analytics Contract.md>) and the [research plan](<Research/Research Reports/Product Analytics and Reliability/Often Enough — Product Analytics and Reliability Plan.md>).

Consolidated `integration` is now merged through **`eff1e14ce0503ce255800fcc58f75a32415cef6b`** (analytics merge `df73109`). Real onboarding, Help/About, iPhone Home/Lock widgets and Often Enough bundle IDs landed. Their consent-gated adapters are now added and require fresh native verification. Accounts, sync and verified StoreKit purchases have not landed; do not merge unfinished owner branches or invent their coverage.

Consent-gated content-free iPhone analytics, durable callbacks, bounded independent queues, daily summaries, screen timing, local backup outcomes and native checks are implemented. Commits pushed through `7332d3f`; see checklist’s latest validation recovery for current runs and fixes. macOS run [36893196823](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36893196823) passed native analytics, speed rules and core storage/migrations; app build failed on a Privacy Section initializer; corrected for the next run, UI/performance were skipped. Earlier contract runs exposed a Swift exclusivity error that `1910242` fixes; those failures are not acceptance evidence.

Successful PostHog reads established sole EU Default project **290602**, currently empty (30-day SQL query returned no events). Owner confirms free plan with no billing configured; current published analytics allowance is 1M/month. `billing:read` remains unavailable, so actual billing/spend cap is not verified. Confirmed project updates disabled unwanted automatic capture. Two dashboards were created: [Adoption & Attention](https://eu.posthog.com/project/290602/dashboard/989702), [Flows, Reliability & Coverage](https://eu.posthog.com/project/290602/dashboard/989704). Both dashboards now contain eleven saved insights with explanatory notes and layouts; whole-dashboard execution succeeded with empty/null results and zero ingestion. No paid product was enabled.

The public capture-only project key is configured; production sending remains gated off pending final native UI/performance acceptance. This workspace cannot reach EU ingestion (CONNECT 403), but the authorized macOS integration test succeeded. Actual PostHog rows verified two synthetic development records sent twice retained one row per UUID, `propertyless` person mode, profiles/geoip disabled and allowlisted fields only. Production records remain absent. No crash SDK is active; separate crash consent stays unavailable.

## Requested scheduled continuation attempts

Main prompt receipt: **2026-10-01 16:04:41 UTC** / 21:34:41 IST. First requested target: **2026-10-01 18:49:41 UTC** / October 2 00:19:41 IST. Scheduling tools expose cloud automations without a verified same-Codex-chat/repository wake target; harmless automation read succeeded, but no compatible wake was available. **No automation was created.** Do not create a generic reminder or duplicate coding run. If a genuine first scheduled message arrives, check completion before creating a second/final one-time continuation exactly 5h20m after its receipt; no third.

Required continuation instruction: “Continue and complete the analytics implementation task on the existing `analytics` branch if it is not completed. Read `Analytics — Start Here.md` and the analytics implementation checklist to recover current progress. Preserve completed work, verify actual remaining work, and continue implementation, testing and PR preparation under the original task’s constraints. If completed, do not restart it.”

Remaining independent work: complete targeted app builds/tests, resolve any failures, update final report/checklist/test evidence and draft PR #3. An explicit macOS provider smoke was added in `8d63880`: two synthetic development records, sent twice with stable IDs, excluded from production metrics; only the public capture key is used. Read the provider smoke summary and inspect actual provider rows before claiming success. Current macOS run is 36899451178 (`783950a`); latest `7332d3f` validation is queued behind it. Run 36896347493 passed build/core/69 native checks and 8/9 UI checks, but revealed the compound note-count test expectation and missed performance targets; do not call it acceptance. Integration was rechecked at PR creation and remains `173f4f5`. Never merge/release. Provider delivery/profile/geoip/dedup gate is now verified for synthetic development records; read checked-in evidence. Remaining gates: native UI/performance and final release configuration. Missing feature adapters wait for owners’ consolidation.


### Consolidated feature recovery — 17:59 UTC

Merged actual integration onboarding/widgets/identity, resolved four conflicts preserving analytics, and added: suggestion creation provenance; first-run/replay steps and terminal outcomes; observed post-consent activation provenance; widget durable/retry guards; content-free deep-link and extension paging counters; consent-mirrored, excluded-from-backup bounded paging mailbox; daily WidgetCenter kind/family inventory with placement unknown; privacy/default-source state and widget publication reliability. No widget item IDs, names, selected configuration, page keys or values enter analytics. Mailbox counts can be lost on termination and old-day counts are dropped; coverage stays incomplete. Native tests extended; telemetry timestamp formatting now uses a reusable Sendable format style to pass strengthened consolidated speed rules. Next: push tagged native build/tests/performance, inspect failures and actual provider rows, refresh dashboards/report and PR. Production remains gated false until verification.
