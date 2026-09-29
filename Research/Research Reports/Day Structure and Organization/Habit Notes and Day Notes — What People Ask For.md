# Habit Notes and Day Notes — What People Ask For

Written by Claude (Claude Code), 29 September 2026. Build Plan #54. It adds whole-corpus counts to the earlier [Organization and Notes Deep Dive](<Habit Tracker — Organization and Notes Deep Dive.md>) (23 Sep), which recommended per-habit dated notes and left the whole-day note open.

**The question (the user, 29 Sep):** build habit notes, and first research whether people also need a note for the whole day.

## Answer

1. **Habit notes: yes.** A note belongs to one habit on one day. It can be added on any day, including a missed or skipped day, and adding one never marks the habit done. Users show this is the main ask: 56 reviews in 25 apps want or praise a note on a habit's day (mean ★4.61), plus 44 more that say "daily notes" but mean one habit's day.
2. **A standing description on the habit: yes, as a separate field.** 15 reviews in 10 apps want a note that stays on the habit ("instructions or reminders on what exactly to do", `2049264808`), not one per day.
3. **A note for the whole day: yes, small.** 28 reviews in 17 apps ask for a note about the day itself, apart from any habit (mean ★4.18). It's a real, separate job: one line of context for a day that affected several habits. It's smaller than habit notes, so it comes second.
4. **Never prompt for a note.** It's always optional and never asked for after a check-in or a skip.

## What the reviews say

Scan of all 1,487,223 reviews (App Store, Play Store and native apps; `Research/Temp/notes/scan.py`). Hits were read one by one and classified by hand (`Research/Temp/notes/classify.py`). A hit can count in two groups (a note on a missed day is also a habit note).

| Group | Reviews | Apps | Mean ★ |
|---|---|---|---|
| A note on a habit's day (what I did, what I read, which workout) | 56 | 25 | 4.61 |
| Said "daily notes", but meant one habit's day | 44 | 14 | 4.57 |
| A note on a **missed** day (why I didn't do it) | 12 | 7 | 4.08 |
| A standing note on the habit (instructions, why I track it) | 15 | 10 | 4.27 |
| Looking back at notes (on the calendar, in one list) | 7 | 7 | 3.86 |
| **A note for the whole day, not tied to a habit** | **28** | **17** | **4.18** |
| Daily reflection praised in journaling-first apps (Finch, Habio, Roubit, Fabulous, 21 Days) | 55 | 12 | 4.84 |
| Note editor hidden by the keyboard, or text unreadable | 5 | 4 | 3.40 |
| A forced "why did you skip?" prompt, disliked | 1 | 1 | 2.00 |

**Habit notes**, in reviewers' words:
- A note records what the tick can't: "what exactly did I train in the gym" (`11762845723`).
- It must work on days it wasn't done: "I would like to add a note to explain why I didnt do the habit" (`11400095925`).
- Notes need their dates and a way to find them later: "habit note should track dates" (`5da8bac2-8cd5-4546-b9b6-7984fbcb25ac`); notes "visible on the calendar page" (`8114041656`).

**Whole-day notes** are asked for as a different thing from habit notes:
- "add notes for a day without being able to assign them to a task or habit" (`9b2b38e8-b8ec-4739-9ab9-ed4f0b022ec8`).
- "stuff that isn't necessary task/habit related" (`10da0f19-6aef-44c0-9612-ea9e7303d904`).
- A day off explains many misses at once: "a day that I'm sick in bed and unable to do some of them" (`449b6be1-76bb-49a5-9d81-e4a7d54f8a69`).
- One reviewer ranks it above habit notes: "possibly even better, generic notes about a day" (`e3a9fe0f-31ef-4fab-b185-705c7c3d4301`).

The 55 journaling-app reviews show people value a daily reflection. But in those apps it is the product itself, so they don't show that a habit tracker needs a journal. They support a short day note, not a journaling feature.

**What goes wrong:**
- A note field hidden by the keyboard: "obstructed by the phone's keyboard" (`0cda4235-b93e-4694-9862-211b90f5f960`). Our rule "every typing field stays above the keyboard" already covers this.
- A prompt that can't be skipped: "the inability to skip through things like questions about why I didn't follow through" (`c8bde985-47d2-42ea-9b0b-8b5464a658df`). Feature Ledger C268 has more of the same.

## Which app adds a note most intuitively (added the same day, at the user's request)

The first build used a long-press menu and a sheet. The user said that isn't a good way, and asked which app users find easiest. Scan of every review mentioning notes together with ease, difficulty or a gesture, grouped by app (`Research/Temp/notes/ease_scan.py`), then read by hand for the habit trackers.

- **Way of Life is the clear winner.** 174 reviews praise its notes (2.24% of its 7,764 reviews, mean ★4.86; report 76), and only 4 call them hard to reach. Its note is written **in place, on the day screen**: select a habit and "the input bar is showing" (`770122833`). Mark it and write "on the one screen" (`1001797283`); "From one screen I am able to easily update all my activities, write notes if I want to" (`718390142`).
- **A pop-up on every tick is the most common complaint:**
  - Loop: "I just wish the notes box didn't pop up every time I go to tick that I completed the habit" (`6303e9f0-0e10-40ff-9685-fe1e9d8709b7`).
  - Habitify, on its comment box when a day is marked failed: "annoying and infantilizing" (`13665455992`).
  - Habit Hub: "distracting popups (prompts to write a note when skipping a habit" (`13280430575`).
- **Buried notes are the other:**
  - HabitNow: "Note/Desc behind too many taps" (`d40f2aa8-596d-4d8f-b23e-ac0d92c0b6cb`).
  - Productive: "the Notes field has gotten buried in the interface" (`5402526794`).
- **Offered right after logging, and optional, it's liked.** Habit Tracker's memo after completing is praised by those who switched it on for one habit: "which i disabled for a lot of my habits but kept on for my gym habit" (`11605571903`).
- **A mark on the day helps find notes again** (Habit Hub's "yellow  shading on the date I left a note", `4115322082`).

**Decision:** the note is written in the row itself, as in Way of Life, and offered at the moment it's useful without asking:
- After a check, an amount, a stopped timer or a ticked step, that row shows a small **Add note**. Tapping it turns the line into a text field right there; Return or tapping away saves.
- The row that's just been logged stays in place while it offers the note (done rows otherwise sink to the bottom), so the offer is where the person is looking.
- A saved note shows under the progress. Tap it to change it in place.
- Long-press → Add Note does the same, for any day.
- In the routine player, the "Saved · Undo" message gets **Add Note**.
- Nothing pops up by itself.

## Design (users show the need; placement reasoned from first principles)

| Note | Where it's written | Where it shows |
|---|---|---|
| **Habit note** (one habit, one day) | **In the row:** Add note appears after logging; tap the note to change it; long-press → Add Note. In the player: Add Note beside Undo, and in Habit options | Under the row's progress that day; the habit's Notes list (long-press → All Notes), newest first |
| **Habit description** (no date) | The Edit Habit form, a **Description** row | The routine player, under the habit's name, so instructions are there while doing it |
| **Day note** (the whole day, no habit) | The day menu in the bottom bar (Today ⌄) → **Note for the Day** | A line above the day's list on that day |

- Any day, past or today, done or not. A note never changes a habit's progress.
- It's one text per habit per day and one per day. Editing it replaces it, and clearing the text removes it.
- It's never prompted, and never required.

## Limits

- The keyword scan finds people who wrote about notes; it doesn't measure how many would use them. Reviews that ask for something are counted, not people.
- Counts are of hand-read keyword hits. Reviews that describe notes in other words are missed, so each figure is a floor.
