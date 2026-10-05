Written by Claude (Claude Code), 4 October 2026.

# Swipe Actions — Reveal, Never Act

**The user's question (4 Oct):** "If I swipe too much, it directly adds a note. I have to swipe very carefully to get all
three options. Maybe a swipe should just reveal the options, and the person taps one; maybe Skip should be on the
swipe instead of Undo. I'm not native to the iPhone: research how people expect swipes to work there, even with two or
three options, and implement it properly."

**Answer, in short:**
- **A swipe only reveals; it never performs an action, however far it goes.** People's most repeated swipe complaint is
  a swipe that did something they didn't mean, and two say exactly what the user saw: swipe a bit too far and the app
  acts on its own.
- **Two buttons a side at most, the most used at the edge.** Three buttons behind one swipe need a precise swipe; one
  reviewer left an app over it.
- **Swipe left: Skip (at the edge) and Note. Swipe right: Undo, named ("Undo +1 glass").** Skip on a left swipe is the
  arrangement people ask for and praise; Undo stays one swipe away because accidents need a way back. Pause moves to
  the long-press menu and the Day sheet, where it already was (U5: nothing is lost).

This revises 3 Oct's decision ([Today's Rows — Tap, Swipe, the Day Sheet and Delete](<Today's Rows — Tap, Swipe, the Day Sheet and Delete.md>)):
Note ran on a full swipe, chosen as the one harmless action. A note sheet opening by itself still surprised the person.

## How this was researched

- `Research/Temp/swipe2/scan.py` read all **1,238,784** reviews; **947** mention swiping. Five questions over them: a
  swipe that went too far or happened by accident (17), a swipe revealing options (23), Skip by swipe (31), Undo and
  swipes (12), left versus right (42). Every one was read; reviews about swiping between days or pages were set aside.
- The 3 Oct report's counts are kept (1,700 reviews read for rows, taps and swipes).
- How the iPhone's own lists behave (Mail, Reminders, Messages) and Apple's guidance on swipe actions.

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **A swipe did something by itself** (too far, while scrolling, by accident) | **≈15** | "If u swipe too much it will mark the whole thing complete" (`f90a6a78…`); "If I swipe too far, it'll automatically say I completed all instances" (`788bfc06…`); "I'd prefer to click on the action… rather than it happening automatically as I keep skipping or completing accidentally" (`9483180231`); "always accidentally swiping habits left or right when I'm just scrolling" (`6914338864`); to-do apps' swipes that deleted by accident (7) |
| **Skip by swipe, wanted or praised** | ≈15 | "swipe right when completed or swipe left to skip!" (`3026852113`); "swipe to the side and click skip" (`11859603797`); "Ability to swipe habits to the left to skip" (`9977984348`) |
| **A way back after a wrong swipe** | ≈7 | "Easy undo for accidental swipes" (`11733064263`); "If u swipe wrong there is no way to undo" (`10042846418`) |
| **Too many buttons behind one swipe** | 3 | "You have to swipe left just barely to get all the buttons to show up so you can skip it. I'm sick of trying to swipe exactly right" (`6152463760`, who deleted the app) |
| **Swipe actions nobody can find** | ≈4 (26 on 3 Oct) | "There's no hint or suggestion that swiping will get you those options" (`437a8053…`) |
| Left/right confusion | 5 | Skip and Done on opposite swipes get mixed up (`1779914961`, `5871313636`) |

**The iPhone's own lists:** in Mail and Reminders a swipe reveals labelled buttons, and a *full* swipe performs the
button at the edge (Mail's Trash, Reminders' Delete), with undo. That's where the accidental deletes in to-do apps
come from. Apple's guidance treats swipe actions as shortcuts for actions available elsewhere too, and asks for
destructive ones to be confirmed or undoable. A habit row's swipe actions are all available elsewhere (the Day sheet,
the long-press menu), so nothing needs the full-swipe shortcut.

## Decision (built 4 Oct 2026, branch `claude/timer-swipe-limits-and-fixes`)

| Swipe | Reveals | Basis |
|---|---|---|
| **Left** on a habit | **Skip** (Undo Skip once skipped) at the edge, then **Note**; a task shows Note only | Users show it: Skip by swipe (≈15), skip on the left (the common arrangement) |
| **Left** on a quit habit | **Log Slip** at the edge, then **Note** | U5: where the "Slipped" button was |
| **Right** | **Undo**, naming what it takes back, when the day has an entry | Users show it: a way back after accidents (≈7); U14 |
| **A full swipe, either side** | Nothing happens beyond revealing | Users show it: actions done by a swipe (≈15); the user's own report |
| **Pause / Resume** | Long-press menu and the Day sheet (no longer on the swipe) | Two buttons a side (`6152463760`); nothing removed (U5) |

**Checked:** `TodayRowSheetUITests.testSwipeActions` swipes all the way across and checks that only Skip and Note show,
Skip at the edge, both big enough to hit, and no note sheet opens; `TodayRowLayoutUITests.testQuitRowSwipeLogsASlip`.
The feel of the swipe is for the iPhone (U9).
