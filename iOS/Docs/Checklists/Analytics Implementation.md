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
