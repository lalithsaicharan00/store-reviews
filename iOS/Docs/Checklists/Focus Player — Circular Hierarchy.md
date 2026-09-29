# Focus player — circular hierarchy

Written by Codex, 29 September 2026.

## User requests

- [x] Prioritize the current habit and progress consistently across every habit type.
- [x] Put the habit title at the top, outside the circle.
- [x] Centre a circular progress display with the icon, current/target, and period underneath, all inside it.
- [x] Keep daily, weekly, monthly and yearly targets correct; retain units, limits and flexible quotas.
- [x] Reduce the bottom controls to a logging row and a navigation row.
- [x] Put manual logging beside the primary action.
- [x] Replace the next-habit card with two chevrons and Skip today between them.
- [x] Keep generous spacing and reachable controls, checklist steps, undo, clock visibility and routine navigation.
- [x] Build for iPhone successfully. No automation tests run, as instructed.
- [ ] Install on the iPhone: paired iPhone 16 is currently unavailable; user asked to reconnect/unlock it.

## Reference and decisions

Viewed the timer screenshot on [Routinery’s App Store page](https://apps.apple.com/us/app/routine-planner-habit-tracker/id1450486923): habit title above a circular icon/timer display. The user's requested hierarchy drives this implementation; the screenshot is a visual reference, not usability evidence.

Replaced: the linear bar, side-by-side period badge, next-habit preview card, and three-row control shelf. Retained: the actual progress and target, saved units, period meaning, timer state, flexible quotas, checklist actions, manual logging, undo, skip/undo skip, queue and summary. Skip remains available only for habits that support skipping a day; period totals and limits keep their existing rules. Chevrons navigate without logging or skipping.

## Simulator visual review

29 September 2026: built and launched on iPhone 17 Simulator (iOS 26.5), using isolated sample habits. Inspected actual screenshots of a daily amount, weekly check, running timer and checklist. The timer advanced from 0:09 to 0:29 with corresponding ring progress. Found the checklist's last row partially below the viewport; reduced its circle to 260 points and confirmed all three sample steps now fit. Other habits retain the 320-point circle. Screenshots: `Research/Temp/ios-shots/circular-simulator/`.

No automated UI test suite was run. This was rendering and live-timer inspection; tap-driven navigation, logging and persistence were not exercised in this pass. Simulator remains open on the timer for the user to review. The simulator-only `-focus-preview` launch option waits for fixture loading and opens the actual player directly.
