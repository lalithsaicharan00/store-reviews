# Progress Week — Visual Redesign

Written by Claude (Claude Code), 2 October 2026. Research and design only; implementation waits for the user's choice.

- [x] Start from newest `claude/server-and-sync`; create `claude/progress-week-research`.
- [x] Read root/research rules, Docs rule 3, Design Rules, performance rules, decided Progress spec and report.
- [x] Describe current overview, habit rows, quit rows and day marks exactly from current code.
- [x] Address visual density despite correct data; Week first, overview then habits then quit.
- [x] Give rows/card padding room; fix centred icons against multiline text.
- [x] Make marks understandable at a glance or explain them with a beautiful legend.
- [x] Make the overview attractive.
- [x] Preserve range tabs, period navigation, group chips and View Options exactly.
- [x] Preserve native iOS/system fonts/SF Symbols, light/dark and accessibility Dynamic Type.
- [x] Keep monochrome chrome, habit colours, shape-based states, neutral skipped/paused/unplanned days.
- [x] Keep weekly empty days neutral, limits unjudged until period end, read-only Progress, habits-not-ticks counts.
- [ ] Capture genuine demo before images: light, dark, accessibility, habits and quit scroll positions. **Partial:** newest CI supplies genuine light Week and grouped Week; no genuine dark/accessibility/quit-scroll capture is available. See report §1; no fabricated before images.
- [x] Search all three review corpora, multilingual scanners, with counts/denominators/IDs and audited evidence.
- [x] Inspect winning apps' App Store/Play listings and weekly/progress screenshots.
- [x] Inspect design references and Apple's patterns/HIG/accessibility.
- [x] Keep all third-party imagery gitignored in Research/Temp; cite source URLs.
- [x] Generate at least five distinct options, each overview/habits/quit, with 12–15 real demo habits and realistic states.
- [x] Render every option at 393 × 852 pt @3x: light, dark, large accessibility text; habit/marks close-ups.
- [x] Explain each option's answers, performance cost, VoiceOver/large text and risks.
- [x] Write comparison, recommendation and exact implementer spec (measurements/fonts/colours/copy/marks/overview/quit/VoiceOver).
- [x] Save report/images at requested paths; add report to research index.
- [x] Verify cited IDs, image layout, checklist and performance rules; no app code changes.
- [x] Add all researched inspirations, screenshots and source links to the supplied Figma Inspiration page using Figma MCP.
- [ ] Commit and push research deliverables only to `claude/progress-week-research`.
- [x] Prepare final delivery with options/images, recommendation and the user’s next decision.

Verification: all 662 source records and 42 cited review IDs checked against all three canonical stores; no duplicates/unassigned records/count mismatches. Fifteen render variants are 1179 × 2556 pixels with 14 cards and no horizontal overflow. Speed rules pass. Figma MCP read-back confirms 113 image-filled nodes, no empty slots, no layout overflow; native captions/source links and five option galleries are present. No app code changed. Large-text images are simulations; native accessibility/VoiceOver verification follows implementation.
