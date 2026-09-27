# Times, Day Sections and Reminders — Can People Predict What Happens?

> **Written by Claude (Claude Code)**, 27 September 2026. Follows [New Habit Round 4](<New Habit Round 4 — Checklists, Streaks and Times a Day.md>) §3 and replaces its "Day Section menu takes several sections" rule. The implementation spec is [iOS/Pending to Implement.md](<../../../iOS/Pending to Implement.md>). Authorship of every report is listed in the [Research Reports index](<../README.md>).

**The questions.**
1. The user's idea: drop the Day Section choice. A habit shows in the day section that its reminder time falls in (a reminder at 7 AM puts it in Morning). A habit with no reminder goes to Anytime. Is that right, and is it intuitive?
2. When someone creates a habit, can they tell exactly how it will behave later: where it shows, on which days, when their phone will alert them, and what happens if they don't do it? This covers the whole New Habit screen, not only this change.
3. Alarms, notifications and "nag until done" reminders: how should they work so people can predict them?

**Basis.**
- **New scans of about 1.03M App Store and Play reviews** (every habit corpus). The scripts and hits are in `Habit Creation Evidence/placement_scan*.py` and `placement_hits*.json`. Every quote below was re-read from `reviews.jsonl` with `placement_quotes.py`. IDs have the form `A13#15552`: store A (App Store) or P (Play), app folder 13, line 15552.
- **The hand-coded Day Structure study** ([Explained in Plain English](<../Day Structure and Organization/Habit Tracker — Day Structure Explained in Plain English.md>) §1.3, §1.4, §1.7, §1.10).
- **Feature Ledger cards:** C039 (reminders fire reliably, once), C123 (few, controllable notifications), C258 (nag until done), C014 (several reminders), C252 (complete from the notification), C074 (louder sounds), C276 (a time separate from the reminder), C073 (order), C075, C142 and C217 (comprehension), C006 (stay minimal), C288 (a way back from denied notifications).
- **Apple's platform facts:** notification interruption levels, the Critical Alerts entitlement, AlarmKit in iOS 26, and the Health app's Medications schedule. These are used as platform facts and pattern references, not as authority.
- **The current code:** `NewHabitView.swift`, `HabitStore.swift`, `ReminderScheduler.swift`, `TodayView.swift`, `DaySections.swift`.

Each point below says what it rests on: **users show** (review evidence), **reasoned from first principles**, or **platform fact**.

---

## The short answer

| Question | Answer |
|---|---|
| Is "the reminder decides the section" right? | **The core is right; the wording and one rule need changing.** A **time** should decide the section. A reminder at that time is a switch, **on by default**. With no time, the user can still pick a section, and Anytime is the default. |
| Is it intuitive as first proposed? | **Not fully.** Four things would surprise people: (1) the word "Reminder" says *notification*, not *where it shows*; (2) a habit in Morning would force a notification; (3) the section control would appear and disappear; (4) nothing on the form says what happens later. |
| What makes it predictable? | **One control, one effect, stated in words next to it.** Time → where it shows. Remind Me → a notification at that time. Alert → notification or alarm. Remind Again → repeats until ticked, with a limit. A live sentence under each group says what will happen. |
| Alarm vs notification | Offer both per habit: **Notification** (default) or **Alarm** (iOS 26 AlarmKit: rings on silent and in Focus, full screen, snooze). Say so in plain words, because an alarm that rings on silent is a surprise if nobody warned you. |
| Nag until done | **"Remind Again" if not done:** every 15 / 30 / 60 minutes, **up to 3 more times**, stopping the moment it is ticked. |
| The rest of the form | Mostly predictable already. Five gaps: no "first due" date, no word on how Today shows weekly habits, nothing on when reminders stop, Quit doesn't say where it shows, and Time it doesn't say how it's logged. Each has a one-line fix (§5). |
| Is it confirmed? | **No.** It is reasoned and evidence-backed, not tested with people. §6 gives a five-person "predict the outcome" test with a pass bar. Run it before building beyond the form. |

---

## 1. The test: can they predict it before tapping Add?

*Reasoned from first principles.* A form is predictable when, looking at it and nothing else, a person can answer five questions correctly:

1. **Where** will it show on Today?
2. **On which days** will it show?
3. **What counts as done**, and what happens after that?
4. **When will my phone alert me, and how?** (a banner, a sound, an alarm)
5. **What if I don't do it?** Will it keep reminding me, and until when?

The usual ways to make this work are:
- **Feedforward:** say what will happen before the person commits.
- **One control per effect:** a switch changes one thing.
- **No hidden state:** nothing changes that the screen doesn't show.
- **The person's own words.**

Reviews show what happens when this fails:

- **Placement and reminder disagree:** “I set a habit for the afternoon and It doesn't allow me to choose the time I want it to remind me at. I got a notification at 10am when I was still asleep” (`A53#1416`, HabitMinder, 2★). Also “I purchased the upgrade so I could schedule an evening reminder for 10:30 pm, yet it still reminds me at 7:30 as well” (`A13#2483`, Productive). **Our current build allows the same contradiction:** Day Section and Reminders are separate controls, so a habit in Evening can have a 7 AM reminder.
- **A habit isn't where they expected, and nothing said why:** “none of my habits appear on the other days. No idea why.” (`A33#2711`); “I have one set for 1x a week, I completed it yesterday and it's in my list again today” (`P2#12230`).
- **Ledger:** unexplained rules read as broken (C217, 8 apps). Features people can't find are rated as missing (C142, 24 apps). Setup confusion is a 1★ driver (C075, 37 apps).

## 2. The idea under test, and what changes

### 2.1 What is right about it

- **One source of truth.** Where a habit shows and when it reminds can no longer disagree. That removes the `A53#1416` failure.
- **It matches how people talk.** "I take it at 7" already says "morning". The Day Structure study found **59 of 137** "sections are too coarse" reviews want the habit at a specific clock time. One reviewer suggests exactly this model: sections as time ranges that contain habits with exact times (N22). *Users show.*
- **It unifies "several times a day".** Two times put the habit in two sections, with a tick in each. This covers the 79 "show it in several sections" and 32 "several reminders" requests in one gesture (§1.3 of the study). *Users show.*
- **It sorts Today by time.** “organize the dailies… according to the reminder times… (Ex. Morning tasks at the top of the list.)” (`P8#4300`). Ledger C073: two of four reviewers in one report ask to sort by reminder time. *Users show.*

### 2.2 What would surprise people, and the fix

| As first proposed | Why it surprises | Fix | Basis |
|---|---|---|---|
| The control is called **Reminder**, and it also moves the habit | "Reminder" means *my phone will buzz*. Moving the habit is a side effect the word doesn't predict | Call the rows **Time**. Their label shows the section (“Morning  7:00 AM”). Reminding is its own switch, **Remind Me**, on by default | First principles (one control, one effect). Apple's Health Medications uses the same split: scheduled times group the Log list, and reminders are a separate setting (platform pattern) |
| **No reminder → Anytime**, so being in Morning means getting a notification | People who want sections but not pings are punished | With no time, a **Day Section** picker remains (Anytime by default). With a time, Remind Me can be switched off | *Users show:* forced time or forced notification draws 1★ reviews: “Now you have to enter a time and get a notification too… I don't want a notification for them either” (`P126#17701`, 1★); “i am now forced to pick a time for all tasks. I DONT WANT TO DO THAT” (`P126#18298`, 1★); “The only flaw is that you have to set a reminder for a habit” (`A8#819`); “some habits that dont have an exact time and I don't want to be reminded about” (`A8#821`). Section-without-a-time is praised: “add activities for a time of the day and not a specific time” (`A13#15552`); “separated into morning, evening and night tasks rather than demanding a specific time” (`A13#12038`); “prevents the 'missed the start by a minute, guess I won't do it at all' issue” (`P49#1515`) |
| A morning routine of 6 habits means 6 reminders | 6 buzzes at once | Habits due at the **same minute share one notification** (“Morning · Meds, Stretch +4”) | *Users show:* “5 for a single morning is ridiculous” (`P12#16262`); “multiple reminders for morning activity” (`A24#28047`, 1★); “I would have alarms going off all day. That would drive me insane!” (`P84#20831`). But separate times must stay separate: “I don't want to be reminded to deeply focus on work and do yoga at the same time” (`A24#42607`). Apple pattern: Health groups medications set for the same time into one entry and one notification |
| The section row **disappears** once a reminder exists (my first hybrid) | A control vanishing is hidden state | The **Day Section** row always stays. With times it becomes read-only, lists the sections (“Morning, Evening”), and the footer says “Set by the times below” | First principles (no hidden state) |
| Nothing on the form states the outcome | People guess | A **live sentence** under the When and Reminders groups (§3.2) | Ledger C217, C075; `A53#1416` |

### 2.3 How big is the "section, no notification" group?

The user asked whether this is a small, very custom case that can be ignored. **It isn't, and it doesn't need to be large to matter.** The only way to support it is to keep the section picker for habits without a time, and that is an existing control that costs nothing new.

- *Users show:* in two targeted scans (58 hits, all read), **at least 10 reviews** prefer a part of the day to a clock time, and **at least 12** complain about being forced to set a time or reminder. The IDs are in `placement_hits2.json` and cited above.
- *Users show:* notification fatigue is common. 741 reviews match "too many / turned off / don't want notifications", and Ledger C039 reports 744 on notification volume in one app (Fabulous). Mixed signal: many of these are about marketing pushes, not habit reminders.
- *Users show:* the Day Structure study found 656 reviews praising sections. The strongest praise is for Productive, where free users pick morning, afternoon or evening with no clock time (C008: exact clock times were its most resented paywall).

## 3. The design

### 3.1 The form, top to bottom

```
[icon] Name                                   ← unchanged
Colours                                       ← unchanged
How Often   Every Day ▾                       ← unchanged; footer gains "First due …" (§5)
<type's goal section>                         ← unchanged; small footer fixes (§5)

WHEN
Day Section          Anytime ▾                ← picker while there are no times
⊖ Morning                         7:00 AM     ← each time; label = the section it lands in
⊖ Evening                         9:00 PM
⊕ Add Time
  footer: live "where and when" sentence

REMINDERS                                     ← only once there is at least one time
Remind Me                              [on]
Alert                         Notification ▾  ← Notification · Alarm (iOS 26+)
Remind Again If Not Done              Off ▾   ← Off · Every 15 min · Every 30 min · Every hour
  footer: live "what your phone will do" sentence
```

- **With no time:** Day Section is a normal menu (Anytime, the user's sections, New Section…). It is a **single choice** for every type. To do something twice a day, the user adds two times; that replaces the multi-select menu from round 4. The REMINDERS group is hidden, because there is nothing to remind at.
- **With a time:** the Day Section row stays, read-only, listing where the habit will show. The picker is replaced, not hidden.
- **Removing the last time** sets Day Section to the section that time was in, so the habit doesn't jump to Anytime.
- **Default when a time is added:** Remind Me is on, Alert is Notification, Remind Again is Off. This is the user's original idea in one tap: add 7:00 AM, and it's in Morning and reminds you at 7.
- **Permission:** notification permission is asked when the first time is added with Remind Me on (as today). Alarm permission is asked when Alarm is first chosen. If a permission is denied, the footer says so and offers **Open Settings** (C288).

### 3.2 The sentences (feedforward)

Generated from the choices and updated live. Examples:

| Choices | WHEN footer | REMINDERS footer |
|---|---|---|
| No time, Anytime | “Shows in Anytime on Today. Add a time to place it in a part of the day.” | (hidden) |
| No time, Evening | “Shows in Evening on Today (6:00 PM–12:00 AM). No reminder.” | (hidden) |
| Check it off, 7:00 AM + 9:00 PM | “Shows in Morning and Evening, with a tick in each. Done for the day when both are ticked.” | “A notification at 7:00 AM and 9:00 PM on days it's due. None for a time you've already ticked.” |
| Same, Remind Again every 30 min | same | “…If not ticked, reminds you again every 30 min, up to 3 more times.” |
| Same, Alert: Alarm | same | “Rings like an alarm, even on silent or in a Focus, until you stop or snooze it.” |
| Remind Me off | same | “No notifications. The times only place it on Today.” |
| Count an amount, 9 AM / 12 PM / 3 PM | “Shows once, in Anytime: an amount adds up across the day, so it isn't split.” | “A notification at 9:00 AM, 12:00 PM and 3:00 PM until you reach 8 glasses.” |
| A Few Times a Week, 7 PM | “Shows in Evening every day until you've done it 3 times this week.” | “A notification at 7:00 PM each day until the week's 3 are done.” |
| Set a limit, 8 PM | “Shows in Evening.” | “A notification at 8:00 PM each day it's due.” (Remind Again is hidden: a limit is never "not done".) |

### 3.3 Placement rules (one place in code, used everywhere)

*Reasoned from first principles, with the Today fold rule in mind.*

1. **A time's section** is the timed section whose range contains it: `start ≤ t < next start`, and the last section runs to its own end.
   - A time **before the first section's start** (5:30 AM when Morning starts at 6) belongs to the **first** section.
   - A time **after the last section's end, before the day ends** (1 AM with the day ending at 3 AM) belongs to the **last** section.
   - If there are **no timed sections** at all, the habit goes to Anytime.
2. **Check it off on a set schedule** (Every Day, certain days, every few days/weeks, dates of the month) gets **one row per section** that holds one of its times, with a tick in each. This is round 4's rule, now driven by times. Several times in the same section are **one row**; the later times re-remind for that row. *Users show:* the second reminder is often a nudge, not a second time: “I only need one 'ding', but other habits I need to be interrupted multiple times” (`A43#529`).
3. **Everything else** (amounts, Time it, limits, checklists, and any "A Few Times a Week/Month/Year" or weekly/monthly total) is **one row**. It goes in the section of its times if they all fall in one section, **Anytime** if they spread across sections, or the picked Day Section if it has no time.
   - Why not the first time's section? *Reasoned:* Today folds unfinished sections that aren't Now. A water habit filed under Morning would be folded away by 3 PM, while Anytime stays open.
4. **Placement is worked out when shown, not saved.** Editing a section's start time moves timed habits with it. That is the promise of time-based sections, and the Day Sections footer says so.
5. **Within a section:** timed rows sort by time, untimed rows follow in their saved order. Manual reordering within a section is a separate task; when it lands, a drag wins and sticks (C073).
6. **Today shows the time on the row** (“0/1 · 7:00 AM”), so Today itself explains why a habit is where it is. *Users show:* N24, N25 (show the time; sort by it).

### 3.4 Reminder behaviour

| Rule | Basis |
|---|---|
| Fires only on days the habit is due, only for its own row's time, and **never for a row already ticked** | *Users show:* firing after completion is the top reminder complaint (C039, 42 apps). The current scheduler stops everything once the whole day is done; this narrows it to the row |
| Same minute, same alert style → **one notification** listing the habits; one habit → its own notification | `P12#16262`, `A24#28047` vs `A24#42607` |
| **Remind Again If Not Done:** 15 / 30 / 60 min, **up to 3 more times**, cancelled the moment the row is ticked | *Users show:* C258 (Strong, 5 apps). “Best feature by far is the nag me until Im done option” (Report 43); “if I don't do it by that time, I get a new notification every 1 hour or so until I mark it as done. I don't want to set such reminders manually” (`P2#2708`). The cap of 3 is *reasoned*: it keeps the promise stated in the sentence, fits the 64-notification iOS limit, and respects C123's "escalation opt-in, never spammy". Apple pattern: Health's Follow Up Reminders send one more after 30 min |
| Limits (“Set a limit”) never re-remind | First principles: a limit has no "not done" |
| Mark done from the notification (single-habit notifications): **Done**, and **+1 unit** for amounts | Ledger C252 (Strong, 7 apps) |

### 3.5 Alarm vs notification

**What users show.** Of 75 "alarm instead of notification" keyword hits (all read), **at least 13** ask for an alarm-style reminder and **5** praise apps that offer one:
- “something like an alarm that would go off until I did it” (`A13#12563`);
- “Like an alarm or something similar, that I need to stop or snooze. At the moment it is just a notification that I might not even see” (`P12#49280`);
- “The 'alarms' are just notifications that quietly pop up… I need like a real alarm” (`P4#11611`);
- “an alarm option (for example some days I have a lot of notifications and I mute everything but alarms)” (`P3#12581`);
- “I really like the option of either a notification or an alarm… having to have phone on silent it helps to have a alarm flashing” (`P84#23892`);
- “alarm option for the highest priority reminders” (`P84#17536`);
- “when it's best to use Alarm instead of notification for hourly recurring tasks (such as Medication) whereas Notification is suitable for daily” (`P84#21381`).

**The failure to design against is an alarm nobody expected.** “Alarms are ringing even though in silent mode. This bug make me failed in my 3rd attempt of driving online exam test” (`P2#9368`). Ledger C123: “Some users depend on an un-dismissable alarm, others are driven out by it; a global default serves both badly.”

**Platform facts:**
- **Notifications** have interruption levels. *Active* lights the screen and can play a sound, but respects silent mode and Focus. *Time Sensitive* breaks through notification controls such as Focus ([Apple: UNNotificationInterruptionLevel](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel)).
- **Critical Alerts** play a sound on mute and in Do Not Disturb, but need an **entitlement Apple must approve** ([Apple: critical-alerts entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.usernotifications.critical-alerts)). Not available to a habit tracker by default.
- **AlarmKit (iOS 26)** gives third-party apps real alarms: “alerts that always activate even if Silent mode or a Focus mode is enabled”, full-screen snooze and stop, the Lock Screen, Dynamic Island and Apple Watch. It needs the user's permission ([MacRumors](https://www.macrumors.com/2025/06/11/ios-26-third-party-alarm-apps/), [Apple: AlarmKit](https://developer.apple.com/documentation/alarmkit)).
- The app's minimum is iOS 18 (`iOS/README.md`), so Alarm exists only on iOS 26 or later.

**Recommendation.**
- **Alert: Notification** is the default. It is a standard *active* notification that respects silent mode and Focus.
- **Alert: Alarm** (iOS 26+) uses AlarmKit. Below iOS 26 the option isn't shown; a dead option is worse than none.
- **Time Sensitive is not used.** Breaking through Focus is exactly what Alarm offers when chosen; doing it silently would be the `P2#9368` surprise.
- The choice is **per habit**: medication rings, flossing buzzes (`P84#21381`).
- The Alarm footer **says it rings on silent and in Focus**, before it ever does.
- An alarm's **Stop doesn't mark the habit done**. It says so, and offers “Done” on the alarm where AlarmKit allows a secondary button.
- Remind Again uses the same style as the first alert.

## 4. Why "Time + Remind Me" rather than "Reminder decides"

Both place the habit by time. The difference is the words and one switch.

| | "Reminder decides" (as proposed) | "Time decides, Remind Me switch" (recommended) |
|---|---|---|
| What the word predicts | a notification | where in the day it goes |
| In a section without pings | only by picking a section (no time) | a section, or a time with Remind Me off |
| Twice a day without pings | not possible | two times, Remind Me off |
| Rows added to the form | 0 | 1 (Remind Me), plus Alert and Remind Again when on |
| Matches | the user's idea | the user's idea + C276 (a time distinct from its reminder: 471 scheduling requests in one app, 186 of them for a time on the item) + Day Structure §1.4 (59 want a clock time on the habit vs 31 want a reminder at one) + Apple's Health Medications split |

The extra rows sit under REMINDERS, which only appears once a time exists (C006: additions are opt-in).

## 5. The rest of the New Habit screen: can people predict it?

Each row answers: what someone sees, what they'd predict, and whether that's right.

| Part | Predictable today? | Gap | Fix |
|---|---|---|---|
| **New list** (7 types, each with "Example: …") | Yes. Words come from reviews (round 2 and Words and Units) | The one-line summary (“Done or not done.”) is only read by VoiceOver | None needed. Examples teach better than definitions; keep the list fitting on an iPhone SE |
| **Icon, name, colour** | Yes: the icon previews live and suggestions change as you type | — | — |
| **How Often** | Mostly: every rule has a plain sentence, and the two groups are named | (a) A set schedule not due today looks like a lost habit (`A33#2711`). (b) Period rules don't say how Today shows them (`P2#12230`) | (a) Add “First due Thursday, 2 Oct.” when that isn't today. (b) Period rules add “Shows on Today every day until you've done it N times this week.” |
| **Count an amount / Set a limit** | Yes: “Each tap on + adds 1.” / “It counts while you stay at or under the limit.” | — | — |
| **Time it** | Partly: no footer | How it's logged | “On Today, ▶ starts a timer; it counts toward 20 min.” |
| **Checklist** | Yes: “the habit is done when every item is ticked” | — | — |
| **Quit** | Partly: “The counter runs from here.” | Where it shows | “…It shows at the top of Today under Quitting, counting up.” |
| **To-do** | Yes: “If it isn't done, it moves forward to today until it is.” | The time and the Day Section can disagree (same bug as habits) | A time places it (same rule as 3.3). Day Section only when there's no time. Remind Me gains Alert and Remind Again |
| **When / Reminders** | No: two unlinked controls, and no word on when reminders stop | §2.2 | §3 |
| **After Add** | Partly: the sheet closes and Today may hide the new habit (folded section, not due today) | People can't find what they just made (C142) | Today opens the habit's section, scrolls to the row and highlights it briefly. If it isn't due today, the "First due" line already said so |
| **Day Sections editor** | Partly | Its footer and "Delete Section" message don't mention timed habits | Footer: “Habits with a time move with it.” Delete: “Habits without a time move to Anytime; habits with a time move to the section their time is in.” |

## 6. How we'll know it's intuitive (do this before building beyond the form)

*Reasoned from first principles.* Reviews show what fails; they can't prove a new design works. The cheapest proof is a **predict-the-outcome test**: five people who haven't seen the app, a build (or Figma) of the form, and no explanation.

For each scenario, show the filled-in form and ask the five questions from §1. Then show Today and the notification, and ask “Is this what you expected?”

| # | Form shows | They should say |
|---|---|---|
| 1 | Check it off, Every Day, no time, Day Section Evening | In Evening, every day, no notification |
| 2 | Check it off, 7:00 AM and 9:00 PM, Remind Me on | In Morning and Evening, a tick in each, a notification at each time, none once that tick is done |
| 3 | Count an amount 8 glasses, 9 AM / 12 PM / 3 PM | One row in Anytime, reminders until 8 are logged |
| 4 | Take meds, 8:00 AM, Alarm, Remind Again 15 min | Rings even on silent, again up to 3 times if not ticked |
| 5 | A Few Times a Week (3), 7:00 PM | In Evening every day until 3 this week, reminded each evening until then |
| 6 | Certain days (Mon/Wed/Fri) created on a Tuesday | Not on Today until Wednesday; the form said “First due Wednesday” |
| 7 | 5:30 AM with Morning starting at 6:00 | In Morning |

**Pass bar:** at least 4 of 5 people predict every scenario correctly, and nobody is surprised by an alarm. Any scenario that fails changes its wording or its rule before implementation continues. With five people, most usability problems of this kind show up; this is a check on wording, not a statistical claim.

## 7. What this does and doesn't establish

- **Established (users show):**
  - Placement and reminders that disagree confuse people.
  - Forced times or forced notifications draw 1★ reviews.
  - Some people want parts of the day without clock times.
  - Nag-until-done and alarm-style reminders are valued by a real minority and resented when they come as a surprise.
  - Reminders firing after completion is the top reminder complaint.
- **Reasoned, not tested:** the exact words, the three-repeat cap, grouping same-minute notifications, Anytime for spread amounts, and the placement edge rules. §6 is the test.
- **Not established:** how many users will use Alarm or Remind Again, or whether a Remind Me default of on or off retains better. On-by-default follows the user's intent and C008 (reminders are the core loop).
- **Keyword floors:** counts from scans are minimums (other wordings are missed), and some hits are about marketing notifications. Quoted reviews were read in full.

## Sources

- Apple: [UNNotificationInterruptionLevel](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel), [Critical Alerts entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.usernotifications.critical-alerts), [AlarmKit](https://developer.apple.com/documentation/alarmkit), [Track your medications in Health](https://support.apple.com/guide/iphone/track-your-medications-iph811670c81/ios), [Add and log medications](https://support.apple.com/en-us/105064).
- [MacRumors: iOS 26 makes third-party alarm and timer apps better](https://www.macrumors.com/2025/06/11/ios-26-third-party-alarm-apps/); [MacRumors: Follow Up and Critical medication reminders](https://www.macrumors.com/how-to/set-up-critical-medication-reminders-ios/).
- Our evidence: `Habit Creation Evidence/placement_scan.py`, `placement_scan2.py`, `placement_scan3.py`, `placement_quotes.py`, `placement_hits*.json`; Feature Ledger cards listed under Basis; Day Structure Explained §1.3–1.10.
