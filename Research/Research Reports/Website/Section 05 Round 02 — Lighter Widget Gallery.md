Written by Codex, 12 October 2026. Current Work 93; user-directed visual revision, design review before implementation.

# Section 05 Round 02 — Lighter Widget Gallery

**Historical revision, superseded 12 October 2026.** The user subsequently requested authentic simulator Home/Lock Screen screenshots, removal of Free/Plus labels and removal of the separate Lock catalogue. The gallery below is no longer the current proposal. Four main renders were inspected; final handoff publication for this superseded revision was interrupted by that new direction.

## What the user accepted and what changes

The user accepts the widget content and coverage. The full black Lock Screen band is rejected, widget surfaces need clearer separation without heavy shadows, and the catalogue feels heavy. Preserve the interaction claims and confirmed Free/Plus plan, all native family designs and the accepted earlier sections/Morning routine (W1/U5/U9/U28).

This revision reuses [Round 01's focused 22-original review audit](<Section 05 — Interactive Widgets.md>); it does not claim a new review sample, popularity ranking or conversion measurement. The layout choices below are reasoned from the user's feedback and first principles: make the native widget itself the main visual unit, avoid duplicate size displays, and keep plan/sizing choices next to the relevant family. No new competitor artwork, app behavior, paywall or native capture is introduced.

## Revised presentation

- Remove the large filled panels around the Home Screen widgets. Names and Free/Plus badges remain outside the actual native preview, with ordinary readable typography.
- Keep complete Small habit/task examples and the Medium weekly design visible. Tasks and Today habits each have Medium/Large preview states; Large is the default, and the size switch retains both designs without displaying duplicate lists simultaneously. Every family and both applicable sizes remain available. The preview switch is website chrome, not a control invented inside the native app/widget UI.
- Use a stable preview stage for Medium/Large to avoid page movement during size changes. Figma uses instant component-variant changes; the eventual site can use accessible HTML radio controls and CSS, with no graphics engine or mandatory animation. Keep at least 44px touch height, keyboard selection, visible focus and a text description of the selected size in implementation.
- Replace the black Lock Screen band with an open neutral composition: concise Free introduction plus Circular, Rectangular and both Inline designs. Monochrome accessory designs have dark primary ink against the light presentation background. The source `PhoneWidgets.swift` uses `Color.primary`; preserve values, glyphs, ring geometry and opacity relationships. These are editable light-background design examples, not a newly captured installed Lock Screen.
- Give each Home Screen widget a white surface against a 95.5% neutral gray gallery, with a 0.5px quiet edge and restrained contact/ambient elevation. Contact: 0 2px 4px at 6.5% black. Ambient: 0 10px 24px, -4px spread, at 9% black. Effects belong only to the matching background wrapper; no text shadow, stacked outer-panel shadow or perpetual movement. This creates separation through surfaces/edges as well as blur, rather than simply increasing shadow weight.

The section's headline, core Home Screen benefit, meaningful Home emoji, Free/Plus plan and scope footer remain. Lock Screen actions still distinguish direct circle check/count actions from summary links and entries that open the app. Original widget source components/values stay intact; cloned light accessory previews are scoped to the website.

## Source and implementation contract

Reuse the existing website semantic colors, spacing and SF Pro styles, badge components, and approved Small/Medium/Large/weekly widget sources. New additions are scoped gallery-background/primary-ink tokens, one widget-elevation style, website size-option states, and eight responsive family sets with two sizes each. Semantic color aliases have explicit scopes and web syntax. Native UI remains editable rather than flattened screenshots; do not ship SF Pro font files or review-board PNGs.

Large and Medium preview stages have equal heights. The same family's Free/Plus badge applies in both states: Small habits/tasks, Medium/Large Tasks and all Lock Screen families Free; Medium/Large Today habits and This week Medium Plus. App gate implementation/release reconciliation is still pending. No Android widget release, installed-native screenshot, physical-device speed or black-screen stability claim follows from Figma (S19/S2/U9).

Preserve hero, habits, progress, Morning routines and the separate tasks section. Compare their text and sizes against the saved pre-revision baseline. Maintain all eight main/combined gallery copies, and inspect 1440/768/390/320 final compositions plus representative Medium states. Record exact source IDs, bounds, controls and portable previews in the final manifest. Native website/device measurements and publication follow approval.

## Final validation

Final read-back, previews and structural checks are recorded in [the current handoff](<../../../website/Design Handoff.md>) and [Round 02 manifest](<../../../website/Design Previews/Section 05 Round 02/manifest.json>). Review PNGs are references, not production payloads. Figma interaction configuration and real browser keyboard/touch testing are separate checks.
