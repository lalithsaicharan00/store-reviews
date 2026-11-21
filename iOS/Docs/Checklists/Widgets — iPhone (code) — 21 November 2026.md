# Widgets — iPhone (code) — 21 November 2026

Written by Claude (Claude Code), 21 November 2026, at the user's request: "this is mostly the last thing, widgets …
earlier we used to have widgets as a plus, part of a plus. So we need to remove it now. It's not plus anymore. It's
free … check is all of the adding widgets and all of the screens are properly working, and make sure widgets should be
interactive … without any performance issues, syncing issues … step by step, thoroughly complete the task."

Figma: the iOS app file, *widgets components* (`1235:2`), *native components* (`1255:3030`: the gallery, Edit Widget
card, option lists, Home Screen menus) and the flows (`1236:2446`, `1241:489`, `1244:787`, `1245:394049`,
`1246:394207`, `1247:394597`, `1248:1967`). The design checklist is
[Widgets — iPhone — 10 November 2026](<Widgets — iPhone — 10 November 2026.md>). Branch `ios-update`.

**Locked (Rulebook U28):** how a tap shows, saves, syncs and what each button does stays exactly as
[Widgets — Taps and Updates (Locked)](<../Widgets — Taps and Updates (Locked).md>) says. Only words, looks and speed
work under its §8 change here.

## The user's points

- [x] 1. Widgets are free: no Plus anywhere in the widgets or their setup.
- [ ] 2. Adding a widget and every screen of it works (the gallery, Edit Widget, the choices).
- [ ] 3. Widgets stay interactive, with no performance or syncing problems.
- [ ] 4. Every state Figma draws is right.

## Steps

- [x] Gallery and Edit Widget words from Figma (names, descriptions, Habit and Routine choices, a default habit);
  the snapshot's unused Plus flag removed
- [ ] One Habit (Small): Habit and Message
- [ ] Today (Medium, Large): List and Message, the list row and its fill
- [ ] Tasks (Medium, Large)
- [ ] This Week (Medium): Habit and Message
- [ ] Adding on the Simulator: the gallery, Edit Widget, the option lists
- [ ] Interactive: ✓, +1, ▶ on the Home Screen; the app and the widget agree; nothing lost
- [ ] Speed: the widget scenarios; nothing slower

## Left for the logic pass

- **Figma's "Couldn’t save · Check in the app" (One Habit) has no state in the code:** a widget can't know a save
  failed. It needs the app to write that into the snapshot, which touches the locked flow (U28): the user's call.
- **Lock Screen widgets** (inline, circular, rectangular, Lock Today) aren't in Figma; kept as they are.
- Still to check (stopped at the usage limit, 21 Nov 2026): the adding flows (1245:394049, 1246:394207,
  1247:394597, 1248:1967) against the Simulator, every state in light and dark on the Home Screen, ✓ +1 ▶ taps,
  the UI tests' changed words (T3), the Rulebook note.

## What was done

- **Plus:** the snapshot's unused `plus` flag is gone; nothing in the widgets was gated.
- **Words from Figma:** gallery names and descriptions, Routine (All of Today first, the default), the first habit
  by default, and the message cards (Tap to choose, Habit removed, Start one in the app, Routine deleted · Tap to
  choose another, Tap to choose the habit this widget shows).
- **Looks from Figma (views only; the switch, intents and touch regions untouched):** One Habit (40 icon, 34 round
  button, Body name, Subheadline status, quit run as the grey status line, 8 bar on System Fill, band), the lists
  (header, solid count pill so the locked header patch still covers it, rows, spacing), This Week (grey cards,
  44 icon, Title 2 number, Caption 2 Semibold days, the message card).
- **Checked on the Simulator:** One Habit added from the app icon's menu (iOS 26), starts on the first habit.
