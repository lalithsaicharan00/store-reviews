Written by Claude (Claude Code), 11 November 2026.

# Notifications and Alarms — iPhone — 11 November 2026

The Figma page *notifications & alarms* (`1265:24553`) was Android's: its components, its 12 flows (360 × 800) and the
every-kind board. The user's points, in order, and what was done. What iOS really does is in
[Notifications and Alarms — iOS Native](<../Notifications and Alarms — iOS Native.md>).

## The user's points

> "all of them are related to Android … we have to update do research and update. According to the iOS, iPhone."

- [x] 1. Research what iOS 26 does, on the Simulator, not from memory: the banner, the Lock Screen card, swipe left,
  the expanded card and its actions, typing in a notification, what an action leaves behind, the stack, both permission
  alerts, the AlarmKit alarm locked and unlocked. Written in *Notifications and Alarms — iOS Native*.
  - Not readable on the Simulator (it has no notification settings): the app's own notification page and AlarmKit's
    switch in Settings. **To check on the phone.**

> "the ability to log from the reminders … I don't know in iOS, is it possible or not? If possible, then create designs
> for it."

- [x] 2. Logging from a reminder, where iOS allows it: Done (check, task, a week goal), +1 glass (an amount with a step),
  typed Log (an amount with no step; minutes for a time habit), Start Timer (opens the app). Not possible and dropped:
  the inline +1 pill and progress bar, Undo in the notification, the notification staying after an action, one tick per
  checklist step. Flows 265–272: Done (265, 266, 272), +1 glass (267), Log Steps typed (268), Start Timer opening the
  app (269), Log Minutes typed (270), a checklist opening its Day details (271).

> "Then we have alarm screen … however iOS supported, have it that way."

- [x] 3. The alarm is AlarmKit's own: the system's full-screen alarm when locked, the Dynamic Island when in use, Done in
  the habit's colour, Stop as the system's. Our full-screen alarm screen and its six kinds go. Components *Alarm · Lock
  Screen (iOS)* and *Alarm · Dynamic Island (iOS)*, measured from the Simulator; flows 276 and 277.

> "we have permission screens … everything needs to be native iOS … not how it looks in iOS native. How it functions"

- [x] 4. Permissions are iOS's two alerts (notifications, alarms) and Settings. Android's *Let alarms fill the screen*,
  *Allow alarms*, *Full screen notifications* frames go: iOS has no such permissions. *Allow alarms? alert (iOS)* is
  Apple's kit Alert with Apple's words and our one paragraph; flows 275 (Allow) and 278 (Don't Allow). The notification
  question stays where it is (create new, flows 222–224).

> "All of the flows needs to be updated according to the iOS native. And if any flows are missing, they need to be
> created."

- [x] 5. Flows numbered from 265, at 402 × 874, in the widgets page's style; Android's twelve go.
- [x] 6. Missing flows: an alarm while the phone is in use; alarms not allowed; If Not Done, Remind Again (free now).

> "make sure and cross-check for each and everything. Is this a native thing."

- [x] 7. Every screen looked at; every claim in a note matches the research; no Plus anywhere (*Remind me again (Plus)*
  on the board).

## What's on the page now

- **notifications components (iOS)** (`4919:6765`): Reminder (iOS), built on Apple's *Notification - Collapsed*, with
  Stack and Count; Reminder · actions (iOS), 1 or 2 actions, from Apple's *Notification - Expanded*; Reply field (iOS);
  Lock Screen (iOS), Apple's kit with no notifications; Alarm · Lock Screen (iOS); Alarm · Dynamic Island (iOS); Allow
  alarms? alert (iOS), Apple's kit Alert. Keyboards are Apple's kit keyboard (letters; its ABC key reads 123, as on the
  Simulator, and the kit has no numbers-and-punctuation layout).
- Deleted: Android's components (Reminder notification, Reminder group, the native Notification Center, Lock Screen and
  Home Screen frames at 360 × 800, Full screen notifications, Alarm screen, Let alarms fill the screen, Allow alarms),
  the every-kind board with *Remind me again (Plus)*, and the twelve flows.
- One fix on the way: the Skincare Day details copied from the old flow had Serum's row without its 16 left padding.
- **The app's screens fill the iPhone's 402 × 874 (the user, 11 Nov 2026: "the empty space you can see it … they're not
  filling properly").** The Timer screen and the Reminders page were drawn at 360 × 800 with every part pinned to the top
  left, so a copy stretched to 402 × 874 left a grey band on the right and at the bottom (269's timer, 274, 275 and 278).
  Fixed in the components, not the copies: their parts now stretch across (the Home Indicator stays at the bottom, the
  Timer's sheet grows down, the Remind Me With menu keeps to the right), so every copy fills. Today and Day details (265,
  271) already did.

> "the text of an enough and mets should be in white color itself. It is about legibility … Even the second button
> should be similar to stop button" (277, the Dynamic Island)

- [x] 8. Not buildable as asked: iOS draws the alarm from one tint, so the words, the symbol and the ✓ share it (the test
  app's white `textColor` didn't reach the island). The user chose the habit's light shade instead: *Alarm · Dynamic
  Island (iOS)* and *Alarm · Lock Screen (iOS)* take `iOS/Habit/<Hue>/Gradient Top` (Meds' light red in 276 and 277),
  the Lock Screen's Done word is black, and the slide thumb's glow follows the tint.

## To check on the phone

- The app's own page in Settings (notifications) and AlarmKit's switch there (278's last note).
- A banner touched and held while the phone is in use (265 goes through Notification Center, which was read).
- The open pile's header (273 draws the reminders only).
- The clocks read Apple's 9:41 everywhere, as in Apple's kit; the flows say the real times in words.
