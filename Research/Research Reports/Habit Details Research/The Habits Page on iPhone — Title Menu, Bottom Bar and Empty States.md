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

## Left for the user

1. **Title menu or segmented control.** The title menu was chosen for room and clarity; the segmented control is
   iOS's other way and keeps both names in view.
2. **The period in the bottom bar.** It replaces Android's pinned row and matches Today; the cost is a bar on a page
   that had none.
