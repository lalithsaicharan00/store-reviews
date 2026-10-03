# Today's Rows — The Line Under the Name, Notes and Spacing

Written by Claude (Claude Code), 3 October 2026, at the user's request (checklist
[Today — Row Layout, Subtext, Notes and the Task Sheet](<../../../iOS/Docs/Checklists/Today — Row Layout, Subtext, Notes and the Task Sheet.md>)).
It follows [Today's Rows — Tap, Swipe, the Day Sheet and Delete](<Today's Rows — Tap, Swipe, the Day Sheet and Delete.md>)
(the same day) and revisits the card reports
[28. The Day Card](<../Home Screen and Visual Design/Today Screen Habit Cards/28. The Day Card — What It Shows, and in What Order.md>) and
[33. Fixed Places on the Card](<../Home Screen and Visual Design/Today Screen Habit Cards/33. Fixed Places on the Card — Time, Streak, Frequency.md>)
(24 Sep), whose fixed-places rule the app had drifted away from.

**The questions (the user's words, tidied):**
1. What should the line under a habit's name say, for every kind of habit and goal, so that every row works the same way: "at this place I find this"?
2. Should every row have that line? (Some have two lines today, some none. A checklist's steps shouldn't have one; a task should say it's a task.)
3. Quit habits show "Slipped" and a best run under everything. What should they show?
4. Where should a note be typed? (Today it's typed in a bar while the row is in view; the user wants a separate sheet with Save, and "Edit Note" once there is one.)
5. How should Undo and Add note sit, so nothing wraps and the spacing is even?
6. What should tapping a task open?

## Answer in one screen

1. **One line under every name, saying what today asks of that habit.** It always gives the same kind of fact, in this order:
   - **how much, and how far along**, when the habit is counted: `3/8 glasses`, `12/20 min`, `1/3 times`, `2/3 this week`, `1/4 steps`, `1/2 cups max`;
   - **or how often**, when it's a single tick: `Every day`, `Every Mon, Wed and Fri`, `Every 2 days`;
   - **then its time**, if it has one: `· 7:00 AM`.

   The data changes from habit to habit; the idea doesn't. The line is always one line, never two.
2. **Every habit and task row has exactly one such line.**
   - A task's line says it's a task: `Task`, `Task · 5:00 PM`, `Task · From Wed 1 Oct`.
   - A checklist's step rows have none: they're parts of the row above them, not rows of their own.
   - Skipped and paused days say so in the same place: `Skipped today`, `Paused until Fri 10 Oct`.
3. **A quit habit's line is its best run** (`Best 12 days`), and the live count since the last slip stays on the right, where other rows have their button.
   - The "Slipped" button line goes. Logging a slip moves to the row's tap (its Day sheet's Log a Slip…), a swipe, and the touch-and-hold menu.
   - After a slip, the row offers the same named Undo as every other row.
4. **A note is written in its own sheet,** opened from Add Note, never typed in the row or in a bar over Today.
   - The sheet has Cancel and Save, room for a long note, and Delete Note when one exists.
   - Once a note exists, the button reads **Edit Note**.
   - The note's text isn't shown in the row. It's in the Day sheet, the habit page's Notes, and Edit Note.
5. **After a log, one short line of compact buttons sits under the text: the named Undo and Add Note (or Edit Note).**
   - They're small capsule buttons: one line each, never wrapped, 8 points apart, aligned with the name above.
   - The line shows only while the offer lasts (until the next log elsewhere or the pause), so a row is at most three lines: name, its line, and these buttons.
6. **A task's row opens the same Day sheet, shaped for a task.** It holds:
   - Done;
   - for a one-time task, its date with **Do Tomorrow**;
   - the note;
   - Edit Task;
   - Archive and Delete in the ⋯ menu, as for habits.

**Spacing, one set of numbers for every row:**
- name to line: 2 pt;
- the icon, the text pair, the streak and the button centred on one 44-pt band;
- 6 pt from the band to the after-log buttons;
- 8 pt between those buttons;
- the list's own row spacing between rows;
- icon to text: 12 pt; text to the right-hand items: at least 8 pt.

## What was read

**Scope.**
- Scanned: every review in the App Store, Play Store and native corpora (1,487,223).
- Seven pattern families, narrowed to rows, cards and the main list:
  - what people want visible on the list (129 hits);
  - "at a glance" (495);
  - clutter on the list or cards (165);
  - text cut off or wrapping (204);
  - quit habits on the list (465);
  - tasks beside habits (24);
  - notes and where they're typed (55).
- **1,537 read by hand; 330 on topic, from 47 apps.**
- The coding is in `Today Row Text Evidence/` (`scan.py`, `narrow.py`, `codes_*.py`, `tally.py`, `coded_counts.json`).
- The hit files are in `Research/Temp/rowtext/` (ignored by git).
- Every quote below was checked against the corpus.

**How to read the numbers.**
- Counts are reviews, not people.
- The question is narrow, so most counts are small. Where a decision rests on few reviews, it says so and says what reasoning carries it.

## Key findings

### 1. People look for today's state on the row; mixed formats are what confuse them

- **Today's progress and "done or still to do" are what people scan for:**
  - 8 reviews (7 apps) want progress on the main list: "the only suggestion that i do have for you is to show progress on the home page somehow" `1591156461`;
  - 7 (4 apps, 4.71★) say whether each habit is done must read at a glance: "it is hard at a glance to work out what is done and what is outstanding" `11725650343`.
- **The streak belongs on the row** (20 reviews, 10 apps; already there, on the right):
  - "I want to be able to see how long my streak is from the front page" `9559403535`.
  - It must not *replace* today's state: "it makes it nearly impossible to tell at a glance which habits I've done" `d4b8ab93-51cc-403e-a730-40985b6d2bf9`.
- **When rows read differently, people have to remember each one** (3 reviews; small, but it is the user's point exactly):
  - "I have to try to remember for each habit whether it's daily or not, and what frequency I set it" `3554375156`;
  - "the graphics with some add and some quit behaviors next to each other are really confusing" `5414901550`.
- **How often belongs on the row too** (2 reviews; report 28 found 10 more asking for the time):
  - "be able to see the target frequency in the overview (I now put them manually in the title)" `42ee056a-baf0-4e5c-9d9e-0697e86bc4d0`.
  - People write how often in words. 13 native reviews say symbols without words tell them nothing (calendar dots, rings), averaging 1.62★.

**So, reasoned from first principles on top of these:**
- Every row answers the same question in the same place: *what does today ask of this, and how far along am I?*
- A counted habit answers with numbers ("3/8 glasses"). A single tick answers with how often ("Every Mon, Wed and Fri"), because its done-or-not is the ✓ itself, and "0/1" says nothing ("a once-a-day tick shows no 0/1", 28 Sep).
- The time comes last on the same line, as report 28 put it. A habit planned for a set day of the week only appears on those days, so for a counted one the numbers matter more than repeating its days.

### 2. One line, not two, and nothing that isn't needed

- **Extra text is clutter.**
  - 42 reviews (6 apps, 2.43★) complain that things other than their habits crowd the main list.
  - 3 call the extra text clutter: "Unnecessary text clutter" `5341561913`.
  - A native list repeating a label under every item is "very cluttered because the list name is displayed beneath every task" `5742976469`.
- **A second line with loose spacing costs rows on screen:** "display due dat on second line with tons of spacing. You end up getting very few tasks on the screen" `7285346916`.
- **Cut-off names annoy people** (7 reviews): "longer goal names which get truncated if longer than a few characters" `1484200659`.
  - Today cuts every name at 15 characters, though names may be 24 (U6).
  - So the name now uses the row's width and ends in "…" only when it runs out of room.
  - A few (3) would rather names wrap. The user ruled that out: rows stay at their lines.

### 3. Quit habits: the count since the last slip, and the best run

- **85 reviews (5 apps, 4.92★) say the live count since the last slip is what helps** (counting a habit's "days since" on the list or a widget):
  - "All I want to see when I open the app is how many days it has been" `9725862564`.
  - That count is already the big number on the right of a quit row.
- **The best run is the one other fact people value** (7 reviews, 5.0★): "you can still see your previous 'streak' which motivates you to try reach it" `8603872369`.
  - One person finds it hurts ("seeing the longest streak and average streak ruins the progress if I keep comparing myself to the past" `8404418658`).
  - So it stays quiet, on the line, not big.
- **A slip shouldn't feel like starting from nothing** (5 reviews): "Having to reset a counter does not mean you are back to square 1" `13091581867`.
  - This fits the U3 words. The row says "Best 12 days", and the slip is an entry with a named Undo like any other.
- **Hours early on, days later** (6 reviews): "being able to see the hours in the beginning was way more motivating to see '72 hours'" `9649217076`.
  - `Format.elapsed` already does this on the right.
- **So the quit row follows the same anatomy:** name, its line (`Best 12 days`), and the live count where other rows have their button.
  - The "Slipped" button line under everything (what the user saw as stray text) goes.
  - Log a Slip stays one tap from the row (its Day sheet), the swipe and the menu (U5).

### 4. Tasks next to habits must say they're tasks

- **15 reviews (5 apps) want tasks and habits told apart on one list.** Some praise apps that separate them: "allowing to track both tasks and habits and to separate them" `8265532671`. Others complain they can't: "the habits or tasks don't say like selected tasks or habits so it is hard for me" `a351f0f3-acd1-4517-9946-bc6e3c6609b7`.
- One person sees no need.
- **So a task's line always starts with "Task".** It's the word people use for it, and a word needs no legend.
  - What follows is its time, or where it came from if it was carried over ("From Wed 1 Oct").
  - A task gets the same tap as a habit: its Day sheet, with what a task needs (Done, Do Tomorrow, its date, the note, Edit Task).
  - Like every Day sheet, its rare and lasting actions sit in the ⋯ menu.

### 5. Notes need room and must never be lost

- **Typing needs room** (3 reviews): "you can only view a small portion of the current sentence you're typing … Please update it so we can see the entire note" `3844009364`.
- **Notes that vanish are among the angriest reviews:**
  - 40 reviews average 1.93★: 6 in habit apps, 34 about the iPhone's Notes app.
  - "there needs to be an auto save feature for the notes function. I have lost notes" `1023368205`.
- **So the note gets its own sheet:** a growing field in a Form that stays above the keyboard, as `NoteSheet` already does in the Day sheet, with Cancel, Save and Delete Note.
  - It opens at half height and can be pulled to full.
  - Save is explicit, so nothing is half-saved. Cancel keeps the old note.
  - The earlier choice of a bar over Today (29 Sep, chosen so the row stayed in view) is replaced at the user's request. The sheet names the habit and the day at its top, so the context is still there.
- **The row doesn't show the note's text.** One review wants it there; the user's point is that it made rows run to four lines.
  - The Day sheet shows the note, and Add Note becomes Edit Note.

### 6. Spacing and alignment (reasoned from first principles and the iPhone's own lists)

The user saw rows that felt squished, uneven spacing, and icons that didn't line up. In the code, all three have one cause: the icon and the button sat at the top of a band whose text block grew with every extra line (a rhythm line, a flexible line, the note, Undo). So the icon drifted from the name, and rows had four different heights.

**The fix:**
- Every row has the same first block: icon, name with its one line, streak and button, all centred on one 44-pt band (the iPhone's minimum touch height, and the height of a two-line Settings row's text).
- Anything after a log goes in a separate line under the text, aligned with the name, at a fixed 6 pt below.
- A native look: the small capsule buttons Apple uses for inline actions (`.bordered`, `.capsule`, `.small`), monochrome per U2.
- A hierarchy of space, with no number used for two jobs:
  - 2 pt inside the text pair;
  - 6 pt between the band and its buttons;
  - 8 pt between buttons;
  - 12 pt between icon and text;
  - the list's own spacing between rows.

## What each row says (the build)

| Kind | Line under the name | Right side |
|---|---|---|
| Check, once a day | `Every day` / `Every Mon, Wed and Fri` (· time) | ✓ |
| Check, several a day | `1/3 times` or `1/3 pills` (· time) | +1 |
| Check, a habit ticked in two parts of the day | how often (· that part's time) | ✓ |
| Weekly or monthly count | `2/3 this week` | ✓ (today's tick) |
| On some days each week ("3 days a week") | `2/3 days this week` | ✓ |
| Amount | `3/8 glasses` (· time) | +step or + |
| Time | `12/20 min`, live `7:42/20 min` while running | ▶ / ❚❚ |
| Limit (cut back) | `1/2 cups max` | + |
| Checklist | `1/4 steps` | ⌄ steps |
| Checklist step | none | ✓ |
| Task | `Task` (· time, or · From Wed 1 Oct) | ✓ |
| Quit | `Best 12 days` | live count |
| Skipped day | `Skipped today` / `Skipped` | as before |

The New Habit preview keeps its own line ("—" before an amount is set).

## Limits

- **Small counts:** 3 reviews on mixed formats, 2 on frequency, 3 on room to type. The anatomy rests mainly on the user's rule ("the same kind of fact in the same place") and on scanning principles (report 33). The reviews point the same way and none point against it.
- **The best run on a quit row** has 7 reviews for and 1 against. Progress's "Show Streaks" switch already hides streaks; it hides the best run too.
- **To check on the iPhone** (U9): the after-log buttons at the largest text sizes (they fall back to icons only if both don't fit), and Edit Note's sheet over a running timer.
