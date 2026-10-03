# Habit History — Original and Revised Mockups

Written by Codex, 3 October 2026. Illustrated companion; the original research text is preserved separately.

**Mockup status: schematic layout and content study only. Habit names, dates, values and note text are dummy/illustrative data. These are not final visual designs. Final visuals need substantial polish: typography, spacing, hierarchy, colors, chart labels, accessibility, native interaction and all states. No usability test or wired interaction prototype is implied.**

**Version status:** **Current direction: use the revised chronological History flow from board 327:194.** Earlier calendar-first History from 317:133 remains archived below. History is the working label; exact naming and visual design still need validation.

[Unchanged original research report](<../Original Reports/Day Structure and Organization/Habit History — Research and Recommended Layout.md>) · [Full Figma study](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-194).

Recent corrections should be easy without restricting old dates. Show newest-first meaningful-day rows grouped by month/year; keep Go to date and Add entry visible. A meaningful day can contain entries, an explicit saved status or a note. Do not manufacture empty dates as missed rows. Direct date access still opens an unlogged past day. The assumption that most edits occur within a week is plausible, not established by review frequency.

## Original calendar-first History — superseded

Retained for the research trail. This is the earlier architectural History proposal. **We are going with the revised list below.** Its calendar mechanism can inform the date chooser but is not the main History feed.

![Schematic Original calendar-first History — superseded](<../Mockups/Information Architecture/Original History.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=317-164).

## Revised History — recent meaningful dates

One row per meaningful date, descending chronology, with month/year headings, actual total/status, entry count and optional note indicator. October 1 is absent because no record exists; September remains open near the boundary. Go to date must directly reach any permitted date and year. No default nested year/month accordions or seven-day edit gate.

![Schematic Revised History — recent meaningful dates](<../Mockups/History/Recent History.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-213).

## Inspect one day

A date opens shared habit Day details. Separate 300 ml and 400 ml entries remain visible; correction acts on one saved entry. The day note is independent. Previous/next day helps nearby corrections without repeatedly returning to the list. Navigation and reading must not mutate progress.

![Schematic Inspect one day](<../Mockups/History/Inspect One Day.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-356).

## Change one value

Changing 300 ml to 250 ml yields a 650 ml day total while preserving the 400 ml entry, identity and day note. Edit/Remove are explicit. The visible Date row is a proposed capability: generic cross-date moves are not supported by the audited store and need implementation work. Logged-at metadata must not imply actual behavior time.

![Schematic Change one value](<../Mockups/History/Change One Value.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-403).

## Reach an unlogged past day

Go to date opens the exact selected date even without a feed row. Offer Add entry and Add day note. No entries recorded is not proof of failure. Neither a current-month gate nor a nearest-logged-day substitution is acceptable.

![Schematic Reach an unlogged past day](<../Mockups/History/Unlogged Past Day.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-509).

## Repeated checks

Two saved +1 entries can each be undone. Remove only the accidental second record; do not clear the whole day.

![Schematic Repeated checks](<../Mockups/History/Repeated Checks.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-559).

## Bulk count

A saved count of five can be one record. Display 5 times · 1 entry, allow count editing and whole-record undo, and never invent five timestamped taps.

![Schematic Bulk count](<../Mockups/History/Bulk Count.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-570).

## Duration entries

Timer and manual sessions remain individual records. A backfilled session says when it was added; generic created-at is not happened-at. Correct or remove one duration while retaining the others.

![Schematic Duration entries](<../Mockups/History/Duration Entries.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-577).

## Checklist and quit entries

Undo the named checklist step or the exact mistaken slip. Slip time can be an entered event time. Do not synthesize no-slip daily rows. Corrected totals, streaks and milestones must agree with remaining records.

![Schematic Checklist and quit entries](<../Mockups/History/Checklist and Quit Entries.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-588).

## Full study board

![Full research board](<../Mockups/History/Study Board.png>)

The original History report preserves 139 checked originals, 16 diagnostic ledger cards, secondary Undo counts and official adjacent-app documentation. Correction restore semantics, list/calendar usability, label comprehension and generic date moves remain open implementation/validation work.

[Package index and current direction](<../README.md>).
