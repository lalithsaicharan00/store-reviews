# The First Run — Start in One Tap

Written by Claude (Claude Code), 30 September 2026. What a fresh install of the iOS app shows first. Ledger cards [C075](<../Feature Ledger.md#c075>) (skippable onboarding and in-app help: 37 apps, Certain), [C159](<../Feature Ledger.md#c159>) (launch to the core action with no interstitials), [C209](<../Feature Ledger.md#c209>) (no sign-up wall), [C235](<../Feature Ledger.md#c235>) (a first-run escape hatch), [C185](<../Feature Ledger.md#c185>) (a polished onboarding converts but doesn't retain), and rule B4 of [Data Safety](<../Data, Sync and Accounts/Data Safety — Every Way Users Lose Data, and the Rules That Prevent It.md>) (offer "I've used this before" before any setup).

## Answer

1. **The app opens on Today.** No tour, questionnaire, account, paywall or permission request comes first.
2. **Three actions on the empty Today:**
   - **New Habit**, the one prominent button. The New screen explains each kind of habit as it's chosen.
   - **Restore from a Backup**, for anyone who has used Habits before. It uses the same merge as Settings, which only adds, so nothing has to be set up first.
   - **How It Works**, the searchable help, whenever wanted and never forced.
3. **Permission when it's needed.** Notifications are asked for when the first reminder is turned on, not at launch (already the case).
4. **If the database can't be opened, the app says so** and changes nothing (already the case: "Your habits couldn't be opened…").

## What the reviews say

Fresh keyword scan of habit and routine trackers' App Store and Play Store reviews (1,238,784 reviews; `Research/Temp/stats/firstrun/`), samples read by hand. Counts are keyword floors.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Easy or quick to set up, no sign-up | 858 | 71 | 4.74 |
| No instructions, hard to work out | 866 | 86 | 3.34 |
| Long onboarding or questionnaire (often into a paywall) | 228 | 22 | 1.64 |
| A tour that can't be skipped | 35 | 14 | 1.86 |

- **Starting fast is praised more than anything else here.** Users show: "Easy to set up and use. Habit tracking shouldn't be a chore that takes away from the desire to do the actual habit" (HabitNow, 5★, `688cf82d-2e42-4294-bc54-9e5443334b0b`); "This app is so easy to set up and so pleasing to the eye" (everyday, 5★, `10745919163`).
- **Long setup is punished, hardest when it ends in a paywall.** Users show: "It's gonna make you go through a long questionnaire just to slap you with a 26.99 a month … plan" (Me+, 1★, `436e8018-75bd-41e1-a751-6066c8416e00`); "It has too many steps, some questions ask about the same thing over again and you cant skip any of them" (Me+, 2★, `10938670752`).
- **Forced tours are too.** Users show: "I couldn't skip a tutorial because it was necessary" (MyRoutine, 3★, `6592315d-59cc-4a64-bdae-42d810657771`); "can't get past forced water drinking tutorial, uninstalling" (Fabulous, 1★, `cbc1a84c-db17-4203-8ebd-5a735ecdb22c`).
- **But people do need help to find.** Users show: "I just started and there are just no instructions. I don't understand what the difference is between the types of tasks" (Habitica, 1★, `bf94e529-48dc-4269-adde-122e8c093ec0`); "It definitely needs a tutorial because there is a lot to do" (Finch, 5★, `13007077014`). Hence How It Works on the first screen, and each type explained where it's chosen (the New screen already does this).
- **Coming back shouldn't mean starting over.** Users show: "Every time i open the app i need to restore a backup and wait a minute and redo onboarding" (Fabulous, 2★, `14507325871`). Data Safety B4 found the same: "you need to go through the process of starting from scratch before you can reload the data".

## Reasoned from first principles

- **The first screen is the product.** Someone who just installed a habit tracker wants to add a habit. Today, empty, with one clear button, is both the first-run screen and the screen they'll use every day, so there's nothing to learn twice and nothing to skip.
- **Help is offered, not imposed.** A tour teaches before the person has a reason to care; a searchable answer, reachable from the first screen and from Settings, teaches at the moment of the question (C075).
- **Restore is on the first screen, not in a menu.** A person moving phones or reinstalling is at their most anxious about their history; they shouldn't have to make a habit first to find Settings.

## Not built yet

- Restore by scanning a code from the old phone, or signing in: with Plus sync (Data Safety B5, Architecture).
- Importing another app's export (people switching in).
- A library of ready-made habits inside New (the navigation study put it there); for now New starts from the kind of habit.

## Tests

- `FirstRunUITests.testFreshInstallOffersNewRestoreAndHelp`: the empty Today shows all three; How It Works opens and closes; New Habit opens New. Written; not run (no Mac in this cloud session).

## Limits

Keyword counts are floors and include noise. The screen hasn't been tried with new users.
