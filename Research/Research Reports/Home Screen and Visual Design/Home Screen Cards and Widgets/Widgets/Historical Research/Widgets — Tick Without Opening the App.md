# Widgets — Tick Without Opening the App

Written by Claude (Claude Code), 30 September 2026. What the first widget in the iOS app does, and why. It builds on two earlier studies instead of repeating them: [Home Screen Cards and Widgets](<../../Home Screen Cards and Widgets.md>) §6 (7,844 widget reviews read by hand: what widgets people want) and [Architecture 07. Other Surfaces](<../../../../../../Architecture/07. Other Surfaces.md>) §3.1 (the plumbing: snapshot file, tap journal, day rollover). Ledger cards: [C023](<../../../../Feature Ledger.md#c023>) check off from the widget, [C040](<../../../../Feature Ledger.md#c040>) a widget must never go blank, stale or disagree with the app, [C009](<../../../../Feature Ledger.md#c009>) basic widgets stay free, [C039](<../../../../Feature Ledger.md#c039>) no reminders after a habit is done, [C264](<../../../../Feature Ledger.md#c264>) never add a tap to logging.

## Answer

1. **One widget, "Today", free, in every size:** small, medium and large on the Home Screen, and circular, rectangular and inline on the Lock Screen.
2. **Home Screen: today's habits by name, what's left first.** A header with "3/5" and a bar, then the rows in Today's order with unfinished habits on top and done ones below, dimmed, with a filled ✓. Medium shows 3 rows, large 7 and "+N more"; small shows the next habit.
3. **Each row has the same button as Today**, and tapping it logs without opening the app: ✓ for a once-a-day habit, +1 for a count, +250 for an amount with a quick step. A count goes up one tap at a time; it never jumps to done. Habits that need a timer, a checklist or a typed amount show a chevron and open the app.
4. **Done rows aren't buttons.** A widget only ever adds; a wrong tap is undone in the app, like a notification's Done.
5. **Lock Screen:** a ring of done out of planned, "3 of 5 done · Next: Stretch", or "All habits done".
6. **It never shows the wrong day.** The app writes today and tomorrow, so the widget turns over at the person's own day start without the app. If the app hasn't run for a whole day, the widget says "Open Habits to see today" instead of showing yesterday's list.
7. **Reminders stop** once a habit is ticked done from the widget.

## What the reviews say

Fresh keyword scan of habit and routine trackers' App Store and Play Store reviews (1,238,784 reviews; `Research/Temp/stats/widget_hits.json`), samples read by hand. Counts are keyword floors; the hand-coded counts are in the widget study.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Ticking from the widget (wanted, praised or lost) | 695 | 97 | 4.01 |
| Loving a widget | 1,530 | 108 | 4.61 |
| Widget stale, blank or not updating | 152 | 36 | 3.20 |
| Widget behind a payment | 699 | 75 | 2.70 |
| A list of the whole day's habits | 400 | 71 | 4.00 |

- **Ticking in place is the point, and losing it hurts.** Users show: "I like the previous widget that I can mark finished just from the widget instead of needing to get into the app" (ShineDay, 1★, `7553360995`); "I don't like how it opens the app each time you check something off" (ShineDay, 4★, `8239700598`).
- **One tap adds one step, not the whole goal.** Users show: "I could mark it once in the morning and once again later. Now … a single tap completes the entire habit, making it impossible to track partial progress" (Habitify, 3★, `12832854491`). Hence +1 for counts, and a chevron to the app for anything that can't be one fixed step.
- **The whole day, not one habit.** Users show: "not for just one habit but the entire collection of habits due that day" (Habitify, 5★, `10464675879`); "task list widget so I know what I have left to do for the day" (Finch, 4★, `14407038000`).
- **What's left comes first.** Users show: "The task that are completed also appear in the widget which just make the list of things to do seem longer" (HabitMinder, 3★, `5055323000`); "only showing remaining ha[bits]" (HabitMinder, 4★, `4638761023`); "tap the one I've done and it disappears. It makes me feel so much more organised" (ShineDay, 5★, `3254531371`). Done habits move below and dim rather than vanish, because the widget study found people split between hiding them (63) and keeping them struck through (20); moving them down serves both.
- **A stale widget is worse than none.** Users show: "the widget on iOS doesn't update, and the habits that have been marked as completed don't reset until you open and close the app" (Habitify, 2★, `11654766103`); "Any widget with a heat map remains empty despite being completed in the app" (Habitify, 4★, `13571560242`); "it just comes up with a blank screen when added" (Finch, 4★, `9784351502`).
- **Don't charge for it.** Users show: "Incredibly disappointed that the monthly tracker widget is now behind a paywall" (Habit Tracker, 1★, `11220373537`). Paid widgets average 2.70★, the lowest theme here.

## Reasoned from first principles

- **The widget draws only what the app wrote.** It never works anything out itself, so its numbers can't disagree with Today's (C040). The app rewrites the file after every change and asks the widget to redraw.
- **Taps wait as files, each with its own entry ID.** The widget can't safely open the database (Architecture 07: SQLite in a shared container gets apps killed), so a tap is saved as a small file with an entry ID made at the tap. The app adds waiting taps before it shows anything, plans reminders or redraws the widget, and adding the same ID twice counts once, so a tap is never lost or doubled. The files are deleted only after the database save succeeds.
- **The row changes at once.** The widget updates its own copy of the file straight after the tap, so the ✓ fills and the row moves down without waiting for the app.
- **Two days, not one.** With today and tomorrow in the file, the timeline switches at the day start (after the person's day end, "Day Ends At" in Settings). After the last written day ends it shows "Open Habits", because showing yesterday is the stale-widget failure.
- **Names, not only icons.** The widget study found 28 people asking for names; a list of names reads at a glance.
- **Nothing destructive on the widget.** No reset, no undo, no delete: the widget study found accidental taps come from destructive buttons on widgets.

## Not built yet

- Week grid, month calendar and streak tiles, and a single-habit widget (widget study §6.4): later, as more designs. Basic interactive widgets stay free; extra designs and more than 5 habits on a widget belong to Plus (Architecture 02 §3.1).
- Choosing which habits a widget shows (a configurable widget).
- Android widgets (Jetpack Glance), which can use the database directly.

## Setup

- The app and the widget share the App Group `group.com.lalithsaicharan.habits` (entitlements added to both targets). It must also be turned on for both App IDs in the Apple developer account before the widget can read the app's file on a device.
- Removing the day's reminders from the widget is best-effort: if it doesn't happen there, the app removes them when it next runs and replans.

## Limits

Keyword counts are floors, and the widget hasn't been tried on a device: this cloud session can't build Swift. The earlier widget study has the hand-coded numbers.
