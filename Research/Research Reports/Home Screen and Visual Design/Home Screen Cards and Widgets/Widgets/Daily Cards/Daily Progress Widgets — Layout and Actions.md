# Daily Progress Widgets — Layout and Actions

Written by Codex, 5 October 2026. Initial code audit at `d4038444b86c4480ab0f9e82576326bb088d3982`; refreshed main audit at `f0e52f46d8ef4641b247aa8b243d1728777b3440`. The [quit, limit and period-goal revision](<Quit, Limits and Period Goals — Revision.md>) incorporates the user’s subsequent layout correction and records source/formatting evidence. This is a research and editable design proposal for Current Work item 9; no app behavior has been implemented or tested on an iPhone here (W1/U9).

## 1. Decision

Use **one visible action, anchored at the upper right, and a body tap that always opens today's Day details**. Keep three visual groups: habit icon and action; habit name and the relevant value; a substantial rounded progress/context capsule. The capsule displays progress or necessary context and never acts as a second button. Fully quit habits show a live current run instead of daily progress; configured period goals appear below the name, with today’s contribution in the capsule. Action meaning changes with the habit's input needs; position, target size and the relationship between action and body stay consistent.

This develops the user's second layout. It keeps the first layout's clear daily value, removes the rejected fourth explanatory line, and makes the quantity increment explicit inside the action itself (`+1`, or a wider `+500`). Equal outer insets are part of the contract, rather than something estimated separately for each habit.

Two visible buttons are unnecessary for a binary check and a saved quantity. They still cannot offer a useful direct action for an arbitrary checklist step. If two were mandated, the consistent pair would be **quick action + Open Day details**, with quick action unavailable when input must be selected. That duplicates the body tap and leaves a redundant or disabled button in several cases. A universal plus/minus pair would be worse: one binary check toggles, repeated checks add, timers have sessions, slips have timestamps, and checklist steps have independent identities (U14/U19). The one-action layout is the design recommendation, not a statistically established preference.

**Created:** [Today — One Habit, One Action](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=537-2981), on the existing Inspiration page. There are 29 base semantic variants, three scope examples, a four-state timed-limit family and a paused quit component, light and dark appearances, and exact action notes outside the cards. Previous Free and Paid sections remain intact.

## 2. Evidence and its limits

The [complete review audit](<Review Audit.md>) contains 37 individually read originals: 35 iOS and 2 Android reviews. They were selected to examine interaction, identity, timer correctness, steps and goal clocks. This is targeted qualitative evidence; it does not establish which shape is most popular, estimate a percentage of all users, or independently reconstruct the earlier report's aggregates. Original records, stable store IDs, zero-based source line indices and manual classifications are saved in [Verified Review Sources.json](<Verified Review Sources.json>). All records were matched back to their read-only JSONL originals; none were unassigned or unknown (W2).

User signals relevant to this card:

- **A direct action should do exactly the expected small action.** Habitify `A33#164` describes a widget change that completed the whole habit instead of a partial morning/evening contribution. HabitKit `A7#833` appreciates interactive widgets. Dots `A56#6` wants progress to change without an unexpected app launch. These support precise increments and truthful distinctions between direct action and an input-opening link.
- **A name is necessary identity.** Habit Tracker `A1#55119` requests words instead of only emoji. Don't Break the Chain `A36#190` cannot distinguish multiple widgets without titles. Keep the habit name, even when the icon is familiar.
- **Steps need explicit selection.** Everyday `A4#19971` describes individual yoga positions; Done `A10#22185` describes a room-cleaning checklist. Tiny Routines `A52#19868` describes individually chosen tasks in an older extension. This supports keeping named steps reachable, not ticking an arbitrary next step. The older extension does not prove a current Small widget can host its UI.
- **Timers need freedom, persistence and correct state.** `A1#2368` wants to browse while the timer continues; `A23#2478` wants a large timer; `A26#3546` describes quitting a timer losing its state. `A1#44450`, `A1#44839` and `A23#4446` raise wrong counts, lingering paused activities or disagreement between app and timer surfaces. The response is a full-screen option, manual entry, session integrity and consistent pause behavior—not another decorative number.
- **Low clutter matters, but density needs differ.** Fabulous `A24#36006` describes unwanted content consuming attention; Dots `A56#18` appreciates minimalism and direct checking. Other selected reviews request denser multi-item widgets. Those are different use cases and do not invalidate a focused single-habit card. The user's supplied designs are the direct preference evidence for this card's spacing and hierarchy.
- **A weekly quota is not necessarily a daily obligation.** Strides `A55#1466` requests three hours across a week without compulsory daily sessions. Android Loop `P24#572` describes a weekly cigarette limit and `P24#19536` flexible weekly completion. Android evidence supports a scheduling need, not iOS capability. Quit evidence `A36#53` supports logging an event rather than demanding an abstinence check every day.

Historical references may describe old app versions, Today extensions or old free plans. This study does not claim those competitors currently ship the proposed layout. Review evidence supports the needs above; shared geometry, a single CTA and the 18-point capsule are design decisions to solve those needs.

## 3. Native interaction contract

Apple recommends glanceable, focused widgets, stable controls and standard content margins. The design uses 16-point insets and system typography. Complex selection belongs in the app rather than a miniature form inside the widget. [Apple HIG: Widgets](https://developer.apple.com/design/human-interface-guidelines/widgets).

Use **Button/Toggle with an AppIntent for an actual mutation**: checking, adding an amount, starting or pausing a session. For an action that only opens a screen, use a **Link or widgetURL**. Apple explicitly distinguishes these roles; authentication may be required while the device is locked. [Adding interactivity](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities).

Use one body `widgetURL`, with a more specific Link for the visible input arrow. Apple's current dedicated routing document includes Links in `systemSmall` and larger families (and `accessoryRectangular`). An older extension guide describes narrower support, so do not carry that older restriction forward as a blanket claim. Verify the actual supported OS/family on device; if a target does not provide the desired small-widget link behavior, route the body to the appropriate input screen rather than displaying a control that cannot work. [Linking to specific app scenes](https://developer.apple.com/documentation/widgetkit/linking-to-specific-app-scenes-from-your-widget-or-live-activity).

Widgets are archived views rather than ordinary continuously running app screens. Build interaction through supported intent-backed controls; do not promise a scrollable checklist, text field, custom picker or ordinary in-process state update in a Small widget. [WWDC: Bring widgets to life](https://developer.apple.com/videos/play/wwdc2023/10028/).

An arrow therefore means **open input**; it is intentionally different from a check, `+1` or play/pause. Every target needs a semantic VoiceOver name, such as “Add one glass to Water for today”, “Choose Morning routine steps”, or “Record a slip”. Color and an unlabeled symbol alone must not carry the action's meaning (U1/U2).

## 4. Shared geometry, locked before variants

The sample is 158 × 158 points, matching the supplied 316-pixel reference at 2×. This is a study size, not a universal WidgetKit dimension. The reused iOS library Small shell is 164 × 164; production must use the family's actual available geometry and system content margins rather than hardcoding a particular iPhone (U1).

| Element | Study geometry | Reason |
|---|---|---|
| Outer insets | 16 pt on every side | Balanced relationship to the rounded shell |
| Header | 44 pt high | One native-sized action and one habit icon |
| Action | 44 × 44; 76 × 44 for `+500` | Exact amount stays on one line; right edge never moves |
| Habit glyph | 28 × 28 frame, 24 pt SF Symbol | Familiar, colored identity without a competing label |
| Name and value | 22 + 20 pt, no internal gap | One semantic group: which habit and its current value |
| Inter-group gaps | 11 pt each | `16 + 44 + 11 + 42 + 11 + 18 + 16 = 158` |
| Progress capsule | 126 × 18, radius 9 | Clearly visible progress without another standalone text row |
| Name / value | Native Headline 17 semibold / Subheadline 15 regular | Compact native hierarchy; the value does not overwhelm identity |

The capsule spans the same content width as the two text lines. No extra “adds one glass” footer, motivational sentence, week dots or monthly progress statistic is placed inside the card. Quit’s best run is the explicit user-requested context exception, inside the existing capsule. An exact saved increment is the action label. Limit state, quit best run or today’s contribution to a period goal sits **inside the existing capsule**, not in a fourth row. Quit uses the same separate name/value group, with one emphasized `15d 22:36:35` line (17 semibold). The revised daily-limit, quit-best and positive period-contribution captions are 13 semibold in semantic ink.

**6 October CTA revision supersedes the original primary/outline styling:** incomplete controls use neutral system fill and ink; genuine positive completion uses the habit's main color with constant-white content, matching the app's `RoundActionButton` (U2). +N retains its exact increment meaning after completion, running timers stay neutral, and limits/slips never receive a completed-goal treatment (U16/U25). Limits retain a neutral consumed-capacity fill. Both appearances retain the same geometry. Read [CTA Colors — Match Today Rows](<CTA Colors — Match Today Rows — 6 October 2026.md>) for source and preview/native scope. The SF Symbols, native shell, shared content component, text properties, icon swaps, color variables and spacing/radius aliases are editable in Figma. No Code Connect mappings were found; this is not a production code binding.

## 5. Exact behavior by habit type

| Habit / input | Today's value and capsule | Visible CTA | What happens |
|---|---|---|---|
| One check per eligible day | Not checked / Checked; empty / filled | Check | Set this day's desired checked state. Checked state can uncheck this exact day. Guard the expected revision so an old tap cannot toggle a newer result. |
| Repeated check | 1 of 3 checks; actual daily count | `+1` | Add one check, never the entire goal and never an implicit undo. |
| Named Morning/Evening checks | 1 of 2 checks | Arrow | Open the named slot controls. Do not silently select the first undone slot. |
| Quantity with saved increment | 3 of 8 glasses | `+1` | Add the displayed configured amount, once per deliberate tap. |
| Quantity without a saved increment | 2 of 5 km | Arrow | Open native amount input. Save adds one record; Cancel adds nothing. |
| Walking steps | 4.2k of 8k steps | Arrow, or `+500` when configured | Enter an amount, or add exactly the saved 500 steps. Accessible value reads the exact numbers. |
| Duration, ready | 12 of 30 min | Play | Start once; open the existing full-screen timer by default. Respect the timer-screen preference. |
| Duration, running | Saved time + current session; 18:24 of 30 min | Pause | Save this session once and stop it. Stay on the Home Screen. Body still opens Day details. |
| Duration, paused | Saved total; 18 of 30 min | Play | Resume as a new session while preserving prior saved time. |
| Checklist | 2 of 5 steps or 5 of 100 steps | Arrow | Open the full named list for this day. Toggle only the selected step UUID. |
| Completed checklist | 5 of 5 steps | Same arrow | Review or correct a named step. Do not change the action to reset-all. |
| Quit completely | Live current run: **15d 22:36:35** on one emphasized line; **Best 45 days** | Quiet arrow | Open Record a slip. Save actual timestamp once; current run restarts from chronological history. Cancel changes nothing. No positive logging or daily completion claim. |
| Daily cut-down / at-most limit | 1 of 2 cups; neutral fill with emphasized Daily limit / Limit reached / Over the limit | Quiet `+1`, or arrow for custom input | Record actual consumption. The card remains neutral at and above the limit. |
| Duration cut-down / at-most limit | Social media, max 20 min: 10 of 20 min / running 12:36 / reached 20 / above 25; corresponding limit-state capsule | Quiet Play/Pause | Use the same start, full-screen preference and pause/save contract as other timers; never celebrate consumption reaching its limit. |
| Weekly/monthly total limit | 1 cup today; Weekly/Monthly limit | Same quiet action | Log today's consumption; period allowance is contextual in Day details, not today's denominator. |
| Weekly/monthly total positive goal | Configured **3 h a week / 10 times a month** subtitle; **12 min today / 2 checks today** capsule | Type's normal action | Keep configured goal and today’s contribution distinct; no invented daily quota or period-progress fill. |
| Flexible schedule with a real daily dose | 12 of 30 min | Type's normal action | A genuine 30-minute daily target still gets a daily fill, even when scheduled three days per week. |

After reaching a positive count/amount target, preserve the actual number and keep meaningful additive logging available: **9 of 8 glasses**, with the visual fill capped at 100%. Completion is not permission to discard further records. A binary check remains a binary toggle. Corrections to an amount, repeated check or slip live in Day details and name the exact record; a plus never becomes a minus or reset button (U14/U19).

One-time tasks have global completion semantics in the code. If included in this habit card, show “Completed” when already finished rather than implying a check was made today; repeating tasks can use the eligible-day binary contract. An empty checklist has no meaningful denominator: show “No steps” and open editing; never show a fabricated 0 of 1. These are same-layout fallback rules, not additional invented habit types.

## 6. Timer: full screen, background continuation, manual entry

**Yes: Start opens the full-screen timer by default.** That follows the app's existing preference and accepted TimerScreen behavior. Starting and opening must be one coordinated action: persist a single session, then route to it. A Link that merely opens an idle timer is not equivalent to Start. If the user disabled automatic timer opening, start in the background and keep the Home Screen.

Closing the full-screen view keeps the timer running. Pause commits elapsed time once. Resume starts a new interval and adds to saved time; it does not clear the day. “Log time manually” remains available through Day details and the existing timer flow. Opening a manual editor during a run must preserve the existing pause/save/resume rules and prevent duplicate accounting on Save or Cancel.

The widget should render a system-managed elapsed-time text when feasible, not re-publish the entire store once a second. Apple's timer-interval `Text` initializer is appropriate for the changing clock; a timeline or system progress view can refresh the bar without promising every-second arbitrary widget code. A captured Figma “18:24” is an illustration, not evidence of animation. [SwiftUI timer text](https://developer.apple.com/documentation/swiftui/text/init(timerinterval:pausetime:countsdown:showshours:)). Keep clock work isolated to the smallest view and avoid broad recomputation (S3/S5).

A rollover needs explicit implementation. Current `dayProgress` adds the whole active interval when drawing today; `stopTimer` credits its elapsed interval to the `LocalDay` passed by the caller. These alone do not establish correct midnight/day-boundary accounting. For timers started from this Today widget, the recommended contract is to partition elapsed time at the app's **logical tracking-day boundaries** and persist each segment once, so yesterday's time never appears as today's contribution. Reconcile that behavior in the shared timer model and all app surfaces; the widget must not independently invent a different persistence policy. Preserve historical/manual assigned-day records. Test custom day start, timezone changes and foreground/background transitions (D7). This is a build requirement, not an existing guarantee.

## 7. Checklist steps versus walking steps

Checklist steps are named independent items. A small card cannot identify which of 100 items the user intended by a generic plus. The card displays a count and opens the complete native scrollable step list. That screen exposes all steps, their current state and the selected tracking day. Selecting a step toggles its exact UUID. Navigation or scrolling never completes a step. Already checked steps can be corrected individually; order stays the user's order (U13/U14).

Walking steps are a quantity habit with unit “steps”. No HealthKit, `CMPedometer`, `HKQuantityType` or `stepCount` integration was found in the app/shared sources in this audit. Therefore these designs offer manual quantity logging and a configured increment. They do not imply automatic health-data import. A future automatic source would show synced today's steps and route to source/details rather than inviting duplicate manual additions; it requires separate permissions, deduplication and source precedence work.

## 8. Goal clocks and honest progress

Derive **today value**, **daily target if one actually exists**, **period target**, **period kind**, **eligibility** and **timer state** separately. Do not assume that `dayGoal` always means a real daily obligation: its fallback can be the habit's general goal. Do not use period-completion booleans to fill a daily bar. Flexible day-count quotas and legacy period-total goals need different treatment.

For a daily amount/time dose, use `todayValue / dailyTarget`, with fill clamped to 0…1 and actual text left intact above target. For a checklist, count unique checked step UUIDs for the day over actual step count. For repeated checks, count today's actual events over a real daily count target. For a weekly/monthly positive quota with no daily dose, display the configured period goal below the name and today’s actual contribution in the neutral capsule. A weekly/monthly limit similarly uses a neutral capsule identifying its period. Weekly/monthly progress totals belong to their respective app surfaces. Fully quit is the explicit exception: show the live current quit run and best-run context, without a daily success bar.

## 9. Unavailable states, correction and accessibility

Skipped days keep saved values and open the existing Day sheet with Undo skip in its established position; direct logging is disabled (U15). Paused habits and ineligible days open details without silently logging. A removed or invalid selected habit displays a choose/open state, never a substitute habit's progress. Locked/private content conceals identity and values until authentication. Future start dates and ended schedules use the ineligible-day contract.

Every mutation revalidates configured habit UUID, kind/rule revision, logical day/zone, schedule, pause/skip, privacy and timer session identity against loaded durable state. Distinct intentional taps get distinct event IDs; retries of one event must not double-log. A stale midnight tap refreshes without applying the old day's action. A failed write must not produce lasting false completion; recover to the persisted state and surface an actionable failure in the app. Exact record corrections remain in Day details.

Keep names available in full to VoiceOver even when the visible compact name truncates. Never truncate the meaningful amount or unit into an ambiguous value. Use compact exact-enough display notation with full spoken numbers; if a locale/unit or accessibility size cannot fit, prefer a wider widget/adaptive rendering while retaining the same three semantic groups. Do not indefinitely shrink type to force every possible string into a Small card. The 29 English examples fit at the study type sizes; arbitrary locales and all Dynamic Type sizes still require native verification. Test light/dark, tinted/accented appearance, increased contrast, Reduce Motion, RTL, large numbers and decimal units. Color must not be the only cue (U1).

## 10. Code audit and implementation work

File names are abbreviated after the first reference; model files are under `iOS/Habits/Model`, shared widget files under `iOS/Shared`, and screen files under `iOS/Habits`. Line locations refer to the audited baseline and may move.

| Source | Finding | Required work |
|---|---|---|
| `iOS/Habits/Model/Habit.swift` | Check, amount, duration, checklist, quit, task; several frequency clocks | Classify input and goal scope without flattening distinct semantics |
| `HabitStore.swift:1061–1129` | `dayProgress` is day-oriented; `progress`/`goal` can be period aggregates | New today-only snapshot fields; explicit optional daily target |
| `HabitStore+Widgets.swift` | Current widget items use `progress`, `goal`, `isSatisfied`; quit uses since-last-slip context | Separate today contribution and configured period goal; reuse quit counterStart/counterValidUntil and add derived best-run presentation |
| `GoalInput.swift:121` | Positive saved quick increment versus asks-how-much input | Show exact saved amount or a genuine input link |
| `HabitStore.swift:2210` | Existing widget logging guards state, deduplicates events, but blocks non-limit logging after completion; supports limited actions | Keep existing safeguards; add binary desired-state and precise additive contracts; allow actual meaningful counts above target |
| `HabitStore.swift:2247` | Checklist operation already targets step UUID | Reuse named step flow; no first-undone guessing |
| `HabitStore.swift:2257–2297` | Timer start/stop persist; stop credits the caller's day | Session-ID/revision guard, coordinated start/routing, rollover accounting and reliable refresh |
| `iOS/Shared/WidgetSnapshot.swift` | Bounded dated frames, privacy and schema validation already exist | Extend snapshot version deliberately; preserve bounds and privacy fail-closed behavior |
| `WidgetIntents.swift`, `AppModel.swift:233` | Existing additive widget intent loads store, logs and flushes | Typed intents for check/add/start/pause; no fake mutation intent for open-only arrows |
| `HabitsApp.swift:38`, `TodayView.swift:233–243` | Existing item route opens Day sheet; timer route opens timer without starting it | Keep body item route; add explicit input destinations where necessary; coordinate start before timer route |
| `TodayRows.swift:322`, `TimerScreen.swift`, `Settings/Preferences.swift` | Start/pause, full screen default, background continuation and manual entry exist in app | Reuse behavior and preference rather than introducing a separate timer experience |
| `Today/DayActivity.swift` | Named slots/steps, manual quantity/time, slip logging and record correction exist | Preserve those capabilities behind the card body/input routes |
| `StopTimerIntent.swift` | Existing Live Activity path is not a complete guarded widget-session contract; extension path can return without saving | Harden/reuse shared logic only after loaded-state, privacy, stale-session and persistence behavior are validated |

The new data contract should include habit identity, logical day with validity bounds/zone, privacy state, action type and exact increment, today saved value, optional true daily target, period scope, checklist count, quit current-run anchor/validity/past-best and Show Streaks preference, eligibility, timer session ID/start and cumulative saved time, and rule/schema revision. Use bounded precomputed frames; do not reread all history in each widget render (S5/S8). These are proposed fields, not files already changed.

Build in this order: daily model/snapshot and target-scope tests; safe direct logging; explicit input routes; session-aware timer controls and rollover; shared SwiftUI layout; accessibility/appearance; native tap/persistence tests. Reuse current input screens. Basic input correctness, identity and corrections must behave consistently regardless of entitlement; this follow-up does not change the earlier Free/Plus proposal.

## 11. Delivery and acceptance

The [package index](<README.md>) links all cards, editable Figma nodes, 40 PNG exports, the structural audit and machine-readable scenarios. Figma read-back found 29 base variants plus four supplemental card examples with equal insets, zero progress-value overflows, and zero action targets below 44 points at the study scale. Visual inspection corrected glyph anchoring, a wrapped +500 and long status copy before final export. Native shell instances, SF Pro/SF Symbols and bound semantic geometry remain editable. The two older sections retain their original IDs and bounds.

Native acceptance still needs: select/change habit; independently add several cards; correct deep-link and intent tap regions on Small; check/uncheck and repeated increments; named slots and a 100-step list; saved/custom amount, zero/decimal/large values and above-target logging; start/close/pause/resume/manual timer accounting; locked and killed-app behavior; midnight/custom-day/timezone rollover; weekly/monthly configured goals and limits; live one-line quit time, best/Since preference, slip cancellation/backdating/correction and pause/end boundaries; stale rules/deleted selection; write failures; VoiceOver, localized text, Dynamic Type and tinted mode; free/paid consistency and performance. Coordinate any future CI dispatch under T10. No app CI was dispatched for this research/design work.

The detailed [request checklist](<../../../../../../iOS/Docs/Checklists/Daily Widget — Layout and Actions — 5 October 2026.md>) records research completion. Current Work item 9 remains open until implementation and required validation; this report is not a runtime sign-off.
