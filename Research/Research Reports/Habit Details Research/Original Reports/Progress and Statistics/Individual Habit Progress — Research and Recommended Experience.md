# Individual Habit Progress — Research and Recommended Experience

**Author: Codex · 3 October 2026**  
**Status: Research recommendation; layout and counting contracts still need validation. No application code changed.**
> **Follow-up revision, 3 October:** the later [Visibility, Comparisons and Milestones study](<Individual Habit Progress — Visibility, Comparisons and Milestones.md>) recommends visible inline summaries and comparisons, open Week/Month/Year sections, and an upfront milestone summary. This earlier layout remains a research iteration; its label-only navigation rows and default preference against stacked periods are superseded.


Individual habit Progress ki recommendation: **selected period facts → daily record / year in pixels → one useful comparison → since-start record, streaks and milestones**. Oke screen lo “Over Time”, separate “Year”, multiple overlapping percentages, five longest runs pettadam avasaram ledu. Habit type batti actual facts maarali; section purpose and navigation consistent ga undali.

User accepted boundary: **recorded data + clear totals/counts**. Transparent arithmetic allowed. Habit-strength scores, predictions, estimated money/time saved, health claims, invented daily targets vaddu. History / Notes / Progress ane three jobs accepted; ee report Progress meeda focus chestundi.

## Evidence and what it establishes

Ee study lo **87 original reviews**, **28 app/store datasets**, **22 May 2014–4 September 2026**, individually read chesi original source path, newline-based line number, full text verify chesanu; zero missing. **14 diagnostic ledger cards** fully checked, covering C012 grids, C047 totals, C101 milestones, C216 forgiving progress, C217 explainability, C256 missing/skip semantics, C308 quit tracking. Full originals and method [evidence folder](<Individual Habit Progress Evidence/Verified Review Index.md>) lo unnayi. Ledger cards secondary analysis; vaati whole-report counts ni fresh verification laga present cheyyatledu.

Prior [comprehensive Progress research](<The Progress Page — What People Need, and How to Build It.md>) evidence TSV lo 14,726 unique reviews, 11,870 on-topic codes unnayi. Below counts aa stored coding nunchi recomputed; **fresh whole-corpus recoding kaadu**. Themes overlap; app IDs separate store datasets kuda include chestayi. These counts establish recurring problems; usage frequency, market prevalence, chart preference ranking establish cheyyavu.

| Prior code | Reviews / 11,870 on-topic records | Share of coded on-topic set | Review date span | Meaning / limit |
|---|---:|---:|---|---|
| ?TOT | 440 | 3.71% | 2012-02-07–2026-09-04 | Totals requested; not every request for the same unit |
| ?PART | 230 | 1.94% | 2012-06-04–2026-09-05 | Partial progress requested |
| ?YEAR | 131 | 1.10% | 2015-07-06–2026-08-21 | Year view requested; not proof of one grid geometry |
| XNONDAILY | 245 | 2.06% | 2011-11-03–2026-09-03 | Non-daily schedule problems |
| XWRONG | 468 | 3.94% | 2013-05-29–2026-09-04 | Incorrect statistics; broad code |
| XCONF | 253 | 2.13% | 2011-12-10–2026-09-05 | Confusing statistics |
| XCLUTTER | 106 | 0.89% | 2013-12-24–2026-07-12 | Clutter complaints |
| ?EXP | 98 | 0.83% | 2011-02-03–2026-08-13 | Broad export requests, including raw data; **not 98 annual-image requests** |

Coding limitations direct checking lo visible: relevant Days Since trend request `10193651577`, Do Habits clutter complaint `8101391015` prior set lo NA; some relevant schedule originals coded set lo levu. Kabatti counts ni exhaustive feature census laga use cheyyakudadhu.

Most useful direct evidence:

| User need | Individually checked originals | Design implication |
|---|---|---|
| Exact quantity, not visually estimating bars | Do Habits `7908224726`; Habit Tracker `11596679734` | Total visible; bar/day inspection shows exact value |
| Raw success/fail/skip counts alongside percentages | Habitify `13291400972` | Prefer explicit count + denominator; percent optional |
| Lifetime work survives a streak break | Productive `8501717309`; HabitBull `e4caab0a…`; DotHabit `f9c34729…` | Keep recorded cumulative facts, not streak-only framing |
| Weekly target evaluated as weekly | Do Habits `7462593752`; Habit `3901732031`, `4685770593`; Habitify `13572292515` | Match goal period; no inferred daily target |
| Partial effort remains visible | Habit Tracker `6345193240`, `5670498596`; Productive `11462493635`; RoutineFlow `3e445595…` | Preserve actual values and partial states |
| History persists beyond this week/month | Streaks `10796378002`; Avocation `d2a54f67…`; Productive `2dbb9c3e…` | Navigate old periods; year and since-start reachable |
| No record differs from not doing | Loop `007a9215…`; ledger R41-089/R41-161 | Explicit missing-data state and counting explanation |
| Actual unit axis, readable duration | Loop `c94ac6df…`, `c603b916…` | Unit labels; hours/minutes, not ambiguous decimal time |
| Cut-down differs from building up | Motivated `174b7e07…`, `4316a23a…`; Loop `05abe6c1…`, `a4b5695d…` | More consumption is not more achievement; show actual limit |
| Quit history should survive a reset | Quit Bad Habits `10995642477`, `14000029981`, `14380495771` | Recorded slips and intervals retained; timer alone insufficient |
| Streak comparisons can demotivate | Days Since `8404418658` | Secondary and hideable; not universal top headline |
| Long UI screenshots are awkward | Habit Tracker `7458490388` | Compose a dedicated export, not screenshot the scrolling screen |

IDs abbreviated here for readability resolve to full IDs in the evidence index. No review quote is needed to understand the recommendation. Reviews support these jobs; **they do not prove this exact ordering, default range, 31×12 grid or interaction flow**. Those are design inferences to test.

## What other apps establish—and where they fail our brief

**HabitKit:** official changelog documents year grid, monthly completions chart, current/best streak, several completions per day, and year-in-review share images. Useful mechanisms: long record + exact totals; export composed separately. [Official changelog](https://habitkit.app/changelog).

Important caveat: its official guide defines “Completion Rate” using logged amounts and the **current** goal, capped at 100, rather than historical successful-day counts. A goal increase can lower the score without any old log changing. Adopt the inspection mechanism, **not this formula**. [Official metric explanation](https://habitkit.app/help/guides/a-streak-is-not-a-consistency-score).

HabitKit also distinguishes daily quantity goal from frequency: twelve repetitions on one day do not become four qualifying days. Its help says daily-goal edits preserve earlier goals, while the completion-rate guide reveals a different current-goal denominator. This shows why each metric needs its own explicit contract. [Daily goals and multiple completions](https://habitkit.app/help/habits-and-streaks/set-daily-goals-and-multiple-completions).

Its quit help describes automatic clean-day handling, a daily Stay Below rule, and limitations on quit charts/weekly limits. That model does not cover our full quit/cut-down scope. Our limit boundary should follow our configured “at most” rule; do not silently copy another app's strict-below boundary. [Quit tracking help](https://habitkit.app/help/habits-and-streaks/track-a-habit-you-want-to-quit).

**Habitify:** official documentation uses month/year selection, streaks, raw completion states and a multi-window consistency index. Use explicit scope and count breakdowns; omit its weighted index. Its feedback board contains a request to restore readable daily columns after a thin line replaced them. This is specific counter-evidence against “cleaner-looking line = better information”, not a universal bar-chart preference survey. [Progress documentation](https://intercom.help/habitify-app/en/articles/6113616-see-the-progress-of-a-good-habit), [first-person feedback](https://feedback.habitify.me/p/visual-representation-of-progress).

**Loop:** official project supports flexible schedules, charts and an advanced habit-strength formula; CSV/SQLite are analysis/data export. Flexible schedules are relevant; strength is outside the facts-only brief. Do not confuse raw data export with a share image. [Official repository](https://github.com/iSoron/uhabits).

**Adjacent quit/counter apps:** checked Days Since / Quit Bad Habits originals show requests for reset history, exact event times, optional streak comparisons and retained old intervals. These are stronger reasons for a factual quit record than for copying build-habit completion percentages.

**Supplied visual references:** [259:70](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=259-70) inspected: HabitKit year selector + horizontal seven-row grid + monthly line; visible months March–September, not twelve months visible at once. [297:53](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=297-53) inspected: bullet-journal-inspired months-as-columns, dates-as-rows, multiple tracker examples and side legends. It is visual inspiration, not preference evidence or a verified official app specification.

No live device walkthrough conducted. Official docs, source, supplied screenshots and original reviews support this study. Marketing claims do not establish behavioral effectiveness.

## Recommended information architecture

Shared habit header lo **habit name + actual goal/schedule + ⋯**. Edit/Pause/Archive/Delete menu lo. History / Notes / Progress tabs remain. Statistics annitini common header lo pettakudadhu; otherwise every tab cluttered avuthundi. Optional compact streak can remain only if user has enabled it; main factual summary belongs in Progress.

Progress default **Month**: recent history + enough pattern context, with less density than Year. This is a proposed compromise, not a proven usage fact. Remember last choice. Direct links from all-habits Progress preserve selected range/year and habit. Flexible weekly habit ki Week can be a sensible initial context; test this before automatic type-dependent defaults.

| Order | Visible heading / control | Question answered |
|---|---|---|
| 1 | Week · Month · Year; explicit dates and previous/next | Which period am I looking at? |
| 2 | **September 2026** / **This week · 28 Sep–4 Oct**; 1–3 facts | What was recorded, and which goals were met? |
| 3 | **Daily record** for Week/Month; **2026 in pixels** for Year | On which dates did it happen? |
| Near grid | **What the squares mean** accordion | What does each mark/color represent for this habit? |
| 4, conditional | **Recorded minutes by day**, **Completed weeks**, etc. | How do meaningful buckets compare? |
| 5 | **Since started · 8 Jan 2026** | What is the accumulated record? |
| Within 5, optional | **Streaks and milestones**; quiet current/next + reached list | What factual consecutive records were reached? |

“Since started” expands the full record; it is not a fourth tiny segmented label “All”. For long histories show a full-range summary and useful month/year buckets, not thousands of day bars. Within Week/Month a visible **Year in pixels · 2026** navigation row switches into Year context. Within Year, share action is beside that heading. Oke calendar/year grid ki rendu independent sections undakudadhu.

One selected-period summary does not silently mix current-week progress, this-month counts and all-time best. Current interval has explicit **so far / ends 4 Oct**. “Since started” is visibly separate from selected-period results. Max three facts is a design budget, not a researched magic number; fewer if the third repeats the first.

Empty record: “No entries recorded in September.” Allow Open history / Add past entry. “Not enough data” is not zero. Old year with no records still navigable; future periods are not presented as failures.

## Facts that scale to each habit type

| Habit / goal | Primary facts | Useful secondary facts / chart | Avoid |
|---|---|---|---|
| Daily check, once | Goal met on **18 of 22 ended planned days**; distinguish missing records | Selected-period daily grid; all-time completed-day count | Repeating 82%, 18/22 and identical bars everywhere |
| Multiple checks / count per day | **63 times recorded**; goal met on X of Y ended planned days | Actual daily counts; goal 3/day; exact bar values | Capping total at goal; equating entry rows with repetitions |
| Amount: pages, km, glasses | **340 pages recorded**; historical goal-met days | Actual quantity bars + applicable daily goal | Unitless %, “best day” that assumes more always better |
| Time / live build timer | **6 h 20 min recorded**; goal-met days | Recorded duration bars; sessions only if stored session identity exists | 6.33 hours unlabeled; invented session counts from edits |
| Checklist | Fully completed days; completed scheduled step opportunities | Optional per-step **8 of 10 planned opportunities** | Treating 4/5 steps as zero; comparing changed checklist as constant |
| N repetitions per week/month | Current **2 of 3 this week, so far**; ended weeks met X/Y | Repetitions per actual goal period; dated week labels | Converting target into daily quota; daily-streak framing |
| Total amount/time per week/month | Current **140 of 180 min this week**; ended periods met X/Y | Actual weekly/monthly totals with each period's goal | Dividing 180 by 7 and coloring each day as goal success |
| N qualifying days per week/month | **2 of 3 days** that met the daily threshold; optional raw total | Qualifying-day record + ended-period outcomes | 40 min in one day counting as two 20-min days |
| One total target since start | **450 of 1,000 pages recorded** | Factual cumulative amount; target reached date if derivable | Implied daily failures, forecast completion date |
| Cut-down daily | Actual recorded amount vs **at most 2/day**; recording coverage | Confirmed complete-day outcomes if coverage is supported | Blank = zero; darker = better for more consumption |
| Cut-down weekly/monthly | **9 recorded against a limit of 12 this week; period open** | Actual period totals; closed adequately recorded periods | Green “week achieved” on Monday while usage may rise |
| Quit / elapsed timer | Time since last **recorded** slip/restart, with anchor; recorded slips in range | Slip dates, retained intervals, optional longest recorded interval | “100% clean”, assumed abstinence, fake slips from resume events |

“Times recorded” means **sum of repetition values**, not database entry-row count. A quantity edited from 5 to 3 contributes 3, not 8. Deleted/undone entries are removed; cumulative totals can decrease after corrections. Checklist step count means recorded completed opportunities, with stable step identity and the checklist active that day.

Daily success uses the historical rule in force on that date. Weekly/monthly success uses a documented rule-change policy for the actual goal period. If goal frequency changes mid-period, segment it or mark that transition unevaluated; do not silently pick the last rule and rewrite old performance. Unit/type changes require separate series unless a exact supported conversion exists. Never add pages to minutes.

Averages are secondary because denominator choices can hide missing data. If offered, name them precisely: **“Average per recorded day · 6 days”** versus **“Average per planned day · 22 days”**. Averages over confirmed zero days include zero; unobserved days are not zero behavior. Percentages can be optional arithmetic summaries next to counts, not independent cards or composite scores.

## Counting and coverage contract

A value can be mathematically derived and still be factual, provided its inputs/scope are explicit. Separate **recorded quantity**, **goal result**, **record coverage**.

For build habits, ended scheduled opportunities form the denominator after documented skip/pause/off-day exclusions. Completed, partial, explicitly not done and unrecorded opportunities remain distinguishable. An unrecorded planned day can count as **no recorded goal completion**; it must not be labeled proof that the person did nothing. Provide breakdown in **How these numbers are counted** rather than four permanent cards. Today/current period remains separately visible.

For daily limits, a single recorded coffee proves at least one was logged; it does not prove only one was consumed. Without explicit complete-day confirmation or complete import coverage, show **recorded amount + days with entries**, and omit “days within limit” / “days with none”. If confirmation is added later, evaluate only confirmed closed days and disclose incomplete ones. Do not force a new daily confirmation UI merely to preserve a percentage nobody requested.

Quit absence-of-slip data can be shown as **No slip recorded**, not verified “clean”. Timer anchor should identify habit start, actual slip, or explicit restart/resume. A synthetic start/reset timestamp is not a recorded slip event. Two slips on one day are **2 events on 1 day**. Pause policy must say whether displayed duration excludes paused time or restarts at resume; preserve historical events either way.

| Case | Honest result |
|---|---|
| This week: 6 ended planned days, 4 met, 1 partial, 1 unrecorded; today pending | **4 of 6 ended planned days**; Today pending; full week's plan is 7. Not 4/4 or a finished 7-day result |
| Goal 3 checks/day; two days have 5 and 1 | **6 times recorded**, **1 of 2 days met goal**. Never cap total at 4 |
| 20 minutes on 3 days/week; Monday has 40 minutes | **1 qualifying day**, **40 minutes recorded** |
| Weekly goal spans 31 Aug–6 Sep | Calendar September quantity counts September dates; weekly result explicitly labeled 31 Aug–6 Sep. Do not claim all that week's quantity happened in September |
| Limit week: some entries, no confirmation of other days | Actual recorded total vs limit; open/incomplete coverage. No certified zero days |
| Quit: two actual slips on same date, later pause/resume | Two slip events; one slip date; resume recorded separately |
| No eligible ended period | “No completed goal periods yet”, not 0% or 100% |
| Goal changed, backfill, undo, leap year | Recalculate using applicable rules; preserve dates, units and explanations |

Week/month/year controls are **calendar windows** with exact dates. Goal-period comparisons are separately labeled **Weeks ending in September** or show explicit overlapping full weeks. Never put calendar-month quantity and full overlapping-week quantity under an identical “September total” label. Week labels include date/year, not just W1. Respect week-start, habit-day cutoff and local calendar policy. Logging time is not automatically behavior time: a backfilled generic entry timestamp cannot support “you usually exercise at 8 pm”.

## Which chart earns its space?

**Daily check:** grid is usually enough. Year can add **Goal met by month**, labeled **18 of 22 planned days**, where comparison helps. Percent-only monthly bars hide denominator differences; actual count + eligible-opportunity labels are required. Months with zero opportunities show a neutral empty state, not failure.

**Amounts/counts/durations:** zero-baseline bars answer discrete “how much per day/week/month?”; units on axis and exact value on selection. A goal line belongs only when it is an actual goal for that bucket. Monthly recorded totals across the year do not have an invented monthly target derived from a daily goal unless the label explicitly describes the sum of historical planned goals. No arbitrary 80% full-day threshold.

**Period goals:** chart actual weeks/months against their own goal/limit. Different targets use stepped/individual markers. Current bar is explicitly open. When calendar Year is selected, raw monthly sums and ended weekly outcomes answer different questions; choose the one matching the primary goal rather than stack both by default.

**Checklist:** grid + fully complete days first. Per-step comparison is useful when the user asks which steps were recorded: raw counts and denominators, including step start/end dates. No step-ranking claim from unequal opportunities.

**Cut-down:** show quantity/limit; over-limit is a factual boundary, not a punishment score. More recorded consumption must not receive a stronger success color. Low/unrecorded quantity does not establish success without coverage. A chart may use amount-colored cells with explicit “Recorded amount” legend; green goal checks only where outcome can be established.

**Quit:** day record of slips plus recorded-interval facts. Optional monthly slip counts are factual; line interpolation between events adds little. Keep old intervals after a slip. Exclude medical benefit timelines.

Default exclusions: habit strength, rolling weighted consistency, “best weekday”, longest gap, five-longest-run list, pie chart alongside identical counts, daily pace/forecast, several repeated averages. A factual cumulative curve can be an optional **Recorded total** view for total-target habits or explicit demand; it is not a forecast. A time-of-day chart needs actual event-time data. By-weekday analysis can be a later explicit question with counts/opportunities; no arbitrary “28 days unlocks insight” threshold.

## Year in pixels, interaction and legend

Recommended study layout matches the supplied portrait reference: **12 month columns × 31 date rows**, impossible dates blank. Full width, no side legend. On 390-pt phone, 350-pt content can fit a 14-pt date gutter + twelve 28-pt pitches. Visible square 24, pitch 28; complete year is tall and vertically scrolls. Full-year thumbnail/snapshot is available in export.

This is a tradeoff: wide year visibility vs tall page and smaller targets. A seven-row GitHub layout at 53 weeks cannot show all columns at 28-pt pitch inside 350 pt; it needs horizontal scrolling or much smaller cells. The current branch uses horizontal year scrolling. Neither geometry is proven preferred by reviews. Test portrait year against existing horizontal layout before finalizing.

Apple's indexed current accessibility table gives iOS/iPadOS **44×44 default, 28×28 minimum** control size and asks for sufficient spacing. A 28-pitch matrix is dense and not equivalently comfortable to normal controls. Never create overlapping 44-pt hit boxes on a 28-pitch grid. [Apple accessibility guidance](https://developer.apple.com/design/human-interface-guidelines/accessibility). Direct page requires JavaScript; size table verified through indexed official content.

Recommendation: cell tap **selects a date read-only** and shows **date + exact recorded value + applicable goal + state** in a normal-size detail row; **Open day** goes to the shared History day view. Tapping a cell never logs/undoes progress. Provide **Explore days** with normal calendar targets and **Go to date**, plus VoiceOver date/value/state labels and month grouping. Tiny-cell precision is an enhancement, not the only route to edit. If testing shows adjacent selection errors, annual taps should open the relevant month for precision rather than pretend day targeting is reliable.

Marks share the existing branch's visual grammar where meaning is valid: daily goal met ✓, distinct partial shades, skipped/pause/off-day symbols, today outline. But semantics must be type-aware:

- For a **weekly total**, daily cell means recorded amount, not fraction of an invented daily goal. Weekly goal outcome is shown on the weekly result.
- For **cut-down**, cells show recorded amounts/outcomes without rewarding larger consumption or treating unrecorded as zero.
- For **quit**, slip marker and “No slip recorded”; no daily completion percentage.
- Distinguish unrecorded ended day, explicit zero/not done, paused/skipped/off-day, before tracking, future, and nonexistent dates. No single blank that means all five.
- Partial shade communicates progress towards that day's actual daily goal, not arbitrary goodness. Exact amount remains accessible. Goal change dates are inspectable; different-unit eras need separate legends/series.

**What the squares mean** accordion belongs adjacent to the grid. First-use expanded is sensible, remember collapsed preference. Explanation updates by habit type; don't use the current generic “Goal met” key for every type. **How these numbers are counted** is separate help for denominator/coverage, not a duplicate color legend. In app, no large right-side scale. Share image must include its own legend even if app accordion is collapsed.

## Streaks and milestones

Streaks are factual consecutive **goal-period results**, not a habit-strength score. Days/weeks/months must be named, and paused/skipped transition rules explained. Current and best live in **Since started / Streaks and milestones**, below recent record; avoid duplicating “longest this week” when it simply repeats days done. Hide with the existing streak preference.

Milestones deserve an understandable place, not a detached carousel. Proposed compact line: **“Current run: 12 days · Next: 30 days”**, followed by **Reached milestones** disclosure. Milestone basis must be explicit: consecutive goal periods, total recorded quantity, or quit recorded interval. Arbitrary thresholds are product choices, not facts about when a habit is formed. Existing ladder can be inspected without claiming it is scientifically validated.

A reached milestone has a date only if data can establish that crossing under historical rules. Current best streak length alone cannot recover an exact award timestamp. Undo/correction should recalculate factual achievements; it must not preserve a false event as a verified achievement. Earlier valid achievements remain after a later break. Optional reached history is useful; “current centered, past left, future right” carousel has no demonstrated usability advantage here and takes attention from actual progress. No forced confetti, congratulation or milestone notifications in this IA proposal.

## Sharing and reachability

**Individual habit Year in pixels → Share year** is required by the brief. All-habits Progress should link to that habit with selected year preserved; that page's aggregate export is a different artifact. Don't make users search for a habit image through aggregate export.

Dedicated share preview includes habit title (editable visibility if desired), selected year, **As of 3 Oct 2026** for partial year, factual unit/count summary, applicable goal/coverage meaning, and a compact **bottom or side legend inside the image**. Notes and private event details do not automatically go into a grid image. Hide-name preference should be a meaningful preview control if provided, not an unexpected behavior.

Use the same grid states and historical rules as the in-app view. Future dates do not become failures. Export light/dark appearance with readable marks; preserve symbolic meaning rather than color alone. A period-goal year's daily amounts need a recorded-amount legend, not “Very good/okay/none”. PNG first is a sensible delivery format; optional story/square presets follow after the content is correct. Exact format is a product proposal, not established user preference.

Monthly/weekly image sharing is useful in particular accountability contexts (`d1f94777…`) and official apps demonstrate it, but the broad export request count also includes CSV/backup. It does not justify share buttons on every section. Keep the individual habit's Year share as this phase's focus; overview Week/Month sharing can be researched separately as planned. Existing `YearShare.swift` renders aggregate dots with no habit-specific legend; it is not already the requested feature.

## Current code and branch audit

Read-only baseline: working branch `claude/server-and-sync`, HEAD `a593dee`. Cached `origin/claude/progress-week-cards` at `2385768`; cached `origin/main` at `53af924`. Branch includes shared day marks, folding heat key and Week/Month/Year cards. **Live merge status and CI not confirmed**; no branch or merge actions performed.

| Location / observed behavior | Implication for follow-up implementation |
|---|---|
| `HabitPageView.swift`: monthly numbers, Today, calendar, Over Time, Year, Runs, Milestones, Notes, management together | Replace with accepted tabs; one named period context |
| `HabitStore+OverTime.swift`: count total capped per-day at goal | Preserve raw repetitions separately from achieved-goal credit |
| Same model: daily limits compute within-limit/zero days from absent entries | Coverage problem; actual recorded totals first |
| `HabitStore+WeekCards.swift` on progress branch: weekly/monthly/yearly total divided by 7/30.4/365 for daily shading | Inferred daily quota is outside facts-only brief |
| Shared heat key uses generic goal-met meanings | Keep visual system, adapt semantic key by type |
| Year taps route to first day of month; quit year callback has no effect | Exact-day read context / clear precision month route needed |
| `HabitStore+Progress.swift`: includes full goal periods ending in selected window | Label overlap precisely; calendar totals are a separate calculation |
| `quitStats` counts no-slip dates as clean; quit history can have synthetic start edge | Avoid unsupported clean-day claims and synthetic slip counts |
| Year share is aggregate-only and uses older dots without legend | Dedicated individual-habit export renderer required later |

These are audited behavior/design gaps, not claims that every path is a production bug. Some are intentional earlier policies that conflict with the clarified brief. Source changes and app tests belong in the implementation phase.

## Validation before locking the layout

Use realistic tasks across daily check, multi-check, timed, checklist, 3-days/week, weekly quantity, cut-down, quit and goal-changed history. Check whether users can explain a primary fact correctly, identify exact date/amount, distinguish unrecorded from zero, see an open period without calling it complete, find a previous year, correct through History without accidental logging, understand milestone basis, and share a self-contained year image.

Compare portrait year vs current horizontal grid for date-finding errors, effort and accessibility at normal/larger text sizes. Test weak color vision and VoiceOver. Don't claim density is solved merely because squares fit. This study establishes the content model and a coherent proposed IA; it does not substitute for usability testing.

## Editable Figma study and verification

[Open the Progress research board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=345-306) on the supplied inspiration page. Six editable examples: Month daily-duration record, weekly-total goal, portrait Year, dedicated year-share composition, cut-down coverage and quit event history. These specify interactions; the Figma study is not a wired prototype.

Reusable daily-record cell family has 11 states with variable-bound colors. Existing native segmented controls, rows and buttons reused; product text uses SF Pro. Final screenshot visually inspected after targeted refinements. Structural check: **zero font mismatches, zero child overflow, 11/11 cell-state fill bindings** (blank intentionally has no fill). Board 1,840 × 3,604; light appearance research mockups. Dark appearance, larger text and interaction accuracy remain implementation/usability validation work.

Month, Year and share examples use the same generated fixture: September **565 recorded minutes / 22 of 27 ended planned days**; Jan–Sep **5,085 recorded minutes / 196 of 249 ended planned days**. Figures are illustrative, not the user's records. Skip/pause exclusions and missing-data semantics are explicit. Full-year layout is tall: fitting twelve months across the phone does not mean the entire year fits within one viewport.

