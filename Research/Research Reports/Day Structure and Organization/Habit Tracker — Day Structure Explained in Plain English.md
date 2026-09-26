# Habit Tracker — Day Structure Explained in Plain English

> **Written by Claude (Claude Code)**, 24 September 2026. Authorship of every report is listed in the [Research Reports index](<../README.md>).

Date: 24 September 2026. Status: an explanation of the evidence. **It is not a decision record.** Decisions are kept in Notion.

This report is a companion to [Habit Tracker — Day Structure Whole-Corpus Verification](<Habit Tracker — Day Structure Whole-Corpus Verification.md>). That report gives the counts and the ratings. This one explains **every row of every table** in plain words:

- what the row means;
- what users actually asked for;
- how the feature should work if you build it.

It also answers the stats questions directly: what to show for groups, whether to show stats per day section, and what to show after a guided run.

---

## How to read this report

**Scope.**

- Every number comes from the same hand-coded set: 5,066 habit-app reviews that discuss day structure, dated 2011–2026.
- "n" is the number of reviews.
- A percentage is always out of the row's own total, which is stated.

**What was added for this report.** Several rows in the first report were too broad to act on, for example "one habit in several sections". I re-read and sub-typed those reviews **by hand, every review**:

| Row | Reviews read |
|---|---|
| One habit in several sections | 153 |
| Exact clock time | 137 |
| Customising sections | 125 |
| Day-plan variants | 77 |
| Hidden / whole-day view | 88 |
| Group stats | 174 |
| Section-stats scan | 124 hits |

For a few other rows (manual order, filter vs headers, two dimensions, routine containers, habit stacking, per-habit timer) I split the hand-coded reviews **by keyword**. Those splits are marked *(keyword floor)*: they are minimum counts, because a keyword misses reviews that say the same thing in other words.

**References.**

- **E-numbers** point to reviews cited in the first report. They are repeated in Appendix B.
- **N-numbers** are new reviews cited here, in Appendix A.
- Every review ID was resolved by script, not typed by hand.

**Each item follows the same pattern:**

- **What it means**
- **What users said** (numbers)
- **How to build it**

---

# Part 1 — Time-of-day sections

Scope for Part 1: 1,574 reviews that talk about sections. Manual ordering is counted separately in 1.9.

## 1.1 "Praise sections or use them daily" — 656 reviews (41.7%)

**What it means.** People like having their day split into parts: Anytime, Morning, Afternoon, Evening. They say it stops the list feeling like "everything at once", matches how a day actually feels, and suits people who can't follow strict clock times. Examples:

- E1: time of day is what sets the app apart.
- E2: the split matches how we experience a day.
- E3: better than rigid time-blocking.

**What users said.** This is the most-praised structure in the whole day-structure set. Most of the praise comes from Productive and Fabulous: 402 of 656, or 61.3%.

**How to build it.** Ship the four default sections exactly as planned. Everything that follows in Part 1 is about doing them well.

## 1.2 "Ask for morning / afternoon / evening sections" — 190 reviews (12.1%)

**What it means.** These users are in apps that have no sections, such as Loop and HabitNow. They ask for them: "separators so I can see which medicines are morning and which are evening" (E9), "partitions in the list" (E8).

**How to build it.** Nothing extra. This row shows that people who don't have sections want them.

## 1.3 "Want one habit in several sections" — 153 reviews (9.7%)

**What it means.** One habit happens **more than once a day, at different parts of the day**:

- brushing teeth in the morning and at night;
- medicine three times a day;
- a planner check morning, afternoon and evening.

In most apps a habit can belong to only one section, so people make copies ("Teeth AM", "Teeth PM"). That splits the history and the stats.

**What users actually asked for** (hand-sub-typed, all 153):

| What they want | n | % of 153 | Example |
|---|---|---|---|
| The **same habit shown in several chosen sections**, each with its own tick | 79 | 51.6% | N1, N2, N6 |
| A **count per day** ("8 glasses", "3 times"), ticking one at a time | 35 | 22.9% | N12, N13, N14 |
| **Several reminders a day** for one habit | 32 | 20.9% | N10, N11 |
| Complain they had to **duplicate** the habit as a workaround | 21 | 13.7% | N18, N19 |
| Praise an app that already does it | 17 | 11.1% | N5, E17 |
| Want all check-ins **counted in one history** (partial days, totals) | 16 | 10.5% | N3, N7 |
| A rule for when the **day counts as done** across the slots | 5 | 3.3% | N8, N9 |
| **Every X hours** or inside a time window | 4 | 2.6% | N16, N17 |

**So is it reminders, or adding the habit to several sections?** Mainly the second, with reminders following from it.

- Half the reviews ask for the habit to *appear* in more than one section.
- A fifth ask for more than one reminder. In almost every case that is the same need: one reminder per time the habit is done.
- A fifth ask for a daily count, which is a different habit type (see "count habits" below).

**How to build it.**

1. **In the habit editor:** "How many times a day?" If more than one, the user picks a section for each time, for example Morning and Evening. Each of these is a **slot**.
2. **On Home:** the habit shows as a row in each chosen section. Teeth appears under Morning and under Evening, with its own tick in each place.
   - Ticking the morning row completes **only** that slot.
   - N4 describes a watch app that wrongly marks both slots done. Avoid that bug.
3. **Once the morning slot is done,** its row shows as done. The evening row stays open. It must not disappear or move (N6 asks for this behaviour).
4. **Reminders:** each slot can have its own reminder, at the section's start or at an exact time you choose. This covers the 32 "several reminders" requests without a separate feature.
5. **History and stats stay in one habit** (N3, N7, N19). A day with 1 of 2 slots done shows as partial, for example a half-filled dot.
   - **Default rule:** the day counts as done when all slots are done (N8).
   - **Optional rule:** "at least N of M slots". Some people prefer a softer rule, and N9 complains when nothing counts until every slot is done.
6. **Count habits are different.** "Drink 8 glasses whenever" is **one row** with a +1 button and progress 3/8 (N13). It lives in one section, usually Anytime.
   - Splitting a count across sections (N14: a morning, day and evening sub-target adding up to 8) is a later refinement, not v1.
7. **"Every 2 hours"** (4 reviews) is too rare to build now.

## 1.4 "Sections too coarse; want an exact clock time" — 137 reviews (8.7%)

**What it means.** "Coarse" means wide. "Morning" covers roughly six hours. Some habits need a precise time: "8:30", "meds at 9:00 pm", "meditate 8:30–9:15" (N20). If the app offers only Morning, Afternoon and Evening, these users can't set that.

**What users asked for** (hand-sub-typed, all 137):

| What they want | n | % of 137 | Example |
|---|---|---|---|
| Set a habit at a **specific clock time or time slot** (e.g. 8:30–9:15) | 59 | 43.1% | N20, N21 |
| A **reminder at an exact time**, not "sometime in the morning" | 31 | 22.6% | E22, N23 |
| **Show the time** on each habit and **sort the list by it** | 28 | 20.4% | N24, N25 |
| An **hour-by-hour schedule / timeline** view of the day | 24 | 17.5% | N26, N27 |
| More or finer sections in general | 9 | 6.6% | N28 |
| Every N hours / within a window | 4 | 2.9% | — |

**How to build it.**

1. **Optional time on a habit (or on each slot).** Leave it empty and the habit simply lives in its section. Set it, and:
   - the reminder fires at that time;
   - the habit sorts by time inside its section. N25 shows the classic bug: 9:25 listed after 9:30 because it was created later.
   - the time is shown on the row (N24).
2. **A timed habit sits in the section whose time range contains its time.** N22 suggests exactly this: make sections time ranges, and let habits with exact times fall into them.
3. **Do not build a timeline or calendar view.** That turns the app into a day planner, which is a different product. 24 people ask for it, but it is the least valuable part of this row for a habit tracker.

## 1.5 "Want to customise sections" — 125 reviews (7.9%)

**What it means.** The question was: is this about the first section's start, the last section's end, or the timings of each section? It is all three, plus names and extra sections. The reviews split like this (hand-sub-typed, all 125):

| What they want | n | % of 125 | Example |
|---|---|---|---|
| **More or different sections**: lunch, before bed, commute, a fourth med slot | 47 | 37.6% | N33, N34, N35 |
| **Change the start and end time of each section** ("my morning starts at 9", "at noon") | 28 | 22.4% | E19, N29, N30 |
| Praise apps that already let them customise | 26 | 20.8% | N41, N42 |
| **Day start / rollover**: "my night routine at 1 am counts as tomorrow" | 20 | 16.0% | E20, E21, N31 |
| **Shift work or changing wake times** | 13 | 10.4% | N38, N39, N40 |
| **Rename sections** | 9 | 7.2% | N36, N37 |
| A custom time window on a single habit | 4 | 3.2% | — |
| **Turn a section off** they don't need | 3 | 2.4% | E38 |

**The model that satisfies all of these.**

1. **Each section has a name and a start time.**
   - Its end is simply the next section's start. That way there are never gaps or overlaps.
   - Anytime has no time. It is always shown, at the top or bottom as the user prefers.
2. **"Day starts at" is a separate setting.** It is when yesterday closes and today opens. It is not the same as Morning's start.
   - A night owl can keep Morning at 9:00 and still have the day roll over at 3:00 am. Then a 1 am evening routine counts for the right day (E21, N31).
   - The last section runs until the day start.
   - A default a few hours after midnight is kinder to night owls than midnight itself. The exact default is a product call.
3. **Add a section:** name plus start time. Examples: "Before bed 22:30", "Lunch 12:30" (N33, N34).
4. **Rename** any section (N36, N37).
5. **Hide** a section without deleting it, for example "I don't need Afternoon" (E38).
6. **Order follows start time automatically.** Manual reordering of sections is not needed. The only ordering complaints were about sections showing in the wrong order after a bug (N74, and N35 for categories).
7. **Shift workers** are helped mostly by items 1 and 2: move the boundaries and move the day start. The deeper shift need, switching the whole plan, is in 1.6.
8. **Optional nicety:** N32 asks the app to check "did you finish yesterday?" before rolling over. A simpler version is to let people tick yesterday's habits the next morning.

## 1.6 "Want day-plan variants" — 77 reviews (4.9%)

**What it means.** Some people's days are not the same every day. Examples:

- weekdays vs weekends;
- day shift vs night shift;
- term time vs holidays;
- exam weeks;
- travelling.

They want a different set of habits or routines for each kind of day.

**What users asked for** (hand-sub-typed, all 77):

| What they want | n | % of 77 | Example |
|---|---|---|---|
| **Different habits on specific weekdays** (weekday vs weekend, a Monday-only step) | 33 | 42.9% | N43, N44, N45, N46 |
| **Periods**: semester vs holiday, exam season, winter, an event countdown | 13 | 16.9% | N49, N50, E115 |
| Bugs or usability in an app that already has "modes" (MyRoutine) | 13 | 16.9% | N48, N54 |
| **Shift work**: swap the whole day's set in one step | 11 | 14.3% | N47, E32 |
| Praise apps that already support it | 9 | 11.7% | N43 |
| **An alternative version of the same day** (short version, "bad day" version) | 8 | 10.4% | N53 |
| **Pause normal habits while travelling or on holiday** | 6 | 7.8% | N51, N52 |

**How to build it without over-engineering.**

1. **Weekday scheduling per habit** covers the largest part (42.9%). Example: "Gym: Mon, Wed, Fri". A habit that isn't due today doesn't appear.
   - For weekday rules on a single step inside a routine (N45, N46): the step is a habit, so it already has its own days.
2. **Pause a group** covers holidays, travel and exam season (N49, N51) cheaply. You already have groups. Add "Pause until…" on a group.
   - Paused habits disappear from Home and don't break streaks.
3. **Full "modes"** (a saved day plan per shift, switched from Home) is the only way to fully serve shift workers (N47). It is also the most bug-prone. MyRoutine's modes generate a steady stream of complaints: the mode resets the next day (N48), switching mixes up routines (E32), the switch is buried in settings (N54).
   - **Defer this.** Revisit it if shift workers become a target group.

## 1.7 "Sections hide habits, or force a split view with no whole-day view" (TH) and "Want the whole day visible with section headers" (TA)

These two rows are about the same problem, so they were sub-typed together: **88 reviews**.

**What it means.** Some apps show one section at a time, like tabs or swipeable pages. Some open automatically on the current part of the day. Users then:

- can't see their whole day;
- open the app to an empty screen;
- or lose unfinished morning habits once it becomes afternoon.

A third of these reviews (29 of 88) are from Productive, most of them after a redesign that made exactly this change (N57, N58).

**What users said** (hand-sub-typed, all 88):

| What they complain about / want | n | % of 88 | Example |
|---|---|---|---|
| **No single overview**: they must swipe or tap between Morning / Afternoon / Evening pages | 25 | 28.4% | N55, N56 |
| Want to **switch the time-of-day split off** entirely | 17 | 19.3% | N60, N61 |
| Want **one list with section headers** (all parts of the day on one screen) | 15 | 17.0% | E10, N63, N64 |
| Want to **choose or remember the default view** (e.g. always open on All) | 12 | 13.6% | N62, E11 |
| **Anytime or weekly habits handled badly**: forced into a period, or shown in every section | 12 | 13.6% | N68, N69 |
| The app **auto-jumps to the current period** and the rest is out of sight | 10 | 11.4% | E12, N57, N58 |
| **Praise apps that offer both** a "now" view and a whole-day view | 5 | 5.7% | N65, N66, N67 |
| **Unfinished habits disappear** when their window ends | 4 | 4.5% | N59, E13 |

**How to build it.**

1. **Home is one scrolling list** for the whole day, with a small header per section: Anytime, Morning, Afternoon, Evening. This is what users with headers praise and what the others ask for.
2. **Never auto-switch.** The app may scroll to the current section when it opens, but everything else stays on the same screen.
3. **Never hide unfinished habits** because their window has passed. A late morning habit stays visible, possibly marked "earlier today" (N59).
4. **Optional "Now" focus toggle** for people who like seeing only what is due now (N65). It is off by default, and the app remembers the choice (N62).
5. **Option to turn sections off:** "Show my day as one plain list". This serves the 17 who don't want time of day at all. Their habits all sit in Anytime and the headers disappear.
6. **Anytime and "3 times a week" habits** go in Anytime. They never repeat in every section (N68).
7. **Completed habits** may sink within their section or collapse, but never leave the screen without the user asking.

## 1.8 "Sections removed in an update" — 47 reviews (3.0%)

**What it means.** Almost all of these (46) are from Me+, which removed its morning/afternoon/evening grouping. Every task became "any time of day" (E27, E28). Users were furious:

- the average rating is 2.55★;
- 47% of these reviews are 1–2★;
- 12 said they were leaving.

**How to build it.** No feature, just a rule: once shipped, sections are part of how people run their day. **Never remove them in a redesign.**

## 1.9 "Manual ordering of habits" — 291 reviews (5.7% of all 5,066)

**What it means.** People do their habits in a particular order, like "make bed, then vitamins, then workout". They want the list in that order and they want it to stay that way. This row applies to any list, not only sections.

**What users said** *(keyword floor, of 291)*:

| Need | n | % |
|---|---|---|
| **Drag to reorder** / manual order | 236 | 81% |
| **Sort by time** / chronological order | 59 | 20% |
| **The order doesn't stick**: the app reshuffles daily or after edits | 37 | 13% |

Examples: N70, N73 (order jumbled daily), N71 and E25 (the sequence matters), N72 (orders things even without set times), N75 (drag teeth before stretching).

**How to build it.**

1. Long-press and drag to reorder inside a section. The order is saved permanently and never reshuffled by edits or updates.
2. Drag a habit into another section to move it there. This is the same as changing its section, and it keeps its history (see 1.10, "history reset").
3. Habits with an exact time sort by time. Untimed habits keep their manual position.
4. New habits go to the bottom of their section.
5. Widgets use the same order (N74).

## 1.10 Section complaints, row by row (248 reviews, hand-sub-typed)

These are complaints about how apps implemented sections. Each one is a pitfall to avoid.

| Complaint | n | % of 248 | What it means | What to do |
|---|---|---|---|---|
| **Bugs**: habits missing from sections, sync, lost data | 84 | 33.9% | After updates or restores, habits vanished from sections, weekly habits appeared in no section, or data was lost (N130, N131) | Test that every due habit appears in exactly one place per slot; never lose data on restore |
| **Clutter or confusion** | 59 | 23.8% | Mostly Fabulous: routines buried under ads and coaching (N132) | Keep Home to the day's habits only |
| **Cap per section or paywall** | 48 | 19.4% | "Only 4 habits per morning on free" (E33); limits even on premium (E34) | No per-section caps |
| **Fixed boundaries / rollover**; night owls, shift | 22 | 8.9% | Can't move "Night" past midnight; morning forced to start at 12 am (E19) | Editable section times plus a separate day start (1.5) |
| **Forced to assign a section, or can't turn one off** | 18 | 7.3% | Must pick a time of day for every habit (E36) | Anytime is the default; sections can be hidden |
| **Hidden / no whole-day view** | 12 | 4.8% | See 1.7 (E34) | One list with headers |
| **Reminders only per section, not per habit** | 12 | 4.8% | One alarm for the whole morning, not per habit (N133) | Reminders per habit or slot |
| **Section feature removed or changed** | 11 | 4.4% | Custom groups removed, only time of day left (N134) | Don't remove structure people rely on |
| **Exact time missing** | 8 | 3.2% | See 1.4 (N135) | Optional exact time |
| **History reset when a habit changes section** | 5 | 2.0% | Moving a habit from morning to evening wiped its streak (E39, E40, N112) | History belongs to the habit, not the section |
| **Want a category dimension besides time** | 5 | 2.0% | Time is the only way to organise (N136) | Groups (Part 2) |
| **Can't put daily repeats in different sections** | 3 | 1.2% | See 1.3 (N137) | Slots |

## 1.11 Stats for day sections: should you show them, and which ones?

**What users said.** I scanned every coded review for stats words near time-of-day words (124 hits) and read each hit:

| Signal | n | Example |
|---|---|---|
| Want or praise **stats per time-of-day section** | 11 | E5 (morning block and evening block completion), N98, N99, N100, N101, N102 |
| Want or praise **stats from a guided run** (time per step, skipped steps, per-routine history) | 10 | N106, N107, N108, N109 |
| **Don't want** time-of-day stats, or dislike split calendars per section | 2 | N110, N111 |
| **Lost history** when a habit changed section | 5 | E39, E40, N112 |

In addition, 12 of the 174 group-stats reviews are really about section stats (section 2.6). All of these counts are small (Limited evidence). People don't ask for section analytics. What they describe is simpler: "how many of my morning habits are left", and "how did my morning block go today".

**What to show.**

1. **Yes: a progress count in each section header on Home**, for example "Morning 3/5". It costs almost nothing and is exactly what E5 and N102 describe.
2. **Yes: habit stats stay attached to the habit**, not the section. Moving a habit between sections never resets anything.
3. **Yes: a short summary at the end of a Start run** (details in 3.8). This is what routine users praise most.
4. **Not in v1: a dedicated per-section stats screen.** Demand is small, and two users say such stats get in the way (N110, N111).
   - If you add it later, reuse the group filter. On the Stats screen, a "Morning" chip could filter the charts the same way a group chip does.
   - Do not build separate calendars per section. N111 calls that absurd.

---

# Part 2 — Groups

Scope for Part 2: 2,228 group reviews in habit context.

## 2.1 "Ask for groups, folders, categories or tags" — 933 reviews (41.9%)

**What it means.** People want to put habits into named buckets: Health, Work, Study, Home, Medicines.

- The main reason is a **long, cluttered list**: 73 say so explicitly (E41–E44).
- 95 are **already faking it with colours**.
- 214 (keyword floor) name a **time of day** as the group they want. In apps without sections, people use groups to fake them. With real sections, that part of the demand goes to sections.
- Loop, which has no groups at all, supplies 344 of these requests.

**How to build it.** Groups exist, are optional, and start empty.

## 2.2 "Praise or use grouping" — 668 reviews (30.0%)

**What it means.** Users of apps with categories (HabitNow, Habitify, Way of Life, Habitica) say grouping keeps things tidy. They often like being able to create their own groups (E45–E47).

**How to build it.** User-created groups, each with a name, a colour and an optional icon.

## 2.3 "Friction with an app's grouping" — 474 reviews (21.3%)

**What it means.** Things that went wrong with grouping in other apps. 22.2% of these reviews are 1–2★ and 28 people said they were leaving.

| Friction *(keyword floor, of 474)* | n | % | What it means | What to do |
|---|---|---|---|---|
| **Can't edit, delete or rename groups** | 110 | 23.2% | A misnamed tag is stuck forever (E68, E69) | Full edit: rename, recolour, delete |
| **Colour or icon choice** | 83 | 17.5% | Too few colours for 20+ groups (N113) | A decent palette or a colour picker |
| **Group order** | 70 | 14.8% | Groups sorted alphabetically or at random; "Before bed" shows above "Morning" (N35) | Drag to reorder groups |
| **Paywall or caps** | 70 | 14.8% | "Only 2 categories free", so they leave (E73) | Don't cap groups |
| **Bugs** | 66 | 13.9% | A group was created but doesn't show (N114) | — |
| **Preset or forced set** | 48 | 10.1% | Must choose from built-in categories only (N115, E70, E71); too many sub-categories to click through (E72) | No forced presets; no mandatory group |

## 2.4 "Use or want filter / tab / list switching by group" — 260 reviews (11.7%)

**What it means.** There are three ways apps let you "look at one group":

- **Filter**: a chip row above the list ("All · Health · Work"). Tapping one shows only that group's habits on the same screen.
- **Tabs or pages**: each group has its own tab or page, and you swipe or tap between them.
- **Separate lists**: independent lists, as if each were its own mini-app.

**What users said** *(keyword floor, of 260)*:

| Form | n | % |
|---|---|---|
| Filter | 93 | 36% |
| Separate lists | 81 | 31% |
| Tabs or pages | 71 | 27% |
| Names a time of day | 37 | 14% |

Praise examples: "tags let you zoom in with a filter on what's relevant right now" (E48); tapping a label to see only those habits (E51).

Refinements people ask for:

- remember the chosen filter, or not (N79);
- filter by several tags at once (N78);
- lists built from selected habits rather than whole categories (N77).

**How to build it (your plan: filter only).**

1. **A chip row on Home:** All · Group A · Group B …
   - All is always first.
   - Tapping a group shows only its habits, still under the section headers. So "Health" shows Morning: vitamins; Evening: stretch.
2. **Open on All by default.** You may remember the filter within a session, but always show clearly which filter is on. This avoids the hidden-habit trap (2.8).
3. **Habits with no group always appear in All.**
4. **Not in v1:** filtering by several groups at once (N78), and tabs or separate lists.

## 2.5 "Want visible group headers or collapsible groups on the list" — 158 reviews (7.1%)

**What it means.** Instead of filtering, these users want groups **visible on the main list**, as headings with habits underneath, often collapsible like folders:

- "a coloured header per life area — filters each time get annoying" (N84);
- "I want to see all goals at once, grouped" (N80, N81);
- "groups that fold and unfold" (N82).

**What users said** *(keyword floor, of 158)*:

| Need | n | % |
|---|---|---|
| Collapse / expand | 51 | 32% |
| Headers / dividers | 40 | 25% |
| Name a time of day as the header | 30 | 19% |
| Say filtering is annoying or not enough | 11 | 7% |

Examples of time-of-day headers: morning/evening medicines, or dividers by time and by weekly/daily (N83). Only 8 reviews explicitly criticise a filter-only design.

**Why filter-only is still right for your design.** Home already has section headers. Adding group headers would mean two levels of headings (Morning → Health → habits), which is exactly the clutter people want to escape. A fifth of these requests (those naming a time of day) are already met by sections.

**How to build it.**

- Keep filter-only.
- Make sections collapsible. That gives the "fold and unfold" feel people ask for.
- Optionally, show a small colour dot for the habit's group on each row, so the grouping is visible without headers. People who group by colour today (E55) will like this.

## 2.6 "Want group-level stats" — 174 reviews (7.8%)

**What it means.** People want to see how they're doing **per group**, not only per habit. Hand-sub-typed, all 174:

| What they want | n | % of 174 | Plain meaning | Example |
|---|---|---|---|---|
| **Filter the Stats screen to one group** | 48 | 27.6% | "Show me only my Medicine group's report" | N76, N90 |
| **A completion % per group for the day or period** | 37 | 21.3% | "2 of 3 workout habits done = 66%"; a ring or bar per group | E64, N88, N89 |
| **Compare groups** | 31 | 17.8% | "Which area gets the most or least attention?"; pie or balance view | N91, N92 |
| **A trend per group over weeks or months** | 24 | 13.8% | "Work 85% in January, Home 100% in February" | E65, N93 |
| **Overall stats across all habits** | 20 | 11.5% | One number for the whole day or month, regardless of group | N94, N95 |
| **A target per group** | 16 | 9.2% | "Any of these 3 sports, 5 times a week", or points per group | N96, N97 |
| **Stats per time-of-day section or routine** | 12 | 6.9% | See 1.11 | N98, N100 |
| Praise existing group stats | 11 | 6.3% | — | — |
| **Group progress on a widget** | 8 | 4.6% | Home-screen widget per group | N104 |
| **Time spent per group** | 7 | 4.0% | Hours per category, only relevant with timers | E67, N103 |
| Stats per sub-item | 5 | 2.9% | See Part 4 | — |
| Complain group stats were removed | 4 | 2.3% | Finch removed its category totals and people left (N105) | — |

**What to show for group stats (v1).**

1. **The same chip row on the Stats screen** (All · Health · Work…). Picking a group filters every chart to that group. This is the top request (27.6%) and it reuses what you already build for Home.
2. **One number per group per day or period: completion %.** This is habits done divided by habits due, counting slots (1.3). Show it on the group chip or at the top of the filtered stats.
3. **A simple "groups this month" list:** each group's completion % as a horizontal bar, sorted. This answers "compare groups" without pies or radar charts.
4. **The trend per group** comes free if the existing week/month chart respects the group filter.
5. **Overall completion %** across everything, shown when All is selected (N94, N95).

**Later, not v1:** group targets ("any of these, 5 times a week"), time spent per group (only if timers are common), and group widgets.

## 2.7 "Want category separate from time, or several tags per habit" — 57 reviews (2.6%)

**What it means.** This row mixes two related needs *(keyword floor)*.

- **Time and category as two separate dimensions** (18). In some apps one field does both jobs. You can put a habit in "Morning" or in "Health", not both (E58, E59, N85). Your design already separates them: section is *when*, group is *what area*. This row supports that choice directly.
- **Several tags per habit** (18). For example, stretching is both "Morning routine" and "Fitness" (N86, E62); praise for multi-category apps (N87).

**How to build it.**

- Keep section and group as two independent fields. The design already does this.
- In v1, a habit belongs to **one group**. Several groups per habit is a later addition, because it complicates filters and stats. Evidence is Moderate (57 reviews).

## 2.8 Two risks the evidence flags (Limited in count, severe in effect)

- **Hidden habits.** In some apps, tasks added without a tag couldn't be found (E74), and "All" didn't show everything (E75). Rules: All shows everything; untagged habits are visible; an active filter is always obvious.
- **Forced categorisation.** Mandatory preset categories drove people away (E70, E71, N115), while a few praise apps that don't force categorising (E76, E77). Rule: groups are optional and invisible until the user creates one.

---

# Part 3 — The Start button (guided run) and "no separate routine feature"

Scope for Part 3: 1,062 routine reviews.

## 3.1 "Praise a guided run" — 369 reviews (34.7%)

**What it means.** A guided run shows one step at a time: "Now: brush teeth — 2 minutes", with the next step coming automatically or on a tap. People say it removes decisions ("tells me what to do next", N118) and helps with time blindness. Many are ADHD users:

- 187 routine reviews mention ADHD, autism or executive function;
- 92 of those are praise (E82, E83).

**Concentration.** Most of this praise comes from two dedicated runner apps, Routinery and RoutineFlow: 269 of 369 reviews.

## 3.2 "Friction with guided runs" — 340 reviews (32.0%, hand-sub-typed)

| Complaint | n | % of 340 | Plain meaning | What to do |
|---|---|---|---|---|
| **Bugs, crashes, lost progress** | 102 | 30.0% | The run resets mid-way, starts from the last step, or loses history (N125, N126) | Keep the run state safe across app switches and restarts |
| **Notifications** missing, too weak, or nonstop | 58 | 17.1% | Start reminders don't fire, or fire 46 times (N127); users miss loud persistent alerts (E96) | Reliable reminders; the user chooses gentle or persistent |
| **Caps on routines, or paywall** | 53 | 15.6% | "Only 2 routines free: I need morning, afternoon, evening" (E102) | Sections are the routines, so there is no cap |
| **Timer pressure / want to tick without a timer** | 39 | 11.5% | "Let me mark done instead of a timer" (E86); timers feel stressful | Timer only if the habit has a duration |
| **Watch problems** | 39 | 11.5% | The watch ends the run or doesn't sync (E99) | Later; do it properly or not at all |
| **Rigid order**: can't skip, reorder or come back | 31 | 9.1% | Parents need flexibility (E105) | Skip, Later, and reorder during the run |
| **Clutter / preset content** | 30 | 8.8% | Ads and coaching pop-ups inside routines (N128) | A clean run screen |
| **Timer stops in the background** | 28 | 8.2% | Leaving the app kills the timer (E94) | Background-safe timer with a live notification |
| **Tied to a fixed start time** | 17 | 5.0% | "Plans change; I don't start at the same time every day" (E108) | Start any time |
| Need day variants | 8 | 2.4% | See 1.6 | — |
| Habit stacking broken | 7 | 2.1% | See 3.3 | — |
| Can't see the whole day | 5 | 1.5% | Routines hide the day (N129) | Home stays one list |

## 3.3 "Want or praise an ordered sequence / habit stacking" — 149 reviews (14.0%)

**What it means.** **Habit stacking** is the Atomic Habits idea of attaching a new habit to one you already do: "after I pour coffee, I meditate". In reviews it appears as:

- general praise for building stacks (116 name "stacking", *keyword floor*);
- concrete needs about **order** (53 mention order or sequence):
  - do habits in a set order (N118);
  - keep linked habits together when reordering (N119);
  - "triggers" that start a stack (N120);
  - a reminder for the next habit once the previous one is done. This is broken in Habitify, which frustrates users (N121).

**How to build it.** A section *is* a stack: its habits in their manual order. Start runs them in that order. You don't need a separate stacking feature. The "remind the next habit when the previous is done" behaviour happens naturally inside a Start run.

## 3.4 "Want a routine as a named bundle or checklist, not a timer" — 119 reviews (11.2%)

**What it means.** People want to group several habits into "Morning routine" and tick them as a list:

- "a habit group like 'morning' that I can tick in one press or item by item" (E111);
- "lists only take whole categories, not the habits I choose for my morning routine" (N116);
- "combine habits into routines, with routine stats" (N117).

*Keyword floor, of 119:*

| Signal | n | % |
|---|---|---|
| About grouping habits into a routine | 94 | 79% |
| Name a part of the day | 71 | 60% |
| Say checklist or tick instead of timer | 20 | 17% |

**How to build it.** This is exactly "a section is a routine": the section's habits are the checklist. The 60% who name a part of the day are served directly.

## 3.5 "Ask for a guided run" — 110 reviews (10.4%)

**What it means.** People in apps without a runner ask for one: "run routines without a timer" (E88), "move steps around after starting" (E107), "don't tie routines to a time" (E108).

**How to build it.** The Start button.

## 3.6 "Want a per-habit timer (single habit, not a sequence)" — 94 reviews (8.9%)

**What it means.** A timer on one habit, like "read 30 minutes", separate from routines.

- Complaints: the timer stops when the phone sleeps (N122); the timer records nothing (N123).
- *Keyword floor:* 26 explicitly ask for a timer on a habit.

**How to build it.** A habit with a duration can show a small play button on its row. That uses the same timer engine as Start: it runs in the background and records the minutes.

## 3.7 "Praise a runner app without naming the mechanic" — 71 reviews (6.7%)

**What it means.** General love for a routine app, for example "perfect for morning, evening, self-care, study, work routines" (N124). This shows that routine apps have a loyal audience, but it gives no design detail.

## 3.8 How Start should work (from all of the above)

1. **Every section header has a Start button,** including when a group filter is on. With "Health" filtered, Start runs only the Health habits in that section. That is how people get study, skincare or workout routines without a routine object (E100, E91, E115).
2. **The run screen shows one habit at a time,** with three actions: **Done**, **Skip**, and **Later** (move to the end).
   - A timer appears only if the habit has a duration.
   - Habits without durations are just tick and next. This serves the 148 people who want timer-optional runs (E86–E90).
3. **"Auto-advance when the timer ends"** is a setting, **off by default**. Some want it on and some find it rushes them (E92, E93).
4. **During the run the user can reorder or return to skipped steps** (E105, E107).
5. **Background-safe:**
   - the timer keeps going if the user leaves the app;
   - a persistent notification or live activity shows the current step;
   - leaving and returning never resets the run (E94, N125).
6. **Start any time.** Section times are only for placing habits and reminders.
7. **The run ticks the same habits as Home.** There is no separate routine history.
8. **End-of-run summary** (the stats routine users praise, N106–N109):
   - steps done and steps skipped;
   - total time;
   - for timed steps, planned vs actual minutes.

   Over weeks this becomes "average time of your Morning run" and "most-skipped step" (N109). v1 needs only the end-of-run screen and a small history per section.

---

# Part 4 — Sub-habits

Scope for Part 4: 682 sub-habit reviews.

## 4.1 "Ask for checkbox sub-items inside a habit" — 328 reviews (48.1%)

**What it means.** One habit with small parts you tick inside it:

- "Exercise → 10 push-ups, squats" (E120);
- "Morning routine → water, wash face, teeth, mobility" (E123);
- "teeth → morning and evening points" (E121).

A fifth of these (132 of 682, keyword floor) mention a routine or the morning. So many sub-habit requests are really routine requests, and sections plus Start already cover those.

## 4.2 "Praise checklist sub-items" — 145 reviews (21.3%)

**What it means.** Apps with checklist habits (HabitNow, Me+, Strides, Habitica) are praised for them. For example, "the checklist groups tasks and saves screen space" (E118).

## 4.3 "Friction with sub-items" — 145 reviews (21.3%; 33.8% of them 1–2★)

| Friction *(keyword floor, of 145)* | n | % | Plain meaning | What to do |
|---|---|---|---|---|
| **Reorder, edit or limits** | 46 | 31.7% | Can't reorder sub-tasks, or must delete and re-add (E135) | Drag to reorder; edit in place |
| **Paywall** | 32 | 22.1% | "The checklist inside a habit is premium only" (E133) | Keep checklists free |
| **Bugs** | 17 | 11.7% | Sub-task progress doesn't update the parent (E136) | — |
| **Display / collapse** | 9 | 6.2% | Sub-items auto-expand and clutter the list (E134) | Collapsed by default, with n/m shown |
| **All-or-nothing completion** | 4 | 2.8% | "Unless every item is ticked, the habit counts as not done" (E124) | A completion rule |

## 4.4 "Want typed sub-items" — 85 reviews (12.5%)

**What it means.** Sub-items with their own type:

- a timer per item, like "stretch 2 min" (E128, E129);
- a count per item;
- a reminder per item (E130);
- statistics per item, like "how often did I pick option 1 vs option 2" (E131, N139).

*Keyword floor, of 85:*

| Mentions | n |
|---|---|
| Time or duration | 27 |
| Count | 13 |
| Per-item stats or reminders | 22 |

**Why not build it.** Only 12.5% ask for it. Everything it offers already exists one level up: **make each part its own habit in a section** (with its own duration, count or reminder) and run the section with Start. Adding types to sub-items would give two ways to do the same thing and double the stats logic.

## 4.5 "Want the parent auto-completed, or partial credit" — 70 reviews (10.3%)

**What it means.**

- The habit should complete itself when all its items are ticked (E125: vitamins group checks when all inside are done).
- Or it should count as partly done: "3 of 5", or "at least 3 of 5 = done" (E126).
- N138 wants the day's overall % to include sub-tasks.

**How to build it.**

- The parent shows n/m.
- Completion rule: **all items (default)** or **at least N items**.
- Ticking the parent directly ticks all items.
- A half-done parent shows as partial in history, the same visual as a partial slot day (1.3).

## 4.6 "Prefer no sub-items" — 8 reviews (1.2%)

**What it means.** A few people praise apps *without* sub-tasks, for example "just did-you-do-it-or-not" (E137). This is a reminder to keep sub-items hidden until someone adds one.

## 4.7 How sub-habits should work

1. **One level only,** checkbox only.
2. **Where to add them:** in the habit editor, "Add checklist item".
3. **On Home:** the habit row shows "2/4". Tap to expand, tick items.
4. **Completion rule:** all (default) or at least N. Show partial days in history.
5. **Stats:** the parent habit's history as usual. A simple per-item "done X times this month" list inside the habit is enough for the few who want it (N139). No per-item streaks.
6. **Rule of thumb to show in the UI:**
   - parts of one thing you tick together → checklist items;
   - separate habits you do one after another → put them in a section and press Start.
7. **Free, not paywalled.**

---

# Part 5 — All the stats in one place

| Stat | Where | Why | Evidence |
|---|---|---|---|
| **Progress per section**, e.g. "Morning 3/5" | Section header on Home | "How many morning habits are left?" (E5, N102) | Limited, but cheap and natural |
| **Habit history** (calendar, streak, completion %), counting slots and partial days | Habit detail | Unchanged core; must survive section moves | Strong (E39, E40 on resets) |
| **Stats filtered by group** | Stats screen, chip row | The top group-stats request (27.6%) | Strong |
| **Completion % per group** (today / week / month) | Group chip or top of filtered stats | "2 of 3 workout habits = 66%" | Moderate–Strong (37) |
| **Groups compared** (ranked bars, this month) | Stats screen, All selected | "Which area am I neglecting?" | Moderate (31) |
| **Overall completion %** | Stats screen, All selected | One number for the day or month | Moderate (20) |
| **End-of-run summary**: steps done or skipped, total and per-step time | After Start | Routine users' favourite stat | Limited (10), strongly praised |
| **Per-item counts** for checklist items | Inside the habit | "Which option did I do more?" | Limited |
| *Later:* group targets, time per group, group widgets, per-section stats screen | — | — | Limited |

---

# Part 6 — Build checklist

**Sections**

- [ ] Four default sections: Anytime, Morning, Afternoon, Evening.
- [ ] Each section has a name and a start time; sections order themselves by start time.
- [ ] Add, rename and hide sections.
- [ ] A separate "Day starts at" setting (rollover).
- [ ] Home is one list with section headers. It never auto-switches and never hides unfinished habits.
- [ ] An optional "Now" focus toggle, remembered.
- [ ] An option to turn sections off (plain list).
- [ ] Habits can be done several times a day, one slot per chosen section, each slot with its own tick and optional reminder.
- [ ] Count habits (+1, n/N) are a separate habit type.
- [ ] Optional exact time on a habit or slot; it sets the reminder and the sort order.
- [ ] Drag to reorder within a section; the order is permanent; drag across sections to move.
- [ ] Moving a habit between sections never touches its history.
- [ ] No caps per section.

**Groups**

- [ ] Optional; none by default.
- [ ] A chip row on Home: All first, open on All, untagged habits in All, active filter obvious.
- [ ] Full edit: rename, recolour, reorder, delete.
- [ ] A small group colour dot on habit rows.
- [ ] The same chip row on Stats; completion % per group; a ranked month comparison; overall %.
- [ ] Pause a group (holidays, travel).

**Start**

- [ ] Start on every section header, respecting the active group filter.
- [ ] Done / Skip / Later; timer only for habits with a duration; auto-advance off by default.
- [ ] Reorder and return to skipped steps during a run.
- [ ] Background-safe with a live notification; resilient to leaving the app.
- [ ] Start any time.
- [ ] End-of-run summary; a small run history per section.

**Sub-habits**

- [ ] One-level checklist; n/m on the row; collapsed by default.
- [ ] Completion rule: all / at least N; partial days in history.
- [ ] Drag to reorder items; free.
- [ ] No typed sub-items.

**Deferred** (evidence Limited, or high bug risk):

- full day modes;
- timeline view;
- several groups per habit;
- group targets;
- per-section stats screen;
- watch;
- every-N-hours habits;
- count targets split across sections.

---

## Method notes

**Hand sub-typing.** New in this report for the "one habit in several sections", exact-time, customisation, day-variant, whole-day-view and group-stats rows, plus a hand-read of the 124 stats-scan hits. The sub-type files are saved next to the coded map in `Research Reports/Day Structure and Organization/Day Structure Evidence/Whole-Corpus Coding/`:

- `multi-section-subtypes.txt`
- `exact-time-subtypes.txt`
- `customisation-subtypes.txt`
- `day-variant-subtypes.txt`
- `whole-day-view-subtypes.txt`
- `group-stats-subtypes.txt`
- `section-stats-scan.txt`

**Keyword floors.** For manual order, filter / tab / list, headers, two dimensions, routine bundles, stacking and per-habit timers, the splits were made by keyword inside hand-coded sets. They are minimums.

**Other limits** (as in the first report):

- long reviews were read in windows around the matched words;
- a single coder did the coding;
- counts are mentions, not votes.

---

## Appendix A. N-references (new in this report)

Review IDs were resolved by script from the coded index. Each ID was checked against its app's `reviews.jsonl`. Gists are paraphrases.

| Ref | App | Store | ★ | Date | Review ID | Codes | Gist (paraphrase) |
|---|---|---|---|---|---|---|---|
| N1 | Habit Tracker | App Store | 5 | 2023-04-05 | `9788442073` | TM T+ | Wants one habit ticked in both the morning and evening lists, and absent from the afternoon list. |
| N2 | ShineDay | App Store | 5 | 2020-01-12 | `5392534160` | TC TM | One habit can only sit in one section; showing it in two sections means creating a second copy. |
| N3 | ShineDay | App Store | 5 | 2024-12-12 | `12055682808` | TM $ | Wants several check-ins in different sections, all counted in the same habit's history. |
| N4 | Habitify | App Store | 3 | 2021-04-28 | `7273250234` | T+ TM TF W | Likes splitting one habit into AM / PM / night with separate alerts, but the watch marks both done at once. |
| N5 | Productive | App Store | 5 | 2018-03-08 | `2284758864` | T+ TM | Praises scheduling one habit for several times of day instead of creating it three times. |
| N6 | Habit Hearts | App Store | 4 | 2025-01-04 | `12143331423` | TM | After the morning tick, wants the habit to move to the evening slot rather than stay under morning. |
| N7 | ShineDay | App Store | 4 | 2020-04-29 | `5877686227` | TM | With several reminders a day, wants a separate check-in record for each time period. |
| N8 | Streaks | App Store | 3 | 2015-07-23 | `1231800707` | TM | A planner check needed morning, afternoon and evening; wants all three required before the day counts. |
| N9 | Me+ Lifestyle Routine | Google Play | 1 | 2023-09-27 | `40521efd-6d41-4ab8-9a7c-429e2d2c06a2` | TM SF | Teeth three times as part of routines: cannot tick it until all three times are done. |
| N10 | Finch | App Store | 5 | 2024-09-03 | `11683046715` | TM | A twice-daily habit gets one reminder; must create duplicate goals to be reminded twice. |
| N11 | Loop Habit Tracker | Google Play | 4 | 2019-01-13 | `34c3b06c-f52b-41c1-ac64-4d536c78817f` | TM | One habit = one notification; doing something morning and evening means two habits, two graphs. |
| N12 | Habit — Daily Tracker | App Store | 5 | 2020-03-06 | `5623922975` | TM | Wants teeth morning/evening in one habit, half-filled after the first tap. |
| N13 | ShineDay | App Store | 5 | 2020-03-08 | `5630917021` | TM | Wants 7 glasses a day to fill in 1/7 steps per tap. |
| N14 | Habit Tracker | Google Play | 5 | 2024-05-07 | `c1bd8dc1-ca14-41af-82c2-222e81afb52d` | TM ST SP | Wants 8 glasses split into morning, day and evening sub-targets that add up to the daily goal. |
| N15 | HabitNow Daily Routine Planner | Google Play | 5 | 2020-12-08 | `2ace8ebf-9228-49fc-b8e0-8ad6e4d21510` | TM ST | Praises adding 10 minutes of meditation three times a day towards a 30-minute daily target. |
| N16 | Productive | App Store | 5 | 2017-05-08 | `1608588546` | TM TE | Wants a habit every 2 hours through the day, not only once per section. |
| N17 | Habit — Daily Tracker | App Store | 3 | 2020-03-30 | `5735732049` | TM TE | Wants 5 push-ups every hour between set times; deleting the app because it cannot. |
| N18 | ShineDay | App Store | 5 | 2018-08-24 | `3106839647` | TM | Wants one habit done three times in different sections instead of naming copies 'XX1, XX2'. |
| N19 | Loop Habit Tracker | Google Play | 2 | 2018-02-18 | `ad216dbf-970e-4c07-a13a-c00c792eb693` | TM | Twice-daily meds need two separate habits and two reminders, which ruins the statistics. |
| N20 | Productive | App Store | 1 | 2023-12-28 | `10753562338` | TE L | Cannot give a routine a clock slot such as 8:30 to 9:15; cannot use the app. |
| N21 | Habit Tracker | Google Play | 5 | 2022-01-04 | `f5195b34-33a6-4630-a3fb-8edfb0a6a64e` | TE | Wants one habit at an exact hour inside the morning without moving the rest of the morning. |
| N22 | Habit Tracker | Google Play | 5 | 2022-02-27 | `73d3d410-4d23-410c-a2c8-599d7437d39d` | TE TC | Suggests sections become time ranges that contain habits with exact times. |
| N23 | Productive | App Store | 2 | 2017-11-21 | `1937839398` | TE | Reminders are only per morning/afternoon/evening; must set specific times elsewhere. |
| N24 | Productive | App Store | 2 | 2020-01-07 | `5373172344` | TE TO | Wants each habit's time shown in the list and the list auto-sorted chronologically. |
| N25 | Habit Tracker | Google Play | 5 | 2021-12-24 | `f901f947-673f-4e0e-a61a-9c4afe018152` | TO TE | Asks how to sort habits by time inside their section (9:25 should come before 9:30). |
| N26 | Productive | App Store | 4 | 2020-04-09 | `5784357359` | TE | Wants a timed schedule view of the whole day in addition to day parts. |
| N27 | Habit Hub | App Store | 4 | 2021-02-20 | `7017819148` | TE $ | Wants a daily planner view showing habits as time slots. |
| N28 | ShineDay | App Store | 2 | 2021-06-06 | `7432329369` | TE TC | Wants each section to carry specific clock times. |
| N29 | Productive | App Store | 4 | 2015-06-17 | `1213880362` | TC TF | Student and night owl: wants to set when the three periods end so habits are not 'overdue'. |
| N30 | Tappsk | App Store | 5 | 2021-10-16 | `7921454987` | T+ TC | Fixed morning/day/evening times are a good idea, but must be editable; their morning starts at noon. |
| N31 | Loop Habit Tracker | Google Play | 4 | 2017-09-25 | `3d129a4d-ab9d-4238-a257-2cb2e0167ed1` | TM TC | Night owl: wants the day to roll over at 2 am. |
| N32 | Loop Habit Tracker | Google Play | 4 | 2021-02-07 | `aefc0593-638f-42d6-a8e3-2de0648f556e` | TC | Wants the app to ask before starting a new day, in case yesterday was not logged. |
| N33 | Productive | App Store | 5 | 2017-09-03 | `1771112848` | TC TM | Takes meds four times a day; only three slots; wants wake-up, lunch, dinner, bedtime slots. |
| N34 | Productive | App Store | 5 | 2015-07-21 | `1230639082` | TC RC $ | Wants a separate 'before bed' routine so the evening section stays uncluttered. |
| N35 | Habitify | App Store | 4 | 2020-09-19 | `6443527252` | GF TO TC $ | Wants to reorder categories and to add own time bands such as commute or lunch break. |
| N36 | Fabulous Daily Routine Planner | Google Play | 4 | 2021-04-21 | `a5c82075-43ed-474b-90bd-540665c6c4d4` | T+ TC | Likes that the default morning/afternoon/evening groups can be renamed. |
| N37 | ShineDay | App Store | 5 | 2021-09-15 | `7807522940` | TC $ | Wants section names changed to morning, forenoon, noon, afternoon, evening, before bed. |
| N38 | Finch | App Store | 3 | 2024-08-03 | `11566387171` | TC | Shift worker: day counting and bedtimes misalign; wants to set morning/afternoon/evening/night times. |
| N39 | MyRoutine | Google Play | 1 | 2026-01-01 | `1eeac6a4-ec12-4cdb-a137-aea86fc6b7f3` | TC | Night-shift worker: day starts at night; wants to set wake-up and bed times. |
| N40 | Productive | Google Play | 3 | 2021-07-28 | `0559f5a0-6fc7-4b33-85ec-957b58ea2218` | TC | Night-shift: wants morning to be 14:00 to 16:00. |
| N41 | Habitify | App Store | 5 | 2020-05-11 | `5932629140` | T+ TC I | Switched apps because each period's time can be adjusted. |
| N42 | Habit Tracker | Google Play | 5 | 2023-07-04 | `935a2c9a-1c34-4030-a99b-af632407a095` | T+ TC | Praises sections calculated from the user's own wake-up and bedtime. |
| N43 | RoutineFlow | Google Play | 5 | 2024-02-16 | `65f6ffc9-a333-4a76-aa14-b41ecc73d61c` | R+ TV | Praises core daily routines plus different routines for specific weekdays. |
| N44 | Fabulous Daily Routine Planner | Google Play | 4 | 2022-12-14 | `4d6948ba-becc-48ca-b8b6-8a255915c8b0` | TV $ | Wants two saved sets of morning/afternoon/evening: one for weekdays, one for weekends. |
| N45 | Routine Planner, Habit Tracker | Google Play | 4 | 2020-12-20 | `99789bb3-6f66-44cb-b333-1cefb3aefc05` | R? TV | Wants days-of-the-week on individual steps inside a routine. |
| N46 | Routine Planner, Habit Tracker | App Store | 5 | 2025-07-19 | `12911127629` | TV | Wants conditions per task inside a routine, e.g. only on Mondays. |
| N47 | MyRoutine | Google Play | 5 | 2021-12-13 | `c607d2b5-dcb8-4ca9-beb0-5c0d8c24c843` | TV | Shift nurse: wants to switch the whole day's set of routines per shift in one step. |
| N48 | MyRoutine | Google Play | 4 | 2026-02-25 | `deca4978-5180-4780-a855-1d378a4de222` | TV RF $ | Uses five routine modes for shifts; the chosen mode resets to mode 1 the next day. |
| N49 | Habit Tracker | App Store | 5 | 2022-12-23 | `9426679660` | G? TV | Wants habit groups that can be switched on and off, e.g. a holidays group. |
| N50 | MyRoutine | Google Play | 5 | 2025-12-29 | `c68a02cf-b840-4896-943f-5685e16a653a` | TV $ | Asked for a separate exam-period routine set; thanks devs for adding routine modes. |
| N51 | HabitNow Daily Routine Planner | Google Play | 4 | 2023-07-13 | `44564785-0c4d-4003-8f3e-6438286d77c9` | TV | Wants to pause a group of habits, e.g. work-day routines while on holiday. |
| N52 | Productive | App Store | 5 | 2018-07-22 | `2947592923` | TV | Wants a mode for trips to snooze or skip all tasks for a period. |
| N53 | RoutineFlow | Google Play | 5 | 2024-03-08 | `ae69bcb2-3343-45ee-980d-8b23221723fb` | R+ TV | Keeps a shorter version of a routine for days with less time. |
| N54 | MyRoutine | App Store | 5 | 2025-12-26 | `13556531783` | TV $ | Routine mode must be switchable from Home, not buried in settings. |
| N55 | Productive | App Store | 3 | 2016-01-12 | `1315253865` | TA TH | Cannot see the whole day in one place; only morning, afternoon, night separately. |
| N56 | Productive | App Store | 2 | 2020-05-06 | `5909868820` | TH TA L $ | No single overview; keeps swiping between morning and afternoon pages. |
| N57 | Productive | App Store | 2 | 2019-12-21 | `5299406526` | TH TA | After update opens on the empty morning list; must scroll sideways to all-day habits. |
| N58 | Productive | App Store | 1 | 2019-12-22 | `5303610660` | TH | App auto-focuses the current time of day and shows nothing; must swipe to all-day. |
| N59 | Productive | App Store | 3 | 2017-11-18 | `1930839935` | TH | Unfinished morning habits vanish when the afternoon window starts. |
| N60 | Productive | App Store | 1 | 2020-01-07 | `5373909092` | TH | Asks for an option to remove morning/afternoon/evening entirely. |
| N61 | Productive | Google Play | 3 | 2020-06-15 | `fa85f13e-1c31-483e-81af-7538c3cee33b` | TH | Wants to disable morning/noon/evening times altogether. |
| N62 | Productive | App Store | 4 | 2020-06-04 | `6035890321` | TH | Wants Today to remember the last chosen view, e.g. All Day. |
| N63 | Productive | App Store | 3 | 2018-10-12 | `3292332659` | TH TA GV | Wants the full day list, grouped, to be the main screen. |
| N64 | Me+ Lifestyle Routine | App Store | 3 | 2024-02-02 | `10892491681` | T? TA | Wants the default view divided into morning, afternoon, evening parts. |
| N65 | Habitify | App Store | 5 | 2018-12-04 | `3491889583` | T+ TA | Loves seeing either the habits due now or the whole day. |
| N66 | Do Habits | App Store | 5 | 2024-01-06 | `10790122614` | T+ TA | Likes allocating to a time of day while still viewing the whole list together. |
| N67 | Habitify | App Store | 4 | 2018-01-02 | `2050580709` | T+ G? TA | Loves switching the view between all and time of day. |
| N68 | Habit Tracker | Google Play | 1 | 2024-02-14 | `ae5e4d84-94a1-4082-8d68-ac10846dfe22` | TF TH | A-few-times-a-week habits show in every section; wants a separate section for them. |
| N69 | Fabulous | App Store | 5 | 2023-08-17 | `10266506628` | TH | Wants tasks that can be completed any time of day, not tied to a period. |
| N70 | Productive | App Store | 3 | 2020-04-02 | `5748623490` | TO | Habits do not stay in the order set within morning/afternoon/evening; they move daily. |
| N71 | Productive | App Store | 5 | 2021-07-23 | `7609630224` | TO RS | Wants to reorder habits inside each time block because the sequence matters. |
| N72 | Habit Hub | App Store | 3 | 2024-10-16 | `11840965309` | TO RS L | Does things in a set order even without set times; cannot reorder; keeps abandoning the app. |
| N73 | Me+ Lifestyle Routine | App Store | 3 | 2023-08-03 | `10216117860` | TR TO | Task order gets jumbled and has to be reorganised every day. |
| N74 | ShineDay | App Store | 5 | 2018-07-19 | `2931388961` | TO W | Widget shows sections in a confusing order; wants morning-to-night order. |
| N75 | Rabit | Google Play | 4 | 2021-03-12 | `2b9386a5-9182-4d92-acc0-a0019109c570` | TO RS | Wants to drag habits freely, e.g. put brushing teeth before stretching. |
| N76 | Habit Tracker | App Store | 4 | 2025-04-25 | `12582947693` | GS GL | Wants the overall stats page to select a group, e.g. see only the medicine group report. |
| N77 | HabitNow Daily Routine Planner | Google Play | 5 | 2025-05-23 | `b0abfd3f-e29c-4456-9a6f-8dafcba6d561` | GD GL S+ | Only one category per habit; lists should allow AND/OR of categories. |
| N78 | Way of Life | App Store | 5 | 2016-04-16 | `1364076276` | GL GD | Wants filtering by several tags at once, e.g. free-time tasks on a chosen weekday. |
| N79 | TheFor | Google Play | 4 | 2024-03-18 | `d9f47220-1ca5-443b-a977-b0ef18b8416b` | RC GV TH | Wants the app to remember the selected filter instead of resetting to All. |
| N80 | Do Habits | App Store | 5 | 2020-07-08 | `6171008582` | GV GL | Tags and a category filter exist, but wants all goals visible at once, grouped by category. |
| N81 | Habit Tracker | App Store | 5 | 2022-12-13 | `9391204679` | GV GL | A tag filter exists, but wants a grouped view with dividers showing all tasks by tag. |
| N82 | Habit Tracker | App Store | 5 | 2024-02-05 | `10904548372` | G? GV | Many categories make scrolling long; wants groups that fold and unfold. |
| N83 | Loop Habit Tracker | Google Play | 5 | 2026-01-26 | `d9bc4062-0806-4cea-9c7c-ab3e6e2aec03` | T? GV | Wants separators or tabs by time of day and by periodicity. |
| N84 | Habit Tracker | App Store | 4 | 2023-07-24 | `10177962947` | GV TA GL | Wants a coloured header per life area or time of day on Home; filters each time are annoying. |
| N85 | ShineDay | App Store | 5 | 2021-12-07 | `8103345642` | GD G? | One field is used both for time of day and for category, so both cannot be done at once. |
| N86 | Me+ Lifestyle Routine | App Store | 4 | 2025-10-02 | `13214934363` | G+ GD | Wants several tags: stretching is both morning routine and health/fitness. |
| N87 | Habit Tracker | Google Play | 5 | 2026-09-01 | `1a8eb08e-d387-4738-af74-68edbd05b57f` | G+ GD RC $ | Praises one habit linked to several categories: a morning stack and an overall purpose. |
| N88 | Habit Tracker | App Store | 5 | 2023-07-31 | `10204139203` | GS | Wants a ring per category instead of one overall ring. |
| N89 | Habit Tracker | Google Play | 4 | 2024-02-08 | `05ec473c-58e1-4cf7-af93-b2b2a5ea29ee` | G? GS | Wants a tiled view showing n/x completed per category for the day. |
| N90 | Habitify | App Store | 5 | 2019-11-07 | `5099504216` | GL GS | Wants the progress screen filtered to one area/category. |
| N91 | HabitNow Daily Routine Planner | Google Play | 3 | 2026-04-23 | `7824ccec-b7aa-4038-859b-815014712719` | GS | Wants category percentages in charts to see which areas get most focus. |
| N92 | ShineDay | App Store | 4 | 2021-12-19 | `8147234803` | GS | Missing summary charts and category breakdowns. |
| N93 | MyRoutine | Google Play | 5 | 2023-01-07 | `f328972b-6e9e-4ab8-b2d5-f35529cbc704` | GS | Wants monthly/yearly completion counts per routine, per group and in total. |
| N94 | Habit Tracker | Google Play | 4 | 2023-08-10 | `8b2d8fe4-d028-4b01-bacb-7603fe73adc5` | G? GS | Wants an overall percentage across all tasks and one per category. |
| N95 | Habit Pixel | Google Play | 5 | 2026-07-05 | `a270791b-c51c-4c7f-bc8b-fc20338d0d3a` | GS | Wants an overview of all habits together, regardless of category. |
| N96 | Habit Tracker | App Store | 4 | 2026-04-28 | `14005073188` | GS G? | Wants a category target: at least 5 times a week any of three sports. |
| N97 | Habit Tracker | Google Play | 5 | 2025-03-11 | `994a1a4e-61f4-4548-83b3-326d633b9131` | GS SP | Wants a fitness category to count as done on any day yoga, lifting or running is done. |
| N98 | ShineDay | App Store | 5 | 2019-10-01 | `4869327189` | GS | Wants check-in statistics by time period. |
| N99 | ShineDay | App Store | 4 | 2019-07-08 | `4428439161` | GS TF | Wants a count of habits per time period. |
| N100 | Loop Habit Tracker | Google Play | 4 | 2020-05-16 | `f9fd4133-b9f4-4ca4-8574-ad98b4d6152a` | G? GS SP T? | Wants a group like 'morning routine' with its daily completion percentage. |
| N101 | Habitify | App Store | 3 | 2025-10-04 | `13224394178` | TF GS W | Watch progress complications for the current time of day and for an area were removed. |
| N102 | Habit Tracker | App Store | 5 | 2023-02-25 | `9653787577` | T+ | Sorts routine tasks by morning/afternoon/evening and sees the percentage still to do. |
| N103 | HabitNow Daily Routine Planner | Google Play | 4 | 2021-07-29 | `d725af06-65d5-43ea-a4c8-c7e28e6381cd` | GS | Wants overall statistics, not only per habit, plus hours spent by category. |
| N104 | Habit Tracker | Google Play | 4 | 2017-11-10 | `1b67c4dd-b3b2-4153-b8c8-9a2911602ce3` | GS W L | Leaving to find an app with category status percentages on the home screen. |
| N105 | Finch | App Store | 1 | 2025-04-18 | `12559327482` | GS L | Category totals ('Journeys') were removed; ADHD user feels unheard. |
| N106 | Routine Planner, Habit Tracker | App Store | 4 | 2021-10-27 | `7959641419` | R? S? TC | Per-routine time report (planned vs actual per step) is a godsend for time blindness. |
| N107 | Routine Planner, Habit Tracker | Google Play | 5 | 2020-07-29 | `c03bda07-3969-4ec7-8de7-3bb5ab5d2c36` | R+ | Praises the time report at the end of each routine for adjusting durations. |
| N108 | RoutineFlow | Google Play | 5 | 2023-08-30 | `36f563d0-837f-46cc-9d16-60d8cb433ba3` | R+ GS | Shows how long each task took and suggests adjustments; stats per routine over time. |
| N109 | Routine Planner, Habit Tracker | Google Play | 4 | 2020-08-20 | `3570c16c-2ed0-44e1-810c-c7633ecd8068` | R? | Wants a weekly summary of time per task and which items were skipped. |
| N110 | Habitify | App Store | 5 | 2020-05-09 | `5921374406` | TF | Time of day does not matter for their habits; the time-of-day statistics take space and should be hideable. |
| N111 | Fabulous Daily Routine Planner | Google Play | 3 | 2016-04-20 | `1a38d757-a68a-496b-a84c-943ec5d46ed5` | TF TH TA TC | Tasks are split into three undeletable sections, with one calendar per ritual; wants one combined calendar. |
| N112 | Productive | App Store | 4 | 2020-05-23 | `5985266266` | TF TV | Changing a habit's time of day or frequency resets its stats. |
| N113 | HabitNow Daily Routine Planner | Google Play | 5 | 2024-09-10 | `222e7a13-dce2-4184-b794-d94d7ab03284` | G+ GF $ | Has 20+ categories on premium and wants a full colour picker. |
| N114 | Roubit | App Store | 3 | 2022-11-13 | `9285542940` | GF | Created a routine group, but the group and its routines do not appear. |
| N115 | Habit Tracker | Google Play | 1 | 2020-01-19 | `3064b05d-5580-4a3e-b037-18ce85633014` | GF | Must choose from preset categories, as if everyone were the same. |
| N116 | HabitNow Daily Routine Planner | Google Play | 3 | 2024-01-26 | `b5a5dd3a-93f8-40fc-9aca-7fddea00dcbb` | RC GL GF GD | Lists only accept whole categories; cannot build a 'Morning routine' list from single habits. |
| N117 | Awesome Habits | App Store | 4 | 2022-01-28 | `8290170982` | RC GS W RS | Wants to combine habits into routines with routine-level stats and widgets. |
| N118 | Routine Planner, Habit Tracker | Google Play | 5 | 2021-09-27 | `c0ff81a5-b155-49ba-9d00-cef13c516089` | R+ RS | Loves performing a series of habits in a row on autopilot, told what comes next. |
| N119 | Routine Planner, Habit Tracker | Google Play | 4 | 2025-07-08 | `fe93abb1-92ba-4a0d-925a-4ad07fbd6077` | RS R? | Wants to link habits so they stay together when reordering. |
| N120 | RoutineFlow | Google Play | 5 | 2023-04-02 | `8e1e08c6-12fb-4195-b2f7-90c8cbd03d2d` | R+ RS | Loves adding triggers to stack new habits onto existing tasks. |
| N121 | Habitify | App Store | 2 | 2021-12-01 | `8083522711` | RS RF $ | Habit stacking does not remind after the previous habit is done, even on premium. |
| N122 | Habit Rabbit | App Store | 4 | 2024-02-23 | `10969074775` | HT RF | Habit timer stops when the phone sleeps or the app is left. |
| N123 | MyRoutine | App Store | 2 | 2026-09-03 | `14504465163` | HT RF $ L | Timer exists but records nothing; wants time totals and statistics. |
| N124 | Routine Planner, Habit Tracker | Google Play | 5 | 2021-02-07 | `7d920411-aee7-44d6-803f-e8d731fdcb00` | RU TC | Uses routines for morning, evening, self-care, study and work. |
| N125 | Routine Planner, Habit Tracker | Google Play | 1 | 2023-04-17 | `37357318-3ba3-4758-9bf4-1d6344873b6a` | RF $ | Routine resets itself mid-way and records the wrong start time. |
| N126 | Routine Planner, Habit Tracker | App Store | 1 | 2023-04-09 | `9803199216` | RF L | Routine starts from the middle or end every time; looking for another app. |
| N127 | Routine Planner, Habit Tracker | App Store | 4 | 2026-05-08 | `14039999029` | RF | Start-routine notifications would not stop; deleted the app once. |
| N128 | Fabulous Daily Routine Planner | Google Play | 1 | 2025-01-17 | `4e6e510d-83c9-4d9e-8f1f-24cd58e8d362` | RF | Mostly ads for other apps; a checklist in Notes works better. |
| N129 | Routine Planner, Habit Tracker | App Store | 5 | 2021-07-04 | `7538016690` | TA RF R? | Routines only show as groups; wants the whole day at once and ticking without the timer. |
| N130 | Productive | App Store | 2 | 2019-12-30 | `5339345897` | TF | After the update, weekly habits do not show under any section. |
| N131 | Productive | App Store | 1 | 2019-12-25 | `5319311402` | TF | Habits exist in the list but appear in no part of the day, so they cannot be completed. |
| N132 | Fabulous | App Store | 3 | 2022-01-04 | `8201856419` | TF | Home is so cluttered that the morning and evening routines are hard to reach. |
| N133 | Fabulous Daily Routine Planner | Google Play | 5 | 2019-11-07 | `02552f23-6041-4e0f-a8e6-e0fcce56238f` | TF | Needs an alarm per habit, not one per routine section. |
| N134 | Do Habits | App Store | 1 | 2025-06-18 | `12789423554` | GF TF | Custom groups disappeared; tasks can only be sorted by time of day. |
| N135 | Fabulous Daily Routine Planner | Google Play | 2 | 2021-05-06 | `6db12307-a1c5-4623-a0f2-d0611d01a94f` | TE TF | Only three sections, so only three alarms; prefers a calendar with exact hours. |
| N136 | Dear Me | App Store | 1 | 2025-01-20 | `12206654248` | G? TF | Just a list added to the day; wants categories like cleaning or health. |
| N137 | Habit Tracker | App Store | 4 | 2022-10-03 | `9145349154` | TM TF | When a habit repeats several times a day, cannot say which part of the day each belongs to. |
| N138 | HabitNow Daily Routine Planner | Google Play | 5 | 2026-02-23 | `376896c0-e5e3-4be5-b17d-4334e2eed1e0` | SP | Wants an overall daily % that counts tasks and sub-tasks, shown under the dates. |
| N139 | HabitNow Daily Routine Planner | Google Play | 4 | 2024-06-10 | `8016aab6-baf4-4bdb-86d1-ba07deaa1018` | ST GS | Sub-habits have no statistics for which option was done how often. |

## Appendix B. E-references (from the verification report)

The same table as Appendix C of the verification report, repeated here so this report stands on its own.

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
