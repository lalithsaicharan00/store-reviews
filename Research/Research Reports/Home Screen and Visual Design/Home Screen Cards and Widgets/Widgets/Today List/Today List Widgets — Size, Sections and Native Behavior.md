# Today List Widgets — Size, Sections and Native Behavior

Written by Codex, 5 October 2026. Research and layout recommendation for Often Enough; native implementation and Figma exploration have not begun in this follow-up.

## 1. What the user asked and the recommendation

The user wants to understand native iPhone Medium and Large widgets, how established everyday apps use them, and how our long Today screen can fit when it contains Quit or Cut Down, Anytime, Morning, Afternoon, Evening and custom timed sections. This follows the accepted direction to explore a multi-habit Today list next; it does not request a weekly history widget or immediate code changes.

**Start the layout study with Large. Build a Medium companion from the same list model.** Large gives room to prove mixed habits, readable names, progress and safe action targets together. Medium offers the same selected content in a shorter window. This is a suitability recommendation, not a claim that Large is the most popular iPhone size.

Use one widget family called **Today list**, with **All Today** as the default content and an optional chosen section through native Edit Widget. Use one column. Keep the app's section/row order and identify each row's section compactly. Do not try to fit five separate miniature cards, empty section boxes, routine Start buttons or an app-style accordion inside it. Additional items stay available through explicit pagination and a deep link to the complete Today screen.

Quit and cut-down rows are available in All Today and in their own section selection, but are ongoing facts rather than chores left to finish. Never fabricate completion targets for them. The person's placement of that section is preserved; the widget does not silently put it first or last.

## 2. What iPhone widgets actually support

Apple describes Medium as wider than Small, and Large as the same width as Medium with more vertical space. Apple recommends focused content, useful larger layouts and balanced density, with normally 16-point margins and an 11-point option for tighter groupings. These are family/layout guidelines, not one universal device pixel size. Native SwiftUI must adapt to the actual context. [Apple Widgets HIG](https://developer.apple.com/design/human-interface-guidelines/widgets?changes=_3)

The practical constraints are:

- **A fixed display window:** WidgetKit does not provide an ordinary scrolling list or text-entry form inside a Home Screen widget. A long list must be shortened, filtered, paged by explicit actions, or opened in the app. [Apple: Creating a widget extension](https://developer.apple.com/documentation/WidgetKit/Creating-a-Widget-Extension)
- **Simple actions are possible:** an App Intent button/toggle can perform a saved check or increment. Complex selection and input belong in the app. Widget updates follow timeline entries; they do not use a normal app view's mutable local state. An intent persists its change before returning, after which the system requests updated content. This is not a promise of zero refresh latency. [Apple: Bring widgets to life](https://developer.apple.com/videos/play/wwdc2023/10028/), [interactivity documentation](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities)
- **Stacks are a separate mechanism:** swiping a Smart Stack switches among widgets. It does not scroll rows inside one widget. Someone could deliberately stack Morning and Evening widgets, but that is optional OS organization, not our list-navigation model. [Apple: Add, edit and remove widgets](https://support.apple.com/en-ie/guide/iphone/iphb8f1bf206/ios)
- **Choose content natively:** touch and hold → Edit Widget → choose the relevant list/section. Adding a size and selecting its content are separate concerns. Do not promise a custom habit-selection step automatically appears in Apple's Add Widget gallery. [Apple: Reminders widget](https://support.apple.com/en-mide/guide/iphone/iph3fb74d597/27/ios/27)

This study concerns the existing `.systemMedium` and `.systemLarge` families. A recently published Things OS 27 announcement also mentions an extra-tall option; that does not establish support in our current project or remove the need to design the two families requested here. Do not treat an older family table as a complete inventory of every new OS capability. [Things OS 27 announcement](https://culturedcode.com/things/blog/)

## 3. Patterns in established everyday apps

These are documented patterns, not a ranking of app usage or evidence that every pattern is liked. Sources were checked on 5 October 2026. Provider documentation can lag installed releases; we did not install competitors on an iPhone.

| App / source | Documented behavior | Useful lesson for this problem |
|---|---|---|
| [Apple Reminders](https://support.apple.com/en-mide/guide/iphone/iph3fb74d597/27/ios/27) | A chosen list; Edit Widget changes it; items can be completed from the widget | One configured list and straightforward task actions feel native |
| [Apple Calendar examples in the Widgets HIG](https://developer.apple.com/design/human-interface-guidelines/widgets?changes=_3) | Medium and Large expand event coverage; Large adds time-of-day context | Size changes how much is visible; it need not reproduce the entire app hierarchy |
| [Things widget support](https://culturedcode.com/things/support/articles/2803567) | Each widget can independently select Today, another built-in list, a project/area or tags; optional interactive checkboxes | Make content scope configurable; multiple widgets can serve different contexts |
| [Todoist Apple widgets](https://www.todoist.com/help/todoist/features/use-a-todoist-widget-on-an-apple-device-ptRdme), updated 18 Sep 2026 | Tasks comes in Small/Medium/Large; selects Today, Upcoming, projects, filters or labels; Medium/Large support completion on iOS 17; separate Productivity widget | A task list and statistical overview have different jobs; one size family can share selection semantics |
| [Microsoft To Do support](https://support.microsoft.com/en-au/todo/ios-widgets-and-microsoft-to-do), plus its [2021 announcement](https://techcommunity.microsoft.com/t5/microsoft-to-do-blog/microsoft-to-do-ios-14-widgets-are-now-available/ba-p/2118825) | Select a list in Edit Widget; its historical Medium/Large task lists show different detail levels | List selection is a repeated pattern. The support page is scoped to iOS 14/version 2.37 and says completion is unavailable; do not use that legacy limitation as a current iOS rule |

The repeated pattern is **a selected view into content**, with a bounded amount visible. There is no evidence here that we should squeeze all of our sections into separate boxes. The argument for adopting selection comes from those native patterns plus the user needs below; the exact row layout is reasoned from first principles.

## 4. What the review evidence says—and what it does not

This is a targeted re-read of **nine complete iOS originals**, selected from the parent catalogue and Daily Cards audits. Their dates range from 2018 to 2026. Complete records and stable source locations are in [Verified Review Sources.json](<Verified Review Sources.json>). No new percentage, country comparison, representative sampling claim or exhaustive iOS preference ranking is made. Older Today-extension reviews describe a need, not proof of present WidgetKit behavior. The full earlier September classification is still missing; attributed historic totals are not reconstructed here (W2).

| Verified reference | Date | What the person expresses | Design implication |
|---|---|---|---|
| A10#2775, Finch | 9 Aug 2026 | Wants a task-list widget to remember the app and see what remains today | Names and remaining work matter more than decorative totals alone |
| A33#1602, Habitify | 12 Oct 2023 | Wants the day's/week's whole collection and asks for two columns | There is demand for coverage/density; one request does not prove two columns work best for long names, units or actions |
| A23#4768, Streaks | 20 Sep 2021 | Asks to restore a Medium widget containing up to 12 tasks | Some people value high capacity; this is a historical request, not current shipped capacity or a safe text-list target |
| A53#702, HabitMinder | 31 Oct 2019 | Completed tasks make the widget list look longer; asks to hide them | Offer remaining-first content and a clear completed-display option |
| A53#1515, HabitMinder | 19 Aug 2019 | Wants remaining habits at the top and less verbose context | Keep essential facts; avoid sentences under every row |
| A52#19868, ShineDay | 2 Oct 2018 | Values individually named routine tasks, day sections and tapping finished items away | Preserve recognizable names and explicit step selection; not a claim about modern in-widget checklist expansion |
| A1#55119, Habit Tracker | 1 May 2022 | Wants words instead of emoji-only identification | Keep names visible; icon-only density is a separate optional design |
| A33#164, Habitify | 29 Jun 2025 | Complains that a tap completes the whole goal instead of adding one contribution | Each quantity/repeated-check tap adds its exact configured increment |
| A56#18, Dots | 26 Aug 2026 | Likes a minimal interface, alternate formats and checking habits without opening the app | Offer a clean list that still does useful work; do not confuse minimal content with missing control meaning |

The evidence supports **coverage, recognizable items, uncomplicated logging and less completed clutter**. It also exposes a tension between capacity and legibility. It cannot settle Medium versus Large by popularity. Large-first is our response to this app's mixed input types and content needs.

## 5. Size and space: the initial layout budget

Use native families in production. For the first design exercise, the existing catalogue's **360 × 170 Medium / 360 × 376 Large** can be illustrative canvases in logical points. These are our study references, not measurements of every iPhone. Recheck smaller devices, OS scaling, Dynamic Type and actual widget margins before committing a row count.

| Part | Medium study target | Large study target |
|---|---|---|
| Content | All Today or one chosen section | Same scopes |
| Visible rows | Start with 2 readable rows | Start with 5 readable rows |
| Header | Title/open-list target and explicit page navigation share one band | Same model |
| Row | Icon, habit/task name, one essential status line, one quick-control area | Same model |
| Overflow | Header page controls + title opens full selected list | Same, with room for a clearly labelled full-list/extra-items link |
| Smaller/larger text contexts | Reduce capacity when needed | Reduce capacity when needed |

Arithmetic for these illustrative heights: equal 16-point outer insets leave 138 points in Medium and 344 in Large. A 44-point header, 6-point separation and two 44-point row bands use Medium's 138. Large can use a 44-point header, 8-point gap, five 44-point rows with four 4-point gaps, 12-point gap and a 44-point full-list footer: 344 points. This is a vertical feasibility budget only, not evidence that every localized name/status fits horizontally. The Medium budget has no spare space for separate section headings or a footer.

Start with roughly system-body-sized names and smaller readable status text; use system text styles and adaptive layout, not a fixed font contract. A 44-point **hit region** is independent of a smaller visible glyph. Essential action targets must not overlap. If the actual context cannot fit the budget, lower the row count rather than shrinking controls or hiding the unit/goal scope. U1/U9 still require native and phone checks.

The existing implementation shows 3 Medium / 6 Large rows at ordinary text sizes and 2 / 4 in larger contexts. Those are code constants, not proof that names, metadata and tap regions are ideal. We should not inherit them untested.

## 6. How to handle our sections

**Preferred first prototype: one column with compact section context.** All Today keeps the same sequence as the app but removes full section-card containers. A small section label accompanies the row's name within its identity area, leaving the one status line for the habit's actual progress/goal. Repeated labels can be visually quiet; each row must remain understandable on a later page. For a section-filtered widget, the header already says Morning or Anytime, so omit repeated row section labels.

Do not add a third status line for the category. Prototype a compact name-line section label and prove that our 24-character names still remain recognizable. If that fails with long names or translation, use a short shared section heading for the consecutive visible group and accept fewer rows. It is better to show four clear Large rows than five ambiguous ones. This alternative needs an actual side-by-side readability check before final artwork.

The content rules are:

1. **All Today:** use the person's `todayCards` order, and their mixed habit/task order within each section. Do not automatically switch to Afternoon when the clock changes. Empty sections use no space.
2. **One section:** native Edit Widget offers Anytime, Quit or Cut Down and each current timed section by stable ID. Morning and Evening widgets can coexist. Custom Night must work without code special-cases. A renamed section updates its displayed name; a removed selected section shows a clear unavailable/choose-section state, never an unrelated list without explanation.
3. **Other existing options:** retain Tasks only and Show completed. Tasks only must remain visible in the title/configuration and must not hide a quit section's emptiness behind an all-done message. There is no need to charge for correctly choosing a basic list.
4. **Quit or Cut Down:** available as a dedicated scope, without routine Start, completion checkmarks or a section completion bar. Its rows remain factual and neutrally actionable.
5. **Overflow:** page through the chosen scope in order. Repeat section context on every page. Show a page indicator and distinct previous/next controls; disable unavailable directions. The title opens the full selected list, and Large can expose an explicit additional-items link. Page navigation is an app-defined App Intent, not native scrolling.

Do not allocate one permanent row to each section. With 20 Morning items and one Evening item, that would hide 19 of the Morning items and make the list misleading. Do not automatically prioritize quit rows, running timers, reminders or incomplete sections over the saved order. Someone who wants Morning immediately can explicitly choose Morning. Someone wanting a continuous quit counter already has the dedicated one-habit card.

**Multiple placements:** current `workOutPlacements` returns `slot: nil` and explicitly says progress is shared when a habit appears in several sections. All Today should show that habit once at its first eligible placement in the person's order; a selected section should include it when it belongs there, showing the same shared progress. No additional completion is invented for the second section. This deduplication is a proposed widget presentation choice, not an accepted change to the app's repeated rows. Recheck it if the underlying logging model changes.

## 7. Logging and today/ongoing meaning

One compact row keeps the established mental model: **body opens the relevant Day details; the separate control performs one clear action or opens the exact input flow**. It is not two big CTAs per list row. Complex input remains in the app; do not invent widget menus, inline keyboards or expanded steps.

| Type | Essential status | Quick-control meaning |
|---|---|---|
| Binary habit/task | Planned rhythm or current Done state | Toggle this day's check, with explicit correction path |
| Repeated checks / quantity | Today's actual contribution and genuine daily target | Add one saved count/amount, never complete the whole goal; name the increment accessibly and make it visually understandable |
| Amount without saved increment | Today's amount / applicable goal | Open amount input for this habit and day |
| Duration | Today's time and applicable goal; Running/Paused when needed | Use the accepted timer behavior; Start opens the full timer, Pause affects that habit's running session; manual entry remains in Day details. New direct timer intents are not present in current widgets |
| Named checklist | Completed steps / total named steps | Open this habit's named steps; never guess the first unfinished step or log the entire checklist |
| Completely quit | Emphasized single-line current elapsed run | Quiet route to Record a slip; no Done, +1, Start or daily quota. Best/Since is visible in the dedicated card and Day details; assess space before adding it to a list row |
| Cut down, quantity/time | Actual consumption and legible Daily limit / Limit reached / Over the limit context | Quiet saved increment or exact input/timer route; reaching a limit never invites celebration |
| Genuine week/month goal | Configured goal with explicit week/month scope, with today's contribution where it fits | Log to today; never show a fake daily fraction of the period goal (U25) |

A single one-line subtitle cannot reliably carry section name, today amount, week/month goal, units, running state and best streak together. Put section context in the identity area, prioritize the applicable status/goal, and reserve the rest for the exact Day-details route. The prototypes must include the weekly/monthly examples the user already requested. Do not quietly revert to today's minutes alone or a weekly bar labelled Today.

The header's **left** count includes actionable positive habits/tasks, not ongoing quit/limit rows. When both are present, distinguish e.g. **3 left · 2 ongoing**; if it cannot fit, retain the left count and make ongoing status clear in rows/selected scope. Page counts count displayed rows, not remaining chores. If only ongoing rows exist, show them with **Ongoing**, never “Nothing left to check off” as the entire content. A completed positive goal is not a limit reached.

Skipped items are neutral, excluded from left counts and available for correction through the full Today/Day-details route. If Show completed includes skipped rows, show Skipped today and no active logging control; body tap reaches Undo skip. Paused/not-planned items do not fill the active list, but remain available in the app. Current widget `planned` filtering removes skipped items even with Show completed, so including them needs an explicit projection change rather than a visual promise (U5/U15).

Keep completion feedback in place before replacing a row. The app's 1.5-second settle (U4/U13) cannot simply be assumed to run inside WidgetKit. The first prototype should retain a just-completed row as a checked item until deliberate paging/list navigation or an independently scheduled refresh, then apply the configured completed policy. Verify actual intent-driven updates and rapid repeated taps on an installed widget. Do not claim a precise removal delay unless that native design is proven. Show completed must allow binary correction; an amount's correction opens named Undo in Day details.

## 8. Options considered

| Option | Benefit | Failure / choice |
|---|---|---|
| Five miniature section cards | Looks structurally like the app | Headings/boxes consume Medium; large lists still overflow. Reject as default |
| Large with compact headings per visible group | Clear section boundaries, more room for long status text | Variable capacity and orphan-header handling; keep as alternate to test against compact row context |
| One-column list + section context + configured scope | Works for names, mixed inputs and chosen sections | Must prove compact labels do not crowd long names; preferred first study |
| Automatically switch section by clock | Feels timely | Hides earlier unfinished work and changes a person's order; not default (U13) |
| Two-column tiles / icon grid | More items at a glance; some direct demand | Less room for names, units, quit clocks and accurate step meaning; separate compact-favourites design |
| A scrolling replica of Today | Everything remains inside one surface | Ordinary WidgetKit scrolling is unavailable; not a viable implementation |
| Summary-only counts | Very clean | Does not answer which task to do or allow useful mixed logging; supplementary Small, not the Today list |

## 9. Current code findings and handoff

Audited local branch `codex/daily-widget-layout-oct5` at base `d4038444`, whose nine previously audited widget/goal source files match fetched main `f0e52f46`. This is not a fresh claim about remote HEAD after that fetch. No runtime edits were made here.

- `iOS/Shared/PhoneWidgets.swift`: Today already supports Small/Medium/Large. Agenda chooses fixed row capacities and slices rows into pages. Row captions are small, quick-control glyphs are 27/30 points, and footer paging is already implemented. Actual hit regions still need device verification.
- `iOS/Shared/WidgetIntents.swift`: agenda configuration exposes only Show completed and Tasks only. There is no section picker. Check/add intent exists; duration/checklist/quit need app routes in the current implementation.
- `iOS/Shared/WidgetSnapshot.swift`: `WidgetItem` contains no section ID/name, placement membership, section order or running-session descriptor. Its agenda includes planned ongoing items, and hides done positive items unless Show completed is on. Snapshot facts must be expanded before the proposed content selection/layout is feasible.
- `iOS/Habits/Model/HabitStore+Widgets.swift:21`: snapshot sorting puts **all habits ahead of tasks**, then uses the first placement's `sections` position. This differs from app `todayCards` ordering and mixed habit/task order. Quit has no placement, and limit placement is not the app's dedicated restraint-card routing. Do not build new section semantics on this sort.
- `iOS/Habits/Today/TodayView.swift:340`: `rowsBySection` supplies each placement in mixed saved order; rendering iterates `todayCards`, routes quit/limits separately, and keeps paused items separate. Its semantics are the reference, not a reminder-time sort.
- `iOS/Habits/Model/HabitStore.swift:557` / `:635`: shared progress across placements; person's movable Anytime/Quit cards and chronological timed sections. Reuse these facts in a cached widget projection (S5/S8/S16).
- `PhoneWidgetEntry.pageKey` uses kind/family/Tasks only/Show completed, not a section selection or independent instance ID. Equal configurations share pagination. A new scope must enter the key; if independent duplicate-widget paging is promised, its instance identity needs a deliberate design and native test. Do not claim independence currently exists.
- Existing list links open Today generally; the proposed selected-section destination must be added and verified before the header can promise to open that exact scope.

Build the projection once in the store: eligible unique items, stable IDs, all section memberships, canonical first placement, selected scope, mixed saved order, ongoing/actionable counts, honest goal status and validated action routes. The same frame must drive page contents and counters. Adding transient page state must not modify habit order. Every logging intent still validates the shown logical day, current configuration, entry deduplication and privacy before storing (D7). Page changes write no habit logs.

Keep All Today/section selection/basic checks and valid amount increments free. Paid density/history/style variants can add value later; do not create a basic-list defect or artificially conceal overflow to drive upgrades. This continues the existing research proposal, not a newly accepted pricing decision.

## 10. What must be proved before final design/build acceptance

Compare the compact-context and compact-heading Large layouts using real 24-character names, longest allowed units and long custom section names. Then derive Medium from the winning row model. Cover: all five default sections; moved Anytime/Quit; custom Night; empty Morning; 1/5/20/100 items; five free habits plus unlimited tasks; only quit/limits; all positive items done; mixed ongoing/done; Show completed and Stay in Place; several-section shared-progress habit; weekly/monthly quantity/time; running timer; long named checklist; renamed/deleted selected section; two differently scoped widgets; equal-config shared/independent paging; last-page completion; day rollover/custom day start, DST and travel; stale actions; disabled privacy; light/dark/tinted/clear; accessibility text and VoiceOver.

Native acceptance requires an actual Home Screen install, safe distinct tap regions, legible text/status, rapid logging without replacement under the finger, correct deep links, page persistence and correct disk state after relaunch. Run the relevant CI/performance checks only when implementation is ready and after T10 coordination; the phone remains the layout authority (U9). This research does not complete Current Work item 9.
