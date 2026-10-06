# Medium design verification — 6 October 2026

Written by Codex. Saved Figma/artifact verification only; native acceptance remains open under U9.

The read-only `verify_medium_today.py` passed: 21 scenario components, 24 review instances, 35 rows and 77 header/action regions. Ordinary capacity is two; the larger-text study uses one. Equal 12-point visible margins, a 22-point visible header and 12-point row/header gaps fit the 338 × 158-point reference. Every measured action/header region is at least 44 points, stays inside the widget's rectangular bounds and is disjoint from all other action/header regions. The actual text audit reports no allocated-line-height or clipped-ancestor overflow. This does not prove native touch shapes, mis-tap rates or all locales/text sizes.

Actual role icons, labels (+1, +500, check, play/pause, exact input/checklist open), CTA color/content bindings and progress fractions passed. Complete quantity/checklist examples have full fills; the running timer matches its stated fraction; period-only, quit and limit examples have no positive fill. Empty/private/unavailable examples contain no item actions. Light/dark renders, paging, period goals, quit/limits, larger-text reflow, completed input and running/manual-step examples were inspected.

Twenty-six final PNGs pass manifest/dimension/byte/SHA-256/chunk-CRC checks, with exact image coverage. Reused Large structure still contains its 24 original row templates, 16 scenario components and original accepted board. The original Large and single-habit sections were not revised in this pass.

Figma nested instance size overrides initially retained old progress widths; fixed with three Medium-only source-state templates and measured again. Larger text initially kept fixed caption boxes; fixed with actual reflow and unclipped content, then rendered again. The lesson is recorded in Rulebook U9. Saved audits reflect the corrected final state. The [handoff](<Layout and Implementation Handoff.md>) lists native implementation and device acceptance still required; the drawings are not wired logging prototypes.

Reproduce using [the delivery verifier](<../../../../../../Tools/widget_catalogue/verify_medium_today.py>). The broader package link/image verifier, `git diff --check` and repository speed-rule checker also passed. No native code, CI dispatch, commit or push in this phase.
