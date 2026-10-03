# Today's Rows — Tap, Swipe, the Day Sheet and Delete

Written by Claude (Claude Code), 3 October 2026, at the user's request (checklist
[Today — Row Sheet, Swipe Actions, Order and Tap Again](<../../../iOS/Docs/Checklists/Today — Row Sheet, Swipe Actions, Order and Tap Again.md>)).
It builds on [Undo and Fixing Progress — What People Expect](<Undo and Fixing Progress — What People Expect.md>) and
[Undo After Logging](<Undo After Logging.md>) (30 and 29 Sep), which already settled that undo takes back exactly one
entry and that tapping a tick again takes it back.

**The questions (the user's words, tidied):**
1. Should a completed habit move down?
2. What should a tap on a habit's row open, and what should that sheet hold for each kind of habit?
3. Should Delete be in it?
4. What should swiping a row offer, and on which side?
5. How does undo say what it will undo?
6. Should tapping a completed habit's button take it back? Today a habit counted several times a day undoes its last tick when tapped at its goal, then fills again on the next tap.

The user's rule for all of it: use the mental models people already have, never new ones.

## Answer in one screen

1. **Done habits move below the rest after the pause, as most people ask (the user's final call, 3 Oct 2026).**
   - The earlier report [Ticking Off, Folding and Small Settings](<../Home Screen and Visual Design/Ticking Off, Folding and Small Settings — What People Need.md>) read 243 reviews about rows moving after a tick:
     - 90 want done items to sink (3.87★);
     - 7 want them kept in place;
     - 9 ask for a setting.
   - The user first chose "stay in place" (order is the person's own, Rulebook U13), built that morning; after trying it, they reversed it the same day: done habits should move down.
   - So "Move to Bottom" is the default again, settling only after the pause (U4), and "Stay in Place" stays in Appearance for the 7.
2. **A tap on a habit's row opens its Day sheet for the day Today is showing. The round button keeps logging in one tap.**
   - This is the iPhone's own split: in Reminders and Mail, the circle acts and the row opens. Health works the same way: tap a row, see its data.
   - Users show they expect a tap to open the habit's details (16 reviews, 9 apps). They complain when a tap does the wrong thing (8 reviews, 2.38★) or opens the edit form instead of the habit (4).
   - The sheet shows which day it is with the **same day control as Today's bottom bar** (‹ Yesterday ›). Entries, controls and actions are that day's, so its contents follow the day without a sentence saying so.
3. **Delete isn't a button in the sheet. It sits in the sheet's ⋯ menu, next to Archive, and asks first, offering Archive instead.**
   - People complain it's too easy to delete (79 reviews), that a mistaken delete couldn't be undone (68), and that they couldn't find Delete at all (63).
   - So Delete has to be findable, never in the way, and never on a swipe.
4. **Swipe left (trailing):** Note (a full swipe, harmless, as today), Skip or Undo Skip, and Pause.
   **Swipe right (leading):** Undo, naming what it takes back ("Undo +1 glass"), only when the day has an entry. A full swipe never skips, undoes or deletes.
   - Users love swiping in habit apps (120 reviews, 4.62★). The complaints are swipes that *perform* the action unseen:
     - an accidental skip or tick (35 in habit apps, 22 in native list apps);
     - "which way is which" (14, 2.79★);
     - gestures nobody discovers (26).
   - Labelled buttons that a swipe *reveals* avoid all three.
5. **Every undo names what it takes back:** "Undo +1 glass", "Undo 20 min", "Undo Done", on the row, the swipe and the long-press menu alike. It always removes one entry, never the whole day. The sheet lists the day's entries, so "the last one" is something the person can see.
6. **One rule for the round button. ✓ toggles that day's tick; + always adds.**
   - The biggest complaint is a tick that can't be taken back (33 reviews, 11 apps, 2.97★); the existing research found the same.
   - The second is a tap doing something else the second time: adding again, completing the week, or undoing (15 reviews, 2.80★).
   - People who count several times a day expect each tap to add one more (5).
   - So a habit ticked once a day keeps its toggle, judged on that day only. A habit ticked several times a day becomes a "+1" counter like amounts, and its taking-back is the named Undo.

## How the evidence was gathered

- **Scan:** all 1,487,223 reviews (App Store and Play Store habit apps, and the native-app corpus: Reminders, Microsoft To Do, Google Tasks, Google Keep and others), in English and about a dozen other languages (`Today Row Actions Evidence/scan.py`). Hits per question:
  - swipe words: 1,924;
  - tapping again, un-checking or double tapping: 957;
  - deleting by accident, or a delete button: 641;
  - a tap that opens a habit: 65.
- **Narrowing:**
  - **Swipes:** kept those near an action word or a direction (1,237). The native ones were limited to the four list apps where items are ticked or deleted (391); Calendar, Notes, Sheets, Fitness and Health were dropped.
  - **Tapping again:** kept those with "again", a double tap, or a counting word (402).
  - **Delete:** kept habit apps and the native list apps (362).
- **Reading:** every one of the 1,700 kept reviews was read and hand-coded (`codes_*.py`). 794 were on topic. The rest were about swiping between days, deleting the app itself, subscriptions, or spreadsheets. Counts per code, with every review ID: `coded_counts.json`.
- **Design references** (principles, not competitor copying):
  - Apple's Human Interface Guidelines on swipe actions (leading and trailing actions, a full swipe performing the first one, destructive actions confirmed or undoable) and on sheets and menus;
  - the iPhone's own Reminders, Mail and Health;
  - Nielsen's "consistency and standards" and "user control and freedom".
- **Every quoted review ID below was checked against the corpus text** (35 quotes).

Counts are floors: people who find an app easy rarely write about it, and a review can carry several codes.

## What the reviews say

### Swiping a row

Habit apps: 480 read, 286 on topic in 44 apps. Native list apps: 391 read, 169 on topic.

| Group (habit apps) | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Swipe to complete, used and liked | 120 | 22 | 4.62 |
| Swipe to delete (want or use) | 45 | 7 | 4.38 |
| An accidental swipe did something | 35 | 9 | 3.60 |
| Prefer a tap; swipe hidden or awkward | 26 | 14 | 3.73 |
| Swipe to skip | 21 | 11 | 4.33 |
| Swipe to log part of an amount | 17 | 5 | 3.88 |
| Which way is which | 14 | 10 | 2.79 |
| Swipe to undo or fix an entry | 11 | 7 | 3.55 |
| Other actions by swipe (note, edit, move to tomorrow) | 11 | 6 | 4.18 |

**Liked when it's the satisfying final step:** "Love swiping to say a habit is done" (Habit Tracker, `9435214443`).

**Hated when a swipe performs an action people can't see coming:**
- "the swiping was opposite of I thought it would be so I kept skipping" (Productive, `5871313636`);
- "accidentally marking tasks as completed or skipped because it's the same motion" (Productive, `5297567225`);
- "It's way too easy to get it wrong because they all use the same swipe function" (Productive, `3604033505`).

**Hidden gestures cost people the main task:**
- "I had a really hard time finding out how to check ("complete") the task in the app, until i found out you had to swipe right" (Productive, `12615677653`);
- "There's no hint or suggestion that swiping will get you those options like the standard 3 dots for more options" (TrackIt, `437a8053-7857-4c02-8ca5-39bc5a2cf873`).

**The arrangement people praise is a tap that completes plus a swipe that reveals the rest:** "You quickly tick to complete or swipe to select Skip or Fail" (Habitify, `0b2a5250-d671-4710-a719-6bd498772ab3`).

**Native list apps show what iPhone users already expect:**
- the system's own gestures (68 reviews): "the swipe option that apple puts in every app" (Google Keep, `10670432099`);
- Reminders' swipe that revealed "options such as: 'mark as completed', 'remind me in an hour'" (`8302796577`);
- and, again, deletes by an accidental swipe with no way back (22): "Wish the Undo for accidental swipes to remove gave you a little more time" (Tasks, `e3b0814c-ee08-43e3-bda4-c1aabb95ea4f`).

### Tapping a completed habit again

402 read, 84 on topic in 53 apps.

| Group | Reviews | Apps | Mean ★ |
|---|---|---|---|
| No way to un-check a mistaken tick | 33 | 11 | 2.97 |
| A second tap did something unexpected (added again, completed the week, undid) | 15 | 9 | 2.80 |
| Double tap to complete (for and against) | 13 | 9 | 4.31 |
| Tap again should take the tick back | 10 | 9 | 4.20 |
| A tap should open the habit (or opened the wrong thing) | 6 | 5 | 4.00 |
| Counters: each tap adds one more | 5 | 2 | 4.00 |

**A tick must come back off with the same tap:**
- "the first press will check-in, and pressing it again will undo the check-in" (Habit Tracker, `12474979339`);
- "once you tap a task to complete it, you cannot immediately tap it again to reset the completion status" (Reminders, `11495864497`);
- "LET US UNCHECK" (Fabulous, `3988742804`).

**A second tap that does something else is the confusing case:**
- "I often accidentally double click a habit and have to back it out or undo it" (Awesome Habits, `13585104492`);
- "Now that same action completes it for the week" (Habit Tracker, `13999482645`).

**Counting several times a day is understood as adding, tap by tap:**
- "clicking on the circle once should fill up the ring by 1/3. Clicking it again brings it to 2/3 full. And then the last time, it should do the checkmark." (HabitNow, `59bcc2d6-06e7-47eb-a52d-95f4b722015f`);
- "click the check mark for once, click it again for twice" (Loop, `a84dc3ef-e227-417e-b003-5be01694edfc`).

**For amounts, the existing research already found people want one wrong entry fixed, not the day:** "If there was an easy swipe option to reduce or fix the input I'd give this 5 stars" (Habit Tracker, `9466621749`).

### Deleting

362 read, 223 on topic.

| Group | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Too easy to delete; wants a confirmation | 79 | 14 | 3.23 |
| Deleted a habit, task or entry by mistake, no way back | 68 | 15 | 3.28 |
| Couldn't find how to delete, or no delete at all | 63 | 25 | 3.24 |
| Where Delete lives (too prominent, beside Save, only inside Edit) | 21 | 15 | 3.19 |
| Wants Archive, a bin or Recently Deleted | 16 | 6 | 3.62 |
| Wants a confirmation | 16 | 6 | 3.38 |
| Undo or restore after deleting (wanted or praised) | 13 | 5 | 4.00 |

**Easy to hit, hard to undo:**
- "I accidentally deleted one of my habits. To my surprise, there's no possibility of undoing that operation. I lost track of years of information." (Habit Tracker, `12813158013`);
- "It should not be that hard to edit and that easy to delete." (Productive, `3655095954`);
- "It's too easy to delete a habit accidentally, no confirmation!" (Rise, `15788f9a-2c6e-43f3-9981-04b1cdb20009`).

**A Delete in plain sight is itself a complaint:** "Why on earth is the delete button so prominent anyway!" (Microsoft To Do, `10110436445`).

**But hiding it completely is the other complaint:** "you don't have a delete button on your app" (Me+, `10356776073`).

**What reassures people is that nothing is lost by a stray touch:** "Items aren't deleted from your list if accidentally bumped." (Microsoft To Do, `6236784547`).

### A tap that opens the habit

65 read, 32 on topic.

People expect a tap to show the habit itself (16 reviews, 9 apps), not its edit form (4): "habit edit info really shouldn't be the first thing I see when I click on each habit" (Productive, `7838723822`). They expect its notes there too (4): "show memo/note right when clicking the habit" (Habit Tracker, `10410891202`).

A tap that does the other thing is the 2.38★ complaint (8):
- "When I tap the habit, it doesn't add a count, but opens the habit." (Do Habits, `3880965892`);
- "My instinct is to long press the task itself to edit it but, of course, that triggers the task to be marked as done" (Streaks, `7473616926`).

That is why the round button and the row must never swap jobs.

### Done rows moving

There's a little evidence each way, read along the way:
- **For staying put:** "Erledigte nach unten schieben bringt die Reihenfolge am Folge Tag durcheinander" (moving done ones down muddles the next day's order; Me+, `0c078e89-344e-4a5e-bda7-a46a5164cd18`); "I have to find where that task went" (HabitNow, `7cf3f154-1467-43b3-a0a6-cdf27da0d7bf`); "they were kept in order" (Microsoft To Do, `5970171590`).
- **For sinking:** "Wish finished tasks MOVES TO THE BOTTOM" (To Do List, `9c09d5db-2f0f-454f-b7f6-2a1cad6934e1`).

This scan adds little to the earlier, larger reading: of 243 reviews, 90 want done items to sink, 7 want them kept, 9 want a setting. The default follows that majority (the user's final call, 3 Oct 2026); Stay in Place is the setting for the few who keep their order.

## The design (reasoned from first principles on top of the evidence)

**What is the person doing on Today?** Logging, many times a day, mostly with one tap. Occasionally fixing a day, writing a note, skipping, pausing. Rarely editing or deleting a habit. So:
- the most frequent action is one tap and never moves;
- the occasional ones are a tap or a swipe away, labelled;
- the rare and destructive ones are in a menu that asks first.

### The row

| Gesture | What it does | Why |
|---|---|---|
| Tap the round button | ✓ toggles that day's tick · **+** adds (the habit's step, or opens Add Entry) · ▶/⏸ starts or stops the timer · ⌄ shows a checklist's steps · Slipped (quit) logs a slip | The control's own job, the same every time (Reminders' circle). A tick is judged on that day only, so a weekly goal's tick toggles too |
| Tap the row | Opens the habit's **Day sheet** for the day Today shows | Reminders, Mail and Health: the row opens the item |
| Swipe left | **Note** (full swipe) · **Skip** / **Undo Skip** · **Pause…** / **Resume** | Trailing actions, as in Mail and Reminders, revealed with labels. Only the harmless Note performs on a full swipe |
| Swipe right | **Undo +1 glass** (named), when the day has an entry | One leading action that takes back exactly the last entry; no full swipe |
| Touch and hold | Open Habit Page · Edit Habit · Add Entry… · Add/Edit Note · Skip · Pause… · Undo +1 glass (named) · All Notes | The same actions as the sheet, for people who long-press. No Delete |

### The Day sheet, for every habit (one sheet, the same shape everywhere)

1. **Top:** the habit's icon and name, then the **day control** from Today's bottom bar: ‹ day › with the date. It opens on the day Today shows; ‹ › and the date picker move it. Everything below belongs to that day.
2. **Result:** that day's result in the habit's own words ("6/8 glasses", "Done", "2 of 3 this week", "No slips").
3. **Log:** the habit's own control:

   | Habit | Control |
   |---|---|
   | Once a day, or one day of a weekly goal | Done toggle |
   | Several times a day, amount, limit | Add Entry, and +step where set |
   | Time | Start/Stop timer and Add Entry (manual time) |
   | Checklist | The steps |
   | Quit | Log a Slip |

4. **Entries:** each of that day's entries with its time. A tap edits it; a swipe deletes that one, with Undo.
5. **For this day:** Skip / Undo Skip · Add Note / Edit Note.
6. **The habit:** Open Habit Page (chevron, pushed in the sheet) · Edit Habit · Pause… / Resume.
7. **⋯ menu** (top right): Archive · Delete Habit… The confirmation offers "Archive Instead", as on the habit page.

### Undo, named everywhere

The row's inline Undo, the leading swipe and the long-press item all say what they take back, from the entry itself:
- "Undo +1 glass" (amounts and counters);
- "Undo 20 min" (time);
- "Undo Done" (a single tick).

The sheet shows every entry, so nothing is hidden. Taking back a whole day is deleting its entries in the sheet, one by one, each with Undo.

## Limits and what's open

- The counts are floors, and the swipe and tap-again groups are weighted toward the apps that use those gestures most (Productive, Tasks, Microsoft To Do).
- On done rows moving, the larger earlier evidence favours sinking (90 vs 7 of 243). Staying in place is the user's decision, with the setting kept for everyone else.
- Deleting a habit still can't be undone, against Rulebook D6 ("deleting is archiving, with undo"). The confirmation and "Archive Instead" soften it. Making Delete itself undoable is a separate piece of work, noted in the checklist.
- The swipe layout is reasoned from the evidence and Apple's conventions, not tested with people. Check it on the iPhone (U9).
