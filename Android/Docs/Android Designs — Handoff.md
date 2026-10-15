# Android Designs — Handoff

Written by Claude (Claude Code), 12 October 2026, at the user's request, so the Android design work can continue in a
new session on the user's MacBook (with the iPhone simulator). Read [Android — Start Here](<README.md>) first (decisions
A1–A14), then this page. **Every frame as an image (no Figma needed):** [Android Designs — Every Screen](<Designs/README.md>).

## Where the designs are

Figma file `Ncccsm1l2O62GJ5xLSInqk` ("Design"), page **Andriod mobile** (`1241:2`):
<https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1241-2>. Each screen lives in a **named section**,
left to right in the order a person reaches it (the user, 12 Oct 2026: "arrange everything properly in a section").

| Section (id) | Frames (id) | State |
|---|---|---|
| **Onboarding: new to the app** (`1548:2`) | Splash, Android's own, light (`1610:2`; the dark frame `1610:22` was removed 14 Oct: **the designs are light mode only**, the app keeps its dark mode): the adaptive icon's foreground with no icon background (288 dp, inside Android's 192 dp circle) centred on `#FFFFFF` / `#0D0D0D`, the Logo Guide's backgrounds; no title, no branding image (added 13 Oct); Welcome (`1548:3`); 1 of 3 · Your habit. Your goal. (`1548:46`); 2 of 3 · Quit or cut down. (`1548:177`); 3 of 3 · Tasks, once or on repeat. (`1548:296`); Your days and weeks (`1548:420`), with New day starts at open (`1550:2`, 12:00 AM to 11:00 AM, as in Day and Week) and Week starts on open (`1550:71`, Sunday to Saturday); Your first habit (`1548:456`; an idea opens the New Habit form, `1302:2`). Frames numbered 01–07 in order (13 Oct) | Built 12 Oct from the user's wireframes (`835:503`) and the built iPhone app; "What's included" removed. **01–06 redesigned 13 Oct and built in the app to match** (below, "Onboarding, 13 Oct 2026"); 07 redesigned in Figma, not built yet. The 06 before its redesign is kept beside the section for comparison (`1650:20585`, labelled BEFORE; not a screen) |
| **Onboarding: coming back** (`1549:2`) | Welcome back (`1549:3`); Sign in with Google: Android's account chooser over Welcome back (`1549:38`), Google's permission screen (`1549:97`); Getting your habits (`1549:128`); Restore a backup (`1549:154`; then the restore flow, `1472:2`) | Built 12 Oct; Move from another device removed |
| **Today** (`1260:2`) | Today, light, 360 × 800 (`1350:2`, the Expressive version, which replaced `1246:2`); the day bar in four day states (`1256:6`); empty: No habits yet, the first time (`1551:3`), and Nothing planned today (`1551:195`; new: the iPhone shows a blank list, Current Work 106) | Approved 12 Oct ("let's go with this one"); the drawer and every Day details sheet show it behind them |
| **Day details** (`1260:3`) | Water, an amount (`1362:2`, replaced `1258:2`); then every other kind, left to right: Read, a time habit (`1280:3`); Read, timer running (`1294:2`); Take vitamins, a check, not done (`1294:220`) and done (`1294:432`); Stretch breaks, several a day (`1294:644`); Call family, a week goal (`1294:866`); Deep clean, a month goal (`1294:1083`); Gym, N days a week (`1294:1300`); Tidy desk, a checklist (`1294:1512`); Smoking, quit with no slips (`1296:2`) and a slip (`1296:214`); Coffee, a limit (`1296:430`); Social media, a time limit (`1296:644`); a task, not done with Reschedule (`1296:858`) and done (`1296:1080`); Read, skipped (`1296:1292`); Meditate, paused (`1296:1510`); Water, an earlier day ("Yesterday", `1296:1722`) | Water approved; the rest built 12 Oct from the built app, the user: "I already approved it … just complete them" |
| **Logs and slips: add, all, view, delete, edit** (`1261:290`) | Add log (`1261:2`), All logs (`1261:83`), Log (`1261:120`), Delete confirmation (`1261:162`), Edit log (`1261:213`); Add slip (`1297:83`), Slip (`1297:164`), Delete this slip? (`1297:209`), Edit slip (`1297:257`) | Logs built, not yet reviewed by the user; slips built 12 Oct |
| **New: choices and habit form** (`1302:2`) | New · What do you want to do? (`1566:2`); Build or maintain · How do you want to track it? (`1566:44`); New Habit forms, full length: Check it off (`1321:2`), Track an amount (`1321:125`), Time it (`1321:272`), Checklist (`1321:400`); Quit or cut down · What do you want to do? (`1566:106`); Quit (`1321:529`); Cut down (`1321:614`); Task (`1321:738`) | Built 12 Oct from the built app; forms redone in the second style (the user: "this new one is looking good"), Icon | Colour in one row; question headings stay Regular |
| ~~**New: the form's pages** (`1563:535`)~~ | **Merged into "New: choices and habit form" (`1302:2`), 13 Oct 2026, and the section removed.** Each form's pages sit one column to the right of it, below its row, with an arrow from the row that opens each (arrows fan out sideways; pages stacked under their own form always made arrows cross). Shared pages once, from 2.1: 2.1.1 Icon (`1564:607`), 2.1.2 Colour (`1564:454`), 2.1.3 How often (`1563:328`), 2.1.4 Time of Day (`1563:438`), 2.1.5 Group (`1563:494`) and 2.1.5.1 New group (`1567:106`), 2.1.6 Starts (`1564:58`), 2.1.7 Ends (`1564:322`); own pages: 2.2.1 How much (`1567:2`) and 2.2.1.1 Unit (`1563:33`), 2.3.1 How long (`1567:60`), 2.4.1 Steps (`1563:286`), 3.2.1 Limit (`1567:31`). **1.1 Add a 6th habit (Plus)** (`1569:104`, whole sheet `1569:2`) under screen 1, dashed arrows from Build or maintain and Quit or cut down only (the user: it shows only when it's meaningful, never for a task, never abruptly at Add). **Not drawn yet:** the form's Reminders page, 3.1's Started pickers, Task's Repeat, Date and Time pages | The app still shows the Plus sheet at Add (`HabitForm.kt`); move it to choosing Build or maintain / Quit or cut down when building |
| **Menu: navigation drawer** (`1326:2`) | Drawer open over Today (`1326:3`); the same, scrolled to the end (`1326:231`) | Built 12 Oct from the built app |
| **Routine player and timer** (`1328:2`) | Player pages, one per kind and state: a check (`1344:2`); a check, done, with the Saved snackbar (`1344:57`); several a day (`1344:117`); a checklist (`1344:173`); an amount, one tap (`1333:2`); a timer running (`1344:241`); a timer, not started (`1344:297`); an amount typed each time (`1344:352`); a limit (`1344:407`); a task (`1344:463`); skipped, with its snackbar (`1344:518`); the last habit, done (`1344:582`); ⋮ menu (`1345:2`); Your routine (`1345:70`); End of the routine (`1345:183`); Timer, running (`1345:219`) | Expressive version approved 12 Oct ("this is looking good"); the first version was rejected |
| **Habit details: Progress, History, Notes** (`1373:2`) | Water · History (`1375:2`), Notes (`1375:732`), Progress (`1373:3`, the user: "looking really amazing"), All milestones (`1735:4`, 14 Oct), ⋮ menu (`1375:1275`); History and Progress drawn full length | Built 12 Oct |
| **Progress: Week, Month, Year** (`1376:2`) | Week (`1376:3`), Month (`1376:226`), Year (`1376:496`), all full length | Built 12 Oct from the built app; **no ⋮ menu** (removed the same day, below) |
| **Settings: Times of Day** (`1437:2`) | Times of Day (`1440:2`); New time of day, defaulting to free time 4–6 AM (`1440:69`); Edit time of day · Morning (`1440:152`) | Built 12 Oct from the simulator, then made Expressive at the user's request (the terminal session's version was deleted) |
| **Settings: Day and Week** (`1449:2`) | Day and Week (`1449:3`); New day starts at, menu open (`1449:51`); Week starts on, menu open (`1768:100`) | Built 12 Oct from the built app; **redesigned 14 Oct** in Figma, not built (below, "Day and Week, 14 Oct 2026") |
| **Settings: Reminders** (`1456:2`) | Reminders with the reminder check (`1456:3`); a habit's reminders, on (`1456:91`); Get reminders on time, the exact-times sheet (`1456:164`); a reminder that didn't arrive (`1456:206`) | Built 12 Oct from the built app and decisions A11 D1–D3 |
| **Settings: Appearance** (`1458:2`) | Appearance (`1458:3`); Done habits, its menu open (`1458:85`) | Built 12 Oct from the built app |
| **Settings: Google Drive & Backup** (`1461:2`) | Not backed up (`1465:2`); backed up, free (`1465:54`); synced, Plus (`1465:123`); offline, changes waiting (`1465:192`); Delete your data from Google Drive?, the dialog (`1475:2`); Erase everything on this phone?, the dialog (`1473:27`); Restore from a backup (`1465:258`) | Rebuilt 12 Oct after the user's review ("what is this backup files only on this phone … why you're mixing backup and restore, export and import"), on the structure of the researched Backup & Export mockups (`950:309`) |
| **Restore from a backup: the flow** (`1472:2`) | Google account chooser, Android's own (`1472:3`); Google's permission screen (`1472:62`); Choose a backup, ours (`1472:93`); the system file picker, Android's own (`1472:155`); Restore, the preview and confirm, ours (`1472:207`); restored, with Undo (`1472:247`) | Built 12 Oct at the user's request ("will it be the app UI or any native UI?") |
| **Settings: Privacy & Security, App Lock** (`1474:2`) | Privacy & Security (`1474:3`); then the App lock flow in order: 1 off (`1478:2`), 2 How do you want to unlock Often Enough? (`1478:28`), 3a your phone's lock, Android's prompt confirms it (`1478:66`), 3b create an app passcode (`1478:118`), 3c confirm it (`1478:175`), 4 on (`1478:232`); later, opening the app with your phone's lock (`1478:286`) or the app passcode (`1478:317`) | Built 12 Oct; reordered the same day at the user's request ("right now its screens are juggled") |
| **Settings: Plus** (`1476:2`) | Plus, buy: on the phone, Get Plus pinned (`1544:3`), whole page (`1480:2`); Plus is yours: on the phone (`1544:106`), whole page (`1480:77`) | Rebuilt 12 Oct after the user's review: the light app icon, price first, then what you get with Plus in one list (tablet, Wear OS, Windows), plain plan rows, Plus Family, Restore purchases only where you buy |
| **Settings: Help & Feedback** (`1476:110`) | Help & Feedback (`1476:111`); a topic open (`1476:194`) | Built 12 Oct |
| **Settings: About** (`1476:264`) | About (`1476:265`) | Built 12 Oct |
| **Widgets** (`1555:2`) | On home screens: One habit 2×2 (Water +1, Meditate ▶) and Today 4×2 for a section (`1555:3`); Today 4×4 with pages (`1555:92`); This week 4×2 and Tasks 4×2 (`1555:197`); Tasks 4×4 (`1555:290`) | Built 12 Oct from the built iPhone widgets (`iOS/Shared/PhoneWidgets.swift`) and the iPhone boards (`537:2981` …); one state each, the other states to follow |
| **Widgets: adding and changing** (`1559:2`) | Android's own: touch and hold the home screen (`1559:3`), Widgets searched for "often", full length (`1559:102`), a widget tapped: Add (`1559:416`); ours: One habit, choose a habit (`1560:2`); on the home screen (`1560:89`); Android's own: touch and hold the widget, Reconfigure (`1560:178`); ours: change the habit (`1560:270`); Today, the day or one section (`1560:357`); Tasks, all or one section (`1560:459`); This week, choose a habit (`1560:533`); Today without Plus (`1560:645`) | Built 12 Oct |
| **Widgets: every state** (`1557:402`) | One habit, 30 states (`1557:2`); Today, Tasks and This week, 24 states (`1558:550`) | Built 12 Oct from the built iPhone widgets |
| **Notes: add, view, delete, edit** (`1274:2`) | Add note, empty (`1274:3`); Add note, typed (`1277:2`); Add note on a day that already has a note, from the Notes tab with the date pill (`1279:2`); Discard this note? (`1277:121`); Note (`1277:235`); Delete this note? (`1277:288`); Edit note (`1277:325`); Discard your changes to this note? (`1279:111`) | Approved, 12 Oct ("looks good"); the two variants (`1279:2`, `1279:111`) follow it |

## The reference is the built iPhone app, not Figma

**The user, 12 Oct 2026:** "take the developed app as a reference … in Figma we might have outdated designs." The
Figma iPhone, iPad and redesign frames (and `Research/…/Day Details, Logs and Notes — 7 October Redesign/Images`) can
be out of date. Before designing each Android screen, open the same screen in the built app on the iPhone simulator
and match its content, order, words and rules; change only what Android does differently. The user chose to run the
simulator on their MacBook for this (12 Oct 2026; Rulebook T1 otherwise keeps builds off it, for the battery, so keep
it on the charger). A Debug launch with no arguments adds the sample habits (T14); `-uitest` runs on its own in-memory
database (D8). `iOS/HabitsUITests/DayDetailsScreenshotUITests.swift` shows how the app's own tests reach each screen.

**Building it on the MacBook (12 Oct 2026):** the Habits scheme embeds the Watch app, so Xcode needs the **watchOS
simulator platform** installed (Xcode → Settings → Components), and the Kotlin core is built for Apple silicon only, so
pass `ARCHS=arm64`: `xcodebuild build -project Habits.xcodeproj -scheme Habits -destination 'id=<simulator>'
-derivedDataPath ../Research/Temp/ios-sim-build ARCHS=arm64`. Then `xcrun simctl launch booted com.oftenenough.app
-open-day Water` opens Water's Day details directly (`-open-add Water` its Add screen; Debug simulator builds only).
Screenshots go in `Research/Temp/android-design-shots/`.

## Decisions made while designing (the user, 12 Oct 2026)

- **Completely native Android, Material 3 (Expressive, as on Android 16); the ideas exactly the iPhone's.** "Our app
  should feel like an official material design app … the overall ideas … we will keep what we have exactly in the
  iPhone."
- **Light only in Figma.** No dark versions were drawn: native components make dark mode automatic ("it's not a
  custom design … we are using native things"). **The app still needs dark mode** (the user, 13 Oct 2026): built from
  Material 3's dark roles, with an old dark design (`194:10`) as colour inspiration only ([every screen](<Designs/README.md>)).
- **The font is Google Sans Flex, Regular and Medium only** (the user, 13 Oct 2026, after Roboto and Google Sans Flex side by side on Welcome; "don't use semi-bold unless I say"). The app bundles it (Android's own font is Roboto) and uses the design's sizes as drawn, with no size or letter-spacing overrides of its own. Welcome (`1548:3`, now named "02 · Welcome · the first screen after downloading"; the section's frames are numbered 01 Splash to 07 Your first habit): Often Enough 32/40 Medium, letter spacing −0.5; the line under it 16/24 Regular, grey; the question 16/24 Medium; choice names 16/24 Medium; their descriptions 14/20 Regular, grey. The logo, name and line are centred in the space above the question; 24 from the logo to the name, 8 from the name to the line (3 : 1). **Text has a measure, never hand-typed breaks** (the user, 13 Oct 2026): it fills a narrow screen and stops at a set width on a wide one, so it breaks at a natural pause (the line 254, "…repetition. / You choose…"; the choices' descriptions 212, "…keep track of / your tasks."); measure the words in Figma and set the width mid-window. Built in the app the same day to match Figma exactly, with vector logos from Figma's SVG export and the splash on `#FFFFFF` / `#0D0D0D` (`claude/android-app` `5afdacff`; the rules are written in `Onboarding.kt`'s Welcome header). The other screens move to it next.
- **Onboarding, 13 Oct 2026: the user's points, in order** (Figma `1548:2`, screens 01–05; built in the app on
  `claude/android-app`, where each rule is also written in the code: `Onboarding.kt`'s Welcome and intro headers,
  `Fonts.kt`, `Motion.kt`, the logo drawables, `MainActivity`):
  - **Design = app.** "Whatever exactly we have in the Figma, the same way it should look in the developed version."
    The app uses Figma's numbers as drawn: no sp sizes or letter spacing of its own. Check on the real phone at its own
    size, never a resized emulator ("build it … whatever the original size is").
  - **Hierarchy from size and two weights:** Google Sans Flex, Regular and Medium only; never SemiBold unless the user
    says. Welcome: the name 32 Medium (−0.5), its line 16 Regular, the question 16 Medium, choice names 16 Medium over
    14 Regular. Intro pages: heading 28 Medium (−0.25), line 16 Regular, section title 16 Medium over 12 Regular, habit
    names 16 **Medium** over details 14 Regular.
  - **Spacing:** Welcome's logo, name and line are centred in the space above the question; 24 from the logo to the
    name, 8 from the name to its line (3 : 1; 16 : 8 was tried first). The choices: 16 padding, 2 between name and
    description, 16 before the chevron. On the intro pages, 20 between a streak and the row's round button (was 12,
    "very close").
  - **Text has a measure, never hand-typed breaks:** "if the space is smaller it should try to fill the space, but if
    the space is large then it should split." Measure the words in Figma, set the width mid-window, use it in both.
    Welcome's line 254, its choices' descriptions 212; the intro lines 296 / 228 / 296; headings break balanced.
  - **The welcome asks one thing:** Privacy & optional usage sharing removed (Design Rules, Onboarding).
  - **Logos are vectors from Figma's SVG export**, converted with Android Studio's converter, for Welcome and the splash
    ("use SVG … whichever is better in the long term"); the PNGs looked soft on a large screen.
  - **The splash** is Android's own, on `#FFFFFF` / `#0D0D0D`, at its normal speed (a 5-second hold was only for a look).
  - **The navigation bar takes the screen's colour** (no white strip behind three-button navigation).
  - **Motion:** moving between onboarding steps, and from the welcome into the app, uses Material's shared axis X,
    300 ms ("snappy … but very boring" without it; "very performance efficient"). Keep it this short.
  - **Intro pages (03–05):** the card starts at the same place on all three (the heading space is the tallest of the
    three, measured), with any space left below it ("let it be"). The page dots stay, 20 above Continue, still while
    the pages slide; the current one a 24 dp ink pill, the others ink at 30 % (tonal `#E6E6EA` couldn't be seen,
    outline `#79747E` was "too dark … competing with the active state").
  - **Streaks are 🔥 with the number** on Android too ("in iOS already we have that rule"); done on 03–04 so far, Today
    and the rest not yet. In Figma, set the emoji in Google Sans Flex: Figma can't draw the Noto Color Emoji font.
  - **Habit icons on 03–05 are circles.** Elsewhere the app mixes circles and Expressive "cookie" shapes; the user is
    deciding, screen by screen. The tasks on 05 have their own colours (brown, indigo, green), not one orange; 05 no
    longer shows "Unlimited tasks · Included in the free plan".
  - **How to work:** change only the screen the user names, never every screen or the whole file without asking (a
    page-wide 🔥 swap had to be undone); no text styles or other reusable pieces in Figma until the user approves them.
  - **06 · Your days and weeks** (`1548:420`, menus open `1550:2`, `1550:71`; built in `Onboarding.kt`'s `DaysPage`,
    rules 1–4 there): the intro pages' type and top bar; **plain words** ("plain English … users should get it in one
    read"): "Choose when your day and week start." under the heading, one line (measure 296), and "You can change these
    later." under the card, 12/16, never the path to the setting ("they click on hamburger menu … we don't need to
    explain it"). An earlier proposal, "Up late? Check-ins after midnight can count for the day before.", was replaced
    as too specific. **The two settings are one card of Welcome's rows** (round grey icons, 16 Medium over 14
    Regular). **A setting's menu always opens 4 under its row, right edges together, on every phone** ("don't place it
    like an absolute position … in any phone it should work that way"): Material's dropdown opened at the left, then
    moved the 13 hours to the top of the screen when it decided they didn't fit; the app now places its own popup
    under the row and makes it as tall as that phone's room (to 24 above the navigation bar, as Figma), scrolling the
    rest. ≡ › Day and Week keeps its own rows for now (change only the named screen). **Not built yet: a scroll bar
    on the open menu** ("it indicates that this is scrollable"), as Figma `1550:2` draws it (4 wide, ink at 25 %, at
    the menu's right edge).
  - **07 · Your first habit** (`1548:456`; the old version kept beside the section, `1655:20573`): redesigned in
    Figma 13 Oct, **not built yet**. The intro pages' type and top bar; one plain line, **"Pick a habit below, or
    create your own."** (284 of the 296 measure; the user: "it's not an idea, it's a habit"), in place of "Choose an
    idea to get started. You can edit it before adding it." ("Pick an idea, then make it your own." came between);
    the eight as Welcome's rows (16 above and below, 16 Medium over 14 Regular) with **coloured habit icons**, as
    habits are shown everywhere in the app (the user: "that's how we represent them in the app"): the intro pages'
    filled white icons (Material Icons Round 22) on Drink water blue `#4285F4`, Exercise pink `#E52592`, Read orange
    `#FA7B17`, Meditate purple `#A142F4`, Walk green `#34A853`, Go to bed on time indigo `#5856D6`, Stop smoking grey
    `#80868B`, Less coffee brown `#A1887F`. When built, each idea opens its form with that colour, so the habit added
    looks as it did here. The app's note under the list ("An idea only fills in the form…") isn't in the design.
    **Built 13 Oct**, with the scroll bar above. **Back from a picked habit's form** (the user, 13 Oct 2026): it
    returns to Your first habit as it was, because the welcome ends only when the habit is added (the form opens over
    it); it asks Discard / Keep editing only when something differs from what the pick filled in ("showing that
    pop-up only makes sense when we are in a dirty state"); Back and Discard used to close the app (a crash: the form
    set its step to "" while sliding away). Same from Help's Show the welcome again.
- **Small screen first:** 360 × 800 (status bar 36, gesture navigation 24 at the bottom, a camera hole).
- **Today's top app bar: ≡ · Edit (pencil) · Filter · +**, no title. + is in the top bar, **not a floating action
  button** (the FAB beside the day bar was rejected: "not looking good").
- **The day bar is Material's floating toolbar** (`HorizontalFloatingToolbar`, version B, chosen over a docked
  full-width bar), at Google's standard size from the component's code: **64 high, fully rounded, 8 padding at the
  ends, 4 between items, 48 × 48 arrows, 16 above the gesture area**; 320 wide; white with a hairline edge and a
  shadow (Google's default is grey with no shadow: kept white because the user wanted it "easily noticeable"); a soft
  fade behind it (Android's gradient protection).
- **The day bar's width never changes** when the day changes (the user: "the layout shift … looks ugly"); ‹ and ›
  stay at its ends. **Corrected 12 Oct (the user):** "no layout shift" means the width only: the ring, the day name ▾
  and the count sit **together as one group, centred**, 8 apart, and may move a little as the text changes ("Today",
  "Yesterday", "Wed, 30 Sep"; "4/13"). The earlier version, with the three spread to fixed slots across 200, looked
  wrong. Applied to every day bar on the page.
- **Cards are Android 16's segmented lists:** each row its own white piece, 2 apart, outer corners 24 (were 20), inner
  4, on a `#F0F0F3` background, 16 from the screen's sides, 16 between cards (were 12).
- **Rows:** 72 high (Material's two-line item); a round 40 habit icon in the habit's colour (round, not the iPhone's
  rounded square); name 16 / line 14; streak with a filled flame; a 40 round button (tonal grey, or filled in the
  habit's colour when the goal is met); the progress fill in a light tint of the habit's colour.
- **Today · light (`1350:2`), 14 Oct 2026** (the user: "nothing much to improve … improve the fonts … take inspiration from" intro 1 of 3): Google Sans Flex with the intro pages' hierarchy: section names 16 Medium over "Starts 6 AM" 12 Regular, **habit names 16 Medium** over details 14 Regular, streak numbers, badges, Start and the day bar Medium; **20 from a streak to the round button** (was 12; the intro pages' gap). **Streaks are the 🔥 emoji**, as on the intro pages (the user: "streaks still using the fire icon rather than emoji"; Material's `local_fire_department` icon replaced, drawn as intro 1's: Google Sans Flex, an 18 place, 2 from the number). This frame only; Today's other frames (empty states, day bar states) not yet.
- **The Expressive "cookie" shape is for large icons and empty screens** (the user, 14 Oct 2026: "wherever we have large icons, let's use cookie shape. In empty screens, anyway, we are using it"): the routine player's hero icon, big headers and empty states; **small habit icons are circles** (Today, the intro pages, ideas, forms); choice rows use plain rounded squares. Circles everywhere was tried on the player the same day and reverted ("cookie shape was looking good"). The cookie: 9 points, inner radius 0.86, corners a tenth of its width.
- **Today · empty · no habits yet (first time) (`1551:3`), 14 Oct 2026:** **New habit** (filled) and **Start from an idea** (tonal) only. *Start from an idea* stays: it opens the same 8 habits as onboarding's Your first habit (`IdeasScreen`), and the research found an empty screen with nowhere to start among the worst-rated moments (208 reviews, 2.75★) while ideas helped (103). **Removed:** *Restore from a backup* (the welcome has just asked "Have you used Often Enough before?", and Restore stays in ≡ › Google Drive & Backup) and *How it works* (it opened Help & Feedback, not a tutorial; the intro pages have just explained the app; Help stays in ≡) (the user: "do we need it?"). Material's empty state: a picture, a title, a line, one main action and at most one more. Google Sans Flex: "No habits yet" 24 Medium, the line 16 Regular at a 268 measure ("…to do / often enough, or start from an idea."), the group centred. **The iPhone's empty Today still offers all four** (Design Rules, Onboarding; the research report's §4): drop the same two there if the user agrees. The day bar states (`1256:6`) are in Google Sans Flex.
- **Today · empty · nothing planned today (`1551:195`), 14 Oct:** Google Sans Flex, the title 24 Medium. **New habit stays tonal here and filled on the first-time screen, on purpose:** with no habits, adding one is the only thing to do (filled); on a day with nothing due the person has habits and nothing is wrong, so adding is offered quietly (tonal; U3, nothing counts against anyone; Material: emphasis follows importance). **Today · Start from an idea (full length) (`1710:2`)**, new, after the first-time screen with an arrow from its Start from an idea: the app's `IdeasScreen`, drawn as onboarding's Your first habit (the 8 habits in their own colours, names 16 Medium over 14 Regular, ›), titled "Start from an idea", with "An idea only fills in the form. Nothing is added until you tap Add." under the list. **The app's `IdeasScreen` still shows grey icons (`ListRow`): build it with `IdeaRow`.**
- **Day details (`1260:3`), 14 Oct 2026:** all 19 frames in Google Sans Flex (weights as they were), the habit's 48 header icon a **circle** (was a cookie; small icons are circles), frames named without "Android ·".
- **Logs and slips (`1261:290`), 14 Oct 2026** (the user: "similarly … like the quit started date and time … make it look like a native"): every frame in Google Sans Flex and named without "Android ·"; the habit as its 40 circle icon and name (fixed, no ›, no "Habit" label); **Date and time are two controls, never a chain** (the user asked whether date-then-time was intuitive, then: "do some research … how Android handles it natively"): Android's Settings keeps **separate "date" and "time" preferences** (AOSP `date_time_prefs.xml`), Material 3 for Compose has **no combined date-and-time picker** (`DatePicker`/`DatePickerDialog`, `TimePicker`/`TimePickerDialog`; a combined one exists only on iOS), and Google Calendar's event editor puts the date and the time side by side, each its own tap. So every date-and-time is **one row of two pieces, Date | Time**, each opening only its own picker (the date takes the spare width): Add log / Add slip both with ›; Log / Slip and their delete confirmations neither; Edit log / Edit slip both with › (since 14 Oct the date too: U19 now lets a record move to another day, Current Work 109); 3.1 Quit **"Started" | "At"**. The chain (date, then time) was drawn first and replaced: the common fix is the time alone, a second dialog appearing is a surprise, and Cancel on the second is ambiguous. The iPhone keeps separate Date and Time rows (U22). **A slip's time zone** (the user: "should we allow the user to change the time zone or should we show it at all?"): never changeable (a slip is a moment; Design Rules: no time-zone setting); **hidden when it's the phone's own**; shown only when the slip was recorded elsewhere, as a line of its own under the Date | Time pair, "Recorded in India Standard Time" (Google Calendar shows an event's time zone only when it differs). Drawn: "Slip · Smoking · recorded in another time zone" (`1718:69`). The iPhone shows the time zone on every slip (`LogRecordView`).
- **3.1.1 · Started: date picker** (`1721:2`, Material's date picker over Quit, "Started", Mon 12 Oct) and **3.1.2 · Started: time picker** (`1721:315`, Material 3's dial picker: "Select time", 1 : 12, AM / PM, the hour dial, the keyboard icon to type it, Cancel / OK), in the New section under row 3, with an arrow from Started to the date picker and from At to the time picker (the user: "how the screen will look when they click on date and time … add it in the quit screen"). Rows 4–5 moved down 880.
- **Dates and times, everywhere (14 Oct 2026; the user: "update it everywhere, wherever we have used it"):** no grey capsules anywhere (they were the iPhone's compact picker). **In a form:** a date with a time is one row of two pieces, **Date | Time**, each opening only its own Material picker (Logs and slips, 3.1 Quit's Started | At); a date alone is an ordinary row with › (Task's Date). **In a compact header with the keyboard up:** Material's **assist chip** with a calendar icon ("Today, 12 Oct"), as Google Tasks shows a date: all four Add note frames; a saved note's day stays plain text. **A list of times** (a habit's Reminders): each time a row, the time 16 Medium over its label ("8:00 AM" / "Reminder 1"), remove at the start, › opening the time picker. Task's Time stays a switch.
- **Where a record came from, plain (14 Oct 2026; the user could not understand "Recorded with Record a slip."):** something added by hand now reads **"Logged by hand."** / **"Recorded by hand."** (it named the button used: "Logged with Log manually."); the others were already plain ("Logged from a widget.", "from a reminder.", "with the timer."). Kept, since it explains a record nobody remembers adding. **The words are shared: change both apps** (`iOS/Habits/Model/Words.swift` `originLine`, Android `data/StoreWords.kt`). The Notes section (`1274:2`) is in Google Sans Flex, frames named without "Android ·"; its date is Material's assist chip.
- **Habit details (`1373:2`), 14 Oct 2026:** History, Notes, Progress and the ⋮ menu in Google Sans Flex, the
  header's habit icon a **circle** (small icons are circles); the day squares in History stay the app's own (the user:
  "these check marks are not usual check marks"). **Progress's hierarchy** (the user: "we have to have proper
  hierarchy here"): the record number 45 Regular, card titles 16 Medium, figures 24 Medium over 12 Regular labels,
  the type scale's steps only (45 · 28 · 24 · 16 · 14 · 12). **The current streak is the 🔥 emoji**, as on Today.
  **Milestones keep the cookie, made a medal** (the user: "milestone should feel special … if you think cookie shape
  better then keep it"): an award is the one place a shape of its own is earned, so the cookie stays for reached
  milestones only, given a gradient of the habit's colour, a white inner ring at 82 % and a soft shadow in the
  habit's colour, while **the next milestone is Material's circular progress indicator** (not reached yet, so no
  medal). Applied to Progress (`1373:3`) and the ⋮ menu frame behind it (`1375:1275`). **All milestones (`1735:4`),
  new**, after Progress with an arrow from "See all 5": ← "All milestones", "Water · 5 reached", then one segmented
  list per track, **In a row** and **In total**, each starting with its next milestone (the ring, "30 days in a row /
  Next · 7 to go · now 23") and then every one reached, newest first, as a medal with "Reached 3 Oct"; under them
  "Each track shows its next milestone. Reached ones stay, even if a streak ends." (a medal is never taken back: U3).
- **The type scale and text styles (14 Oct 2026; the user: "create the text styles … do some research … follow
  some principles … that creates the best possible hierarchy").** 22 local styles named **Android / …** in the Figma
  file, Google Sans Flex, letter spacing 0, each with a description of where it's used. **Sizes are Material 3's**
  (Compose `TypeScaleTokens`: 57, 45, 36, 32, 28, 24, 22, 16, 14, 12, 11), **Emphasized = Medium** (Material 3
  Expressive's emphasized styles are the same sizes, heavier), **plus one step of our own, 20** (Regular and Medium).
  **The principle is a modular scale:** within one screen, neighbouring levels of the hierarchy differ by at least
  **1.25×** (a major third); two levels that must share a size differ by weight or colour. Material's own steps are
  finer (1.09–1.37), so a screen skips steps rather than using neighbours together. **20 is kept** because Material
  has nothing between 16 and 22 (its largest gap, 1.375×) and 16 → 20 is exactly 1.25: it's for a one-line key
  sentence ("Reached on 12 of 12 days so far": 22 wraps in a 360 card), a large typed name (the user: "below the title
  size"), a plan's price, the drawer's name and the routine player's 96-high button labels (Material's 24 for a Large
  button doesn't fit their 130 of room). **18 is not used** (the user asked whether we need it): Material has no 18,
  and 16 → 18 is 1.125×, too small a step to read as a level; every 18 was a unit beside a big figure (now Body Large
  16, as Water's already was), a plan name or a list name (now Title Medium 16). **44 became 45** (Display Medium),
  **64 became 57** (Display Large), **40 became 36** (Display Small). **By job:** top app bar and sheet titles Title
  Large Emphasized 22; a habit's large title, a screen's question or status Headline Medium (Emphasized) 28; the
  player's habit name Headline Large Emphasized 32; the one big figure on a screen Display Medium 45 (an amount being
  typed: Emphasized), clocks and the player's count Display Large 57 (Display Medium 45 for a checklist's count, so it
  stays 1.4× the 32 name); dialog and sheet headlines Headline Small 24; tile figures Headline Small Emphasized 24;
  list item and card names Title Medium 16 (Medium wherever a name sits over supporting text, the habit form's Icon and
  Colour rows included); body and a unit beside a figure Body Large 16; supporting text Body Medium 14; buttons, tabs,
  chips, section labels and **menu items** Label Large 14 (Material's menu token); badges Label Medium 12; footers and
  notes under a group Body Small 12 (How much, How long and Limit's notes moved from 14); weekday letters and chart
  axes 11. **Not styled on purpose:** the status bar and the keyboard (Android's own), icon glyphs, and the 🔥 (an
  icon, 18, as on Today). **Applied to every frame of this session's sections** (onboarding, Today, Day details, Logs
  and slips, Notes, the habit form, the menu, the routine player, Habit details, Progress, Times of Day, Reminders):
  3,000+ texts, every one styled, none overflowing; the menu's Today and Reminders moved off Roboto, Reminders' small
  icons became circles. Checked frame by frame; fixed on the way: the checklist player's count (36 beside a 32 name),
  the timer's two buttons (equal widths), Day details' titles (Regular), clipped supporting lines (now end in "…").
- **Progress: Week, Month, Year (`1376:2`), 14 Oct 2026:** Google Sans Flex at the sizes and weights it had (the
  summary "Reached on 2 of 2 days so far" stays 20 Medium, as on Habit details' Progress), the status bar Android's
  own; each habit's 44 icon a **circle** (small icons are circles); frames named without "Android ·". **Week · Month
  · Year stays Material 3 Expressive's connected button group** (the user: "if they are native … keep it"): it's
  Material's control for switching views of the same content (tabs move between different pages), and it's drawn to
  the spec, 2 apart, inner corners 8, the selected one fully round with a check.
- **Section headers:** name 16 Medium, "Starts 6 AM" 12; **"N left" as a grey badge** (12 Medium, corners 12); ▶ Start
  (filled ink for the Now section, tonal grey otherwise); ⌃/⌄. Folded: **the habit icons as an overlapping stack** (28,
  a white ring, 6 overlapping) ending in a "+N" disc. **Outer corners 24, 16 between sections** (Expressive version,
  12 Oct). **Every section, the current one included, is the same white pieces on the grey screen.** Tried and rejected
  the same day: the current section in a grey container (its grey dulled the progress fills), an ink outline ("really
  ugly"), a deeper grey, a dark container, and a white screen with grey cards or grey section containers. The current
  section is marked only by its filled ▶ Start.
- **Day details is a modal bottom sheet** (drag handle, corners 28) with **✕ at the start, the title, ⋮ at the end**
  (Android's placement); the iPhone's content (habit ›, This day card with +1 | Log manually and the note, Today's logs
  with at most three rows, Skip today last and outlined).
- **Add / Edit screens:** ✕ and a one-line title; Habit, Date, Time as segmented rows with tonal pill buttons that
  open Android's date and time pickers; the amount large in its own card; the filled main button full width just
  above the keyboard (drawn as Gboard's number pad). **Log view:** ← back, **Delete log (red text on grey) | Edit
  (filled)** at the bottom. **Delete** asks in Material's dialog (Cancel, Delete log in red).
- **Notes** (12 Oct, from the built app): no habit card; one line under the title, the round 24 habit icon, the name
  (16 Medium) and the day ("Today, 12 Oct", 14, secondary), lined up with the text inside the box (32 from the edge);
  the note in a white card (corners 20, Roboto 16/24, "Write a note"); Save full width 12 above the keyboard, **off
  (Material's disabled filled button: ink at 12 %, label at 38 %) until something is typed**, as on the iPhone; Gboard's
  letter keyboard (capitals at the start of a note, Enter as the dark new-line key). **Edit note has ✕ only**, never ‹
  and ✕ (the iPhone showed both once: Current Work 104). The keyboard closes when a dialog opens. **Dialog and button
  words are sentence case on Android** ("Keep writing", "Discard changes", "Delete note"; the iPhone's alerts say "Keep
  Writing", "Delete Note"), as Material writes them and as "Delete this log?" already did.
- **Day details, Expressive version** (the user, 12 Oct; applied to all 19 sheets): the habit card's icon in the
  **cookie shape**; **This day** with corners 28, padding 18 / 20, and **the count and its second line on one row,
  baseline-aligned** (the user's own edit): a number in the status becomes the large count ("**4** of 8 glasses", 44),
  a short second line sits at the row's right ("4 glasses to go", "8 min to go", "One step left"), a long one stays on
  its own line below ("Timer running · 0:03", "Paused days don't count toward your streak"); a status with no number
  stays 28 Medium ("Not done", "Skipped"). **The wavy progress bar only where there's progress toward a goal**
  (amounts, time, several a day, week and month goals, checklists), never on checks, limits, quits, tasks, skipped or
  paused days. Logging buttons 52 high, equal; the note row has a leading `sticky_note_2`; list corners 24; 12 between
  blocks. **The sheet stays as compact as before:** the day title and the habit card stay (the title changes to a date
  on other days; the user rejected moving the habit into the title), and Skip today ends no lower than it did (753 on
  Water; every other sheet ends higher).
- **Day details, every kind** (12 Oct, from the built app's `DayDetailsFixture`, `-uitest -day-details-fixture
  -open-day <name>`): the words and buttons are the iPhone's. Emphasis follows U16: a positive goal action is filled
  (Mark done, +1, Add a check, Start timer, Resume habit); a limit's +1 / Start timer and a quit's Record a slip are
  tonal; Undo done is tonal. Quit, limit and task sheets have no Skip (as on the iPhone). Several checks a day list
  "Checks today", each row with its own **Undo** text button. A checklist's steps are **Material checkboxes** (square,
  18, ticked in the habit's colour), not the iPhone's circles. Reschedule rows carry a leading icon (`redo`,
  `calendar_month`). **Skipped: both logging buttons stay visible and switched off** (U15; the iPhone left "Stop and
  save" on when a running timer's day was skipped). An earlier day is titled "Yesterday" and ends with "Skip this day".
- **New (+) and the habit form** (12 Oct, from the built app): the iPhone's words, order and examples. The first step
  closes with ✕ (not "Cancel"), later steps go back with ←. Choice rows are segmented pieces with Material Symbols
  (`trending_up`, `trending_down`, `calendar_month`, `check_circle`, `tag`, `timer`, `assignment`, `block`, `speed`).
  **The form, second version (the user, 12 Oct: the first, with outlined fields straight on the grey and no chevrons,
  "is not looking good … take inspiration from … Google apps"):** **Add is a filled pill button** at the end of the
  top app bar, off until there's a name (Google Calendar's Save); "Preview" with the Today row as it will look; then
  **one card holding the name, the description and Icon | Colour**: the name a **large borderless field** (22, "Name,
  e.g. Make bed", like Calendar's "Add title" and Keep's "Title"), the description with a leading `notes` icon, and
  **Icon | Colour as one compact row of two connected pieces**, each with its own chevron (the user: "they are
  important but … not as important as how often"); **every settings row has a leading Material Symbol, the value under
  the title and a trailing chevron** when it opens a page (Compose `SegmentedListItem`: leading icon, supporting text,
  trailing icon); a row that sets its value in place ends with that control instead (Date / Started pills, Time switch).
  "When you tap +" as radio rows, "Each tap adds" in a small filled field. Icons: `event_repeat` How often, `tag` How
  much, `timer` How long, `checklist` Steps, `speed` Limit, `history` Started, `repeat` Repeat, `calendar_today` Date,
  `schedule` Time / Time of Day, `folder` Group, `notifications` Reminders, `event` Starts, `event_busy` Ends.
  **Third version, 13 Oct 2026 (2.1 Check it off `1321:2`, then 2.2 Track an amount `1321:125`, 2.3 Time it
  `1321:272`, 2.4 Checklist `1321:400`, 3.1 Quit `1321:529`, 3.2 Cut down `1321:614`, 4 Task `1321:738` (its Date
  an ordinary row like Started, its Time keeping Material's switch); not built; the
  BEFORE copies were deleted at the user's request). **Quit's Started is an ordinary row** (the user chose it, 13 Oct
  2026, over Google Calendar's date and time as plain text to tap): "Started" over "12 Oct 2026, 1:12 PM" and ›,
  opening Material's date picker and then its time picker. The grey date and time capsules were the iPhone's compact
  date picker, which Material doesn't have. How much, How long and Steps are ordinary two-line rows;
  "When you tap +" keeps its radio rows and the small "1" field, in the same type and corners:** the user: "it is not looking good … font size hierarchy … maybe we are using excessive
  icons"; "don't try to copy the iOS design"; "don't use those ugly input fields". Google Sans Flex: the title
  **"New Habit" 22 Medium** in the small top app bar (Material's default is 22 Regular; a large bar was offered and
  turned down: "New Habit is not the most important thing" on this screen), the name field **20 Regular** so it sits
  below the title, setting names **16 Medium over their values 14 Regular**, left-aligned. **No leading icons on the
  settings rows** (only the habit's own icon and colour remain); **the grey › stays** on every row that opens a page,
  Icon and Colour included (the user: without it "user experience is very confusing"; Settings has none, but this
  form mixes typed fields with rows, and many first see it during the welcome; NN/g's weak-signifier study). Same
  words, groups and order as before.
  **The three choice screens, 13 Oct 2026** (1 What do you want to do? `1566:2`, 2 How do you want to track it?
  `1566:44`, 3 Quit or cut down `1566:106`, descriptions there at a 180 measure so "much." isn't alone; not built): Google Sans Flex, the heading 28 Medium (−0.25) with a measure so it breaks evenly ("What
  do you want / to do?" 246, "How do you want / to track it?" 236), names 16 Medium over 14 Regular, 2 apart,
  descriptions on 01 with a 189 measure (184–194 break naturally); segmented pieces 2 apart, corners 24 / 4; **plain
  40 rounded squares (corners 12, `#E6E6EA`) with the icon in ink**, in place of the Expressive "cookie" shapes (the
  user: "don't use the curly … just use direct square"). "Add a task" now reads **"Something to get done, once or on
  repeat."** (two lines, like the others; "No habit progress, streaks or stats." dropped so the three rows match; the
  user preferred fixing the words to moving the icons, which stay centred as in Settings). **The section is laid out
  as a flow** (the user, 13 Oct 2026): "1 · What do you want to do?" at the top left; one row per choice, each
  reached by an arrow from that choice: 2 · Build or maintain, 2.1 Check it off, 2.2 Track an amount, 2.3 Time it,
  2.4 Checklist; 3 · Quit or cut down, 3.1 Quit, 3.2 Cut down; 4 · Task. Frame names are just the number and the
  screen ("2.1 · Check it off"), no "Android ·" or "New Habit ·". The sections below moved down 3,308.
- **The ≡ menu is Material 3's modal navigation drawer** (12 Oct, the iPhone's items and groups): a sheet 304 wide
  (the screen less 56, so Today shows at the edge), end corners 16, over a 32 % scrim; the app's name as the small
  headline; items 56 high with pill-shaped selection (Today selected, its icon filled), Material Symbols, 14 Medium
  labels, counts at the end (Habits 15, Tasks 3); the iPhone's five groups split by dividers. **"iCloud & Backup" is
  "Google Drive & Backup" on Android**; Privacy & Security uses `shield` (Android's own Security icon) instead of the
  iPhone's hand. Thirteen items at Material's 56 don't fit 800, so the drawer scrolls (both ends drawn); its content
  stays below the status bar, as Compose's `ModalDrawerSheet` pads for the system bars.
  **14 Oct 2026 (the user: "with the current font, they are not at all looking good … should we use a logo?"):** the
  frames are "1 · Menu · open" (`1326:3`) and "1.1 · Menu · scrolled to the end" (`1326:231`). **The drawer opens
  with our logo and name**, as Google's own apps do (Gmail, Calendar, Keep and Drive open their drawers with the
  product's logo and name; Material 3's drawer has an optional headline there): the transparent tonal mark (Logo
  Guide `1166:17`; 36 frame, inside the guide's 24+ for compact use), 12, "Often Enough" 20 Medium, lined up with the
  items' icons. Items in Google Sans Flex 14 Medium, the counts in grey; groups, dividers, 56-high items and the
  pill on Today unchanged. Today behind the scrim stays as it is (the user: leave Today for now).
  **Icons, 14 Oct:** every unselected item's icon **outlined at weight 300** (Material Symbols Rounded Light), **20**
  (the user asked for 20 after seeing 24; the gap to the label is 16, so labels stay at 52); only the selected one
  filled (Material's drawer rule); Appearance uses `palette` (Android Settings' theme icon) and Progress
  `monitoring` (an outline chart), since `contrast` and `bar_chart` stay solid even outlined (the user: the icons
  were "popping up too much"). **Building it:** the app's `Icons.Rounded/Outlined` (the older Compose library) have one weight, 400; the
  drawer needs Material Symbols vectors exported at weight 300, fill 0 (filled for the selected one).
- **Routine player and timer, Material 3 Expressive version** (12 Oct; the user rejected the first, a ring with a
  "‹ Day details ›" toolbar: "not looking good … the day details … creating very ugly thing"). The iPhone's words,
  order and one main action per kind; the look from Expressive's tactics (Google Design's research: containment, bold
  shape and colour, larger key actions; Clock's giant buttons): a top app bar with ✕, **title "Anytime ▾" and a
  subtitle "Habit 4 of 12"** (opens Your routine) and ⋮; thin routine segments; **one large white hero card** (corners
  32) holding the habit's icon in Material's **cookie shape** (9-sided scallop) in its colour, the name (32), **a "📅
  Today ›" chip that opens Day details** (also first in ⋮), a display-size count ("2 of 8 glasses") and Expressive's
  **wavy progress bar** in the habit's colour; at the bottom **a button group, 96 high: ‹ (tonal) · the main action
  (ink) · › (tonal)**, like media controls. **No "Day details" toolbar.** Main action per kind, as the iPhone: Mark
  done (a check, a task), Log one (several a day), Log 1 glass (one tap), Log amount (typed each time), Start / Pause
  (time), Log 1 cup (a limit), none for a checklist (its steps sit in the card and ‹ › share the row), Next / Finish
  routine once done or skipped. **The iPhone's "Saved · Undo · Add Note" banner is Material's snackbar** (dark, corners
  4, Undo and Add note as its actions). ⋮: Day details, View routine, Go to first unfinished, End routine. Your routine
  is a modal bottom sheet (Edit, ✓ for done, ▶ for the current one). The end page is the same card (the cookie in ink),
  with Return to unfinished (tonal) and Done (large, ink). The timer: ⌄ to put it away, the same card, and a button
  group of Log manually (tonal) and Pause (ink).
- **Long labels and long checklists in the player** (the user, 12 Oct: "in real world scenario this is not going to
  work"). **‹ and › are 56 wide** (still well over 48), the main button takes the rest, its label 18 Medium. **When a
  label doesn't fit beside its icon, the icon moves above it and the label may wrap to a second line** (withdrawn, see below) inside the
  96-high button. **Corrected the same day (the user): the main button's label stays on one line, its icon beside it,
  and a long label ends in an ellipsis** ("Log 2.5 kilom…", `1347:2`), so the button group keeps its sizes and
  spacing; TalkBack reads the whole label. (The icon-above, two-line version is withdrawn.) **A checklist with many steps**
  (`1347:57`): the header turns compact (a 64 cookie beside the name and the day chip), then the count and the wavy
  bar, and **the steps scroll inside the card** with a fade and a scroll indicator at the bottom showing there's more.
- **Habit details** (12 Oct, from the built app; the iPhone opens on History): **a large top app bar** whose title is
  the habit (the cookie icon, "Water" 28, the goal as its subtitle; it collapses to a small bar on scroll; this also
  avoids the iPhone's doubled "Water", Current Work 95); **Material primary tabs** History · Notes · Progress, pinned,
  with an ink indicator under the selected label. History: Add log and Go to date as tonal buttons; What the squares
  mean collapsed; each month a segmented group (header "October 2026 / Reached on 12 of 12 days so far" ⌃, then a row
  per day: the day's square, "Mon 12 Today", "8/8 glasses · 8 logs" (**logs, not the iPhone's "entries"**), a note icon
  when there's a note, ›). Notes: a Material search bar, Add note, notes grouped by month with the text wrapping.
  Progress: the iPhone's cards in order (Overall record with four tiles, the current streak's tinted; Milestones with
  **cookie badges** and **circular progress** for Next; Week, Month with its bar chart, Year in Pixels), each with
  ‹ › icon buttons where the iPhone has them. The today square has an outside ring (its rows must not clip it). ⋮:
  Edit habit, Pause…, Archive, then Delete in red.
- **Progress** (12 Oct, from the built app): a drawer destination, so its top app bar leads with **≡**, not ← (back
  goes to Today); title "Progress", ⋮. **Week · Month · Year as a Material connected button group** (selected: ink with
  a check, others tonal; outer corners 20, inner 8). The period navigator "‹ 11–17 Oct / This week ›" (› off on the
  current period). What the squares mean, collapsed. **One card per habit in the iPhone's order and words**: the
  habit's cookie icon, name and goal, › to Habit details; the summary ("Reached on 2 of 2 days so far" / "16 glasses
  this week"; "1 of 3 this week" / "2 to go · 6 days left"; "Met 4 of 6 weeks so far"; "Every step on 2 of 2 days so
  far"); then the period's squares: the week's seven, the month's calendar, or the year's weekday × week grid aligned to
  the latest week. Square states: done (the habit's colour, ✓), part (its colour at 50 %), not done (grey ✗), not
  scheduled (dashed outline), still to come (grey); today has an outside ink ring. **No ⋮ menu** (the user, 12 Oct:
  "overall, we don't need these options … we will get to know from users"): the iPhone's Show Percentages, Show Streaks
  and Full Day are dropped. Checked first: Full day is ledger C201 (Strong, 4 apps) and percentages had one direct ask;
  hiding streaks is part of C157 (Certain) and C207 (Certain), but Progress shows no streaks, so its switch did nothing
  here. If people ask to hide streaks, it returns in Appearance (Current Work 96).
- **Times of Day** (12 Oct, from the built app, made Expressive at the user's request): rows with the name, the times
  as supporting text and ›; **no icons** (a time of day has no icon to choose) and **no coloured day timeline** (tried
  and removed the same day, the user: "user can't set a coloring here … make it clean and simple"). **Add time of day
  is an extended FAB** (ink, corners 16, bottom right; Clock adds alarms this way), not the iPhone's last row. New /
  Edit: ✕, the large borderless name, then **one Starts tile** (36, like Clock; an `edit` pencil at its top right; it
  opens the time picker) with **the end worked out under it as plain grey text**, "Ends 6:00 AM, when Morning starts"
  (the last one: "…, when your new day starts"), the iPhone's footer, then **Your day**. **14 Oct 2026 (the user: "end
  is looking the same as start … the user can easily mistake … it can also be editable"):** the Ends tile is gone,
  because the end isn't asked for (Current Work 108). Rereading the Day Structure study's 28 reviews about section
  times showed people set when parts of their day *start*; none asks for a gap or an end before the next start, one
  asks for the others to "adjust automatically", and the few "end" requests are about getting past midnight, which
  New day starts at covers (report 25). **Your day marks the row the page is about with a chip** (**+ New**, or
  **✎ Editing**; the user: "no change chip feels … weird … indicate like this is the current section"), its name
  Medium; **a row whose times change** shows its new range in ink and "Was 6:00 AM – 12:00 PM" under it; **an
  unchanged row has no badge** and its range stays grey, so "No change" is gone. Drawn: Edit · Afternoon · start
  moved (`1746:10`). Edit ends with Delete time of day (red on grey, 56) and shows the time of day's real end (the
  iPhone shows start + 1 h: Current Work 97). **The same full page opens from the habit form** (2.1.4.1, `1746:71`):
  the dialog was deleted (the user, 14 Oct: the page "is clearly showing … your entire day and where the new section
  is getting added"). The section (`1437:2`) is in Google Sans Flex, its frames named without "Android ·". **A new time of day opens in free
  time and splits nothing** (the user: no "randomly new timings"): with the standard set, 4:00–6:00 AM, just before
  Morning; the rule, shared with the iPhone, is Current Work 98.
- **Onboarding: coming back, 14 Oct 2026** (section `1549:2`, above "new to the app"; research: [Coming Back — Every Way
  to Get Your Habits Back](<../../Research/Research Reports/Data, Sync and Accounts/Coming Back — Every Way to Get Your Habits Back.md>)).
  The user found the first layout confusing (iCloud appeared under Google) and approved a simpler one: **one question,
  "where are your habits?", four answers**, each a row: 2 Google account (choose, allow Drive, look; found → habits
  back → Today, wrong account → shows which one, nothing found → try another way; Start fresh? dialog), 3 Apple account
  (found in Drive → connect it; **in iCloud → use a code from the iPhone**, the only place iCloud appears; no account),
  4 Old phone (enter its code, and the old phone's side), 5 Backup file. A free person's "Move here" is a question
  inside "habits back", not its own outcome. Empty frames are named for their job, to design one by one.
  - **1 · Welcome back** (`1549:3`, designed 14 Oct, **redesigned the same day around signing in**). The user: "if they
    have an account, this is how they think … signing in is what is intuitive", and "the whole purpose of the account
    is recognizing the place". A person with an account signs in and the account knows where the habits are (which
    Google Drive or iCloud, by its private ID), so the app goes there by itself; the "where are your habits?" question
    only helps someone without one. So: onboarding's top bar and heading, **"Welcome back."** and **"Sign in to get your
    habits back."**; two sign-in buttons the same size (Google's and Apple's own rules), **Continue with Google** (white,
    grey outline, the four-colour G) and **Continue with Apple** (black, the Apple logo), 56 tall, 16 Medium; then
    **Other ways** (14 Medium, grey) and a two-row card: **Your old phone** · Move them with a code, **A backup file** · A
    file you saved. Continue with Google also serves someone with no account: it looks in that Google account's Drive,
    where free backups go. Every text uses the Android styles. (The first version, four equal rows under "Where are
    your habits?", and its "Not sure?" note are gone.)
  - **2 · Google account: choose one** (`1549:38`) and **2.1 · Allow Google Drive** (`1549:97`) are **Google's own
    screens** (Google Play services draws them), so they're drawn in Google's font, Google Sans (our Google Sans Flex,
    with the Android styles at Google's sizes), Google's blue buttons and the real four-colour G; screen 1 sits behind
    the sheet. **2.1 shows only the first time a Google account gives Often Enough Drive access** (the user asked
    whether it shows on every new phone): Google keeps the permission in the account, so a new phone signed in to the
    same account gets access with no screen ("in subsequent sessions, and as long as the granted permissions are not
    removed by the user … without any user interaction", Android's AuthorizationClient guide). It comes back only if
    the person removes the access in their Google Account. A device with one Google account and a default set may skip
    the chooser too.
  - **2.2 · Looking in Google Drive** (`1549:128`, designed 14 Oct): centred, Material 3 Expressive's **contained
    loading indicator** (a 64 grey circle, an ink shape) over "Looking for your habits" (22 Medium) and "In
    sam@gmail.com’s Google Drive" (14, grey: says which account, from the wrong-account evidence), Cancel at the bottom.
    **Animated in Figma** (4.55 s loop): the shape steps through Material's seven loading shapes (soft burst, 9-sided
    cookie, pentagon, pill, sunny, 4-sided cookie, oval) every 0.65 s, each settling from 86 % as it arrives, while the
    group turns two full turns. Figma can't morph one shape into another, so each crossfades into the next; the app
    uses Compose's `ContainedLoadingIndicator`, which morphs for real. Checked frame by frame from a render.
  - **Row 2 rearranged (the user: "it's a one-time thing … it should be like an if condition"):** 2 goes straight to
    2.2; 2.1 (Allow Google Drive) sits under 2 on a dashed arrow, "only if this account hasn't allowed it before", and
    joins 2.2; the outcomes moved one column left.
  - **2.3 · Habits back: what was found** (`1789:2`): onboarding's top bar and heading ("Welcome back." and "Your
    habits are in sam@gmail.com’s Google Drive." — which account, from the wrong-account evidence); **one card for the
    copy found, described as Settings' Restore preview describes a backup**: a history icon, "31 habits, 929 logs" (20
    Medium) and "From a Pixel 9 · today, 9:14 AM" (14, grey: when and from where, from the old-copy evidence); "Plus
    comes back too." under it when it does. At the bottom one filled **Bring them back** and a text button **Start
    fresh instead** (never deletes anything: the copy stays in Drive). No merge or replace choice: a new phone has
    nothing to merge with. A free person whose habits sync on another phone gets one more line here (Move here).
  - **2.3.1 · Bringing them back** (`1789:3`): 2.2's centred layout and its animated indicator, "Bringing back your
    habits" and "18 of 31 habits"; no Cancel (a restore isn't stopped halfway).
  - **2.3.2 · Today** (`1789:4`): Today as designed, with a snackbar above the day bar, "Your habits are back: 31
    habits, 929 logs" (no Undo: there was nothing on the phone to go back to).
  - **The flow follows the sign-in screen (14 Oct):** rows named for the buttons (2 · Continue with Google, 3 · Continue
    with Apple); 2.3's heading became **"We found your habits."** (screen 1 is now "Welcome back."); 3.2 offers one tap,
    Continue with Google (the app checks the account's private ID after the pick; no email shown), then 2.2; a new **2.5 · In
    iCloud: use a code from your iPhone** for someone who signs in with Google but whose habits are in an iPhone's
    iCloud; rows 3–5 moved down to make room.
  - **The wrong-account screen was removed (14 Oct).** The user: "how you're knowing … this is a wrong account …
    this might also be like security issue like revealing the other person's account name". Right on both counts: when
    someone picks a different Google account than last time, the app only learns about the one just picked, so it
    can't name the other; and naming accounts isn't needed. **The app never names another account** (D16 corrected).
    A Drive backed up to a different Google account still works (its permission belongs to that Drive's account): the
    person chooses it, and the app compares the account's private ID after the pick.
  - **2.4 · No habits found** (`1789:6`): **"No habits found."** and "Nothing in sam@gmail.com’s Drive."; **Choose
    another Google account** as the filled button at the bottom (the likely fix), Start fresh under it (straight to setup, no
    dialog: nothing to leave behind); **Other ways** in the middle: Continue with Apple, Your old phone, A backup file.
  - **2.3.3 · Start fresh?** (`1789:7`, over 2.3, from its "Start fresh instead"): Material 3's basic dialog, "Start
    fresh?", "Your habits stay where they are, so you can bring them back later." (true for Drive and iCloud alike;
    it first said "in your Google Drive", wrong from 3.3), Cancel and Start fresh. No email.
  - **2.4's button is "Choose another Google account"; no separate "Google Drive account" choice** (the user asked
    for research on it): no review separates the sign-in account from the backup account, so one choice looks for both.
  - **2.6 · In another Google account** (`1803:2`): for the one case the app *knows* (the person's own record says the
    backups are in a different Google account, e.g. changed in Google Drive & Backup): **"One more step."** "Your habits
    are backed up to a different Google account. Choose it to bring them back." **Choose that Google account** (Google's
    chooser; the app compares the account's private ID after the pick; the wrong one shows this screen again) and Start
    fresh instead (the dialog). **No account is named.** The Apple row's 3.2 is the same screen.
  - **Row 2 now:** 2 → (2.1 first time only) → 2.2 → 2.3 found (→ 2.3.1 → 2.3.2 Today; → 2.3.3 Start fresh?), 2.4 no
    habits found, 2.5 in iCloud, 2.6 in another Google account.
  - **Screen 1's Continue with Google has no outline** (the user: "that much thick visible border … not looking good"):
    white on the grey page, the G and 16 Medium text; Google's own button rules allow this borderless (neutral) form.
    Screen 2's sheet now sits over the current screen 1.
  - **The Apple row (14 Oct).** **3 · Continue with Apple** (`1789:8`) is **Apple's own sign-in page in a browser tab**:
    on Android, Sign in with Apple is Apple's web page, not a phone sheet, so it's drawn as Chrome shows it (Chrome's tab
    bar: ✕, "Sign in with Apple", 🔒 appleid.apple.com, ⋮) with Apple's page in **SF Pro** (the Apple logo, "Sign in with
    Apple" 28 Semibold, "Use your Apple Account to sign in to Often Enough." 17, the Email or Phone Number field with its
    → , "Forgot password?" in Apple's blue); Apple's password, code and Share/Hide My Email steps follow on its own
    pages. **3.1 · Looking for your habits** (`1789:9`): 2.2's animated screen, "Signed in with Apple". **3.2**
    (`1789:10`): the same screen as 2.6, One more step. **3.3 · They're on your iPhone** (`1789:11`): "Android can't
    open iCloud, so move them across with a code."; three numbered steps (1 Open the app on your iPhone · Or on your
    iPad; 2 Choose Move to a new phone · In ≡ › iCloud & Backup; 3 Type its code on this phone · It works for 24 hours);
    **Enter the code** (→ 4) and Start fresh instead. **3.4 · No account found** (`1789:12`): "No Often Enough account
    uses this Apple Account." (the one just used, never another); Other ways: Another Apple Account, Your old phone, A
    backup file; **Continue with Google** (screen 1's white button) as the main action, the usual reason an Apple
    sign-in finds nothing; Start fresh. Never creates an account by itself (D3).
  - **Screen 1, third version (14 Oct, after the user's decision that free people have no account at all; D16).**
    "Welcome back." and "Choose how to bring your habits back."; **With your Plus account**: Continue with Google,
    Continue with Apple; **Without an account**: **Google Drive** · Your backups there (the Drive logo: a free person's
    backup, which can be a different Google account from a Plus sign-in, so it's its own row), Your old phone, A backup
    file. Nobody has to wonder whether they "have an account": only Plus people made one, on purpose. The flow below
    screen 1 still follows the previous version; its changes are listed for the user.
  - **The flow restructured into six rows to match screen 1 (14 Oct, the user: "update whatever the screens that we need
    to update in the remaining flow").** **2 · Continue with Google** and **3 · Continue with Apple** are for Plus
    accounts and **always bring Plus back**; each goes 2/3 → Looking (signed in with Google / Apple) → **Found** ("We
    found your habits." "Plus is on, and your habits are in your Google Drive."), **In iCloud** ("They're on your
    iPhone." "Plus is on. Android can't open iCloud, so move your habits across with a code.", the three steps, "No
    iPhone? Any iPhone or iPad on your Apple Account can make the code.", Enter the code → 5) or **No account found**
    ("No Plus account uses sam@gmail.com." / "…this Apple Account."; Without an account: Google Drive, Your old phone, A
    backup file; the other sign-in as the main button; Start fresh). **4 · Google Drive** is a free person's backup:
    Google's sheet ("the account you back up to"), Allow Google Drive (dashed, first time only), Looking in Google
    Drive, Found (no Plus line) → Bringing back → Today, Start fresh? (the one dialog, used from every Found and In
    iCloud screen), and **No habits found** (Choose another Google account; Your old phone, A backup file; Start fresh).
    **5 · Old phone** (the code, which carries Plus too) and **6 · Backup file** are still empty frames. "One more step"
    (2.6, 3.2) is gone: an account goes to its own backups by itself, **assuming the account keeps the backup account's
    email privately, never shown (proposed; waiting for the user's yes)**. Screen 2's sheet shows the current screen 1.
  - **14 Oct, the user's review of the six rows.** The Google row is right as built: Found when the Plus account's
    backups are in Google Drive, They're on your iPhone when they're in iCloud, No account found otherwise; the Apple
    row's Found only when its backups are in Google Drive (allowed before, so it opens by itself). **Words: signing in is
    a Google account (or Apple Account), backups are a Google Drive.** **No account found (2.4, 3.4)** now lists **Try
    another account** (2.4: Another Google account · Choose a different one, Continue with Apple · If you made it with
    Apple; 3.4: Another Apple Account, Continue with Google) above Without an account, with only Start fresh at the
    bottom: one button would have had people guessing which of two things it meant. **No habits found (4.4)**: **Try
    another Google Drive**. Google's own sheets (4, 4.1) keep "Sign in with Google": Google's wording, not ours. **To
    revisit:** the iCloud steps' words (2.3, 3.3) once the account and iCloud & Backup pages are redesigned (Current
    Work 110).
  - ~~5 · Old phone, a 12-character code (14 Oct, replaced the same day by the QR / 6-digit row below).~~ **5 · Old phone, the new phone's side only (14 Oct).** The user: "we don't need to design the old phone … generating
    the code … belongs to the move it to another phone page where we have in the navigation". The old phone's screen was
    removed from this section. **5 · Enter the code** (`1789:13`): "Enter the code." "Type the code your old phone
    shows."; Material's outlined text field (focused, the file's style) labelled Code with "7K4M-92QX-HB3T"; "On your old
    phone, open Move to a new phone." (12, grey; revisit with the iCloud steps); **Continue** riding above Gboard's
    letters keyboard. **5.1.1 · This code didn't work** (`1789:17`): the same screen, the code kept as typed, and in ink
    (never red) with an error icon: "That code didn't work. Check it, or get a new one on your old phone." **5.1 ·
    Getting your habits** (`1789:14`): the animated indicator, "From your old phone". **5.2 · Your habits are here**
    (`1789:15`): "Everything your old phone sent."; the card (31 habits, 929 logs · From a Pixel 9 · today, 9:14 AM);
    "Plus came too." when it did; **Bring them back** (no Start fresh: they asked for this move). **5.3 · Today**
    (`1789:16`), with the snackbar. **To check:** the drawer has no Move to a new phone page today (Google Drive &
    Backup's "Move to another device" was removed on 12 Oct, before the code move came back, D15): it needs a place.
  - **Row 5 redesigned: scan a QR code, or type 6 digits (14 Oct; Rulebook D15).** The user rejected the 12-character
    field and asked for both ways. **5 · From your old phone** (`1815:2`): "Keep the app open on both phones." (it first said "…and close by"; the user: the relay works however far apart they are, and typing the 6 digits needs no camera); two
    steps (Open Move to a new phone · On your old phone; Scan the code it shows · Or type its 6 digits); **Scan the
    code** and Type the code instead. **5.1 · Google's code scanner** (`1815:3`, Android's own: dark camera view, a
    guide frame, ✕ and torch, "Point your camera at a QR code"). **5.2 · Type the code** (`1789:13`): "Type the code."
    "The 6 digits on your old phone."; **six boxes** (48 × 56, white, the focused one with an ink outline), Gboard's
    **number keypad**, "It checks itself when all 6 are in." and **no button** (nothing greyed out). **5.2.1** (`1789:17`):
    empty boxes and "That code didn't work. Your old phone now shows a new one." (one guess per code: **the server ends the code
    on the wrong try and at once tells the old phone, through the relay, to show a new QR and 6 digits**, D15; the Move to a
    new phone page must show that change live). **5.3 · Getting
    your habits** (`1789:14`): "Keep both phones open". **5.4 · Your habits are here** (`1789:15`), **5.5 · Today**
    (`1789:16`). The old phone's QR and digits belong on Move to a new phone in the menu (not designed yet).
  - **Row 6 · Backup file (14 Oct).** **6 · Choose the file** (Android's own file picker, the same as Settings' Restore,
    `1472:155`, in Google Sans: Recent / Downloads / Drive, "Often Enough backup 2026-10-12 0914.zip", shortened in the
    middle to one line as Android's picker draws long names). **One backup file on every device** (the user, 14 Oct 2026:
    "the backup file created on iOS as well as Android should be the same everywhere"): the shared core's checked zip,
    named `Often Enough backup YYYY-MM-DD HHmm.zip`, never `.db` or `.oftenenough` (Rulebook D5; why: `Core/Backup File
    Format.md`, "One file on every device"). **6.1 · Your backup file**: "Your backup file." with the file's whole name
    under it, on one line (it fills the width: a name isn't prose); the card (a document icon, "31 habits, 929 logs",
    "From a Pixel 9 · 12 Oct, 9:14 AM": when and from where, as everywhere); **Bring them back** and Choose another file
    (no merge or replace: a new phone has nothing to merge). **6.2 · Bringing them back** (the animated indicator), **6.3
    · Today** (the snackbar). **6.1.1 · That isn't a backup**: "Choose a file whose name starts with “Often Enough
    backup”." and **Choose another file**. A file carries habits, not Plus: a Plus person signs in to bring Plus.
  - **The iPhone, for later:** an iPhone or iPad on the same Apple Account shows **no screen at all**: iCloud asks no
    permission, so the habits come back when the app opens (D14). The iPhone's version of this flow starts from that
    case; "Welcome back" there is for a different Apple Account, Google Drive, the old phone or a file.
- **The Android designs are light mode only (the user, 14 Oct 2026):** "for the sake of simplicity we will only keeping
  light mode". Draw no dark frames; the dark splash was removed from onboarding. **The app keeps its dark mode** (already
  built): every screen built from a light design still follows the phone's dark theme, so the app's colours stay tokens.
- **Appearance became General, 14 Oct 2026** (Figma `1458:3`, menu open `1458:85`, the drawer `1326:3`/`1326:231`;
  **not built**). The user: the page "is more than appearance … choose the proper name", "System" not "System
  default", "the same width for each option", "checkmark is definitely not a good thing" for System, and "can we
  improve the theme selection". **General** is what Google's own Android apps (Gmail, Calendar) call this mix of
  look and behaviour; the drawer's row is General with the `tune` icon. On the page:
  - **Theme: three equal tiles**, each a small preview of the app in that theme (three rows with a habit-colour dot),
    with a radio and its name under it: Light, Dark, **System** (the preview half light, half dark). The chosen tile
    has a 2-wide ink outline and a filled radio; the others a 1-wide outline. "System follows your phone's dark theme."
  - **Rows as Day and Week's** (round grey icons, 16 Medium over 14 Regular); **each switch's explanation is its own
    one-line supporting text** in place of the 12-pt paragraphs: Vibration · A light buzz as you log; Sound when done
    · Follows your sound mode; Open timer full screen · Swipe down to hide it; Show in notifications · Even on the
    lock screen. Done habits keeps one footer: "They move once you stop ticking, never mid-tap."
  - The Done habits menu opens 4 under its row, right edges together (onboarding's menu).
- **Day and Week, 14 Oct 2026** (Figma `1449:3`, `1449:51`, `1768:100`; **not built yet**). The user: change the font,
  "it needs to match onboarding" (the menus), "in general improve the screen", "use our text styles", and the Clock
  group "feels like … a configuration section rather than information … if it is information then present it well".
  **Android first, never the iPhone's layout or words** (the user, 14 Oct: "just because in the iPhone we have it some
  way, don't do it that way … everything should feel native").
  - **The two settings are onboarding 06's card**: two rows 2 apart (outer corners 24, inner 4), round grey icons, 16
    Medium over 14 Regular, ▾. Top bar as Times of Day (22 Medium).
  - **Information sits on the page, not in a card.** A white card says "tap me"; the old Clock rows looked like settings.
    Android's own Settings puts a page's explanation on the page itself (`SettingsLib` `FooterPreference`: no
    container, secondary colour, an optional link). A first version as an ⓘ and four sentences was "too much text"
    (the user, 14 Oct: "present it in a better way … easy to read and understand"), so it's **a Material list with no
    container**, under a "How it works" subheader (14 Medium, grey): each fact a leading icon (24, grey, no circle, in
    line with the setting icons above), a **short headline to skim** (14 Medium, ink) and one short supporting line
    (14 Regular, grey), 16 apart: 🌙 bedtime **Late nights** "Logs before your new day starts count for the day
    before." · calendar_view_week **Weekly goals and streaks** "Use the week you choose above." · flight **Travel and
    clock changes** "Your logs keep their day." · schedule **12 or 24-hour time** "Follows your phone's setting." with
    **Date & time settings** (14 Medium, ink, underlined) under it, opening Android's own Date & time page
    (`Settings.ACTION_DATE_SETTINGS`) in place of spelling out the path. The per-row footers and the "Clock" header
    are gone.
  - **Both menus have a frame** ("day and week should have these both"), and open as onboarding's: 4 under their own
    row, right edges together; New day starts at runs 12:00 AM to 12:00 PM and stops 24 above the navigation bar,
    scrolling (scroll bar as onboarding); Week starts on shows all seven days.
- **Day and Week** (12 Oct, from the built app): two **dropdown rows** (Material's exposed dropdown menu: leading icon,
  title, the value as supporting text, ▾; it opens a menu with ✓ on the chosen value, scrolling when long): **New day
  starts at** as exact times (**12:00 AM**, 1:00 AM … 12:00 PM; **never "Midnight"**, the user: "user has to click on
  it, see what is midnight") and **Week starts on** (the seven weekdays, **default Sunday, no "Automatic"**), each with
  the iPhone's footer, minus "Automatic follows your region" (Current Work 99, the same fix on the iPhone). The **Clock** group keeps its two notes as quiet rows (14, grey, an icon each): "Times follow your
  phone's 24-hour time setting, in Settings › System › Date & time" (Android's path, not General › Date & Time) and the
  daylight-saving note. Sentence case: "New day starts at", "Week starts on".
- **Keep reminders coming, 14 Oct 2026** (Figma `1775:2`, after "a reminder that didn't arrive", arrow from Show me
  how; **not built**). The user: "when they click on show me how, where does it take them? … we should showcase some in
  app screen … I think that screen is missing." The app's Show me how (and the reminder check's Battery **Fix**) opened
  Android's battery-optimisation list straight away (`ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS`): every app on the
  phone, with no word on what to change. The research had said to show **the phone maker's own steps** (Android app
  report §4 point 5; Play forbids asking for the exemption directly). The new page, titled **Keep reminders coming**:
  one plain line on why ("Samsung puts apps to sleep to save battery, which can stop reminders."), then the steps as
  onboarding's two-row card, a number where the icon goes, each step's **action as its headline in the maker's own
  words** and where it is as the line under it, and its own **Open**: 1 Set battery to Unrestricted · App info ›
  Battery (opens the app's own App info, `ACTION_APPLICATION_DETAILS_SETTINGS`); 2 Add it to Never sleeping apps ·
  Battery › Background usage limits (opens Battery). Then "Good to know" as the information list: Only for Often
  Enough / Other apps keep saving battery · Open takes you there / Then come back here. **Per maker** (same page,
  `missedReason`'s three cases): Xiaomi's steps are Autostart on and Battery saver › No restrictions; every other phone
  one step, App battery usage › Unrestricted. The menu names on each maker's current version still need checking on
  real phones (D12: a Samsung and a Xiaomi). **Battery Fix opens this same page** (the user, 14 Oct: "keep the same
  page itself"; arrow `1776:2`): one place explains the phone's battery steps, whichever way in.
- **A habit's Reminders moved into the form's flow, 14 Oct 2026** (the user: "these two screens … should be in this
  section … they don't belong here"). "Habit · Reminders · on" and its "Get reminders on time" sheet left Settings:
  Reminders for **New: choices and habit form** (`1302:2`) as **2.1.6 · Reminders** (`1456:91`, under Group, as the
  form's rows run: Group, Reminders, Starts) and **2.1.6.1 · Get reminders on time (sheet)** (`1456:164`, to its right,
  with an arrow from Remind me). Starts and Ends became **2.1.7** and **2.1.8**; everything from Starts down, and every
  section below on the page, moved down 938 to keep the gaps; the form's arrows step in a lane (Group 1548, Reminders
  1536, Starts 1524, Ends 1512). Settings: Reminders keeps the page and "a reminder that didn't arrive".
- **Reminders, 14 Oct 2026** (Figma `1456:3` only; **not built yet**; the other three frames in the section still say
  "Exact times"). The user asked why Android has no alarm permission like the iPhone. **It has one:** the row called
  "Exact times" *is* Android's alarm permission, which Android itself names **Alarms & reminders** (Settings › Apps ›
  Special app access), so the row now uses Android's name and "Off: up to 10 min late" (D1). The Alarm style itself
  is built (D3): `setAlarmClock`, the alarm sound on the alarm stream, ringing until stopped (`FLAG_INSISTENT`).
  What Android doesn't give us is a full-screen alarm: since Android 14, Google Play keeps full-screen intents for
  alarm-clock and calling apps. Other changes, to the user's "improve it further":
  - **The check leads with its state:** "Fix 1 thing so reminders come on time." (all fine: say so), not a description
    of the check.
  - **A habit row's times and its style are two lines** ("8:00 AM · 2:00 PM" / "Notification"; "8:00 AM" / "Alarm ·
    again every 15 min"), not one sentence wrapping at a random word.
  - **The 12-pt footer under With reminders became a "How it works" list at the page's end**, Day and Week's
    pattern (no container; icon, 14 Medium headline, 14 Regular line): Only on planned days / Days off stay quiet ·
    Stops when done / No more reminders that day · Alarm or notification / An alarm rings until you stop it ·
    Paused or archived / Reminders are kept but stay quiet. The frame is the page at full length (1246).
- **Reminders** (12 Oct; the iPhone's page plus decisions A11 D1–D3): the iPhone's "On This iPhone" group becomes a
  **Reminder check** card (D2): Notifications, **Exact times** and **Battery**, each with its state in words and either a
  ✓ or one ink button that opens that setting ("Allow", "Fix"); exact times off says "reminders may come up to 10
  minutes late" (D1). Then the iPhone's **With reminders** (each habit's times, Notification / Alarm, "Again every 15
  min") and **Without reminders** groups, habits with their cookie icons. **A habit's reminders**: "Remind me" switch
  (Material switch, on = ink with a ✓ thumb; the chrome stays monochrome, U2), the times as removable rows with time
  pills, Add another reminder, **Remind me with** (A notification / An alarm, D3) and **If not done, remind again**
  (Never / Every 15 min / 30 min / hour) as dropdowns, the iPhone's outcome sentence, Reminder says. **Exact times are
  asked for in context** (D1): after notifications are allowed for the first reminder, a bottom sheet "Get reminders on
  time" explains in two sentences and opens Alarms & reminders ("Allow exact times" / "Not now"); never at first launch.
  **A reminder that didn't arrive** (D2) shows **once**, at the top of Reminders: what happened in plain words, that
  phone maker's reason, "Show me how" and "Dismiss"; it never blames the person, and the check below shows what to fix.
  Never a direct battery-exemption request (Play policy).
- **Appearance** (12 Oct, the iPhone's groups and footers): **Theme as a connected button group** Light · Dark ·
  **System default** (Android's own word for following the phone; the iPhone says "Automatic"), the chosen one ink with
  a ✓; Today's **Done habits** as a dropdown (Move to bottom / Stay in place); **When you tick**: **Vibration** (Android's
  word for the iPhone's "Haptics") and Sound when done, the chime "follows your phone's sound mode"; **Timers**: Open
  timer full screen and **Show in notifications** (the iPhone's "Show on Lock Screen"; on Android a running timer is a
  Live Update in the notifications, lock screen and status bar, A11 D4). Switches on are ink with a ✓ thumb. **A
  connected button group's buttons keep at least 16 of padding at each side and take their width from their labels**
  (the spare width shared equally), so a long label like "System default" never touches the edges (the user, 12 Oct).
- **Google Drive & Backup** (12 Oct; the iPhone's iCloud & Backup with Google Drive in iCloud's place, A4/A10;
  **rebuilt the same day** on the structure of the researched Backup & Export mockups, `950:309`, after the user found
  the first version confusing). The page answers three questions, in order: **is my data safe?** (one status card),
  **how do I get it back?** (**Restore**) and **how do I take it out?** (**Export**). The status card (corners 28, a 56
  icon disc, ink when backed up or synced; title; when · where; one line of why; actions that share the row equally) has
  four states: **Not backed up** ("Your habits are only on this phone", Back up to Google Drive, the promise that we never
  see the habits, D16); **Backed up** (free: "Today 9:14 AM · Google Drive (sam@gmail.com)", D4's rhythm in one sentence,
  Back up now / Change account); **Synced** (Plus: Sync now / Change account); **No internet** (A6: "3 changes waiting to
  sync", "Everything works offline …", Try again; never blaming the person). **Devices** (kept, the user liked it): this
  phone and the others with when each last synced; on the free plan, this phone plus "Use on more devices … with Plus".
  **Restore**: one row, *Restore from a backup* ›, which asks **"Where is your backup?"**: Google Drive ("Any day of the
  last week, month or six months") or **A backup file** (this is where importing lives; there's no separate Import
  row), "Restoring replaces the habits on this phone. You can undo it for 30 days" (D5). **Export**: Save a backup file
  ("To restore later, here or on another device") and Export a spreadsheet (CSV). **Last, a red group** (kept from the
  iPhone and its research; the user: "if we need to have erase … add it back"): **Delete my data from Google Drive…**
  (when connected) and **Erase all my data…**, each asking in Material's dialog first (the iPhone's words): Delete asks
  "Delete your data from Google Drive?" with Save a backup file first / Delete from Google Drive / Delete from Google
  Drive and this phone / Cancel; Erase asks with Save a backup file first / Erase everything (red) / Cancel; it's the only way to clear the app's hidden copy in Drive, which uninstalling leaves
  behind. **Gone:** "Backup files: only on this phone", a separate Import row, and Move to another device (removed by the
  user). Example accounts are generic.
- **Restore: which screens are ours and which are Android's** (12 Oct). Backups live in Drive's private **app data
  folder** (`drive.appdata`, A4), which Google hides from the Drive app and drive.google.com, so **Restore from Google
  Drive is our own UI**: "Google Drive" lists the backups by device ("Pixel 9 · this phone", "Pixel Tablet") and day
  (Today 9:14 AM, Yesterday, a week, a month, six months back), each with "12 habits, 840 logs". **Native, drawn as
  Android shows them:** Android's **Google account chooser** sheet ("Choose an account · to continue to Often Enough",
  only if no account is connected yet) and **Google's permission screen** for the Drive app-data scope; and for **A
  backup file**, Android's **system file picker** (Storage Access Framework: Recent / Downloads / Drive). Both routes then
  share our **Restore** preview (D5): "12 habits, 840 logs · From "Pixel 9", 12 Oct 2026, 9:14 AM", "On this phone now",
  **Replace what's on this phone** (ink) and **Merge** (tonal), each with what it will change, and "You can undo a restore
  for 30 days"; after it, a snackbar "Restored: 12 habits, 840 logs · Undo" and an **Undo last restore** row (until the
  30 days end). Android says **logs** where the iPhone's restore says "check-ins" (Current Work 95).
- **Privacy & Security and App lock** (12 Oct, the iPhone's page and App Lock decisions 1–4): App lock › (Off); **Outside
  the app**: Hide names outside the app ("Widgets, reminders, alarms and Google Assistant show icons and numbers");
  **Help improve the app**: Share usage, Share crash diagnostics (off and dimmed, "Not available yet"); the closing line
  **"No ads. No account. Your habits stay on your phone and in your own Google Drive; we never see them."** (D16; the
  iPhone still says "An account is optional": Current Work 101). **The iPhone's Face ID and iPhone passcode become one
  choice on Android, "Your phone's lock"** ("Fingerprint, face, PIN or pattern: whatever unlocks this phone. Android
  chooses which to show"): Android's BiometricPrompt doesn't let an app pick fingerprint or face, it uses what the person
  set up, with the screen lock as the fallback, so there's no second question. The other choice is **An app passcode**
  (six digits). **The flow, in order** (the user, 12 Oct): App lock off → switch on → **"How do you want to unlock Often
  Enough?"** (two radio rows, Continue) → your phone's lock: **Android's prompt once, "Confirm it's you"**, to check it
  works; or an app passcode: **Create an app passcode** → **Enter it again** → **App lock, on** (the switch, **Unlock
  with**, **Lock again** Immediately / After 1 minute / After 15 minutes, "Locking your phone always locks the app at
  once"). Later, opening the app: a white cover with the ink cookie lock, "Often Enough is locked", under Android's
  prompt "Unlock Often Enough"; or the app passcode screen (six dots, round keys, Forgot app passcode? → the 24-hour
  reset, App Lock decision 2).
- **Plus** (rebuilt 12 Oct after the user's reviews): **the light app icon** (Figma `1160:161`: the tonal three-tile
  mark on white, app-icon corners; the user, after a gold logo and a gold tile were tried: "let's use this logo
  itself … since we are in the light mode"). **The price comes first, what Plus adds second** (the user: "what is the
  price, that is the most important thing, and what it unlocks is the second"). Buy, top to bottom: a **left-aligned
  header** (the icon at 64 px beside "Plus" / "One payment, yours forever."; the user: "the header … left aligned, I
  really liked it"); the **free-habits card** ("3 of 5 free habits used · 2 left" with a linear bar; the user: "that
  limit was amazing, let's add it back"); the **plan rows**, one segmented list, no outline: Plus · Just you · $24.99 ·
  one-time and **Plus Family** · You + 5 people, each with their own habits · $59.99 · one-time, the chosen one with a
  filled radio on the neutral tone `#E6E6EA` (U2); then **What you get with Plus, one list** of two-line rows (a tonal
  round icon, a title, one line; the user: "let's combine everything together … what you will get in the Plus"):
  Unlimited habits (Free has 5. Add as many as you like.), More widgets (Today's list and This week, A13), Tablet,
  Wear OS watch, Windows app (A14), **Synced through Google Drive** (never "your own Google Drive": the user, "syncing
  through Google Drive, that's it"). Pinned at the bottom on the page's background: **Get Plus · $24.99** and a
  full-width tonal **Restore purchases** (no "One-time, no subscription" line). The first screen (360 × 800) shows the
  price, both plans and the button. **Restore purchases lives only on the buy screen** (the user: "when the Plus is
  already yours, why do we need a restore purchase there?"). Owned: the same left-aligned header ("Plus is yours / Yours forever"; the user: "to make consistent … make it left alignment"),
  **What you have with Plus** (the same list), "Nothing to sign in to: Plus comes with your Google account, on every
  phone, tablet and computer signed in to it", a **Plus Family** card with the sum (Plus Family $59.99 · You paid for
  Plus −$24.99 · **You pay $35.00**) and **Upgrade for $35.00**, then Contact us. The iPhone's matching changes are
  Current Work 103.
- **Onboarding** (12 Oct, from the user's wireframes `835:503` and the built iPhone app; the user handed it over:
  "we do need some changes in the onboarding since we have removed some things"). Two sections above Today, in the
  order a person meets them. **New:** the Welcome (**our light app icon**, the user: "in the first screen use our app
  logo"; Often Enough; "Habits grow through repetition. You choose how often is enough."; "Have you used Often Enough
  before?" with two rows, I'm new here / I've used it before; Privacy & optional usage sharing was removed on 13 Oct, see Design Rules' Onboarding); **"What's included"
  (the free plan) is gone** (the user: "let's remove that screen"); the three pages with a page indicator, Skip setup
  and Continue, each showing Today's real rows, one card with Today's corners (round top on the header, round bottom on the last
  row only) (an amount, a check, a timer, steps; Smoking's run, Coffee's limit,
  Social media's time limit; three tasks and Unlimited tasks); Your days and weeks (Day and Week's own two rows: 12:00
  AM and Sunday, never Midnight or Automatic, Current Work 99; each opens the same exposed-dropdown menu as Day and
  Week, the chosen value ticked); Your first habit (eight ideas, Create my own habit
  pinned). **Coming back:** Welcome back with **Sign in with Google** (your habits come back from Google Drive; Android's
  account chooser, Google's permission screen, then Getting your habits with an Expressive loading indicator and a
  count) and **Restore a backup** (Google Drive or a backup file, then the restore flow); Start without restoring.
  **Move from another device is gone** (A12: a transfer is built last). Not drawn yet: "We found data on this device"
  (when Android's own Auto Backup has already brought the database back).
  The iPhone's matching changes: Current Work 105.
- **Today, empty** (12 Oct). **No habits yet** (after Skip setup, Start without restoring, or deleting the last
  habit): only ≡ and + in the top bar (Edit and Filter have nothing to act on), no day bar; an Expressive cookie shape
  with the checklist symbol, "No habits yet", "Add something you'd like to do often enough, or start from an idea.",
  then **New habit** (filled), **Start from an idea** (tonal), and Restore from a backup and How it works as text
  buttons: the iPhone's four ways out, never a dead end. **Nothing planned today** (habits exist, none on this day):
  the normal top bar and day bar (an empty ring, no count), "Nothing planned today", "Your habits are planned for other
  days. Each one shows on its own days.", and New habit (tonal); neutral, never "missed" or "no habits due" (U3).
- **Widgets** (12 Oct; the user: "fixed sizes, similar to iPhone, but widgets should look good"). The kinds the iPhone
  has built, with A13's free and Plus: **One habit** (2×2, free), **Today** (4×2 for the day or one section, 4×4 with
  ‹ 1/2 › pages above five; Plus), **Tasks** (4×2, 4×4; free), **This week** (4×2, one habit; Plus). **Fixed sizes, no
  resizing in the first version** (`resizeMode="none"`, min = max): 2×2 156 × 176, 4×2 328 × 176, 4×4 328 × 368 on a
  360-wide phone, inside Google's Pixel ranges (2×2: 109–306 × 115–276; 4×2: 245–624 × 115–276; the 4×4 follows the
  cell formula, 118 × 4 − 16 = 456 at most; [Widget sizing](https://developer.android.com/design/ui/mobile/guides/widgets/sizing),
  [Layouts](https://developer.android.com/develop/ui/views/appwidgets/layouts)). **Corners: 28 dp**, the most
  `system_app_widget_background_radius` ever is, and **12 dp inside** (28 − the 16 dp padding, Google's rule:
  [Glance](https://developer.android.com/develop/ui/compose/glance/create-app-widget)). **Touch targets 48 dp** (Google's
  widget layouts guide), the visible button 36–44 dp inside it. White surface, our ink and the habits' colours (no
  wallpaper colours, A11 D5); the habit icons are the Android app's filled circles, not the iPhone's bare symbols (kept, the user, 12 Oct: "keep the filled circle icons"; widgets can't animate, so no shape morphing there). The
  same contents as the iPhone: a row is icon, name, "Section · 3 of 8 glasses", 🔥 streak and the round button
  (✓, +1, ▶, ↗ for steps), filling toward its goal (U25), done in the habit's colour (U2); the header names the list
  and "2 of 5 done". This week: the habit card, today's value, a bar, and the week's seven squares from Sunday (Current
  Work 99). **No lock-screen widgets in the first version** (on Android they are new and only on some devices; check what Pixel and Samsung phones allow before designing any; the iPhone's three stay iPhone-only for now).
  Taps follow the locked rules (U26/U28): the whole card changes at once, the app saves behind.
- **Adding and changing a widget** (12 Oct; the user: "native to Android, how in Android it allows to change the
  habit, to select a specific section"). Android's own steps: touch and hold the home screen → **Widgets** → search
  "often" → Often Enough's six widgets with previews, size and one line each ("With Plus" on Today and This week) → tap
  one → **Add**. Then **our setup screen** (Android's widget configuration activity), the same shape for every widget:
  ✕ and the widget's name, a live preview on a wallpaper-coloured card, **Show** with one choice (radio rows), and a
  full-width **Add widget**. One habit and This week: choose a habit (icon, name, "Anytime · 8 glasses a day"). Today:
  **All of today, or one section** (Morning, Afternoon, Evening, Anytime, Quit or cut down, each with its start and
  how many), **text only, no icons**: times of day have no icons and people can't give them one (the user, 12 Oct). Tasks: all of today's tasks, or one section. **Changing it later** is Android's own Reconfigure: touch and
  hold the widget, the pencil, and the same screen with **Save** (`android:widgetFeatures="reconfigurable"`; the
  setup is also optional, `configuration_optional`, so a widget never sits empty: a new One habit shows "Choose a
  habit · Tap to choose", which opens the same screen). **Adding a Plus widget without Plus** never blocks: the screen
  says what Plus adds and what the widget does without it ("shows how many are done and opens Today"), with **Get
  Plus · $24.99** and **Add without Plus**; on the home screen it shows the day's count, "Tick habits off here with
  Plus" and Open Today (Current Work 93: never blank, never a paywall on a tap). The launcher's own screens (the
  menu, the picker, Add, the pencil) differ between Pixel and Samsung: check both on the phones (A11 D12).
- **Every widget state** (12 Oct, from the built iPhone widgets): One habit in 30 states (a check, done, several a day,
  an amount and past it, typed each time, a saved step, a timer ready and running, a checklist and done, quit's run,
  after a slip and a new best, a limit under, reached and over (a neutral grey, never red, U3/U25), a time limit, a
  week and a month goal, skipped, paused, not planned today (its days instead), a long name; and Choose a habit, Habit
  removed, No habits yet, Content hidden, Open to update, Couldn't save). Today and Tasks: one section with a timer
  running, quit and limits, all done, names hidden (Hide names outside the app), nothing planned (for today, or in a
  section), section unavailable, no habits, hidden, open to update, without Plus, the 4×4's page 2 of 2, no tasks
  today, "2 tasks left" with names hidden. This week: done today, quit, cut down, a week goal (its off days dashed),
  choose a habit, hidden, open to update, without Plus.
- **The New choices** (redone 13 Oct in Material 3 Expressive, then calmed the same day after the user's review):
  New, Build or maintain, and Quit or cut down. **One heading only**: the top bar keeps ✕ or ← and no title, so the
  28 sp question is the page's title (a title in the bar above it competed). One card per choice: the icon in **the
  same cookie shape every time** (56 dp, tonal grey; the user: mixed shapes, especially the small four-point one,
  looked uneven), the name at **16 sp Regular** (never heavier than the heading), one line, a short example chip that
  always fits ("e.g. Smoking", "e.g. Coffee, 2 a day"), and ›; the same padding (16) and gaps (4) on every card.
- **The habit form's pages** (13 Oct, from the built iPhone app). Each row of New Habit opens its own page, in
  Android's way: a top app bar with ← and the row's name, and the goal so far in a small chip ("8 glasses every
  day", "Every Mon, Wed and Fri"), so the page always says what it changes; going back keeps the choice (no Save).
  **How much / Limit** (redone 13 Oct in Material 3 Expressive, the user: "use material design expressive"): one
  white card with the period ("Every day", "At most, every day"), a big number (57 sp) in a tonal box between round
  − and + buttons, and the unit as a chip with ▾ that opens Unit. **Unit**: Create your own unit, No unit, then the iPhone's groups (Drinking, Walking and
  running, Reading and writing, Exercise, Everyday, Money; a limit adds Cutting down first), radio rows. **How long**: the same card, hours : minutes in two big boxes (the one being typed outlined) and quick picks as
  filter chips (5, 10, 15, 20, 30, 45 min, 1 h). **Steps**: one row per step with a drag handle and ✕, Add step, "Up to 24
  letters a step". **How often**: radio rows grouped as on the iPhone (In total; A number of days; Days of the week;
  Every few days, weeks or months; On a date); the chosen one opens its controls in place (Days of the week: Weekdays
  / Weekends chips and seven round day buttons from Sunday). **Time of Day**: "Pick one or more" checkboxes (Morning,
  Afternoon, Evening with their times, no icons) or Anytime, and New time of day. **Group**: None and the groups, New
  group (a dialog with a folder icon, "Put habits together, then filter Today and Progress by group.", Name, 6/24,
  Cancel / Add). **Starts**: Material's date picker dialog titled Starts, with "A
  start date in the past lets you tick the days since then." **Ends**: a menu on the row (Never ✓, On a date…),
  opening upward when there's no room below. **Colour**: a bottom sheet of the 13 habit colours, the chosen one
  ringed. **Icon**: a full page with a search bar and the iPhone's groups (Health, Fitness, Mind, …) on white tiles,
  the chosen one filled in the habit's colour, and Done. **Add a 6th habit**: **contextual, as on the iPhone** (the user, 13 Oct: "it
  is showing the context … not just random upgrade"), **built from the approved Plus page** (redone 13 Oct after
  "looking very ugly"): ✕; the left-aligned "Add a 6th habit" and "You're using all 5 free habits. Plus makes room for
  as many as you like."; one white card with the person's five habits in their colours and the sixth as a filled ink
  + at the end, "5 of 5 free habits used · Plus: no limit" and a full bar; then the Plus page's own plan rows and its
  What you get with Plus list; pinned: Get Plus · $24.99, a tonal **Make room instead** (archive or delete one) and
  its one-line explanation. Not drawn yet: Make room's list, a task's Repeat, a quit habit's Started picker.
- **Help & Feedback and About** (12 Oct, the iPhone's words): Help has a Material search bar at the top (the iPhone has
  it at the bottom), Contact us, Show the welcome again, the iPhone's footer, then the topics grouped as on the iPhone,
  each an **expanding row** (▾ opens the answer in place). Answers name today's controls and say "log" (the iPhone's
  still name retired ones: Current Work 102). **About**: the logo (the transparent light tonal mark, `1166:17`, 96 px, straight on the white card: the Logo Guide's "simple matching surface", so no tile and no outline; the user, 12 Oct: "use our app logo"), name and version in one card, The name, Privacy
  (with Google Drive), Acknowledgements and Android's standard **Open source licences** ›.
- **Headings are Medium, the top-bar title stays Regular** (the user, 12 Oct: "if it is the default thing, let's keep
  it … if it is a design choice then … at least make it medium"). Checked in Compose Material 3's `TypeScaleTokens.kt`:
  Headline/Title Large are `WeightRegular` by default, and Material 3 Expressive adds **Emphasized** versions at
  `WeightMedium` (`HeadlineSmallEmphasized`, `TitleLargeEmphasized`). **Day details' status** ("12 of 20 min", 28) uses
  the emphasized style, **Roboto Medium**. **A screen's question heading** ("What do you want to do?", 24) was tried in
  Medium and **reverted to Regular** (the user: "it is creating some sort of imbalance … in the day details, it is
  okay"; to be judged again in the app on the phone). The small top app bar's title (22, Title Large) stays Regular,
  Material's default.
- **Type and icons:** Roboto (Regular, Medium); Material Symbols Rounded for outline chrome icons, Material Icons Round
  for filled ones (habit icons, the flame, ▶ ✓ + in round buttons). Ink `#1C1B1F`, secondary text `#5E5E62`, tonal
  `#ECECEF`/`#E6E6EA`, error red `#B3261E`. Chrome stays black, white and grey; colour is for habits (U2, decision A11's
  D5: no wallpaper colours).

## Routine player: the header, 14 Oct 2026 (Figma `1328:2`, "Routine player · a check" `1344:2` first)

- The user: "the way in the header, like Anytime and Habit 1 of 12 is there, it is very weird … how would Material
  or Material Expressive handle that". The header said the position twice (the subtitle "Habit 1 of 12" and twelve
  bars, filled up to the current habit; they never showed done or skipped) and stacked a subtitle under a title
  that drops down.
- Now: **one-line title "Anytime ▾", 22 Medium** (a title that drops down is Google's own pattern, Calendar's
  "October ▾"; it still opens Your routine), and under the bar **one Material 3 Expressive linear progress
  indicator** (track 4, a 4 gap, a stop dot) with **"1 of 12"** (12 Medium, grey) at its end: Material has no
  stepper, and its linear indicator still works with 25 habits, where 25 bars don't. Google Sans Flex throughout; the
  habit's name 32 Medium. **Applied to the whole section** (the user: "update the remaining in this section"): every player frame has the one-line title and the indicator with its own "N of 12" (the last habit and the end of the routine show it full, "12 of 12"; the end's "12 of 12 covered" subtitle went the same way); every frame in Google Sans Flex and named without "Android ·". Timer · running has no routine header and only changed font.

## The form's pages: the user's points, 13 Oct 2026 (Figma, New section `1302:2`)

- [x] 2.1.1 Icon: Google Sans Flex; 12 between a group's name and its icons, 24 between groups; Done 40 high.
- [x] 2.2.1 How much (and 3.2.1 Limit, the same page in the app): **one number box the card's full width (296 × 80,
  45 Regular), wide enough for the longest amount the app takes, 9,999,999.99 ("0000000.00" measures 268), from the
  start**, the unit chip centred under it, **the number keypad open on arrival**. **No − and +** (the user: "if they
  are around the input field then only they make sense"; around a box that wide they'd need 30-size digits;
  Material 3 has no stepper and amounts run to millions, so typing is the way, as U22 says for the iPhone). A
  connected − | + under the field was tried first and rejected.
- [x] 2.3.1 How long: **Material's time input**: two 96 × 72 boxes, **two digits each** (Android's Clock timer stops
  at 99 hours; minutes to 59), "Hours" / "Minutes" under them; **the quick picks leave the card** for their own group
  ("Quick picks", Material filter chips, ✓ on the chosen one). The app's boxes take 3 digits today: change to 2.
- [x] 2.4.1 Steps, 2.1.5 Group, 2.1.5.1 New group, 2.1.6 Starts, 2.1.7 Ends, 3.2.1 Limit, 2.1.2 Colour, 1.1 Add a 6th
  habit (both): Google Sans Flex, titles 22 Medium. Starts, Ends and Colour now sit over the redesigned 2.2 form;
  Ends' menu opens from the new Ends row (above it, Material's rule, when there's no room below).
- [x] 2.2.1.1 Unit: **a Material 3 search bar ("Search units")** at the top: 28 units in 6 groups run to about three
  screens, and Android's own long pick-one lists (Settings' languages, time zones) open with one. Everything else
  kept, Create your own unit included.
- [x] 2.1.3 How often: drawn as the **Check it off** version (Daily · A number of times · Days of the week · Every
  few days, weeks or months · On a date), since 2.1 opens it; the summary chip at the top dropped (the chosen row
  says it, and the form shows the sentence); grouped radio rows (the chosen label Medium), the chosen option's
  settings open in its card: Weekdays / Weekends as suggestion chips, the seven days as 40 circles across the card.
- [x] 2.1.4 Time of Day: **radio buttons for the kind, checkboxes only for the times**: Anytime ("No set time") or
  At set times of day ("Pick one or more"); only under the second, indented, Morning / Afternoon / Evening as
  checkboxes and + New time of day. The "Or" heading is gone. (The app shows the times first, then "Or", Anytime.)
- [x] 4.1 Repeat (menu) drawn: Never ✓ / On a schedule, 200 wide, 4 under the Repeat row, right edges together.
- [x] Every screen in the section in Google Sans Flex (the status bars' 9:41 stays as on every screen).
- [x] 2.1.3 How often, spacing (14 Oct): the chosen option and its settings are **one white piece** (the row, then
  the chips and day circles 16 in, 16 between them, 16 under), not two pieces 2 apart.
- [x] **2.1.4.1 New time of day**: first drawn as a dialog (13 Oct); **replaced 14 Oct by the full page from
  Settings → Times of Day** (`1746:71`), so a time of day is added the same way from everywhere. The app's
  `NewSectionDialog` becomes that page.
- [x] **4.2 Task, repeating** (after "On a schedule"): no Date row; "It comes back on the days you pick below. Tasks
  don't have progress or stats."; a **How often** card ("Every day"); Starts and Ends at the end; the preview reads
  "Every day". **4.2.1 Repeat**: the task's own How often: Daily (Every day), Days of the week, Every few days, weeks
  or months, On a date, **After it's done** (no "Several times a day", no "A number of times"). Arrows 4.1 → 4.2 → 4.2.1.
- [x] **Add a 6th habit is row 5** (14 Oct; the user: "it's the same level as build or maintain, quit or cut down,
  add task … a replacement for them when they reach five habits"): 5 · Add a 6th habit (`1569:104`, the whole sheet
  `1569:2` under it), reached by the dashed arrows from Build or maintain and Quit or cut down; its heading 28 Medium
  (−0.25), as the onboarding headings. **5.1 · Make room** (`1691:2`, from "Make room instead"; the iPhone's
  `MakeRoomView`): "Archive or delete one of your 5 habits to add a new one.", each habit with its icon, its name on
  one line, an outlined **Archive** and **⋮** (Delete…), and "Archived habits keep all their progress, and you can
  bring them back any time."; once there's room, the habit being added goes ahead. **5.1.1 · Delete (dialog)**
  (`1691:88`): "Delete Take vitamins?" / "Its history and notes are deleted too. Archiving keeps them and makes room
  just the same." with **Archive instead** (filled), Delete, Cancel, stacked at the end (three don't fit in a row).
  The Android app has only a "Make room instead: archive a habit" text button today, with no page behind it.
- [ ] Still not drawn: the form's Reminders page, 3.1's Started pickers, Task's Date and Time pickers.

## Settings: Backup & Sync, 14 Oct 2026 (Figma `1461:2`; the old Restore section `1472:2` folded in and removed)

The user's points: the menu row is **Backup & Sync** on every platform (Android is designed first; the iPhone follows);
arrange the section like "New: choices and habit form" and "Onboarding: coming back"; add the missing restore screens with
our own UI; simplify the dialogs ("too many options … a high chance of misclick"); the finished pages' text styles.

- **Layout:** 1 · Backup & Sync on the left with its other states under it (1.1 not backed up, 1.2 synced (Plus), 1.3 no
  internet); one row per flow to the right, elbow arrows, no crossings: **2** Use another Google Drive (Google's own sheet →
  2.1 Allow Google Drive, dashed: first time for that account only → 2.2 Switch Google Drive?), **3** Move to a new phone
  (→ 3.1 Sending your habits → 3.2 Your habits are on your new phone; 3.3 A new code, after a wrong try), **4** Restore from
  a backup (4.1 Choose a backup → 4.1.1 Restore this backup? → 4.1.2 Restoring → 4.1.3 Restored, with Undo; 4.2 Android's
  file picker → 4.2.1 Restore this file?; 4.3 Your old phone → 4.3.1 Getting your habits → 4.3.2 Restore what it sent?; all
  three join at 4.1.2), **5** Delete your Google Drive backup?, **6** Erase all your data?.
- **Text styles, as on the finished settings pages:** page title Title Large Emphasized; row title Title Medium, its line
  Body Medium; section label Label Large (muted); footers Body Small; row icons in a 40 × 40 tonal circle; dialog title
  Headline Small, body Body Medium, buttons Label Large; flow screens as coming back (Headline Medium Emphasized heading,
  Body Large lead, a card with Title 20 Emphasized, a 56 filled button and one text button).
- **The card says where the habits are:** "Your habits are in your own Google Drive. Only Often Enough can open them, and we
  never see them." with "Today 9:14 AM · sam@gmail.com". Devices only with Plus. **Move and restore** holds Move to a new
  phone and Restore from a backup (Google Drive, A file you saved, Your old phone).
- **Restore this backup?** shows what's in it and what this phone has now, then one choice, **Add what's missing**
  (selected) or **Replace this phone**, and one **Restore** button: the old screen's two big buttons (Replace, Merge) were
  easy to mis-tap. "You can undo it for 30 days."
- **Dialogs: two choices only,** Cancel and the one action, side by side, the action in red: Delete your Google Drive backup?
  ("Your habits are removed from sam@gmail.com's Google Drive. This phone keeps everything.") and Erase all your data? ("…
  Your Google Drive backup stays, so you can bring them back."). Gone: "Save a backup file first" and "Delete from Drive and
  this phone" (erasing this phone is its own row).
- Words that changed to fit without a word alone or running past the edge: "Delete Google Drive backup…", "To restore
  later, on any phone", "A file you saved", "Switch Google Drive?".
- **Second round, the same day (the user's review):**
  - **Restore replaces, stated as information** (4.1.1, 4.2.1, 4.3.2): the choice between Add what's missing and Replace is
    gone; a "How it works"-style fact says "This replaces what's on this phone · The 10 habits and 812 logs on this phone now
    are replaced with the backup. You can undo it for 30 days." (evidence: the account pages report §6).
  - **4.1 · Choose a backup shows every backup kept** (D4): device chips (this phone, the tablet), then **Every day this
    week** (7), **Every week this month** (4), **Every month, back to April** (6), and a footer saying exactly what's kept.
    The Restore row's Google Drive line is "From today back to six months ago" (not "last week", which read as only the
    last week).
  - **Bottom text buttons are full-width and 56 high, Title Medium** (M3 Expressive's medium size), 8 under the filled
    button: the small Label Large one was "very smaller" and too close. Done here and in Onboarding: coming back (21
    screens).
  - **A loading block is centred in the space left** between the status bar (or top app bar) and the Bottom area (the
    user centred 3.1 by hand): done on all ten such screens here and in coming back.
  - **"Scan QR code" and "Type instead"** (4.3 and coming back's 5); the step reads "Scan the QR code it shows".
  - 3.3's note wraps inside the card on small screens: "Someone typed a wrong code. Here’s a new one."

## Cancel on waiting screens, 14 Oct 2026 (the user)

- **Cancel goes back to the screen before** (the user: "if we click on cancel we should be able to go back to the previous
  thing"), and is centred in its Bottom area like every other bottom button.
- **Which waiting screens have Cancel:** those waiting on something outside the phone (Looking in Google Drive, Looking
  for your habits, Getting your habits from the old phone, Sending your habits). **None** on those writing habits into the
  phone (Restoring, Bringing them back): stopping halfway could leave half a restore, it takes seconds, and Undo is offered
  after.

## Settings: Privacy & Security, App lock, 14 Oct 2026 (Figma `1474:2`)

The user: "update the font and overall font hierarchy. Use our text styles … arrange the screen properly like how we made
it for setting backup and sync … so that we know the flow."

- **Layout:** 1 · Privacy & Security, with 1.1 (signed in with a Plus account) under it; then App lock as a flow: 2 App lock ·
  off → 2.1 How do you want to unlock? → 2.2 Confirm it's you (Android's own prompt) or 2.3 Create an app passcode → 2.3.1
  Enter it again → 2.4 App lock · on; then, dashed, **later, opening the app**: 3 with your phone's lock (Android's prompt),
  3.1 with the app passcode.
- **Text styles as the finished pages** (title Title Large Emphasized, rows Title Medium + Body Medium, labels Label
  Large, footers Body Small, row icons in 40 × 40 tonal circles); the setup question is Headline Medium Emphasized; the
  passcode headings Headline Small Emphasized; the keys Headline Medium; Android's own prompt keeps its own look.
- **Where your data is** comes first (the account pages decision): *Your habits · On your phones and in your own Google
  Drive. We never see them.* and *Your account · None. An account is only for Plus.* (with Plus: *sam@gmail.com. Only for
  Plus: your purchase and your family, never your habits.* ›, to Plus › Your account). The footer was "No ads. No
  account. …", wrong for Plus people; now *No ads, and nothing is ever sold.*
- Words changed to fit: App lock's line *Your fingerprint, face or a passcode*; *Share crash reports*; the passcode choice
  *Six digits, just for this app. Good if others know your phone's PIN.*

## App lock: the missing screens, 14 Oct 2026 (Figma `1474:2`), and the account page (Figma `1476:2`)

The user: "some things are missing … the 24-hour delay … during that delay, they should be able to cancel it … when
changing the passcode, they should enter … whatever the phone screen confirmation" and "from your account … where that
leads to, we don't have anything right now".

- **Second round, same day (the user: "confirm it's you … whatever we have, it should ask for that"; research: the App
  Lock reports, WhatsApp's lock asking for the fingerprint to turn it off).** Every change to App lock asks **"Confirm it's
  you"** by the way in use, never a separate "are you sure" dialog:
  - **Turn off:** with the phone's lock, **2.6** Android's own prompt (fingerprint, face, PIN or pattern: Android
    chooses); with an app passcode, **2.7** the keypad ("Confirm it's you · Your app passcode turns App lock off.").
  - **Change app passcode** (only with an app passcode; its row: *Enter your current one first*): **4** the keypad,
    "Enter your current app passcode." → 4.1 Choose a new app passcode → 4.2 Enter it again → 4.3 "App passcode changed".
  - **Every keypad that asks for the app passcode has Forgot app passcode?**, except the one cancelling a running reset.
- **The lock screen:** 3.2 Wrong app passcode ("That's not your app passcode.", the dots cleared; after five in a row the
  waits).
- **Forgot app passcode: the 24-hour reset, started at once and cancellable** (the user: "once they start reset … it
  should just start a reset"; the report: with an app passcode, "the wait alone"). **5** *Forgot app passcode? · After 24
  hours you can choose a new app passcode. Until then, your app passcode cancels the reset.* (Cancel · Start reset) → **5.1
  Reset in progress**, the lock screen until it ends: a **countdown** (23:59:41), *Ready tomorrow at 10:14 AM. If it
  wasn't you, cancel it.*, and **Cancel reset** → **5.2** Confirm it's you (the app passcode; no Forgot here) → **5.2.1**
  the app opens, "The reset was cancelled." **5.1.1 · the notification** it sends at once (*App passcode reset asked for ·
  Ready tomorrow at 10:14 AM. If it wasn't you, open the app and cancel it.*), so the owner notices: the reset can't stop
  someone who has the phone for a day unseen, it makes sure the owner sees it first; and without it a forgotten passcode
  would lock people out of their own habits. After 24 hours, **5.3** *The 24 hours are up* (Choose a new app passcode · I
  remember it) → 5.4 → 5.5, and the app opens. No "Confirm it's you" anywhere in the reset.
- **This differs from the Android code today** (`PrivacyLock.kt`, `AppLock.kt`): there, Forgot on a phone with a screen
  lock sets a new passcode at once through Android's prompt, and the 24-hour wait runs only on a phone with no screen
  lock; changing the passcode and turning off follow the way in use already. To build: Forgot always starts the wait at
  once, the countdown screen with Cancel reset, the notification.
- **3 · Plus · with an account** (from ≡ › Plus, and Privacy & Security › Your account): Plus is yours (Plus Family ·
  yours forever); **Your account** (Signed in with Google · sam@gmail.com; What your account holds · *Your Plus, your
  family, and where your habits are backed up. Never your habits.*); **Your habits** (In your own Google Drive ›, to Backup
  & Sync); **Your family** (You · Owner, Lee · Joined 12 Oct, Invite sent · Ends 21 Oct ›, Add a person · 3 places free ›;
  *Each person has their own habits. Nobody sees anyone else's.*); **Sign out** (*Plus stays on this phone through Google
  Play*) and **Delete my account…** (red). 3.1 Invite someone (a sheet: the code, the link, Share invite, Copy code), 3.2
  Sign out?, 3.3 Delete your account?. The rest of the Plus section (buying, no account) is still the 12 Oct design.

## Settings: Plus & Account, 14 Oct 2026 (Figma `1476:2`; the 12 Oct Plus frames replaced)

The user: rename Plus ("people think plus is the tab where … upgrade selling is there"); important things first; free
has no account, and why; a small reminding nudge; where people restore their purchase; say what the account holds
positively; our app icon; the Get Plus and Restore flows. The structure is in [The Menu](<The Menu — Every Page, Its Name and What It Holds.md>), "Plus & Account".

*The first round is below as it was; its account copy, 2.2 and the single long page were replaced the same day ("Plus & Account, second round").*

- **Menu row and page title: Plus & Account** (drawer `1326:3`, `1326:231`).
- **The page, down the left, in four states:** **1 Free** (our app icon · *3 of 5 free habits used*; **Where your habits
  are** · In your own Google Drive ›, *We never see your habits.*; **Your account** · *No account on Free · You don't need
  one. An account comes with Plus: it keeps your purchase and syncs your habits between your devices.*; a calm **Plus**
  card with a tonal **See Plus**, never the filled bottom spot; **Already have Plus?** · Sign in, Restore from Google Play,
  Join a family), **1.1 Plus, no account yet** (*Plus works only on this phone …* · Create an account; Upgrade to Plus
  Family), **1.2 Plus with an account** (Signed in with Google; *What your account holds · Your Plus purchase and your
  family, so you can sign in on any device. We never see your habits: they're stored in your own Google Drive.*; Your
  family; Sign out; Delete my account…), **1.3 Plus from a family** (Leave Lee's family).
- **The flows, one row each, from the rows that start them:** **2 Get Plus** (its own page: plans, what you get, Get Plus ·
  $24.99, *I already have Plus*) → 2.1 Google Play's own purchase sheet → 2.2 *Plus is yours. Keep it on all your
  devices?* (Continue with Google · Continue with Apple · Not now; *Without an account, Plus works only on this device.
  You can create one later.*) → 2.3 Google's account sheet → 1.2; 2.1.1 Payment pending; 2.1.2 Payment not completed.
  **3 Sign in** → Google's sheet → Looking for your Plus → Plus is back (→ 1.2), or 3.4 No account found (Another Google
  account, Continue with Apple, Get Plus). **4 Restore from Google Play** → Plus is back (→ 1.1), or 4.2 No Plus found
  (Sign in instead). **5 Join a family** (the code, Gboard) → Sign in to join → Join Lee's family? (→ 1.3). **6 Create an
  account** (from 1.1). **7 Invite someone, 7.1 Sign out?, 7.2 Delete your account?**
- Research behind the order: [Plus Scope and Account at Purchase](<../../Research/Research Reports/Business Model and Monetization/Plus Scope and Account at Purchase.md>) §7 (buy first, then one optional
  step; Plus Family needs the account), [Where the Plus Button Goes](<../../Research/Research Reports/Business Model and Monetization/Where the Plus Button Goes — Accidental Taps and Pushy Placement.md>) (a calm card, never
  the bottom filled spot: 48 accidental-tap reviews, 1.60★), and the account pages report (lost purchases are the top
  complaint).

### Plus & Account, second round, 14 Oct 2026 (the user's review of `1866:154`)

*Its copy, 2.2 and the Apple decision stand; its sub-pages were undone in the third round below.*

The user: "You don't need one. An account comes with Plus" could offend and was wrong. The account doesn't sync the
habits ("syncs your habits between your devices … they might think … it might read it"): **habits sync through the
person's own Google Drive; the account is for signing in and keeping the purchase**, so Plus and the way back to the
habits reach every device. And privacy can't be the reason Free has no account, or Plus people would think they have
less of it. Every line now says what the person gets, never what they're refused.

- **Copy, by state.** **1 Free:** *Your account* · **No sign-in needed** · *Free works without an account. Your habits
  back up to your own Google Drive.* The Plus card: *Unlimited habits, and the same habits on all your devices, synced
  through your own Google Drive. One payment, yours forever.* · See Plus. **1.1 Plus, no account yet:** **No account yet**
  · *An account keeps Plus on all your devices. Your habits sync through your own Google Drive.* · Create an account.
  **1.2 Plus with an account:** **What your account holds** · *Your Plus purchase and your family, so you can sign in on
  your other devices. Your habits aren't in it: they sync through your own Google Drive, and we never see them.*
- **Sub-pages, not tabs.** The long page is split into two pages opened from rows: **1.4 Already have Plus?** (`1872:830`;
  Sign in, Restore from Google Play, Join a family; footer *Plus bought on this Google account also comes back by itself
  when you open the app.*), opened from the Free page's one row *Already have Plus? · Sign in, restore it from Google Play,
  or join a family*; and **1.5 Your family** (`1872:998`; each person, Invite someone), opened from 1.2's row *Your family ·
  You, Lee and an invite · 3 places free*. Why not tabs: Material tabs switch between views of the same kind of content,
  and a Family tab would be empty for everyone on Free and on Plus for one; a row that opens a page is how Android's own
  Settings nests a group (reasoned from first principles). Tabs remain an option if the user prefers them.
- **2.2 Plus is yours (`1871:2`), redesigned:** the cookie-shaped icon (workspace_premium) centred, **Plus is yours.**
  and *Thank you. Keep it on all your devices with an account.*, then one card of three points with icons: **Plus on all
  your devices** · *Sign in on your other devices*; **Your habits sync through your Google Drive** · *They stay in your
  own Drive. We never see them.*; **Your purchase stays safe** · *Even if you lose this phone.* At the bottom: *Without an
  account, Plus works only on this device. You can create one later.*, **Continue with Google** (filled), **Not now**.
- **Continue with Apple removed from 2.2 and 6 Create an account (`1871:49`; now *Keep Plus everywhere.* / *An account
  takes Plus to every device.*).** Reasoned from first principles: someone who has just paid through Google Play on an
  Android phone is already signed in to Google there, and every extra button on the step after paying is one more thing
  to choose. The research doesn't settle it either way: [Plus Scope and Account at Purchase](<../../Research/Research Reports/Business Model and Monetization/Plus Scope and Account at Purchase.md>)
  §7 shows Apple and Google side by side, but it was written for the iPhone, where Apple's rules apply; it has no reviews
  about which providers to offer after paying on Android. (The iPhone keeps Sign in with Apple when it offers Google.)
  **Apple stays on the sign-in screens** (3 Sign in, 3.4 No account found, 5.1 Sign in to
  join), where someone coming from an iPhone may have made their account with Apple.
- Re-laid out with the sub-pages: 23 arrows, no overlaps; every line checked for a word alone on its last line and for
  text past its card.

### Plus & Account, third round, 14 Oct 2026 (the user's review of `1872:2`)

The user: keep the options up front ("what we earlier had is better than this one"), and "the mental model for everyone
should almost stay same … consistent and predictable"; Create an account belongs inside the Your account card as its
primary action; and two views were missing: Google Drive not connected, and the person who manages a family. **The
second round's sub-pages (Already have Plus?, Your family) are gone;** everything is on the page.

**One structure in every state, top to bottom** (only what's inside each part changes):

| Place | 1 Free | 1.1 Free, Drive not connected | 1.2 Plus, no account | 1.3 Plus with an account | 1.4 Plus Family, you manage it | 1.5 Plus from a family |
|---|---|---|---|---|---|---|
| Plan card | Free · *3 of 5 free habits used* | the same | Plus is yours · *Yours forever, on this phone* | Plus is yours · *Yours forever, every device* | Plus is yours · *Plus Family · yours forever* | Plus is yours · *From Lee's family* |
| Where your habits are | In your own Google Drive ›; *We never see your habits.* | **Only on this phone** · *Not backed up yet* · **Back up to Google Drive** (filled, inside the card; opens Backup & Sync's own flow) | as 1 | as 1 | as 1 | as 1 |
| Your account | **No sign-in needed** · *Free works without an account. Your habits back up to your own Google Drive.* | *Free works without an account.* | **No account yet** · *An account keeps Plus …* · **Create an account** (filled, inside the card) | Signed in with Google · What your account holds · **Sign out** | the same, holding *your Plus purchase and your family* | the same, holding *your place in Lee's family* |
| Your family | Join a family › | Join a family › | Upgrade to Plus Family › | Upgrade to Plus Family › | **You · Owner; Lee ›; Invite sent ›; Add a person ›**; *Plus Family · up to 6 people …* | Lee · Owner; You; **Leave Lee's family** |
| Then | **Already have Plus?** (Upgrade to Plus is in the plan card since the fourth round); Sign in ›, Restore from Google Play › | the same | — | Delete my account… | Delete my account… | Delete my account… |

- **An action lives inside the card it belongs to:** Back up to Google Drive in Where your habits are (the same filled
  button and words as Backup & Sync's not-backed-up state), Create an account and Sign out in Your account, Join, Upgrade,
  Add a person and Leave in Your family. Only Delete my account… stands alone, last.
- **New screens:** 1.1 (Drive not connected), 1.4 (the manager), **7.3 Remove Lee?** (from Lee › on 1.4: *Lee keeps their
  habits. Plus stops on their devices, and their place opens for someone else.* Cancel · Remove) and **7.4 Leave Lee's
  family?** (*Your habits stay on this phone and in your Google Drive. Plus stops until you get it again.* Cancel ·
  Leave). Invite sent › opens the same Invite sheet (7) as Add a person.
- **Renumbered:** the old 1.1 Plus no account is 1.2, 1.2 with an account is 1.3 (now Plus for one; Plus Family is 1.4),
  1.3 from a family is 1.5. The flows that end on a state name the new numbers (2.2 Not now → 1.2; 2.3, 3.3 → 1.3; 4.1 →
  1.2; 5.2 → 1.5). Overlays 4.2, 7, 7.1 and 7.2 are rebuilt over the new pages.
- **Layout:** the six states down the left; to their right, rows in the page's order (Get Plus, Join a family, Sign in,
  Restore, then Create an account, Sign out, Delete, Remove, Invite, Leave), so every arrow from a state runs to a row
  lower than the one before and no two cross (checked: no crossings, no overlaps, no arrow through a frame). Every line
  checked for a word alone on its last line.

### Plus & Account, fourth round, 14 Oct 2026 (the user, on `1872:2`): Upgrade to Plus inside the Free card

The user: move the Plus card into the Free card, "because upgrade to plus is … the action that we are aiming for in the
first hand", and free the space the separate card took; "make sure it looks clean, neat". This replaces the first
round's calm card with a tonal **See Plus** at the bottom of the page.

- **The Free card** (states **1**, **1.1** and the page behind dialog **4.2**): our app icon · **Free** · *3 of 5 free
  habits used*; a 1 px divider; *Unlimited habits, and the same habits on all your devices, synced through your own
  Google Drive. One payment, yours forever.* (the approved line, unchanged); **Upgrade to Plus** (the same filled,
  in-card button as Create an account and Back up to Google Drive, with `workspace_premium`). It opens **2 · Get Plus**.
- **The separate Plus card is gone;** after Your family, Free shows only **Already have Plus?** (Sign in, Restore from
  Google Play). Each Free page is 67 px shorter.
- **Layout:** the states are restacked with the usual 160 px gaps. The Get Plus row now comes first on the right and
  Join a family second, so the rows still follow the page's order. The arrows were redrawn: none cross, none pass
  through a frame and no frames overlap.

### Plus & Account, fifth round, 14 Oct 2026 (the user, on `1872:16`, `1877:203`, `1877:222`)

- **The Free card has the habits bar from Get Plus** (`1544:32`): *3 of 5 free habits used* · *2 left* over the same
  linear progress bar, under the app icon and **Free** (the old subtitle went into the bar). States 1, 1.1, 4.2.
- **Where your habits are + Your account → one section, Backup & account** ("both are related to the account itself.
  Account and backup … merge it in a clear way"): one grouped list (24 px outer corners, 4 px between, 2 px gaps, as
  elsewhere): the habits' place first (In your own Google Drive ›, or Only on this phone), then the account rows; the
  footer *We never see your habits.* closes it. In every state, 1–1.5, and the page copies behind 4.2, 7, 7.1–7.4.
- **Back up to Google Drive and Create an account are tonal, not filled** (the user: "it should be a secondary
  button"). Android's own guidance: a filled button is "for primary actions"; tonal and outlined are for actions that
  are "important but not primary" ([Compose buttons](https://developer.android.com/develop/ui/compose/components/button)).
  On Free, the primary action is Upgrade to Plus, so one filled button per page. Backup & Sync's own not-backed-up page
  keeps its filled Back up to Google Drive: there it is the page's main action.
- **No "Free works without an account."** (the user: people take a sentence like this as a promise forever, "they
  don't even think about how technically it works"): **No sign-in needed** stands alone.
- **What your account holds** no longer repeats the footer: *… they sync through your own Google Drive.*
- **Tapping In your own Google Drive ›** opens **Backup & Sync** (Settings), the same page as the menu row.
- **Layout:** states restacked with 160 px gaps; arrows redrawn from their rows (no crossings, no overlaps, none
  through a frame).

### Plus & Account, sixth round, 14 Oct 2026 (the user, on `1877:222`, `1877:458`, `1872:410`): the account goes into the plan card

The user: say *why* there's no sign-in on Free; "In your own Google Drive" makes no sense without a heading, it should
say backup, Google Drive and the email; "Plus is yours. That is enough" (no *Yours forever, every device*); move What
your account holds and Sign out into the Plus card; keep it consistent, clean and small.

**Why this layout** ([The Account and Backup Pages](<../../Research/Research Reports/Data, Sync and Accounts/The Account and Backup Pages — Your Google Drive, and an Account Only for Plus.md>)):
the account lives inside Plus (§1.1), and Plus and the habits are always shown as two separate things, because 51
reviewers got one back without the other (§2.3). So every state has the same two cards: **the plan card holds the plan
and its account; Backup holds only where the habits are.** Free's "no sign-in" sits in the same place as Plus's account,
so the structure doesn't change between states.

| | Free | Plus, no account | Plus with an account (1.3, 1.4, 1.5) |
|---|---|---|---|
| Plan card title · subtitle | Free · *No sign-in needed* | Plus is yours · *No account yet* | Plus is yours · *Signed in as sam@gmail.com* |
| Its line | *An account holds only a Plus purchase, so there's nothing to sign in to on Free.* | *An account keeps Plus on all your devices. It holds only your purchase: your habits stay in your own Google Drive.* | *Your account holds only your Plus purchase* (1.4: *and your family*; 1.5: *your place in Lee's family*)*, so you can sign in on your other devices. Your habits sync through your own Google Drive.* |
| Its button | (the habits bar, then Upgrade to Plus, filled) | Create an account (tonal) | Sign out (tonal) |
| Backup | **Backed up to Google Drive** · email › (Backup & Sync), or **Not backed up** · *Only on this phone for now* · Back up to Google Drive (tonal); *We never see your habits.* | the same | the same |

- **Sign out appears only where there's an account** (1.3–1.5); 7.1 opens from 1.3. Its old line "Lee keeps Plus." was
  left over from when 1.3 included the family owner; now *Plus stays on this phone through Google Play. Your habits stay
  here and in your Google Drive.* **7.2** likewise: *Your account is deleted. Your purchase stays with Google Play. Your
  habits stay on this phone and in your Google Drive.*
- 1.5's Backup row shows priya@gmail.com (it showed sam's). Overlay pages 7–7.4 rebuilt; states restacked; arrows
  redrawn from Create an account and Sign out in the cards (no crossings, overlaps or arrows through frames); no word
  alone on a last line.

### Plus & Account, seventh round, 14 Oct 2026 (the user, on `1872:16`, `1889:8`, `1877:71`, `1868:508`, `1868:620`, `1868:656`, `1868:2`, `1868:42`, `1868:194`)

- **The Free card, rearranged** ("very heavy"; the 3 of 5 bar "out of nowhere"): app icon · **Free** · *No sign-in
  needed*; *An account only keeps a Plus purchase and signs you in on your other devices. Free has nothing to keep, so
  you don't need one.*; then one grey **Plus box** (`#f0f0f3`, 20 px corners) that holds the habits bar, *Plus gives you
  unlimited habits, the same on all your devices. One payment, yours forever.* and the filled button. The bar now sits
  with the offer it explains.
- **The button says Get unlimited habits** (icon `all_inclusive`), not Upgrade to Plus. No controlled test of upgrade
  wording was found; paywall vendors and practitioner guides recommend a specific, benefit-led label over a bare
  "Upgrade" ([Funnelfox](https://blog.funnelfox.com/effective-paywall-screen-designs-mobile-apps/),
  [Apphud](https://apphud.com/blog/design-high-converting-subscription-app-paywalls)), and our own research has the
  habit cap as the moment people decide (Free Plan Design: *"You're tracking 5 habits. Plus unlocks unlimited habits …"*).
  It sits under the bar, so the two read as one thought. **Get Plus** stays the buy button on Get Plus (2), so this
  button never sounds like it charges.
- **Long emails are cut in the middle, keeping the domain** (*Signed in as alexa…@gmail.com*; the Backup row
  *alexandra.mont…@gmail.com*), shown on 1.4 and its overlays 7 and 7.3; the rule is in The Menu.
- **5 · Join a family** is the Move to a new phone code screen: *Join a family.* · *The 6 digits from your invite.*, six
  boxes, the number keypad, *It checks itself when all 6 are in.* No letters, no Continue button. The invite sheet (7)
  shows the same kind of code (*482 019*) and its link; the link opens the app straight at 5.1 or 5.2. **To decide for
  the Worker:** a 6-digit invite code lives 7 days, so it needs a limit on wrong tries per device, as the move code has.
- **5.1 Sign in to join, 5.2 Join Lee's family?, 3 Sign in and 3.3 Plus is back** now look like 2.2 Plus is yours: the
  cookie icon (`group_add`, `group`, `login`, `workspace_premium`), a centred title and line, and a white card of points
  with icons. 3.3 has no back arrow (Done), and says *Plus*, not Plus Family (it leads to 1.3). 3.1's background is the
  new 3.
- **Continue with Apple stays on 5.1 and 3, but no longer as the loudest button.** The invite works the same whatever
  phone Lee has: the person joining signs in with *their own* account. Apple is there for one case: someone whose
  account was made on an iPhone with Apple (the research's reason for keeping it on the sign-in screens). The footnote
  says so: *Made your account on an iPhone? Sign in the same way you did there.* Both buttons are now white and the
  same size, Google first (Apple's guidelines allow the white style and ask for equal size).

### Plus & Account, eighth round, 14 Oct 2026 (the user; the logo boards `1160:2`, `1166:2`; invite sheet `1873:2`)

- **Our logo wherever Plus is the subject** (the user: "wherever we use the plus word, we should use our app logo, but
  in an enhanced way"). Heroes of **2.2 Plus is yours**, **2.3** (its background), **6 Create an account**, **3.3 and
  4.1 Plus is back**: the approved **light app icon** (white tile, the transparent tonal mark `1166:17` at its 52:60
  inset, 80 px, 30% corners as the guide's rounded-square preview) on a **soft cookie halo** (`#e3e3e8`, 112 px), with
  a light shadow on the tile only. Within the [Logo Guide](<../../Brand/Logo Guide.md>): tones, order, tilt and inset
  untouched; no outline, gradient or heavy shadow on the mark. Small Plus slots use the transparent mark itself: 24 px
  in points (*Plus comes back*, *Plus on all your devices*), 40 px in 3.4's Get Plus choice.
- **4.1 Plus is back** now matches 3.3: *Bought with this Google account.*; Plus on your Android devices · *With this
  Google account.*; Want it on an iPhone or iPad too? · *Create one in Plus & Account.*; Done.
- **The Free card's Plus box, in order of importance:** *Plus gives you unlimited habits, sync across all your devices
  and more widgets. One payment, yours forever.* Order from [Free Plan Design](<../../Research/Research Reports/Business Model and Monetization/Free Plan Design — Habit Cap, Widgets and an Honest Listing.md>):
  the habit cap is the main reason people buy; devices and sync next; widget designs and sizes are Plus (18 reviewers
  bought Plus *for* widgets). **Button: See what's in Plus →** (it opens Get Plus, which lists everything).
- **Invites: a single-use link, never a typed code.** A 6-digit code living 7 days can be guessed; the move code gets
  away with it only because both phones are online together and one wrong try ends it. Production family plans use
  links: Google's family groups give each invitation a unique sign-up link that works once and expires after 2 weeks,
  and a waiting invitation holds a place ([Google](https://support.google.com/families/answer/6317858?hl=en)); Spotify's
  manager copies an invite link and the invitee signs in with their own account
  ([Spotify](https://support.spotify.com/sz/article/invite-remove-family-member/)). So:
  - **7 Invite someone:** *They join with their own account. Their habits stay their own.*; the invite's **QR code**
    (*With them? They scan it with their camera.*); **Share invite link** (Android's share sheet); *Works once, for
    7 days. Cancel it in Your family.* The link is needed: most family members aren't in the room.
  - **7.5 Invite sent** (from Invite sent ›): *Ends 21 Oct. Nobody has used it yet.*, the same QR, **Share again**,
    **Cancel invite** → **7.6 Cancel this invite?** (*The link and the QR code stop working, and the place is free
    again.* Keep it · Cancel invite).
  - **5 Join a family** (from the menu): *Got a link? Tap it on this phone. It opens here.* / *With them? Scan the code
    on their phone.* · **Scan QR code** (Google's code scanner, as Move to a new phone). The link opens the app straight
    at 5.1 or 5.2. The row on the page: *Have an invite? Open it or scan it*.
  - The server: an unguessable token per invite, single use, 7 days, cancellable; the manager sees who joined and can
    remove them (7.3).
- **Layout:** 7.5 between 7.3 and 7, 7.6 to its right; the section grew 880 px and the sections under it moved down
  by the same. Arrows redrawn: no crossings, overlaps or arrows through frames.
- **Not changed, for the user:** 2.2 still says *Without an account, Plus works only on this device*; the account
  research (§1.6) found that wrong on Android (Play restores Plus on the same Google account) and proposed *Without an
  account, Plus stays with your Google Play account, on Android only. You can create one later.*

### Plus & Account, ninth round, 14 Oct 2026 (the user, on `1871:2`, `1896:15`, `1544:3`)

- **The logo has no cookie halo anywhere:** our light app-icon tile with its soft shadow only (2.2, 2.3, 6, 3.3, 4.1;
  48 px in Get Plus). Other cookie heroes (Sign in, Join a family, 5.1, 5.2) keep the cookie with a Material icon, as
  the Android cookie rule says; only the logo lost it.
- **2.2's line is corrected** (also in 2.3): *Without an account, Plus stays with your Google Play account, on Android
  only. You can create one later.* The old *Plus works only on this device* was wrong on Android: Google Play brings
  Plus back on any Android device signed in to the same Google account (Architecture 02 §3.4; account report §1.6).
  What an account adds is the iPhone and iPad, Plus Family, and finding the habits again.
- **2.2 keeps Google only** (the user asked whether Continue with Apple should come back): the person has just paid
  through Google Play, so they're using a Google account at that moment; Apple sign-in stays on Sign in (3) and Sign
  in to join (5.1) for someone whose account was made on an iPhone.
- **2 · Get Plus leads with what you get** (the user: "we should lead with the feature list"; "intentionally long";
  Plus or Plus Family is "the same level decision"). RevenueCat's paywall guide puts value first (spell out what the
  purchase gives, highlight key features), and feature checklists outnumber benefit carousels about 2:1 in a paywall
  corpus ([RevenueCat](https://www.revenuecat.com/docs/playbooks/guides/hard-paywall),
  [Lazyweb](https://labs.lazyweb.com/research/category/paywall-anatomy-and-plan-structure-benchmarks.md)); no source
  tests feature-first against plan-first, so this is reasoned, not measured. The page:
  - our logo (48) · **Plus** · *One payment, yours forever.*;
  - one white card, seven features with icons and one line each: Unlimited habits · *Free has 5. Plus has no limit.*;
    Sync across all your devices · *Through your own Google Drive.*; More widgets · *Today's list and This week.*;
    Your tablet too; Wear OS watch; iPhone and iPad too · *The same habits, with an account.*; Windows app;
  - fixed at the bottom: **Plus** and **Plus Family** as two equal tiles side by side (name, radio, price, *Just you* /
    *You + 5 people*), then **Get Plus · $24.99** and **I already have Plus**. The 3-of-5 bar left this page (the Free
    card and the 6th-habit sheet show it). On a 360 × 800 phone all seven features show without scrolling.

### Plus & Account, tenth round, 15 Oct 2026 (the user, on `1544:3`, `1867:2`): Get Plus, less to read

The user: "very cluttered"; *Unlimited habits* and *More widgets* explain themselves; only *Sync across all your devices
· through Google Drive* needs its line; fewer icons; "as compact as possible … so that focus goes on the decision"; still
feel like a lot: every device (Wear OS, Apple Watch, iPhone, iPad, tablet, Windows, Mac).

- **One white card:** three checked lines (one `check` icon each, no circles): **Unlimited habits**, **Sync across all
  your devices** · *Through your own Google Drive.*, **More widgets**; a divider; **Works on** and eight small outlined
  labels: Android phone, Tablet, Wear OS watch, iPhone, iPad, Apple Watch, Windows, Mac. People scan rather than read,
  read the first words of a line, and skip lists that are long or repetitive (NN/g's findings, as summarised by
  [UX Planet](https://uxplanet.org/how-people-read-on-the-web-influences-content-design-41a812ea236c) and
  [Yoast](https://yoast.com/the-psychology-of-scannable-content-and-bullet-points/)): short checked lines lead with the
  word that matters, and the devices read as one glance that still feels like a lot.
- The card ends 46 px above the plans on a 360 × 800 phone.
- **2.1, 2.1.1 and 2.1.2 now show the new page behind them.** 2.1.1 keeps its own parts on it: *Waiting for your
  payment · Plus turns on as soon as Google Play confirms it. You can close this.* and the greyed **Waiting for payment**
  button (they were lost for a moment when the page was swapped, and restored from the first build).

### Plus & Account, eleventh round, 15 Oct 2026 (the user, on `1544:98`, `1901:161`, `1867:351`)

- **Get Plus's bottom area:** no top line, no white behind the plans (the user removed it on 2; now the same on 2.1,
  2.1.1's old copy and 2.1.2); the two plan tiles 12 apart, 20 between the tiles and **Get Plus**, 8 to *I already have
  Plus*.
- **Works on, in pairs:** two columns, others on the left and Apple on the right, so each row is one kind of device:
  Android phone · iPhone, Tablet · iPad, Wear OS watch · Apple Watch, Windows · Mac. Labels 28 high, 6 apart; the card
  ends 17 px above the plans.
- **2.1.1 Payment pending is its own screen**, not a card on Get Plus: the same centred block as *Looking for your
  Plus* (the Material 3 Expressive loading indicator, *Waiting for your payment*, *Plus turns on as soon as Google Play
  confirms it.*, 280 wide), centred between the status bar and the bottom area, and a **Close** text button. Plus turns
  on by itself when Google Play confirms.

### Plus & Account, twelfth round, 15 Oct 2026: the missing screens, designed and linked

The user: "create those screens. And also connect those arrows properly. So that I can see how it links." All 22 screens
that were placeholders are designed, from the section's own patterns (wording in The Menu, "The flows added on 15 Oct"):
2.4–2.7 Plus Family from Get Plus; 8–8.3 Upgrade to Plus Family; 7.7–7.10 Sign out and Delete for the manager and a
member (over 1.4 and 1.5); 7.2.1 Confirm it's you and 7.2.2 Account deleted; 5.3–5.8 invites that don't work and the two
joining cases (the hero centred between the top bar and the buttons; 5.7 uses our logo); 3.5 and 4.3 Couldn't connect
(the Looking for your Plus block with a `wifi_off` icon).

- **Layout (rearranged the same day; the user: "they're just vertically … arrange them properly"):** one row per state
  for what it opens, so the section reads across, not down (3640 × 10640, was 3120 × 17680; the sections below moved up
  7040). Rows: Get Plus (2 → 2.3, with 2.1.1 / 2.1.2 and the Plus Family purchase 2.4 → 2.7 under it); Join a family
  (5 → 5.2); Sign in (3 → 3.3, 3.4, 3.5); Restore (4 → 4.1, 4.2, 4.3); **1.2:** Create an account (6) and Upgrade to Plus
  Family (8 → 8.3); **1.3:** Sign out? (7.1) and Delete (7.2 → 7.2.1 → 7.2.2); **1.4, the manager:** Sign out? (7.7),
  Remove Lee? (7.3), Invite sent (7.5 → 7.6), Invite someone (7), Delete (7.9); **1.5, a member:** Sign out? (7.8),
  Leave (7.4), Delete (7.10). The invite problems (5.3–5.8) stack in the last column, fed from opening the invite.
  The first screen in a row takes its arrow from the left; the others take theirs from the gap under their row, in the
  same left-to-right order as the rows that open them, so they don't cross.
- **Arrows:** 48. **One crossing is unavoidable**: on 1.3, Sign out (in the plan card) sits above Upgrade to Plus
  Family, while on 1.2 Upgrade sits below Create an account, so the two arrows into 8 can't both keep order; 1.3's
  Upgrade arrow crosses its Sign out arrow once. No overlaps, no arrow through a frame. 7.9 and 7.10 continue to 7.2.1
  (said in their names; an arrow there would cross the Invite sent row).
- No word alone on a last line.

### Plus & Account, thirteenth round, 15 Oct 2026 (the user, on `1902:3`): Get Plus with room, and the choice first

The user: "too compact … doesn't have breathing space"; on a short phone it will scroll; "maybe we can split the decision
itself, like choosing only Plus or family beforehand … do research and come up with the best possible design".

- **The choice comes first**, right under the title: a two-part single-select **Just you | Family**, each showing its
  price ($24.99, $59.99), with ✓ on the chosen one. Android's own guidance: a segmented button is "to let users choose
  from a set of options, side-by-side" ([Compose](https://developer.android.com/develop/ui/compose/components/segmented-button));
  paywall guidance on tiers that differ by who they're for suggests choosing the tier first, and keeping every option's
  price visible rather than hiding one behind a switch ([Adapty](https://adapty.io/docs/paywall-with-tabs.md),
  [Adapty on toggle paywalls](https://adapty.io/blog/your-toggle-paywall-is-about-to-get-rejected/)). One line under it
  says who it's for: *Just for you, on all your devices.* / *For you + 5 people, each with their own habits.*
- **More room:** 20 between parts, the card padded 20 with 16 between lines, device labels 32 high and 8 apart. On a
  360 × 800 phone the last row of devices scrolls under the fixed bottom (a soft shadow marks it); shorter phones scroll
  more. **The bottom holds only Get Plus · $24.99 (Get Plus Family · $59.99 on 2.4) and I already have Plus.**
- 2.4 is the same page with Family chosen; 2.1, 2.1.2 and 2.5 show the new page behind them; the upgrade page (8, 8.1)
  has the same card spacing. In 2.4 and 8 the bottom area had slipped under the page; it is on top again.

### Plus & Account, fourteenth round, 15 Oct 2026 (the user, on `1902:3`, `1918:2`, pointing at Progress's `1376:18`)

- **The choice is a connected button group, like Progress's Week · Month · Year** (Material 3 Expressive): two
  buttons 2 apart, rounded on the outside, 8 on the inside; **the chosen one is a white pill** (1 px `#d4d4d9` edge,
  a soft shadow, ✓) and the other is grey `#e2e2e7`. Not black: the buy button under it already is (the user).
- **Works on labels have room:** 40 high (10 above and below, 14 at the sides), 12 corners, 10 apart. The list scrolls
  further under the fixed bottom on a 360 × 800 phone, which is expected.
- Applied to 2, 2.4, the pages behind 2.1, 2.1.2 and 2.5, and the labels on 8 and 8.1.

### Plus & Account, fifteenth round, 15 Oct 2026 (the user, on `1918:2`): the choice as radio rows

The user rejected the connected buttons ("not even looking like something you can select and tap"; no border, no
shadow; only Get Plus should draw the eye) and asked what native Material would do. **Android's answer for picking one of
a set is the radio button** ("lets a user select an option from a set of options … when only one item can be selected"),
in 56 dp rows where the whole row is the target (`Modifier.selectable`, `Role.RadioButton`, `selectableGroup()`)
([Compose radio button](https://developer.android.com/develop/ui/compose/components/radio-button)). So the choice is one
plain **white card** (24 corners, no border or shadow) with two rows: ◉ **Just you** · *On all your devices* · **$24.99**,
○ **Family** · *You + 5 people* · **$59.99**, a hairline between them. The selected radio is the only dark mark, and it's
small. The line under the old buttons is gone (each row says who it's for). On 2, 2.4 and the pages behind 2.1, 2.1.2, 2.5.
This replaces the fourteenth round's connected buttons.

### Plus & Account, sixteenth round, 15 Oct 2026: the manager hears when someone joins

The user: "small notification to the manager when someone joins their family" (no email: we have no email service).
**5.2.1 · On Lee's phone**, after Join family on 5.2: a notification, in the same style as App lock's (5.1.1):
`group_add` · *Often Enough · now* · **Priya joined your family** · *Priya has Plus now. 3 places left in your family.*
Tapping it opens Plus & Account, where Priya is in Your family. Spotify does the same for its family plan's manager
([Spotify](https://support.spotify.com/sz/article/invite-remove-family-member/)).

- **How it reaches Lee's phone (to build):** the Worker sends it through Firebase Cloud Messaging when an invite is
  accepted; the app shows it on a **Family** notification channel. If notifications are off, nothing is lost: Your
  family shows Priya the next time Lee opens the page. The message carries no habits, only the joiner's first name.
- The arrows to the invite problems (5.3–5.8) now leave from 5.2's bottom edge, so 5.2 → 5.2.1 runs straight.

### Help & Feedback, 15 Oct 2026 (the user, on `1476:110`)

*Replaced the same day by "Help & Feedback: email only" below; the eight answers are kept here in case a FAQ is written later.*

The user: keep only what's absolutely necessary, "instead of shipping something that is half finished, not shipping at
all would be good"; fix the fonts and hierarchy; the name may change; research it.

- **What people come for** (W6): an answer, or a way to reach us. Our research has missing help and instructions in
  482 reviews at 2.69★ (Settings — What People Need There) and the questions people can't answer: undo, filling in a
  day, skip and pause, deleting, where the data is, moving phones (Onboarding report §5). So help stays, short and
  complete, rather than going.
- **Name: Help & Feedback, unchanged:** the name Google's own apps give this row, and the same on the iPhone.
- **The page** (`1 · Help & Feedback`, and `1.1` with a question open): our text styles throughout (title Title Large
  Emphasized, section labels Label Large, rows Title Medium, answers Body Medium, the footer Body Small), Plus &
  Account's grouped rows (24 outer corners, 4 inside, 2 apart). **Contact us** · Email us ›; **Using the app** (5);
  **Your habits and Plus** (3). A question opens in place (`expand_more` / `expand_less`); one open at a time.
- **Removed:** the search field, Show the welcome again, and every topic beyond these eight. The old frames (Roboto, no
  text styles) are deleted.
- **The answers, final** (each checked at its real width, no word alone on a line):
  1. **Undo a wrong tap:** Right after you log, Undo shows under the habit's name: tap it. A ✓ can also be tapped again
     to take it back. For an earlier log, tap the habit to open Day details, tap the log, then Delete.
  2. **Fill in a day I forgot:** Go back a day with ‹ in the bar at the bottom of Today, then log as usual. For an
     older day, open the habit and use Go to date in History.
  3. **Skip a day, or pause a habit:** To skip one day, tap the habit to open Day details, then Skip today. For a
     stretch of days, open the habit and choose ⋮ › Pause…. Skipped and paused days never break a streak.
  4. **Archive or delete a habit:** Open the habit and choose ⋮ › Archive or Delete. Archive keeps its history and
     frees its place on the free plan. Delete removes the habit and its history for good, and asks first.
  5. **A reminder didn't come:** Some phones put apps to sleep to save battery. In ≡ › Reminders, Show me how gives your
     phone's own steps to keep reminders coming. If notifications are off, Reminders says so and can turn them on.
  6. **Where my habits are kept:** On this phone, and in your own Google Drive: they back up as you go, and we never
     see them. ≡ › Backup & Sync shows when the last backup was.
  7. **Move to a new phone:** On your old phone, open ≡ › Backup & Sync › Move to a new phone. On the new one, install
     Often Enough, say you've used it before, then scan the code or type its 6 digits. Both phones need the internet.
  8. **Get Plus back:** Plus bought with this Google account comes back by itself. Otherwise, in ≡ › Plus & Account,
     Sign in, or tap Restore from Google Play.
- **Before release:** support@oftenenough.com must exist and be answered (Build Plan #72). An answer that names a
  button changes with that button.

### Help & Feedback: email only, 15 Oct 2026 (the user, after the questions were designed)

The user asked whether to keep the questions at all. Every answer already lives where the problem happens (Undo under the
habit, Skip in Day details, Pause in the habit's ⋮, the ‹ day bar, Keep reminders coming, Backup & Sync, Move to a new
phone, Already have Plus?); a FAQ repeats them where people have to look, and goes stale each time a button changes.
In-app support chat was researched and set aside for launch (the user: "just launch with email"): our own on the
Cloudflare Worker would cost nothing to run (Workers' free plan, Firebase Cloud Messaging free, Email Routing free) but
needs building and someone answering quickly; hosted services cost money as we grow (Crisp from $45 a month after its
free plan; Intercom $29–132 a seat a month) and hold people's messages.

- **1 · Help & Feedback:** **Write to us** · **Report a problem** (`bug_report`, *Something isn't working*) and
  **Suggest an idea** (`lightbulb`, *A feature you'd like to see*), Plus & Account's grouped rows; the footer *Both open
  your email app, to support@oftenenough.com. We read every message. Your app and Android versions are added for you;
  your habits never are.*
- **1.1 · the email app's new message** (its own screen, shown for what we fill in): To support@oftenenough.com,
  Subject *Often Enough: a problem* (*… an idea* from Suggest), the cursor at the top, and our last line *Often Enough
  1.0 (free) · Android 16 · Pixel 9*. Built with `ACTION_SENDTO` and a `mailto:` address, so only email apps answer.
- **1.2 · No email app** (dialog over the page, from either row): *Write to us at support@oftenenough.com from any email
  you use.* · Close · Copy address (Android shows its own "Copied" notice).
- Arrows from both rows to 1.1, and from either row to 1.2. Before release, the mailbox must exist and be answered
  (Build Plan #72). The iPhone's Help is cut to the same two rows when it's updated to match.

### About, 15 Oct 2026 (the user, on `1476:264`)

The user: "remove all of the unnecessary things … keep only things that are necessary, compulsory … make it look good".

- **What's compulsory:** a privacy policy inside the app (Google Play's User Data policy: "a privacy policy link or text
  within the app itself", [Google Play](https://support.google.com/googleplay/android-developer/answer/10144311)) and the
  open-source notices ("As a developer, you are responsible for displaying open source library notices used in your
  app", [Google](https://developers.google.com/android/guides/opensource)). The version stays: people need it when they
  write to us.
- **1 · About:** our app icon (the white tile with its soft shadow, 80), **Often Enough** (Headline Medium Emphasized),
  *Version 1.0 (1)*, centred with room above; then one grouped list (Help & Feedback's rows): **Privacy policy** ·
  *Opens in your browser* with `open_in_new`, and **Open-source licences** · *The libraries we use* ›.
- **1.1 · Open-source licences:** Google's own screen (`play-services-oss-licenses`, `OssLicensesMenuActivity`, title
  set to "Open-source licences"), listing the app's libraries (AndroidX Activity … kotlinx.serialization, from the app's
  build file); each opens its licence. The plugin builds the list itself.
- **Removed:** the name's paragraph, the privacy paragraph (Privacy & Security and the policy say it), the
  library-by-library rows and the old Roboto frame. Before release the privacy policy page must be published at a
  stable address.

### Onboarding: new to the app, and the notifications permission, 15 Oct 2026

- **07 · Your first habit, the ideas:** the user: the most generic habits, written as people say them ("drink eight
  glasses of water"), all every day for now. From the 4,407 habit statements in our reviews (How People Describe a Habit),
  counted by activity: water 823, exercise 744, reading 333, walking 307, medication or vitamins 295, flossing or brushing
  291, sleep 193, meditating 188; the amounts people name most: 8 glasses (65), 30 minutes of exercise (32) and of reading
  (35), 10,000 steps (17), 10 minutes of meditating (15). So: **Drink 8 glasses of water · Exercise for 30 minutes · Read
  for 30 minutes · Walk 10,000 steps · Take vitamins · Floss · Go to bed on time · Meditate for 10 minutes**, each *Every
  day*, icons in Material Symbols (the quit and cut-down ideas left the list). Today's *Start from an idea* has the same eight.
- **07.1 · Drink water, filled in:** an idea opens straight into its own form (Drink water → Track an amount), everything
  filled in: name, icon, 8 glasses, every day, each tap adds 1 glass; **Add** enabled. Back returns to 07.
- **07.2 · Today, with the first habit:** Anytime · 1 left · Drink water 0/8 glasses with its +; the day bar 0/1. The end
  of onboarding.
- **Layout:** 01 → 07.2 in one row with arrows; 06.1 and 06.2 (the two menus open) under 06. Cross-section links are in
  the frame names: 02's *I've used it before* → Onboarding: coming back; 07's *Create my own habit* → New: 1; *Skip setup*
  → the empty Today.
- **The notifications permission (Rulebook U36):** never at install or in onboarding. In the habit form's Reminders:
  **2.1.6** off as every habit starts → turning on *Remind me* → **2.1.6.1** Android's own *Allow Often Enough to send you
  notifications?* → Allow: **2.1.6.2** (on, times) → **2.1.6.3** the exact-times sheet only if Android holds them back;
  Don't allow: **2.1.6.4** *Remind me* back off, *Notifications are off for Often Enough, so reminders can't come…* with
  **Open settings** (Android stops asking after two refusals).

### Reminder times, the Android way, 15 Oct 2026 (the user, on `1456:118`)

The user: is adding several reminders intuitive and native? It wasn't: a leading ⊖ is the iPhone's edit-mode delete,
"Reminder 1 / 2" said nothing the time didn't, and › promised a new page where a time picker opens. Android's own pattern
is Google Calendar's event notifications: a list of rows, a trailing ✕ to remove one, an add row last, the whole row
opening the picker in place.

- **2.1.6.2 · Remind me at:** each time is a row with a leading `schedule` icon, the time (Title Medium) and a trailing
  ✕ icon button (48, *Remove this time*); tapping the row opens the time picker at that time. Last: **+ Add a time**,
  its words lined up with the times. The footer still says them back (*You get a notification at 8:00 AM and 2:00 PM …*).
- **2.1.6.2.1 · Add a time:** Android's Material 3 time picker (the dial, as in 3.1.2), starting at the current time;
  OK adds it, Cancel adds nothing.

### Google Drive on a new phone: what's remembered, and what's chosen (15 Oct 2026)

The user's question while checking Onboarding: coming back. From Android's AuthorizationClient guide
([developer.android.com/identity/authorization](https://developer.android.com/identity/authorization)) and Google's
OAuth overview ([developers.google.com/identity/protocols/oauth2](https://developers.google.com/identity/protocols/oauth2)):

- **The permission is given once, per Google account, and is remembered everywhere** (the user is right). Our server
  records a Drive only after the person chose it and allowed access, so a recorded Drive means access was allowed. On
  any later phone, tablet or the web, asking again "obtain[s] an access token … without any user interaction", unless the
  person removed the access in their Google Account (then the Allow screen comes back once).
- **What the phone still has to know is *which* Google account to ask for.** Authorization runs for the phone's
  *default* account: "a subsequent authorization request uses the account as the default and skips the account
  selection step", and the default is the account the person signed in to the app with. So:
  - **Signed in with Google, backed up to that same account** (most people): straight through, no screen.
  - **Signed in with one Google account, backed up to another** (allowed, D16), **or signed in with Apple** (Apple can't
    open a Google Drive): the app shows Google's own account chooser once, *Your habits are backed up to a different
    Google account. Choose it to bring them back.* No Allow screen (already given); the account must be on the phone or
    added from the chooser. We can't preselect it: the request takes no account hint, and we keep no email (D16).
  - After choosing, the app checks the chosen account's ID against the one on record before reading anything.
- **Could the app ask for that exact account without the chooser?** Yes, technically: Google's `AuthorizationRequest.Builder`
  has `setAccount(Account)`, "Specifies an account on the device that should be used." Two conditions: the app must know
  the account's **email address** (Android names accounts by email; the private ID on record isn't enough), and the
  account must **already be on the phone** (otherwise the person adds it from Google's chooser anyway). D16 keeps no
  email, so today the chooser stays: one tap, only in this case. Keeping the backup account's email privately would
  remove that tap; it's the open proposal in D16, for the user to decide.
- **Why our server doesn't open the Drive itself:** it could, only by keeping a long-lived refresh token for the
  person's Google account, and then our server could read their habits. D16 rules that out, so only the person's own
  devices ever hold access to their Drive.

### Onboarding: coming back, the missing screens, 15 Oct 2026 (the user, on `1549:2`)

Built after the user's questions (see "Google Drive on a new phone"). Each from the section's own screens:

- **2.5 · Plus is back.** *Your Plus is on the account you signed in with. Your habits are in a different Google Drive
  account: choose the one that holds them.* · **Choose the Drive account** (the user: say clearly which account holds Plus
  and which holds the habits, both being Google accounts; the other account is never named) · **Choose the account** · Start fresh instead → **2.5.1**,
  Google's own chooser over it, then Looking in Google Drive and 2.2. Only when the person signed in with one Google
  account and backs up to another; signed in with the backup account, it goes straight through.
- **3.2 reworked · Plus is back.** *Your habits are in Google Drive. Choose the Google account that holds them.* · **Choose the Drive account** (an Apple
  sign-in can't open a Google Drive, so this step is always there on the Apple path; the old "We found your habits" card
  went, since nothing can be counted before the Drive is opened) → **3.2.1**, Google's chooser, then 4.2 and 4.3.
- **2.6 · Plus is back** (the *No habits found* layout): *We didn't find your habits in sam@gmail.com's Google Drive.
  Bring them another way:* Your old phone (the move code) · A backup file; Try another Google Drive; Start fresh. Rare (the
  Drive copy deleted, or the first backup never finished); also after an Apple sign-in.
- **4.2.1 · Couldn't connect** (`1949:277`, under 4.2), the one screen for every looking step (2.1, 3.1, 4.2): Try again · Cancel.
- **5.3.1 · The move stopped.** *Nothing changed on either phone. Keep the app open on both, then try again.* (`sync_problem`)
  · Try again (to 5) · Cancel.
- **6.1.2 · From a newer version.** *This backup is from a newer Often Enough. Update the app to bring it back; nothing has
  changed yet.* · **Update Often Enough** (Google Play). The whole file is refused, never half brought in (D2, D5).
- **8 · Start fresh:** every Start fresh goes to **Your days and weeks** (as New to the app's 06, without Skip setup), so
  the day's start and the week's first day are right from the start, then **8.1, the empty Today** (Today's first-time
  empty state).
- Arrows for each, with no crossings and none through a frame; the section grew 880 and the sections below moved down.

## How we work on these (the user's standing preferences)

- **Centred screens: the content sits centred between the top and the buttons, and centred text wraps within 280 px** (40 from each edge), never a title set to grow with its text; after narrowing, reword any word left alone (the user, 15 Oct 2026: content should never reach "so extended that it touches the borders"). Fixed across Plus & Account, Today's empty state and App lock's reset screens.
- **Before swapping the page behind a sheet or dialog for a newer copy, list what that frame adds on the page itself** (a card, a disabled button) and put it back: 2.1.1's waiting card went with the old page once (15 Oct 2026).
- Design **one** screen, show it, get approval, then the variants (one example first).
- Every screen goes into its own named section on the page; nothing loose on the canvas, no explanatory labels on it.
- Settle layout questions from the native platform's own patterns (Google's apps, Material docs, the Compose
  component's defaults) and say which; check Google's documentation when a size or pattern is questioned ("is it a
  standard pattern or something we are creating?").
- Before using the Figma tools: load the `figma-use` skill, then `create_session` with the file key.

## What's left, in order

1. ~~**Notes:** Add note, Note (view, Delete note | Edit), Edit note, and their variants.~~ Done 12 Oct.
2. ~~**Day details for every other kind**~~ done 12 Oct (the Day details section, and slips in Logs and slips). Not
   drawn: Tick steps (the checklist's Add screen for a past day) and the amount-per-week / per-month kinds (Push-ups
   "+20" with "0 of 300 this week", Savings "Log amount"); they use the same parts.
3. ~~**New (+):** the choices, then the habit form.~~ Built 12 Oct. ~~The pages each row opens and the sixth-habit
   sheet~~ built 13 Oct. Not drawn yet: Make room's list, a task's Repeat, a quit habit's Started picker; with test
   data over five habits, the iPhone's Quit or cut down opened a blank sheet (check).
4. ~~**The ≡ menu** as Material's navigation drawer.~~ Built 12 Oct.
5. ~~**The routine player and the timer.**~~ Built 12 Oct. Still to draw: the running timer as Android 16's Live
   Update notification (A11 D4) and Today's timer bar.
6. ~~**Habit details:** Progress, History and Notes tabs.~~ Built 12 Oct; All milestones drawn 14 Oct. Not drawn: Go to
   date, a habit with no history yet, and the other kinds' Progress (time, checks, quit, checklist).
7. ~~**Progress.**~~ Built 12 Oct (Week, Month, Year; no ⋮). Not drawn: the legend expanded.
8. ~~**Settings pages:**~~ Built 12 Oct (Times of Day, Day and Week, Reminders, Appearance, Google Drive & Backup and
   the restore flow, Privacy & Security and App lock, Plus, Help & Feedback, About). Was: Times of Day, Day and Week, Reminders (with the reminder check, A11 D1–D2), Appearance, Google
   Drive & Backup (the sync line and status, A7), Privacy & Security and App Lock, Plus, Help & Feedback, About.
9. ~~**Welcome**~~ (the onboarding) built 12 Oct. ~~An empty Today~~ built 12 Oct. Still to draw: "We found data on this device".
10. ~~**Widgets**~~ built 12 Oct: every kind, every state, adding and changing. Paused: lock-screen widgets (the user, 12 Oct).
11. Then the larger phone (412 wide) for the screens that need it, and the tablet layout (A11 D9).
