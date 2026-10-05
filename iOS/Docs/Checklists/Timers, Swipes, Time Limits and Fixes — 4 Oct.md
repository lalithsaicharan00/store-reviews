# Timers, Swipes, Time Limits and Fixes — 4 Oct

Written by Claude (Claude Code), 4 October 2026, from the user's own words. Branch:
**`claude/timer-swipe-limits-and-fixes`**. Current Work Checklist items 16 (with 15), 35, 37, 38, 10 and 11, worked
**one after the other in this order** (the user's priority). Each is researched where asked, built, tested and recorded
before the next. Follows [the Rulebook](<../../../RULEBOOK.md>); T10 before every test run.

## 1. Timers (items 16 and 15)

**The user's words, tidied:** "When we start the timer it just runs in the row. Then it goes automatically into the
Dynamic Island, and it also stays at the bottom of Today, right above the day bar and its chevrons. It might be based on
previous research, but it isn't intuitive; to me it feels weird. Research how users expect the timer to be: when they
tap ▶, do they expect a full-screen timer, or what? Do they expect it in the Dynamic Island, and if so how should it
work? Do they expect it to start in the row with the row filling up? Test those expectations correctly from the
reviews, then implement it properly and test it thoroughly."

| # | Point | Done |
|---|---|---|
| T1 | Fresh research, not a reuse of 28 Sep's: what people expect when they tap ▶ (in the row, a full-screen timer, something else) | [x] Report "Timers — What People Expect When They Tap ▶": 281 timer reviews read on four questions; a big timer is wanted (≈12), a trap isn't (5) |
| T2 | The Dynamic Island / Lock Screen: do people expect it, when should it appear, how should it behave, and a way to turn it off | [x] Wanted (≈41); it ends the moment the timer stops, gets Pause and opens that timer; ≡ → Appearance → Timers → Show on Lock Screen turns it off |
| T3 | The bar at the bottom of Today above the day bar: does it belong, and how | [x] Kept as a Now Playing bar: only while the row is out of sight; tapping it opens the timer full screen |
| T4 | The row filling up while it runs: expected or not | [x] Kept: filling bars help (3 reviews); ▶ now also opens the timer full screen, which a swipe puts away while it runs |
| T5 | Implement what the research shows; test it thoroughly (UI tests, speed run, the iPhone) | [x] TimerUITests (5), Undo, FocusPlayer, RoutineCalendar, Today passed; speed: the timer screen's clock 5.6 ms/s, no freeze; +1 and day ‹ › 75.8 vs `main` 97.4. Found on the way: the player dropped a tap made during a save, Undo included (fixed, S7). **Still yours: the iPhone (U9)** |

## 2. Swipe actions (item 35)

**The user's words, tidied:** "If I swipe too much I directly add a note. Maybe a swipe should just reveal the options,
and then the person taps one. That's what I think, but if research shows something else, go with that. I'm not native
to the iPhone: research how people expect swipes to work there, even with two or three options, from the reviews and
from other resources on the internet, and implement swipe actions properly."

| # | Point | Done |
|---|---|---|
| W1 | Research: how swipes work natively on the iPhone with two or three actions, and what reviews show | [x] Report "Swipe Actions — Reveal, Never Act": 947 swipe reviews; ≈15 swipes that acted on their own, one person who quit over three buttons behind one swipe |
| W2 | Implement it (the user's idea: a swipe only reveals; the research decides) | [x] A swipe only reveals, however far; left Skip then Note, right a named Undo; Pause in the long-press menu. U14 updated. TodayRowSheet and TodayRowLayout passed. **Still yours: the iPhone (U9)** |

## 3. Time limits (item 37)

**The user's words, tidied:** "In quit habits we have units, but one habit was created earlier with minutes, which we
don't offer now. Do users expect that? A build habit could do it, but it isn't a good habit. Research whether there's a
real need for a timer in cut down; if yes, implement what the research says and let me know."

| # | Point | Done |
|---|---|---|
| L1 | Research: is a time limit ("social media 30 min max") a real need, and where it belongs | [x] Report "Time Limits — Should Cut Down Allow Time": a genuine need (≈7 explicit asks across TV, Netflix, Instagram, phone time); Screen Time integration recorded as Current Work 45 |
| L2 | Implement the result; an existing timed limit stays editable and its data safe either way | [x] A Limit can be in minutes; an existing limit is editable and keeps its unit side (D6). `testLimitCanBeTimeAndStaysEditable` passed |

## 4. Then, in order

| # | Item | Done |
|---|---|---|
| H1 | 38: a folded time of day's icons, a scaled gap from the title, centred on the whole header | [x] Built; SectionHeader passed; Today scrolling 19.6 ms/s (in the recent 16–37 range). **Still yours: the iPhone (U9)** |
| H2 | 10: groups, tested properly | [x] Four new tests: deleting a full group keeps its habits, your order and the chips follow, Today and Progress keep their own choice, Start plays only what's shown, names unique, a group pauses. Groups 9/9 passed |
| H3 | 11: the ~74 s freeze after a signed-in launch | [x] Likely cause fixed: the sign-in wrote the Keychain on the main thread; all Keychain calls now run off it. Each launch step's time goes to the system log, saved by CI as `app.log`. Backup and Sync passed; it was intermittent (4 of 13), so it's confirmed only as runs keep passing |

**Tests (4 Oct 2026, GitHub):** `95310e2` Today 8/8; `6918c8d` FocusPlayer, Timer, RoutineCalendar, Undo (33),
TodayRowLayout, SectionHeader, Groups (9), Backup; `4b603dc` NewHabit (20), TodayRowSheet, Sync. Everything these
items touch passed. One lesson recorded in Rulebook T1 (a cancelled run still counts until it shows completed).

## 5. Limit habits on Today (item 14, added 5 Oct)

**The user's words, tidied:** "Where do limit habits belong on Today? We have the Quitting section. Right now cut-down
habits are included in the other sections (the times of day), and that signals you have to log something. It isn't the
case: when you set a limit, you log only if you do it; it isn't compulsory like building a habit. Do your own research
from reviews if you want, then implement it. If they go only in the Quitting section, remove the time of day selection
from the cut-down habit."

| # | Point | Done |
|---|---|---|
| Q1 | Research: do people expect limit habits apart from the habits they must do, and logged only when they happen | [x] Report "Limit Habits on Today — Apart From What You Must Do": 309 reviews read; ≈13 want them apart, 3 log when it happens, 5 work around limits in a to-do list |
| Q2 | Limit habits leave the times of day and sit with quitting on Today | [x] One card, "Quit or Cut Down", in the person's order; no "N left", no Start, never in a routine; Arrange Your Day the same |
| Q3 | The Cut down form has no Time of Day | [x] No row, no ", anytime"; a footer says where it shows and that it's logged only when it happens |
| Q4 | Nothing lost: existing limits keep their data; tests and docs follow | [x] Existing limits keep every saved field (D6); Design Rules updated; FocusPlayer's limit tests rewritten for the new place (reasons in Design Rules). Passed on GitHub, 5 Oct: NewHabit 20, FocusPlayer 13, Today 8, HabitScenario, HabitCreation's cut-down, LongText, RoutineCalendar; Today's speed as before. **Still yours: the iPhone (U9)** |
