# iOS/Shared — the widget extension's code (shared with the app)

Written by Claude (Claude Code), 8 October 2026.

Everything here is compiled into **both** the app and the widget extension (`HabitsLiveActivity`). The widgets draw
only what the app worked out (`WidgetSnapshot`, Rulebook U26).

## LOCKED: how a widget tap works

**Read [Widgets — Taps and Updates (Locked)](<../Docs/Widgets — Taps and Updates (Locked).md>) before changing anything
about widget taps, saving, updating or what a widget button does.** The user approved it on the iPhone on 8 Oct 2026
after a long search, and asked for it to be locked. Changes to what it does need their say-so, then the Home Screen
checks in that page's §6. Speed work and bug fixes that keep the instant switch, the saving of every tap and syncing
without opening the app are welcome (the user, 11 Oct 2026; that page's §8).

In short:

1. The ✓/+ is a switch over the whole card (`WidgetTapCard` in `PhoneWidgets.swift`): iOS shows the card "after one
   tap" the moment it's touched. Only the round button takes the touch. The "after" card is the app's
   (`WidgetItem.after`).
2. `WidgetTapIntent` (`WidgetIntents.swift`) runs in the widget's process: `WidgetDisk.applyTap` swaps the card in the
   snapshot, `WidgetTaps.append` keeps the tap safe (`WidgetTaps.swift`), then it hands over to `WidgetSaveIntent`.
3. `WidgetSaveIntent` runs in the app's process in the background: `AppModel.saveWidgetTaps` saves every waiting tap in
   order (database → sync → backup → reminders) and republishes the widgets from the database.
4. Timers: `WidgetTimerIntent` (app process, for the Live Activity) behind a switch; never opens the app.
5. Timelines hold only the next 3 hours and the next day's start (`PhoneWidgetTimeline.horizon`).

Never: an app-process intent for a tap that should show at once (iOS waits ~3 s to show it), a `Button` in place of
the card switch, `invalidatableContent` on buttons, nested switches, numbers worked out here, or a week of timeline
entries.

## Files

| File | What it is |
|---|---|
| `PhoneWidgets.swift` | Every widget's views, timelines and the card switch (`WidgetTapCard`, `WidgetCardToggleStyle`, `WidgetButtonShape`, `WidgetHeaderPatch`, `ListHeader`, `WidgetRoundFace`) |
| `WidgetIntents.swift` | Edit Widget's choices; the tap, save, timer and page intents |
| `WidgetTaps.swift` | The waiting-taps file and `WidgetDisk.applyTap` |
| `WidgetSnapshot.swift` | The snapshot the app writes and the widgets read (`WidgetItem`, `WidgetDisk`) |
| `WidgetPalette.swift` | Widget colours |
| `WidgetAnalyticsRelay.swift` | Analytics hand-off from the extension |
| `WidgetTiming.swift` | Debug-only timing log, off unless the app is launched with `-widget-timing on` |
| `HabitTimerAttributes.swift`, `StopTimerIntent.swift` | The timer's Live Activity |

The app's side: `Habits/Model/HabitStore+Widgets.swift` (the snapshot, the "after" cards, publishing),
`Habits/App/AppModel.swift` (`saveWidgetTaps`, `timerFromWidget`), `Habits/App/HabitsApp.swift` (publishing on leaving),
`Habits/Today/TodayView.swift` (widget links replace what was open). Checks: `HabitsUITests/WidgetLatencyDeviceTests.swift`
(the iPhone's Home Screen), `Habits/Model/WidgetCheck.swift` and `WidgetReliabilityCheck.swift` (in-app checks).
