# Widgets — implementation spec for every widget

Written by Claude (Claude Code), 6 October 2026, at the user's request: everything an agent needs to build and test
the widgets, in one place. Current Work item 9. **This is the document to build from.** It brings together the
accepted designs (Small, Large and Medium Today lists by Codex, 5–6 Oct) and the designs made on 6 Oct (weekly
Medium, Tasks, Lock Screen, and the Small revisions). For each family, the detail lives in its own handoff and in
Figma; this spec gives the rules, sizes and decisions.

**Read first:** the [Rulebook](<../../../../../RULEBOOK.md>), especially S5/S16 (speed), D7/D8/D10 (data), U1–U4, U9,
U13/U14 (design) and T1–T10 (testing), then [Accepted Widget Contract](<Accepted Widget Contract.md>) (per-type
actions, routes, recovery) and [History and Current Implementation](<History and Current Implementation.md>) plus
[Native Integration and Release](<Native Integration and Release.md>) (code map and gaps).

## 1. What to build now

| # | Family | Sizes | Shows | Figma |
|---|---|---|---|---|
| 1 | **Small · one habit, today** | Small | One habit's today progress and its action | [Small section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=537-2981) |
| 2 | **Large · Today list** | Large | Today or one chosen section; 5 a page | [Large section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=585-4698) |
| 3 | **Medium · Today list** | Medium | Today or one chosen section; 2 a page | [Medium section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=622-6436) |
| 4 | **Medium · one habit, this week** | Medium | Today's progress, the action, the week's squares | [Weekly Medium board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=673-5288) |
| 5 | **Tasks · Large and Medium** | Large, Medium | Today's tasks; 5 or 2 a page | [Tasks board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=688-7901) |
| 6 | **Lock Screen** | Circular, rectangular, inline | One habit; today's summary | [Lock Screen board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=695-8748) |

**No Plus restrictions for now** (the user, 6 Oct 2026: "As of now, without putting any plus or any restrictions, we
just need to implement everything"). Build every widget free; the free/Plus split is a later product decision. When
it comes, the research says Today lists and Tasks stay free (tasks are unlimited on the free plan); the weekly Medium
is the Plus candidate; logging is never behind a paywall (D10; [Free Plan Design §6](<../../../Business Model and Monetization/Free Plan Design — Habit Cap, Widgets and an Honest Listing.md>)).

**Not building:** monthly widgets (parked), icon-only widgets, a Large multi-habit weekly widget, a Lock Screen
"today" circle, a one-habit week on the Lock Screen. Reasons are in §9.

**Next after the widgets:** App Lock together with widget privacy (Current Work item 58; §8 here).

## 2. Shared rules (every family)

**Native.** SwiftUI, SF Pro, SF Symbols; light and dark; Dynamic Type; VoiceOver (U1). Figma uses fixed sizes for a
390/393-pt iPhone (Small 158 × 158, Medium 338 × 158, Large 338 × 354); real sizes vary by phone, so lay out with
the family's size, not these numbers. Use semantic text styles scaled from the sizes below, not fixed points.

**Spacing idea** (the numbers are in Figma; keep the idea): equal outer insets, 16 pt on Small and Large, 12 pt on
Medium. Things that belong together sit closer than things that don't: a habit's name sits close to its value, and
groups are separated by larger gaps. Cards inside a widget use a radius of the widget radius minus the inset
(28 − 12 = 16). Never fake spacing with empty blocks; use stack spacing and padding (the user, 6 Oct).

**Touch targets.** Every action is a **44 × 44 pt** target. Visible round button: **44 pt** on the Small card and the
weekly Medium; **32 pt** inside the 44-pt target on the Today and Tasks list rows. Pager arrows are 44 × 44 targets.
Only one action per row or card; the row or card body opens the item (U14).

**Button colours** (source: `RoundActionButton`, `Components.swift`). Before completion: `tertiarySystemFill` with
ink content. Positive completion (goal met, task done): the habit's colour with white content. Running timers, quit
and limits: always neutral. A saved increment keeps its label ("+500" stays "+500").

**Type** (light reference sizes; scale with Dynamic Type):

| Role | Size and weight |
|---|---|
| Large list title ("Today", "Tasks") | 22 Semibold |
| Medium list title (compact header) | 17 Semibold |
| Count ("1 of 5 done") | 13 Semibold, secondary |
| Row / card name | 17 Semibold (weekly habit card 15 Semibold) |
| Row line under the name | 13 Regular, secondary |
| Small card value ("3 of 8 glasses") | 15 Regular |
| Small supporting text (caption, state) | 12 Medium |
| Weekly Medium value ("3") / goal ("/ 8 glasses") | 26 Semibold / 15 Regular, secondary (long values 22 / 14) |
| Weekly day names | 10 Medium (today 10 Semibold, primary) |
| Streak ("🔥 12") | 15 Semibold, the 🔥 at 12 (as `StreakLabel`) |
| Lock Screen text | never under 11 pt (Apple HIG) |

**Icons.** The habit's SF Symbol in its colour (`HabitColor.mark`). Small card identity 24 pt; list row 24 pt; weekly
habit card 44 pt; button glyphs 17 pt (32-pt button) or 20 pt (44-pt button); "+1" 15–17 Semibold.

**Progress bars and fills.**
- Small card: an 18-pt capsule (radius 9) on the grey track; fill = the habit's colour, solid, no text inside.
- Today list rows: the row's background fills left to right in the habit's colour at **0.15 opacity (light) / 0.26
  (dark)**; a done row is fully tinted.
- Weekly Medium: an 8-pt bar (radius 4) under today's value.
- Limits (cut down): the same bar shapes in neutral grey `widget/limit-fill` (**#86868B light / #636366 dark**),
  never the habit's colour, never red, and never text inside the bar (the user, 6 Oct: a label over a grey fill
  looked heavy and half-unreadable).
- Fills cap visually at full; the text keeps the true value ("9 of 8 glasses", "3 of 2 cups max").

**Day squares** (weekly Medium; the Progress page's language, Design Rules "Progress Week"). One rounded square per
day (radius 0.22 × side), colour strength = how much of that day's goal was done (three lighter steps, goal met,
more), ✓ on goal met and more, grey ✕ not done, ⏩ skipped, ⏸ paused, plain grey still to come, dashed = not
scheduled, a thin outline = today, nothing = before the start. **Widgets use 20-pt squares** (the user, 6 Oct; recorded
in Design Rules), signs scaled to the square: ✓ 10 pt / 2-pt line, ✕ 8 pt / 1.7, ⏩ ⏸ 9 pt. Colours come from
`HeatPalette`; the dashed and today outlines are **#86868B** in light mode (3.25:1 on the grey week card).

**Words.** Say it the way people do (U11): "3 of 8 glasses", "1 of 2 cups max", "Since 20 Sep", "2 left". Never
"due", "overdue", "missed", "failed", "relapse", "reset" (U3).

## 3. Actions by habit type (all families)

| Type | Shows | Action | Notes |
|---|---|---|---|
| Single check | Done or not today | ✓ toggles **today only** | Done: the button in the habit's colour |
| Several checks / saved amount | "3 of 8 glasses" | **+1** / **+500** adds exactly one saved increment | Above goal stays "+1", still adds |
| Typed amount, Health steps | Value of goal | Arrow opens amount entry / the habit | Never fabricate steps |
| Timer | "12 of 20 min"; running shows a live clock | Play opens the full-screen timer; Pause saves one session | Running stays neutral |
| Checklist | "2 of 5 steps" | Arrow opens the named steps | Never ticks a guessed step |
| Weekly / monthly total | **Progress toward the period**: "1h 12m of 3 h", "4 of 10 times" | Per input type | Bar fills toward the week's or month's goal (the user, 6 Oct); goal met turns the button the habit's colour |
| Quit | Live time since the last slip | Arrow opens Record a slip | Never a "done"; never logged from the Lock Screen |
| Cut down (at most) | "1 of 2 cups max" | +1 logs what was used | Neutral bar; numbers show reached or over |
| Task | Name and its section | ✓ toggles today | No stats, no streak |
| Skipped / paused / not planned | Its state | Arrow opens Day details | Quick logging off |

Every write follows [Accepted Widget Contract](<Accepted Widget Contract.md>): validate the item's stable ID, the
displayed logical day and privacy; commit before showing success; one entry per deliberate tap; a stale tap never
logs into a new day (D7).

## 4. Small · one habit, today

Layout: icon top-left (24 pt) and the action top-right (44 pt); name (17 Semibold); value line (15 Regular); then
the 18-pt capsule. In Figma: set `Daily widget / Today` (`540:3003`, 33 variants) plus the timed-limit and recovery
families (42 review cards in all); images in
[Daily Cards/Images](<Daily Cards/Images/README.md>) and the [final typography and recovery note](<Daily Cards/Final Typography and Recovery — 6 October 2026.md>).

**6 Oct revisions** (they supersede the older images 18–22 and 32–35):

![Small revisions](<Daily Cards/Revision — 6 October 2026/Weekly, monthly and limit cards (2x).png>)

- Weekly/monthly total: value "1h 12m of 3 h" / "4 of 10 times"; the capsule fills in the habit's solid colour toward
  the period goal, with **no label** (the user: "users already know that is a weekly habit … just have a number").
  New states: start of the period (empty) and goal met (full, button in colour).
- Limits: plain neutral bar with no text; the value says "max": "1 of 2 cups max", "3 of 2 cups max",
  "10 of 20 min max"; a running timer reads "12:36 of 20 max" because the longer wording does not fit 126 pt.
- Quit: one emphasised live line ("15d 22:36:35") and "Best 45 days"; Arrow → Record a slip.

## 5. Large and Medium · Today list (also any home section)

Handoffs: [Large](<Today List/Large Designs — 6 October 2026/Layout and Implementation Handoff.md>),
[Medium](<Today List/Medium Designs — 6 October 2026/Layout and Implementation Handoff.md>).

- **What it lists:** Today, or **one section the person picks** (Morning, Anytime, Quitting, or their own), chosen by
  the section's saved ID, in the person's own order (U13). The title is the view's name.
- **Capacity: Large 5 a page, Medium 2 a page** (the user: more than five is hard to tap). Header: title and "2 of 5
  done" on one line; with pages, title and count on the left and ‹ 1/3 › on the right (44-pt arrows; the disabled
  arrow is dimmed).
- **Pagination rules (lists and Tasks):** pages are explicit (no scrolling); 6 items = 5 + 1, 12 = 5 + 5 + 2;
  the last page keeps rows at the top and leaves the rest empty, so buttons never shift; the count covers every
  page; the page holds still through a run of taps (U4) and clamps if items disappear; each widget instance keeps its
  own page. Fewer than capacity and no pages: taller 58-pt rows (Large lists; a single task on Medium).
- **Rows:** icon, name, a line (section and value, e.g. "Anytime · 3 of 8 glasses"; a selected section drops the
  repeated section name), the action; the row fills toward today's goal (0.15 / 0.26). Period goals show today's
  contribution beside the configured period goal, with no row fill (the accepted list rule; the user may ask to
  change it to match the Small card's progress toward the period).
- **Summary count** counts positive day items once; quit and cut-down are not "left" (U10).

## 6. Medium · one habit, this week

![Weekly Medium key cards](<Weekly Medium/Images/Weekly Medium — key cards (2x).png>)

Full board: [every state](<Weekly Medium/Images/Weekly Medium — every state (board).png>) · Figma set
`Weekly Medium / One habit` (`673:5287`, 43 variants).

**Layout** (two cards, like the user's reference, without its glow): the **habit card** on the left (96 pt wide,
full height): icon (44), name (15 Semibold, up to two lines, then "…"), and one line under it; on the right, **today**
sits directly on the widget (value + goal, the 44-pt button, an 8-pt bar), and the **week card** below it (seven
20-pt squares with day names, today outlined). Week follows the person's week start.

**The line under the name:** "🔥 12" (the app's streak: a bare number for daily habits, "3×", "4 wk", "2 mo" for
others); quit: **"Best 45 days"**, or **"Quitting"** when there's no best yet, or **"New best"** past it; limits: the
state ("Daily limit", "Limit reached", "Over the limit", "Weekly limit", "Monthly limit"). No current streak: show
nothing or the best run, never a zero (U3).

**Quit** (the user: "don't make those cards look dumb"): live time ("15d 22:36:35") with **"Since 20 Sep"** under it
(the same wording for a first quit date or after a slip; a slip today shows "Since 14:21"); the bar fills toward the
best run (full at "New best"); week: clean days colour ✓, a slip grey ✕. Never "since the last slip" (it keeps
reminding people of the slip). Paused: "Paused" replaces the time.

**Limits:** neutral bar and button; days are judged only when their day or period ends.

**Recovery states** (choose a habit, no habits yet, habit unavailable, content hidden, open to update, couldn't
save): the habit card shows a generic symbol; today shows the title and subtitle; the week card carries the
instruction (e.g. "Touch and hold the widget, then Edit Widget to pick a habit.").

**Colours** (new variables, Day sheet collection): `weekly-widget/background` #FFFFFF / #000000,
`weekly-widget/container` #F2F2F7 / #1C1C1E, `weekly-widget/empty-day` #DEDEE3 / #2C2C2E. In dark mode, grey squares
must sit on #1C1C1E, never #2C2C2E (the same colour as the grey square; found 6 Oct).

## 7. Tasks · Large and Medium

![Tasks Large](<Tasks/Images/Tasks Large — key cards (2x).png>)
![Tasks Medium](<Tasks/Images/Tasks Medium — key cards (2x).png>)

Full board: [every state](<Tasks/Images/Tasks — every state (board).png>) · Figma sets `Tasks widget / Large`
(`687:8158`, 12) and `Tasks widget / Medium` (`688:7900`, 10).

- Same layout, capacity and paging as the Today lists: **Large 5, Medium 2**, pages above that.
- Title "Tasks" (a chosen section: "Morning tasks"); count "1 of 5 done".
- Row: icon (24), name (17 Semibold), one line: the section and its time if set ("Afternoon · 5:00 PM"), or where a
  carried-over task came from ("From Sat 3 Oct", as `taskLine` says); in a section view, the time or "Task".
- One ✓ per task; done = tinted row and the button in the task's colour. **No statistics** (the user: "tasks won't
  have any statistics … all they have is a check mark, an icon and which section of the day they belong to").
- States: five, four (58-pt rows), six and twelve over pages, all done, section, long names, no tasks today, content
  hidden; dark done tint 0.26.

## 8. Lock Screen

![Lock Screen — today and two habits](<Lock Screen/Images/Lock Screen — today and two habits (2x).png>)
![Lock Screen — four habits](<Lock Screen/Images/Lock Screen — four habits (2x).png>)

Full board: [every state](<Lock Screen/Images/Lock Screen — every state (board).png>) · Figma sets
`Lock / Circular · one habit` (`694:9071`, 14), `Lock / Rectangular · today` (`694:9150`, 5), `Lock / Inline`
(`694:9163`, 3).

**Platform facts** (Apple HIG, Widgets): circular 72 × 72, rectangular 160 × 72, inline 234 × 26 (390/393-pt phones;
68 / 153 × 68 on the smallest). Vibrant rendering: **monochrome**, no habit colours; meaning must not depend on
colour; text ≥ 11 pt; inline has one tap target. Buttons work without unlocking (iOS 17+, App Intents
`authenticationPolicy`).

**One-habit circle (the user's rules):**

| Habit | Shows | Tap |
|---|---|---|
| Single check | **Icon only**; a full ring around the icon when done | ✓ today |
| Daily goal (count, time, steps, checklist) | Icon + value **on one line** ("3/8", "12/20m", "4.2k/8k") + a ring to the goal | Saved +1/+500 adds once; others open the app |
| Quit | Icon + "15d" ("14h" on the first day) | Opens the app; slips never logged here |
| Cut down | Icon + "1/2", **no ring** | +1 |
| Paused / private / choose a habit | "Paused" / lock / "Choose" | None / opens setup |

Ring: 6-pt stroke, track at 30 % white, progress full white, starting at the top. Values: 15 pt; longer values 12 pt
(and `minimumScaleFactor` so any value stays on one line; the user: "don't split them in two lines").

**Today rectangle:** "Today  3 of 5 done", one segment per habit, and **"2 left · Stretch, Read"** in the person's own
order, ending in "…". **Never "Next"** (Anytime and quit habits have no next). States: in progress, all done, many
habits, private (counts only), no habits. **Inline:** "3 of 5 habits done", "All 5 habits done", or one quit habit
("Smoking · 15d").

**Removed** (the user, 6 Oct): the today circle ("3/5" read like one habit's count), the one-habit week (no room for
a button: seven 20-pt squares already take 158 of 160 pt), the button rectangle and the up-next list.

## 9. Privacy, App Lock and what's next

- **"Content hidden" is set by the app, not iOS.** It shows when the person turns on **Menu → Widgets → Hide widget
  content** or the app's **Face ID lock** (`AppLock.swift`; `HabitStore+Widgets.swift` publishes an empty snapshot).
  While either is on, the widgets show the lock and "Content hidden", with no names, progress or logging, until it is
  turned off. Unlocking the app does not reveal them; widgets cannot ask for Face ID.
- **iOS layer for everyone:** mark the widgets' views `privacySensitive` so iOS hides them on the Lock Screen while
  the phone is locked (the person's Settings → Face ID & Passcode → Allow Access When Locked applies).
- Feature Ledger: C017 Passcode lock (Strong, 15 apps; "minor", noticed mainly when missing, removed or paywalled) and
  C096 Privacy and discretion stack (Strong, a must-have for recovery users on family phones).
- **Next work: Current Work item 58**: App Lock and widget privacy, to be designed after the widgets ship.

## 10. Decisions made on 6 October (the user)

1. Large multi-habit weekly widget: dropped ("we are not going to build it").
2. Weekly widget: Medium, one habit, two cards like the reference, no glow; streak small ("🔥 12"), icon big.
3. Build one card first, then variations only on request.
4. Widget squares may be 20 pt (only legibility matters; they can't be tapped).
5. Quit: best under the name; "Quitting" with no best; no "since the last slip"; "Since 20 Sep" instead.
6. Limits: state text not beside or inside the bar; in the weekly Medium it goes under the name, in the Small card the
   value says "max".
7. Monthly widgets: parked (Medium can't fit the month at a legible size; Large possible later).
8. Icon-only widgets: not building (people want more habits per widget, but with names).
9. Tasks widgets: Large 5 and Medium 2 a page, with paging; free.
10. Lock Screen: circles by type (above), today rectangle with "N left", inline; values on one line; no today circle.
11. Small weekly/monthly: progress toward the period, solid colour, no label.
12. No Plus restrictions for now; App Lock and widget privacy next.

Evidence for 7, 8 and the Lock Screen: keyword scans of all 1,238,784 store reviews, every match read by hand
(about 34 month/calendar-widget reviews against 695 about ticking from a widget; about 4 wanting icon-only, 7 hurt by
it, 25 wanting more habits per widget; 154 Lock Screen reviews, more about seeing progress (57) than ticking (31)).
These are directional counts, not a coded study (W2). Request checklists: [index](<Request Checklist Index.md>).

## 11. Building it: code and gaps

- **Code entry points** ([Implementation Handoff](<Implementation Handoff.md>), recheck on current `main`):
  `iOS/Shared/PhoneWidgets.swift` (kinds, providers, views), `WidgetSnapshot.swift` (data),
  `WidgetIntents.swift` (configuration, logging, paging), `HabitStore+Widgets.swift` (publishing).
  Keep the existing widget kinds and saved configurations stable.
- **Gaps to close:**
  - week squares: publish seven `HeatCell`s per habit from the store (the Progress Week values), not `dayMark`
    strings; quit habits currently get no history (S5);
  - sections: the snapshot needs section IDs and the person's order; a "tasks only" filter already exists;
  - paging per widget instance; period progress values for weekly/monthly goals;
  - Lock Screen views in vibrant mode; `privacySensitive`.
- **Speed:** history worked out once in the store; publishing waits for changes to stop (S16, 2 s); one `Canvas`
  per week strip; no per-row formatters (S8). Measure with a speed run (S2).

## 12. Testing (do it thoroughly)

- **Each family and state** above: a UI or snapshot check that the right text, fill and action appear, in light and
  dark, at a large Dynamic Type size, with VoiceOver labels (one element per row, the action as a named action; T9).
- **Actions:** every type's tap writes exactly one entry for the displayed day, survives a cold start, and never
  logs twice from a retried tap or into a new day after midnight, a custom day start or a time-zone change (D7).
- **Paging:** 6 / 12 / 16 items, the last page's positions, a page held through taps, clamping when items go.
- **Configuration:** two widgets with different habits or sections stay independent; a deleted habit shows "habit
  unavailable" and is never replaced.
- **Privacy:** Hide widget content and App Lock both produce "Content hidden" everywhere; no names leak.
- **Test launches** never touch real data (D8). Run tests once, at the end (T7), with T10's coordination; speed run
  for anything touching `HabitStore` (S2).
- **On the iPhone (U9):** the real picker (Edit Widget), Lock Screen vibrant rendering and contrast, tinted/clear
  Home Screens, 20-pt squares (⏩ against ⏸), and the dark-mode backgrounds.

## Images

| Family | Images |
|---|---|
| Small | [Daily Cards/Images](<Daily Cards/Images/README.md>) and the [6 Oct revision](<Daily Cards/Revision — 6 October 2026/README.md>) |
| Large Today | [Large Designs/Images](<Today List/Large Designs — 6 October 2026/Images/README.md>) |
| Medium Today | [Medium Designs/Images](<Today List/Medium Designs — 6 October 2026/Images/README.md>) |
| Weekly Medium | [Weekly Medium/Images](<Weekly Medium/Images>) |
| Tasks | [Tasks/Images](<Tasks/Images>) |
| Lock Screen | [Lock Screen/Images](<Lock Screen/Images>) |
