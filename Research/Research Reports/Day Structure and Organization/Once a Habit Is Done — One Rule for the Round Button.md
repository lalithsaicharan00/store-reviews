Written by Claude (Claude Code), 16 October 2026.

# Once a Habit Is Done — One Rule for the Round Button

**The user's question (16 Oct):** a check habit's ✓ fills with its colour when done, and so does an amount's +. But a
checklist keeps a grey chevron, and a finished timer a grey ▶. "Should it become a check, or should it still be play
or pause … but a filled colour? … whatever it is, it needs to be consistent everywhere … the mental model needs to be
the same for everything." Android first.

## Answer, in short

**One rule for every kind: the fill says done; the symbol says what a tap does.**

| Kind | Not done yet | Done |
|---|---|---|
| Check | grey ✓ | ✓ in the habit's colour (tap: untick) |
| Amount | grey + | + in the habit's colour (tap: one more) |
| Time | grey ▶ | ▶ in the habit's colour (tap: another session); ⏸ while it runs on past the goal |
| Checklist | grey ⌄ | ⌄ in the habit's colour (tap: open the steps, any of which can be unticked) |
| Week or month goal, task | grey ✓ | ✓ in the habit's colour |

The whole row's fill, and its count (*8/8 glasses*, *4/4 steps*), say "done" alongside the button.

Turning every done button into a ✓ was considered and not chosen:

- **People keep going after the goal.** 18 reviews ask to log past it: *"letting you continue to tap your task after
  it's already marked 'complete'"* (A23#4533); *"If I reach my 10 glasses of water/day and get in 2 more I wanna record
  that!"* (A23#4826). A ✓ would hide the + and ▶ at exactly that moment.
- **A ✓ that adds would surprise people.** If the ✓ still added or started a timer, a tap would do something its symbol
  doesn't say. The 3 Oct research found that the second most common complaint about a row's button (15 reviews, 2.80★).
- **Telling done from not done** (6 reviews: *"hard to tell if it's been completed or not"*, A1#45581) is answered by
  three cues together: the full fill, the filled button and the count. One of them, the fill's length, doesn't depend
  on colour (P2#7625: green and red were hard to tell apart).

## How this was researched

- `Done State Evidence/scan.py` read every **App Store and Play Store** review (habit and to-do apps) for two
  questions:
  - logging past the goal (280 matches, mostly "above and beyond" praise of support teams and "can't add more than 3
    habits");
  - telling done from not done (20 matches).
- All of them were read by hand. `review_classification.py` keeps the themes, and `verify.py` checks all 25 quotes (0
  mismatches). The counts are **directional**.
- It builds on [Today's Rows — Tap, Swipe, the Day Sheet and Delete](<Today's Rows — Tap, Swipe, the Day Sheet and Delete.md>)
  (3 Oct): ✓ toggles, + adds and never takes back, and the button fills only when the goal is met.

## What changed in Figma (16 Oct)

Done rows whose button was still grey now use the habit's colour with a white symbol, in 9 rows across 8 frames:
- the done Stretch timer in 4.2, 4.3, 4.3.1, 1.8, 7.24, M.2 and M.2.1;
- the done Skincare checklist in 1.7.2 and 1.7.3.

The check, amount, week goal, task and running-timer rows already followed the rule.

## Limits

- The counts are small.
- Whether the ⌄ of a done checklist reads as "done" as clearly as a ✓ is reasoned, not tested. Check it on a phone
  (U9).
