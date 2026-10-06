# Weekly Medium Widget — One Habit

Written by Claude (Claude Code), 6 October 2026. Design follow-up under Current Work item 9; app implementation
remains separate.

**Superseded the same day:** a Large widget listing habits with seven-day squares (five, then four, then three a page).
The user dropped it ("we are not going to build it") and asked for its Figma section, components and repo files to be
deleted. They were deleted.

The user's points, in their order:

- [ ] Build a **Medium** widget with **weekly** progress for **one habit**, in Figma.
- [ ] Follow the inspiration closely (a dark Medium widget: a left tile with a large icon, a streak count and its
  label; on the right, today's value "5863 / 8000", a progress bar, and seven day marks with day names in their own
  container). **Leave out its glow.**
- [ ] Use our habit icon where the inspiration has its streak icon.
- [ ] Keep a progress bar for today.
- [ ] Show the week the way our app does: adapt the inspiration's circles to our day squares.
- [ ] Fit the habit's name and icon, its streak, and the main action (CTA), each placed properly.
- [ ] Put things in containers, as the inspiration does: the week sits on a card, and so do the icon, streak and text.
- [ ] Keep it clean, minimal and useful; the point of the widget is logging without opening the app.
- [ ] Keep working files in `Research/Temp/` (ignored by git).

## Round 2 — the user's corrections, 6 October

- [x] Build **one** widget only, not variants; delete the other eight states and the review board.
- [x] Only **two cards**, like the reference: the habit card and the week card. Today's value and bar sit on the widget.
- [x] Smaller day cells with more space between them inside the week card.
- [x] Streaks aren't the focus: one line, shown the app's way (🔥 and the number, as `StreakLabel` draws it). Make the
  icon bigger and centre everything in the habit card.

Result: one light-mode Water widget, Figma node `665:5129` in the "Weekly Medium — one habit" section. It uses 20-pt
squares, which is below the Rulebook's 24-pt minimum and needs the user's say-so. The ✓ is scaled to 10 pt. In light
mode the widget is white with #F2F2F7 cards, and the empty squares are #DEDEE3 so they show on the grey card. Awaiting
review.

## Round 3 — every variation, 6 October

The user approved the round 2 widget and asked for variations matching the Small daily cards (537-2981), taking
special care that quit cards are rich, and including empty, unavailable and privacy states.

- [x] Every habit type and action from the Small list: single check, repeated, named slots, quantity, above goal,
  custom amount, walking steps, timers, checklists.
- [x] Quit: the live time since the last slip, a bar toward the best run labelled "Best 45d", and clean days (colour ✓)
  and slips (grey ✕) in the week. Also: slip recorded, a new best run, and paused.
- [x] Limits: daily, timed, weekly and monthly, each below, reached and over. Neutral bars and buttons, and a label for
  the state; days are judged only when their period ends.
- [x] Period goals: weekly total, monthly total, flexible daily target.
- [x] Skipped, paused, private habit, not planned today, long name.
- [x] Recovery: choose a habit, no habits yet, selection unavailable (also covers Small's "removed or stale"), content
  hidden, open to update, couldn't save. The week card carries the instruction.
- [x] Eight dark samples.

Figma: the "Weekly Medium — one habit" section; the 42-variant component set "Weekly Medium / One habit" is
`673:5287`, and the board is `673:5288`. Still open: the user's OK for 20-pt squares (the Rulebook minimum is 24 pt).

## Round 4 — polish, 6 October

- [x] Keep the week card, but use the Small card's 44-pt visible button and trim the week card's side padding to 8 pt.
- [x] Proper auto layout: remove every spacer block. The Today group (value row and bar, 6-pt spacing) fills the space
  above the week card (10-pt spacing), centred.
- [x] Quit: "Best 45 days" goes under the habit name, or "Quitting" when there is no best yet. Remove "since the last
  slip" (it keeps reminding people of the slip) and the bar label. A new best shows "New best". Add a first-run card.
- [x] Limits: move "Daily limit", "Limit reached", "Over the limit" and the weekly or monthly limit from beside the bar to
  the line under the habit name.

43 variants in `673:5287`; the board `673:5288` is updated.

## Round 5 — the date a quit run counts from, 6 October

- [x] Research: is "restarted on <date>" helpful after a slip? A keyword scan of the Days Since reviews (10,621; a
  direction, not a full coding) found 31 mentions of a clean, quit or start date (4.5★), 18 about how a reset feels, and
  40 that value reset history (4.8★, which belongs in Habit details). Report 36 (24 Sep) already chose "Since [date]".
  The scan output is in `Research/Temp/widget-7day/quit-date-scan.txt`.
- [x] Add a neutral "Since 20 Sep" under the live time on the four live quit cards, with the same wording for a first
  quit date and after a slip. A slip today shows the time, "Since 14:21". The paused card has no live time, so it gets
  no date.

## Round 6 — are 20-pt squares legible? 6 October

- [x] The user's test: squares can't be tapped, so 20 pt is fine if they are reliably legible. Measured: every sign is at
  least 3:1 against its square, in light and dark. Two outlines were below 3:1 on the grey card (dash and today 2.92:1),
  so they now use #86868B in light mode (3.25:1, Figma variables `mark/not-scheduled-dash` and `mark/today-outline`).
  Recorded as a widget exception in Design Rules (Progress Week). Still to check on the iPhone: ⏩ against ⏸ at 9 pt,
  and tinted/clear Home Screens.

## Widget decisions — 6 October

- **Monthly widgets: parked.** A quick keyword scan of 1,238,784 reviews, every match read by hand: about 34 are
  about month or calendar widgets (about 15 requests, 11 praise, 8 complaints about paywalls, breakage or
  tinted-mode legibility), against 695 about ticking from a widget (September widget report). Our day squares need
  20 pt or more, so a Medium month doesn't work (17 pt, or 14 pt in a 6-week month, and no button). If users ask after
  launch, build the Large single-habit month (Figma `680:7515`: 28-pt squares, 22 pt in a 6-week month, keeps today
  and the button). Don't switch widgets to dots: it would break the squares used everywhere else.
- **Icon-only widgets: not building.** The same scan found about 4 reviews wanting compact or icon-only widgets,
  about 7 hurt by icon-only ("no clue to remembering the habit", "good luck with multiple widgets", icons too small to
  know what to press), and about 25 wanting more habits in one widget. The named Large (5) and Medium (2) Today lists
  answer that. If density is asked for later, use a compact list that keeps the names, never bare icons.
  The scan output is in `Research/Temp/widget-7day/icon-widget-scan.txt` and `month-widget-scan-all.txt`.

## Settled and documented — 6 October

- [x] 20-pt squares: the user decided legibility is the only test; measured and recorded as a widget exception in
  Design Rules (Progress Week).
- [x] Documented for building in [Implementation Spec — Every Widget §6](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Implementation Spec — Every Widget.md#6-medium--one-habit-this-week>), with images in the Widgets folder.
