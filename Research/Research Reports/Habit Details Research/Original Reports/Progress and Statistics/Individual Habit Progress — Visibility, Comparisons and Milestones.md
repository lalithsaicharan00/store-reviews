# Individual Habit Progress — Visibility, Comparisons and Milestones

**Author: Codex · 3 October 2026**  
**Status: Follow-up research recommendation after user review; no app implementation.**

**Revised recommendation: show a compact Overall record and a visible milestone summary, then open Week, Month and Year sections with actual content and inline previous-period comparisons.** Keep History / Notes / Progress as the job tabs. Do not put important facts behind label-only rows. Use disclosure for the legend, counting explanation, older comparison history and the full list of reached milestones.

This supersedes the earlier recommendation that stacked time sections should be avoided by default. The previous Figma board overused navigation rows—Recorded minutes by day, Completed weeks, Since started, Streaks and milestones—without showing what those sections actually contained. That made its information architecture look cleaner while leaving important content unseen. A period picker would remove one control row but would not fix that underlying problem.

## What the focused evidence supports

For this follow-up, 9 relevant originals from the previous verified set were re-read and 11 further originals retrieved, read in full and source-verified: **20 checked originals**, a purposive check rather than fresh whole-corpus coding. The evidence file includes relevant and contrary cases, and two mood requests outside this habit-statistics scope. Do not count all comparison-themed reviews as requests for a previous-week card.

| Original | What it supports | What it does not establish |
|---|---|---|
| Do Habits `7462593752` | Explicit request for one total for this week and one for last week; daily breakdown alone is insufficient | Every habit needs the same comparison chart |
| Habit Tracker `6345193240` | Values simultaneous month/year reporting; wants charts higher because scrolling to the bottom is inconvenient | Stacked sections universally outperform visible range controls |
| Do Habits `7908224726`; Habit Tracker `11596679734` | Exact values alongside charts or on inspection | A graph without numbers is enough |
| Productive `8501717309` | Wants total recorded repetitions without manually tallying a year | Only streaks or percentages satisfy the record job |
| Streaks `1437821189` | Recent week/month statistics can be more useful than only lifetime averages | Hide the accumulated record entirely |
| Habit Tracker `5543456646` | Explicitly praises its within-habit week/month/year comparisons | Every comparison must be visible as a separate full chart |
| Days Since `12090334442` | Wants archived, fixed periods so their records can be compared | Compare any two intervals without matching their definitions |
| Days Since `10193651577` | Wants recorded reset history and comparisons over time | Predictions or health claims are needed |
| Habit Tracker `d116ca92-55ee-4566-b91b-260f02dfb4d0` | Reached milestone badges should remain accessible rather than disappear | Milestone carousel placement is proven |
| Loop `8487e9e8-ef90-4cf5-8aa5-a60e10429ebd`; Days Since `12729490999` | Milestone recognition matters to some users; optional reminders requested | Mandatory reminders, scientific habit-formation thresholds, or a dominant full-screen milestone panel |
| Habit Tracker `7573610950` | One user wants total rate / previous-month comparison / logs hideable because they complicate understanding | Comparisons are unwanted by everyone |
| Days Since `8404418658` | Longest/average streak comparison can demotivate; asks to hide selected statistics | Streak comparison is the universal default for quit habits |

Additional originals `7912669673`, `10072478578`, `11388955514`, `12177691317` ask for quit patterns or richer event context, not specifically stacked period cards. `10879429787` and `11082857514` concern mood analytics, outside this change. The distinction matters: the prior PAT code is broad.

Full records, source paths and verified line numbers: [Visibility Evidence](<Individual Habit Progress Evidence/Visibility Evidence.jsonl>). Prior statistical counts remain in the original report; this follow-up does not invent a preference percentage or claim usage frequency.

NN/G's primary guidance makes initial visibility depend on the task: core information should be available up front, and secondary access must clearly predict what it reveals. This does not prove our exact card order; it supports correcting the label-only links. [Progressive disclosure](https://www.nngroup.com/articles/progressive-disclosure/).

Apple's chart-design guidance recommends descriptive numeric summaries and visible chart previews, with richer interaction introduced as needed; deeper views preserve the earlier values and context. Use an actual chart/count preview, not merely a menu label that says a chart exists. [Design app experiences with charts](https://developer.apple.com/videos/play/wwdc2022/110342/).

## Recommended page order

1. Shared habit name, actual goal/schedule, management menu, then History / Notes / Progress.
2. **Overall record**: accumulated recorded work and explicitly scoped goal-result count. Start date is supporting metadata, not a navigation row.
3. **Milestones**: actual current/next progress, latest reached milestone and current/best consecutive record where enabled. Full reached history can expand; the important facts stay visible.
4. **Week**: current week with exact dates, recorded facts, a concise previous-week comparison and the appropriate daily record / period-goal chart.
5. **Month**: current or selected month, recorded facts, previous-month comparison and an appropriate monthly visualization.
6. **Year in pixels**: selected year, self-contained year record and Share year. Legend remains an adjacent accordion as requested.

For daily build habits, compact Overall record + milestone summary should occupy limited space together; do not stack six large statistic tiles above the recent record. For quit habits the live recorded interval is the meaningful overall headline; comparisons and milestones remain adjustable because the counter-evidence is direct. Streak preference still applies; hiding streaks must not hide cumulative recorded work.

Week/Month/Year content is **open by default**. Historical period selection sits locally in the heading, e.g. previous/next arrows beside September 2026. A label that opens a date chooser selects dates; it does not conceal the current record. This removes the second tab row and a global scope that users must mentally apply to every section.

Older detail can be reached by clearly named actions after a visible result: More weeks, All reached milestones, Open day. A section's key information must make sense without taking that action. A full-scroll snapshot will be long because the year matrix itself is tall; use a visible Year in pixels shortcut to scroll to that section, preserving the selected year. A shortcut does not replace the section.

## What the previously unclear sections mean

**“Compare weeks”** should not be an empty destination. For a weekly total goal, show a **Recorded minutes by week** chart with exact dated buckets, plus the default prior-week comparison. A small recent-period chart can show a few recent weeks; its displayed count is a density choice to test, not a research-proven number.

**“Completed weeks”** is a different fact: how many *ended goal weeks* met their configured target. Example: **2 of 3 completed goal weeks met 180 minutes**. Keep it inside the corresponding goal-period section. It is irrelevant for a simple daily habit, where days are the goal unit. Do not create a generic Completed weeks row for every type.

**“Recorded minutes by day”** answers how much was recorded on individual dates. For a duration/amount habit, render that chart directly inside the relevant Week/Month section with units, baseline and inspectable values. It is not inherently a this-week-versus-last-week chart. A separate comparison sentence or pair of totals answers the comparison job.

**“Since started”** is metadata for **Overall record**. Show **84 h 45 min recorded** and **Since 1 January 2026** directly, with data scope/as-of. Optional detail explains eligible goals and missing records. Users should not need to open a separate page to see the accumulated total. Current and historical goals/units need the counting contracts from the original report.

## Default comparisons: yes, with an explicit contract

For comparable recorded quantities, show the previous adjacent period by default, inline. Exact values first; a factual difference can be secondary. Avoid evaluative arrows, “better/worse”, or colors that equate more consumption with improvement.

| Situation | Default comparison |
|---|---|
| Closed week | Full selected week vs full previous week, exact dates |
| Open week | Same elapsed habit days in both weeks; clearly label both date ranges and the as-of cutoff |
| Closed month | Whole selected month vs whole previous month; show lengths/eligible opportunity counts when relevant |
| Open month | Same elapsed calendar portion of both months; show actual ranges and missing-data scope |
| Different month/year lengths | Match available calendar dates or common elapsed portion; disclose clipping and extra days. Do not silently normalize |
| Daily check / checklist | Recorded goal counts with each period's eligible denominator; raw repetition/step counts if useful |
| Weekly/monthly goal | Actual goal-period total and applicable target; ended-period goal outcomes separately |
| Cut-down | Recorded quantity comparison with recording coverage; fewer recorded units does not certify lower consumption |
| Quit | Recorded slip/event counts or intervals; optional comparison rather than a universal “best streak” judgment |
| Goal/unit/type changed | Retain each target and unit. Suppress a misleading common comparison or show separate segments |
| No earlier record / tracking started midway | Show “No comparable previous period”; never invent zero |

The same-day cutoff needs actual data granularity. If only habit-day assignments are reliable, use **completed habit days** as the shared cutoff; do not compare a partial Wednesday with all of last Wednesday. If true event timestamps exist, an as-of clock-time comparison can be explicit. Generic logging timestamps and backfilled entries do not establish behavior time.

An overall cumulative total does not have a sensible “last week” comparator. A recorded streak can have current/best labels; no percent-growth badge is needed. A previous-period difference is transparent arithmetic, within the clarified facts-only brief, but arbitrary strength scores are still excluded.

## Repetition, visibility and clutter

Repeating the *metric* across clearly labeled time windows can help users: 45 minutes this week, 565 minutes in September, 5,085 minutes since start answer different questions. The design should be evaluated on usefulness, labeling and scanning effort—not on eliminating every repeated number.

Redundant representations within the same scope remain worth questioning: 100%, 7/7, a full ring and seven identical goal checks can all say the same thing. They may provide reassurance, but cost space; keep the complementary record and summary rather than fill each section with every chart available. A month grid and daily-amount bars may both be valuable, but they answer different questions. Choose a type-appropriate primary visualization, and expose another inline only where its question warrants the space.

Stacked sections have a real tradeoff: they reduce hidden state and switching but increase scrolling. Neither reviews nor generic HIG prove one layout wins. The revised stacked proposal is justified by the requested visibility and existing evidence; it needs an honest comparison against a **fully populated** range-control version. The previous label-only version was not a fair comparison.

## Milestones: visible summary, precise basis

Keep current/next progress and a reached record visible near Overall record, above the time sections. Example from the illustrative daily-goal fixture: current 5 eligible goal completions in a row, best 10; next unreached milestone 14, with 9 further consecutive eligible completions required; first 7 reached 8 January. The fixture explicitly excludes skip/pause from eligible opportunities and breaks the run on other non-met eligible days. These are sample rules and data, not a claim that the product's final streak semantics are settled.

For a weekly goal, milestones count consecutive goal weeks, not calendar days. For quit, show an elapsed recorded interval, with the anchor and pause policy. A cumulative milestone can use actual pages/hours if supported; threshold selection is still a product choice. No invented habit-formation or health benefit claims.

The milestone summary can be visible while older reached items are disclosed. Optional display follows evidence about motivational differences. User preference—not a blanket assumption that milestone data is secondary—should control visibility.

## Revised study and remaining validation

The [revised editable Figma study](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=357-1531) is on the existing inspiration page. It shows actual inline content and comparisons, not links standing in for a future screen. Main daily-duration example uses the original Month/Year fixture so figures remain consistent; a weekly-goal variant explains why goal-period results differ from daily-goal results. A third example shows the exact-day calendar alternative to the daily amount chart.

The 1,440 × 3,194 study was visually inspected. All three product examples use SF Pro, no visible descendants extend outside their phone bounds, the annual matrix includes all 31 date rows plus its month heading, and there are no image fills standing in for editable content. [Structural audit](<Individual Habit Progress Evidence/Visibility Figma Audit.json>). The buttons, calendar inspection and scroll shortcut specify proposed behavior; interactions are not wired. Local historical-period controls and optional hiding remain behavior specifications, not a complete interaction prototype.

Sample data: as of the **end of 30 September 2026**, this week's completed Monday–Wednesday recorded total is **45 minutes**, prior Monday–Wednesday **55 minutes**; prior full week **130 minutes**. September **565 minutes** versus August **600 minutes**; goal-result denominators **22/27** and **23/28**. Overall **5,085 minutes**, **196/249** eligible ended goals. Dates, differences and milestone crossings are calculated from the saved fixture, not hand-invented decorative statistics.

Test whether people can immediately state the current week's quantity, explain the comparison cutoff, distinguish period goals from daily logs, find cumulative work and a reached milestone, inspect an exact day, and reach/share the selected year. Measure wrong interpretations, switching/taps and scrolling effort across the populated variants. No app tests or implementation were performed for this research-only revision.
