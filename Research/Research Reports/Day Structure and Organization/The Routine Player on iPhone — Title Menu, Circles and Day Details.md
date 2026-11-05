# The Routine Player on iPhone — Title Menu, Circles and Day Details

Written by Claude (Claude Code), 6 November 2026 (IST). iPhone design loop, screen E: the routine player
(Figma "IOS app", [Routine player 906:89513](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=906-89513),
page "routine player" 234:2).

## What people come to this screen to do

To go through a time of day's habits one at a time (Morning: Meds, Stretch, Skincare) without hunting on Today:
do the one in front of them, move on, and see that the routine is finished. Users show what goes wrong elsewhere
([Focus Player — How It Should Behave](<Focus Player — How It Should Behave.md>), 2,271 reviews): controls that stop
fitting at larger text, being stuck on a screen, and clutter at the bottom of a timer screen.

## What was wrong (the user's points, 6 Nov)

- **The header didn't look good:** ✕, then "Morning ◇" (a pop-up button's up-down chevrons) pushed against it at the
  left, ⋯ at the right, and under it a full-width progress line with "1 of 3" squeezed at its end. Two rows for one
  job, and the title wasn't where an iPhone title sits.
- **The "Today" button:** a grey chip with a calendar under the name that opened Day details. It named a day, not
  what it does.
- **The cookie** (Material 3 Expressive) behind the icon. Android keeps it (A52); on the iPhone the brief allows it
  only for medals.
- The hero sat in a big white card on every screen, so the habit screen looked like a form.
- Button words in sentence case ("Mark done").

## What was tried (Simulator, iPhone 17, iOS 26)

| Version | Verdict |
|---|---|
| Title menu, "Morning ⌄" with "1 of 3" as its subtitle | **Chosen**: one row, centred, the iPhone's title-menu shape |
| Title menu plus a progress line under the bar | The line repeated the count and added a row |
| Day Details inside ⋯ | Clean, but hides the way to logs, notes and Skip |
| Day Details as a Small Bordered button under the description | **Chosen**: says what it opens; a quick action, as the user's rules describe |
| Hero without a card, the icon in a circle of the habit's colour | **Chosen** for the habit and end screens; the checklist keeps list cards (header and steps), as a List draws them |
| A time habit inside the Timer ring | Looks right; not built yet (see Still open) |
| Main action in the iOS bottom bar as a Label | The bar shows a Label as its symbol only (a lone ✓ or ▶); kept the capsule with a word |

## What changed

**Routine player, all 5 variants:** the header is ✕ · **Morning ⌄** with "1 of 3" (Caption 1, Secondary) under it,
centred · ⋯, 16 from the edges; the progress row is gone. The habit's icon sits in a **circle of its colour** (112 on
the habit screen, 72 on a checklist, 96 at 200 %); the end page's is Ink with ✓. The hero has no card on the habit
and end screens. **Day Details** (Small Bordered, no symbol) replaces the Today chip. Button words are Title Case
(Mark Done, Add a Check).

**92 copies** (Habit 66, Checklist 13, many steps 1, End 10, 200 % 2): their words are component properties and
carried over; each copy's colour was copied from its cookie onto its circle before the cookie was removed. The
yesterday flow says so in the subtitle ("Yesterday · 1 of 3"), since the chip that named the day is gone.
Captions, arrow labels and frame names on the page: the title menu, Day Details, banner (not snackbar), the circle.

## Screen F: Your routine (907:29174)

Already iOS's own shape: a Medium sheet without a handle (one height), Edit as a word, Change order as the List's
edit mode with grabbers, a footer. Two things changed: the **done row's trailing ✓ is gone** (a trailing checkmark
on iOS means "selected"; the row's supporting line already says Done), so only the row you're on keeps a marker,
▶ (play.fill, Secondary, as Music marks what's playing); and **Done** in Change order is a Semibold glass word, as
Add and Save are. Its 4 copies on the page follow.

## Left for the user

1. **Day Details visible or in ⋯.** Chosen visible (a small capsule under the name); the alternative keeps the hero
   cleaner and puts it first in ⋯.
2. **The hero card.** Removed on the habit and end screens; the old white card made the screen read as a form.

## Still open

- **A time habit in the player** still shows its clock as text with a flat line; it should use the Timer ring, as
  the timer on its own does (a Screen=Time variant).
- **Outside the app** (frames 958:157631 and the notes 260:225, 260:231) the page still shows Android's Live Update
  status-bar chip; on the iPhone a running clock is a Live Activity in the Dynamic Island and on the Lock Screen.
  To do with the notifications page.
