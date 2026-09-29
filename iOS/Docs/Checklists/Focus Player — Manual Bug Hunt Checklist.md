# Focus Player — Manual Bug Hunt

Written by Claude (Claude Code), 29 September 2026, from the user's request of the same day. It follows the Codex build ([Full-screen Routine Focus Player](<Full-screen Routine Focus Player.md>)) on branch `codex/routine-focus-player`.

**Context (the user's words, tidied):** automated tests only run the code; they don't catch experience bugs. Use the app like a normal person, by hand, and catch bugs, unexpected pop-ups and things that feel wrong in the full-screen routine (focus) player. Research first how the whole player should work, write it down, then fix the problems one after another.

## Every point the user made

| # | Point | Done |
|---|---|---|
| M1 | Test by hand, like a user, not with automated tests; the aim is experience and UX bugs, unexpected pop-ups, how it feels | [ ] |
| M2 | Pause / resume button sometimes turns black in the full-screen player | [x] Main thread was busy with Today behind the player; fixed 29 Sep (Speed and Responsiveness checklist) |
| M3 | Research thoroughly, from reviews, how the whole routine player experience should be (the other agent built it; check it works as expected) | [x] `Focus Player — How It Should Behave.md` |
| M4 | Add Time (logging time by hand) must work in full screen; its pop-up opens but not fully on screen (has to be scrolled up), and it may not be the right pop-up at all | [x] Checked by hand 29 Sep: Log Time opens full height, all of it on screen |
| M5 | Write down how everything in the full-screen player should behave, before fixing | [x] Same report |
| M6 | Fix the problems one after another (a loop is fine) | [ ] |
| M7 | Habit creation has been tested enough; this round is the player | [x] |
| M8 | First improve the whole player flow and every screen (research how), clean and better looking; then test | [ ] |
| M9 | Never "Add Time": say **"Log time manually"** (and the same for amounts); the timer is already running, this logs by hand | [x] "Log time manually" / "Log amount manually" in the code |
| M10 | Move between habits without having to "skip" one | [x] Swipe, ‹ and › move without skipping; three quick › taps checked 29 Sep |
| M11 | Up next is just faint text and doesn't show properly: make it a proper preview | [ ] |
| M12 | Controls and placement as users expect, each screen intuitive and matching their mental model | [ ] |
| M13 | Every type works in the player: time, amounts (with manual logging), check-offs, checklists, cut down (at most) | [ ] |
| M14 | Up next: just the icon and name; shorter card | [x] |
| M15 | Clear space between the main button and "Log … manually" (no mis-taps) | [x] |
| M16 | No "Not done yet" on done-or-not habits | [x] |
| M17 | Never the word "due" anywhere in the app; write it down | [x] Design Rules "Words the app never uses" |
| M18 | Skip a habit from the player | [x] Skip today, neutral everywhere (C016) |
| M19 | "Routine" button → "View routine" | [x] |
| M20 | Habit actions on the habit's page, not in the routine's ⋯ | [x] |
| M21 | No flicker or lag on Pause/Resume; nothing should feel like it hangs | [x] Instant state, only the clock ticks |
| M22 | "Goal reached" cut off on Drink water | [x] |

## Limits of this round

- The physical iPhone can't be driven from here (the device tool works only with simulators, and no screen-control tool is available). Hands-on testing is done on the iPhone simulator, one tap and one look at a time; fixes are installed on the iPhone for the user to confirm.
- The branch holds uncommitted work from two agents (the New Habit form and the focus player). Nothing is committed without the user.
