# Schedule and Goal Round 2 — evidence

Written by Claude (Claude Code), 28 September 2026. Evidence for [Schedule and Goal — Round 2, Making It Intuitive](<../../Schedule and Goal — Round 2, Making It Intuitive.md>).

| File | What it is |
|---|---|
| `scan.py` | Regex scan of every `reviews.jsonl` (App Store, Play Store, native apps) for 8 themes. Writes `Temp/schedule-goal/hits.json` (2.9 MB, not committed). |
| `show.py` | Prints a theme's hits with a text window around the match, the way they were read. |
| `codes.py` | The hand-curated code → review-ID map (1,714 assignments, 1,401 distinct reviews). `A:` App Store, `P:` Play Store, `N:` native apps. |
| `add.py` | Helper used while coding. |
| `verify_ids.py` | Checks every coded ID, and every ID cited in a report, against the source files. Run from `Research/`: `python3 "Research Reports/Habit Creation/Habit Creation Evidence/schedule_goal_round2/verify_ids.py" "<report>.md"`. |
| `phrases.py`, `phrases.txt` | Phrase counts over 922,405 English (or untagged) reviews: the words people use for schedules. |
| `review_index.md` | Every coded review, grouped by code, with store, ID, app, stars, date and excerpt. Any number in the report resolves to exact reviews here. |

Run the scripts from `Research/`. `scan.py` and `show.py` read and write `Temp/schedule-goal/`.
