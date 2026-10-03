# Habit History — Research and Recommended Layout

Written by Codex, 3 October 2026. Exploratory research and reviewable design recommendation; formal decision record kaadu. Scope: individual habit details lo History job, navigation, day/entry hierarchy, correction and naming. Notes editor, Progress charts, home-screen implementation ee study scope lo levu.

**Recommendation: History tab lo newest-first, month-wise day summaries; visible “Go to date” + “Add entry”; date tap tho aa day details; aa day lo individual entries edit/remove/undo.** Empty dates ni list lo manufacture cheyyakudadhu, kaani date chooser nunchi open chesi backfill cheyyagalagali. Default lo nested year → month accordions avasaram ledu.

User accept chesina first point ni earlier IA report and Figma board lo annotate chesam: **three jobs → separate tabs**. Working labels History / Notes / Progress. Previous calendar-first History layout finalized kaadu; ee study aa assumption ni reopen chestondi.

## Evidence scope and limitations

Existing Feature Ledger canonical points **C010, C223, C262, C264** complete statements and contradictions read chesam; **16 diagnostic source cards** direct ga checked. Existing whole-corpus *Undo and Fixing Progress*, *Filling In a Past Day*, *The Habit Page*, and durable Progress review coding ni use chesam.

Ee session lo **139 original reviews individually read and verified**: all 90 reviews previously coded BF in Progress evidence, 44 diagnostic/source-card citations, and five wrong-value / past-month-note / gating checks. IDs anni source JSONL lo dorikayi; zero missing. Date range **27 December 2013–6 September 2026**. Idi purposive source verification, random sample kaadu. Complete [review index](<Habit History Evidence/Verified Review Index.md>), [original text](<Habit History Evidence/Verified Reviews.jsonl>), [checked source cards](<Habit History Evidence/Checked Ledger Cards.jsonl>) and [method](<Habit History Evidence/Method.json>) preserved.

Additional English keyword discovery 1,238,784 App Store + Play Store reviews scan chesi 646 candidates retrieve chesindi. Aa 646 ni hand-code cheyyaledu; update bugs, “downloaded yesterday” lanti false positives kuda unnayi. Aa discovery counts ni temporal frequency claim ki use cheyyatledu. Prior Undo report multilingual whole-corpus findings ni **secondary findings** ga attribute chestunnam; aa report mention chesina temporary classification folder present checkout lo ledu, kabatti full theme counts independent ga recompute cheyyaledu.

Six product references ni current official documentation nunchi inspect chesam: Habitify, Strong, Apple Health, Toggl Track, Clockify, Day One. Docs pattern feasibility ni show chestayi; users prefer chestarani prove cheyyavu. Fresh adjacent-app store corpus extract cheyyaledu; habit-app primary reviews already correction/navigation problem ni directly describe chestunnayi. Current SwiftUI source read-only ga inspect chesam; implementation change cheyyaledu.

## 1. Mee assumptions meeda evidence verdict

| Assumption | Verdict | Practical implication |
|---|---|---|
| Mostly yesterday / previous week edits untayi | **Plausible; majority or frequency not established.** Explicit recent examples unnayi, older correction/import examples kuda unnayi. Reviews usage telemetry kaavu. | Recent-first default sensible. Seven-day limit, current-month limit, old dates hidden gate justified kaavu. |
| Chronological date rows useful | **Reasoned recommendation, supported indirectly by finding/editing a known day.** Direct list-vs-calendar preference experiment ledu; calendar backfill ki positive reviews kuda unnayi. | Newest-first list default + calendar/date chooser on demand. |
| Within a day individual records modify cheyyali | **Strong problem evidence.** Extra +1, wrong amount/time, only whole-day-reset complaints explicit ga unnayi. | Day aggregate oka summary; editable unit exact saved entry. |
| Only dates with a log show cheyyali | **Good for a compact entry feed; too narrow for full habit History.** Notes-only and explicit skipped dates meaningful saved records. | Dates with saved entries, note or explicit status show cheyyali. Synthetic empty days omit. |
| Months/years collapsible aithe navigation better | **No direct preference evidence found.** Older navigation complaints say forced day-by-day traversal painful. | Month headers + direct date/month/year jump solve the evidenced problem. Collapse optional test; nested accordion default avoid. |
| History / Logs naming decide cheyyali | **History is the best current working label; usability not tested.** Reviewers both terms use chestunnaru. | History tab; short helper copy clarifies edit/backfill. “Entry” exact individual record kosam use cheyyali. |

Recent evidence: Productive **2085529972** previous-week gaps fill cheyyadaniki calendar request; Streaks **1764142379**, **11525453355** late-evening completion ni next day record cheyyadam useful ani cheptayi; HabitKit **42d1c0ba-f3ee-4b03-9b92-b344f2c03a82** next-day forgotten logs describe chestundi.

Older access counter-evidence: Onrise **13922090666** beyond-one-week backfill request; **11587754660** seven days app lo enter cheyyakapothe earlier dates unavailable ani objection; Simple&Powerful **13085435338** current month edit avuthundi, previous month ki return avvatledu ani request. Habit Tracker **8229554896** pre-app habit start date praise; Atoms **12259757598** previous app data import and edits taruvata old history unavailable complaint. Ivi recent-first ni reject cheyyavu; recent-only ni reject chestayi.

C010 first-line “users accept a bounded free window” ni settled consensus laga read cheyyakudadhu. Same canonical point R08-055 lo explicit contradiction undi. R01-012 representative **11578392138 / 12625167724** near-identical Chinese passages paid/free behavior ni describe chestayi; five-star rating alone seven-day gate preference experiment kaadu. User frequencies or broad consent ni aa two records nunchi infer cheyyakudadhu.

## 2. Correction job ki strongest user evidence

[Undo and Fixing Progress — What People Expect](<Undo and Fixing Progress — What People Expect.md>) reported subset: **715 on-topic habit-app reviews across 84 apps**, collected by that study through 30 September 2026; source periods vary by app. Themes overlap. Below percentages **715 on-topic reviews denominator tho**, whole-market rates or user-behavior proportions kaavu. Signal label: review evidence of a recurring problem, attributed secondary count.

| Reported theme | Count / 715 | Apps | History implication |
|---|---:|---:|---|
| Fill a missing past day | 59 / 715, 8.25% | 27 | Missing date must remain reachable |
| Change a past day's result | 54 / 715, 7.55% | 30 | Later correction is a permanent capability |
| Fix/delete one wrong amount or time record | 47 / 715, 6.57% | 22 | Edit exact entry, not day total |
| Only reset day/habit/all data available | 17 / 715, 2.38% | 9 | No whole-day wipe as a single-entry fix |
| Undo hidden, awkward or gone too soon | 58 / 715, 8.11% | 17 | Visible, persistent correction route |
| Past days changed by stray taps | 17 / 715, 2.38% | 10 | Navigation must not mutate data |
| Undo leaves statistics/streak/reward wrong | 53 / 715, 7.41% | 22 | Recalculate derived outcomes after correction |
| Want to inspect each day's entries | 12 / 715, 1.68% | 8 | Day details expose underlying records |

Primary checks behind key conclusions:

- **11377690769**, Habit Tracker, 3★, 13 June 2024: wrong tracked time ki full-day reset matrame available; previously accumulated time teliyakapothe correct total lose avuthundi.
- **9466621749**, Habit Tracker, 4★, 3 January 2023: three stretches instead of four entry fix kosam entire habit reset cheyyalsi vachindani describes.
- **6b3d5bc8-74c9-44d6-96b0-53c18598c572**, Habitify, 4★, 10 July 2024: accidental extra +1 ni delete cheyyadaniki faster Log History access kavali. Ee request exact-event correction ni directly supports.
- **915678945**, Strides, 3★, 27 December 2013: additive entry vs replacement total confusion, individual record inspect/edit absence. Old evidence; current product defect ani claim cheyyatledu.
- **11493203641**, Awesome Habits, 5★, 14 July 2024: history accidental edits ni prevent chesi, changes intentional ga cheyyadam explicit praise.
- **f321ffea-223f-41c6-bb78-d1a3c1dfc2d2**, Goal & Habit Tracker Calendar, 4★, 19 May 2024: scrolling to analyse history valla past marks accidentally changed.
- **13736433494**, Finch, 4★, 11 February 2026: immediate undo disappears; later correction cumbersome. **14245262334 / 14391501375**, Streaks, June/August 2026: visible alternative to shake-only immediate undo request.
- **304cddea-ffd8-405a-9a4f-98c86f1f49ac**, Loop: wrong-day tick undo chesina streak intact ga restore avvatledu. Corrected data and derived numbers must agree.

## 3. Recommended History structure

History purpose: **“Aa day em record chesanu? Correct ga unda? Missing entry ni add cheyyacha?”** Charts, milestones, streak comparisons ee tab lo repeat cheyyakudadhu. Common header existing agreed IA lo untundi; History content starts with two visible actions and a compact chronology.

```text
Habit name + goal          •••
History | Notes | Progress

View, edit or add past entries.
Go to date                 Add entry

October 2026
Sat 3 · Today        500 ml · 2 entries                 ›
Fri 2 · Yesterday    700 ml · 2 entries · Note           ›
[Thu 1 has no saved data → no list row]

September 2026
Wed 30               1,800 ml · 4 entries               ›
Tue 29               Skipped · Note                    ›
Sun 27               Note only                         ›
```

**Newest first** ante dates descending order; latest saved tracking day at top. Day row full date/weekday, actual day total or status, saved entry count, and optional note indicator. Month heading year tho undali; year change daggara “January 2026” / “December 2025” clear ga untayi. Progress percentages and month totals ikkada add chesthe earlier clutter malli vastundi.

Today no record unna separate empty daily row create cheyyakudadhu. **Add entry** today default tho opens; **Go to date** any allowed date ni opens. Today record unte actual row Today label tho show avuthundi. All empty historical dates ni “missed” ga infer cheyyakudadhu: no data and explicit not-done are different.

Dates with saved content ni include cheyyali: positive entries; explicit skip / other persisted day status; day note without completion. Notes-only row completion imply cheyyakudadhu. History row lo note preview optional single short line/badge; full written browsing Notes tab lo. Rendu surfaces same note object ni reference chestayi. This exception is a design inference: saved context hide cheyyakunda, chronology usable ga unchadaniki.

Pause duration lo every paused day ki synthetic row create cheyyakudadhu. Day chooser aa date state ni explain cheyyali; existing pause interval aa date ni cover chesthe relevant context show cheyyali. Recording/skip/pause conflicts ni silently merge or delete cheyyakudadhu.

### Month/year navigation and collapse

Default: recent chronology open, months simple section headings. Screen height paiki old months automatic ga hide avuthayi; anni dates load cheyyalsina requirement ledu, progressively load cheyyachu. Previous month already visible list lo unte additional expand tap undakudadhu. Especially 1 October na yesterday 30 September — “older month” ani collapse chesthe recent correction kuda hide avuthundi.

**Go to date** date selector opens. Month/year jump direct ga undali; multi-year date kosam 60 arrow taps or day-by-day swipes demand cheyyakudadhu. Today / Yesterday shortcuts picker lo useful, additional permanent chip row necessary ani evidence ledu. Date selection **Day details** ni opens, list lo nearest logged date ni silently choose cheyyakudadhu. Empty date select chesina exact date visible ga undali.

Month collapse compact secondary option ga test cheyyachu, kaani default mandatory accordion recommend cheyyatledu. If retained: header tappable, clear expand state, recent loaded groups expanded, group hidden aithe record-count summary, collapse state tab return lo preserve. Direct date selection collapsed group valla block avvakudadhu. **Year → month → day nested accordions avoid**: direct date chooser already year access istundi; extra gates task cost penchuthayi. Exact collapse preference ki direct user data ledu.

Navigation reviews contradictory but useful: Do Habits **3901553792** calendar badulu forced day-by-day swipe objection; **9576830161** swipe option remove chesi manual single-day selection objection. Conclusion “only one navigation method” kaadu: adjacent-day arrows/swipe in Day details, direct date jump for distant days. Calendar-on-demand remains valuable; calendar-first vs list-first comparative usability untested.

### Date row → Day details, rather than all events on the main feed

Main list one row per meaningful date. Tap date tho same habit's Day details opens; habitual day controls and entries akkada untayi. Individual records ni main feed lo always expand chesthe high-frequency habits valla dates scan cheyyadam costly avuthundi. Inline day expansion is an alternative, not ruled out by evidence; day sheet is the current recommendation because same context/editor can be reused from Home, History, Progress date links, Notes date links.

History nunchi known date open: one tap. Check entry undo: date tap → exact Undo, two taps. Value correction: date tap → entry Edit → Save, three activations plus typing. This is a proposed interaction count, measured task performance kaadu. Multiple corrections on the same day stay within Day details; each save taruvata page top ki jump avvakudadhu. Adjacent-day controls allow previous-week cleanup without repeatedly closing/reopening.

A full-day reset should not be beside individual entry correction. User “Undo this check” expectation clear ga undali; “Not done” day-level action silently all records delete cheyyakudadhu. If bulk clear is ever retained, separate, clearly scoped and reversible.

## 4. Day details and per-habit behavior

Day details title actual **tracking date**, habit name. Summary computed from remaining saved records. Individual records newest logged first; consistent ordering with the feed. Read-only entry value/action, honest logged metadata and source where known; explicit **Edit** and **Remove**, or **Undo check**. Swipe may be a shortcut; visible correction route remains.

| Habit kind | Day summary | Individual record | Correction |
|---|---|---|---|
| One check/day | Done / no recorded completion | One completion | Undo this completion; re-add explicitly |
| Repeated checks | 2 of 3 times, where 3 is that day's count goal | Each saved +1, or one saved bulk record | Undo that record; bulk count can be edited as a whole integer |
| Amount | 700 ml · 2 entries | 400 ml and 300 ml separately | Change 300 → 250; result 650; 400 stays |
| Duration | 35 min · 2 entries | Timer/manual sessions separately | Correct one duration or remove it; do not zero all sessions |
| Checklist | Steps completed for that day | Step name, not generic “Check” | Undo named step only |
| Quit / cut down | Relevant recorded slips, with actual event time | Each slip | Correct slip time/remove mistaken slip; counter recomputes |

A saved entry is not necessarily one physical tap. Existing model's “mark day done” can create **one count entry value 5**. Display “5 times · 1 entry”, not five invented timestamped events. “Undo this entry” removes those 5; smaller correction uses Edit count. Total and entry count rendu same number anukokudadhu.

Weekly frequency ki fake “1 of 3 today” avoid: “3 times a week” is scheduling frequency, day count goal kaadu. Day row shows what was actually recorded; period goal belongs in appropriate context. Amount units, duration formatting, at-most targets, historical goal/rule and display preferences must be respected. “Goal reached” and “record exists” separate concepts.

**Quit habits lo log leni dates success ni automatically represent chestayi ani History daily rows manufacture cheyyakudadhu.** Empty slip history = no slips recorded, not “nothing accomplished”. Helper copy should say “Recorded slips appear here”; ongoing abstinence and milestones Progress lo meaningful ga untayi. Source/start-time record, if shown, should be labelled as start context, not a slip.

### Value, date, timestamp and notes

Editing entry value should preserve identity and other records. Add an entry means additive record. If editing a day total is ever introduced, replacement vs increment must be explicit; do not secretly rewrite multiple event values. Entry moving to another tracking date is a sensible future correction need (wrong-day reviews exist), but current store API does not support generic date moves. Show it as a proposed editor capability requiring implementation work, not an existing feature.

Generic `createdAt` is **logged-at timestamp**. Backfill for 2 October entered on 3 October must not display “did at 10:20 on 2 October”. Day header = 2 October; metadata = “Added 3 Oct, 10:20 am”. Quit entries use an actual entered slip time under current model; label “Slipped at”. Unknown source/time should remain unknown, not guessed. Routine player/timer sessions must preserve actual measured data rather than synthesising activity times.

A day note stays attached to the day; editing/removing a progress entry must not erase it. Moving one entry to another day should not silently move the day note. Entry-level notes and their editor model need separate subsequent research; this study does not introduce a new entry-note data model.

Correction feedback should describe scope: “250 ml saved; day total 650 ml” or “One check removed”. Remove must offer a clear restore route tied to that record; a seconds-only toast should not be the sole way to recover. Existing immediate-undo problems justify this requirement; the exact restore lifetime/interface still needs editor-level validation. Source identity, date, note, totals, streaks and milestones should remain consistent after undo or restore. No repeated honesty prompt or confirmation on ordinary logs.

## 5. What adjacent apps add — and what not to copy

Official docs checked 3 October 2026; current installed app UI was not independently exercised. Documentation availability does not establish comparative usability.

| App | Documented behavior | Relevant lesson / limit |
|---|---|---|
| [Habitify](https://intercom.help/habitify-app/en/articles/9501869-how-to-undo-or-fix-a-wrong-habit-log) | Habit → ••• → Log History → remove exact record. Wrong value currently corrected by delete then re-add; shake state temporary. | Exact record matters. Our primary reviewer specifically asks for faster access; direct History tab and in-place value edit reduce the evidenced detour. |
| [Strong](https://help.strongapp.io/article/249-how-do-i-edit-a-past-workout) and [exercise detail](https://help.strongapp.io/article/237-about-exercise-detail) | History finds past workouts for that exercise; workout has explicit Edit/Save. Charts and Records separately available. | Past records vs analysis are distinct. Docs last updated 2021/2022; no claim latest UI is unchanged. |
| [Apple Health](https://support.apple.com/en-us/108779) | Add dated/time-valued data; Show All Data exposes records and single-record deletion separately from Delete All. | Day aggregate cannot be the only editable unit. Imported data source needs explicit ownership; avoid pretending the aggregate is a raw record. |
| [Toggl Track iOS](https://support.toggl.com/en-us/article/toggl-track-timer-for-ios-8ew1yp/) | Chronological entries with per-date totals; similar records can expand; report area separate. | Date summary + underlying records feasible. Five-second delete undo and ten-day mobile retrieval described in docs are limitations to avoid copying into permanent habit-history access. |
| [Clockify iOS](https://clockify.me/help/apps/iphone-app) | Recent list, tap entry to edit date/time, individual delete with Undo, calendar path to other days. Similar records can be grouped. | Multiple navigation surfaces can lead to same record editor. Group deletion is inappropriate as default exact-entry undo for repeated checks. |
| [Day One](https://dayoneapp.com/guides/tips-and-tutorials/calendar-view-in-day-one/) | Date opens its entries; explicit creation for selected date; iOS can jump by date. Android date-search differs. | Calendar should reveal dated context, not mutate completion. Do not assume identical platform behavior. |

No competitor proves collapsible month/year lists are superior. The recommended list and direct date access follow user jobs, recovery evidence and first principles. Calendar advocates in our reviews remain a reason to test the alternative, rather than discard calendar access.

## 6. Current app: what can be reused, what is a gap

Read-only audit of current checkout:

- `iOS/Habits/Today/DaySheet.swift` already represents one habit on one selected date, with adding progress, type-specific controls, skip and day note. Reuse conceptual day context; existing calendar-first layout is not binding.
- `iOS/Habits/Today/DayEntriesSection.swift` already lists individual entries in reverse order, opens EntryEditView for ordinary value records, and deletes exact records through `undoEntry(id)`. This directly supports user's exact-entry requirement.
- `iOS/Habits/Model/HabitStore.swift` `editEntry` preserves record identity/date/source; check counts are integers. Generic date changes are not supported. Quit slip time can change within its recorded day.
- `setDayDone(false)` deletes all entries for the day; this conflicts with “undo only one check” when multiple records exist. It must not serve as the default record-level correction.
- Current DayEntriesSection displays generic clock text without identifying logged-at vs happened-at. Backfilled entries need honest metadata copy. Some controls use current habit kind; historical rules/units need explicit verification before implementation.
- Persistent chronology, direct year/month jump, visible entry actions and restoring a removed historical record are research proposals here. They have not been built or runtime-tested. A deletion operation named `undoEntry` is not evidence that undoing that deletion is already implemented.

## 7. Reviewable direction and remaining validation

Recommended baseline is concrete: **History + short helper copy; newest-first meaningful-day list; month/year headings; Go to date and Add entry visible; date → Day details; exact entries corrected there.** Home should eventually open the same Day details, as ledger/users expect multiple entry points; this research does not change Home.

Before calling the layout validated, run these tasks on the list and calendar-first alternatives: correct yesterday's second +1; change one of three time/amount entries; fill last week's unlogged day; correct 30 September while today is 1 October; jump two years back; remove mistaken slip; distinguish note-only/skipped/no-data; return to list without losing position. Include single-check, high-frequency and non-daily habit users. Observe success without coaching, incorrect mutations and steps; naming test should ask where they would go to inspect/fix a past record before explaining the labels.

No claimed percentage threshold or measured usability result exists yet. To validate the time-horizon assumption later, measure correction age from tracking date, not created-at time; separate onboarding import, backfill, value edit, removal and restoring deletion. Content-free telemetry can answer recent vs old correction frequency without capturing note text or habit names.

Figma study includes the recommended chronology, Day details, exact-value edit, empty-day path, a direct-date-navigation explanation and per-type examples. All values are illustrative. Earlier IA board retains its accepted three-job annotation and provisional History status.

[Open the editable History study in Figma](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=327-194). Inspiration page `234:2`, board `327:194`. Four task screens + per-type record examples; native iOS rows/tabs/buttons and two reusable local research components. Structure checked: 149 text nodes, 62 instances, no image-filled UI; SF Pro on product wireframes and DM Sans on research annotations. Composition visually reviewed; this is a schematic design study, not an interaction-tested prototype.
