# Accepted widget implementation contract

Written by Codex, 6 October 2026. Screen-specific handoff; repository policy remains in RULEBOOK.md.

## Shared mental model

Small: icon/action header → habit name/main value → progress or supporting-state capsule. One explicit CTA, with the card body opening that habit's Day details. Equal 16 pt insets, action target at least 44 × 44, no explanatory fourth line. Large: up to five progress-filled rows, 16 pt insets, 12 pt row gaps. Medium: two progress-filled rows, 12 pt insets/gaps and a compact header. Widget dimensions in Figma are design references; family geometry varies by iPhone and must be verified in WidgetKit.

CTAs use `Color(.tertiarySystemFill)` plus semantic ink until genuine positive completion; done uses the habit's selected main color with white content. Running timers, quit and limits stay neutral. A configured +500 stays +500; never replace a saved increment with a generic check. Row fills read the actual positive **daily** fraction, cap visually at 1, and retain the true textual amount above goal. Never fill Today from a week/month aggregate or use a success treatment for limits or quit.

Small supporting progress/state text uses **SF Pro 12 pt Medium** consistently: Best, limit captions, today's contribution under period goals, skipped/paused/private/not-planned/selection/recovery captions. Main names and values keep their accepted styles. In SwiftUI use scalable semantic text relative to the intended text role; 12 pt is the reference size, not permission to defeat Dynamic Type. Match the recorded shared supporting style and inspect actual clipping.

## Exact per-type action

| Habit type | Visible value/context | CTA | Safe behavior |
|---|---|---|---|
| One daily check | Exact day's checked state | Check | Toggle only that day; done may uncheck that same day |
| Repeated check | Today's count / genuine daily count | +1 | Add one check; never toggle the whole quota |
| Quantity / manual walking count | Today's amount / genuine daily target | +N or arrow | Exact saved finite positive increment; without one, open amount input |
| Named checklist / many steps | Today's completed named steps / total | Arrow | Open the named list; never complete an arbitrary next step or all steps |
| Duration ready/paused | Today's logical-day duration and target | Play | Default accepted route starts/resumes in the existing full-screen timer; closing keeps it running |
| Duration running | Saved duration plus live session contribution | Pause | Save the active session once; validate native dispatch and accounting |
| Quit completely | Separate name, one emphasized live elapsed line, Best or Since | Arrow | Open Record a slip; Cancel logs nothing. Saved slip updates the run anchor; no positive completion/log-a-success action |
| Cut down quantity | Today's amount with "max" ("1 of 2 cups max", "3 of 2 cups max"); a plain neutral bar (`widget/limit-fill`, #86868B / #636366) with no label inside it on the Small card (the user, 6 Oct 2026: the label over a grey fill looked heavy) | +N/arrow | Log the actual consumption, including above the limit; never celebrate hitting/exceeding it |
| Cut down duration | Same limit semantics with time | Play/pause/arrow by state | Use timer/manual-duration accounting; show exact reached/above state |
| Week/month total only | Progress toward the period goal ("1h 12m of 3 h", "4 of 10 times"); the Small card's bar fills toward it in the habit's colour like every other card, with no extra label (the user, 6 Oct 2026, superseding "no fill") | Per input type; habit colour once the period goal is met | Never invent goal ÷ days as a daily denominator; the fill is the period's, never presented as today's |
| Weekly/monthly with genuine daily target | Daily contribution / that target, configured period context | Per input type | Daily and period measurements remain distinct |

Elapsed quit example is `15d 22:36:35`; VoiceOver expands days, hours, minutes and seconds. A native widget is not a custom 1 Hz rendering loop: verify system date/timer text and refresh behavior on device. If exact second presentation cannot be supported continuously, preserve honest live duration and document the installed behavior instead of promising a fake countdown.

## Today and selected-section lists

Today is the logical-day view, not a database section. Flatten eligible items in the app's user-controlled order, with concise section context where needed; skip empty headings. Select a real section by stable ID (including custom sections), never by a translated display name. Quit/cut-down are ongoing check-ins, not incomplete positive goals; progress summary counts only eligible positive goals. Keep true totals visible while pages expose every item.

Large capacity five, Medium capacity two (one in the demonstrated larger-text fallback). Header arrows page via intents, never scrolling/swiping assumptions. Keep final-page item positions stable and preserve the user's current page across a run of taps; clamp safely after a list change. Scope pagination by stable widget/view configuration, test identical configurations and multiple instances, and disclose any WidgetKit limitation before claiming full independence. Header/title opens the selected view; each row opens that item; each separate 44 pt CTA performs its own precise action.

## Recovery and configuration

Missing selection → Edit Widget instructions; no habits → create in app; unavailable UUID → choose another, never replace it silently; hidden data → generic private state and authenticate in app; stale/corrupt/expired data → open app to refresh; failed save → reload committed state and open app. Placeholder cards contain no logging intent and no completed coloring. The caption capsule is a display, not a second button.

The app cannot programmatically present iOS's Edit Widget picker from its widget CTA. For Choose a habit/unavailable cards, the arrow opens the in-app widget-setup guidance; that guidance instructs **touch and hold widget → Edit Widget → select habit**. The native editor owns entity selection. The complete [Small state matrix](<Daily Cards/Final Typography and Recovery — 6 October 2026.md>) names all routes and guards.

All writes validate stable item ID, displayed logical day, current signature/state, privacy and storage, and deduplicate event UUIDs. A stale callback cannot log into a new day or another habit. Undo is a named one-record correction in Day details. Basic logging and safe recovery are free; no purchase check or upsell blocks a widget write. Preserve existing stable widget kinds/configuration when updating layouts.

## Validation required when built

Use the family handoffs for exact geometry and state cases. Native acceptance covers installed picker and each action; durable app/widget agreement after relaunch; duplicate callbacks and failed write; several independent widgets; real section edits/deletion and paging; midnight/custom day start/DST/time-zone change; private/pre-unlock/stale data; large names/units and Dynamic Type; VoiceOver without merged containers; native light/dark/tinted/clear modes and entitlement change. Run meaningful affected tests/performance under T10, then record phone model/iOS/version/results. PNG checks establish artifact integrity only.
