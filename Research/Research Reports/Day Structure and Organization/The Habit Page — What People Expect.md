# The Habit Page — What People Expect

Written by Claude (Claude Code), 29 September 2026. Build Plan #56b. A short, focused check (the user agreed a full study wasn't needed). Archive, delete and history rules already come from the Feature Ledger: C016, C041, C176, C219 and C262.

**The question:** what should a habit's own page show, now that pause, notes and Edit need a home?

## Answer

1. **Its history first: a calendar of this habit's days.** Users show this is what the page is for: 21 reviews in 14 apps. One reviewer called losing it after an update the loss of "the most valuable feature for me in this app" (Me+, `0d6ead65-b7e1-430d-a4fe-23776569c1bd`). Mark every kind of day: done, not done, skipped, paused, and not one of its days. One reviewer also wants the days still to come marked (HabitNow, `5a0bfae5-50e4-4a5a-9e27-a6cf13a60fe3`).
2. **Its streak and best at the top, plus a few plain counts.** 29 reviews in 16 apps want stats for one habit. Charts belong to Progress and statistics (#60). The page starts with the numbers the app already knows: current streak, best, and days done this month.
3. **What the habit is, in one line, before anything else.** "Displaying Repeat, Reminders, and Goals right at the beginning… would help understand the habit's purpose" (Habitify, `11472660208`). The app's one-sentence read-back of the habit (`HabitCopy`) is exactly that. The description goes under it (2 reviews).
4. **Its notes, one tap away.** "To get to the Notes field now I have to make 3 presses" (Productive, `5402526794`).
5. **Edit, Pause, Archive and Delete on the page.** "Deleting a habit is almost hidden — it should be a clear option when viewing the habit detailed view" (DayStamp, `9562235582`).
6. **Never make the page the way to check off.** "To check a habit, I need 3 steps: 1. click it once to enter the habit page, 2. check it. 3. Go back" (Habit Tracker, `9070770527`; 5 reviews in 4 apps). On Today, a tap on the row keeps logging. The page opens from All Habits.

## What the reviews say

Scan of all 1,487,223 reviews for words about one habit's page, detail, history, calendar or stats (`Research/Temp/habitpage/scan.py`). All 128 hits were read by hand (`classify.py`); the rest were about the main screen, crashes or the new-habit form.

| Group | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Stats for one habit | 29 | 16 | 3.97 |
| A history calendar for one habit | 21 | 14 | 4.05 |
| Would rather see all habits together (that's Progress, #60) | 8 | 3 | 4.38 |
| Checking off must not need the page | 5 | 4 | 4.00 |
| Moving between habits from the page | 5 | 4 | 3.40 |
| Edit or delete from the page | 4 | 3 | 4.25 |
| Details up front, a description, notes on the page | 2 each | 2 each | 3.50–4.50 |

## The page, reasoned from first principles

Opened from All Habits (#56). Native parts only:

- **Top:** icon, name, and the habit's sentence ("Drink 8 glasses of water every day, morning"). A paused habit says when it's back, with Resume.
- **Numbers:** current streak and best (a quit habit shows its current and best run), and done this month.
- **Calendar:** one month at a time, ‹ ›, with the same marks as the rest of the app. Tapping a day does nothing yet: logging stays on Today. *(Superseded 29 Sep: a tap opens that day to fill in or change it, [Filling In a Past Day From the Habit Page](<Filling In a Past Day From the Habit Page.md>).)*
- **Description, then notes:** the newest few notes, and All Notes.
- **Actions:** Edit in the toolbar, then Pause / Resume, Archive and Delete in a list at the bottom. Delete asks first and says the history goes too. Archive says the history stays.

Not now: charts (#60), and moving between habits with a swipe (5 reviews). The list is one tap back.

## Limits

A keyword scan finds people who name the page. Most people never write about a page they're happy with, so the counts are floors. The layout above is reasoned from first principles and hasn't been tested with people.
