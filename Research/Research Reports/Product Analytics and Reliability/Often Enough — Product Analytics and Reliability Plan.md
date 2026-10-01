Written by Codex, 1 October 2026.

# Often Enough — Product Analytics and Reliability Plan

**Status: consolidated iPhone analytics implemented on `analytics`; final Release/native verification and PR readiness in progress. Production sending remains disabled because performance/rollout acceptance is unresolved; synthetic EU provider acceptance and all 14 dashboard queries are verified.** The contract below is the research proposal; the dated implementation audit at the end and analytics handoff record actual code, project changes and test evidence. The pinned branch audit is historical and does not mean unfinished features are consolidated.

## 1. Recommendation

Use **PostHog EU for explicit, content-free product events**. Measure frequent actions through three compact daily summaries, with separate events for important, infrequent flows. Keep automatic click capture, session replay, arbitrary logs and person profiles off.

Answer these questions first:

1. Which features do consenting installations actually use, and how often?
2. How many tasks and habits are created, and which habit types are chosen?
3. Which screens receive visits and active attention?
4. Which backup/account configurations are active, and which were explicitly chosen?
5. Where do onboarding, account, upgrade and recovery flows fail?
6. Do releases introduce crashes, storage problems, broken widget actions or slow screens?

The existing architecture selects **Sentry for crash diagnostics**, alongside PostHog for product analytics. Keep that division initially. PostHog now documents native iOS error tracking, but changing crash providers needs a separate coverage and privacy evaluation; do not initialize both crash collectors by default.

These are application measurements. They still involve **pseudonymous installation identifiers**, so “no habit content” does not mean “no personal data whatsoever.” No account linkage, advertising identifiers or behavioural fingerprinting is proposed.

## 2. Evidence, access and implementation status

The audit inventoried **31 remote branch references at 21 distinct tips** on 1 October 2026. Every distinct tip's commit metadata and changed-file list was checked. Relevant app models, navigation, persistence, widgets, onboarding checklists and server/privacy/release/backup documents were inspected. This is a branch and architecture audit, not a claim that every historical file was reviewed.

The complete pinned inventory is in Appendix A. Other agents are active; later commits can supersede this snapshot. In particular, current main does not contain all feature work.

Important findings from the pinned research branch audit (not current consolidation):

| Area | Observed state | Consequence for analytics |
|---|---|---|
| Habit model | Check, amount, duration, checklist, quit and task; cut-down is represented through the at-most rule | Derive a content-free reporting type; never infer it from the habit name or unit |
| Integration | Today, tasks, habits, Progress, groups, routines, reminders, history/correction, undo, pause/archive, settings and export/restore | Instrument durable actions and canonical destinations after merge |
| Onboarding and Help | Skippable welcome flow, first-habit suggestions, replay, Help/FAQ and About; native onboarding checks documented | Distinguish first run, restore and replay; do not send names, search text or chosen habit content |
| iPhone widgets | Today, individual item, Lock Today, Icons and History families; actual Home interaction tests and app-host renders documented | Measure accepted actions and configuration, never render callbacks as views; actual Lock host testing remains a separate release check |
| Server and sync | Apple/Google server auth, sync rules, Plus verification, account backups and rate limiting; latest shared core has checked restore with preview/Replace/Merge/undo | Client sign-in/purchase/backup UI still has work; server support does not establish a completed client feature |
| Other platforms | Android, watch and web client work is later in server status; iPad support is not established by this audit | Reserve the shared contract; do not claim these clients are shipped |
| Existing analytics | No PostHog product wrapper or operational crash SDK initialization found in reviewed app source | Treat every event below as proposed, not live |

The PostHog plugin was found **installed and enabled**. No callable PostHog project/query tools were exposed during that initial research session. Consequently, the active project's region, consent settings, event history, billing allowance, retention and current usage were **not inspected at that research stage**. The implementation audit below supersedes these access assumptions. Official public documentation was available through PostHog's GitHub repositories.

This report is reasoned from the product's measurement questions and inspected source. It does not assert new review-corpus counts or a new competitor survey.

## 3. Privacy boundary and denominators

### 3.1 Identity and consent

Follow Architecture 09's installation identity, separate usage/crash controls, EU analytics and no account linkage:

- Generate a random installation ID dedicated to analytics. Keep it out of account tokens, synced Keychain items, cloud backups and data exports.
- Never call identify/alias using an account ID, Apple/Google identity, email, purchase ID or a hash of these. Hashing an account ID still links the account.
- Disable person profiles and default person properties. A plan/account-state enum may accompany an event without creating an identity profile.
- Recommend **usage off until optional informed consent**. Do not initialize the SDK, preload flags or queue behaviour before consent. Crash sharing has a separate switch.
- Provide the control in Privacy and an optional, plain-language welcome consent affordance if first-run measurement is required. It must not block onboarding or core tracking.
- If consent is offered only after welcome, a full first-run funnel cannot be measured. Report only steps observed after consent; do not upload pre-consent history later.
- Opt-out stops collection and clears pending SDK events, local counters and extension relays. Do not emit an opt-out event after disabling collection.
- Erase Everything clears consent, counters and analytics identity; a reinstall starts a new identity. Restoring habit data must not restore analytics identity or consent.
- Cloud/server activity does not independently authorize collecting product analytics for an opted-out client. Keep server operational counts separate.

All product adoption percentages must say **“among consenting active installations with this capability”**. One person on two phones can count twice; a reinstall can count again. “People,” globally unique users and cross-device conversion are not justified by this identity model.

Account creation needs special care: client analytics can count installations that completed a verified new-account registration. Exact accounts created belongs to a content-free server operational counter. Do not join that counter to installation analytics.

Preserve the existing documented retention ceilings: analytics 12 months, crash diagnostics 90 days, subject to provider/account capabilities. Verify configured retention before release; those ceilings do not establish the free plan's actual retention. Document privacy labels/manifests and inspect real SDK payloads. Never promise “not linked to you” merely because names were omitted.

### 3.2 Allow and reject

**Allowed:** controlled feature/screen/type enums, aggregate action counts, active seconds, success/failure codes, app version/build, OS major version, platform/form factor, actual entitlement state, backup configuration and sampling/coverage metadata.

**Rejected everywhere, including errors and breadcrumbs:**

- Habit/task/checklist/group names, descriptions, notes, goal values, logged amounts, timer lengths, units, schedules, selected history dates, streak lengths and quit/slip details.
- Habit, entry, group, database, widget-instance, account, device-sync and purchase identifiers; widget signatures/tokens and reminder identifiers.
- Email, name, auth provider subject, credentials, Apple receipts, transaction IDs, invitation codes, contacts, clipboard and advertising identifiers.
- Database contents, raw SQL bindings, exported file names/paths, request bodies/headers, raw error messages, screenshots or session replay.
- Full URLs, query strings, search queries, precise location, inferred country from locale, notification text or support messages.

A temporary random analytics event UUID can support delivery deduplication. It must identify only that analytics record, never a business object. Strip IP-derived location enrichment, use the provider's supported GeoIP-disable controls and review IP handling in the project; this does not mean the ingestion service never receives an IP address.

## 4. Contract shared across platforms

Use the same versioned event names and enums across native clients. Do not create events such as ios_habit_created and android_habit_created.

Required common properties:

| Property | Definition |
|---|---|
| schema_version | Integer; initially 1 |
| platform | ios, ipados, android, watchos or web |
| form_factor | phone, tablet, watch or browser |
| app_version / app_build | Controlled release metadata |
| os_major | Major OS version; no full device fingerprint |
| release_channel | production, beta or development |
| origin_surface | app, widget, watch, notification, shortcut or web |
| plan | free, plus, family or unknown, derived from actual ownership |
| sample_rate / sampling_version | Inclusion probability and policy version |
| analytics_record_id | Random record identity for retry deduplication; never a habit/account ID |

Daily envelopes also require period_start_utc, period_end_utc, collection_started_mid_period, foreground_active and external_action_active. These describe analytics coverage, not the dates of habit logs. Use UTC collection periods, independent of the user's configurable “new day” boundary.

Properties are allowlisted, typed and bounded. Unknown fields, arbitrary strings and unrecognized enum values are rejected before SDK capture. Do not use a generic “button_clicked” event with arbitrary labels.

**Project arrangement:** one production EU product project for released app clients; an isolated non-production project/key for CI, debug and beta as appropriate. Platform/form-factor breakdowns distinguish devices. Put a marketing website in a separate project initially so visitor page views do not consume the app's event budget or pollute its activation funnel. Organization billing may still share allowances: verify actual billing scope rather than assuming another project creates another free allowance.

Do not link web cookies or watch identities to account IDs. For a paired watch, the phone may relay a consented, bounded watch summary without recording the same action twice. Use origin_surface=watch. Independent watch installations need their own consent and identity design. Never claim a watch SDK is supported without checking its deployment targets and extension restrictions.

## 5. Recommended event registry

**P0** is the initial useful set. **P1** is a later addition only when it answers a defined question and fits the observed budget. **Future** means no emitter until the capability exists. “Once” below means a local once-per-flow/period guard, not a new network request for each event.

| Event | Priority | Emit when | Specific properties and limits |
|---|---|---|---|
| onboarding_step_reached | P0 | A consented first-run or replay destination genuinely appears | flow_mode=first_run/replay/restore; step=welcome/free_plan/day_week/first_item; at most once per step per flow |
| onboarding_finished | P0 | Explicit completion, skip-all or handoff to restore | flow_mode; outcome=completed/skipped/restore_handoff; no “abandoned” event inferred from termination |
| entity_created | P0 | A new task or habit has committed successfully | entity_type=task/habit; habit_type; creation_origin=manual/suggestion; exactly one per new entity; excludes imports/restores/sync replication |
| activation_reached | P0 | First successful tracking write observed after consent | milestone=first_observed_tracking_write; entity_type and habit_type; cohort=fresh_first_run/restored/existing/unknown; once per installation, never reconstructed retrospectively |
| feature_usage_daily | P0 | A closed collection period containing observed activity is frozen | Fixed aggregate fields from §6; one record per active installation-day |
| screen_engagement_daily | P0 | A closed period has screen activity | Fixed visits/active_seconds per canonical screen; one record per installation-day, not per screen |
| configuration_snapshot | P0 | A closed foreground-active collection period is frozen | Latest observed account/backup/plan and feature state in that period; one per foreground-active day; no background heartbeat |
| preference_changed | P1 | A user explicitly saves a meaningful preference | setting=backup_primary/secondary_copy/reminder_mode/widget_privacy/theme/feedback/streaks; value is a controlled enum; exclude auto-defaults |
| account_flow_result | P0; emitter awaits UI | An explicit registration/sign-in/link/sign-out/delete attempt reaches a terminal observed result | action; provider=apple/google/not_applicable; result=success/cancelled/failed; new_account=true/false/unknown only from verified response; bounded failure_code |
| paywall_opened | P0 | Plus screen actually appears from a user action | entry_point=menu/habit_limit/widget_configuration/feature_gate; once per presentation |
| purchase_flow_result | P0; emitter awaits purchase UI | A purchase attempt resolves | product_tier=plus/family/family_upgrade; result=verified/pending/cancelled/failed; verification=store/server; fixed failure_code; no prices/receipts/order IDs |
| purchase_restore_result | P0; emitter awaits purchase UI | Restore/check ownership finishes | result=restored/no_entitlement/cancelled/failed; verification; no success merely from tapping Restore |
| backup_restore_result | P0 | User export/backup/restore completes or actually fails | operation=export/manual_backup/restore; provider; format=checked_backup/csv/legacy/unknown; restore_mode=replace/merge/not_applicable; result=success/cancelled/failed; fixed failure_code |
| reliability_state_changed | P0 | A bounded first failure or recovery for a subsystem is observed | subsystem=storage/backup/sync/widget/reminder; state=degraded/recovered; fixed failure_code; at most one of each per subsystem/day |
| widget_inventory | P1 | Main app successfully queries current widget configurations, after consent | Fixed kind/family presence/count fields; once daily only when configuration differs; query_supported and query_result; no instance IDs |
| creation_flow_finished | P1 | User closes a creation form or saving fails | entity_type; selected habit_type; outcome=created/cancelled/save_failed; once per flow; no validation field contents |
| family_flow_result | Future | A real invite/join/leave/revoke feature is implemented | action/result only; no invite codes/member identities |

For account/purchase/restore events, local UI flow guards prevent repeated callbacks from emitting twice. Offline retry reuses the analytics record identity. For purchase entitlement changes discovered later, record the actual current plan in configuration_snapshot; a launch ownership check is not a new purchase.

Habit type contract: check, amount, duration, checklist, quit, cut_down, not_applicable. Task uses entity_type=task and habit_type=not_applicable. Classify at-most amount habits as cut_down before the general amount branch; resolve the effective rule at the action, since historical rules can differ. Do not expose “water,” “smoking,” numeric increments or unit text.

Do not create an event for each onboarding field, validation error, habit suggestion, FAQ search character or Settings row tap. Funnel queries can infer dropout only after a stated observation window; a closed app is not proof of abandonment.

## 6. Daily summaries and complete feature coverage

### 6.1 feature_usage_daily

Use a small local counter table and freeze **one envelope for the installation-day**. Store counts as named numeric properties from a fixed registry so PostHog can sum them. Omit unused counters; a missing known counter means zero only when coverage_complete=true.

Recommended initial groups:

| Feature group | Fixed counters/flags | Product question |
|---|---|---|
| Tracking | tracking_write_count; habit_write_check/amount/duration/checklist/quit/cut_down; task_write_count | Which tracking controls are used? Counts are operations, never logged values |
| Origin | write_origin_today/manual/routine/reminder/timer/history/shortcut/widget/watch/web | Where do successful user-originated writes happen? Sum origins equals tracking_write_count |
| Corrections | undo_count, edit_entry_count, delete_entry_count, history_log_count | Are correction tools needed and discoverable? Do not count undo as a new successful log |
| Tasks | task_completed_count, task_reopened_count, task_deleted_count | Is unlimited task tracking used? Creation totals come from entity_created |
| Organization | group_created_count, group_assigned_count, reorder_count, filter_used, section_fold_used, completed_filter_used | Are groups and Today controls useful? No group names or membership |
| Routines/timers | routine_started_count, routine_finished_count, routine_cancelled_count, timer_started_count, timer_stopped_count | Is guided tracking adopted? No routine names or timer durations |
| Habit management | schedule_edited_count, goal_edited_count, reminder_edited_count, habit_paused_count, habit_resumed_count, habit_archived_count, habit_deleted_count | What management tools are used? Count saves, not draft edits |
| Progress | progress_week_used, progress_month_used, progress_year_used, progress_group_filter_used, habit_calendar_used, weekday_chart_used, runs_chart_used, money_view_used, year_share_started_count | What parts of Progress are opened or selected? Never send monetary values or chart data |
| Notes/milestones | note_saved_count, milestones_opened | Measure feature use without text, streaks or milestone values |
| Help/support/review | faq_opened_count, help_search_used, contact_support_opened_count, welcome_replay_count, review_prompt_requested_count | Measure help discoverability; request != system prompt displayed, support composer != message sent |
| Widgets/Shortcuts | widget_action_accepted_count, widget_deeplink_opened_count, widget_page_changed_count, shortcut_action_accepted_count | Accepted actions only; paging may be lower-priority if the extension relay adds undue complexity |
| Reliability/performance | Fixed subsystem success/failure counters; sampled cold_launch_ms_bucket, screen_ready_ms buckets and observation counts | Failure rates need success denominators; no raw exceptions or full traces |

Use booleans for “used at least once” where repeated taps add little value. Feature adoption = distinct eligible installations with a flag/counter above zero / distinct eligible active installations, not the number of events.

Origin counters describe an action, not the device that uploads it. A widget-origin habit write can contribute to total tracking and widget adoption; dashboards must not sum those two categories as separate writes.

No count is updated from drawing, observing a changed database, replaying an outbox, importing, restoring or applying another device's sync operations. Increment only after the initiating operation's durable commit. Current optimistic UI insertions and “perform” queues require explicit success hooks; tapping the row or inserting it in memory is insufficient. Counters remain a separate disposable telemetry store, never columns in synced habit records.

### 6.2 screen_engagement_daily

Canonical screens:

today, my_tasks, all_habits, progress, habit_detail, history_day, new_habit, new_task, routine_player, menu, times_of_day, day_and_week, reminders, appearance, widgets_settings, backup_sync, account, plus, privacy, help, about, onboarding.

For each supported screen, define fixed fields visits_<screen> and active_seconds_<screen>. Add explicit canonical names only through a schema revision. New-habit sub-editors remain under the creation screen initially; Progress ranges are feature flags, not more screen names.

A visit begins when a destination becomes the top visible interactive surface. SwiftUI body recomputation is not a visit. Stop attention when covered by another destination, a modal, the menu, backgrounding, locking or loss of scene focus.

Use monotonic elapsed time and pause after **30 seconds without interaction**; resume on interaction. This is an estimate of active attention, not eye tracking. Running a habit timer does not keep screen attention active. No one-second network heartbeats or observable clock that redraws Today.

For iPad split views/multiple windows, attribute time to the focused interactive pane; avoid assigning the same interval in full to multiple screens. Enforce summed screen time <= the application's eligible foreground time. Report both visit share and median/percentile active time among visitors. A longer visit can signal confusion; it does not by itself establish satisfaction.

### 6.3 configuration_snapshot

Keep current state locally while foreground-active, refresh it on successful configuration changes, and freeze the latest observed state into one snapshot per closed foreground-active day. Do not emit another snapshot for every change. This trades immediate configuration reporting for lower volume; dashboards show the collection period and freshness.

Capture:

- account_state=no_account/signed_in/unknown and account_provider=apple/google/multiple/not_applicable.
- backup_primary=server/icloud/google_drive/local_only/unknown; primary_source=automatic/user_selected/unknown.
- secondary_copy=icloud/google_drive/disabled/unknown; effective_backup_status=verified_recent/problem/never_verified/os_managed_unobservable/unknown.
- sync_state=enabled/disabled/not_entitled/no_account/unknown.
- Actual plan, reminder permission=authorized/denied/not_determined/unknown, reminder_mode=notification/alarm/disabled/unknown where supported.
- Feature-setting enums: theme, haptics/sound, milestone/streak visibility, widget-content privacy, app-lock enabled. Omit irrelevant or unavailable fields.
- onboarding_state=not_started/in_progress/completed/skipped/unknown; current state is not retrospective step history.
- capability_set_version plus fixed availability flags for account UI, sync, purchase, widget families, alarm reminders and relevant platform features.

Use the **latest snapshot within the reporting period per installation**, not every snapshot as another person. Unknown/missing state remains its own category, never “no account.”

The latest backup design has optional accounts on Free and Plus: no-account iOS defaults to an own-iCloud safety copy; an account defaults to server backup; Plus plus an account enables sync. Secondary own-cloud copies can coexist. Distinguish primary provider from secondary coverage and automatic defaults from explicit selection.

Android Auto Backup is OS-managed: configuration is observable, successful recent backup generally is not. Never label it verified merely because enabled. Likewise a cloud file write acknowledgement is not proof that restore has been tested.

## 7. Widgets, iPad, watch, web and Android

| Surface | Meaningful measurements | Measurements to avoid |
|---|---|---|
| iPhone Home | Accepted tracking actions, user-triggered app opens, configured kind/family presence, paging if safely relayed | Provider/timeline reload counts as views, inferred dwell, per-render capture |
| iPhone Lock | Accepted actions/deep links and accessory family where reliably supplied | Pretending app-host renders verify actual Lock host behaviour |
| iPad | iPadOS supports Home widgets and Lock widgets; Lock widgets arrived with iPadOS 17. Apply the same kind/family schema when this app supports them | Assuming the app is iPad-ready because the OS supports widgets |
| Android widgets | Same semantic accepted-action event counters after durable write; Android adapter for configuration/refresh failures | Treating launcher rendering as an impression or assuming every launcher exposes installation/removal |
| Watch | Watch-origin successful actions, watch foreground screen summary, relay failures | Counting phone relay and watch write twice; background refreshes as sessions |
| Web app | Shared semantic events and route allowlist, foreground/idle timing, sanitized failures | DOM/text/form autocapture, query-string capture and account-linked cookies |
| Marketing website | Optional separate project: route category, download/store-link clicks and visitor conversion within consent | Full URL/referrer queries, automatically merging website visitors with app installations |

Current widget kind identifiers: OftenEnough.Today.v1, OftenEnough.Item.v1, OftenEnough.LockToday.v1, OftenEnough.Icons.v1 and OftenEnough.History.v1. Normalize these to today/item/lock_today/icons/history and family to small/medium/large/accessory_inline/accessory_circular/accessory_rectangular.

Current WidgetLogIntent supplies item/day/event/signature, **not reliable widget kind/family context**. Future implementation must add controlled provenance if required. Never export those existing parameters. Family alone may not establish Home versus another host such as StandBy; use host=unknown where the OS does not supply trustworthy placement.

Run capture/counter updates in the app-side accepted-action path. Do not add a network SDK to the widget provider. For genuine extension-side paging, use a bounded, disposable content-free App Group relay gated by mirrored consent. Relay failure must not block widget use. Querying WidgetCenter current configurations reports a snapshot of configuration, not views, a precise installation timestamp or guaranteed removal events.

App Lock/widget privacy settings should remain effective independently of analytics. A replayed widget callback, duplicate event, already-complete item or undone tombstone must not be counted as another accepted log.

## 8. Free-plan budget and overload policy

PostHog's official pricing source inspected on 1 October lists **1M Analytics events per month**. Product Analytics is billed by captured event volume. Batching 20 events into one HTTP request still represents 20 billable events. Other products have separate allowances; leaving replay/flags/surveys off reduces both privacy exposure and accidental product usage.

Use a planning ceiling of **700,000 app analytics events/month**, with the remainder reserved for new-install bursts, failures, other organizational usage and estimation error. Confirm the actual allowance and billing scope in your account before implementation.

Estimate:

E = D × A × (3p + c) + N × f + O

where D=days, A=consenting active installations/day, p=daily-summary cohort inclusion, c=average selected low-frequency events per active installation/day, N=new eligible installations/month, f=onboarding/activation events per new installation, and O=other projects/reliability/widget-inventory/P1 overhead.

The three summaries are an upper bound: screen/config summaries require foreground use; a widget-only day may generate feature usage alone. The following conservative examples assume D=30, c=0.5 and reserve 100,000 events for N×f+O. They are planning examples, not observed usage.

| Consenting active installations/day | Daily summary sample p | Estimated monthly events |
|---|---:|---:|
| 1,000 | 100% | 205,000 |
| 5,000 | 100% | 625,000 |
| 10,000 | 50% | 700,000 |
| 20,000 | 10% | 580,000 |

Recompute using actual event counts after launch; c can be much higher when many entities are created. There is no unconditional promise that this design remains free at every scale.

Overload order:

1. Keep P1 events off initially, disable accidental SDK automatic events and suppress repeated failures.
2. Reduce all three daily summaries using a stable random installation cohort; record inclusion probability. Use the same cohort for numerator and denominator of summary-based percentages.
3. If low-frequency events alone exceed budget, sample **whole installations consistently across flows**, including entity creation and onboarding. Do not sample only successes or arbitrary events halfway through a funnel.
4. Monitor projected usage weekly and after releases. Configure a product billing limit appropriate to zero paid usage and confirm its effective behaviour; provider docs say exceeding limits drops data permanently.
5. Dashboards must flag sampled periods, incomplete delivery and budget exhaustion; no missing data should be presented as “feature unused.”

Weighted aggregate operation totals can use count/sample_rate when the sample is appropriate. Do not naively multiply unique installation counts to claim an exact population. Changing sample rates changes comparability; retain sampling_version and examine cohort bias.

Keep records bounded locally, with at most seven days of unsent daily summaries; drop older telemetry rather than blocking tracking. Freeze each closed period once, persist a random record ID and reuse it across delivery retries. Upsert/deduplicate daily analytical records by record ID before summing; verify PostHog's actual ingestion deduplication support rather than assuming capture retries are exactly once. Explicitly label stale/lost coverage.

No work is scheduled merely to send at midnight. Freeze on the next eligible lifecycle transition and upload opportunistically. Use collection-period properties for dashboards rather than ingest time, since offline records can arrive later. Purge both SDK and local queues on consent withdrawal.

## 9. Reliability and production readiness

### 9.1 Crash diagnostics

Maintain a separate crash pipeline with its own consent, quota and payload review. Existing Architecture 08 calls for Sentry across iOS/Android/Worker; the SDK wiring and operational setup remain implementation work.

Required evidence before choosing a native crash provider:

- Release symbolication: dSYMs for Apple, mappings/native symbols for Android, source maps for web/Worker; CI upload credentials stay out of shipped apps.
- Synthetic fatal crash recovered on the next launch, nonfatal failure, offline delivery and opt-out queue deletion.
- Stack/breadcrumb sanitization using synthetic secret habit text and auth tokens, inspected in actual outgoing and received payloads.
- Platform-specific coverage for native crashes, app hangs/ANRs and termination diagnostics; no promise that one SDK captures every OS kill.
- No account identity or content in error contexts; never forward exception descriptions blindly.

PostHog's current iOS documentation lists limitations: system frames are not symbolicated and Swift crashes appear as SIGTRAP without the actual error message. It is a viable provider to evaluate, not a reason to silently replace the repository's existing Sentry direction.

The architecture's beta target is crash-free >=99.8%. Define the denominator using the selected crash provider's comparable sessions/consent cohort. Do not divide crashes from Sentry by sampled PostHog daily records. Launch-started without launch-ok is a recovery signal, not proof of a crash.

### 9.2 Action failures and operational monitoring

Product events use fixed failure codes, for example storage_write_failed, storage_read_only, backup_integrity_failed, backup_permission_revoked, backup_quota_full, sync_auth_required, sync_rate_limited, sync_unavailable, widget_stale_action and reminder_schedule_failed. Unknown exceptions map to unknown_failure; their raw text never enters analytics.

Daily summaries include attempted/succeeded/failed counts per subsystem. An intermittent failed operation can count toward a failure rate even when no persistent degraded state is entered. Keep state_changed incident events bounded and nonfatal operation counters aggregate.

Cloudflare dashboards/operational metrics should cover uptime, request/5xx rates, latency, rate-limit exhaustion, backup job success and a practiced restore. Do not emit a PostHog event for every sync poll, HTTP request or replicated row. Account creation/deletion totals can remain anonymous operational counters without joining identities.

Sample launch-ready and selected screen-ready/hitch metrics through native tooling; separate cold/warm launch and app version. Performance summaries carry observation counts and coarse duration buckets, not raw traces of user activity. Existing CI performance checks remain release evidence, not production analytics.

App tracking, writes, backup and widget actions must succeed if analytics is offline, full, disabled or throwing. Network batching and bounded counter persistence must not run on SwiftUI draw paths or introduce database scans/timers into Today.

## 10. Dashboards and exact interpretations

| Dashboard | Calculation / question | Denominator and caution |
|---|---|---|
| Feature adoption | Distinct installations with a feature counter/flag >0; sum operations separately | Eligible consenting active installations in the same daily cohort; zero-use days need summaries |
| Creation mix | Count entity_created split task/habit and habit_type; creations per creator and per active installation | Durable new creation only; imported content is excluded; counts do not establish current inventory |
| Screen engagement | Visitors, visits, active seconds, attention share and typical per-visitor time | Foreground-active installations with valid screen coverage; timer runtime excluded |
| Progress | Week/month/year and chart/group-filter adoption | Installations with Progress capability; no chart-point or chart-content collection |
| Onboarding | Reached steps -> explicit finish -> creation -> first observed tracking write within seven days | Fresh first-run consented cohort only; replay, restore and existing-install flows separate; consent bias disclosed |
| Accounts | Latest account state; verified successful registration/sign-in outcomes | Known-state active installations; show unknown separately; server totals answer exact accounts created |
| Backup | Latest primary/secondary provider, automatic vs selected, verified/problem/unknown state | Provider-eligible platforms; don't call automatic iCloud defaults “users selecting iCloud” |
| Plus | Paywall presentation -> verified purchase; pending/cancelled/failure breakdown; restore results | Eligible presentations/installations; repeated presentations separated from installation conversion |
| Widgets | Configured kind/family among successful queries; accepted actions and deeplink adoption | Supported queried installations; no impression/dwell or unseen-host claims |
| Reliability | Subsystem failed/attempted counts, incident/recovery trend, crash and operational dashboards | Matching cohort and version; diagnostics handled separately from product quota |
| Retention | Return foreground or accepted external-action days after first observed activity | Installation retention among opt-ins, not unique-person or cross-device retention |

Suggested query logic for each daily metric:

1. Filter production, schema_version, period bounds and capability.
2. Deduplicate analytics_record_id; use collection period, not late upload day.
3. For feature adoption, count distinct installation IDs with positive counters / distinct IDs with valid feature-summary coverage.
4. For backup/accounts, pick one latest valid snapshot per installation in the period; show stale coverage and unknown explicitly.
5. For average screen time, sum active seconds / visitors or visits according to the labelled metric. Do not average per-envelope values and call it a population average.
6. Apply matching sample cohorts and weights only where statistically appropriate.

Review dashboards weekly during beta, after each rollout and monthly afterward. Investigate low use alongside feature availability and failures. A feature unavailable on Android or gated behind Plus should not be ranked “unpopular” using every free iPhone installation as its denominator.

## 11. Implementation sequence and ownership

This is a future checklist, not work performed by this report.

1. **Confirm project configuration:** actual EU ingestion host, public project token, billing scope/limit, retention and current usage. Keep personal API/admin tokens out of apps. Confirm crash provider choice against Architecture 08.
2. **Finalize contract and privacy:** optional consent copy, canonical enums/counters, capability map, schema version, allowed failure codes and installed-ID lifecycle. Resolve first-run consent placement without making it mandatory.
3. **Build one native analytics boundary:** typed API, explicit SDK configuration, strict before-send sanitization, bounded counters, daily freeze/dedupe, sampling and no-op mode. Inject an in-memory test sink; no view may call the SDK directly.
4. **Integrate merged app hooks:** persistence success callbacks, canonical navigation ownership and current settings. Start with entity creation, daily tracking/screen/configuration summaries and actual onboarding.
5. **Follow feature branches:** account/backup UI hooks belong with their real client flows; purchase events follow verified StoreKit/Play results; widget context follows accepted-action paths. Do not instrument placeholder Get Plus buttons as successful purchases.
6. **Add diagnostics:** release symbols, scrubbed crash SDK, fixed-code failures and independent Cloudflare monitoring. Keep crash consent independent.
7. **Validate in non-production:** native macOS GitHub Actions for iPhone code when implemented; targeted tests and required performance checks. Add Android/web/watch adapters as those clients arrive, with the same contract.
8. **Enable production gradually:** payload inspection, event-volume forecast, daily-record dedupe verification and dashboards with honest coverage labels. Add P1 only after initial measurements identify a useful question.

Relevant source hooks are HabitStore.add/addLogged/logFromWidget/undoEntry, AppModel.logFromWidget/logFromReminder, canonical MenuPlace/navigation, Progress range selection, routine lifecycle, actual onboarding destinations and the future account/purchase/backup client adapters. Shared Core restore/sync must distinguish originating actions from replicated application. Server aggregate counters stay outside the phone's analytics identity.

The iOS docs show automatic lifecycle and screen capture enabled by default, surveys and feature-flag preloading enabled, and automatic rage clicks available independently of element capture. Explicitly disable unwanted defaults, swizzling-dependent auto capture, flags/events, surveys, session replay, automatic logging and tracing headers. Set personProfiles=never and setDefaultPersonProperties=false. Gate SDK initialization on consent; use setBeforeSend's allowlist/drop capability and verify all automatic properties in actual payloads. Pin the SDK version and check exact APIs rather than copying configuration names across platforms.

Web likewise needs explicit disabling of autocapture/pageview/pageleave/replay/console logging and full URL properties. Automatic tracing headers can expose the installation identity to authenticated servers; leave them off.

## 12. Acceptance tests for implementation

| Case | Required result |
|---|---|
| No consent, decline, crash-only opt-in | Zero product capture, queued events, flag/replay calls or analytics identifiers in account requests |
| Opt-out while offline with extension queue | SDK and local relay/counters purged; no later upload |
| Synthetic names/notes/values/token strings everywhere | Strings absent from outgoing and received analytics/crash payloads, including breadcrumbs and SDK-added fields |
| New habit/task save, failed write and retry | One creation after success; zero on failure; business IDs absent |
| Every habit type, historical rule and task | Correct controlled type; cut_down separate from amount; task has no habit subtype |
| Widget double callback, stale signature, Undo, cold launch | Only newly committed accepted action counted; no retry duplication or business token export |
| Restore/import/sync to another device | No fictitious new creations/log adoption from replication; one observed restore result |
| Screen cover, modal/menu, background, lock, idle | Visits/time attributed once, inactive time excluded; no Today redraw clock |
| Day boundary, DST, new-day setting, offline week | UTC collection stable; daily records unique; late events use collection period; telemetry retention bounded |
| Backup auto-default vs explicit selection; primary plus secondary | Dashboard separates default, choice and secondary coverage |
| No account / account / unknown; sign-in vs registration | Distinct states; no account IDs; no false new-account count |
| Purchase pending/cancelled/refunded/restore-no-entitlement | Verified outcomes only; launch ownership checks never counted as new sales |
| Debug, CI, seeded demo and simulator activity | Isolated from production project; release capabilities correctly reported |
| Sampling change and exhausted billing allowance | Dashboard coverage warning; coherent cohorts; telemetry never blocks app features |
| Native fatal crash, nonfatal error and OS termination | Diagnostic provider coverage demonstrated; terminations not mislabelled; symbols uploaded |
| iPhone, future iPad/Android/watch/web | Same semantic contract; unsupported features excluded from denominators; relay counted once |
| Network disabled and telemetry store full | Core logging, widgets, backup and UI remain functional; no material performance regression |

Completion means these cases pass against captured payloads and the provider dashboard, not simply that capture() was called. Production release is blocked on content leakage, consent failures or analytics affecting durable tracking.

## Appendix A. All branch references reviewed

Aliases sharing a tip are grouped. SHAs pin the audit and distinguish current work from archive, CI and scratch branches.

| Branch references | Pinned tip | Analytics relevance |
|---|---|---|
| `animations-and-settings`<br>`archive/animations-and-settings-2026-10-01` | `369834be81c45aa27d8bb59d0a2fdf5beeaf38e1` | Animations/settings; configuration and feedback adoption. |
| `archive/adoring-dijkstra-3rixv2-2026-10-01`<br>`claude/adoring-dijkstra-3rixv2` | `44a6c9cdb2ed871c8e399c45229c274febe92008` | Navigation research; canonical destinations and entry paths. |
| `archive/habit-tracker-features-igxafl-2026-10-01`<br>`claude/habit-tracker-features-igxafl` | `b562894b224d8e1f6f6d9815f9cb8b33bf2e7ba3` | Earlier widget/Shortcuts/app-lock work; use current widget implementation for hooks. |
| `archive/main-2026-10-01`<br>`archive/perf-scrolling-and-ci-2026-10-01`<br>`perf-scrolling-and-ci` | `3235a58c347f3e35264d777cd77154945317e98d` | Scrolling/performance baseline; archived main shares this tip. |
| `archive/perf-smooth-app-2026-10-01`<br>`perf-smooth-app` | `64eeb9a885cc26ec4b382afa65587f6388515536` | Performance tooling; CI measurements, no customer events. |
| `archive/progress-page-research-2026-10-01`<br>`progress-page-research` | `b26938fbefa366482e76ca56f9ed72b036a24099` | Progress and groups; ranges, charts and group adoption. |
| `archive/sidebar-2026-10-01`<br>`sidebar` | `5a848d156fa86cf8283026519a0d35302741c9ba` | Sidebar, tasks, reminders and export/restore. |
| `archive/undo-research-2026-10-01`<br>`claude/undo-research` | `471328d5f087fc3c055f41200c06fd3ebb99c12b` | Undo, entry correction and history. |
| `archive/vigilant-brown-kqro5t-2026-10-01`<br>`claude/vigilant-brown-kqro5t` | `850a27e9de8d3557acad89d5deed656e060ce0e8` | Habit forms, schedule and cut-down classification. |
| `ci-results` | `2f226add49f5427bef2e9049c83705e34f7bc7c9` | CI result artifacts; excluded from production analytics. |
| `claude/eloquent-turing-oznzs3` | `06ddb4cc8e62512b8760e2b5236dd6ff78eb4906` | Explicitly superseded by onboarding-and-help; do not merge as another feature. |
| `claude/free-plan-data-safety` | `3f9438c52c5ad7bafc8265effd41c9d028386302` | Latest free-plan backup/account design and setup backlog. |
| `claude/gracious-newton-exo5ow` | `e2d7409e8d52926e3e2f5a9cac353dc5a2cdad95` | Often Enough branding/bundle identifiers; avoid splitting dashboards by old app name. |
| `claude/integration-check-b` | `c47a1c410270cf60f054c23d8929077a28a34978` | Chart performance investigation; no new customer feature. |
| `claude/pensive-bardeen-ou4hiw` | `d57034f3a12bcb5f2dc409ae95f7276c5bf2d064` | Earlier backup research; superseded where the newer experience differs. |
| `claude/perf-bisect-habit-page` | `1fba6f709b022da16ecdf264f09e1c0c0d3995fd` | Scratch performance bisect; exclude test-driver activity. |
| `claude/server-and-sync` | `caa8a4f50104a89ffd66edca531e408c4525d771` | Server, sync, optional accounts, verified entitlements and checked core restore. |
| `codex/iphone-widgets` | `ce505f7c31929efd518a2b5711fd28ad03e89b70` | Current iPhone widget families, action persistence and test evidence. |
| `integration` | `695d3c95c264912ba455d4b78cb3e41740534e2c` | Integration of progress/sidebar/undo/animations plus current speed rules. |
| `main` | `993c2086f08367d4c5d879a31791804eb75e48fd` | Main baseline; not the complete merged feature set. |
| `onboarding-and-help` | `ddedb0a75e8819971107cb150d4b1e5a86bb9891` | Welcome flow, Help, About and onboarding native tests. |

## Appendix B. Sources

Repository links below are pinned to the audited branch tips where feature state differs:

- [Integration source](https://github.com/lalithsaicharan00/store-reviews/tree/695d3c95c264912ba455d4b78cb3e41740534e2c/iOS/Habits), especially Model/Habit.swift, HabitStore.swift, Menu/MenuModel.swift and Progress.
- [Privacy and Account Deletion](https://github.com/lalithsaicharan00/store-reviews/blob/caa8a4f50104a89ffd66edca531e408c4525d771/Architecture/09.%20Privacy%20and%20Account%20Deletion.md), consent/identity, providers and retention.
- [Release Safety and Operations](https://github.com/lalithsaicharan00/store-reviews/blob/caa8a4f50104a89ffd66edca531e408c4525d771/Architecture/08.%20Release%20Safety%20and%20Operations.md), crash provider and rollout criteria.
- [Server, Sync and Launch status](https://github.com/lalithsaicharan00/store-reviews/blob/caa8a4f50104a89ffd66edca531e408c4525d771/Architecture/Server%2C%20Sync%20and%20Launch%20%E2%80%94%20Status.md), current built/pending boundary.
- [Latest Backup, Sync and Accounts experience](https://github.com/lalithsaicharan00/store-reviews/blob/caa8a4f50104a89ffd66edca531e408c4525d771/Research/Research%20Reports/Data%2C%20Sync%20and%20Accounts/Backup%2C%20Sync%20and%20Accounts%20%E2%80%94%20One%20Seamless%20Experience.md), optional accounts and primary/secondary backup design.
- [Onboarding and Help checklist](https://github.com/lalithsaicharan00/store-reviews/blob/ddedb0a75e8819971107cb150d4b1e5a86bb9891/iOS/Docs/Checklists/Onboarding%20and%20Help.md).
- [iPhone widget implementation and evidence](https://github.com/lalithsaicharan00/store-reviews/blob/ce505f7c31929efd518a2b5711fd28ad03e89b70/iOS/Docs/iPhone%20Widgets.md).
- [PostHog iOS configuration](https://github.com/PostHog/posthog.com/blob/a0881efede3e1434713807318edb4344543f6e75/contents/docs/libraries/ios/configuration.mdx), inspected SDK defaults and sanitization controls.
- [PostHog web configuration](https://github.com/PostHog/posthog.com/blob/a0881efede3e1434713807318edb4344543f6e75/contents/docs/libraries/js/config.mdx).
- [PostHog free-tier pricing source](https://github.com/PostHog/posthog.com/blob/a0881efede3e1434713807318edb4344543f6e75/src/components/Pricing/Test/freeTierData.tsx) and [Product Analytics pricing](https://posthog.com/docs/product-analytics/pricing), monthly 1M public allowance and event-based billing.
- [PostHog billing limits](https://posthog.com/docs/billing/limits-alerts) and [billing questions](https://posthog.com/docs/billing/common-questions), limits and permanent data loss beyond the limit; official repository versions inspected.
- [PostHog iOS error-tracking limitations](https://github.com/PostHog/posthog.com/blob/a0881efede3e1434713807318edb4344543f6e75/contents/docs/error-tracking/installation/ios.mdx).
- [Apple: Widgets on iPad](https://support.apple.com/guide/ipad/add-edit-and-remove-widgets-ipadcfe2bfb9/ipados) and [WidgetKit platform guidance](https://developer.apple.com/documentation/widgetkit): platform references for later implementation, not evidence that this app supports iPad. These Apple pages were not retrieved in this restricted session.


## Historical implementation audit — 1 October 2026 (before eff1e14 consolidation)

The pinned feature-branch audit above is historical, not a claim those branches are consolidated. Analytics merges only `integration`, currently through `173f4f51eab20359a0bd01396b0ffe00d8cba590`. Current app has durable tasks/habits, all six habit subtypes including quit/cut-down, corrections, timers, routines, Progress/charts, notes, reminders, settings, local CSV/backup/merge restore and a disabled Plus page. It has no consolidated onboarding, account/sync/cloud-backup, verified StoreKit purchase/restore or Home/Lock Screen widget targets. The passive timer Live Activity exists, but has no action callbacks or conventional configurable Home/Lock widgets; it emits no render/impression telemetry. Those adapters must follow their owners' eventual implementations. Shared enums reserve future platform semantics; iPhone is the only analytics adapter.

The iPhone implementation now enforces optional consent, synchronous revocation and purge, random unlinked installation identity, independent backup-excluded state, scalar property allowlists at capture and wire boundaries, stable whole-installation sampling, operation guards, daily UTC envelopes, bounded retries/retention/queues and explicit daily event caps. Durable creation/tracking/correction callbacks follow successful persistence. Imports/restores do not emit creation or tracking. Estimated screen attention uses an independent monotonic idle cap; no timer clock or observable telemetry state invalidates the main screen. Configuration distinguishes saved choices from defaults and reports missing feature capabilities. Baseline activation provenance stays unknown; onboarding funnel conversion and exact person retention are not claimed.

Successful provider reads verified EU Default project 290602, the owner's sole production project. Actual 30-day events query returned no data; current month project ingestion is zero. Owner confirms free plan/no billing configured; published allowance remains 1M analytics events/month, with 700k planning ceiling. Actual organization allowance, billing usage and spend-limit enforcement remain unverified because the connector lacks billing:read. No paid services were enabled. A single project is used per the owner's direction; debug/CI/beta delivery is excluded rather than assigning an unavailable second project.

Confirmed project updates disabled autocapture, exception autocapture, web vitals, console logs, performance capture, replay, surveys, heatmaps and dead-click capture; IP anonymization is enabled. The app uses explicit EU HTTP batches without initializing an SDK. No Sentry or other crash collector is active in consolidated code, so crash coverage and symbolication remain unverified. Separate crash consent is disabled; this implementation adds no duplicate collector.

Prepared [Adoption & Attention](https://eu.posthog.com/project/290602/dashboard/989702) and [Flows, Reliability & Coverage](https://eu.posthog.com/project/290602/dashboard/989704) dashboards. All eleven saved SQL insights were executed successfully, with empty/null outcomes and zero project ingestion; this validates query execution, not real production delivery. Queries deduplicate record IDs, use collection periods, avoid account/person joins, disclose consent/sampling/coverage and retain unknown denominators. Source definitions and identifiers are in `iOS/Docs/Analytics Dashboards.json`; metrics are labelled noncanonical because catalog access is unavailable. The existing starter dashboard is preserved.

Real EU ingestion is blocked by this execution environment (HTTP CONNECT 403) and no connector capture tool exists. Production sending therefore stays gated off until a consented release-device upload, provider payload/profile/geoip inspection and retry deduplication verification occur on an authorized network. Payload serialization, deterministic offline/retry tests and empty dashboards must not be described as provider acceptance. No release or App Store privacy submission is authorized by this task.

Current testing and PR progress are maintained in [Analytics Implementation](../../../../iOS/Docs/Checklists/Analytics%20Implementation.md) and the root analytics handoff. Native contract and core storage/migration checks passed in macOS run 36893196823; app build exposed a Privacy Section initializer error, corrected subsequently. Run 36895905756 exposed nondeterministic JSON key order on retries, corrected with sorted serialization. Both failures are diagnostic evidence, not completion. Targeted macOS UI and performance validation remain in progress.

Provider follow-up at 17:35 UTC: the authorized GitHub macOS integration test reached EU ingestion. Actual PostHog queries verified two development-labelled synthetic creation/daily-feature records, sent twice with stable UUIDs, retained one physical row per record. Both are propertyless with profile processing and geoip disabled; complete stored property bags contain only allowlisted fields and no user content, account IDs, IP/location or automatic SDK metadata. Production cohort remains empty. Thus local network denial is no longer a provider acceptance blocker. Billing/spend-cap remains API-unverified; stored rows after deduplication are not authoritative ingress or billable usage. Native UI/performance acceptance and release configuration remain in progress.

### Consolidated app refresh — 2 October 2026, 00:04 IST (18:34 UTC Oct 1)

`integration` eff1e14 landed actual onboarding, Help/About, iPhone Home/Lock widgets and Often Enough IDs; analytics merged only that consolidated base (df73109). Previous absence claims describe the dated earlier audit. Adapters now cover optional welcome consent access, observed once-per-step first-run/replay events, durable suggestion creation and activation provenance, content-free Help actions, durable widget logging/retries, app deep links, consent-mirrored bounded extension paging, kind/family inventory and snapshot-publication reliability. Placement/impressions/selected configurations remain unobservable or intentionally excluded. Configuration reports widget privacy/default source and capability-set v2. Accounts, sync, verified StoreKit purchases and crash SDKs still have not landed; no future-platform coverage is claimed.

Daily coverage v2 explicitly zero-fills only the working adapter registry. Missing reserved counters remain unknown, and adoption dashboards exclude prior coverage versions. All events share a stable installation sampling cohort. Inventories are change-triggered and persistently limited to once/day; paging mailboxes are discarded on opt-out, drain at most once and drop old-day counts. No habit content, business identifiers or account linkage enters either transport or relay. Both native targets include conservative privacy manifests.

Three new saved provider insights are 6270561 (observed onboarding steps/endings), 6270562 (seven-day outcomes among observed first-run installations), and 6270563 (latest successful kind/family inventory; placement unknown). Their queries executed successfully with empty production results before saving. Four coverage-v2 updates remain labelled pending until provider calls confirm execution/update; an automatic approval usage-limit failure blocked earlier validation attempts, not an unsafe-action determination. No generic scheduling reminder or duplicate coding run was substituted for unsupported same-chat continuation.

Native run 36899451178 passed 71 contract checks, core storage/migrations, app build and all nine targeted UI tests. Consent-on performance missed targets (39.1ms/s scroll, 251.5ms/s taps, 79.4ms/s typing), with scheduler work prominent; do not infer a causal telemetry regression without the same-run baseline. Consolidated builds 36903471716/36904494091 passed expanded native/provider checks but exposed an initializer-scope provenance compile error; fixed in 48cd1e9. Current 36907293697 validates merged app/widget/onboarding code and compares same-build consent off/on. No release or merge is authorized.

Provider follow-up at 00:30 IST Oct 2: all fourteen saved queries executed successfully in both refreshed dashboards. Coverage-v2 adoption/screen queries now use single event scans after the larger UNION form exceeded provider query resources. Notes and layouts disclose actual widget/onboarding coverage, post-consent bias, incomplete delivery and noncanonical catalog status. The monthly stored-row signal is eight synthetic development records; production remains empty, and stored deduplicated rows are not billing usage. Final code 6634a28 adds timed duration cut-down classification, frozen open-period metadata and engine-level relay revocation/fail-closed backup exclusion. Native intermediate build/UI passed; same-build baseline measurement failed and final tagged validation is pending.

Native follow-up at 01:05 IST Oct 2: run36911212496 fully passed 88 contract checks, Core, Debug app/widget build, all14 targeted UI tests, provider smoke and five valid off/on windows. Same-build scroll15.9→17.2ms/s, taps47.0→31.1, typing31.2→36.6, widget log0.6→1.0 and guide2.6→8.5. Global speed targets remain unmet in both modes; no causal or physical-device acceptance claim. Exact machine-readable evidence is saved in the iOS docs. Production remains gated false while Release-policy and final reliability-contract validations finish.


Final review at 01:17 IST Oct 2: reliability terminal callbacks deduplicate per operation/subsystem; sampling policy changes start together for flows and summaries at the next UTC period; widget drain counts are returned only after successful durable removal. Tests exercise duplicate/conflicting callbacks, sampling reductions/expansions after upgrade and disk-full relay clear/retry. Full Release-policy run36911869018 passed Debug and Release simulator app/widget builds. Latest focused af72c61 native/Core/both-build validation remains pending. Actual provider now contains 12 deduplicated synthetic development rows and no production rows; person-list is empty. No billing/analytics-retention API verification, real-user population or physical-device acceptance is invented.
