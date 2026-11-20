# Evidence: What People Actually Pay For

Hand labels and the scripts that count them. Run every script from this folder with `python3 -I <script>`. The
scripts read the review files in `Research/App Store Reviews/` directly, or the text files here.

## App 1 — Habit Tracker – Goal Tracker & ADHD Planner

| File | What it is |
|---|---|
| `1-payer-final-ids.json` | The 962 + 1 reviews that say they paid. Line n of the labels = position n in this list. |
| `1-trigger-codes.py` | What made each one pay, labelled by hand from the full text (`T`; codes explained at the top). |
| `1-trigger-tally.py` | Counts by group and reason: all storefronts, outside China, US, China. |
| `1-family-share-read.txt` | The payers coded family, share, health, Watch or other, in full, for the "set aside" table. |
| `1-together-scan.py` | Finds candidate reviews about doing habits with other people (11 languages). Writes `1-together-read.txt`, `1-together-ids.json` and a sample of what the search left out. |
| `1-together-candidates.json` | The broader first search, used only to sample what the narrow search missed. |
| `1-together-read.txt` | The 1,011 candidates, oldest first (`idx\|review_id\|country\|rating\|month\| title \| text`). |
| `1-together-codes.py` | Hand labels for each candidate (`K`; codes explained at the top). |
| `1-together-tally.py` | Counts: all, outside China, China, US. |
| `1-together-excluded-sample*.txt` | Two random samples of reviews the search left out, read by hand to estimate what was missed (about 2.5%). |

## App 2 — Daily Habits

| File | What it is |
|---|---|
| `2-all-reviews.txt` | All 517 reviews, oldest first (`n\|country\|rating\|month\| title \| text`). |
| `2-all-ids.json` | Review ID for each line. |
| `2-codes.py` | Hand labels (`K`): `pay=Y/I/F`, `why=…`, `tog=…` (explained at the top). |
| `2-tally.py` | Payers, reasons, and the ones outside price, goodwill and the giveaway list. |

## Calendar sync (all habit apps)

| File | What it is |
|---|---|
| `cal-read.txt` | 830 habit-app reviews mentioning calendar sync or integration (`idx\|store\|app\|review_id\|country or language\|rating\|month\| text`). |
| `cal-ids.json` | `[store, app, review_id]` for each line. |
| `cal-codes.py` | Hand labels: direction, stance, payment, which calendar (explained at the top). |
| `cal-tally.py` | The counts in the report. |

## App 3 — Days Since

| File | What it is |
|---|---|
| `3-pay-read.txt` | The 951 reviews with a word about paying, price, buying or donating, oldest first (`n\|country\|rating\|month\| title \| text`). |
| `3-pay-ids.json` | Review ID for each line (one JSON list). |
| `3-codes.py` | Hand labels (`K`): `pay=Y/I/D`, `why=…` (explained at the top). Lines with no label say nothing about paying for this app. |
| `3-tally.py` | Payers, would-pay, donate, reasons, and the payers outside price, goodwill and the giveaway list. |

The 1★–2★ counts before and after the widget lock, and the money-saved count, are word searches over all 10,621
reviews in `reviews.jsonl`, marked as such in the report.

## App 7 — HabitKit

| File | What it is |
|---|---|
| `7-all-reviews.txt` | All 2,993 reviews, App Store (A) and Play (P), oldest first (`n\|store\|country or language\|rating\|month\| text`). |
| `7-all-ids.json` | `[store, review_id]` for each line. |
| `7-codes.py` | Hand labels (`K`): `pay=Y/I/F`, `why=…`, `disc=…` (explained at the top). |
| `7-tally.py` | Payers, reasons and how people found the app. |

The one-off counts in the report (the cap and widget complaints by word search, payers by country and language) were
run by hand from these files and are marked as word searches where they are.
