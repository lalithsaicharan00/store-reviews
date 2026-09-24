# Today screen (list view, default) — top-area research questions

Screen: Figma Ncccsm1l2O62GJ5xLSInqk, board 18:4 "Main · Today list" (screenshot: board-18-4.png).
Goal: understand the screen thoroughly and improve it, top to bottom. Start with everything above the first section header.
Method for each question: (1) the existing Research Reports, (2) a full-corpus screen of all reviews
(App Store, Play, Native), hand-reading the matches, (3) external UX sources (platform guidelines, NN/g, competitor apps).
Then write the report, then move to the next question. One report per question. Questions are merged only where genuinely the same.

What is on screen now, top to bottom:
- Row 1: large title "Today", then "Thu 24 Sep · 14:30"; overall progress ring "5/11"; round "+" (add habit)
- Row 2: 7-day date strip Fri 18 … Thu 24, each day a progress ring, today filled black
- Row 3: segmented control List | Week | Month | Year; "Now" button; grid button (list ⇄ cards density)
- Row 4: group chips All 5/11 · Health 57% · Mind 0% · Home …
- Then section headers (ANYTIME any time 1/3 [Start]) and habit rows

## Q1. The title row: "Today" heading, date and time
- The bottom tab already says "Today". Do users need a "Today" heading as well?
- Do they need "Thursday 24 September"? Do they need the time "14:30" (the phone status bar already shows it)?
- Is the positioning right, and how do we cut the clutter in the first row?

## Q2. The overall progress ring (5/11) vs today's ring in the date strip
- Today's cell in the date strip already has a progress ring. The header ring is the same ring with a number. Is that redundant?
- Do users want the ring, the number, or both? If both, how do we show them without clutter?
- Can overall progress be combined neatly with the date strip?

## Q3. The 7-day date strip
- Do users need a date strip with per-day progress at all?
- If yes: a fixed 7-day strip, or can they move around (swipe to earlier/later weeks, jump to a date)?
- Which days: the last 7 days ending today, or the calendar week (Mon–Sun), and can it show future days?

## Q4. Where the view switcher (List · Week · Month · Year) sits
- Picking Week changes the title above it from "Today" to "This week". UX rule (to verify): a tab or segmented
  control should change only the content below it. If it changes things above, it is in the wrong place.
- Verify this against UX guidelines. Where should the switcher go? Can the view choice be combined neatly with the title?

## Q5. What must be always visible vs on demand (group chips and the view switcher)
- Rule (to verify): controls used very often stay up front; controls used rarely should not take permanent space.
- Are the group chips (All · Health · Mind · Home) used often enough to be always visible?
- Same question for the List/Week/Month/Year switcher.
- Do we need to show all of these at once?

## Q6. The "Now" button
- What is it (its purpose), do users need it, and if yes where should it live?

## Q7. The list ⇄ cards (grid) button
- What is it (its purpose), do users need it on Home, and if yes where should it live?

## Q8. Where to edit day sections from Home
- Users can add sections, set start/end times, set when the day starts, reorder, and turn sections off.
- These must be reachable from Home. Where should the entry point be, and what should it look like?

## Q9. What to call the screen and the tab
- The tab is "Today", but the screen also shows Week, Month and Year views. Should it still be called "Today"? If not, what?

## Progress
(see NOTES.md)
