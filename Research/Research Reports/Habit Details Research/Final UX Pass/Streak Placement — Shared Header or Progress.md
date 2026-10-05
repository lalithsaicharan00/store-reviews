# Streak Placement — Shared Header or Progress

Written by Codex (OpenAI), 5 October 2026.

**Recommendation: put Current streak and Best streak in the individual habit's Progress tab, visibly in its early summary. Remove the pair from the shared Habit-details header.** Keep the centered icon, name, goal/schedule, description and any paused/resume context above History / Notes / Progress. Preserve Today’s existing quick streak access.

**Scope:** individual Habit details only. “Progress” here means the tab inside this habit, not the app-wide Progress page. This is a focused research recommendation and a revision to existing layout studies, not a new mockup set, a formal Notion decision, an implemented feature or a usability-test result.

## 1. The question and why it changed

The current app screenshots at [420:2107](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=420-2107) have no header streak pair. The [4 October proposal at 433:2071](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=433-2071) added Current/Best below the habit identity following the user's earlier request. The user now asks whether those statistics belong in the common area when History, Notes and Progress already have separate jobs.

The earlier rationale joined two different findings: users value easy streak access, and the header identifies the habit. The first does not establish the second as the right placement. No reviewed evidence proves that users want both statistics above every tab. The revised recommendation keeps the progress information visible where people inspect progress, while giving the other tabs their own working space.

## 2. Method, evidence and limits

This pass re-read and verified **18 complete original reviews** selected from the prior Today streak and individual-habit Progress evidence. It includes praise, visibility requests, contrary preferences, units/correctness problems and context about broader progress. Each cited ID was retrieved from its source JSONL, not copied from memory. Reconciliation: **18 found, 0 missing, 0 duplicate source/ID pairs**. The full checked text, source path, current line number, date, rating and country/language metadata are saved in [Streak Placement Evidence.jsonl](<Streak Placement Evidence.jsonl>); the complete source index is below.

This is purposive verification for a placement question, **not a new whole-corpus or per-app analysis**. It does not estimate the percentage of users who prefer a header, the frequency of tab use, or current market prevalence. The selected originals span 23 August 2016–31 December 2025; reviews describe other apps and versions, not this proposed page. Original-language Chinese and Japanese reviews were read; English interpretations below are paraphrases. The Loop review's language metadata says German although its text is English; the text controls interpretation.

The earlier [Showing the Streak report](<../../Home Screen and Visual Design/Today Screen Habit Cards/31. Showing the Streak — One Unit Rule, One Place.md>) and [individual Progress follow-up](<../Original Reports/Progress and Statistics/Individual Habit Progress — Visibility, Comparisons and Milestones.md>) provided the retrieval leads. Their published counts have not been recomputed here and are not evidence of preference for this particular placement. The reusable full-app analysis procedure is not being represented as completed by this focused check.

The current SwiftUI header, Progress tab and Figma layer structure were also inspected. UX guidance was browsed on 5 October 2026. Sources below inform the reasoning; none tested this app's header.

## 3. What the reviews establish

| Evidence | User need | Placement implication and limit |
|---|---|---|
| Do Habits `9560249714`: “Why did they take away the streak number on the main page?”; Loop `1768efc5-64a0-4cc8-919b-6f3918229ff6` asks for countable habits' streaks on the main page, like yes/no habits. | Quick motivational feedback without opening every habit. | Preserve the existing Today surface. These are **main-list** requests, not requests for Current/Best over History or Notes. |
| Way of Life `1760651629` wants Best visible even after a break, instead of requiring another run of check-ins. Habit Tracker `6ad5d1f7-2278-4299-b010-aa527f8432fc` asks for Current/Longest to be highlighted while discussing the habit's calendar/statistics. | Readable Current/Best, with Best retained when Current resets. | This is the strongest counterweight to removing prominence. Show both directly near the start of Progress; do not bury them in an accordion or suppress Best because Current is short. Neither original compares our header with a Progress tab. |
| Streaks `1437821189` values a long streak as motivation, alongside recent week/month statistics. | Streaks can be valuable feedback. | Keep the metric and easy access. Motivation alone does not justify repeating it across all jobs. |
| Way of Life `9405916639`; Productive `fa7ace69-ea88-42c9-924c-1a5ecb21aa77` ask to see progression of streak lengths. | Understand improvement over time. | Fits Progress alongside trends. A new streak-history chart is outside this task. |
| Days Since `8404418658`: “seeing the longest streak and average streak ruins the progress if I keep comparing myself to the past.” HelloHabit `13366668018` asks to hide streak count for specific habits on Home. | Some people want less comparison or optional streak visibility. | Preserve Show Streaks and neutral language. Moving a statistic does not replace that preference; no new per-habit setting is proposed here. |
| Habit Tracker `7573610950` says some totals/comparisons/log features make understanding harder; `6345193240` prefers charts and wants control over their position because reaching them requires scrolling past numbers. | Different people value different progress representations. | Keep the early summary compact. Do not consume the common header or stack large numerical tiles before every task. This is not evidence that all users dislike numbers. |
| Productive `8501717309` wants accumulated repetitions without manually tallying a year. DotHabit `f9c34729-82c4-4f1d-b6e5-7e73b8a26f97` wants cumulative and consecutive achievement both visible. Days Since `10193651577` wants reset patterns and comparisons. | Progress is broader than an unbroken chain. | Current/Best belong alongside cumulative work and relevant trends, rather than becoming the page's entire success story. |
| Habit Hub `7539356424` wants weekly streaks to follow the weekly goal; HabitKit `13578452293` questions a 12-week streak after eight weeks; EZ Habit `ef38a67d-2614-43ae-b7fe-8d9dcc4a58b4` finds its weekly counter confusing. Habitify `13572292515` reports incorrect limit/longest-streak statistics in Progress. | Accurate numbers and explicit counting scope. | Goal-period units and existing counting rules remain essential wherever the metric sits. Correctness complaints do not prove that a tab caused the problem. |

These originals establish **value, access, optionality and clarity**. They do not establish an empirical winner between this header and this tab. The specific placement recommendation below is reasoned from those requirements and the screen's jobs.

## 4. UX/UI reasoning for this page

### Shared identity versus task-specific information

Every tab needs to answer “Which habit is this, and what is its goal?” The icon, name and schedule provide that common context. History answers “What happened on a date, and how do I correct it?” Notes answers “What did I write?” Progress answers “How am I doing over time?” Current streak and Best streak primarily answer the third question.

Apple recommends segmented controls for closely related subviews and noun labels that describe each choice. This supports preserving the single Habit-details page with its three clear content jobs. It does **not** require every statistic to sit outside their content. [Apple: Segmented controls](https://developer.apple.com/design/human-interface-guidelines/segmented-controls).

NN/G explains that in-page tabs organize related views within the same page and should work consistently. Our application of that guidance is to retain stable identity and navigation while letting each selected panel contain its relevant information. The source is not a finding that streaks must always be tab-scoped. [NN/G: Tabs, Used Right](https://www.nngroup.com/articles/tabs-used-right/).

### Attention and vertical space

Two large statistics before the tabs give them priority even when someone is correcting a record or reading a note. The inspected daily study uses an 82 pt card row plus a 24 pt outside gap. Removing that row lets the tabs and their content begin **106 pt earlier** in this particular fixed-size study. This is a measured layout change, not a prediction of task speed or a universal SwiftUI spacing constant.

NN/G's minimalist-design guidance says to prioritize information useful to the current task because extra content competes for attention. Our inference is that History rows and Notes content should not routinely be preceded by a comparative-statistics block. Keeping the name/goal still gives those rows context. [NN/G: Aesthetic and Minimalist Design](https://www.nngroup.com/articles/aesthetic-minimalist-design/).

### Accessible disclosure, without burying important facts

The tradeoff is real: from History or Notes, reading the pair now requires selecting Progress once. That is acceptable as a provisional choice because Progress is a visible, named destination, and Today retains quick streak access. It would become worse if the pair required a second “Streaks” link, an expanded accordion or a long scroll beneath charts. Retain an open early summary.

Progressive disclosure requires both a sensible split and a clear route to the deferred information; it also warns against making frequently needed information unnecessarily hard to reach. We are **not classifying streaks as unimportant or rarely used**, since there is no usage evidence for that. We are grouping them under the relevant job and acknowledging the extra tap. [NN/G: Progressive Disclosure](https://www.nngroup.com/articles/progressive-disclosure/).

## 5. Alternatives considered

| Option | Benefit | Cost | Recommendation |
|---|---|---|---|
| Current + Best in the shared header | Visible from every tab without switching; supports users motivated by immediate comparison. | Permanent vertical/attention cost for History and Notes; duplicates facts already in Progress. | Remove from the shared area. |
| Current in the header, Best in Progress | Keeps live motivation nearby with less height. | Splits two related facts, still precedes unrelated tasks, and needs a new header arrangement. | Do not introduce this compromise without evidence that this page needs it. |
| Both visibly in early Progress | Clear home for longitudinal feedback; clean shared identity; reads naturally with totals/milestones. | One tab selection from History/Notes; finding it must be checked. | **Use this option.** |
| Both deep in Progress or under disclosure | Small initial Progress view. | Repeats the previous hidden-content problem and weakens the visibility reviews' need. | Avoid. |

## 6. Recommended treatment by habit type

| Habit | Where and how |
|---|---|
| Daily binary, checklist, amount or duration | Current streak / Best streak in the open early Progress summary. Use the actual consecutive goal unit and preserve cached calculations. Logging a quantity twice does not manufacture two streak days. |
| Weekly/monthly/yearly total or frequency goal | Same placement. Units follow the actual goal period: e.g. `4 weeks` with `3 times a week` context. Do not convert a long day streak into months, or pretend each recorded event is a goal period. |
| Every few days / selected-day habits | Same placement. Use the established eligible-goal counting and explicit unit/copy; placement does not change how unscheduled, skipped or paused dates count. Do not invent a new calculation to fill the space. |
| At-most limit | Same placement, factual language. An unfinished current period must not be presented as a confirmed kept limit solely because no consumption was logged. |
| Quit | Current run / Best run within Progress's open Overall record, where the live interval is already a meaningful headline. Do not repeat the pair above History or Notes. Retain existing Today live-counter access and the factual `Quitting since…` identity context; moving the pair does not remove that context. Keep comparisons optional under existing visibility preferences. |
| Task | No streaks or habit statistics. This question does not create a task Progress tab. |
| Show Streaks off | Omit streak/run comparisons using the existing setting; do not leave blank cards, hide unrelated totals or silently re-enable them on Progress. |

For a broken/new streak, use neutral copy consistent with the existing metric semantics, retain Best when one exists, and avoid a failure message. The pair remains a read-only summary; correction stays in the selected Day details and exact-record editor. Units, skip/pause, historical goals and quit timestamps remain the store's responsibility (Rulebook U3/U5/U19, S5/S8).

### Relation to the existing Progress layout

The [revised Progress study, 359:1538](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=359-1538), already exposes current/best within an open milestone summary after Overall record and before Week/Month/Year. Keep that structure; do not add another statistics panel or redesign Progress for this pass. Its older fixture wording and header styling are schematic; production labels use the type-specific streak/run language and shared identity contract above.

The current `HabitPageView.swift` explicitly keeps numbers out of its common header. `HabitProgressTab.swift` already reads Show Streaks, shows quit numbers in Overall record and visible milestone tracks near the top. This recommendation therefore avoids adding a duplicate header surface. It is not a claim that all proposed labels, preferences or native layouts have been device-validated.

## 7. Existing designs and documentation changed

Only the six existing shared-header studies were revised: daily History `433:2078`, weekly History `433:2119`, Notes list `433:2187`, empty Notes `443:2078`, no-search-results Notes `443:2108`, and quit History `443:2140`.

Removed each Current/Best card pair; moved the existing segmented tabs and subsequent tab content up by the removed 106 pt. Kept the centered identity, wrapping goal, 24 pt outside identity-to-tabs gap, tab-owned actions, native-size controls, monochrome chrome and all existing rows. The week example remains taller because its goal wraps. No new frames or mockups were created. The accepted Day-details sheet, entry editor, note reader/editor, recording forms, current-app screenshot references and existing Progress study were preserved.

The six own-design PNG exports and export provenance are refreshed in [Wireframes](Wireframes.md). The active handoff, package index, research index, Rulebook U20, Design Rules and Current Work Checklist item 48 identify this revision. Earlier research reports retain their dated history, with explicit precedence where relevant. These are representative layouts requiring native iOS implementation and real-iPhone validation (U1/U9/U17), not final visual assets to copy.

## 8. Confidence and what could change the recommendation

**Moderate confidence in the information architecture; no empirical confidence estimate for this exact placement.** Reviews show differing needs and come from other products. We have no session analytics, task timings, card-sort results or participant test comparing the alternatives. Nothing supports a claim that most users visit History or Notes more often than Progress.

During later native validation, ask people to find Current and Best from a History arrival, correct a past record, find a note, and interpret a weekly streak. Check whether the pair is easy to discover without instruction, whether it remains readable near the top at larger text sizes, and whether Best remains available after a break. If many relevant users repeatedly switch to Progress merely to monitor Current while doing another job, reconsider a compact optional current-only surface. That is a condition to investigate, not another mockup or setting added now.

**Conclusion:** retain easy streak access on Today; give the individual habit's Progress tab ownership of Current/Best; reserve the shared header for identity and applicable state. This best fits the existing three-job structure while preserving the value and optionality described in reviews.

## Appendix: every checked original

The accompanying evidence file preserves complete originals. Line references identify the current source files; prior Today aliases were resolved to real review IDs before citation. The source index below is generated from those verified records.

| Review ID | App | Date | Rating | Country / language metadata | Original source and current line |
|---|---|---|---|---|---|
| `7573610950` | Habit Tracker | 2021-07-14 | 5 | cn | [Source JSONL](<../../../App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl>), line 29272 |
| `6345193240` | Habit Tracker | 2020-08-21 | 5 | cn | [Source JSONL](<../../../App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl>), line 36412 |
| `8501717309` | Productive - Habit Tracker | 2022-03-27 | 1 | us | [Source JSONL](<../../../App Store Reviews/13. Productive - Habit Tracker - Daily Routine & Goals Planner/reviews.jsonl>), line 11859 |
| `1437821189` | Streaks | 2016-08-23 | 5 | gb | [Source JSONL](<../../../App Store Reviews/23. Streaks - The habit-forming to-do list/reviews.jsonl>), line 2329 |
| `10193651577` | Days Since: Quit Habit Tracker | 2023-07-29 | 5 | us | [Source JSONL](<../../../App Store Reviews/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter/reviews.jsonl>), line 8391 |
| `8404418658` | Days Since: Quit Habit Tracker | 2022-02-28 | 2 | us | [Source JSONL](<../../../App Store Reviews/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter/reviews.jsonl>), line 9622 |
| `13572292515` | Habitify: Habit Tracker | 2025-12-30 | 3 | ca | [Source JSONL](<../../../App Store Reviews/33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks/reviews.jsonl>), line 287 |
| `1760651629` | Way of Life - Habit Tracker | 2017-08-30 | 4 | ar | [Source JSONL](<../../../App Store Reviews/76. Way of Life - Habit Tracker - Build a better, stronger you/reviews.jsonl>), line 16 |
| `9405916639` | Way of Life - Habit Tracker | 2022-12-17 | 5 | us | [Source JSONL](<../../../App Store Reviews/76. Way of Life - Habit Tracker - Build a better, stronger you/reviews.jsonl>), line 5038 |
| `f9c34729-82c4-4f1d-b6e5-7e73b8a26f97` | Habit Streak Tracker: DotHabit | 2022-06-05 | 4 | ja | [Source JSONL](<../../../Play Store Reviews/124. Habit Streak Tracker - DotHabit/reviews.jsonl>), line 530 |
| `6ad5d1f7-2278-4299-b010-aa527f8432fc` | Habit Tracker | 2021-03-12 | 4 | en | [Source JSONL](<../../../Play Store Reviews/24. Habit Tracker/reviews.jsonl>), line 2550 |
| `fa7ace69-ea88-42c9-924c-1a5ecb21aa77` | Productive - Habit tracker | 2020-01-18 | 3 | en | [Source JSONL](<../../../Play Store Reviews/33. Productive - Habit tracker/reviews.jsonl>), line 2185 |
| `9560249714` | Do Habits: Get It Done | 2023-01-29 | 2 | us | [Source JSONL](<../../../App Store Reviews/31. Do Habits - Get It Done - Daily Routine & Goal Planner/reviews.jsonl>), line 3273 |
| `1768efc5-64a0-4cc8-919b-6f3918229ff6` | Loop Habit Tracker | 2022-06-05 | 5 | de | [Source JSONL](<../../../Play Store Reviews/3. Loop Habit Tracker/reviews.jsonl>), line 902 |
| `13366668018` | HelloHabit - Habit Tracker | 2025-11-07 | 4 | us | [Source JSONL](<../../../App Store Reviews/50. HelloHabit - Habit Tracker - Tasks, Routines, & Streaks/reviews.jsonl>), line 135 |
| `7539356424` | Habit Hub: Routine Tracker | 2021-07-04 | 4 | us | [Source JSONL](<../../../App Store Reviews/43. Habit Hub - Routine Tracker - Daily Todo, Goals & Schedule/reviews.jsonl>), line 335 |
| `13578452293` | Habit Tracker - HabitKit | 2025-12-31 | 4 | us | [Source JSONL](<../../../App Store Reviews/7. Habit Tracker - HabitKit - Streaks & Accountability/reviews.jsonl>), line 724 |
| `ef38a67d-2614-43ae-b7fe-8d9dcc4a58b4` | EZ Habit: simple habit tracker | 2022-08-26 | 4 | en | [Source JSONL](<../../../Play Store Reviews/69. EZ Habit - simple habit tracker/reviews.jsonl>), line 201 |
