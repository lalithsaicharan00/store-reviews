# Pausing a Habit — What People Need

Written by Claude (Claude Code), 29 September 2026. Build Plan #55. It adds whole-corpus counts to Feature Ledger point C016 (Skip / holiday / pause mode: Strong, 33 apps, negative in 22).

**The question (the user, 29 Sep):** the next feature is pausing a habit. Research first how pausing should work across the whole app, then build it.

## Answer

1. **Pause one habit at a time, for a stretch of days, and keep the streak.** Users show this is the ask: 88 reviews in 31 apps want to pause a habit, and 24 in 16 apps say outright that the streak must survive. Travel and holidays are the main reason (93 of 171 reviews that want or use a pause), then illness or injury (29).
2. **A paused day works exactly like a skipped day.** It isn't one of the habit's days, so it's neutral in the streak, the ring and every percentage. The app already treats Skip today this way (`HabitStore.skips`), so pause is a run of skipped days, not a new kind of day. The apps that got this wrong are the pause complaints: 11 reviews in 4 apps (mean ★2.82) where un-pausing reset the streak or asked about the paused days.
3. **Ask how long: until a date, or until I turn it back on.** Default to a date, and resume on its own. There's no minimum or maximum: both kinds of limit drew complaints. Users show the date matters: a Finch user can pause goals on holiday but has to "remember to activate them again" (`13025750079`).
4. **A paused habit leaves Today, its reminders stop, and it's out of routines.** It shows as one quiet line in a folded **Paused** card at the bottom of Today, with the date it comes back and a Resume button. That way it's never lost. Hiding with nowhere to find it drew "How do i enable them?" (ShineDay, `4350173981`).
5. **No app-wide "vacation mode" switch.** Only 4 reviews ask for one switch for everything. More (14 in 7 apps) want to keep some habits going while others pause, such as medicine on holiday. Pausing several at once belongs in All Habits (#56), with a Select mode.
6. **Pause is free and never offered.** The app never suggests pausing, and there's no "streak freeze" to earn or buy. Pausing is always the person's own choice. Five reviews prefer strictness, and two dislike a gamified streak freeze.

## What the reviews say

Scan of all 1,487,223 reviews (App Store, Play Store and native apps; `Research/Temp/pause/scan.py`). It found 607 reviews with the words for pause, vacation or holiday mode, sick or rest days, or a streak freeze. Each was read and classified by hand (`Research/Temp/pause/classify.py`). 260 were on topic, in 50 apps. The rest were about timers, workouts, routine players, subscriptions, or phrases like "days off alcohol". A review can count in more than one group.

| Group | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Want to pause a habit | 88 | 31 | 3.98 |
| Pause or vacation mode exists, and is praised | 62 | 16 | 4.89 |
| The streak must survive the pause (said outright) | 24 | 16 | 4.25 |
| Want some habits kept, or a lighter set while sick | 14 | 7 | 4.07 |
| **Un-pausing reset the streak, or asked about the paused days** | **11** | **4** | **2.82** |
| Paused days should not drag stats, percentages or trends | 10 | 8 | 3.60 |
| Want to set how long (a date, a range, "for a period") | 10 | 6 | 4.50 |
| Other pause bugs (can't resume, habits came back, pause removed, dates not kept) | 6 | 3 | 2.83 |
| Paused habits should leave the main screen | 5 | 4 | 4.00 |
| Skipping day by day used as (or is a pain as) a pause | 5 | 4 | 4.60 |
| Prefer no pause (strictness), or dislike a gamified streak freeze | 5 | 3 | 3.80 |
| Pause length limits disliked (7-day maximum, 2-week minimum) | 4 | 2 | 4.25 |
| Want one switch for everything | 4 | 4 | 4.75 |
| Reminders must stop while paused | 4 | 3 | 4.00 |
| Couldn't find pause, or how to turn it back on | 3 | 2 | 3.67 |
| A quit counter: stop the clock between attempts (Days Since only) | 19 | 1 | 3.84 |
| *Not a pause:* forgiving a day already missed (streak repair or freeze) | 41 | 13 | 3.63 |

**Why people pause** (the 171 reviews that want or use a pause; matched by keyword within those hand-picked reviews): travel or holiday 93, illness or injury 29, a season or a change at school or work 9, overwhelm, mental health or grief 8, and 48 give no reason.

**Praise is concentrated.** Finch (19) and Habit Tracker (19) carry most of the 62. Where a pause works, it's praised as the thing that makes a streak app humane. One reviewer paused through a grandfather's funeral and came back "with no problem" (Finch, `13273198779`).

## What goes wrong in apps that have a pause

Users show the failures, and each one becomes a rule:

- **The streak breaks on resume.** "It used to be that if you paused tasks you didn't lose your streak… I lose all my streaks every time I unpause" (Streaks, ★2, `10772984090`). "When I turned them back on it shows an X in all of those days" (Streaks, `11138802961`). Rabit had the same fault 6 times. **Rule:** paused days are never a miss, before or after resume.
- **It asks about a paused day.** After a short pause, Rabit asked "whether you did it or not, even though that's the day you had it paused… either lie… or let the streak end" (`c776bc9d-8917-4abf-acb1-81f3c7547b86`). **Rule:** never ask about a paused day.
- **Reminders keep coming, and weekly goals don't shrink.** "I cannot turn off the notifications on vacation mode", and a half-week away still expected the full weekly plan (Habit Tracker, `12381252932`). **Rule:** reminders stop, and a week or month that had a paused day can't break the streak.
- **Limits that don't fit a life.** Finch's pause stops at a week ("going away for the summer", `12759473246`). Habit Tracker's seemed to need at least two weeks, too long for a weekend (`11759331889`). **Rule:** any length, including open-ended.
- **Pausing everything, or nothing.** "A vacation mode for some habits only instead of a 'general' vacation mode… if I'm feeling sick I won't do some of my habits (ex: running)" (Habit Rabbit, `d7c13950-d1fa-4696-b475-10cbcf3e4373`). **Rule:** pause is per habit.
- **Skipping every day instead.** "It could be a pain to have to skip habits every day that you can't do while away from home" (Awesome Habits, `8656250182`). **Rule:** Skip today stays for one day, and pause covers a stretch.
- **Hidden with no way back.** "Paused Habits — How do i enable them?" (ShineDay, `4350173981`). **Rule:** a Paused card on Today, plus Resume in the long-press menu and on the habit page.
- **Churn when it's missing.** "Ultimately I didn't keep going with this app due to lack of… Vacation mode" (HabitNow, `3454667b-6d22-407b-a947-558d8f204e97`). "It makes me feel guilty for losing my streaks" (HelloHabit, `13086329598`).

## How pause works across the app

Reasoned from first principles on top of the rules above. Where a row rests on reviews, it says so.

| Place | While paused | Why |
|---|---|---|
| **Today** | The habit leaves its time-of-day card, and "N left" doesn't count it. A folded **Paused** card at the very bottom lists it: "Water · Until Mon 6 Oct", with Resume | Users show paused habits shouldn't read as "not done" (`434b05fd-7a8f-4187-9b35-87d261177dab`). A card keeps it findable, and the Quitting card already folds the same way |
| **Streak** | Paused days are skipped over. The streak carries on after resume | Users show (24 + 11 reviews) |
| **Weekly, monthly and yearly goals** | A period with a paused day can't break the streak. If the goal is still met in that period, it counts | A half-paused week shouldn't demand the full target (`12381252932`). "Neutral unless met" is simple and never punishes |
| **Stats and percentages** | Paused days are left out, like skipped days | Users show (10 reviews) |
| **Calendar and history** | A paused day gets its own quiet mark (a dash, like a day that isn't scheduled), never a miss | Users want paused days visible and told apart from failures (Rabit `c776bc9d…`, Onrise, DayStamp) |
| **Reminders and alarms** | None on paused days. They're scheduled again on resume | Users show (4 reviews); a reminder for something paused is noise |
| **Routine player** | Not in the routine, and the section's count leaves it out | Same as Today |
| **Notes** | Still allowed on a paused day ("sick", "away") | A note never changes progress, and a reason for a pause is a natural note |
| **Logging on a paused day** | Allowed. Doing it anyway counts, and the day stays neutral if it isn't done | Not something to forbid, and "neutral unless done" matches Skip |
| **Edit habit** | Still possible while paused | Nothing about pause depends on the rule |
| **Cut down** | Pauses like a build habit: the limit isn't checked on paused days | A limit on holiday is the same case as a goal on holiday |
| **Tasks** | A repeating task can be paused; a one-time task can't (reschedule it instead) | 1 to-do app review wanted it for vacations and sickness |
| **Quit habits** | See below | |

**Quit habits.** Days Since reviewers ask to "pause the counter" 19 times. But they mostly use it for things that aren't quitting (haircuts, a social media break, a fasting challenge). The recurring wish is that a new attempt shouldn't start the moment they reset: "you could have the ability to 'pause', so another streak wouldn't automatically start" (`9071875815`). Stopping a quit clock and carrying on later would claim smoke-free days that weren't. So, reasoned from first principles: **pausing a quit habit ends the current run, kept in its history as a finished run and not a slip, and resuming starts a new run.** This needs the user's call before it's built.

## Pause, Skip today and archive

| | Skip today | Pause | Archive (#56) |
|---|---|---|---|
| How long | One day | A stretch: until a date, or until turned back on | For good, until restored |
| Where | The player's Habit options (today) | Long-press → Pause…, the habit page, All Habits (several at once) | All Habits, the habit page |
| On Today | Gone for that day | In the folded Paused card | Not shown |
| Streak and stats | Neutral | Neutral | Frozen as it was |
| Comes back | Tomorrow | On the date, or by Resume | By Restore |

Report 23 found Streaks users treat archive and pause as one request (57 mentions). They're different jobs: pause is "not now", archive is "done with this" (`5cbc92be-2276-41cb-a8d7-198a4773328c` wants either). Both keep all history.

## The pause sheet

Reasoned from first principles, using native iOS parts:

- **Long-press → Pause…** (next to Edit Habit), and a Pause row on the habit page. It opens a small sheet titled "Pause Water".
- **Until:** quick choices ("1 week", "2 weeks", "Choose a date…"), then **Until I turn it back on**. It's a date by default, so it comes back on its own.
- **From:** Today by default, and can be changed to a later day (a trip booked ahead) or an earlier one (someone who was sick and pauses after the fact). Days already logged keep their logs.
- One line above the Pause button says what happens: "Water leaves Today until Mon 6 Oct. Your streak stays, and reminders stop."
- **Resume:** from the Paused card, the long-press menu ("Resume Water") or the habit page. Resuming never asks about the days it was paused.

## Not doing, and why

- **An app-wide vacation switch:** 4 reviews. It would also pause medicine and anything that still happens on holiday (14 reviews want some kept). Several at once comes from Select in All Habits.
- **A lighter "sick mode" routine** (10 reviews want easier goals while ill): a separate idea, not a pause. Parked.
- **Streak repair or freeze for a day already missed** (41 reviews, mostly Finch): it forgives after the fact and is a different feature. In this app, a past day can already be filled in or skipped, which covers the honest cases.
- **Limits on pause length, or a cost:** both drew complaints. Pause is free.

## Limits of this evidence

- Keyword scans miss requests worded another way ("stop tracking for a while"), so the counts are floors.
- The reasons are keyword matches within the hand-picked reviews, not a second hand reading.
- Praise comes mostly from two apps (Finch and Habit Tracker). The broken-streak complaints come from Streaks (2023–24) and Rabit (2021–22), so each fault is one app's defect, told by several people.
- The Today card, the sheet and the quit rule are reasoned from first principles, not tested with people.
