# Android Designs — Every Screen

Written by Claude (Claude Code), 13 October 2026, at the user's request: "document everything from start to end … because there is no Figma in the cloud." Every Android frame in Figma, exported at 2× (`Images/`), in the order a person meets them. The reasons behind each screen are in [Android Designs — Handoff](<../Android Designs — Handoff.md>) ("Decisions made while designing"); the product decisions are in [Android — Start Here](<../README.md>) (A1–A14).

Source: Figma file `Ncccsm1l2O62GJ5xLSInqk`, page **Andriod mobile** (`1241:2`). Every frame below names its node ID, so a person with Figma can open the same frame.

## The design language (applies to every screen)

- **Material 3 Expressive, as on Android 16; completely native components** (Jetpack Compose Material 3). The ideas, words and rules are the iPhone app's; only what Android does differently changes.
- **Size:** designed at 360 × 800 dp (status bar 36, gesture navigation 24). Larger phones and tablets are not drawn yet: lay out from these (A11 D9: tablets and foldables at launch, the iPad's layout).
- **Colour (light):** screen `#F0F0F3`; surfaces white; ink `#1C1B1F`; secondary text `#5E5E62`; tonal fills `#E6E6EA`/`#ECECEF`; outline `#79747E`; error red `#B3261E` (only for destructive text, never for progress or habits, U3). **The chrome is monochrome; colour belongs to the habits** (U2): each habit's colour fills its round icon, its progress tint and its done button. **No wallpaper (dynamic) colours** (A11 D5).
- **Shape:** segmented lists (each row its own white piece, 2–4 dp apart, outer corners 24, inner 4); cards 24–28; buttons fully rounded (filled ink 56 dp for the main action, tonal grey 48 dp for the second); the Expressive "cookie" (9-point) for illustrative icon containers.
- **Type:** Roboto (the system font). Screen questions 28 Regular; titles 22 Regular; row names 16 Regular; supporting 14; labels 12–14 Medium. Never make a card's title heavier than the page's heading.
- **Icons:** Material Symbols Rounded; habit icons are filled circles in the habit's colour with a white glyph (in the app and on widgets).
- **Dark mode: required in the app** (the user, 13 Oct 2026), though every frame here is light. Derive it from Material 3's dark roles with the same structure; for colours only, use the **old** dark design below as inspiration: it is a very old screen (its layout and parts are outdated: follow the light frames for everything else).

![Dark mode reference — an old design, for colours only](<Images/00 Dark mode reference (old design, colours only).png>)


> **Superseded, 22 October 2026.** Sections 01 and 02 below are the old onboarding. There is no onboarding any more:
> the app opens on Android's own splash, then Today (Rulebook U40; [Android — Start Here](<../README.md>) A25). The
> frames that replaced them are in the new Figma file **Android-app** (`sJptV3HAKYauEIGUxYS3qs`), page **onboarding**
> (`1:5`). The menu in section 03 is superseded too: it is six rows now (`12:5259`).

## 01. Onboarding: new to the app

Figma section `1548:2`. First launch for someone new. The Welcome shows our light app icon; "What's included" (the free plan page) was removed. Three pages with a page indicator, Skip setup and Continue, then Your days and weeks (each row opens a dropdown menu: 12:00 AM … and Sunday … Saturday; never "Midnight" or "Automatic"), then Your first habit (an idea opens the New Habit form, section 07).


**Onboarding · Welcome** (`1548:3`)

![Onboarding · Welcome](<Images/01 Onboarding new to the app/01 Onboarding Welcome.png>)


**Onboarding · 1 of 3 · Your habit. Your goal** (`1548:46`)

![Onboarding · 1 of 3 · Your habit. Your goal](<Images/01 Onboarding new to the app/02 Onboarding 1 of 3 Your habit. Your goal.png>)


**Onboarding · 2 of 3 · Quit or cut down** (`1548:177`)

![Onboarding · 2 of 3 · Quit or cut down](<Images/01 Onboarding new to the app/03 Onboarding 2 of 3 Quit or cut down.png>)


**Onboarding · 3 of 3 · Tasks, once or on repeat** (`1548:296`)

![Onboarding · 3 of 3 · Tasks, once or on repeat](<Images/01 Onboarding new to the app/04 Onboarding 3 of 3 Tasks, once or on repeat.png>)


**Onboarding · Your days and weeks** (`1548:420`)

![Onboarding · Your days and weeks](<Images/01 Onboarding new to the app/05 Onboarding Your days and weeks.png>)


**Onboarding · Your days and weeks · New day starts at (menu)** (`1550:2`)

![Onboarding · Your days and weeks · New day starts at (menu)](<Images/01 Onboarding new to the app/06 Onboarding Your days and weeks New day starts at (menu).png>)


**Onboarding · Your days and weeks · Week starts on (menu)** (`1550:71`)

![Onboarding · Your days and weeks · Week starts on (menu)](<Images/01 Onboarding new to the app/07 Onboarding Your days and weeks Week starts on (menu).png>)


**Onboarding · Your first habit** (`1548:456`)

![Onboarding · Your first habit](<Images/01 Onboarding new to the app/08 Onboarding Your first habit.png>)


## 02. Onboarding: coming back

Figma section `1549:2`. Someone who used the app before. Sign in with Google brings habits back from Google Drive (Android's own account chooser and Google's own permission screen, then Getting your habits). Restore a backup leads into the restore flow (section 18). Start without restoring goes to the empty Today. Move from another device is gone. Not drawn: "We found data on this device" (Android Auto Backup already restored the database).


**Onboarding · Welcome back** (`1549:3`)

![Onboarding · Welcome back](<Images/02 Onboarding coming back/01 Onboarding Welcome back.png>)


**Onboarding · Sign in · Google account chooser (Android’s own sheet)** (`1549:38`)

![Onboarding · Sign in · Google account chooser (Android’s own sheet)](<Images/02 Onboarding coming back/02 Onboarding Sign in Google account chooser (Android's own sheet).png>)


**Onboarding · Sign in · Google’s permission screen** (`1549:97`)

![Onboarding · Sign in · Google’s permission screen](<Images/02 Onboarding coming back/03 Onboarding Sign in Google's permission screen.png>)


**Onboarding · Getting your habits** (`1549:128`)

![Onboarding · Getting your habits](<Images/02 Onboarding coming back/04 Onboarding Getting your habits.png>)


**Onboarding · Restore a backup** (`1549:154`)

![Onboarding · Restore a backup](<Images/02 Onboarding coming back/05 Onboarding Restore a backup.png>)


## 03. Today

Figma section `1260:2`. The approved Today: Material 3 Expressive segmented cards on #F0F0F3, top app bar ≡ · Edit · Filter · + (no FAB), the day bar as Material's floating toolbar (fixed width, the ring + day name + count centred as one group). The two empty states: No habits yet (first time; only ≡ and +) and Nothing planned today (neutral words, U3).


**360 × 800 · Today · light** (`1350:2`)

![360 × 800 · Today · light](<Images/03 Today/01 Today light.png>)


**Today · empty · no habits yet (first time)** (`1551:3`)

![Today · empty · no habits yet (first time)](<Images/03 Today/02 Today empty no habits yet (first time).png>)


**Today · empty · nothing planned today** (`1551:195`)

![Today · empty · nothing planned today](<Images/03 Today/03 Today empty nothing planned today.png>)


**Day bar · four days, nothing moves** (`1256:6`)

![Day bar · four days, nothing moves](<Images/03 Today/04 Day bar four days, nothing moves.png>)


## 04. Day details

Figma section `1260:3`. Day details is a modal bottom sheet (✕ start, title, ⋮ end) for every habit kind and state: an amount, a time habit (and running), a check (done/not), several a day, week/month goals, N days a week, a checklist, quit (no slips / a slip), limits, tasks, skipped, paused, an earlier day.


**360 × 800 · Day details · Water** (`1362:2`)

![360 × 800 · Day details · Water](<Images/04 Day details/01 Day details Water.png>)


**Day details · Read · time habit** (`1280:3`)

![Day details · Read · time habit](<Images/04 Day details/02 Day details Read time habit.png>)


**Day details · Read · timer running** (`1294:2`)

![Day details · Read · timer running](<Images/04 Day details/03 Day details Read timer running.png>)


**Day details · Take vitamins · not done** (`1294:220`)

![Day details · Take vitamins · not done](<Images/04 Day details/04 Day details Take vitamins not done.png>)


**Day details · Take vitamins · done** (`1294:432`)

![Day details · Take vitamins · done](<Images/04 Day details/05 Day details Take vitamins done.png>)


**Day details · Stretch breaks · several a day** (`1294:644`)

![Day details · Stretch breaks · several a day](<Images/04 Day details/06 Day details Stretch breaks several a day.png>)


**Day details · Call family · week goal** (`1294:866`)

![Day details · Call family · week goal](<Images/04 Day details/07 Day details Call family week goal.png>)


**Day details · Deep clean · month goal** (`1294:1083`)

![Day details · Deep clean · month goal](<Images/04 Day details/08 Day details Deep clean month goal.png>)


**Day details · Gym · N days a week** (`1294:1300`)

![Day details · Gym · N days a week](<Images/04 Day details/09 Day details Gym N days a week.png>)


**Day details · Tidy desk · checklist** (`1294:1512`)

![Day details · Tidy desk · checklist](<Images/04 Day details/10 Day details Tidy desk checklist.png>)


**Day details · Smoking · quit, no slips** (`1296:2`)

![Day details · Smoking · quit, no slips](<Images/04 Day details/11 Day details Smoking quit, no slips.png>)


**Day details · Smoking · quit, a slip** (`1296:214`)

![Day details · Smoking · quit, a slip](<Images/04 Day details/12 Day details Smoking quit, a slip.png>)


**Day details · Coffee · limit** (`1296:430`)

![Day details · Coffee · limit](<Images/04 Day details/13 Day details Coffee limit.png>)


**Day details · Social media · time limit** (`1296:644`)

![Day details · Social media · time limit](<Images/04 Day details/14 Day details Social media time limit.png>)


**Day details · Task · not done** (`1296:858`)

![Day details · Task · not done](<Images/04 Day details/15 Day details Task not done.png>)


**Day details · Task · done** (`1296:1080`)

![Day details · Task · done](<Images/04 Day details/16 Day details Task done.png>)


**Day details · Read · skipped** (`1296:1292`)

![Day details · Read · skipped](<Images/04 Day details/17 Day details Read skipped.png>)


**Day details · Meditate · paused** (`1296:1510`)

![Day details · Meditate · paused](<Images/04 Day details/18 Day details Meditate paused.png>)


**Day details · Water · an earlier day** (`1296:1722`)

![Day details · Water · an earlier day](<Images/04 Day details/19 Day details Water an earlier day.png>)


## 05. Logs and slips: add, all, view, delete, edit

Figma section `1261:290`. Add log, All logs, Log (view first: Delete log | Edit), its delete confirmation, Edit log; the same for slips.


**Add log · Water** (`1261:2`)

![Add log · Water](<Images/05 Logs and slips add, all, view, delete, edit/01 Add log Water.png>)


**All logs · Water** (`1261:83`)

![All logs · Water](<Images/05 Logs and slips add, all, view, delete, edit/02 All logs Water.png>)


**Log · Water** (`1261:120`)

![Log · Water](<Images/05 Logs and slips add, all, view, delete, edit/03 Log Water.png>)


**Log · Delete confirmation** (`1261:162`)

![Log · Delete confirmation](<Images/05 Logs and slips add, all, view, delete, edit/04 Log Delete confirmation.png>)


**Edit log · Water** (`1261:213`)

![Edit log · Water](<Images/05 Logs and slips add, all, view, delete, edit/05 Edit log Water.png>)


**Add slip · Smoking** (`1297:83`)

![Add slip · Smoking](<Images/05 Logs and slips add, all, view, delete, edit/06 Add slip Smoking.png>)


**Slip · Smoking** (`1297:164`)

![Slip · Smoking](<Images/05 Logs and slips add, all, view, delete, edit/07 Slip Smoking.png>)


**Slip · Delete confirmation** (`1297:209`)

![Slip · Delete confirmation](<Images/05 Logs and slips add, all, view, delete, edit/08 Slip Delete confirmation.png>)


**Edit slip · Smoking** (`1297:257`)

![Edit slip · Smoking](<Images/05 Logs and slips add, all, view, delete, edit/09 Edit slip Smoking.png>)


## 06. Notes: add, view, delete, edit

Figma section `1274:2`. Add note (empty, typed, day already has a note, discard?), Note view, delete, Edit note and its discard dialog.


**Add note · Water** (`1274:3`)

![Add note · Water](<Images/06 Notes add, view, delete, edit/01 Add note Water.png>)


**Add note · typed** (`1277:2`)

![Add note · typed](<Images/06 Notes add, view, delete, edit/02 Add note typed.png>)


**Add note · day already has a note** (`1279:2`)

![Add note · day already has a note](<Images/06 Notes add, view, delete, edit/03 Add note day already has a note.png>)


**Add note · Discard this note?** (`1277:121`)

![Add note · Discard this note?](<Images/06 Notes add, view, delete, edit/04 Add note Discard this note.png>)


**Note · Water** (`1277:235`)

![Note · Water](<Images/06 Notes add, view, delete, edit/05 Note Water.png>)


**Note · Delete confirmation** (`1277:288`)

![Note · Delete confirmation](<Images/06 Notes add, view, delete, edit/06 Note Delete confirmation.png>)


**Edit note · Water** (`1277:325`)

![Edit note · Water](<Images/06 Notes add, view, delete, edit/07 Edit note Water.png>)


**Edit note · Discard your changes?** (`1279:111`)

![Edit note · Discard your changes?](<Images/06 Notes add, view, delete, edit/08 Edit note Discard your changes.png>)


## 07. New: choices and habit form

Figma section `1302:2`. New: What do you want to do? → Build or maintain / Quit or cut down (one cookie shape for every icon, 28 sp question as the only heading, card names 16 Regular). Then the New Habit form for each kind (Check it off, Track an amount, Time it, Checklist), Quit, Cut down, Task.


**New · What do you want to do?** (`1566:2`)

![New · What do you want to do?](<Images/07 New choices and habit form/01 New What do you want to do.png>)


**New · Build or maintain** (`1566:44`)

![New · Build or maintain](<Images/07 New choices and habit form/02 New Build or maintain.png>)


**New Habit · Check it off** (`1321:2`, full length)

![New Habit · Check it off](<Images/07 New choices and habit form/03 New Habit Check it off.png>)


**New Habit · Track an amount** (`1321:125`, full length)

![New Habit · Track an amount](<Images/07 New choices and habit form/04 New Habit Track an amount.png>)


**New Habit · Time it** (`1321:272`, full length)

![New Habit · Time it](<Images/07 New choices and habit form/05 New Habit Time it.png>)


**New Habit · Checklist** (`1321:400`, full length)

![New Habit · Checklist](<Images/07 New choices and habit form/06 New Habit Checklist.png>)


**New · Quit or cut down** (`1566:106`)

![New · Quit or cut down](<Images/07 New choices and habit form/07 New Quit or cut down.png>)


**New · Quit** (`1321:529`)

![New · Quit](<Images/07 New choices and habit form/08 New Quit.png>)


**New · Cut down** (`1321:614`, full length)

![New · Cut down](<Images/07 New choices and habit form/09 New Cut down.png>)


**New · Task** (`1321:738`, full length)

![New · Task](<Images/07 New choices and habit form/10 New Task.png>)


## 08. New: the form’s pages

Figma section `1563:535`. Every page a form row opens: How much / Limit (big number between − and +, unit chip), Unit, How long (hours : minutes + quick picks), Steps, How often (choices expand in place), Time of Day (no icons), Group + New group dialog, Starts (date picker), Ends (menu), Colour (bottom sheet), Icon (search + grid), and Add a 6th habit (contextual Plus: your five habits + the sixth slot, the Plus page's plans and list, Make room instead).


**New Habit · How much** (`1567:2`)

![New Habit · How much](<Images/08 New the form's pages/01 New Habit How much.png>)


**New Habit · How much · Unit (full length)** (`1563:33`, full length)

![New Habit · How much · Unit (full length)](<Images/08 New the form's pages/02 New Habit How much Unit (full length).png>)


**New Habit · How long** (`1567:60`)

![New Habit · How long](<Images/08 New the form's pages/03 New Habit How long.png>)


**Cut down · Limit** (`1567:31`)

![Cut down · Limit](<Images/08 New the form's pages/04 Cut down Limit.png>)


**New Habit · Checklist · Steps** (`1563:286`)

![New Habit · Checklist · Steps](<Images/08 New the form's pages/05 New Habit Checklist Steps.png>)


**New Habit · How often (full length)** (`1563:328`, full length)

![New Habit · How often (full length)](<Images/08 New the form's pages/06 New Habit How often (full length).png>)


**New Habit · Time of Day** (`1563:438`)

![New Habit · Time of Day](<Images/08 New the form's pages/07 New Habit Time of Day.png>)


**New Habit · Group** (`1563:494`)

![New Habit · Group](<Images/08 New the form's pages/08 New Habit Group.png>)


**New Habit · Group · New group (dialog)** (`1567:106`)

![New Habit · Group · New group (dialog)](<Images/08 New the form's pages/09 New Habit Group New group (dialog).png>)


**New Habit · Starts (date picker)** (`1564:58`)

![New Habit · Starts (date picker)](<Images/08 New the form's pages/10 New Habit Starts (date picker).png>)


**New Habit · Ends (menu)** (`1564:322`)

![New Habit · Ends (menu)](<Images/08 New the form's pages/11 New Habit Ends (menu).png>)


**New Habit · Colour (sheet)** (`1564:454`)

![New Habit · Colour (sheet)](<Images/08 New the form's pages/12 New Habit Colour (sheet).png>)


**New Habit · Icon** (`1564:607`)

![New Habit · Icon](<Images/08 New the form's pages/13 New Habit Icon.png>)


**New · Add a 6th habit (Plus sheet) · on the phone (bottom pinned)** (`1569:104`)

![New · Add a 6th habit (Plus sheet) · on the phone (bottom pinned)](<Images/08 New the form's pages/14 New Add a 6th habit (Plus sheet) on the phone (bottom pinned).png>)


**New · Add a 6th habit (Plus sheet) · whole page** (`1569:2`, full length)

![New · Add a 6th habit (Plus sheet) · whole page](<Images/08 New the form's pages/15 New Add a 6th habit (Plus sheet) whole page.png>)


## 09. Menu: navigation drawer

Figma section `1326:2`. The ≡ menu is Material's navigation drawer (open, and scrolled to the end).


**Menu · navigation drawer open** (`1326:3`)

![Menu · navigation drawer open](<Images/09 Menu navigation drawer/01 Menu navigation drawer open.png>)


**Menu · navigation drawer scrolled to the end** (`1326:231`)

![Menu · navigation drawer scrolled to the end](<Images/09 Menu navigation drawer/02 Menu navigation drawer scrolled to the end.png>)


## 10. Routine player and timer

Figma section `1328:2`. The routine player (Expressive hero card + button group) for every kind and state, its ⋮ menu, Your routine, the end, and the timer screen.


**Routine player · a check** (`1344:2`)

![Routine player · a check](<Images/10 Routine player and timer/01 Routine player a check.png>)


**Routine player · a check, done · Saved snackbar** (`1344:57`)

![Routine player · a check, done · Saved snackbar](<Images/10 Routine player and timer/02 Routine player a check, done Saved snackbar.png>)


**Routine player · several a day** (`1344:117`)

![Routine player · several a day](<Images/10 Routine player and timer/03 Routine player several a day.png>)


**Routine player · a checklist** (`1344:173`)

![Routine player · a checklist](<Images/10 Routine player and timer/04 Routine player a checklist.png>)


**Routine player · a checklist, many steps (scrolls)** (`1347:57`)

![Routine player · a checklist, many steps (scrolls)](<Images/10 Routine player and timer/05 Routine player a checklist, many steps (scrolls).png>)


**Routine player · an amount (Expressive)** (`1333:2`)

![Routine player · an amount (Expressive)](<Images/10 Routine player and timer/06 Routine player an amount (Expressive).png>)


**Routine player · a long label (ellipsis)** (`1347:2`)

![Routine player · a long label (ellipsis)](<Images/10 Routine player and timer/07 Routine player a long label (ellipsis).png>)


**Routine player · a timer running** (`1344:241`)

![Routine player · a timer running](<Images/10 Routine player and timer/08 Routine player a timer running.png>)


**Routine player · a timer, not started** (`1344:297`)

![Routine player · a timer, not started](<Images/10 Routine player and timer/09 Routine player a timer, not started.png>)


**Routine player · an amount typed each time** (`1344:352`)

![Routine player · an amount typed each time](<Images/10 Routine player and timer/10 Routine player an amount typed each time.png>)


**Routine player · a limit** (`1344:407`)

![Routine player · a limit](<Images/10 Routine player and timer/11 Routine player a limit.png>)


**Routine player · a task** (`1344:463`)

![Routine player · a task](<Images/10 Routine player and timer/12 Routine player a task.png>)


**Routine player · skipped · Skipped snackbar** (`1344:518`)

![Routine player · skipped · Skipped snackbar](<Images/10 Routine player and timer/13 Routine player skipped Skipped snackbar.png>)


**Routine player · the last habit, done** (`1344:582`)

![Routine player · the last habit, done](<Images/10 Routine player and timer/14 Routine player the last habit, done.png>)


**Routine player · ⋮ menu** (`1345:2`)

![Routine player · ⋮ menu](<Images/10 Routine player and timer/15 Routine player menu.png>)


**Routine player · Your routine** (`1345:70`)

![Routine player · Your routine](<Images/10 Routine player and timer/16 Routine player Your routine.png>)


**Routine player · end of the routine** (`1345:183`)

![Routine player · end of the routine](<Images/10 Routine player and timer/17 Routine player end of the routine.png>)


**Timer · running** (`1345:219`)

![Timer · running](<Images/10 Routine player and timer/18 Timer running.png>)


## 11. Habit details: Progress, History, Notes

Figma section `1373:2`. Habit details: History, Notes, Progress (full length), ⋮ menu.


**Habit details · Water · History** (`1375:2`, full length)

![Habit details · Water · History](<Images/11 Habit details Progress, History, Notes/01 Habit details Water History.png>)


**Habit details · Water · Notes** (`1375:732`, full length)

![Habit details · Water · Notes](<Images/11 Habit details Progress, History, Notes/02 Habit details Water Notes.png>)


**Habit details · Water · Progress (full length)** (`1373:3`, full length)

![Habit details · Water · Progress (full length)](<Images/11 Habit details Progress, History, Notes/03 Habit details Water Progress (full length).png>)


**Habit details · ⋮ menu** (`1375:1275`)

![Habit details · ⋮ menu](<Images/11 Habit details Progress, History, Notes/04 Habit details menu.png>)


## 12. Progress: Week, Month, Year

Figma section `1376:2`. Progress: Week, Month, Year (full length; no ⋮ menu).


**Progress · Week (full length)** (`1376:3`, full length)

![Progress · Week (full length)](<Images/12 Progress Week, Month, Year/01 Progress Week (full length).png>)


**Progress · Month (full length)** (`1376:226`, full length)

![Progress · Month (full length)](<Images/12 Progress Week, Month, Year/02 Progress Month (full length).png>)


**Progress · Year (full length)** (`1376:496`, full length)

![Progress · Year (full length)](<Images/12 Progress Week, Month, Year/03 Progress Year (full length).png>)


## 13. Settings: Times of Day

Figma section `1437:2`. Times of Day list (no icons, no timeline), New time of day, Edit.


**Settings · Times of Day** (`1440:2`)

![Settings · Times of Day](<Images/13 Settings Times of Day/01 Settings Times of Day.png>)


**Settings · New time of day** (`1440:69`)

![Settings · New time of day](<Images/13 Settings Times of Day/02 Settings New time of day.png>)


**Settings · Edit time of day · Morning** (`1440:152`)

![Settings · Edit time of day · Morning](<Images/13 Settings Times of Day/03 Settings Edit time of day Morning.png>)


## 14. Settings: Day and Week

Figma section `1449:2`. Day and Week: day start (12:00 AM … as a dropdown) and week start (Sunday … Saturday).


**Settings · Day and Week** (`1449:3`)

![Settings · Day and Week](<Images/14 Settings Day and Week/01 Settings Day and Week.png>)


**Settings · Day and Week · New day starts at (menu)** (`1449:51`)

![Settings · Day and Week · New day starts at (menu)](<Images/14 Settings Day and Week/02 Settings Day and Week New day starts at (menu).png>)


## 15. Settings: Reminders

Figma section `1456:2`. Reminders settings (with the reminder check), a habit's reminders, the "Get reminders on time" sheet (exact alarms), a reminder that didn't arrive.


**Settings · Reminders** (`1456:3`, full length)

![Settings · Reminders](<Images/15 Settings Reminders/01 Settings Reminders.png>)


**Habit · Reminders · on** (`1456:91`, full length)

![Habit · Reminders · on](<Images/15 Settings Reminders/02 Habit Reminders on.png>)


**Habit · Reminders · Get reminders on time (sheet)** (`1456:164`)

![Habit · Reminders · Get reminders on time (sheet)](<Images/15 Settings Reminders/03 Habit Reminders Get reminders on time (sheet).png>)


**Settings · Reminders · a reminder that didn’t arrive** (`1456:206`)

![Settings · Reminders · a reminder that didn’t arrive](<Images/15 Settings Reminders/04 Settings Reminders a reminder that didn't arrive.png>)


## 16. Settings: Appearance

Figma section `1458:2`. Appearance and its Done habits menu.


**Settings · Appearance** (`1458:3`, full length)

![Settings · Appearance](<Images/16 Settings Appearance/01 Settings Appearance.png>)


**Settings · Appearance · Done habits (menu)** (`1458:85`)

![Settings · Appearance · Done habits (menu)](<Images/16 Settings Appearance/02 Settings Appearance Done habits (menu).png>)


## 17. Settings: Google Drive & Backup

Figma section `1461:2`. Google Drive & Backup in its states (not connected, backed up free, synced Plus, offline with changes waiting), its two dialogs, and Restore from a backup.


**Settings · Google Drive & Backup · not connected** (`1465:2`)

![Settings · Google Drive & Backup · not connected](<Images/17 Settings Google Drive & Backup/01 Settings Google Drive & Backup not connected.png>)


**Settings · Google Drive & Backup · backed up (free)** (`1465:54`, full length)

![Settings · Google Drive & Backup · backed up (free)](<Images/17 Settings Google Drive & Backup/02 Settings Google Drive & Backup backed up (free).png>)


**Settings · Google Drive & Backup · synced (Plus)** (`1465:123`, full length)

![Settings · Google Drive & Backup · synced (Plus)](<Images/17 Settings Google Drive & Backup/03 Settings Google Drive & Backup synced (Plus).png>)


**Settings · Google Drive & Backup · offline, changes waiting** (`1465:192`, full length)

![Settings · Google Drive & Backup · offline, changes waiting](<Images/17 Settings Google Drive & Backup/04 Settings Google Drive & Backup offline, changes waiting.png>)


**Settings · Google Drive & Backup · Delete your data from Google Drive? (dialog)** (`1475:2`)

![Settings · Google Drive & Backup · Delete your data from Google Drive? (dialog)](<Images/17 Settings Google Drive & Backup/05 Settings Google Drive & Backup Delete your data from Google Drive (dialog).png>)


**Settings · Google Drive & Backup · Erase everything? (dialog)** (`1473:27`)

![Settings · Google Drive & Backup · Erase everything? (dialog)](<Images/17 Settings Google Drive & Backup/06 Settings Google Drive & Backup Erase everything (dialog).png>)


**Settings · Restore from a backup** (`1465:258`)

![Settings · Restore from a backup](<Images/17 Settings Google Drive & Backup/07 Settings Restore from a backup.png>)


## 18. Restore from a backup: the flow

Figma section `1472:2`. Restore: Android's own account chooser, Google's permission screen, Choose a backup (Google Drive), Android's own file picker, preview and confirm, restored with Undo (30 days, D5).


**Restore · Google account chooser (Android’s own sheet)** (`1472:3`)

![Restore · Google account chooser (Android’s own sheet)](<Images/18 Restore from a backup the flow/01 Restore Google account chooser (Android's own sheet).png>)


**Restore · Google’s permission screen** (`1472:62`)

![Restore · Google’s permission screen](<Images/18 Restore from a backup the flow/02 Restore Google's permission screen.png>)


**Restore · Choose a backup (Google Drive)** (`1472:93`)

![Restore · Choose a backup (Google Drive)](<Images/18 Restore from a backup the flow/03 Restore Choose a backup (Google Drive).png>)


**Restore · system file picker (Android’s own)** (`1472:155`)

![Restore · system file picker (Android’s own)](<Images/18 Restore from a backup the flow/04 Restore system file picker (Android's own).png>)


**Restore · preview and confirm** (`1472:207`)

![Restore · preview and confirm](<Images/18 Restore from a backup the flow/05 Restore preview and confirm.png>)


**Restore · restored, with Undo** (`1472:247`)

![Restore · restored, with Undo](<Images/18 Restore from a backup the flow/06 Restore restored, with Undo.png>)


## 19. Settings: Privacy & Security, App Lock

Figma section `1474:2`. Privacy & Security and App lock: off → How do you want to unlock? → your phone's lock (BiometricPrompt confirms) or an app passcode (create, confirm) → on; later, opening the app with each.


**Settings · Privacy & Security** (`1474:3`)

![Settings · Privacy & Security](<Images/19 Settings Privacy & Security, App Lock/01 Settings Privacy & Security.png>)


**App lock · 1 · off** (`1478:2`)

![App lock · 1 · off](<Images/19 Settings Privacy & Security, App Lock/02 App lock 1 off.png>)


**App lock · 2 · How do you want to unlock?** (`1478:28`)

![App lock · 2 · How do you want to unlock?](<Images/19 Settings Privacy & Security, App Lock/03 App lock 2 How do you want to unlock.png>)


**App lock · 3a · Your phone's lock: Android's prompt confirms it works** (`1478:66`)

![App lock · 3a · Your phone's lock: Android's prompt confirms it works](<Images/19 Settings Privacy & Security, App Lock/04 App lock 3a Your phone's lock Android's prompt confirms it works.png>)


**App lock · 3b · Create an app passcode** (`1478:118`)

![App lock · 3b · Create an app passcode](<Images/19 Settings Privacy & Security, App Lock/05 App lock 3b Create an app passcode.png>)


**App lock · 3c · Confirm the app passcode** (`1478:175`)

![App lock · 3c · Confirm the app passcode](<Images/19 Settings Privacy & Security, App Lock/06 App lock 3c Confirm the app passcode.png>)


**App lock · 4 · on** (`1478:232`)

![App lock · 4 · on](<Images/19 Settings Privacy & Security, App Lock/07 App lock 4 on.png>)


**App lock · later · opening the app: your phone's lock** (`1478:286`)

![App lock · later · opening the app: your phone's lock](<Images/19 Settings Privacy & Security, App Lock/08 App lock later opening the app your phone's lock.png>)


**App lock · later · opening the app: app passcode** (`1478:317`)

![App lock · later · opening the app: app passcode](<Images/19 Settings Privacy & Security, App Lock/09 App lock later opening the app app passcode.png>)


## 20. Settings: Plus

Figma section `1476:2`. Plus: buy (price first, free-habits card, plans, What you get with Plus as one list, Get Plus pinned, Restore purchases only here) and Plus is yours (Plus Family upgrade for the difference). Each as the phone view (bottom pinned) and the whole page.


**Plus · buy · on the phone (bottom pinned)** (`1544:3`)

![Plus · buy · on the phone (bottom pinned)](<Images/20 Settings Plus/01 Plus buy on the phone (bottom pinned).png>)


**Plus · buy** (`1480:2`, full length)

![Plus · buy](<Images/20 Settings Plus/02 Plus buy.png>)


**Plus · Plus is yours · on the phone** (`1544:106`)

![Plus · Plus is yours · on the phone](<Images/20 Settings Plus/03 Plus Plus is yours on the phone.png>)


**Plus · Plus is yours** (`1480:77`, full length)

![Plus · Plus is yours](<Images/20 Settings Plus/04 Plus Plus is yours.png>)


## 21. Settings: Help & Feedback

Figma section `1476:110`. Help & Feedback (search at the top) and a topic open.


**Help & Feedback** (`1476:111`, full length)

![Help & Feedback](<Images/21 Settings Help & Feedback/01 Help & Feedback.png>)


**Help & Feedback · a topic open** (`1476:194`, full length)

![Help & Feedback · a topic open](<Images/21 Settings Help & Feedback/02 Help & Feedback a topic open.png>)


## 22. Settings: About

Figma section `1476:264`. About: the light tonal mark straight on the white card, name, version, the name's meaning, privacy, acknowledgements.


**About** (`1476:265`, full length)

![About](<Images/22 Settings About/01 About.png>)


## 23. Widgets

Figma section `1555:2`. Widgets on Pixel-style home screens: One habit 2×2, Today 4×2 and 4×4, This week 4×2, Tasks 4×2 and 4×4. Fixed sizes, no resizing in v1; 28 dp corners, 12 inside; 48 dp touch targets; filled-circle habit icons.


**Home screen · One habit (2×2) and Today (4×2)** (`1555:3`)

![Home screen · One habit (2×2) and Today (4×2)](<Images/23 Widgets/01 Home screen One habit (2x2) and Today (4x2).png>)


**Home screen · Today (4×4)** (`1555:92`)

![Home screen · Today (4×4)](<Images/23 Widgets/02 Home screen Today (4x4).png>)


**Home screen · This week (4×2) and Tasks (4×2)** (`1555:197`)

![Home screen · This week (4×2) and Tasks (4×2)](<Images/23 Widgets/03 Home screen This week (4x2) and Tasks (4x2).png>)


**Home screen · Tasks (4×4)** (`1555:290`)

![Home screen · Tasks (4×4)](<Images/23 Widgets/04 Home screen Tasks (4x4).png>)


## 24. Widgets: adding and changing

Figma section `1559:2`. Adding and changing a widget: Android's own touch-and-hold menu, widget picker, Add; our setup screen (choose a habit, or all of today / one section, text only); the widget placed; Android's Reconfigure; a Plus widget without Plus (never blocks).


**Add a widget · 1 · touch and hold the home screen** (`1559:3`)

![Add a widget · 1 · touch and hold the home screen](<Images/24 Widgets adding and changing/01 Add a widget 1 touch and hold the home screen.png>)


**Add a widget · 2 · Widgets, searched (Android’s own, full length)** (`1559:102`, full length)

![Add a widget · 2 · Widgets, searched (Android’s own, full length)](<Images/24 Widgets adding and changing/02 Add a widget 2 Widgets, searched (Android's own, full length).png>)


**Add a widget · 3 · a widget tapped: Add (Android’s own)** (`1559:416`)

![Add a widget · 3 · a widget tapped: Add (Android’s own)](<Images/24 Widgets adding and changing/03 Add a widget 3 a widget tapped Add (Android's own).png>)


**Add a widget · 4 · One habit: choose a habit (ours)** (`1560:2`)

![Add a widget · 4 · One habit: choose a habit (ours)](<Images/24 Widgets adding and changing/04 Add a widget 4 One habit choose a habit (ours).png>)


**Add a widget · 5 · on the home screen** (`1560:89`)

![Add a widget · 5 · on the home screen](<Images/24 Widgets adding and changing/05 Add a widget 5 on the home screen.png>)


**Change a widget · 6 · touch and hold it: Reconfigure (Android’s own)** (`1560:178`)

![Change a widget · 6 · touch and hold it: Reconfigure (Android’s own)](<Images/24 Widgets adding and changing/06 Change a widget 6 touch and hold it Reconfigure (Android's own).png>)


**Change a widget · 7 · One habit: change the habit (ours)** (`1560:270`)

![Change a widget · 7 · One habit: change the habit (ours)](<Images/24 Widgets adding and changing/07 Change a widget 7 One habit change the habit (ours).png>)


**Add a widget · Today: the day or one section (ours)** (`1560:357`)

![Add a widget · Today: the day or one section (ours)](<Images/24 Widgets adding and changing/08 Add a widget Today the day or one section (ours).png>)


**Add a widget · Tasks: all of today or one section (ours)** (`1560:459`)

![Add a widget · Tasks: all of today or one section (ours)](<Images/24 Widgets adding and changing/09 Add a widget Tasks all of today or one section (ours).png>)


**Add a widget · This week: choose a habit (ours)** (`1560:533`)

![Add a widget · This week: choose a habit (ours)](<Images/24 Widgets adding and changing/10 Add a widget This week choose a habit (ours).png>)


**Add a widget · Today without Plus (ours)** (`1560:645`)

![Add a widget · Today without Plus (ours)](<Images/24 Widgets adding and changing/11 Add a widget Today without Plus (ours).png>)


## 25. Widgets: every state

Figma section `1557:402`. Every widget state: One habit in 30 states; Today, Tasks and This week in 24 states (empty, private, open to update, couldn't save, without Plus, pages, names hidden).


**Widgets · One habit (2×2) · every state** (`1557:2`)

![Widgets · One habit (2×2) · every state](<Images/25 Widgets every state/01 Widgets One habit (2x2) every state.png>)


**Widgets · Today, Tasks and This week · every state** (`1558:550`)

![Widgets · Today, Tasks and This week · every state](<Images/25 Widgets every state/02 Widgets Today, Tasks and This week every state.png>)
