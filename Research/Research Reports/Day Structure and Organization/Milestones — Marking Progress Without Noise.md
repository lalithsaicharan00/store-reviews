# Milestones — Marking Progress Without Noise

Written by Claude (Claude Code), 30 September 2026. How the iOS app marks milestones. Ledger card [C101](<../Feature Ledger.md#c101>) (milestones, achievements, celebration: 21 apps, Certain), read with [C157](<../Feature Ledger.md#c157>) (every guilt mechanic optional), [C095](<../Feature Ledger.md#c095>) (neutral tone), [C006](<../Feature Ledger.md#c006>) (stay minimal) and [C264](<../Feature Ledger.md#c264>) (never add a tap to logging). It builds on [Check-off Feedback — Haptics, Sound and Animation](<Check-off Feedback — Haptics, Sound and Animation.md>), which ruled out confetti and full-screen celebrations.

## Answer

1. **A milestone is a line, not an event.** When a tap reaches one, the Undo bar that the tap already shows says so in bold, with what was logged underneath: "30 days in a row" / "Read: done". No pop-up, screen, confetti, sound or notification, and the next tap is never in the way.
2. **Two kinds:**
   - **A streak reaching** 7, 30, 100, 365, 500 and 1,000, then every year (4, 12, 26 and 52 for weekly goals; 3, 6 and 12 for monthly ones).
   - **The whole day done:** "All 5 done today", when the last planned habit is done.
3. **A record that can't be lost.** Each habit's page has a Milestones section listing every milestone reached, from the best streak, and the next one with how many to go. Quit habits show their time since the last slip: 1 day, 3 days, 1 week, 2 weeks, 30 days, 90 days, 6 months, 1 year, then every year. It's all worked out from the history, so it can't be lost or disagree with the numbers.
4. **A switch.** Settings → Today → Milestones, on by default. Streak milestones follow Show Streaks; with streaks hidden, only "All done" shows.
5. **Undo takes it back.** The milestone belongs to the tap; undoing the tap removes both.

## What the reviews say

Fresh keyword scan of habit and routine trackers' App Store and Play Store reviews (1,238,784 reviews; `Research/Temp/stats/milestones/`), samples read by hand. Counts are keyword floors.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Liking milestones, badges or celebration | 643 | 63 | 4.64 |
| Asking for them | 245 | 50 | 4.42 |
| Celebration that's annoying, childish or can't be turned off | 40 | 19 | 2.95 |
| Round-number streaks (100th day and so on) | 48 | 13 | 4.31 |
| Quit and sobriety milestones | 39 | 19 | 4.54 |

- **People want round numbers marked.** Users show: "some kind of badge or reward … if he continues to main[tain] his streak for a certain period of time" (Loop, 4★, `8487e9e8-ef90-4cf5-8aa5-a60e10429ebd`); "specially if you like to celebrate happy 100th or 300th … milestone reminders for each counter, which you can enable or disable" (Days Since, 5★, `12729490999`); "I would recommend more trophies, milestones" (Habit-Bull, 5★, `1539540172`).
- **Finishing the day is its own moment.** Users show: "add a celebratory animation when all tasks for the day are completed" (Strides, 4★, `2969534848`); "seeing the gold badge when i've completed all my tasks for the day just makes me feel more accomplished" (Me+, 5★, `11966638221`).
- **Keep them.** Users show: "the badges you receive on certain days are not saved, I think it will be more motivating when you know that you are reaching milestones" (Habit Tracker, 4★, `d116ca92-55ee-4566-b91b-260f02dfb4d0`). Hence a record worked out from the history, not stored awards.
- **Celebration that blocks the next tap is hated.** Users show: "I have to sit and wait through multiple animations back-to-back … just to be able to hit the next checkmark" (Finch, 3★, `13689426510`); "stupid congratulation screen that you can't turn off makes everything take way longer" (Fabulous, 2★, `a988480a-a1fe-4e16-850b-37e7c3678847`); "I don't need a congratulations every time I tick off a task. There is no option to turn this feature off" (Fabulous, 3★, `9104109143`).
- **And so is being talked down to.** Users show: "it feels very child-like … It makes too big of a deal when you check something off. We should be able to turn this forced encouragement off" (Me+, 4★, `12010228356`).

## Reasoned from first principles

- **Words where the eye already is.** After a tap, the person looks at the row and the bar below it. Putting the milestone in that bar marks it without adding a thing to dismiss, and it goes by itself, like the Undo it sits beside. Loud celebration is what draws the complaints; the word "milestone" is what people ask for.
- **Only on a tap, only when reached.** A milestone shows once, when the tap that reached it is made, not on opening the app, not repeated, and never as a notification (a streak reminder by notification is a guilt mechanic, C157).
- **On by default, unlike sounds.** C006 says additions start off. This one adds no new element: the bar shows after every tap anyway, and the milestone only changes its words: a few times a year per habit, and on a day everything gets done. The switch is there for anyone who wants plain numbers (the counter-signal in C101).
- **Plain, adult words.** "30 days in a row", "All 5 done today". No "Amazing!", no mascot, no exclamation marks (C095, C178).
- **From the history, never stored.** Milestones reached are worked out from the best streak, so filling in a forgotten day, restoring a backup or editing an entry can't leave a badge that disagrees with the calendar.

## Not built yet

- A milestone reached by a timer running out (timers don't go through the Undo bar).
- Sharing a milestone as an image (Quit Habit Decision: milestone screenshots are the happiest reviews). Later, with the store-listing work.
- Money saved for quit habits.

## Limits

Keyword counts are floors and include some noise ("badge" also means the app icon's red number). The design hasn't been tried with people or on a device.
