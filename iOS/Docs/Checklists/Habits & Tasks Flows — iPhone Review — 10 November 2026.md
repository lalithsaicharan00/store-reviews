# Habits & Tasks Flows — iPhone Review — 10 November 2026

Written by Claude (Claude Code), 10 November 2026, from the user's request the same day. Figma: file
`zLgBjb7M7Fp6UN0pg7J3a8`, page **habits & tasks** (`269:148`). Done the same way as the
[Routine player flows](<Routine Player Flows — iPhone Review — 10 November 2026.md>).

**The user (10 Nov 2026):** "we have to update the numbers … is this tab … the size of the tab, is it like a native
iPhone size? … If not, just update that … regarding the snack bar … what happens when we have more than one line of
text? … work on the flows one after the other and update them. And if anything is unnecessary, delete them … work on
one thing at a time. Don't try to rush it up."

## The user's points

- [x] **1. The Habits | Tasks tab: is its size native?** Measured on the iOS 26.5 Simulator (iPhone 17) with a
  throwaway app: a segmented `Picker` at `.controlSize(.large)` (and `.extraLarge`) is 48 tall, its white pill 2 in
  from every edge (44 tall), the words 13 (Footnote, the selected one Medium), the same size as the regular
  control's; mini, small and regular are all 32 with a 28 pill. Figma's Large was 48 tall with the words at 13, so the
  height was right; its pill sat 3 in (42 tall, radius 21). Fixed in the design system (Segmented control,
  Size=Large): inset 2, pill 44, fully round. All 122 copies (115 here, 5 on details pages, 2 on create new) follow.
- [x] **2. The Banner with more than one line.** Apple has no snack bar, so there's no system rule to read; the
  Banner follows how iOS's own capsules (the AirPods and Focus pills, Mail's Undo Send) behave: one line where it
  fits, then it grows. Built in the design system (Banner, `4663:227469`, in Specimen · Banner `1300:2592`):
  - **It hugs its words up to 328 wide** (16 from each edge of a 360 screen), then wraps to a **second line, never a
    third:** past two lines the words end in …. Its height grows from 44; the radius stays 22, so two lines read as a
    rounded card, not a pill.
  - **The words sit at the top of their own column and the button stays centred against them.** On two lines the
    symbol stays with the first line.
  - **Buttons=None, One, Two** is now a variant, because a copy can't change a text's maximum width: the words get
    272, 221 or 146 before they wrap. The old Show booleans are gone. Copies: None 21, One 66, Two 16.
  - **Three real banners now take two lines,** as they would on the phone: "Buy groceries added to Tomorrow" (Show),
    "Learn the Spanish verbs restored" (Undo), and "No internet. It backs up once you’re online."
  - The specimen shows one line, two lines, and a long one cut with ….
  - **Every copy is centred on its screen:** five sat 4 to 31 off (Today 7, Day details 6, Habits & Tasks 3, Settings
    2 and 3), and the routine player's five mains had moved to x 113 after the swap; all are at the centre now, the
    player's pinned to it.
- [x] **3. Number the flows.** 35 flows, numbered on from the routine player's 155: **156–190**, in page order (each
  header's words and its frame's name; the frames were all still called "✕ with a timer running").
- [x] **4. Every screen of every flow, one flow at a time; delete what isn't needed.** All 35 flows, below. One
  screen went (180's third, which couldn't show what it claimed); two old Android drawings of Task details became
  copies of the iOS component (186, 189). Left for their own reviews: Task details' dark Add Note button, and the
  date picker's main, which is drawn for a today of 21 Oct.

## Flow by flow

- [x] **156 · Open Habits & Tasks from the menu.** Today, the menu, Habits on Week: all right. The last note still
  said "Week · Month · Year" in the bottom bar; it now says Week ⌃⌄ (Week, Month or Year) and the period.
- [x] **157 · Week, Month and Year.** Week went straight to Month with a "Month" arrow, but the bottom bar is a
  drop-down now, so the step in between was missing. **Added screen 2: the menu open from Week ⌃⌄** (the design
  system's Menu, rows with a checkmark column, no symbols: Week ticked, Month, Year), opening upwards over its
  button as iOS does at the bottom of the screen. Month and Year moved along (now 3 and 4); the arrows read Week ⌃⌄,
  Month, and Month ⌃⌄, then Year.
- [x] **158 · An earlier week, and back to this one.** Right as drawn: ‹ steps back, "so far" and the today ring go,
  Back to This Week floats above the bar in plain glass.
- [x] **159 · Scroll the page.** The last screen said "the end of the page" but stopped 128 short: Archived and
  What the squares mean sat under the bottom bar. **Fixed in the design system** (Habits page, Screen=End of the
  list): the list is scrolled to its real end, with 30 between the last row and the bar. The third note had drifted
  beside the screen; it's under it now.
- [x] **160 · Tap a card: Habit details, and back.** Right as drawn. Screen 3 said "‹, Back or a swipe": the iPhone
  has no Back button, so it's "‹ or a swipe from the edge". Habit details' **See All streaks** was the one button
  the title-case pass missed: **See All Streaks** in the Overall record card, so in all 54 copies.
- [x] **161 · Tap a square: Day details for that day.**
  - Add Log's wheel showed **5 min** where 6 were logged; it's at 6 now.
  - Its date was the component's **9 Nov 2026**, in a week of 18–24 Oct whose Friday is today; it's **23 Oct
    2026, 9:41 AM** (now, as the status bar says).
  - **The banner covered the bottom bar.** Saved · Undo floats just above the bar, as the design system's own
    Tasks screen has it (674, 8 above a bar at 726), so **every banner on this page that sat on a bar (20) is 8
    above it now.** The six on pages with no bottom bar (Archived habits, Archived and Completed tasks) ran 2 into
    the Home Indicator's room; they're 8 above it now, fixed in their mains.
  - Log time is Log Time in the arrow and the note.
- [x] **162 · A card's ⋯: Edit Habit.**
  - **The menu opened under ⋯; an iOS menu opens from its button and covers it** (Rulebook, menus). It now sits
    with its corner on ⋯ (the right edges equal, its top on the button), as the reviewed Day details flows have it.
    **The same on every card and row menu on this page (12):** Habits (Edit Habit, Pause…, Resume, Archive,
    Delete), Archived habits, and Tasks (One-time and Repeating). Two of them had been drawn under the wrong row:
    Resume now covers Stretch's ⋯, Skip This Time covers Water plants'. "Skip this time" is **Skip This Time**.
  - **Edit Habit's top-right button was the form's dark Add.** The Rulebook says Add, Save and Done are plain glass
    with a Semibold word. **Fixed in the design system** (Create new form, all 10 variants): plain glass, Semibold,
    as Add Log has it; **and this copy says Save.**
- [x] **163 · A card's ⋯: Pause….** The Pause sheet is the same as the reviewed Day details one (✕, handle,
  Confirm), so it stays. The arrow and the note still said "Cancel | Pause": they say ✕ and Confirm now.
- [x] **164 · A paused card's ⋯: Resume.** Right as drawn (its menu re-anchored with 162).
- [x] **165 · A card's ⋯: Archive.** Right as drawn.
- [x] **166 · A card's ⋯: Delete.** Right as drawn. The last note said "Cancel, a tap outside or Back closes the
  question": an iOS alert has neither, so it says Cancel, and Undo in the banner after Delete.
- [x] **167 · Archived habits: open, Restore.** The menu in the design system's Archived habits page (Screen=Menu
  open) sat under ⋯; it covers it now, as in 162. The note promised "how many days it has" on each row, which the
  rows don't show; it says when it was archived.
- [x] **168 · Archived habits: Delete, open one, the last one restored.** The last screen had **two "Push-ups
  restored" banners** stacked 2 apart, one from the page's own component and one dropped on top; the extra one is
  gone.
- [x] **169 · Search habits and tasks (from Habits).** The screens are right. Their names and notes still described
  Android: "Android's full search view" and "‹ again (or Back) closes it". They now say the field takes the bar's
  place with ✕, ‹ comes back to the search as it was, and ✕ closes it.
- [x] **170 · Search: no match (from Habits).** Right as drawn; the form's Add is plain glass now (from 162) and the
  banner sits above the bar (from 161).
- [x] **171 · +: a new habit.**
  - **Show didn't show Floss:** the page stopped with Floss's name and goal above the screen's edge. **Fixed in the
    design system** (Habits page, Screen=Habit added): the whole card is in view, 8 under Habits | Tasks.
  - The form had the default purple star where the card that came out of it is Floss's teal icon; the form now has
    the same icon and colour.
- [x] **172 · Every kind of card (Week).** A board for the build, not a moment on the phone, but each of its four
  frames was cut at 800 and lost its third card (Gym's dashed days, Deep clean's month goal, Coffee's limit,
  Journal), which the notes describe. The boards are 967 tall now, all three cards whole; the notes moved under them.
- [x] **173 · Empty and first states.**
  - **The first week's ‹ was on,** though there's nothing earlier and the note says it's off. It's dimmed the way
    the bar dims › on the latest period (38 %).
  - **July's way back was a dark "Back to this month" sitting on the bottom bar,** and the bar still said
    October with › off. It's now the plain glass **Back to This Month** floating above the bar, as Back to This Week
    in 158, and the bar says **July** with › on.
- [x] **174 · Long names and large text.** Right as drawn: a 24-letter name stays one line with …, and at 200 % the
  text grows and the squares keep their size.
- [x] **175 · Tasks: One-time.**
  - **Pick up parcel said "Done 2:05 PM" at 9:41 AM.** It's **Done 9:05 AM**, fixed in the Tasks page's mains,
    so in all 50 copies.
  - The note promised done tasks are struck through; the rows draw the name in grey, so the note says that. It
    also said Habits has Week · Month · Year in its bar: it has the Week ⌃⌄ drop-down and the period.
- [x] **176 · Tasks: Repeating.**
  - **Completed said "6 tasks done" on 43 screens and 12 on three others,** while 182 has it reach 14 once today's
    two done tasks move in at the day's end. It's **12** everywhere before then.
  - **One way of writing a date on the whole page.** It mixed "Fri, 30 Oct" (Tasks' headings and rows) with
    "Fri 30 Oct" (Paused until, Next, the banners). It's **Fri 30 Oct** everywhere (the day-and-month order iOS
    writes without a comma), in 161 copies, 107 texts and the frames' names. A date more than two weeks off is
    just **9 Dec**: with its weekday, "Every 2 months · Next Wed 9 Dec" broke onto a second line.
  - **Car service was planned for "Tue 4 Nov"; 4 Nov 2026 is a Wednesday.** It's Wed 4 Nov everywhere.
- [x] **177 · A task's ⋯: Move to Another Day.**
  - **Menu rows in title case on this page:** Move to Another Day…, Do Today, Pick a Day…, Mark as Not Done,
    Delete All Completed (20 rows, and the arrows, notes and names that quote them). Move to Another Day… takes
    two lines in the 249-wide menu, as a long row does on the iPhone.
  - **The arrow said "Tap 30 · OK", but the picker has no OK:** choosing a day closes it, as its own note says.
    The arrow says Tap 30, screen 3 is "30: it leaves Today", and its note says choosing a day moves it. Screen 2
    no longer calls the picker Android's.
- [x] **178 · A task's ⋯: Edit Task and Duplicate.**
  - **Edit Task's top-right button said Add;** it says **Save**, as Edit Habit does (162) and as the arrow says.
  - **Both forms showed the form's default blue calendar** for Pay electricity bill, whose row is a yellow bolt.
    Edit Task and the duplicate's New Task now have the yellow bolt and yellow colour.
- [x] **179 · A task's ⋯: Archive and Delete.** Right as drawn: Archive asks nothing and offers Undo; Delete asks
  with Cancel and Delete only, then offers Undo.
- [x] **180 · A repeating task's ⋯: Skip This Time.** The menu and the skipped row are right ("Next Wed 28 Oct",
  Skipped on Sun 25 Oct · Undo). **The third screen is gone:** it showed One-time, which never lists a repeating
  task, so it couldn't show anything about the skip; screen 2's row and note already say it keeps coming every 3
  days.
- [x] **181 · A task with No date: Do Today, or Pick a Day.**
  - **The menu opened over Sort old photos, under the wrong ⋯.** It covers Fix the bike light's ⋯ now, fixed in
    the design system (Tasks page, Screen=Menu open), as in 162.
  - **The date picker offered 21 and 22 Oct, which are past.** The picker's main is drawn for the Day details
    flows, where today is 21 Oct; on this page today is Fri 23 Oct, so its two copies here (177 and 181) grey 21
    and 22 as they grey the days before.
  - The notes promised Undo (the banner has Show) and an OK (choosing a day closes the picker); they say Show and
    choosing a day. Screen 4 no longer calls the picker Android's.
- [x] **182 · A task done on Today, and when the day ends.**
  - **Pick up parcel was two different things:** a box on Today, another symbol on Tasks. It's the box
    (`shippingbox.fill`) on Tasks too, in 49 rows.
  - **Its ✓ on Today was red,** for a brown task: a met goal's button is the habit's own colour. It's System Brown.
  - It's ticked at 9:41 in screen 1, so Tasks says **Done 9:41 AM** in screen 2 (9:05 elsewhere, where it was
    done earlier). Its name and note say grey, not struck through.
  - The next day and Completed reaching 14 are right.
- [x] **183 · Completed tasks: Mark as Not Done.**
  - **Completed tasks opened on a "Today" group holding Book flights and Pick up parcel,** but 182 says today's
    done tasks stay on Tasks until the day ends, and this flow starts from 14 done, which is the next day. That
    group is **Fri 23 Oct** now (a date, never "Yesterday"), fixed in the design system (Completed tasks page, all
    five screens that have it).
  - **The menu said "Mark As Not Done";** Apple keeps a short word like *as* lower case: **Mark as Not Done**,
    in both menus' mains and in 184.
- [x] **184 · Completed tasks: Delete All Completed.** Right as drawn: the one-row menu covers ⋯, the alert says
  how many with Cancel and Delete only, and the empty page says when tasks come here, with Undo above the Home
  Indicator.
- [x] **185 · Archived tasks: Restore, Delete.** **The menu sat 10 above and 10 right of its ⋯;** it covers it now,
  fixed in the design system (Archived tasks page, Screen=Menu open), as in 162. Screen 4 is named for what it
  shows: the task leaving Archived tasks, with Undo.
- [x] **186 · Search habits and tasks (from Tasks).**
  - **Call the dentist's Task details was an old Android drawing:** a bare ‹ and ⋯ with no glass, and a dark
    Add note button. It's now a copy of the iOS **Task details page** (Screen=One-time · not done yet), filled in
    for Call the dentist. **The same old drawing stood in for Car service in 189;** that's a copy too.
  - The Task details main said **Tue 4 Nov** for Car service; it's Wed 4 Nov, as on Tasks (176).
  - The last note said "‹ again closes it": ‹ comes back to the search, and ✕ closes it, as in 169.
  - Left as the details page draws it: Task details' Add Note is a dark floating button. That page is its own
    review.
- [x] **187 · Search: no match (from Tasks).** **The last screen said "plumber added to Today" over a Today that
  didn't have it.** The Tasks page's One-time main has a hidden plumber row now (Anytime, the form's blue calendar),
  at the end of Today's open tasks before the done ones, the way it keeps the bill's copy and Fix the bike light;
  this screen shows it. The rest is right.
- [x] **188 · +: a new task.** The form had the default blue calendar where the row it makes is Buy groceries'
  green cart; the form has the green cart now. The two-line banner and Show are right.
- [x] **189 · Tap a task: its details, and back.** **"Tap Car service" was drawn with Car service scrolled under
  the bar** (only its time showed). The flow taps **Dentist check-up**, the row in full view, and its Task details
  (the iOS copy from 186) is filled in for it: the red case, Tue 17 Nov, 10:30 AM.
- [x] **190 · Tasks: empty states and Font size 200%.**
  - **At 200 %, Pick up dry cleaning's row had a gap of a whole line** between its name and its time: the name's
    row kept a two-line height while the name showed one line with …. It hugs its line now (95 tall, like the
    others), in the design system (Tasks page, Screen=Large text).
  - The note spoke Android ("grows in sp", "the tab indicator", "tabs grow taller", none of which the screen
    shows); it says the text grows, icons and ⋯ keep their size, rows grow taller.
  - The empty states are right.
