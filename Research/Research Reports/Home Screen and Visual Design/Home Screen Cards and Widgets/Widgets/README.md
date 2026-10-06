# Widgets — start here

Written by Codex, 6 October 2026. Consolidated research, design and implementation handoff for **Current Work item 9**.

**Current design:** Small Today cards with SF Pro **12 pt Medium supporting labels**, one action, six explicit setup/recovery states; Large Today/selected section with **at most five progress-filled rows**; Medium Today/selected section with **two progress-filled rows**, reducing to one in the larger-text study. Neutral CTAs become habit-colored only on genuine positive completion. These are Figma/artifact deliveries; native changes and physical-iPhone acceptance remain pending.

All widget-specific reports, original review evidence, design images and implementation history now live in this folder. Repository policy, canonical work checklists and reusable verification tools remain in their prescribed locations and are linked below. Do not create another competing widget spec outside this package.

## Agent reading order

1. Read the repository [Rulebook](<../../../../../RULEBOOK.md>) and [CLAUDE.md](<../../../../../CLAUDE.md>) in full. Policy lives there, particularly U1/U2/U9/U13/U14/U25, D7/D10/D11, S3/S5/S16, T7/T10 and W1–W5.
2. Read [History and Current Implementation](<History and Current Implementation.md>) to understand the original problem, what superseded what, and the current native gaps.
3. Read [Accepted Widget Contract](<Accepted Widget Contract.md>) for the cross-family implementation contract and routes. Then read the applicable family handoff linked below.
4. Inspect the final family images and Figma IDs; use the latest dated corrections rather than historical examples. Each manifest records node ID, dimensions, byte count and SHA-256.
5. Track work in [Current Work item 9](<../../../../../iOS/Docs/Checklists/Current Work Checklist.md>) and the [request checklists](<Request Checklist Index.md>). Keep item 9 open until the native work and required tests are complete; record the phone check separately.
6. Run the [delivery verifiers](<../../../../Tools/widget_catalogue/README.md>) before changing/publishing artifact evidence. Native code needs its own tests, performance checks and device evidence.

## Current family references

| Family | Exact reference | Images | Figma |
|---|---|---|---|
| Small Today | [Daily Cards](<Daily Cards/README.md>), [final typography and states](<Daily Cards/Final Typography and Recovery — 6 October 2026.md>) | [48 final exports](<Daily Cards/Images/README.md>) | [Small section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=537-2981) |
| Large Today / selected section | [Five-item layout and implementation](<Today List/Large Designs — 6 October 2026/Layout and Implementation Handoff.md>) | [20 exports](<Today List/Large Designs — 6 October 2026/Images/README.md>) | [Large section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=585-4698) |
| Medium Today / selected section | [Two-item layout and implementation](<Today List/Medium Designs — 6 October 2026/Layout and Implementation Handoff.md>) | [26 exports](<Today List/Medium Designs — 6 October 2026/Images/README.md>) | [Medium section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=622-6436) |
| Original free/Plus catalogue | [Research](<iPhone Widgets — Types, Native Setup and Free vs Plus.md>), [proposal handoff](<Implementation Handoff.md>) | [26 individual historical concepts](<Images/README.md>), [Free board](<Free Widgets.png>), [Paid board](<Paid Widgets.png>) | [Free](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3114), [Plus](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3116) |

The original catalogue is useful for research, setup, optional surfaces and pricing proposals. Its small/list aesthetics do **not** override the accepted family references. Plain/six-row Large drafts are rejected. Small supporting 13 pt Semibold and 11 pt Regular treatments are superseded by 12 pt Medium. A primary status heading remains a heading; this correction targets supporting progress/state labels, not every line of type.

## Evidence and limitations

The [181-original audit](<Verified Review Sources.json>), [full review index](<Verified Review Index.md>) and [inventory summary](<Scan and Verification Summary.json>) distinguish machine inventory, selected manual audit and attributed earlier research (W2). The lexical inventory is not a population preference study. Android opinions do not prove iOS preference; missing historical coding remains disclosed. The [Daily audit](<Daily Cards/Review Audit.md>) and [Today-list research](<Today List/README.md>) carry their own scopes.

The [1 October report and originals](<Historical Research/iPhone Widgets — Research and Implementation.md>) and [Native Integration and Release](<Native Integration and Release.md>) preserve source behavior, historical test runs, performance limitations and the physical-phone matrix. Read dated source claims with their recorded revision. The [publication validation](<Publication Validation.md>) explains what this delivery actually verified.

Five free habits is an allowance for unarchived habits at a time, **not five habits per week**. The free/Plus boundary in the original catalogue remains a proposal; reliable basic logging, safe recovery and retained data are not upgrade friction. Do not infer pricing approval from Figma delivery.
