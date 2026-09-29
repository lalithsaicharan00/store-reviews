# Focus player — spacing and goal clarity

Written by Codex, 29 September 2026.

## Requests

- [x] Give the header progress segments approximately 20–24 logical units of clearance from the toolbar, adapting rather than using physical pixels.
- [x] Centre the main CTA with enough separation from other targets to reduce accidental taps.
- [x] Remove the checklist's Tick each step instruction and its reserved row.
- [x] Show saved goal meaning consistently, particularly flexible daily targets versus weekly quotas.
- [x] Document decisions, reasons and validation.

## Decisions and reasons

SwiftUI dimensions are logical points, independent of Retina pixel density. Use a 24-point baseline scaled with Dynamic Type for the header's top spacing and separation between action rows, capped at 36 points to avoid excessive whitespace at accessibility sizes. Keep the bottom edge of the progress segments at 8 points of padding, so the bar moves down a modest amount.

The primary CTA is centred horizontally, with a 240-point baseline width that scales to a maximum of 320 points and stays within the available width. It remains at least 52 points tall. Its own visible capsule is its hit target; the surrounding whitespace is not part of the label. A scaled 24-point gap separates it from the chevrons/options row. This is a spacing decision, not a claim that mis-taps are impossible.

An unfinished checklist has no extra instruction or disabled CTA. The tappable checklist rows are the actions. Completion still exposes the normal Next/Finish action.

Goal context has one location, under the habit name and above the circle. A daily/scheduled-day quantity says Today; weekly/monthly/yearly aggregate quantities say This week/month/year. Their denominator already supplies the numeric target and units. Flexible goals instead display the saved plan using the existing HabitCopy formatter, e.g. 20 min on 3 days a week. The circle continues showing today's elapsed time against today's 20-minute target, with an accessibility description stating Today. The old 0/3 days progress line is removed from the circle; completed-day progress remains available in Habit options. This distinguishes the target set by the person from progress made toward it and avoids presenting a weekly quota as today's duration goal.

Use one line at standard text sizes; permit wrapping at accessibility sizes rather than truncating a saved goal. Preserve the existing header/menu distinctions, manual entry access, timer behavior and data.

## Validation and consolidated record

Simulator build succeeded. Inspected the rendered daily-amount page: toolbar/progress spacing, goal context above the circle, and centred CTA with separation from navigation. The simulator had moved to Drink water by screenshot time, so this does not claim visual verification of Flexible reading in this pass. No automation suite ran. The updated app remains available in the simulator.

The complete current design and reasons, including earlier iterations, are consolidated in [Routine Player — Design Decisions](<../Specs/Routine Player — Design Decisions.md>).
