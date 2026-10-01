# iPhone widgets — research, implementation and acceptance plan

Written by Codex, 1 October 2026.

This report turns the existing review research into an implementation plan for **iPhone Home Screen and Lock Screen widgets**. It covers habits, quit habits, cut-down limits and unlimited tasks. Work lives on `codex/iphone-widgets`, based on Integration commit `d8645036bb3c65ebd8f207f1c2023f0afbd579f2`. It does not implement purchases, account sign-in, Android, Apple Watch or iPad layouts.

## 1. What was researched, and what the evidence can establish

The main source is [Home Screen Cards and Widgets](<Home Screen Cards and Widgets.md>), especially sections 6–9. That study reports **7,844 reviews read, 7,818 widget-coded reviews, across 151 apps**, including both stores and multiple languages. Its topic counts overlap; do not add them to obtain a population. These are review-corpus associations, not a representative survey, usability study, conversion experiment or causal estimate.

Also reviewed: the existing **Widgets — Tick Without Opening the App**, **Free Plan Design — Habit Cap, Widgets and an Honest Listing**, **Tasks in the Free Plan — Limit, Count or Plus**, Architecture/07 Other Surfaces, the store's historical-rule and day-boundary behavior, and the performance/design rules. The existing prototype report is useful for requirements, but its old implementation has no demonstrated phone validation and is not present in Integration.

For this implementation, **43 cited iPhone primary review records were reopened and read**, preserved with source app number, zero-based record index, review ID, stars, country, date and original text in [the evidence file](<iPhone Widget Evidence/primary_reviews.json>). Some of those records concern readability or progress generally. They are a targeted verification set, not a new exhaustive widget coding exercise. The original whole-corpus coding is reused with attribution, not claimed as new work. Raw review files remain unchanged.

Public Apple web documentation cannot be fetched from this session's restricted network. API availability, build behavior and runtime checks will therefore be checked against the Xcode SDK on GitHub's macOS runner. Relevant references for a reviewer: [interactive widgets](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities), [timelines](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date), [accessory families](https://developer.apple.com/documentation/widgetkit/widgetfamily), and [App Groups](https://developer.apple.com/documentation/xcode/configuring-app-groups). These links are references, not a claim that their current contents were retrieved here.

## 2. What people value

| Need | Prior study findings | Consequence |
|---|---|---|
| Glanceable presence | 788 visibility mentions; 4.78★ | Show the person's data immediately, without promotional chrome. |
| One-tap tracking | 1,100 interactive mentions, including 496 requests and 324 praise | Checks and saved increments work in place; opening the app is reserved for input that needs a screen. |
| One overview | 426 all-habit-list requests in 56 apps; 65 single-tile clutter complaints | A free agenda is the default recommendation; a person need not install five separate tiles. |
| Individual tiles | 82 praise; 44 single-habit praise mentions | Support a selected habit or task with its name and real amount. |
| History | 61 week-grid praise and 54 requests; 76 calendar praise and 107 requests | Optional week/month history, separate from the daily action surface. |
| Quit counters | 159 counter mentions; 175 streak mentions | Show time since the latest slip/start, without making reset an easy action. |
| Lock Screen | 73 praise and 100 requests | Provide inline, circular and rectangular accessory families. |
| Task visibility | 87 to-do requests | Tasks appear in the agenda and can be selected individually; no habit cap applies to tasks. |

Examples from the reopened primary records: `11412519740` asks for interactive widgets; `11393534582` praises their arrival; `10074496489` values several counters on one page; `7824788952` welcomes restoration of the 12-task medium layout; `8626356287` asks for words on icons; `13733717410` praises the history grid. Read their full wording in the evidence file. Those are examples, not independent count estimates.

## 3. Complaints and explicit responses

| Complaint | Evidence / scope | Required behavior and acceptance case |
|---|---|---|
| Blank, stuck or unsynchronised | 957 broken +315 stale; union 1,226 (15.7%, 80 apps, 3.27★); `3342943112`, `6463354814` | Atomic, versioned snapshots; refresh after durable changes; missing/corrupt/expired data gives an honest Open App state, never a fabricated empty success. W01–W04. |
| Wrong day unless app reopened | Existing widget study and architecture | Precomputed logical-day timelines using Calendar wall-clock boundaries, custom day start, DST and timezone invalidation. Reject old-day buttons. W05–W08. |
| Widget says undone after saved check | `6463354814`; prior sync study | Same database and historical rules as Today; action waits for commit and snapshot publication before returning. W09–W12. |
| One tap completes a repeated goal | Existing widget report | Each check contributes exactly one tick, amount uses the saved increment, never “complete remaining goal”. W13. |
| Done items remain crowded | `11522568446`; prior study: hide done 63, keep done 20 | Agenda defaults to remaining work with a visible total; configuration can show completed items. Limits and quit counters are separate ongoing check-ins. W14. |
| Weekly habits appear every day as unfinished | 80 today-only mentions, including 21 weekly complaints | Use existing scheduling and day satisfaction; no invented daily failure for a weekly target. W15. |
| Lost layouts during redesign | 302 mentions | Stable widget kinds/configuration; no removal of list, labels, numerical increments or families. W16. |
| Too large / too sparse / list cut off | 312 size mentions; 22 cut-off-list complaints | Appropriate density by family, explicit pagination and Open Today route. Native widgets cannot scroll. Unlimited means all tasks remain reachable, not infinite rows in finite space. W17–W19. |
| Icon ambiguity and small type | `8626356287`, `13902720788`; 28 label mentions | Names on home tiles; full VoiceOver label/value/action. Circular lock widgets open to details when space cannot carry a name. W20. |
| Dark/tinted/clear mode invisibility | `11751917371`, `13256010922`; prior iOS26 complaints | System foreground/material and accented-mode-aware views; no dependence on color alone; screenshot each family in light/dark/tint, larger text. W21–W23. |
| Destructive accidental reset | 36 accidental-tap mentions; `11989500206` | No reset, slip, delete, undo-all or historical toggle on a widget. Quit tile is read-only; open the existing slip form. W24. |
| Basic widget sold after being free | 342 paywall mentions, 41 apps, 2.48★; prior free-plan report 25 basic-widget complaints, 1.72★ | Basic agenda, individual tile and all Lock Screen families stay free; Plus adds layouts/history. No trial takeover, purchase pop-up on logging, or second habit cap. W25–W27. |
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
3. Publish only after storage has loaded successfully and queued writes have completed. Serialize/coalesce publication and atomic replacement; do not overwrite a good snapshot with an empty database-open failure. Bound retained history/outlook, never serialize the whole log corpus on each tick.
4. Precompute future logical-day frames and dated timeline entries. Day boundaries use the store's calendar and day-start wall-clock setting, including DST. Once outlook expires, show Open App instead of claiming current information. WidgetKit controls refresh timing; exact refresh at midnight cannot be guaranteed by an app.
5. Interactive logging uses `LiveActivityIntent` in both targets to execute in the app process. It calls the normal serialized write path, validates current ID/day/configuration, uses a stable rendered action UUID for database idempotency (including deleted-entry tombstones), commits first, then publishes and reloads affected timelines. No extension-owned write journal or undurable “success”.
6. A fresh published action gets a new token, so deliberate further amount increments work. Replayed callbacks cannot double-log. Validation occurs inside the write queue, protecting concurrent app/reminder/widget callbacks. Non-additive operations open the app with a URL containing item ID; invalid IDs safely fall back to Today.
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

Research and branch creation complete. Implementation and macOS validation pending. This section will be replaced with actual results, workflow URLs, tested simulator/SDK, and honest remaining limitations before handoff.
