# Filling In a Past Day From the Habit Page

Written by Claude (Claude Code), 29 September 2026. A short, focused check before building it (the habit page's calendar showed history but "tapping a day does nothing yet", [The Habit Page — What People Expect](<The Habit Page — What People Expect.md>)). The Feature Ledger already settles *whether*: back-dating is a free recovery action ([C010](<../Feature Ledger.md#c010>), 34 apps; [C262](<../Feature Ledger.md#c262>), Certain). This check is about *how*: what a tap on a day in one habit's calendar should do.

## Answer

1. **A tap on a day opens that day; it never changes the day by itself.** Users show both sides. People praise filling in missed days from a habit's calendar, but a calendar that ticks or unticks on a tap changes history by mistake. So the tap opens a small sheet for that day, and the change is one more, clearly labelled tap.
2. **The sheet uses the control the habit already has.** Mark as Done / Mark as Not Done for a tick; the number of times for "3 times a day"; Log Amount / Log Time for amounts and time, with each thing logged that day listed and deletable; the steps for a checklist. Nothing new to learn.
3. **Show what the day was first**: "Done", "Not done", "5,200 of 8,000 steps", "Skipped". For a week or month goal, the whole period too ("That week: 2 of 3 times"), since one day alone isn't the goal.
4. **Skip, and the day's note, belong on the same sheet.** A skipped day can be un-skipped there; a note written for that day can be read and changed there.
5. **Only days that can honestly change are tappable:** from the habit's first day up to today, on its days (or a day set aside with Skip). Paused days, days before it started and days to come only show.
6. **Open the page from Today too.** "View Habit" in the row's long-press menu, next to Edit Habit. A tap on the row still logs (the rule from the habit page report).

## What the reviews say

Scan of 1,238,784 App Store and Play Store reviews for a calendar, history or past day together with tap, edit, change, mark, check or fill (`Research/Temp/scan.py`): 2,393 hits, narrowed to 108 that describe tapping or clicking in a calendar or on a day, all read by hand.

**Filling in from the calendar is wanted and praised:**

- "Can I suggest the option to click on the calendar and 'fill in' days completely from the previous week? Occasionally I'll forget to check the app at the end of the day" (Productive, 5★, `2085529972`).
- "Calendar where you can choose the goal and click the dates if it was missing" is among "the best things" (Goal Streak, 5★, `11346385680`).
- "If you forget to check something you can click onto the habit, navigate to the calendar, click edit, and tap any dates that you know you did a habit. This helped me enormously" (Loop, 5★, `8e8f85ab-ceb8-4077-9bdf-8a975d61879e`).
- Losing it is a downgrade: "Before you could click to a calendar view and update your streaks for any days you may have missed recording. Now you have to swipe back, day by day" (Do Habits, 3★, `3901553792`); "I would update my trackers through the History tab — super quick" (Strides, 2★, `13025306978`); "it annoys me to have to click through the calendar a billion times" (HabitNow, 4★, `efca38e2-3d8b-46e6-a01a-1753ae1e7744`).
- A past day must also be un-doable: "I checked a box on a previous date and realized I'd made a mistake but once … the day had passed I couldn't take it back" (Fabulous, 1★, `7654198659`).

**A tap that changes the day by itself goes wrong:**

- "The calendar allows you to done/undone a task in the statistics interface itself … we can by mistake click on previous days and unknowingly mark the habit undone" (Habit Tracker, 4★, `e20a0188-4949-445f-97b3-c71778990840`).
- "In the calendar view for one of the tasks, I accidentally tapped on an old day" (Streaks, 1★, `1946127158`).
- "Tapping on calendar within a habit increases the count for a given day — confusing" (Habitify, 3★, `248c15c6-ba3b-463d-b794-e77df6d0abcb`).
- "It could have been better if tapping on a day in calendar view shows the details of that day rather than marking it" (everyday, 4★, `cece2a48-af57-458b-b27f-0862d9a3ec10`).

**The day's note, from the calendar:** "the ability to view the note for a specific day by clicking on it from the calendar view. If that feature is added, this app would be a perfect 5" (Evoday, 4★, `10569299689`); the same wish for notes read from calendar days (Habit Tracker, 4★, `11693755507`).

| Group | Reviews |
|---|---|
| Fill in missed days from a calendar (asked for, praised, or missed after removal) | 7 |
| Mistaken changes from tapping a calendar day | 4 |
| Read the day's note from the calendar | 2 |

## The design, reasoned from first principles on top of that

- **What is the person trying to do?** Put right a day: they did it and forgot to log, or logged by mistake. It's rare and deliberate, so one extra tap costs little, and a mistaken change to history costs a lot (streaks are what people protect, C176).
- **What could go wrong?** A stray tap while scrolling the month. A sheet that opens and does nothing until a button is pressed can't change anything by accident, and Done closes it.
- **Consistency:** the same words as Today ("Log Amount Manually", "Skip", "Add Note"), the note written in the same note bar, the same round calendar.
- **Recovery:** every change on the sheet can be reversed on the same sheet (Mark as Not Done, Delete an entry, Undo Skip).

## Limits

A keyword scan finds people who write about the calendar; the counts are floors, and the layout hasn't been tested with people. Loop's "edit" mode (a switch that makes days tappable) is another way to prevent mistakes; a sheet was chosen because it also shows what the day was and holds the note, which a toggle can't.
