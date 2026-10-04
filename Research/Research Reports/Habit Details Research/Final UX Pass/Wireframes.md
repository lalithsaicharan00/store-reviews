# Habit Details — Proposed Screen Studies

Written by Codex (OpenAI), 4 October 2026. Read the [research and interaction handoff](README.md) before implementing these screens.

These are **editable Figma mockups and portable image exports**, not final iOS visuals. Native SwiftUI controls, system typography, semantic colors, light/dark appearance, Dynamic Type and VoiceOver are required in the app (Rulebook U1/U9). All dates, values, names and note text below are illustrative.

Editable boards: [header, History and Notes](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=433-2071), [type-aware recording](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=434-2071), and [Notes/quit edge states](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=443-2071). The PNGs are exports from individual editable frames; Figma remains the source for changing them.

## Header, History and navigation

### 01. Daily habit: chronology first

The navigation title identifies the page. The centered habit identity and two streak facts lead into the same existing month/day list. A persistent bottom action area supplies **Find a day** and **Log time manually**. The latter opens a record flow with Today selected; a date row opens Day details directly.

![Daily habit History](Images/history-daily.png)

### 02. Weekly goal: two-line supporting text and week streaks

The goal/time-section text wraps without touching the streak cards. Both streak cards say **weeks**; the weekly frequency is directly above. The History action names the fact being recorded.

![Weekly habit History with wrapping header](Images/history-weekly.png)

### 03. Find a day: select, then open; no logging on selection

The date picker can reach an empty old day. The helper explains that this opens **Day details** for the selected day. Today/Yesterday shortcuts are optional; month/year access and exact-date confirmation are required.

![Find a day](Images/find-a-day.png)

### 04. Quit habit: run language and neutral slip action

Quit habits use **Current run** and **Best run**, not a build-habit success streak label. A date without a recorded slip does not generate a fake History row. **Record slip** is available with neutral emphasis (U3/U16).

![Quit habit header and History](Images/quit-header.png)

## Notes: browse, search, read and edit

### 05. Notes list

Search is a full-width inline field immediately above the notes it filters. **Add note** has its own bottom action. The existing month/dated preview structure remains.

![Notes list](Images/notes-list.png)

### 06. No notes yet

No fabricated note rows. The empty state explains that notes are date-scoped and independent of progress; Add note stays available.

![Empty Notes tab](Images/notes-empty.png)

### 07. Search with no matches

The query and clear control remain visible. The empty result is different from a habit with no notes. Add note remains reachable when the keyboard is dismissed; the live keyboard layout needs native validation.

![Notes search with no matches](Images/notes-search-empty.png)

### 08. Note reader

The exact note date is prominent. Note text has a content-sized reading area. **Edit** is visible. **Open day details** is a related destination with the same date and context. Delete belongs to More, not a peer navigation row.

![Individual note reader](Images/note-reader.png)

### 09. Note editor

The selected date is visible before the multiline text field; Save commits a note for that date. A dirty Cancel must offer discard recovery. In native iOS, use the keyboard, field focus and actual date picker rather than copying this static specimen.

![Add or edit note](Images/note-editor.png)

### 10. More menu and deletion confirmation

The More menu scopes **Delete note** to this one note. Its confirmation states that the day's progress remains. Neither tapping More nor tapping the menu item removes data before confirmation.

![Note-reader More menu](Images/note-menu.png)

![Confirm deletion of one note](Images/note-delete-confirm.png)

## Recording for a selected day

The first four examples add one independent saved record. The tracking day defaults to Today and may be changed before Save. A past-date form preserves the selected day and describes logging time honestly. These forms share a date model; their value controls and wording follow the habit.

### 11. Amount, Today

`Add 1 glass` adds one new amount record. Existing records are context, not a total to overwrite. The summary's chevron is a route to inspect Day details, not an editor for the total.

![Record water today](Images/amount-today.png)

### 12. Amount, past day

The selected historical date stays visible. Saving now for 2 October must not pretend the water was consumed at the current save time.

![Record water for a past day](Images/amount-past.png)

### 13. Duration

Hours/minutes are a native input, not a passive label. This adds a distinct manual session; existing timer sessions remain separate. The one-record editor later corrects exact duration, including seconds where supported (U19).

![Record a duration](Images/duration.png)

### 14. Repeated check / weekly frequency

A count control adds to the selected day's count. The displayed weekly goal is context, not an invented same-day target. One bulk save remains one saved record.

![Record one call](Images/repeated-check.png)

### 15. Daily check and 16. Checklist

These are **route diagrams** for the selected date: use the already accepted Day-details sheet and its native check/step controls. Do not build the illustrated date row or a second check editor as another Day-details design. One daily check has a named Mark done/Undo; a checklist edits named steps.

![Once-daily check route](Images/daily-check.png)

![Checklist route](Images/checklist.png)

### 17. At-most amount and 18. Quit slip

The ability to record remains visible but neutral. An at-most goal does not encourage another cup. A slip captures its actual occurrence time; correcting its date/time later must move the same record and recompute the run (U16/U19).

![At-most amount record](Images/limit.png)

![Record a quit slip](Images/quit-slip.png)

### 19. Skipped day conflict

The usual recording controls remain visible but disabled while the selected day is skipped. **Undo skip** stays at the skip action's position in the actual Day-details design; logs and note remain visible there. This mockup illustrates the state rule and must not replace the approved Day-details layout (U15).

![Skipped selected day](Images/skipped-day.png)

## Image and source inventory

This page references **20 individual PNGs**. The editable Figma screen frames use SF Pro text and native Figma layers. The earlier [day-sheet and entry-editor handoff](<../../Day Structure and Organization/Day Details and Entry Editor Handoff/README.md>) remains the implementation reference for those two surfaces; the History and Notes flows link to them without redesigning them here.
