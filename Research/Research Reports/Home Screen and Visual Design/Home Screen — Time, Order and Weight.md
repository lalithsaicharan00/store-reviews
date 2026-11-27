# Home Screen — Time, Order and Weight

Written by Claude (Claude Code), 22 November 2026.

**The questions (the user, 21 Nov 2026).** In real life most habits don't happen at a fixed time, and quit habits have no "now" at all. So how does a habit app know what "now" is? The user asked for the research questions behind this to be answered from reviews, read one by one. This report gives findings only. It doesn't say what the app should do.

**What was read.** 2,249 reviews, every one read in full and in its own language, and coded by hand. No keyword filtering.

| Set | Reviews | What it is | What it's good for |
|---|---|---|---|
| **A** | 995 | Every review already cited as evidence in the Today-screen reports | What people say once the topic is the home screen |
| **B6** | 654 | The reviews in the earlier random set (1,200 drawn from 222,078 habit-app reviews of 150+ characters, seed 20261121) that touch daily use | How common something is when nobody asked |
| **C** | 600 | Drawn at random (seed 20261121) from the 5,526 reviews earlier hand-coded as about time of day, routines or schedules (Day Structure coding, Non-Scheduled Days map), excluding A and B | What people say once the topic is *when* |

A script checked the coding: every review coded once, no unknown codes, nothing missing. All 2,249 review IDs were checked against `reviews.jsonl`, with no mismatches. The evidence folder [Home Screen When Evidence](<Home Screen When Evidence/Per-Review Index.md>) holds:

- the per-review index;
- the [codebook](<Home Screen When Evidence/Codebook.md>);
- the [full counts](<Home Screen When Evidence/Counts.md>).

**How to read the numbers.**

- A count is the number of reviews that say something; one review can say several things.
- Most reviews don't talk about time at all. Only 556 of 2,249 (25%) describe when their items happen.
- The numbers show which way the evidence leans, not how many people hold each view.
- Review IDs are written as set and index, then the source cite: `C145 A10#57326` means set C, review 145, App Store folder 10, line 57,326.

## The short answer

- **Almost nobody's items have a clock time.** Of the 556 reviews that describe when their items happen, 485 (87%) don't involve a clock time at all. The most common kind is "*n* times a week, any days" (146 reviews). Next come routines done in order (113), parts of the day (107) and set weekdays (98).
- **"Now" for most items is the day, not the hour.** The clearest wish about the app deciding is "don't show me what isn't due today": 27 reviews ask for that. Only 11 like the app picking by time of day. Separately, 93 people plan their own day.
- **Real life doesn't follow the plan** (76 reviews):
  - sick days, rest days and holidays;
  - shift and night work;
  - days that end after midnight;
  - running late.
- **When an item's time passes, people want it to stay, not vanish.** 37 want it to stay or carry over and 27 want to log it late. Only 6 complain about it vanishing, 8 want a clean slate each day, and 2 dislike pile-up.
- **Order matters to people who do routines** (113 say so). Only 4 ask to be free of a set order.
- **Quit items are rarely talked about as a list problem.** Only 8 reviews say where or how quit items should sit, and all 8 want them treated differently from things to do: no tick means success, or a running counter.
- **Heaviness comes from different places, depending on who's talking.**
  - When the topic is the home screen, it's the number of items.
  - In the random set, it's feelings first (guilt, pressure), then setup and choices, then busy screens. Item count comes last.
- **Seeing everything beats hiding.** 284 reviews want everything in view, 56 accept hiding, and 11 forgot something that was hidden. The list gets lighter as they **finish things** (96 like done items going away), not by hiding what's undone.
- **"Heavy in the morning, light in the evening" isn't something reviewers say.** Mornings are where routines and overwhelm show up. Nobody asks for a light evening.

## 1. What kinds of "when" do people's items have?

Of the 556 reviews that describe when their items happen:

| Kind of "when" | Reviews | In set C (timing, n = 600) | Example |
|---|---|---|---|
| *n* times a week or month, any days | **146** | 83 (13.8%) | "Go on a walk 3× a week", shown every day until done (C559 `A10#29857`) |
| A routine done in order (see §2) | **113** | 17 | Morning steps in order (A375 `P49#422`) |
| A part of the day (morning, evening…) | **107** | 24 | Morning/afternoon/evening grouping called essential (C341 `A13#11807`) |
| Set weekdays | **98** | 69 (11.5%) | Gym Mon/Wed/Fri (C303 `A16#1076`) |
| A clock time | **71** | 20 | Meds at a set time (C488 `N4#9801`) |
| Quit, avoid or limit | **67** | 14 | Sobriety counter (C560 `A3#9639`) |
| Every *n* days, or since last done | **48** | 22 | Repeating task often done after its day; wants the next due date (C202 `P84#11608`) |
| Several times a day | **37** | 13 | Water every two hours (C543 `A4#16031`) |
| A task with a date | **34** | 14 | Dated to-dos (C269 `P126#75484`) |
| An amount over the day or week | **29** | 9 | One hour a week, across days (C241 `P2#9295`) |
| Tied to an event (after work, before bed) | **19** | 3 | Due only from 6 pm, after work (C43 `A23#682`) |
| Says plainly "no set time" | **15** | 4 | Retired, no clock; gets to things across the week (C572 `A23#5100`) |
| A to-do with no date | **11** | 4 | Someday tasks kept out of the way (C274 `A85#3038`) |

**What this shows.**

- **Clock times are a small minority.** Only 71 of 556 reviews (13%) mention one. Even then it's usually a reminder time, not the time the thing is done.
- **The week is the main unit.** "*n* times a week, any days" is the largest kind (146), and its reviews pull in two directions:
  - **Keep it on the list until the week's goal is met.** Eight reviews: A85, A463, A838, C145, C162, C237, C526, C559. Three of them (C162 `P22#1712`, C237 `P2#10957`, C145 `A10#57326`) complain that the habit disappeared once the minimum was met, or ask for it to stay so extra can be logged.
  - **Hide it once the week's goal is met.** Four reviews: A83 `P24#15092`, C340 `A52#15149`, C384 `A1#46830`, and C205 `A57#31` (skip for today).
  - **Don't count it as failed on a day off.** Five reviews: C71 `N5#16836`, C108 `A76#7665`, C152 `P65#7762`, C303 `A16#1076`, A539. A weekly goal that reads as 0 % or "missed" on a rest day feels like shaming.
- **Parts of the day are both liked and called rigid.**
  - One review calls them essential (C341 `A13#11807`), and another says splitting the day makes it less intimidating (A166 `A13#6743`).
  - Others call the fixed morning/afternoon/evening rigid and want their own sections and order (B361 `P10#109`, B628 `P10#12052`).
  - One person can't put the same habit both morning and night (B107 `A52#16787`).

## 2. Is sequence enough?

- **113 reviews** talk about doing things in an order or keeping their own order. **4** ask for freedom from a set order:
  - B305 `A10#60753`;
  - B407 `P49#693`;
  - B631 `P5#6080`;
  - C46 `P5#2636` (skip a step, do it after the routine).
- **Order is about routines.** Most order reviews are morning, evening or end-of-work routines run step by step. People like that the next step is decided for them, so they "don't think what's next" (A375 `P49#422`, A115 `P5#2241`).
- **People want their own order, not the app's.** They ask to reorder steps and to keep that order everywhere:
  - C189 `A54#287`;
  - C546 `P4#28686`;
  - C494 `A76#4950` (the order was jumbled when filtered).
- **Order doesn't fix when.** People still start the routine late (C185 `A5#3165`), skip steps (C46) or take one into the afternoon.
- **Within a part of the day, order is enough. Across the day, it isn't.** Things outside routines (weekly goals, dated tasks, quit items) don't sit in a sequence at all.

## 3. Who decides what's "now"?

| Who decides | Reviews | What they say |
|---|---|---|
| **The person plans their own day** | **93** (76 in A) | Plan the night before or with morning coffee; pick a few from the long list (A667 `A68#4026`, A394 `P8#5718`, A706 `P12#15077`) |
| **The app hides what isn't due today** | **27** | Show only today's habits; not-due ones are confusing or discouraging (C263 `A36#369`, C476 `A1#52955`, A360 `P3#13933`, A155 `A10#44371`) |
| **The app shows what fits this time of day** | **11** | Only what to do right now; evening skincare not before 8 pm; bedtime tasks only from a set time (A24 `A13#16911`, A73 `P2#10764`, C406 `A48#2604`) |
| App decides, and it's disliked | **3** | Opens to an empty morning list (A164 `A13#6092`); won't let them tick another day's task (C190 `A4#19326`); sets alarms from wake time (B202 `P12#151390`) |
| Set it once, don't think again | **4** | Rotations set once take the strain off (C429 `A4#18763`, C358 `A85#2276`) |
| App learns when | **4** | Shift reminders to when things are actually done (C315 `A7#440`, A363 `P3#15988`) |

**What this shows.**

- **For the day, people are clear: show today and keep everything else away.** Not-due items on Today are a steady complaint across apps (27 reviews).
- **Within the day, people split.**
  - 11 like the app showing what fits the time.
  - Others were hurt when time-based views hid things:
    - morning habits vanished when the window passed (A21 `A13#16273`);
    - a day view showed only the evening, so morning events were missed (A963 `N8#34171`).
- **Mostly, people decide for themselves.** 93 plan or pick their own day.

**Real life drifts from any plan.** 76 reviews say the app's times or days don't fit their life. Hand-sorted, the main kinds are:

- **Rest days, sick days, holidays (26):**
  - C550 `N5#15394`, sick and kids;
  - C586 `N5#14083`, losing progress "would mentally hurt";
  - C28, C93, C207.
- **Times that move within the day (14):**
  - running late, starting the routine when they want, flexible sleep;
  - A21, A116 `P5#2411`, B574 `P65#15558`, B591.
- **Shift, night and irregular work (11):**
  - C290 `A4#1181`, 4× a week but the days change;
  - C474 `A18#816`, three shifts;
  - C302, A461 `A1#51978`, B247 `P5#2493`.
- **The day ends after midnight (6 more, plus several of the shift reviews):**
  - C131 `P8#15604`, C191 `P49#1399`, B535 `A65#385`, A287.

## 4. Do quit items belong with actions?

- **67 reviews** mention quit, avoid or limit items. **Only 8** say how such items should sit or behave next to the rest, and **all 8 want them treated differently**:
  - **No tick means success:**
    - B512 `A20#1302`;
    - B549 `A33#2689` (should start as done, change on a slip);
    - B68 `P24#9699`;
    - B184 `P3#1039` (can't tell "no" from "not yet").
  - **The tick only on a slip:** A255 `A36#53`.
  - **Shown as 0 % on a day it went well:** C368 `A31#1820`.
  - **A running counter instead of daily ticks:** C481 `A3#4843`, C560 `A3#9639`.
- **No review asks for quit items to sit in the same list as ordinary things to do.** No review asks to separate them either. What reviewers want changed is how the item *behaves*, not where it sits.
- **The "now" for a quit item is the urge.** It appears once, in A242 `A3#9329`: someone opened the app when tempted at a dinner party, and the day count stopped them drinking.

## 5. What happens when a window passes undone?

| What people want | Reviews | Examples |
|---|---|---|
| **Keep it, carry it to later or tomorrow, remind again** | **37** | Weekly task should show all week until done (A838 `P4#26144`); undone moves to the next day showing its original date (A434 `A52#3672`); a "later" that reminds again (B645 `P3#13101`); 4 of 10 push-ups today, 16 tomorrow (C62 `P3#10387`) |
| **Let me log it late or for an earlier day** | **27** | Can't tick yesterday after forgetting (B81 `P12#4244`); opened after midnight and yesterday was closed, streaks lost (C131 `P8#15604`); likes counting a tick for the day before (C354 `A23#7020`) |
| **Start each day clean** | **8** | Clear the day for a blank slate (A150 `A10#27975`); done items gone at day's end (A918 `P84#9390`). Several mean *no guilt*, not *delete* (A489, A716). One wants both: start fresh, with undone items suggested the next day (A941 `N10#22619`) |
| **Complains it vanished** | **6** | Morning habits gone when the window ends (A21 `A13#16273`); anytime habits gone from the daily view (A170 `A13#13638`) |
| **Pile-up feels bad** | **2** | Dislikes undone tasks moving to the next day by themselves (B260 `A59#3402`); wants to mark something "too late" so it goes away (A615 `A41#25`) |

**What this shows.**

- **Carrying over is wanted far more than letting things go.** 37 + 27 reviews against 2 + 8.
- **Late still counts.** People expect a habit done late, or logged the next morning, to keep its day.

## 6. How long are lists?

- **57 reviews give a number.** The median is **15**. In buckets:
  - 13 have 7 or fewer;
  - 16 have 8–15;
  - 17 have 16–30;
  - 11 have more than 30.
- Six of them say about 100:
  - A129 `A1#49418`;
  - C319 `N1#11157`, about 100 tasks, with the urgent ones pinned on top of the widget.
- Another **72** say "a lot" without a number.
- **32** keep only a few on purpose:
  - C354 `A23#7020`, limited to 6 and fine with it;
  - C431 `A76#2435`, 6 fit one view.
- **Caution:** 47 of the 57 numbers come from set A, where long lists are the topic. The random set has only 6 numbers (9, 30, 7, 100, 12, 6), too few to say what's typical.

## 7. "See it all": which question does it answer?

| Question | All | Set A (home screen) | Set B6 (random) | Set C (timing) |
|---|---|---|---|---|
| How much is left? | **94** | 81 | 3 | 10 |
| Did I forget or miss anything? | **73** | 55 | **12** | 6 |
| What's next or now? | **45** | 42 | 1 | 2 |
| What have I done today? | **43** | 39 | 2 | 2 |

**What this shows.**

- **When the topic is the home screen, "what's left" leads.** It shows up as badges, counts and widgets counting down (C431 `A76#2435`, C518 `A20#586`, C559 `A10#29857`).
- **When nobody asked, "did I forget something?" leads.** In set B6 it's 12 against 3 for "what's left". Examples:
  - medicine — did I take it?;
  - the morning routine's small parts (C199 `A5#2475`, B3 `P3#4646`).
- **People with weekly goals want the target shown too,** for example "2 / 4", not just "2" (C467 `A86#1180`, C500 `A1#45835`).

## 8. Where does heaviness come from?

| Source | All | Set A (home screen) | Set B6 (random) | Set C (timing) |
|---|---|---|---|---|
| The number of items | **78** | **68** | 5 | 5 |
| Visual busyness (cards, colours, ads, clutter) | **67** | 46 | 19 | 2 |
| Feelings (guilt, red, zeros, pressure) | **63** | 21 | **26** | 16 |
| Choices and setup (options, questions, deciding) | **42** | 18 | 20 | 4 |

**What this shows.**

- **On the home screen, it's the count.** People describe:
  - 57 tasks and too many options (A41 `A4#19937`);
  - a giant list causing analysis paralysis (A132 `A1#52115`);
  - a high "tasks left" number that made one person remove half (A0 `A10#35966`).
- **Elsewhere, it's feelings and decisions.**
  - **Feelings:**
    - a streak back to 0 after 100 days (C307 `A31#1201`);
    - a weekly goal shown as 0 % (C152 `P65#7762`);
    - "100 %" turning into compulsion, where a green light at 60 % felt like success (C509 `A18#873`);
    - one person who hates missing ticks and does a 3×-a-week habit every day (C477 `A20#3597`).
  - **Decisions:**
    - overwhelmed by options, asking "do I have to drink water at a set time?" (B504 `A24#14219`);
    - finding the time-of-day choice itself redundant (B56 `A52#16635`).
- **Some people want guilt.** "The right level of guilt" keeps one person on track (B567 `A48#420`), and a strict reset keeps another going (B401 `A70#180`). So feelings cut both ways.

## 9. Heavy in the morning, light in the evening?

Reviewers don't describe this pattern, and no review asks for a light evening. What the reviews do show:

- **Mornings come up more.** Of the 107 reviews about parts of the day, 62 mention the morning and 34 the evening, night or bed.
- **The morning is where routines and overwhelm sit.** One person found everything on one page overwhelming first thing in the morning (A345 `P3#2801`). Another had too much to do morning and evening and forgot things until routines fixed it (C453 `P45#201`).
- **People plan in the morning or the night before** (A667 `A68#4026`, A706 `P12#15077`).
- **The evening comes up for other reasons:**
  - bedtime routines;
  - things that should only appear late (A73 `P2#10764`, C406 `A48#2604`);
  - the day not ending at midnight (C191 `P49#1399`).

So this question isn't answered by reviews. The morning is clearly the heavier, more structured time, and the evening is mostly about the day's end.

## 10. Trust or lightness?

| | All | Set A | Set B6 | Set C |
|---|---|---|---|---|
| Wants everything visible, even if long | **284** | 249 | 19 | 16 |
| Accepts hiding or folding | **56** | 51 | 3 | 2 |
| Forgot something that was hidden | **11** | 11 | 0 | 0 |
| Likes done items going away | **96** | 89 | 0 | 7 |

**What this shows.**

- **Seeing everything wins, about 5 to 1** (284 to 56). Only one review takes both sides.
- **Things that were hidden got forgotten** (11 reviews):
  - below the fold (A251 `A33#3422`, A340 `P3#1589`, 50 items);
  - on another page or tab (A209 `A23#5213`, A426 `A18#889`);
  - in a smaller widget (A245 `A31#3588`).
- **The people who accept hiding** mostly do so because a long list overwhelms them. Folding or grouping makes it calmer:
  - A361 `P3#15112`, "chunks less intimidating";
  - B492 `P2#4735`.
- **The list gets lighter by finishing, not by hiding what's undone** (96 reviews). On what happens to done items, set A splits:
  - 82 want them gone or at the bottom;
  - 32 want to see what they've done;
  - 7 want both, for example sunk to the bottom but still visible (A925 `P84#15957`).

## Limits of this evidence

- **Set A was chosen because it's about the home screen,** so it inflates home-screen topics (seeing all, counts, list length). Set B6 is the fairest guide to how common something is, but it's small on most questions.
- **Set C was chosen because it's about time,** so it inflates schedules (weekly goals, weekdays).
- **One reader coded every review.** Notes in the index say what each code rests on, so any count can be checked back to exact reviews.
- **Most reviews say nothing on these questions:** 75% describe no "when" at all. The counts are what people volunteer, not a survey.
