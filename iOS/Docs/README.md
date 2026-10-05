# iOS Docs — what was decided and built for the app

Written by Claude (Claude Code), 28 September 2026.

These are the iPhone app's own documents: the specs it was built from and the user's point-by-point checklists for each round. They are kept apart from the store-review research in [`Research/Research Reports/`](<../../Research/Research Reports/README.md>), which is evidence. Everything here was implemented in the app, or is waiting to be.

**What the app can do today:** [What's Built](<What's Built.md>), a checklist ticked as each feature is finished.

## How to use these without reading them all

0. **The Rulebook first: [RULEBOOK.md](<../../RULEBOOK.md>)** holds every rule for every change: speed, data safety,
   design, testing and how we work (loaded by the root `CLAUDE.md`).
1. **Always read [Design Rules — Don't Regress](<../Design Rules — Don't Regress.md>) first.** It is the short version of everything below: each rule the app must keep, and the research behind it. For most changes it is enough.
2. **Before changing a screen, open only the spec for that screen** (table below). Read a research report only when a rule's reason is unclear or you need to change the rule.
3. **When the user asks for a change**, write every point they made into a new checklist in `Checklists/` before starting, and tick it as you go.
4. **When a decision changes**, update the spec and the matching line in Design Rules together, and mark the old text as superseded. Don't delete it.

## Specs (build from these)

| Spec | Status | Open it when you change |
|---|---|---|
| [Groups — What to Build](<Specs/Groups — What to Build.md>) | **Current.** Built 30 Sep: groups in Today's Filter, one editor, the habit form, Habits by group, group stats on Progress | Groups, Today's Filter, Progress's group chips |
| [Progress — What to Build, in Order](<Specs/Progress — What to Build, in Order.md>) | **Current.** Build Plan #60a–#60g: four fixes first, then Progress in three phases; Progress opens from the ≡ menu | Progress, the habit page's stats, Today's weekly-goal counting, cut-down limits, archive, quit slips |
| [Routine Player — Design Decisions](<Specs/Routine Player — Design Decisions.md>) | **Current.** Consolidates the routine player hierarchy, spacing, goals and actions with reasons | The full-screen routine player |
| [New Habit Goal and Time of Day](<Specs/New Habit Goal and Time of Day.md>) | **Current.** Its Schedule and Goal parts are superseded where they conflict with Design Rules' "Schedule and Goal" section | The New Habit form, Goal screen, Time of Day, units, checklists |
| [iPhone Widgets](<iPhone Widgets.md>) | iPhone widget kinds, App Group, logging/privacy contract, account and entitlement merge hooks; physical-device release matrix | Home/Lock widgets, widget publication, integration |
| [Widget research and design handoff](<../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widget Catalogue Study — 5 October 2026/README.md>) | **Proposal, 5 Oct.** Separate package: research, free/Plus catalogue, editable Figma, 28 PNGs, evidence and implementation acceptance; Current Work 9 stays open | Widget redesign, selection issue, progress layouts and plan boundary |
| [Analytics Contract](<Analytics Contract.md>) | Optional content-free iPhone collection; production sending gated off; future-client vocabulary is not coverage | Durable analytics callbacks, consent, daily summaries, screen attention and widget relays |
| [Pending to Implement](<Specs/Pending to Implement.md>) | **Partly superseded.** §6 and its sidebar reliability addendum cover reminder scheduling, alarms and notification actions | Reminders, alarms, Remind Again |
| [Today Improvements](<Specs/Today Improvements.md>) | **Partly superseded** by the Section Header research (28 Sep) | Today's sections, routine play, the day bar |

## Planning and current work

| Document | Purpose | Maintain here |
|---|---|---|
| [Product Roadmap](<../Product Roadmap.md>) | The whole app's capabilities, original build rounds and longer-term feature work; formerly Build Plan | Broad features and dated implementation history |
| [Current Work Checklist](<Checklists/Current Work Checklist.md>) | Recent user feedback, current issues, planned improvements and completed follow-ups; formerly Next Up | Current priority, progress and validation evidence |

Fix issues in existing functionality first (the user, 4 Oct 2026). Planned improvements stay in their recorded order
until the user starts them. When an item appears in both documents, the current checklist owns its current status;
the roadmap links to it and preserves the older history. Screen-specific checklists retain detailed requirements
and evidence. An unchecked item must be verified against current code before being described as a reproducible bug.

## Checklists (the user's points, round by round)

| Checklist | State |
|---|---|
| [Goal and Choice Screens — Round 2](<Checklists/Goal and Choice Screens — Round 2 Checklist.md>) | Done |
| [Section Header — Start and Left](<Checklists/Section Header — Start and Left Checklist.md>) | Done |
| [Schedule and Goal — Implementation](<Checklists/Schedule and Goal — Implementation Checklist.md>) | Done (by Codex, simulator only) |
| [Schedule and Goal — Round 2, Make It Intuitive](<Checklists/Schedule and Goal — Round 2 Checklist.md>) | Research done; superseded by Round 3 |
| [Creating a Habit — Round 3, The User's Own Words](<Checklists/Creating a Habit — Round 3, The User's Own Words Checklist.md>) | Research and design done; built 29 Sep |
| [Round 3 Build — Copy, Days, Dates and Limits](<Checklists/Round 3 Build — Copy, Days, Dates and Limits Checklist.md>) | Built 29 Sep; not yet compiled or run on a phone |
| [Full-screen Routine Focus Player](<Checklists/Full-screen Routine Focus Player.md>) | Built 29 Sep; research, validation and the user's ordered follow-up work |

| [Focus Player — Compact Progress and Fast Navigation](<Checklists/Focus Player — Compact Progress and Fast Navigation.md>) | Built 29 Sep; automation stopped at the user’s request |
| [Focus Player — Circular Hierarchy](<Checklists/Focus Player — Circular Hierarchy.md>) | Circular progress and two compact control rows; no automation tests per user |
| [Focus Player — Header and Habit Options](<Checklists/Focus Player — Header and Habit Options.md>) | Compact routine header, smaller circle and habit-specific action sheet |
| [Focus Player — Spacing and Goal Clarity](<Checklists/Focus Player — Spacing and Goal Clarity.md>) | Adaptive spacing, centred CTA, no checklist instruction, saved goal context |
| [Focus Player — Speed and Responsiveness](<Checklists/Focus Player — Speed and Responsiveness.md>) | Lag and the Pause fade measured and fixed 29 Sep (Today no longer redraws behind the player) |
| [Edit Habit](<Checklists/Edit Habit.md>) | Built 29 Sep: edit from the row's long-press menu, changes apply from today, goal history keeps past days |
| [Easy Undo and Fixing Progress](<Checklists/Easy Undo and Fixing Progress.md>) | Research done 30 Sep; build waits for the user |
| [Habit Notes and Day Notes](<Checklists/Habit Notes and Day Notes.md>) | Built 29 Sep: a note per habit per day, a description, and a note for the day |
| [Animations and Settings](<Checklists/Animations and Settings.md>) | Built 1 Oct on `animations-and-settings`: tick feedback and done rows that wait for a pause (#58), folding (#59), Appearance and Day and Week settings (#61) |
| [Sidebar Menu](<Checklists/Sidebar Menu.md>) | **Final** (30 Sep): the ≡ side menu with Progress, Habits, Tasks and every setting; built on the `sidebar` branch |
| [Merging the Branches](<Checklists/Merging the Branches.md>) | 1 Oct: every branch saved, the real ones merged into `integration`, the decisions made while merging, and what waits |
| [Groups](<Checklists/Groups.md>) | Built 30 Sep: research put together, plan, groups and group stats |
| [Progress Week — Visual Redesign](<Checklists/Progress Week — Visual Redesign.md>) | Research and five visual options (2 Oct). The user chose cards; built as [Progress Week — Habit Cards Build](<Checklists/Progress Week — Habit Cards Build.md>) |
| [Progress Page — Research](<Checklists/Progress Page — Research.md>) | Research done 30 Sep: [The Progress Page — What People Need, and How to Build It](<../../Research/Research Reports/Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>); not built yet (Build Plan #60) |
| [Sidebar — Backup Tasks and Reminders](<Checklists/Sidebar — Backup Tasks and Reminders.md>) | Free backup/export/restore, every saved task with editing, reminder reliability and Actions/performance evidence |
| [App Speed — Round 2](<Checklists/App Speed — Round 2.md>) | 30 Sep: optimised phone build, remembered streaks, instant taps, stall meter; rules in `iOS/PERFORMANCE.md` |
| [iPhone Widgets](<Checklists/iPhone Widgets.md>) | Research and implementation on `codex/iphone-widgets`; macOS results and device release checks are recorded in the research report |
| [Analytics Implementation](<Checklists/Analytics Implementation.md>) | Implemented on `analytics`; macOS native/UI/build/provider evidence and exact production rollout dependencies |
| [Current Work Checklist](<Checklists/Current Work Checklist.md>) | **Open.** Existing issues and validation first; planned improvements, future ideas and completed feedback retain their original item numbers and evidence |
| [Progress Week — Habit Cards Build](<Checklists/Progress Week — Habit Cards Build.md>) | Built 2 Oct on `claude/progress-week-cards` (not compiled yet): Week as one card per habit, dates bar pinned, key, no overview or rings |

Analytics recovery starts at [Analytics — Start Here](<../../Analytics — Start Here.md>). Saved provider definitions and verification are in [Analytics Dashboards.json](<Analytics Dashboards.json>); exact consent-off/on measurements are in [Analytics Performance Evidence.json](<Analytics Performance Evidence.json>).
