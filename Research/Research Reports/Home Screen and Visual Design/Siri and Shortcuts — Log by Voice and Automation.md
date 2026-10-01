# Siri and Shortcuts — Log by Voice and Automation

Written by Claude (Claude Code), 30 September 2026. What the iOS app offers Siri, the Shortcuts app, Spotlight and the Action button, and why. Ledger card [C046](<../Feature Ledger.md#c046>) (Shortcuts / Siri / URL scheme / API: 17 apps, Contested, "power users who evangelise"). The plumbing was set in [Architecture 07. Other Surfaces](<../../../Architecture/07. Other Surfaces.md>) §3.3: App Intents for log, add one, what's left, streak and open, free on the phone, never needing an account or the network.

## Answer

1. **Four actions, free:** Log a Habit, What's Left Today, Get Habit Progress, Open a Habit.
2. **Siri knows them without setup:** "Log Water in Habits", "Mark Stretch done in Habits", "What's left in Habits", "How's Water going in Habits", "Open Read in Habits". They also show in Spotlight and can go on the Action button.
3. **Log a Habit adds one step, like the widget and a notification's Done:** a tick (left alone if already done), one more for a count, one quick step or the amount said for an amount, the minutes said for time. If it needs a number and none was given, Siri asks "How much?" or "How many minutes?". A habit ticked per time of day fills its first unticked one. Checklists and quit habits are logged in the app, and Siri says so.
4. **It works with the app closed,** so automations work: tap an NFC tag on a pill bottle, arrive home, open an app, press the Action button.
5. **It answers with where things stand:** "Water: 4 of 8 glasses today." "Stretch is done today. 5 in a row." "3 of 5 done. Still to do: Read and Meds."
6. **A shortcut someone builds keeps working.** Habits are found by their ID, not their name, so renaming one doesn't break an automation, and these actions are never removed or renamed in a later version.

## What the reviews say

Fresh keyword scan of habit and routine trackers' App Store and Play Store reviews (1,238,784 reviews; `Research/Temp/stats/siri/`), samples read by hand. A small group: 587 reviews match any of the words, some of them noise, out of 1.24 million. But they rate high when it works and low when it breaks.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Shortcuts app support, wanted or praised | 127 | 25 | 4.12 |
| Log or tick by Siri or an assistant | 55 | 21 | 4.07 |
| Automations and NFC tags | 50 | 22 | 4.10 |
| Asking for it outright | 34 | 17 | 3.97 |
| Siri or Shortcuts broken or removed | 24 | 11 | 2.67 |
| Reading back streaks or what's left | 21 | 7 | 3.52 |

- **Logging without opening the app is the job.** Users show: "It'd be nice to have shortcuts so I can log activity using Siri" (Habit Tracker, 5★, `8989616230`); "you can even connect Siri to it and check off your daily habits and the app will update itself" (Productive, 5★, `5344197498`).
- **Automations, especially NFC tags.** Users show: "I've added NFC tags to all the stuff I have habits around - creating automations is super easy" (Productive, 5★, `5947302081`); "I'd love to be able to tap an NFC tag to mark something complete like 'read some of a book before bed' … when I … am trying to reduce the amount of light from their screen" (Habit Tracker, 5★, `13015778311`); "my homescreen is already very crowded and most of my productivity is handled through automations" (Habit Tracker, 4★, `10187231135`).
- **It must work with the app closed.** Users show: "as long as you have Streaks open 24/7, everything is great … if Streaks is not open, the shortcut will fail to log activity … 100% of the time" (Streaks, 3★, `10982093264`). Hence the actions run in the app's own process, which iOS starts in the background.
- **One step, not the whole goal.** Users show: "Would love the 'Hey Siri' option to increment one notch in a streak instead of marking as complete" (Streaks, 5★, `3456330491`). The same finding as the widget.
- **Breaking someone's shortcuts is punished.** Users show: "no longer support for Siri … so all my custom Siri phrases to complete tasks were gone" (Streaks, 1★, `11379255315`); "Siri Shortcuts support is also broken or just entirely gone now without warning" (Do Habits, 1★, `8498726949`); "Shortcuts support that looks like it works, until one day it just breaks ruining your streaks" (Streaks, 1★, `9727532228`); "they aren't showing all tasks or marking them complete" (Streaks, 3★, `12250225882`). Broken or removed averages 2.67★, the lowest theme here.
- **Reading back, not only writing.** Users show: "there is only one shortcut that resets the counter but nothing that can fetch what the current time streak is" (Days Since, 4★, `9387304699`). Hence What's Left and Get Habit Progress, both returning text a shortcut can use.

## Reasoned from first principles

- **The same write as a tap on Today.** The actions use the one store and its write queue, then redraw the widget and re-plan reminders straight away (iOS may suspend the app soon after), so a habit done by voice stops reminding, and Today, the widget and Siri agree.
- **Only adds.** A voice command can be misheard; adding one step is easy to see and remove on the habit's page, while an "undo" or "reset" by voice could lose real data without being seen. The same rule as the widget and notifications.
- **By ID, never by name.** A shortcut stores the habit's ID; the name is only for display and for finding it when you say it. Renaming a habit or reordering Today can't break a saved automation.
- **Streaks follow the Show Streaks setting.** Someone who hid streaks on Today doesn't want Siri reading them out.
- **No URL scheme or web API yet.** App Intents cover Siri, Shortcuts, automations, Spotlight and the Action button on iOS. A public API needs an account and a server, which the free app doesn't have (Architecture: Plus).

## Not built yet

- Starting and stopping a habit's timer by voice (one request, `6317405506`).
- Android: app shortcuts and Assistant, when the Android app is built.
- Past days by voice ("I drank water yesterday"): the habit's page does this.

## Limits

Keyword counts are floors and include some noise (the word "shortcut" is used loosely). The actions haven't been run on a device: this cloud session can't build Swift.
