# The iPad Layout — Familiar Like the iPhone, Native to the iPad

Written by Claude (Claude Code), 11 October 2026, for [Current Work 86](<../../Checklists/Current Work Checklist.md>)
(Product Roadmap 66). Research; the decisions taken so far are in §8. The user's words are kept in
[The User's Prompts, Word for Word](<The User's Prompts, Word for Word.md>).

**What the user asked.** Today's whole point is quick scanning: how much is left for the day. The iPhone already has
time-of-day sections, closed sections that still say how many things they hold, and the ≡ side menu. On the iPad the
app should feel "kind of the same" as the iPhone, never something new, and at the same time feel native and
intuitive, using the iPad's room. Research first, then designs in Figma (page `1078:309`).

**How each claim is backed:** "users show" = reviews we read; "Apple" = Apple's own guidance, quoted from the Human
Interface Guidelines (HIG) or a technote; "reasoned" = first principles, where no review or rule settles it.

---

## 1. The short answer

| Question | Answer |
|---|---|
| **What do iPad users complain about most?** | **An iPhone app on the iPad.** 477 of the 996 layout reviews say the app is a blown-up or postage-stamp iPhone app, or has no iPad version at all. The second complaint is **portrait only**: 165 reviews, against 12 that praise landscape. People use the iPad sideways, on a stand or in a keyboard case (users show, §3.1–3.2). |
| **What is the iPad for, next to the phone?** | **Planning, reviewing and keeping the day in view; the phone is for ticking things off on the go.** People set habits up on the iPad and log on the phone; they keep the iPad open on a desk with the phone put away; they look back in the evening (users show, §3.3). |
| **What do they want the room used for?** | **Seeing more of the day at once, with the same things they know**: more habits and more of the day without scrolling, the day's sections side by side, a summary always in sight. Not a busier screen: a crowded "fill every space" layout is criticised too (users show, §3.4). |
| **What does Apple ask for?** | Use **size classes, not the device**; on regular width, **switch the menu to a sidebar**; "keep functionality the same as size classes change, and keep layout changes recognizable and familiar"; **support every orientation and any window size** (full-screen-only is deprecated in iPadOS 26); sheets as centered **form sheets**; keyboard and pointer work (Apple, §4). |
| **So what should the iPad's Today be?** | **The iPhone's Today in Apple's iPad frame** (revised after studying 14 top iPad apps, §6): the ≡ menu becomes a sidebar with a count of what's left beside Today, as in Reminders and Things; Today stays one column of the same section cards at a comfortable width, as in Reminders (whose Today is also split into Morning, Afternoon and Tonight); Day details opens as a popover pointing at the row, like a Calendar event; the day control moves to the top bar's centre. Every card, row and word stays the iPhone's. A narrow window is simply the iPhone layout. A Columns view, each time of day side by side, comes later as an option. |

---

## 2. Evidence and method

| Source | Read | About the iPad's layout or use |
|---|---|---|
| App Store reviews of the 74 habit apps that mention the iPad, a tablet, landscape, Split View, Stage Manager, multitasking, a keyboard or the Pencil | **2,071, every one read** | **996** (the other 1,075 are about sync, buying twice, or name the iPad in passing) |
| Apple's, Google's and Microsoft's own apps (Reminders, Calendar, Notes, Health, Fitness, Google Calendar, Tasks, Keep, Microsoft To Do): iPad/tablet reviews that also use a layout word | **455, every one read** | **337** |
| Play Store tablet reviews of habit apps with a layout word (Android tablets: supporting evidence only, W2) | **209, every one read** | **129** |
| Apple: HIG Layout, Sidebars, Split views, Toolbars, Sheets, Windows, Widgets, Keyboards, "Designing for iPadOS"; TN3192 (full-screen deprecation) | current pages, read 11 Oct 2026 | — |
| Our own research: [Feature Ledger C141](<../../../../Research/Research Reports/Feature Ledger.md#c141>) (Native iPad layout, 32 apps), [iPad Sync and Server Trust](<../../../../Research/Research Reports/Data, Sync and Accounts/iPad Sync and Server Trust — Backlog 5.md>) (who iPad users are), [Hamburger Menu vs Bottom Tab Bar](<../../../../Research/Research Reports/Home Screen and Visual Design/Navigation Pattern/Hamburger Menu vs Bottom Tab Bar.md>) (sidebar requests), the Section Header and Today research behind Design Rules | — | — |

The corpus: 337,331 App Store habit-app reviews, 901,453 Play Store, 248,439 for the platform apps. Each review was read
and coded by hand into the codes in [`iPad Layout Evidence/coded.py`](<iPad Layout Evidence/coded.py>) (habit apps),
[`coded_native.py`](<iPad Layout Evidence/coded_native.py>) and [`coded_play.py`](<iPad Layout Evidence/coded_play.py>);
[`check.py`](<iPad Layout Evidence/check.py>) checks that every coded key exists, no review has a code twice and no key
is repeated, and writes [`tally.txt`](<iPad Layout Evidence/tally.txt>). [`scan.py`](<iPad Layout Evidence/scan.py>)
regenerates the candidate list. Review keys are `A<app>#<line>` (App Store), `N…` (platform apps), `P…` (Play Store),
the same scheme as the earlier iPad report.

**Limits, said plainly.** Reviews undercount iPad users: people write when something breaks, and the earlier study
found iPad reviewers are buyers (they mention paying 2.1× as often). One Chinese app (A52) gives 56 of the 165
landscape complaints, so landscape demand is real but concentrated there; it is still raised in 24 apps. Habit apps
with good iPad layouts are rare in the corpus, so praise (55 reviews) is thinner than complaint. Apple's guidance is
quoted from the pages as published on 11 Oct 2026 and is version-scoped (iPadOS 26).

---

## 3. What people say

### 3.1 The main complaint: an iPhone app on the iPad (users show)

| Code | Reviews | Apps | Mean ★ | Since 2022 |
|---|---|---|---|---|
| Stretched or tiny iPhone app ("STRETCH") | 191 | 31 | 3.68 | 80 |
| No iPad version, asks for one ("NOIPAD") | 286 | 27 | 4.02 | 73 |
| Either | **477** | — | 3.89 | — |

The same picture recurs in every language: a phone-sized rectangle in the middle of the screen with black around
it, blurry or pixelated, or simply blown up (`A20#3602`, `A31#2311`, `A24#17960`, `A31#2347`). Two things stand out:

- **It loses sales at the moment of purchase.** "Please make an iPad version so I can buy the lifetime
  subscription" (`A12#318`); several promise to pay or upgrade their rating once there is a real iPad version (`A20#3516`, `A20#757`,
  `A52#17054`); one deleted the app the moment it opened as an iPhone app (`A16#923`).
- **It is cheap to fix and costly to ignore.** The Feature Ledger already says it: a stretched phone UI on iPad does more
  rating damage than a missing Watch app, "a layout, not a new product" ([C141](<../../../../Research/Research Reports/Feature Ledger.md#c141>)).

**Our app today is exactly this.** It is built iPhone-only (`TARGETED_DEVICE_FAMILY = 1`) and portrait-only, so on an
iPad it would run as a phone-sized window: the state 477 reviews complain about.

### 3.2 The iPad lives sideways (users show)

| | Reviews | Apps | Mean ★ |
|---|---|---|---|
| No landscape, or landscape broken ("LAND-NO") | **165** | 24 | 3.84 |
| Praises landscape ("LAND-YES") | 12 | 7 | 4.42 |
| Platform apps: landscape asked for / praised | 149 / 4 | — | — |
| Play Store tablets: landscape asked for / praised | 110 / 5 | — | — |

Why sideways: **a keyboard case or Magic Keyboard** ("99.9% of the time is locked in to my Apple Magic Keyboard",
`A31#4620`; `A10#40111`, `A36#165`, `A52#13974`, `N8#3908`), **a stand** ("its on a stand and I can only read it
straight", `A41#120`; `A18#1747`), and simply habit ("every iPad app … is landscape for a reason", `A13#6105`). Some
bought **because** an app did landscape (`A33#510`; "the only tracker I could find that works in landscape",
`A48#2662`), and some refuse apps that force portrait (`A41#120`, `A20#133`, `A31#206`). Landscape that hides content
or breaks when rotating is also reported (`A1#3357`, `A1#47539`, `A10#3830`).

### 3.3 What the iPad is for (users show)

From the reviews that say how they use the iPad next to the phone (82 coded ROLE, 47 coded MAIN: the iPad is their main device):

| Use | Reviews (sorted by hand) | What they say |
|---|---|---|
| **Set up, plan, review** on the iPad; tick off on the phone | 12 | "I use an iPad to set things up and my iPhone to input tracking data" (`A31#4799`); "Setup your habits on your iPad, fine-tune them on your iPhone and check them off on your Apple Watch" (`A41#576`); the iPad "to make new routines and edit easily" (`A5#1828`); an iPad "for a bigger analytic view", the iPhone "for a quick and on-the-go view" (`A13#9422`) |
| **At a desk, at work or studying**, the phone put away | 16 | the iPad for productivity and wellbeing apps, the phone kept for calls and social media (`A24#2062`); "I put my phone away to eliminate distractions" (`A31#4785`); `A4#19912`, `A52#15035` |
| **Evening and reflection**, journaling with a keyboard | 11 | "on my tablet at night when I'm reflecting on my day" (`A1#50944`); logging on the iPhone, journaling on the iPad (`A76#6894`); `A5#3009`, `A24#29975` |
| **Always open, in view** | 9 | "keep the app open at all times on my iPad so it's easier for me to check off my tasks" (`A4#17342`); "glance at the side of my iPad rather than opening the app" (`A33#2472`); a widget docked so "I see my habits every time I use my iPad" (`A48#2604`) |
| **At home**; the phone when out | 12 | "I do not take my iPad everywhere with me" (`A24#7298`); the iPad at home, the phone on a dog walk (`A5#1251`, Korean); `A13#812` |
| Children's habits on a family iPad | 16 | `A31#51`, `A24#33331`, `A10#22490` |

The platform apps say the same of calendars: the iPad is where people "sit down to schedule things or review the coming
week", the phone is for when they are out (`N8#31671`); "iPads make more sense when looking through what's
scheduled this week … phone is probably better for the day's agenda" (`N8#1121`).

**What this means for Today (reasoned):** the iPad's Today is read more than it is tapped in a hurry. It is looked at
from a little further away, often for longer, often in landscape, and often next to other apps. Scanning the whole day
(what's left, what's next, how the day is going) matters even more than on the phone; quick one-thumb ticking matters a
little less.

### 3.4 Use the room to see more — not to add more (users show)

29 habit-app reviews say what the room should show ("MORE"):

| Want | Reviews | Examples |
|---|---|---|
| More habits at once (smaller items, no scrolling) | 8 | icons "enormous" on iPad, wants more than six "and still all be visible at a glance" (`A23#4757`); "the ability to have a smaller thumbnail view that includes all of them" (`A3#3000`); on iPad "all my habits fit in one widget" (`A41#711`) |
| More of the day or week at once | 4 | a landscape view showing seven days (`A20#1096`, French); landscape made it easier "to look back and see entries from previous days" (`A55#1180`) |
| Progress beside the list | 7 | use the big screen to show the graphs (`A23#1921`, French); `A13#11986`, `A33#3685` |
| Use the empty space at all | 9 | a 12.9-inch iPad has "quite a bit of empty space … to display more information on the one screen without having to go through menus" (`A13#321`); "view all the pages at once" (`A23#380`) |

The platform apps show it at scale: Apple Calendar's iPad month view, with every event written in, is the thing 14
iPhone users ask to have on their phone (`N2#9760`, `N2#22836`, `N2#7000`); Google Keep was praised for "3 columns on
the iPad and 2 on the iPhone. Most apps waste the screen real estate by using only one column" (`N7#12386`); Google
Calendar's iPad layout with "the month view alongside the list of events" (`N8#8940`); Reminders' column view
(`N1#8235`). People wanted Health and Fitness on the iPad "to see the data on a larger screen" (11 reviews,
`N4#293`, `N4#3879`).

**But not clutter and not giant.** A calendar "crowded … despite occupying every space it can" is torn apart
(`N8#17641`); "expand the view instead of stretching it" (`P24#8657`); "more of a fun view than a 'managing' view"
(`P33#1877`). Size cuts both ways: everything "so big" on iPad, and the person wants to "not feel like a grandma who can’t see"
(`A55#1189`); text and icons too big to read comfortably (`A5#1098`, Korean), and the opposite, text smaller than on the phone (`N7#11015`).
**More at the same size, not the same at a bigger size** (reasoned from these).

### 3.5 Same app, same habits, same gestures (users show)

When the iPad version differs from the iPhone's, people are angry. Apple's own Fitness on iPad lacked the summary and
rings the iPhone shows: "appears radically different to a long time user" (`N5#14030`), "make this like the iPhone
app" (`N5#15430`); 11 such reviews. Habit apps: features or buttons missing on the iPad (20 "PARITY": `A23#1758`,
`A4#2309`, `A24#33273`), and a different gesture per device makes people mix them up (tap on the Watch, long-press on the phone, so "we therefore keep mixing up the actions",
`A23#7254`). Apple says the same (§4): keep functionality the same as the space
changes. **This is the user's "it's kind of the same", backed by reviews.**

### 3.6 Multitasking, keyboard, widgets (users show)

- **Next to other apps** (29 "MULTI"): Split View or Slide Over asked for so the habit list sits beside a notes app, a
  planner or a lecture (`A13#5982` with Goodnotes, `A24#8157` as a floating note while studying, `A13#6269`,
  `A18#1522`); one person said it was the only thing stopping them from moving over from another app (`A13#9442`); iPadOS 26's windowed mode already
  broke one app (`A23#3942`). Platform apps: Split View with notes praised (`N3#7929`), broken ones hated.
- **Keyboard** (24 "KEYS"): typing notes and journaling with a hardware keyboard (`A10#69579`, `A76#4873`), and
  layouts that leave room for an on-screen keyboard that isn't there (`N7#11761`) or let the keyboard cover a field
  (`A1#55437`, `N10#18345`). Shortcuts are asked for (`A25#537`, `N8#25848`).
- **Widgets** (57 "WIDGET"): iPad widgets asked for, praised as a glanceable list, and complained about when they
  don't update (`A1#54923`, `A33#73`, `A48#2604`).
- **Pencil** (4): handwriting notes, a minor want.

### 3.7 iPad-only bugs to design and test against (users show)

145 "BUG" reviews, mean **2.90**, the lowest of any code: sheets taller than the screen with Done off the bottom
(`A1#48430`), a Save button that does nothing on iPad (`A1#48919`, `A53#1000`), screens that can't scroll (several Finch reviews,
`A10#48368`, `A10#50303`), a picker cut off at the bottom (`A18#1360`, `A18#1370`), the week strip showing only three days
(`A18#1445`), landscape glitches on rotation (`A1#35924`, `A5#931`), and the keyboard covering a field
(`A1#55437`). These become test cases (§7).

---

## 4. What Apple asks for on the iPad (Apple, iPadOS 26)

| Topic | Apple's guidance (quoted from the HIG unless noted) | What it means here |
|---|---|---|
| The device | People "set it on a surface or place it on a stand", "typically within about 3 feet"; use "viewing distance and input mode to … determine the size and density" ("Designing for iPadOS") | Density is chosen for reading at arm's length; same type sizes, more on screen |
| Large display | "elevate the content people care about, minimizing modal interfaces and full-screen transitions" | Today stays in view; prefer sheets that don't cover the whole screen |
| Size classes | "Determine layout based on size classes, not device type or orientation" (Layout) | The layout follows the window's width, not "is this an iPad" |
| Familiar when resizing | "Keep functionality the same as size classes change, and keep layout changes recognizable and familiar to the platform … Consider taking advantage of larger spaces to switch from a Tab bar to a Sidebar" (Layout) | The ≡ menu becomes a sidebar on regular width; nothing else changes meaning |
| Sidebar | Let people hide it with the iPadOS edge swipe; "Avoid hiding the sidebar by default"; at most two levels; familiar symbols (Sidebars) | The menu's rows, same order, same icons |
| Split views | "Account for narrow, compact, and intermediate window widths" (Split views) | Design three widths, not two devices |
| Windows | iPad windows are full screen or freely resized; window controls appear at the toolbar's leading edge, so move leading buttons inward when they appear (Windows) | No leading-edge button that window controls could cover |
| Full screen only | `UIRequiresFullScreen` is deprecated in iPadOS 26 and will be ignored; apps should support "all interface orientations" and resizing; iOS 27 requires a launch screen (Apple technote TN3192) | Portrait-only is not an option on iPad |
| Toolbars | Leading, center and trailing groups; "the center area" holds "common, useful controls"; aim for at most three groups (Toolbars) | The day control fits the center; Edit and Filter + New stay trailing |
| Sheets and popovers | "Prefer using the page or form sheet presentation styles in an iPadOS app" (Sheets); a popover shows "a small amount of information or functionality", and "avoid displaying popovers in compact views" (Popovers) | Day details as a popover pointing at its row (§6); New Habit and other forms as form sheets; the iPhone's sheets in a narrow window |
| Keyboard | Respect standard shortcuts; custom ones for "only the most frequently used" commands, Command as the main modifier (Keyboards); iPadOS 26 shows commands in a menu bar | A handful of shortcuts, also in the menu bar |
| Widgets | An **extra large** widget size exists on the iPad (Home Screen and Today View), plus Lock Screen widgets (Widgets) | A whole-day widget is possible later (widgets are locked, U28) |

---

## 5. What Today has to keep (our own research)

These are decided for the iPhone and must hold on the iPad, because they are what make it "the same app":

- **"N left" on every section, open or folded**: "It's what people open the app to see. Never replace it with a
  button" (Design Rules, Today section headers). Folded sections show their icons and "+N".
- **Time-of-day sections in the person's order** (Rulebook U13), each saying when it starts; Now's Start is primary.
- **One row shape**: icon, name, one line under it, the round control on the right; tap the round control to act, the
  row to open Day details (U14); swipes reveal, never act; the long-press menu.
- **The day bar**: ‹ · ring, "Today ⌄", "6/15" · › (U23), and Back to Today only on another day.
- **Nothing moves during a run of taps** (U4); done rows sink after the pause (U13).
- **The ≡ menu's rows and order**: Today · Progress · Habits · Tasks | Times of Day · Day and Week · Reminders ·
  Appearance | iCloud & Backup · Privacy & Security | Plus | Help & Feedback · About (Design Rules, ≡ Menu — FINAL;
  "iCloud & Backup" after Current Work 81).
- **Speed**: every S rule, measured, not judged by eye.

Reviews back the scanning goal from the phone side too: people want to see "what is left for the day" (`A13#14619`),
a quick way to see "which habits have I not fulfilled today yet" (`A86#572`), done items sinking so the top shows what's next
(`A41#787`), and the day split into parts that "reflects how we experience our days" (`A13#12959`, `A13#14549`).

---

## 6. How the top iPad apps do it (second pass, 11 Oct 2026)

The user asked that the layout questions be settled by how Apple's own iPad apps and the best third-party apps look in
portrait and landscape, and what people praise or dislike, not by guesswork. I looked at the current App Store iPad
screenshots of 14 apps (Apple's Reminders, Notes, Calendar, Mail, Health and Home; Things 3, Todoist, TickTick,
Fantastical, Structured, Streaks and Habitify), the HIG pages on popovers, tab bars, sidebars and multitasking, and the
platform-app reviews of §3. The screenshots stay out of the repository (D11: no other apps' images in git); what each
shows is written down in [`iPad Layout Evidence/Top iPad Apps — What Each Screen Shows.md`](<iPad Layout Evidence/Top iPad Apps — What Each Screen Shows.md>).

### 6.1 What they have in common

| Question | What the top apps do | Who |
|---|---|---|
| **Navigation** | A **sidebar** (a split view), shown beside the content in landscape and tucked away in portrait. Apple's HIG says to prefer a top tab bar on iPad, but every productivity app here uses a sidebar; the tab bar is for media apps | Reminders, Notes, Mail, Calendar, Health, Home, Things, TickTick, Habitify, Todoist, Fantastical |
| **"How much is left"** | A **count beside Today in the sidebar**, always in view, plus counts on section headers | Reminders (big tiles: Today 6, Scheduled 16…), Things (Today badge), TickTick (counts on every list and day header), Notes (counts on folders) |
| **A day's list** | **One column**, split into sections, never cards scattered across the screen. Reminders' Today is split into **Morning, Afternoon and Tonight**, exactly our times of day. Things keeps the column at a readable width (≈ 700 pt), centred on a big screen; Reminders and Habitify run it the full width | Reminders, Things, TickTick, Habitify |
| **Side by side** | Only as a **view people choose**: Reminders' **Columns** turns each section into its own column, left to right in the section order (praised: "columns mode is great", `N1#8235`); dashboards lay cards **three across, flowing in rows** | Reminders, Todoist (boards); Health, Home (dashboards) |
| **Details of one item** | A **popover pointing at the item**, the list staying in view (Apple's own example in the HIG: "a calendar event popover … disappears after the change, letting people continue reviewing the events"); inline expansion; or a pushed page in the content column | Calendar and Reminders (popover; one reviewer complained when Reminders' details popped up off to the side, `N1#7979`, another when tapping an event stopped showing them, `N2#16334`), Things (inline), Notes, Mail, Health (pushed) |
| **Date and view controls** | **At the top, in the centre** (Day / Week / Month / Year), with a **Today** button at the top | Calendar, Fantastical, TickTick |
| **At-a-glance summary** | Summary chips across the top (Home: "Lights 5 On", "Security No Alerts"), tiles with counts (Reminders) | Home, Reminders |

What people dislike in these patterns (users show): a sidebar that is always there and can't be put away
(`N8#16832`) or pops back by itself (`N1#20880`, `N3#9779`); a detail panel stuck on one side of the day view
(`N2#18857`); a popover placed off the screen (`N1#7979`); a busy calendar "despite occupying every space" (`N8#17641`).

### 6.2 What this means for our Today

**The iPad's Today is the iPhone's Today in Apple's iPad frame:**

1. **A sidebar instead of the ≡ drawer**, with **a count of what's left beside Today**: the scan from anywhere in the
   app, the way Reminders and Things do it.
2. **Today is one column of the same section cards as on the iPhone** (Morning, Afternoon, Evening, Anytime, Quit or
   Cut Down, Paused), in the person's order, each with its "N left" and folded icons. On a wide window the column keeps
   a comfortable width (≈ 700 pt, like Things) instead of stretching rows across the screen.
3. **Day details opens as a popover pointing at the row** (like a Calendar event), Today staying in view; its content
   is the iPhone's Day details, and Add log, Log and Note open inside it. In a narrow window it is the iPhone's sheet.
4. **The day control sits in the top bar's centre**, like Calendar's view switcher, and "Back to Today" appears at
   the top beside it when another day is open, like Calendar's Today button.
5. **A Columns view as an option, later** (Reminders' Columns): each time of day its own column, left to right in the
   person's order. It answers "show me the whole day at once" (§3.4) without changing the default. To design after the
   first screen is approved.

This replaces the first pass's "cards side by side in two or three columns" (§6.6): no top app lays a day's list out
that way, and side-by-side sections are a view people choose, not the default.

```
 iPad 11-inch, landscape (1180 × 820) — sketch, not a design
┌───────────────────┬─────────────────────────────────────────────────────────────┐
│            ◧      │            ‹   ◔ Today ⌄   6/15   ›         Edit   ⧩  +     │
│ ⌂ Today        9  │      ┌───────────────────────────────────────────────┐      │
│ ▤ Progress        │      │ Morning   Starts 6 AM            2 left ▶ Start│      │
│ ☰ Habits          │      │ ◉ Water        3/8 glasses                 (+) │      │
│ ✓ Tasks           │      │ ◉ Read         Every day                   (✓) │      │
│                   │      └───────────────────────────────────────────────┘      │
│ Times of Day      │      ┌───────────────────────────────────────────────┐      │
│ Day and Week      │      │ Afternoon  Starts 12 PM   ◉ ◉ ◉ +2    3 left ›│      │
│ Reminders         │      └───────────────────────────────────────────────┘      │
│ Appearance        │      ┌───────────────────────────────────────────────┐      │
│ iCloud & Backup   │      │ Evening    Starts 6 PM               4 left   │      │
│ …                 │      │ ◉ …                                            │      │
└───────────────────┴─────────────────────────────────────────────────────────────┘
```

### 6.3 Widths

The layout follows the window's width (Apple, §4). Device widths, in points, portrait × landscape: iPad mini 744 × 1133;
iPad and iPad Air 11-inch 820 × 1180; iPad Pro 11-inch 834 × 1210; iPad Air 13-inch 1024 × 1366; iPad Pro 13-inch
1032 × 1376.

| Window | Layout |
|---|---|
| **Compact** (a narrow window next to another app) | **The iPhone app, exactly**: ≡ drawer, bottom day bar, sheets |
| **Regular, portrait** (11-inch, 820–834 pt) | Today fills the width up to ≈ 700 pt; the sidebar is tucked away and slides in with the sidebar button or the edge swipe (the system's default) |
| **Regular, landscape** (11-inch, 1180–1210 pt) | Sidebar (≈ 320 pt) beside Today; Today's column ≈ 700 pt, centred in the rest |
| **13-inch** (to design after the 11-inch, as decided) | The same, with more margin; the Columns view earns its place here |

### 6.4 The rules, I1–I12 (revised)

| # | Rule | Backing |
|---|---|---|
| I1 | **The same Today, not a new one.** Cards, rows, the round control, the line under the name, "N left", folded icons, Start, swipes, long-press menu, words and spacing are the iPhone's, unchanged | §3.5; Apple "keep … familiar"; the user |
| I2 | **Compact width is the iPhone layout**, exactly, including the ≡ drawer, the bottom day bar and sheets | Apple size classes; §3.6 |
| I3 | **On regular width the ≡ menu is a sidebar** (`NavigationSplitView`): the same rows and order, Today · Progress · Habits · Tasks first and the menu's other groups below, as on the iPhone; beside Today in landscape, tucked away in portrait, always possible to put away, never popping back by itself | §6.1 (every productivity app); `N8#16832`, `N1#20880` |
| I4 | **The sidebar's Today row shows how many are left today** (a plain grey count, as Reminders, Things and Notes do) | §6.1; the user's scan goal |
| I5 | **Today is one column of the iPhone's section cards**, filling the width up to ≈ 700 pt and centred beyond it; nothing moves because something was tapped (U4) | §6.1 (Reminders, Things, TickTick, Habitify); U4; U13 |
| I6 | **The day control sits in the top bar's centre**; **Back to Today** appears beside it only on another day | §6.1 (Calendar, Fantastical); U23 keeps the phone's bottom bar |
| I7 | **Top bar: the system sidebar button · the day control · Edit, then Filter and +** (three groups), nothing at the leading edge that window controls could cover | Apple Toolbars and Windows; Design Rules ≡ Menu |
| I8 | **Every orientation and any window size**; nothing assumes full screen | §3.2; Apple TN3192 |
| I9 | **Day details is a popover pointing at its row** on regular width (Add log, Log and Note open inside it; it asks before closing if something was typed, U18); a sheet on compact width; the routine player and the timer stay full screen | §6.1 (Calendar, Reminders); Apple Popovers ("avoid displaying popovers in compact views"); U18 |
| I10 | **The same type sizes and Dynamic Type**; at the largest sizes the column simply grows | §3.4; U1 |
| I11 | **Keyboard and pointer**: a few shortcuts in the iPadOS menu bar (New Habit ⌘N, Go to Today ⌘T, previous and next day, Filter), hover highlights, right-click opens the long-press menu, Return saves an Add screen | Apple Keyboards; §3.6 |
| I12 | **Speed and tests on the iPad too**: a year of history, rotation and window resizing, measured (S2); the iPad-only bugs of §3.7 as test cases | Rulebook S, T |

### 6.5 What stays for later (reasoned)

- **The Columns view** (§6.2 item 5), designed after the first screen.
- **Progress, Habit details and the other pages**, one by one; Progress is where a dashboard of cards (Health's
  pattern) and charts beside the list (§3.4) fit best.
- **An extra large "whole day" widget** for the iPad Home Screen: widgets are locked (U28), so only with the user's
  say-so.
- **Live Activities and alarms on the iPad** must be checked on a real iPad before anything is promised.

### 6.6 History

The first pass (11 Oct 2026, morning) recommended the iPhone's cards side by side in two or three iPhone-width columns
and Day details as a centred form sheet, and asked the user six questions. The user decided two (free; the 11-inch
first) and asked for the rest to come from the top apps' patterns, which changed the layout to one column (plus an
optional Columns view later) and Day details to a popover.

---

## 7. Building it (for later; notes, not a plan)

- **Settings**: add the iPad to the build (`TARGETED_DEVICE_FAMILY = 1,2`), all four orientations on iPad, a launch
  screen; keep the iPhone portrait-only unless decided otherwise.
- **Speed (S rules)**: a taller iPad screen draws more rows at once, and the sidebar's count changes with every log.
  Keep a tap redrawing only its row and the count (S6), never a lazy grid inside a `List` (S13), no `GeometryReader` per
  row (S10); when the Columns view comes, choose how to build it only from variants side by side in one run (S2,
  `PerfSwitches`). New `PerfDriver` scenarios:
  Today on an iPad simulator with a year of history (scroll, tap, day ‹ ›), rotating, resizing the window (T4).
- **Tests**: UI tests on the iPad mini in portrait, an 11-inch in landscape, a 13-inch in landscape and a compact
  window; every key frame named on one line (T14, T15); the cases of §3.7 (a sheet's main button reachable, scrolling
  in every sheet, the keyboard never covering the focused field, rotation mid-sheet).
- **iPhone check (U9) becomes an iPad check** too: the user's iPad, light and dark, larger text, with a keyboard.

---

## 8. Decisions

| # | Question | Outcome |
|---|---|---|
| 1 | Is the iPad layout free or Plus? | **Free**, decided by the user on 11 Oct 2026; sync between devices stays Plus |
| 2 | How do sections sit on a wide screen? | **One column, as in the top apps** (§6.1–6.2); side by side only as an optional Columns view, each section its own column in the person's order, like Reminders |
| 3 | Day details on the iPad? | **A popover pointing at the row**, like Calendar's events and Reminders' details; a sheet in a narrow window (§6.1) |
| 4 | Three columns on the widest windows? | **No longer needed**: the Columns view scrolls sideways when there are more sections than fit |
| 5 | Where does the day control go? | **The top bar's centre**, like Calendar's and Fantastical's controls, with Back to Today beside it |
| 6 | Which design first? | **The 11-inch iPad**, decided by the user; the 13-inch after it |

Questions 2–5 were settled from the top apps' patterns at the user's request (11 Oct 2026: "these questions shouldn't
be for me … take inspiration from top apps and top patterns in the iPad").

---

## 9. Evidence index

Every number above resolves through the coding files; the main review keys per finding:

| Finding | Keys |
|---|---|
| Stretched / no iPad version (477) | `STRETCH` and `NOIPAD` in `coded.py`; examples `A20#3602`, `A31#2311`, `A24#17960`, `A16#923`, `A12#318`, `A20#3516` |
| No landscape (165) / landscape praised (12) | `LAND-NO`, `LAND-YES`; `A31#4620`, `A41#120`, `A36#165`, `A33#510`, `A48#2662`, `A13#6105` |
| What the iPad is for (82 + 47) | `ROLE_THEMES` and `MAIN` in `coded.py`; `A31#4799`, `A41#576`, `A13#9422`, `A24#2062`, `A4#17342`, `A33#2472`, `N8#31671`, `N8#1121` |
| See more at once (29) | `MORE_THEMES`; `A23#4757`, `A3#3000`, `A13#321`, `A23#1921`, `N7#12386`, `N8#8940` |
| Not clutter, not giant | `N8#17641`, `P24#8657`, `P33#1877`, `A55#1189`, `A5#1098`, `N7#11015` |
| Same app on every device | `PARITY`; `N5#14030`, `N5#15430`, `A23#7254`, `A23#1758` |
| Multitasking (29), keyboard (24), widgets (57) | `MULTI`, `KEYS`, `WIDGET`; `A13#5982`, `A24#8157`, `A13#9442`, `A23#3942`, `N7#11761`, `A48#2604` |
| iPad-only bugs (145, mean 2.90) | `BUG`; `A1#48430`, `A1#48919`, `A18#1360`, `A18#1445`, `A1#55437` |
| Today's scanning needs (phone side) | `TODAY_EVIDENCE` in `coded.py` |
