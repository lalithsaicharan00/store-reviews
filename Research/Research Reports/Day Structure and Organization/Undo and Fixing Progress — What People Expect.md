# Undo and Fixing Progress — What People Expect

Written by Claude (Claude Code), 30 September 2026. Build Plan #57 ("Easy undo after checking or logging"). Research only; nothing is built yet.

**The questions (the user's words, tidied):** how should undo work after checking or logging, and where do people expect it? Is a snackbar enough, or should there be several ways? Once someone has logged and moved away from the screen, how do they fix today's progress (or an earlier day's)? Should the habit page have something for this, and if so, a dedicated space near the top?

## Answer in one screen

1. **Mistakes are common, and having no way back is what people complain about, not the mistake itself.** 445 reviews in 63 habit apps describe logging something by mistake. 382 in 52 apps say they couldn't undo it (mean 3.37★). Users show this is a reason to leave: "I accidentally checked off the water habit (I was exploring the app) and it can't be unchecked. Uninstalled." (Fabulous, `70f2f09c-c0bd-4682-9092-79646a535dc1`).
2. **Undo must be visible and must not vanish before people look.** 58 reviews in 17 apps have an undo but can't find it or reach it in time: shake only (Streaks), "only the second after you complete it and then the option is gone" (Finch, `13736433494`), a tap target that's too small (ShineDay). A snackbar that disappears after a few seconds is the same problem again.
3. **Never refuse or scold.** Fabulous blocks un-checking on purpose. It draws 128 of the 382 "can't undo" reviews, and people call the message patronising: "getting scolded for trying" (`2849054541`). Habit Rabbit's "Be honest. This cannot be undone." on every log is the same mistake (`9400918761`). One person liked it (`ad4c5de2-445d-48ad-8e39-c490b22aadce`); many more left.
4. **For amounts and time, people want to fix one entry, not wipe the day.** 47 reviews in 22 apps. 17 in 9 apps say the only fix was resetting the whole day, habit or all data: "I have to reset the entire habit. If there was an easy swipe option to reduce or fix the input I'd give this 5 stars" (Habit Tracker, `9466621749`).
5. **After leaving the screen, people go to the habit's history to fix a day.** 54 reviews in 30 apps want to change a past day's result; 59 in 27 apps want to fill in a missed day; 12 praise apps that allow it (mean 4.42★).
6. **But a history grid that changes on one tap causes new mistakes.** 17 reviews in 10 apps ask for past days to be protected from stray taps (mean 4.18★): "accidentally changed marks from my past days while scrolling back to analyse my habit adherence" (`f321ffea-223f-41c6-bb78-d1a3c1dfc2d2`).
7. **Undo must reverse everything the log changed.** 53 reviews in 22 apps: the streak stayed broken, stats kept the tick, a reward or badge stayed, a grey dot was left, the reminder stayed off.

**What this means for the app (reasoned from first principles on top of the evidence above):**

- **Right after logging, on Today: an inline "Undo" on the row that was just logged**, next to the existing "Add note". Not a floating snackbar. It stays until the person logs something else or leaves the day, not for a few seconds.
- **Every later fix goes through one Day sheet** (that habit on that day: its result, each entry with its time, add / change / delete, skip). The sheet opens from the Today row's long-press menu, from the Log sheet, and from the habit page (a **"Today" row near the top** and **a tap on any calendar day**).
- **Tap-again to un-check stays for check habits.** "+" still never undoes. "Undo Last Entry" stays in the long-press menu, but it's no longer the only way.
- **No confirmation on ordinary logs.** The habit page calendar must not change a day on one tap; a tap opens the Day sheet.

The full design is in "What to build" below.

## How the evidence was gathered

- **Scan:** all 1,487,223 reviews (App Store and Play Store habit apps, and 11 native apps such as Reminders, Microsoft To Do, Google Tasks and Apple Health) for words about undoing, un-checking, mistakes, wrong entries, fixing or deleting a log, editing past days, minus buttons and undo messages, in English and about 12 other languages (`Research/Temp/undo/scan.py`). 6,187 hits.
- **Narrowing:** kept only hits where the mistake or undo word sits near a progress word (check, tick, log, streak, tap, entry…), leaving 3,634 (`narrow.py`). Dropped Notes, Calendar, Google Calendar and Google Sheets (661 reviews, nothing is "logged" there) and accidental-purchase reviews (296) (`prune.py`).
- **Reading:** all 2,677 remaining reviews were read one by one and hand-coded (`classify.py`, 36 codes). **1,084 were on topic: 715 in 84 habit apps and 369 in 7 native apps.** The rest were about deleted apps, lost accounts, sync bugs, accidental subscriptions, text editing in notes, or "I found this app by accident".
- **Existing research:** Feature Ledger C223 (undo is a visible button, never gesture-only; Certain, 11 apps), C262 (recovery actions stay free), C010 (backfill missed days), C090 (destructive quick actions need confirm or undo), and [The Habit Page — What People Expect](<The Habit Page — What People Expect.md>).
- **Design references:** Apple's Human Interface Guidelines on undo and redo, Nielsen's "user control and freedom" heuristic, Raskin's "Never use a warning when you mean undo", and WCAG 2.2.1 (time limits). These are principles, not competitor copying.

Counts are floors: people who never make a mistake, or who find undo easily, rarely write about it. A review can count in several groups.

## What the reviews say

Habit apps only (715 reviews, 84 apps). Native to-do and health apps are reported separately below because their items vanish when completed, which changes the problem.

| Group | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Logged something by mistake | 445 | 63 | 3.44 |
| Couldn't undo it, or couldn't find how | 382 | 52 | 3.37 |
| Want to fill in a missed past day | 59 | 27 | 3.29 |
| Undo exists but is hidden, awkward or gone too soon | 58 | 17 | 3.31 |
| Want to change a past day's result after leaving it | 54 | 30 | 3.15 |
| Undo didn't reverse everything (streak, stats, rewards, reminders) | 53 | 22 | 3.32 |
| Want to fix or delete one wrong amount or time entry | 47 | 22 | 3.64 |
| The mistake happened on a widget, watch or notification | 31 | 12 | 3.16 |
| Praise easy undo | 29 | 18 | 4.76 |
| Want ticking to be harder (hold, double tap) | 28 | 15 | 4.14 |
| Logged on the wrong day | 24 | 11 | 3.33 |
| Want "Are you sure?" (mostly before resets and streak-ending actions) | 22 | 12 | 4.14 |
| Mistake inside a routine or timer player | 19 | 4 | 4.21 |
| Only fix was resetting the day, habit or all data | 17 | 9 | 3.00 |
| Want past days protected from stray taps in history views | 17 | 10 | 4.18 |
| Un-checked something by mistake (tap-again toggles) | 16 | 11 | 3.31 |
| Can't undo a skip | 15 | 4 | 2.80 |
| Mention an undo message or snackbar | 15 | 5 | 3.93 |
| Quit counter reset by mistake | 15 | 2 | 3.53 |
| Tapping a day in the calendar changes it | 13 | 8 | 3.23 |
| Want to see the day's individual entries | 12 | 8 | 3.42 |
| Praise editing past days | 12 | 9 | 4.42 |
| The app refuses un-checking on purpose | 10 | 2 | 2.60 |
| Want a minus / decrease button | 7 | 6 | 3.43 |
| Dislike confirmations on routine taps | 4 | 4 | 2.75 |
| Like that ticks can't be undone | 1 | 1 | 5.00 |

**Where the mistakes come from** (habit apps, where the review says): a widget 20, the wrong day 19, a routine player 19, a swipe 15, a tap in a history calendar 9, an accidental un-check 7, scrolling 6, one tap completing the whole goal 4.

**Native apps (369 reviews):** Apple Reminders' interactive widget (iOS 17) and Microsoft To Do's left-edge circles produce most of them. The pattern differs from habit apps: the ticked item **disappears** (121 reviews), so people often don't know what they ticked: "sometimes it happens so quickly you don't know what you just lost" (To Do, `8945842975`). The ones that praise a fix keep the ticked item in place: "Wunderlist … kept the crossed off item in the same location in the list" (`5702302766`), "They just drop to the bottom of the list with a check mark. But is still on your list" (`6236784547`).

### 1. People make mistakes, and the missing way back is the complaint

Mistaken logs come from ordinary use: exploring the app on day one, scrolling, holding the phone, a widget brushed while unlocking. What people are angry about is being stuck with a false record. They care about the record being true: "I want to be fair to myself when I actually did it or not" (Fabulous, `4afc673d-2e39-4cd3-87a9-11349c27bfee`). The most serious case: "I accidentally ticked that I'd taken my medication one day and discovered that you cannot undo a task ticked off by mistake" (Fabulous, `5911520819`).

Refusing on purpose makes it worse. Fabulous shows a message instead of un-checking: "I get a pop up saying I can't uncheck it. Are you serious?!" (`4968961775`). Habit Rabbit asks for honesty on every log: "It feels so condescending and it comes up EVERY time I log a habit" (`9400918761`). The one review that likes no-undo (`ad4c5de2-445d-48ad-8e39-c490b22aadce`) is outweighed 128 to 1 in Fabulous alone.

### 2. Undo has to be visible, and it has to still be there when people notice

- **Shake is not an undo.** Streaks' shake-only undo draws steady complaints: "Ridiculous that not possible to manually undo a completed entry except by shaking immediately after" (`14245262334`); "only available immediately after accidentally marking a task as complete" (`14391501375`). Feature Ledger C223 (Certain) says the same across 11 apps.
- **A few seconds is too short.** "I know that you can just undo completion, but that's only the second after you complete it and then the option is gone" (Finch, `13736433494`). Reminders: "Sometimes fat thumbs hit the wrong button and it's gone before it can be reactivated" (`14288109442`). And people often notice the slip later: "I frequently click one of the tasks by mistake, and sometimes without even knowing" (Reminders widget, `11596860568`).
- **A floating message gets in the way.** Google Tasks' "Task completed | Undo" toast covered the next button people needed (`11108013567`); in Tasks the undo bar covers the new-task button (`cd6adabe-0421-4ba7-9af4-995a630e04b1`); one person disliked an undo pop-up after every tick (`dc0fd1a7-de95-4dac-a095-d93f280d8c71`).
- **But people do ask for a short undo after ticking**, in their own words: "display a 'cancel completion' button at the bottom for a while right after completing" (To Do, Japanese, translated, `6111071596`); "add an Undo option in the 'Task Finished' snackbar" (a UX designer, `6ffd6bc1-ed20-415c-9f70-749d0f6c3357`).

So: an undo right after the action, yes, but one that is attached to the thing that changed, doesn't cover anything, and doesn't time out while the person is still looking.

### 3. Amounts and time: fix the one entry, see what was logged

For counts and timed habits, "undo" isn't enough on its own. People typed 35 hours instead of 35 minutes, logged four instead of three, tapped +1 twice. They want that entry fixed or removed, not the day reset:

- "if you accidentally add the wrong amount of time, there seems to be no way to undo it except to reset the timer for the full day" (Habit Tracker, `11377690769`).
- "I have to reset the entire habit. If there was an easy swipe option to reduce or fix the input I'd give this 5 stars" (`9466621749`).
- "No way to view each entry or edit each entry … you can't tell whether you logged for the day or not nor can you tell what you logged" (Strides, `915678945`).
- "a faster way to get to the log history screen (sometimes I accidentally hit +1 multiple times and need to delete one)" (Habitify, `6b3d5bc8-74c9-44d6-96b0-53c18598c572`).

A minus button is asked for less often (7) than editing the entries themselves (47).

### 4. After leaving: people go to the history and expect to fix the day there

54 reviews want to change a past day's result and 59 want to fill in a missed day. Most of them name the calendar or history as where they tried. The complaint in apps that allow it is the opposite risk: one tap in a statistics grid changes a day without anyone noticing.

- "the calendar allows you to done/undone a task in the statistics interface itself … we can bymistakely click on previous days and unknowingly mark the habit undone" (`e20a0188-4949-445f-97b3-c71778990840`).
- Praise for the balance: "when checking the history of a habit the app is designed in a way that it doesn't allow to accidentally modify past days, if you want to change somet[hing]…" (Awesome Habits, `11493203641`).
- A few want past days locked completely (`2f3f4bb9-72c7-45e2-988f-7a82cbe163d0`, `a4113d46-a2b8-4adb-80e4-94297021ed1f`), but 87 reviews in 37 apps want to change or fill in past days, so locking isn't the answer. An explicit step is.

### 5. Undo must put everything back

53 reviews: after undoing, the streak stayed broken ("if I accidentally hit a wrong day and then un-select it my streak is broken", Loop, `304cddea-ffd8-405a-9a4f-98c86f1f49ac`), the day kept a grey dot (ShineDay, `7662846726`), rewards and badges stayed, or reminders stayed silenced. Undo has to be the exact inverse of the log.

### 6. Tap-again, confirmations and "make ticking harder"

- **Tap-again to un-check is expected** for check habits; losing it is a complaint (ShineDay's redesign turned "one tap to complete, one tap to cancel" into three taps each, Chinese, `7563054459`). It also causes accidental un-checks (16), but those are visible and one tap fixes them, so the answer is feedback, not removal.
- **Confirmations are wanted before resets and streak-ending actions** (22), not before every tick. A confirmation on every log is disliked (4, including Habit Rabbit above), and one review shows it failing anyway: "I accidentally tapped ok too fast" (Productive, `5435183168`).
- **Hold-to-complete is praised by some** (28, mean 4.14) as a guard, but mostly as an option. Our Design Rules already settled on one-tap logging (Logging a Count research), so this report doesn't reopen that.

### 7. Players, skips and quit habits

- **Routine players:** 19 reviews (mostly Routinery) pressed Done instead of Pause and want the previous task back **with its time**: "reading is 30 min, I pressed complete by mistake after 10 min; I want to go back to reading with 10 min done" (Korean, translated, `fc00b12e-1434-40c4-bc90-509ffcb46ea8`).
- **Skips need undo too:** 15 reviews in 4 apps, mean 2.80, among the lowest here.
- **Quit habits:** 15 reviews about a quit counter reset by a stray tap (Days Since): "this wouldn't be an issue if i could go in and either undo a reset, edit a reset…" (`11108689966`).

## What to build (reasoned from first principles, using the evidence above)

**The one rule:** every log can be taken back exactly, from where the person is looking right after, and from the habit's own day later. Undo removes that exact entry and everything it caused. No confirmation on ordinary logs.

### Right after logging (on Today)

- **Inline Undo on the row just logged, next to "Add note".** Today already keeps the just-logged row in place (it doesn't sink below the done rows while "Add note" is offered). That's where the person's eyes are, so Undo goes there: `Add note · Undo`. It covers nothing (evidence 2) and needs no timer.
- **It stays** until the person logs another habit, changes day or leaves Today. It doesn't time out after a few seconds (Finch, Reminders, WCAG 2.2.1).
- **It names what it undoes** for amounts and time ("Undo +250 ml", "Undo 12 min"). For checks, plain "Undo" is clear. This follows Apple's HIG advice to describe the result of undo.
- **It removes that exact entry,** even if another log came in since (the player already does this with `undoEntry(id)`).
- **VoiceOver:** after a log, announce "Logged" and offer Undo as an action on the row, so no timer is needed there either.

### Checks, counts and time

- **Check habits: tap again un-checks** (unchanged). Give un-checking a different haptic from checking, so an accidental un-check is felt (`305a9044-87ad-41a0-80d4-2c2c0eac56da`).
- **Counts: "+" never undoes** (unchanged, a Design Rule). Inline Undo covers the extra tap.
- **The Log sheet (tap the row) lists the day's entries** under the input: time, amount, where it came from (Today, the player, a reminder). Swipe to delete, tap to change the amount. This answers evidence 3 without adding a minus button, and it keeps "An addition, never a replacement of the day's total".
- **"Undo Last Entry" stays in the long-press menu**, next to a new **"Edit Today's Progress…"** that opens the Day sheet.

### Later: one Day sheet, reachable from Today and the habit page

A single sheet for one habit on one day. The title names the habit and the day ("Water · Sunday 28 Sep"), so the day is never in doubt (evidence: 24 wrong-day reviews).

- **Contents:** the day's result in the same words as the row (6 of 8 glasses, Done, Skipped, Paused); each entry with its time and source; Add; change or delete an entry; for check habits a Done / Not done control; Skip / Undo skip; the day's note.
- **Changes save as they're made.** No confirmation, because the sheet is the explicit step. Everything recalculates: streak, best, done this month, the ring, the week strip, reminders.
- **Opens from:** the Today row's long-press menu ("Edit Today's Progress…", or "Edit Progress…" on another day via the day bar), the Log sheet's entry list, and the habit page (below).

### On the habit page

- **A small "Today" row near the top**, under the habit's sentence and numbers: "Today · 6 of 8 glasses" with a chevron, opening the Day sheet for today. Most fixes are for today (evidence 1), and the page is where people go once they've left Today. It is a way in to the sheet, not a place to log: the page research found people don't want the page to be the way to check off (5 reviews).
- **Tap a calendar day → the Day sheet for that day.** A tap never changes the day by itself (evidence 4: protects history from stray taps, and still lets people fix and fill in past days). This replaces "Tapping a day does nothing yet" in the habit page report.
- **Future days:** nothing to change, so a tap does nothing.
- **Not a big dedicated section.** One row is enough; a large editor on the page would compete with the calendar, which the page research ranks first.

### Routine player (follow-up check, 30 Sep)

31 of the on-topic reviews are about a player: Routinery 15, Apple Fitness 12, Fabulous 3, Morning Habits 1. What they ask for, and where our player already stands:

| Ask | Reviews | Our player |
|---|---|---|
| Go back to the habit I completed by mistake | 12 (Routinery, Fabulous) | Built: ‹ goes back; the page shows it done |
| Keep the time already done when going back, don't reset it | 2 (`fcaa917c-a912-403c-8988-c78898c34b71`, Korean `fc00b12e-1434-40c4-bc90-509ffcb46ea8`) | Built: time is saved as entries; nothing resets |
| Don't lose the session when I close or swipe by accident | 5 (Routinery, Fabulous, Apple Fitness) | Built: can't be swiped away; Close saves; progress stays |
| Resume after pressing End by mistake | 5 (Apple Fitness) | Built: End routine goes to the summary, which has "Return to unfinished" |
| Pressed Complete when I meant Pause | 3 (Routinery) | Doesn't apply: a timer's button is Pause / Resume, never Complete |
| Ask "Are you sure?" before ending | 3 (Apple Fitness) | Not needed: ending loses nothing. One reviewer found that exact prompt a problem ("I have accidentally not answered, so it continues to track", `10583022272`) |

**So after the undo message goes, the player needs no confirmations.** Every action in it can be taken back: a log (Habit options → "Undo +250 ml" / "Undo check", repeatable one entry at a time), a skip (Undo skip), Next or End (‹ and Return to unfinished).

One change is worth making: **when the page shows a habit this routine completed, show a small "Undo" under the result, visible and with no timer**, the same as the inline Undo on Today. Right now, once the 4-second message has gone, undo is one level down in Habit options. That is the "hidden undo" pattern (58 reviews), and in a player people move fast and notice later. It sits on the page, so it covers nothing (the message is timed because it covered a checklist step, found by hand 29 Sep). Habit options keeps its Undo too.

Unchanged on purpose: Undo in the player only removes entries made in this routine, so an entry from earlier in the day can't be removed by accident (found by hand 29 Sep). Those are fixed from Today (inline Undo, the Log sheet's entries or the Day sheet).

### Notifications, widgets and quit habits

- **Notification "Done" / "+1 glass":** it can't show an Undo, so the entry shows its source ("from reminder, 8:02") in the Log sheet and Day sheet, where it can be removed. If undo brings the habit below its goal, the day's remaining reminders come back.
- **Widgets (when built):** a ticked habit stays visible and ticked, and tapping it again un-ticks. Never let a tick vanish (Reminders evidence: 121 native reviews about items disappearing).
- **Quit habits:** "Slipped" gets the same inline Undo and appears in the Day sheet.

### Not to build

- **No confirmation on ordinary logs** (Raskin; Habit Rabbit and Do Habits reviews).
- **No shake-to-undo as a way of undoing.** It can stay as the system extra, but nothing may depend on it.
- **No app-wide undo history.** Only one review asks for multiple levels. Each undo belongs to one habit on one day.
- **No floating snackbar on Today.**
- **No lock on past days.** Protect them with the explicit step instead.

## Where the current app stands

| Need | Today | Gap |
|---|---|---|
| Undo right after a check | Tap again un-checks | No visible Undo; un-check isn't felt differently |
| Undo right after + or a timer | "Undo Last Entry" in the long-press menu only | Hidden (C223: never gesture-only) |
| Fix one wrong amount or time | Only the last entry, from the menu | No entry list, no edit |
| Undo in the routine player | Message with Undo (4 s), plus Habit options; ‹ back keeps logged time | After the message, undo is only inside Habit options |
| Undo a skip | "Undo skip" in the message and on the page | — |
| Fix today after leaving Today | Go back to Today; long-press → Undo Last Entry | No Day sheet |
| Fix an earlier day | Day bar → that day's row | The habit page calendar does nothing on tap |
| Undo a notification "Done" | Not possible except Undo Last Entry | No source shown |
| Undo recalculates everything | Streak and progress are derived from entries | Check that reminders are rescheduled after undo |

## Limits

- The scan finds reviews that use words for undo and mistakes. People who fix things silently, or describe it differently ("I had to re-enter"), are missed.
- Fabulous alone is a third of the "can't undo" group because it blocks un-checking on purpose. Without it, the group is still 254 reviews in 50 apps.
- The native apps are to-do lists, where a completed item disappears; that makes mistakes harder to notice than on a habit row that stays. They're used for the "don't let it vanish" and "undo message" findings only.
- The design section is reasoned from the evidence and first principles and hasn't been tested with people.

## Files

`Research/Temp/undo/`: `scan.py` (hits.jsonl), `narrow.py`, `prune.py` (read_queue.jsonl, batches/), `classify.py` (every code, keyed by queue number; `python3 classify.py` validates and writes coded.json), `verify_ids.py`.
