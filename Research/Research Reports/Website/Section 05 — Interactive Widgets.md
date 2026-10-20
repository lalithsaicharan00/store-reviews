Written by Codex, 12 October 2026. Current Work 93; design proposal for review, development awaits approval.

# Section 05 — Interactive Widgets

## The visitor question

**Can I check in without opening the app, and which widgets are included for free?** This follows the user's section order. It is a proposed visitor question supported by app-use reviews, not a measured fifth-place ranking or conversion uplift (W2/W6). Show the action, the sizes and the plan beside each family. Keep the explanation short.

## Evidence and its limits

Freshly hand-read and re-resolved **22 complete original reviews from 10 iOS app/store datasets**, 27 August 2017–4 September 2026. Leads came from the earlier Widgets verified-source index; each body, rating and date was read, and the original JSONL record was checked again by ID. This is a focused qualitative audit, not a fresh whole-corpus prevalence study. Every selected record is indexed below, including adjacent evidence and a non-substantive record; zero unknown IDs, duplicate IDs or unassigned interpretations. Earlier widget reports' totals remain attributed rather than independently reproduced.

Users show:

- **Interactivity is a benefit in its own right.** `11393534582` praises it; `11412519740` requests it; `14472221855` values checking habits from Home Screen without opening the app. `12832854491` objects to completing a whole count goal with one tap: show the saved increment, not an invented all-at-once action.
- **Lock Screen presence matters, even for a glance.** `11073757522` and `11519003640` praise it; `8209176286` requests it. `13876121897` describes personal counter motivation and a paywall objection. Do not turn personal recovery/ADHD testimony into a health or efficacy promise.
- **Explain the plan before download.** `11220373537` and `8797076855` object to withdrawn/free-to-paid widget access. Their pricing does not decide our pricing; the user's confirmed split does. Free/Plus labels sit beside the examples.
- **Names and list capacity are meaningful.** `8626356287` wants words over emoji-only recognition; `7824788952` requests a denser Medium widget. Keep names, units and size labels. Our actual Medium/large paging must not be replaced by an imaginary unlimited list.
- **Advertising a widget is not evidence it works.** `8102406517`, `9784351502` and `6956866789` describe unavailable/blank/promised widgets; `3342943112` describes stale Watch/widget state. No promise of instantaneous updates, universal in-widget entry, Android launch readiness or production performance follows from this design.

Primary references checked 12 October: [Apple's interactivity documentation](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities) and [widget HIG](https://developer.apple.com/design/human-interface-guidelines/widgets). Apple documentation required JavaScript and its Markdown URL was unavailable to the web reader; our concrete action claims are therefore verified against the repository's current WidgetKit code and locked action contract, rather than inferred from the title. [HabitKit's official widget guide](https://habitkit.app/help/widgets/add-a-habitkit-widget-to-your-home-screen), updated September 2026 for 1.18, separates sizes, platform support, paid access and tap behavior. Its provider-authored structure is inspiration; its artwork, pricing and behavior are not copied. Reviews above explain why our own distinctions matter.

## Current product truth and pricing

Verified `iOS/Shared/PhoneWidgets.swift`, `iOS/Habits/Model/HabitStore+Widgets.swift`, current widget configurations and [the locked contract](<../../../iOS/Docs/Widgets — Taps and Updates (Locked).md>) (U28). Home Screen ✓ and saved-count actions run in place; duration controls start/pause in place. Typed values, checklists and quit-slip entries use the correct app sheet. A Circular Lock Screen widget supports direct check/saved-count actions; rectangular and inline widgets are glance summaries/links, not extra logging controls. No claim that every widget action avoids opening the app.

| Family shown | Scope | Website plan |
|---|---|---|
| One item | Small habit and Small task | Free |
| Tasks | Medium and Large | Free |
| Today habits | Medium and Large; Today or a selected section | Plus |
| This week | Medium, one habit | Plus |
| Lock Screen | Circular one habit, Rectangular Today, Inline Today and Inline one habit | Free |

The user confirmed Lock Screen **Free** in this chat. The [12 October main policy update](https://github.com/lalithsaicharan00/store-reviews/commit/ac462364b33bc90ebaaa7a222893d153cdae87ac) agrees: Small/Tasks/Lock Screen Free; Today/This week Plus. **The local native code still has no widget paywalls; implementation/release reconciliation is pending.** This proposal expresses the intended website plan, not a claim that those gates have already shipped. Android equivalent widgets are planned; these are iPhone designs, not Android screenshots or release evidence. No monthly or large-week widget, removed Today circle or twelve-row Medium is invented.

## Copy and composition

Headline: **Interactive widgets.** Supporting copy: **Check off habits and tasks, add a count, or start a timer. All from your Home Screen.** A licensed Home emoji supplies meaningful color without replacing words.

Four Home Screen family panels: **One habit or task**, **Your tasks, together**, **Your habits, together**, **Your week at a glance**. Explicit Small/Medium/Large labels and Free/Plus badges. Lock Screen band: **Lock Screen widgets.** Free badge; **Tap the circle to check off or add a count. Keep summaries in view.** All Circular/Rectangular/Inline designs shown. Footer: **Other entries open the app. Widgets shown on iPhone.** No additional CTA, availability chip or long method inventory.

Reasoned from first principles: three desktop columns; tablet two-column rows; phones stack complete panels. All widget families remain visible without hidden tabs or a graphics engine. Native UI sits within its own rounded, softly elevated background; no tilted picker crops, uneven surrounding wallpaper or debug fixture names. Neutral gray section after the white routine, plus a dark neutral Lock Screen presentation surface. That surface is deliberately not presented as an installed phone wallpaper. Task capability retains its separate following section (U5).

## Visual provenance and Morning correction

Reuse the existing approved **editable widget component designs** from Figma's Widgets page, with their native shells, names, units and action glyphs. They are not represented as new installed Home Screen screenshots. Small task is a faithful editable example: Return books / For today / check action / zero progress, verified against `SmallWidget` and `fillTask`. The surrounding website and family labels are editable, with shared website typography/color/spacing tokens. Exact source IDs and final validation are in the section manifest.

Inspected prior actual Home Screen/gallery/harness artifacts. The installed Home Screen sample contained debug fixture names; the picker previews were tilted with uneven surrounding background; the supposed Lock picker image showed no installed widget. These are not suitable for this marketing catalogue. Existing run 38136626357 artifacts contained unrelated App Lock/reminder captures, not the Morning routine needed. No new CI was dispatched and no native code changed. Read-only old artifact downloads do not constitute new tests.

Routine Section 04 now displays **Morning · 1/4 / Stretch / Today / 0:08 of 10 min / Pause / Day details / previous-next**, preserving its accepted copy, geometry and original hardware bezel. The user previously authorized building faithful UI when a screenshot is unavailable. This entire screen is rebuilt as editable UI from current `RoutinePlayer.swift`, `HabitStore.seedDemo` and Apple's iOS 26 status bar/Liquid Glass components, **not a retouched Anytime PNG or an actual Morning capture**. Previous is disabled at the first step. Native opacity/ring semantics and source fonts are inspected. Replace this reconstruction with a clean native Morning capture for publication; see [Morning provenance](<../../../website/Design Assets/Native/Morning Routine — Design Provenance.json>) (U9).

## Feasibility and validation

Static composition, no WebGL, live canvas, continuous ticking artwork, autoplay or animation dependency (S19). Implementation can use normal responsive grid/stack CSS, lazy-loaded content images with dimensions, and short semantic copy. Export each widget independently at the size needed, compress modern formats with fallback, and avoid shipping review-board PNGs or SF Pro font files. Meaningful text and download actions must remain HTML. Actual low-end-device decode/scroll/interaction and reduced-motion/Save-Data tests happen after design approval; Figma proves only layout.

Final checks/previews and source inventory are recorded in [the handoff](<../../../website/Design Handoff.md>) and [Section 05 manifest](<../../../website/Design Previews/Section 05 Round 01/manifest.json>). Native app behavior/paywalls, CI and hosting remain unchanged.

## Complete original-record index

| Review ID | Rating / date | Original source / current line | Hand-read interpretation |
|---|---|---|---|
| `11393534582` | 5 / 2024-06-18 | `Research/App Store Reviews/7. Habit Tracker - HabitKit - Streaks & Accountability/reviews.jsonl`:834 | Direct praise for newly interactive widgets; supports leading with interactivity, not a claim about every widget action. |
| `12832854491` | 3 / 2025-06-29 | `Research/App Store Reviews/33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks/reviews.jsonl`:165 | Objects to one tap completing an entire count goal; preserve step-by-step counts and distinguish tap actions. |
| `11412519740` | 5 / 2024-06-23 | `Research/App Store Reviews/34. Habit Tracker - Evoday - Daily Streaks Calendar & Goals/reviews.jsonl`:15 | Requests interactive widgets; a request is not evidence that the competitor currently supports them. |
| `14510762767` | 5 / 2026-09-04 | `Research/App Store Reviews/36. (Not Boring) Habits - Science-backed habit tracker/reviews.jsonl`:54 | Adjacent overview/list and quit-tracking request; not specific evidence about widgets. |
| `11073757522` | 5 / 2024-03-22 | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:47725 | Lock Screen visibility is described as helpful. |
| `8209176286` | 3 / 2022-01-06 | `Research/App Store Reviews/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter/reviews.jsonl`:1219 | Historical request for a Lock Screen widget; does not establish current availability. |
| `13876121897` | 2 / 2026-03-22 | `Research/App Store Reviews/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter/reviews.jsonl`:2111 | Lock Screen counter is personally motivating; objects to removing a formerly free feature. Personal recovery testimony is not an efficacy claim. |
| `11519003640` | 5 / 2024-07-21 | `Research/App Store Reviews/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter/reviews.jsonl`:2440 | Direct praise for the Lock Screen option. |
| `8626356287` | 3 / 2022-05-01 | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:55120 | Wants words instead of emoji-only identification. Keep habit/task names visible; emoji is supporting decoration. |
| `10074496489` | 5 / 2023-06-26 | `Research/App Store Reviews/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter/reviews.jsonl`:2624 | Multiple counters on one page valued; adjacent density evidence, not an explicit widget request. |
| `1754444168` | 4 / 2017-08-27 | `Research/App Store Reviews/23. Streaks - The habit-forming to-do list/reviews.jsonl`:2428 | Requests more tasks and a list; adjacent historical list-density evidence, not specific widget behavior. |
| `7824788952` | 5 / 2021-09-20 | `Research/App Store Reviews/23. Streaks - The habit-forming to-do list/reviews.jsonl`:4769 | Requests the earlier Medium widget with more tasks. Show list sizes and paging accurately, not twelve simultaneous rows. |
| `11220373537` | 1 / 2024-05-01 | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:379 | Objects to a formerly free widget becoming paid; clear Free/Plus expectations matter. |
| `8797076855` | 1 / 2022-06-21 | `Research/App Store Reviews/36. (Not Boring) Habits - Science-backed habit tracker/reviews.jsonl`:274 | Basic widget paywall/locked appearance led to deletion. Supports clear upfront scope; no competitor pricing is transferred. |
| `14472221855` | 5 / 2026-08-26 | `Research/App Store Reviews/56. Dots - Habit Tracker Widget - Daily Routine, Goal & Planner/reviews.jsonl`:19 | Praises minimalism and crossing habits off from Home Screen without opening the app. Personal ADHD testimony is not a treatment claim. |
| `8102406517` | 2 / 2021-12-06 | `Research/App Store Reviews/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter/reviews.jsonl`:9925 | Advertised widget could not be installed; availability must match the release. |
| `9784351502` | 4 / 2023-04-04 | `Research/App Store Reviews/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker/reviews.jsonl`:1905 | Widget renders blank after installation; visual designs are not reliability proof. |
| `6956866789` | 2 / 2021-02-05 | `Research/App Store Reviews/20. Habit — Daily Tracker - Crush your goals like a boss/reviews.jsonl`:3355 | Paid specifically for a promised widget that was unavailable; verify actual shipped families before publication. |
| `3342943112` | 3 / 2018-10-25 | `Research/App Store Reviews/23. Streaks - The habit-forming to-do list/reviews.jsonl`:3670 | Watch/widget sync required opening the app; never promise instantaneous sync or arbitrary widget update timing. |
| `11751917371` | 5 / 2024-09-22 | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:793 | Body only says Caption. No substantive widget finding; retained in the index and excluded from design evidence. |
| `9490930528` | 5 / 2023-01-10 | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:54552 | General color/aesthetic/chores motivation praise; does not specifically establish a widget preference. |
| `8748814318` | 5 / 2022-06-07 | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:55033 | General readable scrolling interface, Health, timers and stats praise; adjacent clarity evidence, not specific widget preference. |
