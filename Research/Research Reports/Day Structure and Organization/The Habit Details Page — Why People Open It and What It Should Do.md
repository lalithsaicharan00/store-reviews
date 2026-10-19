# The Habit Details Page — Why People Open It and What It Should Do

> **Written by Claude (Claude Code)**, 19 October 2026, at the user's request (Current Work 143). Authorship of every
> report is listed in the [Research Reports index](<../README.md>).

**The question (the user's words, tidied).** "I still think we need a lot of research about why people open the habit
details page." Do the research, work it out, and report back. The milestone rule (board `2266:2`) and Google Sans Flex
were checked first (Current Work 143); this report is about the page itself.

---

## The short answer

- **People open one habit's page to look back, not to set it up.** One reviewer said why in a single line:
  "I only need to open the app when I want to review my progress or update a past day" (`P3#4965`).
- **Six jobs**, from 1,647 reviews read and coded by hand (103 habit apps). In order of how many reviews raise each:

  | # | Job | Reviews | Apps | Avg ★ |
  |---|---|---:|---:|---:|
  | 1 | **See the record**: which days it was done, this month and over the year | 525 | 68 | 4.29 |
  | 2 | **Check the numbers**: current and best streak, rate, totals, the month or year in sum | 470 | 66 | 4.29 |
  | 3 | **Write and read notes** on a day (what was done, why it was missed) | 410 | 61 | 4.35 |
  | 4 | **Fix a past day** (forgot to tick before midnight, a mistake) | 188 | 59 | 3.74 |
  | 5 | **Change the habit** (goal, schedule, name) without losing its past | 119 | 37 | 3.69 |
  | 6 | **Milestones and badges** | 100 | 36 | 4.42 |

- **What hurts most is trust**: a streak or calendar that's wrong, or history that's gone (218 reviews, **3.07★**, the
  lowest of anything here). Next come jobs 4 and 5, both under 3.8★: fixing a day and changing a habit are where people
  get stuck or lose data.
- **The order matters.** People tap a habit to see how it's going. Two reviewers ask outright that the edit screen not
  come first (`A13#12040`, `P8#101`), and one wants the opposite (`A33#2976`, §2.7).
- **Some things people want on the page actually belong elsewhere.** These are the streak on the Today row (68
  reviews), all habits together (76: the Progress page's job) and logging straight from a reminder (11).
- **Our Android design already covers most of this.** It has History, Notes, Progress, a year grid, milestones, Go to
  date and four record tiles. **Five gaps** are listed in §4 (one corrected on 19 Oct: the month calendar exists),
  and **five decisions** for you are in §5. The biggest is which tab the page opens on.

---

## 1. Basis

- **Screened:** 932,330 reviews in the App Store and Play Store corpora, with the to-do apps left out
  (`Habit Details Evidence/habit_details_scan.py`). That left 2,018 habit-app reviews that talk about one habit's own
  page: its history, calendar, statistics, streaks, milestones, notes, editing past days or its settings.
- **Read:** all 2,018, by hand, in 26 batches. **1,647 are on topic** (103 apps, 2012–2026, 859 App Store, 788 Play
  Store). The other 371 matched a word but were about something else: Today, widgets, reminders, sync or prices. Hevy, a
  workout log, was left uncoded.
- **Coded:** each review gets one or more of 57 codes, and the codes are grouped into the six jobs. A review can raise
  several jobs (551 do), so job totals overlap.
- **Checked:** every ID resolves to its review, and **33 quotes are verified word for word** against the corpus
  (`Habit Details Evidence/habit_details_classification.py`, run from `Research/`).
- **How to read the numbers:** the scan looked for words like *calendar*, *notes* and *streak*, so the counts show how
  often each job comes up among reviews about the page. They are not the share of all users. Requests also pile up where
  an app lacked something:
  - Loop gives 54 of the 329 note requests (it had no notes until 2024).
  - Habitica gives 25 of the 305 calendar ones (it has no calendar).

  Ratings lean high (810 of the 1,647 are 5★), so compare the averages with each other, not with 5.

---

## 2. The six jobs, and what users show about each

### 2.1 See the record (525 reviews, 68 apps)

This is the most common reason to open a habit. People want to see the days it was done, at a glance, as a calendar.

- **A month calendar of the one habit** (305 reviews), **a year view** (85, rated highest at 4.60★) and **looking back
  over months and years** (105).
- **The calendar needs dates.** A redesign that swapped a dated calendar for a bare heat map lost a paying user:
  "Now it just shows a heat map with squares and without specific dates" (`A4#12023`). Another reviewer was upset
  that an update "removed the easy, quick-glance monthly calendar view" (`A13#12021`).
- **"When did I last do this?"** (8). This matters for habits that aren't daily: "I want to be able to see the last
  days I did a particular habit" (`A85#332`).
- **A missed streak isn't the whole story:** "you can still look back and see how many times you achieved your daily
  goal" (`A34#20`). Counting the days (18 reviews) matters as much as the run.
- **Each kind of day looks different** (39). Done, skipped, not done and nothing logged should be told apart: "These
  two cases feel psychologically very different, but visually they look almost the same" (`A57#702`). Also asked:
  the amount written on the day (10) and a part-done day shown as part done (5).

### 2.2 Check the numbers (470 reviews, 66 apps)

- **Current and best streak** (173 reviews) and **statistics for this one habit** (191): rate, chart and trend.
- **Best streaks as a list, not one number** (40). The past runs give something to beat: "close to beating my most
  recent streak of 25 or my personal best streak of 30" (`P9#280`).
- **A number that forgives a missed day** (11, 4.55★). "missing a day or two doesn't ruin your score" (`A20#3560`).
  "If I break a streak I don't feel so defeated since I can see the total completion rate" (`A46#1655`).
- **A broken streak shouldn't be the first thing you see.** One reviewer wrote "now I have to stare at that broken
  streak every time I open the Habit" (`P3#8388`). Another wants the best streak always visible, because hiding it "is
  demotivating if you broke the chain" (`A76#15`).
- **The month and year summed up** (36, 4.53★) and **totals** (13).
- **Quit habits have their own numbers** (41, mostly Days Since): time since, longest run, money saved.
- **Patterns** (27): which weekdays slip, and what got in the way.
- **No penalty for days still to come.** "Don't count days that haven't happened yet as" zero (`A1#54056`). Our
  "Reached on 12 of 12 days so far" already does this.

### 2.3 Write and read notes (410 reviews, 61 apps)

- **A note on the day** (329). People write what they did ("which book", "which workout"), how they felt, or a number
  the app doesn't track.
- **A note on a missed day** (29): "i was far from home so it was not possible to do the habit this day" (`P3#9037`).
  Several apps only allowed notes on done days, and reviewers called that out.
- **Reading notes back is its own job** (57). People want:
  - every note of a habit in one list, to "list all the notes in one period to analyse and find a way to improve"
    (`P3#26823`);
  - a note opened from the calendar: "view the note for a specific day by clicking on it from the calendar view"
    (`A34#583`). Notes on the calendar are how patterns show up: "when you look at the calendar you may notice on
    Tuesdays I struggle with cravings" (`A3#5113`);
  - reading without editing: "the only way I can view notes is by editing them" (`A55#1304`).
- **Notes must stay optional.** "I just wish the notes box didn't pop up every time I go to tick" (`P3#4239`).

### 2.4 Fix a past day (188 reviews, 59 apps; 3.74★)

- **Mark or correct a past day** (160 reviews). Usually it's because the person forgot before midnight: "If I forget
  to mark my habit before midnight, it counts it as not done" (`A23#7051`). Apps that allow it are praised for it.
  Apps that don't, or that charge for it, lose people.
- **Days before the habit was added** (23). People want to carry an existing streak over or bring in another app's
  data.
- **A correction must be safe** (14 + 4).
  - Calendars that toggle a day on a single tap change the past by accident: "we can bymistakely click on previous days
    and unknowingly mark the habit undone" (`P30#3582`).
  - A few reviewers want old days locked, because unlimited editing "can make streaks less meaningful" (`A62#9`).
  - A correction should take two deliberate steps, with an Undo.

### 2.5 Change the habit without losing its past (119 reviews, 37 apps; 3.69★)

- **Edit settings** (37). People open the page to rename the habit or change its goal or schedule. What hurts is when
  that wipes the past: "any change to a habit results in all habit history being reset" (`A13#2765`), and "changing
  that one simple detail makes me lose my entire streak from before" (`A13#12805`). There are 28 such reviews, most of
  them about Productive. **Our D6 already forbids this.**
- **Why and how, on the page** (47). People want the habit's description, its steps or their reason to be visible, not
  buried in edit.
- **A page you can add to** (8, all about one app, Today). People praise attaching a journal, counters and milestones
  to a habit: "Swipe up to review cards of different types that you have attached to the goal" (`A86#1216`). That's
  one app's following, so treat it as a signal, not a requirement.

### 2.6 Milestones (100 reviews, 36 apps; 4.42★)

- People ask for badges at the familiar marks ("Just add achievement like when completed habit for 3/7/30 days",
  `P30#3777`) and enjoy them where they exist.
- Three reviews found them pointless or nagging. One reviewer kept getting milestone alerts for a deleted habit.
- **Our milestone rule (17 Oct) already covers what reviewers ask for.** It has in-a-row marks from 3 days, totals and
  yearly anniversaries.

### 2.7 What should come first when the page opens

- **Two reviewers say the page should open on progress, not on settings:**
  - "habit edit info really shouldn't be the first thing I see when I click on each habit" (`A13#12040`, Productive,
    after a redesign moved the month view under "a bunch of unhelpful streaks info");
  - "better show Statistics or graphical presentation instead of editing mode" (`P8#101`).
- **One wants the setup visible first:** "Displaying Repeat, Reminders, and Goals right at the beginning, before
  progress" (`A33#2976`). Our large top bar already shows the goal under the name.
- **Taken with jobs 1 and 2, the evidence says:** open on the record and the numbers, and put settings in ⋮.

---

## 3. What frustrates, and what belongs elsewhere

**Trust (218 reviews, 3.07★, the lowest score in this study)**

| Problem | Reviews | Avg ★ |
|---|---:|---:|
| A wrong streak, count or calendar | 82 | 2.90 |
| History lost after an update, a sync, archiving or deleting | 78 | 2.88 |
| Hard-to-read numbers or calendars | 51 | — |
| A page that's slow or crashes on open | 13 | — |

- Archiving that hides the past is part of this: "When you archive a habit, it just erases the progress from previous
  days" (`P2#3987`).
- The page is where people *see* data loss: "all of my history was deleted as well as my habits" (`A20#3069`). Every
  number on it must match Today and Progress (U26's principle), and archived habits must keep their page.

**Getting there (82 reviews).** Too many taps or swipes (50). Examples:
- reading a note takes "click the habit and then click the memo/note to see what's written" (`A1#56452`);
- switching between habits means backing out each time.

**Belongs outside the page (153 reviews)**
- **The streak on the Today row** (68): people want it "without having to go to the detail page" (`A33#3641`). U20
  keeps Today's streak.
- **All habits together** (76): this is the Progress page's job, not one habit's.
- **Log from a reminder** (11): "I tap the reminder, get to the details screen of a habit, have to tap" back to log
  (`P3#13838`). A reminder should open where logging is, and a page reached from one should offer Add log.

---

## 4. Our Android design against the evidence

The current design is Habit details `1373:2`: a large top bar with the habit's icon, name and goal; tabs History ·
Notes · Progress; and ⋮ with Edit, Pause, Archive and Delete.

| Job | What we have | Gap |
|---|---|---|
| 1 See the record | Progress has a Month calendar (one square per date in weekday columns, ✓ on done days, today outlined, then a bar chart) and Year in Pixels. History lists days by month | **Small additions only** (corrected 19 Oct; the first version wrongly said there was no month calendar): the Month calendar's squares have no day numbers (`A4#12023`'s complaint), don't say a tap opens the day, and have no mark for a day with a note |
| 2 Numbers | Overall record (four tiles, current streak tinted), Week, Month, Year | **Best streaks are one number, not a list** (40 ask for the past runs). The completion rate exists; check that it stays beside the streak |
| 3 Notes | A Notes tab with search, grouped by month; a note icon on History rows; a note on any day through Day details | **No note mark on the year grid** and no way into a note from it. Check that a note can be added on a missed or skipped day |
| 4 Fix a past day | History's Go to date, Add log, and Day details for any past day | **Days before the habit started can't be logged** (23 ask). The year grid's Open day must open Day details, never toggle a day on one tap (`P30#3582`) |
| 5 Change | ⋮ Edit; changes never rewrite the past (D6); a type change archives the old habit with its page | **No place for a description or "why"** on the page (47 ask). Today it's only in edit, if at all |
| 6 Milestones | Milestones card and All milestones, with three tracks including Anniversaries | None |
| Order | The iPhone opens on History; Android shows History first | **Opening on History leads with a list.** The evidence points to opening on the record and the numbers (§2.7) |

---

## 5. Decisions for you

1. **Which tab opens first?** History (as now), or Progress, which has the record and the numbers. The evidence
   favours whichever puts the calendar and the streak first.
2. **The Month calendar we have** (corrected 19 Oct). Add day numbers, open Day details on a tap, and mark days with a
   note.
3. **Best streaks as a list.** Show the top few runs with their dates (40 ask), under the record tiles.
4. **Days before the habit started.** Keep them blank (as now). The other option is letting Edit move the start date
   earlier, so those days can be logged (23 ask, often to carry over a streak from another app).
5. **A description on the page.** Show the habit's "why" or steps under its name, if it has one (47 ask). It's
   optional, and nothing shows when it's empty.

---

## 6. Relation to earlier research

Codex's [Habit Details Research](<../Habit Details Research/README.md>) (3–5 October 2026) set the three tabs (History,
Notes, Progress), dated History rows and an early streak in Progress. These are now U20 and U21. This study is a fresh
hand-read of a wider set of reviews (habit apps only). It **agrees with that structure**: three jobs, each with its own
tab, matches jobs 1–3 here. What it **adds** is:
- how much each job weighs;
- dates, taps and note marks on the calendar;
- which tab comes first;
- past streaks as a list;
- notes reachable from the calendar;
- the trust findings.

The two studies' codes and counts are separate. Neither re-verifies the other's totals.

## 7. Limits

- Keyword screening misses reviews that describe the page in other words.
- Counts lean toward apps that lacked a feature: notes in Loop, the calendar in Habitica.
- The codes are one reader's judgement. They were checked by rereading each batch, not by a second reader.
- Old reviews (back to 2012) describe apps that have since changed. Use them as needs, not as a picture of today's
  apps.
- Nothing here is tested with users.

## 8. The user's decisions (19 October 2026)

- **The page opens on Progress** (the record and the numbers), **History second** (§5 decision 1).
- **History and Notes become one tab**: each day shows its logs and its note together.
- **Best streaks as a list.**
- **The start date can be set to any day**: earlier is always allowed; later stops at the first log, so no log is hidden.
- **The description shows on the habit's page only**, never on the Today row. "Steps" (§2.5) means the same
  description: what the habit involves. The habit form already has *Description (optional)*.
- **Logging straight from a reminder** is noted for later (Current Work 143).
- Recorded in Current Work 143, with placeholders for every screen and state before the designs.

## 9. The user's review of the designs (19 October 2026), and the evidence behind each change

**One Add instead of Add log and Add note.** In 1,647 reviews, people fix or fill a past day by going to *that day*:
- tapping it on a calendar (`A34#578`, `A34#478`, `A57#771`, `A1#56100`; 160 reviews in all ask to correct a past day);
- they complain when every action has its own screen (`A13#13629`, `A13#18587`).

Day details already holds everything a day can take: +1, Log manually and Add a note. So History offers one **Add**:
pick the day (Android's date picker, today and earlier), and that day's details open. It's the extended floating
button Android uses for a page's main action. Search, All · With notes and Go to date stay. Users show the need;
the single entry point is reasoned from it.

**A note shows at most two lines in a History row.** People want to see notes without opening them (`A1#56452`, and
`A57#765` praises seeing them while scrolling). One long note mustn't stretch a day's row past the rest of the list.
Two lines, then …, keeps the list scannable, and the whole note is one tap away. This follows Material 3's list
items, which hold up to two lines of supporting text; the number itself is reasoned from first principles, not taken
from a review.

**The square and › line up with the date and the line under it**, the same in every row, however tall the row
grows (reasoned from first principles: the eye follows the dates down the list). Material 3 likewise top-aligns the
leading and trailing parts of taller list items.

**Streaks live on their own page.** Reviewers value a list of past runs (`P3#13414`, `P3#10974`; 40 reviews), but
what people open the page for first is the record and the numbers (§2.7: `A13#12040`, `P8#101`). So the Overall record
leads, and its **See all streaks** (or **See all runs** for a quit habit) opens the full list. This works the way
Milestones' *See all* already does, the same on every habit.
