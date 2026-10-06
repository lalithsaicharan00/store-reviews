# Widget package publication validation

Written by Codex, 6 October 2026.

This publishes research, editable Figma references, documentation, verification tools and **122 PNGs**: original catalogue 28, final Small 48, accepted Large 20, Medium 26. Every PNG is our own design export with a manifest; no user attachment or competitor screenshot is added to this public repository (D11).

The final Small audit checks 42 individual cards, 25 supporting labels at 12 pt Medium, fitting primary values and one action region of at least 44 pt per card. Six new recovery states and five dark recovery examples are included. A final rendered review corrected an unavailable heading's truncation and a dark inherited value override before exports. Main Small names/values, equal insets and CTA semantics are preserved.

The original catalogue verifier checks 28 PNG signatures, dimensions, byte counts, SHA-256 and all PNG chunk CRCs, plus package/local links and the 181-original audit's cited IDs. Small checks additionally reopen all 37 original records byte-for-record, verify 48 images and final typography/state geometry. Large checks 20 images, max-five spacing, 67 rows, exact actions, 36 retained Small CTA controls and the attributed Q46 arithmetic. Medium checks 26 images, 35 rows, 77 header/action regions, max-two/one fallback, actual progress geometry and no saved clipping/overlap. These checks use saved artifact evidence and are not WidgetKit dispatch tests.

Reproduce from repository root with Python:

```text
python Research/Tools/widget_catalogue/verify_delivery.py
python Research/Tools/widget_catalogue/verify_daily_cards.py
python Research/Tools/widget_catalogue/verify_large_today.py
python Research/Tools/widget_catalogue/verify_medium_today.py
```

Run `iOS/Tools/perf/check_rules.sh` and `git diff --check` before publication. [Publication Verification.json](<Publication Verification.json>) records final checker outputs. The [main audit](<Publication Main Audit.json>) records the inspected 15 commits and unchanged widget entry points at the refreshed baseline.

Repository rules were reconciled with newer main rules before publication: widget goal/layout guidance is **U25**, preserving the existing main U23/U24 routine-player rules. Main's newer data-day and test/CI policies are retained. The final user checklist records documentation/design delivery separately from native completion; Current Work item 9 remains open.

No native source is modified by this package. No iOS test workflow is dispatched; documentation publication is untagged under T10. Native build, performance, actual picker/routes/logging, purchase integration, Dynamic Type/VoiceOver and physical-iPhone acceptance remain pending (U9/W1). Historical run links remain historical; they do not prove the new layouts are implemented.
