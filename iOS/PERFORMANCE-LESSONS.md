# Performance lessons — never repeat these

Written by Claude (Claude Code), 1 October 2026, at the user's request: "Performance is the main thing. We need a
snappy, fast, the best possible experience. Note down everything found, so no agent working on this project, or on
any other app, ever repeats these mistakes."

**Every agent reads this before changing any app code**, in this project or another. The rules this project enforces
are in section S of [the Rulebook](../RULEBOOK.md) (loaded into every session; `Tools/perf/check_rules.sh` fails on
the ones code can show). This file is the evidence behind them, written so any SwiftUI app can use it: each lesson is a mistake
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
| L8 | **A form reading the typed text while drawing** | Every letter rebuilt the whole New Habit form and its preview: 68.8 % of the main thread while typing (1 Oct); before that, previews redrawn per letter, 92 % and 100–400 ms freezes (30 Sep) | The text lives in a small `@Observable` read only by the field; the form reads only "is there a name" and "did it change"; previews catch up when typing pauses (0.3 s). **The binding too is made in the field's own view** (`DraftTextField`): the entry editor made it in its body and cost 23.6 ms/s typing against a bare field's 0 (63 on the iPhone); in its own view 2.3–5.6, the log sheet 37.8 → 15.3 (2 Oct) | Speed runs "Habit form: typing", "Entry editor: typing" against "Control: typing in a bare number field"; the timed count "Entry editor: whole editor drawn" |
| L9 | **A covered screen that keeps drawing** | Today redrew behind the full-screen player on every tap (29 Sep); its per-second clocks ticked under every page pushed from the menu (1 Oct) | Stop the covered screen's clocks and work (an environment flag; a schedule with no ticks) | Profile shows the covered screen's views while another is on top |
| L10 | **Swift Charts in a screen that scrolls** | Its first layout was most of a 1–2.7 s freeze the first time the habit page scrolled to a chart; trimming marks didn't help, and no single option was to blame (1 Oct) | Draw charts in one `Canvas` pass (`LightBarChart`, `LightLineChart`), with every bar for VoiceOver and a chart descriptor for Audio Graphs | `check_rules.sh` (no `import Charts`) |
| L11 | **Several `ForEach`es with plain numbers as ids in one lazy grid** (weekday letters 0–6, days 1–31) | The grid treats equal ids as one cell: days 1–6 of every month were never drawn (found 1 Oct) | One id type for every cell in the grid (an enum: `.weekday(i)`, `.place(i)`) | A screenshot at the start of a month; tests that tap the first days |
| L12 | **Keying cells by their content where places are fixed** (a calendar keyed by day number) | Every cell slid to its new column on a month change; a tap landed mid-slide (1 Oct) | Key by position when positions are fixed; only what a cell shows changes | Watch a month change in a recording |
| L13 | **Heavy rows** (a shadow on text, a `.clear` shadow, a sheet modifier per sheet, a `GeometryReader` per row) | Every Today row paid for an offscreen pass, four sheets and a geometry pass; the timer bar re-rendered its shadow every second (30 Sep) | Shadow on a background shape only; one `.sheet(item:)` per row; `scaleEffect` instead of `GeometryReader` for a fill | `check_rules.sh` (clear shadows) |
| L14 | **Making a tap wait for storage** | Quick taps landed on the old state while the database wrote (29–30 Sep) | Change the screen at once; the write follows; on failure reload and say so | Speed run "Today: +1" |
| L15 | **A redraw that touches the whole screen for something small** (each row's `onAppear` updating shared state) | Every row appearing rebuilt every section of Today (30 Sep) | State that changes while scrolling lives in its own small object read only by who needs it | Profile: one screen's body during scrolling |
| L16 | **An environment value or observed property read by every row, when only a few need it** | Pausing Today's clocks through a value every row read made every row redraw on each menu page opening (1 Oct, found reviewing the fix itself) | Read it in the smallest view that uses it (`RowClock`); a row without a clock never sees it | Review: who reads a value is who redraws when it changes |
| L17 | **Writing to `UserDefaults` on every data change** (a "changed since the last backup" flag, set after each tap) | The Day sheet's add, edit and undo: 535 ms/s of hitches and 36 freezes, against 134 and 2 without it (same hour, same scenario, 1 Oct). Every Today row has an `@AppStorage`, and a defaults write makes them check again | Write only when the value changes (`if !flag { set }`), or keep it in memory and save it when leaving the app | Speed run "Day sheet: add, edit and exact undo"; review: no `UserDefaults.set` in `onChange` paths |
| L18 | **The first keyboard of a launch** | Opening the entry editor (the launch's first text field) stalls 3.3–6.7 s on the hosted simulator; the habit form's first open 1.4–2.8 s; later keyboards cost a fraction (1 Oct) | **Not a phone problem (2 Oct):** on the iPhone 16 the launch's first keyboard cost 136 ms, a later one 127 ms (`form-parts`), against 2.1 s on the hosted simulator. Don't pre-load the keyboard; judge keyboards on the phone | Speed runs "Habit form, the launch's first keyboard" on the iPhone (`measure_perf_device.sh`) |
| L19 | **A lazy grid inside a `List` or `Form` row** (the habit page's month calendar and number tiles; the form's colour and date pickers) | On the iPhone (iOS 26.6) opening any habit's page crashed the app: the list's collection view re-laid out its visible cells 100 deep and asserted (crash report, 2 Oct). GitHub's simulator never showed it | A plain `Grid` with `GridRow`s, sized up front; lazy grids only in a `ScrollView` | `check_rules.sh` (lazy grids only in listed files); test on the real iPhone |
| L20 | **Drawing many small shapes one call at a time in a `Canvas`** (a year of squares, each its own fill, plus a resolved symbol per sign) | The scrolling Year heat map: 39.2 ms/s while scrolling, 134 ms longest (run 37035760133, 2 Oct). The same 24-pt scrolling year drawn as one path per look (six fills, one stroke per kind of sign) and rendered off the main thread: 11.2 ms/s, 44 ms longest, no freezes (run 37096111790, 3 Oct; different runs, so hosted noise applies) | Batch: one `Path` per colour or stroke style, filled or stroked once (`HeatDraw`); signs as paths, not text or images; `Canvas(rendersAsynchronously: true)` for a wide canvas in a scroll view | Speed run "Progress Year: scrolling" |
| L21 | **`ViewThatFits` in a Today row** (the after-log Undo / Add Note line, 3 Oct 2026) | Changing days on Today cost 72 ms/s against 14 before the row work, in the same window (tap-today, 4 Oct). A bisect of three variants run side by side: without the after-log line 16 ms/s; with a plain row line 35; with done rows kept in place 36. `ViewThatFits` laid out all three of its layouts each time the line appeared | One layout; icons only at the accessibility text sizes, chosen from `dynamicTypeSize`; a milestone shortens with "…" | Rulebook S10; bisect variants side by side in one window when a run looks slower |
| L22 | **Choosing a pager from separate hosted runs** (the routine player, 5–6 Oct 2026, Current Work 50) | The page `TabView` measured 5.7, 32.6 and 31.4 ms/s of hitches on fast ‹ › in three runs; a paging `ScrollView` 15.7 in one and 12.9 in another, where the `TabView` beside it measured 32.6 (runs `37363988700`, `37363991450`, `37379485559`, `37384134763`). Separate runs vary more than the difference being judged | Compare variants in one run with `PerfSwitches` and one scenario each; decide on behaviour first (recordings, the fast-navigation check), speed second | Speed run "Routine player: fast ‹ ›"; Rulebook S2, U24 |
| L23 | **Week-long widget timelines** (every iPhone widget, until 7 Oct 2026, Current Work 65) | On the iPhone 16 (iOS 26.6, Debug -O), the opt-in `-widget-timing` log showed the app side of a widget tap was already quick (cold launch → intent 0.11 s, saved 0.5 s, returned 0.8 s; warm 0.3–0.4 s), but WidgetKit drew every timeline entry on each reload before showing anything: 8–22 entries per widget (a week of day starts, hourly quit counts, a running timer's every minute), ~35 ms per Medium entry, so ~0.75 s per Medium reload, twice per tap (the system's reload and the app's). A burst of five taps queued seconds of drawing. Same-run page flips on the Home Screen (`WidgetLatencyDeviceTests`, 3 each way, twice): week-long 0.9 / 1.4–1.5 s, short 0.7–0.8 s (including XCUITest's own tap overhead). After: 2–4 entries per timeline; a tap with the app closed drew the Small widget at +0.52 s and the Medium at +0.76 s from launch, with the app in the background +0.11 s and +0.20 s | A timeline holds the next 3 hours and the next day's start, entries ≥ 5 min apart; a widget tap reloads at once; no `invalidatableContent` on buttons (every marked view dimmed on any tap) | Rulebook S17; `WidgetLatencyDeviceTests`; `WidgetCheck` |
| L24 | **A widget button whose intent runs in the app's process** (`LiveActivityIntent`, so the tap is saved in the database, synced and backed up) (8 Oct 2026, Current Work 66) | Screenshots on the iPhone 16: tap → the widget's number changed at 3.97–4.45 s (XCUITest's tap ~0.54 s of it), app closed or not, though the app had saved and redrawn by +0.5–0.8 s. Same-run page flips: 0.7–0.8 s run in the widget's process, 3.9–4.1 s run in the app's. A `Toggle` drawn as the round button changed on screen at 0.67–0.69 s (≈0.15 s after XCUITest's tap); the numbers followed at ~4 s. A ✓ switch tapped twice fast ended ticked: iOS sent the first tap's value again, so the app now flips what's saved | Instant feedback from the switch, the save behind it in the app; ✓ flips in order, + gets a new ID per tap | Rulebook S18, U26; `WidgetLatencyDeviceTests` |
| L25 | **Calling a regression from runs on different machines** (Current Work 49, 5–8 Oct 2026) | On 5 Oct, separate hosted runs showed `main` far slower than 4 Oct: Today scrolling 0 → 28 ms/s, +1 3 → 25, habit-form typing 9 → 45, Progress paging 125 → 164; three more runs each "pinned" it to the timer/swipe/limits merge. Built side by side in one job (`ios-perf-bisect.yml`), the 4 Oct build and `main` measured: scrolling 12.6 / 11.3, typing 14.2 / 15.8, Progress 107.5 / 93.1 (run `37774018835`); +1 and day ‹ › 159 / 182 and day ‹ › alone 141 / 129 over four rounds each (run `37804587883`). Nothing had got slower. A two-round run on one machine even showed `main` at 2× in that window (`37788595991`), and the same binary twice measured typing 57.5 against 22.6 (`37797217908`) | Before calling something slower, build the before and after in **one job** and measure them in turns, **four rounds or more**, rotating the order (`[ios-perf-bisect]`, `Tools/perf/bisect_perf.sh`); judge a difference only when every round agrees | Rulebook S2 |

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
- **Measure a control in the same run.** "Every screen stalls 150–400 ms on opening" (1–2 Oct) was mostly the push
  itself: a blank page pushed the same way stalled 118–197 ms, and each menu page opened a second time stalled
  107–236 ms, the same within noise; only a few first openings (Help's search bar, Appearance, Day and Week) added
  ~150 ms once per launch (2 Oct). Without the control, those numbers would have sent us optimising pages that cost
  nothing.
- **The phone has the final word** (`Tools/perf/measure_perf_device.sh`, 2 Oct). The hosted simulator inflates some
  costs 15× (the first keyboard) and every push 2–3× (a blank page 120–200 ms there, 45–85 ms on the iPhone 16). Use
  GitHub's runs to compare before and after; check what people feel on the phone.
- **Time and count before changing anything** (`perfTimed`, 2 Oct). The Day sheet's ~50 ms/s of add, edit and undo
  was blamed on the store until the timed table showed the widgets' month projection: 60 runs, 362 ms, up to 118 ms,
  one per change, 180 ms after it (fix: widgets publish 2 s after the last change; going to the background still
  publishes at once): 17 runs, 93 ms. Redraw counts ("Count: …" in the timed table) then showed each screen redraws
  only what changed (one row per +1; the whole list only on a day switch), so what's left is the list machinery's own
  per-change cost, about 6 ms a change on the iPhone.
- **Test with a year of history.** Work that grows with history is fast with a new install's week of data and slow
  with a year of it.

## Open, not yet fixed (update as they're done)

**Above the targets on every build, not a regression (8 Oct 2026, Current Work 49; side by side, simulator):** Today's
day ‹ › 55–160 ms/s depending on the machine (one 40–60 ms stall per switch), habit-form typing at a letter every
50–80 ms 14–20 ms/s, Progress's period and range switch 90–130 ms/s, Today's first scroll one 130–640 ms freeze (later
scrolls ~5 ms/s). The 4 Oct build measures the same in the same job. On the iPhone (2 Oct) the day switch with +1 was
40 ms/s and Progress's switch 110: measure them on the phone (`measure_perf_device.sh`) before optimising.

**On the iPhone 16 (2 Oct, `5457ec2`, a year of history, `measure_perf_device.sh`): no freeze of 100 ms anywhere.**
Scrolling: Today 4.8 ms/s (47 ms longest), Progress 0.7, All Habits 1.1, the habit page 5.7. Openings 46–170 ms
against a blank page's 45–85 ms. Still above the 5 ms/s target, repeating the action quickly: Progress's period and
range switch 110 ms/s (95 ms longest, ~45 ms a switch), the entry editor's typing 63 ms/s, the Day sheet's add, edit
and undo 53 ms/s, Today's +1 and day switch 40 ms/s. The items below are the simulator's figures from before.

- Opening a screen stalls 0.5–1.3 s (target under 0.1 s); slow before the merge too (1 Oct). **2 Oct:** menu pages
  now open within noise of a blank page's push (above); the first openings of Help, Appearance and Day and Week add
  ~150 ms once per launch. Still to measure against the control: Progress, All Habits, the habit page, the habit form
  and the Day sheet.
- Today's first scroll has one 180–440 ms freeze (1 Oct).
- **Day details, logs and notes redesign (7 Oct, simulator, `aa6ee1e`, run `37624454758`, against `a3d33bf`):** typing in
  Edit log 0.0 / 0.3 ms/s (the old entry editor 4.5 / 8.6), in Add log 1.7 (the Log sheet 10.7, a 126 ms freeze);
  Day details' add, edit and undo 90.8 / 126.2 ms/s (148.7 / 185.5); scrolling Day details 0 (16.9), All logs 0.0;
  opening the log editor 118 / 185 ms (930 / 486), a note 1169 ms (3347). **Open:** opening Add log 1027 ms (the Log
  sheet's 429) and Edit log's first keyboard 864 ms (303 ms the second time), the launch's first keyboard on the hosted
  simulator (L18): measure on the iPhone before changing anything. Day details' add, edit and undo is still above the
  target on the simulator, as it was on the phone (53 ms/s, 2 Oct).
- Saving an entry stalls 0.6–0.8 s; opening the entry editor, the launch's first keyboard, 3–7 s on the hosted simulator (L18, 1 Oct).
- **Arrange Your Day (3 Oct, simulator, `365242d`, `arrange` scenario):** scrolling it 0.0 ms/s; moving Anytime and
  sorting a card 2.0 ms/s (29 ms longest); opening it 138 ms the first time and 121 ms after (it replaces Today in
  place; the hosted simulator's blank push is 120–200 ms); working out every card's habits 0.1 ms at most. Today's
  scrolling 2.6 and +1 0.0 in the same run. **Open:** turning Hide Completed on and off every 0.5 s costs 26.4 ms/s
  (48 ms longest, no freeze), about 13 ms a switch, because every card gets the new setting and redraws; people
  switch it once, so it waits for the iPhone's number before any change.

## Analytics validation lesson — 2 October 2026 (IST)

macOS ships Bash 3.2. With `set -u`, expanding a defined empty array (`ANALYTICS_ARGS[@]`) failed before `simctl launch`. The consent-off baseline in run 36907293697 waited 180 seconds per missing record: all three windows were unmeasured, wasting about ten Mac minutes. Consent-on launches used a nonempty array and succeeded. Use explicit argument lists for optional fixture modes, fail promptly on a missing launch PID, and preserve launch diagnostics. A failed/unlaunched baseline is not evidence of an app stall or telemetry overhead.

That run passed 86 native analytics checks and all 14 targeted UI tests. Consent-on windows were scroll 15.9ms/s (127ms longest), taps 14.4ms/s (63ms), typing 2.8ms/s (36ms), compared with 39.1/251.5/79.4ms/s on an earlier hosted run. Hosted noise and consolidated app changes prevent causal comparisons across those runs. Compare off/on in the same build; do not declare full speed acceptance while targets or first-open stalls remain unresolved. All telemetry mutation/persistence stays on its utility queue; type/configuration classification skips work without consent.

With the launcher corrected (run36911212496), five same-build off/on windows completed: scroll15.9→17.2ms/s, taps47.0→31.1, typing31.2→36.6, widget log0.6→1.0, widget guide2.6→8.5. Longest widget log stall22→24ms. Variation has both signs, and a single ordered pair does not prove causal overhead or full acceptance. Global targets are still missed; production telemetry remains gated. Exact source/evidence is in `Docs/Analytics Performance Evidence.json`.


Analytics repeat (1 Oct UTC / 2 Oct IST): run36911869018, same Debug build off→on, scroll28.2→16.7ms/s (166→101ms), taps89.3→136.6 (114→246ms), typing17.1→30.3 (83→104ms), widget-log15.9→15.6 (37→44ms), guide0→0. Form first-open1195/1244ms and guide476/568ms both miss targets. These differ greatly from run36911212496 despite unchanged view/store code. Keep both reports, mixed direction and ordering visible; neither is causal overhead or device acceptance. Production gate stays closed. Final utility-only checks reuse these measured views rather than paying for an unchanged full performance repeat.
