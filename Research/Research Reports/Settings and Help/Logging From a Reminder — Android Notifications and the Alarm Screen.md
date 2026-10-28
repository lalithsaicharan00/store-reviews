# Logging From a Reminder — Android Notifications and the Alarm Screen

Written by Claude (Claude Code), 27 October 2026, at the user's request: "when they turn on notifications, they should
be able to log from the notification itself. So do research how Android allows logging from notification itself …
For checklist, also pay some special attention … And also do research on alarm screens … I don't know whether the
Android functionalities allow that or not."

**The short answer:**
- **Every habit and task with a reminder can be logged from its notification, without opening the app.** The two
  kinds that never get reminders, quit and cut down, are the exception.
- **A checklist works too,** one step at a time: the notification lists the steps, and its button ticks the next one.
- **An alarm screen is allowed, but only if the person turns it on.** Since Android 14, Google Play gives the
  full-screen permission by default only to calling and alarm-clock apps. Any other app has to send the person to
  Android's own *Full screen notifications* switch. If it's off, the alarm stays a ringing notification with its
  buttons, which is what the app does today.

---

## 1. What Android allows (the platform's own rules)

| Rule | Source |
|---|---|
| A notification can have **at most three buttons**, and a button must not repeat what tapping the notification does. | Android Developers, *Create a notification* |
| A button can do its work **in the background** (a `BroadcastReceiver`), without opening the app. | the same |
| **Direct reply** (`RemoteInput`, Android 7.0 and later) lets a person **type into the notification**, and the text reaches the app without opening it. Android's own term is "reply to messages or enter other text". | *Create a notification*; *About notifications* |
| After a button's work, the app **updates the same notification** (same ID) to confirm it. `setOnlyAlertOnce()` keeps the update from ringing again. Updates many times a second can be dropped. | *Create a notification* |
| The system draws a notification from **its own template**: small icon, app name, time, title, text, then the buttons in the expanded view. Google "strongly recommends" the templates. Since Android 12, apps can't make fully custom notifications. Custom content keeps the system's frame and can be as short as 48 dp collapsed, 88 dp heads-up and 252 dp expanded. | *About notifications*; *Custom notification layouts* |
| **One line collapsed; the buttons show when it's expanded.** A heads-up (a new notification over the screen on an unlocked phone) shows its buttons. | *About notifications* |
| **The lock screen** shows notifications with the detail the person allows. Since Android 12, a button can require unlocking (`setAuthenticationRequired`); by default it doesn't. | *About notifications* |
| **Full-screen intent** (the alarm-clock screen over the lock screen) needs `USE_FULL_SCREEN_INTENT`. From Android 14, Play turns it on by default **only for apps whose core purpose is calling or alarms**. Since 22 January 2025, every other app targeting Android 14 or later must "get user permission" and "gracefully degrade the experience if denied". | AOSP *Full-screen intent limits*; Play Console Help 13392821 |
| **Without the permission,** a full-screen notification shows as a heads-up **with pill-shaped buttons for 60 seconds**, locked or unlocked; with the screen off, it wakes the always-on display for 60 s. | AOSP *Full-screen intent limits* (validation table) |
| A button tapped from a notification **may start a foreground service** (Android's exemption for notification actions), which is how **▶ Start** can start the timer's Live Update without opening the app. | Android foreground-service rules (the app's timer already runs this way, `TimerNotice.kt`) |

## 2. What people ask for (users show)

Feature Ledger **C252, "Complete a habit from the notification", is Strong**: 7 apps, one direction. People ask for "a
single tap to complete one once the reminder pops up" (report 53). Tappsk has 28 requests for actions from the
notification or the lock screen (report 59). Way of Life's requests run from 2015 to 2025 (report 76). People "are
lost at the open app step" (report 70).

The ledger has **no reviews about checklists in notifications** or about alarm screens in habit apps. Sections 3.5
and 4 are reasoned from first principles.

## 3. What each kind of habit shows (reasoned from first principles, on Android's rules above)

The rule for every kind: **the button does what the round button on Today does** (Rulebook U14, A50), so a person never
has to learn a second way.

1. **Only adds, never takes back.** Undo appears after a log and names what it takes back.
2. **The notification then updates** to show the new state.
3. **Tapping the notification itself** opens that habit's Day details.

| Kind | Text under the name | Buttons | After a tap |
|---|---|---|---|
| **Check, once a day** | "Not done yet" | **Done** | Goes away; the habit is done for today. |
| **Check, several a day or N a week / month** (one ✓ adds one check, U14) | "1 of 3 today" / "1 of 3 this week" | **Done** | Updates: "2 of 3 this week" · **Undo**. Goes away at the goal. |
| **Amount with a step** | "3 of 8 glasses" | **+1** (the step, as on Today) | Updates: "4 of 8 glasses" · **+1** · **Undo +1**. Goes away a few seconds after the goal. |
| **Amount typed each time** | "0 of 2,000 steps" | **Log** → a text field in the notification ("How many steps?"), sent with ➤ | Updates: "2,500 of 2,000 steps · Goal met" · **Undo**. |
| **Time** | "0 of 20 min" | **▶ Start** · **Log time** | **Start:** the reminder becomes the timer's Live Update (A69): the clock and Pause. **Log time:** a text field ("How many minutes?"), the same as Log. |
| **Checklist** | the steps, one per line, ✓ for the ticked ones (expanded) | **Tick "Push-ups"** (the next step), **Open** | Updates: the step is ticked and the button names the next one. Goes away when the last step is ticked. |
| **Task** (once or repeating) | "Task · due today" | **Done** | Goes away. |
| **Quit, cut down** | — | No reminders, so no notification. | — |

### 3.1 Several reminders at the same minute

**Android groups them, and each stays its own notification with its own buttons** (Android's bundled notifications).
The app today sends one notification with no buttons for a group (`Reminders.kt`, `groups`). That should change: a
summary ("3 habits for Morning"), and each habit underneath it, each with its own buttons.

### 3.2 Hidden names

When names are hidden outside the app, the title is "Your habit" and the buttons stay. The current code
(`ReminderPlan.action`) keeps "Done" and "+1" with names hidden.

### 3.3 On the lock screen

Buttons work **without unlocking** (Android's default). This is the same as the iPhone (Rulebook D13), and logging a
glass of water isn't sensitive. Typing into a direct reply on a locked phone is allowed by Android too.

### 3.4 "Remind me again" (Plus, A73)

The follow-up looks the same, with its own line, e.g. "Still to do today". A tap on any button stops the follow-up.

### 3.5 Checklists, in detail

Five ways were weighed:

| Way | Verdict |
|---|---|
| One button per step | **No:** Android allows three buttons, and a checklist can have more steps. |
| Checkboxes drawn in a custom layout | **No:** since Android 12 the system frames custom content and limits its height (as little as 252 dp expanded). It wouldn't match the phone's other notifications. Google advises the templates. |
| "Mark all done" | **No:** it ticks steps the person didn't do. The app never logs on someone's behalf. |
| Only "Open" | It works, but it misses C252's point (no app-open). |
| **The steps as lines (Android's inbox-style list), and one button that ticks the next unticked step, by name** | **Chosen:** it's the order the person does them in (a routine), every step is still ticked by the person, and the button always says exactly what it ticks. **Open** is beside it for ticking out of order. |

## 4. The alarm screen

**Allowed, with the person's permission.** Often Enough's core purpose isn't an alarm clock, so Play won't turn the
permission on by default. We would declare that honestly in Play Console. Getting it wrong risks the app.

**How it works:**
1. Choosing **Remind me with: Alarm** asks once, the same way Get reminders on time does (A66). Our sheet explains,
   and **Open settings** goes straight to Android's *Full screen notifications* switch for Often Enough
   (`ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT`, Rulebook U40's rule).
2. Coming back, the app checks again (`canUseFullScreenIntent()`).
3. On Android 13 and lower, the permission is on already.

**With it on, a locked or sleeping phone** shows a full-screen alarm over the lock screen, ringing until answered:
- the time;
- the habit's icon, name and goal;
- the logging buttons for its kind, big (Done, +1, ▶ Start, Log for a typed amount);
- **Not now**, which stops the ring and leaves a normal notification.

**An unlocked phone** gets a heads-up that stays, as Android does.

**With it off,** the alarm is the ringing heads-up with pill buttons (Android's fallback), which is what the app
does now (A11 D3).

This replaces A11 D3's "never a full screen" for people who turn it on. That is the user's decision to make.

**Typing on the alarm screen:**
- A typed amount or a typed time **opens the app's Add log over the lock screen**.
- The phone asks to unlock only to save if it is set to.
- A checklist's alarm shows its steps with the **Tick next step** button.

## 5. Sources

- Android Developers, [Create a notification](https://developer.android.com/develop/ui/views/notifications/build-notification)
- Android Developers, [About notifications](https://developer.android.com/develop/ui/compose/notifications)
- Android Developers, [Custom notification layouts](https://developer.android.com/develop/ui/views/notifications/custom-notification)
- Android Open Source Project, [Full-screen intent limits](https://source.android.com/docs/core/permissions/fsi-limits)
- Play Console Help, [Understanding foreground service and full-screen intent requirements](https://support.google.com/googleplay/android-developer/answer/13392821)
- Feature Ledger [C252](<../Feature Ledger.md#c252>)
- The app's code: `Android/app/src/main/kotlin/com/oftenenough/app/app/reminders/Reminders.kt`,
  `data/ReminderPlan.kt`
