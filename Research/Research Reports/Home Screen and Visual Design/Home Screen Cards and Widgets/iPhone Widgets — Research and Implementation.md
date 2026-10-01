# iPhone widgets — research, implementation and acceptance plan

Written by Codex, 1 October 2026.

This report turns the existing review research into an implementation plan for **iPhone Home Screen and Lock Screen widgets**. It covers habits, quit habits, cut-down limits and unlimited tasks. Work lives on `codex/iphone-widgets`, based on Integration commit `d8645036bb3c65ebd8f207f1c2023f0afbd579f2`. It does not implement purchases, account sign-in, Android, Apple Watch or iPad layouts.

## 1. What was researched, and what the evidence can establish

The main source is [Home Screen Cards and Widgets](<Home Screen Cards and Widgets.md>), especially sections 6–9. That study reports **7,844 reviews read, 7,818 widget-coded reviews, across 151 apps**, including both stores and multiple languages, covering November 2011–September 2026. Unless explicitly marked as the separate free-plan study, percentages use the 7,818 coded widget reviews. Signals below are praise, requests or complaints as labelled; topics and subtopics overlap; do not add them to obtain a population. These are review-corpus associations, not a representative survey, usability study, conversion experiment or causal estimate.

Also reviewed: the existing **Widgets — Tick Without Opening the App**, **Free Plan Design — Habit Cap, Widgets and an Honest Listing**, **Tasks in the Free Plan — Limit, Count or Plus**, Architecture/07 Other Surfaces, the store's historical-rule and day-boundary behavior, and the performance/design rules. The existing prototype report is useful for requirements, but its old implementation has no demonstrated phone validation and is not present in Integration.

For this implementation, **43 cited iPhone primary review records were reopened and read**, preserved with source app number, zero-based record index, review ID, stars, country, date and original text in [the evidence file](<iPhone Widget Evidence/primary_reviews.json>). Some of those records concern readability or progress generally. They are a targeted verification set, not a new exhaustive widget coding exercise. The original whole-corpus coding is reused with attribution, not claimed as new work. Raw review files remain unchanged.

Public Apple web documentation cannot be fetched from this session's restricted network. API availability, build behavior and runtime checks will therefore be checked against the Xcode SDK on GitHub's macOS runner. Relevant references for a reviewer: [interactive widgets](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities), [timelines](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date), [accessory families](https://developer.apple.com/documentation/widgetkit/widgetfamily), and [App Groups](https://developer.apple.com/documentation/xcode/configuring-app-groups). These links are references, not a claim that their current contents were retrieved here.

The feature-ledger mapping is [C009: basic widgets free](<../../Feature Ledger.md#c009>), [C023: interactive check-off](<../../Feature Ledger.md#c023>), [C040: no blank/stale/disagreeing widgets](<../../Feature Ledger.md#c040>), [C107: extra widget variants as the paid layer](<../../Feature Ledger.md#c107>), and [C264: protect the logging path](<../../Feature Ledger.md#c264>). These support the priority order: reliable free logging first, useful Lock Screen access second, paid visual/history variants third. C107 contains purchase requests as well as completed purchases; it does not establish that a particular layout will convert.

## 2. What people value

| Need | Prior study findings | Consequence |
|---|---|---|
| Glanceable presence | 788 visibility mentions (10.1%); 4.78★ | Show the person's data immediately, without promotional chrome. |
| One-tap tracking | 1,100 interactive mentions (14.1%), including 496 requests (6.3%) and 324 praise (4.1%) | Checks and saved increments work in place; opening the app is reserved for input that needs a screen. |
| One overview | 426 all-habit-list requests (5.4%) in 56 apps; 65 single-tile clutter complaints (0.8%) | A free agenda is the default recommendation; a person need not install five separate tiles. |
| Individual tiles | 82 check-tile praise (1.0%); 44 single-habit praise mentions (0.6%) | Support a selected habit or task with its name and real amount. |
| History | 61 week-grid praise (0.8%) and 54 requests (0.7%); 76 calendar praise (1.0%) and 107 requests (1.4%) | Optional week/month history, separate from the daily action surface. |
| Counters and quit support | 61 counter-praise reviews (0.8%, including 48 for Days Since); 159 count mentions (2.0%) concern widget numbers generally | Show real amounts; for quit items show time since the latest slip/start, with no reset shortcut. The 159 count mentions are not a quit-only demand estimate. |
| Lock Screen | 73 praise (0.9%) and 100 requests (1.3%) | Provide inline, circular and rectangular accessory families. |
| Task visibility | 87 to-do requests (1.1%) | Tasks appear in the agenda and can be selected individually; no habit cap applies to tasks. |

These quantified rows summarize the earlier whole-corpus coding; its §6 and §9 provide the full source references and review map. The implementation's reopened iPhone records provide concrete examples, rather than new population counts.

Examples from the reopened primary records: `11412519740` asks for interactive widgets; `11393534582` praises their arrival; `10074496489` values several counters on one page; `7824788952` welcomes restoration of the 12-task medium layout; `8626356287` asks for words on icons; `13733717410` praises the history grid. Read their full wording in the evidence file. Those are examples, not independent count estimates.

## 3. Complaints and explicit responses

| Complaint | Evidence / scope | Required behavior and acceptance case |
|---|---|---|
| Blank, stuck or unsynchronised | 957 broken +315 stale; union 1,226 (15.7%, 80 apps, 3.27★); `3342943112`, `6463354814` | Atomic, versioned snapshots; refresh after durable changes; missing/corrupt/expired data gives an honest Open App state, never a fabricated empty success. W01–W04. |
| Wrong day unless app reopened | Existing widget study and architecture | Precomputed logical-day timelines using Calendar wall-clock boundaries, custom day start, DST and timezone invalidation. Reject old-day buttons. W05–W08. |
| Widget says undone after saved check | `6463354814`; prior sync study | Same database and historical rules as Today; action waits for commit and snapshot publication before returning. W09–W12. |
| One tap completes a repeated goal | Existing widget report | Each check contributes exactly one tick, amount uses the saved increment, never “complete remaining goal”. W13. |
| Done items remain crowded | `11522568446`; prior study: hide done 63 (0.8%), keep done 20 (0.3%) | Agenda defaults to remaining work with a visible total; configuration can show completed items. Limits and quit counters are separate ongoing check-ins. W14. |
| Weekly habits appear every day as unfinished | 80 today-only mentions (1.0%), including 21 weekly complaints (0.3%) | Use existing scheduling and day satisfaction; no invented daily failure for a weekly target. W15. |
| Lost layouts during redesign | 302 redesign complaints (3.9%) | Stable widget kinds/configuration; no removal of list, labels, numerical increments or families. W16. |
| Too large / too sparse / list cut off | 312 size mentions (4.0%); 22 cut-off-list complaints (0.3%) | Appropriate density by family, explicit pagination and Open Today route. Native widgets cannot scroll. Unlimited means all tasks remain reachable, not infinite rows in finite space. W17–W19. |
| Icon ambiguity and small type | `8626356287`, `13902720788`; 28 label requests (0.4%) | Names on home tiles; full VoiceOver label/value/action. Circular lock widgets open to details when space cannot carry a name. W20. |
| Dark/tinted/clear mode invisibility | `11751917371`, `13256010922`; prior iOS26 complaints | System foreground/material and accented-mode-aware views; no dependence on color alone; screenshot each family in light/dark/tint, larger text. W21–W23. |
| Destructive accidental reset | 36 accidental-tap mentions (0.5%); `11989500206` | No reset, slip, delete, undo-all or historical toggle on a widget. Quit tile is read-only; open the existing slip form. W24. |
| Basic widget sold after being free | 342 paywall mentions (4.4%), 41 apps, 2.48★; prior free-plan report 25 basic-widget complaints, 1.72★ | Basic agenda, individual tile and all Lock Screen families stay free; Plus adds layouts/history. No trial takeover, purchase pop-up on logging, or second habit cap. W25–W27. |
| Percentages obscure actual progress | `5698098227` | Show 3/8 glasses, remaining task count, or time since slip; tasks never get streaks or habit statistics. W28. |

Zero complaints cannot be promised. These choices address known failure modes; accessibility, physical-device testing and post-release feedback remain necessary.

## 4. Widget catalogue and free/Plus boundary

| Widget kind | Families | Free behavior | Plus behavior |
|---|---|---|---|
| Today agenda | Small, medium, large home | Small summary; medium/large named actionable list, all five available habits and unlimited tasks; next/previous page; include-completed option | Same complete core. No logging restriction. |
| One item | Small home; inline/circular/rectangular lock | Select any active habit or task; check/+saved step when supported; read-only quit counter; open detailed logging for duration/checklist/manual amount | Same complete core. |
| Today on Lock Screen | Inline/circular/rectangular | Remaining task/habit summary, opens Today | Same complete core. |
| Icons | Medium/large home | A clearly labelled free agenda fallback if a saved premium configuration loses entitlement | Compact labelled icon grid with direct checks/increments. |
| History | Small/medium/large home | A useful selected-item status fallback when entitlement unavailable | Selected habit's recent week or month marks, real day values; task selection never invents habit statistics. |

Habits, quit habits and cut-down habits share the existing **five active habits** free allowance. Widgets impose no extra per-widget-count restriction. Tasks, including repeating tasks, are unlimited. Existing excess habits after Plus expiry must not be silently deleted or hidden: the current store remains the source of visibility; creation/unarchive limits belong to the existing plan policy. A selected unavailable/deleted item says to choose another; never substitutes a different habit without saying so.

Upgrade discovery belongs in a calm **Widgets** guide in the menu: show which layouts are Plus and how to add a widget, with the existing Plus destination. Widget logging never opens a paywall. An installed premium widget falls back to free functionality on entitlement loss and recovers its layout when Plus returns. There is no StoreKit integration in this branch. Entitlement comes through the store's `isPlus`, which currently is a debug switch/false in release; the account/purchase agent must wire its durable verified entitlement into the same publisher. Simulated Plus checks are not proof of purchases or restore.

The parallel `claude/server-and-sync` branch was rechecked at `7a2f9d3728e42190783c0ceec859f0502495f5a2`. Its status document records Cloudflare accounts, phone/server sync, **server-side** App Store signed-transaction verification and refund/revoke handling, plus a StoreKit test configuration. The phone's buy/restore client, verified ownership checks and sign-in UI are still pending. Those changes remain on that branch. Preserve the store publication hook when merging sync and connect the verified entitlement to `isPlus`; test purchase/restore/refund effects on installed widgets after the purchase client is integrated. The [integration and physical-device checklist](<../../../../iOS/Docs/iPhone Widgets.md>) spells out these contracts.

## 5. Semantics by item type

- **Check habit:** one additive tick. A checked daily habit stays checked; a repeat count adds one, not the whole remaining goal. Never toggle off from a widget.
- **Amount habit:** add the saved positive finite increment. Without one, open the normal amount screen. Show actual amount and unit. Do not change the saved goal.
- **Duration:** open the existing timer/manual time workflow. Widgets are not continuous polling timers; a running timer's existing Live Activity remains available.
- **Checklist:** show completed/total steps, open the existing day controls. Never pretend one tap completes all steps.
- **Quit:** show time since the latest slip or start; opening leads to the habit's existing history and slip controls. No widget reset/slip button.
- **Cut down:** show logged amount relative to the limit; + records consumption. “Within limit so far” is not final success while the day/period is open. Never hide it merely because the numerical limit is reached.
- **Task:** additive completion for the scheduled occurrence, same date/repeat-after-completion rules as the app. No task streak, heatmap success score or free habit slot consumption.
- **Pause, skip, archive, future start, removed item:** honor the store's current rules. An old action may not revive one. Historical displays read `rule(habit,on:day)`.

## 6. Architecture and recovery

1. Reuse the existing embedded WidgetKit extension alongside the timer Live Activity. Keep the SQLite database in the private app container. App Group contains only a disposable, versioned **snapshot JSON**, not a second database or notes/accounts/secrets.
2. Compile shared Codable models, provider, configuration intents and views into app and extension. Mark cross-process value types nonisolated/Sendable; extension never imports the Kotlin framework.
3. Publish only after storage has loaded successfully and queued writes have completed. Serialize/coalesce publication with monotonic ordering and atomic replacement; recheck privacy after asynchronous preparation and before writing; do not overwrite a good snapshot with an empty database-open failure. Bound retained history/outlook, retain all 31 history marks in each precomputed day, cache each item until its inputs change (timer changes invalidate only that timer), yield between dirty items, and encode/write off the UI actor. Never serialize the whole log corpus on each tick.
4. Precompute future logical-day frames and dated timeline entries. Day boundaries use the store's calendar and day-start wall-clock setting, including DST. Once an actionable agenda outlook expires, show Open App instead of claiming current information. A selected quit counter can continue from its known start using the system clock, up to the next known pause/end: that elapsed-time fact needs no daily app opening. WidgetKit controls refresh timing; exact refresh at midnight cannot be guaranteed by an app.
5. Interactive logging uses `LiveActivityIntent` in both targets to execute in the app process. It calls the normal serialized write path, validates current ID/day/configuration, uses a stable rendered action UUID for database idempotency (including deleted-entry tombstones), commits first, then publishes and reloads affected timelines. No extension-owned write journal or undurable “success”.
6. A changed item receives fresh rendered-event tokens, so further amount increments work after refresh; unrelated cached projections retain their tokens. Replayed callbacks cannot double-log. Validation occurs inside the write queue, protecting concurrent app/reminder/widget callbacks. Non-additive operations open the app with a URL containing item ID; invalid IDs safely fall back to Today.
7. Pagination is disposable shared display state. It never changes logs. Clamp pages after deletion/completion and bound decoding/reads. Concurrent extension writes require coordination.
8. Respect privacy: do not publish notes or descriptions; offer a widget privacy setting that hides sensitive content and disables widget logging. App Face ID does not by itself hide an already-installed widget. Before first unlock protected snapshot reads return a safe locked/unavailable view. Restoring availability refreshes snapshots.
9. Refresh after edits, archive/delete/restore, undo, backup import, entitlement changes, significant-time changes and foreground/background transitions. Write failure is shown as failure, with a retry/open route; no false checkmark survives it.

App Group chosen for the shared surface is `group.com.oftenenough.app`, matching the parallel branding branch's `com.oftenenough.app` bundle direction. Both targets require the same App Group entitlement and Apple portal provisioning before real-device distribution. Unsigned simulator compilation cannot prove provisioning. This branch must document the setting and avoid taking over the other agent's account/database code.

## 7. Step-by-step implementation

1. Preserve evidence, publish this report and user checklist before code changes.
2. Add shared snapshot/date/configuration models and deterministic validation tests.
3. Add app snapshot derivation using the existing schedule/progress/quit-history methods, then atomic shared publishing.
4. Add additive durable widget actions and routing; test repeated, concurrent, stale, failed and cold-launch actions.
5. Add agenda, individual, lock, icon and history layouts. Preserve the existing Live Activity.
6. Add widget guide/privacy controls and Plus fallback behavior; keep account/purchase changes outside this branch.
7. Build and test on macOS GitHub Actions against iPhone simulator destinations. Archive test results, screenshots and logs. Fix failures, rerunning relevant failed checks; run appropriate store/performance regressions.
8. Update this report with exact results and remaining physical-device checks. Do not label SpringBoard or Lock Screen end-to-end validated unless the actual system-hosted widget is installed and exercised.

## 8. Acceptance matrix

| IDs | Cases |
|---|---|
| W01–W04 | Empty/new install; valid atomic round trip; truncated/unsupported/oversized snapshot; failed storage open preserves last good snapshot and displays recoverable state. |
| W05–W08 | Midnight without app UI; 04:00 custom day start; spring-forward/fall-back; travel/timezone and locale/week-start change, expired outlook. |
| W09–W12 | Check and amount save survive process restart; same rendered action twice; concurrent app/reminder/widget writes; write error and protected-data retry. |
| W13–W16 | Multiple checks/day and saved amount increments; hide/show completed; weekly/monthly targets and pauses; stable widget kinds/config restoration. |
| W17–W20 | Every home size and lock family; 0/1/5 habits, many unlimited tasks, pagination/clamping; long names/units; VoiceOver names/values/actions. |
| W21–W24 | Light/dark/tinted/clear rendering, larger text, contrast/reduce motion; quit/no destructive controls; cut-down open-period wording. |
| W25–W28 | Free five habits + unlimited tasks; simulated Plus layouts and entitlement loss/recovery; no paywall in logging; tasks have no habit stats. |
| W29–W32 | Privacy opt-out and re-enable; app route for each non-quick type; undo/archive/delete/restore/import refresh; existing timer Live Activity still builds/runs. |

Run both deterministic logic/storage checks and iPhone UI screenshot tests. Rendering inside an app test harness checks the shared views but **does not prove WidgetKit hosting, timeline delivery, app-process intent dispatch, pre-unlock behavior or Lock Screen installation**. Attempt automated system-host installation and interaction in CI; unsupported simulator/system automation must remain a specifically named unverified check. No local MacBook or physical iPhone is available to this cloud session.

## 9. Validation status

Implementation is on `codex/iphone-widgets`, with current Integration changes through `416a8f7dfe8911a4da01e78f75315cea60c75ded` preserved. Both native targets compile on **Xcode 26.6**, using an **iPhone 17 Pro / iOS 26.5** simulator on GitHub's ARM64 macOS runner. The evidence verifier checks all 43 cited records against immutable review files; the core storage/migration suite and performance source rules pass.

The earlier [71b2c06 verification run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36848752573) passed all four widget app tests and the existing two timer tests plus store correction/Undo regression. It installed the actual medium Today widget and tapped a control after terminating the app, but its persistence assertion failed. The subsequent [6c919da run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36852454114) used the production default database and still failed that assertion, so a custom-database mismatch was not established as the cause. That run passed all five app tests, including the new long-name/unit case. The [9966658 verification run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36856700854) passed all five app tests and the actual Home Screen cold-action/persistence test, with the Lock Screen case explicitly skipped. Disarming fixture reset arguments before system restarts and waiting for asynchronous widget refresh fixed the test. Its installed-widget screenshot shows the completed check removed, and a fresh process verifies the disk entry has widget provenance. A debug-only dispatch diagnostic remains available for future failures. The default-database setup is guarded against resetting a physical device's data. The Lock Screen editor was unavailable both in Settings and through the Notification Center wallpaper route; this is an explicit unverified system-host check.

The [f85cd16 verification run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36860774310) passes the real-repository storage suite, both timer UI regressions and the expanded actual Home Screen test. It checks all nine gallery sizes by their system accessibility values, installs medium Today, verifies a cold check on disk, and exercises next/previous page intents while the app stays closed. Gallery screenshots are placeholder previews; they do not establish configured live data or entitlement enforcement. Installed-widget screenshots and accessibility trees show pages changing from 1/13 to 2/13 and back. The cold DEBUG launch seeds additional demo items, so its 35 remaining items are not evidence of a fresh free-plan quota. This targeted run does not repeat the unavailable Lock Screen picker or the unchanged five app-hosted layout tests that passed at 9966658.

The final [cfa6faa verification run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36869216323) completed successfully: **four targeted native tests passed, zero failures**. It repeats the nine-preview gallery/cold check/disk provenance/paging test and both timer tests; the real-repository suite also covers publication error ordering. An earlier successful publication awaiting timeline invalidation cannot clear a newer write error. Snapshots are committed immediately; closely spaced timeline reload requests share a 250 ms delay, awaited through the surviving request so background intents retain their execution lease. The unchanged family, Plus, month, dark and long-label tests retain their 9966658 evidence; the Lock Screen host remains unverified. Logs and profiles are in the run's `ios-logs` artifact; screenshots/accessibility trees and `.xcresult` are archived separately. Screenshots/results retain seven days; logs retain 90 days. The permanent performance table below preserves the measurements after artifact expiry.

Screenshot review caught a test-quality issue in the earlier 4de01f2 run: the Plus/month/dark switches were still off despite screenshot names. Those images establish free fallback rendering only. The 71b2c06 test asserts each switch's value before screenshots; its actual Plus grid, 31-day history and dark images were inspected. Review also found a truncated compact limit caption, corrected by putting the numeric progress/limit before units. A further regression keeps all 31 history marks as each precomputed day advances, evaluates open/past states using the store's existing day rules, and tests long names/units at larger text.

### Performance records

The existing app's Integration baseline already misses its performance targets: the 3d928ad run measured Today scrolling at 33.3 ms/s with a 302 ms stall and two freezes, and Today tapping at 87.2 ms/s with a 384 ms stall and three freezes. The widget branch has not resolved those broader Today costs. At f85cd16, Today scrolling is 24.8 ms/s / 257 ms / one freeze and tapping is 106.3 ms/s / 109 ms / one freeze. At cfa6faa, scrolling is 31.0 ms/s / 287 ms / two freezes and tapping is 125.0 ms/s / 222 ms / two freezes. These remain release failures.

| Run | Widget durable log/publication: hitch / stall / freezes | Guide scroll: hitch / stall / freezes | Guide opens: first / again |
|---|---|---|---|
| [4de01f2](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36846388174), widget not yet installed | 1.6 ms/s / 22 ms / 0 | 2.5 ms/s / 54 ms / 0 | 5,124 / 213 ms |
| [71b2c06](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36848752573), installed widget | 16.3 ms/s / 40 ms / 0 | 3.7 ms/s / 56 ms / 0 | 467 / 130 ms |
| [6c919da](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36852454114), installed widget, lazy native guide | 24.6 ms/s / 51 ms / 0 | 0.0 ms/s / 0 ms / 0 | 692 / 182 ms |
| [9966658](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36856700854), installed widget, explicit publication coalesced | 26.4 ms/s / 53 ms / 0 | 0.0 ms/s / 0 ms / 0 | 521 / 155 ms |
| [f85cd16](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36860774310), installed widget, timer-only invalidation | 39.6 ms/s / 60 ms / 0 | 0.0 ms/s / 0 ms / 0 | 338 / 100 ms |
| [cfa6faa](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36869216323), installed widget, timeline requests coalesced | 11.2 ms/s / 79 ms / 0 | 0.0 ms/s / 0 ms / 0 | 432 / 162 ms |

Targets are below 5 ms/s, no freezes of 100 ms or more, and opening stalls below 100 ms. A workflow's “Speed tests: success” means metrics were collected; it does **not** establish that these budgets passed. Guide scrolling passes. Installed-widget logging hitch and guide opening remain above budget in these runs. Explicit publication now cancels the redundant delayed update queued by the same committed change; this removes duplicate work but has not brought the recorded logging hitch below budget. Profiles put widget preparation/publication at 0.9% each in the 6c919da sample; native view/navigation work also contributes. The final run records lower widget-log hitch than f85cd16, but still misses the target. The driver awaits publication before its next action, so the added reload delay also changes iteration throughput; this is not a controlled per-action speed comparison. No physical-device performance result is claimed. Performance release acceptance stays open rather than treating a green workflow as a pass.

### Coverage and remaining release checks

| Acceptance cases | Automated evidence | Still requiring system/device or merged-branch verification |
|---|---|---|
| W01–W04 | Real-repository checks, atomic App Group/temp-file round trips, corrupt/version/size/identity/token rejection, failed-open and failed-write preservation, visible publication failure | Fresh distribution-signed install and real protected-data failures |
| W05–W08 | Seven contiguous frames plus explicit expiry; future history windows; 04:00 wall-clock day start; spring/fall DST; timezone/locale mismatch; stable quit extension bounded by pause/end | WidgetKit delivery at midnight/custom boundary while UI stays closed; travel, locale/week-start changes and low power on device |
| W09–W12 | Check/amount persistence through repository reopen; replay/tombstone deduplication; queued app/widget additions; real closed-repository write failure; actual installed medium Today cold intent and fresh-process disk verification | Reminder/widget/app concurrency after the account/sync merge; reboot before first unlock |
| W13–W16 | Repeated daily ticks, saved increment, extra weekly checks, show/hide completed, pause/skip/archive/delete rejection, stable declared kinds | Every installed configuration through upgrade; broader calendar/month/flexible scheduling in the merged release |
| W17–W20 | Shared views at all supported Home/accessory sizes; all nine actual Home gallery previews; installed medium Today next/previous paging; five habits plus 24 tasks; clamped pages; larger-text and long-label fixture; names, full values and actions in accessibility metadata | Actual installation/configuration/paging of every kind and size; VoiceOver traversal and touch accuracy on device |
| W21–W24 | Light families, asserted dark history, larger text, numeric progress and compact limits; read-only quit clock, no reset/slip/delete controls | Each installed family in dark/tinted/clear styles; increased contrast, Reduce Motion and largest accessibility text |
| W25–W28 | Five-habit allowance excludes tasks; all tasks survive projection; free layouts/fallbacks and simulated Plus layouts; entitlement-loss input; no purchase guard in logging; no task history | Real buy/restore/refund/offline ownership and return to Plus after purchase client integration |
| W29–W32 | Privacy toggle, redacted frames, cancellation and concurrent-publication/privacy regression; existing URL routes; Undo, archive/delete stale-action rejection; timer regressions | Actual installed routes for every non-quick type; Face ID, restore/import/sync/account changes and pre-unlock behavior |

The complete [device release matrix](<../../../../iOS/Docs/iPhone Widgets.md#physical-iphone-release-matrix>) stays open for unrun rows. Simulator family screenshots are shared-view tests, not proof of installed Lock Screen widgets. Distribution App Group provisioning and physical locked-state interaction need the Apple account/device available to the owner.

