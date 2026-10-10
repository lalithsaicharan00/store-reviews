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
| [**Widgets — Taps and Updates (Locked)**](<Widgets — Taps and Updates (Locked).md>) | **LOCKED 8 Oct 2026 (U28).** How a widget tap shows at once, is saved by the app in the background, and how widgets update; every decision (W1–W17), measurements, files, Home Screen checks | **Before changing anything a widget does** |
| [iPhone Widgets](<../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Native Integration and Release.md>) | iPhone widget kinds, App Group, logging/privacy contract, account and entitlement merge hooks; physical-device release matrix | Home/Lock widgets, widget publication, integration |
| [Widgets — implementation spec for every widget](<../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Implementation Spec — Every Widget.md>) · [Widgets folder start page](<../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/README.md>) | **Build from this (6 Oct).** Every widget to build: Small, Large/Medium Today lists, weekly Medium, Tasks, Lock Screen; sizes, type, icons, paging, actions, privacy, decisions, test plan; images and Figma links. Current Work 9 (build) and 58 (App Lock, next) | Building or changing any widget |
| [Day Details, Logs and Notes — 7 October Redesign](<../../Research/Research Reports/Day Structure and Organization/Day Details, Logs and Notes — 7 October Redesign/README.md>) | **Accepted for building, 7 Oct; not built.** One folder: the pages to update (with the code behind each), 74 images of every screen, the design decisions. Layout, not exact spacing: build with native components and adapt to the screen's height, iPhone SE first. Read its "Read this first" | Day details (from Today and History), All logs, Add / Log / Edit log, slips, check and checklist adds, Add / Note / Edit note |
| [App Lock Redesign — What to Build](<Specs/App Lock Redesign/README.md>) | **Designed 9 Oct 2026, not built** (Current Work 58.13). Build from this for App Lock: Privacy & Security's App Lock row, the App Lock page (one switch, options once it's on), the setup sheet (If Face ID doesn't work → app passcode explained → enter twice), Lock Again menu, and the new words everywhere ("the app", "app passcode"); screen images and Figma | ≡ → Privacy & Security → App Lock, the lock cover's words, Help's Privacy & Security topics |
| [Account and Backup Redesign](<Specs/Account and Backup Redesign/README.md>) | **Designed and reviewed 10 Oct 2026, not built** (Current Work 76). Sidebar order, the Account page (signed out / free / Plus, Sign In and Create Account sheets), Backup & Export in every state with one backup place at a time, Move to Another Device (transfer code), Restore per state; review evidence, images, Figma, build section (§8) | ≡ menu, Account, Backup & Export, moving and restoring |
| [Habit Progress — Overall Record, Streaks and Milestones](<Specs/Habit Progress — Overall Record and Streaks/README.md>) | **Designed and approved 11 Oct 2026, ready to build** (Current Work 29). Overall record with Current/Best streak, Goal met and Best day (Best week for period goals) in a 2 × 2 grid; Milestones as medals for reached ones, one Next ring per track, See all page; every ladder value kept (to 5,000) and about 15 in-a-row milestones per goal period; every habit type and goal period; edge cases E1–E11 (goal changes keep medals); build notes; Figma frames 1–5 | Habit details → Progress |
| [Free Sync — One Device at a Time](<Specs/Free Sync — One Device at a Time/README.md>) | **Decided 11 Oct 2026, planned, not built** (Current Work 78). Free accounts sync like Plus with one device signed in at a time; signing in elsewhere signs the first out. Everything: server changes (S1–S8), app changes (A1–A8), costs re-checked with Cloudflare, why phone + iPad stays Plus, data safety, tests, rollout | Sync, accounts, Backup & Export, the server's sync and auth |
| [Privacy & Security — What to Build](<Specs/Privacy & Security — What to Build.md>) | **Decided 9 Oct 2026, not built** (Current Work 58). Privacy becomes Privacy & Security; the Widgets page goes (its guide moves to Help); App Lock, the optional Often Enough code, Face ID changed, the 24-hour reset, Ask Again, Hide Names Outside the App, Reminder Says; every message's wording | ≡ → Privacy & Security, the lock screen, the Widgets guide in Help, a habit's Reminders, reminders/Siri/Live Activity text |
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
