# Task Notes in Day Details — Evidence and Decision

Written by Codex (OpenAI), 4 October 2026. This is a focused follow-up to [the Day-details research](<The Habit Day Sheet — Wording, Hierarchy and Actions.md>) and the [task wireframes](<Day Details Wireframes.md>). It concerns the task sheet reached from Today; it does not claim a shipped app change.

## Question and decision

**Keep an optional note in the task sheet.** Completion is the primary action. The note is a secondary, labelled preview after the task's day status and Mark done/Undo done control, not another large button or a required step. An empty note says **Add a note…**; a saved note shows its text and remains tappable after completion. It opens the existing separate note editor. One-time tasks have no “Today's entries” group and no habit-page chevron. Their date and, while unfinished, Do Tomorrow stay accessible below the note. Task editing and deletion belong in the native task menu.

The three task states on the [Day-details Figma board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=370-2031) now show an unfinished task with no note (10), an unfinished task with a saved note (16), and a completed task (20). The old centered-header exploration was removed. These are **layout and interaction wireframes**, not final iOS controls or visual styling (U1/U9).

## Review evidence checked

I searched the repository's App Store and Play Store `reviews.jsonl` files for task-note requests and read the matching review text. These are examples from a targeted search, **not a representative count or a measured task-note adoption rate**. The earlier [Habit Notes and Day Notes](<../Habit Notes and Day Notes — What People Ask For.md>) study concerns habit-day notes and should not be presented as task-specific prevalence.

| Review | What it contributes |
|---|---|
| Finch App Store `12377966507` ([source](<../../../App Store Reviews/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker/reviews.jsonl>)) | Explicitly asks for **optional** task notes for multistep instructions and infrequent tasks, while saying most tasks do not need one. Strongest evidence for keeping notes available but visually secondary. |
| HabitNow Play Store `0b75f8d0-f352-4447-a010-cd69a3644b78` ([source](<../../../Play Store Reviews/2. HabitNow Daily Routine Planner/reviews.jsonl>)) | Praises notes on tasks as part of a simple workflow. |
| Habit Tracker – Habit Diary Play Store `538bf02c-c617-4903-9d86-adb616af45fa` ([source](<../../../Play Store Reviews/10. Habit Tracker - Habit Diary/reviews.jsonl>)); To Do List Play Store `6347f692-e294-42f4-9d09-3ab7d3d35f13` ([source](<../../../Play Store Reviews/100. To Do List - Daily Task Planner/reviews.jsonl>)) | Name the absence of task notes as a drawback. |
| Tasks Play Store `18ade6ee-4253-48a2-bbe5-588708ddd712` ([source](<../../../Play Store Reviews/84. Tasks - To Do List & Reminders/reviews.jsonl>)) | Praises notes for partially completed tasks and follow-up. Supports keeping the note reachable after marking done. |
| Routine Planner App Store `13373809432` ([source](<../../../App Store Reviews/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD/reviews.jsonl>)) | Complains that task notes are buried in menus. This is a reason to show a direct note surface in the task sheet, without elevating it to the primary completion action. |
| Awesome Habits App Store `12933186432` ([source](<../../../App Store Reviews/41. Awesome Habits - Habit Tracker - Streaks, days since & goals/reviews.jsonl>)) | Wants notes reusable across occurrences. Highlights a difference between enduring task instructions and a dated task note; this review alone does not settle the data model. |

## Current app behavior and data boundary

`DaySheet.swift` already offers Add/Edit Note for tasks and opens `NoteSheet`. `HabitStore.setNote(_:of:on:)` stores that note under **task ID plus selected day**. `DaySheet.moveTask(to:)` changes the one-time task's `dueDay`, but does not migrate a note. The app also has a separate task/habit description. Therefore the present note is accurately **Note for this day**, not a guaranteed task-wide instruction that follows the task when rescheduled. Removing Add Note would regress existing behavior (U5); changing its label to “Task note” without changing storage would promise the wrong persistence (D7).

For this design pass, preserve the current day-scoped note and its label. If future research or user testing shows that one-time task instructions must follow a rescheduled task, treat that as a separate product/data decision: define the source of truth, migration, backup/sync behavior, repeated-task semantics and tests before changing the label. Do not silently move or discard notes when changing a task date (D7/U5). The task's description remains the available place for standing instructions.

## Design reasoning and validation

This follows the shared Day-details scan order: task identity → selected-day state → direct completion correction → optional day note → date management. The note is close to the task outcome it explains but spaced away from the primary control. The layout matches daily-check behavior while omitting habit-only navigation, Skip and per-record logs. The note and completion remain usable in both undone and done states.

The review examples establish a real need for optional task context, but do not prove the exact location, label, or frequency of use. Validate the proposed composition on a small iPhone, with long task names, a multi-line saved note, Dynamic Type and VoiceOver before treating the wireframe as a final design (U1/U9).
