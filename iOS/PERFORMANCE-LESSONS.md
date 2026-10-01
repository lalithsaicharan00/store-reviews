# Performance lessons — never repeat these

Written by Claude (Claude Code), 1 October 2026, at the user's request: "Performance is the main thing. We need a
snappy, fast, the best possible experience. Note down everything found, so no agent working on this project, or on
any other app, ever repeats these mistakes."

**Every agent reads this before changing any app code**, in this project or another. The rules this project enforces
are in [`PERFORMANCE.md`](PERFORMANCE.md) (loaded into every session; `Tools/perf/check_rules.sh` fails on the ones
code can show). This file is the why behind them, written so any SwiftUI app can use it: each lesson is a mistake
that was actually made here, what it cost (measured, not guessed), the fix, and how to catch it. Add every new finding
here the same day, with its numbers.

## The mistakes

| # | Mistake | What it cost (measured) | Do this instead | How it's caught |
|---|---|---|---|---|
| L1 | **Shipping an unoptimised build to the phone** (Debug at `-Onone`, the shared Kotlin core as debug) | Every screen several times slower on the iPhone than the same code optimised (30 Sep) | The configuration the user installs is optimised: `-O`, release core | `check_rules.sh` |
| L2 | **Judging speed by eye, screenshots or reasoning** | Fixed taps looked slow and slow ones fine (29 Sep) | Measure before and after, in the app with nothing attached (`PerfDriver` + `MainThreadMeter`, `[ios-perf]`) | Every change touching a screen gets a speed run |
| L3 | **Measuring through UI tests** | XCUITest's screen reading was up to 79 % of the app's main thread and showed 4-second freezes the app never had (30 Sep) | The app drives itself; tests only check behaviour | `PERFORMANCE.md` rule 2 |
| L4 | **A ticking view around a screen or list** (`TimelineView`, `Timer`, ticking state), even once a minute | Today redrew every row every second while a timer ran; a once-a-minute `TimelineView` around the list redrew it on every scroll frame, 55 % busy (29–30 Sep) | Only the one `Text` showing the time ticks; the screen moves its clock with a `.task` that sleeps until the next moment that matters | `check_rules.sh` (allowed files only) |
| L5 | **A `TimelineView` anchored at `.now`/`.distantPast`, or switched with a plain view** | The app froze; the player's circle faded on Pause (28–29 Sep) | Anchor at a fixed date; pause with a schedule that never ticks | `check_rules.sh` |
| L6 | **Walking history in a view's `body`** (streaks, totals, counts) | One tap recalculated every row's streak over a year (30 Sep); the habit page's "Goal met … since" walked all history on every redraw (1 Oct) | Work it out once in the store, remember it, forget it only when what it reads changes | Review: anything that loops over days or entries in a view is a bug |
| L7 | **Building a formatter on every call** (`NumberFormatter()`, `DateFormatter()` …) | Nearly all of a Today row's own time (1 Oct) | Make it once (a `static`, or a cache per locale/places) | `check_rules.sh` |
| L8 | **A form reading the typed text while drawing** | Every letter rebuilt the whole New Habit form and its preview: 68.8 % of the main thread while typing (1 Oct); before that, previews redrawn per letter, 92 % and 100–400 ms freezes (30 Sep) | The text lives in a small `@Observable` read only by the field; the form reads only "is there a name" and "did it change"; previews catch up when typing pauses (0.3 s) | Speed run "Habit form: typing" |
| L9 | **A covered screen that keeps drawing** | Today redrew behind the full-screen player on every tap (29 Sep); its per-second clocks ticked under every page pushed from the menu (1 Oct) | Stop the covered screen's clocks and work (an environment flag; a schedule with no ticks) | Profile shows the covered screen's views while another is on top |
| L10 | **Swift Charts in a screen that scrolls** | Its first layout was most of a 1–2.7 s freeze the first time the habit page scrolled to a chart; trimming marks didn't help, and no single option was to blame (1 Oct) | Draw charts in one `Canvas` pass (`LightBarChart`, `LightLineChart`), with every bar for VoiceOver and a chart descriptor for Audio Graphs | `check_rules.sh` (no `import Charts`) |
| L11 | **Several `ForEach`es with plain numbers as ids in one lazy grid** (weekday letters 0–6, days 1–31) | The grid treats equal ids as one cell: days 1–6 of every month were never drawn (found 1 Oct) | One id type for every cell in the grid (an enum: `.weekday(i)`, `.place(i)`) | A screenshot at the start of a month; tests that tap the first days |
| L12 | **Keying cells by their content where places are fixed** (a calendar keyed by day number) | Every cell slid to its new column on a month change; a tap landed mid-slide (1 Oct) | Key by position when positions are fixed; only what a cell shows changes | Watch a month change in a recording |
| L13 | **Heavy rows** (a shadow on text, a `.clear` shadow, a sheet modifier per sheet, a `GeometryReader` per row) | Every Today row paid for an offscreen pass, four sheets and a geometry pass; the timer bar re-rendered its shadow every second (30 Sep) | Shadow on a background shape only; one `.sheet(item:)` per row; `scaleEffect` instead of `GeometryReader` for a fill | `check_rules.sh` (clear shadows) |
| L14 | **Making a tap wait for storage** | Quick taps landed on the old state while the database wrote (29–30 Sep) | Change the screen at once; the write follows; on failure reload and say so | Speed run "Today: +1" |
| L15 | **A redraw that touches the whole screen for something small** (each row's `onAppear` updating shared state) | Every row appearing rebuilt every section of Today (30 Sep) | State that changes while scrolling lives in its own small object read only by who needs it | Profile: one screen's body during scrolling |
| L16 | **An environment value or observed property read by every row, when only a few need it** | Pausing Today's clocks through a value every row read made every row redraw on each menu page opening (1 Oct, found reviewing the fix itself) | Read it in the smallest view that uses it (`RowClock`); a row without a clock never sees it | Review: who reads a value is who redraws when it changes |

## How to find a slow spot (what worked, and what misled)

- **A profile on a busy shared Mac can lie.** On GitHub's hosted Mac, `sample` lost up to 60 % of its samples and
  showed the main thread idle during a real 1.7-second freeze (1 Oct). One profile is a hint, never proof.
- **Bisect with speed scenarios instead.** Copy the slow scenario into variants that each leave one part of the screen
  out (`PerfBisect` on a scratch branch), and run them all in one speed run. The part whose absence removes the freeze
  is the cause. Two runs found the habit page's charts after profiles had failed (1 Oct). Never merge the scratch
  branch.
- **Look at when the freeze happens, not only how long.** A freeze 30–50 ms after scrolling starts is the first scroll
  building what was off screen; one right after a tap is that tap's work; one after opening is the screen's first
  layout. Each has a different cause.
- **Hosted-Mac numbers vary two to three times between runs.** Compare variants inside the same run, repeat a
  surprising number, and compare patterns (the same freeze in the same place) rather than single values.
- **First appearances are where freezes hide.** A screen that scrolls smoothly after the first time can still freeze
  the first time, and that's what people feel. Measure first opens and first scrolls on their own.
- **A screen with no scenario has no speed.** The quit habit's page and the weekly-total page were never measured
  until 1 Oct, and both froze. Every screen and interaction gets a `PerfDriver` scenario when it's built.
- **Test with a year of history.** Work that grows with history is fast with a new install's week of data and slow
  with a year of it.

## Open, not yet fixed (update as they're done)

- Opening a screen stalls 0.5–1.3 s (target under 0.1 s); slow before the merge too (1 Oct).
- Today's first scroll has one 180–440 ms freeze (1 Oct).
- Saving an entry and opening the entry editor stall about 1 s (1 Oct).

## Analytics validation lesson — 2 October 2026 (IST)

macOS ships Bash 3.2. With `set -u`, expanding a defined empty array (`ANALYTICS_ARGS[@]`) failed before `simctl launch`. The consent-off baseline in run 36907293697 waited 180 seconds per missing record: all three windows were unmeasured, wasting about ten Mac minutes. Consent-on launches used a nonempty array and succeeded. Use explicit argument lists for optional fixture modes, fail promptly on a missing launch PID, and preserve launch diagnostics. A failed/unlaunched baseline is not evidence of an app stall or telemetry overhead.

That run passed 86 native analytics checks and all 14 targeted UI tests. Consent-on windows were scroll 15.9ms/s (127ms longest), taps 14.4ms/s (63ms), typing 2.8ms/s (36ms), compared with 39.1/251.5/79.4ms/s on an earlier hosted run. Hosted noise and consolidated app changes prevent causal comparisons across those runs. Compare off/on in the same build; do not declare full speed acceptance while targets or first-open stalls remain unresolved. All telemetry mutation/persistence stays on its utility queue; type/configuration classification skips work without consent.

With the launcher corrected (run36911212496), five same-build off/on windows completed: scroll15.9→17.2ms/s, taps47.0→31.1, typing31.2→36.6, widget log0.6→1.0, widget guide2.6→8.5. Longest widget log stall22→24ms. Variation has both signs, and a single ordered pair does not prove causal overhead or full acceptance. Global targets are still missed; production telemetry remains gated. Exact source/evidence is in `Docs/Analytics Performance Evidence.json`.
