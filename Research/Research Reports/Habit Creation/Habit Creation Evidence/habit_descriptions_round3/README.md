# How People Describe a Habit (Round 3): evidence

Written by Claude (Claude Code), 28 September 2026. Evidence for [How People Describe a Habit — 4,407 Descriptions From Reviews](<../../How People Describe a Habit — 4,407 Descriptions From Reviews.md>) and [Creating a Habit — Round 3, The User's Own Words](<../../Creating a Habit — Round 3, The User's Own Words.md>).

Run every script from `Research/`. They read the review corpora and read and write `Temp/mental-model/` (gitignored: the intermediate files are large and can be rebuilt with these scripts).

| File | What it is |
|---|---|
| `crosscheck.csv` | **One row per statement (4,407).** Review ID, store, app, stars, date, the sentence, its hand codes, shapes (F01–F18), edge themes, the rows it fills in the Round 3 form, the verdict (Direct · Default · Partial · Not covered) and why, and what `describe.py` reads from the raw sentence. Any number in either report resolves to exact reviews here. |
| `extract.py` | Sentences with an intent marker and a frequency or amount, from every English or untagged review → `statements.jsonl` (8,783) |
| `extract2.py`, `pats.py` | Sentences with an activity verb near an amount or frequency → `statements2.jsonl` (7,867 more) |
| `merge.py` | Merge and de-duplicate → `candidates.jsonl` (10,969) and `rejects.jsonl` (5,681) |
| `filter3.py` | Split candidates by an everyday-activity lexicon → `habit_candidates.jsonl` (7,215) and `dropped3.jsonl` (3,754) |
| `parse.py` | The first slot parser, used to lay out the reading views (`hc_view.txt`) |
| `codes/` | **Hand codes** for all 7,215 `habit_candidates` lines (only kept statements are listed; `codes/README.txt` is the code grammar) |
| `dcodes/` | Hand codes from re-reading all 3,754 `dropped3` lines |
| `rcodes/` | Hand codes from reading the 1,114 set-aside sentences that name an activity |
| `aggregate.py` | Joins codes to sentences and IDs → `coded.jsonl`; checks references and code validity |
| `families.py`, `stats.py`, `vocab.py` | Shapes and counts, units, phrase counts |
| `x_themes.txt` | Hand sort of the 284 `:x` statements into themes (line numbers of `x_view.txt`, which lists `:x` rows of `coded.jsonl` in file order) |
| `logging_scan.py`, `logging_codes.txt` | Logging-expectation scan (391 hits) and its hand codes (LM1–LM7, 167 reviews) |
| `nl_scan.py` | Natural-language entry scan (67 + 4 + 6 reviews) |
| `describe.py` | Prototype of the "say it" parser: `python3 describe.py "Read 2 chapters a week"` |
| `crosscheck.py` | Maps every hand-coded habit to the Round 3 form and a verdict; compares the parser with the hand codes; writes `crosscheck.csv` |
| `verify_ids.py` | Checks every coded ID, and every ID and quote cited in a report, against the source files: `python3 "<this folder>/verify_ids.py" "<report>.md"` |
