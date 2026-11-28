# Routine Player — Helps and Dislikes (Routinery)

Written by Claude (Claude Code), 28 November 2026, at the user's request. **This file is the prompt.** An agent
picking up this work reads it whole, then follows the steps.

## What we're trying to find out

The user's words, 28 November 2026: *"In the routinary app, what are the things that are genuinely helping the users,
and what are the things that genuinely users don't like in the routine player screen? … list out why as well, and
including the numbers."*

The **routine player** is Routinery's full-screen view that runs a routine one step at a time, with a timer on each
step. For it:

1. **What genuinely helps**, with the number of reviews, their average rating, what it is and why it helps.
2. **What users dislike**, the same way.

The answer is one report, [Routinery — Routine Player — What Helps and What Users Dislike](<Routinery — Routine Player — What Helps and What Users Dislike.md>):
9 findings that help and 18 that hurt, numbered 1–27. The same 27 are cards OE-1 to OE-27 in the Often enough Jira
space (labels `routine-player`, `helps` or `dislike`).

## Rules

- **From Routinery's labels only** (`Review Labels/Routinery/<YEAR>/labels.jsonl`); read a review in full
  (`reviews.jsonl`) only to settle a doubt or check a quote.
- **Every number resolves to reviews.** `Tools/player_themes.json` holds the full review IDs for every theme, and the
  report's appendix lists them.
- **Quotes are exact.** A label's `problem` or `feature` text is a summary, not a quote: quote only the label's
  `quote` field or the review text. (A first draft put the summary "feel like failure" in quotes; it was fixed.)
- **Counts are distinct reviews, with the average rating**, and counts under about 10 are called weak.
- **Independent of our own app**: never mention it in the report.
- Work on `main` and push there.

## Method

Run from anywhere: `python3 -I "Review Insights/Routinery/Routine Player — Helps and Dislikes/Tools/player_themes.py"`
prints each theme's size, average rating, low ratings (1–2★) and store split, and writes `player_themes.json`.
Add `appendix` to print the appendix table.

- **Problem themes (`P`)** are hand-made lists of review-ID prefixes, made by reading every candidate label from the
  `problems` field (broken, missing, dislike) that touches running a routine. Each prefix must match exactly one
  review, or the script stops.
- **Help themes (`H`)** are word patterns over `liked` and `chose_for`. False matches found by reading are taken out by
  ID (`excl`) or by pattern (`exrx`), e.g. "pause and breathe", "over time" meaning "gradually", "choice of timer type".
- **Watch themes** (`watch_running`, `watch_wanted`) are patterns over `problems`, checked in samples rather than read
  one by one.

How the 27 findings map to themes:

| # | Theme(s) |
|---|---|
| 1–8 | `timer`, `guided`, `voice` (+`hands_free`), `eta` (+`eta_wants_more`), `skip`, `records` (+`end_screen`), `pause`, `kind_tone` |
| 9 | `add_time`, `overtime`, `auto_next`, `manual_next_choice`, `reorder_mid`, `pause_reminder`, `time_up_cue`, `visual_timer`, `white_noise`, `end_praise`, `lock_island` |
| 10–15 | `undo`, `button_placement`, `skipped_gone_order` (+`no_skip_button`), `edit_mid_run` (+`notes_mid_run`), `parallel`, `no_breathing_room` |
| 16–17 | `timer_forced`, `timer_stress` (+`hide_numbers`) |
| 18–22 | `no_time_up_alert`, `voice_dislike` (+`voice_cant_off`, `voice_wants`, `voice_broken`), `nagging_alerts`, `alert_sound_control`, `stops_music` (+`wants_music`) |
| 23 | `outside_app_missing` (+`outside_app_broken`) |
| 24–27 | `run_lost`, `battery` (+`battery_while_running`), `taps_freeze` `autonext_broken` `eta_wrong` `timer_state_wrong` `skip_bugs` `starts_last_step`, `watch_running` (+`watch_wanted`) |

Themes in the script but not in a finding: `wants_autonext` (19, wishes for auto-advance, covered by finding 9's
helps), `autonext_dislike` (2), `overtime_missing` (3).

## Steps to update

1. Re-run the script after new reviews are labelled; check every prefix still resolves.
2. For problem themes, read the new candidate labels and add their prefixes by hand.
3. For help themes, list each pattern's new matches and exclude false ones.
4. Update the report's numbers, then regenerate the appendix (delete the old table, append the new one).
5. Check every backticked ID and "(N votes)" in the report against `reviews.jsonl`, then commit and push to `main`.

## Files

| File | What it is |
|---|---|
| `Routinery — Routine Player — What Helps and What Users Dislike.md` | The report |
| `Tools/player_themes.py` | Every theme, the counts and the appendix |
| `Tools/player_themes.json` | Theme → full review IDs (`P` problems, `H` helps) |
