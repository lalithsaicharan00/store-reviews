Written by Codex, 12 October 2026. Current Work 93; revised design proposal, implementation awaits approval.

# Section 04 — Guided Routines

**Historical Round 02:** the same Figma IDs now show the Morning correction in [Section 05 research and Morning handoff](<Section 05 — Interactive Widgets.md>). The Anytime PNGs below remain historical, unchanged capture references.

## User correction and visitor question

The earlier combined daily-use section was rejected: it repeated the tracking methods already demonstrated in Section 02 and diluted routines with widgets/reminders. **Section 04 now answers one question: How does the app guide me through my routine?** Lead with the sequence and the current habit, including timing and control. This content order follows the user's direction, supported by routine-use evidence; it is not a measured fourth-place visitor ranking (W1/W2/W6).

## Focused research

Re-read **12 complete original records across 6 app/store datasets**, 14 December 2015–26 June 2026. Eight leads from [the earlier Focus Player audit](<../Day Structure and Organization/Focus Player Evidence.json>), plus four adjacent routine/clarity originals from the earlier website audit, resolved again by ID against current JSONL. Every selected body/rating/date read, with complete interpretation and current source-line index. This is a focused qualitative audit, not a new corpus-wide frequency study. Older report retrieval totals and counts remain attributed; original Android requests do not prove current iOS behavior.

Users show:

- **A sequence of concrete habits helps identify the current action.** `9485098944` describes routine playlists with per-step timing and manual confirmation. `3254531371` values seeing specific routine steps instead of one vague Get ready task. Personal ADHD/ASD testimony is not a health or efficacy claim for Often Enough.
- **Control is part of guidance.** `8368846355` values skipping/extending/changing order; `9818758756` asks for changing sequence without restarting; `bc898c33-568a-4706-a7c3-b0485b711d5f` praises quiet, flexible back/forward movement. Show pause/navigation accurately, without promising automatic completion or forced progression.
- **Timers suit timed habits, not every habit.** `7510768204` asks for untimed steps because compulsory timing can be stressful; `cd5e5cea-14fa-42ec-b290-392f0e745326` values mixed untimed/flexible routines. `934a27bb-4b9e-4fad-92c2-effd245a53e4` wants pause/resume and true recorded time. Do not invent a total routine countdown or duration for an untimed action.
- **Clutter can interrupt the routine.** `7214908680` objects to music/art/banners/lessons demanding attention; `5427155863` criticizes chaotic Home information. This supports one purposeful proof image and short copy, not another collection of feature blocks.
- **Scope remains honest.** `e40b8619-eb5d-4c20-aca2-41bab7d63962` asks for whole-routine time/history, which we do not claim. `1300549370` praises arrangement across parts of day, but its 2015 free-plan/behavior description is historical.

Fresh primary references: [Routinery features](https://www.routinery.app/features) describes step-by-step routine timing; [Tiimo's focus-timer guide](https://www.tiimoapp.com/faq/focus-timer) describes one-task focus, pause and switching. These are provider descriptions checked 12 Oct, not proof that copying their interfaces works. Their automatic scheduling, overlapping timers, voice and other behavior are not transferred into our claims. The app reviews determine what to communicate; our current code determines what we can promise.

## Product truth and proposed copy

Verified `iOS/Habits/Today/RoutinePlayer.swift`, current [Design Rules](<../../../iOS/Design Rules — Don't Regress.md>) and [routine spec](<../../../iOS/Docs/Specs/Routine Player — Design Decisions.md>): section Start opens a full-screen player showing one habit; toolbar shows routine name and position; timed habits use their saved count-up timer; Pause/Resume and previous/next/queue movement are available. Moving does not mark habits complete. Untimed habits remain untimed; limits and quit habits stay outside routines. The bottom bar is Day details, superseding older Habit options screenshots/spec paragraphs. No routine-history/session-cursor promise.

Headline: **Your routine. / One step at a time.** Support: **Follow your habits in a guided routine. / Use timers, pause, and move on at your own pace.**

One clean routine visual; no Check off/count/time inventory, widget/reminder feature rows, additional CTA or broad productivity guarantee. Use actual native routine imagery wherever available; a standalone timer screenshot does not demonstrate a routine. Keep the accepted intact iPhone frame. Any editorial labels must describe the real capture rather than invent matching values or UI.

White background follows the accepted gray progress section. Desktop pairs concise copy with product proof; tablet/phones reflow without crowded feature grids. Meaningful emoji may identify the routine, never substitute for its name. All information/static artwork usable without motion or WebGL (S19). Figma validation and future real-device website performance testing remain separate.

Widgets/reminders remain part of the planned later site coverage, recorded in the website brief and dedicated research. Tasks retain their separate following section. Accepted first three sections are preserved, including the user's caption removal and quiet card-shadow refinement.

## Original source index and interpretation

All selected records and current source lines are listed below; extraction and manual map remain in `Research/Temp/website-section4/`.

| Review ID | Rating / date | Source / current line | Interpretation |
|---|---|---|---|
| `7510768204` | 5 / 2021-06-27 | `Research/App Store Reviews/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD/reviews.jsonl`:113 | Untimed current-action option requested; compulsory timers can stress some people. No pricing transfer. |
| `9485098944` | 5 / 2023-01-08 | `Research/App Store Reviews/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD/reviews.jsonl`:3011 | Routine playlists with per-step time/manual confirmation praised; no clinical, voice or auto-next claim. |
| `8368846355` | 4 / 2022-02-18 | `Research/App Store Reviews/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD/reviews.jsonl`:755 | Flexible movement/order valued; watch disagreement shows accuracy matters. |
| `9818758756` | 5 / 2023-04-13 | `Research/App Store Reviews/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD/reviews.jsonl`:90 | Wants reordering without restart and locked-phone visibility; not proof of current competitor feature availability. |
| `e40b8619-eb5d-4c20-aca2-41bab7d63962` | 4 / 2023-11-18 | `Research/Play Store Reviews/49. RoutineFlow - Routine for ADHD/reviews.jsonl`:1978 | Wants total routine time/history; not offered by our section or current session model. |
| `bc898c33-568a-4706-a7c3-b0485b711d5f` | 5 / 2023-11-09 | `Research/Play Store Reviews/49. RoutineFlow - Routine for ADHD/reviews.jsonl`:2040 | Quiet, back/forward, unpunished movement praised; readability remains essential. |
| `cd5e5cea-14fa-42ec-b290-392f0e745326` | 5 / 2023-11-02 | `Research/Play Store Reviews/49. RoutineFlow - Routine for ADHD/reviews.jsonl`:2074 | Mixed untimed/flexible routines appreciated; no subscription policy transfer. |
| `934a27bb-4b9e-4fad-92c2-effd245a53e4` | 3 / 2026-06-26 | `Research/Play Store Reviews/117. Tiimo - Daily To Do List/reviews.jsonl`:87 | Wants pause/resume and meaningful recorded time; no lost-time or treatment guarantee. |
| `3254531371` | 5 / 2018-10-02 | `Research/App Store Reviews/52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus/reviews.jsonl`:19873 | Concrete routine steps reduce uncertainty; avoid turning personal ADHD experience into a product efficacy claim. |
| `5427155863` | 4 / 2020-01-20 | `Research/App Store Reviews/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help/reviews.jsonl`:21971 | Chaotic home information disliked despite favorable visual rating. |
| `7214908680` | 3 / 2021-04-12 | `Research/App Store Reviews/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help/reviews.jsonl`:36011 | Art/music/banners/lessons can disrupt a routine; a focused proof and brief copy are sufficient. |
| `1300549370` | 5 / 2015-12-14 | `Research/App Store Reviews/13. Productive - Habit Tracker - Daily Routine & Goals Planner/reviews.jsonl`:18986 | Historical arrangement across parts of day appreciated; 2015 allowance/current version not inferred. |

## Delivered proof and verification

The final native proof is the unchanged 7 Oct iPhone 17 Pro simulator capture from existing [run 37624444958](https://github.com/lalithsaicharan00/store-reviews/actions/runs/37624444958), `FocusPlayerUITests/testCompactProgressAcrossPeriodsAndTypes()`: Anytime · 4/9, Read a little, Today, 0:08 / 20 min, Pause and Day details/previous/next. The selected attachment is not failure-associated; that run also contains an unrelated failing pause test and is not claimed as a passing suite. No new run dispatched. Native SHA-1 `4bb14b69f7984185e96b4e1e99d30a25eb3605cd`; [provenance](<../../../website/Design Assets/Native/Routine — Provenance.json>).

All twelve routine copies use shared SF Pro website styles with no website-text overflow. Four complete responsive compositions inspected. Earlier three sections’ text/dimensions/internal text geometry match the preserved baseline; all eight separate task copies retain text/dimensions. Section 03 date captions remain absent and the native card has a consistent 0 8px 24px, 6.5% black shadow on its background wrapper, with unclipped output. Current [handoff](<../../../website/Design Handoff.md>) and [manifest](<../../../website/Design Previews/Section 04 Round 02/manifest.json>). Native content image is intentionally authorized marketing proof; website text remains editable. This is Figma verification, not low-end-phone/runtime validation.
