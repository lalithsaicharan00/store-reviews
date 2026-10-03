# Tasks next to habits: where they sit, and can they be dragged

Written by Claude (Claude Code), 3 October 2026. Scratch evidence for "Arrange Your Day" (follows report 27).

## The answer

**(a) Where tasks sit.** A task sits in its time of day, in **the same list as the habits, in the person's own
order**. There is **no fixed "habits first" or "tasks first" rule.** A new task goes **at the end of its time of day**,
the same as a new habit (report 27), so adding a task never pushes a habit down. Completed tasks follow the habits'
rule: nothing moves during a run of taps (U4).

**(b) Dragging tasks in Edit.** **Yes.** In Edit, tasks have the same ≡ handle as habits and can be dragged anywhere
in their time of day, above, below or between habits. Edit has one order per time of day, not a habit order with a
task order attached to it. The one-off "Sort by time" action from report 27 also sorts tasks that have a time.

Why:

- Users show they want **one list for the day** (15 reviews), not a separate tab for tasks (4). Not one reviewer asked
  for habits above tasks or tasks above habits as a fixed rule. The 6 reviewers who said how a mixed list should be
  ordered wanted **their own order**. The one person who wanted habits and reminders kept in groups wanted to place
  those groups themselves.
- Users show that **one-time tasks are expected to be dragged**. Of the 61 hand-read reviews that say how tasks should
  be ordered, 34 want, or praise, a manual order or dragging. 21 want an automatic sort (due date, A to Z, time).
  To-do-app users give 1★ when they cannot drag.
- Within habit apps that have tasks, **time order comes up for timed tasks** (5 of the 22 relevant reviews). The
  one-off sort covers them, and so does putting a timed task in the right time of day.
- The clutter complaints (10) are almost all about **recurring habits cluttering a to-do list** (7), and come from
  people praising a habit-only app. Only 2 complain that one-time tasks cluttered the habit view, and 1 that one long
  list was overwhelming. None say tasks pushed habits down. Adding tasks at the end of their time of day keeps it that
  way (reasoned from first principles).

## How it was done

- **Corpus:** every App Store, Play Store and native corpus, through `../screen.py`. Cites use the format of
  report 27 (`A`/`P`/`N` + folder + `#` + 0-based line).
- **Screen** (`tasks/tasks_screen.py`): the review mentions habits **and** tasks or to-dos as two kinds, plus a
  placement or order word. It matched **2,218** reviews: 2,184 from habit apps and 32 from to-do apps. A stricter cut
  (`strata.py`) left 914 habit-app reviews. A whole-corpus pattern for explicit placement ("habits above tasks",
  "mixed with", "separate habits and…", "same page") matched 382 (`explicit_full.py`).
- **Hand-read: 254 reviews**, each read in full, coded in `tasks/v2_codes.tsv`. A keyword hit never counts as a
  finding on its own.
  - **MIX (100):** a seeded sample (seed 20261003) of the 914: 80 order-word hits and 20 separate or mix-word hits.
  - **EXP (64):** every explicit-placement hit inside the screen (31), plus the placement, mix, separate and "both on
    one page" subsets of the whole-corpus scan (`tasks/ex_A/B/C/D_both`).
  - **Q2 (60):** a seeded sample of 3,762 order requests from to-do apps (Reminders, Microsoft To Do, Google Tasks, Play
    to-do apps).
  - **Q2H (30):** a seeded sample of 363 order requests that mention tasks, from habit apps that have to-dos (HabitNow,
    Habitica, Tappsk, Hizo and others).
- **Relevant:** 52 of the 164 MIX and EXP reviews, and 61 of the 90 Q2 and Q2H reviews. The rest were about habits only,
  or were off-topic.
- Quotes are checked by `verify.py`: every cite resolves, and every quote is found verbatim.

## 1. A mixed daily list: what order do people expect?

From the 52 relevant MIX and EXP reviews. A review can carry several codes.

| What the review says | Reviews |
|---|---|
| Likes, or wants, habits and tasks **in one list or on one screen** | 15 |
| Values the app **telling the two kinds apart** (on the same screen or in tabs) | 10 |
| Wants tasks in a **separate tab or section** | 4 |
| Wants the mixed list in **their own order** | 5 (plus 1 in the Q2H set, `P2#280`) |
| Wants the mixed list **by time of day** | 2 |
| Wants **sort options** for the mixed list | 2 |
| Wants a **fixed** habits-first or tasks-first order | **0** |

- "a great way to combine daily habits with one time tasks all in one list!" `A13#13002` (Productive, 4★)
- "I really wish there would be a way to have the habits list and the to-do list all together in one list, or at least on the same page." `P61#276` (Hizo, 5★)
- "it was really helpful to see everything on one page including “habits” and “to-dos.” More importantly was being able to adjust the order of items because it helped me be able to plan my day out in chronological order." `A18#2010` (MyRoutine, 1★ after an update removed it)
- "I want to sort tasks and habit manually." `P2#11778` (HabitNow, 4★)
- "The ability to program your day windows and reorder items in time windows is fantastic" `A43#133` (Habit Hub, 5★: habits and to-dos in "one blended display")
- "I would like to be able to pin the reminders at the top, have the daily habits after that, then the scheduled dailies." `P2#11124` (HabitNow, 4★)

The last reviewer groups items by kind, but in an order **they** choose, and asks for "manually order the tasks". It
is the only review close to "kind first". "Separate" usually means *told apart*, not *on another screen*. For example,
"I can separate my one-time tasks and recurring tasks and habits" `P2#4160` comes from HabitNow, which lists both in its
day view.

## 2. Ordering one-time tasks: by hand or automatically?

From the 61 relevant Q2 and Q2H reviews.

| | To-do apps (39 relevant of 60) | Habit apps with tasks (22 of 30) | All (61) |
|---|---|---|---|
| Wants, or praises, **manual order or drag** | 22 | 12 | **34 (56%)** |
| Wants an **automatic sort** (due date, A to Z, tags, priority) | 11 | 5 | 16 |
| Wants **timed tasks in time order** | 0 | 5 | 5 |
| Unhappy that **new tasks land on top**, or about where they land | 1 | 1 | 2 |

One review is in both the manual and time rows (`P2#18132`, which asks for tasks by time, or else to set the order by hand). Several
automatic asks are for a *view* (due-date order, "Tomorrow"), not for taking away the person's own order.

- "I just wish you could manually drag and reorder your tasks... I don't need specific times, nor do I want to bother with that level of granularity in setting my tasks, but I do want them in some kind of order." `P126#28295` (To Do List, 4★)
- "Now everything in in order of when I typed it in or in alphabetical- which is worthless." `N10#21193` (Microsoft To Do, 1★, "Cannot manually move tasks")
- "OFC people need to prioritize their tasks manually!" `P126#20553` (To Do List, 4★)
- "Orders the list alphabetically instead of leaving it in the order I set." `P126#193414` (To Do List, 1★)
- "I would like it even more if I could re-order the tasks in my list rather than have them show up in the order I first inputted them." `P2#13182` (HabitNow, 5★)
- "логично сделать автоматическую сортировку от раннего к позднему" `A59#8837` (Tappsk, 3★)
  - *With several timed tasks in one day, sorting them earliest to latest is the logical thing.*
- "cuando agrego algo de la misma categoria eso nuevo se agrega arriba de lo que va primero y eso me molesta" `P2#18847` (HabitNow, 2★)
  - *When I add something in the same category, the new item goes above the first one, and that bothers me.* They
    want to order tasks "one by one" themselves.

## 3. Complaints: mixed, cluttered, pushed down

| Complaint | Reviews |
|---|---|
| Recurring habits or routines **clutter a to-do list** (the reason given for keeping a separate habit app) | 7 |
| One-time items **clutter the habit view** | 2 |
| One long list of both is **overwhelming** | 1 |
| Tasks **push habits down**, or the reverse | **0** |
| Can't tell repeating tasks from habits | 1 |

- "Personal goals and habits can clutter up a to-do list" `A13#16379` (Productive, 5★)
- "I felt overwhelmed looking at my task manager with the mixture of habit tasks and work tasks." `A13#17181` (Productive, 5★)
- "estaría bien que no aparecieran junto con todos los hábitos, o que pusieran otra sección para las actividades únicas" `P10#19664` (Habit Diary, 4★)
  - *It would be good if one-time activities didn't appear with all the habits, or had their own section.* This is
    about the **all-habits** list, where finished one-time items stay until archived. It is not about the day view.
- "I find one long list somewhat overwhelming for my many habits and tasks." `P8#1988` (Habitica, 5★)

What this means (reasoned from first principles): the clutter people describe comes from many *recurring* items
filling a to-do list, and from one-time items piling up in places meant for habits. For Often Enough, tasks belong on
Today only, never in All Habits or Progress, and a finished task leaves Today once its day is over. Within a time of
day, nobody asks for the two kinds to be split.

## Apple's convention (Reminders), from the saved help pages

- **Inside a list, a manual order is set by dragging.** "While viewing a list, touch and hold an item you want to move,
  then drag it to a new location." (`rem-edit.txt`)
- **A manual order is one of the sort options, and dragging returns to it.** "If you drag a reminder in a list that's
  sorted automatically, the sort option for the list changes to Manual." (`rem-sort-mac.txt`)
- **Today has time-of-day sections, and dragging between them changes the time.** "If you drag a reminder in the Today
  Smart List from one section to another, the reminder's time is updated." (`rem-move-mac.txt`)

So one-time to-dos in Apple's own app are dragged inside a list or section like anything else. That fits what users
show above. It is not the reason for the recommendation.

## Limits

- Habit apps that mix habits and tasks on one Today are few in the corpus (mostly HabitNow, Tappsk, Habitica and
  Hizo), so the Q1 and Q3 numbers are small: 52 relevant reviews. Treat them as direction, not as rates.
- The "clutter" reviews are mostly 5★ praise for a habit-only app, which favours people who chose to keep two apps.
- Q2 to-do apps are not habit apps. They show how people expect to-dos to behave, not how they behave next to habits.
