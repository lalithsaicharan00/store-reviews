# Medium Today — Layout and implementation handoff

Written by Codex, 6 October 2026. Requested family: Medium Today and selected-section widgets. This is a Figma design proposal, derived from the accepted Large family; it adds no weekly/history widget or runtime implementation.

## Layout decision

Use two rows at ordinary text sizes. Preserve the progress-filled row language, one exact action, native symbols and semantic colors. The previous [size/section study](<../Today List Widgets — Size, Sections and Native Behavior.md>) supplies the review evidence; [the accepted Large design](<../Large Designs — 6 October 2026/README.md>) supplies the current visual contract. Two-row Medium density and the compact header are reasoned from first principles and the measured drawing, not a review vote or proof of universal device dimensions (W2).

For this 338 × 158-point reference, equal 12-point visible insets leave 314 × 134. The budget is **22-point header + 12-point header gap + 44-point row + 12-point row gap + 44-point row = 134**. Retaining Large's 16-point margins would leave only 126 points, so that complete arrangement would not fit. Medium uses its own compact insets instead of shrinking names/actions or squeezing three rows. Native implementation must adapt to the actual WidgetKit context and system margins; do not hard-code this canvas size or add default margins a second time.

The visible header occupies y=12–34. Its Open selected view and previous/next hit regions are 44 points tall at y=1–45, using otherwise empty padding. The rows start at y=46 and y=102, ending at y=90 and y=146. Their 44-point action regions are disjoint from the header controls and have 12 points between each other. This is measured rectangular geometry; verify real native content shapes, rounded-edge behavior, VoiceOver and mis-taps on a phone (U1/U9). Paging has distinct previous/next targets, a page fraction, and disabled unavailable directions; there is no scroll/swipe-to-log promise.

A sole unpaged item may use a 100-point row. A one-item final page keeps its ordinary first 44-point slot; never shift actions into the middle as a side effect of membership. The larger-text study reduces capacity to one with a taller row and real text reflow; it is illustrative larger text, not a complete Dynamic Type implementation. Further text sizes/locales may require a different capacity or a simple open-view fallback.

## Selection, order and progress

Default to Today, meaning the aggregate view. Edit Widget selects Today or an actual section by durable identity, including Anytime, Morning, Afternoon, Evening, Quit or Cut Down and custom names. Today is not a newly saved section. The title names the selected view and opens that view in the app; it is not a dropdown for editing configuration. Repeat section context only in an aggregate Today row. A selected-section row omits the redundant section prefix. Preserve app section order and the person's item order (U13); preserve shared-placement identity/progress and count each eligible completable item once in the summary.

The header's done-of-total is **for the entire selected view**, never the page. The page fraction is a separate fact. With two rows, five items use 2+2+1, twelve use six pages and sixteen use eight. Larger-text capacity one uses one item/page. All items must stay reachable through explicit paging and the selected-view route. Do not hide overflow to sell Plus. Do not silently advance a page or replace a row under a finger after logging (U4); apply the app's completed-order preference only after settling. Clamp a no-longer-valid page on a later membership update, without inventing a new selection.

Quit and at-most limits are ongoing context, not positive items to finish; an ongoing-only view omits the done summary. Mixed views count eligible positive habits/tasks only. Today contribution and week/month goal are distinct: the example shows actual contribution plus configured goal, with no fabricated daily denominator or progress fill (U25). Use the app's day-participation rule for period-goal day completion; do not treat meeting a weekly quota as today's whole-view percentage. Skipped/paused/not-planned states stay neutral and follow the existing eligibility/accounting rules.

## Actions and appearance

| Input | Control and behavior |
|---|---|
| Single daily check/task | Check the exact logical day/occurrence; a completed binary check can undo that day's check. Never remove an arbitrary record. |
| Repeated check / saved amount | +N adds one configured contribution. + stays additive after completion. |
| Manual steps | The +500 example adds the saved manual amount; it is not a sensor reading. Unsaved/typed amounts open existing bounded input. |
| Health steps | Open the selected habit's step detail/permission flow. Never invent readings or replace missing authorization with zero progress. |
| Duration | Start/resume/open the existing timer with the person's full-screen preference; a running timer shows pause and saves only that session once. Shared logical-day/session accounting applies. |
| Named checklist | Open the exact named step list. Never guess a step or complete the whole checklist from a generic checkmark. |
| Fully quit | One emphasized live elapsed line under the habit name, Best alongside the title (Since when streaks are hidden); action opens slip logging. No daily completion. |
| Quantity/time limit | Actual consumption/session logging stays neutral; legible Daily limit / Limit reached / Over the limit state. No success fill at the maximum. |

The row body opens that item's Day-details route; the action has its own exact intent/route (U14/U16). These drawings contain no wired logging prototype. Native actions need cold/background persistence/retry and exact-day checks. Body/title taps are distinct from logging and from native Edit Widget.

Before genuine positive completion, controls use **dynamic UIKit tertiarySystemFill with semantic ink**. After completion, use the habit's main color with white content. Running timers, quit and consumption limits remain neutral. Figma preview grays are proxies; reuse the native dynamic color, not their hex values. Positive row-fill opacity is .15 in the light examples and .26 in dark, clamped to one. No fill for quit/limits; a period-only goal fills toward its week or month goal. *(Corrected 8 Oct 2026: the user never asked for week or month goals to stay unfilled; their point was that such goals have no daily goal. They fill toward the week's or month's goal, as Today's row does.)* Names and actual units remain visible; color alone never conveys the state (U2/U25).

## Empty, private and unavailable

No planned items shows an honest empty view with an open-app/view route. If an existing selected section is empty today, keep its name and scope. A renamed section follows its identity; a removed section shows Section unavailable and native Edit Widget guidance, without substituting Today. Locked/private widgets expose no names, values, success summaries, item logging or paging controls; the public title/body opens the app's unlock/recovery route. Missing/stale snapshots likewise use the existing safe recovery state, not yesterday's active controls.

## Remaining native work

The local `AgendaWidgetConfiguration` only exposes Show completed and Tasks only; section selection is not implemented by these designs. Add durable configuration queries, section/order metadata to the bounded snapshot, exact selected-view deep-link routing and appropriate paging namespace. Existing same-configuration paging isolation is a known gap; measure and resolve it rather than claiming per-widget isolation from a Figma page count. Keep basic Today/section selection, logging, system appearance and all free items reachable; this pass changes no entitlement boundary.

Test installed widgets with the app closed; multiple scopes and equal configurations; logging/retries and page stability; rollover/custom day start/time-zone changes; duplicate placements; timer states, quit clocks and quantity/time limit states; permissions, unavailable/deleted entities, privacy and entitlement transitions. Verify smallest supported Medium geometry, supported names/units, localization, larger text, contrast and VoiceOver. Reuse cached projections and shared write paths (S5/S8/S10/S16/D7). Read T10 before any native test dispatch. Figma dimensions, fonts and screenshots do not prove native accessibility, performance, persistence or real-phone usability.
