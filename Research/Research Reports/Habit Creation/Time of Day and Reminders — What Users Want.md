# Time of Day and Reminders — What Users Want

> **Written by Claude (Claude Code)**, 27 September 2026. Replaces the "a time places the habit" rule in [Times, Day Sections and Reminders](<Times, Day Sections and Reminders — Can People Predict What Happens.md>) after the user found the built form confusing. Authorship of every report is listed in the [Research Reports index](<../README.md>).

## The questions (from the user)

1. What do people call the parts of the day?
2. Do they want one habit in several parts of the day (multi-select)?
3. Is it a binary choice (a part of the day **or** a reminder), or do they want both?
4. Do they want a part of the day **without** a reminder, and is that more than a handful of reviews?
5. Notifications, "nag until done" and alarms: what are they, and is anything missing?

## Answers

| # | Answer | Basis |
|---|---|---|
| 1 | **"Time of day."** In 9,132 reviews that mention morning/afternoon/evening/night, "time(s) of (the) day" appears in 121, "section" in 93, "part of the day" in 20 (English keyword floors). "Routine" (3,187) means a sequence, not a place in the day. Productive and Habitify, the apps most praised for this, also say "time of day". | Users show (new scan: `Habit Creation Evidence/timeofday_naming_scan.py`) |
| 2 | **Yes, for Check it off.** 153 of 1,574 section reviews (9.7%) want one habit in several parts of the day. The largest sub-group, 79 of 153 (51.6%), want the **same habit shown in each chosen part, with its own tick**; 21 (13.7%) complain they had to duplicate it. Counts ("8 glasses") are a different need: 35 (22.9%) want one row with a count. | Users show (Day Structure study §1.3, hand-coded) |
| 3 | **Both, independently.** Parts of the day without clock times are the most-praised structure (656 of 1,574, 41.7%), and people also want exact reminder times (137 of 1,574, 8.7%; 31 of them a reminder at an exact time). Reviewers of Productive, where time of day comes first and exact times second, ask for both at once. | Users show (Day Structure study §1.1, §1.4; `timeofday_need_scan.py`, all 83 hits read) |
| 4 | **Yes, and it's the majority behaviour, not an edge case.** The 656 section-praise reviews come mostly from Productive and Fabulous (402, 61.3%), where a habit sits in a part of the day with no notification needed. Being forced to set a time or reminder draws 1★ reviews (at least 18 in the new scan, e.g. `P126#17701`, `P126#18298`, `A8#819`, `P12#65520`). Tiimo's own reviews show the opposite gap: untimed to-dos can't be reminded at all (Tiimo #16). | Users show |
| 5 | Mostly right (see below). | Platform facts |

**What the three alert types are.**
- **Notification:** one banner, with a sound unless the phone is on silent or in a Focus. Shows once. ✔
- **Remind again until done ("nag"):** the same notification repeated, e.g. every 15 minutes, until the habit is ticked (we cap it at 3 repeats). ✔ It's still a notification, so it respects silent mode.
- **Alarm (iOS 26, AlarmKit):** full screen, rings even on silent or in a Focus, until stopped. ✔
- **Not in the list, and why we don't use them:** *Time Sensitive* notifications (break through a Focus as a banner; a surprise if not chosen), *Critical Alerts* (Apple approval, medical use only), a *Live Activity* (a card that stays on the Lock Screen until done; a possible later feature), the *app badge* count, and a *daily summary* notification.

## The design this leads to

*Reasoned from first principles, on the evidence above.* The first build let a reminder time move the habit, and replaced the time-of-day control once a time existed. The user found that confusing, and it is: one control did two things, and a control changed shape. So:

1. **Time of Day decides where it shows, and nothing else does.** Large tappable options (Anytime, Morning, Afternoon, Evening, your own, + New), always visible and editable. Anytime is the default.
2. **Multi-select only where it means something:** Check it off on a set schedule says "Pick one or more." and shows a tick on each chosen part (a tick in each on Today). Other types say "Pick one."
3. **Reminders are a separate, optional switch (off by default).** Turning Remind Me on adds one reminder per chosen time of day, at a time inside it (Morning → 7:00 AM, Evening → 7:00 PM, Anytime → 9:00 AM), labelled "Morning reminder", "Evening reminder". Reminders follow the chosen times of day until the user edits one. A reminder never moves the habit; if the user sets one in another part of the day, the sentence says so.
4. **Alert and "If Not Done, Remind Again"** appear only once Remind Me is on (progressive disclosure).
5. **A plain sentence under each group**, at a readable size, rewritten live: "It shows in Morning and Evening, with a tick in each. The day is done when both are ticked." / "A notification at 7:00 AM and 7:00 PM on days it's due. None for a tick you've already done."

## Limits

- Scan counts are keyword floors in English; the Day Structure numbers are hand-coded but come from 5,066 reviews that discuss day structure, not all reviews.
- Tiimo's Play corpus is small (223 reviews); it's used only as a pattern check, not for counts.
- Whether people predict the new form correctly is untested; the five-person test in the earlier report still applies.

## Addendum: which apps let one habit happen several times a day, and how it works (27 Sep 2026)

**Method.** The 153 hand-coded "one habit in several sections" reviews (Day Structure study, code TM) were grouped by app and re-resolved by review ID (their stored line numbers no longer match the corpus files; all 153 resolve by ID). Then every review of Productive, Habitify, Habit Tracker (Davetech), Streaks, HabitNow, Fabulous and Me+ matching "twice a day / N times a day / morning and evening / multiple times" was read (`timeofday_multi_section_by_app.txt`; scan in `Temp/timeofday/howitworks.txt`). The apps' help pages (Habitify's Time of Day article) don't describe this, so how each app works is taken from its users' own descriptions. *Users show.*

| App | How it works (as users describe it) | What users say |
|---|---|---|
| **Productive** | A yes/no habit can be done **1 to 3 times a day**; each time sits in Morning, Afternoon or Evening, with its own reminder and its own swipe | The only app praised for this at scale (9 of the 17 "an app already does it" reviews). "schedule an individual habit for multiple times a day instead of having to create the same habit 3 times" (`2284758864`); "Some task you gotta do it twice in a day. Like morning and evening" (`1300549370`); "flossing two times a day" (`1309645596`). Main complaint: **the cap of 3** (one per part of the day); people with 8 glasses or frequent posture checks want a real count (`3525950406`, `1478094094`, `4239834531`) |
| **Streaks** | A task has "times per day"; each tap fills part of the circle. No parts of the day | Liked for teeth and flossing ("brushing my teeth three times per day", `4855052326`). Complaints: all-or-nothing history ("a 'twice or nothing' mindset", `9613837462`), extras above the goal can't be logged (`1632467480`). Earlier users asked for exactly this: "push once to fill the circle ½ way, and then again for the other half" (`1303958312`) |
| **Habit Tracker (Davetech)** | A count goal ("X times a day") with **one** time range (morning or evening) | Praised: "I can some twice per day and check off one by one, also… say if it's a morning/afternoon/evening habit" (`10506674209`). Asked for: both morning **and** evening on one habit (`7435724052`, `12153698414`, `8130768295`, `7838880865`). Complaint: the check button marks every instance done at once (`12463084332`) |
| **Habitify** | Earlier: one time of day per habit. Later: a habit can be split into AM / PM / night with separate alerts | Early asks: "can't choose both morning and evening" for vitamins (`2765961302`, `2917668175`). Later praise for splitting, with bugs: the watch marks both done at once (`7273250234`); "allows multiple times per day… doesn't allow you to complete the habit for each time" (`1833153877`) |
| **HabitNow** | A number goal in your own unit, logged in pieces; no parts of the day | "10 minutes three times a day toward 30" (`2ace8ebf…`) |
| **Fabulous** | The same habit is placed in several routines (morning, afternoon, evening) | "drink water (morning, afternoon, and evening)" (`8789286657`) |

**What this shows.**
1. **The pattern people praise is Productive's:** a habit you tick, done a set number of times a day, each time in its own part of the day, with its own tick and reminder. Nobody praises having to pick a different habit type for it.
2. **Its known weakness is the cap.** Tying "times a day" to one per part of the day stops at 3, and people also need plain counts (8 glasses) that aren't tied to parts of the day.
3. **The failures in other apps are about the tick, not the idea:** one tap marking every instance done (Habit Tracker, Habitify's watch), and all-or-nothing history (Streaks).
4. **People describe these habits as ticks done N times**, not as amounts ("set the required frequency to 2", `1300335259`).

**Correction: Productive changed its model.** Productive's own help pages ([How to create a habit?](https://support.productiveapp.io/hc/en-us/articles/26920632424081-How-to-create-a-habit), updated about a year ago; read 27 Sep 2026 in a browser) describe today's app as: a **Goal** of "a number of entries" with a unit ("time, min, glasses, pages, and miles"), and **one** part of the day ("By default… 'Any time of the day', but you may decide to do it in the morning, afternoon, or evening"). The "1 to 3 times a day, each in a part of the day" model praised above is from reviews dated **2015–2020** (`1300549370` Dec 2015 … `5527828164` Feb 2020). Complaints about its cap of 3 run from 2016 to 2020 (`1478094094`, `3525950406`, `4239834531`, `4903277417`); by 2023 reviews describe a count instead ("4 sessions of 30 min per day", `9545448984`). So the one app praised for "a tick in each part of the day" replaced it with **a count plus one part of the day**, apparently because people needed more than one tick per part. Since 2025 Productive also shows a paywall before the app can be used, and custom habits need a subscription (`13827840432`, `13183864355`), so its current flow couldn't be tried without subscribing.

## Addendum 2: one exclusive option plus several that combine — how established products do it (27 Sep 2026)

The user tried Productive and Habitify directly:
- **Productive:** three checkboxes (Morning, Afternoon, Evening), where each tick adds "complete habit N times a day", plus a separate "any time" checkbox whose effect isn't explained.
- **Habitify:** the form row says Anytime, but the pushed screen opens with all three parts ticked and has no Anytime option.

Neither makes the rule visible. The underlying problem is generic: **one exclusive choice (Anytime) plus several choices that combine, with a way to add more.**

| Product | Pattern | Evidence it works |
|---|---|---|
| **GOV.UK Design System, checkboxes with a "none" option** | The combinable options first; then a divider with the word **"or"**; then the exclusive option **last**. Ticking the exclusive option **automatically unticks** the others. A message appears only in the no-JavaScript case ("Select countries…, or select 'No…'") | A public design system whose components are tested with users; it states the exclusive option exists because "leaving all boxes unchecked" is ambiguous ([GOV.UK checkboxes](https://design-system.service.gov.uk/components/checkboxes/)) |
| **Apple Clock, alarm Repeat** | Only the combinable options (Every Monday … Every Sunday) with checkmarks; **nothing ticked means the exclusive state**, shown on the row as "Never"; the row summarises picks ("Weekdays", "Every Day") | Simple, but users look for an explicit option that isn't there ([Apple Community: "No 'daily' option for repeat alarm"](https://discussions.apple.com/thread/252446455)) |
| **Apple Health, Medications** | Choose the mode first ("As Needed" vs a schedule), then add several times | Two steps; suits medication, heavy for a habit form (platform pattern, from the earlier report) |

*Reasoned from first principles, on these patterns:* use GOV.UK's tested structure inside the native control the form already uses for How Often (a row that opens a menu). Parts of the day are ticked, then an "or" divider, then Anytime. Picking either side clears the other automatically, so there's no error or pop-up to read; the divider and the live sentence explain the rule. Keep Apple's summary on the row ("Morning, Evening"; "Anytime").

## Addendum 3: does "one Goal row" hold up? Ticks vs amounts (27 Sep 2026)

**The rule under test:** every habit you build has a Goal: *a number, a unit, per day*.
- 1 time: a plain tick.
- 2 or more times: a tick each time, with partial progress.
- Any other unit (glasses, pages, steps): a counter.
- Minutes: a timer.

**Method.** A scan of all habit-app reviews (`goal_unit_tick_scan.py`):
- (A) people who want a single tick, or who resent having to enter an amount. All 46 hits were read.
- (B) people who want amounts or partial credit instead of yes/no. 275 hits: three sub-patterns counted, 7 of each read.

Plus ledger cards C265 and C048. *Users show; keyword floors.*

**Findings.**
1. **Nobody asks for "a unit but only a tick".** Among the 46 A-hits, the four on-topic reviews point the other way: they want the simple tick as the default, with amounts tucked away.
   - "you can't just have go to the shops, it has to be go to the shops 0/1 very annoying" (`14242754352`, Habit Tracker, 2026);
   - "there are times when I want to simply want to check a box with the more detailed options hidden away" (`13197600650`);
   - "certain goals be x number of times a day and others just be a simple yes or no" (`08d493ca…`, praise);
   - one-click "done" on a numeric target (`7521539649`, Strides).
   The other 42 are about ads, onboarding and pop-ups.
2. **Amounts are wanted by a large group.**
   - Ledger C265: Strides' non-yes/no trackers are praised in 485 reviews, and Way of Life has 129 requests for counts ("In my life things aren't always yes or no").
   - C048 (flexible units and partial progress): 25 apps.
3. **Partial credit for "N times a day" is wanted** (33 hits across 22 apps): e.g. teeth only in the morning "is as good as not doing it at all" (`8112114156`, Streaks), and "100 push-ups… in sets of 25" (`03c7b989…`, Loop).
4. **Separate tracker types confuse people at setup.** Strides' four types draw 118 confused reviews in every era (C265), which supports one Goal row over several types.

**What this means for the design.**
- The rule holds: 1 time is a tick, anything else counts.
- Two safeguards follow from the evidence:
  - (a) a 1-time habit shows **no "0/1"**, just the tick. Our current rows show "0/1" and should change.
  - (b) an amount habit also offers **"Mark as Done"** (fills the day's goal in one tap) via its context menu, for days when someone just wants it done.
- The Goal row's footer states the rule: "Leave it at 1 time for a simple tick. Change it to count something."

## Addendum 4: numbers beyond whole counts (27 Sep 2026)

**Scan:** `goal_numeric_scan.py`, habit-app reviews. The broad decimals pattern was mostly noise (prices, "1.5 months"), so the reviews that use the word "decimal" were read in full: 39 hits, about 30 on topic, in about 15 apps. Variable-amount hits (23) and readings (145, mostly Me+ sleep features) were sampled. *Users show; keyword floors.*

| Need | What users say | Where our build stands |
|---|---|---|
| **Decimals** for distance, hours, litres, weight | "if you walk 0.5 miles you're forced to either not track it or round up" (`12250094565`, HelloHabit); "I can't log 3.25, it has to be a whole number… I'm leaving mainly cause I can't enter decimals" (`29c27a7d…`); "on the days i sleep 7.5 hours, i have to either log 7 or 8" (`1521d131…`); "I want to buy app but I can't until decimals" (`43df67c2…`) | The form already accepts decimals (decimal keypad, stored as decimals). **But** `Format.amount` shows only one decimal place, so 0.25 L shows as 0.2 or 0.3. Fix: up to two decimal places, trailing zeros trimmed |
| **No decimals where they make no sense** | "Why does the habit target… ask for decimal input? …10 pushups… not 12.5" (`bdd98a03…`); "disable decimals on specific habits" (`6a1bb9fe…`); decimals in the widget "look very ugly" (`e05c1ddb…`) | Show whole numbers when the value is whole, which already happens; never show "8.0" |
| **Hours and minutes, not decimal hours** | "3 hours and 52 minutes as 3.86 hours which needs to change" (`be0f2bca…`, Loop); "1.30 + 1.40 is according to app 2.70 while it is 3.10" (`c7c2ffdc…`) | Time it stores minutes. Show totals as "1 h 25 min", never as decimal hours |
| **Logging any amount, not just the fixed step** | Praised: "you can enter any amount you want… someday 45m the other 1h25m" (`10430445130`, Habit Tracker); "input the exact amount… word count" (`13735167844`); asked for: an "Other" amount on the watch (`7016174636`) | Missing: + only adds the fixed step. Add "Add Amount…" (type any amount, e.g. 3.2 km) in the row's long-press menu, and allow going past the goal ("track 6.6 km on a 5 km target", `768ca624…`) |
| **Readings** (weight, mood score, hours slept as a value) | "I want to track my weight, I cannot submit decimal value" (`12510608360`); a mood scale around zero (`28f6ce69…`) | Not covered, and not a sum toward a daily goal. A separate kind (latest value or average, like Strides' "Average"). Out of scope for now; recorded as a gap |

## Addendum 5: HabitNow's two-step "How do you want to evaluate your progress?" (27 Sep 2026)

**The flow** (user's screenshot, 27 Sep):
- **Step 1:** + asks habit, recurring task or task.
- **Step 2:** "How do you want to evaluate your progress?"
  - With a yes or no: "Record whether you succeed with the activity or not".
  - With a numeric value: "a value as a daily goal or limit".
  - With a timer.
  - With a checklist (premium).
- **Steps 3–4:** details and schedule, with page dots.

**How its users react** (all 29,021 HabitNow Play reviews, pattern-matched and read; *users show, keyword floors*):
- **Praise for having the choice (16):** "i can choose beetween yes/no or counting" (`055c4f61`); "simple yes/no, to specific number like 5 L of water or 6 Eggs" (`eef88a65`).
- **Confusion about the choice itself: none.** The 2 hits are about the timer's mechanics.
- **The main complaint is that the choice is locked (11):** "Like I used to track my 'Walking' with yes or no, but later i wanted to track it by steps… I had to create a new habit" (`7affe8d1`); "When I start building a habit, I just like to make sure I get it done in a day. As my discipline improves, I like to star[t counting]" (`80a1fa00`); "I've had to delete and create new 1s" (`7e42b892`).
- **Contrast with Strides** (C265): four abstract types (Habit, Target, Average, Project) draw 118 setup-confusion reviews. HabitNow's concrete choices (yes/no, number, timer, checklist) don't.

**Conclusion.** One question per screen, with concrete choices, captures intent without confusing people. Three weaknesses to fix:
1. The wording "evaluate your progress" and "numeric value" is abstract.
2. The choice is locked after creation.
3. Page dots make it feel like a wizard. That's *reasoned*: it's one more screen for every habit.

Our fix: the same two questions in plain words, as native pushed lists, and the choice only **pre-sets** the Goal row, which stays editable. That solves the lock complaint by design.

## Addendum 6: plain words for the New flow (27 Sep 2026)

**Source:** 246,230 English habit-app reviews (App Store and Play), counting reviews that contain each phrase (`Temp/timeofday/plain_words.py`, copied to `Habit Creation Evidence/`). Reddit was tried through the browser, the fetch tool and web search; all three were blocked or returned no Reddit threads, so it isn't used. *Users show; phrase counts, not hand-coded meanings.*

| Choice | Phrases (reviews) | Chosen |
|---|---|---|
| First question, build | good habit 4,389 · new habit 3,816 · build a habit 2,471 · form a habit 521 | **A good habit** |
| First question, stop | bad habit 2,411 · quit 1,455 · break a habit 481 · cut down 87 | **A bad habit**; then **Quit** / **Cut down** |
| First question, task | task 19,440 · to-do 3,568 · chores 2,045 · recurring task 177 · one-time task 115 | **A task** (once or on repeat) |
| Tick | check off 2,302 · tick off 536 · mark as done 364 · yes or no 358 · done or not 29 | **Check it off**, "Done or not done." |
| Number | count 2,491 · amount 2,436 · how much 1,869 · how many 1,613 | **Count it**, "How many or how much." |
| Time | minutes 2,480 · timer 1,914 · how long 795 | **Time it**, "How long, with a timer." |
| List | checklist 1,317 · list of 279 · subtasks 143 | **Checklist**, "A short list to tick off." |

The questions use the plainest form that non-native speakers can follow: "What do you want to create?", "How do you want to track it?", "What do you want to do?". HabitNow's "How do you want to evaluate your progress?" was judged too abstract (addendum 5).
