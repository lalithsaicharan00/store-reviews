# Habit Details Research

Written by Codex, 3 October 2026. **Start here for individual habit details information architecture, History/logs, Notes and Progress/statistics.** This is the canonical research package for the five Figma studies in this conversation. It includes unchanged original reports, evidence, individual screen PNGs, full board PNGs and illustrated companions.

**Mockup status: schematic layout and content study only. Habit names, dates, values and note text are dummy/illustrative data. These are not final visual designs. Final visuals need substantial polish: typography, spacing, hierarchy, colors, chart labels, accessibility, native interaction and all states. No usability test or wired interaction prototype is implied.**

**4 October follow-up:** Start with the [final UX pass for the header, History actions, recording and Notes](<Final UX Pass/README.md>) when working on these surfaces. It has 20 newer, individual image exports and three editable Figma boards. It supersedes the earlier top-of-History action placement, generic Add Entry wording, split Search/Add Note row and note-reader View Day/Delete rows. The original History chronology and Progress tab direction below still apply. This remains a representative interaction proposal; iOS implementation and device validation are outstanding.

## Current direction and version precedence

| Area | Current direction | Earlier version retained | Read next |
|---|---|---|---|
| Information architecture | Three separate jobs/tabs: History, Notes, Progress; small shared header; top-right habit management menu | Initial content skeleton, including provisional calendar-first History and generic Progress placeholders | [Information Architecture with mockups](<Illustrated Reports/Information Architecture — Research With Mockups.md>) |
| History / logs / entries | **Newest-first meaningful-day list → day → exact entry correction** remains; [4 Oct follow-up](<Final UX Pass/README.md>) revises header, actions, direct-date explanation and type-specific recording | Original calendar-first History from the IA board; top-of-list Add Entry/Go to Date controls | [Final UX pass](<Final UX Pass/README.md>) and [original/revised History](<Illustrated Reports/History — Original and Revised Mockups.md>) |
| Notes | Dated browse → read → edit, independent of completion; [4 Oct follow-up](<Final UX Pass/README.md>) separates full-width search and Add note, clarifies the related-day link and deletion scope | IA Notes skeleton and top split Search/Add Note row | [Final UX pass](<Final UX Pass/README.md>) and [earlier Notes study](<Illustrated Reports/Notes — Research With Mockups.md>) |
| Progress / statistics | **We are going with the revised open Week/Month/Year sections, visible Overall record and milestone summary, actual inline charts/comparisons** | Original second-range-control and label-only navigation-row layout | [Revised Progress with mockups](<Illustrated Reports/Progress — Revised Research With Mockups.md>) |
| Original statistics and type contracts | Preserve factual/historical-rule/coverage/share requirements unless explicitly superseded | Six original examples retained, including quit/cut-down/share | [Original Progress with mockups](<Illustrated Reports/Progress — Original Research With Mockups.md>) |

“Current direction” identifies the requested design baseline and version to continue, **not a claim that visuals, metrics policy or usability have been validated**. This package is research documentation, not a replacement for the formal decisions document in Notion. When earlier prose or an archived image conflicts with the follow-up on visibility/order, follow the revised companion and original follow-up report. Do not silently apply old chart placeholders or generic goal semantics to every habit type.

## Folder map

| Folder/file | Purpose |
|---|---|
| `Original Reports/` | Six report/evidence Markdown files preserved byte-for-byte, plus their original evidence directories. Topic nesting preserves internal relative links. Small clearly labeled Reference Link pages route unchanged report citations to existing secondary repository sources. |
| `Illustrated Reports/` | Five additional reports, each with embedded local individual screen images, screen-by-screen behavior, limitations, source links and a full board overview. These supplement the original reports. |
| `Mockups/` | 29 permanent local PNG exports: 5 full boards + 24 individual screens or type panels, with [export provenance and hashes](<Mockups/Export Manifest.json>). Markdown embeds these files directly; no expiring Figma asset URLs are required. |
| `Evidence/` | [Portable review source index](<Evidence/Source Index.md>), original integrity hashes, source verification and illustrative Progress fixture. Historical absolute paths remain untouched in original documents. |
| `Final UX Pass/` | [4 Oct research and interaction handoff](<Final UX Pass/README.md>), [20 individual Markdown image exports](<Final UX Pass/Wireframes.md>) and three editable Figma boards for the header, History actions, date/record flows, Notes reader/editor and edge states. Supersedes earlier action placement and labels, not the History chronology or Progress study. |

## Unchanged originals

- [Habit Details — Information Architecture Research](<Original Reports/Day Structure and Organization/Habit Details — Information Architecture Research.md>)
- [Habit Details — Verified Evidence](<Original Reports/Day Structure and Organization/Habit Details — Verified Evidence.md>)
- [Habit History — Research and Recommended Layout](<Original Reports/Day Structure and Organization/Habit History — Research and Recommended Layout.md>)
- [Habit Notes — Research and Recommended Experience](<Original Reports/Day Structure and Organization/Habit Notes — Research and Recommended Experience.md>)
- [Individual Habit Progress — Research and Recommended Experience](<Original Reports/Progress and Statistics/Individual Habit Progress — Research and Recommended Experience.md>)
- [Individual Habit Progress — Visibility, Comparisons and Milestones](<Original Reports/Progress and Statistics/Individual Habit Progress — Visibility, Comparisons and Milestones.md>)

## Figma study map

| Study | Board | Status |
|---|---|---|
| Information architecture | [317:133](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=317-133) | Architecture accepted; its initial History/Progress content is superseded |
| Focused History | [327:194](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-194) | Current History direction |
| Focused Notes | [337:276](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=337-276) | Current Notes recommendation |
| Original Progress | [345:306](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=345-306) | Earlier layout; factual contracts still useful |
| Revised Progress | [357:1531](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=357-1531) | Current Progress layout direction |
| 4 Oct header, History and Notes | [433:2071](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=433-2071) | Current action-placement and naming proposal |
| 4 Oct type-aware recording | [434:2071](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=434-2071) | Today/past record forms and Day-details routes |
| 4 Oct Notes/quit edge states | [443:2071](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=443-2071) | Empty/search Notes, quit runs, note menu and delete confirmation |

The five original boards and three 4 October follow-up boards are on inspiration page `234:2`. Their images capture the dated versions in their respective handoffs; later Figma edits require new exports. The live editable source is authoritative for a node’s latest appearance, while this package preserves the documented research versions.

## Instructions for the next agent

Start with this README and the [4 October final UX pass](<Final UX Pass/README.md>) for header/History actions/Notes, then read the relevant illustrated report, unchanged original and evidence. Continue from the revised History chronology and Progress direction. Keep facts to recorded data plus transparent totals/counts; exclude strength scores, predictions, estimated money saved and health claims. Keep no entry, explicit zero, partial result, skipped/paused state, future day and nonexistent calendar date distinguishable. Respect actual daily/weekly/monthly/total goals, historical rule/unit changes and recording coverage. Quit/cut-down cannot inherit build-habit success labels blindly.

The original reports contain dated read-only code/branch audits. Treat them as historical observations and inspect current main before implementation. No app implementation or interaction testing was performed for this documentation task. Polish the final visuals and validate task success, date accuracy, historical corrections, keyboard/draft recovery, accessible cell selection, comparison cutoffs and sharing before treating mockups as finished screens.

Suggested prompt: “Read `Research/Research Reports/Habit Details Research/README.md`, then the illustrated and original report for the area you are changing. Use the revised History/Progress direction, preserve the factual contracts and polish the visuals rather than copy the dummy mockup literally.”
