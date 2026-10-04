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
| T1 | Fresh research, not a reuse of 28 Sep's: what people expect when they tap ▶ (in the row, a full-screen timer, something else) | [ ] |
| T2 | The Dynamic Island / Lock Screen: do people expect it, when should it appear, how should it behave, and a way to turn it off | [ ] |
| T3 | The bar at the bottom of Today above the day bar: does it belong, and how | [ ] |
| T4 | The row filling up while it runs: expected or not | [ ] |
| T5 | Implement what the research shows; test it thoroughly (UI tests, speed run, the iPhone) | [ ] |

## 2. Swipe actions (item 35)

**The user's words, tidied:** "If I swipe too much I directly add a note. Maybe a swipe should just reveal the options,
and then the person taps one. That's what I think, but if research shows something else, go with that. I'm not native
to the iPhone: research how people expect swipes to work there, even with two or three options, from the reviews and
from other resources on the internet, and implement swipe actions properly."

| # | Point | Done |
|---|---|---|
| W1 | Research: how swipes work natively on the iPhone with two or three actions, and what reviews show | [ ] |
| W2 | Implement it (the user's idea: a swipe only reveals; the research decides) | [ ] |

## 3. Time limits (item 37)

**The user's words, tidied:** "In quit habits we have units, but one habit was created earlier with minutes, which we
don't offer now. Do users expect that? A build habit could do it, but it isn't a good habit. Research whether there's a
real need for a timer in cut down; if yes, implement what the research says and let me know."

| # | Point | Done |
|---|---|---|
| L1 | Research: is a time limit ("social media 30 min max") a real need, and where it belongs | [ ] |
| L2 | Implement the result; an existing timed limit stays editable and its data safe either way | [ ] |

## 4. Then, in order

| # | Item | Done |
|---|---|---|
| H1 | 38: a folded time of day's icons, a scaled gap from the title, centred on the whole header | [ ] |
| H2 | 10: groups, tested properly | [ ] |
| H3 | 11: the ~74 s freeze after a signed-in launch | [ ] |
