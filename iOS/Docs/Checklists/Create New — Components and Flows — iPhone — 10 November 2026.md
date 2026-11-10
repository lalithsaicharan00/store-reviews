# Create New — Components and Flows — iPhone — 10 November 2026

Written by Claude (Claude Code), 10 November 2026, from the user's request on Figma's **create new** page (`381:2`) and its
components section (`1061:2015`) in the iOS file. Worked as a loop, one minute apart, **one component or one flow at a
time, every screen looked at** (the user: "one thing at a time, one flow at a time, and in each flow check, is every
screen properly there or not … each and every detail matters").

## The user's points

- [x] 1. Remove the Plus badges from the components: Checklist (How Do You Want to Track It?) and If not done, remind
  again (Reminders). Both are free.
- [x] 2. The Colour sheet: one colour is cut off. Fix it.
- [x] 3. The Icon picker: some icons draw twice (a white and a black one on the coloured tile). Keep the full page, but
  make the picking itself as in Reminders' New List: filled and outlined icons, and the chosen one ringed.
- [x] 4. Delete the Plus flows from create new, and any other flow that's no longer needed.
- [x] 6. Number the flows on from the Details page's last, 214 (the user, 10 Nov 2026: "We are not continuing that numbering here from 215").
- [x] 5. Update every remaining flow, one at a time, every screen checked (215 to 242, 10 November 2026).
- [x] 7. All Day, Anytime and times of day with no set time (the user, 10 Nov 2026; Rulebook, Android A120): All Day built in at the very top for habits
  with several reminders (they go there by themselves); Anytime and All Day each with a description; a time of day the person makes can have no set
  time; Ends chosen like Starts. Page components only, no flows yet.
- [x] 8. "Time of Day" becomes "Routine" (the user, 10 Nov 2026), in the components first. The flows follow with point 5.
- [x] 9. The switch's name and its line, which confused ("it's never Now … above Anytime").
- [x] 10. All Day and Anytime: Delete greyed out in Edit Routine.

## Step by step

- [x] **Plus badges in the components.**
  - How Do You Want to Track It? had two variants: Plan=Free (Checklist with a Plus badge) and Plan=Plus (no badge).
    The badge variant is deleted, and the one left is State=Default.
  - Reminders page lost "Reminders=On · free plan" (the Plus badge under Never). Its one copy is now Reminders=On.
  - Both sets' descriptions now say everything on them is free. No other Plus badge is switched on in the section.
- [x] **The Colour sheet.** In flow 3's screen 5 the sheet's copy had kept old spacing (16 at the sides, 3 between
  swatches), so seven 44-wide swatches needed 330 of the 312 it had and cyan was cut off. In the main (`1074:161496`)
  the swatches sit 18 from each side with no gap between their 44 tap areas (the circles inside still have room), so
  seven fit exactly and both rows line up in columns. Its one copy is set the same. The screen's name said "a sheet of
  14": it's 13.
- [x] **Icon picker, part 1: what Reminders does, and the tile.**
  - Reminders on the Simulator (iOS 26.5) opens New List with the colour row only: lists on the phone alone, without
    iCloud, get no icons. So the icon grid can't be read there, but the colour row's selection can: a grey ring set 2
    outside the circle, which is what our Colour swatch already draws.
  - The picker's tiles were copies of Today's Round button: the chosen icon took the habit's colour (and in flow 3 two
    tiles were coloured, the old star with a black symbol and the new book with a white one). That button is for
    logging, not for choosing.
  - New component **Icon choice** (`4748:34294`, beside the Icon picker): a 48 tap area, a 38 grey circle (Tertiary
    System Fill), the symbol in Ink at 20, and for Selected=True the Colour swatch's grey 3-point ring round it. A
    Symbol text property holds the character.
  - The new picker's 66 symbols, filled and outlined side by side where SF Symbols has both, were matched to SF Pro's
    codes with the icon table's method (`Research/Temp/ios-icons/picker_codes.json`); each outline is one code below
    its filled version.
- [x] **Icon picker, part 2: the page.** In the main (`1074:932`) every group's rows became one grid of Icon choice
  tiles, six to a row, 8 apart: Health 18, Fitness 12 (most figures come in one style only), Mind 18, Home 18. Filled
  and outlined sit side by side (heart, heart; drop, drop …). The star is the chosen one in the main, ringed. Done was
  a dark Prominent button: it's plain glass now, as Add and Save are. The page's two copies (flow 3, screens 2 and 3)
  follow: screen 3 has the book ringed and nothing coloured. Flow 3's note says so. The Rulebook has the decision, and
  the icons doc's "always `.fill`" is marked as replaced.
- [x] **What Do You Want to Do? (`1061:2016`) and Quit or Cut Down? (`1061:2101`).** Looked at: ✕ on the first
  page and ‹ on the second, title case titles, one card of rows (icon, headline, line, chevron), and Quit and Cut
  Down's examples as chips. Nothing cut off, overlapping or out of line; no change.
- [x] **What Kind of Task? (`1109:2`) and Allow Notifications? (`1164:344717`).** Looked at: Once and On Repeat with
  their examples, as the other choice pages; iOS's own alert over Reminders with Remind me on, Apple's words, Don't
  Allow and Allow side by side. No change.
- [x] **Create New form, part 1: Check It Off, Track an Amount, Time It, Checklist.** Looked at each: the name,
  Description, Icon | Colour, the type's own row (How much, How long, Steps), How often, Time of day, Reminders, Starts
  and Ends. Fixed: Track an Amount, Time It and Checklist were 814 tall (their Home Indicator sat at 780, under a
  longer Content); all three are 800 like the rest, and every variant's Home Indicator is pinned to the bottom.
- [x] **Answered (see the user's answers at the end): form rows' capitalisation.** The title-case decision covers titles, buttons and
  menu rows. The form's row labels are sentence case (How often, Time of day, Remind me), while Reminders' own detail
  rows are title case (Date, Early Reminder). Not changed: it would touch every form in the file.
- [x] **The Plus flows are deleted, and the flows are numbered (point 4, point 6).** A sixth habit on the free plan,
  A checklist on the free plan and Remind again on the free plan are gone (42 layers: headers, screens, labels,
  arrows and notes), and the flows under them moved up 4,800 to close the gap. The 25 flows left are numbered on from
  the Details page's 214: **215 · A new habit: check it off** to **239 · The habit form at 200% text**, the header's
  text and its layer name alike. Nothing on the page mentions Plus or the free plan now. Any other flow found not to
  be needed is deleted as its turn comes.
- [x] **One Time of Day page, in one place (the user, 10 Nov 2026: "Why we have multiple … All of these should be in
  the same parent component section … we don't want duplicate components everywhere").** There were three: create
  new's Time of day page (the habit form), a second main of its own in the settings components section for Settings ›
  Times of Day (out of date), and Edit time of day, also in settings components.
  - Now one set, **Time of day page** (`4754:46072`), in create new's components section: *Opened from=A habit*
    (`1098:2071`, the habit form's one choice, Checkmark rows) and *Opened from=Settings* (`4754:45895`, the same
    times as rows with ›, New Time of Day under them and a footer). Both have a hidden spare row (Before work,
    4:00 AM – 6:00 AM) for flows that add one.
  - The 8 Settings copies now use the Settings variant, each still showing its own state: Morning at 7:00 AM, Morning
    deleted with Undo, and Before work in time order. Looked at, each one right. The old main had no copies left and
    is deleted.
  - **Edit time of day** (`830:265`) moved beside it. Its 19 copies (Today, create new, Settings) still point to it.
    The settings components section closed the gap.
  - Searched every page for a time-of-day page that isn't one of these copies. There are none. Today's Add Time of Day
    is a row of Edit Today, which is another component.
  - **For the flow pass (point 5):** create new's flows still show more than one time of day picked ("1 · Time of
    day: Morning; tap Evening too", "2 · Morning and Evening …", "6 · … says Before work, Morning and Evening"),
    which A118 rules out. Also, "5 · Add: Before work is in the list, chosen" shows Anytime ticked. Fix them when
    their turn comes.
- [x] **All Day, Anytime and times of day with no set time: the page components (point 7).** Looked at Calendar's New
  event and Reminders' Details on the Simulator (iOS 26.5) first. Calendar's All-day is a switch row at the top of the
  card that holds Starts and Ends, and on, it drops their times. Reminders' Time is a switch, and on, the time shows
  under it.
  - **Edit time of day (`830:265`)** has Mode, Time and State now, five variants. Edit · Set (`830:103`) and its Error
    (`830:187`); Edit · None (`4761:33039`, "Meds"); New · Set (`4761:33352`); New · None (`4761:33668`).
    - The Time card starts with an **At a Set Time** switch.
    - Ends is a time picker like Starts (12:00 PM), no longer a line saying when the next one starts.
    - Off, Starts, Ends and Your day go, and the footer says it's never Now and sits just above Anytime on Today.
    - **New Time of Day** is the missing page: ✕, Add, a Name placeholder, no Delete, and Your day with the new one
      marked New.
    - The switch row made the pages too long (Delete was cut off at the bottom). The "Habits can still be ticked at any
      time …" footer and New's "This is your day once you add this one" are hidden, and every variant ends above the
      Home Indicator (748, 774, 746).
  - **Time of day page (`4754:46072`).** All Day is first, *For habits with several reminders*. Anytime follows, *For
    habits with no set time*. Settings' footer says you can add your own "with a set time or without one". It no longer
    says each ends when the next starts.
    - New variant *Opened from=A habit with several reminders* (`4763:36841`): All Day ticked, every other row dimmed,
      and a footer saying why and how to choose another.
  - **Checkmark row (design system, `4081:2531`)** got an Enabled property. Its four Enabled=False variants have Tertiary
    Label words, and are bound to the set's properties like the others (a hand-made variant had lost them).
  - **The flows weren't touched, as asked.** The copies already show the changes: All Day on top and the switch row.
    Their own texts (Ends' "when Afternoon starts", Anytime ticked) get fixed with point 5.
- [x] **Routine, Set a Time, and built-in routines can't be deleted (points 8–10, one at a time).**
  - **Renamed in every component** (32 words on create new, 3 in Settings, 4 in Edit Today), each checked on screen:
    - The habit form's row is **Routine**, and its page title is Routine.
    - Settings' row and page are **Routines**.
    - The actions are New Routine, Edit Routine and Delete Routine, and Edit Today has **Add Routine**.
    - The sets are named Routine page and Edit routine, and Edit Today's variant is Empty routine.
    - The flows' own words are left for point 5.
  - **The switch is Set a Time,** like Focus's "Set a Schedule", and it's off on a new routine. The line under it, shown
    only when it's off, reads "Turn on to choose when this routine starts and ends." The old line about Now and Anytime
    is gone.
  - **Built in (`4767:33823`):** Edit Routine for All Day or Anytime has Delete Routine greyed out (Tertiary Label).
    Settings' All Day and Anytime rows now have a › to open it.

## Routines as their own thing (the user, 10 Nov 2026; Rulebook; Android A121)

Worked by a one-minute loop, one step a tick, every screen looked at. After these, the Create New flows (point 5) go on.

- [x] 1. Write the decisions down: the Rulebook, Android A121, this list.
- [x] 2. Create New's first page (What Do You Want to Do?, `1061:2016`): a Routine choice. **Add a Routine** (`4768:33394`), in a card of its
  own under the habit and task choices, 24 below them: `list.bullet`, "Habits you do together, like a bedtime or weekend routine.", and a ›. It's last because
  making habits is what people do most, and a routine holds them. Looked at: nothing cut off, it lines up with the rows above.
  - The first line said "like Morning or Meds". The user asked what that meant: as bare names, the examples didn't read as routines. The line now
    names them as routines. A first fix said "a morning or bedtime routine", but Morning is already in the app (the user: "Morning routine will
    be already given in the app by default … Use anything else"), so the examples are ones a person would make. Workout was next, but it's already the checklist habit's example (the
    user: "use something better"). "Before-work" took the line to three rows where the others have two, so it's bedtime and weekend.
- [x] 3. The banner: *“Meds” created · Undo*, from the app's Banner component (`4663:227469`, Buttons=One: Text "“<name>” created", Action Undo).
  No new component was needed. Tried with "“Meds” created" (215 wide) and a long name, "“Before breakfast” created" (291 wide). Both fit well
  inside 360 with nothing cut off. The test copies are deleted. The flows put it where the person made the routine (step 7).
- [x] 4. Habits & Tasks › Habits (the page component): Edit on the right of every routine heading, and how an empty
  routine looks there.
  - **Habits page set (`986:150825`):** every routine heading (Morning, Afternoon, Evening, Anytime) has **Edit** on its right in all 10 variants
    with a list (30 headings), the same Small Borderless button as Edit Today's. The heading's words keep their place. Quitting and Paused
    aren't routines, so they have none. At large text, Edit uses Accessibility 1 Subheadline to match the heading.
  - **New variant Screen=Routine added (`4773:178866`):** the page after making a routine. Bedtime, a routine the person made, shows with Edit
    and "No habits yet" under it, and the banner *“Bedtime” created · Undo* sits 12 above the bottom bar.
  - **Decided here, check with the user:** a routine the person made shows even with no habits, so it can be found and edited; a built-in one
    with no habits isn't shown. A routine with no set time sits after the timed ones and before Anytime.
  - Looked at Week, Large text and Routine added: nothing cut off or overlapping.
- [x] 5. Settings (the component): the Routines row goes.
  - Removed from all three variants of Settings (`1173:547`): Default, End of the list and Nothing set up. Your day now holds Day Starts At
    (First) and Week Starts On (Last), so the rounded corners are right. The set's description says why the row is gone. Looked at all
    three: nothing cut off.
  - The Routine page's *Opened from=Settings* variant (`4754:45895`) has nothing in Settings to open it now. Its copies are in Settings' flows
    (step 6) and go or move with them; the variant goes once nothing uses it.
- [x] 6. Settings' routine flows: move them to the Habits tab (Edit by a heading → Edit Routine), or delete what's no
  longer needed.
  - Settings had four: Edit a time of day, A new time of day, Delete a time of day, and Leaving Edit Time of Day with changes.
  - **A new time of day is deleted** (16 layers): a routine is made from Create New now, and step 7 draws that.
  - **The other three moved to the Habits & Tasks page** (`269:148`), under flow 190, 1,600 apart as the page's flows are: Edit (y 62,200,
    `1183:11921`), Delete (63,800, `1183:368079`) and Leaving with changes (65,400, `1183:368648`). Their screens, notes and arrows came
    with them unchanged; 6a to 6c below rewrite them.
  - Settings closed the 6,400 gap: Day Starts At and everything under it moved up.
  - **Numbering:** the Habits page's flows are 156–190, and 191 onwards belong to Details. The moved flows have no number for now. Numbering
    them is left for the user.
- [x] 6a. Edit a routine (from the Habits tab): Habits page › Edit by Morning › Edit Routine › Starts › Save › the Habits page, with the
  new words and Set a Time.
  - **Edit a routine** (`1183:11921`) is five screens now, not six. *1 · Habits: tap Edit by Morning* (the Habits page, Week) replaces
    Settings, and the Routines list screen in between is gone: Edit goes straight to Edit Routine. Then *2 · Edit Routine: tap Starts*,
    *3 · Starts: the time wheels at 7:00 AM*, *4 · Starts 7:00 AM: tap Save* and *5 · Habits: Changes saved*, back on the Habits page.
  - Fixed on the way: screen 4's Starts capsule still said 6:00 AM (now 7:00 AM, with Your day's line), and the Changes saved banner sits
    12 above the bottom bar.
  - Notes say routine instead of time of day. Screen 2's note replaces "Ends follows the next one's start": Ends is already set, so a new
    Starts leaves it (A120). The header bar is 2,600 wide to match.
  - Looked at all five: Set a Time is on, nothing cut off, the arrows' words are Edit, Starts, OK and Save.
- [x] 6b. Delete a routine: Habits page › Edit › Delete Routine › the alert › the Habits page without Morning, and Undo.
  - **Delete a routine** (`1183:368079`), four screens: *1 · Habits: tap Edit by Morning* (was the Routines list), *2 · Edit Routine: tap
    Delete Routine*, *3 · Delete Morning?* and *4 · Habits: Morning deleted, Undo* (was the Routines list). On 4, Morning's heading and its
    habits are hidden in the copy, so Afternoon is first. The banner *Morning deleted · Undo* is centred 12 above the bottom bar.
  - The alert said "Its 4 habits", but Morning has 3 on the Habits page (Stretch, Skincare, Meds). It says 3 now. Cancel and Delete only (D9).
  - Notes: Edit opens Edit Routine; All Day and Anytime can't be deleted, theirs is greyed out; the habits go to Anytime here and on Today.
  - Looked at all four: nothing cut off.
- [x] 6c. Leaving Edit Routine with changes: Habits page › Edit › renamed › ✕ › Discard? › the Habits page unchanged.
  - **Leaving Edit Routine with changes** (`1183:368648`), four screens: *1 · Habits: tap Edit by Morning* and *4 · Habits: Morning
    unchanged* replace the Routines list; *2 · Renamed “Early morning”: tap ✕ (or Back)* and *3 · Discard your changes?* were already
    right (Keep Editing and Discard, "Morning stays as it was."). The header and notes say routine; the first arrow's word is Edit.
  - Looked at all four: nothing cut off.
- [x] 7. New flows: Create New › Routine, with a set time and without one, ending in the banner.
  - **240 · A new routine with no set time** (y 41,256, from the Habits tab): *1 · Habits: tap +*, *2 · What Do You Want to Do?: tap Add a
    Routine*, *3 · New Routine: typing “Bedtime”; Add is ready* (keyboard up, Set a Time off), *4 · Habits: “Bedtime” created* (the Routine
    added variant: Bedtime with Edit and No habits yet, and the banner).
  - **241 · A new routine at a set time** (y 42,856, from Today): *1 · Today: tap +*, *2 · What Do You Want to Do?*, *3 · New Routine: typing
    “Before work”*, *4 · Set a Time on, Starts 4:00 AM: tap Add* (Ends 6:00 AM, Your day shows Before work marked New), *5 · Today: “Before
    work” created*. The two flows start from both places that have +.
  - **Fixed in the design system first:** Edit routine's two New variants had their name text unbound, so a copy couldn't show a typed name.
    It's bound to Name now (hidden by default; the placeholder shows). A copy swapped from the habit form also kept the title "New Habit":
    set back to New Routine.
  - **My assumption, check with the user:** Today shows a routine only once it has a habit, so 241's last screen is Today unchanged with the
    banner.
  - Looked at all nine screens: nothing cut off; the banners sit 12 above the bottom bar.
- [x] 8. Other pages' flows that use the routine pages (Today's Edit Today, Create New's habit form): words, All Day,
  Set a Time. Split into the parts below once Today was looked through: four of its flows edit routines (54, 55, 57, 58), and
  about 15 notes across Today still say "time of day".
- [x] 8a. Today 54 · Change a routine (was "Change a time of day"). Header, note and screen 3's name say routine. Screen 5's Starts
  capsule still said 6:00 AM after turning the wheel to 7: it says 7:00 AM now, with Your day's line. Looked at screens 3, 5 and 6.
- [x] 8b. Today 55 · Add a time of day: Edit Today › Add Routine. Its three screens use Edit routine's *Edit* variant with a
  "New Time of Day" title and the old "Habits can still be ticked …" footer: swap to the *New* variants, words, and Set a Time.
  - **55 · Add a routine** is four screens now: *1 · Today*, *2 · Edit Today*, *3 · Tap Add Routine: New Routine, type “Bedtime”* (the New
    variant, Set a Time off) and *4 · Tap Add: Bedtime appears, after Evening*.
  - It used to add Night at 10 PM – 12 AM, cutting Evening back to 10 PM: the old "each ends when the next starts" rule. Ends is chosen
    now, so Night would overlap Evening, and how overlaps work isn't decided. So the example is Bedtime with no set time, which sits after
    the timed routines. The two time-wheel screens went with it.
  - **Edit Today's Empty routine variant (`827:39487`):** Night · 10 PM – 12 AM became Bedtime, and Evening is 6 PM – 12 AM again.
  - Screen 3 kept a hidden "This is your day once you add this one." line from the old copy; it's hidden again.
  - Looked at screens 2, 3 and 4: nothing cut off.
- [x] 8c. Today 57 · Delete a time of day: words, and the alert's habit count.
  - **57 · Delete a routine**: header, note, screen names and the arrow's words (Tap Delete Routine) say routine. Morning has 4 habits on
    Today (Meds, Stretch, Skincare, Meditate), so the alert's count was right. Its words now match the Habits tab's: "Its 4 habits move to
    Anytime. Their logs, notes and streaks stay."
  - The last screen had no way back. It has the Habits tab's *Morning deleted · Undo* banner now, 16 above the Home Indicator (Edit Today has
    no bottom bar).
  - Looked at screens 3, 4 and 5: nothing cut off.
- [x] 8d. Today 58 · Fill a new time of day, and the other notes on Today that say time of day.
  - **58 · Fill a new routine**: Night became Bedtime (it follows 55): screen names *2 · Bedtime is empty*, *3 · Dragging Bed on time into
    Bedtime*, *4 · Dropped: Bed on time is in Bedtime*. The banner says "Bed on time moved to Bedtime · Undo" and is centred again; the
    longer name had pushed it 10 off centre. Looked at all three.
  - **12 notes on Today** in flows 17, 23, 28, 38, 40, 42, 49, 51, 53 and 60 said "time of day" or "times of day". They say routine and
    routines now; each was read after the change. Flow 59's notes are left for step 9, which redoes it.
- [x] 8e. Create New's habit-form flows (215–239): the Routine row and page, A118's one choice (flows showing several ticked), and
  Anytime ticked where it shouldn't be.
  - Looked through every flow on the page: only 215 and 221 open the routine pages, and notes in 215, 229, 230, 231 and 233 said time
    of day.
  - **215 · A new habit: check it off:** *6 · … tap Routine*, *7 · Routine: one choice, Morning*, *8 · ‹: Routine says Morning; tap Add*,
    and the arrow's word is Routine. Screen 7's page kept an old "Time of Day" title and had Anytime ticked while screen 8 said Morning:
    it's titled Routine with Morning ticked now. Its note says one choice, every routine on the page (A118). Looked at 6, 7 and 8.
  - **Notes in 215, 229, 230, 231 and 233** say routine; each read after the change.
- [x] 8f. **221 · Time of day: more than one, and a new one** is built on what A118 ruled out: Morning and Evening both ticked, then
  "Before work, Morning and Evening". Redo it as one choice plus New Routine from the habit form, with the New variant and Set a Time.
  - **221 · Routine: a new one from the habit form**, five screens now: *1 · Routine: Anytime; tap New Routine*, *2 · New Routine: the
    name first, the keyboard up*, *3 · “Bedtime”: Add is ready*, *4 · Add: Bedtime is in the list, chosen* and *5 · ‹: Routine says
    Bedtime; tap Add*. The old second screen (ticking Evening too) is gone and the rest moved left; the header is 2600 wide.
  - Screens 2 and 3 are Edit routine's *New* variant with Set a Time off, the same as Create New's flow 240. The copies kept a Starts row
    from the old Edit variant, showing with the switch off: hidden. Screens 1 and 4 kept a "Time of Day" title: Routine now.
  - Bedtime, not "Before work": Before work would need a time and would overlap Morning, and overlaps aren't decided (as in Today's 55).
    It sits after Evening, ticked alone, with no banner: the tick says it.
  - Header note, arrow words and every note say routine and one choice. Looked at all five screens.
- [x] 9. Any other flow these changes need (for example a habit with several reminders going into All Day). Found on Today:
  **59 · Several reminders in one time of day** shows Meds with 8:00 AM and 11:00 AM in Morning, which A120 now rules out (two
  reminders put it in All Day). It needs redoing with Meds in All Day.
- [x] 9a. **Today 59 · Several reminders: the habit is in All Day.**
  - **Today's component (`582:5843`)** has a hidden *Section · All Day* at the top of Today list: All Day, *1 left*, Start, and Meds
    as its row. A flow shows it where a habit has two or more reminders; the set's description says so.
  - In flow 59's three screens All Day is on, Meds sits there (8:00 AM, then 11:00 AM, as before), and Morning has Stretch and Skincare
    with *2 left*. Header, Who note, the first rule and screen 1's name say All Day; the other two rules still hold.
  - Looked at all three screens: nothing cut off.
- [x] 9b. **Create New: a second reminder puts the habit in All Day.** No flow shows the habit form's side of A120: Routine page's
  *A habit with several reminders* variant (`4763:36841`) is used nowhere. Add a flow: a habit with one reminder, add a second, the
  form's Routine row says All Day, and its page explains why in one line.
  - **242 · A second reminder: the habit goes into All Day** (y 44,456), four screens: *1 · The form: Journal in Morning, one reminder
    at 9:00 AM; tap Reminders*, *2 · Add a Time: 2:00 PM, two times*, *3 · ‹: Reminders says “9:00 AM and 2:00 PM”, Routine says All
    Day; tap Routine* and *4 · Routine: All Day, and why* (the *A habit with several reminders* variant: All Day ticked, the others
    greyed, the line under New Routine). Adding the time itself is left to 222.
  - Nothing asks when Journal leaves Morning: the Routine row says All Day, and its page says why. **My call, not confirmed:** whether
    the form should also say so the moment the second time goes in.
  - **222 · Reminders: turned on** ended with two reminders and Routine still *Anytime*: its last screen says All Day now.
  - Looked at all four screens and 222's last.

## Routines: only Starts is picked (the user, 10 Nov 2026; Rulebook; Android A122)

The user: "we shouldn't allow for overlapping"; "only start will be the time they can pick and the end time will be automatically
adjusted … This will solve all of the problems"; "go ahead and update the designs according to this. It's basically reverting it back
to previous one, but yeah, including the new changes … do it step by step using a loop."

- [x] 1. Write the decision down: Rulebook (A120's bullet), Android A122, this list.
- [x] 2. Edit routine component (`830:265`): every variant with a set time (Edit · Set, New · Set, Built in) has Starts only, no Ends
  row or picker; the line under Starts says when it ends and what moves. Descriptions say so.
  - The three variants with a set time (Edit · Default, Edit · Error, New · Default) hide Ends; Starts is the card's last row. The line
    under the card, hidden until now, is on: *Ends at 12:00 PM, when Afternoon starts.* (Morning), and on New *Ends at 6:00 AM, when
    Morning starts.* (its 4:00 AM example takes nothing from anyone). A flow adds *Morning will now end at 7:00 AM.* where a start
    falls inside another routine.
  - The three variants with no set time (Built in is one of them) say *Turn on to choose when this routine starts.*
  - The set's description says A122: Starts only, no overlaps or gaps, the line, Undo on the banner, and where it's opened from now.
  - Looked at all five variants.
- [x] 3. Create New 241 · A new routine at a set time: Before work at 7:00 AM, its line (*Ends at 12:00 PM, when Afternoon starts.
  Morning will now end at 7:00 AM.*), and what Today shows after (Morning 6–7, Before work 7–12).
  - Screen 4 is *Set a Time on, Starts 7:00 AM: Morning will now end at 7:00 AM; tap Add*: Starts 7:00 AM (the picker's own value
    too), the line in full, and Your day reads Morning 6:00 AM – 7:00 AM, Before work 7:00 AM – 12:00 PM (New), Afternoon, Evening.
  - Screen 5 (Today, *“Before work” created · Undo*): at 9:41 it's Before work's time, so Morning's Start isn't filled any more; Before
    work has no habits yet, so it doesn't show. Its note says so, and that Undo puts Morning back to 12:00 PM.
  - Screen 4's note says Starts only (A122) and what the line does. Screen 3 already says *starts* (step 2).
  - Looked at screens 3, 4 and 5.
- [x] 4. Habits & Tasks' routine flows (Edit a routine, Delete a routine, Leaving Edit Routine with changes): Ends rows, wheels and words.
  - All seven Edit Routine copies took the component's change by themselves: Starts only, *Ends at 12:00 PM, when Afternoon starts.*
  - **Edit a routine:** screen 4's Starts capsule still said 6:00 AM while Your day said 7:00 AM: it says 7:00 AM now. Screen 2's note
    said "Ends is already set, so changing Starts leaves it (A120)": it says Starts only (A122); screen 4's says a later start takes
    nothing from anyone.
  - **Delete a routine:** the alert's note adds that deleting one in the middle makes the one before it run on to the next; Morning is
    the first, so the day's routines start with Afternoon.
  - **Leaving Edit Routine with changes:** nothing about time; unchanged.
  - Looked at Edit a routine 2–5, Delete a routine 2–3, Leaving 2–3.
- [x] 5. Today's routine flows (54 Change a routine, 55 Add a routine, 57, 58) and their notes: Ends rows and words.
  - The Edit Routine copies in 54 and 57 took the component's change by themselves (Starts only and the line). 55's New Routine has
    no set time and says *starts*.
  - **54 · Change a routine:** screen 5's Starts capsule said 6:00 AM while Your day said 7:00 AM: 7:00 AM now. Screen 6 (Edit Today)
    already says Morning · 7 AM – 12 PM.
  - 55 keeps Bedtime with no set time, and 58 has no time. These flows have only a header note, and none mentions Ends.
  - Looked at 54's screens 3–6, 57's 3–4 and 55's 3.
- [x] 6. Search every page for Edit routine copies and notes that still show or mention Ends, a chosen end, or overlaps; fix each.
  - Edit Routine copies: 5 on Create New, 6 on Today, 7 on Habits & Tasks, none elsewhere. None shows an Ends row; every one with a set
    time has the *Ends at …, when … starts.* line.
  - Words searched on every page with routines (Create New, Today, Habits & Tasks, Settings, the design system, the routine player,
    onboarding, the details pages) and in component descriptions: nothing left says "ends when the next begins", "Ends is chosen" or
    "overlap". Create New's *Starts and Ends* (flow 225 and its notes) is a habit's start and end dates, not a routine's: unchanged.
  - Nothing needed fixing, so no screen was touched this step.

## Earlier pages after today's decisions (the user, 10 Nov 2026: "check … have you updated wherever the updates needed in the previous pages that we completed")

- [x] Searched every page for "time of day", "times of day" and "Time of Day" in screens, notes, layer names and component
  descriptions, after Routine (A121), All Day (A120) and Starts only (A122).
  - **Day details:** 2 notes. **Routine player:** 4 notes. **Habits & Tasks:** 6 notes ("as it has no time of day" is now "as no
    routine was chosen"). **Details pages:** 1 note. **Settings:** a note's "like Times of Day" (that page is gone). **Widgets:** 2 notes
    and the List and Setup descriptions. **Design system:** the Start button's and Floating button's descriptions, and the sort menu's
    *By time of day* row, now *By Routine* (its *Your order* and *By name* were sentence case: *Your Order*, *By Name*). **Today:** Edit
    Today's description and an arrow's and label's layer names (*Tap Add Routine*).
  - **Routine page's *Opened from=Settings* variant is deleted:** Settings has no Routines row and there's no routine page (A121); it
    had no copies. The set's and both variants' descriptions say routine, A118, A120 and A122.
  - Looked at the sort menu after the change. Every other change was a note or a description.
  - Already done earlier today: Today's routine flows and notes, flow 59 (All Day), the Habits tab's Edit headings and routine flows,
    Settings' Routines row, Starts only everywhere.

## Point 5: every remaining Create New flow, one at a time, every screen checked

221, 240, 241 and 242 were checked whole while the routines work was done; 222's last screen too. Each flow below: every screen
looked at against today's decisions (Routine, one choice, All Day, Starts only, title case, the new Icon picker) and for anything cut
off, overlapping, stale or wrong; notes and arrow words too.

- [x] 215 · A new habit: check it off
  - Looked at all nine screens. Screens 1–8 right (Routine, one choice and title case were fixed in 8e).
  - **Screen 9 (Today):** Journal had been shown under Skincare with Skincare's rounded bottom corners left on, so the card had a notch,
    and a line under Journal, the last row. Skincare is square with its line now, and Journal has none. Journal also showed 🔥 0: a
    habit added a moment ago has no streak yet, so it shows none.
  - Screen names 2–4 in title case (What Do You Want to Do?, How Do You Want to Track It?, New Habit). Notes: the first page has four
    choices now (a routine goes to New Routine); Add "is ready", not "turns dark" (it's plain glass); "Groups are gone" dropped; the last
    says no streak until it has one.
- [x] 216 · A new habit: leaving it
  - Looked at all six screens: nothing cut off or wrong. The alert (*Discard this habit?*, Keep Editing | Discard) matches Edit
    Routine's; the keyboard goes while it shows.
  - Title case where words name a title or button: screen names *New Habit* and *Keep Editing*, the arrow *+ · Check It Off*, and the
    notes' New Habit, Build or Maintain, Check It Off and Keep Editing.
- [x] 217 · A new habit: its icon and colour
  - Looked at all six screens. The Icon picker (screens 2–3) and the Colour sheet (5) are the new ones, ringed choice, nothing coloured.
  - **Screens 4 and 6 still showed the star in purple:** screen 4 ("Back on the form with the book") shows the book now, and screen 6
    ("the form in orange") shows the book in orange, the Colour swatch orange too (the sheet's own orange style).
  - Notes and arrow words right; no change.
- [x] 218 · How often: several a day, or a number of times
  - Looked at all seven screens: the count, Week | Month | Year and the form's "3 times a month" all agree; nothing cut off.
  - Screen 2's name says *How Often*, the page's title. The arrow *How often* is the form's row, which stays as the row reads (the open
    question on the form rows' capitalisation). Notes right.
- [x] 219 · How often: days of the week, or every few
  - Looked at all eight screens: Every Friday from today's day, then Mon, Wed and Fri; Every other day; Every other week, then on
    Friday with On set days; On the 23rd of every month, and the form says it back. Ticks, counts and words agree.
  - Screens 1 and 8's names say *How Often*, the page's title. Screen 6's last row runs under the Home Indicator, as a long list
    scrolls on the iPhone; left. The form's star in purple is the new habit's default (nothing picked in this flow). Notes and
    arrow words right.
- [x] 220 · How often: on a date each month or year
  - Looked at all six screens: the 23rd by default, then the 1st and 15th; the first Friday on one wheel; Every year on October 23
    on one wheel; the form says it back. Nothing cut off.
  - Screens 1 and 6's names say *How Often*. The arrow *Repeat on ▾ · A weekday* lost Android's ▾ (the iPhone's pop-up button has
    ⌃⌄). Screen 4's note said "from two menus": now *which one (first, second… last) and the day, from one wheel*, as the Wheel
    picker decision says.
- [x] 222 · Reminders: turned on
  - Looked at all seven screens: off by default, iOS asks once, 9:00 AM, the wheels for 2:00 PM, two times in order, and the form
    says "9:00 AM and 2:00 PM" with Routine All Day (A120). Add a Time in title case; nothing cut off.
  - Screen 5's name starts with a capital (*The time wheels*). The last note now says why Routine reads All Day: *With two or
    more, Routine is All Day by itself (A120).* Whether the Reminders page itself should say so is still the open question.
- [x] 223 · Reminders: notifications not allowed
  - Looked at all three screens: the off page, iOS's own alert, then Remind me back off with the line and a Small Bordered
    *Open Settings* (title case). Nothing about routines here; nothing cut off. Notes and arrow words right; no change.
- [x] 224 · Reminders: on time on iPhone, nothing else to allow
  - Looked at all three screens. **Screen 3 (Don’t Allow) showed the plain off page,** "Reminders are off. Turning on Remind me
    asks once…", with no Open Settings, against its own note: now the not-allowed state, as flow 223's screen 3 (*Notifications are
    off for Often Enough…* and a Small Bordered *Open Settings*; the Off variant's hidden button, shown). Its name's apostrophe is
    curly. Screens 1 and 2, notes and arrow words right.
- [x] 225 · Starts and Ends
  - Looked at all seven screens. **The dates never changed:** after tapping 26, Starts still said 23 Oct 2026 on screens 3–7, and
    screen 7 ("Ends says 25 Dec 2026") still said Never. Starts is now 26 Oct 2026 from screen 3 on (the picker's Value), and
    screen 7's Ends says 25 Dec 2026.
  - **Title case:** the Ends menu's row is *On a Date…* (it said "On a date…"; the note already had it), and the arrow word with it.
    Screen 2's name starts with a capital. The calendars, the menu and the notes are otherwise right; nothing cut off.
- [x] 226 · A new habit: track an amount
  - Looked at all six screens (the Unit page whole, 2,296 tall): the type list in title case, the amount form, How Much with the
    decimal pad, Unit (Your own, Create Your Own Unit, then the common ones), 8 glasses with One tap adds a set amount, and the form's
    "8 glasses · each tap adds 1". Routine Anytime; nothing cut off (the keypad covers the last row, as the keyboard does).
  - Screens 3 and 5's names say *How Much*, the page's title. Notes and arrow words right.
- [x] 227 · A new habit: time it
  - Looked at all five screens: the type list, the timed form, How Long with one band across hours and min (10 min marked), 15 min
    picked and marked, the form's "15 min". Routine Anytime; nothing cut off.
  - Screen 3's name says *How Long*, the page's title. Notes and arrow words right.
- [x] 228 · A new habit: a checklist
  - Looked at all four screens: the type list, the checklist form (Steps · None yet), Steps with Dishes, Wipe the counters, Sink and
    a blank Step 4 ready to type, Add Step in title case, and the form's "3 steps". Routine Anytime; nothing cut off. Names, notes
    and arrow words right; no change.
- [x] 229 · A new habit: quit
  - Looked at all six screens: What Do You Want to Do? (with Add a Routine), Quit or Cut Down?, the quit form with Started and Time
    only, the calendar (today and earlier, 20 picked), the time wheels at 8:00 PM, and Started 20 Oct 2026, 8:00 PM. No routine or
    reminders on a quit habit, as its note says; nothing cut off.
  - The last arrow said *Tap outside · Add*, but Add is tapped on screen 6, the end: now *Tap outside*. Today here is 21 Oct, from
    the Date picker's Today-and-earlier variant (Day details' today), where the habit forms use 23 Oct; the flow agrees with
    itself, so the shared picker is left as it is.
- [x] 230 · A new habit: cut down
  - Looked at all six screens: Quit or Cut Down?, the cut-down form (Limit, How often, Reminders; no routine), Limit with Amount |
    Time and the decimal pad, "At most 2 cups", How Often's day, week or month, and "At most 2 cups a week". Nothing cut off.
  - **"Counts as a good day"** (good and bad days are words the app doesn't use, U3): the Limit page's two footers, in the
    component, now say *A day at or under the limit counts toward the streak* (Amount and Time); no copy kept the old words.
  - Screen names: *Quit or Cut Down; tap Cut Down*, *How Often for a limit*. Notes and arrow words right.
- [x] 231 · A new habit: cut down time
  - Looked at all seven screens: Quit or Cut Down?, the cut-down form, Limit's Amount then Time (one band across hour and min, 1 h
    picked), "At most 1 h", How Often's three, "At most 1 h a day". No routine; nothing cut off; the Limit footer is the new
    streak line (flow 230).
  - **Social media had Coffee's cup in brown** on the three forms (screens 2, 5, 7): now a speech bubble (`bubble.left.fill`) in
    Indigo, avatar and Colour swatch alike (the iPhone symbol is Apple's for the iPhone only).
  - Screen names: *Quit or Cut Down; tap Cut Down*, *How Often for a time limit*. Notes and arrow words right.
- [x] 232 · Edit Habit
  - Looked at all eight screens: ⋯ with Edit Habit first, the filled form, How Much at 10, the line "The new goal starts today…",
    Habit details with *Changes saved*, Discard your changes? (Keep Editing · Discard), the name cleared and typed again.
  - **Edit Habit's bar said Add, not Save,** on every screen, against its own notes: the form's button is *Save* on all ten Edit
    Habit and Edit Task copies on this page (flows 232 and 238; the details and Habits & Tasks pages had none left). Greyed while
    the name is empty, as before.
  - Screen 3's name says *How Much*; screen 6's note *Keep Editing*, as the alert says.
- [x] 233 · A new task: for today
  - Looked at all seven screens: Today's +, What Do You Want to Do?, What Kind of Task? (Once · On Repeat), New Task on the name with
    Add greyed, Add ready, the whole task form (Date Today, Time off, Routine Anytime, Reminders), then Today.
  - **Screen 7 put Anytime at the top** (the old "moved to the top" section), above Morning, where screen 1 shows it last: now
    Anytime is in its own place after Evening, with Pick up parcel at its end (3 left), and Morning folded with its own three icons
    (Meds, Stretch, Skincare, no +1) so the new task shows. Where untimed routines sit is still the open question.
- [x] 234 · A task’s date
  - Looked at all five screens: Date Today, the calendar under the row, 30 picked, "Fri, 30 Oct", and Date off with its line.
  - **The Date picker's Today-and-later variant left 21 and 22 enabled** (21 even marked as today, from the Any-day variant) while
    today is 23 and the note says days before today are grey: both are grey Regular in the component now, and all six copies on
    this page follow (flow 225's calendars too).
  - The arrow *(or) Date › No date* is *(or) Date off*: Date is a switch. Names and notes right.
- [x] 235 · A task’s time
  - Looked at all three screens. **Screen 2 (Time turned on, the wheels open) still showed Time off:** its Time row is now on with
    "2:00 PM", as screen 3, and the wheels sit 16 lower so they no longer touch the line under the group (top at 508, ends 712).
    Its name starts with a capital. Notes and arrow words right.
- [x] 236 · A repeating task
  - Looked at all six screens: What Do You Want to Do?, What Kind of Task?, the repeating form (How often, Time, Routine,
    Reminders, Starts and Ends; no Date), How Often for a task with A while after it's done, 2 weeks after it's done, and the form
    saying it back. Nothing cut off.
  - Screens 3 and 6 were 862 tall where every screen is 800 (empty space under the form): 800 now. Screen names and notes say the
    choices as the pages do (*What Kind of Task? Tap On Repeat*, *Add a Task*, *How Often*), in flow 233's names and note too.
- [x] 237 · A new task: leaving it
  - Looked at all seven screens: Today, the two choice pages, New Task with Add greyed, back on Today with nothing asked, Discard
    this task? (Keep Editing · Discard, its question in sentence case), and Today unchanged (4/13). Nothing cut off.
  - Screen names and notes say the pages' words: *What Do You Want to Do? Tap Add a Task*, *What Kind of Task?*, *New Task*,
    *Once or On Repeat*, *Keep Editing*.
- [x] 238 · Edit Task
  - Looked at all seven screens: Tasks with the task's ⋯, Edit Task with *Save* (fixed with flow 232), the calendar with days before
    today grey (fixed with flow 234), "Tomorrow · Sat, 24 Oct", back on Tasks under Tomorrow with the banner, the name cleared
    with Save greyed, and Discard your changes? Nothing cut off.
  - The ⋯ menu's row said *Move to another day…*: now *Move to Another Day…*, as Habits & Tasks has it. The last note says
    *Keep Editing*.
- [x] 239 · The habit form at 200% text: the form (screen 1) was right, its rows at Accessibility 1 with Icon and Colour
  stacked as two rows. **How Often at 200% (screen 2) was drawn at ordinary text size:** its variant
  (How often page, Option=Every day, Text=200%) kept every row's label at Body 17. Fixed in the component: labels
  are iOS/Accessibility 1/Body/Regular (28/34) and grow in height, the checkmark is 28, and long choices (Times a
  week, month or year; On certain days of the week; On a date each month or year) wrap onto two lines with the
  page running past the screen. Screen renamed "How Often at 200%…"; its note now says rows grow and the page scrolls.

## The user's answers to the open questions (10 November 2026)

The user: "whatever the Apple does … let's use that"; "a routine with no habits … in the habits tab under it, it should show … but not in today"; "by default, all day will be at the top … routines with no set time will be shown above anytime, and below the last routine that has set of time"; "when someone sets multiple reminders, yes, we do need to remind them … it should be in all day"; "whatever the flows that numbering needs to be updated, then update it"; "User cannot delete them as well as cannot edit their name. So it's a built-in, it's a fixed thing." Written down as Android A123 and in the Rulebook.

- [x] 1. Form rows in title case, as Apple's forms are. In the components: How Often (every Create New form variant), How Much,
  How Long; on Reminders, Remind Me, Remind Me With, If Not Done, Remind Again, Reminder Says (optional), Open Settings, and the
  Off footer's "Turning on Remind Me"; on How Much, Each Tap Adds. Section headers (Remind me at, How, Quick picks) and values (Every
  day, Never) keep sentence case. Create new's arrow words, notes and screen names that name these rows follow (28 texts, 25 names), and
  the notifications page's "Remind Me With" (a note and a screen name). Looked at a Reminders screen and the amount form.
- [x] 2. A routine with no habits: the Habits tab shows it (Bedtime, Edit, "No habits yet", already drawn in Routine added), and Today
  doesn't (already drawn in 241). No change.
- [x] 3. Order: All Day at the top, then routines with a set time, then ones without, then Anytime. Today, the Habits page (Routine
  added: Evening, Bedtime, Anytime) and Edit Today's Empty routine already follow it. Edit Routine's description now says it. Today copies
  that show Anytime first are ones where the person moved it in Edit Today ("5 · Tap ‹: Today, Anytime comes first"), so they stay.
  The Routine page (the habit form's choice) keeps All Day and Anytime first with their descriptions, as Apple's choice lists put
  None or Never first.
- [x] 4. Reminders says why a habit is in All Day. Reminders page (`1100:2996`) has a new property, All Day line, on the On variants: a
  footer under the times, *You’ve added more than one reminder, so this habit goes in All Day.* It's on in the two copies with two
  times (222's "6 · Tap outside: two times, in order" and "2 · Add a Time: 2:00 PM, two times"). Looked at both.
- [x] 5. All Day and Anytime are fixed: Edit is gone from Anytime's heading in all 7 Habits page variants that have it (Edit Today never
  had one). Edit Routine's Built in variant had no copies and is deleted; the set's description says nothing opens it for them. 190b's
  arrow word now says their headings have no Edit. Looked at Routine added and 190b's first screen.
- [x] 6. The three flows moved from Settings are numbered 190a · Edit a routine, 190b · Delete a routine and 190c · Leaving Edit
  Routine with changes, so no other flow's number changes.

