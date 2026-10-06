# Hiding a Weekly Goal From Today — Is It Needed?

> **Written by Claude (Claude Code)**, 6 October 2026, at the user's request (Current Work 56). Authorship of every
> report is listed in the [Research Reports index](<../README.md>).

**The question (the user's words, tidied).** "Run 15 km this week" has no Skip, and Skip wouldn't make sense for it.
But some days I just don't want to see that weekly goal on Today. That isn't a skip. Is this only my feeling, or do
people really want it? Build it only on a medium or strong signal; one, two or ten reviews is weak.

**Answer: weak signal. Don't build it now.** Two reviews in 1.49 million ask for exactly this. Several times as many
ask for the opposite: keep a weekly goal on Today every day until it's met. A wider and different wish, putting a
habit off to another day, is a medium signal and is recorded below for later; it isn't this feature.

---

## Basis

- **Screened:** all 1,487,223 reviews (App Store, Play Store and the native apps), 6 Oct 2026, with
  `Hide Weekly Goal Evidence/hide_weekly_scan.py`.
- **Two screens:** a week/month wording near a showing, hiding or clutter word (338 matches); and hiding, snoozing,
  postponing or moving a habit for a day (890 matches).
- **Read by hand (545):** the 98 first-screen matches that name a habit frequency ("times a week", "weekly habit",
  "once a month"…) next to a showing word; the 349 second-screen matches that aren't only about snoozing a notification;
  and the 98 snooze matches that mention a habit, goal, list or day.
- **Set aside by rule, not read one by one:** 240 first-screen matches whose period word was a price or a length of
  use ("a month", "every single day"), and 443 that mention snoozing only an alarm or notification. Both were sampled
  while the rules were set (the first 50 of the first screen were read before narrowing it); none of the sampled ones
  was on topic.
- **Coded:** 132 on topic, one theme each (`Hide Weekly Goal Evidence/review_classification.py`; zero unknown or duplicate IDs).

Citations like `P3#14071` point to line 14071 (from 0) of `Play Store Reviews/3. …/reviews.jsonl`; `A` is the App
Store and `N` the native apps.

---

## What people said

| Theme | Reviews | What it means for us |
|---|---:|---|
| **Hide a weekly or monthly goal from today, without skip or fail** (the question) | **2** | Weak |
| Hide or snooze *any* habit for the day, not counted as done, skipped or failed | 5 | Weak, and not about weekly goals |
| An app's hide-for-today that doesn't stay hidden (people who use one) | 2 | Weak |
| Hide a weekly goal once it's done today, or once the week is met | 7 | Already built: done rows sink after the pause, and the Filter's Hide Completed Habits hides them (a week goal counts as done for the day once logged that day) |
| **Show a weekly or monthly goal every day until it's met** (or complaints that it didn't show) | **16** | The opposite wish; our current behaviour |
| Keep a met goal on the list to log extra | 8 | Already built: the row stays and its button still adds |
| A weekly habit shown on a day it isn't due, or counted against days | 11 | Already built: fixed-day habits show only on their days; a week goal never counts against a day |
| Put a habit off to another day (request) | 57 | A different feature (below) |
| Put a habit off to another day (praise for an app that has it) | 24 | A different feature (below) |

**The two exact requests:**
- "You should let us hide the habits we won't need to do that day. For example, I only need to rake once a week… I
  would like an empty list at the end of each day." (Loop, 4★, 2017) `P3#14071`
- "a 'pause/skip/delay/push to tomorrow' option for recurrent tasks – I hate not clearing my daily to do list but
  recurrent tasks that are 'complete once per week/month' clutter the list until they're done." (HabitNow, 4★, 2023)
  `P2#7844`

**The opposite, said more often (16):**
- "make a weekly habit show up every day until I had done it" `A10#27797`
- "it shows up every day and shows your progress as you complete it throughout the week" `A10#29857`
- "the habit automatically reappears every day until that target is reached… once I hit the 3-time limit, it
  automatically hides until the next week" `P61#1108`
- "the ones that are marked as 'Do 4 times a week'… are not showing up on my 'Today' view… I cannot figure out how
  to find them" `A13#13640`

This agrees with the earlier whole-corpus study, [Showing Non-Scheduled Days](<../Home Screen and Visual Design/Non-Scheduled Days/Showing Non-Scheduled Days.md>)
(24 Sep 2026): "x times a week" is the largest request in that set (342 reviews), and those habits should "show every
day until the goal is met".

---

## Why the wish is weaker than it feels (reasoned from first principles)

A weekly goal on Today already asks very little:

1. **It says how far along the week is** ("1/3 this week"), so it reads as a running total, not a chore due today.
2. **Once something is logged today it's done for the day:** it isn't counted in "N left", it sinks with the done
   rows after the pause, and Hide Completed Habits hides it.
3. **It never counts against a day.** A past day without it isn't missed and isn't red; it's neutral, so it doesn't
   lower that day's score.

So the case left is a week goal *not touched today* that the person wants off the screen. It's the one thing that
still costs: today's day bar counts it as open ("2/25") until something is logged or the day ends. The two people
above want exactly that gone, and a "clear list" feeling is a real motivation (`P3#14071`). But hiding a weekly goal also hides the
only daily reminder that the week is still open, which the 16 opposite reviews say is the point. With two reviews,
adding a third state beside Skip and Pause (one more thing to explain, sync and back up) isn't justified.

---

## The medium signal for later: putting a habit off to another day

81 reviews (57 asking, 24 praising an app that has it) want to move a habit to another day: "if you don't get to a
habit on its assigned day, you can either skip it or leave it incomplete… snooze until tomorrow would be great"
`A13#16273`; "I can snooze it to the next day… and not feel guilty about it" `A10#35533`. Most are about **habits on
fixed days or tasks**, not week goals ("I have a habit reminder to do laundry every Saturday but sometimes I don't get
to it until Sunday" `A1#55213`). Our tasks already reschedule (Do Tomorrow, Another Day…). Moving a fixed-day habit's
day is a different design question (what happens to the streak, the moved day and its reminder), and it's left for its
own research item if the user wants it.

---

## Decision

- **Not built.** No "Hide from today" for weekly, monthly or yearly goals. Revisit if new reviews or the user's own
  use show a stronger signal.
- **Kept:** week goals show every day until met; done for the day once logged that day; never counted against a day.
- **Fixed alongside it (Current Work 54):** a week goal's round button no longer fills after one tap; it adds one each
  tap (+1), and fills only when the week's goal is met.
