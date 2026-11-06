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

- ~~**A time habit in the player** still shows its clock as text with a flat line.~~ **Done 6 Nov 2026:** a new
  **Screen=Time** variant (4266:18626) puts the clock in the **Timer ring** (the habit's colour on its Fill, the arc
  as far as the time has gone, full at the goal), with the name, description and Day Details above it and Paused or
  Goal met under it; the bottom bar says Start, Pause, Resume, Next or Log. Its 25 copies were moved to it: their
  words (name, count, Yesterday, status, description, banner) were put back from the Android file's same nodes after
  the swap reset them, each ring took its copy's colour (Teal for Stretch, Orange for Read) and arc (40 %, 67 %, full).
- ~~**Outside the app**: Android's Live Update chip.~~ **Done 6 Nov 2026:** the design system's Android pictures were
  rebuilt in place as the iPhone's (drawn, not Apple's images, D11): **Notification (iOS)** (the banner: app icon,
  Semibold title, body, the time at the trailing edge; 12 copies keep their words and now show only the time),
  **Live Activity (iOS)** (the habit's icon in its colour, name and goal, the clock at 34, the progress line, Pause),
  **Home Screen (iOS)** (rounded-square icons, the Dock, and the **Dynamic Island** showing the running clock,
  bound to the old chip properties), **Lock Screen (iOS)** and **Lock Screen · Live Activity (iOS)** (the date over the
  large time, the card at the bottom; Android's shade and quick settings are gone). The player's frames and notes say
  Dynamic Island, Lock Screen and Live Activity; ⋮ → ⋯.

## The notifications & alarms page (6 Nov 2026)

[Notifications & alarms 1265:24553](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=1265-24553)
showed Android's notifications: an app-name header with an expand chevron, a row of buttons, the shade, a status
bar chip, an inbox-style group and Android's direct reply. Now, drawn as the iPhone's (not Apple's images, D11):

- **Reminder notification** (1268:127): **Collapsed** is iOS's banner (the app icon, the title in Semibold, the text,
  the time at the trailing edge); **Expanded** is the long press: the notification grows (the progress shows) and its
  actions are a **menu under it**, up to four, one per row; **Reply** is iOS's text input action. Every copy shows the
  app icon, as iOS does (78 copies had a habit-coloured icon); "Often Enough · now" became the time alone (45).
- **Reminder group** (1273:903): iOS **stacks** reminders of the same minute (the newest on top, the rest as layers);
  opened, an "Often Enough" header with Show Less and each reminder its own notification.
- **Screens:** Heads-up → **Home Screen · reminder**; Lock screen → **Lock Screen · reminders** (the date over the large
  time, notifications in the lower half); Shade → **Notification Center · reminders** (no quick settings). The timer
  flow's Live Updates are the **Live Activity**.
- **Captions (14):** a long press for the actions, up to four, the reply field, Face ID or the passcode for Open, the
  Dynamic Island, the stack.
- **Left for the user:** the two alarm flows stay Android's, marked "iPhone: AlarmKit, left for the user (screen P)";
  "An alarm without full screen" has no iPhone version.

