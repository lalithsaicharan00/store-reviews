Written by Claude (Claude Code), 17 October 2026.

# While You Were Away — A Card on Today, or the Habit's Own Row

**The user's question (17 Oct):** do we really need the "While you were away" card (Figma MS.4, MS.4.1, MS.4.3, MS.4.4)?
How often does a milestone happen while the person isn't on Today? Could the habit's own row show it instead? The row
would be cleaner and disturb nothing, while a card at the top takes space and "is not feeling anything like a reward".

> **Decided (the user, 17 Oct 2026):** "those cards are not adding any value to the app … if we do want to show the
> completed things, then row is best". There's no "While you were away" card. Away milestones show in the habit's own
> row, as below.

## Answer, in short

**The situation is common, but the card isn't needed. Show every away milestone in the habit's own row:** the band,
with its animation, played once the first time that row is on screen. A landmark's band adds **See**, which opens its
pop-up.

- This extends the rule already decided for quit and cut-down (shown the next day, when the row is seen) to every
  away milestone.
- It drops a fifth surface and a set of rules (lists, *and N more*, when the card goes).
- It keeps the top of Today for what it's for.

## How often it happens

`Milestones on Today Evidence/simulate_away.py` runs the adopted ladders (A21), counting only first-time milestones,
since repeats stay in the row anyway.

| Person | Days a year with a milestone reached away from Today |
|---|---|
| One quit habit, no slip | 12 (days 1, 3, 7, 14, 30, 60, 90 … in the first months) |
| Two quit habits, some slips | about 15 |
| New user, 5 habits, 20% of logs on the widget, watch or a notification | about 6 in the first 90 days, of 25 milestone days |
| The same, 50% of logs outside the app | about 14 in 90 days |
| Established, 8 habits, 20% outside the app | about 12 a year, of 45 |
| The same, 50% outside the app | about 27 a year |

So away milestones are frequent, not an edge case: up to half of all milestones for people who log on the widget, and
**every** quit milestone, since a quit clock runs on its own. Ticking from the widget is a top request (695 reviews,
4.01★, in the 30 Sep widget report), so a large share of logs will happen outside the app.

## What users show

A fresh scan of every App Store and Play Store review, run on 17 Oct 2026. It used three patterns, each read by hand:
- "while you were away", and "summary" or "recap" when the app opens;
- banners, cards or messages at the top that annoy;
- "every time I open the app" near a pop-up or celebration.

| Theme | Reviews | What they say |
|---|---|---|
| Asking for a summary or recap of what happened while away | **1**, about the day's habits, not milestones | *"when I open the app to have a summary of what I did and what is left"* (A7#252) |
| Something shown every time the app opens | **22** matches, nearly all paywall pop-ups; strongly disliked | *"Every time I open the app to track a habit I get this pop-up ad, making the app irritating"* (A31#2668) |
| Messages at the top of the screen | 1 | *"The constant messages at the top are also annoying"* (P12#53091) |
| Being told when a milestone is reached (quit and day-counter apps) | 4 (from the first milestones report) | *"i would hope for milestone notifications"* (A3#68). They ask for a notification, not a card |

Nobody asks for a "while you were away" summary of milestones. What people say about things that appear at the top or
on opening is negative.

## Reasoned from first principles

- **Where people look for a habit is its row.** The milestone belongs to one habit, so its row is the natural place,
  and the band already exists there for the rest of the day. A card at the top shows the same fact a second time, away
  from the habit.
- **Today's top is for doing.** The *How was today?* research found that something taking permanent space at the top
  pushes the habits down, which is why that card shrank to one row. Notices are limited to one at a time for the same
  reason. An away card would add a third thing above the habits on the days it shows, which for widget users is often.
- **A reward should feel like one.** A card with Dismiss and See reads as a notice to deal with. The band plays its
  small celebration where the habit is, at the moment the person actually looks at that habit. The user said the same
  for quit and cut-down: show it "when the user is actually viewing that particular habit".
- **One rule is easier than two.** "A milestone shows in its row" now covers taps, away logs, quit clocks and cut-down
  day ends, and the bar and pop-up keep their own clear cases.

## The design this leads to

| Case | What happens |
|---|---|
| A milestone reached away (widget, watch, notification, another device, a quit clock, a cut-down day end, or a pop-up still waiting when the person left) | The habit's row shows the band. Its animation plays **once, the first time the row is on screen**: the burst rings the medal, the band rises. Then it stays for the rest of that day |
| It's a landmark | The band shows **See**, which opens the pop-up. Nothing opens by itself |
| The row's section is folded (everything in it done) | The habit's little icon in the folded header gets a small medal; opening the section plays the band |
| The person doesn't open Today that day | The band waits until the row is first seen, for up to 7 days. Older than that, it's on the habit's page only (the report's 7-day rule) |
| Several habits at once | Each row has its own band. There's no list, because each moment is in its own place |

**What goes:**
- the card (MS.4, MS.4.1, MS.4.4) and its list sheet (MS.4.3);
- "Dismiss", "See all", and "and N more" for away moments.

**What stays:**
- the opt-in notification for quit landmarks (7, 30, 90, 365), already recommended in A21, which is what quit-app users
  actually ask for.

## Limits

- The simulation's widget shares (20% and 50%) are assumptions; the app has no usage data yet.
- A band on a row far down Today (the Quitting card at the bottom) may be seen late or not at all that day. The milestone
  is never lost (habit page, 7-day wait), but the moment might be. The opt-in quit notification is the answer for people
  who want to be told.
