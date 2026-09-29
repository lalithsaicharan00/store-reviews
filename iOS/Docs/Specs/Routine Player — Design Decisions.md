# Routine player — current design and decisions

Written by Codex, 29 September 2026.

This records the current result of the user's hands-on design iterations. Where older checklists differ, this document and the latest Design Rules describe the intended layout. Earlier checklists remain as history.

## Hierarchy

The toolbar identifies the routine. The content identifies the habit and its goal. The circle shows current progress. The primary button performs the habit's main action. Bottom navigation and the options sheet carry secondary actions.

| Decision | Reason |
|---|---|
| Header is the section name, position and downward chevron, e.g. Morning · 2/10 | Combines identity, location and access to the queue without a separate Habit N of M / View routine row. The number is position, not completions; VoiceOver says this explicitly. |
| Tapping the header opens the routine list | A visible chevron communicates that the heading is interactive. |
| Close is left; the routine-only menu is right | Keeps session-wide actions distinct from actions on one habit. |
| Segmented progress remains below the toolbar | Shows covered/current/remaining habits without repeating another textual counter. |
| Habit title is above the circle | Separates routine identity from the current action and keeps the circle uncluttered. |
| Circle is 272 logical points at normal available widths; checklist circle is 236 | Reduced from the initial 320-point ring after feedback. Checklists need room for their actionable steps. The circle also shrinks to fit available width. |
| Icon and current/target stay inside the circle | Makes the activity and its actual progress the central information; target units and maximum-limit wording remain meaningful. |

## Goal context

One goal-context line sits between the habit title and circle. It replaces the earlier period label and separate flexible-day progress line inside the ring.

| Saved goal | Goal context above the circle | Main progress |
|---|---|---|
| Daily amount, check, checklist or task | Today | Current / today's target, with units where applicable |
| Three checks per week, such as Call family | This week | Total checks / 3 for this week |
| Weekly, monthly or yearly amount/time total | This week / This month / This year | Accumulated quantity / saved target for that period |
| 20 minutes on three days a week | 20 min on 3 days a week | Today's elapsed time / 20 min |

Flexible goals contain two quantities: what to do on a qualifying day, and how many qualifying days are needed. The saved goal is formatted by the existing HabitCopy implementation, not inferred from a test habit's name. Its day-count progress, such as 0/3 days this week, remains in Habit options. It is not a replacement for today's duration target. VoiceOver includes the progress value's period. The context line may wrap at larger text sizes rather than losing goal information.

## Actions and spacing

The main action stays visible: Start/Pause/Resume for timers, the configured quick increment for amounts, and Mark done/Log one for checks. Once complete, it becomes Next or Finish routine. Checklist rows are directly tappable; there is no Tick each step instruction or disabled placeholder CTA. Completed checklists still show Next/Finish.

The CTA is centred horizontally. Its baseline width is 240 logical points, scales with Dynamic Type, is capped at 320, and remains constrained by available width. The visible capsule supplies its hit region and is at least 52 points tall. Empty space around the capsule is not an enlarged invisible button.

A baseline 24-point gap, scaled with Dynamic Type and capped at 36, separates the CTA from the lower navigation row. The header's progress segments use the same scaled top gap and retain 8 points below. SwiftUI uses logical points rather than physical pixels; Retina scaling is handled by the platform. These choices reduce crowding and accidental-tap opportunities; no usability study establishes a zero-misclick guarantee.

Bottom navigation is previous chevron, Habit options (Task options for tasks), and next chevron. Navigating does not mark an activity done or skip it. The last chevron opens the summary.

## Habit options and manual logging

The bottom button opens a medium/large native sheet titled with the current habit. It contains relevant actions: Log time/amount manually, Skip today or Undo skip, session-specific undo, and Show clock. Flexible goal details appear there too. Day skipping is offered only where the stored schedule supports it. The top routine menu remains session-wide.

Manual time logging is first among applicable action choices. Existing review research establishes a need for alternatives to mandatory timers, including forgotten starts and time tracked in another app. It does not establish how frequently our users use manual logging. Treating it as secondary inside a running routine is a contextual design decision. Clock tapping remains a shortcut, and direct manual entry from Today remains available. Amount habits configured to type every entry keep manual logging as the primary action.

Apple's [menus and actions guidance](https://developer.apple.com/videos/play/wwdc2020/10205/) supports separating primary and secondary actions. The user's requested bottom sheet is used rather than an anchored pop-up. See [Header and Habit Options](<../Checklists/Focus Player — Header and Habit Options.md>) for the evidence and limitations.

## Behavior retained

Timer starts/stops update visible state immediately and queue persistence in order. Navigation does not wait for storage. Saves still surface errors. Opening manual time entry pauses/saves the running timer so that time is not counted twice; dismissal resumes a timer that was previously running, subject to existing completion rules. The clock alone redraws each second. Routine navigation, skip, undo, limits and daily/period counting keep their existing data semantics.

## Verification and history

Builds have succeeded for the simulator. Actual screenshots have been inspected during the iterations, including the live clock, weekly checks, amounts, checklist and options sheet. The latest spacing pass was visually inspected on an iPhone 17 simulator's daily-amount page; the user was also navigating the simulator. Automation suites were not run, per the user's instruction. This is not a claim that every interaction, text size or device has been tested.

Detailed change history and reasons:

- [Compact Progress and Fast Navigation](<../Checklists/Focus Player — Compact Progress and Fast Navigation.md>)
- [Circular Hierarchy](<../Checklists/Focus Player — Circular Hierarchy.md>)
- [Header and Habit Options](<../Checklists/Focus Player — Header and Habit Options.md>)
- [Spacing and Goal Clarity](<../Checklists/Focus Player — Spacing and Goal Clarity.md>)
