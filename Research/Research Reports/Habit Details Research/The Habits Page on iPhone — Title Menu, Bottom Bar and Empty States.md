# The Habits Page on iPhone — Title Menu, Bottom Bar and Empty States

Written by Claude (Claude Code), 6 November 2026 (IST). iPhone design loop, screen G: the Habits page (Figma "IOS app",
[Habits page 986:150825](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=986-150825), page
"habits & tasks" 269:148).

## What people come to this page to do

To see how every habit is going over a week, a month or a year, find one, and open it. Less often: step back to an
earlier period, add a habit, switch to Tasks. Reasoned from first principles, with the earlier evidence in this
folder: the cards are the content, so the top must be quiet and say plainly which list you're in.

## What was wrong (the user's points, 6 Nov)

- **The top was crowded and didn't show which tab was active:** ‹ (as if the page were pushed, though it's a place in
  the menu, like Today), a glass Habits | Tasks capsule with no visible selection, and search and + squeezed beside it;
  then Week · Month · Year; then a period row.
- **When scrolled, a period row stuck under the bar** (Android's pinned header), the bar and tabs turning grey.
- **The ⋯ on the cards wasn't aligned:** the More button inside the card's header had a stray right-alignment, so the
  ⋯ sat off the centre of its circle.
- **"Back to this week" was Prominent**, where Today's Back to Today is the plain glass button.
- **The empty states** drew a cookie behind the symbol and a small capsule "New habit".

## What was tried (Simulator, iPhone 17, iOS 26)

| Version | Verdict |
|---|---|
| ☰ · a segmented Habits \| Tasks in the bar · search + | The real segmented control does show a grey pill on the active side, but beside search and + it was still tight at our width |
| ☰ · **Habits ⌄** (a title menu: Habits, Tasks) · search + | **Chosen**: the title says where you are; Tasks is one tap away; the bar breathes |
| Large title "Habits" with Habits \| Tasks and Week · Month · Year under it | Two segmented controls stacked: heavy |
| The period in a Today-style bottom bar: ‹ 18–24 Oct ⌄ › | **Chosen**: it's always in reach, nothing sticks to the top, and it matches Today's day bar |

## What changed

- **Design system:** Navigation bar gets **Text=Title menu** (☰ · the title with a small chevron.down · actions),
  re-linked to the bar's properties. The More button's ⋯ is centred in every Habit history card variant (the stray
  alignment was in the card component, so every card on every page follows). A new **ContentUnavailableView**
  (4252:428521) made from Today's finished Nothing Planned Today: the symbol in Secondary Label with no shape behind it,
  Title 2 Bold, Subheadline, one Large Prominent button.
- **Habits page, all 11 variants:** ☰ · Habits ⌄ · search and +; the pinned period row is gone; the period is the
  bottom bar (18–24 Oct, 11–17 Oct, October, 2026), › off on the latest period; Back to This Week is the plain glass
  floating button above the bar; the empty states are ContentUnavailableView (No Habits Yet, No Habits Right Now)
  with New Habit.
- **52 copies on the page** follow; the first-week copy has ‹ off. Captions and frame names: the title menu, the
  bottom bar, nothing sticks while scrolling; ⋮ → ⋯, ← → ‹, snackbar → banner, menu items in Title Case, across the
  page (64 texts).

## Screen H: Archived habits and Search (988:7736, 991:8050)

**Archived habits** was already iOS's shape (‹, an intro line, one list newest first, each row's ⋯ with Restore and
a red Delete). Changed: the title is **Archived Habits** (Title Case); **No Archived Habits** is now a
ContentUnavailableView (the box symbol, no shape behind it, no button: there's nothing to do); the "snackbar" layers
are named Banner, which is what they are (the design system's Banner).

**Search** had Android's keyboard (an icon strip, ?123, a dark return) and a no-match state of small grey words with a
small capsule "+ Add “yoga”". Changed:

- **Keyboard · letters (native)** (990:251, design system on the settings page) is now **Apple's iOS 26 kit keyboard**
  (suggestions, four rows, 123, a grey return), cropped to its old 260 so no screen moved; every copy on every page
  follows.
- **No match** is iOS's own no-results view: the magnifying glass, **No Results for “yoga”**, "Check the spelling, or
  add it as a new habit or task.", and **one Large Prominent button, Add “yoga”** (A72: a word can be either, so it
  doesn't guess). Both no-match copies name their own word (yoga, plumber).
- Captions: the search field at the top with ✕ beside it, not "Android's full-screen search view"; Move to Another
  Day… opens the calendar.

## Screen I: the Tasks page (999:1061)

The same header problem as Habits, so the same answer: ☰ · **Tasks ⌄** (the title menu: Habits, Tasks) · search and +,
in all 12 variants. One-time | Repeating stays as the content's segmented control (it filters one list, not two
places). **No Tasks Yet** and **No Repeating Tasks** are ContentUnavailableView with one Large **New Task**. Captions
and frame names say the title, not tabs (10 texts, 5 frames).

## Screen J: Archived tasks and Completed tasks (1001:178, 1002:230)

The user: "Archived habits, archived tasks and completed tasks must share ONE mental model and look consistent." They
now share one shape, written into all three components' descriptions: ‹ and a Title Case title (**Archived Habits**,
**Archived Tasks**, **Completed Tasks**); an intro line saying what's kept there (Completed Tasks gained one: "Done
tasks stay here, by the day they were done. Open one again with Mark as Not Done."); one inset list, newest first
(Completed: one per day); each row's ⋯ with the way back (Restore, **Mark as Not Done**) then a red Delete; Undo in a
Banner; and an empty state that is a ContentUnavailableView with no button (**No Archived Tasks**, **Nothing Completed
Yet**, also under the Deleted banner). Completed's bar ⋯ keeps **Delete All Completed**.

## Screen K: Habit details (1020:4052)

"Mostly good, with inconsistencies" (the user). What changed:

- **See All**, not "+ See all streaks" / "+ See all 4": the + said "add", which none of them does (22 buttons).
- **No Progress Yet** and **Nothing Here Yet** are ContentUnavailableView, no shape behind the symbol, no button
  (logging happens on Today). Medals keep their own shape.
- **History's buttons**: **With Notes** (a filter: Bordered, Prominent while on) and **Go to Date…** (Bordered with the
  calendar; "…" because it opens the calendar first), Small capsules, Title Case.
- **The squashed check marks** (1148:286731, 1158:377814 and every history row, 376): the history rows forced the
  28-point day cell into a 12-point slot. They now hold the 24-point day cell (the same squares as the cards), in
  Water's blue.
- **Go to Date… in History** (9 frames): the calendar opens under the button; a new **Month=September** variant of the
  Date picker (September 2026 starts on a Tuesday) shows the earlier month; the chosen day is an Ink circle; choosing
  a day closes the calendar and opens or scrolls to that day (no "Open Tue 8 Sep" button: iOS's calendar acts on the
  tap). ‹ is off before the habit began, › off on this month.
- Captions (42 texts, 23 frames): ⋯ and ‹, banner, the calendar, Title Case button words. Add Note is Title Case on
  its floating button (8).

## Screen L: Streaks and All milestones (1034:74, 1036:235)

"The badges look weird" (the user). They were squeezed: every List item fixes its leading slot at 24 × 24, and All
milestones swapped a 40-point medal and a 48-point progress ring into it, so numbers spilled out of the rings ("400")
and the medals became blobs. Neither the Medal nor the Progress ring uses auto layout, so the slot can't simply hug
them. A new **Milestone row** (design system 4256:2590; Kind Reached/Next × Position First/Middle/Last/Single) holds
the medal (Small, 40, its own shape kept) or the ring (48) in a 48 slot, with the name and when beside it; the 15
rows of both variants were replaced, each keeping its number, arc and colour. The title is **All Milestones**.
Streaks was already right (one inset list of runs with bars, a footer) and is unchanged.

## Screen M: Search in a habit's notes (1053:9079)

Its defects: the results rows had History's squashed day ✓ (fixed the same way: the 24-point day cell, in Water's
blue); "No notes with “swim”" was two lines of small grey text, now iOS's no-results view (**No Notes with “swim”**,
the magnifying glass, "Search looks through this habit's notes. To find a day, use Go to Date…", no button), filling
the space above the keyboard. The keyboard is already the iPhone's (H).

## Screen N: Task details (1136:9271)

"The cells have problems; the Nothing done yet card has padding issues" (the user). The history rows had the same
squeezed day cell as Habit details (28 points forced into a 12-point slot); they now hold the 24-point day cell, each
in its task's own colour. **Nothing Done Yet** is a ContentUnavailableView (no shape behind the symbol, no button), so
its spacing is the design system's, not a card's. The ⋯ menu reads **Edit Task** and **Move to Another Day…**.

## Screen O: How milestones work (1142:29063)

"It looks very weird" (the user). It read like an Android page of grey 17-point headers over cards of 15-point
paragraphs, all evenly spaced. Now it follows Settings' grammar: section headers in Subheadline Semibold, Secondary
Label; each card's first sentence in Body (the rule), the rest in Subheadline, Secondary Label (the detail); 28 between
sections and 8 under each header, so each section reads as one piece. The title is **How Milestones Work**. Both
variants (habits; quitting and cutting down).

## Left for the user

1. **Title menu or segmented control.** The title menu was chosen for room and clarity; the segmented control is
   iOS's other way and keeps both names in view.
2. **The period in the bottom bar.** It replaces Android's pinned row and matches Today; the cost is a bar on a page
   that had none.
