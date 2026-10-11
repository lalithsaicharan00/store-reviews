# Build the iPad App (prompt for a building session)

Written by Claude (Claude Code), 11 October 2026, at the user's request ("we are going to assign this to an agent
so that it can complete it and finish the task").

> **When the work is done and merged, delete this file** (`iOS/Docs/iPad/Build Prompt (Delete When Done).md`) in your
> last commit. It is a one-time hand-off. **Keep everything else in `iOS/Docs/iPad/`**: it's the iPad's documentation.

## 1. The job

Make the iPhone app a universal app that is **fully native on the iPad** (Current Work 86): every screen in
`iOS/Docs/iPad/Designs/`, in every orientation and window size, the keyboard and pointer, the Columns view and the
iPad widgets. Then test it thoroughly on the iPad simulator, and list what must be checked on a real iPad.

Everything you need is in `iOS/Docs/iPad/`. **Start with its `README.md`**, then the research report's §6 (rules
I1–I12) and the design notes, with every picture. The pictures are mockups at 11-inch (1180 × 820) and 13-inch
(1376 × 1032); they show layout, hierarchy and behaviour. Build with native SwiftUI components; where a native
component does it better than a picture, use the native component. If something in the documents is wrong or can't
work, fix the document in the same change and say why; don't silently do something else.

**Priorities, in order:**
1. **The iPhone doesn't change.** Not one pixel, word, tap or millisecond on the iPhone, and nothing about data
   (Rulebook D) changes. Compact width on the iPad is the iPhone app exactly (I2).
2. **No data is ever lost** while rotating, resizing, splitting or closing a window mid-edit (D1–D10; U4; a typed
   amount survives a rotation).
3. **It feels like Apple's own iPad apps**: the patterns in the README's "Decided", nothing invented.
4. **It's fast** (Rulebook S): Today, scrolling and the popover at the iPhone's targets, measured on the iPad
   simulator with a year of history.

## 2. Read first

1. `RULEBOOK.md`, all of it. Especially S1–S10, D1–D8, U1–U4, U9, U12–U14, U17–U19, U23, U26, U28, T1–T4, T7, T10,
   T12, T14, T15, T17, W1, W3.
2. `iOS/Docs/iPad/README.md`, the report's §6, the design notes §1–§8, every picture.
3. `iOS/Design Rules — Don't Regress.md` for each screen you touch (U12): its decisions hold on the iPad too.
4. The code the iPad reshapes: `Habits/Today/TodayView.swift` (top bar, `dayBar`, sheets), `Today/DayBar.swift`,
   `Today/DaySheet.swift` and `AddLogView.swift`, `Menu/SideMenu.swift` and `Menu/MenuModel.swift` (the rows become
   the sidebar), `AllHabits/AllHabitsView.swift` and `HabitPageView.swift`, `Progress/ProgressScreen.swift`
   and `WeekCards.swift`, `Groups/GroupScreens.swift`, `Settings/*`, `Today/RoutinePlayer.swift`, `TimerScreen.swift`,
   `iOS/Shared` (widgets) and `iOS/Docs/Widgets — Taps and Updates (Locked).md` (its principles are what's locked:
   a tap shows at once; every tap is saved safely behind it).
5. `Architecture/11. iCloud Sync with CloudKit.md` §12 (the free plan's one syncing device; the iPad is named there).

## 3. What to build (the README's "Decided" is the source; this is the checklist)

- **Today:** the sidebar (`NavigationSplitView`, the menu's rows and order, counts beside Today, Habits, Tasks; the
  system's sidebar button); the column of the iPhone's cards at ≤ 700 pt, centred; the day control at the top centre;
  Edit · Filter + on the right; portrait with the sidebar put away; a narrow window = the iPhone layout.
- **Day details as a popover** anchored to its row (`.popover(item:attachmentAnchor:)` on regular width, the iPhone's
  sheet on compact: `.presentationCompactAdaptation(.sheet)`), no ✕; All logs, a log and Add log pushed inside it;
  Add log keeps ✕ and blocks outside taps while something is typed (`interactiveDismissDisabled`); the keyboard moves
  it up (landscape uses the SE's short Add log).
- **Habits and Tasks:** list–detail (the selected habit's page beside the list; no › on rows; the header centred).
  The ⋯ menu as a menu; Delete's confirmation as a popover from ⋯.
- **Progress:** Week · Month · Year at the top centre; cards two across in the person's order.
- **Settings:** each page beside the sidebar at ≤ 700 pt; the pages they open pushed there.
- **Sheets and popovers:** New (+) and the habit form, Edit Habit, Set Up App Lock, restore as **form sheets**
  (`.presentationSizing(.form)`); the calendar and Filter as **popovers** from their buttons; Edit Group pushed inside
  Filter (only its own habits + Add Habits; Current Work 85).
- **Full screen:** the routine player and the timer, as on the iPhone.
- **Keyboard and pointer (I11):** the menu bar's View menu (as List ⌘1, as Columns ⌘2, Hide Sidebar ⌃⌘S, Go to Today
  ⌘T, Previous Day ⌘←, Next Day ⌘→) and New Habit ⌘N, with SwiftUI `.commands`; hover effects; a right-click opens a
  row's long-press menu; Return adds on an Add screen.
- **Columns view:** each time of day a column (≈ 300 pt) in the person's order, scrolling sideways; columns never fold;
  Appearance → Layout (iPad only) and the View menu switch it; remembered per device.
- **Widgets:** add `.systemExtraLarge` to the Today list widget (ten a page, two columns of the Large rows, Large's
  paging, privacy and empty states); check every existing widget at iPad sizes; Lock Screen widgets as on the iPhone.
  Keep the switch-based instant tap and the safe save exactly (U26/U28 principles).
- **Words:** README "Words that change on the iPad", from the device (`UIDevice` idiom, `DeviceIdentity.name`,
  `biometryType`), never a second copy of a string.

## 4. System changes (no new data design is needed)

The iPad is the same app on another device: same database, same CloudKit sync (Architecture 11, free plan §12), same
backups and App Group. Build these, and nothing in the data layer:

1. `TARGETED_DEVICE_FAMILY = 1,2`; iPad orientations: all four; keep the generated launch screen (Apple's TN3192:
   iPad apps support every orientation and any window size; `UIRequiresFullScreen` is deprecated).
2. **Windows:** one window (`UIApplicationSupportsMultipleScenes` off) for version 1; every window size still works
   (iPadOS 26 windows resize freely). Keep per-window UI state (sidebar choice, open day, open sheet) in
   `@SceneStorage`, never in the store, so a second window can be added later without changes.
3. **Size classes:** regular → split view, popovers; compact → the iPhone's stack, ≡ drawer behaviour with the
   sidebar button, sheets. A change of width keeps whatever was open (a popover becomes the sheet and back).
4. **Capabilities to check on a real iPad, not assume** (say what you found in the README): Live Activities for a
   running timer; AlarmKit alarms (the Watch research found AlarmKit is iPhone and iPad); Health steps for a Walk
   habit; Touch ID / Face ID for App Lock; no haptics (hide the Haptics row).
5. **Speed:** the speed runs (`PerfDriver` scenarios) on the iPad simulator too, a year of history: Today, the
   popover, Habits list–detail, Progress, the Columns view.

## 5. Testing

- Run CI on the iPad simulator with the workflow's `device` input (an iPad device type, e.g. the newest
  "iPad Air 11-inch" and "iPad Pro 13-inch" types `xcrun simctl list devicetypes` shows), and keep the iPhone runs
  green (T1, T7, T10: your own branch, never cancel others' runs).
- UI tests for: sidebar navigation; Day details popover open, log, All logs, Add log with typing, close by tapping
  outside; the narrow-window fallback (a size-class override or a resized window); rotation mid-edit keeps the typed
  amount; Habits list–detail selection; Columns view switch (menu command and Appearance); the keyboard shortcuts.
- Screenshots of every designed screen from the iPad simulator, compared with `Designs/` (T14: one-line failures).
- The widget tests for the Extra Large family; the iPhone widget tests unchanged.
- Then list the real-iPad checks for the user (U9): §4.4's capabilities, popover placement with the keyboard up,
  Stage Manager / windowed resizing, a hardware keyboard.

## 6. Done when

- Every picture in `Designs/` is built, in landscape and portrait, 11- and 13-inch, and a narrow window.
- The iPhone is unchanged (its full UI test set passes, its speed runs are within noise).
- The iPad tests pass on GitHub; the speed targets hold on the iPad simulator.
- Current Work 86's items are ticked with run numbers (W1), the README updated with anything learned, and this file
  deleted.
