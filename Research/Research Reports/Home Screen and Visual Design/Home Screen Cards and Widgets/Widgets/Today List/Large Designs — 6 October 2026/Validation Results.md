# Final design verification — 6 October 2026

Written by Codex. Design/artifact checks only; native acceptance remains open under U9.

`verify_large_today.py` passed: 16 scenario components, 18 review instances, 67 rows; maximum five items per page, 12-point row gaps, 10-point header gap, equal 16-point insets, no row overflow and no action regions below 44 points. All explicit habit symbols, CTA actions and completion-color bindings match the saved role contract. Six/twelve/sixteen-item paging is 5+1 / 5+5+2 / 5+5+5+1. The original six-row and plain comparison roots are absent from the active section.

Twenty Large PNGs pass dimension, byte-size, SHA-256 and chunk-CRC checks. Thirty-six single-habit CTA cards pass neutral/completed binding checks, including the actual +500 saved-step label. The period-goal example has only its genuinely completed daily row filled; no period-only goal is converted to a daily target. [Progress Fill Audit.json](<Progress Fill Audit.json>) records the visible fill geometry/opacity for every review instance. The retained Q46 map reproduces 446 uncapped/nonduplicate OWN statements, 247 at most five and 283 at most six; this is historical coding arithmetic, not population evidence.

Visual review covered five/four-item light layouts, five-item dark, overflow, and completed/incomplete CTA states. The layouts have equal margins and separated touch regions. The original catalogue, daily-card and final Large verifiers passed; `git diff --check` and the repository speed-rule checker passed. No CI or native test was dispatched. Saved JSON audits and exports are a dated record, not live guarantees if Figma changes later. Native sizing, text scaling/localization, VoiceOver, exact logging, paging isolation, dynamic colors and live clocks must still be tested on the implemented widget.

Reproduce with [the read-only verifier](<../../../../../../Tools/widget_catalogue/verify_large_today.py>). The adjacent [handoff](<Layout and Implementation Handoff.md>) lists the remaining implementation acceptance work.
