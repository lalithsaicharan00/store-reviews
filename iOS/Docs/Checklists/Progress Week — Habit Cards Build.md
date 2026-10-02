# Progress Week — Habit Cards Build

Written by Claude (Claude Code), 2 October 2026. Branch: **`claude/progress-week-cards`**, made from
`claude/server-and-sync` at `5457ec2` (the newest tested code that day: `main` plus five speed and data-safety
commits; `integration` was level with `main`). **Built on Linux, not compiled or run yet:** another agent tests it
(the user: "complete the task, don't test; another agent tests"). A first GitHub build was started with the push (see
"Results" below).

**Why this exists (the user's words, tidied):** the overview card ("Done so far 53 of 55 · 96%") and the day rings
don't state facts once a habit is weekly, monthly, every few days, several times a day or a quit habit. Remove the
overview and the calendar rings, from Progress and from the calendar opened on Today, but keep the ring on Today's
bottom bar. Remove the group numbers too. Build Week as one card per habit (the Figma frame, node 238-355), with
facts only and nothing said twice, a date range at the top, a key for what each mark means, a clear spacing
hierarchy, one-line names, and legible checkmarks. Only Week for now.

Research behind it: [Weekly Habit Cards — What Each Card Shows](<../../../Research/Research Reports/Progress and Statistics/Weekly Habit Cards — What Each Card Shows.md>)
(2,994 reviews hand-coded; the framework for every habit type is its §5).

## The user's points

| # | Point | Done |
|---|---|---|
| U1 | Take the work from the newest tested branch, not from scratch | [x] `claude/server-and-sync` (above). The research commits copied over by cherry-pick |
| U2 | The old research branch: a note saying why it exists, marked safe to delete | [x] `BRANCH NOTE — Research, Safe to Delete.md` on `claude/weekly-overview-stats-ly55gk`; listed in [Merging the Branches](<Merging the Branches.md>) |
| U3 | Remove the overview (Week) | [x] No overview card, day rings, tiles, "Last week: 31 of 42" or Groups card on Week. Month and Year unchanged until they're redesigned |
| U4 | Remove the calendar rings on Today's calendar sheet; keep the bottom bar's ring | [x] `CalendarSheet` shows plain dates (`CalendarDate`); `DayLabel`'s ring untouched |
| U5 | Remove group numbers and group headers (Week) | [x] Week is one list of cards in the habits' order; the group chips still choose which cards show. No "● Health · 24 of 30 · 80%", no Groups card |
| U6 | A card per habit, facts only, never the same fact twice | [x] `ProgressWeekCard`: goal in words · headline on the goal's own clock · at most one different fact · Sun–Sat strip with each day's value. No percentages, no "Today ·" line (today's value is under today) |
| U7 | A date range at the top instead of "This week" | [x] "27 Sep – 3 Oct" (or "21–27 Sep"), "This week" / "Last week" small under it; year added for other years |
| U8 | Weekday names only on the cards, no dates | [x] "Sun Mon Tue…", today semibold and underlined; VoiceOver says the full date |
| U9 | Sticky or not: research it, keep the scroll area large | [x] Only the dates bar is pinned (one 44-pt row). Week/Month/Year, the chips and the key scroll away. Below |
| U10 | Under the group chips, what each mark means | [x] `WeekKey`: one quiet row, "What the marks mean ⌄"; tapping opens **every** mark (not only this week's) with its name and one sentence, and "Show less" folds it. Revised after the user saw the first version (2 Oct): the always-open key was too much, and "Part done", "Not due" and "Coming up" were unclear |
| U16 | Clearer words and symbols for the marks | [x] **Partial** (was Part done), **Not done**, **Today, still open**, **Due later this week** (was Coming up; now a small ring, so it can't look like Not done), **Not scheduled** (was Not due; now a short dash), **Skipped**, **Paused**, **Over the limit**, **Before it started**; quit: **Clean day**, **Slip**. The same words in VoiceOver, the habit page and How It's Counted |
| U17 | One check colour everywhere | [x] White on every colour. Revised (2 Oct, the user: the deepened colours looked darker than purple): every habit colour for marks **and icons** now sits at one shared lightness (`HabitColor.mark`) |
| U19 | Month the same as Week | [x] Month uses the same cards (2 Oct): the month's name pinned at the top ("October", "This month" under it), the chips, the folded key, then a card per habit with its headline on the goal's own clock for the month and a small calendar of marks (weekday letters once, one 22-pt mark per day, today's weekday letter underlined). **No values under the marks** (the user: Month is for seeing patterns; values would make cards tall). A week goal on Month says how many of its weeks were met ("Met 3 of 4 weeks"). Year is unchanged |
| U20 | Year as GitHub's heat map | [x] Year uses the same cards (2 Oct): "2026 · This year" pinned, chips, the folded key, then a card per habit with its year on the goal's own clock ("Reached on 212 of 270 days so far", "Met 38 of 52 weeks") and the year as a grid of **rounded squares** (18 pt, 4-pt gaps): weeks as columns, weekdays as rows with their letters fixed on the left (today's bold and underlined), months on top. The last column holds today; nothing after it is drawn. Only the squares scroll sideways, opening on the latest weeks. Every day a grey square until filled: done = colour; partial = three lighter OKLCH steps (`HabitColor.yearShade`, one lightness per step for every hue, deeper in dark mode); more than the goal, or a limit's day over it = colour with a white ▲; not scheduled = dashed outline; skipped / paused = grey with the sign; slip = grey with ×; today = grey until logged. The key lists every square, with Partial's three steps side by side. No group numbers, percentages, Groups card or share button on Progress any more |
| U18 | Over the limit not grey | [x] The user chose option A: a ring and ▲ in the habit's own colour, never solid (a solid circle is a day within the limit). On the Week cards, Month strips and the day sheet |
| U11 | Spacing hierarchy from proper rules; nothing squeezed | [x] 8-point scale, space inside a group smaller than around it. Below |
| U12 | A long name stays on one line with "…" | [x] `lineLimit(1)`, tail truncation; goal line also one line |
| U13 | Checkmarks: legible and good-looking, no black checks | [x] White check on the habit's colour where it reaches 3:1; on the six light colours a deep shade of the same colour. Below |
| U14 | Follow every speed rule and keep data safe | [x] Below. `check_rules.sh` passes. Progress only reads; no storage or model changes |
| U15 | A document explaining the branch, for merging | [x] This file |

## Decisions, with reasons

**Sticky header: only the dates bar.** Nielsen Norman Group's guidance on sticky headers: keep them as small as
possible (the content-to-chrome ratio), and only make sticky what's needed "often or at any point" while scrolling.
On Week the one thing needed anywhere in the list is *which week these cards show* and ‹ › to change it. Week |
Month | Year is chosen once per visit and replaces the whole page, and the chips filter once, so both scroll away
with the key. Result: one 44-point row (~52 pt with padding), about 8% of a small iPhone's screen, against 23–30% if
the tabs and chips stuck too. It's a `LazyVStack` section header (`pinnedViews: [.sectionHeaders]`): it scrolls up
with the page until it reaches the top, then stays, on the page's own background so cards slide under it.
Sources: [NN/g, Sticky Headers: 5 Ways to Make Them Better](https://www.nngroup.com/articles/sticky-headers/).

**Spacing (`WeekSpacing` in `WeekCards.swift`).** An 8-point scale with the internal ≤ external rule (space inside a
group never larger than the space around it; Gestalt proximity), from
[Cieden's spacing best practices](https://cieden.com/book/sub-atomic/spacing/spacing-best-practices):

| Space | Points | Where |
|---|---|---|
| label | 2 | name ↔ goal line (one label) |
| pair | 4 | headline ↔ second line; a mark ↔ its value |
| tight | 8 | tabs ↔ dates bar; weekday ↔ mark; key rows |
| card | 16 | card padding; gap between cards; header ↔ numbers; numbers ↔ strip; chips ↔ key |
| section | 24 | the controls above ↔ the first card |

Type, largest information first: headline `title3` semibold (the week's fact), name `headline`, goal and second line
`subheadline` secondary, weekdays `caption`, values `caption2`. Icon 40 pt (two lines of text tall), marks 28 pt,
card corners 16.

**Colours and checks (`HabitColor.mark`).** One check colour everywhere: white. Every habit colour used for marks and
icons sits at one perceived lightness, OKLCH 0.64, keeping its hue and as much saturation as the screen allows. 0.64
is the lightest level where white reaches 3:1 (WCAG 1.4.11) on all thirteen colours (3.1–3.8:1). Light and dark mode
land on nearly the same values, so one table serves both. The first try (mixing the light colours with black) reached
the same lightness but drained their saturation, so orange and yellow looked muddy and darker than purple; equal
lightness with saturation kept fixes that. Yellow becomes a mustard (#AA8809) at this strength. Charts and Today's row
fills keep the plain colours for now.

**The key (`WeekKey`).** Progressive disclosure (NN/g): the meanings are one tap away, right where the marks first
appear, and the page stays clean until someone asks. It lists every mark, not only this week's, so nothing new appears
unexplained later. Words say what happened and never judge it (no "missed", "failed" or "relapse", Design Rules), and
no two names can describe the same day.

**The marks** (`WeekMark`): filled + white check (done; quit: clean day), part ring (partial), grey ring (not done),
dashed ring (today, still open), ring with ▲ (over the limit), ring with × (quit slip), ▶▶ or ❙❙ on a grey disc
(skipped, paused), small ring in the habit's colour (due later this week), short dash (not scheduled), nothing (before
it started). Over the limit is a ring and ▲ in the habit's own colour (not grey, never solid). Never red; every state
differs by shape.

## What each card says

From the report's §5; the code is `HabitStore+WeekCards.swift`.

| Habit | Headline | Second line (only if it adds something) |
|---|---|---|
| Once a day / set days / every N days | `4 of 5 days so far` | `+1 extra day` (done on a day it wasn't due) |
| Several times a day | `Full on 4 of 5 days so far` | `42 glasses this week` |
| Amount, time | `Reached on 4 of 5 days so far` | `47,200 steps this week` |
| Checklist | `Every step on 6 of 6 days so far` | `22 of 24 steps · SPF missed twice` (only if a step was missed) |
| N times a week | `2 of 3 this week` | `1 to go · 3 days left`, or `+1 extra` |
| N days a week (amount each) | `2 of 3 days this week` | `13.4 km this week` / to go / extra |
| Total a week | `6 h 20 min of 10 h` | `on 4 days` |
| Month / year goal | `October: 1 of 2` | `1 time this week` |
| Daily limit | `Within limit on 3 of 4 days` (today waits) | `6 cups this week` |
| Weekly limit | `7 of 10 this week` | `2 over · on 4 days` |
| Quit | `12 d 11 h current run` (live, once a minute) | `No slips this week` |
| Nothing to count yet | `Due Sat` / `Due today` / `Started today` / `Not due this week` + `Next due 12 Oct` / `Starts 5 Oct` / the pause text | — |

## Speed and data safety

- Every card is worked out once per week, group and data version in `HabitStore` (`progressSnapshot(…, weekCards:
  true)`), kept in `ProgressModel`'s cache, never in a view's `body` (rules 5, 8). The Week snapshot no longer works
  out day scores, tallies, goals or group bars, so it does less than before.
- No formatter is made per call: values use `compactNumber` / `compactMinutes` (plain arithmetic) and the store's
  cached `HabitCopy.number`. Weekday and month names come from the calendar once per snapshot.
- Only the quit card's run text ticks (`QuitRunClock`, a `TimelineView` anchored at the run's start, once a minute;
  rules 3, 4). It lives in `ProgressScreen.swift`, already allowed in `check_rules.sh`.
- No `List`, no lazy grid; a `LazyVStack` of cards in a `ScrollView` (Design Rules). No shadows. Stable identities
  (habit IDs). The key's `FlowLayout` is a plain `Layout`.
- The calendar sheet no longer works out a score for each of 42 days when it opens.
- Data: Progress only reads. No model, storage, sync or backup change.

## Files

| File | What |
|---|---|
| `Habits/Model/HabitStore+WeekCards.swift` | New: `ProgressWeekCard`, `WeekCardDay`, `WeekColumn`, `WeekLegendKind`; the cards' text per type; quit card; titles |
| `Habits/Progress/WeekCards.swift` | New: `WeekPeriodBar`, `WeekLegend`, `WeekCardView`, `WeekCardStrip`, `WeekMark`, `HabitColor.checkInk`, `FlowLayout`, `WeekSpacing` |
| `Habits/Model/HabitStore+Progress.swift` | `progressSnapshot(…, weekCards:)`; the snapshot's week fields; `progressWeekSnapshot` |
| `Habits/Progress/ProgressScreen.swift` | Week uses `weekList`; `rangePicker` shared; `QuitRunClock` |
| `Habits/Today/DayBar.swift` | `CalendarSheet` cells are plain dates (`CalendarDate`); no rings, no per-day scores |
| `Habits/Model/ProgressCheck.swift` | Golden checks W (week cards: daily, weekly goal, amount, daily limit, quit, key, value formats) |
| `HabitsUITests/ProgressUITests.swift`, `GroupsUITests.swift` | Week has no tiles and its title is the dates. Year (2 Oct): `testYearAndMonthTap` checks Year's title, caption and cards; `testHidePercentages` checks the habit page (Progress has no percentages); the Groups test checks the chips filter the cards (no Groups card anywhere) |
| `Habits/Progress/YearHeatMap.swift` | New (Year): `YearCellStyle`, `YearGrid` (measures and the one drawing function), `YearHeatMap`, `YearKeyCell`, `YearKeyEntry`, `HabitColor.yearShade` (palette from `Research/Temp/year_palette.py`) |
| `Habits/Model/HabitStore+WeekCards.swift` (Year) | `YearLayout`, `YearMonthLabel`, `yearLayout`, `yearCaption`; `WeekCardDay.more` (done above the day's goal) |
| `Habits/Model/HabitStore.swift` | Debug demo `-year-demo`: Swim (every square in one habit: done, three partial steps, not done, more, Sundays not scheduled with an extra now and then, skipped days, a week's pause in the latest weeks, today open) and Coffee (a daily limit, over on some days) |
| `HabitsUITests/WeekCardsUITests.swift` | `testYearCards`, `testYearCardsDark`: pictures of Year, Swim scrolled back, the key, last year |

## To check (for the testing agent)

- [ ] Build (`[ios-ci]`): the code was written without a compiler.
- [ ] `ProgressUITests.testProgressChecks` (the W checks), `testOpenSwitchAndBack`, `GroupsUITests.testProgressAndHabitsByGroup`.
- [ ] Screenshots of Week, light and dark, with the demo data: long names truncate; the key matches the marks; the
      dates bar pins under the navigation bar while scrolling; chips and tabs scroll away.
- [ ] Checks on every colour: white checks on red…gray, deep checks on yellow…cyan, in light and dark mode.
- [ ] Largest text sizes: strips give way to the words.
- [ ] Speed (`[ios-perf]`, scenario `progress`): opening Progress on Week and scrolling, against the last run.
- [ ] Today's calendar sheet: plain dates, today bold, the open day filled, note dots still there.
- [ ] Year (`WeekCardsUITests.testYearCards*`, `-year-demo`): Swim shows every square; the letters stay while the
      squares scroll; the last column ends today; dark mode's partial steps sit between the grey and the colour.
- [ ] Speed (`[ios-perf]`, `progress` cycles Week → Month → Year): switching to Year and scrolling its cards.

## Not done (on purpose)

- **Year's old overview** (rings, tiles, Groups card, Share the Year, How It's Counted) is no longer shown: Year is cards
  (2 Oct). The old views (`ProgressScreen.list`, `overview`, `tiles`, `groupBars`, the rows) and `yearShareItem` are
  unused; remove them after the merge, or bring Share back on its own if the user wants it.
- **Tapping a month in Year** no longer opens it in Month: the card opens the habit, and the habit page has its own
  year grid with months to tap.
- **The Day sheet** is no longer reachable from Progress: it opened from Week's and Month's day rings, which the user
  removed. Today's calendar opens any day. `ProgressDaySheet` stays in the code for now; `testDaySheetShowsOnToday`
  was retired with a note. Year still has its overview, rings code paths (`weekRings`, `monthRings`) are unused
  until Year is redesigned.
- **View Options**: Progress itself shows no percentages now; Show Percentages still governs the habit page.

## Branches (safe to delete, with reasons)

| Branch | State |
|---|---|
| `claude/weekly-overview-stats-ly55gk` | **Safe to delete.** Research only (two reports and their evidence), all three commits copied here; the branch note on it says so |
| `claude/progress-week-cards` | This branch. Merge it, then it can go |

## Results (GitHub)

| Run | What | Result |
|---|---|---|
| [37035760133](https://github.com/lalithsaicharan00/store-reviews/actions/runs/37035760133) (`9b267aa`, Year) | Build, Release build; WeekCards, Progress and Groups UI tests (21); speed `progress`, `progress-year` | All passed. Year scrolling 39.2 ms/s, longest 134 ms, 1 freeze; Progress Year opening 532 ms first, 222 ms again (the blank-page push alone is 120–200 ms on this Mac); Year's snapshot 43 ms (30 cards, 1.4 ms each on average). Week scrolling 21.1 ms/s. ‹ › and range switching 196 ms/s, 258 ms longest (was 183–217 ms/s before Year): still over the target, open |
| (first push) | Build + Progress/Groups UI tests + speed | Waiting; the testing agent reads `ci-results` |
