# Analytics Implementation

Written by Codex, 1 October 2026. Continue on `analytics`; PR base is `integration` unless the consolidated base advances.

## Constraints and progress

- [x] Record prompt receipt: 2026-10-01 16:04:41 UTC (21:34:41 Asia/Calcutta).
- [x] Inspect scheduler: only cloud automations exposed; no supported same-Codex-chat/workspace wake target. No reminder or duplicate coding run created. First requested target would be 2026-10-01 18:49:41 UTC (October 2 00:19:41 IST). Second must only be scheduled if a genuine first message fires and task remains unfinished, at receipt + 5h20m; no third.
- [x] Read handoff, research contract and repository speed/design rules.
- [x] Fetch existing analytics and integration; merge only consolidated integration through `eff1e14ce0503ce255800fcc58f75a32415cef6b` (df73109).
- [x] Successful PostHog projects-get/project-get/read-data-schema/generate-app-url calls: sole Default project 290602, EU URL; no recently seen events. Billing tools unavailable without billing:read. Owner confirms free/no billing, published 1M/month; billing API remains unverified. Synthetic EU delivery, propertyless processing and retry deduplication are verified. Production gate remains off pending performance acceptance.
- [x] Recheck integration at completion: `eff1e14` remains latest; onboarding/Help/widgets/identity are consolidated and merged. Account/sync/purchases still await owners; no independent owner-branch merge.
- [x] Content-free versioned contract, durable creation/tracking/correction/adoption hooks, cut_down classification.
- [x] Optional usage consent, separate crash preference, zero pre-consent collection, purge opt-out and erase; exclude identity from exports/backups/accounts.
- [x] Bounded independent queues, daily envelopes, stable sampling, retry record identity, failure/recovery suppression.
- [x] Screen visits and monotonic 30s idle-capped attention with foreground/cover/lock handling; no observable clock.
- [x] Existing local backup/restore outcomes and configuration states, defaults vs saved user choices. Onboarding, Help and observable iPhone widget adapters added after consolidation. Account/purchase/entitlement restore adapters remain unavailable (no synthetic successes).
- [ ] Complete latest-head native payload/consent/offline/retry/upgrade tests, targeted app callback/UI tests and consent-on native performance evidence. Expanded prior native delivery/persistence tests passed; latest run pending.
- [x] Useful provider dashboards with consent/platform/sampling/coverage labels; actual provider delivery evidence when permitted.
- [ ] Refresh report assumptions, privacy manifest and handoff; commit/push analytics and open PR; never merge/release.

## External dependencies

Owner confirms free/no billing and sole Default production project; published allowance 1M analytics events/month, planning ceiling 700k. Billing scope unavailable; no actual spend-cap verification or paid services. Provider settings update confirmed autocapture/replay/console/performance/web-vitals/surveys/heatmaps off, IP anonymization on. Direct `eu.i.posthog.com` ingestion is network-blocked (CONNECT 403); connector has no capture tool. Production sending remains false pending native UI/performance acceptance; real synthetic provider delivery/privacy/retry deduplication is verified. No crash SDK initialization exists, so separate crash consent is disabled; no duplicate collector added.

Current integration includes onboarding, Help/About and iPhone Home/Lock widgets (eff1e14). Their adapters are implemented and pending final native acceptance. Account/sync/verified StoreKit purchases remain absent; contract tests reject fabricated outcomes, and capability flags remain false. No unfinished owner branch was merged.

## Test and PR evidence

- Pushed `6a6d19f`, `5631cad`, `1910242`. Early native failures diagnosed as Swift overlapping optional-ledger access; helper snapshots sampling before mutation.
- [36893196823](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36893196823): native contract/payload checks, speed rules and core storage/migrations passed; app build failed on Privacy Section initializer; corrected for next run. UI/performance skipped.
- New deterministic transport retry/ack/invalid-batch/opt-out tests, per-day terminal-event cap and privacy manifest are staged for the next targeted run.
- Dashboards [989702](https://eu.posthog.com/project/290602/dashboard/989702) and [989704](https://eu.posthog.com/project/290602/dashboard/989704) created. Eleven derived queries validated against empty actual project (screen aggregate alias corrected and revalidated). Definitions in `iOS/Docs/Analytics Dashboards.json`. Both dashboards filled and whole-dashboard execution succeeded with no query errors, empty/null results and zero ingestion. Metrics catalog access unavailable; definitions marked noncanonical.
- [Draft PR #3](https://github.com/lalithsaicharan00/store-reviews/pull/3) opened against integration and attached to this chat. No merge/release.
- Pushed through `3ab56ab` (latest engine/metadata implementation `0265a1c`). [36896347493](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36896347493) passed expanded native offline/retry/persistence checks and core storage; app build running. Latest-head targeted validation queued (supersedes intermediate pending commit). Latest implementation is `222b292`: performance runs explicitly simulate consent in a separate fixture directory while DEBUG blocks delivery, so queue/file/touch overhead is measured. `0265a1c` preserves original observation metadata across upgrades; `64cb829` skips classification/configuration work without consent. Intermediate pending runs were automatically replaced by the latest queued run; no parallel coding run was created.

- `8d63880` adds an explicit macOS EU provider integration smoke: two content-free synthetic development records, twice with stable UUIDs, public capture key only. Excluded from production queries. Provider acceptance and actual row/profile/geoip/dedup verification are pending; local environment remains CONNECT-blocked. Failure is recorded without blocking native app tests.

## Latest validation recovery (17:30 UTC)

- Run [36896347493](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36896347493), commit `7268e49`: 69 native consent/payload/offline/retry/persistence checks passed; core storage/migrations and app build passed. Eight of nine UI tests passed, including storage failure rollback, relaunch/quick taps, backup integrity/native sharing and optional/separate consent. The durable content-free scenario failed; its expected note count ignored the quit-slip's first durable note save. Corrected in `783950a` to assert both saves; payload sentinel/identifier/value leakage assertions remain.
- Its native perf scenarios completed, but targets were missed: Today scroll 40.2ms/s / 407ms, taps 70.7ms/s / 132ms, form typing 8.2ms/s / 58ms. This run excluded telemetry consent; do not claim analytics performance acceptance from it. Earlier integration baseline (run 36820868673) also exceeded targets (scroll 33.3ms/s / 302ms, taps 87.2ms/s / 384ms).
- Current run [36899451178](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36899451178), `783950a`, is running the corrected note test, observation-upgrade guards, consent-enabled fixture and explicit provider smoke. Provider smoke results must be read from the CI summary before querying the printed synthetic installation/record IDs.
- Latest code `7332d3f` adds same-build consent-off baseline alongside consent-on performance to isolate overhead, and suspends attention under the native file importer. Its targeted run is queued behind the current run. Preserve this work; resolve actual new failures, inspect provider results, compare native performance and update PR #3. Production sending is still false.

## Provider verification — 17:35 UTC

Actual EU PostHog reads now show two synthetic development records from macOS run 36899451178. Creation UUID `3DC035EE-7B06-44D9-80A5-EFDF399E796A`; daily-feature UUID `1D2A60CE-CE0B-4416-BAC6-C8A01A9C2261`; synthetic installation `FBD69B0C-82BB-4A6F-84D4-A26DF42F0D80`. Sent twice with identical IDs; one physical row per UUID and matching analytics_record_id observed. Both person modes are propertyless; actual complete properties retain profile=false/geoip_disable=true and no IP, geoip, SDK/device-detail, account or user-content fields. These are test records, not users. Production cohort remains empty. Dashboard notes and quota interpretation updated: stored rows after deduplication can differ from ingress/billing. No paid service enabled. Production gate remains false until final native UI/performance acceptance.


## Consolidated update — 17:59 UTC

`eff1e14` is merged as `df73109`, including real onboarding/help/widgets and Often Enough IDs. Implemented adapters now cover their observable callbacks; accounts/sync/purchase remain absent. New native tests cover consent-less paging, opt-out/re-opt-in/stale callbacks, at-most-once draining, old-day dropping, observed activation provenance and durable widget retry deduplication. Pending: latest merged-head native build/tests, widget/AppIntent compilation and same-build consent-off/on performance. Earlier 783950a CI is still running; 7332d3f pending. Preserve provider evidence above; do not mistake prior-head results for merged-head acceptance.

### Native success and final coverage refinements — 18:09 UTC

Run 36899451178 completed successfully: 71 Foundation checks, core tests, app build and all 9 targeted UI tests passed. Consent-on perf still missed targets (scroll 39.1ms/s, taps 251.5ms/s, typing 79.4ms/s); this is not acceptance or a causal overhead comparison. New merged run 36903471716 passed extended native contract/provider steps and is building. Further refinements pending: optional welcome → Privacy navigation (no required opt-in), welcome finishes after durable creation flush, once-per-flow observed-step guard, changed widget inventories persistently suppressed/limited to once/day, and coverage-v2 explicit zeroes only for known working feature adapters. Latest full validation will supersede this intermediate head.

### Compile correction — 18:30 UTC / 00:00 IST (Oct 2)

Run 36903471716 passed 82 native checks and provider smoke but build failed: suggestion provenance referenced the initializer-only `idea` parameter. Latest f0d1b7e run 36904494091 has the same compile failure; neither is UI/performance acceptance. Fix stores only `fromSuggestion: Bool` in both form initializers, never the suggestion name in telemetry. Re-run targeted merged native validation. Three additional provider insights were created (6270561/p9LwxJez onboarding, 6270562/uXP18Y5W seven-day observed first-run outcomes, 6270563/NZ2ShfOs inventory). Final coverage-v2 adoption/reliability SQL updates were temporarily not executed because approval review hit a usage limit; do not claim those updates succeeded.

### Review fixes — 00:12 IST (Oct 2) / 18:42 UTC

Merged app and extension build and targeted UI suites passed in 36907293697; same-build performance runs are executing. Final code review found open daily-summary metadata could be relabelled after an upgrade; collection-period metadata is now frozen separately from queued records. Engine-level consent revocation/erase now purges the extension mirror through an injected callback, including callers outside Privacy. Loss counts saturate at 100,000, and welcome step events observe actual page appearances. Native tests cover period metadata and mirrored erase. Pending final validation of these refinements. Coverage-v2 provider configuration/reliability SQL passed; large UNION queries were too busy, replaced by validated single-scan array/tuple expansions. All four saved insights were updated successfully; three new tiles arranged. Whole-dashboard refresh and final notes still pending.

### Final type/privacy coverage — 00:18 IST (Oct 2)

Consolidated forms support timed upper limits as well as amount upper limits: both now classify as cut_down, with durable native checks for a timed suggestion, retries and restore exclusion. Relay consent creation fails closed if backup exclusion cannot be set. Final perf selection adds widget-log and widget-guide to Today scroll/tap and form typing, each with same-build consent-off/on comparison. Current consolidated base is still eff1e14. Both dashboard notes reflect actual feature coverage; adoption dashboard all six saved queries refreshed successfully after single-scan optimization. Flow dashboard final refresh pending.

### Exact baseline failure and native correction — 00:35 IST Oct 2

Completed 36907293697: 86 native checks, core/build and all 14 UI checks passed. Baseline never launched: macOS Bash 3.2 + `set -u` rejected an empty optional array (three 180s waits); fixed with explicit launch arguments, missing-PID fast failure and retained launch logs. Consent-on measured scroll 15.9ms/s /127ms, taps14.4/63ms, typing2.8/36ms; no causal comparison without a working baseline. Final 6634a28 run36909868629 failed native compile because the bounded-loss assignment read `ledger` during optional mutation; fixed by snapshotting previous loss before modifying ledger. Re-run latest final head; do not reuse failed runs as acceptance. Performance lessons updated with evidence and wasted runtime.

### Release-path verification — 00:40 IST Oct 2

Added explicit release-channel configuration and fail-closed policy: Debug is development; TestFlight sandbox receipts force beta; missing/invalid configuration is development. Only controlled channel/Boolean receipt provenance is used, never receipt content, account data or paths in telemetry. Production remains false. Native policy tests cover these paths, and tagged analytics validation now compiles Release as well as the existing Debug app/widget builds before running UI/performance. Latest 7aa5c02 run36911212496 is testing prior fixes; latest Release-policy run supersedes it when queued.

## Remaining launch dependencies (exact boundaries)

- Production gate stays false until native performance acceptance. Current implementation and PR can be reviewed with this explicit gate; shipping/release remains outside the request. Latest tagged validation 7b05a66 compiles both Debug and Release, runs fixed-payload/consent/native UI checks and five same-build off/on performance scenarios.
- Account, server/sync, cloud backup and verified StoreKit purchase/entitlement-restore code must first land in integration. Existing typed semantics/rejection tests cannot substitute for real durable/provider-verified outcomes.
- Architecture selects Sentry, but consolidated source has no SDK initialization, DSN, project or symbol-upload configuration. Crash coverage is zero; separate crash sharing is disabled. Its owner must supply project/DSN, independent consent/scrubbing and native symbolication/coverage evidence. No second collector was added.
- Billing/spend-limit and analytics retention configuration are not exposed by current project access. Owner confirms free/no billing; official free allowance is 1M/month with 700k planning ceiling. Project read exposes only disabled replay retention (30d), which is not analytics retention. No billing/personal API key or paid product was configured.
- Catalog permissions are unavailable; the fourteen executed dashboard definitions are labelled noncanonical. Real production population, physical-device performance and future-platform coverage are unverified; no metric invents them.

Latest provider read: 10 stored development rows/10 unique IDs/5 synthetic installations, production absent, zero person profiles. These are deduplicated stored rows, not authoritative ingress/billing. Both dashboards’ 14 saved queries executed successfully.

### Reliability retry semantics — 01:05 IST Oct 2

Terminal reliability outcomes now guard the operation ticket/subsystem, so duplicate callbacks do not inflate attempts or report conflicting success. A genuinely new retry ticket may recover; native tests assert all three cases. The `[ios-contract-only]` final job runs the full Foundation contract plus Core, Debug and Release builds without repeating unchanged-view UI, provider smoke or performance. Current full 7b05a66 job still verifies the UI/performance/release policy; prior 7aa5c02 run36911212496 fully passed 88 Foundation checks and all14 UI tests plus five working off/on windows. No new HabitStore/view changes accompany the reliability guard. CI summary now includes Release and baseline outcomes explicitly.
