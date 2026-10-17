Written by Claude (Claude Code), 16 October 2026.

# Checklist Steps on a Today Row — Fill, Ticked Steps and Long Lists

**The user's question (16 Oct, Figma 1.7):** "filling like this whole card … feels a little bit weird … what if we have
six or seven? The card will be very long and filling it feels very weird … checked or completed states should be a
little bit different from unchecked ones … maybe just filling that row … keep the rows up … find the best possible UX".
Android first.

## Answer, in short

- **The habit's row and its steps are two blocks** (the user, 16 Oct, pointing at 1.2: "the undo as well as add note …
  are part of the card itself … the remaining things should be like a separate block"). The habit's block holds its
  line, plus *Undo · + Note* after a tick, and the fill covers that whole block, as in 1.2. The steps open in
  a white block of their own underneath, 2 dp apart with 4 dp corners, like the rows of a card. A fill running down past
  the steps would put unticked steps on the progress colour, so they'd look half done, and the fill would grow with
  every step added.
- **A ticked step looks clearly different, and stays where it is.** It gets three cues at once: the box fills in the
  habit's colour with a white tick, the words turn grey, and they're crossed out. People want done items kept in view
  but visibly finished (14 reviews), and say a tick or a strike alone isn't enough (2).
- **Steps keep their order.** A ticked step never moves to the bottom: a checklist is usually a sequence (cleanser
  before serum), and order is the person's own (U13).
- **A long checklist folds.** ⌃ folds it at any time, and the fold stays as the person left it. When the last step is
  ticked, the checklist stays open through the pause (U4), then folds itself. People ask for sub-lists that tuck away
  (12) and that stay folded (1).
- **Every step is a full-width target, 48 dp tall.** 1.7's first step was only as wide as its name, and a tiny target
  makes the wrong thing happen (P37#214).

## How this was researched

- `Checklist Steps Evidence/scan.py` read **all 1,487,223 reviews** (App Store, Play Store, the native apps) on three
  questions, matching words that sit close together:
  - how done items should look (207 reviews);
  - folding sub-lists (76);
  - progress through sub-steps (28).
- All 311 were read by hand. `review_classification.py` keeps the themes, and `verify.py` checks all **35** quotes
  (0 mismatches). The counts are **directional**.
- **What the reviews don't answer:** nobody talks about a progress fill under open steps. That part is **reasoned
  from first principles**, together with the 26 Sep fill decision ([Row Colours — How the Fill Should
  Look](<../Home Screen and Visual Design/Today Screen Jobs/49. Row Colours — One Colour per Habit, and How the Fill Should Look.md>)):
  a white row with a light tint filling from the left, where the fill's length is the progress.
- Most of the evidence on done items and folding comes from to-do apps (Tasks, Google Tasks, Reminders, Microsoft To
  Do), whose sub-lists work like our steps.

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **Done items stay on the list, but look different** | 14 | *"I like being able to see what I've done today, but the little checkbox isn't enough for my brain to sepera[te]"* (P2#9318); *"if done should not disappear but could be greyed or with a line across"* (P126#158041); *"the encouraging sight of crossed out completed steps"* (P84#15051) |
| **One cue is too weak** | 2 | *"the strikethrough is not visually a strong enough immediate indication"* (A33#3273); the checkbox alone (P2#9318) |
| **The opposite view** | 1 | *"better not to strike task that is done, since tick mark is used"* (N10#11650) |
| **Long sub-lists should fold** | 12 | *"it still fills up the entire screen"* (N6#5802); *"If it could all tuck up under the main task with a little arrow to drop it down, then it would be perfect"* (N6#5518); praised: *"you see how many subtasks you have completed and that they are collapsible"* (P84#12588) |
| **The fold stays as left** | 1 | *"every time I collapse subtasks, I reopen the app just to find them all extended again"* (N1#18798) |
| **Done steps get out of the way** | 1 | *"sub-steps don't minimize when completed like regular tasks"* (N10#17923) |
| **Show how many are done** | 3 | *"a progress meter of how many subtasks completed"* (P84#19925) |
| **A tiny target does the wrong thing** | 1 | *"click very precisely on the tiny 0/3 line, otherwise you'll accidentally mark the whole habit as done"* (P37#214) |

## The design (Figma, Today: 1.7 and the new row 1.7.1–1.7.3)

| Part | Decision | Basis |
|---|---|---|
| **Two blocks** | The habit's block (its line, plus *Undo · + Note* after a tick) is filled from the left to *steps done / steps*, as every row is in 1.2. The steps are a separate white block under it, separated like the rows of a card | The user, 16 Oct. Reasoned: a fill under the steps marks unticked steps as progress, and grows with the list instead of with the progress (the 26 Sep fill decision) |
| **The count** | The subtitle says *1/4 steps* | Users show it (3) |
| **A ticked step** | The box fills with the habit's colour and a white ✓; the words turn grey (secondary text, still readable) and are crossed out | Users show it: keep it, but make it clearly different (14); one cue isn't enough (2) |
| **Order** | A ticked step stays in its place | Reasoned: steps are a sequence; U13 (order is the person's own). The to-do reviews that like done items sinking (P84#14344) are about shopping lists, not routines |
| **A long list (7 steps, 1.7.1)** | Every step is shown, 48 dp each; ⌃ folds it at any time; the fold is remembered for that day | Users show it: fold, and stay folded (12 + 1) |
| **The last step ticked (1.7.2)** | The line fills completely; the list stays open through the pause, so the tick is seen | U4: nothing moves during a run of taps |
| **After the pause (1.7.3)** | It folds itself, with *Undo · + Note* under it until the next log (the after-log rule); ⌄ opens it again, where any step can be unticked | Users show it (N10#17923); the after-log decision, 16 Oct |
| **Targets** | Each step's whole width is the target, 48 dp tall | Users show it (P37#214); Material's minimum touch target |
| **While open** | After a tick, *Undo · + Note* sit in the habit's block, as after every log; each step can also be unticked in place | The after-log decision, 16 Oct; the user's two blocks |

## Not decided, for the user

- ~~**The after-log line doesn't fit.**~~ Settled 16 Oct: every after-log line is now ↶ Undo · + Note (243 dp of 300),
  in the Android handoff's "the buttons after a log, short words".
- ~~**Whether other screens follow**~~: yes, the user, 16 Oct. Day details' and the routine player's checklists now show
  ticked steps grey and crossed out too.
- ~~**White pills on a partly filled row**~~: settled 16 Oct, every pill has a 1 dp light outline.

## Limits

- The counts are small and mostly from to-do apps.
- The open/closed fill is reasoned, not measured.
- Check the feel on a phone (U9).
