# Habit Details — Information Architecture Research

Written by Codex, 3 October 2026. Exploratory research; idi product decision record kaadu. Scope: individual habit details page information architecture. Logs editor, note editor, statistics definitions/chart design ee phase lo depth ki vellaledu.

**User follow-up, 3 October 2026:** three jobs ni separate tabs ga organize cheyyadam agreed: History / Notes / Progress. History ane label provisional. Ee report lo History layout/calendar proposal finalized kaadu; chronology, date navigation, individual entry correction, empty-date access and naming next focused study lo evaluate chestunnam. Idi user follow-up annotation; formal decision record kaadu.

**Recommendation: compact common habit header + History · Notes · Progress.** General habit-details entry ki History default. All-habits Progress nunchi habit ni open chesthe Progress tab, source period tho open avvali. Milestones Progress lo first compact section; habit-wide actions top-right **•••** menu lo.

## 1. Evidence em cheptondi, em cheppatledu

Evidence base: Feature Ledger canonical points and their source cards, existing focused reports, current SwiftUI source, selected original reviews, and current official documentation of three journaling apps plus Habitify. Ee study fresh whole-corpus census kaadu. Earlier reports lo unna counts ni secondary evidence ga attribute chestunnam; ee session lo total population ni malli hand-code chesamani claim cheyyatledu.

49 selected source review IDs original JSONL lo resolve chesi individual ga read chesam (verification appendix generated alongside this report). Selection earlier reports' references + Way of Life report lo **all 13 REQ_NOTES_VIEW** reviews. Ivi purposive evidence checks; prevalence sample kaavu. Public journal-app documentation ni IA pattern comparison kosam use chesam; fresh Day One/Journey/Daylio store-review corpus collect cheyyaledu. Product marketing testimonials ni usability evidence ga use cheyyaledu.

Main limitation: store reviews mana app lo actual visit frequency measure cheyyavu. “Most users details ki editing kosame vastaru” ani percentage invent cheyyalem. History, progress understanding, notes retrieval recurring jobs ani evidence support chestondi; **History default** and **three tabs** mana reasoned recommendations, validated winners kaavu.

| Need | Evidence | IA implication | Confidence |
|---|---|---|---|
| Past record correct cheyyadam | C010: 34 apps, Strong; C262: 8 apps, Certain. Productive `2085529972`, Goal Streak `11346385680`, Loop `8e8f85ab-ceb8-4077-9bdf-8a975d61879e` calendar backfill ni want/praise chestaru. | History ni first-class destination ga pettali; a specific past date direct ga reach avvali. | Strong need; exact placement inferred |
| Oka habit ela nadustondo choodadam | [The Habit Page — What People Expect](<The Habit Page — What People Expect.md>): selected keyword-hit analysis lo 29 reviews/16 apps per-habit stats; 21/14 per-habit calendar. | Identity + small meaningful summary common; full analysis Progress lo. | Recurring need; visit ranking unknown |
| Notes write/read cheyyadam | C172: 44 apps, Strong. [Habit Notes and Day Notes](<Habit Notes and Day Notes — What People Ask For.md>) differentiates dated habit notes, standing description, whole-day note. | Habit notes date record tho linked undali; habit description separate. | Strong |
| Dates across notes choodadam | C205: 3 apps, Moderate; cards R18-077/R18-153/R53-087/R76-021/R76-059. Way of Life `13775876385`, HabitMinder `4340672521`, MyRoutine `9774376446`. | Dedicated Notes destination with dated list; date-context access History lo kuda. | Moderate for aggregate retrieval; tab choice inferred |
| Clutter tagginchadam | C006: 55 apps, Certain; Way of Life `718390142` quick recording + deeper statistics available when needed ani praises. | Actions, reflection, analysis anni same long scroll lo force cheyyakudadhu. | Strong principle; solution inferred |
| Milestone value | C101: 21 apps, Certain. Habit-Bull `1539540172` requests milestones; `d116ca92-55ee-4566-b91b-260f02dfb4d0` attained badges visible ga keep cheyyalani wants. | Current target + attained record ki meaningful home. | Need supported; location inferred |
| Streak pressure avoid cheyyadam | C157: 21 apps, Certain; Me+ `12010228356`, Finch `13689426510` forced encouragement/blocked logging ni dislike chestaru. | Streak/milestone controls preference respect cheyyali; celebration navigation ni block cheyyakudadhu. | Strong |

Counts paina existing ledger/report scopes apply. Canonical confidence labels ni unchanged ga adopt chesam; aa labels exact tab layout ni validate cheyyavu. Keyword-hit counts active-user percentages kaavu, themes overlap avutayi, review dates multiple product eras cover chestayi.

## 2. Current page audit

Local checkout `claude/server-and-sync` lo `HabitPageView.swift` inspect chesam. Saved `main`, `origin/main`, `origin/integration` references lo ee file blob identical: `58eb7492520a6e78cabec9faa8a98d6be9d11983`. Idi local reference check; remote live deployment audit kaadu.

Current order:

`Identity + description → paused state → streak/best/month count/total → Today → month calendar → Over Time → Year → Runs → Milestones → Notes → Pause/Archive/Delete`. Edit toolbar lo undi.

Calendar tap already `DaySheet(habit:day:)` open chestondi. Past progress edit ability missing ani kaadu; date retrieval/action path page lo buried ga undi. Monthly calendar history navigation kosam; Over Time lo selected-period aggregate analysis. Renditiki different jobs unnayi, kaani same scroll lo context labels weak ga unte duplicate statistics laga anipistundi.

**Runs** code lo five longest consecutive streak periods, current one marked, Show All. General build habit ki **Streak history** ane name clearer; quit habit ki “Periods without [habit]” la context-specific label tarvata evaluate cheyyali. Ee phase calculations marchaledu.

## 3. People ee page ki enduku vastaru

1. **“Aa roju em record chesanu? Correct cheyyali.”** Date known or approximate; they need history navigation, readable day state, and an explicit route to change the record.
2. **“Ee habit consistent ga chestunnana?”** They need habit identity, meaningful summary and a separate place to inspect patterns/achievements.
3. **“Nenu appudu em raasanu / workout em chesanu?”** They may remember a date or only a word. Date access and an all-notes list solve different retrieval strategies.
4. **“Ee habit goal/schedule enti? Change/pause cheyyali.”** Purpose upfront; occasional management actions in a clear menu.

Quick daily logging main job Today/Home lo continue avvali. Habit details open → mark → back ane mandatory route review `9070770527` lo explicit friction. Home past-edit path requirement preserve chestunnam; Home redesign ee study scope kaadu.

## 4. Recommended hierarchy

```text
Habit details
├─ Common header
│  ├─ Back + habit name/icon + •••
│  ├─ Goal + frequency; relevant schedule/reminder summary
│  ├─ Status: paused/archived when applicable
│  └─ One compact summary: cumulative progress; optional current/best streak
├─ History — default on a general visit
│  ├─ Today record shortcut (view/edit; Add/View note)
│  ├─ Date navigation: calendar + direct month/year/date jump
│  └─ Selected day / history record → same day detail
├─ Notes
│  ├─ All dated notes for this habit; newest first
│  ├─ Find a note / choose a date / add a note
│  └─ Note → read/edit; link to its day record
└─ Progress
   ├─ Compact current milestone + attained milestones entry
   ├─ Selected-period statistics (current Over Time content)
   ├─ Year visualization
   └─ Streak history and deeper breakdowns
```

Tabs are **within this habit**, not new app-wide bottom tabs. No extra Overview tab: common header already does overview work. No independent Milestones tab. Header can collapse while scrolling; keep habit identity, menu and tab navigation reachable. Entire header height sticky ga freeze cheyyadam recommended kaadu.

### Common header: what deserves space

Habit name/icon and goal/frequency mundu. Habitify `11472660208` actual purpose/schedule choodadaniki Edit form ki velladam cumbersome ani cheptundi. Goal plain sentence lo show cheyyali; relevant reminder/schedule summary visible or directly expandable, Edit menu lopala matrame hide cheyyakudadhu.

One short cumulative measure, e.g. “42 days done” or “18 hours logged,” preserves progress after a streak break. Current/best streak, Show Streaks preference enabled unte compact ga show cheyyachu. Today status, selected-month percentages, year statistics, five runs and milestone carousel common header lo stack cheyyakudadhu. Exact metrics choice next statistics research lo final cheyyali; mockup values illustrative.

Long standing description: short preview + expand, full multi-paragraph block tabs paina kaadu. Description is habit instructions; dated Notes are recorded context. Whole-day note multiple habits gurinchi kabatti habit Notes list lo silently include cheyyakudadhu.

### History: separate job, one record

**History** label dates/current records both cover chestundi. “Logs” technical ga correct, kaani time/count events unna habits ki events-only list ani artham kavachu; unlogged past dates backfill kosam disappear avvakudadhu. Label comprehension later test cheyyali.

Today shortcut followed by date navigation. Calendar and an entry list use chesthe same dated record ki alternative access paths ga treat cheyyali; two independent log databases/editor systems kaavu. Future phase calendar/list presentation decide cheyyachu. Important requirement: an empty eligible past date kuda select chesi record add cheyyagalagali; month-by-month arrows matrame older history ki sole route kaakudadhu.

Past day tap → **open day**, not silently complete/uncomplete. Original reviews `1946127158`, `e20a0188-4949-445f-97b3-c71778990840`, `248c15c6-ba3b-463d-b794-e77df6d0abcb` accidental mutations/confusing count changes describe chestayi. Explicit editing within opened record; no need for a separate global “Edit history” mode/menu to discover basic corrections.

Date context same day note ni expose cheyyali. Read `10569299689` and `11693755507`: calendar date nunchi aa roju note choodalekapovadam specific complaint. Complete/missed/skipped days lo note possible; note save progress change cheyyakudadhu. Detailed control design next phase.

### Notes: yes to a separate tab, with context access

Recommended **Notes** tab independent browsing job kosam. Idi C172 lo note demand unna prathi user separate tab adigadu ani claim kaadu. Tab inference comes from retrieval evidence, buried notes complaints and the page's clutter.

History lo note marker/preview, day detail lo Add/View note. Notes tab lo only notes unna dates list, real date + readable preview; note tap full record, “View day” same History record ki. Notes rendu places lo kanipinchina single source of truth. History notes-only filter alternative possible, kaani base path discoverability check tarvata.

Zero notes unte tab disappear cheyyakudadhu: stable position, calm empty state, “Add note,” date defaults to Today but older date choose cheyyachu. Search icon/field retrieval ki home; exact search design scope outside. Notes mandatory prompt or ••• menu-only item kaadu (`5402526794`, `13665455992`, `13280430575`).

Evidence nuance: Habitify `11472660208` read-only goal details hide cheyyakudadhu ani says; user-authorized **Edit habit** menu placement ki conflict kaadu. Likewise Productive `5402526794` standing note-like content examples istundi; aa one review alone dated Notes tab prove cheyyadu. Standing description and dated retrieval evidence separately used.

### Progress: one analysis destination

Current Over Time, Year, Streak history, milestones ikkada. Current calendar History lo date navigation; year grid Progress lo pattern view. Same source day drilldown route maintain cheyyachu, but chart tap direct ga log mutate cheyyakudadhu. Page-level app Progress all-habits overview; ee tab **this habit** analysis. Scope header prevents confusion.

Week/Month/Year/All selected-period structure future statistics work lo simplify cheyyali. Monthly counts common header, calendar footer, Over Time repeated ga show cheyyadam avoid cheyyali. Calculations/charts ee research lo redesign cheyyaledu.

## 5. Milestones placement

**Default recommendation: Progress tab lo first compact section, charts mundu.** Current meaningful target + current progress + “View milestones” attained record. Past achievement inspect cheyyadaniki clear entry; future thresholds progress context lo reachable. Common header paina carousel, new tab, or History date navigation ni push chese banner recommended kaadu.

Carousel idea attractive, kaani left = attained/right = future mapping ni users expect chestarani direct evidence ledu. Center item itself target aa achieved badge aa distinction ambiguous avvachu; streak reset tarvata current target already earned one avvachu. Reached 30 once, now current streak 5 ante attained record and current target two different truths. Labels separate ga handle cheyyali; carousel aa logic ni solve cheyyadu.

| Placement | Assessment |
|---|---|
| Above all tabs | Record editing and note retrieval prathi visit lo motivation module ni cross chestayi; weak fit for default. |
| Inside Progress, first | Motivation inspect chese context lo actionable meaning; selected target + attained history easy to find. **Recommend.** |
| Separate Milestones tab | Fourth destination for a smaller job; Progress overlap. |
| Large carousel inside Progress | Later visual alternative test cheyyachu; current recommendation ki unnecessary complexity. |

Show Streaks off unte streak-based milestone module hide avvali. Milestones disabled unte avoid empty placeholder. Quit habits lo “time since last slip” primary product meaning kabatti compact next milestone summary common header lo exception evaluate cheyyachu; generic habit page ki same treatment force cheyyakudadhu. New habit/no achieved milestone unte calm “First milestone” context, invented badge kaadu. Historical corrections reflect achievements; “forever” ane word data correction semantics ki contrary ga use cheyyakudadhu.

## 6. Management actions

User requested top-right **•••** menu:

`Edit habit → Pause… / Resume → Archive / Restore → Delete…`

Edit current habit configuration. Daily log edit History/day detail lo. Note edit Notes/day note lo. Ee three “edit” jobs menu lo merge cheyyakudadhu. Archive history retain chestundi; Delete confirmation lo history + notes remove avutayani explicit copy. Paused/archived status header lo visible; Resume/Restore clear state-specific actions. Delete destructive confirmation app behavior lo continue avvali; mockup menu placement matrame shows.

## 7. Journal/competitor pattern check

Official documentation accessed 3 October 2026. These establish documented behavior, not proof users prefer a particular tab layout.

| App / scope | Documented pattern | Borrow / limitation |
|---|---|---|
| [Day One, iOS views](https://dayoneapp.com/guides/tips-and-tutorials/journal-views-in-day-one-for-ios/) + [calendar](https://dayoneapp.com/guides/tips-and-tutorials/calendar-view-in-day-one/) | Chronological List; Calendar dates lead to day view. | Date and content browsing as complementary paths. Four journal navigation modes mana small habit page ki copy cheyyakudadhu. |
| [Journey calendar](https://support.journey.cloud/en/categories/app-interface-functionalities/articles/calendar-interface-in-journey) + [entry detail](https://support.journey.cloud/en/categories/app-interface-functionalities/articles/timeline-interface-in-journey) | Date navigation and different browse views lead to entry context; editing at entry detail. | One dated record, multiple ways in. Location/media/template layers out of scope. |
| [Daylio](https://daylio.net/) | Notes optional within daily entry; entries browse through list/calendar/search; charts separately interpret entries. | Captured context vs aggregate analysis distinction. Mood correlation is not part of this proposal. |
| [Habitify web/desktop notes](https://intercom.help/habitify-app/en/articles/11203541-add-manage-note-on-website-desktop-app) + [logging](https://intercom.help/habitify-app/en/articles/11203298-track-progress-of-habits-on-website-desktop-app) | Habit detail has Notes panel; dated grid note marker; log history separate. | Borrow note visibility/date association. Documented current-day-only note creation mana past-day requirement ki fit kaadu; copy cheyyakudadhu. Desktop behavior mobile proof kaadu. |
| [Habitify feedback](https://feedback.habitify.me/p/website-display-issue) | One feedback post calls Notes/About hidden behind expansion hard to discover. | Supporting anecdote only, no market-wide estimate. |
| Way of Life, source review corpus | `1001797283` chronological notes list praise; `13775876385` search request; `13727064808` note date marker request. | Dated retrieval + visible marker; exact tab structure reviews settle cheyyavu. |

Fresh journal review extraction optional kabatti cheyyaledu: existing multi-app notes reviews question ni sufficiently cover chestunnayi; official journal docs retrieval approaches ni clarify chestayi. Journal-only users' priorities ni habit tracker users ki prevalence ga transfer cheyyaledu.

## 8. Alternatives and entry routes

| IA | Tradeoff | Recommendation |
|---|---|---|
| One long page | Everything discoverable by scroll, but unrelated jobs compete and Notes/actions sink. | Current clutter problem repeat avutundi. |
| History + Progress, notes within History | Fewer tabs; note writers must discover a filter/link, mixed rows can grow noisy. | Valid fallback if task testing finds Notes label unused; not default recommendation. |
| History + Notes + Progress | Three distinct jobs directly named; note and day data stay cross-linked. | **Preferred hypothesis for this product.** |
| Overview + Logs + Notes + Statistics + Milestones | Repeats shared header and breaks smaller jobs into extra destinations. | Too fragmented. |

Entry routing matters as much as default tab:

- Today/All Habits → View habit → **History** on first general visit.
- All-habits Progress → this habit → **Progress**, preserve source date/range.
- Calendar/notification/deep link for an older date → **History**, target date visible.
- Open all notes action → **Notes** for the same habit.
- Notes → View day → same **History** date; back returns to note/context.
- Home date view → existing direct edit path remains a parallel entry; this study does not implement or redesign Home.

Explicit navigation intent overrides a remembered tab. Within the same open page, switching tabs retains the date, note position and progress range independently. A statistics month selection must not silently change the date used by Add note or edit Today.

## 9. What to validate next

Small task-based prototype study: find a date three months ago and correct an unlogged day; read an old note remembered by text but not date; inspect consistency; find attained/current milestone; pause/edit/archive a habit. Check first-click correctness, successful completion, taps/backtracks and unintended data change. Compare three-tab proposal with two tabs + explicit Notes entry; counts here are not an experiment result.

Acceptance for this IA: identity and purpose visible; past-date access obvious; no date tap mutates progress; notes reachable without menu hunting; dated note and progress mutually reachable; explicit analytics entry keeps its period; streak-hidden state does not reintroduce streaks via milestone content; habit actions in one top-right menu. Detailed logs/notes/stats work starts after this structure is reviewed.

## 10. Source audit and deliverable

Primary local sources: [Feature Ledger](<../Feature Ledger.md>), [Card Index](<../Feature Ledger — Card Index.md>), [Habit Page research](<The Habit Page — What People Expect.md>), [Past-day research](<Filling In a Past Day From the Habit Page.md>), [Notes research](<Habit Notes and Day Notes — What People Ask For.md>), [Milestones research](<Milestones — Marking Progress Without Noise.md>), [Progress research](<../Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>).

Original-review verification: 49 selected IDs, 49 found, zero missing. Source path, original text/date/rating and JSONL line are recorded in `Research/Temp/habit_detail_ia_verified_reviews.json`; human-readable read file in `Research/Temp/habit_detail_ia_verified_reviews.txt`. Durable selected-review source appendix: [Habit Details — Verified Evidence](<Habit Details — Verified Evidence.md>).

Audit correction: R18-077 source list includes `12024794472`, which actually asks for diary photos; it does **not** substantiate search/aggregation. Retrieval claims here use `9774376446`, `13309723170`, `11802252737` instead. Existing milestone scan reports noisy keyword counts (e.g. app-icon badges), so they are not used to rank tab placement. Historical reviews are user experiences of their period, not assertions about current competitor defects.

Figma deliverable: [editable research board and History/Notes/Progress/Menu architecture wireframes](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=317-133) on the provided **inspiration** page. Illustration only; current app source and statistics definitions untouched.
