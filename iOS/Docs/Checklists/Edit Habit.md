# Edit Habit

Written by Claude (Claude Code), 29 September 2026. Build Plan #53 (the old #47). The decisions were already made in [New Habit Goal and Time of Day §8](<../Specs/New Habit Goal and Time of Day.md>) (27 Sep); this round builds them.

**Context (the user's words, tidied):** note down the order of the remaining features (done: Build Plan "Complete every feature"), then work on editing a habit. The goal is getting every screen and feature right for Figma, not release; no iPhone testing.

## Points

| # | Point | Done |
|---|---|---|
| E1 | Record the feature order in the Build Plan | [x] #53–#61 |
| E2 | A habit can be edited after it's made | [x] Long-press a row → Edit Habit (also quit rows, and Habit options in the player); the New Habit form opens filled in, Save greyed until something changes, Cancel asks before discarding |
| E3 | Only what can change is shown; how it's tracked (check, amount, time, checklist; build, cut down, quit, task) is fixed and not shown (§8) | [x] The form never shows the type; each type keeps only its own rows |
| E4 | Changes apply from today; past days keep the result they had (goal history, §8.2) | [x] Water 8 → 10 glasses: today 8/10, yesterday still 8/8 done; stored as `rules.<id>` (goal history) |
| E5 | The streak continues unless the kind of period changes (day ↔ week ↔ month ↔ year); then it restarts (§8.3) | [x] 8 → 10 kept the 22-day streak; day → week shows the restart line |
| E6 | Before saving, one line says what will happen (§8.4) | [x] "Changes apply from today. Your history stays as it was." / "Your streak restarts. Your history stays." |
| E7 | Checked by hand on the simulator | [x] iPhone 17 simulator, by hand |

## Evidence and decisions

- **Editing never wipes history:** Feature Ledger C041 (Strong, 7 apps, all negative about apps that lose history on edit, archive or cadence change). **Editing is free:** C073.
- **Where Edit lives (reasoned from first principles):** a tap on a row already logs (counts and timers open Log manually; decided in "Logging a Count — One Tap or Type"), so Edit can't take the tap. It goes where iOS puts actions on an item: the row's long-press menu ("Edit Habit", as in Reminders), and in the routine player's Habit options. A full habit page (notes, pause, stats) comes with those features (#54–#56).
- **Goal history, just enough:** kept per habit in the settings table (`rules.<id>`), no schema change. Each entry is the rule that applied up to and including a day. Editing twice in one day keeps the rule from before today.
