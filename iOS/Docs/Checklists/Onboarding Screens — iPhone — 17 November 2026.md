# Onboarding Screens — iPhone — 17 November 2026

Written by Claude (Claude Code), 17 November 2026. The user's points, from the request for Figma's onboarding
components (`796:42464`, page onboarding `1:5`), in the order they're done. Branch `ios-update`.

The user: "these are screen components … in Figma, those pages are components … But in code, whatever is the
production ready … in Swift actual projects we follow that … if you have made any mistakes while implementing the
design system or anything, correct them … document it in a separate place so that no other agents … make that
mistake … test the flow number 1 to flow number 7 … like a real human … Go screen by screen … I don't want you to run
any automated tests."

## The rule for every agent

- [x] Write down how a Figma design becomes SwiftUI: Figma's page components are a Figma way of working, not the app's
      structure. A separate doc, not code comments, linked from the Rulebook so every agent reads it.
- [x] Look back over the design-system work on `ios-update` (colours, text, bars, buttons, inputs, lists, notices,
      progress, cards) for anything copied from Figma that iOS does its own way, correct it, and write each down.
      Five fixed and listed in the doc's last section (17 Nov).

## The screens (Figma's six components)

- [x] **Launch screen** (`553:2427`): `UILaunchScreen` with System Grouped Background only, no logo, no words.
      `Habits-Info.plist` names `LaunchBackground`, the app's first asset catalog (`Habits/Assets.xcassets`).
- [x] **Today, no habits yet** (`547:2419`): `ContentUnavailableView`, `checklist`, No Habits Yet, "Add something you'd
      like to do often enough.", New Habit (prominent, Large), Restore from a Backup (plain), nothing else.
- [x] **Choose a file** (`582:8487`): Apple's picker, `.fileImporter(allowedContentTypes: [.zip])`, straight from
      Restore from a Backup.
- [x] **Restoring** (`582:7893`): `ProgressView` with a label, `.controlSize(.large)`. Restoring Your Habits… with
      Cancel (a file), Looking in iCloud… without (a fresh install, only after a second).
- [x] **No internet** (`582:8426`): `ContentUnavailableView`, `wifi.slash`, No Internet Connection, Try Again, Not
      Now; onboarding only; goes on by itself when online (`NWPathMonitor`).
- [x] **That isn't a backup** (`4172:6415`): two `.alert`s over Today. This File Isn't a Backup (Cancel, Choose File);
      Update to Open This Backup (Cancel, Update).
- [x] The old welcome pages go: Figma's flows start at the launch screen and end on Today.
- [x] UI tests that read the old words and buttons (No habits yet, empty-ideas, empty-help, the welcome's pages) are
      updated with them (T3). The user, 17 Nov: rewrite them only if they're useful. Kept and rewritten only what
      guards something a person could lose (habits back from iCloud, No Internet going on by itself, a first habit after
      midnight landing on today); the welcome's own tests and its screenshots are deleted. The test target compiles;
      **the tests haven't run yet** (a local run was refused here, and CI waits for the user, T1).

Built so far: `Today/EmptyToday.swift` (the empty Today) and `Onboarding/FileRestore.swift` (picker, Restoring Your
Habits…, the alerts; damaged, zipped-again and unreadable files get alerts of the same shape). Start From an Idea and
How It Works are gone from the empty Today, as in Figma. `Onboarding/FirstLook.swift` is the first launch: an
overlay (a cover would slide up) in Today's background from the first frame, Looking in iCloud… after a second, No
Internet Connection on a fresh install offline, all from CloudSync's state. The welcome's pages, its ideas, Help's Show
the Welcome Again and the speed run's onboarding scenario are deleted.

## Testing by hand (after everything is built)

On the Simulator, screen by screen, as a person would. No automated tests until all of this is done.

- [x] Flow 1 · New to the app
- [x] Flow 2 · Back on iCloud
- [x] Flow 3 · Back with a backup file
- [x] Flow 4 · No internet: iCloud
- [x] Flow 5 · iCloud is off (checked by leaving the app and coming back, as the Settings app would)
- [x] Flow 6 · Wrong file
- [x] Flow 7 · Backup from a newer version (the alert shows; Update can't open the App Store on the Simulator, and
      `AppStoreLink.appID` is still to set once the app has its App Store id)

Found and fixed while testing:

- A backup with no habits in it showed as restored onto an empty Today: now an alert says so (D5).
- A `-onboarding` test launch kept `onboarding.done` from the launch before, so No Internet never showed: such a launch
  now always starts fresh (T8).

## Today: no Filter and no Note for the Day

The user, 17 Nov 2026: "remove that group filter as well as a note for the day at the bottom of the day … We have
removed it from designs as well."

- [x] Filter (the groups filter beside +) is gone from Today's bar, with its sheet and the group bar under the bar.
      Today's bar is ☰ · Edit · +, as in Figma.
- [x] Hide Completed went with it: the Filter sheet was its only way in, and Android has no such setting (A32).
- [x] Note for the Day is gone from the bottom of Today, and its card from the top. Saved day notes stay in the data
      and in backups (nothing is lost) and still show, read only, on Progress's day.
- [x] The speed run's groups scenario and its hide-completed measure are deleted.
- [x] Group editing (Groups) had no way in after that. The user, 17 Nov: "Yes, remove groups". Gone from the habit
      form, Habits (one list), Progress (chips, the Groups card, by-group headings and the Day sheet), the store, the
      speed run and the UI tests (`GroupsUITests` deleted, and dropped from the CI workflow's default list). Groups saved
      by an older build stay in the database untouched; golden case G18 now checks that such a database opens with every
      habit and its history.

## Then

- [x] Docs and the Rulebook say what changed.
- [x] Commit and push to `ios-update`.
