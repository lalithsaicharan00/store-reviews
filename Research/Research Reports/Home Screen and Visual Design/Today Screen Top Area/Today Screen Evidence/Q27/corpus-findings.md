# Arranging Today: Order, Group Filter and Finding Section Editing (Corpus Findings)

> Written by Claude (Claude Code), 3 October 2026. Scratch research for the Today screen, not a decision. Decisions live in Notion.

**The three design questions.**
1. How should people filter Today by group?
2. How do people find out that they can edit, add or remove times of day?
3. How should habits be ordered inside a time of day? (The current rule: habits with a reminder time sort by that time, and the rest follow in a saved order.)

**Evidence type.** Everything below is review evidence ("users show…"), except where a line says "reasoned from first principles".

**Citations.** `A` = App Store, `P` = Play Store, `N` = native corpus, then the app folder number, `#`, and the 0-based line in that folder's `reviews.jsonl`. This is the same format as the Today Screen reports. Every cited ID and every quote in this file was checked against the corpus by `verify.py`.

---

## 1. Method

**Corpus.**
- Screened: all **1,487,223** reviews in `App Store Reviews/`, `Play Store Reviews/` and `Native Store Reviews/`. Script: `screen.py`.
- Three tiers:
  - **Habit tier, 876,387 reviews:** every App Store habit app, plus the Play habit apps. This is the same split as the Day Structure study's `refine.py`.
  - **To-do / list tier, 422,166:** Play's to-do and planner apps (folders 84, 85, 95, 97, 100, 111, 121, 126, 129), plus the native Reminders, Microsoft To Do, Google Tasks, Google Keep and Notes.
  - **Other, 188,670:** gym, food delivery, video calls, skincare, calendar, health and sheets.

**Patterns.** Multilingual regexes, so that English, Spanish, Portuguese, German, French, Italian, Russian, Japanese, Korean, Chinese, Turkish, Arabic, Indonesian and Hindi transliteration all match. The full patterns are in `screen.py`. There are four families:
- **ORDER:** reorder, rearrange, re-sort, drag and drop, move up or down, custom, manual or own order, sort or sorting (excluding "sort of" and "sort out"), alphabetical or A–Z, "order of my habits", "in the order I…", random or wrong order, jump around, shuffle, "goes to the bottom or top". Plus non-English equivalents: reordenar, ordem, Reihenfolge, sortieren, ordre, trier, riordinare, порядок, сортировка, 並び替え, 順番, 순서, 정렬, 排序, 顺序, sıralama, ترتيب, and others.
- **ORDCHG** (a subset of ORDER): the order changes by itself, resets or isn't kept; "can't, unable, wish I could, no way to" reorder, sort or drag; random order; completed items move; new items land at the top or bottom.
- **DISC:** a findability phrase within a short window of an edit verb and an object.
  - Findability phrases: can't find, couldn't figure out, didn't know, took me…, hidden, buried, not obvious, where is, how do I, by accident, long press, no way to, can't delete.
  - Edit verbs: edit, rename, delete, remove, add, create, change, customise, manage.
  - Objects: section, category, group, folder, list, area, tag, label, time of day, morning, afternoon, evening, anytime.
  - The same idea is written out for the other languages.
- **FILTER:** filter, show only or only show, view or see only, view by category, focus on one category, tabs per category, hide completed, completed items disappear. Non-English equivalents include filtrar, ausblenden, masquer, фильтр, 筛选, 隐藏, フィルター, 絞り込み and 필터. Photo, water and spam filters are excluded.

**Screen hits** (a review can hit several families):

| Family | Habit tier | To-do tier | Other |
|---|---|---|---|
| ORDER | 4,501 (3,124 also match the stricter ordering phrases in `sample.py`) | 5,173 | 1,146 |
| ORDCHG | 336 | 373 | 84 |
| DISC | 192 | 357 | 32 |
| FILTER | 917 | 911 | 929 |

**Keyword floors inside the hit sets** (from `floors.py`, mostly English sub-patterns). These are counts of reviews that mention a phrase. They have not been read by hand.

| Sub-pattern | Habit | To-do | Other |
|---|---|---|---|
| ORDER: drag, manual, own or custom order, reorder, rearrange | 882 | 960 | 215 |
| ORDER: can't reorder, sort or drag | 151 | 123 | 27 |
| ORDER: by time, chronological | 110 | 53 | 13 |
| ORDER: priority or importance | 89 | 344 | 11 |
| ORDER: alphabetical or A–Z | 68 | 384 | 47 |
| ORDER: order changes by itself | 61 | 76 | 38 |
| ORDER: new item position | 18 | 51 | 1 |
| ORDER: completed go to the bottom | 14 | 47 | 0 |
| ORDER: by reminder or notification time | 13 | 35 | 1 |
| FILTER: filter by group, category or tag | 90 | 190 | 56 |
| FILTER: hide completed | 42 | 76 | 5 |
| FILTER: filter by time of day | 9 | 0 | 0 |

The to-do tier talks about alphabetical (384) and priority (344) order far more than habit apps do. In habit apps, *time* (110) outranks alphabetical (68), and "by reminder time" is rare (13).

**Hand reading.**
- **483 habit-tier reviews**, each read in full in its original language and hand-coded. Of these, 298 were 1–3★ and 185 were 4–5★.
- Drawn from seeded random samples (`sample.py`, seed 20261003; `sample2.py`, seed 20261004), weighted towards 1–3★.

| Draw | Read | On theme | Pool it came from |
|---|---|---|---|
| ORDER | 160 | 125 (78%) | 3,124 strict ORDER hits |
| ORDCHG | 65 | 54 (83%) | 336 |
| ORDREM (*targeted*: ORDER hits that also name a reminder, time or part of the day) | 30 | 29 | 434 |
| DISC | 70 | 37 (53%) | 192 |
| DISC2 (*targeted*: names a group, category, tag or section object) | 38 | 22 | 106 |
| FILTER | 70 | 26 (37%) | 917 |
| FILTER2 (*targeted*: filter near a group or time word, hide completed, show only) | 50 | 43 | 228 |

**What each code records.**
- The person's expectation (their mental model), what went wrong or right, and the exact request.
- ORDER reviews are also coded for **what order they want**, and whether they mention reminders.

**Files.**
- `coding.jsonl`: one row per read review, with the codes and the note.
- `stats.json`: the counts.
- The codebook is at the end of this file.

**Shares below.**
- For ORDER, percentages use the **179 on-theme reviews from the two random draws** (ORDER + ORDCHG; 46 apps; mean 3.06★). The targeted ORDREM draw is reported separately, because it over-samples time and reminder talk.
- The theme totals that include every draw are: ORDER 226 (51 apps, mean 3.05★), DISC 67 (26 apps, mean 2.79★), FILTER 77 (27 apps, mean 3.44★).

**Overlap with earlier work.**
- 39 of the 226 ORDER reviews were already in the Day Structure coding (24 of them coded TO). The other 187 are new evidence.
- For DISC, 23 of 67 were already coded there; for FILTER, 30 of 77.

---

## 2. What the earlier studies already established (reused, not redone)

**Day Structure whole-corpus coding.** 8,439 habit-tier hits, 5,438 coded relevant. Source: [Habit Tracker — Day Structure Whole-Corpus Verification](<../../Research Reports/Day Structure and Organization/Habit Tracker — Day Structure Whole-Corpus Verification.md>), with its coding in `Day Structure Evidence/Whole-Corpus Coding/`.

- **(c) Ordering inside sections.**
  - Manual ordering of habits (code TO) appears in **291 of 5,066** habit-context reviews (5.7%), from 42 listings. Mean 3.86★, and 41 of the 291 are 1–2★.
  - Examples:
    - wants to reorder habits within each period `A2#251`;
    - "I don’t see the point in creating routines like morning/ night if you can’t keep them in a certain order" `A4#6959`;
    - wants routines ordered by time slot or manually `A18#675`.
  - The report did **not** split TO by *which* order people want. That split is the new work in section 3.
  - **Sections themselves:** manual reordering of *sections* has "almost no demand". Sections that carry a start time should sort themselves by it (rated Average).
- **(a) Editing sections and groups.**
  - **TC, wants to customise sections: 125** (7.9% of 1,574 section reviews). Hand sub-types: more or different sections (MO) 47, boundaries (BD) 28, day start (DS) 20, shift work (SH) 13, **rename (RN) 9**, turn a section off (OF) 3. These are from `customisation-subtypes.txt`.
  - Section friction (TF, 248): "forced to assign a section, or cannot turn one off" 18.
  - **Group friction (GF, 474), keyword floors:** cannot edit, delete or rename groups **110** (23.2%); group order 70 (14.8%).
  - Examples:
    - tags can't be edited or deleted, so a misnamed tag is stuck forever `P4#74774`;
    - untagged tasks can't be found `P38#2072`.
- **(b) Filtering by group.**
  - **GL, use or want filter, tab or list switching by group: 260** (11.7% of 2,228 group reviews). That beats **GV, visible group headers: 158**.
  - Only 8 reviews criticise filter-only designs.
  - Examples:
    - tags let you "zoom in" on what is relevant `A76#2240`;
    - custom filters separate the day `P2#5650`;
    - a label bar to switch categories `P3#2090`;
    - grouped headers wanted instead of a filter `P19#40`;
    - colour instead of filters `A31#4904`.
  - **Filter risk:** "All" didn't show all, and some tags were missing from the main screen `P4#98867`.
  - The report's conclusion: groups as a filter on Home, never hiding habits by accident.

**Today Screen Top Area study** (same citation format; [Today Screen Evidence](<../../Research Reports/Home Screen and Visual Design/Today Screen Top Area/Today Screen Evidence/>)):
- **Question 8:** 174 of 286 relevant reviews couldn't find how to edit, delete or rearrange something. 18 couldn't find section, time-of-day or day-start settings (15 of them from Me+ and Fabulous). 21 asked to reorder by hand (REORDERW). Long press: 9 want it for drag-reorder; 16 complain that press-and-hold controls are hidden.
- **Question 24:** groups should default to **A–Z with drag to reorder**, and never sort by count. Based on 6 manual and 2 alphabetical requests.
- **Q4–Q6 codes:** FILTW 34, FILT+ 9, FILT− 10, HIDEDONE 71, SHOWDONE 36.

---

## 3. ORDER: how people want habits ordered (the main new evidence)

### 3.1 Counts

Base: **179** on-theme reviews from the random draws. A review can carry several codes.

**What goes wrong:**

| Problem | n | % |
|---|---|---|
| No way to reorder at all | 76 | 42% |
| Reorder exists but is clumsy or buggy (drag misses, snaps back, crashes, too many steps) | 37 | 21% |
| **The order changes by itself, or isn't kept** | 35 | 20% |
| Couldn't find how to reorder | 5 | 3% |
| Praise for being able to arrange | 13 | 7% |

144 of 179 (80%) report a problem of some kind.

**Which order they want:**

| Wanted order | n | % |
|---|---|---|
| **Their own order, set by hand** (drag, "the order I want") | 60 | 34% |
| **The order they do things in the day** (routine sequence, start-to-end of day) | 19 | 11% |
| *Own order or order of doing, combined* | **72** | **40%** |
| By time of day or scheduled time | 24 | 13% |
| ↳ of which **by reminder time** explicitly | 2 | 1% |
| Wants a choice of sort modes | 16 | 9% |
| Priority or importance | 7 | 4% |
| Other sorts (score, streak, check-in count, category) | 7 | 4% |
| Alphabetical as a want | 1 | 1% |
| Alphabetical, complained about when imposed | 3 | 2% |
| Where new habits land (top, bottom, creation order) | 12 | 7% |
| Completed go to the bottom: want it | 6 | 3% |
| Completed go to the bottom: want them to stay put | 3 | 2% |
| Undone first | 2 | 1% |
| Order of sub-steps or checklist items | 8 | 4% |
| Order on a future day | 5 | 3% |

**Time versus hand order:**
- 25 want time order; 72 want own or doing order. **11 ask for both**: sort by time, *and* let me move things.
- Only **28 of 179 (16%)** mention reminders or notifications anywhere in the review.
- **60 of the 72** who want their own order or doing order never mention reminders at all.

**App concentration** (all ORDER reviews, n = 226):
- Me+ 36, HabitNow 23, Habitica (Play) 20, ShineDay 13, Productive 11, MyRoutine 9. Across 51 apps.
- "Order changes by itself" is concentrated: Me+ supplies 16 of 44.

**Targeted ORDREM draw.** 29 on-theme reviews that mention a reminder, a time or a part of the day:
- 14 want their own drag order, 10 want time order, and 6 want both.
- Only 2 ask for reminder-time order: `P37#843`, `P10#8113`.
- 6 talk about order *inside* morning, afternoon or evening.

### 3.2 What default order people expect (the mental model)

**1. "The list stays the way I put it."**
- The dominant complaint is not "the wrong sort rule". It is "the app moves my things".
- 35 of 179 (20%) say the order changes by itself:
  - after a day rolls over or items are completed;
  - after a sync with a Watch or the web;
  - after a refresh;
  - or a drag snaps back.
- People describe redoing the order **every day**. Several leave or ask for refunds over it.

**2. Their order is the order of their day.**
- When people say *which* order, it is the sequence they do things in. They describe it as "from the start till the end of my day", "the order I want to tackle them", "by what time of day I usually complete them".
- That is a sequence in the day, **not** a clock time they want to enter.

**3. A new habit should land where it belongs, not at the end.**
- 17 reviews (all draws) complain about where a new or edited item lands:
  - at the bottom (`A13#1876`, `P10#12194`, `A10#40142`, `P10#197`);
  - at the top (`P4#22527`, `A31#2605`);
  - "in order by creation" (`A54#295`, `P10#8113`, `P98#1917`, `P3#23224`).
- Creation order is never what anyone wants.

**4. Time order is wanted mainly when items have times.**
- The 24 time-order requests come mostly from people who *do* set times: "I add things by time (8am, 10am, etc)" `P4#22527`.
- Some come from apps whose sections contradict the clock: afternoon stacking above morning `P8#1851`.
- When an app removed times and forced manual dragging every day, one user cancelled `A10#27187`.
- So time order helps people with times. It is no substitute for hand order.

**5. People without reminders want hand order and nothing else.**
- Only 2 reviews say it outright (`A43#244`, `P11#11668`). Both want drag order **without** having to set a time.
- But 60 of the 72 own-order or doing-order requesters never mention reminders. Their model has no reminder in it at all.

**6. Inside a time of day, the same rules apply.**
- 17 ORDER reviews are about order *within* morning, afternoon or evening sections. Examples: `A43#244`, `P10#12194`, `A54#295`, `P8#4906`, `A13#16339`, `A4#18715`.
- They want to arrange habits inside the section, and are frustrated when the section shows creation order or a scrambled order.

**7. Completed habits moving is split.**
- Across all draws, 7 want completed items to sink so the next task is visible (`P9#33`, `A4#7642`, `A4#4041`; Me+ users dominate).
- 4 want them to stay where they are, because moving makes them hunt for the item or breaks their arrangement (`A1#55984`, `P2#9454`, `A4#6735`, `A4#18715`).
- 2 want undone items on top.
- *Reasoned from first principles:* a tap that moves the row breaks the rule that nothing on Today moves during a run of taps (Rulebook U4). Hiding completed habits (section 5) serves the "see what's next" need without moving rows.

### 3.3 Quotes (verified)

**Own order, set by hand, with no reminders:**
- "I don’t always do things at the same time of day BUT I like to do them in a certain order. Even if I choose morning, afternoon, or evening, I can’t change the order." `A43#244` (Habit Hub, 3★)
- "Seria bom se a gente pudesse organizar a ordem da lista (arrastando) sem precisar colocar horário." `P11#11668` (Dear Me, 4★)
  - *It would be good if we could arrange the list order (by dragging) without having to set a time.*
- "I also really would benefit from manual sorting as I do things in a specific order and trying to alphabetize stuff is exhausting." `P2#3768` (HabitNow, 5★)

**The order of the day, and where new items land:**
- "if i want to put everything in order from the start till the end of my day i have to add things backwards." `A25#346` (Grit, 3★)
- "I have 10 tasks at morning, if I want to add a task at the beginning of the day from today I can't, it'll be only on the last." `P10#12194` (Habit Diary, 2★)
- "currently the habits in each section stay in order by creation." `A54#295` (Avocation, 5★). The same reviewer asks to sort "by specific time, type of habit or importance or to be able to drag the habit bubbles to be in a custom desired order."
- "if i add a task for afternoon it stacks above morning instead of in timely order. neither I can manually change it." `P8#1851` (Habitica, 3★)

**Order by time or reminder (the minority):**
- "on the 'Today' page, habits are sorted by creation time by default. It would be fantastic if there were options to sort them by reminder time, importance, or other customizable parameters." `P10#8113` (Habit Diary, 4★)
- "我手动排序很久，一打开就又乱了。建议以提醒时间的先后顺序确认打卡项的顺序。" `A52#12749` (ShineDay, 3★)
  - *I spent ages sorting by hand; open the app and it's scrambled again. Suggest ordering by reminder time.*
  - Here, reminder order is suggested as a fix for a hand order that won't stay put.
- "manually drag reorder every single task individually into the order I want to tackle them EVERY SINGLE DAY" `A10#27187` (Finch, 1★, cancelled after times were removed)

**The order changes by itself:**
- "I wish it kept my tasks in the order I sort them in, finch loves mixing them up and then they’re not organized by what time of day I usually complete them. Please stop moving my tasks." `A10#3549` (Finch, 3★)
- "Can't change the order of the tasks and have that order stay, the order changes randomly as I go from one day to the next." `P4#28423` (Me+, 1★)
- "TODO DIA preciso reordenar a ordem das minhas tarefas pra que fique na ordem certa porque todo dia o app bagunça a ordem delas" `A4#1500` (Me+, 3★)
  - *Every day I have to reorder my tasks to get the right order, because every day the app scrambles them.*
- "Even when I change the order for my morning activities, it goes out of order the next day." `A4#18715` (Me+, 4★). The same reviewer then missed checking off items that ended up at the bottom.
- "왜 순서를 바꿔놓아도 잠시 기다리면 제자리로 돌아가버리나요" `P20#3302` (MyRoutine, 2★)
  - *Why does the order go back to where it was if I wait a moment after changing it?*

**Completed habits moving:**
- "I would like the habits to remain in the place I have them instead of jumping to the bottom when completed." `A1#55984` (Habit Tracker, 5★)
- "The second tap is frustrating because the item got rearranged in the list and I have to find it again" `P2#9454` (HabitNow, 3★)
- "it was way more convenient when the completed tasks have been moved down, so I could see my current task for the rest of the day." `A4#7642` (Me+, 4★)

**Praise:**
- "The way that you can make your OWN routine, and quickly rearrange the order or add another task if you have a different day, is absolutely amazing." `A5#471` (Routinery, 5★)
- "I love that you can make your own habits, add notes to them, and order them how you want, with your day being divided into morning, afternoon and evening so you can see everything clearly." `A13#16339` (Productive, 3★)

### 3.4 What this means for "sort by reminder time" (the product owner's question)

- **Users show** that reminder-time order is almost never what people ask for: 2 of 179 random ORDER reviews (1%), and 4 of 226 across all draws.
- **Users show** that time order of any kind is a minority request: 24 of 179 (13%).
- **Users show** that hand order, or the order they do things, is the majority: 72 of 179 (40%). A stable order is the biggest complaint: 35 of 179 (20%).
- **Users show** that most people asking for an order don't talk about reminders at all (151 of 179 don't mention them).
- This supports the product owner's view: sorting by reminder time is a poor *default*.
- *Reasoned from first principles:* a rule that sorts *some* habits by reminder and the rest by saved order makes a habit jump when someone adds or removes a reminder. That is the same "it moved by itself" the reviews complain about.

---

## 4. DISC: finding how to edit, add or remove sections, groups and tags

**Base:** 67 on-theme reviews (DISC 37 + DISC2 22, plus 8 from other draws). 26 apps, mean 2.79★, 47 of them 1–3★.

| Code | n | Of which: groups, categories, tags | Of which: sections, time of day, routines |
|---|---|---|---|
| Couldn't find how, or didn't know it existed | 40 | 15 | 10 |
| The function doesn't exist (can't delete or rename a tag, can't remove a section) | 21 | 10 | 11 |
| Behind a paywall | 2 | 1 | 1 |
| Found it late or by accident | 2 | | 2 |

The remaining "couldn't find" reviews are about habits themselves (8) or are general (7).

**App concentration:**
- Me+ 15, Habitica 10 (both stores), Fabulous 12 (both stores).
- Habit Tracker (App Store folder 1) has **5 separate reviews asking how to delete or rename a group or tag**: `A1#50103`, `A1#45221`, `A1#50556`, `A1#51060`, `A1#56041`. That is a single app whose group editor people repeatedly fail to find.

**The mental model.**
- People expect to change a group or section **where they see it**: on the chip, the tag, or the section itself.
- When a filter shows tags but offers no way to make or edit them there, they are stuck. "There's an option to filter on tags, but no obvious way to add tags." `P8#9946`
- For sections, the complaint is the same: they can see "morning, afternoon, evening" but can't find how to add to them, remove one, or change what they hold.
- Requests are phrased as questions: "how do I…", "where…".

**What goes wrong.**
- **No edit or delete, so a mistake is permanent.** A misspelled tag stays; an accidentally created group can't be deleted (`P70#1324`, `P8#9401`, `A10#25112`).
- **The editor exists but nobody finds it.** The repeated "how to delete a group" questions in one app show this.
- **Section structure arrives preset, with no visible way to change it.** Examples: Fabulous's morning, afternoon and evening routines (`A24#840`, `A24#38347`, `P26#20`); habits that must go into the morning (`P12#20144`).
- **Some people only discovered it by poking around.** "I was about to delete the app until i started to look into the journeys and tried to edit my morning routine when i realised that there is a lot i did not know about." `P12#12744`

**Quotes (verified):**
- "I don’t know where to delete a group" `A1#45221` (Habit Tracker, 3★)
- "i dont know how to delete the groups" `A1#50103` (Habit Tracker, 4★, review title)
- "There's an option to filter on tags, but no obvious way to add tags. ??" `P8#9946` (Habitica, 3★)
- "would like to know how to add more tags. Had to delete account and start again to add tags." `A85#1043` (Habitica, 4★)
- "The only thing I can’t figure out is how to add to the afternoon and evening lists if I want to." `A24#38347` (Fabulous, 5★)
- "There is no way to remove an afternoon routine given I already have an evening routine." `A24#840` (Fabulous, 3★)
- "I misspelled a tag and could not find a way to fix that." `A10#25112` (Finch, 1★)

**What this adds to earlier work.**
- Question 8 counted findability for editing in general, and Day Structure counted GF "can't edit, delete or rename groups" (110, keyword floor).
- This sample shows the split. For **groups**, "couldn't find" (15) outnumbers "didn't exist" (10). For **sections**, it is about even (10 couldn't find, 11 didn't exist, 2 found it late).
- The usual moment of failure is **standing on the filter or the section and finding no Edit or Add there**.

---

## 5. FILTER: filtering by group, and hiding completed habits

**Base:** 77 on-theme reviews (FILTER 26 + FILTER2 43, plus 8 from other draws). 27 apps, mean 3.44★, 37 of them 1–3★. FILTER2 is a targeted draw, so shares describe the read set, not the corpus.

| Code | n | % of 77 |
|---|---|---|
| Wants completed habits hidden ("hide completed") | 23 | 30% |
| Wants to filter, or have tabs, by group, tag or folder | 19 | 25% |
| A filter or view hid habits unexpectedly ("thought habits were missing") | 8 | 10% |
| Filter broken (bugs) | 9 | 12% |
| Praises a group or time-of-day filter | 8 | 10% |
| Widget should respect the filter or hide completed habits | 8 | 10% |
| Show only what's due today | 6 | 8% |
| Focus: show only what matters now | 3 | 4% |
| Habits split over separate pages (dislike) | 3 | 4% |
| Doesn't want filter-only: wants to see everything, grouped | 2 | 3% |
| Doesn't like hide-completed (row vanishes before a second tap) | 1 | 1% |
| Filter by time of day, or in the context of sections | 9 | 12% |

**The mental model.**
- **A filter is a temporary narrowing.** "only show habits tagged as fitness" `P3#15077`. It helps people "not get overwhelmed by seeing all the tasks" `A1#594`.
- **Two jobs run together.** Narrowing by group is one. Hiding what's already done, so that "what remains" is visible, is the other. Hide-completed is asked for more often (23) than group filtering (19) in this read.
- **Risk: a filter left on looks like lost data.**
  - "some habits weren’t showing up on the list. I then found out that it was because of the selected time of day filter on the top of the screen. This isn’t very intuitive." `A33#1164`
  - Also `A1#48397`, `P20#3469`, and Day Structure's `P4#98867`.
- **Some people don't want a filter at all.** They want to see everything, grouped: "i don't want to filter since i still want to see all but I'd still group em..." `P8#5454`. This matches Day Structure's GV 158 against GL 260.
- **Order inside a filtered view matters too.** "If u filter out the morning habits it will show all the habits in unsorted manner." `A68#2033`

**Quotes (verified):**
- "The filter also helps me to not get overwhelmed by seeing all the tasks and isolating the ones I need to complete." `A1#594` (Habit Tracker, 4★)
- "Would really love it if there was the ability to use folders or tag and filter each habit (i.e. only show habits tagged as fitness)." `P3#15077` (Loop, 5★)
- "I then found out that it was because of the selected time of day filter on the top of the screen. This isn’t very intuitive." `A33#1164` (Habitify, 5★)
- "A simple toggle switch atop the interface to hide completed habits would solve this." `A13#16273` (Productive, 3★)
- "Now it won’t let me hide completed tasks so it clutters my screen and doesn’t let me see what I need to focus on for what remains." `A31#2702` (Do Habits, 1★)
- "i don't want to filter since i still want to see all but I'd still group em..." `P8#5454` (Habitica, 3★)

---

## 6. Summary for the three design questions

**1. Group filter.**
- **Users show:**
  - filtering by group is wanted (19 of 77 here; GL 260 in Day Structure);
  - a filter left on is mistaken for missing habits (8 here);
  - hide-completed is an equally strong "show me less" request (23).
- *Reasoned from first principles:* the active filter must be visible on Today, with one tap back to All.

**2. Finding section and group editing.**
- **Users show** people look for Edit and Add **on the thing itself**: the filter chips, the tag, the section. When it lives elsewhere, they ask "how do I delete a group" (5 times in one app).
- For sections, the frustration is presets that can't be added to or removed (11 "doesn't exist", 10 "couldn't find", 2 found it late).

**3. Order inside a time of day.**
- **Users show:**
  - hand order, or the order of doing, is the dominant model (72 of 179, 40%);
  - reminder order is almost never asked for (2 of 179);
  - an order that changes by itself is the top complaint (35 of 179);
  - creation order and "new at the bottom" frustrate people (12 of 179).
- *Reasoned from first principles:* the default should be **the person's own saved order**. A new habit goes where the person puts it, or by default at the end of its section, with an obvious way to move it. Nothing reorders itself on completion, sync or a new day. A "Sort by time" action can serve the minority who use times (13%), applied once to the saved order, not as a live rule.

---

## 7. Limits

- **Keyword screen.** Recall is bounded by the patterns. DISC in particular is narrow (192 habit-tier hits) and only half its hits were on theme. FILTER's broad draw was 37% on theme, so a targeted second draw was added. The targeted draws' shares describe what people say *when they raise the topic*, not how often it comes up.
- **Sample, not census.** 483 of about 5,500 habit-tier hits were read. The rest are counted by keyword only, and those counts are floors with unmeasured precision outside the read draws.
- **Weighting.** Reads were weighted towards 1–3★ (298 of 483), so complaint shares are higher than in the whole hit set.
- **App concentration.** Me+ (36 of 226 ORDER; 16 of 44 "order changes by itself"), HabitNow, Habitica, ShineDay and Fabulous dominate. "Order changes by itself" is partly a Me+ bug signal. The *wish* for a stable order is spread across 51 apps.
- **Reminder inference.** "Doesn't use reminders" is inferred from the text not mentioning them (151 of 179). Only 2 reviews say outright that they want order without times.
- **Single coder,** no second-coder agreement. The codes and notes are in `coding.jsonl` for audit.
- **Translations** of non-English quotes are Claude's own.
- **Countries:** no per-country claims are made, because samples per country are below 50.

---

## Codebook

**ORDER: what goes wrong**

| Code | Meaning |
|---|---|
| CANT | No way to reorder |
| HARD | Reorder exists but is clumsy, slow or buggy |
| RESET | The order changes by itself, isn't saved, or reverts |
| FIND | Couldn't find how to reorder |
| PRAISE | Praises arranging |
| WRONG | Order looks wrong or messy, unspecified |
| SYNC | Order differs between devices |
| BUG | A bug is involved |

**ORDER: which order is wanted**

| Code | Meaning |
|---|---|
| DRAG | Own manual or drag order |
| DOING | The order they do things in the day, or a routine sequence |
| DOING- | Wants freedom to do routine steps in any order |
| TIME | By time of day or scheduled time |
| REM | By reminder time, explicitly |
| AZ | Alphabetical wanted |
| AZ- | Imposed alphabetical disliked |
| PRIO | By priority or importance |
| PRIO- | Priority-number ordering confusing |
| OTHERSORT | Score, streak, count, category |
| SORTOPT | Wants a choice of sort modes |
| NEWPOS | Where new or edited items land |
| DONEBOT | Completed should sink to the bottom |
| DONESTAY | Completed should stay put |
| UNDONETOP | Undone first |
| AUTO- | Dislikes an imposed automatic order |
| SUBITEM | Order of checklist steps |
| FUTURE | Arranging a future day |
| GRP | Order of groups or folders |
| NOREM | Explicitly wants order without times or reminders |
| REMMENTION | Mentions reminders in the ordering context |

**DISC**

| Code | Meaning |
|---|---|
| DFIND | Couldn't find how, or didn't know |
| DFIND_OK | Found it, with effort |
| DFIND_ACC | Found it by accident |
| DMISS | The function doesn't exist |
| DPAY | Paywalled |
| PRAISE_EDIT | Praises easy editing |
| LONGPRESS | Long-press expectation |
| F_CATEDIT | Editing tags from the filter |
| OBJ_GRP | Object is a group, category, tag or list |
| OBJ_SEC | Object is a section, time of day or routine |
| OBJ_HABIT | Object is a habit |

**FILTER**

| Code | Meaning |
|---|---|
| F_WANT | Wants a filter, tabs or folders by group |
| F_USE+ | Praises a filter |
| F_HIDE | A filter or view hid habits unexpectedly |
| F_HIDE- | Doesn't want filter-only |
| F_BUG | Filter broken |
| F_FOCUS | Show only what matters now |
| F_NOTDUE | Show only today's due |
| F_WIDGET | Widget should respect the filter or hide completed |
| F_WEAK | Filter too coarse |
| F_COLLAPSE | Collapse or expand all sections |
| F_ALLDAY | Wants the whole day together |
| HIDEDONE | Wants completed hidden |
| HIDEDONE- | Hiding completed causes a problem |
| PAGES- | Habits split over pages |
| GROUPHDR | Prefers grouped headers |

**Context**

| Code | Meaning |
|---|---|
| SEC | Inside or about time-of-day sections |
| GROUPING | "Sort" used to mean group into categories |
| SECFORCED | Forced sections disliked |
| SECCHANGE- | A section change broke history |
| GD | Category separate from time |
| X | Read, not relevant |
