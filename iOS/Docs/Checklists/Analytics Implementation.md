# Analytics Implementation

Written by Codex, 1 October 2026. Continue on `analytics`; PR base is `integration` unless the consolidated base advances.

## Constraints and progress

- [x] Record prompt receipt: 2026-10-01 16:04:41 UTC (21:34:41 Asia/Calcutta).
- [x] Inspect scheduler: only cloud automations exposed; no supported same-Codex-chat/workspace wake target. No reminder or duplicate coding run created. First requested target would be 2026-10-01 18:49:41 UTC (October 2 00:19:41 IST). Second must only be scheduled if a genuine first message fires and task remains unfinished, at receipt + 5h20m; no third.
- [x] Read handoff, research contract and repository speed/design rules.
- [x] Fetch existing analytics and integration; merge only consolidated integration through `173f4f51eab20359a0bd01396b0ffe00d8cba590`.
- [x] Successful PostHog projects-get/project-get/read-data-schema/generate-app-url calls: sole Default project 290602, EU URL; no recently seen events. Billing tools unavailable without billing:read. Owner confirms free/no billing, published 1M/month; billing API remains unverified. Production delivery gate remains off pending real ingestion/privacy validation.
- [ ] Recheck consolidated integration before final push; instrument onboarding/widgets/account/purchases only after their owners land them. Do not merge unfinished feature branches.
- [x] Content-free versioned contract, durable creation/tracking/correction/adoption hooks, cut_down classification.
- [x] Optional usage consent, separate crash preference, zero pre-consent collection, purge opt-out and erase; exclude identity from exports/backups/accounts.
- [x] Bounded independent queues, daily envelopes, stable sampling, retry record identity, failure/recovery suppression.
- [x] Screen visits and monotonic 30s idle-capped attention with foreground/cover/lock handling; no observable clock.
- [ ] Existing backup flows and configuration states, automatic vs selected choices; verified purchase/account results only when supported.
- [ ] Payload/consent/offline/retry/native callback tests, meaningful macOS targeted tests and performance evidence.
- [ ] Useful provider dashboards with consent/platform/sampling/coverage labels; actual provider delivery evidence when permitted.
- [ ] Refresh report assumptions, privacy manifest and handoff; commit/push analytics and open PR; never merge/release.

## External dependencies

Owner confirms free/no billing and sole Default production project; published allowance 1M analytics events/month, planning ceiling 700k. Billing scope unavailable; no actual spend-cap verification or paid services. Provider settings update confirmed autocapture/replay/console/performance/web-vitals/surveys/heatmaps off, IP anonymization on. Direct `eu.i.posthog.com` ingestion is network-blocked (CONNECT 403); connector has no capture tool. Production sending remains false pending real provider delivery/privacy and retry-dedup verification. No crash SDK initialization exists, so separate crash consent is disabled; no duplicate collector added.

Current integration lacks onboarding/account/sync/purchase/widget targets. Do not merge unfinished branches or fake these outcomes. Contract supports their future semantics, but capability flags false and dashboard notes disclose absent coverage.

## Test and PR evidence

- Pushed `6a6d19f`, `5631cad`, `1910242`. Early native failures diagnosed as Swift overlapping optional-ledger access; helper snapshots sampling before mutation.
- [36893196823](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36893196823): native contract/payload checks, speed rules and core storage/migrations passed; app build failed on Privacy Section initializer; corrected for next run. UI/performance skipped.
- New deterministic transport retry/ack/invalid-batch/opt-out tests, per-day terminal-event cap and privacy manifest are staged for the next targeted run.
- Dashboards [989702](https://eu.posthog.com/project/290602/dashboard/989702) and [989704](https://eu.posthog.com/project/290602/dashboard/989704) created. Eleven derived queries validated against empty actual project (screen aggregate alias corrected and revalidated). Definitions in `iOS/Docs/Analytics Dashboards.json`. Filling/whole-dashboard validation pending. Metrics catalog access unavailable; definitions marked noncanonical.
- PR not yet created. No merge/release.
