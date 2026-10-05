# iPhone widgets: integration and release checks

Written by Codex, 1 October 2026. Research, review IDs, the free/Plus decision and acceptance matrix are in [the widget report](<../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/iPhone Widgets — Research and Implementation.md>).

**5 October research/design follow-up:** [Start here — widget catalogue package](<../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widget Catalogue Study — 5 October 2026/README.md>) includes the detailed report, implementation handoff, two editable Figma sections, both complete boards and 26 individual renders. The newer catalogue and plan boundary are **proposals awaiting review**. This guide records the existing integration and historical checks; it does not claim the reported installed-phone picker issue or new designs are validated. Current Work item 9 remains open (W1/U9).

## Targets and shared data

The existing `HabitsLiveActivity` extension contains the timer Live Activity and five stable widget kinds. Both it and `Habits` compile `Shared/WidgetSnapshot.swift`, `WidgetIntents.swift` and `PhoneWidgets.swift`. Only the app compiles the Kotlin repository and `HabitStore+Widgets.swift`. `HABITS_APP` selects the app-process implementation of the shared `LiveActivityIntent`.

Both targets have the `group.com.oftenenough.app` entitlement. The group holds disposable `widget-snapshot-v1.json` and pagination state, with no SQLite file or account credentials. The snapshot has seven logical-day frames, a complete rolling 31-mark history in each frame, and a bounded decoder. Quit counters can continue beyond the agenda outlook up to a known pause or end. Missing, corrupt, expired, pre-unlock or mismatched time-zone/locale snapshots request an app refresh.

On a physical iPhone, register the App Group in the Apple developer portal, enable it for the app and extension identifiers, and regenerate both provisioning profiles. This branch uses Integration's existing bundle identifiers; the parallel branding branch changes them to `com.oftenenough.app`. Preserve the common App Group when merging branding. Ad-hoc simulator signing in CI checks shared-container access; it does not validate distribution provisioning.

## Account, sync and entitlement integration

`claude/server-and-sync` was checked again at `7a2f9d3728e42190783c0ceec859f0502495f5a2`. Its status document records Cloudflare accounts, phone/server sync, server-side App Store transaction verification and refund handling, plus `OftenEnough.storekit`. The phone buy/restore client, ownership checks and sign-in UI are still pending. Those changes remain on that agent's branch.

Widget publication uses the store's existing `onChange` hook after committed writes and loads. Preserve that hook when integrating sync; a successfully applied remote snapshot must finish loading before widgets publish. Failed imports or failed storage opens must leave the previous durable snapshot intact. Add a merged-branch regression for remote changes and account changes before releasing.

Set `store.isPlus` from the other branch's verified durable entitlement. Its `didSet` schedules publication, which enables or removes paid layouts without removing free tracking. Release builds currently start free; debug builds use the existing `-free` flag. A debug Plus switch proves view behavior, not purchases, restore, Family Sharing, refunds or offline entitlement caching. Test those after the purchase client is merged. Include `EntrySource.widget` in the sync codec and route widget writes through the merged repository's sync writer; the parallel branch already records a required schema-6 → 7 merge migration. Never add a purchase check to `WidgetLogIntent.perform()`.

## Logging and routing contract

Checks add one tick; amount controls add the saved finite positive increment. The queued app write validates the logical day, item, signature, pause/archive/skip state, privacy and storage availability. Event UUIDs deduplicate callbacks, including an event tombstoned by Undo. Signatures reuse the repository-precision and unordered-set normalization already used by reminder actions. Publish only after commit; surface a save/publication failure instead of returning false success.

Duration, checklist, manual amount and quit-slip input open the existing Day Sheet through `oftenenough://item/<UUID>`. Summaries and pagination footers use `oftenenough://today`. Deleted IDs safely return to Today. There is no destructive widget reset.

The Widgets guide uses native GroupBox controls inside a lazy ScrollView. Scrolling passes the measured simulator budget; opening still exceeds it in the recorded runs. Compact icon captions put progress and limit numbers first, before units that might be truncated; full status remains accessible.

Publication caches each item's bounded projection, invalidates changed items through the store's existing cache hooks, yields between dirty items, and encodes/writes off the UI actor. Monotonic publication tickets prevent an older preparation replacing a newer snapshot; privacy is rechecked after preparation and immediately before writing. Cancellation preserves the last durable snapshot. Timer changes invalidate only their own widget projection. Explicit publication cancels the delayed update queued by the same committed change, avoiding duplicate work. Numeric captions preserve the app's supported hundredths. Snapshot writes remain immediate; closely spaced timeline invalidations share a 250 ms delay, awaited through the surviving reload request so a background intent does not finish early. An older publication completion cannot clear a newer write error.

Privacy hides names and progress and disables logging. App Lock also publishes a hidden state. iOS controls how soon an already-rendered widget replaces its content, so enabling privacy is not proof of instantaneous removal from SpringBoard.

## macOS verification

**Read Rulebook T10 and the current workflow before every push or test dispatch.** Ordinary documentation commits stay untagged. Before deliberately starting tagged validation, inspect repository-wide live Actions runs/jobs, wait for another agent's queued or running tests to complete and check again; never cancel their tests. The widget cancellation tag is not a routine trigger: it requires explicit user authorization and confirmation that it cannot cancel another agent's work. The workflow's current recheck/validation options determine the scope; select them only when intentionally testing. The historical targeted workflow built the app and extension, checked immutable review evidence and core storage, then ran:

- `WidgetUITests`: real-repository logic checks, every supported family/layout through the shared-view harness, free and simulated Plus layouts, month history, dark appearance, larger text, long names/units and privacy controls. Plus/month/dark switches assert their actual selected state before screenshots.
- `WidgetSystemUITests`: checks all nine Home gallery previews, then installs medium Today and verifies a cold app-process quick action on disk and extension-side next/previous paging while the app stays closed; attempts the actual Lock Screen picker. Unsupported system accessibility is an explicit skip and remains unverified.
- Store correction/Undo and existing timer UI regressions.
- PerfDriver scrolling/tapping, durable widget logging/publication and Widgets-guide opening/scrolling, without XCTest attached to timing launches.

The final [cfa6faa macOS run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36869216323) passes all four targeted tests, with zero failures. The full five app-hosted tests passed at 9966658; actual Lock Screen hosting remains unverified. Widget logging measures 11.2 ms/s / 79 ms / zero freezes; guide scrolling 0 ms/s, but opening 432/162 ms. Logging hitch and opening fail the release budgets. The awaited reload delay changes the driver's iteration throughput, so compare these as recorded scenarios, not a controlled per-action improvement.

Keep the `.xcresult`, screenshots, system accessibility trees, build/test logs and performance records attached to the workflow. Screenshot existence alone does not establish readable layout; inspect them. Passing app-hosted views does not establish WidgetKit intent dispatch or timeline delivery.

## Physical iPhone release matrix

Record phone model, iOS version and results. Keep failed or unrun rows open.

| Surface | Required checks |
|---|---|
| Today small/medium/large | Install, configure completed/tasks-only, page through many tasks, tap check/increment, open Today; verify disk state after terminating and relaunching the app. |
| One Item small | Configure check, repeated check, amount, duration, checklist, quit, cut down, one-time/repeating task; verify additive actions and existing detail routes. |
| One Item inline/circular/rectangular | Install each accessory, check glance text/VoiceOver, tap available quick actions with phone locked and unlocked; quit never resets. |
| Today Lock inline/circular/rectangular | Install each family, verify remaining count and open-Today route without a purchase prompt. |
| Icons medium/large | Plus grid, names/status, pages/actions; entitlement loss and recovery preserve a useful free agenda. |
| History small/medium/large | Week/month marks, long names, VoiceOver date/value/state; task/quit selection does not invent habit statistics; free fallback remains useful. |
| Appearance | Light, dark, tinted and iOS 26 clear styles; largest text, VoiceOver, increased contrast and Reduce Motion. Verify no clipped essential controls or color-only status. |
| Time and lifecycle | Cross logical midnight/custom day start without opening UI; DST, travel, locale/week-start change, reboot before/after first unlock, low power, force quit, several days without opening. |
| Data and privacy | Failed save, Undo, edit/archive/delete/restore/import, sync changes, App Lock, hide/re-enable content, stale button, duplicate callback and concurrent app/reminder/widget writes. |

No paid developer account is required for the ad-hoc simulator checks. Device/distribution App Group provisioning and real App Store purchases require the appropriate Apple account and capabilities.
