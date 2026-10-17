Written by Claude (Claude Code), 16 October 2026.

# Swipe on a Today Row — the Android Way

**The user's question (16 Oct):** "work on the swipe options … what are the primary actions that users expect? … do
some research on top Android apps … and reviews. What users expect in swipe. What are the options? And how do they
expect it to work?" Android first, not copied from the iPhone (the iPhone's version: [Swipe Actions — Reveal, Never
Act](<Swipe Actions — Reveal, Never Act.md>), 4 Oct). Designed in Figma `1260:2`, the last three rows (7.1–7.24);
waiting for the user's review.

## Answer, in short

- **One action a side, as Android's own apps do** (Gmail, Todoist, Google Keep): drag a row and the action shows behind
  it; past halfway its colour fills and the phone ticks; let go and it happens; short of halfway the row springs back.
  Not the iPhone's buttons that wait to be tapped.
- **Swipe left: Skip today** (on a skipped row: **Undo skip**; on a quit row: **Log a slip**, which opens Add slip).
  **Swipe right: Add note** (opens the note sheet). Nothing is saved by a swipe except Skip, and Skip has Undo.
- **Never Done, never Delete by swipe.** Done is the round button, one tap; a swipe that completes or deletes is the
  most common swipe complaint, and for counted habits a swipe can't say "+1" or "all of it".
- **Days change on the day bar, not on the list.** People ask to swipe between days, and a list that pages sideways
  collides with row swipes; the day bar takes ‹ ›, a swipe along it, and Today ▾.

## How this was researched

- `Android Swipe Evidence/scan.py` read **945,134** reviews: every Play Store app in the corpus (146 habit and to-do
  apps) plus Google Tasks, Microsoft To Do and Google Keep. **521** mention a swipe; **362** are about an action, a day
  or a notification, all read by hand. These are **directional** counts (a keyword scan read by hand, not a coding of
  the corpus). Every quote is in `review_classification.py`; `verify.py` checks all 57 (0 mismatches).
- How Android's own apps do it, checked on their help pages: Gmail (Settings › General settings › Swipe actions: one
  action per side, chosen from Archive, Delete, Mark as read, Move to, Snooze or None), Todoist (Swipe actions: Complete,
  Schedule, Delete, Reminders, Select), Google Keep (swipe a note to archive it).

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **A swipe did something they didn't mean** (while scrolling, changing lists, too far) | **14** | *"too easy to accidentally delete items while scrolling"* (P84#12766); *"Too easy to accidentally complete tasks by swiping on them slightly"* (N10#842); *"If u swipe too much it will mark the whole thing complete"* (P98#544) |
| **Swipe between days on Today** | **9** (HabitNow alone 8) | *"swipe left-right between days in the "Today" tab"* (P2#8570) |
| **Swipe to complete**, wanted or praised | 9 | *"a simple swipe of a task to mark it as complete"* (P111#6097) |
| **Skip by swipe** | 6 | *"Swipe Right Complete And Swipe Left To Skip"* (P36#129) |
| **Sideways gestures fighting each other** (a page swipe while marking or scrolling) | 5 | *"When I want to put a check/x it sometimes swipes to another week instead"* (P24#8429) |
| **A swipe as the only way in is hidden** | 5 | *"There's no hint or suggestion that swiping will get you those options"* (P129#163) |
| **Undo after a swipe, not a question first** | 4 | Undo praised (P84#7050); confirmations called excessive (N10#19886, N10#22353) |
| **Let me choose what each swipe does** | 3 | *"(like in Gmail)"* (N7#8000) |
| **A swipe can't log part of a count** | 2 | *"I can't swipe it left to track one of the ten without the card disappearing"* (P98#1252) |

Where the accidents come from: delete-by-swipe in to-do apps (Tasks, Microsoft To Do), and a row swipe sharing the
sideways direction with switching lists or pages. **Microsoft To Do's reviewer on Android's back gesture** — *"I very
often drag the list item"* when swiping in from the edge to go back (N10#14320) — is why rows don't start a swipe at
the screen's edges.

## The design, and why each part

| Part | Decision | Basis |
|---|---|---|
| **How it moves** | Drag shows the action behind the row in grey: its icon and a short word (**Skip**, **Undo**, **Slip**, **Note**; the user, 16 Oct: never an icon alone), so the row moves under 100 dp and the habit's name stays readable; past halfway it fills ink, the full words appear in white (*Skip today*, *Add note*) and the phone ticks; let go to do it; less and it springs back | Android's own apps (one action a side, act on release); Material's swipe-to-dismiss behaviour; the tick and the colour say "this will happen" before the finger lifts |
| **Left** | **Skip today** → the row reads *Skipped today*, with *Undo · + Note* under it until the next log (16 Oct: no snackbar, as after a log) | Users show it: Skip by swipe (6), left for skip (P30, P36); Undo, not a question (4) |
| **Left on a skipped row** | **Undo skip**, in the place Skip was | U15's rule (Skip and Undo skip keep one place) |
| **Left on a quit row** | **Log a slip**: opens Add slip; nothing is logged until Add | A slip logged by accident would end a run; opening the screen keeps it one swipe away and safe |
| **Right** | **Add note**: opens the note sheet; nothing is saved until Save | Reasoned: notes are wanted right at the row (Habit Notes report), and an opened sheet can't do harm |
| **Not on a swipe** | Done, + amounts, Delete, Pause | Done is one tap on the round button; swipe-complete is the top accident (14) and can't log part of a count (2); Delete is in ⋯ only (U14, D6); Pause in the menu and Day details |
| **A task** | Right (Add note) only | A task isn't skipped |
| **Edges** | A swipe never starts in the screen's edge strips | Android's back gesture (N10#14320) |
| **Days** | The list never pages sideways; ‹ ›, a swipe along the day bar, Today ▾ | Users want day swipes (9) and sideways gestures fight (5); the bar is a place no row lives |
| **Finding it** | Everything a swipe does is also in the long-press menu and Day details | A swipe as the only way in is hidden (5) |

**Act when you let go, or show a button? Researched 16 Oct** ([Swipe on a Row — Act When You Let Go, or Show
Buttons](<Swipe on a Row — Act When You Let Go, or Show Buttons.md>), 922 swipe reviews read): with one action a side,
act on release. A revealed button would only repeat what the swipe already shows, and people complain when an app adds
that tap (9). The iPhone's worry, several results behind one drag, can't happen here. **Confirmed by the user, 16 Oct;**
Undo skip and Add note now sit on the row after a skip (7.10), no snackbar.

**Not decided, for the user:** let people choose each side's action (Gmail's *Swipe actions*; 3 reviews ask), in
Appearance: Left = Skip today / Add note / Nothing, Right = Add note / Skip today / Nothing. Not drawn.

## Every kind of row (the user, 16 Oct: "design it for all of them … each and every scenario")

Swiping **right** is the same on every row: **Add note** (**Edit note** when the day already has one). The action shows
at the left edge, because the row moves right. Swiping **left** depends on whether the day can be skipped:

| Kind | Swipe left | Why |
|---|---|---|
| Check, every day | **Skip today** | A day to skip |
| Check on chosen weekdays (Mon, Wed, Fri) | **Skip today** | Only on its days; it isn't on Today otherwise |
| Check every few days | **Skip today** | Its next day counts from the last |
| Check several times a day | **Skip today** | The day's goal is skipped |
| Amount, + adds a step | **Skip today** | |
| Amount you type | **Skip today** | |
| Time (timer) | **Skip today**; nothing while the timer runs | Stop it first |
| Checklist | **Skip today** | |
| Any of these, once skipped | **Undo skip**, where Skip was | U15 |
| Any of these, goal already met today | Nothing | Undo the log first (the after-log buttons, Day details) |
| Week goal, month goal | Nothing | No day to skip; the period counts |
| Quit | **Log a slip** (opens Add slip) | A slip is an event, not a state: after one, the row offers *Undo · + Note* under it until the pause; swiping left again logs another slip, so there's no Undo slip on the swipe |
| Cut down (amount or time limit) | Nothing | Skipping a limit would only hide what happened |
| Task | Nothing | A task isn't skipped |
| A later day | **Skip this day** (a plan, with Undo; the user's wording, 16 Oct: on a later day "this day" is the day open, not today) | 4.3.1's Skip this day |
| Paused habits | No swipe | They wait in the Paused card |

"Nothing" means the row gives a few pixels and springs back, so it's clear there's no action there, rather than not
moving at all.

## Screens (Figma `1260:2`, the last three rows, 7.1–7.24)

**7.1–7.8** swipe left on each kind that skips (every day, weekdays, every few days, + step, typed amount, several a
day, time, checklist) · **7.9** past halfway · **7.10** let go: *Skipped today*, with *Undo · + Note* on the row · **7.11** Undo skip ·
**7.12** a quit row: Log a slip · **7.13** after a slip: *Undo · + Note* on the row · **7.14** a week or month goal,
**7.15** a cut-down habit (and a goal met, a timer running), **7.16** a task: nothing on the left · **7.17–7.23** Add
note on a habit, Edit note, a week goal, a month goal, a quit row, a cut-down row, a task · **7.24** a later day: Skip
this day. The day bar (4) notes the swipe along it.

## Limits

Counts are small and directional. HabitNow supplies most of the day-swipe asks; the to-do apps (Tasks, Microsoft To
Do) most of the accidental deletes. The halfway point and the tick are reasoned from Android's own apps, not tested
with people; check the feel on a phone (U9).
