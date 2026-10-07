# Design Decisions — Day Details, Logs and Notes (7 October)

Written by Claude (Claude Code), 7 October 2026, from a design session with the user (first titled "Day Details, All
Logs, Add and Edit — Small Screens First"). **Start with this folder's [README](<README.md>)**: the pages to update,
the images, and how to build them. It records what was decided
and why, and the intended spacing, so the Figma file can hold designs only. Status: **accepted for building by the user
(7 Oct), not yet built**; the Rulebook changes in section 10 still need the user's explicit OK. Checklist: [Current Work items 59, 60, 61 and 62](<../../../../iOS/Docs/Checklists/Current Work Checklist.md>).

Figma:

- [Water, every screen, three iPhone sizes](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=727-2288)
  (Day details, All logs, Add log, Log, Edit log, Add note, Note, Edit note at SE, mini and 6.1-inch).
- [Every habit and task, one size](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=733-2288)
  (18 rows, 6.1-inch only: every kind and its variations, day states, notes, and the confirmation pop-ups; section 8).

Earlier explorations, kept for history:
[Day details v1 and v2](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=715-2286) and
[Add and Edit](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=722-2288).

The evidence is mostly the user's own review and first-principles reasoning (Research/CLAUDE.md, "never copy
competitors blindly"). No review study was run for these changes; where an Apple app is mentioned, it is a reference
for what feels native, not proof that it is right.

## Read this first: what these designs are, and what they are not

Any agent implementing these screens reads this section before opening Figma.

**1. Two sets, two levels of finish.** The **Water** section is the only one designed at all three sizes (SE, mini,
6.1-inch), with its spacing worked out. The **every-kind section** (section 8) shows every other kind of habit and
task, the day states and the confirmations at **one size only, the 6.1-inch**, for their layout and their words. Use
it for what each kind shows and says. Fit it to the smaller screens with the rules in sections 2 and 3, the way Water
was; don't copy its spacing.

**2. Layout, not pixels.** The frames show the **overall layout**: what is on each screen, in what order, what is
grouped together, and what matters most. They are not an exact specification. Their spacing, sizes and positions were
drawn by hand and are approximate. For example, the toolbar sits almost against the top edge of every frame; a real
sheet has its grabber area and the system's toolbar insets above it. Build with native components (`Form` / `List`
sections, toolbar items, the system button and text-field styles, Dynamic Type) and let them supply their own metrics.
Read the spacing numbers in this document as **relative intent**: which gaps are bigger than others, and roughly by
how much. Don't copy them as fixed values.

**3. Adapt to the screen's height.** Nothing here is fixed to one screen size. The layout adapts to the iPhone's height
and to the text size:

- **The note on Day details:** one line on the smallest screens (the SE), two lines when there is room, never more.
- **Logs on Day details:** with **three logs or fewer, show all of them, and no "All logs" row.** Only with four or
  more: the two newest, then "All N logs ›". Never an "All 3 logs" row that opens the same three logs.
- **Gaps** grow from their minimum toward their maximum as the sheet gets taller (section 3). Larger text uses the
  spare height first; past that, the sheet scrolls.
- **The note box on Add note** fills the room above the keyboard, whatever its size.
- **What never changes:** Skip today stays last and is never pinned; Delete stays last, in red text with no fill; the
  confirming button (Add, Save) is the only filled one in the toolbar.

**4. Check it at three sizes:** the iPhone SE, a mini and a 6.1-inch iPhone in the simulator, with the keyboard up where
a field is focused; then on the real iPhone (U9).

**5. Not approved yet.** Rulebook changes (U17, U18, U19, U22; listed in section 10) need the user's OK before
anything is built.

**6. Every point the user made is in the next section,** in order, with its reason and where it is designed. Check
the build against it. Where a decision went back and forth (the header and the habit: removed, added back, moved),
section 6's **decision log** gives each step, its reason and what replaced it; each screen's "Considered and not
chosen" list gives the options dropped and why.

## 0. The user's points, in one list

Everything the user asked for in the 7 October design session, in the order it was said. Each line gives the reason
and where the design or rule lives. "Superseded" marks a point a later one replaced.

**Day details**

1. Logs pushed the note and Skip today off the bottom of the sheet: fix the layout. → section 4.
2. Don't pin Skip to the bottom: skipping isn't an action to invite. → Skip stays last, plain (section 4, U15).
3. Design for the smallest screen first, the iPhone SE 4.7-inch, and make sure everything fits there. → section 2.
4. The two logging buttons in one row; the note merged into the This day card, one or two lines; Skip at the very
   bottom; it must feel native. → section 4.
5. Everything fits but looks squeezed: improve the spacing; the note may be one line on small screens. → section 3.
6. Spacing has a minimum and a maximum so it adapts to any screen; show the next size up (mini) and the 6.1-inch.
   → section 3; the Water section.
7. With three logs or fewer, show them all and no "All logs" row; only four or more get "All N logs ›". → section 4.
8. Design the All logs page. → section 5.

**Add and Edit**

9. The log screen (called "entry" in the app) doesn't show what matters most; Add and Edit share one mental model;
   the same Add everywhere it opens (Log manually on Day details, Add on History). → section 6.
10. Delete is red text only, never a red background. → sections 6, 7.
11. The amount is the main highlight. → the 48 pt number card (section 6).
12. The date matters: today by default ("Today, 7 Oct" chosen); from History, the day must be clear and choosable.
    → the Date row (section 6).
13. Typing is the main way in, not − / + (people come to Add to type an exact amount). → section 6.
14. Not squeezed; a smaller number; the unit mustn't move while typing; drop the "4 → 6 of 8 glasses" line.
    → section 6.
15. **The time of a log** matters, above all for a past day (today's app stamps a past day's log with today's clock
    time). Check reviews; add it for every kind if it's needed. → yes: section 8, "The time of a log".
16. Don't let a time habit's duration be confused with the log's time. → HOW LONG and Finished at (section 8).
17. "Cancel" is too big. → an icon-only ✕ (section 8).
18. The main button at the bottom, above the keyboard: read top to bottom, act where the thumb is. → section 8.
19. Once a log exists its jobs are view, edit or delete; no greyed-out Save. → the View state (section 6).
20. An explicit **Edit** button beside **Delete** in that bottom place; tapping Edit opens the keyboard. → section 6.
    (Superseded Claude's "tap the value to edit" proposal.)
21. The screen a row opens is for viewing: call it "Log", not "Edit log"; "Edit log" only in edit mode; the same
    view-then-edit step wherever one record opens (a log, a time session, a slip, a note). → sections 6, 7 and row 14.

**Notes**

22. Notes have the same problems: Add note needs a date (from the habit page, which day is it for?); typing first;
    view, edit and delete; the same mental model as logs. → section 7.
23. Is the reader's "View Day" really needed? Keep it if so. → kept, folded into the date line (section 7).
24. Design notes at one size first, then the others. → section 7.

**Every kind of habit and task**

25. One new section at the largest size only (6.1-inch), every kind and its variations, tasks too, one row each.
    → section 8; the every-kind Figma section.
26. Add the delete confirmation pop-ups, just a pop-up. → row 18.
27. **Button words must scale:** never written for one habit; a unit may or may not exist; a check counted several
    times is a check. → the rule table (section 8).
28. Amount quick button "+20", not "Add 20 glasses" (as Today's round button). → section 8.
29. Currency before the number: check the app, record the rule, don't break amounts elsewhere. → "Amounts are written
    one way everywhere" (section 8).
30. Once-a-day check from History: "THIS DAY · Done" was confusing. → Mark a day done (row 8; see 43).
31. Checks are recorded one at a time; adding or editing several at once is wrong. → Add a check, one at a time, no
    multi-check editor (section 8, "Checks are recorded one at a time").
32. No Discard changes pop-up in the design: the app already asks when leaving with changes. → removed; confirmations
    are for deleting only.

**How to work and document**

33. Figma holds designs only; decisions, numbers and reasons go in this document. → this document.
34. The frames are the overall layout, not exact spacing (their toolbar almost touches the top); build native and
    adaptive. → "Read this first", point 2.
35. Document every important point with its reasoning, so whoever builds it forgets nothing. → this section.

**Notes, later the same day**

36. On a note screen the habit card is redundant: you only get there from that habit's Day details or page. Note is
    a note, whether adding, viewing or editing. → no habit card (section 7).
37. Keep the date, inline rather than in a card, the same on every note screen; research it and change it if the
    research agrees. → one date line; the research agreed (section 7).
38. On Add log and the other record screens, are the habit's icon, name and plan needed at all, or should the screen
    be just the task? → the card goes; the name stays as a small subtitle under the title, because Add log also opens
    from a widget and from Today, and notes from Today and the routine player, where the habit isn't on screen
    (section 6). This corrected point 36's "only from Day details or the habit page". *Superseded by 41.*
39. Put the habit's icon with its name in the header, with the screen's name, so the habit is recognised at a glance;
    cut a long name with "…". → a study on one screen first (Water section, beside row 3). *Superseded by 40, 41.*
40. **Two lines in the header are not good.** → the study is one line: **[icon] Water · Add log** (habit name
    semibold, the job lighter; a long name ends in "…", the job stays whole). Once approved it replaces the two-line
    "Add log / Water" title (section 6) on every record screen. *Superseded by 41: the header stayed plain.*
41. Do we need the name and icon at all? → yes (Claude's view, 7 Oct): Add log also opens from a widget and from
    Today, notes from Today and the routine player, with the habit not on screen, and a log on the wrong habit is a
    silent mistake. Then the user, looking at today's Add Entry (it opens with a "Read pages · 0/20 pages" row): keep
    the header plain and put the habit **as a row in the Date and Time card**. → study: header **Add log**; rows
    **Habit · [icon] Water**, **Date**, **Time**. Native (labelled rows in one card, as Reminders' List row) and the
    same on every screen; one row, about 50 pt; it fits with the keyboard up. Waiting for the user's decision before
    it goes on every record screen. → **Approved and applied (the user, 7 Oct: "update it everywhere")** to all 39
    record screens in both sections; the two-line titles are gone.
42. Create the missing screens for every kind, so each can be checked. → done: Edit for no-unit amounts; Log and
    Edit for the month goal with a currency and for the limit; Add, Log and Edit for a time week goal; Add for every
    check kind and the checklist. Every row in the every-kind section now has every screen its kind has.
43. Checks broke the mental model: only they opened on a calendar, while every other Add (even Add slip) has the date
    behind a compact picker. Make them consistent; make them clear with words, not a different layout. → **Add a
    check** and **Mark a day done** (and **Tick steps** for a checklist) are the same shape as every Add: one card
    (Habit, Date, Time), a footer saying exactly what will happen ("Marks Tue 6 Oct as done at 9:40 PM"), the button
    at the bottom; nothing to type, so no keyboard. Add slip already had this shape.

## 1. The problem that started it

Tapping a habit or task row on Today opens **Day details**. Each log added a two-line row under "Today's logs", so two
or three logs pushed the note and **Skip today** below the bottom of the sheet. Skip must not be pinned to the bottom
of the screen: skipping is not an action to invite (the user). U15 keeps Skip and Undo skip in one place.

## 2. Design for the smallest screen first

The app supports iOS 18 and later (`IPHONEOS_DEPLOYMENT_TARGET = 18.0`), so the smallest screen it runs on is the
**iPhone SE (4.7-inch)**. Every screen is designed there first, then on the next size up, then on a 6.1-inch iPhone.
If it fits and looks right on the SE, it fits everywhere.

A full-height (large) sheet is about this tall. These are estimates (the screen's height, less the top safe area and
the gap above the sheet); confirm them in the simulator.

| iPhone | Screen | Large sheet | Bottom strip (home indicator) | Usable above the strip |
|---|---|---|---|---|
| SE (2nd and 3rd gen), 4.7-inch | 375 × 667 | 375 × 637 | none | 637 |
| 12 mini, 13 mini, 5.4-inch | 375 × 812 | 375 × 752 | 34 | 718 |
| 16, 17 (and 13–15, 16e), 6.1-inch | 393 × 852 | 393 × 783 | 34 | 749 |
| Plus and Pro Max | 430–440 × 932–956 | about 863–887 | 34 | about 830–850 |

The number keyboard (decimal pad) is **216 pt** on the SE and about **291 pt** on iPhones with a home indicator
(its keys plus the strip under them).

**Why v1 was dropped:** the first proposal only limited the logs and was drawn at 6.1-inch size. Skip ended at
763 pt: behind the home indicator on a 6.1-inch phone, cut off on a mini, and the note and Skip were both off screen on
the SE. A limit on the logs is not enough while the logs come before the note and Skip.

## 3. Spacing: a minimum and a maximum

Spacing grows with the screen, between a **minimum** (the SE) and a **maximum** (the mini and every taller iPhone).
Related things stay close; different jobs get more space (U17).

**These numbers are relative guidance, not exact values** (see "Read this first", point 2). They are what the Figma
frames were drawn with. What matters is the pattern: gaps inside one job are small, gaps between jobs are larger, the
gap before Skip or Delete is the largest, and all of them grow on taller screens up to a limit. Native sections and
controls bring their own insets; tune the gaps against them on the simulator at the three sizes.

**How it adapts.** Start at the minimum. When the sheet has spare height, every gap grows toward its maximum by the
same share of its range, never past it; then the note gets its second line. On taller iPhones whatever is left stays
below the last control: the content sits at the top, as iPhone sheets do, and nothing is stretched to push Skip to the
bottom. Larger text uses up the spare height first, so the gaps go back toward the minimum; past that the sheet
scrolls. Work out one share (0 to 1) when the sheet's height or the text size changes, from the sheet's height and the
content's height at minimum spacing; never per row or per redraw (S6, S8).

**Why a maximum:** past these values the groups drift apart and a sheet stops reading as one thing (reasoned, not
measured; check on the iPhone, U9).

### Day details

| Gap or padding | Min (SE) | Max |
|---|---|---|
| Toolbar → habit | 14 | 18 |
| Habit → This day | 24 | 32 |
| This day → its logs | 20 | 28 |
| Logs → Skip today | 28 | 36 |
| Habit row, top and bottom | 12 | 14 |
| This day card, top and bottom | 14 | 16 |
| Status → its buttons | 14 | 18 |
| Note, top and bottom | 12 | 14 |
| Note lines | 1 | 2 |

### All logs

| Gap | Min (SE) | Max |
|---|---|---|
| Toolbar → list header | 20 | 28 |

### Add log and Edit log

| Gap or padding | Min (SE) | Max |
|---|---|---|
| Toolbar → habit | 16 | 18 |
| Habit card → AMOUNT header | 28 | 32 |
| Amount card, top / bottom | 24 / 22 | 28 / 26 |
| Footer → Delete this log (Edit) | 28 | 36 |

**Never change, on any screen:** 16 side margins; 8 between two side-by-side buttons; 8 from a section heading to its
rows; 8 from a card to its footer; 2 from the THIS DAY label to the count; rows and buttons 44 pt; cards 16 corner
radius.

**Measured in the Figma frames (Water, 4 logs, a note):**

| Screen | SE (min) | mini (max) | 6.1-inch (max) |
|---|---|---|---|
| Day details: Skip ends at | 611 of 637 | 675 of 752 (strip at 718) | 675 of 783 (strip at 749) |
| Add log, keyboard up: content ends / Add button starts / keyboard starts | 337 / 363 / 421 | 395 / 403 / 461 | 421 / 434 / 492 |
| Log (view): content ends / Delete \| Edit start | 435 / 579 | 445 / 660 | 445 / 691 |
| Edit log (edit mode), keyboard up: content ends / Save starts | 337 / 363 | 397 / 403 | 397 / 434 |
| Add note, keyboard up: note box / Save starts | 203 / 319 | 242 / 358 | 273 / 389 |
| Edit note, keyboard up: note box / Save starts | 203 / 319 | 242 / 358 | 273 / 389 |

All logs with 4 logs ends well short of every size; a long list scrolls.

**While the keyboard is up, room is tight** (the button rides above the keyboard): the footer hides wherever it would
reach the button (the SE and the mini; the 6.1-inch keeps it on Add log); on the SE, Date and Time share one row
("7 Oct 2026" "2:15 PM", no "Today" word); a note's text box fills exactly the room left above the button and scrolls
inside (that is why the mini's box is smaller than the 6.1-inch's: the same 336 pt keyboard on a 31 pt shorter sheet).

## 4. Day details

Order, top to bottom:

1. **Toolbar:** ⋯ menu, the day ("Today"), Close (`xmark`), each 44 pt (U18).
2. **The habit:** icon, name, plan; opens the habit page (a task has none).
3. **This day:** one card holding the day's status ("4 of 8 glasses", "4 glasses to go"), the logging buttons, and the
   day's note.
   - **The two logging buttons share one row:** +1 | Log manually (the quick button as on Today: + and the step,
     section 8), the same size, style showing which one is
     suggested (U16). "Log amount manually" becomes "Log manually". A timed habit: Start timer | Log manually. A single
     check: one Mark done across the row. At the largest text sizes the two stack (chosen from the text size, not
     `ViewThatFits`, S10).
   - **The note is in this card**, under a thin line: the label NOTE, then the note's text on one line (two when there
     is room), ending in "…". A tap opens the note editor, as now. With no note: "Add a note…".
4. **Today's logs:** at most three rows. Up to three logs show as they are; four or more show the two newest, then
   "All N logs ›". One line per log: the amount, then the time on the right. Where a log came from (Manual log, Quick
   add) moves into the log's editor.
5. **Skip today:** last, a plain bordered button, not pinned; it becomes Undo skip in the same place (U15).

**Considered and not chosen:**

- *Pinning Skip to the bottom:* invites skipping (the user).
- *Three buttons in one row with Skip:* makes Skip an equal choice beside logging, and three labels don't fit 343 pt on
  the SE at the default text size. Apple's Health app does put Taken and Skipped side by side for medications; that is
  noted, not followed, for this reason.
- *Moving the logs to the end, after Skip:* fits every phone but separates the logs from the buttons that make them.
  The three-row limit plus the merged note fits instead.

**Rule changes this needs (the user's OK):** the note moves into the day's card, above the logs. That changes U17 and
"Why the note is below day activity" in [The Habit Day Sheet](<../Day Details and Entry Editor Handoff/The Habit Day Sheet — Wording, Hierarchy and Actions.md>).

## 5. All logs

Opens from "All N logs ›", pushed inside the same sheet.

- **Toolbar:** the back chevron only (no title on it, as on Edit log) and the page title. No Close.
- **Title:** the heading Day details uses: "Today's logs", "Checks today", "Slips today"; on an earlier day "Logs for
  Sat 4 Oct" (`DayActivity.logsTitle`).
- **The list:** every log of that day, newest first, one line each, as on Day details. Header: the habit and the count
  ("WATER · 4 LOGS"). Footer: the total and what a tap does ("4 glasses in all. Tap a log to see, change or delete
  it.").
- A tap opens the log's view, **Log** (section 6), with Delete | Edit. A check counted several times a day keeps its row's own Undo button instead, as on Day
  details (U19). After saving or deleting, the list updates; with no logs left it goes back to Day details.
- **Left out on purpose:** no swipe to delete (U14); no add button (logging stays on Day details); no Close.

## 6. Add log and Edit log

One screen, the same order in every state. Drawn first for an amount habit; every other kind is in section 8.

**Where they open.** Add log: "Log manually" on Day details, and Add on History. **Log** (the view): any log row (Day
details, All logs); its **Edit** button opens **Edit log**. People reach Add to type an exact amount: the one-tap
quick button is already on Day details.

Order:

**Three states of one screen: Add, View, Edit** (the user, 7 Oct). Adding is one job; once a log exists its jobs are
to **look at it**, **change it** or **delete it**, so the screen a log row opens is for **viewing** first, and changing
it is a deliberate step.

| | **Add log** | **Log** (view, from a log row) | **Edit log** (after tapping Edit) |
|---|---|---|---|
| Toolbar | ✕ \| Add log | ‹ \| Log | ✕ \| Edit log (✕ leaves edit mode; asks first if anything changed) |
| Habit | [icon] Water, first row of the card | the same | the same |
| Date | "Today" + date picker | shown, fixed ("Today, 7 Oct") | shown, fixed (a log can't move days yet, D7, U19) |
| Time | time picker (now by default) | shown ("11:20 AM") | time picker, within the same day |
| AMOUNT | the number field, focused, keyboard up | the number, large, not a field | the number field, focused (number selected, so typing replaces it), keyboard up |
| Footer | "Adds a new log. Other logs stay as they are." | "Logged with Log manually." (where it came from) | hidden while typing |
| Bottom | **Add** (filled; off until there's a number), above the keyboard | **Delete log** \| **Edit**, side by side | **Save** (filled, always on), above the keyboard |

Order on every state, top to bottom:

1. **Toolbar** (above): **one line, the screen's job only** ("Add log", "Log", "Edit log"); nothing on the right (the
   main button lives at the bottom, section 8). Never a second line under the title (the user, 7 Oct: "two lines in
   the header is not good").
2. **The habit, the date and the time, one card:** **Habit** · [icon] Water (shown, not changeable here; no chevron),
   then **Date** (Add: "Today" in words beside the native compact date picker), then **Time** (section 8, "The time of
   a log"). Opened from a day, that day is already chosen; from History's Add, today. Any day from the habit's start
   to today, never a future day. On the SE with the keyboard up, Date and Time share one row under Habit.

**Decision log: the header and the habit on the record screens** (7 October, in the order it happened). Each step
says what the screen had, why it changed, and what replaced it. Read it before changing either.

| # | What the screen had | Why it changed (who) | What replaced it |
|---|---|---|---|
| 1 | **Today's app:** toolbar Cancel \| Add Entry \| Add; a first card row "Read pages · 0/20 pages" (habit and progress), then Date | The user didn't like Add / Edit Entry: the order didn't match what matters | The first designs (section 6) |
| 2 | **4 Oct study and our first designs:** a **habit card** at the top (icon, name, plan "8 glasses a day"), then a Date row, then the amount; Cancel \| Add log \| Add in the toolbar | Kept from the Day details layout, for one mental model | (still in use until steps 4–6) |
| 3 | **Toolbar:** text "Cancel" left, "Add" / "Save" right | The user: "Cancel is very huge"; the main button is easier to reach and read at the bottom, above the keyboard | **✕** (accessible name Cancel) left; **one filled button at the bottom** (Add / Save / Mark done / Add a check); nothing on the right (section 8) |
| 4 | **Notes: the habit card** above the date | The user: it's redundant, the habit is behind the note; research: room to write is the editor's top complaint (the card, heading and footer took ~170 pt) | No habit card; one inline date line; the box doubled (section 7) |
| 5 | **Logs: the habit card** | The user asked whether the icon, name and plan are needed at all. Claude checked the entry points: Add log also opens **straight from a widget** and **from a Today row**, notes **from Today and the routine player**, where the habit isn't on screen; a log on the wrong habit is a silent mistake. So: not nothing | Card removed; the **name as a small subtitle** under the title ("Add log / Water"). This also corrected step 4's "only from Day details or the habit page" |
| 6 | **Subtitle "Add log / Water"** | The user wanted the icon too, for recognition | Study: **[icon] Water** with "Add log" under it |
| 7 | **[icon] Water / Add log** (two lines) | The user: **"two lines in the header is not good"** | Study: **[icon] Water · Add log** on one line, a long name ending in "…" |
| 8 | **[icon] Water · Add log** | The user asked whether name and icon are needed at all; Claude: yes (step 5's entry points). The user then, looking at today's Add Entry (step 1's "Read pages" row): keep the header plain, put the habit beside Date and Time | **Header: "Add log" only.** **Habit · [icon] Water** as the first row of the Date-and-Time card; on notes, the habit at the start of the one-line date row. Approved and applied to all 39 record screens: "update it everywhere" |

**Where it ended, and why it holds:** the header is one line and says only the screen's job (Add log, Log, Edit log,
Add note, Note, Edit note, Add a check, Mark a day done, Tick steps). The habit is always on screen, because some
entry points show nothing else, but as an ordinary labelled row (Habit · [icon] name) in the card that already holds
Date and Time, which is how today's app and native iPhone forms show context (Reminders' List row). The icon and the
plan never come back as a separate card: they don't help anyone type a number and cost the screen's space. Day
details keeps its own habit row, which there is the link to the habit's page.

3. **AMOUNT, the main thing.** A section header, then one card: the number centred at 48 pt, the unit under it. The
   unit never moves as digits are typed; only "glass" / "glasses" changes. Decimal pad, up to two decimals.
4. **Footer** (above).
5. **The bottom place** (above): the one place for the screen's actions, reachable by the thumb. On View it holds
   **Delete log** (plain, red text, no red fill, asking first: Cancel / Delete Log, U19) and **Edit** (filled), side by
   side; there is no Delete row in the content any more.

**Why View first, and an explicit Edit button** (the user, 7 Oct): people open a log to see it as often as to change
it, and "tap the number to edit" isn't obvious enough; an Edit button says plainly what will happen. Calling the view
"Edit log" was wrong for someone who only looks, so the title is **Log** until Edit is tapped. A greyed-out Save
sitting on screen had no job: Save exists only in edit mode, and there it is always on (saving with no change simply
returns to the view).

**Delete beside Edit.** A destructive button next to the everyday one invites mistaken taps (deleting too easily is a
known complaint, 79 reviews, U14's evidence). The user chose the pair; it stays safe because Delete is plain red text,
not filled, on the left, and always asks first. If the iPhone check shows mistaken taps, give the pair more space
before moving Delete back into the content.

**Considered and not chosen:**

- *− and + buttons around the number* (as Apple's Fitness app sets a goal): typing is the job here (the user).
- *The keyboard starting closed:* same reason.
- *The unit beside the number:* it slid sideways with every digit.
- *A "Today: 4 → 6 of 8 glasses" line:* a sum to check that doesn't help the one job; Day details shows the total as
  soon as the log is saved.
- *A field inside a card, with a label and a day line:* looked squeezed; the card is now the field.
- *Three read-only rows (day, time, source) on Edit:* pushed the amount down and outranked it. (The view now shows
  Date and Time as two short rows in the habit card, and the source in the footer.)
- *Tap the value to edit, no Edit button, Save appearing only after a change* (Claude's proposal, 7 Oct): one tap
  fewer and no mode, but the user found it not obvious; the explicit Edit button won.
- *A disabled Save on the edit screen:* a button with no job (the user, 7 Oct).

**Rule changes this needs (the user's OK):** U22's "accepted controls" (a small field with the unit beside it) become
this number card. Today the app has two adding screens, Add Entry (`AddEntryView`) and Log Amount / Log Time
(`LogProgressView`, also used by the timer screen and the routine player); the time habit's design decides how the
second one joins.

## 7. Notes: Add note and Note

The same mental model as logs: **Add note** is Add log's shape; **Note** (view) and **Edit note** (edit mode) are
Log's and Edit log's. Water section rows 6–8, at all three sizes; every-kind section row 17.

Today the app has three note screens: a quick editor from Today, Day details and the routine player (`NoteSheet`), a
second editor from the habit page (`NoteEditorView`, with a date picker), and a reader (`NoteReaderView`, with Edit,
View Day and Delete Note). These two screens replace all three.

**Where they open.** Add note: "Add a note…" on Day details (that day chosen), and Add note on the Notes tab (today,
changeable). Note: a note on the Notes tab, and a saved note on Day details (pushed in the sheet, as Edit log is).

**No habit card on a note screen** (the user, 7 Oct). When a note is reached from that habit's Day details or that
habit's page, the habit is already on screen behind it, so a card repeating it was redundant. What a note screen needs
is the date and room to write. **Correction, same day:** notes also open from Today (the swipe's Note, the long-press
menu, the "Add Note" offer after logging, `TodayView.noteSheet`) and from the routine player, where the habit isn't
necessarily visible; so the habit came back, first as a subtitle under the title, then (the final decision, section
6's decision log, step 8) as **[icon] name at the start of the one-line date row**. Three things point the same way on
the rest:

- **Room to write is the editor's top complaint.** In [Habit Notes and Day Notes](<../Habit Notes and Day Notes — What People Ask For.md>),
  the keyboard hiding the text or a cramped box was the most common editor complaint (5 reviews, mean 3.40★): "the
  keyboard hides the note section so you can't see what you're typing" (`1386531056`). The habit card, the NOTE
  heading and the footer took about 170 pt from the box.
- **The date matters:** notes "should track dates" (`5da8bac2-8cd5-4546-b9b6-7984fbcb25ac`) and be findable by day
  (`8114041656`). It stays, as one line.
- **Apple's Notes app** shows only a small date line above the text: no card, no heading (a reference for what feels
  native, not proof).

**Every note screen, top to bottom** (Add note, Note, Edit note):

1. **Toolbar:** ✕ | Add note; ‹ | Note; ✕ | Edit note. One line.
2. **One line with the habit and the date, no card,** in the same place on every state: **[icon] Water** at the start,
   the date at the end (a spacer between; the habit's name ends in "…" if the line runs out of room):
   - Add note from the **Notes tab**: "Today" in words, a native compact date picker (any day from the habit's
     start to today). If that day already has a note, the box fills with it and the date line says so ("Tue 6 Oct
     already has a note; you're changing it", as now, U5).
   - Add note from **Day details**: the day as plain text ("Today, 7 Oct"); it was chosen by opening that day.
   - **Note** (view), from the Notes tab: "Sun, 4 Oct · 6 of 8 glasses ›", which opens that day's Day details (the
     reader's "View Day", kept). From Day details: the date only.
   - **Edit note:** the date only; a note's day doesn't change.
3. **The note itself, the whole rest of the screen.** No NOTE heading, no footer. Add / Edit: a text box filling the
   room down to Save, scrolling inside as the note grows; view: the full text.
4. **Bottom:** Add: **Save** above the keyboard (off until something is written). View: **Delete note** (plain, red
   text, asking first) | **Edit**. Edit: **Save**, always on. Saving an empty note also removes it, as today.

**The note box with the keyboard up:** **203 pt** on the SE, **242** on the mini, **273** on the 6.1-inch (before
this change: 91, 96, 127).

**Note** (view) and **Edit note** are the same three states as a log (section 6): ‹ → view; Edit → edit mode, ✕
leaves it (asking first if anything changed). A note has no time of its own: it belongs to the day.

**"View Day": kept, folded into the date line.** A note is a reflection on a day, so "how did that day go?" is the
natural next question, and the History tab is several taps away. As part of the date line it costs no extra row and
shows the answer before the tap. Reasoned from first principles; no review evidence was looked for.

**Considered and not chosen:**

- *Today's reader and editor as two separate screens:* a third screen to learn. The view and edit are now one screen
  in two states, with an explicit Edit button (the user, 7 Oct), the same as a log.
- *A separate "View Day" / "Open day details" row* (today and the 4 Oct study): an extra row for what the date line can
  carry.
- *Delete inside the editor only:* the person reading a note couldn't delete it without first "editing" it.

## 8. Every kind of habit and task (6.1-inch)

The user asked for every kind of habit and task, with its variations, at one size (the largest, 6.1-inch), plus the
missing confirmation pop-ups. The button words had to scale: one rule per kind, never words written for one habit,
because a habit may or may not have a unit, a check habit counted several times a day is a check whatever else it
says, and a once-a-day check is different again. The rules below come from the app's own code (`DayActivity.makeActions`,
`makeStatus`, `HabitStore.countsUp`, `canSkip`, `isTotal`) and keep its decisions, except where noted.

### Button words: one rule per kind

| Kind | Day details buttons (left one is the suggested step) | Add / Edit screen | Skip? |
|---|---|---|---|
| Amount with a quick step | **+{step}** \| Log manually ("+1", "+20", "+250", "+1k"): Today's own button text (`"+" + Format.amount(step)`), never the unit or currency, so a long unit can't make it long; VoiceOver says the whole thing ("Add 1 glass") | Add log / Edit log, AMOUNT | Daily goal: yes |
| Amount, no quick step | **Log amount** (one button) | Add log / Edit log, AMOUNT | Daily goal: yes |
| Time, today | **Start timer** \| Log manually | Add log / Edit log, HOW LONG (hours, min, sec); clock row "Finished at" | Daily goal: yes |
| Time, timer running | **Stop and save** \| Log manually; the clock in the status line | | yes |
| Time, an earlier day | **Log time** (one button; no timer on other days) | | Skip this day |
| Check, once a day; Check, N days a week | **Mark done**, then **Undo done** (bordered) | No Edit (U19). History's Add: **Mark a day done** (Habit, Date, Time; **Mark done**) | yes |
| Check counted (several a day, or N a week / month / year) | **Add a check**, always, whatever unit the habit has; one check per tap | No Edit: each check has its own Undo. History's Add: **Add a check** (Habit, Date, Time; **Add**, one check) | Several a day: yes |
| Checklist | No button: the steps are the controls, inside This day | None | yes |
| A limit (amount or time) | The same words, **both bordered**: reaching a limit is never the suggested step (U16) | As for its kind | no |
| Quit | **Record a slip**, then **Record another slip** (bordered, never prominent) | Add slip / Edit slip, WHEN IT HAPPENED | no |
| Task | **Mark done**, then **Undo done**; a Reschedule group (Do tomorrow, Another day…) until done | None | no |
| Any habit, paused | **Resume habit** \| Log manually | | no |
| Any habit, skipped | The usual buttons in place, turned off; Skip becomes **Undo skip** in the same place (U15) | | Undo skip |

A week, month or year **total** (amount or time) and every limit have no Skip (`canSkip`). The "All logs" link uses
the list's own noun: **All N logs**, **All N checks**, **All N slips**.

### Rule: amounts are written one way everywhere

Every amount in these screens is written by the app's own `HabitCopy.amount`, as on Today, Progress, History and the
widgets: **the unit after the number** ("2 glasses", "250 ml", "1 glass"; no unit: "40"), **except the four currency
symbols, which go before it** (`HabitCopy.currencies`: **$ € £ ₹**, "₹120 of ₹200"). Don't invent another format for
one screen's convenience (the user, 7 Oct: "we shouldn't break things"). The two places that show no unit, on purpose,
are the quick button ("+20") and the big typed number on Add / Edit log, where the unit sits on its own line under the
number (and a currency symbol stays before the digits: "£15").

### Checks are recorded one at a time

The user, 7 Oct: "the whole point of check is checking it individually, one at a time". Today, Day details and the
widgets already add **one check per tap**, each its own log with its own Undo. The one exception in today's app is
**History's Add Entry, whose Times stepper (1–99) saves several checks as one log**, which then opens an editor for
its count (U19's "multi-check record"). This proposal removes that: History's Add on a check habit opens **Add a check** (or **Mark a day done**) and adds **one** check (or marks the day done). Logs of several checks saved before keep working (shown as
"2 checks" and still correctable), so nothing already saved breaks. Approving it changes U19's multi-check line.

### Confirmations are for deleting only

Leaving Add / Edit with changes already asks in the app (Discard Changes / Keep Editing, U19); that stays as it is and
isn't redrawn here. The pop-ups in row 18 are only the delete confirmations.

### The time of a log

**The problem (the user, 7 Oct).** A log has a time as well as a day, but Add / Log manually never shows it. In
today's app every log except a slip is saved with the moment it was entered (`HabitStore.log` creates
`Entry(…)` with `createdAt = now`; only `slip(at:)` takes a time). So a glass added for Tuesday from History on
Wednesday evening reads "9:40 PM" on Tuesday's list, at a moment that never happened on that day; the earlier one-log
study already noted that a backfilled log's `createdAt` "may be later than the tracked day".

**What reviews show.** A keyword scan of all 337,331 App Store reviews in the corpus (74 apps; English phrases such as
"timestamp", "change the time", "what time I", "wrong time"), narrowed to 120 reviews that mention logging, every one
read by hand. Most were about reminder times or when the day starts and don't count here. Limited evidence, but one
way:

- **Want each log's time kept and visible** (8 reviews, 7 apps): "would love if it time stamped more. I'm having to
  write in memo to track what time I get stuff done" (`11626304337`); see "at what time was my last entry of drinking
  water" (`10347808361`); "I'd love time stamps on entries" (`8342702542`); "know what time I marked my habit
  complete" (`1534536904`); "time stamp when you marked off your goals" (`3160695494`); "record the time of each task
  when completed" (`10823972903`); "data export doesn't include timestamps, only dates" (`11255085120`); praise for
  looking back "at what time I took it the previous day" (`2859734300`).
- **Want to set or correct the time, above all when logging late** (3 reviews, 3 apps): "if I go to the gym at 6 PM
  but only check it off at 9 PM, I'd like to set the completion time to 6 PM" (`14053501855`); "edit the time stamp
  for each log" (`3669117808`); "entering the exact time for meditating" (`6071252362`).
- **Quit: set a slip or start in the past** (5 reviews, all one quit app): `8913462962`, `13112109276`,
  `5492378192`, `6515966512`, `13287995208`. The app already has this for slips.
- **A warning:** a day worked out from a timestamp broke a 600-day streak across time zones (`9998476908`, 1★). The
  app stores the day itself (D7); keep it that way. The time only orders and describes the log.

The scan and the reading list are in `Research/Temp/log-time/` (not in git).

**Decision: yes, every log gets a Time.** Add log, Add slip, Add a check and Mark a day done show **Date** and **Time**;
Edit log and Edit slip let the time change within the log's own day (the day itself stays fixed until a log can move
days safely, D7, U19). Rules for whoever builds it:

- **Default:** today, now. Another day: the same clock time on that day (a native date-and-time picker keeps the time
  when the date changes), shown so it's easy to change.
- **Bounds:** within the chosen day as the app counts it (`store.dayBounds`, so a 3 AM day start allows 1:30 AM "the
  next morning"), never later than now: the same bounds Edit slip already uses.
- **The day stays the chosen day**; the time never moves a log to another day.
- `HabitStore.editEntry` changes a timestamp only for slips today; it needs the same same-day rule for every log.

**No confusion on time habits.** The duration is **HOW LONG** (hours, min, sec), never "Time"; the clock row is
**Finished at**, since a saved timer session is stamped when it stops. Amounts and checks say **Time**.

**A small screen.** On the SE with the keyboard up there isn't room for two rows: Date and Time share one row, two
pickers side by side ("7 Oct 2026" "2:15 PM"), and the footer hides while typing.

### The toolbar and the main button

- **✕ instead of "Cancel"** on Add log, Add slip, Add note, Add a check, Mark a day done and Tick steps: an icon-only close control in a 44 pt
  target, accessible name "Cancel" (iOS 26 shows a cancel action this way). With something typed it still asks first
  (Discard Changes / Keep Editing, as now). Edit screens keep their back chevron.
- **The main button moves to the bottom** (the user, 7 Oct): one full-width filled button, riding just above the
  keyboard, or above the home indicator when there's no keyboard: **Add**, **Mark done**, **Add a check**, and
  **Save** in edit mode. People read the screen top to bottom and act where their thumb is; nothing else on the screen
  is filled. The toolbar keeps only ✕ or ‹ and the title.
- **Viewing a record (Log, Slip, Note):** the bottom place holds **Delete** | **Edit** instead (section 6). There is
  never a greyed-out Save on screen.
- **Rule change:** U18 says editors keep text Cancel / Save / Done in the toolbar; this moves Save / Add to the bottom
  and Cancel to ✕. Needs the user's OK.
- **Fit at 6.1-inch, keyboard up:** the content ends at 399–421 pt and the button starts at 434 (Add log, all kinds);
  Add note's box is 128 pt so it ends at 382, above its button at 389.

**Changes from today's app words, for the user to confirm:**

- **Check habits always say "Add a check".** Today a check habit with a unit says "Add 1 glass" (`checkUnit`); the
  user: a check counted several times a day "will be a check no matter what". The unit stays in the status line
  ("2 of 3 times", "2 of 8 glasses").
- **"Log amount manually" / "Log time manually" become "Log manually"** when they share the row with a quick button
  (they must fit half the width on an SE); **"Log amount" / "Log time"** when they're the only button.
- **"Pause timer and save time" becomes "Stop and save"** (half the width again); the status line shows the running
  clock.
- **Amount quick buttons say "+1", "+20"** (the user, 7 Oct), as Today's round button already does; today's Day sheet
  says "Add 1 glass". Water's button becomes "+1" in every frame.
- **History's Add on a check habit:** Add a check (one check, no Times stepper) or Mark a day done, the same shape as every Add (above).

### What each kind shows (the 18 rows)

1. **Amount, daily goal** (Water): the full set: Day details, All logs, Add log, Edit log.
2. **Amount, no unit, week goal** (Push-ups, 300 a week, step 20): "40 today", "160 of 300 this week"; +20; no
   unit line under the typed number; no Skip.
3. **Amount, no quick step, month goal, a currency** (Savings, £200 a month): one button, Log amount; "£15" typed.
4. **Amount, a limit** (Coffee, at most 2 cups): "1 cup today", "Limit 2 cups · within limit"; +1 | Log manually, both
   bordered;
   Add log's footer "Records what happened. Your limit stays the same." Nothing red, no "over" wording (U3).
5. **Time, daily goal** (Read, 20 min): sessions as logs ("3 min · 1:30 PM"); Add log types hours, minutes and
   seconds in three big fields, the number pad up, the focused field lighter; Edit log the same, keyboard down.
6. **Time, timer running; an earlier day:** Stop and save | Log manually, "Timer running · 3:12"; Yesterday: "25 of 20
   min", "Goal reached", one button Log time, "LOGS FOR TUE 6 OCT", Skip this day.
7. **Time, week goal** (Exercise, 2 h 30 min a week): "30 min today", the week as context, no Skip.
8. **Check, once a day** (Take vitamins): Not done → Mark done; Done, "Checked at 8:42 AM" → Undo done. History's
   Add: **Mark a day done**, the same shape as every Add (✕ | Mark a day done; one card: Habit · [icon] Take
   vitamins, Date · Yesterday [6 Oct 2026], Time [9:40 PM]); footer "Marks Tue 6 Oct as done at 9:40 PM. If that day
   is already done, it says so here and Mark done is off."; **Mark done** at the bottom. Nothing to type, so no
   keyboard. (Replaced, in turn, the 7 Oct "THIS DAY · Done" card and a calendar-first "Choose a day" screen.)
9. **Check, several times a day** (Stretch breaks, 3 a day): "4 of 3 times", "Goal reached"; Add a check, one per tap;
   each check a row with its own **Undo** (no editor, U19); "CHECKS TODAY", "All 4 checks". History's Add: **Add a check**,
   the same card (Habit, Date, Time); footer "Adds one check to Tue 6 Oct at 9:40 PM. Checks already there stay.";
   **Add** at the bottom. Nothing to type, nothing to edit.
10. **Check, week goal** (Call family, 3 a week): "Not checked today", "1 of 3 times this week"; Add a check; no Skip.
    History's Add: **Add a check** ("…It counts toward this week.").
11. **Check, month goal** (Deep clean, 2 a month): "1 time today", "2 of 2 times this month"; its check with Undo.
    History's Add: **Add a check** ("…It counts toward this month.").
12. **Check, N days a week** (Gym, 3 days a week): a day is done or not: Mark done; "2 of 3 days this week"; Skip.
    History's Add: **Mark a day done** ("…It counts toward that week.").
13. **Checklist** (Tidy desk, 3 steps): "2 of 3 steps done", "One step left"; the steps as rows inside This day,
    above the note; no logs. History's Add: **Tick steps**, the same card, then STEPS (tap to tick or take back);
    **Save** at the bottom.
14. **Quit** (Smoking): "No slips recorded" → Record a slip; "1 slip recorded", "SLIPS TODAY". Add slip: one card,
    Habit ([icon] Smoking), Date and Time pickers; **Add** at the bottom. A slip row opens **Slip**
    (view: date, time, time zone shown; **Delete slip** | **Edit** at the bottom); **Edit** opens **Edit slip** (the
    date fixed, since a slip can't move days yet, D7, U19; the time a picker; **Save** at the bottom).
15. **Task, one time** (Submit report): no habit-page link; Not done → Mark done and Reschedule; Done, "Completed at
    4:10 PM" → Undo done, no Reschedule.
16. **Day states** (shown with Water; the same for every kind): skipped, paused, an earlier day.
17. **Notes** (shown with Read; the same for every kind): Add note from the Notes tab (the note box fills the room
    above the text keyboard) and Note, whose date line says how that day went and opens it; no habit card on either.
18. **Delete confirmations:** a native alert over the screen it came from, Cancel first and the red action last,
    nothing else (no typing to confirm). Each names what goes and what stays:
    - **Delete this log?** "1 glass at 11:20 AM is removed from today. Your other logs stay." Cancel · Delete Log
    - **Delete this slip?** "The slip at 10:16 AM is removed, and your quit run is worked out again." Cancel · Delete
      Slip
    - **Delete this note?** "Only the note for Sun 4 Oct is removed. That day's progress stays." Cancel · Delete Note

    Leaving an edit with changes keeps the app's existing Discard Changes / Keep Editing question (above); it is not
    part of this design.

## 9. How the Figma file is organised

- **Water section:** eight rows, one per screen in the order a person meets them (1 Day details, 2 All logs, 3 Add log,
  4 Log, 5 Edit log, 6 Add note, 7 Note, 8 Edit note) and a column per iPhone size (SE, mini, 6.1-inch). Each frame is
  the sheet's own size. Rows 3–8 were rebuilt on 7 Oct from the every-kind section's current screens.
- **Every-kind section:** one row per kind or variation (18 rows), the screens that kind has from left to right, all at
  the 6.1-inch size. Each row's label says what makes it different.
- Frames carry short captions only. Decisions, numbers and reasons live in this document.

## 10. Still open

**Rulebook changes, each needing the user's OK before anything is built** (a product rule changes only with the
user's say-so):

- **U17** (Day-sheet spacing): the note moves into the This day card, above the logs.
- **U18** (Close icon; text Cancel / Save in editors with a draft): Add screens get ✕ instead of Cancel; Add / Save /
  Mark done / Add a check move to one filled button at the bottom; a record's view has Delete | Edit there.
- **U19** (editing one record): the editor opens as a view (Log, Slip, Note) with Delete | Edit, and Delete leaves its
  last row in the content for the bottom place; every log's time can change within its day; History adds one check at
  a time, and new multi-check logs are no longer made.
- **U22** (the accepted controls): the amount becomes one large number card, typed.

**Other open items:**

- The notes screens (no habit card; "View Day" in the date line) and the button-word changes in section 8: the user's decision.
- The every-kind screens at the SE and mini sizes, if the user wants them drawn (the rules in sections 2 and 3 say how
  they fit).
- Native build, tests on GitHub (T7), a speed run (S2), and the iPhone check at SE, mini and 6.1-inch sizes (U9).
