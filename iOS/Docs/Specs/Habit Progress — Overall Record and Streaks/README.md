# Habit Progress — Overall Record, Streaks and Milestones

Written by Claude (Claude Code), 11 October 2026, at the user's request: improve a habit's Progress tab (Habit details →
Progress) one thing at a time: bring the streaks back where they can be seen, improve the Overall record card, then
redesign Milestones so they feel earned, for every habit type and every goal period. Current Work 29 (its 11 Oct
sub-points).

**Status: designed and approved by the user, 11 Oct 2026; ready to build. Not built.** Build from this document. Week,
Month and Year in Pixels are not part of this work and don't change.

- Figma: [section "Habit Progress — Overall record and streaks"](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=984-309)
  on the "onboarding" page (iPhone SE width, 375 pt; light mode; the page scrolls). Frames 1–5 below.
- Research: [Milestones That Feel Earned — Awards, Not Squares](<../../../../Research/Research Reports/Day Structure and Organization/Milestones That Feel Earned — Awards, Not Squares.md>)
  (11 Oct), [Milestones on the Habit Page](<../../../../Research/Research Reports/Day Structure and Organization/Milestones on the Habit Page — What to Mark and How to Show It.md>)
  (3 Oct, the ladders), [Streak Placement — Shared Header or Progress](<../../../../Research/Research Reports/Habit Details Research/Final UX Pass/Streak Placement — Shared Header or Progress.md>) (5 Oct).
- **Frame 1's old Milestones card (Figma node 984:360, the squares) is superseded and hidden.** Frame 1 shows Overall
  record only; Milestones are frames 2–5. Never build the squares again.

Contents: [1 What was wrong](#1-what-was-wrong) · [2 Overall record](#2-overall-record) ·
[3 Milestones](#3-milestones) · [4 The ladders](#4-the-ladders) ·
[5 Every habit type and goal period](#5-every-habit-type-and-goal-period) · [6 Edge cases](#6-edge-cases) ·
[7 Building it](#7-building-it) · [8 Open points](#8-open-points)

| Frame | What it shows | Image |
|---|---|---|
| 1 | Read (time habit, daily goal): Overall record with streaks | [1](<Images/1 Read — Progress tab top.png>) |
| 2 | Read: Milestones, one reached | [2](<Images/2 Read — Milestones as awards.png>) |
| 3 | A year of Read (example data): Milestones with 8 reached, scrolled | [3](<Images/3 Many reached — card.png>) |
| 4 | The All milestones page ("See all 8 ›") | [4](<Images/4 All milestones page.png>) |
| 5 | Exercise, 3 times a week (example data): weekly Overall record and Milestones | [5](<Images/5 Weekly goal — Exercise.png>) |

## 1. What was wrong

From the user's iPhone screenshots of Read's Progress tab, 11 Oct:

- **The streaks were hidden:** only a small grey "Now 0 · best 6" at the end of the Milestones card's "In a row" line.
  (This branch's code shows a Current / Best pair inside Milestones, Current Work 23; either way it sat under
  Milestones, not in the summary.)
- **Overall record read weakly:** after the headline, the numbers people look for were buried in grey sentences
  ("Goal met on 7 of 38 planned days · 18%", "Best day 21 min · 8 Oct").
- **Milestones felt like "just another record"** (the user): reached, next and later milestones were the same squares,
  and a long row of grey future squares ran to 5,000.

**What people want to see here (W6):** how it's going overall and their streak (current and best), then what they've
earned and the one thing to aim for next.

## 2. Overall record

![Frame 1](<Images/1 Read — Progress tab top.png>)

The summary card, first under "What the squares mean", with the streaks in it. Read's real numbers:

| Part | Shows | Style |
|---|---|---|
| Title line | **Overall record** · Since 2 Sep 2026 (right) | Headline / subheadline secondary, one line; at accessibility text sizes "Since …" goes under the title |
| Headline | **2 h 43 min** recorded | 28 pt bold value; "recorded" 17 pt secondary, same baseline |
| Box 1 | Current streak · **🔥 0** days | Box tinted with the habit's colour (14–16 %); 🔥 as on Today's row |
| Box 2 | Best streak · **6** days · 26 Sep – 1 Oct | Neutral box (`tertiarySystemFill`-like, 12 pt corners) |
| Box 3 | Goal met · **7** of 38 days · 18% of planned days | Neutral box |
| Box 4 | Best day · **21** min · 8 Oct | Neutral box |

- A 2 × 2 grid, 8 pt gaps, equal heights per row. Each box: label (13 pt secondary), the number (22 pt semibold) with
  its unit after it (15 pt regular), an optional detail line (13 pt secondary). Card padding 16, 16 between parts.
- **Current and Best always both show**, Best even when Current is 0. Best's detail is the best run's dates.
- **Show Streaks off removes boxes 1 and 2**; Goal met and Best day remain as one row.
- The percentage follows Progress's "Show percentages" option (today's behaviour).
- No average streak, no streak chart. Nothing counts against anyone (U3): a 0 streak gets no warning or invitation.
- On the iPhone SE the whole card is visible without scrolling (it ends at about 610 pt of 667).
- Quit habits keep their own Overall record card (current run, best run, clean days, slips, Log a Slip), unchanged.
- The copy comes from `habitRecord` as today (headline, goal-met wording per type); only the layout changes. Per type
  and per goal period: §5.

## 3. Milestones

### 3.1 The card

![Frame 2](<Images/2 Read — Milestones as awards.png>)

| Part | Read's example | Style |
|---|---|---|
| Title line | **Milestones** · "1 reached", or **See all N ›** once two or more are reached | Headline; right side subheadline secondary, chevron 13 pt semibold, monochrome |
| Latest | Medal **3** · "Latest" (only when there are earlier ones) · **3 days in a row** · Reached 28 Sep | 64 pt medal on a plate tinted with the habit's colour (12 %), 12 pt corners, 12 pt padding, 14 pt gap |
| Earlier | Shelf of 44 pt medals, newest first, each captioned (frames 3 and 5) | Scrolls sideways; the fifth peeks at the edge |
| Next | Label "Next", then one row per track | 13 pt secondary label; rows 12 pt apart |
| Next row | Ring **7** · **7 days in a row** · 7 to go | 48 pt ring, target number inside (17 pt bold, 15 pt for 3+ digits); title 17 semibold; detail 15 secondary |

**The medal:** a circle in the habit's colour, a light-to-deep gradient of it (top lighter), a fine white inner ring
(55 % white, 1.5 pt on 56–64 pt medals, 1 pt on 44 pt; inset 9 % of the size), a soft shadow in a dark shade of the
habit's colour (y 2, blur 6), the number in white bold at 40 % of the size (34 % for 3 digits, 28 % for 4+). Only
reached milestones are medals; nothing else on the page looks like one.

**The ring:** a grey track (`tertiarySystemFill`-like) with the habit's colour filling clockwise from the top. Its
fraction is **current ÷ target** for both tracks: the current run against the next in-a-row milestone, the total
against the next total milestone. (Today's code measures from the last milestone reached, which leaves it empty whenever
the current run is below the best.)

**What the card shows, by state:**
- **None reached:** no plate; "Next" with the first milestone of each track (3 days in a row; 10 times in total).
- **One reached:** the plate with that medal; no "Latest" kicker, no shelf; the right of the title says "1 reached".
- **Two or more:** the newest (from either track) on the plate with "Latest"; the rest on the Earlier shelf, newest
  first; **See all N ›** in the title line opens the All milestones page.
- **Every milestone of a track reached** (after 5,000 in total, say): that track's Next row says "Every milestone
  reached".
- **Next for in a row** is the first milestone not reached yet, so above the best run: with a current run of 18 and a
  best of 41, it's 50 ("32 to go · now 18, best 41"). The medals for 3, 7, 14 and 30 are already earned and aren't
  offered again.
- **Only the next milestone of each track is drawn.** Later ones are not shown on the card or the All page; each appears
  when the one before it is reached. This is a deliberate removal (U5): the row of grey future squares read as a to-do
  list of locked items and the far ones looked unreachable. **Every milestone that exists today stays, and the in-a-row
  ladders get more (§4)**; nothing is secret, only not listed.

**The shelf captions:** daily goals: "30 in a row" / "50 in total" + date ("20 Jan" this year, "Nov 2025" for earlier
years). Week, month and year goals need the unit, so two lines and no date: "8 weeks" / "in a row", "10 weeks" /
"goals met" (dates are on the All page and in VoiceOver). Quit: "30 days" / "since a slip".

**The reward moment** (it was the user's "surprise"): reaching a milestone still shows the line under the tapped row
on Today (the 30 Sep decision; `milestoneOffer`, unchanged). The first time the Progress tab opens after a new medal,
that medal scales in once with a light haptic (`.sensoryFeedback(.success)`), then never again; with Reduce Motion it
simply appears. No confetti, no sound, no pop-up.

### 3.2 Many reached, and See all

| Frame 3: the card, scrolled | Frame 4: All milestones |
|---|---|
| ![Frame 3](<Images/3 Many reached — card.png>) | ![Frame 4](<Images/4 All milestones page.png>) |

Example data (not Read's real history): a year of Read, started 2 Sep 2025; current run 18, best 41; 163 times in
total; 8 reached (3, 7, 14, 30 in a row; 10, 25, 50, 100 in total).

**The All milestones page:** pushed from **See all N ›**; one-line title **Milestones**, the back chevron, no ⋯.
- One card per track: **In a row** and **In total** (quit habits: **Since a slip**), each titled with "N reached".
- In each: the track's Next row (ring, title "Next: 50 days in a row", detail "32 to go · now 18, best 41"), a divider,
  then every reached medal (56 pt) in a three-column grid, newest first, each with its caption ("30 days", "100 times")
  and full date ("20 Jan 2026").
- Footnote under the cards: "Milestones you reach stay here, even when a run starts again."
- A track with none reached shows only its Next row.
- Show Streaks off: no In a row card.

### 3.3 VoiceOver

- A medal: "3 days in a row, reached 28 September 2026" (one element).
- A Next row: "Next: 50 days in a row, 32 to go. Now 18, best 41."
- See all: a button, "See all 8 milestones".
- Overall record's boxes: each one element ("Current streak, 0 days"; "Best streak, 6 days, 26 September to 1 October").

## 4. The ladders

**Every milestone value that exists today stays, in every ladder, up to 5,000 in total.** The new design changes how
milestones are shown (one next at a time, medals for reached); the user's 11 Oct request adds more in-a-row values.

### 4.1 In a row: about 15 per ladder (the user, 11 Oct 2026)

The user: the in-a-row milestones felt like "only three or four" for a habit; there should be more, "not 50 or 60 …
maybe 10, 15 if it makes sense". Each ladder below keeps every value it has today (**bold**) and adds values between
them (plain), so each goal period has about 15 milestones over the time a habit is realistically kept.

| Ladder | Milestones (today's values in bold) | How many |
|---|---|---|
| Days in a row (daily goals) and times in a row (selected days, every N days …) | **3**, **7**, 10, **14**, **30**, **50**, 75, **100**, 150, **200**, 250, **365**, **500**, **730**, **1,000**, then every 365 after 730 (**1,095**, **1,460** …) | 15 up to 1,000 days (10 today) |
| Weeks in a row (week goals) | **2**, 3, **4**, 6, **8**, 10, **12**, 16, 20, **26**, 39, **52**, 78, **104**, then every 52 (**156**, **208** …) | 15 by three years (8 today) |
| Months in a row (month goals) | 2, **3**, 4, 5, **6**, 9, **12**, 15, 18, **24**, 30, **36**, then every 12 (**48**, **60**, **72** …) | 12 by three years, 15 by six (5 today) |
| Years in a row (year goals) | 1, **2**, **3**, **4**, **5** … every year | one a year; a year goal can't sensibly have more |
| Days since a slip (quit) | **1**, **3**, **7**, 10, **14**, **30**, 45, **60**, **90**, 120, **180**, 270, **365**, 500, **730**, then every 365 | 15 up to two years (10 today) |

Why these: the early markers matter most (reviews write 3 days 135 times, 7 days 97, 10 days 42: the 3 Oct report),
so 10 days, 3 weeks and 2 months come early; later ones are spaced so no gap is longer than about the time already
done (75 between 50 and 100, 150 and 250 between 100 and 365, 39 and 78 weeks, 9 and 15 months). 21 and 66 days stay
out: they're "habit-forming" numbers with no evidence behind them (3 Oct report).

### 4.2 Everything else (unchanged)

| Track | Values (keep all of them) | Code |
|---|---|---|
| In total (goals met), every unit | 10, 25, 50, 100, 250, 500, 1,000, 2,500, 5,000 | `milestoneTracks` `totalLadder` |
| Today's after-tap line | a streak reaching any in-a-row value in §4.1; "All N done today" | `milestoneOffer` |

- **Where the code changes:** `StreakUnit.isMilestone` (`Milestones.swift`) for days/times, weeks, months and years;
  `HabitStore.quitMilestones` (`HabitStore+Phase2.swift`) for quit. Today's after-tap line uses the same ladders, so it
  will also mark the new values (10 days, 3 weeks, 2 months …); that's intended.
- **Self-checks to update** (`ProgressCheck` G19): `StreakUnit.days.milestones(upTo: 400)` becomes
  `[3, 7, 10, 14, 30, 50, 75, 100, 150, 200, 250, 365]`; `StreakUnit.weeks.nextMilestone(after: 4)` becomes 6. G9's
  quit "Next: 7 days · in 2 days" stays (nothing added below 7).
- Still a proposal, **not approved:** In total for month goals adding 3 and 6 before 10, and for year goals 2 and 5
  (E5). Build In total as above unless the user says yes.

## 5. Every habit type and goal period

### 5.1 Overall record by type

| Habit | Headline | Box 3 | Box 4 | Streak unit |
|---|---|---|---|---|
| Time, amount, several checks a day | "2 h 43 min recorded" | Goal met · X of Y days · % of planned days | **Best day** value · date | days |
| Check once a day | "Done on N days" | Goal met · X of Y days · % | none | days |
| Checklist | "N steps done" | Every step · X of Y days · % | none | days |
| Selected days / every N days | as its kind | Goal met · X of Y days · % | as its kind | times ("7 times in a row") |
| Week / month / year goal (any kind) | "N recorded" (a check: "28 times recorded") | Goal met · X of Y weeks (months, years) · % of weeks | **Best week / Best month / Best year** value · its dates ("5 times · 23–29 Aug") | weeks / months / years |
| Limit, a day ("at most") | "N recorded" | Within the limit · X of Y days · % | none | days |
| Limit, a week or month | "N recorded" | Within the limit · X of Y weeks · % | none | weeks / months |
| Quit | its own card, unchanged | | | days since a slip |
| Task | no Progress tab | | | |

When box 4 doesn't apply, Goal met takes the full width of its row (§8.1).

### 5.2 Week, month and year goals

![Frame 5](<Images/5 Weekly goal — Exercise.png>)

Example data: Exercise, a check habit, "Exercise 3 times a week", started Sun 2 Aug 2026 (weeks Sun–Sat), today Sat
10 Oct; 9 weeks over, goal met in 7 (missed 2–8 Aug and 6–12 Sep): runs of 4 weeks (9 Aug – 5 Sep) and 3 weeks
(13 Sep – 3 Oct, still going); this week 2 of 3; 28 times in all; best week 5 times (23–29 Aug).

What already works in the code, for every habit kind: the streak counts periods whose goal was met, in the goal's
unit; the period running now never breaks a run and adds as soon as its goal is met; a paused period is skipped, not
broken; a limit's period counts only once it's over; Today shows "3 wk" / "2 mo" beside the 🔥.

- **Current streak** shows the running period under it: **"This week: 2 of 3"** ("This month: 1 h 20 min of 4 h"), so
  "3 weeks" doesn't look stale midweek; once met, "This week: done". Day goals have no detail line here. Limits omit it.
- **Best streak:** "4 weeks · 9 Aug – 5 Sep". **Goal met:** "7 of 9 weeks · 78% of weeks".
- **Best week / month / year** replaces Best day (the goal is the period's): the period with the most recorded, with its
  dates. Limits have none.
- **Milestones:** Latest "4 weeks in a row · Reached 3 Sep" (the day that week's goal was met, E3); Next "8 weeks in a
  row · 5 to go · now 3, best 4" and **"10 weeks of goals met · 3 to go · 7 so far"**. The total track says "weeks
  (months) of goals met", never "10 weeks in total", which reads as a length of time.
- Progress inside the running week otherwise stays on the Week card.

### 5.3 Milestone wording by type

| Habit | In a row | In total |
|---|---|---|
| Daily goal | "7 days in a row" | "10 times in total" |
| Selected days / every N days | "7 times in a row" | "10 times in total" |
| Week / month / year goal | "8 weeks in a row" | "10 weeks of goals met" |
| Day limit | "7 days in a row" | "10 days within the limit" |
| Week / month limit | "4 weeks in a row" | "10 weeks within the limit" |
| Quit | — | — ; one track: "30 days since a slip" |

## 6. Edge cases

Found in the code on `app-lock-privacy-security` (`Milestones.swift`; `HabitStore+HabitPage.swift` `milestoneTracks`,
`habitRecord`, `nthCounted`; `HabitStore.swift` `walkRuns`; `Habit.swift` `streakUnit`). E1–E3 are bugs to fix in this
build; E4 and E6 are answered by the new ladders (§4.1); E5 is still a proposal.

| # | What happens today | Example | Build this |
|---|---|---|---|
| E1 | **Changing the goal's period resets milestones.** Runs and totals are worked out only in today's goal unit; periods under another goal are skipped | 30 weeks of a week goal, then changed to a day goal: "8 weeks in a row" and "25 weeks of goals met" vanish; Best streak drops | Work out each goal era in its own unit and **keep every medal reached** ("8 weeks in a row" stays after the change, in weeks). Best streak and the Next rows follow today's goal; the current run starts with the new goal's effective date (D6). Reached milestones never go (reviews: lost achievements 3.0★) |
| E2 | **Totals mix days and weeks.** After a change from an amount-or-count-a-day goal (`flexible(.day)`) to a week goal, each old day counts as a "week" in Goal met and In total | 40 days of "20 min a day", then "2 h a week": "Goal met in 46 of 50 weeks" | Goal met and the In total count only periods of today's unit; earlier eras keep their own medals (E1) |
| E3 | **A period's reached date drifts.** `nthCounted` and `habitRecord.metDates` use the period's last day, or today while it's running | Week goal met Wed 8 Oct: the medal says 8 Oct, 9 Oct, 10 Oct … then Sat 11 Oct | The date is **the day the period's goal was met** (the day of the entry that met it) |
| E4 | Month milestones are sparse: 3, 6, 12, then every 12 | First medal after 3 months; nothing between 12 and 24 | Decided: the months ladder of §4.1 (2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 36, then every 12) |
| E5 | In total uses 10 … 5,000 for every unit | A month goal: 25 months of goals met is two years away | Keep 10 … 5,000; proposed, not approved: add 3, 6 for months, 2, 5 for years (§4.2) |
| E6 | Year goals start at 2 years in a row | Nothing for the first year | Decided: every year from 1 (§4.1) |
| E7 | A run reaching a milestone a second time | Best 41, a new run reaches 7 again | No second medal: a milestone is reached once, dated by the first run that reached it. Today's after-tap line still says "7 days in a row" (it's about the current run) |
| E8 | Editing or deleting an entry | The entry that reached 30 days is deleted | Milestones are worked out from records, never stored, so the medal moves or goes honestly (as today) |
| E9 | Show Streaks off | | No streak boxes, no in-a-row medals, Next row or All-page card; In total stays (as today) |
| E10 | Archive, pause, week start or day start changes | | Paused periods are skipped (as today). Week start and day start apply everywhere (D7), so a change recomputes runs and dates; medals follow the records |
| E11 | Habit started midweek | First week is partial | Counted when its goal is met (as today, `max(range.lowerBound, startDay)`) |

## 7. Building it

**Views** (`iOS/Habits/AllHabits/HabitProgressTab.swift`):
- `HabitRecordCard`: the new layout (§2): title line, headline, a `Grid` of fact boxes (never a lazy grid in a list,
  S13); at accessibility text sizes one column, chosen from `dynamicTypeSize` (no `ViewThatFits`, S10).
- Move the streak facts (`StreakFact`, ids `habit-streak-current` / `habit-streak-best`) from `MilestoneTrackView`
  into the Overall record boxes; keep `habit-progress-record`.
- Replace `MilestonesCard` / `MilestoneTrackView` / `MilestoneToken` / `ProgressTrack` with: `MilestoneMedal` (size,
  number, colour), the Latest plate, the Earlier shelf (a horizontal `ScrollView`), `MilestoneNextRow` with a ring
  (`Circle().trim(from: 0, to: fraction)` stroked; no `GeometryReader`), and `AllMilestonesPage` pushed by a
  `navigationDestination` the page holds (U27 pattern). Keep `habit-milestones`; add `habit-milestone-latest`,
  `habit-milestones-see-all`, `habit-milestone-next-inARow`, `habit-milestone-next-inTotal`, `all-milestones`.
- Medal colours come from the habit's colour (`HabitColor.mark` and lighter/darker shades of it) in light and dark
  mode; check the white number's contrast in both (a dark version wasn't drawn).
- The "first seen" scale-in: remember, per habit, the medals already shown; write it only when a new medal is first
  shown (S15), never per data change; test launches keep their own (D8).

**Model** (`HabitStore+HabitPage.swift`, worked out once in `HabitPageModel`, never in `body`, S5):
- `HabitOverall` gains the streak facts (current, best, best run's dates), the running period's progress ("This week:
  2 of 3") and Best week / month / year for period goals.
- `milestoneTracks`: E1 (eras, kept medals), E3 (dates), the ring fraction (current ÷ target), the wording of §5.3.
- `habitRecord`: E2 and E3 for Goal met.
- Ladders: the in-a-row and quit ladders of §4.1 (adding values only); In total unchanged (§4.2).

**Tests:** update the UI tests that read the old Milestones and streaks (`ProgressUITests.testHabitPageYearAndMilestones`,
`HabitPageUITests.testStreaksOnTheProgressTab`) in the same change (T3); add `ProgressCheck` cases
for E1–E3 and E7 (a week goal changed to a day goal keeps "8 weeks in a row"; a week met on Wednesday is dated
Wednesday); a `PerfDriver` scenario for the All milestones page (T4) and a speed run (S2); the SE layout
(`SmallScreenUITests`, T15); check on the iPhone in light and dark mode (U9).

## 8. Open points

1. **Goal met spanning the row when box 4 doesn't apply** (check once a day, checklist, limits; and with Show Streaks
   off and no best day, Goal met alone). Recommended and assumed in §5.1; the user hasn't confirmed it. Build it this
   way unless they say otherwise.
2. **In total for month and year goals** (E5, §4.2): not approved; build In total as 10 … 5,000.
3. **Dark mode** wasn't drawn; follow the light frames with the system's dark colours (the user's phone is in dark
   mode, so check it there).
