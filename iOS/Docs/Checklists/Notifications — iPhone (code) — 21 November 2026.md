# Notifications — iPhone (code) — 21 November 2026

Written by Claude (Claude Code), 21 November 2026, at the user's request: "Next, we need to work on the
notifications … Check is everything working fine, then fix it … full screen alarm and notifications and reminder
actions, pop-ups and dynamic island … check thoroughly everything."

Figma: the iOS app file, page *notifications & alarms* (`1265:24553`): *notifications components (iOS)* (`4919:6765`)
and flows 265–278. What iOS does is in [Notifications and Alarms — iOS Native](<../Notifications and Alarms — iOS Native.md>)
(on `main`); the design checklist is [Notifications and Alarms — iPhone — 11 November 2026](<Notifications and Alarms — iPhone — 11 November 2026.md>).
Branch `ios-update`.

## The user's points

- [x] 1. Notifications: what a reminder says and how it piles, as Figma.
- [x] 2. Reminder actions: the right action for each kind of habit, and each one saves.
- [x] 3. The alarm (AlarmKit): full screen when locked, the Dynamic Island in use, its button, its permission.
- [x] 4. Check everything on the Simulator.

## Found in the code (before)

- The line under the name was the plan ("Every day", "Time for meds"), not progress ("Not done yet", "3 of 8 glasses").
- Same-minute reminders were merged into one ("Morning · Meds, Stretch +2") with no actions; Figma: each habit its own,
  piled by routine.
- Actions: an amount with no step, a time habit and a limit were wrong (no Log Steps, no Start Timer or Log Minutes;
  a limit had +1). No action had its symbol.
- A follow-up said "Not done yet · …"; Figma: *Still to do today*.
- Tapping a reminder only scrolled Today to its routine; Figma: the habit's Day details.
- The alarm's tint was the habit's main colour with white words; decided: the light shade (Gradient Top), black word.
  Its button didn't stop the alarm itself, and only checks, tasks and stepped amounts had one.

## Steps

- [x] What a reminder says: progress words; *Still to do today* on a follow-up; *Task for today*
- [x] One reminder per habit, piled by routine (no merged reminder)
- [x] Actions per kind, with symbols: Done · +1 glass · Log Steps (typed) · Start Timer + Log Minutes · none
- [x] Typed Log and Start Timer handled; tap opens Day details
- [x] Follow-up replaces the earlier one where iOS allows
- [x] Alarm: tint, black word, second button per kind, stops itself; the permission's own words
- [x] Reminders page: the alarms-off line, If Not Done choices
- [x] Checked on the Simulator: banner, actions, typed Log, Start Timer, alarm locked and in use

## Left for the logic pass

- The reminder check (`-uitest -remindercheck`) still fails one check that was failing before this work:
  *performance fixture must contain 100 reminder rules and a year of history* (`seedDemo` no longer makes that many).
  Every other check passes, the new ones included.
- A follow-up replaces the earlier reminder only while the app runs: iOS needs a different identifier for each
  planned reminder, so one planned ahead can't take the place of another. `clearDelivered` tidies them on the next run.
- Figma's *Actions=2* card shows *Log Glasses* beside +1 glass. The app gives an amount with a step only +1 glass,
  and one without a step only the typed Log: one action each, so nothing to choose between. Say if both are wanted.
- **On the Simulator, alarm buttons need a build signed with the team.** An unsigned Simulator build has no team ID,
  so iOS can't find the app's intents ("Unable to get teamId") and Done or Start on an alarm does nothing. Re-sign the
  app, its extension and its libraries with the team's certificate before installing. A phone build is signed anyway.

## What was done

Checked on the iPhone 17 Pro Simulator (iOS 26), on a build signed with the team, each with a test launch of its own
(`-dbname`, `-ring-soon`, D8):

- **Banner:** a white card, no buttons, the habit's name and its progress (*Water · 0 of 8 glasses*, *Read · 4 of 10 min*).
- **Actions** (swipe left › View): +1 glass saved `Water 1 · reminder`; Walk's *Log Steps* opened iOS's reply field
  straight away, and 2,500 typed on a locked phone saved `Walk 2500 · reminder`; Read had Start Timer ▶ and Log Minutes.
- **Tap:** opens the habit's Day details for that day.
- **Alarm:** asked once with the new words; locked, the full-screen alarm with the habit's light shade and a black
  *Done*; in use, the Dynamic Island in the same tint with ✓ and ✕. ✓ stopped the alarm and saved `Meds 1 · reminder`.
  A time habit's *Start* stopped the alarm and opened its timer, running.
- Fixed while checking: amounts in a reminder were shortened (*8k steps*); they're now in full (*8,000 steps*) with
  the unit in the plural, as Today writes them.
