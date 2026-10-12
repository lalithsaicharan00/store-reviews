# Android Designs — Handoff

Written by Claude (Claude Code), 12 October 2026, at the user's request, so the Android design work can continue in a
new session on the user's MacBook (with the iPhone simulator). Read [Android — Start Here](<README.md>) first (decisions
A1–A12), then this page.

## Where the designs are

Figma file `Ncccsm1l2O62GJ5xLSInqk` ("Design"), page **Andriod mobile** (`1241:2`):
<https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1241-2>. Each screen lives in a **named section**,
left to right in the order a person reaches it (the user, 12 Oct 2026: "arrange everything properly in a section").

| Section (id) | Frames (id) | State |
|---|---|---|
| **Today** (`1260:2`) | Today, light, 360 × 800 (`1246:2`); the day bar in four day states (`1256:6`) | Approved |
| **Day details** (`1260:3`) | Day details · Water, a bottom sheet over dimmed Today (`1258:2`) | Approved ("this is looking good") |
| **Logs: add, all, view, delete, edit** (`1261:290`) | Add log (`1261:2`), All logs (`1261:83`), Log (`1261:120`), Delete confirmation (`1261:162`), Edit log (`1261:213`) | Built, not yet reviewed by the user |

## The reference is the built iPhone app, not Figma

**The user, 12 Oct 2026:** "take the developed app as a reference … in Figma we might have outdated designs." The
Figma iPhone, iPad and redesign frames (and `Research/…/Day Details, Logs and Notes — 7 October Redesign/Images`) can
be out of date. Before designing each Android screen, open the same screen in the built app on the iPhone simulator
and match its content, order, words and rules; change only what Android does differently. The user chose to run the
simulator on their MacBook for this (12 Oct 2026; Rulebook T1 otherwise keeps builds off it, for the battery, so keep
it on the charger). A Debug launch with no arguments adds the sample habits (T14); `-uitest` runs on its own in-memory
database (D8). `iOS/HabitsUITests/DayDetailsScreenshotUITests.swift` shows how the app's own tests reach each screen.

## Decisions made while designing (the user, 12 Oct 2026)

- **Completely native Android, Material 3 (Expressive, as on Android 16); the ideas exactly the iPhone's.** "Our app
  should feel like an official material design app … the overall ideas … we will keep what we have exactly in the
  iPhone."
- **Light only.** No dark versions: native components make dark mode automatic ("it's not a custom design … we are
  using native things").
- **Small screen first:** 360 × 800 (status bar 36, gesture navigation 24 at the bottom, a camera hole).
- **Today's top app bar: ≡ · Edit (pencil) · Filter · +**, no title. + is in the top bar, **not a floating action
  button** (the FAB beside the day bar was rejected: "not looking good").
- **The day bar is Material's floating toolbar** (`HorizontalFloatingToolbar`, version B, chosen over a docked
  full-width bar), at Google's standard size from the component's code: **64 high, fully rounded, 8 padding at the
  ends, 4 between items, 48 × 48 arrows, 16 above the gesture area**; 320 wide; white with a hairline edge and a
  shadow (Google's default is grey with no shadow: kept white because the user wanted it "easily noticeable"); a soft
  fade behind it (Android's gradient protection).
- **The day bar never shifts** when the day changes (the user: "the layout shift … looks ugly"): ‹ and ›, the ring
  and the count each keep a fixed place (the count's slot fits "13/13"); only the day name changes, centred between
  them ("Today", "Yesterday", "Tomorrow", "Wed, 30 Sep"). Stricter than the iPhone's `DayLabel` (`.frame(width: 196)`).
- **Cards are Android 16's segmented lists:** each row its own white piece, 2 apart, outer corners 20, inner 4, on a
  `#F0F0F3` background, 16 from the screen's sides, 12 between cards.
- **Rows:** 72 high (Material's two-line item); a round 40 habit icon in the habit's colour (round, not the iPhone's
  rounded square); name 16 / line 14; streak with a filled flame; a 40 round button (tonal grey, or filled in the
  habit's colour when the goal is met); the progress fill in a light tint of the habit's colour.
- **Section headers:** name 16 Medium, "Starts 6 AM" 12; "N left"; ▶ Start (filled ink for the Now section, tonal
  grey otherwise); ⌃/⌄. Folded: the habit icons (24) and "+N".
- **Day details is a modal bottom sheet** (drag handle, corners 28) with **✕ at the start, the title, ⋮ at the end**
  (Android's placement); the iPhone's content (habit ›, This day card with +1 | Log manually and the note, Today's logs
  with at most three rows, Skip today last and outlined).
- **Add / Edit screens:** ✕ and a one-line title; Habit, Date, Time as segmented rows with tonal pill buttons that
  open Android's date and time pickers; the amount large in its own card; the filled main button full width just
  above the keyboard (drawn as Gboard's number pad). **Log view:** ← back, **Delete log (red text on grey) | Edit
  (filled)** at the bottom. **Delete** asks in Material's dialog (Cancel, Delete log in red).
- **Type and icons:** Roboto (Regular, Medium); Material Symbols Rounded for outline chrome icons, Material Icons Round
  for filled ones (habit icons, the flame, ▶ ✓ + in round buttons). Ink `#1C1B1F`, secondary text `#5E5E62`, tonal
  `#ECECEF`/`#E6E6EA`, error red `#B3261E`. Chrome stays black, white and grey; colour is for habits (U2, decision A11's
  D5: no wallpaper colours).

## How we work on these (the user's standing preferences)

- Design **one** screen, show it, get approval, then the variants (one example first).
- Every screen goes into its own named section on the page; nothing loose on the canvas, no explanatory labels on it.
- Settle layout questions from the native platform's own patterns (Google's apps, Material docs, the Compose
  component's defaults) and say which; check Google's documentation when a size or pattern is questioned ("is it a
  standard pattern or something we are creating?").
- Before using the Figma tools: load the `figma-use` skill, then `create_session` with the file key.

## What's left, in order

1. **Notes:** Add note, Note (view, Delete note | Edit), Edit note. *(Was about to start; check the built app's note
   screens first.)*
2. **Day details for every other kind:** time habit (Start timer | Log manually; timer running), check once a day,
   check several times a day, week and month goals, N days a week, checklist (Tick steps), quit (no slips, a slip, Add
   slip, Slip view, Edit slip), a limit, a task (Mark done, Reschedule), and the day states (skipped, paused, an earlier
   day).
3. **New (+):** the choices, then the habit form.
4. **The ≡ menu** as Material's navigation drawer.
5. **The routine player and the timer.**
6. **Habit details:** Progress, History and Notes tabs.
7. **Progress.**
8. **Settings pages:** Times of Day, Day and Week, Reminders (with the reminder check, A11 D1–D2), Appearance, Google
   Drive & Backup (the sync line and status, A7), Privacy & Security and App Lock, Plus, Help & Feedback, About.
9. **Welcome and an empty Today.**
10. **Widgets** (Glance; the locked widget principles, U26/U28).
11. Then the larger phone (412 wide) for the screens that need it, and the tablet layout (A11 D9).
