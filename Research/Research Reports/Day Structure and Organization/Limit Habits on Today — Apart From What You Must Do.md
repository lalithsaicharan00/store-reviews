Written by Claude (Claude Code), 5 October 2026.

# Limit Habits on Today — Apart From What You Must Do

**The user's question (5 Oct):** "Where do limit habits belong on Today? Right now cut-down habits sit in the times of
day, and that signals you have to log something. It isn't the case: when you set a limit, you log it only if you do
it. It isn't compulsory like building a habit. We have the Quitting section; do they go there? If they go only there,
remove the time of day choice from the cut-down habit."

**Answer, in short:**
- **Yes: limits leave the times of day and share one card with quit habits, "Quit or Cut Down".** Users show they
  want bad habits kept apart from the habits they build (≈13 ask for a separate section, tab or category), and that
  they log a limit **when it happens**, not on a schedule.
- **In a list of things to do, a limit is misread.** People work around it: they reword a bad habit so they can tick
  it, tick it at the end of the day, snooze its reminder until night, or get congratulated for ticking a habit they
  wanted to avoid.
- **So the Cut down form has no Time of Day,** and the card has no "N left" and no Start: nothing in it is a task.
  A limit keeps its ordinary row, its + to log and its reminders (U5: nothing is lost).

This revises the 29 Sep player decision "Cut-down items are check-ins" (a limit inside a time of day's routine): with
limits out of the times of day, routines hold only what's to do.

## How this was researched

- `Research/Temp/limitplace/scan.py` read all **1,238,784** reviews (App Store and Play Store, Hevy left out). It
  kept reviews that mention bad habits, quitting, cutting down or limits **and**, within about 220 characters, where
  they sit or how they feel to log (a separate section, tab or list; the to-do list; checking off; "feels like a
  task"; pressure, guilt): **309** reviews. Every one was read; most were about something else (a list of features, a
  quit counter) and were set aside.
- What's left is small and consistent; the counts are what was found, not a sample.

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **Keep bad or limit habits apart from the rest** (a section, a tab, a category) | **≈13** | "you should make a section for 'bad habits'" (`9880710444`); "a bad habit tracker section or page would be great, and helpful for separation of good and bad habits" (`13695520678`); "I would love to be able to create a section for 'bad habits'" (`13844953512`); "Please add a feature to limit bad habits. And separate them from others" (`7a420b47…`); "A second tab for bad habits… I know you can mix these on as the app is" (`8e46f2d2…`); also `9d88626d…`, `d6c3c368…`, `24d86a8e…`, `6037660882`, `13162425122`, `5881828433`, `7886599419` |
| **Log it when it happens, not on a schedule** | 3 | "in another section, you write the habits you want to stop doing and whenever you do them, you mark them" (`d6c3c368…`); "my target is to limit my caffeine intake to 2 coffees a day. I should be able to log each coffee I drink" (`6015057608`); "a reverse bad habit calendar where I only check off when I do something 'bad'" (`8e46f2d2…`) |
| **Workarounds when a limit sits among things to do** | 5 | Reworded bad habits "in a way that I can cross them off my list" (`9015696002`); "just use a normal habit and tick at end of day" (`13848651353`); "snooze it until you finish the day" (`5439d93b…`); "It also congratulates me when I tick check the bad habit 😅" (`c3263de2…`); reminders that kept coming for "don't do this today" habits (`10308923146`) |
| **A bad habit isn't tied to a time of day** | 2 | "replacing a bad habit might not always be day/time based… 'whenever I feel like having an unhealthy…'" (`11402101270`); "it does not occur at a specific time each day" (`11007001740`) |
| **Reminders can feel pushy for a bad habit** | 1 | "No push notifications. That's a little too proactive for someone trying to break bad habits" (`40e14d1b…`) |

### Reasoned from those

- **Where it sits says what it asks.** Every time of day on Today shows "N left" and a Start: it's a list of things
  to do. A limit there reads as one more thing to do, which is exactly what the user saw and what the workarounds
  show. A limit is a **ceiling**: an empty day is a good day.
- **Quit habits and limits ask the same thing of the person:** "tell me when it happens". The app already keeps quit
  habits in their own card without a status. One card for both answers the ask for a "bad habits section" without a
  new concept, and its name matches the choice people made when adding the habit ("Quit or cut down").
- **No Time of Day for a limit** follows: it would only decide which time of day it sits in, and it no longer sits in
  one. Reminders stay, off by default, for anyone who wants a nudge to log (U5); the one review against reminders is
  answered by their being off unless turned on.

## Decision (built 5 Oct 2026, branch `claude/timer-swipe-limits-and-fixes`)

| Where | What happens | Basis |
|---|---|---|
| **Today** | Limits (cut-down habits) sit in the **Quit or Cut Down** card with quit habits, in the person's own order, never in a time of day | Users show it: a separate section (≈13), log when it happens (3), workarounds (5) |
| **The card** | No "N left", no Start; folds like any card; keeps its place among the cards (Arrange Your Day moves it). Folded, its whole name shows | Reasoned: nothing in it is to do |
| **A limit's row** | Unchanged: its + logs one, its ▶ times a time limit, its Day sheet, swipes and menu as before. Shown on any day it applies (a coffee can be logged afterwards); quit counters stay today only | U5: nothing lost |
| **Routines** | A time of day's Start never includes a limit | Follows from the above; supersedes "Cut-down items are check-ins" (29 Sep) |
| **The Cut down form** | No Time of Day row; the sentence has no ", anytime"; a footer says "It shows on Today under Quit or Cut Down. Log it only when it happens." Reminders stay, off by default | The user's ask; users show bad habits aren't time-based (2) |
| **Existing limits** | Keep everything they saved, their time of day included (now unused by Today); history untouched | D6 |
| **The day bar and Progress** | Unchanged: a limit already never counted as "left" while its day is open | U10 |

**Checked:** `FocusPlayerUITests.testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown` and
`testOnlyALimitShowsUnderQuitOrCutDownWithoutStart`; `NewHabitUITests.testLimitCanBeAWeeklyTotal` (no Time of Day,
the footer) and `testLimitCanBeTimeAndStaysEditable` (the row sits under Quit or Cut Down); the card's new name in
`TodayUITests`, `LongTextUITests`, `RoutineCalendarUITests`. The look is for the iPhone (U9).
