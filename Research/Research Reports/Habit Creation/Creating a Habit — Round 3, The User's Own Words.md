Written by Claude (Claude Code), 28 September 2026.

# Creating a Habit — Round 3, The User's Own Words

The user rejected the Round 2 design ([Schedule and Goal — Round 2](<Schedule and Goal — Round 2, Making It Intuitive.md>)) as still rule-based. Their test: if someone says "I want to track my reading, my weekly goal is two chapters", or "I run 5K every day", it should go straight onto the screen as said. Today it doesn't. The sentence is split between a type screen, a Goal and a Schedule, and a hidden rule decides what + does.

This round did the research first. [How People Describe a Habit](<How People Describe a Habit — 4,407 Descriptions From Reviews.md>) collects **4,407 descriptions of 5,092 habits** from 922,405 reviews, read and coded by hand. The design below was built from them, then **checked against every one of them** (§3).

- **User's points:** [the Round 3 checklist](<../../../iOS/Docs/Checklists/Creating a Habit — Round 3, The User's Own Words Checklist.md>).
- **Evidence, including one row per statement:** [`Habit Creation Evidence/habit_descriptions_round3/`](<Habit Creation Evidence/habit_descriptions_round3/README.md>).
- **Mockups:** [New Habit — Round 3](https://claude.ai/artifact/ANKvCwMetGruSECAC2AiMY) (four iPhone screens: the form, How often, "say it", Today).

**Status: built 29 September 2026, at the user's go-ahead,** with the differences in §7. It has not yet been compiled or run on a phone (the cloud session has no Swift toolchain).

---

## The design in one sentence

> **A habit is the sentence the person would say. The form has one row for each part of it (the habit, how much, how often) and reads it back the way they'd say it: "Read 2 chapters a week".**

What follows from that:

1. **Schedule and Goal become one row, How often.** Its choices are the endings people actually say: "every day", "twice a day", "3 times a week", "on Mon, Wed, Fri", "every 3 days", "a week", "on the 1st of the month".
2. **The type screen goes.** The type follows from How much:
   - nothing → check it off;
   - minutes or hours → timer;
   - any other unit → an amount.
3. **+ always says what it adds** ("+1 glass", "+250 ml", "+5 km", "+1,000 steps"). Today's hidden rule, where + adds 1 for some habits and opens a number pad for others, goes.
4. **Type it as you'd say it.** Typing "Run 5 km 3 times a week" in the name offers to fill the rows. It is a suggestion, never applied silently.

---

## 1. What is wrong now, and the evidence

### 1.1 One sentence, three places

People say the rhythm and the amount in one breath: "8 glasses a day", "100 miles weekly", "30 minutes 5x per week". The hand codes for all 1,348 statements with an amount needed only two forms: an amount with its period, or an amount each time with a number of times. None needed a schedule and a separate goal. Today's flow splits the phrase up:

| They say | Today (built) | Round 3 |
|---|---|---|
| "Read 2 chapters a week" | Build → *How do you want to track it?* Track an amount → Goal: 2, chapters, *Goal counts over* A week → Schedule then reads "Any day this week" | Habit **Read** · How much **2 chapters** · How often **a week** |
| "Run 5 km, 3 times a week" | Track an amount → Goal 5 km (a day) → Schedule: Flexible days, 3 different days a week, with a confirmation when the goal isn't daily | **Run** · **5 km** · **3 times a week**, read back as "Run 5 km, 3 times a week" |
| "Brush twice a day" | Check it off → Goal 2 (a day) | **Brush** · How often **twice a day** |
| "Drink 8 glasses a day" | Check it off with the unit *glasses*, **or** Track an amount: two right answers, and the person must know the difference | **Drink water** · **8 glasses** |
| "Gym 3 times a week" | Check it off, then either a weekly Goal of 3 **or** Schedule "A number of days": two places hold the same thing | **Gym** · **3 times a week** |
| "Walk 10,000 steps" | Track an amount → Goal 10,000 steps; on Today + asks how much (a rule the person can't see) | **Walk** · **10,000 steps** (every day); Today shows **+1,000 steps** |

### 1.2 The type screen asks what the sentence already says

"2 chapters" is an amount, "30 minutes" is time, and "meditate every day" is check-off. The screen *How do you want to track it?* asks the person to classify their own sentence before they've said it. Reviews never describe a habit by its type; they describe it by what and how much (§3 of the descriptions document). Reasoned from first principles: a question whose answer is already in the user's words is a step that can only be answered wrong.

### 1.3 The hidden rule for +

`CountLogging.quickIncrement` (`iOS/Habits/Model/GoalInput.swift`): + adds 1 when the goal is a whole number up to 10, or when the unit is on a list of one-at-a-time units. Otherwise + opens the number pad. The Goal screen explains it in a footer, but on Today two habits with the same-looking + behave differently:

| Goal | What + does today |
|---|---|
| 12 chapters | adds 1 (chapters are on the list) |
| 12 pages | asks how much (pages aren't; 12 is over 10) |
| 2 laps | adds 1 (goal ≤ 10) |
| 2 km | asks how much (km is "measured") |
| 11 glasses | adds 1 |
| 11 push-ups | asks how much |

Users show what they expect a tap to be (167 reviews coded, §7 of the descriptions document):

- **One more of the thing I named** (57 reviews): "check off the amount each time" (`1383777971`).
- **A step of my own size** (13): "my bottles of water are 17oz each" (`6721564744`); "a custom +10 would be perfect" (`c4c14097-1651-4354-9c35-aa38a542d6e3`); "just click the '500ml' button" (`11323727126`).
- **Type the odd amount** (19).
- **Undo** (10).
- **Go past the goal** (32).

None of these is served by a rule that changes with the goal's size.

### 1.4 "Times" is counted as "days"

People say "3 times a week" 408 times and "3 days a week" 117 times, and they mean different things. Today, Schedule's "Flexible days" counts different dates only. Reviewers catch it: "taking 2 walks on the same day only credits 1 walk towards a 4-times-a-week goal" (`409fde25-5df1-4e14-a456-9074948a7e89`).

---

## 2. The design

### 2.1 Screen 1 stays

*What do you want to do?* → **Build or maintain · Quit or cut down · Add a task**. It names intent, which reviews don't state in any other way, and it was decided in the copy research. Tasks keep their own form.

### 2.2 The New Habit form

```
Cancel              New Habit               Add

        Read 2 chapters a week            ← the read-back, large, updates as you type

  Habit          Read
  How much       2 chapters                 ›
  Each + adds    1 chapter                  ›
  How often      a week                     ›
  On Today: +1 chapter · 0/2 this week

  Time of day    Anytime                    ›
  Reminders      None                       ›
  Ends           Never                      ›

  Steps          None                       ›
  Icon & colour                             ›
```

The **read-back** is the sentence, built only from the rows: name + how much + how often ("Read 2 chapters a week", "Run 5 km, 3 times a week", "Meditate every day", "Gym on Mon, Wed, Fri"). It follows the Goal Screen Round 2 rule that the goal is read back big at the top, not as a row. The line **On Today** says exactly what Today will show and what one tap does, before saving.

### 2.3 Habit: the name, or the whole sentence

- A name field (24 characters, as now), placeholder **"Name, or say it: Run 5 km 3 times a week"**.
- When what's typed contains an amount or a rhythm, a line appears under the field: **"Fill in: 5 km each time · 3 times a week"** with a **Use** button. Use fills How much and How often and trims the name to "Run". Ignoring it leaves the name as typed.
- It is never applied silently. The rows can always be set by hand, and every filled row can be changed.

Evidence and reasoning:

- The parser behind it (`describe.py`) agrees with the hand codes on **82.6%** of 3,602 single-habit review sentences, and on **85.7%** for the rows the form ends up with. That is on whole review sentences, which are harder than a typed name (§3.3). The user's two examples fill correctly.
- Users show a want for typed entry mostly in to-do apps: 62 of 67 natural-language reviews. In habit apps it is 5 reviews, including "it doesn't allow you to just type in habit, instead it quizzes you" (`dd5beccb-b430-4bfb-b97f-582dced19e32`). **Limited evidence**, so it is an offer, not the main path.

### 2.4 How much

| Choice | Means | Shown as |
|---|---|---|
| **Just do it** (default) | check it off | "Done or not" |
| **An amount**: a number and a unit | minutes and hours make it a timed habit; any other unit makes it an amount | "2 chapters", "30 min", "10,000 steps" |

- Units come from the existing grouped unit list (Drinking, Walking and running, Reading and writing, Exercise, Everyday, Money, plus Time) and ⊕ Create Your Own Unit.
- The unit stays optional. "8" with No Unit is fine.
- **Ranges** (100 statements, "3–5 cups"): the goal is the lower number, the number people treat as the target.
- **Cut down** uses the same row, read as **At most**: "At most 3 coffees a day". Limits are said exactly like goals, with the same periods (123 statements), so they get the same sentence with one word changed.
- **Quit** keeps "Stop completely" (82 statements; "allow a goal of Zero Per Day", `8468652583`), with no How much or How often.

### 2.5 How often: the endings people say

How often opens a list. **Every choice is written as the end of the person's sentence, with their amount in it.** That way the difference between "a week in total" and "each time" is read, never looked up.

| Choice, with no amount | Choice, with "2 chapters" | People's shape | Habits |
|---|---|---|---:|
| **Every day** | 2 chapters **a day** | F01, F02 | 2,403 |
| **__ times a day** | 2 chapters **each time, __ times a day** | F03 | 483 |
| **__ times a week** · **__ days a week** | 2 chapters **each time, __ times a week** | F04, F05 | 773 |
| **Once a week** | 2 chapters **a week** | F07, F06 | 297 |
| **On certain days** (M T W T F S S; Weekdays; Weekends) | 2 chapters **on Mon, Wed, Fri** | F08 | 223 |
| **Every __ days / weeks / months** | 2 chapters **every 3 days** | F09 | 198 |
| **__ times a month** · **Once a month** | 2 chapters **a month** · **each time, __ times a month** | F10, F11, F12 | 222 |
| **__ times a year** · **Once a year** | 2 chapters **a year** · **each time, __ times a year** | F13, F14, F15 | 67 |
| **On a date**: each month (the 15th · the first Saturday · the last day) or each year (1 October) | 2 chapters **on the 1st of each month** | X5 theme | 28 |

Rules the words already carry, so the app follows them rather than adding its own:

- **An amount with "a week / a month / a year" is the total** for that period ("100 miles weekly": 174 habits). **An amount with "N times" is each time** ("30 minutes 5x per week": 87 habits, a week, a day or a month). The read-back says which: "Read 2 chapters a week" vs "Run 5 km, 3 times a week".
- **"Times" counts every time; "days" counts different days.** "3 times a week": two walks on Sunday count 2. "3 days a week": they count 1. The picker is "__ [times ▾] a week", with times | days. People say both (408 vs 117) and complain when one is counted as the other (§1.4). For an amount each time, a time is a day on which the amount was reached ("5 km each time" counts days with 5 km logged), and the row's footer says so.
- **Six days on "On certain days" reads "Every day except Sun"**: "daily, except Wednesday" (`8044714695`), 16 statements with exceptions.
- **Not said means every day.** "Walk 5,000 steps" and "drink water in the morning" (F18, F17: 377 habits) arrive with How often set to **Every day**, shown and changeable.
- Nothing is greyed out and there are no confirmations: every choice is a complete sentence on its own, so no combination can contradict another row.

### 2.6 The type follows from How much

| How much | How often | Today shows | One tap |
|---|---|---|---|
| Just do it | once in its period | ✓ | done |
| Just do it | N times a day / week / month | ✓ with **1/3** | counts one |
| minutes or hours | any | **▶** and the clock "7:42/20 min" | ▶ starts in place (unchanged); tapping the row opens Add Time |
| any other unit | any | **+1 chapter**, **+250 ml**, **+5 km**, and "3/8 glasses" | adds the step written on it |
| any, with **Steps** | any | the steps | ticks a step |

**Checklist stops being a type.** It becomes an optional **Steps** row on any habit ("Clean kitchen: dishes, sink, floor"). The screen *How do you want to track it?* is removed, and so is the choice between "Check it off with glasses" and "Track an amount in glasses". A count in whole units that happen one at a time behaves the same whichever way it was entered.

### 2.7 The one logging rule: + adds what it says

- **Every amount habit's + shows its step:** "+1 glass", "+250 ml", "+5 km", "+1,000 steps".
- **The step is a row on the form, "Each + adds"**, filled in for the person; it is never a question they must answer. The earlier research decided against *asking* "Each tap adds"; this shows the answer instead.
  - Amount **each time** ("5 km, 3 times a week"): the step is that amount, +5 km.
  - Drinks by volume: one glass, **+250 ml / +8 oz / +0.25 L**. Drinks are 20.6% of amounts; "each 8 oz I drink" is how people log.
  - Whole counts up to 20 (glasses, chapters, books, pills): **+1**.
  - Bigger counts: **a round tenth of the goal** (10,000 steps → +1,000; 100 push-ups → +10, as asked in `0c0d9477-fd54-45fe-938c-4e07567c811f`).
  - Distances: +1 km / +1 mile.
- **Tapping the habit row opens Add Amount** (unchanged). It is a sheet with the number pad for the odd amount, "Add … again", and **Undo last** (10 reviews ask for undo or minus).
- **Logging never stops at the goal:** "7/5 km" (32 reviews).
- **Cut down** logs the same way ("+1 coffee"). Today reads "4 · limit 3" once over, as the limit rule already says; users show they want over-the-limit to read as not met (`12127257673`).

This replaces `CountLogging.quickIncrement` and its footer. Nothing on Today depends on the goal's size or a unit list.

### 2.8 When, and until when

- **Time of day:** unchanged.
- **Reminders:** unchanged, plus **Every __ hours, from __ to __** (default: 8 AM to 10 PM). "Every N hours" is a reminder rhythm in 47 statements, and a further 22 statements ask for spacing within a window.
- **Ends:** **Never · On a date · After __ days**. "for fourteen days" (`10121142973`), "for 66 days" (`772a9831-7325-46fd-a9f2-e9690c212fa7`): 31 statements give a length or an end. After N days is stored as the end date.

### 2.9 Editing

Changing How much or How often applies **from today**. Past days keep the goal they had, the Round 2 rule ("update habit of studying from 3 hours a day to 5 hours a day but still have all those days as done", `e4000cc2-b732-45b8-bdcd-bf5b4a2a214e`).

### 2.10 Out of scope, on purpose

These are asked for, and each is noted with its count so it can come back:

| Asked for | Statements | For now |
|---|---:|---|
| Different on different days, rotations, cycles ("twice on Sundays and three times on Mondays", `7893166567`) | 25 | one habit per variant |
| Progression ("studying time increases by 10 minutes every week", `148098dd-e1e7-49d2-8380-42a579041d2f`) | 10 | change the amount; it applies from today |
| Recording a value (weight, wake-up time) | 8 | not a habit shape here |
| Either/or, tiers, baseline + stretch | 6 | name it "Gym or run" |
| Averages and allowed misses | 11 | "6 times a week" covers a rest day; averages are not a goal |
| Rolling weeks, "N times in M days" | part of 22 | calendar weeks from your week start |
| Counted from the last time done | 9 | stays on tasks (Repeat after done); the Design Rules keep it off habits |

---

## 3. The cross-check: every description against the design

`crosscheck.py` takes each of the 5,092 hand-coded habits and asks: **with the words this person used, what does the form hold, and did anything have to be added?**

| Verdict | Meaning | Habits | Statements (worst habit in each) |
|---|---|---:|---:|
| **Direct** | their words fill How much and How often as said | 4,535 (89.1%) | 3,881 (88.1%) |
| **Default** | one unsaid thing is filled in and shown: every day (292 statements), reminder hours (46), the lower end of a range (100) | 463 (9.1%) | 434 (9.8%) |
| **Partial** | the habit fits; an extra they asked for doesn't (averages, rolling weeks) | 43 (0.8%) | 43 (1.0%) |
| **Not covered** | §2.10 | 51 (1.0%) | 49 (1.1%) |

Within Default, a statement can have more than one filled-in thing, so the reasons add to more than 434.

### 3.1 By shape

| Shape | Direct | Default | Partial | Not covered |
|---|---:|---:|---:|---:|
| F01 every day | 1,380 | 0 | 5 | 11 |
| F02 an amount a day | 965 | 33 | 4 | 5 |
| F03 several times a day | 466 | 15 | 1 | 1 |
| F04 N times a week | 676 | 36 | 15 | 6 |
| F05 an amount each time, N times a week | 34 | 6 | 0 | 0 |
| F06 an amount a week | 125 | 3 | 0 | 2 |
| F07 once a week | 165 | 0 | 0 | 2 |
| F08 set weekdays | 209 | 1 | 1 | 12 |
| F09 every N days, weeks or months | 183 | 1 | 10 | 4 |
| F10 monthly | 111 | 0 | 4 | 2 |
| F11 N times a month | 77 | 1 | 1 | 0 |
| F12 an amount a month | 25 | 0 | 0 | 1 |
| F13 yearly | 27 | 0 | 0 | 0 |
| F14 N times a year | 21 | 1 | 0 | 0 |
| F15 an amount a year | 18 | 0 | 0 | 0 |
| F16 every N hours | 0 | 48 | 1 | 0 |
| F17 time of day only | 0 | 166 | 0 | 0 |
| F18 an amount, no period | 53 | 152 | 1 | 5 |

Every shape people use has a How often choice worded the way they say it. The defaults are concentrated where the person didn't say how often (F17, F18) or gave a reminder rhythm (F16). There, the form shows **Every day** or **8 AM to 10 PM** for them to change.

### 3.2 Reading it the other way: the old flow against the same statements

Every Direct row above would need at least a type choice in today's flow. For most shapes it would also need a Goal and a Schedule, which are two screens for one phrase:

- 773 "N times a week" habits (F04, F05) have two places that could hold them (Goal A week, or Schedule Flexible days).
- The 40 "an amount each time, N times a week" habits need a daily goal plus a flexible schedule.
- Nothing in the table needs a period confirmation in Round 3.

### 3.3 The parser on the same statements

On the 3,602 statements with one habit and no extras, `describe.py` finds the same How often shape as the hand code **82.6%** of the time, and the same form rows **85.7%** of the time once "not said" means every day.

The main misses are sentences that describe a habit indirectly:

- "I set a goal for daily steps" names no number (84 read as check-off).
- "my goal is 30 minutes" leaves "a day" unsaid (132 read as no period; the form's default then gives the same result).
- "multiple times a day" phrased in ways the rules don't catch (57).

These are review sentences about habits, not habits typed into a name field, so on real input the rate should be higher. That still needs testing on the phone (§5).

---

## 4. What changes in the code (when approved)

| Area | Change |
|---|---|
| `NewHabitView` | Build or maintain goes straight to the form; the *How do you want to track it?* screen is removed. The form gets the read-back header and the rows Habit · How much · Each + adds · How often · On Today. |
| `GoalEditor`, `ScheduleEditor` | Merged into one **How often** list (§2.5). "Goal counts over", "Flexible days", "Count days over" and the "Use a goal for each scheduled day?" alert go. The monthly/yearly date pickers move under **On a date**. |
| `Habit` model | Reused, not replaced. The kind is set on save from How much: no amount → `.check`, time unit → `.duration`, other → `.amount(unit:increment:)`, with the increment from **Each + adds**. How often maps onto today's `Frequency`: every day `.daily`; certain days `.weekdays`; N times a day `.daily` with goal N (or N × each, increment each); N **times** a week/month/year `.perWeek/.perMonth/.perYear` (these already count every tick); N **days** a week `.flexible(.week, N)`; an amount each time, N times a week `.flexible(.week, N)` with the amount as the daily goal; a week/month/year in total the period goal; every N `.everyNDays/.everyNWeeks/.calendar`; on a date `.monthDates/.calendar`. **New:** a reminder interval with a window. |
| `GoalInput.swift` | `CountLogging.quickIncrement`, `measured`, `oneAtATime`, `tapLimit` and `explanation` removed. |
| `TodayRows` | + always shows and adds `increment` ("+250 ml"). Add Amount sheet gains **Undo last**. |
| New `HabitSentence.swift` | The `describe.py` rules in Swift, offline, with unit tests taken from `crosscheck.csv`. |
| Tests | `NewFlowUITests`, `GoalFlowUITests`, `NewHabitUITests`: labels change (Design Rules: update tests with labels). Add a test per row of §2.5 and the user's two sentences. |

---

## 5. What still needs checking

- **On the phone:** the How often list at the largest text size, and the read-back with a 24-character name.
- **Typing:** whether people use "say it" at all, and how often it fills something wrong. The reviews can't tell us this (limited evidence, §2.3); a small test with real people can.
- **The step defaults (§2.7)** are reasoned from the units people log in. Each one is visible and changeable, but whether they're right is a usability question, not a review count.

---

## 6. What changes from earlier decisions

| Earlier decision | Round 3 | Why |
|---|---|---|
| Round 2: Schedule says which days; Goal says what counts over a period; two rows | One row, **How often**, with the endings people say | The user rejected the split. The hand codes needed no schedule-plus-goal form (§1.1). |
| Type screen: Check it off · Track an amount · Time it · Checklist | Removed; the type follows from How much; Checklist becomes **Steps** | The sentence already answers it (§1.2) |
| Design Rules, Goal screen: "No 'Each tap adds' question; + adds 1 when whole ≤ 10 or one-at-a-time, otherwise asks" | **+ always shows its step**; "Each + adds" is a filled-in row, not a question | The user named this hidden rule (§1.3). Users show steps of their own size (13 reviews). |
| Design Rules, Logging a count: "+1" adds one, "+" opens Add Amount | Every + is "+step"; the row opens Add Amount | One rule instead of two |
| Design Rules: "Flexible schedules count different dates, never taps" | "times" counts every time; "days" counts different days | People say both (408 vs 117) and complain when times are counted as days (§1.4) |
| Round 2: senseless combinations greyed out with a reason | Nothing to grey out: each choice is a whole sentence | No combination of rows can contradict |
| Kept | Screen 1 · Cut down's Limit (now "At most") · ▶ timer in place · Add Amount sheet · units list · edits apply from today · dates of the month (now under On a date) · task repeat-after-done | |

**The Design Rules file is not changed yet.** It describes what is built. §6 is the list of edits it needs when this is approved.

---

## 7. Build notes (29 September 2026)

The user asked for the build with one emphasis: **the copy is the value** ("whatever users select, multiple days or multiple dates, it should read the way people read it", on Today and on the form). Checklist: [Round 3 Build — Copy, Days, Dates and Limits](<../../../iOS/Docs/Checklists/Round 3 Build — Copy, Days, Dates and Limits Checklist.md>).

**Built as designed:** one form for Build or maintain with the read-back sentence; How much (Just do it, an amount, or time); Each + adds; How often as sentence endings; Steps instead of the Checklist type; Cut down with Limit and a day, week or month; + always adds its saved step; "times" counts every time and "days" counts days; Today shows how often for rules that name days ("Every Mon and Wed", "Every Sun to Thu", "On the 1st of every month").

**The copy rules**, decided while building and checked in every combination:

- All 127 sets of weekdays, for weeks starting Sunday and Monday.
- 24 date patterns, each with and without "use the last day" and at three intervals.
- 54 calendar rules, each for weeks starting Sunday and Monday.
- 70 habit shapes, including the longest name and unit.

The rules are in the Design Rules ("Habit copy"). The Python reference and its print-outs are in `iOS/Tools/copy_oracle/`, and `CopyCheck` compares the app against them on the phone. The main decisions:

- **Weekday ranges:** a range only for one unbroken run of three or more days ("every Sunday to Thursday", "every Friday to Monday"). Mixed sets name every day, because "every Monday, and Wednesday to Friday" read worse than listing them.
- **Five days that aren't a run** read as "every day except Thursday and Saturday".
- **Dates:** "on the 1st to 3rd and the 15th"; "on odd dates"; more than six separate dates → "on 7 dates each month"; 28 or more → "every day except the 31st".
- **Sentences:** use whole, grouped numbers ("Walk 10,000 steps a day"; "k" stays on Today's progress line). Never "1 glasses". A name that is the unit isn't repeated ("100 push-ups a day").

**Different from the proposal:**

| Proposal | Built | Why |
|---|---|---|
| "Say it" fill-in from the name field | Not built | The user asked in the same message for short names, and kept limits (24 characters) cut a typed sentence short. There are only 5 habit-app reviews for it. It can come back with its own field. |
| "2 tablets each time, 3 times a day" | Not offered; an amount is per day, per total or on some days | It needs a new stored field (a schema change) |
| "5 km each time, 3 times a week" | Reads **"5 km on 3 days a week"** | It counts the days 5 km is reached, and the words now say exactly that |
| A task's schedule row, "Schedule" / "Repeat" | **How often**, with the same words as habits | One name for one thing |

**Known effect on existing habits:** amount habits made before this build saved a step of 1, so their + now adds 1 (for example, one step on an old 8,000-step habit). There is no edit screen yet, so re-create those habits; new ones get the suggested step.

**Tests:** `NewHabitUITests`, `GoalFlowUITests` and `ScheduleUITests` are rewritten for the new form. New tests cover:

- the user's examples;
- a weekday range on the form and on Today;
- Anytime never combining with another time of day;
- your own step;
- the time unit;
- the copy check.

The other UI tests that walked through the old type screen are updated.
