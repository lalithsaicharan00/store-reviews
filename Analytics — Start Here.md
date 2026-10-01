# Analytics — Start Here

Written by Codex, 1 October 2026. Branch: `analytics`.

## Branch origin

This branch was created directly from **`integration`**, at commit
`4cfa11118531c43bca6d56432e8d8fc120dd20b8`, rather than from the older `main`.
It inherits that integration snapshot. Other feature branches were reviewed for the analytics plan but were not merged into this branch.

## Current implementation handoff (1 October 2026)

Implementation is preserved on `analytics`; final native verification and PR readiness are **in progress**. [PR #3](https://github.com/lalithsaicharan00/store-reviews/pull/3) targets `integration`; never merge/release. Read the [implementation checklist](<iOS/Docs/Checklists/Analytics Implementation.md>), [shared contract](<iOS/Docs/Analytics Contract.md>) and [research plan](<Research/Research Reports/Product Analytics and Reliability/Often Enough — Product Analytics and Reliability Plan.md>) before continuing. Do not restart the implementation.

Merged only consolidated `integration` through **`eff1e14ce0503ce255800fcc58f75a32415cef6b`** (analytics merge `df73109`); rechecked 19:40 UTC, unchanged. Onboarding, Help/About, iPhone Home/Lock widgets and Often Enough IDs are consolidated. Account/server/sync/cloud-backup, verified StoreKit purchase/entitlement restore and a crash SDK are absent; their reserved contract vocabulary is not adapter coverage. Do not independently merge owner branches.

Implemented optional usage consent, separate unavailable crash consent, zero pre-consent collection, random installation identity without account linkage, opt-out/erase purge, content allowlists, durable callbacks, daily UTC envelopes, bounded queues/retries/retention, consistent whole-installation sampling, estimated screen attention, onboarding/Help/local-backup/configuration and observable widget adapters. No SDK, autocapture, replay, profiles or duplicate crash collector. Latest code **`af72c61`** fixes durable widget mailbox draining after **`8f6bbaf`** (open-period sampling policy) and **`b20f7ac`** (terminal reliability deduplication).

Completed macOS run [36911212496](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36911212496), `7aa5c02`: 88 native checks, Core storage/migrations, Debug app/widget build, all 14 targeted UI tests, provider smoke and five same-build consent-off/on timing windows. Exact measurements are in [Analytics Performance Evidence.json](<iOS/Docs/Analytics Performance Evidence.json>). Global speed targets remain unmet in both modes; one ordered comparison does not prove causal overhead or physical-device acceptance.

Full Release-policy run [36911869018](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36911869018), `7b05a66`, has passed Foundation/Core and both Debug and Release **simulator** app/widget builds; UI/performance are running. Final utility-only contract job on `af72c61` will verify 101 native checks plus Core and Debug/Release builds, reusing unchanged-view UI/performance evidence. Pending `b20f7ac` and `8f6bbaf` focused jobs were superseded, not separate coding chats.

Verified sole EU Default project **290602**. Owner confirms free/no billing configured; official Product Analytics allowance is 1M/month, planning ceiling 700k. Billing/spend cap and analytics retention are not API-verified; disabled replay retention is not analytics retention. No paid service enabled. Final provider read: **12 development rows/12 unique record IDs/6 synthetic installations**, zero production rows and zero person profiles. Actual retried UUIDs, propertyless processing and content-free/profile/geoip-suppressed property bags were inspected. Workspace ingestion is CONNECT-blocked; authorized macOS smoke succeeds.

Both dashboards are complete: [Adoption & Attention](https://eu.posthog.com/project/290602/dashboard/989702), [Flows, Reliability & Coverage](https://eu.posthog.com/project/290602/dashboard/989704). All **14 saved queries** and whole-dashboard refreshes succeeded. Definitions, IDs and provider evidence are in [Analytics Dashboards.json](<iOS/Docs/Analytics Dashboards.json>). Production is empty; consent, sampling, post-consent provenance, incomplete widget/platform coverage and noncanonical catalog status are explicit. Stored deduplicated rows are not billing usage.

`AnalyticsProductionEnabled=false` remains deliberate. Share Usage can collect locally; only an eligible production channel plus consent and a reviewed enabled gate can send. Debug/TestFlight/CI/performance app fixtures cannot send; the separate explicitly authorized provider smoke contains only synthetic development records. Rollout dependencies: speed/physical-device acceptance, unavailable billing/retention verification and absent feature/crash-provider owners. Reviewable implementation does not mean a live production rollout.

## Requested scheduled continuation attempts

Main prompt receipt: **2026-10-01 16:04:41 UTC** / 21:34:41 IST. First requested target: **2026-10-01 18:49:41 UTC** / October 2 00:19:41 IST. Scheduling tools expose cloud automations without a verified same-Codex-chat/repository wake target; harmless automation read succeeded, but no compatible wake was available. **No automation was created.** Do not create a generic reminder or duplicate coding run. If a genuine first scheduled message arrives, check completion before creating a second/final one-time continuation exactly 5h20m after its receipt; no third.

Required continuation instruction: “Continue and complete the analytics implementation task on the existing `analytics` branch if it is not completed. Read `Analytics — Start Here.md` and the analytics implementation checklist to recover current progress. Preserve completed work, verify actual remaining work, and continue implementation, testing and PR preparation under the original task’s constraints. If completed, do not restart it.”

Remaining independent work: inspect completed full Release-policy and latest focused native jobs, resolve actual failures, update final evidence/report/checklist/PR and mark PR ready when checks pass. Dashboards and synthetic provider verification are complete. Keep production false, document exact unavailable dependencies and never merge/release. Historical recovery entries below preserve earlier diagnostics; the current section above takes precedence.


### Consolidated feature recovery — 17:59 UTC

Merged actual integration onboarding/widgets/identity, resolved four conflicts preserving analytics, and added: suggestion creation provenance; first-run/replay steps and terminal outcomes; observed post-consent activation provenance; widget durable/retry guards; content-free deep-link and extension paging counters; consent-mirrored, excluded-from-backup bounded paging mailbox; daily WidgetCenter kind/family inventory with placement unknown; privacy/default-source state and widget publication reliability. No widget item IDs, names, selected configuration, page keys or values enter analytics. Mailbox counts can be lost on termination and old-day counts are dropped; coverage stays incomplete. Native tests extended; telemetry timestamp formatting now uses a reusable Sendable format style to pass strengthened consolidated speed rules. Next: push tagged native build/tests/performance, inspect failures and actual provider rows, refresh dashboards/report and PR. Production remains gated false until verification.


### Validation recovery — 00:30 IST Oct 2 / 19:00 UTC Oct 1

Final tagged code 6634a28 is pushed. Final run 36909868629 is queued; intermediate 8e93786 run 36909127104 was automatically superseded, not a second coding chat. Native run 36907293697 passed app/widget build and targeted UI, but its consent-off baseline timed out/failed; consent-on measurement still running. Do not infer performance acceptance from UI success. Read completed job 110520917140 logs and fix the actual measurement failure before final validation. Both EU dashboards (14 saved queries) refreshed successfully; source JSON preserves IDs, definitions, caveats and provider evidence. PR #3 description updated, still draft. No automation exists; requested first target passed without a supported scheduled message, so no second/third schedule should be manufactured.


### Current recovery checkpoint — 00:55 IST Oct 2 / 19:25 UTC Oct 1

No new coding chat/automation exists. First requested time has passed without a compatible wake; do not fabricate a second schedule. Native baseline issue was macOS Bash 3.2 empty-array expansion, not an app stall; corrected in 7aa5c02. Both current off/on modes actually launch the same build. The 6634a28 run failed optional-ledger exclusivity before app tests; corrected with previous-loss snapshot, and current 7aa5c02 native/UI pass confirms it. Final code 7b05a66 adds explicit Release channel, TestFlight sandbox→beta exclusion and a Release build step, keeping production false. All independent implementation is preserved; remaining work is final Release/native/performance evidence, handoff/report/PR readiness. Exact launch dependencies are in the checklist; unavailable account/sync/StoreKit/crash features are not implemented or fabricated. Latest provider reads show ten development rows, no production rows and zero person profiles; dashboards’ fourteen saved queries execute successfully.


### Sampling-policy recovery — 01:15 IST Oct 2

Final review found current-config sampling could disagree with the frozen open-period metadata after an app update. Inclusion and flow sampling metadata now retain the open UTC period policy, switching together at the next period; four deterministic upgrade checks cover reductions, expansions and next-day adoption. Final focused contract/Core/Debug/Release job supersedes the pending reliability-only job. Full Release-policy run36911869018 has passed Foundation/Core and both builds; UI/performance remain running. No views or store callbacks changed. Production remains false.


### Widget drain transaction — 01:16 IST Oct 2

Final mailbox audit found a failed atomic clear could return a count that remained on disk. Draining now returns counts only after a successful durable clear. Two native checks inject a disk-full clear failure and verify the retry consumes pending counts once. Final focused Foundation/Core/Debug/Release validation covers this utility-only fix; existing full UI/performance run remains valid for unchanged views/store. Final provider read: 12 development records/12 unique IDs/6 synthetic installations, production absent; person-list returned empty. No paid products or automation created.
