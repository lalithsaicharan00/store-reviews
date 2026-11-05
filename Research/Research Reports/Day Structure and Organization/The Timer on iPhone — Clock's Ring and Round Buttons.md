# The Timer on iPhone — Clock's Ring and Round Buttons

Written by Claude (Claude Code), 6 November 2026 (IST). iPhone design loop, screen A: the timer on its own
(Figma "IOS app", component [Timer screen 705:7745](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=705-7745)).

## What people come to this screen to do

To time a habit (Stretch, Piano, Social media) while doing it, and to stop or pause when they're done. They open it
from Today's ▶, from Day details' Start Timer, or by tapping a row whose clock is running. While it's open they
glance at it: how long so far, how far to the goal (or the limit). Two things are secondary: adding time done
without the timer (Log Time) and looking at the day (Day Details). Leaving never stops the clock (Android's mental
model, kept: Today's row and the Live Activity keep it ticking).

Users show what goes wrong elsewhere ([Focus Player — How It Should Behave](<Focus Player — How It Should Behave.md>),
2,271 routine and timer reviews): pause that doesn't hold is the most repeated bug (68 reviews), the Pause/Resume
control must always look like the main button, and controls must still fit when text is enlarged ("everything on the
app is enlarged … I can't even press the 3 buttons", `cbb9e1be-b199-4142-b512-2dd860b13dbb`).

## What was wrong (6 Nov 2026)

Everything on the old screen came straight from Android:

- **The cookie** (Material 3 Expressive's 9-point star) behind the icon. iOS has no such shape.
- **The wavy progress line** (Material's running indicator). iOS has no wave; its timers show progress with a ring
  (Clock) and show that they're running by counting.
- **The "Today ›" chip** under the name (a Material assist chip), opening Day details.
- **A tonal "Log time" and a filled "Pause" side by side**: Android's square button group (A69) redrawn as capsules.
  The user: "the buttons don't feel native".
- **⌄ in a glass circle** to put the screen away, on a full-screen page with a white card.
- A limit's timer (Social media) drew its wave in the habit's pink on Day details' copy, against A41 (neutral).

## What iOS does for this job

- **Apple's own timer is Clock's** (Timer tab): a large clock inside a thin progress ring, and two round buttons at
  the sides: a grey "Cancel" and a coloured "Pause"/"Resume", each a disc inside a thin ring with one word. Every
  iPhone user knows it. This is the native grammar for "a clock is running here". (The Clock app isn't on the iOS
  Simulator, so it's described from the phone; the probe below rebuilt it with SwiftUI's own parts.)
- **A layer that can be put away while work carries on** is a sheet: swipe down or ✕, and what's under it shows
  again. Day details is already a Large sheet; the timer opens over Today or over Day details the same way.
- **A title with a line under it** (the habit's name, then the day) is the navigation bar's title and subtitle, as in
  Mail or Files; a word action in the bar ("Day Details") follows the bar's own text button (HIG, Toolbars), as Edit
  does on Today.

## What was tried (Simulator, iPhone 17, iOS 26, 9:41)

A SwiftUI probe (scratch branch `claude/nice-hopper-dhgw5r-probe`, safe to delete) drew five versions, then a
second round of the chosen one in every state:

| Version | What it was | Verdict |
|---|---|---|
| A | Full screen; icon, name and a small "Today ›" button above a ring; Clock's round buttons | Reads at once as a timer; the top was crowded with two "Today"s |
| B | Sheet; icon circle, name, "Today ›", clock and a linear ProgressView; glass Log Time… and Pause capsules | Clean but generic; white glass "Log Time…" faded into the sheet |
| C | B with a ring instead of the bar | Better, but the capsules still read as "a form", not a clock |
| D | Day details grammar: a card with the clock, then Log Time… and Day Details as rows, one Prominent Pause | Consistent, but no longer feels like a timer; Pause far from the clock |
| E | Sheet; the habit's name as the title, "Today" in the bar, icon inside the ring, Clock's buttons in Ink | Cleanest and most iPhone-like |
| F (round 2) | E with the title and the day as title + subtitle, and **Day Details** as a word | **Chosen** |
| G (round 2) | F with ⋯ (Day Details, Log Time…) | A menu hid Day Details and doubled Log Time |
| States | Paused, Goal met, Over the limit, full screen, and large text (Accessibility 1) | All read well; at large text "Log Time" overflowed the circle, so the round buttons' words stay at Body size, as Clock's do |

## What changed

**Design system (page 493:2)** — two new parts, because the routine player's time habits will use them too:

- **Clock button** ([4228:2548](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=4228-2548)):
  an 80 disc inside a 2 pt ring, 90 across, one word in Body Regular. Neutral (Secondary System Fill, Label: Log
  Time), Prominent (Ink, white: Start, Pause, Resume), Done (the habit's colour, white: Pause once the goal is met,
  A91). The word doesn't grow past Body, so it always fits.
- **Timer ring** ([4228:2551](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=4228-2551)): 260
  across, 10 thick, round ends, the habit's colour on its Fill, filling clockwise from the top; inside, the habit's
  filled icon, the clock in SF Pro Light 64 (tabular figures) and the goal. A limit is System Gray on Gray Fill (A41).
- **Navigation bar** (495:70): the shared actions capsule now follows Action 1, so a bar with only a word action
  (Day Details) no longer keeps an empty 44 pt slot that pushed the word over the title. No copy in the file used
  Action 2 without Action 1 (checked on all 13 pages).

**Timer screen** (705:7745, Running and Paused): a Large sheet from the status bar's foot (y 54), System Background.
✕ (glass, 16 from the top and side), the habit's name with "Today" under it, and **Day Details** as a word at the
right. The Timer ring in the middle, then a status line that keeps its place: empty while running, "Paused",
"✓ Goal met" (new property *Show ✓ (Goal met)*), "Over the limit". At the bottom, Clock's round buttons: **Log Time**
(Neutral) at the left and **Pause / Resume** (Prominent; Done at the goal) at the right. A 200 % text frame sits next
to the component (4230:447235).

**Every copy, every page** (13): Day details page 4, Today 3, routine player 7 (the timer on its own). Each copy's
habit, clock, goal, colour, progress and state were read before the rebuild and put back; Piano's goal now says
"of 3 h this week", since its clock counts the week. The pink wave on Day details' Social media copy is now a grey
ring. Captions, arrow labels and frame names on the three pages now say ✕ (or swipe down) for ⌄, "as a sheet" for
"full screen", Day Details for "Today ›", "ring" for "wave", and Start Timer / Log Time… as Day details writes them.

## Left for the user

1. **✕ or ⌄.** The sheet now closes with ✕, like every sheet in the app. ⌄ said "put away, the clock keeps going"
   more plainly; on iOS that is said by the sheet itself (swipe down) and by Today's row keeping the clock. If ✕ reads
   as "stop the timer" to you, the alternative is a glass chevron.down in the same place.
2. **Day Details as a word, or the title as a button.** A word in the bar is explicit; it costs room, so a long
   habit name ("Social media") sits close to it on the 360 frame (the 393 phone has room). The alternative is ⋯ with
   Day Details inside (version G), which hides it.
3. **A new text size for the clock.** The ring's clock is SF Pro Light 64, drawn without a text style (the file's
   "iOS/Custom/Clock" is Rounded Medium 36, used for the old clock). Say if it should become a style, and its name.

## Still open (other screens)

- The routine player's own card for a time habit still has the cookie and the wave (screen E); it should use the
  same Timer ring and Clock buttons.
- Today's notes about the backup card's "wavy line" (Today page, 149:391) describe Android's indicator; the iPhone
  shows work under way with its activity indicator (to fix with Today's leftovers).
