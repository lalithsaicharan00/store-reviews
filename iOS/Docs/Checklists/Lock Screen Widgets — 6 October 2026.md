# Lock Screen Widgets

Written by Claude (Claude Code), 6 October 2026. Design follow-up under Current Work item 9.

The user's points:

- [x] Research how Lock Screen widgets work: sizes, interactive or display only, how little fits, and what to do when
  someone has more than four habits. Progress is what motivates people.
- [x] They should be interactive if possible, and look good.
- [x] Build the variations found (not every state); the user picks one.
- [x] The user picks: the today rectangle, one-habit circles and the inline line. Drop the one-habit week (no room for a
  button) and the button rectangle and up-next list.

Research (Apple HIG Widgets; App Intents docs; a review scan saved in `Research/Temp/widget-7day/lockscreen-scan.txt`):
- Sizes on a 390/393-pt iPhone: circular 72 × 72, rectangular 160 × 72, inline 234 × 26 (above the clock). The
  smallest phones get 68 × 68 circular and 153 × 68 rectangular.
- Vibrant mode is monochrome: no habit colours, grey levels only; meaning can't depend on colour. Minimum text size
  11 pt. Inline offers only one tap target; avoid several targets.
- Interactive: buttons work on the Lock Screen (iOS 17+) without unlocking when the intent allows it (App Intents
  `authenticationPolicy`).
- Reviews: 154 mention Lock Screen widgets (4.2★). Seeing progress at a glance comes up more (57) than ticking off
  (31). Quit counters are especially loved there. One 2★ review: tapping a Lock Screen habit completed it by accident.

## Final — 6 October (the user's rules)

- [x] One-habit circle: a check shows only its icon (a full ring when done); a daily goal (count, time, steps,
  checklist) shows its icon, the value, the goal in small text, and a ring; quit shows "15d", or hours in the first day;
  cut-down shows its value with no ring. Also paused, private and choose-a-habit.
- [x] Today rectangle: title, count, one segment per habit, and "N left · names" in the person's own order. Never
  "Next", because Anytime and quit habits have none. "All done"; many habits; private (counts only); no habits.
- [x] Today circle: a 3/5 ring, all done, no habits. Inline: "3 of 5 habits done", "All 5 habits done", a quit habit.
- [x] Taps: ✓ and a saved +1/+500 work without unlocking; timers, typed amounts, checklists and quit open the app; slips
  are never logged from the Lock Screen.

Figma: section "Lock Screen widgets — final" (`695:8747`), board `695:8748`. Component sets: `Lock / Circular · one
habit` `694:9071` (14), `Lock / Circular · today` `694:9092` (3), `Lock / Rectangular · today` `694:9150` (5),
`Lock / Inline` `694:9163` (3). The variation mock-ups were deleted.

## Round 2 — 6 October

- [x] Goal values on one line, never split: "3/8", "12/20m", "4.2k/8k". 15 pt for short values; 12 pt (above
  Apple's 11-pt minimum) for longer ones so they clear the ring. Natively, use `minimumScaleFactor` so any value fits
  on one line.
- [x] Remove the today circle ("3/5 done"): it read like one habit's count and repeated the rectangle and the inline
  line. Deleted its component set `694:9092` and its board group.
