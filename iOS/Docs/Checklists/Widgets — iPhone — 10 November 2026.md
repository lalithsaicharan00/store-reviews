# Widgets — iPhone — 10 November 2026

Written by Claude (Claude Code), 10 November 2026, at the user's request: "next work on the widgets … we have
removed all of the plus screens. Plus features, everything is free. So remove those plus related features and update
the widgets screens … They are still using Android ones … Update them according to the iOS first of all, iOS
dimensions like square, small, medium, large … work on one widget at a time. Once all of those are done, then work on
the designs."

Figma: the iOS app file, page **widgets** (`1232:173760`). One widget per pass of the loop.

## The user's points

- [x] Everything is free: no Plus anywhere in the widgets (no "comes with Plus" states, no free-plan flow).
- [x] Every widget at the iPhone's own sizes, not Android's 2 × 2, 4 × 2 and 4 × 4.
- [x] One widget at a time, in the design system first.
- [x] Then the screens and flows: the iPhone's Home Screen, adding a widget and editing one the iPhone's way, not
  Android's launcher, edit frame and setup screens.

## The iPhone's sizes

From Apple's own kit, *iOS and iPadOS 26* (Figma's libraries), *Home Screen Widget - iPhone*, read 10 Nov 2026:

| Size | Points | Corner |
|---|---|---|
| Small | 164 × 164 | 28 |
| Medium | 349 × 164 | 28 |
| Large | 349 × 365 | 28 |

They belong to the kit's 402 × 874 Home Screen (*Home Screen - iPhone*). Each phone size has its own; read them from
the phone before building.

Android's sizes map to these: 2 × 2 → Small, 4 × 2 → Medium, 4 × 4 → Large.

## The widgets

- [x] One habit (2 × 2) → Small. The component (*Widget · One habit (Small)*, Habit and Message) was Android's
  156 × 176, padding 16 by 12: now 164 × 164 with Apple's 16 margin all round, the gap above the name taking the
  difference, so icon and ✓ stay at the top and the name, status and bar at the bottom. All 64 copies follow; the
  every-state board looked at again (30 states, nothing cut). Still Android-sized: the scaled previews inside
  Android's widget picker and sheet (go with them, below), and two export frames for Android's picker previews
  (`drawable-xxhdpi/widget_preview_one_habit.png`, 468 × 528, and its 374 × 422 copy), which belong to Android.
- [x] Today and Tasks list (4 × 2, 4 × 4) → Medium and Large. The component (*Widget · List (Medium, Large)*) was
  Android's 328 × 176 and 328 × 368: Medium is 349 × 164 and Large 349 × 365, Apple's 16 margin at the sides and 12
  at top and bottom, and the variants are named Size=Medium and Size=Large. Medium's two rows are 52 tall (56 doesn't
  fit 164 under the header); Large keeps five rows of 56. **Design system:** the list row (*Widget · List row*) didn't
  stretch, so at the new width its progress fill and button stayed where they were: its fill and body now stretch,
  and every *Widget row fill* scales, so 30 % stays 30 % at any width. 31 copies had kept Android's size as their own
  and are back to the component's. The every-state board is laid out again at the new sizes (it overlapped) and its
  copies say Medium and Large; its *Today without Plus* state is deleted (everything is free). Looked at the board
  again: every state fits.
- [x] This week (4 × 2) → Medium. The component (*Widget · This week (Medium)*, Habit and Message) was Android's
  328 × 176: now 349 × 164 with 16 at the sides and 12 at top and bottom; the habit block and the week block keep
  their places and fill the height. 9 of its 28 copies had kept Android's size as their own and are back to the
  component's. The every-state board is laid out again at 349 wide in four columns (it overlapped), its copies say
  Medium, and its *free plan* state is deleted (everything is free). Looked at the board again: all six states fit.
- [x] Plus removed: the *comes with Plus* setup screens and the "Today widget on the free plan" flow. **Design
  system:** the list and This week widgets each had a hidden Plus label and a *Show Plus label* switch: both gone.
  Widget setup's *Today · free plan* and *This week · free plan* are deleted (five screens left, the set shrunk to
  fit). The flow "Today widget on the free plan" is deleted whole (header, seven screens, arrows, words and notes).
  The gallery's three descriptions ended "With Plus." in the widget picker, the app's widgets sheet and their 34 copies:
  the words end before it now. "Add the Today widget from the app's icon" was for "Someone with Plus": now anyone.
  Searched the page again: no shown word says Plus or free plan. Looked at the list widget and the gallery again.
  Left: the design system's List item still has a hidden Plus label and Plus row (used across the app, not only here);
  noted in the Rulebook for a whole-file pass.
- [x] Home Screen: Apple's, not Android's launcher and search bar. **Design system:** *Home screen* was Android's
  360 × 800 launcher (an At a glance date and weather, four round dock icons, a Google search bar, a Home
  Indicator). It's now Apple's *Home Screen - iPhone* from the iOS 26 kit, 402 × 874, the size the widget sizes belong
  to: the kit's wallpaper, status bar, Search pill and Dock, its app icons kept but invisible (hiding their frame
  pulled Search and the Dock up), and no Home Indicator (iOS shows none on the Home Screen). The Widgets slot sits
  where the kit puts a widget: 27 from the left, 90 from the top, 349 wide. **New:** *Widget name (native)*, the
  name iOS shows under every widget, read from the kit: SF Pro Medium 12, white, 5 below the widget. Each widget on
  the board now has it ("Often Enough"), two Smalls sit 21 apart, and one widget's top is 200 below the last for
  Small and Medium (401 for Large), as the kit's grid. The board is *Home Screen · widgets*, its four screens named
  Small, Medium and Large. Looked at the board: all four fit, nothing cut. The flows' copies of the Home Screen are
  402 × 874 now too; their widgets get their names and their rows are spaced again with the flows.
- [x] Adding and editing: the iPhone's widget gallery and Edit Widget, not Android's launcher menu, edit frame and
  setup screens
  - [x] The widget gallery. Apple's kit has no gallery, so it's read from the iOS 26 Simulator on an iPhone 17
    (402 × 874, the same size as the kit's Home Screen), 11 Nov 2026: touch and hold the Home Screen, Edit, Add
    Widget. **New:** *Widget gallery (native)*, the list: a sheet 122 from the top, corners 38, over the Home Screen
    dimmed 22 %; a drag handle; Search Widgets (a 350 × 44 capsule, 26 from the sides); then each app with widgets,
    72 a row, its icon 48 at 27 and its name in Headline at 91, a separator from the name to the edge. Often Enough
    sits among Apple's apps in A to Z order, with Apple's own icons from the kit. *Widget gallery · Often Enough
    (native)*, one variant per widget and size (One habit Small; Today Medium and Large; This week Medium; Tasks
    Medium and Large): the app's icon (29) and name at the top with ✕, the widget's name in Title 1 Bold and what it
    does in Body (Tertiary Label, as measured), centred; the widget itself at its own size in the middle; six page
    dots; and Add Widget, a 48 capsule 25 from the sides. **The button takes the app's accent colour** (the
    Simulator's Ambient Music page was purple): ours is Ink, so the app's AccentColor must be Ink when it's built.
    The descriptions are the Android picker's, one per kind as iOS has (Today's Large no longer says "five at a
    time"). **New:** *Often Enough icon (native)*, the iPhone app icon: the brand's square master in iOS's rounded
    mask, any size. Looked at both: nothing cut, every page's widget fits. On the Simulator, the gallery's own
    suggestions page came up empty; the app list and an app's page are what's drawn.
  - [x] The Home Screen's edit mode and its Edit menu (Add Widget, Customise, Edit Wallpaper, Edit Pages). Read from
    the iOS 26 Simulator on an iPhone 17, 11 Nov 2026 (touch and hold the Home Screen; Edit). **Design system:**
    *Home screen* is now a set, **Mode=Default** (its 15 copies stay on it) and **Mode=Editing**: no status bar, Edit
    and Done glass capsules (66 × 28, Headline, white) at 39 and 297 from the left, 19 from the top, and the page dots
    (7 round, 14 apart, this page white, the others 40 %) in a 78 × 29 glass capsule where Search was. **New:**
    *Widget editing marks (native)*, Size=Small, Medium and Large, laid over a widget at its own size: the remove badge
    (26 round, light glass, grey minus) 6 left of and 7 above its corner, and the glass resize handle along its
    bottom-right corner. *Home Screen edit menu (native)*: our Menu with four Menu items, white words and symbols on
    frosted glass (a blur, so the words read over a white widget, as on the Simulator), placed 40 from the left and 63
    from the top, under Edit. **Its four symbols aren't in Figma's SF Pro** (widget.small.badge.plus is newer than
    Figma's copy; apps.iphone.badge.paintbrush, photos and apps.iphone.on.rectangle.portrait are Apple's private
    ones), found by matching the Simulator's icons against every symbol on the Mac and brought in as their outlines,
    *Symbol · … (native)*, 28 × 22 like a glyph. **Menu item** has a new hidden *Leading symbol* (swap) and *Show
    leading symbol* switch for such symbols, on all seven variants; nothing else changes. Looked at edit mode with a
    Medium and two Smalls, with and without the menu: nothing cut, the words readable.
  - [x] Touch and hold an app or a widget, and Edit Widget. Read from the iOS 26 Simulator on an iPhone 17, 11 Nov
    2026, with Reminders. **iOS 26's touch and hold menu starts with a row of sizes** (the app's icon, Small, Medium,
    Large): tapping a size on an app's icon turns the icon into that app's widget where it is, with no edit mode, and
    on a widget it changes the widget's size. **New:** *Widget size button (native)* (44 × 37, the chosen one on black
    10 %, radius 12, its symbol at 20 pt) and *Home Screen touch and hold menu (native)*, one variant per thing held:
    App icon (Edit Home Screen, Remove App), One habit widget (Small only), Today and Tasks (Medium, Large) and This
    week (Medium), each with Edit “…”, Edit Home Screen and Remove Widget. Share App isn't drawn (Apple's own apps
    don't show it). Its seven symbols are SF Symbols brought in as outlines, as the edit menu's were. **New:** *Edit
    widget card (native)*, 349 × 349 at 26 from the left and 262 from the top, corners 39: the app's icon (35), the
    widget's name in Headline, Often Enough in Subheadline Tertiary Label, what it does in Subheadline Secondary
    Label, then one choice in a 52 capsule (Grouped Background): One Habit and This Week choose a **Habit**, Today and
    Tasks a **Routine** (All of Today by default). *Widget option list (native)*, the page the choice opens: a sheet
    62 from the top with ✕ and the choice's name, rows 45 tall (a 29 coloured circle with the habit's symbol, the
    name, ✓ in Ink on the one shown), and Search at the bottom; Routine lists All of Today, All Day, the person's
    routines and Anytime, with no icons. **Reasoned, not read:** a new One Habit widget starts on the first habit on
    Today (the intent's default), so it's never empty; which of our widgets a size shows from the icon is the first
    in the app's list for that size (Small One Habit, Medium and Large Today).
  - [x] Android's launcher menu, edit frame, widget picker, app icon, icon menu, widgets sheet and the Widget setup
    screens deleted: none had a copy left once the flows were redrawn. The native components section is laid out
    again in two rows (it overlapped: the gallery sat on the symbols and the editing marks) and both component
    sections are sized to what they hold. The app icon component's artwork didn't scale, so every copy under 64 was a
    white square: it scales now (19 copies). Every "section" word on the page is "routine" (*Routine deleted · Tap to
    choose another*); searched again: no shown word says section, time of day, Plus or Android.
- [x] Every state and milestone boards at the new sizes. The every-state boards (One habit, Today and Tasks, This
  week) and the three milestone boards are laid out again: 32 between widgets, each caption the widget's width and
  16 under it, the Large widgets in a row of their own; the milestone boards' widgets were 3 apart and their names
  said 2 × 2 and 4 × 2. The list widget's header ended 8 past its rows: it lines up with them now, so › sits over the
  rows' buttons.
- [x] The flows, the iPhone's way and numbered after Settings (which ends at 257). Android's three (Add a widget, Add
  the Today widget from the app's icon, Change a widget) are deleted whole. **258 · Add a Widget** (7 screens): touch
  and hold the Home Screen, Edit, Add Widget, the gallery, Often Enough, Add Widget, Water on the Home Screen in edit
  mode, Done. **259 · Add a Widget from the App’s Icon** (3): touch and hold Often Enough, Medium, the Today widget
  where the icon was. **260 · Change a Widget** (6): touch and hold the widget, Edit “One Habit”, the card, Habit,
  Read, tap outside, Read on the Home Screen. Each step has its note, every screen is 402 × 874 and the Home Screen's
  own. Looked at every screen.
- [x] The other widgets' flows (11 Nov 2026, the user: "What about weekly widget and what about task list? … for adding
  today … pick any one size because it is duplicate … by default adding today. And adding any of the routine").
  One size each where a widget has two (Medium; the gallery note says Large is a page of its own). Each starts at
  the gallery's first page, its who note saying the steps before are 258's. **261 · Add the Today Widget** (4): swipe
  to Today, Add Widget, Done; it starts on All of Today. **262 · Show One Routine on the Today Widget** (6): touch and
  hold, Edit “Today”, the card's Routine, Morning, tap outside, Morning on the Home Screen. **263 · Add the This Week
  Widget** (4): it starts on Water; changing its habit is 260's way. **264 · Add the Tasks Widget** (4). The gallery's
  Today (Medium) page showed Morning: it shows All of Today now, what a new widget starts on. Looked at every screen.
