# Check-off Feedback — Haptics, Sound and Animation

Written by Claude (Claude Code), 29 September 2026. Build Plan #58 ("completion feedback") and Feature Ledger [C069](<../Feature Ledger.md#c069>) (check-off sound and haptic: Certain, 12 apps, "named as a reason to keep coming back"), with [C229](<../Feature Ledger.md#c229>) (a deliberate, physical completion), [C149](<../Feature Ledger.md#c149>) (respect Reduce Motion) and [C006](<../Feature Ledger.md#c006>) (every addition opt-in or off by default).

## Answer

1. **Haptics on by default, with a switch.** A light click every time + logs, a firmer "success" when a habit becomes done. People love the click; people with sensory overload leave apps whose vibration can't be turned off.
2. **Sound off by default, with a switch.** A short system sound when a habit is done: it follows the silent switch and never stops the person's music.
3. **No confetti, no full-screen celebration.** One small bounce of the ✓ when it's done, and nothing with Reduce Motion on.
4. **Feedback answers a tap, never a redraw.** Moving to another day shows other rows done; that must not buzz or chime.
5. **The done row stays put until the next log** (it offers "Add note" in place), so the fill and ✓ finish where the person is looking before it sinks. This covers #58's "finish the animation before the row moves".

## What the reviews say

Keyword scan of App Store and Play Store reviews of habit and routine trackers (`Research/Temp/stats/feedback_hits.json`); samples read by hand.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Loves the completion sound | 189 | 46 | 4.49 |
| Loves the haptic click | 48 | 25 | 4.31 |
| Vibration or haptics can't be turned off | 19 | 14 | 3.00 |
| Too much animation or confetti | 62 | 20 | 2.50 |

- **Sound:** "plus satisfying sound when ticking off a habit" (Habitify, 4★, `1467950022`); "the sound when you check something off is SO satisfying and motivating" (Habitify, 5★, `3905644213`).
- **Haptics:** "Cleanly laid out and gives haptic feedback which is very satisfying" (Productive, 5★, `4540757430`); "I love the haptic feedback and the micro animations" (Habit Tracker, 5★, `8180458210`); missed where absent: "I do miss having haptics feedback when ticking a habit" (Habit Tracker, 4★, `8811202814`).
- **But switchable:** "Impossible to turn off vibration … Very annoying, especially for a (supposedly) peace-of-mind application" (HelloHabit, 1★, `11686840765`); "No way to turn off haptics so the app is completely unusable and overstimulating for me" (Me+, 2★, `d05395bc-9ba9-4387-a9ee-730e9392f0af`); "It gives me sensory overload when I click on anything" (Me+, 3★, `05250aec-0027-4786-9c13-a542b320f02b`). Where the switch exists it's praised: "If you don't like the haptics you can turn them off" (Finch, 5★, `11788185999`).
- **Restraint with animation:** "too much confetti!!! It actually feels a bit patronizing … like good for you you drank water" (Finch, 4★, `13619815550`); "Every little process is slowed down by them" (Fabulous, 3★, `13608941209`); "Please add an option to disable transition animations" (Productive, 2★, `1521135023`). The 250 reviews praising animation are almost all about pets and characters (Finch), not about ticking off.
- The ledger adds: some find sounds interrupt their audio (report 31), and a 2022 completion animation was rejected by users (report 46).

## Reasoned from first principles

- **Frequent action, tiny feedback:** logging happens many times a day, so the feedback is short (a click, a bounce) and never blocks the next tap.
- **Honest to the tap:** feedback fires only within a moment of a tap on that button, so it can't be triggered by changing the day or a sync.
- **Defaults:** haptics are silent and private, so on; sound is public, so off until chosen.

## Limits

Keyword counts are floors. Which sound feels best hasn't been tested with people; the system "Tink" is a placeholder choice.
