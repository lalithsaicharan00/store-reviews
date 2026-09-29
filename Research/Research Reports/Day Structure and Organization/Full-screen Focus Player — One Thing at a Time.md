Written by Codex, 29 September 2026.

# Full-screen focus player — one thing at a time

## Decision

Build a native, centered, full-screen player launched from a time-of-day section's Start. Show one habit and its actual controls, with a small routine-position indicator and next-item preview. No mandatory whole-routine countdown. Timed habits get one prominent count-up clock using the existing saved habit timer. Untimed habits stay untimed.

This is a design recommendation informed by reviews, not a usability-study result.

## Evidence and limits

Read the existing [Timing a Habit report](<../Habit Creation/Timing a Habit — Start, See and Stop.md>) and [Day Structure decision](<Habit Tracker — Day Sections, Categories and Routines Decision.md>). Their historical counts are not a new count for this study. A fresh keyword screen of routine/planner corpora produced 1,594 broad matches, including irrelevant and non-English matches. This is a retrieval pool, not 1,594 supporting reviews; a purposive sample was read for specific decisions. Eight traceable records are saved in [Focus Player Evidence.json](<Focus Player Evidence.json>).

| Review | Relevant evidence, paraphrased | Implication |
|---|---|---|
| Routinery `7510768204`, 5 stars | Wants an untimed, current-task/check-off option because timers can distract or stress people | Do not invent durations for checks, counts or checklists |
| Routinery `9485098944`, 5 stars | Values timed sequences, manual confirmation rather than mandatory auto-completion, overtime and quick skipping/reordering | One clear current item; keep control over advancing |
| Routinery `8368846355`, 4 stars | Values skip/extend/change order; asks for visible remaining time and complains of watch/phone disagreement | Easy queue navigation; all surfaces use the same saved progress |
| Routinery `9818758756`, 5 stars | Wants changing sequence during a run without restarting and timer visibility while locked | Queue with jump/revisit; retain existing Live Activity |
| RoutineFlow `e40b8619-eb5d-4c20-aca2-41bab7d63962`, 4 stars | Wants actual total routine time and historical records | Total duration has value for retrospective analysis; not proof that a second live countdown belongs on every screen |
| RoutineFlow `bc898c33-568a-4706-a7c3-b0485b711d5f`, 5 stars | Likes quiet operation, back/forward and non-punitive skipping; requests total time needed; criticizes contrast | Clear controls and system colors; do not infer timing for unknown steps |
| RoutineFlow `cd5e5cea-14fa-42ec-b290-392f0e745326`, 5 stars | Praises flexible/fixed routines, untimed tasks and smooth flow | Support mixed routines without making everything a timer |
| Tiimo `934a27bb-4b9e-4fad-92c2-effd245a53e4`, 3 stars | Wants start/pause/resume and a record of actual time | Preserve partial sessions; pause saves rather than discards |

## Current product references (accessed 29 September 2026)

- [Routinery's timer redesign](https://www.routinery.app/updatenote/3-29-19) exposes auto-next, timer options and minimization. [Its official App Store listing](https://apps.apple.com/us/app/routine-planner-habit-tracker/id1450486923) describes pause, skip and time adjustment. Useful inspiration: a player with accessible controls; it does not establish that our untimed habits need durations.
- [Tiimo's focus-timer guide](https://www.tiimoapp.com/faq/focus-timer) describes one-task focus, pause/play and task switching. We use one focused habit clock; switching within our player saves the previous timer instead of leaving overlapping player timers.
- [Structured's focus-timer guide](https://help.structured.app/en/articles/331010) describes a full-screen timer with subtasks, manual exit and Live Activities. Its documented focus mode does not automatically continue into the next task. Our explicit Next stays inside the same routine.

## Why no whole-routine countdown?

An estimate is useful when every step has a known duration. Our data represents goals, not duration estimates for tasks: drink 8 glasses, take medication, clean three checklist steps and stay under two coffees. Summing only meditation and reading would falsely describe the entire routine. A daily or weekly time goal is also not necessarily intended for one sitting.

Therefore the primary routine indicator is position, not a time budget. The queue may show remaining **timed goals**, explicitly separate from untimed items; it is not an ETA. Do not count routine elapsed time toward habit progress, and do not create a second timer. Actual whole-session duration/history is deferred until a real session-history model exists. That preserves the opportunity without shipping misleading statistics.

## Screen and interaction decisions

- Native `NavigationStack`, full-screen presentation, `ScrollView`, `ProgressView`, `Button`, `Menu`, `List` and system sheets. SF Symbols and the habit's existing color/icon provide recognition. System backgrounds and semantic text colors support both appearances.
- Top: Close, section name, More; small “Habit 2 of 5” indicator and a directly accessible routine list. Middle: generous space, centered icon/name, the meaningful quantity or clock. Bottom: reachable primary control, back/skip and next preview. Content scrolls at large text sizes; actions remain reachable.
- Check/task: one tap logs a check. Repeated checks add one each, never the full daily goal. After completion the primary action becomes Next. No automatic movement: completion feedback is visible and correction stays available before the user advances.
- Amount: one tap adds the configured increment; Add Amount opens the existing native sheet for any quantity. Reaching the target enables Next, and extra amounts remain available.
- Time: entering an unfinished timed item starts/resumes the existing timer. Pause saves elapsed time; resume continues the total. Add Time remains available. Going past the goal keeps counting until Pause/Next/Skip/Close. Backgrounding and locking do not pause it. No automatic completion or advancement.
- Checklist: native full-width rows, one tap per step, existing checks preserved. No forced order inside a checklist.
- Cut down: a check-in, never a completion target. Show what was logged and the limit, with optional logging. Continue records only that the user reviewed this item in this session; it never adds consumption or declares the whole day successful. Include limits even while under the limit (the old pending filter excluded them). Quit streaks remain outside timed sections.
- One tap: logging, pause/resume, each checklist step, next, skip, back. One/two taps: queue/jump to any item, manual logging, undo latest entry. Queue includes previously visited items; jumping does not complete intervening items.
- Skip preserves partial progress; summary distinguishes actual completion, reviewed limits and items left for later. Revisit unfinished items from summary. Close saves the current timer before dismissing; starting again uses saved progress. No separate fabricated routine completion entries.
- Date rollover: stop the session's timer against its original tracking day and ask the user to return to Today. Never silently log a yesterday action on a new day. Saved timers and entries survive process death; session position is not a persisted routine-history feature in this iteration.
- Preserve existing single-habit timer behavior, manual logging sheets, section-header layout, background timing and Live Activity integration. No white noise, voice engine, forced auto-next, separate Pomodoro, or fictional duration fields in this iteration.

## Validation

See the [implementation checklist](<../../../iOS/Docs/Checklists/Full-screen Routine Focus Player.md>) for build, device, behavioral and visual verification results.
