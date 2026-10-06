# Small Widget — Weekly and Monthly Progress Fill

Written by Claude (Claude Code), 6 October 2026. Design follow-up under Current Work item 9.

The user's points (Figma 545-3811 and 545-3831, the Small weekly and monthly total-goal cards):

- [x] There was no view of the progress filling: the capsule only said "12 min today" or "2 checks today".
- [x] The progress should count toward the weekly or monthly goal.

Done in Figma (component set `Daily widget / Today` `540:3003`):

- [x] Weekly total goal (`540:2994`): value "1h 12m of 3 h"; the capsule fills to 40% in the habit colour (0.3, so the
  label stays readable), labelled "This week".
- [x] Monthly total goal (`540:2995`): value "4 of 10 times"; the capsule fills, labelled "This month".
- [x] New variants: start of week (`702:11301`) and start of month (`702:11313`), both empty; goal met (`702:11307`,
  `702:11319`), with a full capsule and the action in the habit colour.
- [x] Board: a new group "Weekly and monthly goals · progress fill" in the Small section; stale notes updated.
- [x] The Accepted Widget Contract row for week/month totals is updated: the user superseded "no fill" on 6 Oct.

Still open: the Large and Medium Today lists still show period-only goals without a row fill (their handoffs say
so). Ask the user whether those rows should fill toward the week or month too.

## Round 2 — 6 October

- [x] The light tint with "This week"/"This month" looked odd beside every other card's solid fill. Now the bar uses
  the solid habit colour, with no label: people know a weekly habit is weekly, and the number says what is counted.
- [x] Limit cards (Figma 545-3745): the grey fill (#D5D5DA) was barely visible on the track (about 1.2:1). There is
  now a new variable `widget/limit-fill`: #86868B in light (3.25:1 on the track; label text 4.7:1) and #636366 in dark
  (label text 5.3:1). It is bound to the daily-limit cards (below, reached, over) and the timed-limit states. Checked
  in light and dark.

## Round 3 — 6 October

- [x] Light-mode limit cards still looked wrong: the label sat half on the grey fill and half on the track. Now the
  limit bar is a plain bar like every other card (neutral grey, no text inside), and the value line says it is a
  limit, as the app does: "1 of 2 cups max", "2 of 2 cups max", "3 of 2 cups max", "10 of 20 min max", and for the
  running timer "12:36 of 20 max" (the clock already says minutes; the full wording was 144 pt in a 126-pt line).
  Applied to the three daily-limit cards and the four timed-limit states.
