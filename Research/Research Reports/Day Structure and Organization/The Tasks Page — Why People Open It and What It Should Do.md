# The Tasks Page — Why People Open It and What It Should Do

> **Written by Claude (Claude Code)**, 18 October 2026, at the user's request (Current Work 130). Authorship of every
> report is listed in the [Research Reports index](<../README.md>).

**The question (the user's words, tidied).** Research the Tasks page the way we researched the Habits page:
- Why do people come to it?
- What do they want to do there most often?
- What are its jobs, and what must it get right?

Report it plainly. Decisions, placeholders and designs follow afterwards, as for the Habits page. The Figma Tasks
section (`2373:2`) is empty for now.

---

## The short answer

- **Today already shows today's tasks.** People come to the Tasks page for what Today doesn't show:
  - what's coming on later days;
  - what's left over from earlier days;
  - tasks with no day yet;
  - what's done;
  - each repeating task, once.
- **Eight jobs**, from 1,152 reviews read and coded by hand (68 apps). In order of how much they matter:
  1. **Change, fix or remove a task.** The lowest-rated job (2.74★). People can't edit a task planned for another
     day, can't find delete, or delete by accident.
  2. **See what's coming** (181 reviews). Tomorrow, this week and later, in one place, grouped by day.
  3. **Deal with what didn't get done** (161). Unfinished tasks should move on by themselves, and moving one to
     another day should be one tap. **Our app already carries unfinished one-time tasks to today**, and reviews praise
     exactly that.
  4. **Clear what's done, or look back at it** (177). Both wishes are common. One section answers both: done tasks
     move out of the way into a *Done* section, newest first, with their dates.
  5. **Keep a long list in order** (426, the most reviews, but mostly content users asking for more, 3.83★). Their own
     order kept, dates in order, search. The order changing by itself is the angry part (2.62★).
  6. **Repeating tasks that behave** (96). The commonest complaint: after it's ticked, the next one vanishes until its
     day, so people can't plan.
  7. **Keep tasks without a date, and pick today's** (79). Wanted by 47. But six reviews complain when a new task
     defaults to *no date* and gets lost.
  8. **Do several at once** (77). Move many to another day, or delete many done ones.
- **The most frequent actions, in order (reasoned, with the reviews' support):**
  1. glance at what's left and what's next;
  2. tick something off;
  3. move an unfinished task to another day;
  4. add something for a later day;
  5. now and then, edit, delete, reorder or clear done tasks;
  6. rarely, search or change several at once.
- **Follow-up, 18 Oct 2026:** the user decided five of the questions, and a second pass of 890 reviews answered the
  rest (§7, §8):
  - group by when;
  - ~~a guarded tick on every row~~: **no tick on the Tasks page** (the user, later on 18 Oct: tasks are done on
    Today; the Tasks page lists them, and ⋮ manages them; §8.2);
  - completed tasks kept as history, never deleted by the app;
  - repeating tasks under their next date;
  - one-time tasks roll over, but a repeating task never doubles.
- **Third pass, 19 Oct 2026 (§9), habit apps only, after the user asked whether this was a habit app's task page or a
  to-do app's home page:** 792 more reviews read, 164 on topic. A list only by when hides repeating tasks and tasks
  far ahead (27 reviews), and what sits at the bottom gets missed (15). So, after the user's review, the page has
  two tabs by how a task is planned, **One-time · Repeating** (No date last in One-time; Repeating grouped by how
  often), and *Completed tasks* and *Archived tasks* move to the top bar's ⋮.
- **What the page must satisfy:**
  - every task in one place, grouped by **when**;
  - nothing lost or piling up unseen;
  - change, move and delete always one obvious step away, with words;
  - done tasks out of the way but kept;
  - repeating tasks shown with their next date;
  - the person's own order never changed behind their back.

---

## Basis

- **Screened: 1,295,451 reviews** on 18 Oct 2026, with
  [`Tasks Page Evidence/tasks_page_scan.py`](<Tasks Page Evidence/tasks_page_scan.py>). These are every App Store and
  Play Store review, plus the to-do apps' own corpora: Reminders, Google Tasks and Microsoft To Do.
- **Two groups:**
  - **Habit apps**: the review had to mention a task, to-do, chore, errand or reminder.
  - **To-do apps**: Reminders, Google Tasks, Microsoft To Do, and the Play Store's to-do apps: Tasks, To Do List,
    To-do list – tasks planner and others.
- **Twelve screens:**
  - later days;
  - all tasks in one place;
  - done tasks;
  - undone and moved tasks;
  - no date;
  - repeating;
  - search;
  - sorting;
  - lists;
  - edit and delete;
  - several at once;
  - calendar views.
- **Matched: 2,764.** 724 loose habit-app matches were set aside by a stricter pattern before reading. These matched
  only the "all tasks" screen, with no list, page or view in the sentence: praise like "helps me complete all my
  tasks". A random 40 of them were read afterwards to check the rule. 36 were praise with no wish for this page. The
  other four were a lost-data report, a widget complaint, a calendar remark and a request for a stats page (a Progress
  job).
- **Read by hand: 2,040.**
- **On topic: 1,152** (habit apps 652, to-do apps 500), coded by hand. A review can carry several codes. The codes,
  codebook and jobs are in [`Tasks Page Evidence/review_classification.py`](<Tasks Page Evidence/review_classification.py>).
  Running it checks:
  - every citation exists;
  - every code is in the codebook;
  - every quote below is in its review.
  All 42 quotes pass.
- **Citations:** `P4#3928` is line 3928 (counted from 0) of `Play Store Reviews/4. …/reviews.jsonl`. `A` is the App
  Store; `N` is the native apps' corpus (`N1` Reminders, `N6` Google Tasks, `N10` Microsoft To Do).
- **Scope:** counts are reviews that raise a theme, not people who want it. They show what goes wrong and what's
  asked for, relative to each other.
- **Earlier evidence used:**
  - [Tasks in the Free Plan](<../Business Model and Monetization/Tasks in the Free Plan — Limit, Count or Plus.md>)
    (all tasks free and unlimited, no streaks or stats);
  - [New Habit Screen, Round 2](<../Habit Creation/New Habit Screen, Round 2 — Types, Frequency, One-Time Tasks.md>)
    (one-time tasks move forward to today);
  - the Habits page report (its decisions on search, the row's ⋮ and Archived).

---

## 1. Why people open this page: eight jobs

| Job | Reviews | Apps | Mean ★ | What it tells us |
|---|---:|---:|---:|---|
| **1. See what's coming** (later days, a week or month) | **181** | 30 | 3.77 | The page's main reason to exist beside Today |
| **2. Deal with what didn't get done** (carry over, move, notice) | **161** | 28 | 3.75 | Daily; done well it's praised, done badly it's tedious |
| **3. Change, fix or remove a task** | **172** | 24 | **2.74** | The most painful: where people give up |
| **4. Keep a long list in order** (lists, order, sort, search, all in one place) | **426** | 47 | 3.83 | The most asked, mostly by content users |
| **5. Clear what's done, or look back at it** | **177** | 31 | 3.66 | Two wishes, one answer |
| **6. Repeating tasks that behave** | **96** | 17 | 3.46 | Mostly to-do apps getting it wrong |
| **7. Keep tasks without a date, and pick today's** | **79** | 15 | 3.92 | Wanted, with a trap in the default |
| **8. Do several at once** (move, delete, duplicate) | **77** | 17 | 3.47 | Small, but felt by heavy users |

Also raised, outside this page:
- widgets for tasks (58; the Tasks widget already exists);
- tasks lost by an update or sync (8, 1.25★; the D rules cover this);
- praise for keeping habits and one-time tasks apart (13, 4.46★): *"I like that it separates habits from one time
  tasks"* (HabitNow, 5★, `P2#8000`).

*Job 4 has the most reviews, but they come mostly from to-do-app users asking for more (3.83★). Job 3 has fewer and
the worst ratings (2.74★): that's where people leave. As on the Habits page, design for job 3 first. Jobs 1 and 2 are
what make this page different from Today.*

---

## 2. Each job: what people said, and what the page should do

### Job 1. See what's coming (181 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| See tasks for later days in one place | 111 | 3.82 |
| See dated tasks on a calendar (week or month) | 67 | 3.76 |
| Future tasks cluttering today's view (or praise that they don't) | 14 | 3.64 |

**Users show:**
- **Without a view of later days, people can't prepare.**
  - "I can’t find out how to see what I have planned for tomorrow so I just have to hope I’m ready" (Habit Tracker,
    4★, `A1#2365`)
  - "I really wish that I could see what's on the agenda for the next day." (Productive, 5★, `A13#16681`)
- **Grouping by day is what people praise.** "…groups tasks by due date, such as today, tomorrow, next week, next
  month, later and no due date. this one does it perfectly" (To Do List, 5★, `P126#50191`).
- **But not on today's list.**
  - "Why can't I hide future tasks?" (Microsoft To Do, 5★, `N10#10058`)
  - Of Google Tasks hiding repeats until their day: "I don’t feel overwhelmed looking at it" (4★, `N6#5497`).
  - The future belongs on its own page, not mixed into today.

**So the page should:**
- group tasks by **when**: *Today*, *Tomorrow*, then the rest of this week day by day, then *Later* (and *No date*, if
  decided);
- keep future tasks off Today until their day (Today already does this);
- leave a full calendar to the habit app's other views for now: 67 ask, but a calendar inside a task list is a second
  page in itself (reasoned). Day headings give the same "what's on Thursday" answer.

### Job 2. Deal with what didn't get done (161 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| Move, postpone or reschedule a task to another day | 65 | 3.78 |
| Unfinished tasks should carry on to the next day by themselves (or praise that they do) | 64 | 3.80 |
| A task left from an earlier day is hard to notice | 18 | 2.72 |
| Praise for being shown what's left | 11 | 4.73 |
| Don't let unfinished daily tasks pile up | 6 | 4.00 |

**Users show:**
- **Carrying over is praised; making people do it by hand is resented.**
  - "I love how your unfinished tasks is just being moved to next day." (Tappsk, 5★, `A59#11917`)
  - "…the undone items did not roll over to the next day. I have to go into and edit them and move them each day.
    this was off-putting." (Me+, 3★, `P4#3928`)
- **Without alarm.** "…overdue tasks roll over to the next day without big "overdue!!" warnings" (HabitNow, 5★,
  `P2#3263`). This agrees with our rule never to say *overdue* (U3).
- **Moving one is an everyday need.** "i wish the app had the ability to snooze tasks to a different day for when
  schedules change." (Me+, 4★, `P4#6660`)
- **The day ends when the person's day ends.** "…as a night person I always do my task at midnight until the morning
  of the next day" (Tappsk, 5★, `A59#13552`). Our day start setting (D7) already answers this.
- **Daily repeats shouldn't pile up.** "If it's daily and I've missed a day, then it should have the option to just
  delete it." (To Do List, 5★, `P126#35298`)

**So the page should:**
- show carried-over tasks under *Today* with their original day in their line ("Planned for Tue 14 Oct"), never
  "overdue" and never red;
- offer **Move to another day** on every unfinished task: *Tomorrow*, or *Pick a day*. This is the Day sheet's
  *Reschedule*, reachable from the row;
- keep the current rule: a one-time task carries over; a missed repeating occurrence doesn't pile up.

### Job 3. Change, fix or remove a task (172 reviews, 2.74★)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| Can't edit or plan a task on a day other than today | 59 | 2.68 |
| Can't delete, or can't find delete | 58 | 2.86 |
| Can't find how to edit, or editing is broken | 43 | **2.26** |
| Wants deleted tasks recoverable | 9 | 3.56 |
| Change one occurrence of a repeating task, not all | 6 | 3.50 |

**Users show:**
- **Editing only on the task's own day is the single worst pattern.** Me+ alone is 43 of the 59.
  - "I can't edit a task unless it is the day I'm supposed to do the task? This is not helpful." (Me+, 2★,
    `P4#29590`)
  - "Each time I try to edit something it tells me to focus on today and won’t let me edit." (Me+, 3★, `A4#19062`)
- **Delete must exist and be findable.** "There's no way to delete a task. Deal-breaker." (Me+, 1★, `P4#17399`)
- **…and be recoverable.** "Today I accidentally deleted a list of reminders." (Reminders, 2★, `N1#12168`)
- **Repeating tasks need a one-off change.** "If I change due date or time, it will change for all my recurring task
  as well." (To-do list – tasks planner, 2★, `P97#2491`)

**So the page should:**
- let any task, on any day, be edited from its row: a ⋮ with **Edit**, **Move to another day**, **Duplicate**,
  **Archive** and **Delete…**, written out (our rule: actions always have text);
- open the task's details on a tap, as the Habits page does;
- confirm Delete and offer Undo afterwards.

### Job 4. Keep a long list in order (426 reviews)

| Theme | Reviews | Mean ★ | Mostly from |
|---|---:|---:|---|
| Separate lists, categories or sub-lists | 126 | 4.31 | to-do apps (88 of 126) |
| Their own order, by dragging, kept | 85 | 3.78 | both |
| Sorted by date or time | 76 | 3.82 | habit apps (56) |
| Search | 64 | 3.52 | to-do apps (50) |
| All tasks in one place, across days or lists | 58 | 4.03 | both |
| Other sorts (priority, name, colour) | 50 | 3.76 | both |
| The order changes by itself, or dragging fails | 26 | **2.62** | both |

**Users show:**
- **Their order is theirs.** "Please stop moving my tasks." (Finch, 3★, `A10#3549`)
- **But dates should come in order.** "Why isn‘t it possible to sort the tasks in the list by the scheduled time?"
  (Tappsk, 1★, `A59#1352`)
- **Search, once a list is long.**
  - "I have well over 600 different reminders and when I type in a word to search for it, it fails to come up."
    (Reminders, 2★, `N1#8769`)
  - Google Tasks' missing search draws the sharpest words: "Is it really possible that the company who created
    internet search has not included a search feature in their Task Application?" (1★, `N6#6748`)
- **Lists are praised in to-do apps.** "…separate lists … really helps to reduce overwhelm of seeing everything as
  once." (Tappsk, 5★, `A59#1910`)
- **All in one place.** "…a way to view all of the repeating tasks in one simple list in order to edit them (or the
  routines) without having to skip through days and weeks and months" (Me+, 5★, `A4#2700`)

**So the page should:**
- order by date between sections. Within a day, keep the person's order (drag), the same order Today shows (U13);
- put search in the top bar, as on the Habits page (the user's decision there);
- **not add task lists now.** This is reasoned from first principles:
  - Our tasks already sit in times of day, and habits in groups. A third way to organise would compete with both.
  - The demand comes mostly from people using a to-do app as their whole system (88 of 126).
  - It's a decision for the user (§7).

### Job 5. Clear what's done, or look back at it (177 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| A record of done tasks (history, by date) | 74 | 3.80 |
| Hide, clear or delete done tasks | 57 | 3.65 |
| Move done tasks below, separate or dim them, not hide | 38 | 3.87 |
| Ticked by accident, wants it back | 22 | **2.50** |

**Users show:**
- **Out of the way…**
  - "…when you completed a task it was bumped to the bottom of the list. This is HUGE for people with object
    permanence issues" (Me+, 4★, `A4#16792`)
  - "I feel more accomplished when I can actually clear them off my list." (Me+, 3★, `P4#71175`)
- **…but kept.**
  - "I wish there was a way of keeping track of my previously completed tasks so I could look back on the progress
    I've made." (Habitica, 4★, `P8#6660`)
  - "I like being able to see what I've done today" (HabitNow, 5★, `P2#9318`)
- **Mistakes must be easy to take back.**
  - "Too easy to accidentally complete a task." (Habitica, 3★, `P8#4793`)
  - "…it would be good to be able retrieve it and restore it from this logbook as well." (Habitica, 4★, `P8#5965`)
- **Not instantly.** With done tasks hidden, a tick made "the card disappear" "on the first touch", before a second
  tap could change it (Loop, 2★, `P3#7224`). This is our hold rule (U4).
- **Clearing in bulk.** "There is no way to bulk-delete completed tasks so you are stuck with the thousands of
  finished things" (Microsoft To Do, 1★, `N10#18485`)

**So the page should:**
- move a ticked task, after the usual pause, into a **Done** section at the end:
  - folded by default, with its count ("Done · 12");
  - newest first, each with the day it was done;
- give every tick an **Undo** right away, and keep un-ticking possible from Done;
- offer **Delete done tasks…** in the top bar's ⋮, asking first (whether to offer it is a decision, §7).

### Job 6. Repeating tasks that behave (96 reviews, 3.46★)

**Users show:**
- **The next one vanishes until its day**, mostly in Google Tasks and Tasks: To Do List.
  - "Once I complete a recurring task for this month it disappears from the list and only pops up the morning the
    task is due. I need all tasks visible ALL THE TIME." (Google Tasks, 2★, `N6#6362`)
  - "…after checking today instance upcoming instances are not visible" (Tasks, 2★, `P84#54118`)
- **But not straight back on today's list.** "…any repeating reminder immediately shows the next iteration — I like to
  bask in the joy of having comp[leted]" (Reminders, 4★, `N1#8742`).
- **Some want a missed one to wait.** "…recurring tasks not completed should move to the next day." (HabitNow, 4★,
  `P2#10547`). Our *After it's done* repeat already does this.

**So the page should:**
- list each repeating task **once**, in its own **Repeating** section, with its rhythm and next date ("Every Sunday ·
  Next Sun 26 Oct");
- keep today's occurrence under *Today*, and the next one off Today until its day (as now).

### Job 7. Keep tasks without a date, and pick today's (79 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| Tasks with no date ("someday") | 47 | 3.98 |
| Pick today's tasks from a bigger list (Microsoft's *My Day*) | 29 | 4.00 |
| A new task should default to today, not to no date | 6 | 3.17 |

**Users show:**
- **Some tasks have no day yet.**
  - "…can't add tasks with no date.... most of the times i need to collect and organise my tasks in different
    categories first and gradually decide when they will take place." (HabitNow, 4★, `P2#922`)
  - "I use the quick task feature to make my "To Do" list so that the app doesn't bother me about being overdue, but I
    have the list available when there is free time." (To Do List, 5★, `P126#47524`)
- **But a no-date default loses tasks.** "Doesn’t default task date to today so takes end up alllll the way at the
  bottom of your task list under the no date category" (Google Tasks, 2★, `N6#862`)

**So the page could** (this is a decision, §7):
- allow **No date** in the task form, with the default staying *Today*;
- show undated tasks only here, in a *No date* section, never on Today;
- give each one **Do today**, which gives it today's date.

Today stays the day's only list. *My Day* is that same wish, met by Do today.

### Job 8. Do several at once (77 reviews)

**Users show:**
- "Why can’t I select a bunch of tasks and move them to today? Have to do it one by one is tedious." (Reminders, 4★,
  `N1#19918`)
- "…I could select multiple items and do a bulk move to a new day/time when the day goes sideways." (Reminders, 5★,
  `N1#736`)
- "I have to repeatedly type in tasks instead of duplicating them to another day." (Me+, 1★, `P4#7609`)

**So the page should:**
- start selection with a long press, as Google's apps do;
- offer **Move to another day**, **Archive** and **Delete…** for the selection;
- put **Duplicate** in each row's ⋮ (as on the Habits page).

---

## 3. The most frequent actions

Reviews don't measure how often people do things. Two signals help:
- what people describe doing;
- how many reviews in each job mention daily use ("every day", "each morning").

Reviews about moving unfinished tasks (24%) and about repeating tasks (27%) mention daily use most. Reviews about
order and lists (11%) and about editing (12%) mention it least. The rest is **reasoned from first principles**.

| How often | Actions | Where it happens |
|---|---|---|
| **Several times a day** | Glance at what's left; tick something off | Mostly Today; the Tasks page's *Today* section too |
| **Daily** | Move an unfinished task to another day; see tomorrow | The Tasks page (and the Day sheet's Reschedule) |
| **A few times a week** | Add something for a later day; look at the week ahead | The Tasks page |
| **Now and then** | Edit, delete, reorder; clear or look back at done tasks | The Tasks page |
| **Rarely** | Search; change several at once; restore an archived task | The Tasks page |

So the top of the page should answer "what's left today and what's next". Moving a task should be one step from its
row. Everything else can sit one level down, in the ⋮ menus.

---

## 4. What's built now (for the record, not a baseline)

*The user, 18 Oct 2026: the iPhone's task screens were made on the fly; the Android designs are the final ones.*

| Area | Now | Against the jobs |
|---|---|---|
| Unfinished one-time tasks | **Move forward to today** by themselves (`HabitStore.isDue`) | ✓ Job 2, praised in reviews |
| Moving a task | Day sheet: *Do Tomorrow*, *Another day…*; a repeating task's occurrence moves only before its next one | ✓ Job 2, but not from the Tasks page's row |
| The Tasks page | One flat list of every task in the person's order, done ones mixed in; then *Archived*; tap opens the task's page; swipe to archive or delete; *Select* for several; drag to reorder (`AllHabitsView(kind: .tasks)`) | ✗ No grouping by day (job 1); done tasks not separated (job 5); no search (job 4) |
| Repeating tasks | Today shows the day's occurrence; *After it's done* waits | ✗ The page doesn't say when each comes next (job 6) |
| No date | Every one-time task has a day (default today) | Job 7 is a decision |
| Done tasks | Stay in the list where they were | ✗ Job 5 |
| Words | "Planned for Wed 1 Oct", never "overdue" (U3) | ✓ |

On Android the Figma Tasks section is empty. Both apps decide what's due through the shared core, so the carry-over
and repeat rules above hold on Android too.

---

## 5. How native Android does it (reasoned, not review evidence)

This describes the platform's conventions, so the page feels part of the phone. Where the reviews above agree, that's
said.
- **Google Tasks**, Android's own to-do app:
  - a circle at the start of each row ticks it;
  - a ticked task drops into a folded **Completed (n)** section at the end, with a snackbar Undo;
  - ⋮ holds *Sort by: My order / Date* and *Delete all completed tasks*;
  - dates show as small chips in the row.
  
  Its own reviews complain about:
  - no search (`N6#6748` and about 20 like it);
  - repeating tasks hidden until their day (`N6#6362`);
  - new tasks defaulting to no date (`N6#862`).
  
  So copy its shape, not those three gaps.
- **Rows:** Material 3 list items, with the tick at the start (a checkbox, as Google Tasks), the name, one supporting
  line (when · time of day), and ⋮ at the end. No › chevron, as on the Habits page.
- **Section headings** for days (*Today*, *Tomorrow*, *Thu 23 Oct*, *Later*), in the segmented rounded blocks the other
  Android pages use.
- **Selection:** a long press, and the top bar turns into a selection bar with the count and actions (Gmail, Keep,
  Photos).
- **Undo:** a snackbar after a tick, a move or a delete.
- **Add:** a floating action button, *Add task* with its label, as Google Tasks.

---

## 6. The page this suggests (a description, not a design)

*Superseded by §8.6, after the user's decisions and the follow-up research.*

**Top bar:** ☰ · *Tasks* · search · ⋮ (*Delete done tasks…*, *Archived tasks*). **FAB:** *+ Add task*.

**Sections, in order:**
1. **Today**:
   - today's tasks in Today's order, carried-over ones included, each saying its original day;
   - the tick at the start.
2. **Tomorrow**, then each remaining day of this week by name (*Thu 23 Oct*), then **Later** (by date).
3. **No date**, if decided, with *Do today* on each.
4. **Repeating**: each repeating task once, "Every Sunday · Next Sun 26 Oct".
5. **Done · 12**:
   - folded; newest first;
   - each row shows "Done Tue 14 Oct";
   - un-tick from here.
6. **Archived · 3** ›, opening Archived tasks (as on the Habits page).

**Each row:**
- tick ○;
- name;
- one line: when and where ("Planned for Tue 14 Oct · Morning", "Tomorrow · 6:00 PM · Evening");
- ⋮ with **Edit**, **Move to another day**, **Duplicate**, **Archive**, **Delete…**.
- **Tap:** the task's details (History, Notes). **Long press:** selection.

**States to draw:**
- no tasks yet;
- a few tasks today only;
- many tasks across days;
- carried over from earlier;
- with repeating tasks;
- with done tasks (folded, open);
- a tick with its Undo;
- Move to another day;
- a search with and without matches;
- selection;
- Archived tasks;
- No date (if decided).

---

## 7. Decisions

> **Decided by the user, 18 Oct 2026** (these apply to the Tasks page only; Today keeps showing each dated task in its
> time of day, or in Anytime, and it can be ticked there too):
> - **Tasks with no date:** allowed; a new task still defaults to *Today*.
> - **No task lists or categories** for now.
> - **Search** always in the top bar, the same mental model as the Habits page.
> - **Long press to select several.**
> - **Completed tasks are kept as history.**
> - Left to the research, with a follow-up where the evidence was thin: grouping by when, the tick on each row, how
>   completed history works, where repeating tasks show, and **whether an unfinished task rolls over**, including a
>   repeating one (the user: "if it is a repeat task for every three days … rolling over to tomorrow doesn't make
>   sense. It will create double tasks"). Answered in §8.
>
> **The user's correction, 18 Oct 2026:** the iPhone's task screens were made on the fly and aren't a reference. The
> Android designs are the final ones; §4 only records what's built.
>
> **Decided by the user after the designs, 18 Oct 2026 (overrides §8.2):** the Tasks page has **no checkbox**. "You can
> see what you have created but it's not like you should be able to complete from there. They appear in the Today
> here … it's just a list of displaying things. And the three-dot menu, that's it." Each row shows the task's icon
> in its colour, as on the Habits page; a tap opens the task, ⋮ manages it. Done tasks are done on Today.
> **And every delete question has two buttons, Cancel and Delete** (no *Archive instead* beside them: "there is a
> high chance of misclick … just show two options very clearly"), for one task or habit and for several selected;
> the body says that archiving keeps the history (Rulebook D9).

The original options, kept for the record:

1. Group the page by when, or keep one list in the person's order. *Answered in §8.1: group by when.*
2. A tick on each row with Undo, or tap only to open. *The research said a tick, with Undo (§8.2); **the user
   decided no tick: tap to open, ⋮ to manage.***
3. A folded *Done* section with *Delete done tasks…*, or keep every done task as history. *Decided: history; §8.3.*
4. A *Repeating* section, or repeating tasks under their next date. *Answered in §8.4: under the next date, plus a
   Repeating list for managing them.*
5. Tasks with no date. *Decided: yes, default Today.*
6. Lists or categories. *Decided: not now.*
7. Search in the top bar. *Decided: always.*
8. Selecting several. *Decided: long press.*

---

## 8. Follow-up research: the open questions (18 Oct 2026)

**Method.** A second screen of the same 1,295,451 reviews, aimed at the five open questions:
- an unfinished task moving on, and missed repeats;
- a list grouped by when;
- where and how people tick;
- completed tasks;
- seeing repeating tasks.

It found 1,925 matches that the first pass hadn't read. All were read by hand; **890 were on topic** (codes and quotes
in [`Tasks Page Evidence/followup_classification.py`](<Tasks Page Evidence/followup_classification.py>), the screen in
`followup_scan.py`; all 30 quotes checked). The two passes never read the same review, so their counts can be added.

### 8.1 Group the page by when: yes

| Evidence | Reviews | Mean ★ |
|---|---:|---:|
| See later days in one place (first pass) | 111 | 3.82 |
| Grouped by when: today, tomorrow, days, later (follow-up) | 30 | 3.63 |
| Sorted by date (first pass) | 76 | 3.82 |
| Their own order, by dragging (first pass) | 85 | 3.78 |
| Plan tomorrow's list the night before (follow-up) | 17 | 3.82 |
| All past unfinished tasks lumped under one "Past" heading (follow-up) | 1 | 1.0 |

**Users show:**
- Day headings with the weekday beat vague buckets: "…clearly separated by day with the week day also marked (ex.
  Monday, 12 Oct) instead of having "Next Week"" (To Do List, 4★, `P126#67903`).
- A long date-sorted list isn't enough: "…organized them by week/month instead of just a long list sorted by date."
  (Tasks, 4★, `P84#31709`)
- Within a day, the order is still theirs: "…change the task order looking at one day via drag and drop (when the list
  is sorted by date)" (Google Tasks, 3★, `N6#1320`).
- Planning ahead is an evening habit: "Please allow for setting up your daily to-do list for the NEXT DAY." (Microsoft
  To Do, 4★, `N10#18154`)

**Decision.** Sections by when:
- *Today* (with carried-over tasks, §8.5);
- *Tomorrow*;
- each of the next five days by name ("Thursday, 23 Oct");
- *Later*, with a heading for each month;
- *No date*.

Within a day, the person's own order, by dragging; on *Today* it's the same order Today shows. Nothing is lumped into a
"Past" heading.

### 8.2 A tick on each row: the research said yes, guarded; the user decided no

> **Decided by the user, 18 Oct 2026: no tick on the Tasks page.** Tasks are done on Today, where each one already
> shows in its time of day; the Tasks page is for seeing and managing what's planned. Each row shows the task's icon,
> its name, one line and ⋮. A task done on Today shows on the Tasks page struck through at the end of *Today*, with
> the time it was done, until the day ends; *Mark as not done* is in its ⋮ menu (and on Completed). A later task is
> done early from Today's view of that day. The evidence below is kept for the record; its accidental-tick finding
> is one more reason for the user's choice.

| Evidence (follow-up) | Reviews | Apps | Mean ★ |
|---|---:|---:|---:|
| Ticked by accident, couldn't easily take it back | **147** | 17 | 2.98 |
| Wants to tick a task planned for a later day early | 13 | 7 | 2.92 |
| Ticking from the task list itself (wanted or praised) | 2 | 2 | 3.0 |
| Wants a confirmation before a tick | 5 | 2 | 3.8 |

**Users show:**
- **Making people go back to Today to tick is resented:** "You can't check them off as done unless you are on the
  TODAY'S task list, so you're going back and forth between TODAY and TASKS. Makes NO sense." (HabitNow, 1★,
  `P2#9363`)
- **Early ticks matter:** "…i have a bill due on Oct 25 and I pay it on Oct 15, i cannot yet mark it as completed."
  (HabitNow, 5★, `P2#8957`)
- **The real danger is the accidental tick that vanishes**, the follow-up's largest finding:
  - "My thumb that I typically use to scroll downwards lands exactly where the ‘complete’ button is" (Microsoft To Do,
    1★, `N10#10405`)
  - "…so easy to accidentally click the complete button... Then the task disappears and you've no idea what you just
    lost..." (Microsoft To Do, 1★, `N10#10516`)
  
  Most of the 147 come from two places: Reminders' interactive widget (iOS 17), and Microsoft To Do's tick at the
  screen's edge with no Undo.

**What the research recommended (not taken).** A checkbox at the start of every row, on every day, so a later task
could be ticked early. Four guards:
1. Only the checkbox ticks; a tap on the row opens the task.
2. A snackbar after every tick: *Done · Undo*.
3. **A ticked task doesn't vanish.** It stays, struck through, at the end of its day until that day is over (§8.3),
   so a wrong tick is visible and can be unticked in place.
4. No confirmation dialog. Five ask for one, but it would slow the most frequent action; Undo answers the same need.
   This part is reasoned.

A repeating task's next occurrence ticked early counts for that occurrence; the one after it appears under its own day.

### 8.3 Completed tasks: kept as history, never deleted by the app

| Evidence (follow-up) | Reviews | Mean ★ |
|---|---:|---:|
| A record of completed tasks to look back at | 77 | 4.10 |
| Today's done tasks stay visible, struck through, until the day ends | 49 | 4.00 |
| Done tasks hidden or cleared from the list | 38 | 4.50 |
| Delete all done tasks at once | 25 | 3.24 |
| Newest first, to find an accidental tick | 22 | **2.32** |
| An option to remove done tasks after a while | 21 | 4.38 |
| The date and time it was done | 19 | 4.37 |
| **Angry that completed tasks were deleted automatically** | 17 | **2.06** |
| Grouped by the day they were done | 13 | 3.69 |
| A repeating task's past completions kept | 8 | 3.75 |

**Users show:**
- **Deleting history is the worst thing an app did here.** To Do List's update in May 2026 started deleting finished
  tasks after 30 days:
  - "WHY DID YOU MAKE FINISHED TASKS AUTO DELETE AFTER 30 DAYS. I REALLY LIKED LOOKING BACK AND SEEING WHAT IVE
    ACCOMPLISHED." (5★, `P126#18362`)
  - "…you deleted over 300 of my completed tasks including critical medical history" (1★, `P126#18467`)
- **For the day itself, struck through, then gone:**
  - "The finished tasks should be marked, but should disappear at midnight, not right away." (Google Tasks, 3★,
    `N6#3911`)
  - "…get a line through them and go away st the end of day instead of just vanishing immediately." (To Do List, 3★,
    `P126#55586`)
- **Out of sight, not deleted:** "I love that I can hide finish tasks without deleting them … completed tasks lists
  give me anxiety." (Tasks, 5★, `P84#13144`)
- **With when:** "Wish it would log date & time of when you completed task." (To Do List, 4★, `P126#30702`) and
  "Wunderlist would show the completed items in order of last completed on the top." (Microsoft To Do, 1★,
  `N10#14123`)

**Decision.**
- **Today:** a task done on Today shows on the Tasks page at the end of *Today*, struck through, with the time it
  was done, until the day ends (at the person's day start, D7).
- **Then it moves to *Completed*:** a row at the end of the page, *Completed · 128 ›*, like *Archived*. It opens a
  page:
  - grouped by the day done (*Today*, *Yesterday*, *Thursday, 16 Oct*), newest first;
  - each task with the time it was done, and its planned day if that was different ("Planned for Sat 25 Oct");
  - *Mark as not done* in a row's ⋮ menu;
  - search covers it.
- **Repeating tasks' completions** are listed there too.
- **The app never deletes completed tasks by itself.** People can delete one, or select several (*Select all* ›
  *Delete…*); that's how the 25 who want to clear them all do it. There's no automatic clean-up, given what happened
  to To Do List's users. Rulebook D6 already treats deleting as archiving with undo.

### 8.4 Repeating tasks: under their next date, plus a list to manage them

| Evidence | Reviews | Mean ★ |
|---|---:|---:|
| After ticking, the next one is hidden until its day, so no planning (follow-up) | 38 | 2.89 |
| …and in the first pass (repeating + see later days) | 16 | — |
| Don't clutter today's list with future or repeating tasks (follow-up) | 18 | 3.89 |
| The list jumps to the next occurrence after a tick (follow-up) | 9 | **1.89** |
| The next one appearing straight away on today's list is confusing (follow-up) | 7 | 3.14 |
| All repeating tasks in one list, with their next and last dates (both passes) | 7 | — |

**Users show:**
- "If there is a monthly or yearly task, I will not know about it until the day it is due." (Google Tasks, 3★,
  `N6#3917`)
- "…every time I finish a repeating task, it visually fast-forwards to the date of the next occurrence … Then I have to
  scroll back to the top. Every single time." (To Do List, 1★, `P126#17068`)
- "…if I checked the mail today, for example, I don't want the next instance to show in My Day today as well!"
  (Microsoft To Do, 2★, `N10#23128`)
- "…see my current repeating task, but also when the next one will be due, since I often don't do the task on the day
  it is due." (Tasks, 5★, `P84#11608`)

**Decision.**
- Each repeating task shows **once**, under the day of its next occurrence, with its rhythm in its line ("Every 3
  days"). Only the next one shows, so a daily task doesn't fill *Later*.
- Ticking today's occurrence leaves it struck through in *Today*. The next one appears quietly under its own day:
  - the list never scrolls or jumps;
  - the next one is never added to *Today*.
- A **Repeating · 6 ›** row at the end of the page lists every repeating task once, with its rhythm, next date and the
  last time it was done, for managing them. It's not a section in the main list, which would show each task twice.

### 8.5 Rolling over: yes for one-time tasks; a repeating task never doubles

| Evidence | Reviews | Mean ★ |
|---|---:|---:|
| One-time: should carry to the next day, or praise that it does (both passes) | 124 | 3.97 |
| Don't carry (mostly daily lists) (both passes) | 9 | — |
| Keep its original date, or mark it (follow-up) | 6 | — |
| Repeating: a missed one should give way to the next, not stay overdue (follow-up) | 19 | 3.89 |
| Repeating: a missed one should stay until done (follow-up) | 7 | 3.86 |
| Repeating: missed repeats pile up, or must be ticked one by one (follow-up) | 5 | 3.40 |
| Repeating: a missed one disappears with no trace (follow-up) | 5 | **2.20** |
| Repeat counted from when it was done (follow-up) | 18 | 2.89 |
| Skip one occurrence (follow-up) | 7 | 4.29 |

**Users show:**
- **One-time tasks:**
  - "…your tasks automatically move to the next day if you don't do them so nothing gets left behind." (To-do list –
    tasks planner, 5★, `P97#3600`)
  - With its date kept: "…move uncompleted task to Today with visible notes or tags that indicate its original due
    date" (Reminders, 3★, `N1#16622`).
- **Repeating tasks: never double.**
  - "…if you miss a repeating daily task, and you do it the day after and check it off, the app will not duplicate the
    task expecting you to do the same thing twice now in one day." (Reminders, 4★, praise, `N1#8383`)
  - The opposite: "…when you dont achieve that goal it stays until you complete it, which causes goals to pile up."
    (Finch, 2★, `A10#25265`), and "…not make me check off each missed day." (Microsoft To Do, 5★, `N10#2247`)
- **But don't lose it.**
  - "…reoccurring tasks disappearing when not marked complete. So the next day you don't know what u didn't get done"
    (To-do list – tasks planner, 2★, `P97#2905`)
  - For long cycles people want it to wait: "I have fortnightly recurring tasks … which I need to compete some time
    during that fortnight. the uncompleted tasks didn't carry over day to day and just jumped to the next due date."
    (Tasks, 5★, `P84#29645`)
- **Some want the next one counted from when it was done:** "…repeating of the task from the day I done it, but not
  from the date I wanted to do it?" (To Do List, 4★, `P126#202530`) **or to skip one:** "Sometimes I intentionally want
  to skip a task without marking it as completed" (Reminders, 4★, `N1#6302`).

**Decision: one rule, at most one open occurrence of a task at any time.**
1. **A one-time task** not done carries to *Today* every day until it's done, moved or deleted. Its line keeps its
   date ("Planned for Tue 14 Oct"), never "overdue", never red (U3). On Today it sits in its own time of day.
2. **A repeating task on a fixed schedule** (daily, days of the week, every few days, weeks or months) that isn't done
   carries to *Today* the same way, **until the day its next occurrence is due. That day, the missed one quietly gives
   way to the new one**, so there are never two copies and nothing to tick off twice.
   - Doing a carried one (on Today) counts for its own day; the schedule doesn't move.
   - **The user's example:** a task every 3 days, due Monday and not done. It shows on Tuesday and Wednesday as
     "Planned for Mon 13 Oct". On Thursday only Thursday's shows.
   - A daily task's next one is always tomorrow, so a missed daily task never carries: it simply starts fresh. That
     answers both the 19 who want a reset and the 7 who want long cycles to wait.
   - If the schedule has ended, the last occurrence carries like a one-time task.
3. **A task that repeats *After it's done*** only ever has one occurrence. It waits until done, and the next is
   counted from that day. This is already the option for the 18 who want repeats counted from completion.
4. **Skip this time**, on a repeating task's occurrence only, lets it go without doing it; the next stays where it
   is. A one-time task is moved or deleted instead. This is new: the 4 Oct iPhone rule had no Skip for tasks, and the
   7 reviews ask for it.

**This changes a shared rule.** Today the core drops a missed repeating occurrence the next day: that's the "disappears
with no trace" complaint. Rule 2 needs the shared core's spec, its golden cases and the Android build changed together
(Rulebook T21). It changes what people see, so it's the user's decision, given here.

### 8.6 The page, as decided (replaces §6)

> **Changed by §9 (19 Oct 2026):** two tabs at the top, One-time and Repeating; the rows at the end go; *Completed tasks*
> and *Archived tasks* move to the top bar's ⋮. The rest of this section stands.

**Top bar:** ☰ · *Tasks* · search · + (*Add task*; the form's date defaults to Today, with *Tomorrow*, *Pick a date*
and *No date*). No FAB, no top-bar ⋮ (as drawn, 18 Oct).

**Sections:**
1. *Today*, in Today's order, carried-over tasks included (each saying its planned day); ones done on Today struck
   through at the end.
2. *Tomorrow*.
3. The next five days by name.
4. *Later*, with month headings.
5. *No date*, each with *Do today*.

**Rows at the end:**
- *Repeating · 6* ›
- *Completed · 128* ›
- *Archived · 3* ›

**Each row:**
- the task's icon in its colour (no checkbox: the user, 18 Oct);
- name;
- one line: when, time of day and rhythm ("Planned for Tue 14 Oct · Morning", "Thursday · Every 3 days");
- ⋮ with **Edit**, **Move to another day**, **Duplicate**, **Skip this time** (repeating only), **Archive**,
  **Delete…** (asks first, Cancel and Delete only).

**Gestures:**
- **Tap:** the task's details.
- **Long press:** selection, with *Move to another day*, *Archive*, *Delete…*.
- **Drag:** reorder within a day.

**States to draw:**
- empty;
- today only;
- many days;
- carried over (one-time and repeating);
- a repeating task under its next day;
- a task done on Today, struck through at the end of *Today*;
- Move to another day;
- Skip this time;
- No date;
- search with and without matches;
- selection;
- Repeating, Completed (by day, select and delete) and Archived pages.

---

## 9. A habit app's task page: finding every task (third pass, 19 Oct 2026)

**The user's question (19 Oct 2026, after approving the designs):** was this research about a dedicated tasks page
inside a habit tracker, or about the home page of a to-do app? "Both are really different … our job, the main task
page, is actually helping the users to see what are the tasks they have." And two problems with the page as designed:
- grouped by when, **a repeating task that comes only on some days, or a task planned far ahead, is hard to find**;
- **Repeating, Completed and Archived sit at the very bottom**, so with a long list they're hard to reach.

**The honest answer: both.** The first pass read 652 habit-app reviews and 500 from to-do apps; the follow-up read 111
habit-app and 779 to-do-app reviews. §8.1's "group by when" leaned on the to-do apps: its follow-up row (30 reviews)
had 28 from them, and all four of its quotes are from to-do apps. The habit-app half of the first pass did ask to
see later days in date order (*see later days in one place* 67 habit-app reviews, *sorted by date* 56), but it also
asked for *one place showing all tasks* (37). So this third pass reads habit apps only.

**Method.** [`Tasks Page Evidence/finding_scan.py`](<Tasks Page Evidence/finding_scan.py>) screened all **932,330**
habit-app reviews (App Store and Play Store, to-do apps left out) that mention a task or to-do, for: can't find or
see a task; tasks only shown on their day; a list of all, future or repeating tasks; tabs and filters; tasks far
ahead or on long cycles; long scrolling; where done or archived tasks are; tasks apart from habits. Reviews already
coded in §1–§8 were left out, so the counts can be added. **792 matched; all were read by hand; 164 are on topic**
(codes, codebook and quotes in [`finding_classification.py`](<Tasks Page Evidence/finding_classification.py>); all 18
quotes checked). Me+ (121 matched), Habitica (149), Finch, HabitNow, Streaks and Productive give most of them.

| Finding (habit apps only) | Reviews | Apps | Mean ★ |
|---|---:|---:|---:|
| **Can't see every task, only day by day**; a task on another day, or far ahead, is out of sight | **27** | 11 | **3.26** |
| A quick way to narrow the list (status, due, type, today) | 23 | 11 | 4.09 |
| **Tasks on long cycles**: monthly, every few months, yearly | 22 | 11 | 4.05 |
| **By how often, or by kind**: dailies, weeklies, monthlies; one-time apart from repeating | 21 | 9 | **4.29** |
| **What they need is at the bottom, or tucked in a menu**, so they scroll or miss it | **15** | 11 | 3.40 |
| Plan by day: tomorrow, later days, a month calendar | 14 | 8 | 3.57 |
| Tasks kept apart from habits (we already do this) | 13 | 10 | 3.92 |
| Done tasks kept and findable, out of the way | 11 | 7 | 3.18 |
| **A filter, tab or fold hid something they needed** | 5 | 4 | **2.60** |

**Users show:**
- **Day by day hides tasks.** "i want to see all my rountine tasks but there is no screen for it … i cannot know when
  is the cleanning bathroom day. i need to tap on all day on calendar to search for it" (Me+, 2★, `A4#20315`).
  "I'm having issues finding tasks that i created that I don't use everyday." (Me+, 3★, `A4#17502`). "after the clicked
  save i couldn't find where the task went" (a task repeating on Sundays; Me+, 4★, `P4#12363`).
- **Far ahead is real in habit apps.** "Most of my important tasks that I need to track are once a year gardening
  tasks" (Me+, 2★, `P4#12225`); "I forget to change my electric toothbrush head every 3 months OR remember to get my
  flu shot every October" (Productive, 5★, `A13#15567`). Hiding them until close is resented: "unless a task is due in
  3 days it doesn't show up on the schedule at all" (My Study Life, 4★, `P111#1808`).
- **One list of everything.** "create a tab that lists all tasks" (Streaks, 4★, `A23#122`); "I really just need to see
  all tasks with all statuses" (Streaks, 3★, `A23#4544`).
- **By how often, and by kind.** "I would like to also be able to view what habits i have daily, weekly and monthly
  quickly" (Habit Tracker, 4★, `A1#51180`). HabitNow's split is praised: "I can separate my one-time tasks and
  recurring tasks and habits" (5★, `P2#4160`); Habitica's too: "the separate tabs for habits/daily tasks/one-off to-dos
  is so much easier to navigate than other apps that throw them all together in one list" (4★, `A85#321`).
- **The bottom of a long list is where things get missed.** "I have to scroll all the way down to see my one active
  long-term goal that doesn't have a due date" (Habit Slayer, 4★, `P66#16`); "if I'm working on the ones at the bottom
  of the list, it can be very inconvenient!" (Loop, 4★, `P3#12774`); the add button at "the end of the list … it's not
  as convenient if the list is long" (Finch, 5★, `A10#18725`); pages "tucked away in a menu" (Streaks, 5★, `A23#2028`).
- **But a view must never hide things silently.** "if I filter due tasks only, I miss it" (Habitica, 2★, `P8#121`);
  "The different tabs for types of task is a bit complex and easy to lose things" (Habitica, 3★, `P8#1731`).

**What it means for this page.**
1. **The user is right about both problems.** A list only by when makes people know a task's date to find it, and
   puts the rest at the end of the scroll. Habit-app reviews ask for every task in one place (27) and by how often
   (21) about as often as for later days by date (14 here, 67 in the first pass).
2. **Keep the by-when list as the main view** (people still plan tomorrow and the week), **but never as the only way
   in.** A repeating task is found by how often it repeats; any task, any date, by search (already in the top bar).
3. **The other views go at the top, always in reach**, not as rows at the end.
4. **The main view shows every open task**, so a view never hides something silently; the others are plainly named
   parts of it, and the chosen one is always marked (the 5 reviews at 2.60★).

**Revised the same day, after the user's review of version 2 (19 Oct 2026):** "it is mixing different kind of
things like a no date is a state kind of thing. Done is a completed state … repeating, it's a schedule related state.
So mixing everything together, it feels weird … and we only have very small space there." Four buttons for three
different questions (how it's planned, whether it has a day, whether it's finished) were wrong. **The views answer one
question only: how is the task planned?** Reasoned from first principles, with the review support above for one-time
apart from repeating (*by kind*, praised at 4.91★ for HabitNow and Habitica).

**Decision (version 3, approved by the user on 19 Oct 2026: "I liked the latest version … Version 3. So yeah, update it
accordingly everything"; applied to every frame of Figma's Tasks section):**
- **Two Material 3 primary tabs under the top bar, pinned while the list scrolls: One-time · Repeating.**
- **One-time**: every one-time task by when, as §8.6: Today (with carried-over ones), Tomorrow, the next days, later
  months, and **No date last**: a task without a day is still a one-time task, so it isn't a view of its own.
- **Repeating**: every repeating task once, **by how often**: *Every day*, *Every few days*, *Every week*, *Every
  month*, *Every few months or longer*; each row gives its rhythm, next day and last done (a yearly boiler service is
  here today, not only in the far months). A repeating task due today shows on Today and in this tab, never twice on
  Tasks.
- **Finished and archived are states, not kinds of task**, so they leave the page's views: the top bar's ⋮ holds
  **Select, Completed tasks, Archived tasks**, one tap from anywhere on the page, never at the end of a long list.
  *Completed tasks* is §8.3's page (one-time and repeating together, by the day done).
- **Nothing is hidden silently** (point 4 above): both tabs are always on screen and named, and between them they hold
  every open task.
- **Search** stays in the top bar and searches every task, with archived ones apart.
- **Archived, both ways (the user, 19 Oct 2026, after asking whether Habits should do the same):** *Archived tasks* is
  in the top bar's ⋮ (reach from anywhere) **and** a quiet last row of the One-time tab, *Archived · 3 tasks*, shown only
  when something is archived (found at the end without looking, with its count). The Habits page does the same: its
  last row stays and *Archived habits* joins its ⋮. *Completed tasks* stays in the ⋮ only: it's history, not something
  looked for at the end of a list, and three rows at the bottom were what felt buried.

**Tasks with no date: kept, said plainly (19 Oct 2026).** The user asked whether a task saved without a date makes
sense at all, since it never shows on Today: keep it only if there's real demand. There is, in habit apps alone: 17
habit-app reviews in the first pass ask for undated tasks and 5 in the third for a backlog to pick from, several of
them as the reason not to buy: "There's only one reason that holds me back... can't add tasks with no date" (HabitNow,
`P2#922`); "It would be great if the app supported tasks without a particular date, just like backlog/brain dump tasks
that do not show up daily unless you check the backlog." (HabitNow, 5★, `P2#6656`). No habit-app review complains
about them; the 6 that do (a new task defaulting to no date and getting lost) are to-do apps, and our new task
defaults to Today. So No date stays, and **the app says what it means**: the task form's note under Date, "Saved
without a date, it stays on the Tasks page, under No date. It won't show on Today until you give it a day."; the
preview's "It shows on the Tasks page under No date, not on Today."; and under the *No date* heading, "They stay here
and don't show on Today until you give them a day."

**Task details' History, in plain words (19 Oct 2026; the user: "Added Monday 13th October is like very confusing").**
A one-time task's History reads *Planned for Sat 18 Oct · Morning · not done yet* (or *Done Sat 18 Oct, 9:12 AM*), then
*Task created · Mon 13 Oct, 7:40 PM*; no "This task" heading. Its Notes tab is a habit's Notes (search, Add note, notes
by month), drawn as frame 10.2.

<details><summary>Version 2, replaced (its Figma frames were removed at the user's request once V3 was applied)</summary>

**Decision (19 Oct 2026, designed in Figma's Tasks section as version 2; the user's call on it is pending).**
- **Material 3 segmented buttons under the top bar, pinned while the list scrolls: All · Repeating · No date ·
  Done.** One is always chosen; *All* on opening. Material's segmented buttons are for switching views, and four fit
  side by side on a 360 dp phone, so none is ever off the screen (a row of chips would scroll and hide *Done*); the
  chosen one is filled, without a check mark, which wouldn't fit beside *Repeating*. Not tabs: tabs are separate pages
  (Habitica's are praised, and also "easy to lose things"), while these are views of one list with *All* first. This
  choice is reasoned, not settled by reviews.
- **All**: every open task, by when, exactly as §8.6 (Today with carried-over ones, Tomorrow, the next days, later
  months, No date last). The *Repeating*, *Completed* and *Archived* rows at the end go.
- **Repeating**: every repeating task once, **by how often**: *Every day*, *Every few days*, *Every week*, *Every
  month*, *Every few months or longer*; each row's line gives its next day and rhythm ("Next: Sun 19 Oct · Every 3
  days"), and a yearly task is there today, not only in the far months of *All*.
- **No date**: only the tasks without a day, with *Do today* in their ⋮.
- **Done**: what *Completed* was (§8.3): by the day done, newest first, select and delete.
- **Archived** is rare: in the top bar's ⋮ (*Select*, *Archived tasks*) and in search results.
- **Search** stays in the top bar and searches every task, with archived ones apart (the Habits page's model).
- The Habits page also keeps *Archived* as its last row; the same reach problem applies there with many habits. It
  isn't changed here (only the Tasks page was named).

</details>

---

## 10. Limits

- **What the counts measure.** Reviews mention what's missing and what goes wrong more than what works. Counts show
  strength relative to each other, not shares of users.
- **The to-do apps speak loudly.** 500 of the 1,152 come from Reminders, Google Tasks, Microsoft To Do and the Play
  Store's to-do apps, where tasks are the whole app. Lists, search and bulk actions lean on them. Habit-app users
  speak most about editing, later days and carrying over.
- **One app dominates one theme.** Me+ gives 43 of the 59 "can't edit another day" reviews. The theme is real, but its
  size is one app's rule.
- **Set aside before reading.** 724 loose habit-app matches ("helps me complete all my tasks") were excluded by a
  stricter pattern. A random 40 of them held nothing for this page (Basis), so the loss is small, but it isn't zero.
- **Frequencies are reasoned.** §3 rests on what people describe, not on measured use. Analytics after release will
  tell.
- **Native Android** is the platform's conventions, reasoned, not tested with people.
- **The third pass (§9) is habit apps only, and small:** 164 on topic. Me+ and Habitica give many of them, and a few come
  from planners that sit among the habit apps (My Study Life). Its counts show which problems recur, not how many
  people have them.
