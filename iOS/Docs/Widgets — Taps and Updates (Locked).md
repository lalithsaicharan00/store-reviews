# Widgets — Taps and Updates (Locked)

Written by Claude (Claude Code), 8 October 2026, at the user's request, after they checked every part on their iPhone
and said: "everything is perfect … lock it down … so that any other agent working on widgets in the future make sure
they don't disturb these things, like the responsiveness of the widgets, updating the data, all of that."

**This is locked.** Every decision below was reached by measuring on the iPhone 16 (iOS 26.6), often after an approach
that looked right in code failed on the phone. Don't change how a widget responds to a tap, how a tap is saved, how
the widgets are updated, or what a widget button does, without the user's say-so. If a change is agreed, repeat the
Home Screen checks in §6 on the iPhone and let the user try it before calling it done.

The same rules are repeated, shorter, in: [RULEBOOK.md](<../../RULEBOOK.md>) (S17, S18, U26, U28), [Design Rules —
Don't Regress](<../Design Rules — Don't Regress.md>) ("Widgets"), the code's own folder
([iOS/Shared/README.md](<../Shared/README.md>)), and comments marked **LOCKED** in each file listed in §7. If you find
one of them out of step with this page, this page is the reference; fix the other and tell the user.

Related history: Current Work items 64, 65 and 66 in the [Current Work Checklist](<Checklists/Current Work Checklist.md>);
measurements in [PERFORMANCE-LESSONS.md](<../PERFORMANCE-LESSONS.md>) L23 and L24.

---

## 1. What the user expects (their words, tidied)

- "Visually it should look instant … when I check it, immediately everything here on the card should be updated. That's
  how Reminders is working." Not only the button: the number, the bar, the row's fill and the list's "N of M done".
- "In the background the app can do whatever it wants … update the database slowly and then later sync it … but the
  data should not be lost. If they clicked something it should be registered; if they move on to the next habit and
  click, that should be registered too."
- "The data should be saved to the app and backed up … even if they use the widgets without opening the app for
  several days." A tap kept only on the phone until the app is opened is "a deal-breaking thing … a showcase".
- Repeated quick taps must keep moving forward (6 → 7 → 8), never look like an undo.
- Timers start and stop on the widget and in the Dynamic Island, without opening the app.
- Checklists ("steps"), quit habits and numbers you type open the app, straight on the right screen; a newer widget link
  replaces whatever was open, and an older one never comes back.
- After logging in the app and going straight back to the Home Screen, the widget shows it at once ("people will think
  this is a bug").
- Check habits keep their ✓, even counted several times a day or toward a week or month goal (never a +1).
- A week or month goal fills toward that week or month, as Today's row does. (The user never asked for such goals to
  stay unfilled; their point was that they have no daily goal. An earlier "no fill" rule was a misreading.)

## 2. How a tap works (the locked design)

```
Tap on a ✓ or + (only the round button takes the touch)
│
├─ iOS flips the switch at once: the whole card shows its "after one tap" version
│     (`WidgetTapCard`, a Toggle drawn as the card; both versions drawn ahead by iOS)
│
├─ WidgetTapIntent runs in the WIDGET's process (~30 ms)
│     1. WidgetDisk.applyTap: the snapshot's card becomes `item.after` (the app's own next state)
│     2. WidgetTaps.append: the tap is written to widget-taps.json in the App Group (durable)
│     3. WidgetCenter.reloadAllTimelines: other widgets showing the habit redraw too
│     4. returns .result(opensIntent: WidgetSaveIntent())
│
├─ iOS redraws the tapped widget ~0.2 s later from the changed snapshot,
│     so a quick next tap lands on the new card and moves on again
│
└─ iOS runs WidgetSaveIntent in the APP's process, in the background (~40 ms later; the app never comes to the front)
      AppModel.saveWidgetTaps: every waiting tap, oldest first, one run at a time
        → HabitStore.logFromWidget (database) → flush
        → taps removed from widget-taps.json only after they're saved
        → widgets republished from the database (`publish(hold: true)`), reminders re-planned
        → sync: the store's change asks `SyncService.scheduleSoon`, which keeps the app running in the background
          (`beginBackgroundTask`) until the server has it, 2 s after the last tap (W18)
```

The app also runs `saveWidgetTaps` when it starts (`ensureLoaded`) and every time it comes back to the front
(`HabitsApp`, scene phase active), so a tap never waits in the file for long even if the hand-over were ever skipped.

## 3. The decisions, and why

| # | Decision | Why (what was measured or found) |
|---|---|---|
| W1 | **A tap's intent runs in the widget's process** (`WidgetTapIntent`, a plain `AppIntent`), **then hands over to the app** with `OpensIntent` → `WidgetSaveIntent` (a `LiveActivityIntent`). | An intent run in the app's process (`LiveActivityIntent`) took 3.9–4.5 s to show on the Home Screen whatever our code did; the same action run in the widget's process showed in 0.7–0.8 s (≈0.55 s of that is XCUITest's own tap), measured side by side in one run. Our own reloads during that wait weren't shown. The hand-over was proven with stand-ins: 3/3 taps ran the app intent in the background ~0.03–0.12 s later; the app never came to the front. |
| W2 | **The whole card is one switch** (`WidgetTapCard`): a `Toggle` whose style draws the card "now" and "after one tap". Only the round button takes the touch (`WidgetButtonShape`); a row's body keeps a link to Day details laid over it; a Small card's body keeps `widgetURL`. | A `Button` can't change before the reload; a `Toggle` is drawn by iOS in both states ahead and flips on the touch (Apple, WWDC23 "Bring widgets to life"). With only the button as a switch, the user saw the button change and the card follow seconds later: rejected. |
| W3 | **The "after" card is the app's** (`WidgetItem.after`), worked out with the same code that draws Today (`widgetItem(..., adjust:)`). The widget never computes habit numbers (U26). A ✓'s after is the flipped day; a +'s is a chain of `HabitStore.widgetTapsAhead` (5) steps, each holding the next. | So the widget never disagrees with the app. The chain lets quick + taps keep moving on after each fast redraw. |
| W4 | **Every tap counts; saving is idempotent.** A + is saved by its own new ID (never twice); a ✓ is saved as the state it set ("check"/"uncheck", decided by `applyTap` from the card on screen), never as "flip". Taps are saved in the order made. | A + carried the drawn card's ID before, so a second tap before the redraw was dropped as a duplicate. On a ✓ switch, iOS resent the first tap's value on a quick second tap, so the app can't trust `value`. An absolute state saved twice changes nothing. |
| W5 | **`widget-taps.json` is a safety net, not the plan.** The app saves taps immediately through the hand-over; the file only covers a hand-over that never ran. Taps are removed only after `store.flush()` succeeds; a storage failure keeps them. | The user's rule: data must reach the database, sync and backup without opening the app. |
| W6 | **Nested switches don't work; don't try again.** A switch inside a switch's "after" is ignored by iOS (the outer one takes every tap), even with the outer's touch area removed. | Measured twice on the iPhone: Water showed 24 → 25 → 24 → 25. |
| W7 | **Timers: ▶ and ⏸ start and stop on the widget**, as a switch (`WidgetTimerToggleStyle`) running `WidgetTimerIntent` (app process, so the Live Activity and Dynamic Island show it). Each tap starts it if it isn't running and stops it if it is, in order. The app never opens. | The user: "time-based habits shouldn't open the app; it should immediately start the timer there itself and in the Dynamic Island." Measured: ⏸ showed 0.3 s after ▶, the clock counted, ⏸ stopped it. |
| W8 | **What opens the app, and its glyph:** a checklist ("steps") → that day's Day details, ↗; a quit habit → Record a slip, ↗; an amount with no saved step (a number to type) → the log sheet, a plain **+** (no "+1"), as Today's row. Check habits, tasks and amounts with a saved step log on the widget. | The user, 8 Oct 2026. |
| W9 | **A widget link replaces whatever the app had open**, including an earlier widget's log sheet (`TodayView.replacingPresented`: everything closes without animation, then the new screen opens 150 ms later). | iOS shows one sheet at a time: a timer left open hid a checklist's Day details, and an old log sheet came back after the newer screen closed. |
| W10 | **A timeline holds only the next 3 hours and the next day's start** (`PhoneWidgetTimeline.horizon`), entries ≥ 5 minutes apart (a running timer's fill every 5 minutes). | WidgetKit draws every entry the moment it gets a timeline: a week of entries (21 for a Medium list, ~35 ms each) cost ~0.75 s per reload. |
| W11 | **The app publishes the widgets 0.5 s after the last change, and at once when it starts to leave the screen** (scene phase inactive, and again on background); a widget tap or leaving reloads without the 250 ms merge. | With a 2 s wait, logging in the app and going straight back to the Home Screen showed the old widget: the update came after the app had left, and iOS held it back. Measured after: the widget changed within 1 s of leaving. |
| W12 | **A list's "N of M done" changes with a row's tap**: the row's "after" draws the header's count over the real one (`WidgetHeaderPatch`, `ListHeader(live: false)`), on a pill of `tertiarySystemBackground` that the real count also has. | A widget can't paint the system's own background (it measured RGB 46–51 against our 28), so a full-width cover showed a band. Only the count is redrawn, on identical pills. |
| W13 | **No `.invalidatableContent()` on widget buttons.** | Any tap dims every marked view in the widget: the Medium rows flickered. |
| W14 | **A week or month goal fills toward its period** (row and card), as Today's row. | §1; supersedes nothing the user ever said. |
| W15 | **Check habits keep their ✓** (`.add where item.type == "check"` draws a ✓ that adds one check). | Current Work 64. |
| W16 | **VoiceOver:** each card's switch is one button named for what it does ("Add 1 to Water", "Mark Meds done") with the card's state as its value; not "switch, off". | The switch would otherwise read as a toggle; tests and VoiceOver look for buttons. |
| W18 | **A tap reaches the server without the app being opened** (8 Oct 2026, the user's go-ahead; Current Work 67). The change asks for a sync (`SyncService.scheduleSoon`), which holds `beginBackgroundTask` until the server has it: 2 s after the last change in the background (a quick run of taps is one request), 3 s in front, never more than 10 s; no request when nothing is waiting; one sync at a time; no launch pull when iOS starts the app in the background. A failed sync keeps the change in the outbox and asks for a background refresh (~15 min), which syncs. **Nothing here waits in an intent:** the visual side (W1–W17) is untouched. | Measured on the iPhone: before, five widget taps with the app already started were saved but never sent (iOS suspended the app inside the 3 s wait); after, one request with all five ~2 s after the last, the app never in front; the widget still shows each + at 0.3 s (PERFORMANCE-LESSONS L25). |
| W17 | **Snapshot writes are coordinated** (`NSFileCoordinator`) in both the app (`WidgetDisk.write`) and the widget (`applyTap`). | Both write the same file within milliseconds of each other. |

### Known, accepted limits

- One widget doesn't change another on the same frame: a Small widget's tap shows in the Today list widget about half
  a second later (the tapped widget's reload, then the others').
- About five quick + taps in a row show at once before the app's redraw; any more are saved and show on the redraw.
- A done row sinks after the 1.5 s pause (U4, U13); a quick tick-then-untick can slide a row away and back.
- The header count sits on a faint pill (W12).

## 4. Measurements (iPhone 16, iOS 26.6, Debug -O)

| What | Result |
|---|---|
| App-process intent, tap → visible change (Water) | 3.97–4.45 s, app closed or not (L24) |
| Same page flip: widget process vs app process | 0.7–0.8 s vs 3.9–4.1 s (incl. ~0.55 s XCUITest tap) |
| Widget part of a tap (log) | ~30 ms; the app's save started ~40 ms later and finished ~90 ms after |
| Whole card 0.3 s after a tap | Meds "Checked" + bar; Water 6 → 7 of 8 + bar; list row "Done" + header 1 → 2 of 23 |
| Three quick + taps on Water | 24 → 25 → 26 → 27 on screen; 27 saved |
| A ✓ tapped twice fast | Done, then Not yet; saved as Not yet |
| Week-long vs short timelines (page flips) | 0.9 / 1.4 s vs 0.7–0.8 s (L23) |
| Log in the app, straight to the Home Screen | widget changed within 1 s |

## 5. Files and what each owns

| File | Owns |
|---|---|
| `iOS/Shared/WidgetTaps.swift` | `WidgetTap`, `WidgetTaps` (the waiting-taps file), `WidgetDisk.applyTap` (the card's "after" on tap) |
| `iOS/Shared/WidgetIntents.swift` | `WidgetTapIntent` (widget process), `WidgetSaveIntent` (app, background), `WidgetTimerIntent`, `WidgetPageIntent`; `WidgetLogIntent` stays for widgets drawn by older builds |
| `iOS/Shared/PhoneWidgets.swift` | `WidgetTapCard`, `WidgetCardToggleStyle`, `WidgetButtonShape`, `WidgetHeaderPatch`, `ListHeader`, `WidgetRoundFace`, `WidgetTimerToggleStyle`; timelines (`PhoneWidgetTimeline.horizon`) |
| `iOS/Shared/WidgetSnapshot.swift` | `WidgetItem.after`, `todayAmount`, `todayLevel`, `completesNext`; coordinated `WidgetDisk.write` |
| `iOS/Habits/Model/HabitStore+Widgets.swift` | `widgetItem(..., adjust:)`, `widgetTapsAhead`, the "after" chain; `WidgetPublisher` timing (0.5 s, immediate) |
| `iOS/Habits/Model/HabitStore.swift` | `logFromWidget` modes: "add", "check", "uncheck", "flip" (the last only for the older `WidgetLogIntent`) |
| `iOS/Habits/App/AppModel.swift` | `saveWidgetTaps` (in order, idempotent, removes after saving), `logFromWidget` / `timerFromWidget` queued one after another |
| `iOS/Habits/App/HabitsApp.swift` | Publishing on leaving (inactive, background); saving waiting taps on return |
| `iOS/Habits/Today/TodayView.swift` | `replacingPresented`: a widget link replaces whatever was open |
| `iOS/HabitsUITests/WidgetLatencyDeviceTests.swift` | The Home Screen checks (§6) |
| `iOS/Shared/WidgetTiming.swift` | Debug-only timing log (off unless asked for) |

## 6. Checking a change (the iPhone's Home Screen only)

The user, 8 Oct 2026: test widgets on the Home Screen first and only, then stop and let them try it; don't run other
suites before they've accepted the behaviour. `WidgetLatencyDeviceTests` runs on the person's own widgets; each test
takes back the logs it made (`-undo-widget-logs-since`, debug builds only) and changes nothing else.

| Test | Proves |
|---|---|
| `testWholeCardChangesAtOnce` | Small ✓ and + cards change entirely 0.3 s after a tap |
| `testListRowChangesAtOnce` (`WIDGET_TAP_TWICE=1` for a quick second tap) | a list row and its header count change at once; a ✓ goes back on a second tap |
| `testQuickPlusAndTimer` | quick + taps move on (24 → 25 → 26 → 27); ▶ starts and ⏸ stops a timer on the widget |
| `testWidgetFollowsTheAppAtOnce` (`APP_TAP_LABEL`) | a log in the app shows on the widget within ~1 s of going back |
| `testLinksReplaceWhatWasOpen`, `testOldLogSheetDoesNotComeBack` | widget links open the right screen and replace what was open |
| `testPageFlipToVisibleChange` (`WIDGET_PAGE_VARIANTS=process`) | the widget-process vs app-process difference (W1) |
| `testWhichIntentKindOpensTheApp` (`WIDGET_PROBE_MODES=chain`) | the hand-over runs the app in the background (W1) |

Run one with `xcodebuild test … -only-testing:HabitsUITests/WidgetLatencyDeviceTests/<test>` on the device (README in
`iOS/`), environment through `TEST_RUNNER_…` variables. Judge from the pictures (attachments), never from logs alone
(Rulebook T12, S18). Find a row's button by its VoiceOver name and tap by position (the switch covers the card).

Debug-only switches, all off by default and set by launching the app with them: `-widget-timing on|off` (timing log in
the app's Documents), `-widget-probe live|extension|chain|off` (stand-in buttons that change no data),
`-widget-page-probe live|off`, `-widget-week-timeline` / `-widget-short-timeline`, `-undo-widget-logs-since <unix
time>` with `-undo-any-source`. After any test that launches the app with `-uitest`, open the app normally once: test
launches write their demo habits into the widgets' file (a known D8 gap, tracked separately).

## 7. Change policy

- Locked: W1–W18. Ask the user before changing any of them, and say which.
- Code that implements them carries a comment starting `LOCKED (widget taps, 8 Oct 2026)` pointing here.
- Adding a new widget kind or action: follow §2 (switch over the card, `after` from the app, `WidgetTapIntent` →
  `WidgetSaveIntent`, idempotent saving), then run the §6 checks and hand it to the user.
- Never: an app-process intent for a widget tap that should show at once; `Button` instead of the card switch for ✓/+;
  `invalidatableContent` on buttons; numbers worked out in the widget; a tap saved only in the file; a week of
  timeline entries; nested switches.
- **Changed with the user's say-so, 8 Oct 2026 (Current Work 74; none of W1–W17):** a test launch (`-uitest`) keeps its
  widget files in an App Group folder of its own (`WidgetDisk.directory` → `uitest/`), so a UI test on the iPhone never
  shows its demo habits on the person's Home Screen or saves and removes the person's waiting taps. The widget extension
  and every ordinary launch use the person's folder as before; `-dbname` system tests (WidgetSystemUITests) too.
