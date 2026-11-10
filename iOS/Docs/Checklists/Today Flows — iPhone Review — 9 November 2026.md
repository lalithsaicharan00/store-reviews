# Today Flows — iPhone Review — 9 November 2026

Written by Claude (Claude Code), 9 November 2026, from the user's request the same day. Figma: file
`zLgBjb7M7Fp6UN0pg7J3a8`, page **today** (`54:5580`). Every point the user made, in order (Rulebook W1).

**The ground rule (the user):** "I'm not giving you the permission to update anything drastically or change the idea
itself … the idea will remain same, but implementation was imperfect or it was kind of buggy." Only the date title's
format is a new decision.

## The user's points

- [x] **1. One flow at a time.** Check every screen of every Today flow; fix what is badly drawn or buggy; ask before
  any change to an idea.
- [x] **2. Number the flows from 8** (onboarding has 1–7), as the onboarding flows are numbered ("8 · …").
- [x] **3. Remove anything Plus** on the Today page.
- [x] **4. Pause a habit:** the sheet is glass and "the text on top of it is not looking good". Make it consistent
  with Day details ("gray background and white things on top of it"): "pop-ups should be consistent everywhere".
- [x] **5. Pause until a date:** screen 4's calendar pop-over "is white, it's good … but so much empty space". Check
  how the iPhone's own calendar pop-up looks, and keep Day details' consistency.
- [x] **6. Pick a day:** the same calendar, the same empty space. *Done 9 Nov: 318 × 326 above the day bar (flow 39).*
- [x] **7. Add a note by swiping right:** screen 3, "past halfway it turns dark. It is not looking good."
- [x] **8. Every swipe flow (Skip by swiping and the rest):** the action isn't centred, "that half black color";
  do it the way the iPhone does. Research whether the iPhone shows an icon and then text, or the text inside the button.
- [x] **9. Cut-down habits, amount or time:** add **max**: "0 of 2 cups max", "0 of 30 mins max" (minutes as *mins*).
- [x] **10. The day's title:** today stays **Today**; any other day is its date, **"8 Nov"** for yesterday, **"10 Nov"**
  for tomorrow (the month short, as *Nov*, never "Yesterday" or "Tomorrow"). Write the rule down. *Done 9 Nov: rule written (Rulebook, Android A119); every day bar on the page reads Today or a date, and the day bar components' defaults are 20 Oct and 22 Oct, so no "Yesterday" or "Tomorrow" is left.*
- [x] **11. A separate page of every change so far that Android needs too** (iOS-only changes left out), e.g. the date
  title. *Done 9 Nov: [Today Flows — Changes Android Needs Too](<Today Flows — Changes Android Needs Too — 9 November 2026.md>).*

## Decisions and findings

(Filled in flow by flow.) Order: the left column top to bottom (8–59, Plus's notice deleted), then the milestone
column (60–87). Header ids are in the loop's notes below.

- **8 · Check off a habit** (`68:2`): screen 1 had no number and sat 12 px left of the column (now "1 · Today: Meds
  not done yet", x 0). After the tick the day bar still read 4/13; it reads **5/13** and its ring moved with it.
- **9 · Check off several times a day** (`117:2`): 1/3 and 2/3 drew the same fill. **Every part-done fill on Today
  was 40 % whatever its count** (a copy can't resize a child). Fixed in the design system first: Habit row's
  *Progress fill* now sits in a full-width *Progress track* whose right padding sets how far it reaches (a copy can
  override padding); every variant keeps its old look by default (3,006 rows checked unchanged). Then all 1,675
  part-done rows on Today were set from their own numbers (1/4 steps 25 %, 12/20 min 60 %, 6:42 of 10 min 67 %,
  $300/$500 60 %). The day bar reads 5/13 once the goal is met. Rows that say "Skipped today" still have a part fill:
  checked with the Skip flows.
- **10 · Add an amount** (`71:2`): the day bar stayed 4/13 after Water reached 8 of 8; reads 5/13 on screens 3–4.
  Fills, Undo · Note and 9 of 8 were right.
- **11 · Log an amount manually** (`87:2`): Water is at 5 and 7 of 8 here, yet Anytime said "2 left" and the day bar
  4/13 (both copied from a Today where Water was done). Now 3 left and 3/13. Day details, Add Log and "All 4 logs"
  were right.
- **12 · An amount typed each time** (`119:2`): right as drawn (Log opens Add Log with $50, 50 % → 60 %, "$200 to go
  this month"). Tried "$300/$500 this month" to match "2/3 this week": it's cut off beside 6 mo and Log, so it stays
  "$300/$500"; Day details says "this month".
- **13 · Time a habit** (`73:2`): at the goal Stretch's streak stayed 4 and the day bar 4/13; now 5 and 5/13 on
  screens 4–5. Timer sheet, the row's clock and ⏸ / ▶ were right.
- **14 · Log time by hand** (`95:2`): Add Log drew Stretch's icon on System Green; it's System Teal everywhere else,
  now here too. The note said "minutes first, with the number pad", but the screen is the iPhone's duration wheel:
  the note now says so. The arrow said "Log Time…"; the button says "Log Time".
- **15 · Tick checklist steps** (`75:2`): once all four steps were ticked, Skincare's streak stayed 12 and the day bar
  4/13; now 13 and 5/13 on screens 4–5. Fills (1/4, 2/4), "2 left" → "1 left", Undo · Note and the ⌄ / ⌃ fold were
  right.
- **16 · A week or month goal** (`77:2`): at 3 of 3 the day bar stayed 4/13; now 5/13 on screens 2–3. The fill
  toward the week's goal, "2 left" → "1 left", 4 wk → 5 wk and Undo · Note were right.
- **17 · Do a task on Today** (`120:2`): Pick up parcel had been drawn over Water's row, so Water (done, 8/8) was
  gone from Anytime while "3 left" still counted it as there. Fixed in the design system first: the Today screen's
  Anytime section has a fourth row, hidden by default, *Habit row · task (row 4)* (no copy changes). Here Water is
  back and the task is the fourth row, at the end of Anytime as the note says; the list scrolls with it. Today counts
  the task (Android A86), so once it's done the day bar reads 5/13 (was 4/13). Other flows that drew the task over
  Water: checked as each comes.
- **18 · Quit: log a slip** (`79:2`): Day details, Add Slip and "1 slip recorded" were right, and the row restarts
  from the slip with Undo · Note. **Point 9 done on the whole Today page here**, since Coffee and Social media sit
  under Smoking on every Today: 61 cut-down rows now read "0 of 2 cups max", "1 of 2 cups max", "0 of 30 mins max",
  "12:40 of 30 mins max", and the Social media timer's ring "of 30 mins max". "Limit reached · …" and
  "Over the limit · …" already name the limit, so they get no "max"; "42 of 30 min" became "42 of 30 mins".
  **Left as drawn, to ask:** Smoking reads "Since 3 Oct" beside "19d 12:32:45", and Add Slip's day is 21 Oct, which
  is 18 days on; 20 copies share the line, so it's for the user to say which number is meant.
- **19 · Log a slip from the menu** (`81:1657`): right as drawn. Touch and hold lifts Smoking and opens the Menu
  (Edit habit, Pause, Add note, Log a slip) under it; the menu may overlap the day bar, as an iPhone context menu
  sits over everything. Add Slip and the row after it match flow 18.
- **20 · Touch and hold a habit** (`122:2`): after Skip today the day bar still read 4/13. A skipped day is "left out
  of every count" (Android's Day details), so it reads **4/12** now; Morning's "3 left" → "2 left" was already right.
  The menu (Edit habit, Pause, Add note, Skip today) and "Skipped today · Undo · Note" were right. The same rule is
  applied to the Skip flows as they come.
- **21 · Pause a habit** (`122:550`): **point 4.** The Pause Meds sheet drew its words and choices straight on the
  glass. It now matches Day details: the sheet is System Grouped Background (its glass hidden), and the four
  choices are one white inset card (the Checkmark rows' own Secondary System Grouped Background, First … Last, 16 in
  from the sides), with the explanation above it lined up with the rows' words. Same height, same words, same
  Confirm. Done on all five Pause sheets on Today (here and in flow 22). The rest was right: the menu, the banner
  "Meds paused until Wed, 28 Oct · Undo", "2 left" and the day bar 4/12.
- **22 · Pause a habit until a date** (`137:2`): **point 5.** The calendar component (Date picker, `705:1025`) is
  318 × 326, the size of iPhone's graphical calendar in a popover, but screen 4's copy had been stretched to
  328 × 537: that was the empty space. Both copies are back to the component's size, sit just above *Until a date…*
  (there's no room under it), and select the right day: **22** (tomorrow) when it opens, **30** once tapped; both had
  25. The calendar has no OK, Cancel or ✏ (iPhone's picks on tap and closes when you tap outside), so the arrow
  "OK" is "Tap outside the calendar" and the notes no longer mention them. The sheet's button is **Confirm**, so the
  arrows that said "Pause" (here and in flow 21) say Confirm. The Pause sheets are already Day details' grey and
  white (flow 21). Banner, "Back on Fri, 30 Oct" and the day bar 4/12 were right.
- **23 · Resume a habit** (`122:1300`): right as drawn. The Paused card at the end of Today ("Paused until 28 Oct",
  Resume), Day details' Paused card with Resume Habit, and Meds back in Morning with "Meds resumed · Undo"; Morning's
  "3 left" counts Meds again and the day bar goes from 4/12 to 4/13 as Meds rejoins the total.
- **24 · Undo and Note follow the latest log** (`84:2`): Water is at 6 and then 7 of 8 here, yet Anytime said
  "2 left" and the day bar 4/13 (copied from a Today where Water was done), and after Call family's ✓ "1 left". Now
  **3 left · 3/13** on screens 1–2 and **2 left · 4/13** once Call family is done (3–4). Undo · Note moving from Water
  to Call family and going when a routine starts, the fills and 4 wk → 5 wk were right.
- **25 · Undo clears the buttons** (`139:5`): the same miscount as flow 24 (Water at 6–7 of 8, "2 left" and 4/13).
  Now 3 left · 3/13, then 2 left · 4/13 after Call family's ✓, and **3 left · 3/13** again after Undo takes it back
  (Call family 2 of 3, 4 wk, no buttons). The rest was right.
- **26 · Skip a day** (`85:2`): after Skip today the day bar still read 4/13; a skipped day leaves the total (flow 20),
  so it reads **4/12**. Day details (Skip Today last, Mark Done off once skipped, Undo Skip in Skip's place) and
  "Skipped today · Undo · Note" with Morning's "2 left" were right. Meds' row shows no part fill here.
- **27 · Skip by swiping** (`85:780`): **point 8, the swipe.** Measured on the iPhone 17 Simulator (iOS 26.5) with
  a real `swipeActions` row at Today's height, 70: iOS draws a **60 × 40 capsule**, not a circle, in System Gray with
  a filled ▶▶, *Skip* under it in Footnote, and the two centred in the row on an 80-wide strip; past halfway the
  capsule **stretches across the row in the same grey** and the caption stays under its middle. Nothing turns dark.
  The component (`763:273`, all four variants) had an 81-row's 50 circle squeezed into 70 with an 11 caption 2 under
  it, an outline ▷▷ and a 70 slide: that was the off-centre look. It's now iOS's, and every copy follows. Screen 3 and
  its note no longer say "turns dark" or "Skip today" (iOS has one label). Screen 4's day bar reads 4/12 after the
  skip (was 4/13), and the header now spans all four screens (it stopped short of screen 4). The Lists doc has the
  measurements.
  **Icon then text, or text in the button?** On iOS 26 a swipe action with a symbol shows the symbol **inside** the
  capsule and the word **under** it; only an action with no symbol puts the word inside. Ours have symbols, so
  symbol inside, word under (tried both on the Simulator).
- **28 · Add a note by swiping right** (`124:2`): **point 7.** The component's four states were already right after
  flow 27, but two copies here painted over its background: screen 3's with Ink (`#303030`, the "turns dark") and
  screen 2's with a see-through fill. Both now take the component's System Grouped Background, so past halfway the
  Note capsule stretches across the row in the same grey, as iOS does. Screen 3 no longer says "turns dark" or
  "Add note". The other six swipe copies on Today had no such override. Counts (2 left, 4/13) and Add Note were right.
- **29 · Undo a skip by swiping** (`124:647`): Meds, skipped, is a 106 row (Undo · Note under it), but the swipe
  copies on screens 2–3 were a fixed 70 holding it, so everything below jumped up 36 mid-swipe and Undo skip sat high.
  Measured on the Simulator, a taller row keeps the 60 width and makes the capsule **50 tall**, also at full swipe; the
  caption doesn't move. Fixed in the component first: the swipe now hugs the row inside it, and the capsule's height
  is its padding, so these two copies are 106 with a 60 × 50 (and 197 × 50) capsule and nothing moves. The day bar
  read 4/13 while Meds was skipped: now **4/12** on screens 1–3, back to 4/13 once the skip is undone. Screen 3 no
  longer says "dark".
- **30 · Log a slip by swiping** (`124:1376`): right as drawn once flow 27's swipe fix reached it: Log a slip in the
  60 × 40 capsule, the same grey at full swipe, Add Slip opening with nothing logged until Add. Its ↩ is the app's own
  (`arrow.uturn.backward.circle` beside Log a Slip in `TodayRows.swift`), so it stays. Screen 3 no longer says "dark".
- **31 · Swiping where there's nothing to do** (`124:2081`): screen 3 drew Coffee with a ✓; Coffee is an amount
  ("0 of 2 cups max") and has + on every other Today, now here too. Screen 4 had Pick up parcel drawn over Water's row
  (the flow 17 bug): Water is back, done, in row 3, and the task is the fourth row, with the list scrolled as in flow
  17; "3 left" was already right. The Rule note said a left swipe "gives a little and springs back", against the
  screens and iOS (a row with no swipe action doesn't move): it now says the row stays still.
- **32 · Add a note after a log** (`90:2`): Water is at 5 and 6 of 8, yet Anytime said "2 left" and the day bar 4/13
  (the flow 11 miscount): now 3 left · 3/13 on screens 1, 2 and 5. Screen 5's "Note saved" banner sat over the
  Undo · Note buttons its own note says stay: it now floats just above the day bar (8 above it, as the Rulebook says
  of Saved), clear of them, and is named Banner, not Snackbar. Screen 3's note said "tap it [the date] to pick
  another day", but a note's day is plain and can't change: it now says so. Add Note, Add turning on, and the note in
  Day details were right.
- **33 · Add a note from Day details** (`90:828`): screen 1 had the flow 11 miscount (Water 5 of 8, "2 left",
  4/13): now 3 left · 3/13. The screens draw **Add a Note** as its own row with a chevron (decided 6 Nov), but the
  arrow, a screen name and two notes still said "Add a note…" and that it "sits in This day, under the logging
  buttons": all now say Add a Note and where it is. Day details, Add Note and the note taking the row's place were
  right.

**34 · Change a note** (`91:2`). Screen 1 said 2 left and 4/13 while Water is at 5 of 8: now 3 left and 3/13, its ring with it. On the last screen the saved note wraps to two lines, which pushed Skip Today down under the Note saved banner; the banner now sits under the button (y 732), clear of the Home Indicator. The Note view, Edit Note and the notes were right.

**35 · Delete a note** (`91:607`). Screen 1 said 2 left and 4/13 with Water at 5 of 8: now 3 left and 3/13, its ring with it. Screen 5's name said "Add a note… is back"; the screen shows Add a Note, so the name says that. The alert (Cancel and a red Delete, centred), the Note view and the Note deleted · Undo banner were right.

**36 · Leave a note unsaved** (`91:1143`). Screen 1 said 2 left and 4/13 with Water at 5 of 8: now 3 left and 3/13, its ring with it. The label, arrow and screen 3's name said "Add a note…"; they now say Add a Note, as the row does. Discard this note? used the plain Alert, so Discard was black: it's now the Destructive kind, Discard in red, as the app's code has it (`role: .destructive` in `NoteSheet.swift`) and as Delete is in flow 35; the words are unchanged, with won’t's apostrophe curly.

**Simulator test app's colours (9 Nov 2026, the user: "they're looking way brighter than what we have in the design").** The throwaway swipe probe (`Research/Temp/ios-lists/`) drew a row's fill as the system colour at 22 %, about twice the colour of Figma's Fill and darker. It now uses Figma's `iOS/Habit/<Hue>/Fill` hexes, checked on the Simulator's screen (`#E1F7E6`, `#E7F1FF`, `#D8F7FA`). The swipe measurements never depended on the fill.

**37 · Log yesterday** (`99:2`). The day title on the yesterday screens said Yesterday: now **20 Oct**, the user's new format (written down as a rule in the Rulebook's "Starting again" and as Android A119, which also needs building on Android). Meds showed 🔥 57 on screen 1 and on yesterday's list, though the flow's own rule note and screen name say yesterday missed means no streak (Android A113, ST-1a): the 🔥 is hidden on both, and 58 shows once yesterday is ticked. "Back to today" is "Tap Back to Today", as the button says. The header was 2600 wide over four screens: now 2040. Counts (4/13 today, 8/13 then 9/13 on 20 Oct) add up.

**38 · Look at tomorrow** (`100:2`). The day title said Tomorrow on three screens: now **22 Oct** (A119). Day details for that day was titled **Today**: now 22 Oct, as a sheet for another day is titled by its date. Its bar showed 60 % for a day with nothing logged: now empty (Value 0). The note on screen 2 said "no logging buttons", but every Today row keeps its round button (the user, 25 Oct); it now says what's true: a task can be done early, a habit is logged on its day. "Back to today" is "Tap Back to Today". Counts (0/12 planned, 4/13 today) add up.

**39 · Pick a day** (`101:2`). The calendar (`789:39339`) was 328 × 509: its days ended at 324, so the rest was empty white running off the screen's bottom (the user's point 6). It's now the pause calendar's size, 318 × 326, centred, and sits 8 above the day bar it opens from, as a popover does. The day title after picking said "Tue 13 Oct": now **13 Oct** (A119, no weekday). "Back to today" is "Tap Back to Today". Counts (9/13 on 13 Oct, 4/13 today) add up.

**40 · No habits yet** (`104:2`). The first two screens (Splash, No Habits Yet) are the onboarding's 393 × 852 frames, so the first two arrows started inside them: both now start at the screens' edges (x 393 and 953), labels with them. The label and note said "New habit" and "Restore from a backup"; they now use the buttons' words, New Habit and Restore from a Backup. The screens themselves were right: Water lands in Anytime, 0/1, then 1 of 8 with Undo · Note and an eighth of its fill.

**41 · Nothing planned today** (`104:419`). Tomorrow's day title said Tomorrow: now **22 Oct** (A119). "Back to today" is "Tap Back to Today". The empty Today (Nothing Planned Today, New Habit) and tomorrow's Gym row (1 planned, 0/1) were right.

**42 · Notice: backup is paused** (`125:2`). The notes still said "Not now hides it for 7 days" and "Not now / Dismiss", from before the card took TipView's anatomy (6 Nov): they now say its ✕. "Manage storage" is "Tap Manage Storage", the button's words. The card (filled symbol, Headline, Subheadline, one Bordered fix, ✕) and the counts (Morning 3 left, 4/13) were right; screen 2's "Backed up just now" banner sits above the day bar, as a banner does.

**43 · Notice: backup is off** (`125:371`). Screen 2's banner was Android's, "Google Drive connected · sam@gmail.com", which the iPhone app must never show (App Review 2.3.10) and which contradicts the flow (signing in to iCloud): it now says **Backed up to iCloud**, as the flow's note does, and is centred. No other visible text on the Today page names Google, Drive or Android. The rule note said "Not now / Dismiss": now its ✕. "Open Settings · sign in" is "Tap Open Settings, sign in". The card (Backup Is Off, Open Settings, ✕) and the counts (4/13) were right.

**44 · Notice: your backup was removed** (`125:807`). Screen 2's note said the card shows "a wavy line": iOS has no wave, and the card draws `ProgressView`'s 4 pt bar, so the note now says "a bar". The rule note said "Not now / Dismiss": now its ✕. "Back up again" is "Tap Back Up Again". The four screens (iCloud Backup Deleted, Backing Up to iCloud… with its bar, Backed Up, then the card gone and the rows moved up) and the counts (4/13) were right.

**45 · Notice: reminders can't come** (`125:1537`). The notifications alert on screen 2 was see-through: the Alert component's glass was Apple's kit's 60 %, so the Morning card's Start capsule and the rows' fills showed behind its title and words. iOS's own `.alert` on the Simulator is near solid (238 grey over the dimmed list; `Research/Temp/ios-menus/sim-alert.png`), so the **Alert component** now has the Medium sheet's surface, `#ECECEC` at 95 %, on both kinds; all 36 copies on Today, Day details, Details, Settings, Habits & Tasks and Create new took it (none had its own fill). Written into [Menus and Sheets](<../Menus and Sheets — iOS Native.md>). The rule note said "Not now / Dismiss": now its ✕. Labels are "Tap Turn On" and "Tap Allow". The card and the counts (4/13) were right.

**46 · Notice: reminders can't come (notifications off)** (`153:206`). The rule note said "Not now / Dismiss": now its ✕. "Open Settings · turn on · come back" is "Tap Open Settings, turn on, come back". The card (Open Settings, no ✕, since reminders can't wait), the "Reminders are on" banner and the counts (4/13) were right.

**Plus flow deleted** (`125:1901`, "Notice: Plus is waiting for payment"), with its notes, screens, arrow and label, as asked (the app is free; Plus comes later as new features). The 177 items of the left column below it moved up 1,600, so the column has no gap; the right column (x 4,400) wasn't touched.

**47 · Cut down: an amount** (`116:2`). Day details' newest log said 1:30 PM while the clock says 9:41, after two taps just made: now 9:41 AM, 9:41 AM, 8:10 AM. The note said "+1 and Log manually"; the button is "Log". Screen 1 already says "1 of 2 cups max" (point 5). "Limit reached · 2 of 2 cups" and "Over the limit · 3 of 2 cups" stay without "max": with it the over line ran out of room at 360 ("3 of 2 cups…"), and "Limit" already says it's a most. Counts, the plain + and no fill (a limit isn't a goal) were right.

**48 · Cut down: a time limit** (`116:987`). Screen 5's line was cut off, "Over the limit · 42 of 3…", hiding the limit itself (the 🔥7 and ▶ leave it 171 wide at 360). A label is never cut and wrapping text grows its row (Rulebook, 31 Oct), so on this copy the line wraps: "Over the limit ·" then "42 of 30 mins", kept together with non-breaking spaces. **The Habit row component still cuts its second line at one line;** any long line on a row with a streak would be cut the same way. "✕" is "Tap ✕". Screen 1 already says "0 of 30 mins max" (point 5); the timer's ring (12:40 of 30, 42 %), the grey ring and plain ⏸ at the limit, and the counts were right.

**49 · A new habit appears** (`126:362`). Right as drawn: Journal lands at the end of Morning as a plain row, Morning goes from 3 to 4 left and the day from 4/13 to 4/14. The label "Add (the habit form)" now says what's tapped: "Tap +, fill it in, Add".

**50 · Couldn't save a tap** (`126:900`). Screen 2 ticked Meds and Morning went to 2 left, but the day bar still said 4/13: now 5/13 (screen 3, after Meds goes back, stays 4/13). Screen 3 was named "a banner says so" while it draws an alert, which is right (iOS has no snack bar; a failure is an alert): renamed.

**51 · Long names and large text** (`126:1437`). Screens 1 and 2 right as drawn (a 24-letter name ends in … on one line). **Screen 3 was Android's 200 % frame, hand-built:** Google Sans, a pencil for Edit, bare ☰ and +, "3 left" in chips, Android's day bar. Redrawn as the Today component (`4440:79048`) at iOS's Accessibility 1 sizes: every text on its `iOS/Accessibility 1/…` style (Body, Caption 1 and the flames sized by hand where no style exists), and each Section header on its own **Text size = Accessibility 1** variant, so headers go onto two lines as the note says. **The navigation bar and the day bar keep their default size:** iOS's bars don't grow with Dynamic Type (a long press shows the Large Content Viewer), and at the large size the day pill pushed its ring out and wrapped "4/13". Label "Font size 200%" became "Larger Text on" (Accessibility 1 is about 165 %, and iOS calls it Larger Text); the note's "sp" and "Font size" are iOS words now.

**52 · What a row's second line says, with reminders** (`232:2`). Right as drawn: goal then "| 8:00 AM" where there's a reminder, Skincare shows its next one (9:00 PM), and Done drops the time. Screen 2's day bar said 4/13 after Meds was ticked: now 5/13, as in flow 50. The arrow and label were still named "Tap Water": now "Tap ✓ on Meds", as their text says.

**53 · Arrange Today** (`57:2`). Right as drawn: Edit Today, Read dragged from Anytime into Evening, "Read moved to Evening · Undo" in the banner, and Today after it (Evening 3 left with a +1, Anytime 1 left, the day still 4/13). Names only: the arrow, label and screen 2 said ✏ where the button says Edit; the last label said "‹" alone and is now "Tap ‹".

**54 · Change a time of day** (`59:4`). Three fixes:
- **Save was dark** (Glass button, Style=Prominent) in the Edit time of day component (`830:265`, both variants), against the decided rule that Add, Save and Done are plain glass with a Semibold word (Navigation, 5 Nov 2026). Fixed in the component: Style=Regular, Body Semibold; all 19 copies still say Save. (The Navigation page says the Prominent variant was deleted; it's back in the Glass button set, so check other sheets for it as flows come.)
- **Screen 5 said 7:00 AM under Your day but 6:00 AM in the Starts pill:** the pill is 7:00 AM now.
- **Screen 4's wheels covered the 6:00 AM they belong to:** the popover now sits 8 under the pill, right-aligned with it, as iOS's compact picker opens. Its label said "OK", but iOS's time wheels have no OK: "Turn to 7, tap outside". "Tap Starts" became "Tap 6:00 AM" (the pill is what's tapped), and the ✏ names say Edit.

**55 · Add a time of day** (`59:712`). Fixes on the three form copies (screens 3, 4, 5):
- **Its confirming word said Save** on a new time of day, while the flow's arrow said Add: now **Add** (iOS adds with Add, edits with Save).
- **Its title was "New time of day"**, where the edit form says "Edit Time of Day" (Apple's title case): now "New Time of Day".
- **Screen 5's Starts pill still said 6:00 AM** while Night showed 10:00 PM: now 10:00 PM.
- **The wheels covered their pill**, as in flow 54: moved under it.

Labels: "OK" became "Turn to 10 PM, tap outside", "Tap Starts" became "Tap 6:00 AM", "Add" became "Tap Add", and the ✏ names say Edit. (A first pass at the title also rewrote the footer under Time; caught on the screenshot and put back word for word from the main.) The settings page has more copies of this form with a New title; they're outside the Today page and weren't touched.

**56 · Move Anytime or Quitting** (`62:2`). Right as drawn: Anytime lifted by its ≡, dropped at the top, "Anytime moved to the top · Undo", and Today opens with Anytime first (2 left, the day still 4/13). Names only: ⠿ became ≡ (the handle drawn), ✏ became Edit, and the last label "‹" became "Tap ‹".

**57 · Delete a time of day** (`65:2`). Right as drawn: Edit Time of Day (Save now plain glass, from flow 54's component fix), the alert "Delete Morning? Its 4 habits will move to Anytime." with Cancel and a red Delete (D9: two choices), and Edit Today scrolled to Anytime with Meds, Stretch, Skincare and Meditate at its end (Afternoon and Evening are above, scrolled out of view). Labels now name the button: "Tap Delete Time of Day", "Tap Delete"; ✏ became Edit.

**58 · Fill a new time of day** (`65:717`). Right as drawn: Night starts empty with "Drag a habit here", Bed on time lifts out of Evening and drops into Night, Evening loses it, and the banner says "Bed on time moved to Night · Undo". Fixed: the first arrow and label were still named ✏; now "Tap Edit".

**59 · Several reminders in one time of day** (`1714:66792`). Right as drawn: Meds shows 8:00 AM, then 11:00 AM once 8:00 has gone, and 11:00 AM stays after it passes (screens 2 and 3 alike on purpose). Fixed: the last note said "A habit in two times of day shows each one's own reminders on its own row", which the 6 Nov rule (a habit sits in one time of day, A118) ended; the sentence is gone.

**60 · Milestone on the row: a check** (`107:2`, first of the right-hand column, which runs 60–87). Right as drawn: Meds 29 → 30, the day goes 4/13 → 5/13 and Morning 3 → 2 left, the band "30 days in a row" sits under Undo · Note, and later Undo · Note go while the band stays. Nothing to fix. (The band's medal is the design system's 16 pt Medal star and reads as a small red disc at this size; it's the shared row component, left as it is.)

**61 · Milestone on the row: an amount** (`107:544`). Right as drawn: Water 7/8 → 8/8 with the band "30 days in a row" and the day 4/13 → 5/13, then 9/8 with nothing played again. Fixed, all three screens: Meds, the last row of Morning, looked like a card of its own under the section, because Skincare above it still had a last row's settings (24 pt bottom corners, no separator). Skincare now has a middle row's 4 pt corners and its separator.

**62 · Milestone on the row: a timer** (`107:1091`). Right as drawn: ▶ opens the timer sheet (Day Details, the ring, Log Time and ⏸), ✕ leaves the clock on the row at 6:42 of 10 min, and at 10:00 the row fills, ⏸ takes the habit's colour, the band rises, the day goes 4/13 → 5/13 and Morning 2 → 1 left. Fixed: Stretch showed 🔥4 before the goal and 🔥30 with "30 days in a row" after it; it's 🔥29 before now (screens 1 and 3). Meds looked like a separate card again (Skincare had a last row's corners and no separator; screens 1, 3 and 4). The label "✕" is now "Tap ✕".

**63 · Milestone on the row: a checklist** (`107:1654`). Right as drawn: ⌄ opens the steps, Serum ticks to 2/4 with Undo · Note, and the last step makes it 4/4 with the band above the open steps, the day 4/13 → 5/13 and Morning 2 → 1 left. Fixed: Skincare showed 🔥12, then 🔥30 with "30 days in a row"; it's 🔥29 before now (screens 1–3). Meds looked like a separate card on every screen: on screen 1 Skincare had a last row's settings, and on screens 2–4 the open steps had 24 pt bottom corners. Both now have 4 pt corners, and the last step, Sunscreen, has its separator above Meds (screen 4 already did).

**64 · Milestone on the row: quit, no tap** (`107:2429`). Right as drawn: nothing opens on its own; when Quitting comes on screen, Smoking's "30 days clean" band rises once, and Coffee reads "0 of 2 cups max". Fixed, across the page: every Today screen that shows Quitting (24, in this flow and in the quit, cut-down, slip and milestone flows) drew it by renaming the Anytime section, so Anytime (Read, Call family, Water) disappeared; here screen 1 had Anytime and screen 2 had Quitting in its place. The Today component (`582:5843`) now holds a hidden "Section · Anytime (above Quitting)" (`4470:120961`) before that slot, turned on in those 24 screens. The list is anchored at the bottom, so Quitting and anything drawn over it stayed exactly where it was (checked on every screen; swipe screen 770:20309 looked at).

**65 · Milestone bar: one milestone** (`108:2`). Right as drawn: Meds 2 → 3 with the day 4/13 → 5/13 and Morning 3 → 2 left; Meds' bar ("3 days in a row · Meds", medal, See, the shrinking line) rises above the day bar in the habit's red with no ✕; after 5 s it goes and the band "3 days in a row" takes its place in the row. Nothing to fix.

**66 · Milestone bar: the next one replaces it** (`108:561`). The idea stays: two milestones close together, Meds then Stretch, one bar at a time, the new one replacing the old. Fixed: Stretch started already past its goal (10:02 of 10 min, filled, 🔥2), Morning counted it done (2 left) while the day didn't (4/13), and its milestone waited for a tap on ⏸, against flow 62's rule that a timer's milestone plays when the clock crosses the goal. Now Stretch runs at 9:52 then 9:56 (neutral ⏸, fill to match; Morning 3 → 2 left), reaches 10:00 by itself on screen 3 (🔥3, ⏸ in its colour, Morning 1 left, day 6/13) and keeps counting on screen 4 (10:05) with its band. Meds keeps Undo · Note on screens 3 and 4, since no new log was made. Label "Tap ⏸ on Stretch" → "Stretch reaches 10:00"; screens 1 and 3 renamed to match.

**67 · Milestone: a number reached again** (`108:1308`). Right as drawn: Meds 6 → 7 after a break (it had 7 before), the row fills with "7 days in a row again" and no bar, Morning 3 → 2 left and the day 4/13 → 5/13; later Undo · Note go and the band stays, as in 60. Meds is the first row, so nothing looks detached. Fixed: the second arrow was named "Arrow · 5 s" under the label "Later"; now "Arrow · Later".

**68 · Pop-up: your first milestone** (`110:2`). Right as drawn: Meds 2 → 3, Morning 3 → 2 left and the day 4/13 → 5/13; the pop-up is the Medium sheet with one height (glass ✕, no handle, the 3 badge, "Your first milestone · 3 days in a row · Meds", the next one at 7, All milestones as its one button); after Close the band "3 days in a row" is in the row. Fixed: after Close, Meds had lost Undo · Note although no other log was made; they stay now (as in 66), with the band under them. Screen 3 renamed to say so.

**69 · Pop-up: a month in a row** (`110:592`). Right as drawn: Meds 29 → 30, Morning 3 → 2 left and the day 4/13 → 5/13; the pop-up (30 badge, "30 days in a row · Meds · reached today", next 60 at half its ring, All milestones), then the band in the row. Fixed as in 68: after Close Meds keeps Undo · Note (no other log was made); screen 3 renamed.

**70 · Pop-up: a year in a row** (`110:1179`). Right as drawn: Meds 364 → 365, Morning 3 → 2 left and the day 4/13 → 5/13; the pop-up (365 badge, "365 days in a row · Meds · every day for a year", next 730 at half its ring, All milestones), then the band in the row. Fixed as in 68: after Close Meds keeps Undo · Note; screen 3 renamed.

**71 · Pop-up: weeks of goals met** (`110:1766`). Right as drawn: Call family 2/3 → 3/3 this week, 🔥25 wk → 26 wk, Anytime 2 → 1 left and the day 4/13 → 5/13; the pop-up (26 badge, "26 weeks of goals met · Call family · half a year, week after week"), then the band in the row. Fixed: the next milestone on the pop-up read "52 weeks in a row" under a title of "26 weeks of goals met"; now "52 weeks of goals met" (one line). After Close Call family keeps Undo · Note, as in 68; screen 3 renamed.

**72 · Pop-up: months of goals met** (`110:2353`). Right as drawn: Deep clean 0/1 → 1/1 this month, 🔥5 mo → 6 mo, Anytime 2 → 1 left and the day 4/13 → 5/13; the pop-up (6 badge, "6 months of goals met"), then the band in the row. Fixed: the pop-up said "every month since April", but six months to November start in June; now "since June". Its next milestone read "12 months in a row"; now "12 months of goals met", as in 71. After Close Deep clean keeps Undo · Note; screen 3 renamed.

**73 · Pop-up: a yearly anniversary** (`110:2937`). Right as drawn: Meds ticked, 🔥12 → 13, Morning 3 → 2 left, the day 4/13 → 5/13; the pop-up "One year of Meds" and then the band "One year of Meds" in the row. Fixed: the flow is "started a year ago today" (9 Nov), but the pop-up read "Since 21 October 2025" and the next one "21 October 2027"; now 9 November 2025 and 9 November 2027. The note said "See the year opens the habit's Year in pixels" while the pop-up's one button is All milestones (as on every pop-up); the note now says what that button does, as on 68. After Close Meds keeps Undo · Note; screen 3 renamed.

**74 · Pop-up: quit, from its band** (`111:2`). Right as drawn: Smoking's "30 days clean" band waits in Quitting; tapping it opens the pop-up (grey 30 badge, "Smoking · reached yesterday", next 60 days clean, now 31); Close goes back to the same Today; no counts change. Fixed: Smoking read "Since 27 Sep" (43 days) beside a clock of 31d and a pop-up saying 30 days was reached yesterday; now "Since 9 Oct" on all three screens. Behind the pop-up, Today was missing the Anytime section above Quitting that screens 1 and 3 have, so it showed Skincare, Afternoon and Evening instead of the same place; it now matches. The first arrow was named "Tap See" under "Tap the band"; renamed.

**75 · Pop-up: cut down, from its band** (`111:714`). Right as drawn: Coffee's "30 days within the limit" band waits under its row ("0 of 2 cups max"); tapping it opens the pop-up (30 badge, "Coffee · yesterday, no more than 2 cups", next 60); Close goes back to the same Today; no counts change. Fixed as in 74: Smoking read "Since 3 Oct" beside a 19d clock; now "Since 20 Oct" on all three screens. Behind the pop-up Today lacked the Anytime section above Quitting and showed another place; now it matches screens 1 and 3 (its layer, named after a Smoking flow, renamed). The first arrow "Tap See" renamed "Tap the band".

**76 · Pop-up: from a bar's See** (`111:1426`). Right as drawn: tapping ✓ on Meds plays the "25 times in total" bar (Morning 3 → 2 left, the day 4/13 → 5/13); See opens the same pop-up (25 badge, next 50, "25 so far"); Close leaves the band. Fixed: Meds read 🔥57 → 58 days in a row against 25 times in total, which can't both be true; it's 🔥11 → 12 now. Behind the pop-up the band wasn't in the row, though the note says See puts it there; it is now, and after Close Undo · Note stay (as in 68). Screens 3 and 4 renamed to match.

**77 · Pop-up: back to your best** (`111:2209`). Right as drawn: Meds 13 → 14 (its best before a break), the bar, then See opens "14 days in a row, again · Meds · back to your best run" with the next at 30; Morning 3 → 2 left and the day 4/13 → 5/13. Fixed: screen 3 was named "Tap the band" under the label "Tap See"; renamed to say the bar goes and the band is in the row, as in 76. Meds kept Undo · Note only until See; it keeps them on screens 3 and 4 now (no other log was made).

**78 · Pop-up: quit, back after a slip** (`111:2992`). Right as drawn: Smoking's "30 days clean again" band; tapping it opens "30 days clean, again · Smoking · back to your earlier run", next 45 (its best); no slip mentioned; Close goes back; no counts change. Fixed as in 74: "Since 3 Oct" beside a 30d clock is now "Since 10 Oct" on all three screens; Today behind the pop-up gets the Anytime section above Quitting so it's the same place as screens 1 and 3 (layer renamed); arrow "Tap See" renamed "Tap the band".

**79 · Reached away: from a widget** (`112:2`). Right as drawn: the widget tap, the milestone reached while the app was closed, the band waiting on Today. Fixed: Water had been dropped into Morning in place of Meds, which left Meds alone under Skincare; Meds is first in Morning again (Done, 🔥58) with the extra copy hidden, Water sits in Anytime (🔥30), and screen 2 scrolls to Anytime with the blue "30 days in a row" band (it had turned red when the slot was reset).

**80 · Reached away: in a folded section** (`112:360`). Right as drawn: folded, nothing shows about the milestone; opening Afternoon plays Refill water's band once; "2 left" and 4/13 agree on both screens. Fixed: the folded Afternoon showed Walk, a book, Water and "+1" (four habits) while the opened section holds Refill water, Walk and Study; the folded icons are now a drop, a walk and Study's graduation cap, in the rows' order and colours, with no "+1".

**81 · Reached away: the milestone notification** (`112:757`). Right as drawn: the notification's words (title names the milestone, the habit's name in its own slot), the pop-up on tap, the band after Close. Fixed: the lock screen said "Wed, 21 Oct", now "Mon, 9 Nov" (today); Smoking said "Since 27 Sep" against a 30-day run, now "Since 10 Oct" on both Today screens; the Today behind the pop-up was scrolled to Afternoon with Anytime-above hidden, now scrolled to Anytime and Quitting as screen 3 shows after Close (layer renamed from a stale "Quitting comes on screen" name).

**82 · Reached away: the milestone notification, phone in use** (`166:2`). Right as drawn: iOS's banner dropping in over the Home Screen with the same words as the lock screen, the same pop-up on tap, the band after Close. Fixed: the Dynamic Island showed a running timer (6:43, Stretch) while Today has no timer running, now off; Smoking "Since 27 Sep" against a 30-day run, now "Since 10 Oct" on both Today screens; the Today behind the pop-up now shows Anytime and Quitting as screen 3 does (layer renamed from a stale name).

**83 · Rule: a pop-up, a bar, then just the row** (`114:2`). Right as drawn: Meds' 30 takes the day's pop-up, Stretch's 3 the bar, Skincare's 7 only its row band; counts 4/13 → 6/13 → 7/13 and Morning 3 left → 2 → 1 → Done agree; Undo · Note follows the newest log. Fixed: nothing beyond the number.

**84 · Rule: two bars, then just the row** (`114:793`). Right as drawn: Meds' 3 and Stretch's 7 take the day's two bars, Skincare's 14 only its row band; each row shows its band once its bar has gone; counts 4/13 → 5/13 → 6/13 → 7/13 and Morning 3 left → Done agree; Undo · Note follows the newest log. Fixed: nothing beyond the number.

**85 · Rule: no more than 2 pop-ups in 7 days** (`114:1551`). Right as drawn: Meds' 30 goes down to a bar because the week's two pop-ups are used; 4/13 → 5/13 and Morning 3 left → 2 left agree. Fixed: after the bar's 5 s Undo · Note had gone with no new log, now kept (Done · just logged · milestone); screen 3's name said See still opens the pop-up, but the bar (and See) has gone by then, so it now says tapping the band still opens it.

**86 · Rule: history added later is never celebrated** (`114:2107`). Right as drawn: today shows Meds with no streak after the missed day; ticking 8 Nov's Meds brings 🔥29 back and plays nothing; 8/13 → 9/13 and Morning 2 left → 1 left agree. Fixed: the day bar said "Yesterday", now "8 Nov" (A119) on both earlier-day screens, and screen 2's name follows; Meds on 8 Nov, a day that ended not done, showed 🔥28, now no streak (A113, ST-1a). Open: 8 Nov's Skincare is 3/4 (unmet) yet shows 🔥12 there and on today; left as drawn, since changing its day changes the counts.

**87 · Rule: undone and done again** (`114:2646`). Right as drawn: Meds' 3 takes a bar; Undo takes the check, the 3 and the band away (5/13 → 4/13, Morning 2 left → 3 left); ticking again brings 🔥3 back and nothing plays a second time. Fixed: nothing beyond the number.

**All Today flows (8–87) reviewed and numbered.** Still to do: earlier-day and later-day titles that assume today is 21 Oct (20 Oct, 22 Oct, 13 Oct in flows at y −8237, −6637, −5037, −1837) and the day bar components' "Yesterday" / "Tomorrow" defaults; then the page of changes Android also needs.

**Date sweep done (9 Nov).** The earlier- and later-day titles in the flows at y −8237, −6637, −5037 and −1837 read 20 Oct, 22 Oct and 13 Oct, and the two day bar components (Screen=Back to today, Screen=Tomorrow) now default to 20 Oct and 22 Oct; no bar on the page says Yesterday or Tomorrow.

**Open, for the user:**
- **Two "todays" on one page.** Flows 11–48 are drawn as if today is Wed 21 Oct 2026 (Smoking "Since 3 Oct", Add log dates of 21 Oct, October calendars, "Back on Wed, 28 Oct"); the milestone flows 73–86 as 9 Nov. Each flow agrees with itself. Moving the early flows to 9 Nov would mean redrawing calendars and weekdays, so it's left for the user to decide.
- **Flow 86:** 8 Nov's Skincare is 3/4 (not met) yet shows 🔥12 on that day and today.
- **Flow 18:** Smoking "Since 3 Oct" beside a 19d clock, left as drawn.
- **Habit row component** still cuts its second line at one line (wrapping it changes every row's height).

## The user's points, 10 November 2026

- [x] **12. One "today" on the whole page: 9 Nov.** Flows drawn as 21 Oct move to Mon 9 Nov (calendars, weekdays, "Since" dates, Add log dates, earlier and later days).
- [x] **13. Flow 86 is a bug:** Skincare ended 8 Nov at 3/4, so no streak on 8 Nov (A113) and none today.
- [x] **14. Flow 18:** keep "Since 3 Oct" and make the clock the right number of days.
- [x] **15. A row's running timer** is Body Regular and looks odd beside the streaks: use the 15 Semibold style.
- [x] **16. The day bar's middle never changes width** (Today and any date alike): it shifted the layout on every ‹ ›.
- [x] **17. Explain the open point about the Habit row component** (its second line cut at one line).

**Done 10 Nov (points 12–17).**
- **One today, Mon 9 Nov.** Every date drawn from 21 Oct moved 19 days on (weekdays two back): 20 Oct → 8 Nov, 22 Oct → 10 Nov, 13 Oct → 1 Nov, "Back on Wed, 28 Oct" → "Mon, 16 Nov", Fri 30 Oct → Wed 18 Nov, Wed 4 Nov → Mon 23 Nov, Add log dates 21 Oct 2026 → 9 Nov 2026, Edit Today's 5 Nov 2026 → 24 Nov 2026, "Paused until 28 Oct" → "16 Nov" (1,270 texts, 8 screen names). The calendar pop-over got November 2026 variants (Any day, today 9; Tomorrow and later, 1–9 greyed), used in flows 22 and 39; flow 22 now taps 18 (Wed, 18 Nov) and flow 39 taps 1 (1 Nov). Flow 41's Gym is on Tue, Thu and Sat, so it's planned tomorrow (Tue 10 Nov) and not today (Mon). Flow 85: "two pop-ups in the last 7 days, on Thursday and Saturday" (Monday and Tuesday couldn't be earlier this week on a Monday); its screen says (Mon). Flow 64's Smoking "Since 27 Sep" beside 30d is "Since 10 Oct". The day bar components default to 8 Nov and 10 Nov.
- **Flow 86 and flow 37:** Skincare ended the earlier day at 3/4, so that day's row has no streak (Screen=Back to today, in the component, with Meds) and today's Skincare has none on those flows' Today screens.
- **Flow 18 and the others with "Since 3 Oct":** the clock is 36d 12:32:45 (3 Oct, evening, to 9 Nov, 9:41), on all 16 rows; screen 1 is "Smoking, 36 days without".
- **A row's run clock** (Habit row's *Run*, every variant) is iOS/Subheadline/Semibold, 15, the style of the streak count beside other rows.
- **Day bar:** its date slot (Day name and ▾) is a fixed 80 wide and centred, wide enough for "28 May", so the ring and the count stay where they are on Today and on every date (in Bottom toolbar, 260 copies follow it).

## The user's points, 10 November 2026 (later)

- [x] **18. A row's second line is only the goal.** Positive habits: today's goal; cut-down habits: the limit ("1 of 2 cups max", "0 of 30 mins max"); quit habits: since when (the start, or the last slip). "Limit reached" and "Over the limit" don't belong in that line: they're an indication of progress, the job a fill does for a positive habit, which a cut-down habit doesn't have. Research and find another way to show "you've reached the limit" and "you've gone past it" (flows 47 and 48), and make the two consistent.
  - First try, rejected (the user, 10 Nov 2026: "don't replace the streaks text or in the place of it … for milestones, we have a band … let's use something like that"): the words in the trailing slot, where a quit row shows its clock.
  - **Done, waiting for the user's look:** a **Limit band** in the Habit row component (`571:277`, properties *Show limit band* and *Limit words*, on To do and Quit or cut down · just logged). The milestone band's place and size (32 tall, under the row, words at the text's edge) but neutral, so it never reads as a milestone or a warning (Android A41: never red, no warning): Tertiary System Fill, Label words, the `hourglass` symbol (Screen Time's limit symbol), no medal, sheen or sparkle. "Limit reached" at the max, "Over the limit" past it. The goal line now reads "2 of 2 cups max", "3 of 2 cups max", "30:00 of 30 mins max", "42 of 30 mins max".
  - Flows 47 (screens 2, 3, 4) and 48 (screens 4, 5) use it. **Consistency fix:** past the limit both rows hide the streak (the day can't end within max, A113); flow 48 had kept 🔥7 while flow 47 hid it. At the limit the streak stays (a day at the max is within max, A23).
  - Review evidence (`Research/Temp/limit-indicator/`): users want going over shown plainly and never treated as success (Grit #12778092747 "200%", Loop `05abe6c1-13db-4234-8299-9eac9d0d6e65`, Habitify `432e23c9-c1d1-4eca-8baf-6322aae86520`), and the day not counted when over (Do Habits #1920668030, Today #1448646478, HabitNow `300a2b80-105d-43b9-950c-a333a431d1cc`). Where to put the indicator was reasoned from first principles and the user's band idea.
  - Not changed: Day details still says "Limit 2 cups · Over the limit" in its card (another surface).
- **Water's streak below its goal** (the user, 10 Nov 2026, found while reviewing Day details): Water's done default is
  🔥23, which counts today, so a Water under 8 of 8 on today says **🔥22**. 28 rows on today's screens; the 10 Nov
  screens left as they were.

