# Habit Tracker — Day Structure Whole-Corpus Verification

> **Written by Claude (Claude Code)**, 24 September 2026. Authorship of every report is listed in the [Research Reports index](<../README.md>).

Date: 24 September 2026. Status: evidence assessment of a proposed design. This is **not a decision record**. Decisions live in Notion. The research reports in this folder are exploratory.

Question: will the planned day structure meet what users ask for, or is it over-engineered? The plan has four parts: groups, time-of-day sections, a Start button per section, and sub-habits. Every part below is rated on a five-step scale: Excellent · Good · Average · Below average · Worst.

---

## 1. Answer on one screen

| # | Planned part | Rating | Why, in one line |
|---|---|---|---|
| 1 | **Groups used only as a filter on Home** (select a group → only its habits; All → everything) | **Good** | Grouping is the most-requested single thing in this whole set. A filter is the more-requested display form, and sections already give Home its headers. Filters must never hide habits by accident. |
| 1b | Group-wise stats | **Good** | Asked for across many apps. Keep it to one completion view per group. |
| 2 | **Time-of-day sections**, defaults Anytime / Morning / Afternoon / Evening | **Excellent** | The most-praised structure in the corpus. Removing it caused churn. The complaints are about execution, not the idea. |
| 2a | Rename sections and change their times, including when the day starts | **Excellent** | This fixes the second-largest cause of section complaints: fixed boundaries, night owls and shift workers. |
| 2b | Add new sections | **Good** | Real but smaller demand, mostly for more slots and shift work. Cheap once rename exists. |
| 2c | Reorder sections by hand | **Average** | Almost nobody asks. Order sections automatically by start time instead, and let Anytime sit at the top or bottom. |
| 3 | **Start button per section** (guided run of all its habits) | **Good**, if it is check-off first | Strong praise, especially from ADHD users. It is also the highest-friction feature in the corpus. A timer-first runner would be **Below average**. |
| 3b | No separate routine feature; sections act as routines | **Good** | People mostly describe routines as parts of the day. The gap is routines that are not a time of day (study, skincare, workout). Close it by letting Start respect the active group filter. |
| 4 | **Sub-habits as simple checkboxes** (one level) | **Good** | Broad demand, and checklist habits are praised where they exist. Needs a completion rule (all, or at least N) and must not be paywalled. |
| 4b | Typed sub-habits (time-based or count-based per sub-item) | **Below average** | Only 12.5% of sub-habit reviews ask for it. It duplicates what sections plus Start already do with typed habits. |

**Must-haves the plan does not yet mention.** These are among the most frequent asks:

- One habit in several sections (teeth morning and night; meds three times a day).
- Manual order inside a section.
- A whole-day view that never hides habits after their window passes.
- A separate day-start (rollover) time.

**Over-engineered?** Not in scope: each of the four ideas maps to a strong, repeated need. The risk sits in three specific choices:

- typed sub-habits;
- manual reordering of sections;
- a timer-first runner.

There is also one overlap to manage: sub-habits and sections-as-routines can both model a "morning routine" (section 5).

---

## 2. What was tested

As described by the product owner:

1. **Groups:** used only for filtering on Home. Select a group to see only its habits; All shows everything. Group-wise stats, details undecided.
2. **Time-of-day sections:** default Anytime, Morning, Afternoon, Evening. Users can rename, reorder and re-time them, and add new ones. Nothing is hard-coded.
3. **Start per section:** runs all the section's habits together as a guided routine. There is no separate routine feature.
4. **Sub-habits:** should they exist? If so, checkbox-only, or typed (time-based, count-based)?

---

## 3. How the corpus was checked

**Screen.** Every review in the repository was screened: **1,487,223 reviews**.

| Corpus | Reviews |
|---|---|
| App Store | 337,331 |
| Google Play | 901,453 |
| Native-app corpora | 248,439 |

Multilingual patterns covered five families: time of day, groups, routines, sub-habits and group stats.

**Tiers.**

- **Habit-app tier: 8,439 hits** (App Store 4,278, Play 4,161). Every one was read and hand-coded.
- **Adjacent tier: 10,688 hits** from to-do, notes, calendar, gym and native apps. These were screened, and a seeded sample of 80 was read (section 4.4). The adjacent tier was not fully coded.

**Coding.**

- The codebook is in Appendix A. A review can carry several codes.
- Flag **D** marks remarks about one-off to-dos rather than recurring habits. D reviews are excluded from every habit count below.
- **5,438 reviews** were relevant, of which **5,066** are in habit context. The other 3,001 were read and judged not relevant: generic "time of day", content categories, social groups, workout routines and similar.

**Validation (`aggregate.py`).**

- The map covers indices 0–8,438 exactly once.
- 0 gaps, 0 duplicate indices, 0 unknown codes.
- Refinement remaps were applied and checked.

**Friction sub-types.**

- Section complaints (248) and guided-run complaints (340) were **sub-typed by hand, every review**.
- Group friction (474) and sub-habit friction (145) were split by keyword, only inside those hand-coded sets. Those splits are **floors**.

**Scope.**

- Period: review dates from 13 Jan 2011 to 6 Sep 2026. 125 app listings contributed at least one relevant review.
- Signal labels: **Strong** = ≥100 reviews from ≥15 app listings. **Moderate** = 30–99 reviews, or fewer than 15 listings. **Limited** = fewer than 30 reviews.
- Every figure below uses this scope and period unless it says otherwise.
- Representative reviews are cited as **E-numbers**. Appendix C resolves each one to its app, store, rating, date and review ID.

**What these numbers are not.**

- They are counts of people who chose to mention something. They are not votes or market shares.
- Apps differ in features, age and review volume. Silence about a feature is not evidence that nobody needs it.
- There are no time-trend claims, so no survivorship test was needed.
- There are no country-level claims, so the 50-review country threshold does not apply.

**Concentration, disclosed.**

- Group requests: Loop, which has no grouping, supplies 344 of 933 (36.9%).
- Section praise: Productive and Fabulous supply 402 of 656 (61.3%).
- Guided-run praise: Routinery (both stores) and RoutineFlow supply 269 of 369 (72.9%).

**Rating versus text.**

- Many complaints come from 4–5★ reviews. For example, 69% of section-friction reviews are 3–5★ (mean 3.20★).
- Star ratings are shown only as context.

---

## 4. Findings

### 4.1 Time-of-day sections: **Excellent**

Scope: **1,574** habit-context reviews with a section code. This excludes reviews coded only for manual ordering.

| Code | What users say | n | % of 1,574 | Listings | Signal | Examples |
|---|---|---|---|---|---|---|
| T+ | Praise sections or use them daily | 656 | 41.7% | 36 | Strong | E1–E5 |
| TF | Friction with an app's sections (sub-typed below) | 248 | 15.8% | 23 | Strong | E33–E40 |
| T? | Ask for morning / afternoon / evening sections | 190 | 12.1% | 42 | Strong | E6–E9 |
| TM | Want one habit in several sections | 153 | 9.7% | 29 | Strong | E15–E17 |
| TE | Sections too coarse; want an exact clock time | 137 | 8.7% | 27 | Strong | E22, E23 |
| TC | Want to customise sections: boundaries, day start, more sections | 125 | 7.9% | 25 | Strong | E18–E21 |
| TV | Want day-plan variants (weekday/weekend, shifts) | 77 | 4.9% | 21 | Moderate | E30–E32 |
| TH | Sections hide habits, or force a split view with no whole-day view | 64 | 4.1% | 15 | Moderate | E11–E14 |
| TR | Sections removed in an update | 47 | 3.0% | 2 | Moderate (Me+) | E27–E29 |
| TA | Want the whole day visible, with section headers in All | 38 | 2.4% | 12 | Moderate | E10, E11 |

Manual ordering of habits is coded separately because it applies to any list. It appears in **291 of 5,066** habit-context reviews (5.7%), from 42 listings. Signal: Strong. Examples: E24–E26.

**Section complaints, hand-sub-typed (n = 248).**

| Sub-type | n | % of 248 |
|---|---|---|
| Bugs: habits missing from a section, sync, lost data | 84 | 33.9% |
| Clutter or confusion (mostly Fabulous's crowded home) | 59 | 23.8% |
| Cap on habits per section, or paywall | 48 | 19.4% |
| Fixed boundaries / rollover; night owls, shift work | 22 | 8.9% |
| Forced to assign a section, or cannot turn one off | 18 | 7.3% |
| Habits hidden after their window; no whole-day view | 12 | 4.8% |
| Reminders only per section, not per habit | 12 | 4.8% |
| Section feature removed | 11 | 4.4% |
| Exact time missing | 8 | 3.2% |
| History reset when a habit moves section | 5 | 2.0% |
| Want a category dimension besides time | 5 | 2.0% |
| Cannot put daily repeats in different sections | 3 | 1.2% |

**What this means.**

- The defaults you picked are exactly what the most-praised apps ship (E1–E5).
- Complaints are about execution, not the concept: broken sync, caps per section, fixed boundaries, hidden habits and history resets.
- Taking sections away is costly. The 47 removal reviews average **2.55★**, 46.8% are 1–2★, and 12 say the user is leaving (E27–E29).

**Customisation.** Boundary, day-start and "more sections" requests (TC 125, plus 22 boundary complaints) justify rename and re-time as **Excellent**, and add-section as **Good**.

Reordering sections by hand has almost no demand. The only ordering complaints are about sections showing in the wrong order after a bug (e.g. a restore scrambled morning/noon/evening). Sections that carry times should sort themselves, which gives **Average** for manual reorder.

### 4.2 Groups: **Good** (filter on Home) · group stats **Good**

Scope: **2,228** habit-context group reviews, from 112 listings.

| Code | What users say | n | % of 2,228 | Listings | Signal | Examples |
|---|---|---|---|---|---|---|
| G? | Ask for groups, folders, categories or tags | 933 | 41.9% | 59 | Strong (Loop 344) | E41–E44 |
| G+ | Praise or use grouping | 668 | 30.0% | 54 | Strong | E45–E47 |
| GF | Friction with an app's grouping | 474 | 21.3% | 50 | Strong | E68–E73 |
| GL | Use or want filter / tab / list switching by group | 260 | 11.7% | 37 | Strong | E48–E52 |
| GS | Want group-level stats | 174 | 7.8% | 32 | Strong | E64–E67 |
| GV | Want visible group headers or collapsible groups on the list | 158 | 7.1% | 30 | Strong | E56, E57 |
| GD | Want category separate from time, or several tags per habit | 57 | 2.6% | 17 | Moderate | E58–E63 |
| GN | Praise not being forced to categorise | 8 | 0.4% | 5 | Limited | E76, E77 |

**Why people ask.**

- 73 of 933 group requests (7.8%) name the long list, scrolling or clutter explicitly (E41–E44).
- 95 group reviews describe using colour as a workaround.
- 214 group reviews (9.6%, keyword floor) name a time of day as the group they want, for example "morning" or "night". Where an app has no sections, people use groups to fake them. With real sections, that part of the demand moves to sections.

**Filter versus visible headers.**

- Filter or tab switching (260) is requested more than headers (158).
- Only 8 reviews explicitly criticise filter-only designs (E53–E55; Limited).
- Home already has section headers. A second header system for groups would stack two levels of headings, so **filter-only is the right call**.

**Filter risks you must design out.**

- Habits hidden by a forgotten filter or by missing tags. E74 and E75 (Limited, but severe): untagged items could not be found, and "All" did not show all.
- Forced categorisation. Users left over mandatory, preset category pickers (E70–E72).

**Group friction (GF 474), keyword floors.**

| Friction | n | % of 474 |
|---|---|---|
| Cannot edit, delete or rename groups | 110 | 23.2% |
| Colour or icon choice | 83 | 17.5% |
| Group order | 70 | 14.8% |
| Paywall or caps (for example, 2 or 5 free groups) | 70 | 14.8% |
| Bugs | 66 | 13.9% |
| Preset or forced set | 48 | 10.1% |

In total, 22.2% of GF reviews are 1–2★, and 28 say they are leaving (E71–E73).

**Group stats.** 174 reviews (Strong) ask for completion per group, e.g. "1 of 2 workout habits = 50%", or monthly completion by area (E64–E67). One completion view per group is enough. Time-spent and radar charts are rarer asks and belong later.

### 4.3 Start per section, and no separate routine feature: **Good** (conditional)

Scope: **1,062** habit-context routine reviews, from 70 listings.

| Code | What users say | n | % of 1,062 | Listings | Signal | Examples |
|---|---|---|---|---|---|---|
| R+ | Praise a guided run: start, step timer, next step | 369 | 34.7% | 15 | Strong, but concentrated in two apps | E78–E85 |
| RF | Friction with guided runs (sub-typed below) | 340 | 32.0% | 22 | Strong | E86–E110 |
| RS | Want or praise an ordered sequence or habit stacking | 149 | 14.0% | 29 | Strong | E106, E107 |
| RC | Want a routine as a named bundle or checklist, not a timer | 119 | 11.2% | 31 | Strong | E111–E114 |
| R? | Ask for a guided run | 110 | 10.4% | 20 | Strong | E88, E107, E108 |
| HT | Want a per-habit timer (single habit, not a sequence) | 94 | 8.9% | 29 | Moderate | E82 |
| RU | Praise a runner app without naming the mechanic | 71 | 6.7% | 6 | Moderate | — |

**Who it serves.** 187 routine reviews (17.6%) mention ADHD, autism or executive function, and 92 of those are praise (E82, E83). The run mode is a real draw for a real audience.

**Guided-run complaints, hand-sub-typed (n = 340).** Mean 3.24★, 30.3% are 1–2★, and 29 say they are leaving.

| Sub-type | n | % of 340 |
|---|---|---|
| Bugs, crashes, lost progress | 102 | 30.0% |
| Notifications: missing, too weak, or nonstop | 58 | 17.1% |
| Caps on number of routines, or paywall | 53 | 15.6% |
| Timer pressure; want to tick off without a timer | 39 | 11.5% |
| Watch problems | 39 | 11.5% |
| Rigid order; cannot skip, reorder or come back | 31 | 9.1% |
| Clutter or preset content | 30 | 8.8% |
| Timer stops in the background or on app switch | 28 | 8.2% |
| Tied to a fixed start time | 17 | 5.0% |
| Need day variants | 8 | 2.4% |
| Habit stacking broken | 7 | 2.1% |
| Cannot see the whole day | 5 | 1.5% |

**Timer-optional is a requirement, not a nicety.**

- **148 of 1,062** routine reviews (13.9%) either want a checklist-style routine or say the timer itself is the problem (E86–E93).
- Where both modes exist, the choice is praised (E84, E85).
- Some users find the timer is what makes it work (E93), so keep durations optional rather than removing them.

**Sections as routines: supported.**

- At least **368 of 1,062** routine reviews (34.7%, keyword floor) name a part of the day.
- Free-tier caps on routines are resented precisely because people want a morning, an evening and often an afternoon routine (E100–E104).
- Requests for "a morning-routine group of habits" are frequent (E111–E114).

**The gap.**

- Some routines are not a time of day: study, skincare, going out, season or event (E100, E91, E115, E116).
- Some people need to start routines whenever they like, not at a set clock time (E108–E110).
- Letting **Start run the section as currently filtered by a group** covers the first need without adding a routine object. Starting manually at any time covers the second.

### 4.4 Sub-habits: checkboxes **Good**, typed **Below average**

Scope: **682** habit-context sub-habit reviews, from 72 listings.

| Code | What users say | n | % of 682 | Listings | Signal | Examples |
|---|---|---|---|---|---|---|
| S? | Ask for checkbox sub-items inside a habit | 328 | 48.1% | 51 | Strong (Loop 70) | E120–E123 |
| S+ | Praise checklist sub-items | 145 | 21.3% | 18 | Moderate (Me+ 72, HabitNow 24) | E117–E119 |
| SF | Friction with sub-items | 145 | 21.3% | 16 | Moderate | E133–E136 |
| ST | Want typed sub-items: time or count per item, per-item stats or reminders | 85 | 12.5% | 20 | Moderate | E128–E132 |
| SP | Want the parent auto-completed or partial credit | 70 | 10.3% | 20 | Moderate | E124–E127 |
| SN | Prefer no sub-items | 8 | 1.2% | 5 | Limited | E137–E139 |

**Typed demand is a minority.** Within ST, 27 mention a time or duration, 13 a count, and 22 per-item stats or reminders (keyword splits). Most of these can be modelled today as separate typed habits in a section, run with Start.

**Sub-habit friction (SF 145), keyword floors.**

| Friction | n | % of 145 |
|---|---|---|
| Reorder, edit or limit | 46 | 31.7% |
| Paywall | 32 | 22.1% |
| Bugs | 17 | 11.7% |
| Display or collapse | 9 | 6.2% |
| All-or-nothing completion | 4 | 2.8% |

Overall, 33.8% of SF reviews are 1–2★.

**Overlap with routines.** 132 of 682 sub-habit reviews (19.4%, keyword floor) mention a routine or the morning. Many sub-habit requests are really routine requests (E120, E123), and sections plus Start already answer those.

**Adjacent tier (sample of 80, seed 20260924; not full-coded).**

- 19 of 20 sampled sub-task hits concern to-do subtasks. They point to a settled pattern: collapse under the parent, show progress, reorder, tick from the widget, repeat with the parent.
- 17 of 20 group hits concern folders or labels for to-dos and notes.
- 5 of 20 time-of-day hits and 7 of 20 routine hits were relevant, and only 2 were in a habit sense.

---

## 5. Is it over-engineered?

| Item | Verdict | Reason |
|---|---|---|
| Four concepts (groups, sections, Start, sub-items) | **Keep** | Each maps to Strong demand. Keep groups and sub-items **invisible until used** so a new user sees only sections. |
| Sub-items vs section-as-routine | **Define the boundary** | Both can model "morning routine". Rule: parts of one habit you tick together → sub-items. A sequence of separate habits done in a block → a section, run with Start. |
| Typed sub-habits | **Cut** | 85 of 682 (12.5%) ask. It duplicates typed habits plus sections and makes stats harder. |
| Manual section reordering | **Replace** | Almost no demand. Auto-order by start time; pin Anytime top or bottom. |
| Timer-first Start | **Change** | Timer pressure, background stops and notifications make up a large share of the 340 complaints. Make Start check-off first, with optional durations. |
| Group stats | **Keep, small** | One completion view per group, reusing the habit stats chart. |
| Several groups per habit | **Later** | Moderate (57). Adds filter and stats complexity. |
| Day variants (weekday/weekend/shift modes) | **Not now** | Moderate (77). The best-loved implementation (MyRoutine) also draws bug reports (E32). Per-habit weekdays cover most cases. |

---

## 6. Design changes this evidence supports

**Sections**

1. Home is one scrolling day with section headers. It never hides a habit because its window has passed. Finished sections may collapse.
2. One habit can sit in several sections, each with its own tick: teeth AM and PM, meds three times.
3. Manual order inside each section.
4. A day-start (rollover) setting, separate from section times. Evening may run past midnight.
5. An optional exact time on a habit inside its section, used for its reminder and its sort position.
6. Reminders per habit, not only per section.
7. Moving a habit between sections never resets its history.
8. No cap on habits per section in the free tier.
9. A section can be hidden, for example Afternoon, without deleting it.

**Groups**

10. Optional, with none by default. "All" is always the first chip and the default whenever the app opens. Untagged habits always appear in All.
11. Groups are fully editable: rename, recolour, reorder, delete. Deleting a group leaves its habits ungrouped.
12. Group stats: completion % per group for a week and a month, using the same chart style as habit stats.

**Start (guided run)**

13. Start steps through the section's unfinished habits in section order. Each step offers Done, Skip or Later. A timer appears only if the habit has a duration. Auto-advance is a setting, off by default.
14. The user can reorder or skip during the run, and return to skipped steps.
15. Timers are background-safe, with a persistent notification or live activity, and alerts are reliable. Watch support comes later.
16. Start respects the active group filter. That gives study, skincare or workout "routines" without a routine object.
17. Start works at any time. It is never locked to a start time.

**Sub-habits**

18. One level, checkbox only. The parent completion rule is "all" by default, or "at least N". Show n/m progress. Items collapse under the parent, can be reordered, and can be ticked from the list and the widget.
19. The UI states the boundary: sub-items are parts of one habit; sections hold a sequence of habits.
20. Do not paywall checklists. The paywall accounts for 22.1% of sub-habit friction.

---

## 7. Compared with the earlier decision report

[Habit Tracker — Day Sections, Categories and Routines Decision](<Habit Tracker — Day Sections, Categories and Routines Decision.md>) reached the same direction:

- customisable day sections as the primary structure;
- an optional Start;
- categories as an optional filter;
- no separate Routines tab;
- one-level steps.

That report was built from ledger cards and 30 spot-checked reviews. This one reads all 8,439 habit-tier hits and adds:

- quantities with denominators;
- timer-optional as a requirement;
- one habit in several sections, and manual order, as must-haves;
- evidence against typed sub-habits;
- "Start respects the group filter" as the answer to routines that are not a time of day.

---

## 8. Caveats

- **Long reviews were read in windows.** For reviews over 500 characters, coding used the text within ±170 characters of each matched term. A relevant point elsewhere in a long review could be missed, so the counts are floors.
- **The screen sets the candidate pool.** A review that discusses these needs without any screened word is not counted.
- **The adjacent tier was not fully coded.** Its 10,688 hits (native 5,910, Play 4,778) were represented by an 80-review sample.
- **Single coder.** Codes were not double-coded.
- **Keyword splits are floors.** The GF and SF splits, and the keyword counts in section 4, are lower bounds inside hand-coded sets.
- **Listing counts are approximate.** Listing counts merge app names across stores approximately. Some generic names ("Habit Tracker") cover several apps.

---

## Appendix A. Codebook

| Area | Codes |
|---|---|
| Sections | T+ praise/use · T? ask · TC customise (boundaries, day start, more sections) · TF friction · TM one habit in several sections · TA whole-day view with headers · TV day-plan variants · TE exact clock time · TO manual ordering (any list) · TH sections hide habits / forced split · TR sections removed |
| Groups | G+ praise/use · G? ask · GF friction · GV visible headers / collapsible · GL filter / tab / list switching · GS group stats · GD category separate from time, or several tags · GN praise for not being forced |
| Routines | R+ praise guided run · R? ask · RF friction · RC routine as bundle / checklist · RS ordered sequence / stacking · RU runner praise, no mechanic named · HT per-habit timer |
| Sub-habits | S+ praise · S? ask for checkbox sub-items · ST typed sub-items / per-item stats · SP parent auto-complete / partial · SF friction · SN prefer none |
| Flags | $ money · L leaving · W widget · I chose the app for it · D one-off to-do context (excluded from habit counts) |

The full codebook with coding notes is in `codebook.md` in the evidence folder.

## Appendix B. All codes, habit context (n = 5,066)

| Code | n | Mean ★ | 1–2★ | Leaving | Code | n | Mean ★ | 1–2★ | Leaving |
|---|---|---|---|---|---|---|---|---|---|
| T+ | 656 | 4.70 | 2.0% | 0 | G+ | 668 | 4.77 | 1.5% | 0 |
| T? | 190 | 4.23 | 5.8% | 6 | G? | 933 | 4.30 | 3.5% | 11 |
| TC | 125 | 4.18 | 7.2% | 1 | GF | 474 | 3.49 | 22.2% | 28 |
| TF | 248 | 3.20 | 31.0% | 16 | GL | 260 | 4.28 | 5.4% | 1 |
| TM | 153 | 4.02 | 10.5% | 5 | GV | 158 | 4.30 | 3.2% | 1 |
| TA | 38 | 3.66 | 21.1% | 3 | GS | 174 | 4.28 | 4.0% | 5 |
| TE | 137 | 3.57 | 21.2% | 7 | GD | 57 | 4.30 | 1.8% | 1 |
| TH | 64 | 3.22 | 23.4% | 5 | GN | 8 | 4.88 | 0.0% | 0 |
| TO | 291 | 3.86 | 14.1% | 11 | R+ | 369 | 4.67 | 2.4% | 2 |
| TR | 47 | 2.55 | 46.8% | 12 | R? | 110 | 4.14 | 7.3% | 2 |
| TV | 77 | 4.35 | 5.2% | 0 | RF | 340 | 3.24 | 30.3% | 29 |
| S+ | 145 | 4.66 | 4.1% | 1 | RC | 119 | 4.39 | 2.5% | 2 |
| S? | 328 | 4.11 | 8.5% | 15 | RS | 149 | 4.26 | 12.1% | 7 |
| ST | 85 | 4.09 | 9.4% | 4 | RU | 71 | 4.90 | 0.0% | 0 |
| SP | 70 | 4.21 | 7.1% | 2 | HT | 94 | 4.39 | 6.4% | 2 |
| SF | 145 | 3.11 | 33.8% | 9 | SN | 8 | 5.00 | 0.0% | 0 |

Family totals, counting each review once: sections 1,794, or 1,574 excluding reviews coded only for manual ordering · groups 2,228 · routines 1,062 · sub-habits 682. Including to-do context (D), 5,438 reviews are relevant.

## Appendix D. Evidence files

In [Day Structure Evidence / Whole-Corpus Coding](<Day Structure Evidence/Whole-Corpus Coding/>):

- `review-classification-map.txt`: the hand-coded map, one line per relevant review.
- `coded-reviews.jsonl`: the complete per-review index. Each relevant review has its store, app folder, source line, review ID, rating, date and codes, so any number resolves to exact reviews.
- `candidate-index.jsonl`: all 8,439 habit-tier hits that were read, relevant or not.
- `section-friction-subtypes.txt` and `guided-run-friction-subtypes.txt`: the hand sub-typing.
- `adjacent-tier-sample.jsonl` and `adjacent-tier-sample-codes.txt`: the 80-review adjacent sample.
- `code-summary.json`, `cited-reviews.json`, `codebook.md`, `remap.txt`.

Scripts are in `Tools/day_structure/` (see its README).

## Appendix C. Cited reviews

Review IDs were resolved by script from the coded index, not typed by hand. Every ID was checked against its app's `reviews.jsonl`. Gists are paraphrases.

| Ref | App | Store | ★ | Date | Review ID | Codes | Gist (paraphrase) |
|---|---|---|---|---|---|---|---|
| E1 | Productive | App Store | 5 | 2020-02-14 | `5531983464` | T+ | Setting habits to a time of day is what sets this app apart. |
| E2 | Productive | App Store | 5 | 2020-05-01 | `5889247182` | T+ TF | Morning / afternoon / evening / all-day split is simple and matches how a day feels. |
| E3 | Tiimo | Google Play | 4 | 2026-07-18 | `8f6fc116-9f74-4ac4-a1a8-eb7c3b144ddf` | T+ R+ | Likes tasks split into morning, afternoon, night because rigid time-blocking does not work for them. |
| E4 | Fabulous Daily Routine Planner | Google Play | 5 | 2020-09-10 | `18d634b2-0db4-4002-a7bf-4ecd99d420e4` | T+ R+ | Great for morning, afternoon and evening routines; full-screen start prompt is hard to ignore. |
| E5 | Way of Life | App Store | 5 | 2016-05-10 | `1376233352` | T+ GS | Has a morning block and an evening block and checks how well each went at day's end. |
| E6 | Habit Tracker | App Store | 3 | 2021-08-11 | `7679011547` | T? $ | Would be better with morning / afternoon / night categories; uses another app for that. |
| E7 | Finch | App Store | 4 | 2024-08-17 | `11622246574` | T? RC | Wants daily goals divided into morning, day and evening to build routines. |
| E8 | everyday Habit Tracker | Google Play | 5 | 2021-09-03 | `fa65ea9a-7fb7-4363-9f91-2b811c9f5ea4` | GV T? | Wishes for partitions in the habit list, e.g. morning, noon, evening. |
| E9 | Loop Habit Tracker | Google Play | 5 | 2025-01-07 | `f1625010-1d73-43f2-9105-cabdb9574241` | GV T? | Wants separators, e.g. which medicines are taken in the morning vs evening. |
| E10 | Habit Tracker | App Store | 4 | 2024-11-21 | `11973991252` | TA | Asks for a small heading bar per part of day inside the All view. |
| E11 | Productive | App Store | 5 | 2024-07-08 | `11468493322` | TH TA | Wants the default page to be All rather than the morning/afternoon/evening pages. |
| E12 | Productive | App Store | 4 | 2019-12-22 | `5306068227` | TH | View defaults to time of day so all-day habits are not seen; habits disappearing. |
| E13 | Habitify | App Store | 4 | 2019-04-24 | `4053514561` | TH $ | When shown by time of day, unfinished items hide once the next period starts. |
| E14 | Productive | App Store | 1 | 2019-12-23 | `5310232027` | TH TA $ | New design shows only the morning part instead of the whole day; paid a lot for this. |
| E15 | Finch | App Store | 5 | 2026-03-10 | `13834927587` | TM | A goal done twice a day cannot be put in two different times of day. |
| E16 | Habit — Daily Tracker | App Store | 5 | 2020-08-11 | `6305815424` | TM $ | Would buy if one habit could occur several times a day (teeth AM/PM, meds 3x). |
| E17 | Productive | App Store | 4 | 2017-02-03 | `1535934373` | T+ TM | Likes setting one habit for several times of day (water, spending). |
| E18 | Habit Tracker | App Store | 5 | 2025-08-12 | `13005403096` | TC $ | Only three fixed periods; wants to define more, e.g. 4-hour blocks for shift work. |
| E19 | Habit Tracker | App Store | 4 | 2024-06-06 | `11348827617` | TF TC | Time-period setting forces mornings to start at midnight; night owl needs 9 am. |
| E20 | MyRoutine | App Store | 5 | 2024-10-08 | `11811576801` | TC | Night owl: day rolls over before evening routine is done; wants to set the switch time. |
| E21 | MyRoutine | App Store | 4 | 2025-03-10 | `12403094681` | TC | Cannot change the day's start time; 1 am night routine counts as the next day. |
| E22 | Productive | App Store | 1 | 2018-05-05 | `2508547531` | TE L $ | Only vague morning/afternoon/evening slots, no specific reminder time; worst purchase. |
| E23 | Habit — Daily Tracker | App Store | 1 | 2024-07-18 | `11506619653` | TE | Does not allow picking a specific time of day for habits. |
| E24 | Daily Habits | App Store | 3 | 2019-04-17 | `4025884406` | T+ TO | Likes vague time-of-day labels but wants to reorder habits within each period. |
| E25 | Me+ Lifestyle Routine | App Store | 2 | 2023-09-23 | `10400255535` | TO RS | Pointless to have morning/night routines if their order cannot be kept. |
| E26 | MyRoutine | App Store | 5 | 2025-07-15 | `12892785499` | TO $ | Wants routines ordered by time slot or manually reorderable. |
| E27 | Me+ Lifestyle Routine | App Store | 2 | 2023-11-22 | `10611293251` | TR L | After update every task says 'any time of day'; wants the day parts back or will use Reminders. |
| E28 | Me+ Lifestyle Routine | App Store | 1 | 2023-12-30 | `10763548699` | TR | Update removed morning/night/afternoon routines; now only specific times. |
| E29 | Me+ Lifestyle Routine | Google Play | 1 | 2023-11-02 | `009bfc79-0e7e-4bf4-8e8a-35e9030ee2c8` | TR TM $ | Cannot divide the day into morning/afternoon/evening or list meds 3x a day; waste of money. |
| E30 | Routine Planner, Habit Tracker | App Store | 1 | 2026-03-19 | `13863035457` | TV $ | Free tier allows two routines; needs weekday/weekend morning and night variants. |
| E31 | Fabulous Daily Routine Planner | Google Play | 4 | 2018-12-23 | `c3b7bd3d-9a32-4a84-9f81-a5b876becf07` | TV | Routines fit school days but not weekends; wants more than one routine per part of day. |
| E32 | MyRoutine | App Store | 5 | 2026-02-27 | `13795524849` | TV TF | Shift nurse: routine modes are a lifesaver, but switching one day switches all following days. |
| E33 | Fabulous Daily Routine Planner | Google Play | 4 | 2024-08-19 | `a98229f5-aeef-4a5a-8a4e-03dfced4d68d` | TF $ | Only 4 habits per morning / afternoon / night on free tier. |
| E34 | Habitify | App Store | 3 | 2018-02-26 | `2249638055` | TA TF $ | Needs the day at a glance; only chunks of time shown; per-chunk limit even with premium. |
| E35 | Fabulous Daily Routine Planner | Google Play | 1 | 2019-12-28 | `4dc2be2b-52f1-411a-aa0b-0e71ac4975ed` | TF $ L | Limits habits to three per time of day unless you pay; pushes premium. |
| E36 | Fabulous Daily Routine Planner | Google Play | 1 | 2019-05-06 | `17683366-4d1c-4cd6-8d05-fda6976d4d50` | TF L | Forced to choose a time of day for each habit; does not work for variable schedules. |
| E37 | MyRoutine | App Store | 4 | 2022-03-06 | `8426698390` | TF TC TH $ | Having to pick morning/afternoon/evening is very inconvenient; shift workers exist. |
| E38 | Fabulous | App Store | 4 | 2021-01-28 | `6922246879` | TF TC | Cannot turn off the afternoon routine they do not need; gets pointless notifications. |
| E39 | Productive | App Store | 4 | 2020-01-22 | `5435183168` | TF | Changing a habit's time of day warned it would delete all history. |
| E40 | Productive | App Store | 4 | 2018-11-06 | `3385597876` | TF | Changing a habit's time of day creates a new entry and loses history. |
| E41 | Loop Habit Tracker | Google Play | 4 | 2021-02-19 | `709e0886-3d60-4227-b9ee-b66decc3a915` | G? GV GL | ADHD user: wants tabs or collapsible categories; one long list is overwhelming. |
| E42 | Habit Tracker | Google Play | 4 | 2026-01-14 | `69485bc3-7590-4952-a9d9-976f3e1510a2` | G? GV | No way to group habits by type; must scroll through big blocks to find one. |
| E43 | Loop Habit Tracker | Google Play | 5 | 2025-07-13 | `08cf3053-9ae1-4f8d-bddc-bae4c82f0ce3` | G? GV | Seeing everything on one page first thing in the morning is overwhelming; wants categories. |
| E44 | Strides | App Store | 4 | 2015-01-09 | `1127178880` | G? GV | Wants goals categorised into folders instead of one big list. |
| E45 | HabitNow Daily Routine Planner | Google Play | 5 | 2023-11-24 | `8ccb7a8f-7138-41ff-821b-83944ec48783` | G+ | Organises habits and tasks into categories and can create new ones. |
| E46 | Habitify | Google Play | 4 | 2023-09-19 | `87bec25e-7f63-4878-9403-4f09d757d1f6` | G+ $ | Categorising by life area looks good and reduces clutter (premium user). |
| E47 | Habitify | Google Play | 5 | 2022-01-29 | `9c547336-0e12-4e04-b824-7db8d6b63426` | G+ T+ RS | Uses folders to see morning and night routines at a glance; habit stacking works. |
| E48 | Way of Life | App Store | 5 | 2021-06-23 | `7496599271` | G+ GL | Tags let you zoom in with a filter on what is relevant right now. |
| E49 | HabitNow Daily Routine Planner | Google Play | 5 | 2024-02-07 | `4115ecfa-a474-41dc-b68d-d88cc023c89d` | G+ GL | Made custom filters (self care, chores, tasks) to separate the day. |
| E50 | Habit Pixel | Google Play | 4 | 2026-08-04 | `0faf9928-6d10-4a36-8785-834e23580928` | G+ GL | Praises easy category filtering and search. |
| E51 | Loop Habit Tracker | Google Play | 4 | 2026-02-02 | `f7bfc0fd-af62-49be-8273-a438fb0c5316` | G? GL | Wants a label bar at the top to switch categories and see only those habits. |
| E52 | Loop Habit Tracker | Google Play | 4 | 2020-02-27 | `8b491ad3-0687-46af-aed1-72c0c310d111` | G? GL | Wants tabs or pages per category; colour alone is not enough. |
| E53 | TheFor | Google Play | 4 | 2024-03-30 | `5a2e072a-f04f-4553-b9db-adb18ffbf1c6` | GV | Wants habits of the same routine grouped together in the list, not just as a filter. |
| E54 | MyRoutine | Google Play | 5 | 2025-02-23 | `321838da-8183-4a48-a5a1-c8efcb3d830c` | GV GF | Asks to display tags under routines instead of filtering by tags. |
| E55 | Do Habits | App Store | 5 | 2019-02-05 | `3736242860` | G+ GV | Uses colours to group while still seeing all habits; filtering feels burdensome. |
| E56 | Habit Tracker n Pets | Google Play | 5 | 2021-02-03 | `631bebae-05b8-4317-9b37-647e2c321ca8` | GV GL | Asks for collapsible groups on the front page to view one category at a time. |
| E57 | Loop Habit Tracker | Google Play | 3 | 2019-08-13 | `0cf07c41-5581-450d-917d-3bce5a079d82` | G? GV | Wants habits grouped in a dropdown that can be expanded or hidden from its heading. |
| E58 | ShineDay | App Store | 5 | 2022-04-22 | `8592619814` | G? T+ GD | Only one classification dimension exists; wants time period plus a separate tag dimension. |
| E59 | ShineDay | App Store | 5 | 2021-08-13 | `7689801832` | G? T+ GD | Wants categories and time periods separated so category grouping and time order coexist. |
| E60 | MyRoutine | Google Play | 5 | 2025-06-02 | `364418ac-829b-4149-bf8c-2500599dde89` | G? GD | Can only split by morning/lunch/evening; wants categories like work, study as well. |
| E61 | Habitify | App Store | 1 | 2018-10-05 | `3267164639` | GF TF GD L $ | No grouping except by time of day, and time-of-day intervals glitch; money wasted. |
| E62 | Me+ Lifestyle Routine | Google Play | 5 | 2024-07-10 | `519a824a-9bcd-4703-9aea-e2df89cd5b24` | GD | Wants more than one tag per task. |
| E63 | Me+ Lifestyle Routine | Google Play | 5 | 2024-10-15 | `4722bd9d-953d-4d1a-bd41-c7b99bdb5963` | GD | Asks to allow three or more tags on several tasks. |
| E64 | HabitNow Daily Routine Planner | Google Play | 4 | 2025-04-18 | `5f0384a2-feb8-4625-a2a5-70a35a256c91` | GS | Wants category-level progress, e.g. 1 of 2 workout habits = 50%. |
| E65 | HabitNow Daily Routine Planner | Google Play | 5 | 2024-02-18 | `e2909471-ecba-419b-b5f3-477c7364b2f9` | GS | Wants completion % per category per month (work 85%, home 100%). |
| E66 | Loop Habit Tracker | Google Play | 5 | 2021-01-16 | `7c5ac732-8448-4ce1-b91e-960a117c925b` | G? GS | Wants named groups with summary reports and charts per group. |
| E67 | Productive | App Store | 5 | 2019-04-06 | `3978603389` | GS | Wants time spent by morning/day/evening and by group. |
| E68 | Me+ Lifestyle Routine | Google Play | 4 | 2026-08-03 | `79ac3d35-287f-420f-88bc-f5f2087a70ff` | GF | Tags cannot be edited or deleted; a misnamed tag is stuck forever. |
| E69 | Me+ Lifestyle Routine | Google Play | 4 | 2024-01-03 | `86c8713c-0d74-4fae-a735-3cd26c49aacd` | GF | Cannot edit or delete tags; a mistake stays forever. |
| E70 | Habit Tracker | Google Play | 1 | 2018-08-11 | `8f6a2102-e6f0-438a-8d6c-d2916846b29b` | GF | Just wants to name a goal and tick dates, but has to fight category pickers. |
| E71 | Habit Tracker | Google Play | 2 | 2019-11-10 | `33de342c-be04-4456-b93b-15b5c2c9ee2a` | GF L | Must pick a category for every habit, only from presets; will install another app. |
| E72 | Me+ Lifestyle Routine | Google Play | 2 | 2023-12-09 | `2226f89d-da4c-4566-8cd4-02da45547cfb` | GF L | Too many sub-categories to click through; deleting the app. |
| E73 | Habitude Daily Routine Planner | Google Play | 3 | 2020-06-28 | `4169ac7e-e13c-4872-b8c8-529325b1d541` | GF $ L | Only 2 categories without premium; will look for another app. |
| E74 | Roubit -Daily Life Routine Care | Google Play | 5 | 2024-02-20 | `d54f2e84-cd0d-4152-bc89-32a3233eadb7` | GF | Tasks added without a tag cannot be found. |
| E75 | Me+ Lifestyle Routine | Google Play | 3 | 2023-10-18 | `3a37bfb0-573b-4f1a-b0a1-64064609c89f` | GF TH | Tapping All does not show all tasks; some tags do not appear on the main screen. |
| E76 | Days Since | App Store | 5 | 2024-12-22 | `12094225073` | GN | Loves being able to track anything without being forced to categorise or sort. |
| E77 | Loop Habit Tracker | Google Play | 5 | 2018-06-04 | `913eff54-1e6c-419b-b2f1-b285d95b2498` | GN | Sometimes people do not need categories; simplicity is the point. |
| E78 | Routine Planner, Habit Tracker | App Store | 5 | 2025-12-07 | `13487673204` | R+ | Uses the routine feature; can skip, run over or finish early, so easy to start. |
| E79 | Fabulous Daily Routine Planner | Google Play | 5 | 2023-10-28 | `42106afd-6b84-4ab8-b9eb-0d1d852ac601` | R+ | Loves the timer for morning and evening routines; helps with mild ADD. |
| E80 | RoutineFlow | Google Play | 5 | 2023-07-22 | `6233f875-e4ff-442f-913f-81534fd5b582` | R+ S+ | Lays out morning and evening routines with timed steps inside each. |
| E81 | Routine Planner, Habit Tracker | App Store | 4 | 2025-11-06 | `13362713060` | R+ RF | Custom timers let them move to the next action without thinking; sleeps and wakes earlier. |
| E82 | Fabulous | App Store | 5 | 2020-05-01 | `5888781576` | R+ RF HT | ADHD: timers are essential, but the habit timer stops when the phone sleeps. |
| E83 | Routine Planner, Habit Tracker | App Store | 4 | 2024-08-13 | `11606439146` | R+ RF | ADHD: finally maintains morning, evening and end-of-work routines thanks to the timer. |
| E84 | Routine Planner, Habit Tracker | App Store | 5 | 2025-05-09 | `12634975055` | R+ RC RF | Likes that you can either run the timer or check tasks off yourself. |
| E85 | Fabulous | App Store | 2 | 2021-08-19 | `7712363758` | R+ RF | Everything wanted in a routine builder, including a choice of timed or not timed. |
| E86 | Routine Planner, Habit Tracker | App Store | 4 | 2023-05-22 | `9952706862` | RF RC | Wants to mark a routine step done instead of running a timer. |
| E87 | Routine Planner, Habit Tracker | App Store | 3 | 2020-11-19 | `6661289869` | RF RC | Suggests a simple done indicator instead of a timer auto-starting for each habit. |
| E88 | Routine Planner, Habit Tracker | App Store | 3 | 2020-09-27 | `6474496213` | R? RF | Would love the option to run routines without a timer. |
| E89 | RoutineFlow | Google Play | 4 | 2023-04-25 | `09dfb136-9f6f-461c-99ab-78248878ea69` | RF RC | Wishes they could tick each item off instead of starting a timed routine. |
| E90 | Routine Planner, Habit Tracker | Google Play | 3 | 2022-03-28 | `1ba28cda-ae01-49fc-9da0-e54c27da3b7f` | RF RC | Becomes just a stopwatch; wants to mark tasks complete without it being so rigid. |
| E91 | PlanMe | Google Play | 5 | 2023-11-20 | `f6eea06e-3100-4c27-9d98-be7f064d3b8e` | TV RF RC | Wants plan A/B/C for semester, vacation, holidays and a checklist beside routines; timers rush them. |
| E92 | Routine Planner, Habit Tracker | Google Play | 4 | 2021-02-05 | `81ca585c-1e66-455f-b1f0-a4aac54fee47` | RF $ | Timing of each task once started is very stressful; red overtime colour feels bad. |
| E93 | RoutineFlow | Google Play | 5 | 2023-12-04 | `08d1c0dd-1c45-48d7-b981-bad51033e6de` | R+ RF | Timer gave anxiety at first but is what makes it more productive than a checklist. |
| E94 | Routine Planner, Habit Tracker | App Store | 2 | 2022-12-18 | `9409668585` | RF L | Must stay on screen to run; routine includes other apps so it breaks. |
| E95 | Routine Planner, Habit Tracker | Google Play | 2 | 2023-03-23 | `e2aa7070-dad0-4e36-aed7-ee33c71f7abe` | RF L | Stopwatch stops when you leave the app, so it is useless. |
| E96 | Routine Planner, Habit Tracker | App Store | 1 | 2026-07-31 | `14371016110` | RF L | Persistent start alarms were removed; they were the point of the app. |
| E97 | Routine Planner, Habit Tracker | Google Play | 4 | 2020-07-06 | `23858dac-0fd3-4e0e-ad02-ab8a9424f595` | RF $ | Start notifications are too subtle to notice; wants a full-screen alarm option. |
| E98 | Routine Planner, Habit Tracker | App Store | 4 | 2024-02-10 | `10924800327` | R+ RF W | Wants to run routine timers from the watch without opening the phone. |
| E99 | Routine Planner, Habit Tracker | App Store | 3 | 2025-03-20 | `12442067714` | RF W L | Watch app ends a running routine; hoped to stay off the phone; shopping around. |
| E100 | Routine Planner, Habit Tracker | App Store | 3 | 2025-02-22 | `12342952953` | RF TV $ | Free tier allows only two routines; needs about five (study, skincare, going out). |
| E101 | RoutineFlow | Google Play | 5 | 2026-07-02 | `e3439522-9e2e-4fe8-9b42-41709163c808` | RF TC $ | Only one routine free; wants morning and night separately. |
| E102 | Routine Planner, Habit Tracker | App Store | 3 | 2023-09-03 | `10330070398` | RF $ L | Hit the routine limit and was asked to pay $30 a year to add one more. |
| E103 | Routine Planner, Habit Tracker | Google Play | 5 | 2021-01-21 | `60d1d18b-dc1e-44b2-afcc-e5c75da5e0a0` | RF TC $ | Wants three free routines, e.g. morning, afternoon, night. |
| E104 | RoutineFlow | Google Play | 3 | 2024-05-27 | `9078d872-c823-4b7c-beaa-2bea9b418722` | RF $ | Free plan allows one routine; wants a morning AND an evening routine. |
| E105 | Routine Planner, Habit Tracker | Google Play | 3 | 2021-01-13 | `30fb4bae-7e87-4f52-a13e-54791df4cc8d` | RF L | Too rigid: must complete in order; skipped items cannot be checked later; parents need flexibility. |
| E106 | RoutineFlow | Google Play | 3 | 2022-12-28 | `e3ecdbcd-1498-4b5f-ab18-902ee55a5b0d` | RS RC RF | Wants more of a checklist so a parent can do things in a different order and still count. |
| E107 | RoutineFlow | Google Play | 5 | 2023-05-15 | `9ee23c15-5c43-47fc-b8e6-43697cb1cfef` | R? RS | Wishes steps could be moved around after the routine has started. |
| E108 | Routine Planner, Habit Tracker | App Store | 4 | 2022-10-12 | `9175533341` | RF R? | Wishes a routine did not have to be tied to a specific time; plans change. |
| E109 | Routine Planner, Habit Tracker | App Store | 4 | 2023-09-24 | `10402562707` | RF L | Works nights with small kids; a fixed start time does not fit. |
| E110 | RoutineFlow | Google Play | 5 | 2022-11-20 | `88080365-0eb2-47cb-bb31-35fec12769e6` | R+ RF | Praises being able to start routines whenever, unlike apps that fix a time of day. |
| E111 | Loop Habit Tracker | Google Play | 5 | 2024-08-10 | `263631bc-2449-46fd-a0ac-6bdb531d8238` | RC T? | Suggests habit groups like 'morning' that can be ticked in one press or item by item. |
| E112 | Loop Habit Tracker | Google Play | 3 | 2020-01-16 | `ddf25d14-3197-498b-a6a4-3a7d55354dae` | RC T? | Cannot create a morning-routine group of habits; gives 3 stars for that. |
| E113 | HabitNow Daily Routine Planner | Google Play | 3 | 2024-01-27 | `78cf2557-0746-4b39-a74c-b42da5c03c42` | RC GD GF | Lists can only take whole categories, not individual habits for a morning routine. |
| E114 | Me+ Lifestyle Routine | App Store | 5 | 2023-12-04 | `10654881787` | T? RC | Asks for separate morning and night routine lists. |
| E115 | MyRoutine | Google Play | 4 | 2024-07-12 | `f3f6c05a-8e46-41ea-ba95-5f69ae8654b7` | TV G? | Wants routine folders for seasons or events (winter, wedding countdown, exam). |
| E116 | RoutineFlow | Google Play | 4 | 2023-11-05 | `e96d983b-e55e-4aa8-84b5-4e7a3134b006` | G? R? | Would love to organise routines in folders or tags and auto-advance to the next step. |
| E117 | HabitNow Daily Routine Planner | Google Play | 5 | 2023-08-12 | `e7dced85-639a-46f9-82c6-67a4a2ccdaa3` | G+ S+ TO | Loves categorised recurring habits with checklists and custom reminders. |
| E118 | HabitNow Daily Routine Planner | Google Play | 5 | 2021-10-24 | `2e778c7e-e437-4337-86b1-42d348e69b77` | S+ RC | Checklist feature finally groups tasks and saves screen space. |
| E119 | Strides | App Store | 5 | 2019-02-26 | `3815207063` | S+ | Handles habits with sub-steps as well as to-do projects; very flexible. |
| E120 | Loop Habit Tracker | Google Play | 5 | 2024-05-06 | `6325de43-bf27-499e-9b09-bc08421d0aa6` | G? RC S? | Asks for folders (morning, evening routine) and sub-habits inside a habit (exercise -> 10 push-ups). |
| E121 | Motivated | Google Play | 5 | 2025-01-16 | `ce9d4c2e-ac25-42fe-b6fc-512c35565f1d` | S? TM | Wants mini sub-points, e.g. brush teeth with morning and evening items. |
| E122 | Habit Tracker | App Store | 5 | 2023-09-03 | `10330830619` | S? R? | Wants sub-tasks for habits to hold a step-by-step guide. |
| E123 | Habit Tracker | App Store | 4 | 2026-01-30 | `13692456434` | S? RC | Wants a checkbox habit, e.g. Morning routine with water, wash face, teeth, mobility. |
| E124 | HabitNow Daily Routine Planner | Google Play | 4 | 2022-11-20 | `1e6345c8-46d8-466e-8a23-cfab2bd28a66` | S+ SP GL | Checklist habit counts as not done unless every item is ticked; wants partial state. |
| E125 | Loop Habit Tracker | Google Play | 5 | 2021-01-07 | `589ba2fa-dbe7-4537-ab6f-ab1aea04e92c` | S? SP | Wants sub-categories so a habit completes when all its parts are done. |
| E126 | Streaks | App Store | 4 | 2015-08-30 | `1250902830` | S? SP | Wants sub-goals that mark partial completion of a larger daily goal. |
| E127 | Loop Habit Tracker | Google Play | 4 | 2023-02-15 | `1d4dcc27-a03d-4c79-b2d2-766751faace9` | GV SP S? | Wants a 'vitamins' group that expands and gets its own check when all inside are done. |
| E128 | HabitNow Daily Routine Planner | Google Play | 5 | 2023-08-18 | `295970ec-bb73-4d57-ae11-e72a476bf734` | ST $ | Wants a timer or stopwatch on each checklist sub-item. |
| E129 | HabitNow Daily Routine Planner | Google Play | 4 | 2024-04-11 | `4688e86c-b5f4-4290-8093-85cae60ecfd3` | S+ ST | Wants minutes set per checklist item inside an exercise habit. |
| E130 | Eden | App Store | 5 | 2026-03-17 | `13858664729` | S? ST | Wants sub-points that each get their own reminder. |
| E131 | HabitNow Daily Routine Planner | Google Play | 4 | 2026-09-05 | `b5b9f625-86e5-4da6-964e-f34bb40e7d97` | ST | Wants statistics for individual sub-categories inside a multiple habit. |
| E132 | Loop Habit Tracker | Google Play | 5 | 2022-10-17 | `8c3a4667-12a0-4ef4-9ff0-7be10e8a0e20` | S? ST | Wants a gym habit with sub-categories (chest, back, shoulders) holding exercises. |
| E133 | Habitify | App Store | 1 | 2026-04-20 | `13977555592` | SF $ | Checklist inside a habit is behind the paywall; not really free. |
| E134 | ShineDay | App Store | 4 | 2020-04-07 | `5776161898` | S+ SF | Sub-items auto-expand on every launch and look cluttered; wants to choose. |
| E135 | Me+ Lifestyle Routine | App Store | 5 | 2024-07-09 | `11474472371` | SF | Wants to move sub-tasks by tapping instead of deleting and re-adding. |
| E136 | Strides | App Store | 1 | 2025-09-11 | `13124800203` | SF SP | Completing sub-tasks does not change the parent's progress (0%). |
| E137 | Productive | App Store | 5 | 2016-05-31 | `1386617846` | SN | Loves that there is no clutter of sub-tasks, just did-you-do-it-or-not. |
| E138 | HabitNow Daily Routine Planner | Google Play | 5 | 2023-05-14 | `d2bef6ba-dbd7-4d06-a03e-96c1711023e8` | SN HT | Has the essentials without complex sub-sub-sub lists. |
| E139 | RoutineFlow | Google Play | 5 | 2024-06-24 | `85147850-bcb3-4f5c-b556-eae44f996ab4` | SN R+ | Easy, not overflowing with buttons that open multiple subtasks. |
