# Completion Sound, Squares Key and Notes Months — 5 Oct

Written by Claude (Claude Code), 5 October 2026, from the user's own words. Branch:
**`claude/timer-swipe-limits-and-fixes`**. Current Work Checklist items 18, 25 and the new 46, then a pass over the
whole checklist. Follows [the Rulebook](<../../../RULEBOOK.md>); T10 before every test run.

## 1. Completion sound and haptic (item 18)

**The user's words, tidied:** "Work on the completion sound and haptic for every kind of habit. Quit habits and Log
Slip don't get one: reaching a number there is a negative thing. For everything else it's overall completion: with 4
steps, only the 4th gives the sound. For an amount of 10, nothing at 8 or 9; as soon as it crosses 10 (it might go to
11, or be logged twice by hand), the log that crosses it gets the sound. Same for time. Work out typed time: a goal of
10 with 12 typed. Where the sound plays matters too. Right now some habits don't get it."

| # | Point | Done |
|---|---|---|
| C1 | One rule for every habit: the completion plays once, on the log that makes the habit complete (the day's goal, or the week's/month's for a period goal) | [x] `HabitStore+Feedback`: the store decides for every log, from any screen (Today, Day sheet, player, timer screen, typed logs, History's Add Entry, an edited log) |
| C2 | Checklist: only the last step | [x] |
| C3 | Amount: nothing on the way; the log that crosses the goal, even past it (9 → 11); nothing after | [x] |
| C4 | Time: a running timer plays it the moment its clock reaches the goal; if the app was away then, stopping it plays it; typed time that crosses the goal plays it on Log | [x] |
| C5 | Typed numbers (a goal of 10, 12 typed): plays when Log/Save is tapped, if it crossed; an edit that crosses plays on Save | [x] |
| C6 | Never for quit habits (Log Slip) or limits | [x] A light tap only |
| C7 | Where it plays: in the app only; a log from Siri, a widget or a notification stays silent | [x] |
| C8 | Tested | [x] `CompletionFeedbackUITests` passed (run `37268101680`), with FocusPlayer, Today and NewHabit. The speed run (`37276908176`) is being repeated: one 546 ms stall in Day-sheet scrolling, against 122 ms before |

## 2. "What the squares mean" (item 25)

**The user's words, tidied:** "The squares accordion should be open only the very first time; everywhere else after
that, closed."

| # | Point | Done |
|---|---|---|
| K1 | Open by itself only on the first visit to each place: each habit's page, Progress's Week, Month and Year | [x] `HeatKeyVisit` |
| K2 | Folded on every later visit; a tap opens it; never folds by itself during a visit (switching dates, scrolling it away) | [x] |
| K3 | Kept across launches; test launches start fresh (T8) | [x] |
| K4 | Tested | [ ] Progress passed (`WeekCardsUITests.testSquaresKeyOpensOnlyOnEachRangesFirstVisit`, run `37276908176`). The habit page failed: All Habits' link kept the page's state for the next push, so the second visit reused the first one's open key. Fixed (a new visit when the page is popped); rerun next |

## 3. Notes in month cards (new item 46)

**The user's words, tidied:** "In the habit details page, History has a card per month that folds; open by default,
and each day is a row in it. Notes need the same: a month card, each day's note a row in it, like History's entries.
Right now notes are added very weirdly."

| # | Point | Done |
|---|---|---|
| N1 | A card per month like History's: its name and "N notes", folding from its header, the newest two open | [x] `NoteMonthCard` |
| N2 | A row per day's note, dated as History's days are ("Sat 4 Today"), the note's first lines, opening the note | [x] |
| N3 | Search still works and opens every month it finds | [x] |
| N4 | Tested | [x] `HabitPageUITests.testNotesFoldByMonthLikeHistory` passed (run `37276908176`) |

## 4. The checklist pass

**The user's words, tidied:** "Whatever is completed in implementation and tested on GitHub, mark it completed.
Checking on the iPhone is a different thing; otherwise things get confused."

| # | Point | Done |
|---|---|---|
| A1 | Every item built and GitHub-tested is ticked and moved to Completed, with its iPhone check noted separately | [ ] |

## 5. History's buttons (item 26, added 5 Oct)

**The user's words, tidied:** "Work on item 26. Apart from the buttons being unreadable, they look a little big:
they aren't primary actions, they're secondary. People use them rarely, but for those who do, they should be good."

| # | Point | Done |
|---|---|---|
| B1 | Add Entry readable in light and dark (it was white text on the off-white ink fill in dark mode) | [x] |
| B2 | Add Entry and Go to Date sized as secondary actions: native size, not full-width and large | [x] Bordered, regular size, subheadline, side by side at their own width; Notes' Add Note the same (it had the same fill) |
| B4 | Notes: search was cramped beside a bigger Add Note. Decide inline search or a search page; Add Note the same size as History's buttons | [x] Inline search across the full width (it filters only this habit's notes; the months stay in view; the 4 Oct handoff), Add Note on its own row under it, one shared button style (`pageAction()`); no search while there are no notes |
| B3 | Tested; dark-mode picture | [ ] `HabitPageUITests.testHistoryFlows` (native width), `testNotesFlows` (search width, same button), `testPicturesDark` |

