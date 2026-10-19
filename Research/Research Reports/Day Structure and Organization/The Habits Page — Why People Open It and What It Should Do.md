# The Habits Page — Why People Open It and What It Should Do

> **Written by Claude (Claude Code)**, 18 October 2026, at the user's request (Current Work 141). Authorship of every
> report is listed in the [Research Reports index](<../README.md>).

**The question (the user's words, tidied).** The Android Habits page in Figma (`2106:2`) is out of date. It's where
every habit a person has made lives, whatever its kind, including archived ones. Before redesigning it, find out why
people come to this page and what they want to do there, the way Today was designed from what people come to Today for.
Should habits be shown by time of day or by group? What does native Android do? Research first; nothing is designed or
built until the user decides.

---

## The short answer

- **People open an all-habits page for five jobs.** In order of how many reviews raise them:
  1. find a habit and **change or remove it**;
  2. **retire a habit without losing it** (archive);
  3. **find their way around a long list** (groups, order, search);
  4. see **how all their habits are doing** at once;
  5. **set up faster** (duplicate, change several at once).
- **The biggest failure in other apps is that people can't find where to change a habit.** 342 reviews describe
  this, and they rate apps lowest of any job here (2.88★). Apps that show only today's habits leave people "digging
  through the calendar" for one that isn't due today. A list of every habit, with change one tap away, is the page's
  reason to exist.
- **Archive is wanted, praised, and done badly.** 225 reviews. People want a habit out of the way with its history
  kept. They praise archive when it works (4.70★). They complain when archived habits still remind them, still lose
  score, can't be found, lose history on restore, or still count toward a free limit.
- **Time of day or group?** Show the page **by time of day, in the person's own order, as on Today**. When groups
  exist, offer a one-tap switch to **by group**, as headed sections and never a filter that hides the rest. People ask
  for groups mostly to tame long lists (177 reviews). They also want sections they can see without filtering. And they
  are angry when an app forces a grouping they didn't choose.
- **The current design gets the skeleton right but misses most of the jobs.**
  - **Right:** sections, Paused and Archived.
  - **Missing:** rows show only a name, with no goal or schedule, so "Skincare" and "Skincare (night)" can't be told
    apart. The › chevron is the iPhone's pattern, not Android's. There's no way to change a habit without opening it,
    no search, no selection of several, and the Archived row doesn't say how many it holds.

---

## Basis

- **Screened:** all 1,487,223 reviews on 18 Oct 2026, with
  [`Habits Page Evidence/habits_page_scan.py`](<Habits Page Evidence/habits_page_scan.py>). The scan used ten screens:
  - a page of all habits;
  - a habit that can't be found;
  - archive;
  - finding edit or delete;
  - order and sorting;
  - viewing by group or time of day;
  - search;
  - several at once, and duplicating;
  - long lists;
  - overview statistics.
- **Read by hand: 2,700.** These are the matches from the App Store and Play Store habit corpora:
  - every match of the first six screens, plus long lists and several at once;
  - for search, groups, sorting and overview statistics, the matches that name a habit, a grouping or a sort.

  The native-app corpus (Reminders, Google Tasks and others) was left out: it isn't about habits.
- **On topic: 1,193**, coded by hand. A review can carry several codes. The codes are in
  [`Habits Page Evidence/review_classification.py`](<Habits Page Evidence/review_classification.py>), with a codebook.
  Every citation was checked against its `reviews.jsonl`.
- **Off topic, read and set aside (1,507):**
  - "habit list" or "manage my habits" used loosely in praise;
  - widget requests;
  - archive meaning "achieve", or the Spanish *archivo* (a file);
  - the Play corpus's to-do, student-planner and gym apps (Tasks, To Do List, Hevy), whose list wishes aren't about
    habits.
- **Citations:** `P3#2600` is line 2600 (counted from 0) of `Play Store Reviews/3. …/reviews.jsonl`; `A` is the App
  Store.
- **Scope:** counts are reviews that raise a theme, not people who want it. Many more people use these pages silently.
  The numbers show what goes wrong and what's asked for, and how strongly, relative to each other.
- **Earlier evidence used:** the Feature Ledger's C073 (reordering and editing, 35 apps), C016 (pause and archive,
  33 apps), C045 (groups, 28 apps) and C041 (editing never wipes history); the Day Structure report's 2,228 group
  reviews; and the iPhone's [Groups spec](<../../../iOS/Docs/Specs/Groups — What to Build.md>).

---

## 1. Why people open this page: five jobs

| Job | Reviews | Apps | Mean ★ | What it tells us |
|---|---:|---:|---:|---|
| **1. Find a habit and change or remove it** | **342** | 57 | **2.88** | The most painful: people give up and uninstall |
| **2. Retire a habit without losing it** (archive, pause, finished habits) | **225** | 54 | 3.93 | Wanted and praised, often done badly |
| **3. Find their way around the list** (groups, order, search, long lists) | **478** | 73 | 4.00 | The most asked, mostly by happy users who have many habits |
| **4. See how all habits are doing** | **156** | 33 | 4.10 | Mostly statistics across habits: a Progress job, not this page's |
| **5. Set up faster** (duplicate, several at once) | **80** | 23 | 3.89 | Small, cheap wins |

*Job 3 has the most reviews, but they come from contented users asking for more (4.00★). Job 1 has fewer and
the worst ratings (2.88★): that is where people leave. Design for job 1 first, then make job 3 good.*

---

## 2. Each job: what people said, and what the page should do

### Job 1. Find a habit and change or remove it (342 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| Can't find how to edit, rename or delete, though the function may exist | 111 | 3.24 |
| Editing impossible or limited (a future day, the name, the schedule) | 89 | **2.19** |
| Can't delete, or wants delete | 83 | 2.73 |
| No place that lists every habit, including those not due today | 43 | 3.35 |
| A new habit missing from the list (bugs) | 19 | 1.89 |
| Changing a habit's type | 9 | 3.78 |

**Users show:**
- **Without a list of every habit, a habit not due today can't be reached.**
  - "There's no way to locate a 'habit' to change it … You're stuck digging through the calendar to find it." (Me+,
    1★, `P4#26145`)
  - "Once you set a routine there is no way to see a master list of all of your routines." (Me+, 1★, `A4#15267`)
  - "There needs to be a profile screen to see all your habits in total." (Me+, 4★, `A4#17945`)
  - Me+ alone accounts for 103 of the 342, many of them its "focus on today" refusal to edit a future day.
- **Edit and delete are hidden behind gestures and unfamiliar icons.**
  - "Edit and delete should be as easy to find as the big plus button." (Dear Me, 1★, `P11#5753`)
  - "I actually had to do a google search to figure out how to delete a task." (Streaks, 3★, `A23#5255`)
  - "My instinct is to long press the task itself to edit it but … that triggers the task to be marked as done."
    (Streaks, 3★, `A23#4809`)

**So the page should:**
- list every habit, whether or not it's due today, and whether or not it's on Today;
- let a person change a habit from its row in one obvious step, with the words *Edit*, *Pause*, *Archive* and
  *Delete…* written out, never only an icon (our rule: actions always have text);
- tap a row to open Habit details, as everywhere else;
- never make a tap on this page log anything. This page is for managing habits, not doing them, so a tap can't mean
  "done" by mistake.
- **Changing a type is already decided** (Rulebook D6, 18 Oct): the old habit is archived, a new one starts today, and
  the app asks first. Nine reviews here back it; HabitNow's users had to delete and re-create (`P2#8162`).

### Job 2. Retire a habit without losing it (225 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| Wants archive: stop without losing history | 71 | 3.93 |
| Praises archive | 40 | **4.70** |
| Archived habits still remind, still score, reappear, or lose history on restore | 34 | 3.26 |
| Can't find archived habits or how to restore one | 32 | 4.22 |
| Wants archived habits' history still visible | 19 | 4.00 |
| Archive paid for, or archived habits count toward the free limit | 19 | 2.89 |
| Pause for a while instead | 16 | 4.06 |
| A finished habit (an end date) should leave the list | 11 | 3.73 |
| Start a habit over as a new round, keeping the old | 10 | 3.90 |

**Users show:**
- **Why people retire a habit:**
  - it became automatic: "now fully ingrained … so I archived them" (Streaks, 5★, `A23#4965`);
  - it's seasonal: vitamins in autumn and spring (Way of Life, `A76#4237`), "bird feeder cleanings can be hidden off
    season" (Days Since, `A3#6400`);
  - it ended: a 30-day challenge, or a course;
  - it's too much for a hard stretch: archiving "habits that are just impossible for me" during depression (Habit
    Tracker, 5★, `A1#2088`).
- **Deleting is the only alternative, and it costs the history.** "The only way to remove a habit from view is to
  delete it, but that results in losing all its data." (Habit Rabbit, 4★, `A28#619`)
- **Archive done badly undoes its point:**
  - "I still get notifications for habits I've archived." (Loop, `P3#13415`)
  - "when you archive a habit and restore it, you lose all your history" (Grit, `A25#1163`)
  - "I accidentally put one of my favorite habits in the archive. And I can't find how to retrieve it." (Habit
    Tracker, `A1#235`)
  - "why an archived or 'completed' habit would exist for that 2 [free habits]" (Not Boring, `A36#321`)

**So the page should:**
- keep **Archived** at the end of the list as a row that says how many it holds (*Archived · 3*). It opens
  *Archived habits*: each habit with when it was archived, its whole history openable, **Restore**, and
  **Delete…**;
- make an archived habit go quiet everywhere: no reminders, no widget, no score or streak that keeps falling, and no
  place among the free five. Restoring it brings back everything it had;
- keep **Paused** (back on a date) separate from **Archived** (stopped until brought back). They are different
  promises, and people asked for both.

### Job 3. Find their way around the list (478 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| See habits **by group** (area, category, folder, routine) | **177** | 4.25 |
| A sort (by time, name, score, streak, colour) | 95 | 3.94 |
| Their own order | 82 | 3.83 |
| A long list is hard to scan or manage | 65 | 3.95 |
| See habits **by time of day** | **60** | 3.98 |
| More habits on one screen (smaller rows) | 33 | 3.88 |
| Search | 29 | 4.24 |
| Filter (tag, category, day) | 26 | 4.27 |
| Their own order lost or jumbled | 24 | **2.50** |
| Praise for reordering or sort options | 20 | 4.85 |
| **Angry at a grouping the app forced on them** | 4 | **1.50** |

**Users show:**
- **Groups are asked for to tame a long list, and seen as sections, not as a filter.** Of the 177 reviews:
  - 125 name areas of life (health, work, school);
  - 34 ask for sections or headers, 33 to fold sections, 23 for folders and 22 for tabs or pages. Only 18 ask for a
    filter.
  - Two quotes:
    - "sorting based on groups when seeing all habits without completely removing the rest from the screen" (Habit
      Tracker, 5★, `A1#46210`)
    - "separate sections, like morning afternoon evening, or before/after work, and for this to be visible without
      having to filter" (Habit Pixel, 4★, `P14#95`)
- **Time of day is wanted on the list itself.**
  - "I prefer to see all habbits in the same page … sorted by hour and organize by period (morning, afternoon,
    evening)" (Streaks, 3★, `A23#639`)
  - "being able to see on the main habit list page which habits are assigned to morning vs evening vs all day"
    (Habit Tracker, 5★, `A1#52161`)
- **People want both views.** 22 reviews ask for groups *and* time of day.
- **A grouping the app chooses is resented.** When Done split everyone's list into daily and weekly sections:
  - "Now they're forced into separate daily and weekly categories and it ruins the whole flow for me." (1★,
    `A31#3248`)
  - "Adding settings to allow to pick your view would be helpful." (2★, `A31#3231`)
- **Order matters and must stay put.** Most sort requests are chronological. Order lost or jumbled is the
  worst-rated theme in this job (2.50★, 24 reviews). The Feature Ledger's C073 found the same across 35 apps.
- **Search matters to people with many habits.**
  - "i have more than 100-200 habits in list" (Loop, `P3#6757`)
  - "3+ years later and the search function hasn't still been added, so I'm removing 1 star" (Loop, 4★, `P3#2065`)

**So the page should:**
- show habits **by time of day, in the person's own order, exactly as Today** (one order everywhere: Rulebook U13;
  done habits don't sink here, since this page isn't for the day). It then reads like Today with nothing hidden: what
  isn't due today is here too;
- when the person has groups, add a **Show by: Time of day · Group** switch. *Group* shows one headed section per
  group, in the groups' own order, then *No group*. Both views show every habit. Neither is a filter;
- never invent a grouping the person didn't make (no daily/weekly split);
- **Search** (Material's search bar), so a habit can be found by name;
- **Order** is changed in one place, Arrange (Today's), reached from here too. Sorting stays a one-off action (U13),
  not a mode that overrides the person's order.

### Job 4. See how all habits are doing (156 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| Statistics for all habits together | 107 | 4.14 |
| A small fact on each row (streak, %, the week) | 19 | 4.32 |
| A calendar of all habits | 19 | 4.11 |
| How often or the reminder time shown on the row | 5 | 3.80 |

**Reasoned from first principles:**
- Statistics across habits is **Progress's job**, and Progress already does it (overview, per-habit cards, groups).
- Putting streaks and percentages on this page would make it a second Progress, and a crowded list.
- **What each row does need** is enough to tell habits apart and know what each one is: its **goal and how often**
  ("8 glasses · Every day", "3 times a week", "Mon, Wed, Fri · 6:30 PM"), and a status only when there is one
  (*Paused · back 20 Oct*, *Ends 30 Nov*).
  - "Show the time and days for each habit in the habit list; I have to click on the habit to see the reminder time
    and Edit to see the day(s)" (Loop, 3★, `P3#6444`)

### Job 5. Set up faster (80 reviews)

| Theme | Reviews | Mean ★ |
|---|---:|---:|
| Duplicate a habit or routine | 55 | 3.95 |
| Select several and delete, pause, move or archive at once | 27 | 3.78 |

**Users show:**
- **Duplicate:** "you can't duplicate a habit, so if you've got a bunch of similar ones, get ready to type 'em all out
  manually" (Habit Tracker, 2★, `A1#46473`).
- **Several at once:** "my daughter decided to put 144 goals on there. We have been trying to delete them for days"
  (Finch, `A10#479`).

**So the page should:**
- offer **Duplicate** in each habit's menu: it opens the habit form filled in, named "… (copy)";
- let a long press select a row and then others, the way Android does, with **Archive**, **Pause**, **Move to
  group** and **Delete…** for all of them.

---

## 3. Time of day or group: the direct answer

**By time of day by default, with a switch to group once groups exist.** Five reasons:

1. **It's where people already look** (reasoned).
   - Today is arranged by time of day, in the person's order, and they find their habits there every day.
   - The same arrangement here means a habit is exactly where they expect, plus the ones not due today.
2. **Groups are optional and most people have none** (the Groups spec: no preset groups, nothing until the first
   one).
   - A page organised by group would be one long *No group* section for most people.
3. **When groups exist, people want them as visible sections** (users show: 75 of 177 name sections, headers,
   folders, folding or pages, against 18 that ask for a filter).
   - So *by group* is a view of the whole list, not a filter.
4. **People resent views chosen for them** (users show: Done, 1–2★).
   - The person picks; the page remembers their choice.
5. **It agrees with what the iPhone already decided.**
   - The iPhone's Groups spec says the Habits page shows "one section per group … then No Group" when groups exist.
   - The switch keeps that view and adds time of day as the starting one.

*Quitting* stays its own section in both views, as on Today. A quit habit has no time of day, and its job differs.

---

## 4. The current design, item by item (Figma `2106:3`)

| What it has | Verdict | Why |
|---|---|---|
| Sections by time of day, with times ("Morning · 6 AM – 12 PM") | **Keep** the sections; consider dropping the times | The order is right; the times repeat Today and Settings |
| Rows: icon, name, › | **Change** | No goal or schedule, so habits can't be told apart (two *Skincare*, two *Water*-like rows); › is the iPhone's sign for "opens a page", while Android lists don't use one |
| *Study* shows "Mon, Wed, Fri" but no other row shows how often | **Change** | Every row should say its goal and how often |
| Quitting section | **Keep** | As on Today |
| Paused section with "Back on 20 Oct" | **Keep**, add Resume | Paused is a different promise from archived |
| Archived row at the end | **Keep**, add the count | People can't find archives (32 reviews); a count says it holds something |
| + in the top bar | **Keep** if Today does the same | One way to add, everywhere |
| No search | **Add** | 29 ask outright; 65 struggle with long lists |
| No way to change a habit from the list | **Add** the row's ⋮ menu | The most painful job (342 reviews, 2.88★) |
| No way to select several | **Add** the long press | 27 ask; native Android behaviour |
| Group view | **Add** the switch | 177 ask; none of them should lose the rest of the list |
| How was today | **Leave out** | Future work, not in the first release (A22) |
| Tasks | **Leave out** | They have their own page (Tasks, in the menu) |

---

## 5. How native Android does it (reasoned, not review evidence)

What follows describes the platform's conventions, so that the page feels like part of the phone. It isn't evidence
that people want it; where the reviews above agree, that's said.

- **Lists:** Material 3 rows are a leading icon, a headline, one or two lines of supporting text, and a trailing
  element (text, an icon button, a switch).
  - Android 16's Material 3 Expressive groups related rows into rounded "segmented" blocks with small gaps, as in the
    phone's own Settings. The current Figma page already uses this, and it suits a list of sections.
  - The Compose API for segmented items is still being finalised (`SegmentedListItem`, `segmentedShapes`), so the
    build should check the release before relying on its names
    ([Compose Material 3 package](https://developer.android.com/reference/kotlin/androidx/compose/material3/package-summary),
    [Expressive lists in Compose](https://proandroiddev.com/beyond-flat-lists-build-expressive-material-3-lists-in-compose-65e6f8f355fb)).
- **Trailing ›:** Google's own lists (Settings, Contacts, Keep, Files) open a row by tapping it and don't draw a
  chevron. A ⋮ icon button at the end of a row is the usual way to reach that item's actions (Drive, Files). That
  matches job 1's need for a visible way to change a habit.
- **Search:** Google's list-heavy apps put search at the top (Gmail, Contacts, Keep, Files), opening a full search view.
- **Selecting several:** a long press starts selection; the top bar turns into a selection bar with the count and the
  actions (Keep, Gmail, Photos)
  ([Keep: organise your notes](https://support.google.com/keep/answer/6191044)).
- **Archive:** Keep and Gmail take an item off the main list and keep it in an *Archive* place, from the menu. Restoring
  is one action (Keep: Menu › Archive). Our drawer rows are fixed (Habits, Tasks, …), so *Archived* stays at the end of
  the Habits page, where the reviews say people look for it.
- **Group switch:** Material's connected button group (as Progress uses for Week · Month · Year) or a single choice
  in the top bar's ⋮ ("Show by").

---

## 6. The page this suggests (a description, not a design)

**Top bar:** ☰ · *Habits* · search · + · ⋮

- The ⋮ holds *Show by* (once groups exist), *Arrange*, *Edit groups* and *Archived habits*.

**List,** in the person's order:
- **By time of day:** Morning, Afternoon, Evening, Anytime (each of the person's own times of day), then
  **Quitting**, then **Paused**.
- **By group:** each group, then *No group*, then Paused. Quit habits sit in their group, each marked *Quit* in its
  line.
- **Each row:**
  - the habit's icon on its colour;
  - the name;
  - one line: goal and how often ("8 glasses · Every day", "10 min · Mon, Wed, Fri", "Under 2 cups a day");
  - a status only when there is one (*Paused · back 20 Oct*, *Ends 30 Nov*);
  - ⋮ at the end, with **Edit**, **Duplicate**, **Pause** (or *Resume*), **Archive** and **Delete…**.
- **Tap a row:** Habit details. **Long press:** selection, with Archive, Pause, Move to group and Delete… for the
  selection.
- **At the end:** *Archived · 3* ›, opening Archived habits.

**Archived habits** (its own page):
- each habit with "Archived 3 Sep";
- tap for its details and whole history;
- ⋮ with **Restore** and **Delete…**;
- a line saying archived habits keep their history, send no reminders, and don't count toward the free five.

**States to draw:**
- no habits yet;
- one or two habits;
- many habits (search earns its place);
- with groups, in both views;
- something paused;
- nothing archived (no Archived row);
- a search with no match;
- selection.

---

## 7. Decisions for the user

> **Decided by the user, 18 Oct 2026:**
> 1. time of day by default, with *Show by: Group* once groups exist;
> 2. tap a row for Habit details, and its ⋮ for Edit, Duplicate, Pause, Archive and Delete…;
> 3. search is always in the top bar;
> 4. add Duplicate;
> 5. no times beside section names;
> 6. no free-plan count on the page (the line about the free five sits on Archived habits only).
>
> Placeholders for every screen and state are in Figma `2106:2` (Current Work 141).

1. **Default view:** time of day, with a *Show by: Group* switch once groups exist (recommended); or group sections
   always when groups exist (the iPhone spec as written); or time of day only.
2. **The row's ⋮ menu** (recommended, for job 1), or tap-only rows with every action inside Habit details.
3. **Search:** an icon in the top bar always (recommended, as Google's apps do); or only once there are more than
   about ten habits.
4. **Duplicate:** add it (55 reviews; recommended) or leave it for later.
5. **The times beside section names** ("6 AM – 12 PM"): drop them here (recommended) or keep them as on Today.
6. **A free-plan count** at the top of the list ("4 of 5 free habits") or not. The menu already shows *Habits 15*.

---

## 8. Limits

- **What the counts measure:** reviews mention what goes wrong and what's missing more than what works. So the
  satisfied majority who find their habits fine is unseen, and counts show strength relative to each other, not the
  share of users.
- **Screens miss some reviews.** Keyword screens miss reviews that describe a problem in other words. For archive,
  edit and delete, the earlier Feature Ledger cards (C016, C041, C073), built from whole-app readings, point the same
  way.
- **Other job, same matches.** Several themes (group, sort, order) also apply to Today's list. They are counted here
  because a review asking to "see my habits by category" doesn't say which screen. The conclusion on groups is
  therefore about how people want their habits arranged in general. It agrees with the Today research.
- **Not yet checked by people:** the native-Android section is the platform's conventions, reasoned, not tested with
  users.
