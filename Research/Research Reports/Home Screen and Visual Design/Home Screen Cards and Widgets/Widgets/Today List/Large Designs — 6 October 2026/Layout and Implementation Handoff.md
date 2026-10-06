# Large Today list — Layout and Implementation Handoff

Written by Codex, 6 October 2026. Final selection: progress-filled only, five items per page, wider spacing and the app's CTA colors. This supersedes the initial six-row / plain comparison.

## Design decision and evidence

The user rejected the cramped six-row and plain treatments and selected progress filling with a maximum of five items per page. Physical capacity alone did not establish comfortable spacing; this user review sets the final density (U25).

Keep Today available by default. It is the aggregation of eligible day items, not a new saved section. Optional selection of one app section offers focus without forcing everyone to configure several widgets. Preserve saved section/row order and shared-placement semantics; omit empty sections. Do not automatically select a time-of-day section, reorder by reminder time, or insert headings that displace action rows (U4/U13).

The existing [Q46 habit-count study](<../../../../Today Screen Jobs/46. How Many Habits People Actually Track.md>) reports 446 uncapped, nonduplicate OWN count statements, with 247 at five or fewer (55.4%), 199 above five (44.6%), median five. The earlier six-item threshold was 283 (63.5%). On 6 October the retained [classification map](<../../../../Today Screen Jobs/Today Jobs Evidence/Q46/review-classification-map.txt>) was reparsed using its codebook: exclude CAP and DUP, take range midpoints, then count OWN. The retained-map arithmetic reproduces 446 total, 247 at five or fewer and 283 at six or fewer. This verifies retained coding arithmetic, not every underlying classification or a new census. It is a historical, self-selected, mixed-platform review sample of total tracked counts; it is not our app's user distribution, conversion rate or today's eligible row count. Tasks can increase the Today list beyond habit counts. The [free-cap report](<../../../../../Business Model and Monetization/Free Habit Limit — 5, 6, 7 or More.md>) informed the original pricing question; no entitlement change is proposed here (W2).

The [5 October Today-list study](<../Today List Widgets — Size, Sections and Native Behavior.md>) already connects nine source-verified iOS review originals to visibility, whole-day access, section choice, explicit increments, completed-item preferences and minimal logging. This pass uses that evidence and the linked accepted small widgets; it is a design follow-up, not a new popularity ranking or exhaustive review scan.

## Geometry and content

The file uses the existing native Large shell instance. The studied logical card is 338 × 354 points, with 16-point content insets and a 306 × 322 interior. This is an example size, not a universal iPhone pixel contract.

- Header: 44 points. Without overflow, Today and the whole-view done count share one line. With overflow, Today and its count form a compact left block; previous/page/next occupies the right. Each arrow has a 44 × 44 region.
- Header-to-list gap: 10 points.
- Full page: five 44-point rows, four 12-point gaps: 268 points. Total interior = 44 + 10 + 268 = 322. Neighboring 44-point action regions are separated by 12 points, rather than the rejected draft's 2.
- A nonpaged four-item view uses four 58-point rows with three 12-point gaps, also 268 points. The same name/value/action positions apply. Native density should be chosen once from family, content count and accessibility size, not measured twice per row (S10).
- Paged lists keep the compact grid on their final page. Six items use 5 + 1; twelve use 5 + 5 + 2; sixteen use 5 + 5 + 5 + 1. All twelve-item pages are shown; sixteen-item middle pages follow the same five-item algorithm. Empty trailing slots are intentional, so actions never shift vertically when paging.
- One name line and one necessary context/value line per row. Today aggregate rows include section context where space permits. A selected-section view omits that repeated label. Long names truncate, while numeric values and goal context stay first; accessibility exposes the full name/value.

The title/header body opens the exact Today or selected section view. Row body opens that item's exact Day details. Its separate round control performs the explicit action. Avoid a whole-widget Link swallowing per-row controls. No scroll view, expandable list or text input is implied by these drawings. Configuration and paging need native App Intent validation.

## Accepted progress fill

The active delivery contains progress-filled rows only. The earlier plain/six-row draft roots were removed by their exact persisted IDs after the user's selection. The accepted rows use the existing app's `ProgressFill`: a left-anchored fraction, visual clamp 0…1, habit color at 0.15 in light and 0.26 in dark. Values may exceed a target; logs are never visually clamped or discarded. Fills do not add a third row line.

Only a real daily positive target supplies a today's-progress fraction. Period-only goals show today's contribution and the configured week/month target as context; they do not invent a daily denominator or shade the row using period completion (U25). Quit and at-most quantity/time limits remain neutral even when a maximum is reached. Limit wording must change to Limit reached / Over the limit as specified in the single-card handoff.

The 16 scenario components cover five mixed rows, four rows, all six-item pages, all twelve-item pages, sixteen first/final pages, Morning, both ongoing/limit pages, five checks, completed day, empty day and long names/period goals. The 18 review instances also include dark five-item and dark completed-day examples. Only the accepted filled treatment is delivered.

## CTA colors — accepted 6 October correction

The user rejected the heavy primary-black/light and primary-white/dark CTAs. Source of truth is `RoundActionButton` in `iOS/Habits/Components/Components.swift`, lines 100–149, and its callers in `TodayRows.swift`, lines 271–336.

| State | Background | Content | Meaning |
|---|---|---|---|
| Before completion | `Color(.tertiarySystemFill)` | `Color.ink` | Neutral action; amount, play and check remain easy to find |
| Positive completion | `habit.color.color` | `Color.white` in both modes | Completion state, not general action priority |
| Count/amount above goal | Habit color | White saved +N | Further real logs remain possible; + never becomes undo |
| Running timer | Neutral system fill | Ink pause glyph | Native caller uses `done && !running`; running alone does not mean complete |
| Quit, at-most limit | Neutral system fill | Ink | Logging a slip/consumption is never a completed positive habit |
| Paused/skipped/unavailable | Neutral with existing disabled/recovery treatment | Ink/disabled ink | Preserve state and available recovery; no false completion |

Figma's neutral fill uses a separate Light/Dark preview token (#EFEFF0 / #3E3E42), explicitly an opaque visual proxy. UIKit resolves the native dynamic color and accessibility contrast; do not copy the preview hex values into SwiftUI. The completed-content token is constant white in both modes, unlike the former day-sheet inverse-ink token. Existing habit color variables are reused. No global day-sheet primary-button variable is changed.

Icon-swap defaults must be set explicitly on each row instance along with its name/value/action properties. The retained component set has one canonical Habit icon property after combining variants; relying on a variant's initial glyph can reset to its shared default after a source edit. The final audit verifies each semantic role's explicit icon and its habit-color binding.

## Logging contract

| Input | Visible action | What must happen |
|---|---|---|
| Binary habit / one-time task | Check | Toggle this exact logical day; completed state allows that day's undo |
| Several checks / saved quantity | +N | Add exactly one configured contribution; preserve +N after goal completion |
| Typed quantity | Open/input glyph | Open that habit's existing bounded input; cancel writes nothing |
| Duration | Play/pause or exact timer route | Preserve session accounting and the user's full-screen timer preference; the drawing does not prove an extension-side timer intent |
| Named checklist steps | Open checklist | Open the named list; never guess the next step or complete the whole habit |
| Manual walking amount | Saved +500 example | Add the configured manual contribution; it is not a sensor reading |
| Health/sensor steps | Open detail | Read authorized data; offer the real permission/recovery flow; never fabricate steps |
| Fully quit | Open slip flow | Show current elapsed run and Best (or Since when streaks are hidden); no daily done action |
| Quantity/time limit | Neutral +N/timer | Log actual consumption/session; never reward approaching/exceeding the maximum |

Today's summary counts eligible completable day items once, not ticks, placements, ongoing quit/limits or a page-local subtotal. The ongoing view has six items across 5 + 1 pages, but only three completable items, and reads 1 of 3 done on both pages. Period-only quota rows need their existing day-participation rule; reaching the week/month quota must not inflate today's denominator. Respect logical day, time zone, day start, goal history, shared placements and durable identifiers (D7/U10/U14/U25).

After a tap, update the same row in place. Hold its page/order through the tap burst; later apply the app's completed-order preference. Never immediately replace it with the next hidden item. A page change is explicit. Clamp the page if membership shrinks; avoid a misleading empty page. Stale/retried intents resolve by durable IDs and log at most once per actual tap; two deliberate increment taps remain two contributions.

## Implementation and acceptance still required

Read `PhoneWidgets.swift`, `WidgetSnapshot.swift`, `WidgetIntents.swift`, `HabitStore+Widgets.swift`, `HabitStore.placements`, `TodayView` and `TodayRows` alongside the prior handoff. Current snapshot/order/section/configuration gaps remain documented there: lack of section metadata, habits-before-tasks ordering, and shared paging state for matching configurations. This design pass changes no app code.

Before release, reproduce configuration and all actions in installed WidgetKit with the app closed; prove per-widget configuration/paging isolation, correct day rollover, persist/retry behavior, account/entitlement changes, sensor permissions, timer session behavior and native clock formatting. Validate smallest supported Large sizes, larger text, VoiceOver labels/actions, contrast settings, long localized strings, limit states and stale/private recovery. Reduce row capacity at accessibility sizes rather than squeeze five unreadable rows. Confirm screenshot readability and target positions on a real iPhone (U9). Follow T10 before any native CI dispatch; this documentation phase dispatched none.
