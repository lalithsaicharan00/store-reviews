# Navigation — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "check how actually native iOS apps do it, and based on that, update this … create the native iOS components itself rather than using these … The pure, I mean, ultimate goal in this Figma file is to achieve the native iOS."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, section `06 · Navigation & search` (node `1299:2427`) on the design system page.

## Where each part comes from

- **What it looks like and its sizes:** real SwiftUI controls on the user's iPhone 16, iOS 26.6, in a throwaway app (`Research/Temp/ios-nav/`, git-ignored). Twenty set-ups were tried: titles, segmented controls, search in each placement, the tab bar, a sheet and the title menu. Sizes were read from the views and from screenshots converted to sRGB.
- **What the app does:** its code (`iOS/Habits/`).
- **The rules for choosing:** Apple's Human Interface Guidelines, read 5 Nov 2026.
- **The glass:** the Liquid Glass frames from Apple's iOS 26 kit, already in the Glass button. It's a good likeness and not exact, as the user asked, since the app will use the real thing.

## What's in the section

| Component | Variants | What it is | Measured |
|---|---|---|---|
| **Navigation bar** (`495:70`, was Top app bar) | 10: Leading × Text | SwiftUI's navigation bar with Liquid Glass buttons | Buttons 44, at 16 from the edges, 5 under the status bar |
| **Bar segmented control** (`4067:2954`, new) | Segments 2 or 3, Selected | A segmented `Picker` in `ToolbarItem(placement: .bottomBar)` | 47 tall, pill 39 (black at 10 %), Subheadline |
| **Period bar** (`4309:2606`, new) | Latest | Bar segmented beside ‹ period ⌄ › in one glass capsule | 360 × 48, gap 8 |
| **Menu row** (`625:46`, was Drawer item) | 2: Selected, Unselected | A row of an inset-grouped `List` | 50 tall, 16 at the sides, 26-wide symbol, gap 14, Body |
| **Search field** (`1114:1963`, was Search bar) | 2: Empty, Typed | `.searchable` under the bar, or inline | 44 tall, capsule of glass, 13 at the sides, gap 9, Body |
| **Active search** (`1052:1960`, was Search view header) | 2: Empty, Typed | `.searchable` while typing: the bar gives way to the field and a ✕ | Field 44 at y 67, gap 11, ✕ 44 |

**Navigation bar:**

- **Leading:** None, Menu (☰) or Back (‹), each a glass circle.
- **Text:** Title, Title and subtitle, None or Segmented.
  - **Title** is Headline, truly centred on the screen.
  - **Title and subtitle** is `navigationSubtitle`: Subheadline Semibold over Caption 1 in Secondary Label. No screen uses it yet. It was kept because iOS has it and the file already had it.
- **Actions:** one or two symbols sharing **one glass capsule**, as a `ToolbarItemGroup` draws them. Two are 100 wide; one is a 44 circle. The shared capsule needed a new Glass button variant, `Style=Grouped`, with no glass of its own. The capsule's glass is tied to the Action 1 switch, so it disappears with the buttons.
- **The bar stays 64 tall** so screens didn't have to move. The phone's buttons sit at y 59, so the bar has 5 above its buttons and 15 below. Apple's kit has 0 and 10, but its status bar is taller for a different iPhone. The phone wins.
- **It has no fill of its own:** content scrolls under glass, so 20 copies with their own fill lost it.

## How iOS does page-level navigation, and what we chose

Android's Primary tabs switched Habits | Tasks on the Habits & Tasks page and Progress | History on Details. **iOS has no such tab style, so Primary tab and Primary tabs were deleted.**

What Apple says:

- Tab bars: "Prefer a tab bar for navigation", and keep it visible across sections.
- Segmented controls on iOS: "Consider a segmented control to switch between closely related subviews." "For switching between completely separate sections of an app, use a tab bar instead."

| Option, tried on the phone | Verdict |
|---|---|
| **Segmented control in the bar's title slot** | Replaced 6 Nov 2026: at 160 wide it's smaller than the row under it, so the second choice looked more important than the first |
| Two segmented controls stacked under the title | Rejected: two identical controls one on top of the other, with no sign which one is the page |
| Tab bar (Today · Habits · Tasks) | Rejected for now: Today already has the Bottom toolbar the user asked for, and a tab bar can't live on a page pushed from the menu. It would be a change to the app's whole structure, and that's the user's call |
| Title menu ("Habits ⌄") | Rejected: Tasks is hidden behind a tap, for a choice used constantly |

### Habits & Tasks: the order people choose in (6 Nov 2026)

The user: "first … which one do they want to go into, habits or tasks? Then if they go into habits, it will be like week, month, year. If they go into tasks, it will be like, is it one time or repeating? Then they think about like, oh, now which time period?" The title menu had hidden Tasks, "not at all good UX because it is an important thing".

| Level | What it is | Where |
|---|---|---|
| 1. Habits or Tasks | Segmented control, Size=Large (`.controlSize(.large)`, 48 tall), full width | Under the bar, pinned: it doesn't scroll away, and it stays on empty pages |
| 2. How to look | A Week ⌃⌄ drop-down on Habits (112 wide, the same for every word), Bar segmented One-time · Repeating on Tasks | Bottom bar |
| 3. Which period (Habits only) | ‹ 18–24 Oct ⌄ › in one glass capsule, with the rest of the bar (208 at 360) | Bottom bar. Tapping the period opens the calendar |

The bar is ☰, search and +, with no title: the control says where you are. Size does the work: level 1 is the biggest control on the page, and the two below are smaller and out of the way.

Tried on the Simulator before choosing:

| Option | Verdict |
|---|---|
| Habits \| Tasks in the bar, Week · Month · Year as a row under it | Rejected: level 2 looks bigger than level 1, and the bar is crowded at 160 |
| Letters (W M Y) beside the period | Rejected: nobody reads W M Y as week, month, year |
| Two floating rows at the bottom | Rejected: too heavy over the list |
| **Week as a drop-down beside the period** | **Chosen by the user, 6 Nov 2026:** "for week, month, year, a drop-down is better", with more room for the period |
| Filter buttons instead of a segmented control | Rejected: not how iOS picks one of three |
| Large segmented on top, Week · Month · Year segmented beside the period | Tried first, then replaced: the user found it weird, and the period had no room |

Why the time scale can go to the bottom: people pick one view and stay on it ([Switching Day, Week, Month, Year](<../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/10. Switching Day, Week, Month, Year — How Often, and Where.md>), read from reviews, not measured taps). The period changes more often, and it's where a thumb reaches.

**Read from a real bottom-bar `Picker` on the Simulator:** words 15 Regular; the selected pill is a clear grey, `#D9DDDC` on glass `#EDF0F0`, so Bar segmented's pill is black at 10 % (a plain paint). The old `#F2F2F7` couldn't be seen on the glass. The large control's words stay 13 (Footnote). iOS fades content as it passes under a bottom bar, so these pages draw it as a Scroll edge: 124 tall, Grouped Background, 0 % to 60 % to 90 %. Today's Figma frames don't have one yet.

**A text cloned from another component keeps that node's hidden key:** three symbols in Period bar came from one source, so every copy gave all three the same id (`I…;4051:2540`) and drew them at random: ‹ › one time, ⌄ the next. Create such a text new, and read a fresh copy's ids for duplicates.

- **Details' Progress | History** is the ordinary **Segmented control** from section 05, under the habit's name. That's what the app does (`AllHabits/HabitPageView.swift:166`). It sits in a plain "Segmented row" frame, 16 at the sides and 8 above and below: 48 tall like the old tabs, so nothing below it moved.
- **There's no title on Habits & Tasks.** The menu row still says Habits & Tasks, and the segments say Habits and Tasks.

## The menu

**Apple's guidance doesn't describe a side menu on iPhone,** and the app says so in its own code (`Menu/SideMenu.swift`). It builds one from system parts, and that's what was kept, because the app has it and the user decided on it on 30 Sep 2026: an inset-grouped list on System Grouped Background, in a panel 84 % of the screen wide, with the dimming a sheet uses.

- **Panel:** 302 wide, no rounded corners, soft shadow, cards with radius 26, 12 between them.
- **Selected row:** the filled symbol and Semibold. No pill behind it.
- **Symbols:** `sun.max.fill`, `checklist`, `plus.circle`, `gear`, `envelope`, `bubble.left`. The row names are Android's, in iOS's title case: **Contact Us** and **Send Feedback** (6 Nov 2026), the same rows on every platform.
- **Back instead of ☰:** a menu row pushes its page, so Habits & Tasks and Settings now have Back, as in the app. ☰ stays only on Today.
- **The header stays:** the Often Enough mark and name are still at the top. The app's menu has none. The user named the items, not the header, so it's left for them to decide.

## Search

iOS has search but draws it differently, so both components were changed, not deleted.

- **Search field:** a glass capsule with `magnifyingglass`, and `xmark.circle.fill` when there's text.
- **Active search:** Android had ‹ then a bare field. iOS has the field first, then a ✕ in its own glass circle. Apple: "Place search at the top" when there's no bottom toolbar, and a toolbar button "animates" into a field. So search on Habits & Tasks and Notes starts from the bar's search button and opens at the top.
- **Not used:** iOS 26's default places the field at the bottom (`.searchable` with no placement, as Help has in the app). It's a real choice for later: Apple says "Place search at the bottom if there's room".

## A correction to section 05

**The app's Add, Save and Done are plain glass with a Semibold word, not dark.** [Buttons](<Buttons — iOS Native.md>) said `.confirmationAction` draws solid Ink, and that was wrong. On the phone, with the app's own code (`AddHabit/NewHabitView.swift:579`), it's plain. A dark one needs `.buttonStyle(.glassProminent)`, and `role: .confirm` gave iOS's blue. So the 9 words placed in the forms became Glass button, Regular, Body Semibold, at y 59, and the unused Prominent variant was deleted.

## What's different on other pages

- **Today's actions are Edit, then + (6 Nov 2026,** the user: the pencil "is looking a little bit weird"). The Navigation bar has a *Text action*: a word in its own glass capsule, 12 before the symbol capsule. Apple's Toolbars guidance keeps a word apart from symbols and uses a word for Edit, and Shortcuts on iOS 26 draws exactly this. SwiftUI: `Button("Edit")`, `ToolbarSpacer(.fixed)`, `Button("New", systemImage: "plus")`. All 264 of Today's bars changed. Filter, which the app still has, stays out (Android removed it).
- **Notes' search in the app** is an inline field with radius 10 (`HabitNotesTab.swift:77`), where the file now has the capsule, which is what iOS draws for `.searchable`. The app gets the same field when it's rebuilt.
- **Flow names and notes still say "tabs"** in places ("the top bar, the tabs and the period row stay"). Those are labels, and they weren't rewritten.
- **The screens are still 360 × 800.**

## Checked

Looked at by eye: section 06, Habits & Tasks (Habits and Tasks), Today, the menu, New habit, Details, Day details, Search with text, the icon picker with its field, and Keep reminders coming.

Read for all copies:

- 190 bars, 13 search fields, 9 active searches, 6 menu rows.
- No copies left on Primary tab, Primary tabs or Prominent, and no other font inside the new components.
- **Action symbols match the Android file exactly by count:** 35 ⋯, 23 search and +, 7 pencil and +, 1 + (the comparison below).

No change was made to the iPhone app, and the throwaway app was uninstalled.

**Not looked at:** every flow screen. Settings, Onboarding, Plus and Widgets were read, not looked at, apart from one Settings page.

**Not measured:**

- The subtitle's sizes were judged from text width in a screenshot.
- The Segmented control read 31 tall in this test where section 05 has 32. It's left at 32.
- The Bar segmented control's width on the phone was set by the test.

## Checking this in Figma

- **Swapping a nested button in a main component resets that button's property overrides on every copy.** Changing Action 1 to the Grouped variant in the main turned 66 copies' symbols back to the default: Water's ⋯ became search. Set the property again on each copy afterwards, or avoid the swap.
- **The Android file keeps the same node ids,** so it's a record of what each copy held. Read it to restore, read-only, and compare counts afterwards.
- **A hugging frame with all its children hidden keeps its last size,** so a glass background behind them stays as an empty circle on 103 copies. Tie the background's visibility to the first child's switch.
- **`getInstancesAsync` can return none of the copies nested inside other copies** (0 for the bar, though it lists them for the Glass word). Don't take that count as proof that none exist.
- **Testing `devicectl` launches on a locked phone fails** ("could not be unlocked") and its screenshot is black. Check for that before trusting a capture.
