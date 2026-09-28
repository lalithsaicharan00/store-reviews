Written by Claude (Claude Code), 28 September 2026.

# Back to Today — When and Where

**The user's feedback (28 Sep):**
- The calendar sheet's open day had a **square** highlight on a screen where everything else is round.
- Its **Today** button showed all the time, at the top, where it did nothing on today itself.
- It should appear only after moving to another date, somewhere that clearly reads "go back to today". Perhaps the bottom.

## What users show

Scan: `Research/Temp/today-button/scan.py` (hits in `hits.txt`), across all 1,238,784 reviews: 38 hits, all read.

**1. A one-tap way back is wanted once someone has left today.**

| Review | App | What they say |
|---|---|---|
| `12541318418` | Grit, 4★ | "when I select a past date, there's no way to quickly return to today's date with a single tap … I have to keep tapping the 'next day' button" |
| `24453767-ec68-4530-8e48-2b9b2c1bfd18` | HabitNow, 5★ | "a button for 'today' if we move to a different date in next week or next month" |
| `659551b0-e4b5-4698-aab0-a9d6c1d43a17` | Loop, 5★ | "Please add a calendar button or 'go to today' button … I lost where I was" |
| `e3a1b8e4-9ca7-4964-b0df-71d22a1a1e90` | HabitNow, 5★ | "needs a function to return to today when you are done scheduling into the future" |
| `c3ec88cb-aaaa-4229-9b7d-5ac92d096258` | Tasks, 5★ | "in calendar mode add a today button taking you to today" |
| `864889a7-db32-45e1-b9a6-8ab66a99f23f` | EZ Habit, 5★ | "add button to return to current" |
| `1478996071` | Habitify, 2★ | after selecting another day "there doesn't seem to be a way to get back to the current day" |

The wording is "**return / go back / get back** to today". The need arises **after** leaving today, which supports showing the button only then. Nobody asks for a Today button while they're already on today.

**2. Being on another day without noticing leads to wrong-day logging.**
- `4358460360` (Fabulous, 3★): "I've checked a wrong habit by mistake many times … cause I was on the wrong day".
- `5181906623` (Habitica): pressing a habit "twice for yesterday when it was supposed to be for today".

A visible "Back to Today" on Today itself doubles as a reminder that another day is open.

**3. Round, not square.** `86bbbdd0-490c-48ac-b61b-ad66134b0f0a` (Loop, 5★) asks for "a circle around the current date". It's a single review; the main reason is consistency: every mark in the calendar is a ring.

**4. Placement near the day controls.** `6136849587` (Do Habits, 1★) complains about day navigation packed into a "tiny little spot at the top left", where a mis-tap "will take you back to today".

**Reasoned from first principles:**
- Day navigation lives in the **bottom** bar (‹ day ›), so the way back belongs next to it, within thumb reach.
- A top-corner button is far from the thumb and far from the controls that took you away.

## Decision

| Where | When | What |
|---|---|---|
| **Today screen** | Only while another day is open | **"↩ Back to Today"**: a primary capsule (ink) floating just above the day bar. Tapping returns to today |
| **Calendar sheet ("Go to a day")** | Only while the open day isn't today, or another month is shown | The same button pinned at the bottom of the sheet. Tapping opens today and closes the sheet |
| Calendar sheet, top bar | Always | Only **Done**. The old top-left Today is removed |
| Calendar, the open day | Always | A filled **circle** inside its ring (was a rounded square) |

**Built** in `iOS/Habits/Today/DayBar.swift` (`BackToTodayButton`, `CalendarSheet`) and `TodayView.swift`. **Checked** on the iPhone 16 with `TodayUITests.testBackToToday` (hidden on today, shown on yesterday, in the calendar too, gone after tapping). `RoutineCalendarUITests` was updated.
