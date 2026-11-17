# Day Details Components — iPhone — 17 November 2026

Written by Claude (Claude Code), 17 November 2026. The user's points, from Figma's *day details components*
(`759:30885`, file "IOS app"), one part per loop tick. Branch `ios-update`.

The user: "these are like a page components in Figma, but in iOS, those are sheets … iOS already has it inbuilt. So
build it properly … you don't need to create a component unless it is required … for a production ready application,
how it should be created that way … designing is a different and development is a different … alerts. These are
inbuilt for iOS … calendar pop-ups. This is also inbuilt … first we are focusing on updating the UI everywhere.
Updating and removing unnecessary screens."

## The parts

- [x] **Day details sheet** (`669:234`), one sheet of one height (`.large`, no handle), ✕ and ⋯ in the bar:
  - [x] Amount: This day's reading, +1 and Log side by side, Add a Note, Today's Logs, Skip Today.
  - [x] Status: Not done, Mark Done.
  - [x] Checklist: its steps as tick rows in the This day card.
  - [x] Cut down: the reading and "Limit 2 cups · Over the limit", +1 and Log both Bordered.
- [x] **Timer screen** (`705:7745`): Running and Paused; Timer / Today title, Day Details, the ring, Log Time and ⏸/▶.
- [x] **Log screen** (`687:829`): Amount, Duration and Slip, each Entry (Add in the bar), View (Edit in the bar,
      Delete as a red row) and Empty ("Enter more than zero.", Add off).
- [x] **All logs screen** (`694:607`): Today's Logs, every log, and the total under them.
- [x] **Alerts** (`702:618`): iOS's own `.alert`: Discard this log? (Keep Editing, Discard), Delete this log? (Cancel,
      Delete).
- [x] **Date and time pickers** (`705:1025`, `703:602`): iOS's own compact `DatePicker`, limited to the days a log can
      take.
- [x] **Note screen** (`765:1087`): Entry empty (Add off), Entry typed, View (Edit, Delete Note as a red row).
- [x] Screens Figma no longer has, removed from the code: the hours/minutes/seconds boxes (now one iOS wheel,
      `DurationWheel`), the bottom Add/Save/Delete | Edit bars on the log and note screens (now in the navigation bar,
      Delete as a red row), `RecordDeleteButton`, the Time zone row, the footer that hid while typing.

## Then

- [x] Each part checked on the Simulator (iPhone 17, iOS 26): every sheet variant, the timer Running and Paused, Add
      Log for an amount, a time (the wheel turns) and a slip, Log and Edit Log, the Discard and Delete alerts, All
      logs, Add Note, Note, Edit Note. UI tests updated for the new words and the wheel; `build-for-testing` and
      `check_rules.sh` pass; the UI tests themselves haven't run yet (no CI tag on this push).
- [x] Commit and push to `ios-update`.
