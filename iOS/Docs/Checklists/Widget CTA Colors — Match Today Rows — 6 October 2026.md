# Widget CTA Colors — Match Today Rows

Written by Codex, 6 October 2026. User correction during the Large Today design pass; Current Work item 9 remains open for native implementation.

- [x] Read the app's actual round-control color and completion logic in light and dark appearance.
- [x] Update the existing single-habit Today cards (Figma section 537:2981), including the shared controls and review examples.
- [x] Update the Large Today list (Figma section 585:4698), originally both treatments; final user selection retains only progress-fill examples, with every scenario updated.
- [x] Before completion, use a neutral system-fill background and semantic ink glyph/text; avoid primary-black or primary-white CTA fills.
- [x] On genuine positive-goal completion, fill the CTA with the habit's main color and use the app's white foreground; keep increment/timer/checklist behavior unchanged.
- [x] Keep quit, cut-down/limits, paused, unavailable and privacy states honest; do not show ongoing or consumption logging as a completed habit.
- [x] Check light/dark renders, completed/incomplete states, targets and existing layout invariants.
- [x] Refresh affected exports, manifests, handoff wording, indexes and Current Work status; preserve the prior Large Today checklist and finish its outstanding delivery work.
- [x] Record the accepted CTA rule in the Rulebook, run documentation/image verification and repository checks. Native iPhone verification remains pending (U9).

Scope: Figma and research/design handoff only. No native code change, CI dispatch, commit or push.
