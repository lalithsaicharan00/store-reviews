Written by Claude (Claude Code), 16 October 2026.

# After a Log — Should Undo and Add Note Stay or Go?

**The user's question (16 Oct):** once Undo and Add note appear after a log, "should they stay and persist there, or
should they disappear after some time? … According to the best possible UX and UI principles … Don't blindly copy
from what we have in the iPhone." Answered for Android first, from reviews and principles; the iPhone's current
behaviour is not the basis.

## Answer

**They stay, with no timer, on the one row that was logged last, and leave when the person moves on:** the next log
(they move to that row), a different day, leaving Today, or starting a routine. They come after **every** log, not only
when a goal is met: each +1, each check, each step, a stopped timer, a typed amount, a slip. A slip follows the same
rule.

Then, after Today's usual pause, that row settles like any other (a done row moves below the rest).

## What users show

`After a Log Evidence/scan.py` read **1,487,223** reviews (every App Store, Play Store and native-app corpus) for an
undo control and how long it lasts; **76** matched and all were read by hand; **20** are on this question
(`review_classification.py`, `verify.py`: 20 quotes, 0 mismatches). Directional counts.

| What people say | Reviews | Examples |
|---|---|---|
| **Undo went before they could use it** | **6** | *"the undo button should always be there"* (P84#13346); *"cannot hit the undo button before it disappears"* (P84#25918); *"only the second after you complete it and then the option is gone"* (Finch, A10#25142) |
| **A floating Undo got in the way** (a toast, banner or snackbar over the next button) | **9** | *"the pop-up blocks the area where I need to tap to complete the next task"* (Google Tasks, N8#2661); *"an Undo button right at the place where the Plus button is located"* (N8#16081); *"the “undo” banner persists and blocks the delete button"* (Keep, N7#9835) |
| Asked for an Undo pop-up "for a few seconds" | 3 | They ask for an undo at all, in apps with none (N10#20775) |
| Controls that come and go unpredictably | 2 | *"appear and disappear along the top at random"* (N3#24367) |

So the two real complaints point in opposite directions — **too short** and **in the way** — and both come from the
same thing: a **floating, timed** Undo. An Undo that's **inline** (on the row, covering nothing) and **lasts until the
person moves on** removes both.

## The principles behind it

- **Control and freedom** (Nielsen's third heuristic): a clearly marked way back, there when the mistake is noticed —
  often a moment later, after reading the row.
- **No time limits on what someone needs to do** (WCAG 2.2.1, Timing Adjustable): a control that leaves on a timer
  fails people who read, move or decide slowly. Android itself has a system setting, *Time to take action
  (Accessibility timeout)*, because timed messages are a known barrier.
- **Nothing moves by itself** (layout stability; our U4): a line that collapses on a timer moves the rows below at a
  moment the person didn't choose, under a finger about to tap. Leaving when the person logs elsewhere ties the change
  to their own action.
- **Covers nothing:** inline, so it never sits over the day bar, the + button or the next row (the 9 complaints).
- **Only one at a time:** buttons kept on every logged row would grow the whole list and bury the habits; only the
  latest log has them, and every older log is undone from Day details.

## Rejected

| Option | Why not |
|---|---|
| Disappear after a few seconds | Too short for some (6), unexpected movement, fails WCAG 2.2.1 |
| A snackbar instead | Covers the next tap (9); one action only, so Add note can't sit beside Undo |
| Stay on every logged row all day | Clutter, a taller list; the person's own record is Day details |
| Only when the goal is met | The mistakes happen on each +1, check or step, not only the last one |

## Screens (Figma `1260:2`)

1.2 (a check) and the row **1.2.1–1.2.8** (an amount's +, a typed amount, several checks a day, a stopped timer, a
checklist step, a week goal, a cut-down +, a task), **1.2.9** a milestone beside Undo, **1.2.10** Edit note when there
is one, **1.2.11** the next log takes them to its row; a slip in 7.13.

## The words on the buttons (16 Oct, the user: "a simpler version … Undo, with an icon, and plus note")

The named Undo (*Undo +2,000 steps*) and *Add note* didn't fit: 12 of 18 lines in Figma ran past the row. Now the
two buttons are **↶ Undo** and **+ Note** (✎ Note when the day has one), the same on every row, and TalkBack keeps the
full name.

Nothing in the reviews needs the name on screen:
- The named Undo was reasoned from Apple's guidance for the swipe and long-press menu, where no row shows what
  changed (*Today's Rows*, 3 Oct).
- *Undo and Fixing Progress* (30 Sep) already found plain "Undo" clear for checks.
- Here the button sits on the row just logged, under its new value (*4/8 glasses*).
- The complaints in this report are about an Undo that leaves or covers something, never about its wording.

