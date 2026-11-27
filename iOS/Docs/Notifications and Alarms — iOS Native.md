Written by Claude (Claude Code), 11 November 2026, for the iPhone's notifications & alarms page in Figma.

# Notifications and Alarms — iOS Native

What iOS 26 actually does with an app's reminders and alarms, read from a small test app on the iOS 26.5 Simulator
(iPhone 17, SDK 27.2) and from the old iPhone app's code (`ReminderScheduler.swift`, `AppModel.swift`'s
`NotificationHandler`, `AlarmScheduler.swift`). Sizes are points. What couldn't be read on the Simulator is marked
**to check on the phone**.

## 1. A reminder as it comes in

- **Banner** (phone in use): a Liquid Glass card at the top, x 8–393, y 59–127 (about 384 × 68). App icon about 38 at the
  left, the habit's name in Headline (semibold), one line under it in Body, *now* at the right in Footnote, secondary.
  Over a light app it reads almost white; over the Home Screen it is clear glass.
- **Lock Screen and Notification Center**: the same card at the bottom of the list, x 14–388 (374 wide), about 63–68 tall,
  radius about 24 (fully rounded ends), clear glass with white words.
- **No buttons and no progress bar on the card itself.** iOS draws nothing of ours: icon, title, one or two lines of
  body, time. Android's inline +1 pill and progress bar have no iPhone version. Progress is said in words in the body
  (*3 of 8 glasses*, *2 of 3 this week*, *12 of 20 min*).

## 2. Acting on a reminder

- The actions are behind a **long press** (Haptic Touch) on the card, or **swipe left › View** on the Lock Screen and in
  Notification Center. A left swipe shows three glass buttons: **Options · View · Clear**.
- Expanded, the card turns **opaque white with dark words** (y 679–742, 370 wide), and the actions sit **under it in one
  glass panel, 250 wide, centred, 16 below the card**: each row an SF Symbol and the action's title (Body, 17), about
  48 apart; one action is a 62-tall capsule, two are 104.
- **Every action closes the notification.** Done, +1 and a typed Log all take it away at once; nothing of ours can stay
  on screen to show the new count, and there is no Undo in a notification. Undo stays where it is in the app (Today's
  row: *Undo +1 glass*). A notification put back by the app after an action didn't appear (tested twice).
- **On a locked phone an action runs without unlocking** (no `.authenticationRequired`), saved in the background; the
  old app finished the write before returning so iOS kept it awake (`NotificationHandler`).
- **An action that opens the app** (`.foreground`: Start Timer) asks for Face ID or the passcode first on a locked phone.
  A Live Activity can't be started from the background by a notification action, so **Start opens the app** and the
  timer starts there; the Live Activity follows as from Today.
- **Typing in a notification** (`UNTextInputNotificationAction`): the action row opens a dark glass field above the
  keyboard, with the placeholder (*Steps*, *Minutes*) and a **Log** button at its right end, grey until something is
  typed and then **iOS's blue** (the system draws it; it can't be Ink). **The keyboard is always the letter keyboard**:
  an action can't ask for the number pad, so 123 is one tap away and the app reads a number from what's typed.
- **Up to four actions** show; each has a title and an SF Symbol (`UNNotificationActionIcon`).
- **Tapping the card** (the default action) opens the app: the old app opens the habit's Day details.

## 3. Several reminders at once

- Reminders that share a `threadIdentifier` **stack**: the newest on top with a **count badge on the app icon's corner**
  (*3*), two thinner plates showing under it, the stack inset to about x 20–382. **iOS 26 shows no summary line** (Android's
  *8:00 AM · 3 reminders*). Tapped, the stack opens into separate notifications, each with its own actions.
- The old app grouped by the habit's routine (`threadIdentifier` = routine). A same-minute reminder of several habits is
  still several notifications, each with its own actions.

## 4. Asking for notifications

- iOS's own alert, asked once (U37: when Remind Me is first turned on): *“Often Enough” Would Like to Send You
  Notifications* / *Notifications may include alerts, sounds and icon badges. These can be configured in Settings.* /
  **Don’t Allow** and **Allow**, two equal grey capsules (Allow is not blue on iOS 26). The words are Apple's; the app
  sets none. Figma has it already: *Allow Notifications?* on the create new page, flows 222–224.
- Refused, iOS never asks again: the app opens **its own page in Settings** (`openNotificationSettingsURLString`). The
  Simulator has no notification settings, so that page's look is **to check on the phone**.
- **iOS has no exact-alarm permission, no full-screen-notification permission and no battery setting.** Android's
  *Get reminders on time*, *Let alarms fill the screen*, *Allow alarms* (Alarms & reminders), *Full screen notifications*
  and *Keep reminders coming* have no iPhone version. A scheduled notification comes on the minute.

## 5. An alarm (AlarmKit, iOS 26)

- **Its own permission**, asked when An alarm is first chosen: iOS's alert *Allow “Often Enough” to schedule alarms and
  timers?* / *This will allow the app to schedule alarms and timers that can play sounds and appear onscreen even if a
  Focus is active.* then the app's own reason (`NSAlarmKitUsageDescription`) / **Don’t Allow** (grey) and **Allow (blue,
  prominent)**. Refused, the switch is in Settings › Apps › Often Enough (**to check on the phone**).
- **Locked: the system's full-screen alarm.** Black; the alarm symbol and the habit's name (Title 1-ish, secondary) at
  y ≈ 390; the time, very large and bold; the app's name under it (secondary); then **one large capsule, 370 × 104 at
  y 578, in the alarm's tint colour with the secondary button's word** (*Done*), and **slide to stop** under it (370 × 104,
  a round thumb with a stop square). The tint is one colour per alarm, so it is **the habit's colour**.
- **Unlocked: the Dynamic Island expands** into a black capsule, 374 × 88 at the top (x 14–388, y 14–102): the alarm
  symbol in the tint, *Often Enough* (tint, dim) above the habit's name (tint), then **two 50 circles: ✓ (the tint on a
  dark tint) and ✕ (white on #333333, Stop)**.
- **Stop is the system's own** (slide to stop, ✕). The second button is ours: it runs an App Intent in the background
  (`secondaryButtonBehavior: .custom`, a `LiveActivityIntent`) and must stop the alarm itself; the test app's didn't,
  and the alarm rang on. Its word and symbol are ours: *Done* ✓, *+1 glass*, or *Open* for what needs the app.
- **What the app can colour: one tint, nothing else.** The alert, locked and unlocked, is drawn by iOS from
  `AlarmAttributes.tintColor`: the Dynamic Island's habit name, app name, alarm symbol and second button all take it,
  and the button's `textColor` (white in the test) reached only the Lock Screen's big button, not the island's ✓. So white
  words with a coloured symbol, or a ✓ drawn like Stop, can't be built (the user asked for both, 11 Nov 2026, for
  legibility). **Decided: the tint is the habit's light shade (`iOS/Habit/<Hue>/Gradient Top`)**, 6.4:1 or more on black
  for every hue, so the words read and stay the habit's colour; **the Lock Screen's button word is black** (`textColor`),
  since white on the light capsule doesn't read.
- An alarm rings through silent mode and a Focus. Stopped, nothing is left behind; the habit stays to do on Today, and
  *If Not Done, Remind Again* still applies.

## 6. What this means for each kind of habit

| Habit | Reminder's actions | Alarm's second button |
|---|---|---|
| Check, a task | **Done** (checkmark) | **Done** |
| Check, N times a week or month | **Done**, adds one check | **Done**, adds one |
| Amount with a step (Water, +1 glass) | **+1 glass** (plus) | **+1 glass** |
| Amount with no step (Walk) | **Log Steps** (typed, Log) | **Open** (Log in the app) |
| Time (Read) | **Start Timer** (opens the app) · **Log Minutes** (typed) | **Start** (opens the app) |
| Checklist (Skincare) | none: tapping opens its steps | **Open** |
| Cut down, quit | none | none |

A checklist gets no action because every action closes the notification: one *Tick Cleanser* would leave three steps
with no reminder, and there is no *Mark all done* (Android). Tapping it opens Skincare's Day details, every step there.

## 7. Decided for the app (11 November 2026)

- **If Not Done, Remind Again:** Never, Every 15 min, Every 30 min or Every hour (Android's choices), free. The follow-up
  says *Still to do today* and replaces the earlier reminder (same identifier), so one habit never piles up. Done, on the
  reminder, Today or a widget, stops them for the day.
- **Alarms refused:** the reminder comes as a notification, and Reminders says so under How. iOS won't ask again, so
  choosing An alarm later opens Often Enough's page in Settings (U40).
- **Figma:** page *notifications & alarms*, components in *notifications components (iOS)*, flows 265–278.
