# Focus player — compact header and habit options

Written by Codex, 29 September 2026.

## User requests

- [x] Reduce the circle size a little across habit types.
- [x] Restore routine identity to the top; move the habit title immediately above the circle.
- [x] Combine routine name, position and queue access in one header button; remove the separate Habit N of M / View routine row.
- [x] Preserve the segmented progress indicator below the toolbar and the routine-only top menu.
- [x] Research whether manual time logging belongs upfront; preserve meaningful access.
- [x] Replace bottom Skip today with a clearly named habit-options button opening a bottom sheet.
- [x] Group manual logging, skip/undo skip, undo entry and clock visibility in that habit-specific sheet.
- [x] Preserve the primary action, chevrons, timer saving and manual-entry behavior.
- [x] Build and visually inspect in the open simulator; no automation suite.

## Research and decision

Existing review synthesis: [Timing a Habit — Start, See and Stop](<../../../Research/Research Reports/Habit Creation/Timing a Habit — Start, See and Stop.md>), section 5. It reports 37 habit-tracker and 52 routine-app reviews seeking alternatives to mandatory timing, including typing elapsed time or simply checking completion. These are combined qualitative themes, not a measurement of manual logging frequency, and not all are requests for manual entry specifically. No product telemetry establishes how frequently our users log manually.

[Apple's Design with iOS pickers, menus and actions](https://developer.apple.com/videos/play/wwdc2020/10205/), transcript discussion of secondary actions: menus can consolidate secondary actions, but hiding important frequent primary actions adds friction. Apple favors anchored menus for short lists; the user explicitly requests a bottom sheet, so use a native sheet with clear habit context and medium/large detents.

Design judgment: within a running routine, retain Start/Pause/Resume as the primary timed action. Put Log time manually first in Habit options, one extra tap away, and retain the clock-tap shortcut and direct manual entry from Today. This is a contextual decision, not a claim manual logging is universally rare. Amount habits configured to type each entry keep Log manually as their primary button. The bottom label is Habit options (Task options for tasks), which distinguishes it from the routine menu better than generic More. The sheet is titled with the current habit name.

Top header: Morning · 2/10 with a downward chevron opens the routine list. The number describes position, not completions; VoiceOver states this explicitly. Progress segments retain completion state. Habit title stays with its own page, immediately above the smaller circle.

## Validation

Simulator build succeeded. Inspected actual iPhone 17 screenshots of the compact header, reduced circle and habit-options sheet using isolated fixture data. No automation suite was run. Visual inspection covers rendering; tap-driven sheet-to-logging and skip flows were not exercised in this pass. Saved main-screen screenshot: `Research/Temp/ios-shots/circular-simulator/compact-header.png`. The sheet was visually inspected before its background was made opaque; the final capture showed the task page after the simulator state changed.
