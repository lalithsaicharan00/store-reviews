Written by Codex, 12 October 2026. Current Work 93; research and design proposal, implementation awaits approval.

# Section 04 — Easy to Keep Up With

**Historical proposal, rejected by the user.** [Round 02](<Section 04 Round 02 — Guided Routines.md>) replaces this mixed section with guided routines only. Evidence remains available; this is not the current design.

## The next question

**Will this be easy to use every day?** Visitors have seen the app’s purpose, their habit’s fit and visible progress. Now show how recording those actions fits into a real day: focused routines, Home Screen access and optional reminders. This is a reasoned page sequence, not a measured fourth-place ranking or conversion forecast (W2/W6).

## Evidence and limits

Fresh hand-read audit: **25 full original reviews across 12 app/store datasets**, 14 December 2015–13 August 2026. Purposive leads from the earlier Daily Cards verified source index, Claude’s [Logging a Count](<../Habit Creation/Logging a Count — One Tap or Type.md>) and [Time of Day and Reminders](<../Habit Creation/Time of Day and Reminders — What Users Want.md>) reports. Resolved every ID against current original JSONL; recorded current line, source, rating, body and manual interpretation. All selected records read, none unassigned/duplicated/missing. This is a fresh audit of these leads, not a new whole-corpus study. Older study totals remain attributed, not independently reverified. Android requests do not prove iOS availability; historical reviews do not establish current competitor behavior or pricing.

Users show that convenient daily use is a concrete product need:

- Direct widget logging praised or requested: `11393534582`, `11412519740`, `3254531371`. Unwanted app opening criticized: `8239700598`, `7553360995`, `14422180050`.
- Small counts should not repeatedly summon a keyboard: `0bace547-8e8f-47c3-a6ef-d06b6c43af70`, `edeab694-bd9b-4261-8ecc-c6d53664d62f`, `e03207c3-2b9e-4b40-9062-518a769e09c0`. Counterweight: `c4c14097-1651-4354-9c35-aa38a542d6e3` rejects both tedious typing and eighty +1 taps; `0bab690c-e1c8-481f-b267-90550bd4cbd7` objects to full-screen dismissal overhead.
- A focused routine should help someone identify the next action, not interrupt with lessons, effects or banners: `3254531371`, `7214908680`, `5427155863`. Optional reminder timing matters, but untimed habits should remain usable: `13197600650`, `e03207c3-2b9e-4b40-9062-518a769e09c0`.
- Clear names and trustworthy actions outweigh decoration: `8626356287`, `13902720788`, `12463084332`, `12133136766`. Personal ADHD accounts are not transferred into a clinical or guaranteed behavioral claim.

[JMIR’s longitudinal study](https://mhealth.jmir.org/2019/8/e12983/) followed 17 health/wellness app users over 14 days, using 34 interviews and 193 diaries. Low-effort entry, simple navigation and control over notifications informed willingness to continue use. Some participants found notifications distracting. Health-app use does not measure this landing page’s conversion.

[A 2026 student habit-app study](https://link.springer.com/article/10.1007/s41347-026-00707-2) used 12 think-aloud sessions and three four-person focus groups after five to six weeks. Participants valued clarity and some reminders but also described logging as extra effort, cognitive overload and phone interaction conflicting with reduced screen time. Small student/gamified-app sample; supports caution, not general prevalence or an outcome promise.

[NN/g product-page guidance](https://www.nngroup.com/articles/ecommerce-product-pages/) supports concise descriptive information and accurate visual proof. Applied as a website design principle, not app-specific experimental evidence.

## Why this goes here

| Candidate | Proposed treatment |
|---|---|
| Daily effort and access | Section 04: resolves whether flexibility/progress will cost too much everyday effort. |
| Tasks | Retain as a separate following section, as the user requested; broaden beyond only-once wording in its later design pass. |
| Privacy/backup | Keep its own next-stage trust section; no broad no-servers-anywhere claim. |
| Price/devices | Hero already signals free/one-time offer; dedicated lower sections retain availability and exact scope. |

## Copy and proof

Headline: **Easy to / keep up with.** Support: **Check off, count or time it. / Then get back to your day.**

Three short labeled explanations, meaningful licensed emojis and no fake controls:

- **Follow your routine.** One habit at a time, in a focused view.
- **Log from your Home Screen.** Check off habits or add a quick count.
- **Choose your reminders.** Pick your times. Or keep reminders off.

Authentic native **standalone Read timer** in the same intact sourced iPhone frame as the accepted hero: Read, Today, 12:07 / 20 min, Pause, Log manually. It illustrates timing/manual choice; it is not labeled as a routine-player screenshot. Existing iPhone 17 Pro simulator capture, source pixels unchanged. Reject the existing store routine/Today image: truncated section names and clipped display make it weak proof. Do not repeat uneven widget-gallery crops. Editorial text explains widgets instead of creating a replacement UI.

Current product verification: `iOS/Habits/Today/TodayRows.swift` uses checks, configured quick increments or amount entry; `iOS/Habits/AddHabit/NewHabitView.swift` defaults Remind Me off and allows chosen times. [Routine design/spec](<../../../iOS/Docs/Specs/Routine Player — Design Decisions.md>) and `RoutinePlayer.swift` establish one habit at a time. [Locked widget contract](<../../../iOS/Docs/Widgets — Taps and Updates (Locked).md>) establishes direct checks/quick counts, while checklists/quit/amounts without steps can open the app. No every-habit-one-tap, always-no-app-opening, automatic completion, instant sync, guaranteed focus or notification-efficacy claim. Code presence is not a live-store release claim; website availability remains prelaunch.

## Design and performance

White after gray progress. Desktop/tablet pair a concise left introduction/three feature rows with the native phone on a quiet neutral stage. Phone widths center their introduction, keep the device intact, then use three readable emoji-led explanations; no cramped multi-column feature tiles. Native artwork remains static. No WebGL, perpetual floating, blur animation or new font dependency (S19). Responsive source optimization and actual low-end-device tests follow implementation; Figma is not performance validation.

The accepted third section keeps all copy/native values, removes only the user-rejected date caption across copies, and adds a quiet shared card shadow. No app/widget behavior edits, test dispatch, commit, push or publication.

## Full source index

The following appendix links every selected original and its interpretation; scratch extraction/map retained under `Research/Temp/website-section4/`. No sample frequency percentages are presented as population facts.

| Review ID | Source / line | Interpretation |
|---|---|---|
| `11393534582` | `Research/App Store Reviews/7. Habit Tracker - HabitKit - Streaks & Accountability/reviews.jsonl`:834 | Values new interactive widgets; other app/version, not our release claim. |
| `11412519740` | `Research/App Store Reviews/34. Habit Tracker - Evoday - Daily Streaks Calendar & Goals/reviews.jsonl`:15 | Requests interactivity; absence not proof that we support every action. |
| `3254531371` | `Research/App Store Reviews/52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus/reviews.jsonl`:19873 | Specific routine steps, named habits and direct widget marking reduce uncertainty; personal ADHD testimony is not our health claim. |
| `8239700598` | `Research/App Store Reviews/52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus/reviews.jsonl`:20492 | App-opening on every check interrupts this reviewer; praise and criticism coexist. |
| `7553360995` | `Research/App Store Reviews/52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus/reviews.jsonl`:20508 | Prefers direct completion on the widget to entering the app. |
| `14422180050` | `Research/App Store Reviews/56. Dots - Habit Tracker Widget - Daily Routine, Goal & Planner/reviews.jsonl`:7 | Unwanted app opening undermines otherwise positive widget experience. |
| `8175263159` | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:2369 | Wants timer on watch and freedom to browse during timing; reserve device support for its own section. |
| `13291175777` | `Research/App Store Reviews/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker/reviews.jsonl`:18881 | Wants focus/timer mode; not evidence for Pomodoro support in Often Enough. |
| `6686258653` | `Research/App Store Reviews/23. Streaks - The habit-forming to-do list/reviews.jsonl`:2479 | Likes reminders and requests more focused timer/access; don’t promise always-on display. |
| `5427155863` | `Research/App Store Reviews/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help/reviews.jsonl`:21971 | Positive appearance but chaotic Home information harms clarity despite four stars. |
| `7214908680` | `Research/App Store Reviews/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help/reviews.jsonl`:36011 | Extra art/music/banners/lessons interrupt the routine; avoid theatrical marketing overload. |
| `4638761023` | `Research/App Store Reviews/53. HabitMinder • Habit Tracker - Daily Reminders & Routines/reviews.jsonl`:1516 | Clear remaining habits, short notifications and multi-device access matter; older version-specific requests. |
| `8626356287` | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:55120 | Emoji without a habit name is insufficient; use labels with emojis. |
| `13902720788` | `Research/App Store Reviews/36. (Not Boring) Habits - Science-backed habit tracker/reviews.jsonl`:191 | Unnamed widgets and spectacle-only value criticized; app comparison/pricing is not independently established. |
| `12133136766` | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:44451 | Incorrect/paused time is worse than visual polish; manual entry and access valued. |
| `13594271430` | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:44840 | Oversized/stale Live Activity blocks phone information; not all prominence is useful. |
| `0bace547-8e8f-47c3-a6ef-d06b6c43af70` | `Research/Play Store Reviews/3. Loop Habit Tracker/reviews.jsonl`:2774 | Wants quick +1 instead of mandatory text entry; free model belongs to other app. |
| `edeab694-bd9b-4261-8ecc-c6d53664d62f` | `Research/Play Store Reviews/3. Loop Habit Tracker/reviews.jsonl`:904 | Repeated keyboard entry interrupts small-count tracking; adjustable increment wanted. |
| `e03207c3-2b9e-4b40-9062-518a769e09c0` | `Research/Play Store Reviews/3. Loop Habit Tracker/reviews.jsonl`:1957 | Wants quick increments and multiple prompts for distributed daily amounts; no notification efficacy promise. |
| `c4c14097-1651-4354-9c35-aa38a542d6e3` | `Research/Play Store Reviews/3. Loop Habit Tracker/reviews.jsonl`:1672 | Typing every time and tapping eighty times both cost effort; never claim one tap for every goal. |
| `0bab690c-e1c8-481f-b267-90550bd4cbd7` | `Research/Play Store Reviews/3. Loop Habit Tracker/reviews.jsonl`:4698 | Extra full-screen app dismissal after numeric entry adds unnecessary work. |
| `13197600650` | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:51379 | Simple check sometimes preferred; widgets completing all repetitions and linked reminder days frustrate; don’t imply their complaints are all solved here. |
| `12463084332` | `Research/App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl`:51598 | Too many steps, accidental complete-all and watch failure undermine usefulness. |
| `1300549370` | `Research/App Store Reviews/13. Productive - Habit Tracker - Daily Routine & Goals Planner/reviews.jsonl`:18986 | Historical praise for arranging morning/afternoon/evening actions; not today’s Productive functionality/free allowance. |
| `1309645596` | `Research/App Store Reviews/13. Productive - Habit Tracker - Daily Routine & Goals Planner/reviews.jsonl`:18925 | Forgetting repeated routine actions matters; historical paid/free description not current competitor policy. |
