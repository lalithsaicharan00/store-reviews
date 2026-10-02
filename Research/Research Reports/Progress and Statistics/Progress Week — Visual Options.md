Written by Claude (Claude Code), 2 October 2026.

# Progress Week — Visual Options

**Recommendation: option 1, Room to read.** Give every habit its own grouped card, move its week strip underneath the text, align the icon with the title, and make the overview's completion fraction the visual anchor. Keep seven days, the decided aggregates and neutral states. Add a visible three-state key and a read-only full legend. Make current quit runs prominent, with best run and the selected week's slips underneath.

This is a research proposal, not an approved implementation. No app code changed. The user chooses an option before another agent implements it. Work starts from `claude/server-and-sync`, commit `5e2c7c5bacafb18fd4b8d573eb025580811ce7d3`, on `claude/progress-week-research`.

The [Figma Inspiration board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=238-2) contains the inspected store imagery, Apple support images, linked design references, research findings and the five option galleries. It was added using **Figma MCP**, including its asset upload API. It is an inspiration board with editable captions and citations, not an editable SwiftUI implementation screen. Third-party images stay in gitignored `Research/Temp/`; none enter this public repository.

## 1. Scope and the current problem

Keep the existing range control, period navigation, group chips and View Options exactly. Keep the `ScrollView` of grouped cards. Only Week's overview, habit presentation and quit presentation change. Month and Year need a separate decision after Week. The user's feedback mentions Week / Month / Year / All; this branch's Progress range picker actually contains **Week / Month / Year**. All belongs to the habit's Over Time view. This proposal does not add, remove or rearrange top controls.

The governing decisions remain [What to Build, in Order](<../../../iOS/Docs/Specs/Progress — What to Build, in Order.md>), [the prior Progress report](<The Progress Page — What People Need, and How to Build It.md>), [Design Rules](<../../../iOS/Design Rules — Don't Regress.md>) and [Performance](../../../iOS/PERFORMANCE.md). Group headers, group totals, group ordering and Archived remain as decided; these mockups use the ungrouped demo to isolate the requested presentation.

### Genuine before images

![Current light Week](<Week View Options/before-light.png>)

[Current grouped Week](<Week View Options/before-groups-light.png>) is a second genuine baseline. Both come from the newest [CI screenshot run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36981365705), `ios-screenshots` artifact 11217090094, matching the branch SHA above. Week is p01, attachment `0A6BFFD1-B7F5-4574-BB95-2C543329D89E.png`; groups are g10, `DE2E43C4-3657-49DF-B6A3-1A1A0670507A.png`. These are iPhone 17 Pro captures, 1206 × 2622 pixels, not resized iPhone 16 captures. The real Week overview reads 72 of 78, 92%, two full days and zero of one weekly goal.

**Capture gap:** this artifact does not contain genuine Progress Week dark-mode, accessibility-size or quit-scroll captures. Its dark screenshot is Today, not Progress. The review artifact contains no installable app, and the local installed builds are older. Root `CLAUDE.md` prohibits a local iOS build/test run. No synthetic image is labelled as a missing before screenshot. Light baseline and code inspection support the diagnosis; native before coverage remains incomplete.

### What the code actually does

Sources: [ProgressScreen.swift](../../../iOS/Habits/Progress/ProgressScreen.swift), [DayMarks.swift](../../../iOS/Habits/Progress/DayMarks.swift), and [HabitStore+Progress.swift](../../../iOS/Habits/Model/HabitStore+Progress.swift).

| User's point | Current presentation | Visual consequence and proposed response |
|---|---|---|
| Correct information feels dense | Outer horizontal padding 16; vertical padding 12; main stack spacing 22. A `ProgressCard` adds horizontal 16, vertical 10, radius 12. Habit group uses a zero-spacing `LazyVStack`, separators and row buttons. | The hierarchy inside a row, rather than the amount of valid data alone, makes reading expensive. Separate identity, quantity and week strip; retain all data. |
| Rows squeezed together | Button vertical padding 8 plus `ProgressRowView` vertical 2: effective row vertical padding 10. Separators start after the icon. | Increase vertical inset and separate cards, or keep a grouped ledger with 20-point row insets. |
| Icon centred against several lines | Centred `HStack`; 32-point icon, gap 12; title allows two lines; subtitle is subheadline and can wrap further. | Align the icon to the title's top. Move the strip out of this horizontal stack so text gains width. |
| Marks unexplained | Trailing strip reserves 126 points: seven 18-point slots with 14-point marks. Very short weekday initials appear once per group, not on every row. | Narrow text is squeezed against tiny symbols. Repeat localized short weekday names; enlarge fixed marks; show a visible key and full legend. |
| Overview merely correct | Seven 38-point rings with 3-point stroke, then divider and three similarly styled tiles. Tile numbers are title3, one line with minimum scale 0.7; captions allow two centred lines. Previous-period comparison is centred. | Give completion the strongest hierarchy, keep full-day and weekly-goal numbers secondary, and left-align captions. Do not shrink required text. |
| Quit section tight | Icon/name/current run share a horizontal row, followed by best/slips. The clock is an isolated `TimelineView` ticking every 60 seconds. | Move the run below the identity and label it. Show the clock's snapshot time at section level. |

At 393 points, the trailing strip and icon can leave roughly 150 points for identity and subtitle. A long title therefore becomes several short lines while the icon stays centred against the whole block. The current accessibility layout hides strips; normal habit VoiceOver includes weekday states, but quit VoiceOver currently omits its current run and the weekday strip. The proposal adds those meanings to quit accessibility.

The current clock is expressly allowed by `PERFORMANCE.md` when isolated. It is **not a current performance violation**. The user's stricter request here—nothing ticking or animating per row—requires the freshness change described in section 6.

## 2. Evidence: reviews first

### Population, retrieval and limits

The canonical, non-duplicated JSONL scan covers **1,487,223 records**: App Store 337,331; Play Store 901,453; Native Store 248,439. It searches progress/week contexts, presentation words and mark-meaning complaints without an English-only filter. The language expansion supplies keyword pairs for all 72 language codes present in the manifests. Metadata codes do not prove the text's actual language; App Store country is not language.

The focused first pass retrieves 339 candidates. The wider language pass retrieves 1,409 additional broad matches, of which a disclosed week/visual proximity screen retrieves 323 for this investigation. **All 662 final candidates were read individually in their original language and hand coded**, including off-topic matches. The remaining broad matches are not claimed as read. Final store mix: App 279, Play 176, Native 207. The coded period is **19 January 2013–7 September 2026**. Retrieval can miss implicit descriptions and unusual wording; this is a focused visual audit, not an exhaustive comprehension study of all 1.49 million records.

Every percentage below uses **662 coded candidates** unless expressly stated otherwise. Codes can overlap; counts do not sum to 662. “Apps” in the machine summary means store/app corpora, not deduplicated products or market share. The [complete per-review appendix](<Week Visual Evidence/Coded Reviews.tsv>) gives ID, source line, store/app, date, rating, retrieval pass and all codes. [Theme Counts](<Week Visual Evidence/Theme Counts.json>) contains every supporting ID. [Codebook and provenance](<Week Visual Evidence/README.md>) explain the narrow scope and counterexamples. [Scanners and verification](../../../Research/Tools/progress_week_visual/README.md) reproduce retrieval and the saved classifications.

The earlier Progress report's 14,726 individually coded records and 11,870 on-topic records remain inherited evidence, not a new reading claim. Its findings about wrong counts, thin statistics, lost history and weekly/skipped-day handling justify retaining the decided data. This report adds visual evidence, rather than reopening those calculations.

### Signals and exact examples

Scope for this table: the 662-candidate, three-store focused audit and period above. These are review signals, not rates of all users experiencing a problem.

| Signal | n / denominator; percentage | What the original texts support | Representative IDs |
|---|---|---|---|
| P_WEEK: weekly/calendar readability or usefulness praise | 102/662; 15.41%; 19 store/app corpora | A week visible at a glance, clear reports, aligned habits and simple progress history. Some describe calendars rather than exactly our weekly strip. | `11264641334`, `13651344795`, `5357485025`, `3276080846`, `cdec6353-c013-4187-85fa-386c015c6118` |
| P_OVERVIEW: overview/aggregate praise | 8/662; 1.21%; 6 corpora | Nearby totals and an all-habit overview are useful. | `2462727208`, `f48b8a81-c4e9-4ed6-8ec6-ebdb5c406dfe` |
| X_MARK: state, symbol, colour or icon ambiguity | 22/662; 3.32%; 13 corpora | Unexplained circles, shades, no-entry states, today versus history, and weekly total versus today's status. Includes adjacent flows such as icon selectors; not all 22 concern a Week screen. | `10177962947`, `12249588346`, `4435616598`, `6653849743`, `d1a16056-b6ad-43cb-9dc5-532a49844fff` |
| X_DENSITY: presentation/readability/navigation friction | 14/662; 2.11%; 10 corpora | Tiny dots, oversized presentation, unnecessary decoration and long scrolling. Do not call all 14 “clutter” complaints. | `8564799469`, `12995454579`, `f1deda17-e651-4254-8dba-f7926fe95d33`, `e1cd197a-4cb6-472e-807e-68db7ad1fb1f` |
| ASK_WEEK: weekly presentation/detail requests | 46/662; 6.95%; 18 corpora | Full week visibility, weekly review, per-habit graphs or summaries. | `4173454628`, `d7cd9e88-59e5-40f6-b471-7cf1479bf369` |
| X_SCORE: score/count explanation or mismatch | 9/662; 1.36%; 7 corpora | A score without a clear denominator, or weekly goals seeming incomplete because today's daily status differs. | `12249588346`, `db3d1094-d2f2-481d-abd3-21d619ebd1bb` |
| P_CLARITY: broader clarity praise | 27/662; 4.08%; 15 corpora | Clean/simple interfaces and readable statistics, without proving a particular legend works. | `9870690248`, `195be0e3-60dd-4846-9048-e58083faecba` |
| P_QUIT: counter/history presentation praise | 2/662; 0.30%; 1 corpus; **limited evidence** | Days Since's prominent duration and useful best/history statistics. | `7620460035`, `11526146653` |
| N_MARK: native calendar/fitness state ambiguity | 40/662; 6.04%; 4 corpora | Native calendar symbols and Fitness rings can also be unclear. Indirect evidence for habit marks. | `11307525894`, `7874086968` |
| N_DENSITY: native calendar/task presentation friction | 47/662; 7.10%; 3 corpora | Weekly readability, space and scrolling tradeoffs. Indirect, not habit-app validation. | `5665298516`, `1593590512` |
| N_PRAISE / N_SUMMARY | 12/662, 1.81%, 3 corpora / 8/662, 1.21%, 2 corpora | Native readability praise / summary or completed-history feedback. Complete IDs in appendix; no design recommendation relies on these small counts alone. | `3998881965` / `12121485818` |
| SOLICITED: explicit promotion disclosure | 1/662; 0.15%; 1 corpus | One InnerGrow reviewer mentions a free-membership promotion. This detects one explicit disclosure, not the actual solicitation rate. | `10797987018` |
| NA: outside these visual themes | 345/662; 52.11%; 57 corpora | Individually read, retained and assigned, including general bugs and unrelated workflows. | `10488633695`, `10910387642` |

### Which apps supply the strongest relevant examples?

The same period/662 denominator applies. These are the highest **retrieved weekly-praise counts**, not a fair ranking of all apps; corpus sizes, languages and retrieval differ.

| App | Weekly/calendar praise | Review-backed value; counterevidence | What to take |
|---|---|---|---|
| InnerGrow / Habit Tracker | 57/662; 8.61%; one App corpus | Clear, attractive weekly reports (`11264641334`, `13651344795`), habits visible at a glance (`8779837436`). A five-star text asks for a plainer report (`8564799469`); another cannot distinguish today's grey state from yesterday's coloured one (`5570550517`). | A readable week and restrained hierarchy. Do not inherit tiny shade differences or decoration. |
| HabitBull | 8/662; 1.21%; App and Play | Balance between weekly tasks and daily habits (`5357485025`); all-week visibility (`2462727208`); clean statistics and useful customization (`f48b8a81-c4e9-4ed6-8ec6-ebdb5c406dfe`). | Aligned weekday columns, explicit amounts. Logging praise does not authorize logging from Progress. |
| Goal Calendar | 8/662; 1.21%; one Play corpus | Weekly percentages/KPIs (`cdec6353-c013-4187-85fa-386c015c6118`) and simple weekly ticks (`ab5ec03f-523d-4517-8603-3fa952ef7c4d`). Wants more goals fitting onscreen (`e1cd197a-4cb6-472e-807e-68db7ad1fb1f`). | Keep all seven days and make option 3 available for users valuing comparison density. Reject red crosses. |
| Way of Life | 7/662; 1.06%; App and Play | Easy to see whether the week is on track (`3276080846`, Japanese `731906569`, `12738522904`). A Play review does not understand its no-entry symbol (`d1a16056-b6ad-43cb-9dc5-532a49844fff`). | Explicit state labels beside a compact strip; explanation is still needed. |
| Loop | 3/662; 0.45%; one Play corpus; limited | Clear week/month history but long scrolling with many habits (`f1deda17-e651-4254-8dba-f7926fe95d33`); asks for all seven days (`d7cd9e88-59e5-40f6-b471-7cf1479bf369`). Wants “didn't happen” distinguishable from forgetting to log (`478f1166-6893-417e-ad4f-7f27ae3cd7f4`). | Honest density comparison and explicit neutrality. No folding menu is added to the fixed controls. |

Other relevant complaints are concrete: Streaks' grey marks need explaining (`4435616598`); random icons/numbers require a manual (`10709565816`); Done's calendar dots are too tiny (`3582038140`); Habitify's weekly goal total does not reveal whether it happened today (`6653849743`); DayStamp requests a separate skipped state (`13574542005`). The colour-blind Strides review (`945529655`) reinforces shape plus text. Ratings do not determine sentiment: the five-star InnerGrow request for less decoration and five-star native task criticism are retained as written. Some reviewers request red failure indicators; those requests conflict with this app's explicit rules and are not adopted.

### Store screenshots, portfolios and Apple patterns

Official App Store screenshot URLs come from iTunes lookup; Play sources are the listing pages. The [Source Catalogue](<Week Visual Evidence/Source Catalogue.md>) preserves direct image URLs and descriptions. The following are visually inspected, relevant examples:

| Reference | What it shows | Evidence or first-principles use |
|---|---|---|
| [InnerGrow listing](https://apps.apple.com/us/app/habit-tracker/id1438388363), image 2 | Habit Reports: aligned weekday dots, habit names and separate aggregates. | Week-at-a-glance grouping is review backed; exact tiny mark styling is not. |
| [HabitBull listing](https://apps.apple.com/us/app/id1041482672), image 4; [Play](https://play.google.com/store/apps/details?id=com.oristats.habitbull) | All-habit weekly matrix; calendar and quantity statistics in adjacent screenshots. | Consistent columns are useful; no red or logging controls transferred. |
| [Way of Life listing](https://apps.apple.com/us/app/id393159800), images 1, 2, 7 | Seven-day rows; explicit Done / Not done / Skip labels; walkthrough. | Labels address reported symbol ambiguity; the logging interaction stays out. |
| [Goal Calendar Play listing](https://play.google.com/store/apps/details?id=info.intrasoft.habitgoaltracker), downloaded images 3–6 | Weekly matrix with numbers, checks and crosses; dark variant. | Alignment and visible quantities help; red/green-only meaning is rejected. |
| [Habitify listing](https://apps.apple.com/us/app/id1111447047), image 4 | Weekly matrix with a fraction and further chart detail below. | Show weekly goal aggregate separately from today's day state. |
| [Evoday listing](https://apps.apple.com/us/app/id1403517519), images 1, 7, 10 | Large quantities with a subordinate week strip, list quantities, dark theme. | Numbers-first hierarchy informs option 4 by first principles, not a winning review count. |
| [Days Since listing](https://apps.apple.com/us/app/id1445348921), images 3, 5, 9 | Large current duration, smaller statistics, labelled weekly bars and saved past attempts. | Limited quit praise plus first principles: keep the run legible and history visible. |
| [Dribbble: IMRAN KHAN](https://dribbble.com/shots/27295388-Habit-Tracker-Mobile-App-Design) | Inspected portfolio image uses a large Daily Goals card and a prominent percentage/circle with calendar structure. | Hierarchy inspiration only. Portfolio engagement is not usability evidence; coloured decorative chrome conflicts with our rules. |
| [Behance: Yana Hardzeyuk](https://www.behance.net/gallery/122409607/Statistics-Section-for-Habit-Tracker-Application) | Statistics-section project found; project image did not load. | URL reference only; no visual claim. |
| [Pinterest: My Weekly Habits](https://au.pinterest.com/pin/my-weekly-habits--3448137208705065/) | Weekly-planner reference found; full image unavailable. Extracted asset was an unrelated gradient. | No planner details inferred; gradient excluded from board. |
| [Mobbin habit search](https://mobbin.com/browse/ios/apps?search=habit) | Authentication prevented inspection. | No borrowed pattern or fabricated screenshot. |

Apple's [Fitness Summary](https://support.apple.com/guide/iphone/see-your-activity-summary-iph4c34a8a95/27/ios/27) pairs rings with named quantities. [Health](https://support.apple.com/en-ie/guide/iphone/iphe3d379c32/ios) uses named measurements and time ranges. [Screen Time](https://support.apple.com/guide/iphone/set-up-screen-time-for-yourself-iphbfa595995/ios) places a named average above a weekly report and permits more detail. [Sleep](https://support.apple.com/en-my/guide/iphone/iph72b370881/ios) names stages and supports time-range selection. These examples support numbers plus visual summary, not mysterious symbols alone. Fitness's current support image is a daily Summary, not proof of a weekly habit design.

The HIG recommends intelligible labels and chart descriptions in [Charting data](https://developer.apple.com/design/human-interface-guidelines/charting-data), grouping and readable separation in [Lists and tables](https://developer.apple.com/design/human-interface-guidelines/lists-and-tables), and scalable text, contrast, non-colour cues and assistive-technology support in [Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility). Applying grouped-card spacing does not require converting our `ScrollView` to a `List`. None of these references proves users understand our nine day states without explanation.

## 3. Marks: preserve meaning, expose it

**There is no credible comprehension percentage in these reviews.** Complaints establish that unexplained circles, shades and symbols can confuse; they do not establish how many people misunderstand this particular strip. Filled checks are familiar, but part rings, dashed rings, tiny triangles and blank weekly-goal days require context. The recommendation below combines review evidence with first-principles reasoning.

Keep all seven slots. Repeat localized short weekday names on every card, with Today bold and underlined. Use 20-point fixed marks in option 1. Give Done a check inside its filled circle; keep partial fraction shapes and express exact quantities in text. Neutral status symbols use monochrome contrast. A blank not-planned cell becomes a small neutral dash so the column reads intentionally empty, without becoming an incomplete day.

Directly after the overview, show **Done / Part done / Today**, then **All day states ›**. Tapping opens a native read-only legend sheet, with the title **Day states**, a close button and one row per state. Explain rare states there and beside the affected card: “Sun skipped · does not count”, “Paused through 4 Oct”, “Empty days do not count against this goal.” A three-entry key alone is not the full explanation.

| Meaning | Current mark | Proposed mark and exact legend copy |
|---|---|---|
| Done | Filled habit-colour circle | Filled circle + check. **Done** — “The day's goal is reached.” |
| Part done | Part-filled ring; fraction of amount | Contrast track + habit-colour arc. **Part done** — “Some of the day's amount is logged. The ring shows the fraction.” Exact amount is text, e.g. “Today · 12 of 20 min”. |
| Planned, ended, not done | Empty grey ring | Empty monochrome ring. **Planned day** — “The day has ended and its goal is not reached.” No prohibited judgmental word appears. |
| Today, unjudged/open | Dashed grey ring | Dashed ring. **Today** — “The day is still open. Nothing is counted against it yet.” For a limit with an amount, keep it open and add “Today · 2 of 3 cups so far”. |
| Limit over, ended | Empty ring + ▲ | Same shape, larger visible triangle. **Over the limit** — “This ended day went above its limit.” Never put this on an unfinished day/period. |
| Skipped | `forward.fill` | Neutral double-chevron. **Skipped** — “Does not count toward the score.” |
| Paused | `pause.fill` | Neutral pause bars. **Paused** — “Does not count toward the score.” |
| Later this week | Small faint habit-colour dot | Five-point neutral dot. **Later** — “This day has not happened yet.” |
| Not its day / before start / weekly goal's empty day | Blank | Seven-point neutral horizontal dash. **No day result** — “Not planned, before the habit started, or no entry for a weekly goal. This is not counted as an incomplete day.” Card context distinguishes the cause; VoiceOver names the actual cause. |
| Quit clean day | Filled quit-colour circle | Filled circle + check. **Clean day** — “A day with no slip recorded. Today is still in progress.” |
| Quit slip | Empty ring | Empty neutral ring. **Slip recorded** — “A slip was recorded on this day. Earlier clean days remain in history.” |
| Quit pause | Pause bars | Neutral pause. **Paused** — “The quit habit was paused on this day.” |

Quit gets its own visible **Clean day / Slip recorded / Paused** key, because Done and Planned day have different meanings there. The full legend has a Quitting subsection. Upcoming quit cells currently render blank; the proposal uses a neutral future dot derived from the date. This is an explicit presentation mapping change, not an additional clean day.

Do not collapse skipped, paused, not-planned and incomplete into one state just to simplify a drawing. Do not introduce red. The only semantic/display changes proposed are the check cue, intentional neutral dash/future-dot rendering, added explanation, and quit snapshot freshness. No scoring, eligibility, goal history or limit judgment changes are proposed.

## 4. Five options and honest density

Every option includes all three sections and the same **14-habit fixture: 12 regular habits and 2 quit habits**. Names, colours and SF Symbols come from the demo seed, with explicit stress additions: Coffee supplies a limit; Floss is paused; Stretch has a skipped Sunday; Skin, Lunch and Smoking use longer names. The seed itself has no limit/paused/skipped example. Red Meds entries and several other seed habits are omitted to keep 14 and obey no-red. Thus this is a faithful demo-based stress fixture, not a claim that unchanged CI seed data contains those states.

The fixture keeps Read's timer, Water's real **8 glasses**, Call family's **3 times a week**, checklist steps, a partial Friday walk and two quit runs. Its week is Sunday 27 September–Saturday 3 October, with Friday 2 October open. The model-shaped illustration has 53 completed habit-day opportunities out of 55 counted opportunities, 96%, three full days and zero of one weekly goal met. Forty-seven completions on ended daily-goal days, two completed weekly-goal entries and four today's completions give 53; two ended incomplete daily opportunities give the other two. Today partial amounts do not enter that denominator. Partial arcs remain informative. The previous 46 of 57 is a hypothetical comparison. None of these replace the real baseline's 72 of 78.

“Counts habits, not ticks” means one eligible habit outcome per day, rather than counting eight glasses as eight successes. The same habit can contribute on several days; **53 does not mean 53 unique habit names**. Weekly-goal empty days remain neutral. Quit is separate from the overview denominator.

Primary images are exactly **1179 × 2556 pixels**, representing 393 × 852 points at @3x. A viewport cannot honestly fit 14 breathing cards and all sections. Each three-screen board shows overview, a scrolled habit position and quit; complete scrolling images prove the population. For every mode, `-habits.png`, `-quit.png` and `-full.png` companions exist. Large-text images simulate accessibility-size scaling and reflow; they are not a native Dynamic Type or VoiceOver test.

The shared top depiction is illustrative context, identical across options. Its CSS is not an instruction to rebuild native top chrome. Implementation retains the actual existing controls.

### Option 1 — Room to read (recommended)

![Option 1: overview, habits, quit](<Week View Options/option-1-board.png>)

[Light](<Week View Options/option-1-light.png>) · [Dark](<Week View Options/option-1-dark.png>) · [Large text](<Week View Options/option-1-large-text.png>) · [Large-text habits](<Week View Options/option-1-large-text-habits.png>) · [Large-text quit](<Week View Options/option-1-large-text-quit.png>) · [Habit close-up](<Week View Options/option-1-habit-closeup.png>) · [Marks/legend close-up](<Week View Options/option-1-marks-closeup.png>) · [All 14](<Week View Options/option-1-light-full.png>).

Completion gets a 36-point hero; seven rings and two secondary statistics stay in the same overview. Individual habit cards use 18-point vertical/16-point horizontal padding, 12-point gaps, radius 18, a top-aligned 32-point icon and a full-width 20-point strip underneath. Quit runs get a 28-point line of their own.

**Answers the feedback:** more breathing room; title-aligned icon; nearby short key/full legend; quantities, eligibility and strip occupy separate lines; a clear overview focal point. No required aggregate disappears. VoiceOver combines identity and aggregate with weekday meanings; accessibility sizes replace the strip with seven readable state lines and stack overview metrics. **Cost:** simple outer lazy stack, seven fixed shapes per card, no chart or timer. More card backgrounds and a little more text than today; still light. **Risk:** longer scrolling and repeated weekday labels. Mockup content height 3,603 points, measured in this fixture—not native performance.

### Option 2 — Week tiles

![Option 2](<Week View Options/option-2-board.png>)

[Light](<Week View Options/option-2-light.png>) · [Dark](<Week View Options/option-2-dark.png>) · [Large text](<Week View Options/option-2-large-text.png>) · [Habit close-up](<Week View Options/option-2-habit-closeup.png>) · [Marks close-up](<Week View Options/option-2-marks-closeup.png>) · [All 14](<Week View Options/option-2-light-full.png>).

The overview leads with the rings and places metrics in neutral inset tiles. Habit cards use padding 20, radius 20 and 30-point marks below a divider. Quit uses the same generous identity/run/strip stack. **Answers:** strongest visual separation and easiest-to-see marks; top-aligned icon, visible explanation and all values retained. Accessibility uses the same text-state fallback and combined spoken summaries. **Cost:** seven larger fixed shapes and extra neutral rectangles, still no heavy layout/charts. **Risk:** physical size consumes scrolling without adding information. Height 4,099 points, about 14% above option 1 in this exact fixture.

### Option 3 — Aligned week ledger

![Option 3](<Week View Options/option-3-board.png>)

[Light](<Week View Options/option-3-light.png>) · [Dark](<Week View Options/option-3-dark.png>) · [Large text](<Week View Options/option-3-large-text.png>) · [Habit close-up](<Week View Options/option-3-habit-closeup.png>) · [Marks close-up](<Week View Options/option-3-marks-closeup.png>) · [All 14](<Week View Options/option-3-light-full.png>).

One grouped card holds generously inset rows with dividers; each row still has full-width identity, quantity and its own aligned 18-point strip. Overview puts the completion number and statistics above the ring footer. Quit remains a separate grouped section with distinct run hierarchy. **Answers:** 20-point vertical row padding, title-aligned icons, repeated weekdays and key; reduced side-by-side squeeze. It improves the current grouped pattern without turning Progress into a dense table. **Cost:** the lightest backgrounds, fixed HStacks and separators; no lazy grid. Accessibility rows grow and switch to text states. **Risk:** less visual separation between habits; 18-point marks remain less legible than options 1/2. Height 3,439 points, about 5% below option 1; best choice when comparing many habits is the priority.

### Option 4 — Numbers first

![Option 4](<Week View Options/option-4-board.png>)

[Light](<Week View Options/option-4-light.png>) · [Dark](<Week View Options/option-4-dark.png>) · [Large text](<Week View Options/option-4-large-text.png>) · [Habit close-up](<Week View Options/option-4-habit-closeup.png>) · [Marks close-up](<Week View Options/option-4-marks-closeup.png>) · [All 14](<Week View Options/option-4-light-full.png>).

The 48-point overview fraction and 23-point per-habit quantity dominate. The icon sits at the title's upper trailing corner, justified by letting a long name occupy the leading edge. Cards use padding 20, radius 16 and a subordinate 16-point strip; quit runs are 36 points. **Answers:** roomy stack, top alignment, quantities understood before symbols, unchanged legend; attractive numerical hierarchy. **Cost:** text and seven fixed shapes, no charts. Accessibility wraps large metrics and uses textual states. **Risk:** disproportionate emphasis on amounts across unlike habit types; smaller marks and shorter context can make day comparison harder. Height 3,916 points, about 9% above option 1.

### Option 5 — Week journal

![Option 5](<Week View Options/option-5-board.png>)

[Light](<Week View Options/option-5-light.png>) · [Dark](<Week View Options/option-5-dark.png>) · [Large text](<Week View Options/option-5-large-text.png>) · [Habit close-up](<Week View Options/option-5-habit-closeup.png>) · [Marks close-up](<Week View Options/option-5-marks-closeup.png>) · [All 14](<Week View Options/option-5-light-full.png>).

Each habit is a small weekly journal: four then three day cells, each with a 24-point mark and a state word. Overview statistics stack; quit has labelled daily states too. Cards use padding 20, radius 20 and top-aligned icons. **Answers:** most self-explanatory marks, maximum text hierarchy and breathing room, all data visible. **Cost:** seven extra state labels per habit, two fixed HStacks—not a nested lazy grid. At accessibility sizes use seven vertical state lines. **Risk:** the longest scroll and weaker comparison because weekdays wrap across two rows. Height 5,060 points, about 40% above option 1. Appropriate only if explicit day-by-day reading matters more than quick comparison.

### Comparison and choice

| Option | Overview anchor | Habit separation | Day readability | Normal fixture height | Performance cost | Principal risk |
|---|---|---|---|---:|---|---|
| 1 Room to read | Completion + ring row | Individual cards | 20-point marks + key/context | 3,603 pt | Low: fixed shapes/text | More scroll than a tight table |
| 2 Week tiles | Rings + inset statistics | Generous cards | Largest marks, 30 pt | 4,099 pt | Low: more rectangles | Space cost |
| 3 Aligned ledger | Metrics + ring footer | Divided grouped rows | Aligned 18-point strips | 3,439 pt | Lowest background count | Rows still feel related/tight |
| 4 Numbers first | Large numerical hero | Individual cards | Exact quantities, 16-point strip | 3,916 pt | Low: larger text | Marks secondary; unlike units compete |
| 5 Week journal | Stacked plain metrics | Individual journal cards | Words beside every 24-point mark | 5,060 pt | Low but more text nodes | Long scroll, broken seven-column alignment |

All five keep fixed top controls, habit-owned colour, monochrome chrome, shape cues, neutral skips/pauses/unplanned days and read-only navigation. All retain the decided values and seven-day information. None needs shadows on text, per-row GeometryReader, a nested lazy grid, Swift Charts, animation or recurring row ticks. A blur, shadow stack, chart-per-card, animated ring or per-row geometry proposal would exceed this brief and should be rejected or explicitly costed separately.

**Choose option 1.** It directly fixes the narrow-text/centred-icon problem while preserving the aligned week. It has enough mark space without option 2's extra scroll, and explicit meaning without option 5's repeated prose. Option 3 is the viable alternative if the user places a higher value on comparing many habits with fewer swipes. The recommendation is a reasoned design judgment informed by the review signals, not the result of comparative usability testing.

## 5. Exact implementing-agent spec for option 1

Implement only after the user selects it. The following measurements are points at the default text size; system text styles scale normally. Do not copy screenshot pixel sizes into SwiftUI.

### Layout, fonts and colours

| Element | Measurement/style |
|---|---|
| Existing Progress shell | Keep current navigation, range card, period controls, chips, menu, section order and filtering. Keep horizontal outer inset 16, main section spacing 22. Use the existing ScrollView and one outer lazy stack for scrolling habit content. |
| Overview section label | Leading inset 16 inside section; 15-point semibold/subheadline, secondary; bottom gap 8. Existing info button remains read-only, 44 × 44 hit target, 18-point symbol. |
| Overview card | Horizontal and vertical inset 20; radius 20; no shadow. Full available width (361 at a 393-wide screen with 16 outer insets). Content height intrinsic. |
| Completion hierarchy | “Done so far this week”, subheadline 15 secondary. Gap 4 to fraction. Fraction 36 bold, scaled relative to largeTitle, monospaced digits. Percentage 17 regular secondary, baseline aligned, gap 4. It can move underneath if it cannot fit. No minimum-scale factor. |
| Overview ring row | Gap 20 after hero. Seven equal-width slots; label caption2/12 secondary; label-to-ring gap 8; ring 38 × 38; stroke 3; date 14 regular. Today weekday semibold and 1-point underline offset 2. Existing full-day check cue remains; future neutral. |
| Overview statistics | Gap 20 before a 1-physical-pixel separator; gap 16 after. Two equal-width leading-aligned stacks, gap 12. Numbers 22 semibold/title2, captions 15 subheadline secondary, number-to-caption gap 4. |
| Previous-period line | Gap 16 after statistics; 15 subheadline secondary, leading aligned. Wrap naturally. |
| Visible day key | Outside overview, top/bottom spacing 14; horizontal inset 6 relative to outer card edge. Done/Part done/Today glyph 20; text caption/12 secondary; glyph-to-label 4; item gap 12. All day states link body/caption as space permits; 44-point minimum hit height. Wrap into natural rows rather than compress. |
| Habits section heading | 15 semibold secondary; inset 16; count trailing; bottom gap 8. Preserve grouping headers and group totals if active. |
| Habit card | Inset top/bottom 18, leading/trailing 16; radius 18; gap between cards 12. Height intrinsic. Whole card navigates read-only to existing habit details at selected Week/period; 44-point minimum target. No interactive marks. |
| Identity | HStack aligned `.top`: icon tile 32 × 32, radius 8; white SF Symbol nominal 20 (fit actual symbol); gap 12. Title body/17 semibold, unlimited lines. Goal line subheadline/15 secondary, gap 4. Chevron 12 secondary, decorative, aligns title top; gap 8 before it. |
| Metric/context | Identity-to-metric gap 16. Metric body/17 medium; context subheadline/15 secondary, gap 4. Use monospaced digits for numeric fragments, not every word. Each line wraps; no fixed row height or clipping. |
| Week strip | Metric/context-to-strip gap 14. Full content width: seven equal flexible slots, no GeometryReader. Weekday label caption/12 secondary; label-to-mark gap 8. Mark fixed 20 × 20. Today has label weight/underline. Use locale week start and short weekday names; never hardcode Sunday or English. |
| Additional state context | Gap 10 below strip; caption/12 secondary, unlimited lines. Includes exact partial/open-limit amount, skip neutrality or weekly-empty explanation when relevant. |
| Quit section | Gap 24 after last regular card; title/count styled like Habits. Snapshot line caption/12 secondary, top gap 4 and bottom gap 10. Quit key caption/12 with 20-point marks, bottom gap 14. |
| Quit card | Same 18/16/radius18/gap12 and identity. Identity-to-run gap 16; run 28 semibold scaled relative to title, monospaced digits; gap 4 to “Current run” caption/12; gap 14 to best/slips subheadline/15; gap 14 to seven-day strip. |
| Legend sheet | Native sheet with navigation title “Day states”, native Close button, grouped rows. Inset 16; state symbol 20 in 32 slot; text gap 12; row vertical padding 12; title17 semibold and explanation15 secondary with gap4. Quitting subheading. No logging controls. |

Semantic SwiftUI colours are the implementation authority. `Color(uiColor: .systemGroupedBackground)` for canvas; `.secondarySystemGroupedBackground` for cards; `.label` for primary; `.secondaryLabel` for supporting text; `.separator` for rules. All chrome and overview rings stay monochrome. Prototype reference values are light canvas `#F2F2F7`, card `#FFFFFF`, primary `#27272A`, secondary `#65656B`, separator `#D1D1D6`; dark canvas `#000000`, card `#1C1C1E`, primary `#EDEDEE`, secondary `#AEAEB3`, separator `#454548`. They document the rendered proposal, not replacements for system contrast/accessibility colours.

Keep each habit's existing colour token. Fixture defaults approximate native orange `#FF9500`, green `#34C759`, blue `#007AFF`, teal `#30B0C7`, purple `#AF52DE`, mint `#00C7BE`, cyan `#32ADE6`, indigo `#5856D6`, brown `#A2845E`, grey `#8E8E93`. Resolve native light/dark variants through existing colour mapping; do not invent new semantic outcome colours. Icon foreground stays the app's current white; mark checks use contrasting monochrome foreground and an outline so pale habit fills are not the sole visible boundary. Never add red.

### Exact text by habit shape

Use structured display fields derived from existing `ProgressHabitRow` data, rather than brittle splitting of the combined English subtitle. This reorganizes the model's existing outcomes without changing calculations. Goal text follows the rule active at the relevant selected period, with existing goal-history/unit handling. Format units/durations through existing `HabitCopy`, `Format` and localized number/date helpers.

| Kind | Goal line | Metric line | Context / extra line |
|---|---|---|---|
| Once on scheduled days | “Every day” or existing localized schedule | “5 of 5 days so far” | Percentage if enabled and available: “100%”. Historical period omits “so far”. |
| Several times each day | “3 times a day” | “14 of 15 times so far” | Percentage if enabled. Keep existing eligible-day denominator and capped contribution; extra ticks do not enlarge overview habit counts. |
| Amount per day | “8 glasses a day” | “48 glasses this week” | “6 of 6 days so far”; today partial, if any: “Today · 6 of 8 glasses”. Amount sums still use compatible unit history. |
| Time per day | “20 min a day” | “1 h 52 min this week” | “5 of 5 days so far”; “Today · 12 of 20 min” if partial. |
| Checklist | “4 steps a day” | “24 of 24 steps so far” | “6 full days · 100%” when percentages enabled. Checklist steps remain checklist statistics, not overview ticks. |
| Daily limit | “Limit 3 cups a day” | “Avg 2.2 cups a day” once ended judged days exist | “Limit 3 cups · ended days only”; “Today · 2 of 3 cups so far” in current period. With no judged days, use the existing “2 cups of 3 cups so far today” value/goal formatter, or “Limit 3 cups a day” in historical empty conditions. No premature within/over verdict. |
| Weekly times goal | “3 times a week” | “2 of 3 so far”, or “3 of 3 · met” | Optional useful remaining count “1 more this week”; neutral clarification “Empty days do not count against this goal.” Historical copy omits “so far”. Never invent seven daily obligations. |
| Period total, e.g. weekly amount/time | “60 km a week” / “1 h a week” | Existing period value/goal, e.g. “42 of 60 km so far” / “30 min of 1 h so far” | Mark “met” only when current minimum goal reached; preserve exact period boundary and history rules. No extra daily denominator. |
| Period distinct-day goal | “3 days a week” | “2 of 3 days so far” | Existing amount total, if relevant, as a separate context line. Reached goal says “met”; neutral empty days remain. |
| Period limit | “Limit 10 cups a week” | “7 of 10 cups this week” while open | “Period still open”; after close use existing “within the limit” if applicable, or value/goal without a judgmental label. Do not judge the open period. |
| Paused regular habit | Existing goal line can remain as identity metadata | Existing paused text, e.g. “Paused through 4 Oct” | “Paused days do not count.” Hide unavailable percentage; retain historical marks. |
| Future start | Existing goal metadata if known | “Starts 5 Oct” (localized date) | No percentage or fabricated 0/0. Before-start marks are neutral. |
| Current no counted outcomes | Existing goal | “Started today”, “Nothing counted yet this week” or “Nothing planned this week”, exactly as eligibility selects today | No guessed percentage. Keep existing historical empty-row omission. |
| Quit, current period | No goal line required | “12 d 11 h” followed by “Current run” | “Best 45 days · 0 slips this week”; selected-week strip, clean-day semantics. |
| Quit, historical period | No present-run line | “Best 45 days” | “0 slips that week”; no today's run in a past week. Preserve best-run scope already calculated. |
| Paused quit | No present run | “Paused” | Best/slips and actual selected-week states. Pause ends the live run under existing decisions, preserving history. |

Normal rows need no redundant metric/context when the only information is one number; keep the hierarchy but do not pad with invented sentences. Show Percentages off removes all optional percentages and preserves the current option's previous-period-line visibility behaviour. Show Streaks stays exactly as implemented. Full Day 80%/60% changes both counts/check cues and caption to “Full days (80%)”/“Full days (60%)”. If no weekly-goal summary exists, omit that secondary statistic. If no eligible denominator exists, use the existing empty-state explanation rather than “0 of 0” or a manufactured percentage.

### Mark construction and overview details

Within the fixed 20-point mark slot: circle diameter 20; neutral outline 1.5; Done check `checkmark` nominal 10; partial track 1.5 and arc 2, round caps, beginning at top. Keep the existing visual minimum arc 0.08 for nonzero tiny fractions and clamp to 1, while exact spoken/text amounts retain the actual fraction. A monochrome 4-point under-stroke beneath the coloured partial arc provides a visible boundary; no shadow. Today dash pattern 2 on / 2 off, outline1.5. Over-limit triangle `arrowtriangle.up.fill` nominal12 in empty ring. Skipped `forward.fill` and paused `pause.fill` nominal12. Later dot5. Neutral dash7 × 1. Larger 32-point legend slots hold the same 20-point marks.

The overview retains **all** decided fields: fraction, optional percentage, seven daily rings/date labels, Full days, Weekly goals met when applicable, prior-week fraction when current display rules permit it. Ring fractions come from existing snapshot scores; completed full-day cue uses chosen Full Day threshold. The metric focus changes, not the count formula. Info-sheet explanation: “Counts habits, not individual ticks. A habit contributes at most once on each counted day. Skipped, paused and unplanned days do not count. Today adds completed habits; incomplete goals wait until the day ends. Weekly goals follow their own period.” Preserve existing exceptions/details for limits and group filters.

Each date ring keeps its existing read-only Day sheet navigation, with a 44-point target around the fixed 38-point ring. That sheet's existing Show on Today action remains; Progress itself does not log. Legend is the only added navigation. No new top menu, collapse switch or scoring preference.

### Quit freshness, accessibility and validation

**Explicit change from the prior live-clock decision:** no `TimelineView` or repeating timer per quit row. Compute a single `asOf` snapshot when entering/foregrounding Progress, changing the selected period/groups, or receiving data changes. Show “Current runs · as of 1:45 PM” above current-period quit cards. No repeating whole-list refresh is introduced as a workaround. Existing day-boundary refresh remains. The displayed run uses whole days/hours and visibly announces its snapshot time; exact seconds remain unnecessary here. The implementing agent should retain the separate habit-detail live clock if it is outside this Week presentation scope. The user should accept this freshness tradeoff when selecting the option.

For **all accessibility Dynamic Type sizes**, not just the supplied simulation: keep icons/marks fixed; title/goal/metrics wrap without line limits; move percentage underneath hero when needed; stack the two secondary overview statistics. Replace the compact habit strip with seven vertical weekday/state lines, 8-point gaps, body-scaled state text. Keep the same states, exact quantities and neutral explanations. The overview ring buttons can use four then three fixed slots at accessibility sizes, with at least 44-point targets and full spoken dates; no lazy grid. At long localized weekday widths in normal sizes, use the existing localized short forms or choose the text-state fallback at screen level, rather than shrinking labels. Use one environment-driven layout decision; no per-row measurement.

VoiceOver hides decorative icon/chevron/mark duplicates and combines the habit card's meaningful content into the existing read-only navigation button. Labels contain name, goal, metric, context and selected-week state summary. Example: “Read. Twenty minutes a day. One hour fifty-two minutes this week. Five of five counted days. Friday, October second: twelve of twenty minutes, part done. Saturday: later.” Expand all seven weekdays in the actual accessibility value, including exact causes: “not planned”, “before start”, “no entry for weekly goal”, “skipped, does not count”, “paused, does not count”. For limits say “still open” or “ended, over the limit” based on actual period status. Accessibility hint: “Opens habit progress for this week.” The strip itself is not seven logging buttons.

Quit example: “Smoking, social ones too. Current run twelve days eleven hours, as of one forty-five PM. Best forty-five days. Zero slips this week. Sunday clean day … Friday clean day. Saturday later.” A paused quit says Paused and omits current-run claim. Historical quit says the selected week and no present duration. Overview ring: “Friday, October second. [actual complete count] of [actual eligible count] habits, [actual fraction/percentage if shown]. Today. Opens day details.” Full-day cue says the actual threshold. Legend control: “All day states. Explains progress symbols.” The new visible and spoken labels never use the prohibited terms.

Test requirements for the implementing agent: native light/dark, increased contrast, colour filters, all accessibility sizes, smallest supported screen and long localized names; VoiceOver reading/navigation order; current and historical Week, non-Sunday week start, group filters, future starts, pauses/skips, archived habits, goal/unit changes, limits before/after day and period close, and View Options visibility. Use existing model/golden tests for calculations; this visual research adds no application tests or code. Verify performance with existing tooling after native implementation. The HTML renderer reports no horizontal overflow in 15 option/mode layouts and 14 cards in each; that is layout evidence, not a native speed benchmark or proof of assistive-technology behaviour.

## 6. Deliverables, provenance and remaining decision

The [checklist](<../../../iOS/Docs/Checklists/Progress Week — Visual Redesign.md>) records coverage and the missing genuine before captures. [Mockup source](<Week View Options/mockups.html>), [fixture](<Week View Options/fixture.json>), [renderer](<Week View Options/render.cjs>) and [layout checks](<Week View Options/render-checks.json>) make the proposals reproducible. Symbols were exported from the system's actual SF Symbols; CSS uses the available system font stack. There is no app-code patch.

The user's next decision is **option 1–5**, with option 1 recommended. Selecting it also accepts the explicitly shown marks/legend and quit snapshot-time changes, or the user can retain the current clock as a stated exception to their no-ticking requirement. This document does not silently change the approved scoring or reopen Month/Year.

Missing genuine dark/accessibility/quit-scroll before captures remain a documented limitation. Behance/Pinterest/Mobbin references are linked with inspection limits, not presented as observed design evidence. Native accessibility and runtime performance verification belong to the implementing agent after the option is chosen.
