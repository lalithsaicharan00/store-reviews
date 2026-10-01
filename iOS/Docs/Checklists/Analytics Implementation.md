# Analytics Implementation

Written by Codex, 1 October 2026. Continue on `analytics`; PR base is `integration` unless the consolidated base advances.

## Constraints and progress

- [x] Record prompt receipt: 2026-10-01 16:04:41 UTC (21:34:41 Asia/Calcutta).
- [x] Inspect scheduler: only cloud automations exposed; no supported same-Codex-chat/workspace wake target. No reminder or duplicate coding run created. First requested target would be 2026-10-01 18:49:41 UTC (October 2 00:19:41 IST). Second must only be scheduled if a genuine first message fires and task remains unfinished, at receipt + 5h20m; no third.
- [x] Read handoff, research contract and repository speed/design rules.
- [x] Fetch existing analytics and integration; merge only consolidated integration at `873265d71485574063ba934d6f1b5e92b392d77f`.
- [x] Successful PostHog projects-get/project-get/read-data-schema/generate-app-url calls: sole Default project 290602, EU URL; no recently seen events. Billing tools unavailable without billing:read. Do not enable production until free allowance/zero-spend cap verified.
- [ ] Recheck consolidated integration before final push; instrument onboarding/widgets/account/purchases only after their owners land them. Do not merge unfinished feature branches.
- [ ] Content-free versioned contract, durable creation/tracking/correction/adoption hooks, cut_down classification.
- [ ] Optional usage consent, separate crash preference, zero pre-consent collection, purge opt-out and erase; exclude identity from exports/backups/accounts.
- [ ] Bounded independent queues, daily envelopes, stable sampling, retry record identity, failure/recovery suppression.
- [ ] Screen visits and monotonic 30s idle-capped attention with foreground/cover/lock handling; no observable clock.
- [ ] Existing backup flows and configuration states, automatic vs selected choices; verified purchase/account results only when supported.
- [ ] Payload/consent/offline/retry/native callback tests, meaningful macOS targeted tests and performance evidence.
- [ ] Useful provider dashboards with consent/platform/sampling/coverage labels; actual provider delivery evidence when permitted.
- [ ] Refresh report assumptions, privacy manifest and handoff; commit/push analytics and open PR; never merge/release.

## External dependencies

Billing: PostHog discovery explicitly reports billing:read missing. Actual allowance, organizational usage and zero-spend limit remain unverified. Production sending must fail closed. Project defaults currently permit autocapture, console/performance/web-vitals and heatmaps; replay is off and IP anonymization is on. No crash SDK initialization exists in consolidated source, so Sentry crash coverage is unverified, and no second collector should be added.

## Test and PR evidence

Pending implementation. Record exact commits, CI runs, outcomes and remaining limitations here regularly.
