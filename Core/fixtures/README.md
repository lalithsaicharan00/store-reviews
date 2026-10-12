# Golden cases for the habit rules

Written by Claude (Claude Code), 12 October 2026 (Current Work 92). The habit rules' contract in numbers: inputs (the
database's rows, a time zone and a fixed "now") and **the iPhone's own answers**, recorded by running the iPhone's code,
so they are what people saw on 12 October 2026, not what anyone assumed. The shared Kotlin rules (`Core/rules/`) must give
the same answer to every one (`GoldenTest`); the rules themselves are written down in [`../spec/`](../spec/README.md).

## Files

| File | What | Kept in git |
|---|---|---|
| `tools/generate.py` | makes every input (`fixturelib.py` writes rows exactly as the iPhone saves them) | yes |
| `tools/hand.py` | the hand-written cases, named after the spec rule they test (`DAY-3 …`, `S-4 …`) | yes |
| `tools/seeded.py` | seeded random histories: every kind, schedule, day start, week start, zone and edit | yes |
| `inputs/hand.json` | the hand-written cases | yes |
| `inputs/seeded-1…4.json` | 2,000 seeded cases (500 a file; every 25th also records the screens, `full`) | no: made by `generate.py` |
| `inputs/year.json` | 450 days of twelve habits of every kind, with the Apple Watch's 400 days (`watch`) | no |
| `inputs/zz-extreme.json` | the extreme account: 40 habits, 15 years, 375,090 logs | no |
| `expected/*.json.gz` | the iPhone's answers, one file per input | yes |
| `expected/inputs.sha256` | the SHA-256 of each input the iPhone answered; `GoldenTest` refuses a different one | yes |

`python3 Core/fixtures/tools/generate.py` makes the inputs (about 20 seconds); the same script always makes the same
files. CI runs it before `./gradlew jvmTest` (core-tests.yml, ios-tests.yml).

## Recording the iPhone's answers

`.github/workflows/core-fixtures.yml`, on a push whose message contains `[core-fixtures]`: builds the iPhone app, makes
the inputs, runs the app on the simulator with `-golden-record` (`iOS/Tools/golden/record.sh`; the recorder is
`iOS/Habits/Model/GoldenRecorder.swift`, Debug only), and pushes the answers to the branch `<branch>-fixtures`. Copy them
into `expected/` with that branch's `inputs.sha256`. Each case loads exactly its rows into a fresh in-memory store, with
the case's time zone (`fixedTimeZone`) and "now" (`clock`), and asks the store's own functions.

## A case

```json
{"name": "DAY-3 America/New_York spring day start 2", "rules": ["DAY-1", "DAY-3"], "timeZone": "America/New_York",
 "nowMs": 1772989200000, "window": ["2026-03-05", "2026-03-11"], "probes": [1772949600000],
 "detail": "full", "watch": false,
 "snapshot": {"habits": [{"id": "…", "kind": "check", "goal": 1.0, "frequency": "daily", "createdAt": …}],
              "steps": [], "reminders": [], "entries": [{"id": "…", "habitId": "…", "day": "2026-03-08", "value": 1.0,
              "createdAt": …, "timeZone": "America/New_York"}], "settings": [{"key": "week_start", "value": "2"}]}}
```

Rows use `Core`'s record field names (spec/README.md "Reading saved data").

## An answer

| Key | What |
|---|---|
| `today` | DAY-1 for "now" |
| `probes` | `[moment, day]` for each probe moment (DAY-1…DAY-3) |
| `bounds` | `[day, first ms, last ms]` for the window's ends and today (DAY-5) |
| `periods` | `[day, [week], [month], [year]]` (DAY-6) |
| `weekdays` | the window's first seven weekdays (DAY-7) |
| `cards`, `members`, `sections` | Today's cards, what each holds, the timed sections and their ends (P-1, P-2) |
| `habits[]` | per habit: `start` (DAY-9), `placements`, `slots`, `periodKind`, `isTotal`, `canSkip`, `canPause`, `runs` (`[first, last, length, current]`), `best` (ST-4), `streakUnit`, `quit` (ST-5: `current`, `best` seconds, `slips`, `history` `[start, end, ending]`, `startDay`), and `days` |
| `habits[].days[]` | one row per window day: `day, due, planned, dayGoal, dayProgress, dayMet, progress, goal, done, flexible (-1: none), complete, satisfied, periodMet, outcome, share, mark, streak, countsUp, fraction, periodRange, skipped, paused, archived` (S-1…G-9, ST-1) |
| `scores` | `[day, done, part, partCount, planned, summary done, summary planned]` (P-3) |
| `watch` | `[habit, streak, best, has logs before the 400 days]` loaded as the Watch does (ST-6) |
| `milestones` | ST-7's ladders (the `ST-7 milestones` case) |
| `full` | `detail: "full"` only: Progress (Week, Month, Year, rows and cards), the habit page's record, Over Time, the weekday chart, quit statistics and the widgets' snapshot, recorded whole for checkpoint 2 |

Numbers compare within one millionth (a sum of the same logs in another order can differ in the last bit).
