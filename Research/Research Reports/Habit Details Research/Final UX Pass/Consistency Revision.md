# Habit Details — Consistency Revision

Written by Codex (OpenAI), 4 October 2026.

**Status:** Revised research and editable layout proposal after the user's rejection of the previous follow-up. This version has not yet been accepted by the user or implemented on an iPhone. The accepted references remain [Day details, 370:2031](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=370-2031) and [the single-record editor, 408:2071](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=408-2071).

Read the [interaction handoff](README.md) and [22 illustrated screens](Wireframes.md) together. The same three Figma boards were updated in place. No competing redesign of the accepted Day sheet was added.

## Why the previous revision was insufficient

Removing the tab-dependent bottom bar and changing labels solved only part of the problem. Blue creation buttons still introduced a second chrome palette. New-record forms had large, unbounded numbers or a passive-looking duration display, although the accepted editor already established bounded numeric fields and typeable H/M/S fields. Dates, notes and toolbars looked different between routes. A general claim that they “follow the editor” did not demonstrate consistent controls.

The user's repeated brief and current-app screenshots at [420:2107](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=420-2107) are the scope for this revision: the habit header, History date/record actions, Notes creation/search, and individual note pages. Rulebook U2 establishes monochrome chrome. U19 establishes the value and occurrence-time controls. U21 preserves the route model. New U22 makes the shared-control requirement explicit.

## Research: evidence versus design inference

| Input | What it supports | What it does not establish |
|---|---|---|
| [Original History research](<../Original Reports/Day Structure and Organization/Habit History — Research and Recommended Layout.md>) and its linked correction evidence | Older and empty dates must remain reachable; a day opens Day details; one wrong amount/time record needs exact correction. | Review themes do not select a particular toolbar position or button color. No new corpus percentages were calculated here. |
| [Original Notes research](<../Original Reports/Day Structure and Organization/Habit Notes — Research and Recommended Experience.md>) and its verified review index | Dated notes, habit context, visible writing/editing access and retrieval matter. Notes remain independent of progress. Its existing-note baseline keeps the saved date fixed. | It does not measure preference for Add note above or below Search. The earlier sample is purposive, not a population estimate. |
| [NN/g: consistency and standards](https://www.nngroup.com/articles/consistency-and-standards/) | Reusing visual treatment, action placement and field conventions reduces relearning between related flows. | It does not prescribe this app's palette, exact gaps or specific CTA labels. Those come from the app's accepted patterns and user feedback. |
| [Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons) and [toolbars](https://developer.apple.com/design/human-interface-guidelines/toolbars) | Recognizable actions, appropriate native sizing and logical groups. A 44 pt hit region is the accessibility baseline used in these studies. | A hit-area baseline is not a mandate to draw every visible button at exactly 44 pt in every accessibility size. |
| [Apple: search](https://developer.apple.com/videos/play/wwdc2026/292/) and [pickers](https://developer.apple.com/design/human-interface-guidelines/pickers) | Inline search can serve its nearby content; compact date/time values can open native selection controls. | A static calendar illustration is not an implemented native picker. |

The research reinforces the existing model. It does not justify replacing the accepted sheets. Placement below is a reasoned proposal informed by the browsing task and the user's direct review, with device/usability validation still outstanding.

## What changed and why

| Surface | Concrete revision | Reason |
|---|---|---|
| Shared header | Native toolbar proxy titled **Habit details**. Center saved icon → name → wrapping goal/time section; Current/Best streak or run facts below. | The page name identifies the destination; the identity identifies the habit. Goal units explain streak units. Centering is specific to this page, as requested; Day details keeps its accepted leading identity card. |
| History actions | Two compact controls within History's scroll content: **Open day…** and a fixed type-based recording label. Both have equal 44 pt targets in the default study. Build-goal recording has monochrome prominence; date access and quit/limit recording are neutral. | “Open day” communicates the destination. A full-width pair of oversized CTAs dominated the old page. A changing page-wide footer assigned page ownership to tabs that do not have separate pages. |
| History date | Picker explains that it opens this habit's Day details, showing logs when present and an empty day otherwise. | Resolves the ambiguous Go to Date destination without claiming it creates a record. |
| Record creation | Reuse the accepted editor's leading habit card, Cancel/title/Save toolbar, bounded number+unit fields, H/M/S fields and slip date/time controls. | The same fact should be entered and corrected using the same recognizable control. The added date row is the creation-specific difference. |
| Duration | Hours, minutes and seconds are visibly separate fields; tap a value to type. Fractional seconds remain supported where the record model permits them. | Matches the accepted precision/editor decision; removes the unrelated passive wheel-like display. Duration is elapsed time, not a time of day. |
| Notes tab | Full-width Search first, then a leading **＋ Add note** text button on a separate aligned row, then the dated list. Same locations in empty/search states. | Search keeps all available width. Creation is visible without competing for the search field's horizontal space or becoming an oversized primary card. The duplicated Notes section heading was removed. |
| Note reader | Shared leading habit card, full date, readable text; Edit note immediately after the text and a separate trailing More target. Exact-date Day details appears as a related section. | Transfers the editor's visual language while retaining reading as the task. Edit is near its object; destructive deletion is not a peer navigation row. |
| Note editors | Same toolbar, identity card, date context and multiline note surface. New note can select a date. Existing note's date is fixed. Existing editor retains a bottom Delete note button without a divider; reader More and editor Delete both confirm. | Prevents accidental note relocation or silent overwriting and preserves the accepted deletion/recovery model. |

### Options deliberately set aside

- **A page-wide bottom CTA that changes by tab:** rejected in the earlier user review; these tabs share a page.
- **A new page-level plus menu for both records and notes:** would add an unrequested decision and hide the direct type-based action. Existing management More keeps its management scope.
- **Add note beside Search or in a prominent filled card:** crowds retrieval or gives creation disproportionate weight. A separate aligned text action keeps it available.
- **Rebuilding Day details for binary/checklist/task actions:** would duplicate existing correction controls. The recording board instead shows the accepted Day-details routes.
- **A different input system for adding versus editing time:** would require learning two controls for the same elapsed-time value.

## One route model across surfaces

1. History row → exact selected **Day details** → a saved amount/time/count/slip record → accepted single-record editor.
2. **Open day…** → date selection → exact Day details, including an empty date. Choosing a date does not write progress.
3. History type-based record action → unsaved form, Today by default → change Date if needed → **Use date** returns to the form → Save adds one separate record.
4. A daily binary check, checklist or task uses Day details directly. It does not get an artificial single-item “entry” form.
5. Notes → reader → Edit note → existing-note editor. Add note → new-note editor; choosing a date with an existing note opens that text instead of silently replacing it.
6. Note reader's **Open day details** passes the note's exact date. Deleting a note preserves that day's progress.

Skip remains the accepted state: logging stays visible and disabled, notes stay editable, and Undo skip stays where Skip was. An add-record route must respect the selected day's state. The date helper is not permission to bypass a skipped, paused or invalid date.

## Native implementation and spacing

These are layout representations, **not final custom control artwork**. Use SwiftUI navigation/toolbar actions, Button, TextField, TextEditor, Menu, DatePicker and native alert/confirmation presentation. Use the saved habit's actual SF Symbol and color; the drawn status bar and symbol glyphs are placeholders. Chrome uses the app's semantic ink across all routes, with native destructive semantics and the existing switch/selection exceptions from U2. Do not copy a default blue accent into these new surfaces.

The studies reuse the accepted editor's card/value geometry and semantic day-sheet variables. Shared local Figma components link identity cards, toolbars, amount/count/duration/slip fields, compact date context and note inputs. The native SwiftUI implementation should reuse its existing views/tokens where appropriate.

Default layout relationships: 8–12 pt within a related group; 24 pt between identity, date/value groups, tabs and tab content; 28–32 pt before separate context or related-day sections. Header-to-supporting-copy stays closer than support-to-streaks. These are outside gaps, not enlarged card padding. Use the accepted editor's established internal padding. Dynamic Type and localized labels can grow or stack the controls; do not enforce a small fixed height when it clips content. Long notes and dated lists scroll; the keyboard must leave the current editing line and Save reachable.

Keep the existing note-length behavior truthful: if the current 1,000-character limit remains, disclose it as the limit approaches, do not silently truncate. Empty Save must not secretly delete an existing note; the explicit confirmed Delete route remains available.

## Verification and remaining work

The three boards contain 22 screens made of editable text, frames and component instances. Structure checks found SF Pro throughout and no image-filled complete-screen nodes. Chrome was checked for unintended blue, and the composition review repaired clipping, button-label geometry and spacing. All 22 local PNGs were refreshed from Figma; the [export manifest](<Export Manifest.json>) records frame IDs, dimensions and hashes.

Documentation checks passed: 8 Markdown files, 300 local links, all 22 image embeds, PNG dimensions/decoding and manifest hashes; no broken links. Git whitespace validation and the repository speed-rules check passed. This documentation-only publication uses an untagged commit under Rulebook T10; no iOS test dispatch is required.

This verifies the research/mockup handoff only. Native picker behavior, keyboard focus, note conflicts, history rules, accessibility, localization, light/dark and saving/deletion still require implementation and real-iPhone validation. The user has not yet approved this revised proposal.
