# iPhone Widgets — Types, Native Setup and Free vs Plus

Written by Codex, 5 October 2026.

**Research and editable design proposal, awaiting review.** This answers Current Work Checklist **9**. It does not change app code, purchases or accepted product rules. Physical-iPhone validation and implementation remain open under Rulebook U9/W1. The captured request and point-by-point audit are in [the research checklist](<../../../../../iOS/Docs/Checklists/Widgets — Research and Figma Brief — 5 October 2026.md>).

The recommendation is a useful free daily routine—independently selected habit squares, named Today/Tasks lists and Lock Screen access—with Plus selling compact favourites, readable history and optional focus/appearance styles. **Choosing the right habit, changing it later and logging reliably are core behavior in both plans.** Do not introduce a second allowance for widget copies or move the already-built large free list behind Plus.

Editable designs: [Free widgets](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3114) · [Paid widgets / Plus](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3116). These are research specimens, including explanatory system-UI proxies; they are not installed widgets or approved final screens.

## 1. What the assumptions get right, and what changes

| Assumption/question | Finding | Recommendation |
|---|---|---|
| Free means five habits per week | The checked-out `HabitStore.freeHabitLimit` is five **unarchived habits at a time**. The creation count excludes tasks and includes paused habits that are not archived. It is not a weekly reset. | Say “5 habits free”; explain active/unarchived allowance where needed. Do not imply that five new habits become available every week. |
| One square widget for one habit | Useful and supported by native Small widgets. Each installed copy can retain a different selection. | Let a free user make Water, Stretch and Read squares independently. Five habit slots do not mean five widget slots; duplicate copies are allowed. |
| A large widget holds all tasks | It can provide access to the whole list, but cannot display infinitely many rows at once. Tasks, including repeating tasks, are unlimited in the current model. | Five readable visible rows in the large specimen, native page actions and Open Today access. Avoid a hidden cut-off at a paid boundary. |
| The user should choose a habit while adding | The native gallery chooses widget kind/size. Configuration is normally edited through **touch and hold → Edit Widget**. We cannot promise an app-controlled chooser before Apple's Add Widget action. | Explain selection in gallery description, show an honest unselected widget, then use the system picker. Teach the native path in the Widgets guide. |
| There is no way to change the selected habit | Current source already declares a selectable App Entity parameter and supports later editing. The installed experience reported by the user differs from this source. | Treat this as a real unresolved experience issue; prove the actual installed kind/build and picker on iPhone before declaring the cause or fix. |
| Progress should motivate | Reviews support this for some users; broader experimental research supports progress monitoring. It does not prove that a particular widget, streak or heatmap increases retention or purchases. | Show meaningful progress without grading, guilt or a mixed score. Keep alternative layouts and respect Show Streaks. |
| Basic free widgets should encourage upgrading | A useful free routine can coexist with optional paid layouts. Reviews also show anger about basic-widget paywalls, lost free features and paid broken widgets. | The upgrade reason is convenience and presentation beyond the basic routine. No forced purchase in a logging path, broken previews or habit-selection paywall. |

Code anchors: [HabitStore](<../../../../../iOS/Habits/Model/HabitStore.swift>), [WidgetIntents](<../../../../../iOS/Shared/WidgetIntents.swift>), [PhoneWidgets](<../../../../../iOS/Shared/PhoneWidgets.swift>). These findings describe this branch's source, not the user's installed binary or the actual StoreKit purchase system.

## 2. Evidence: scope and confidence

The September [Home Screen Cards and Widgets study](<../Home Screen Cards and Widgets.md>) reports **7,844 reviews read; 7,818 widget-coded reviews in 151 apps**, across App Store and Play Store, November 2011–September 2026. Its figures below are **historical reported counts**. Its complete `Research/Temp/homescreen/codes` classification is absent here, so those totals cannot be independently rebuilt in this checkout. Do not treat the historical aggregate as a new iOS-only result.

The [Free Plan Design study](<../../../Business Model and Monetization/Free Plan Design — Habit Cap, Widgets and an Honest Listing.md>) is a separate targeted study: 977 records read, 790 relevant, 112 apps. Its widget counts must not be added to the September widget study. The [30 September logging report](<Historical Research/Widgets — Tick Without Opening the App.md>) and [1 October implementation report](<Historical Research/iPhone Widgets — Research and Implementation.md>) are also reused with attribution; their changing scan definitions are not trend measurements. The separate [Day Marks study](<../../../Progress and Statistics/Day Marks — Heat Map, Rule and Palette.md>) and [Weekly Habit Cards study](<../../../Progress and Statistics/Weekly Habit Cards — What Each Card Shows.md>) inform consistency with the redesigned Progress surfaces; their methods and denominators differ from widget-specific coding.

This pass performed three distinct jobs:

1. **Fresh inventory:** all 216 eligible numbered source files, 1,238,784 records. App Store: 337,331 records / 70 files / 6,822 lexical candidates. Play Store: 901,453 / 146 / 13,590. Total widget-word candidates: **20,412**. Multilingual matching includes Japanese, Korean, Chinese, Russian, Arabic/Persian and Hindi spellings, plus common English variants. Insufficient-volume subfolders are excluded. This is machine inventory, not human reading or style popularity.
2. **Complete-original audit:** **181 records read individually**, 128 App Store and 53 Play Store, across 45 numbered app corpora. This combines originals cited by earlier widget/free-plan reports, the 43-record iPhone evidence file, the earlier logging citations and **all 67 available Dots reviews**. Full text, exact source indices, stable review IDs and human theme assignments are in [Verified Review Sources](<Verified Review Sources.json>) and [the complete per-review index](<Verified Review Index.md>). Verification: 181 exact source matches; zero unknown references, within-theme duplicates or unassigned records. General app-context records remain explicitly labelled.
3. **Current primary-source checks:** Apple guidance, creator help pages and live store listings; competitor policies are dated to this research. Older reviews describe the policy/version at the time of writing. A developer roadmap is not proof that a feature shipped.

**What remains unaudited:** the full 20,412-candidate fresh inventory has not been reread and hand-coded in this pass, and the missing September map has not been recovered. Therefore this is a detailed synthesis and source audit, not a new exhaustive review census. It cannot establish an exact “most popular among iPhone users” ranking, a market share, a complaint-free plan or a purchase-conversion forecast. Neither countries with small samples nor Android requests support an iOS-specific prevalence claim. Old iOS Today-extension reviews establish historical needs, not modern WidgetKit capabilities. Sources do not permit a comprehensive review-burst/solicitation adjustment; creator giveaway threads are excluded from demand counts.

Reproduction: [tools and instructions](<../../../../Tools/widget_catalogue/README.md>), [scan and verification summary](<Scan and Verification Summary.json>). Raw store files were not changed. This separation follows W2: review evidence establishes the need; competitor behavior is a pattern to investigate, not authority.

## 3. What people actually value

The following percentages all use **7,818 historically widget-coded reviews**, across both platforms and the study's 2011–2026 period. Themes overlap. Praise, request and complaint are separate signals; these figures are attributed to the September study and not independently reconstructed.

| Need/style | Historical signal | Verified examples | Implication |
|---|---|---|---|
| Home Screen visibility | 788 mentions, 10.1%; reported 4.78★ | A43#358; A10#2775; A3#5428 | A reminder people actually see can matter more than another dashboard. Show the selected person's data. |
| Quick interaction | 1,100 mentions, 14.1%; includes 496 requests and 324 praise | A7#833; A33#164; A52#20487 | Logging must work from the widget for supported types. One tap adds one step, not the remaining goal. |
| Whole-day list | 426 requests, 5.4%, in 56 apps; 45 praise, 0.6% | A10#2775; A33#1602; P3#2935 | Make a named overview the default recommendation. Many requests come from Android; do not call this an iOS ranking. |
| Individual squares | 82 check-tile praise, 1.0%, of which 74 concern Android Loop; 44 single-habit praise, 0.6%; 65 clutter complaints, 0.8% | P3#11092; A3#2623; A1#55119 | Offer one-habit tiles, while a multi-item option prevents five widgets from crowding the phone. Android's tiny tiles do not imply an iPhone 1×1 family. |
| Week history | 61 praise, 0.8%; 54 requests, 0.7%; 35 complaints, 0.4% | A76#2527; P24#15545; P24#15751 | A rolling seven-day option can avoid an empty Monday. The strongest rolling-week example is Android and remains cross-platform evidence. |
| Calendar/month and heatmap | Calendar: 76 praise, 1.0%, 107 requests, 1.4%; heatmap: 24 praise, 0.3%, 16 requests, 0.2% | A7#576; A56#47; P9#515; P65#4560 | Make history readable and named. Do not add calendar and heatmap counts: coding can overlap. |
| Streak display | 55 praise, 0.7%; 121 requests, 1.5% | A1#54551; P19#272; P4#3474 | Optional focus style. A lost streak or pet is not a universal motivation model. |
| Counters | 61 counter praise, 0.8%, including 48 Days Since; 159 numerical-counter mentions overall, 2.0% | A3#5428; A3#2110; P3#3999 | Real amounts and days since a slip/start are useful. The 159 are not all quit-counter requests. |
| Lock Screen | 73 praise, 0.9%; 100 requests, 1.3% | A1#47724; A3#2439; A3#1218 | Include accessible glance/deep-link families; keep delicate quit actions out of the lock surface. |
| Reliability | Broken/stale union 1,226, 15.7%, 80 apps; reported 3.27★ | A33#1034; A33#3195; A23#3669 | Correct committed state and day rollover are release gates, ahead of decorative variety. |
| Widget paywall | 342 mentions, 4.4%, 41 apps; reported 2.48★ | A36#273; A1#378; A3#2110 | A working basic widget stays useful indefinitely. Do not sell a promise that the installed widget fails to deliver. |

Two qualifications change the interpretation. First, the earliest calendar/app-progress examples are sometimes **app views**, not widget-specific praise; their labels in the evidence index reflect that. Second, A33#1143, previously cited beside “keep completed” preferences, asks for completed tasks to be represented correctly instead of appearing incomplete. It supports **state accuracy**, not an unambiguous preference to keep done rows. Preserve the old report as historical; do not use that example to justify the default.

### Appearance and density

The same historical study reports customization 214 / 2.7%, transparency 69 / 0.9%, dark/system appearance 78 / 1.0%, font settings 64 / 0.8%, contrast 33 / 0.4% and size 312 / 4.0%. Size subthemes include 177 wasted-space mentions and 118 requests for other sizes; subthemes overlap. These are broad themes, not a vote for a single visual template.

The originals give sharper guidance:

- **Keep visible names by default.** A1#55119 wants words instead of emoji; A36#190 cannot distinguish unnamed habit widgets. P3#11777 has the same ambiguity with several transparent buttons. A52#20487 nevertheless prefers an older icon-oriented routine widget. Therefore names by default plus an explicit icon-only option resolves a real tradeoff.
- **Offer quiet, clear presentation.** Dots A56#18 praises minimalism and in-place checking; A56#9 likes seeing day-by-day dots; A56#29 likes varied widget designs; A56#47 asks for several habits' history without several separate widgets. None proves that all users want the same density.
- **Optional color has value.** A3#10509 requests widget colors; P37#439 wants more than black/white; A13#18314 reports buying colorful icons, but concerns general app customization. This is supporting context, not proof of a paid widget color scheme's conversion.
- **System appearance is core usability.** A10#3798 requests visible dark/tinted widgets; P2#8373 dislikes a glaring white widget at bedtime. Dark, tint, clear adaptation and sufficient contrast belong to both plans.
- **Keep completed visible on a single habit tile, but default lists to remaining items.** A53#702 and A1#45378 complain about crowded done rows; A52#19868 praises disappearance. Give lists a free Show Completed option. Settle/reorder only after interaction, preserving U4's protection against moving targets.

The separate Day Marks study estimates roughly 210 genuine positive heatmap mentions, 100 check/cross-calendar mentions, 90 drawn-chain mentions, 75 ring mentions (about 30 about history), 18 dots and 17 stamps. **These are sample-adjusted estimates**, based on 4–5-star lexical matches and hand-check subsets of 30–80 records per style, across a roughly 1.237-million-record multilingual corpus—not exhaustive hand-coded widget counts or iPhone preference shares. That study reports uncertainty of about 10–15 percentage points in the estimated genuine share and uses stars as an initial sentiment proxy. Its directional heatmap lead is useful supporting evidence, but cannot establish a universal winner, or be added to the widget table. The accepted square/HeatPalette system gives this app a stronger consistency reason to use squares than copying a competitor's dots or circles.

**Recommended default:** neutral system card, SF Pro, recognizable SF Symbol, habit color for identity/progress, visible name and one meaningful actual-unit status. **Optional Plus styles:** compact grid, soft habit-colored background and focus typography. Do not adopt decorative custom fonts, illegible transparency, unlabeled circles by default, a quote/pet catalogue, or many nearly identical size variants at launch.

## 4. Current competitors, with the improvement we should make

These are current creator statements/store listings checked on 5 October 2026, not hands-on installations. Review examples are historical user evidence. We do not claim parity, exact purchase conversion or present-day reliability.

| App/pattern | Current primary-source finding | User evidence and adaptation |
|---|---|---|
| HabitKit | Creator describes Pro Home Screen widgets: single habit Small/Medium, compact three-habit history and large eight-habit history; no Lock Screen widget. Selection is through Edit Widget, with a first-habit default when no habit is chosen. Compact rows use icons without names. | A7#576 describes widgets as worth the money and enjoys the squares; A7#833 praises interactivity. Adopt readable history and independent selection; improve the default with an explicit choose state and names. [Widget help](https://habitkit.app/help/widgets/add-a-habitkit-widget-to-your-home-screen), [selection help](https://habitkit.app/help/widgets/choose-which-habits-a-widget-shows). |
| Habitify | Creator help documents Today, chain and heatmap widgets, including weekly/monthly goals and limits, plus several history ranges. | A33#164 objects to one tap completing an entire repeated goal; A33#3195 reports empty paid heatmaps. Adopt useful range choices and actual units; preserve incremental logging and durable updates. Avoid copying over-limit red treatment. [Creator guide](https://intercom.help/habitify-app/en/articles/11373890-how-to-add-homescreen-widgets). |
| Streaks | Paid app emphasizes customizable icons/themes, up to 24 tasks, widgets and progress. Current exact widget capacity was not independently established here. | A23#4768 requests restoration of a 12-task medium widget; A1#55032 dislikes its circle-based **app** interface. Compact layouts have fans, while circles are not universal. Offer compact squares/symbols with optional names, never assume a historical 12-item request is the current catalog. [Store listing](https://apps.apple.com/us/app/streaks/id963034692). |
| Things | Creator documents independent list/project/area/tag widget choices, optional checkboxes, interactive completion on iOS 17+, and Lock Screen shortcuts/progress. | Task-specific customization is reasoned from first principles: the person wants a particular task list, not habit statistics. Put explicit task filtering in the free list and consider area/group filters after the basic selection problem is proven. [Creator support](https://culturedcode.com/things/support/articles/2803567), [interaction announcement](https://culturedcode.com/things/blog/2023/09/interactive-widgets-and-more/). |
| Days Since | Current listing emphasizes counters and widgets; recent reviews describe a free-to-paid transition and developer responses mention preserving existing widget access. | A3#5428 likes the counter; A3#1937 warns about accidental reset; A3#2110 dislikes withdrawing previously free support. Keep a readable free quit counter, with slip/correction inside the app. [Store listing](https://apps.apple.com/us/app/days-since-quit-habit-tracker/id1445348921). |
| Dots | Current US listing says three free habits and Pro for unlimited habits, while listing widgets among the included experience. Some cached regional listings still describe the older unlimited-free model. | All 67 available originals were read. A56#59 praises free useful widgets, A56#47 requests combined history, A56#6 reports opening the app instead of incrementing, and A56#28 wants more widget capacity. Minimalism is a competitive baseline; paid history cannot be justified merely because another app charges for widgets. Historical “unlimited free” praise is not its current entitlement rule. [Current listing](https://apps.apple.com/us/app/dots-habit-tracker-widget/id6758730376). |
| HelloHabit | First-party developer posts describe single-habit widgets, later group widgets, and requested month/year views. A 2026 roadmap response is a plan, not verified shipment. | Transfer the multiple-widget/group need cautiously; developer explains iOS cannot scroll like Android. Do not count giveaway responses as independent prevalence. [Developer discussion](https://www.reddit.com/r/hellohabit/comments/1nlm12t/), [history request/roadmap](https://www.reddit.com/r/hellohabit/comments/1tujq6w/widgets/). |

No competitor's screenshots or visual identity were copied into the repository. The Figma uses editable iOS library shells and Often Enough's existing semantic colors/HeatPalette.

## 5. The native iPhone experience

### Home Screen

Apple's documented path is touch and hold an empty Home Screen area, Edit → Add Widget, choose an app/widget and size, Add Widget, then Done. Later, touch and hold the installed widget and choose Edit Widget; tap outside to finish. Lock Screen widgets use the Lock Screen customization flow. Smart Stacks are an iOS feature, not something to sell as Plus. [Apple Support](https://support.apple.com/en-us/118610).

In our guide, say: **“Add a One habit widget. Touch and hold it, choose Edit Widget, then choose Habit.”** Include a short native illustration and a tappable “How to add” explanation in the app's Widgets guide. Do not force an onboarding tour or repeatedly teach the flow to someone who has completed it.

Apple's configurable-widget model uses an App Intent configuration with parameters and an App Entity query for the available habits. WidgetKit presents the picker. Each instance retains its own selected entity. We control the meaningful parameter names and choices, not Apple's entire gallery/editor or an arbitrary pre-add wizard. [Apple configuration documentation](https://developer.apple.com/documentation/WidgetKit/Making-a-Configurable-Widget?changes=__3_2).

The desired states are:

| Situation | Display and next step |
|---|---|
| Gallery | Clearly illustrative preview; title “One habit”; description explains the later Habit field. Sample Water is not secretly selected data. |
| Added without selection | “Choose a habit” with touch-and-hold → Edit Widget guidance. Do not silently pick the first alphabetic/newest habit. |
| No habits yet | “Create a habit” and Open App. Empty content is not a subscription problem. |
| Selected Water | Water, real amount/unit, applicable action. Changing another widget leaves this selection intact. |
| Renamed/reordered habit | Keep the UUID selection; update the visible name. A reordered list must not change a selected entity. |
| Archived/deleted/unavailable selection | “Choose another” through Edit Widget. Never substitute a different habit. A previously saved selection still resolves to an honest unavailable state. |
| Task-only widget | Native task filter; the whole free task list stays reachable. Do not make tasks compete with habit allowance. |
| Several chosen habits | Compact favourites uses explicit per-slot selection, duplicates removed predictably and stable ordering. Names default on; icon-only is a chosen option. |

The current source's optional `WidgetItemConfiguration.item` already points to the entity query. `itemEntries` does **not** fall back to the first habit; it distinguishes unselected and unavailable states. The gallery's placeholder uses sample content. `AgendaWidgetConfiguration` has Show Completed and Tasks Only, but no explicit chosen subset. `WidgetHistoryQuery` currently reuses the broad item query, so task exclusion needs an implementation acceptance check. The current label “Habit or task” is sensible for One Item; a habit-only picker must say “Habit”. Do not disguise tasks as history-bearing habits.

The user may have an older build, a different installed kind, a configuration/extension issue or unclear guidance. Source review does not distinguish those causes. The **first physical-device acceptance case** is adding two One Item widgets, opening their system editors, selecting different UUIDs, changing one later and cold-launch logging. No mockup or simulator screenshot proves this issue fixed (U9).

### Families, size and “icon-only”

On iPhone, Home Screen widgets use Small, Medium and Large families, with device-dependent dimensions. The examples use approximately **158×158**, **338×158** and **338×354 pt** for a common phone geometry; these are design references, not hard-coded universal sizes. An icon-only **layout within a widget** is possible; an arbitrary one-app-icon-size 1×1 Home Screen widget is not an iPhone WidgetKit family. Accessory inline, circular and rectangular serve the Lock Screen and have their own tight constraints. [Apple widget design guidance](https://developer.apple.com/design/human-interface-guidelines/widgets?changes=_3).

There is no freely scrollable widget view to promise. Work within WidgetKit's supported links and intent-backed controls: readable bounded lists, page actions when they fit and a direct Open Today route. Pages must preserve selection, order and all tasks, and must not create broad app redraws. Medium shows two 44-pt item actions and opens Today for the rest; Large has five item rows plus distinct 44-pt page actions. Dynamic Type may reduce those counts. These row counts are design proposals pending native testing, not claims that the current extension already implements the revised density.

### Interactivity and correction

Apple supports intent-backed Button/Toggle interaction for widgets. The action must persist its result before returning so WidgetKit can render consistent data; arbitrary gestures, text entry and a full app UI do not become available merely by drawing them in Figma. [Apple WWDC23: Bring widgets to life](https://developer.apple.com/videos/play/wwdc2023/10028/).

| Habit/item type | Widget action | Honest visible progress |
|---|---|---|
| One-time daily check | Add one check; once complete, show Done without a destructive second tap | Done / Not yet, for the real logical day |
| Repeated check goal | Add one tick, not the remaining target | 3 of 8 glasses, with the action saying what one tap adds |
| Amount, known increment | Add the saved positive increment, with unit; if unknown, open entry | 750 of 2,000 ml, not an unexplained percent |
| Timer/duration | Open the selected timer/day details; do not claim a tap starts a working widget timer in this proposal | 10 of 20 min; actual running state if later implemented |
| Checklist | Open the existing checklist details | 2 of 4 steps, if that is the actual data; no invented binary completion |
| Limit/cut down | Read status and open Day details for logging | 1 of 2 cups; “Within limit so far”. No bar urging consumption to the ceiling |
| Quit | Read counter; open details for a deliberately recorded slip | 12 days since latest slip/start. No reset/slip button on the widget |
| Task | Mark the selected task complete | Task text and completion. No task streak, heatmap or blended success score |

The checked-out widget action already follows an additive, durable-write approach. Keep that intent rather than selling interactivity as Plus. A wrong addition is corrected through the app's named Undo/history action. Widget completion and the in-app Today toggling surface can have different safety behavior, but their labels and help must make that difference clear. Do not promise a widget's checked button silently removes data.

## 6. What progress belongs in each layout

Your motivation assumption is plausible, with boundaries. Harkin et al.'s meta-analysis of **138 randomized studies, 19,951 participants** found a positive average effect of progress-monitoring interventions on goal attainment, **d=0.40, 95% CI 0.32–0.48**. That is broad behavioral evidence; it is not an experiment on iPhone widgets, this app, heatmap aesthetics, streak anxiety or paid conversion. [Primary study abstract](https://pubmed.ncbi.nlm.nih.gov/26479070/).

Review examples supply the widget-specific reasons: A3#5428 says a visible counter motivates; A7#576 values filling squares and calls the widgets worth the money; A56#9 likes day-by-day progress; A56#63 describes guilt as motivating. We should not copy that last user's guilt language into the product: U3 explicitly requires neutral presentation. A4#7692 and A43#358 like percentage/grade feedback, whereas A20#576 finds percentages confusing. The accepted Progress system uses real units and no mixed percentage. A preference example does not override an accepted product rule.

| Layout | Lead fact | Secondary display | Do not put here |
|---|---|---|---|
| Small one habit | Real current status or amount in the goal's own period | Minimal honest progress bar for a reach target; applicable action | Tiny month grid, mixed habit score, a goal-chasing bar on a limit |
| Medium/large Today and Tasks | Names and remaining actionable items | Per-row amount/period and current completion | A total percentage that mixes tasks, daily habits, weekly goals and quit counters |
| Compact favourites | Symbol, default-visible name, actual status | Explicit log/open meaning and full accessibility text | Five indistinguishable anonymous circles or success inferred from color alone |
| Last seven days | Named habits and a stated rolling range | 24-pt day squares; current-day outline; historical marks open Progress | Today toggles on historical squares, tiny unexplained dates or an invented weekly “failure” |
| Month, Large | One habit, current calendar month, meaningful headline | Full month at 24-pt minimum; correct neutral/sign states | Numbers inside squares; a misleading arbitrary 96/216-day range called “Month” |
| Year summary, Large | One habit and year, real accumulated days/amount | Twelve monthly bars; partial current month explicit; opens Year | A squeezed 365-square heatmap, a completed future month, unfair full-period comparisons |
| Optional streak focus, Small | Current streak with correct day/week/month unit | Best streak as one different fact | A forced streak, a task streak, or contradictory streak count in the wrong clock |
| Lock Screen | Identity where possible and one useful value | System material and direct selected-item route | Mini dashboards, sensitive notes/account data, destructive controls |

Follow the [accepted Progress rules](<../../../../../iOS/Design Rules — Don't Regress.md>) under U12. The same heatmap language applies to Week, Month and Year: rounded squares; color strength for how much; ✓ for goal met/more; grey × for a finished uncompleted day; skipped/paused neutral; future/current incomplete grey; only not-scheduled dashed; before start blank; today a thin outline. No date or number inside a square. A week/month target gives each day its fair share rather than inventing a daily goal. Historical schedule/goal revisions must be respected.

**Never shrink a square below 24 pt.** The app's Week/Month/Year sizes differ; 24 pt is the minimum compact-widget proposal. Large can accommodate a real month. An entire year's daily squares cannot fit at that minimum in an iPhone widget; the native alternative is a useful Year summary that opens the actual scrollable Year page in the app. This is a reasoned adaptation to accepted readability constraints, with weaker direct demand evidence than Week/Month. It is not a promise to reproduce the full app Progress surface on the Home Screen.

## 7. Proposed free and Plus boundary

This retains the current free functionality rather than taking it away. The exact purchase price and billing term are outside this request; no price optimization can be inferred from these reviews.

| Capability | Free | Plus | Why |
|---|---|---|---|
| Habit allowance | Five unarchived habits; tasks excluded | Existing broader habit allowance | The habit policy belongs to the model, not a second widget gate |
| Number of widget instances | No additional cap | Same | Choosing a different habit for each square is basic configuration |
| One habit/item, Small | Name, status, supported check/increment, change selection | Same | Small daily tracking is a complete basic tool |
| Today, Small/Medium/Large | Summary or named list, all content reachable, Show Completed | Same | This catalog already exists free; avoid withdrawal complaints |
| Tasks-only list | Free native task filter, Large and other useful Today sizes | Same | Unlimited tasks must remain useful on the phone |
| Lock Screen | Selected-item and Today summary families | Same | Glance access is basic; existing free families stay free |
| Light/dark, tinted/clear, Dynamic Type, VoiceOver | Included | Included | Accessibility and system adaptation are not cosmetic extras |
| Compact favourites, Medium/Large | Useful named-list alternative | Chosen subset/grid; labels default on, optional icon-only | Home Screen convenience and saved presentation are added value |
| Week/Month history | Current status and access to app Progress | Readable widget history | Additional glance depth; ordinary app data access stays free |
| Year summary | App Year access remains governed by existing app policy | Optional summary layout; validate demand before building | Richer glance view, less direct widget evidence |
| Goal/streak focus | Essential current goal/counter status | Optional typography/layout focus, respects settings | Sell a presentation, not the underlying record |
| Soft habit-colored background | Default neutral card and habit identity color | Optional fuller surface style | Some customization interest; conversion is unproven |
| Configuration, updates, offline logs, privacy, corrections | Complete and reliable | Same | These do not become paid quality tiers |

The separate Free Plan study reports **25 basic-widget-paywall complaints** (25/790 relevant reviews, 3.2%, reported 1.72★) and **26 free-widget praise** (3.3%, 4.92★). It also reports **17 willing/happy widget payers** (2.2%, 4.76★), **7 free-feature-withdrawal complaints** (0.9%, 1.29★) and **29 paid-but-broken widget complaints** (3.7%, 1.62★). Scope: that targeted, cross-platform 112-app study, its archived collection period; counts overlap and are historical reported figures. Representatives include A36#273, A7#576, A1#378, A33#1034; complete original IDs are in the evidence index. These signals support a useful free core plus optional paid depth. They do not show an optimal paywall or conversion rate.

“Enough friction to upgrade” should mean a meaningful choice: five separate free squares or a paid compact favourites layout; free current status or richer paid history at a glance. It should not mean an inconvenient picker, unreliable check-off, a compulsory purchase sheet or a blurred demo that replaces a person's working widget. Users may reasonably remain free forever. We cannot guarantee zero complaints while still withholding optional layouts.

Upgrade discovery belongs in the app's quiet Widgets guide: Included / With Plus, truthful visual previews, See Plus and Restore Purchases. The gallery may identify a paid **layout**, but daily controls never open a paywall. On entitlement loss, preserve the entity selections and stored records, show a useful free list/status fallback, and restore the paid presentation when ownership returns. Verify purchase/restore/refund/expiry in the real entitlement system; a debug `isPlus` flag is not proof. Backup/export/sync safety stays free under D4/D10 regardless of older monetization research.

The older [Plus and Subscription Deep Dive, §2.5](<../../../Business Model and Monetization/Plus and Subscription Deep Dive/Plus and Subscription Deep Dive.md#25-widget-designs>) also argues for selling designs rather than access. Its broader proposed catalogue includes rings, photos, per-widget themes, glass and a year grid, with Streaks 6 screenshots from 2020 as illustration. This pass narrows that proposal: the accepted app uses square day marks; 24-pt minimum prevents a full-year iPhone heatmap; system glass/tint and accessibility belong to both plans; useful free Large/Lock families must stay free. Photo/quote/pet packs and eight-to-ten additional launch layouts lack enough specific value evidence for this app to become immediate build scope. The old report's Dots free-plan correction is consistent with the current listing check; it still does not establish which individual Dots layouts are Pro-only. Its claim that customization is a leading stated purchase reason is historical report evidence, not a new conversion estimate or an independently rebuilt ranking.

## 8. Visual and behavior contract for implementation

- **Native, consistent:** SwiftUI, SF Pro and SF Symbols; app semantic colors and generated HeatPalette. The studies reuse existing Day sheet tokens and iOS library shells. U1/U2/U12 apply. The Figma system gallery/editor drawings are explanatory proxies, not exact Apple screenshots or app-owned screens.
- **Readable before dense:** Small uses one useful fact, Medium a short named list or focused history, Large a meaningful expanded view. Long names truncate visibly with full VoiceOver names; actual-unit strings and action labels take precedence. Use minimum readable marks and honest fewer-row layouts for accessibility text sizes.
- **One clear action:** 44-pt target intent for logging and Large paging in the proposal; verify on native device. Body tap opens the corresponding item/Today/Progress surface. A history view does not accidentally rewrite an old day. The compact symbol buttons need clear per-type add/check/open meaning, not an anonymous color-only control.
- **System appearance:** Check `widgetRenderingMode`; assign accent groups deliberately; preserve glyph/name/value hierarchy if iOS removes the background. Tinted and clear rendering can transform the colors/material; do not rely on a paid background always appearing. [Apple accented/clear guidance](https://developer.apple.com/documentation/widgetkit/optimizing-your-widget-for-accented-rendering-mode-and-liquid-glass), [WWDC25 widget update](https://developer.apple.com/videos/play/wwdc2025/278/). Figma tinted/clear illustrations are conceptual; actual wallpaper/glass is unverified.
- **Durable interaction:** Commit once, then refresh the snapshot before an intent completes. Use system invalidatable content where appropriate while a write is pending. Failed storage does not become a successful mark. Keep UUIDs and historical entry IDs stable across cold launches, retries and duplicate invocations.
- **Correct day:** Local Calendar/day-start/week-start rules apply to scheduled timelines and taps. Reject/refresh yesterday's stale action rather than silently logging against the wrong day. Test travel, DST, custom day start, paused/skipped habits and app-not-open-for-days behavior (D7).
- **Offline and privacy:** The local database is authoritative (D1). Widget snapshots contain only needed bounded projections, not journal text, tokens or account details. The user can hide content; locked/corrupt/missing/expired data gets an honest Open App/update state. No invented empty success.
- **Speed:** Compute history once outside view bodies; bounded per-habit snapshots; coalesced publication and an immediate committed snapshot for an explicit widget action. Respect S5/S8/S16. Do not repeat heavy year/month aggregation for every app tap or timer tick. Measure new widgets/guide openings rather than infer speed from Figma (S2).
- **Compatibility:** Keep stable existing widget kind IDs and saved configurations. Add missing parameters carefully; old instances migrate or retain an honest free fallback. No background change may swap a chosen habit.

## 9. Figma delivery and build order

Two new sections are on the supplied **inspiration** page, to the right of existing studies:

**Free:** two independent one-habit Small examples; Today Medium/Large; task-only Large; done, quit and limit states; small summary; three Lock Screen family proxies; native add/edit/pick journey; unselected/unavailable/privacy/recovery states; dark and conceptual tinted/clear variants.

**Paid / Plus:** compact named favourites and an actual optional icon-only example; last-seven-day strip and a readable Small history alternative (seven 24-pt marks wrap over two rows, with stated range and accessibility order); Month Large; Year summary Large; goal focus Medium; streak focus Small; neutral/soft-fill/dark style comparison; configuration and upgrade/restore guide; entitlement fallback notes. The Small history variant preserves a useful existing family; its interpretation needs usability testing rather than assuming a wrapped row is self-explanatory.

The editable study has reusable widget components, SF Pro text, SF Symbol glyphs, semantic light/dark variable bindings and the app's generated heatmap colors. The base audit found no bitmap fills, foreign fonts or clipped-content overflow. Final structure/screenshots and any remaining design cautions are recorded in [Figma Delivery](<Figma Delivery.md>). Screenshot inspection proves composition only, not material accuracy, purchases, interaction, accessibility or speed on iPhone.

| Priority | Work | Reason / completion evidence |
|---|---|---|
| P0 | Prove selection in the installed iPhone build | Two widgets with different habits, later change one; no default substitution; identify exact kind/build |
| P0 | Correct cold actions, stale/day rollover, privacy and purchase fallback | Native correctness matrix below; preserve free access and durable entries |
| P1 | Polish useful free list/one-habit layouts | Readable names, real units, no cramped targets; task-only configuration; native screenshots and accessibility |
| P1 | Compact favourites, Week and Month | Strongest additional convenience/history direction, with usable free alternative |
| P2 | Year summary, goal/streak focus, softer surfaces | Lower direct widget evidence; usability and purchase-value validation before broad build |

Existing simulator documentation includes installed Home Screen and cold-action checks, but Lock Screen picker coverage was skipped and previous performance results include failures. They are not a current physical-phone sign-off. No CI was dispatched for this research-only change; future pushes/test runs must read T10 and check live repository-wide Actions before starting any tagged work.

## 10. Acceptance matrix and research follow-through

| Check | Required result | Status in this research |
|---|---|---|
| Native add/edit on phone | Distinct selected UUIDs survive changes, reboot and cold launch | Pending implementation/device proof |
| Long names, large text, VoiceOver | Names/units/actions remain intelligible; rows reduce instead of clipping | Specified; native validation pending |
| Quick log by type | Exactly one intended additive entry; no silent whole-goal or destructive action | Source audited; new design implementation pending |
| Correct state/day | App/widget agree after commit, rollover, timezone and day-start changes | Acceptance required; no new runtime tests |
| Task list | All tasks reachable without a widget paywall; paging targets and order stable | Designed; native paging/density pending |
| Week/Month/Year | Historical rules, correct ranges, neutral states and at-least-24-pt squares | Design/source alignment; native snapshots pending |
| Appearance | Light/dark/tinted/clear on actual wallpapers and supported phone geometries | Figma composition checked; system material pending |
| Paid ownership | Buy/restore/refund/expiry preserve data and useful fallback | Proposal; StoreKit integration not claimed |
| Privacy/offline/error | Honest hidden/update state, no lost entries or exposed notes | Specified; device/security acceptance pending |
| Compatibility | Existing kinds/configurations survive upgrade; no free withdrawal | Proposed contract; migration testing pending |
| Research audit | Original IDs/text match sources; attribution and platform labels explicit | 181 exact originals verified; complete historical map unavailable |
| User request audit | Detailed brief, types, styles, progress, competitors, plans and two Figma sections | Delivered; limitations retained rather than checked away |

After implementation, validate with people: ask them to add Water and Stretch without coaching, change one, log an increment, find remaining tasks, interpret a week/month mark and explain the Plus value. Measure task success, wrong-habit/wrong-day actions, update failures and time to complete the setup. Compare named versus optional icon-only layouts for people who choose them; do not force anonymous icons onto everyone. If product analytics is used, follow the existing content-free analytics proposal: no habit names, entries or screenshots in events. Paid uptake needs a properly designed experiment with refund/complaint/retention guardrails; review star averages cannot replace it.

Recover the September classification or complete a separate fresh candidate-by-candidate audit before publishing new popularity percentages. Preserve current findings as attributed directional evidence. Keep Current Work item 9 open until the app work meets W1 and annotate the separate iPhone check under U9.
