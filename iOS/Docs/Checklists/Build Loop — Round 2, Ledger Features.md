# Build Loop — Round 2, Ledger Features

Written by Claude (Claude Code), 29 September 2026. The user's points for this round, and each loop as it's done.

**Context (the user's words, tidied):** complete whatever else is needed. Work out the next most important things from the Feature Ledger's cards and build them one after another, in a loop, with the same process: research first, then build.

**Order chosen from the ledger** (Part 1 "What wins" and Part 7 "must-have", minus business and listing rules, minus what's built): Settings (C170, C038, C157/C207, C288, C075, C036, C085) · check-off feedback (C069, #58) · export and backup (C020, C034, C176) · widgets (C009, C023, C040) · Shortcuts (C046) · milestones (C101).

| # | Point | Done |
|---|---|---|
| U1 | Pick the next most important things from the ledger cards | [x] Order above |
| U2 | Research each, then build, one after another | [x] Each loop below |

## Loop 5 — Settings (#61)

Research: [Settings — What People Need There](<../../../Research/Research Reports/Settings and Help/Settings — What People Need There.md>).

| # | Point | Done |
|---|---|---|
| L5.1 | The avatar opens Settings, a sheet applied at once | [x] `SettingsView` |
| L5.2 | Day Ends At, midnight to noon; Week Starts On, any day; days already logged keep their dates | [x] `HabitStore.saveSettings` |
| L5.3 | Show Streaks (on by default); off hides Today's flame only | [x] `DaySettings.showStreaks` |
| L5.4 | Notifications off for the app: say so, link to iOS Settings | [x] |
| L5.5 | Times of Day from Settings too | [x] |
| L5.6 | How It Works: searchable answers naming where to tap | [x] `HelpView` |
| L5.7 | Plan row (Free, N of 5, Plus…); Privacy stated; Version | [x] |
| L5.8 | Contact Support | [ ] Row ready; hidden until a support address is set (`AppInfo.supportEmail`) |
| L5.9 | UI test | [x] `SettingsUITests` (written; not run: no Mac in this session) |
