# Task Limit — codebook

Every candidate from `scan.py` is read in full and coded. A review with no code line in its batch file is **OFF**
(read, not about tasks and a free/paid/limit question). Several codes per review are allowed.

## What "task" means in the review
- `TW_HABIT` — the reviewer says "task(s)" / "to-do" / "reminder" for what the app treats as a habit (vocabulary overlap).

## Caps
- `HCAP` — a cap on habits (said in any words). Reaction codes below apply.
- `TCAP` — a cap on real tasks / to-dos (one-off or recurring items that are not habits in that app).
- `SHARED` — one cap counts habits and tasks together.
- `N<k>` — the number named for the cap (e.g. `N5`).

## Paywalls on tasks
- `TODO_PAID` — the to-do / task feature itself is paid (whole list or tab locked).
- `RECUR_PAID` — repeating / recurring tasks are paid while one-off tasks are free.
- `TASKFEAT_PAID` — a task feature (subtasks, reminders on tasks, lists, dates) is paid.

## Reaction
- `NEG` complaint · `OK` accepts it / enough · `PAID` says they paid (or will) because of it · `LEFT` left / uninstalled / refuses.
- `WANT_MORE` asks for a higher cap · `BAIT` it used to be free and was taken away.

## Tasks free, demand and use
- `TASK_FREE_PRAISE` — praises free or unlimited tasks / to-dos.
- `ALLINONE` — praises or wants habits and tasks in one app.
- `TODO_DEMAND` — asks for to-dos / one-off tasks in a habit app.
- `HABIT_FOR_TODO` — uses habit slots for chores / to-dos / one-off reminders.
- `WORKAROUND` — uses tasks (or another trick) to get around a habit cap.
- `TASK_NO_STATS` — wants streaks / stats / history on (recurring) tasks.
- `FREE_ELSEWHERE` — says Reminders / Google Tasks / Notes / paper do tasks for free.
- `NO_PAY_FOR_LIST` — won't pay for (or regrets paying for) what they see as a plain list / reminders / to-do app.
- `PAIDAPP` — the cap is inside a paid-upfront app (e.g. Streaks' 6 → 12 → 24), a design choice rather than a free-tier limit; kept out of free-limit tallies.
- `RECUR_AS_HABIT` — uses repeating tasks / reminders (in a to-do app or a habit app's task type) as their habit tracker.
- `RECUR_FREE_PRAISE` — praises that repeating tasks are free (often "other apps charge for this").
