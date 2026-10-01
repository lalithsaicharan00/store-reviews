# Analytics Implementation

Written by Codex, 1 October 2026. Continue on `analytics`; PR base is `integration` unless the consolidated base advances.

## Constraints and progress

- [x] Record prompt receipt: 2026-10-01 16:04:41 UTC (21:34:41 Asia/Calcutta).
- [x] Inspect scheduler: only cloud automations exposed; no supported same-Codex-chat/workspace wake target. No reminder or duplicate coding run created. First requested target would be 2026-10-01 18:49:41 UTC (October 2 00:19:41 IST). Second must only be scheduled if a genuine first message fires and task remains unfinished, at receipt + 5h20m; no third.
- [x] Read handoff, research contract and repository speed/design rules.
- [x] Fetch existing analytics and integration; merge only consolidated integration through `173f4f51eab20359a0bd01396b0ffe00d8cba590`.
- [x] Successful PostHog projects-get/project-get/read-data-schema/generate-app-url calls: sole Default project 290602, EU URL; no recently seen events. Billing tools unavailable without billing:read. Owner confirms free/no billing, published 1M/month; billing API remains unverified. Production delivery gate remains off pending real ingestion/privacy validation.
- [x] Recheck integration at PR creation: still `173f4f5`; feature-owner branches unmerged. Recheck once more at completion. Onboarding/widgets/account/purchases require owners’ consolidation, not independent merges.
- [x] Content-free versioned contract, durable creation/tracking/correction/adoption hooks, cut_down classification.
- [x] Optional usage consent, separate crash preference, zero pre-consent collection, purge opt-out and erase; exclude identity from exports/backups/accounts.
- [x] Bounded independent queues, daily envelopes, stable sampling, retry record identity, failure/recovery suppression.
- [x] Screen visits and monotonic 30s idle-capped attention with foreground/cover/lock handling; no observable clock.
- [x] Existing local backup/restore outcomes and configuration states, defaults vs saved user choices. Account/purchase/entitlement restore and widget/onboarding adapters remain unavailable in consolidated source (no synthetic successes).
- [ ] Complete latest-head native payload/consent/offline/retry/upgrade tests, targeted app callback/UI tests and consent-on native performance evidence. Expanded prior native delivery/persistence tests passed; latest run pending.
- [x] Useful provider dashboards with consent/platform/sampling/coverage labels; actual provider delivery evidence when permitted.
- [ ] Refresh report assumptions, privacy manifest and handoff; commit/push analytics and open PR; never merge/release.

## External dependencies

Owner confirms free/no billing and sole Default production project; published allowance 1M analytics events/month, planning ceiling 700k. Billing scope unavailable; no actual spend-cap verification or paid services. Provider settings update confirmed autocapture/replay/console/performance/web-vitals/surveys/heatmaps off, IP anonymization on. Direct `eu.i.posthog.com` ingestion is network-blocked (CONNECT 403); connector has no capture tool. Production sending remains false pending real provider delivery/privacy and retry-dedup verification. No crash SDK initialization exists, so separate crash consent is disabled; no duplicate collector added.

Current integration lacks onboarding/account/sync/purchase/widget targets. Do not merge unfinished branches or fake these outcomes. Contract supports their future semantics, but capability flags false and dashboard notes disclose absent coverage.

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
