# iOS Native — Design Loop Notes

Written by Claude (Claude Code), 6 November 2026 (IST). The iPhone design loop's dated sections for the
`iOS/Docs/… — iOS Native.md` docs. Those docs (Colours, Text Styles, System Bars, Buttons, Navigation, Inputs, Lists
and Rows, Icons, Menus and Sheets, Progress and Milestones, Onboarding) weren't in git when the loop started, so each
section below is headed with the doc it belongs to; move it there once the docs are pushed. Progress:
[iOS Design Loop — Progress](<Checklists/iOS Design Loop — Progress.md>).

## Buttons — iOS Native · 6 Nov 2026: the Clock button (screen A, the timer)

- **Where a clock runs, the buttons are Clock's**: a round button, an 80 disc inside a 2 pt ring, 90 across, one word
  in Body Regular (Figma: Clock button 4228:2548). Neutral (Secondary System Fill, Label) for the secondary action
  (Log Time); Prominent (Ink, white) for Start, Pause and Resume; Done (the habit's colour, white) for Pause once the
  goal is met (A91). Never a capsule pair under a running clock.
- **Its word doesn't grow with Dynamic Type past Body** (as Clock's): at Accessibility 1, "Log Time" overflowed the
  circle on the Simulator. VoiceOver reads the word.
- Two at most, at the screen's two sides, 28 from the edges and 12 above the Home Indicator's area.

## Progress and Milestones — iOS Native · 6 Nov 2026: the Timer ring (screen A)

- **A running habit's clock sits inside a ring** (Figma: Timer ring 4228:2551): 260 across, 10 thick, round ends,
  the habit's colour on its Fill, clockwise from the top; inside, the habit's filled icon (28, the habit's colour),
  the clock in SF Pro Light 64 with tabular figures, and the goal (Body, Secondary Label). Full at the goal; the clock
  keeps counting.
- **iOS has no wave**: a running clock shows it's running by counting; paused says "Paused" under the ring.
- **A limit's ring is System Gray on Gray Fill** (A41), never the habit's colour, never red; its icon keeps the
  habit's colour. Past the limit the line under it says "Over the limit".

## Navigation — iOS Native · 6 Nov 2026: a word action alone in the bar

- The Navigation bar's shared symbol capsule now shows only with Action 1 (Action 2 needs Action 1), so a bar whose
  only trailing item is a word (Day Details) puts the word at the trailing edge, 16 in, with no empty slot. Checked:
  no copy used Action 2 without Action 1.

## Menus and Sheets — iOS Native · 6 Nov 2026: the timer is a Large sheet

- The timer on its own opens as a **Large sheet** (from y 54, System Background, radius 38 at the top) over Today or
  over Day details: ✕ at the left (16 from the top and side), the habit's name with the day as the subtitle, and
  **Day Details** as a word at the right, which opens that day's Day details over the timer. ✕ or a swipe down puts
  it away; the clock keeps running (Today's row and the Live Activity keep it).
