# Focus Player — Speed and Responsiveness

Written by Claude (Claude Code), 29 September 2026, from the user's hands-on review on the iPhone 16 the same day.

**Context (the user's words, tidied):** in Anytime, the habit Read is started in the routine player and its timer runs. Tapping Pause gives a strange fade on the text, like an opacity animation. Everything in the player feels slow: the chevrons take a moment to go to the next habit, and the "Anytime ⌄" button at the top opens slowly. With native components everywhere it should feel instant.

## Every point the user made

| # | Point | Done |
|---|---|---|
| S1 | Pause on a running timer (Read, in Anytime) shows a strange fade on the text; remove it (and the icon, if the icon causes it) | [x] Not the icon: the clock swapped views on Pause, and "Paused" pushed the icon up. One view now, the line keeps its space |
| S2 | Find out why the player feels slow instead of guessing; check that native components are really used | [x] Measured (below). Native components throughout; the lag was Today redrawing behind the player every second |
| S3 | ‹ and › respond at once and move to the previous or next habit without lag | [x] Simulator: three quick › taps all landed |
| S4 | The "Anytime ⌄" button at the top opens the routine without lag | [x] Same cause, same fix |
| S5 | Everything else in the player responds at once too | [x] Main thread ~2% busy with a timer running |
| S6 | No automated tests: check by hand, fix, then check again | [x] By hand on the iPhone 17 simulator, before and after |
| S7 | Install on the iPhone for the user to try | [x] Installed 29 Sep; waiting for the user's check |

## What was wrong (measured, 29 Sep)

The app was sampled by hand on the iPhone 17 simulator (`sample`, 1 ms, while tapping Start, Pause, Resume, ›, ‹ and "Anytime ⌄"; files in `Research/Temp/perf/`).

- **Before:** the main thread was busy **~22%** of the time (2,300 of 10,600 samples). Almost all of the app's own work was **Today, hidden behind the player**: `HabitRow.row`, `streak`, `dayProgress` and `isDayMet` for every row. Today sat inside one `TimelineView` that ticked **every second while any timer ran**, so the whole list, its streaks and the toolbar were recalculated every second, and again on every tap in the player. A tap that arrived during that work waited, and the button stayed half-faded (its pressed look) until it was handled: the "opacity" the user saw.
- **The fade on Pause:** the player's clock was a `TimelineView` while running and a plain view while paused. Pause swapped one for the other, so SwiftUI rebuilt the circle's contents, and the new "Paused" line pushed the icon and clock up.
- **After:** **~2%** busy (370 of 18,800 samples). Today no longer appears in the samples.

## What changed

1. `TodayView`: while the player covers Today (`playerCovering`, set when the player appears), Today draws a plain background and no toolbar. It comes back as the player starts to close, at the section the routine was started from.
2. `TodayView`: the list redraws on `TodaySchedule`: every minute, and at the moment each running timer reaches its goal (so "N left" and the day bar change on time). Running rows and the timer bar still tick every second on their own.
3. `QuitRow`: its once-a-second clock has a fixed anchor instead of `.now`, which gave it a new schedule on every redraw.
4. `FocusClock`: one `TimelineView` whether running or paused (paused = a schedule that never ticks); the "Paused" / "Not started" line is always there and hidden while running, so nothing moves.

Screenshots can't time a tap here: the simulator tool's screenshot lags the tap (even a plain system sheet isn't visible yet), so the timing evidence is the samples, not the screenshots.
