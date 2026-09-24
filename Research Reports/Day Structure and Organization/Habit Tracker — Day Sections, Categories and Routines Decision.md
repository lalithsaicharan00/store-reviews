# Habit Tracker — Day Sections, Categories and Routines Decision

Date: 23 September 2026. Status: evidence-based product recommendation; not a record of an approved product decision.

## Final recommendation

**Customisable Day sections ni primary organisation ga build cheyyali. Ade section ni direct checklist ga use cheyyachu; optional Start action tho guided routine ga run cheyyachu. Categories ni optional filter ga ivvali. Separate Routines tab, separate routine collection, nested group/routine hierarchy launch lo avasaram ledu. Basic functional customisation free; visual personalisation Plus.**

Organisation ki cross-app evidence broader ga undi. Guided execution ki narrower, specific audience lo strong outcome and purchase evidence undi. Rendu needs real. Vatini competing containers ga implement cheyyalsina avasaram ledu.

Mundu ichina “routine runner ni entirely defer cheyyandi” recommendation ni refine chestunnanu: basic optional guided execution ni include cheyyali. Categories ki long-list organisation value undi, kaani first-use requirement cheyyakudadhu. Implementation order: reliable habit tracking and Day sections → optional guided execution → unobtrusive category filtering. Advanced routine automation launch scope lo pettakudadhu.

## 1. Research scope and what the numbers mean

Repository lo numbered app IDs 90 varaku undatam, 90 completed comparable app reports undatam okati kaadu. Ee audit samayam lo:

- 70 completed Markdown App Store reports unnayi.
- 72 ledger card files lo 7,590 entries unnayi; andulo research sources kuda unnayi.
- C045 (grouping), C053 (time of day), C120 (routine timers/timelines), C206 (day modes) union lo 92 cards retrieve chesanu. Relevant semantic searches tho Habit Hub, ShineDay lanti canonical mapping miss ayina evidence kuda follow chesanu.
- Related report sections, evidence cards, 30 original App Store reviews spot-check chesanu.
- Tiimo Android corpus lo 223 reviews unnayi. English keyword retrieval dwara vachina 15 relevant reviews inspect chesanu; idi multilingual corpus prevalence analysis kaadu.
- Tiimo official product page, public feedback thread, App Store reviews ni supplementary current web check kosam use chesanu.

Ee work fresh manual recoding of every raw review kaadu. Existing reports lo theme counts ni source-reported counts ga use chesanu; selected decisive claims ni original reviews tho verify chesanu. App-level coding, corpus size, observation period, feature availability different kabatti counts ni sum chesi market-wide vote cheyyaledu.

Raw canonical coverage: C045 = 54 cards / 29 source IDs; C053 = 12 / 7; C120 = 22 / 4; C206 = 6 / 1. **Ivi demand counts kaavu.** Repeated summaries, inventory rows, recommendations, bundled themes unnayi. C045 lo Routinery subroutines unnayi; C120 lo HelloHabit standalone timers unnayi. Habit Hub multi-step timer C120 ki map avvaledu. Kabatti “29 apps vs 4 apps, organisation wins by 7×” ane conclusion wrong.

**Defensible answer:** organisation need more broadly distributed; sequential execution need concentrated but consequential. **Not established:** all users lo exact percentage, which concept has the largest unique requester count, feature usage/retention rates, or which naming is most intuitive. Store reviews voting experiment or usage analytics kaavu. Ee limitations product decision ni aapavu; false precision ni aaputayi.

Audit artifacts: [summary](</Users/lalith/Desktop/store reviews/Research Reports/Day Structure and Organization/Day Structure Evidence/audit-summary.json>), [retrieved cards](</Users/lalith/Desktop/store reviews/Research Reports/Day Structure and Organization/Day Structure Evidence/retrieved-cards.jsonl>), [45 original review excerpts with paths, line numbers and IDs](</Users/lalith/Desktop/store reviews/Research Reports/Day Structure and Organization/Day Structure Evidence/verified-review-excerpts.json>).

## 2. Evidence that changes the decision

Theme counts below are inherited from the named app reports, not independently recounted here. A mixed theme can contain praise, complaints and requests; it is not entirely positive demand. Rows overlap and must not be added.

| Evidence | What users actually need | Decision implication |
|---|---|---|
| Habitify: 43 time-of-day mentions; 31 areas/folders mentions, mixed. R33-097/108. Original review 10942733003 verified. | Time sections help prioritise a large list without feeling overwhelmed. | Day sections are a useful default. Does not establish that every user needs categories too. |
| Productive: 56 category/folder requests, R13-032. Habit — Daily Tracker: 58 category/folder requests, R20-045. Days Since: 43 folder/category requests, R03-064. | Separate a growing collection into relevant sets. | Organisation need repeats beyond routine timer products. No universal habit-count threshold is established. |
| Way of Life: 37 category requests and 35 tag-praise mentions, R76-022/054. Strides: 26 tags/category requests, R48-046. | Find relevant habits without scanning everything. | Optional category filters have actual demand; they need not be another mandatory screen. |
| Streaks: nine representative time-segmentation reviews and six life-domain reviews, R23-118/119. Originals 1420887296 and 1276552134 verified. | Separate morning from bedtime; independently separate health, household, finances and other areas. | “When” and “what area” are different questions even when a user calls both groups. Counts here are selected examples, not exhaustive theme totals. |
| ShineDay: 159 mixed time-scene mentions, R52-086. Avocation: ten time-of-day differentiator mentions, R54-023. | Day sections are useful, but adding/editing their structure can be confusing. | One clear Add section action; avoid competing creation buttons for groups and routines. |
| Habify/Habit Tracker: original 13005403096, linked by R01-112. | A paying user explicitly wants more than morning/afternoon/evening, including four-hour segments suitable for shift work. | Custom sections solve schedule fit. This is functional utility, not just appearance. |
| Habit Hub: originals 13415356335 and 9195704288; R43-014/025/100. | Custom day windows, reordering within windows, a timeframe with flexibility to start, and multi-step timers are valued. | Organisation and execution can coexist in a simple experience. This is closer precedent for the combined model than a timer-only product. |
| Routinery: 277 timer/countdown/ETA theme mentions, mixed, R05-041. Originals 8204342733, 7719936293, 11994505654, 13442882939 verified. | Help starting, staying on the next step, noticing elapsed time, and leaving on time. | A folder or checkbox list alone does not deliver the routine-runner benefit. |
| Routinery: report identifies 69 requests for untimed/checklist use and 15 timer-anxiety mentions, §4.6. Originals 10507135013, 10746011966, 13073278557 verified. | Use the same habits without compulsory timing or sequence. | Start must be optional. Completing a habit must never require starting a routine. These counts are not assumed mutually exclusive. |
| MyRoutine: 46 routine-timer mentions, R18-029. Original 12353891566 explicitly names timer as reason to pay; 12815650430 says bundles let them stop using a second routine app. | Organisation plus execution in one product; timer helps overcome difficulty starting. | Basic guided mode deserves inclusion, not dismissal as cosmetic or merely speculative. A few purchase statements do not establish conversion rate. |
| MyRoutine: 31 variable-day/shift-profile requests; purchase/returning-subscriber evidence for routine modes, R18-076/095/137. | Switch between genuinely different day plans, not just rename Morning. | More plausible paid Power expansion than charging for one extra custom section. |
| HabitKit: 11 bundled subhabit/folder/page requests, R07-087. Originals 11526306665 and 13692456434 verified. | A morning container with individual things inside; reduce visual clutter. | “Routine” sometimes means a collapsible checklist, not a timer. Do not count every routine mention as runner demand. |
| Rabit: R65-028 and report §4.4. | Routine grouping can duplicate habits, leave tabs empty, or hit limits even for subscribers. | Same habit/history underneath every view; avoid duplicated routine copies and arbitrary section caps. |

The original reports are in [App Store Reports](</Users/lalith/Desktop/store reviews/App Store Reports>). Card IDs above resolve in the saved retrieval file where present, or the corresponding `Tools/prd_ledger/<app number>/cards.jsonl` file.

### Raw verification corrected two overstatements

1. R01-112 cites two IDs for custom time segments. Only **13005403096** explicitly requests additional segments and discusses shift work. **8504117544** asks to see morning/afternoon/evening together on one page. Ee audit lo second review ni extra-custom-segments vote ga count cheyyaledu.
2. R05-007 says 162 reviewers report no longer being late. Its cited **8305228306** actually describes hoped-for benefits, onboarding problems and uncertainty; **12283999607** says they are still sometimes late but know by how much. Other originals do report improved punctuality. Ee decision lo **162 ni 162 proven successful outcomes ga use cheyyaledu**. Similarly 277 is a timer/countdown/ETA theme, not 277 independent endorsements of live ETA alone.

These corrections weaken overconfident aggregate wording, not the verified need for optional guided execution.

## 3. Tiimo lesson: a routine is more than a label or one timer

Tiimo official [visual planning page](https://www.tiimoapp.com/product/visual-planning) shows planning and focus tools. It is an implementation reference, not evidence of popularity.

On the [public routines feedback thread](https://tiimo.nolt.io/26), one user explains needing a whole morning sequence that can move together when work starts later. They separately describe an unscheduled arrival-home checklist. Another prefers order without timing. The thread supports flexible modes, not compulsory timing or a universal user preference; it is historical feedback, not a statement of current feature availability.

Two dated reviews on the [Canadian App Store listing](https://apps.apple.com/ca/app/tiimo-to-do-list-planner/id1480220328), 22 October 2024 and 3 May 2025, describe dissatisfaction after timed routines became checklists or a whole-routine timer; one says they intend to cancel and another says they are switching. Developer responses acknowledge removal. These are specific self-reported cases, not a churn rate.

Local Android reviews reinforce the distinction: `d193981e-a21a-4a2b-86b8-e924b39c7217` misses old routines; `4a86d64e-6a62-4686-827f-a89ce97a6861` reports changed/lost workflows but later finds some functionality and adjusts. Current implementations/platforms differ. Do not copy a supposed single unchanging “Tiimo model.”

**Design implication:** Start Morning ani button petti total 45-minute timer chupinchadam alone full routine support kaadu. Guided mode should help with the current step, next step and remaining plan. Checklist-only use kuda equally valid.

## 4. Exact product model

### One primary container: Day sections

Settings title: **Day structure**. Create action: **Add section**. This is a proposed naming choice, not empirically proven superior wording.

Default sections: Morning, Afternoon, Evening, Anytime. Users can rename, reorder, remove and create their own: Before work, After work, School run, Wind down, Night shift. An empty section need not occupy Today. Users who prefer a flat list can turn section grouping off.

Every section has a name and order. A preferred time window is optional. “After work” can stay untimed. A window organises the day; it does not force every included habit to occur consecutively or automatically mark it missed when the window closes. A planned window and actual routine start/finish are different values.

Example: Morning contains Make bed, Stretch and Read. User A checks these individually across the morning. User B taps Start and follows them consecutively. Same section; same habits; same dated history. No separate routine to recreate.

### Routine as an optional way to do a section

Provide a secondary **Start** action for a section. Direct check-off remains the primary action. Let the user choose the habits to run and preserve their order; do not force a whole afternoon's disconnected activities into one session.

Basic guided mode:

- Current step and Next/Done; pause, resume, skip this step, end and undo.
- Optional duration per step; untimed steps and untimed sequential use work too.
- A remaining-time estimate when durations are provided; revise it when timing changes. Unknown untimed steps must not produce falsely precise finish estimates.
- Optional alerts with a clear off switch. A timer finishing is not proof that a habit was completed.
- Show only today's due occurrences and avoid re-logging already completed ones. Skipping a step in a session does not automatically fail or excuse the entire day's habit.
- All-day/avoidance/accumulation habits such as No smoking or 2 L water can remain normal tracking entries. They should not be forced into a countdown sequence.

No separate Routines tab in the initial product. No nested subroutines initially. A basic runner is still real functionality: background timing, interruption recovery and accurate progress must work before it ships. These requirements follow from the workflow, not evidence that users asked for every control by name.

### Categories as optional filters

Use one label, **Category**, rather than simultaneously offering Groups, Areas, Tags and Folders. Optional values: Health, Learning, Home, Work. Keep category assignment optional in habit details; expose Filter when useful. Do not require categorisation in onboarding or turn it into another container tree.

Why needed even with sections? Walking in Morning, medication in Afternoon and stretching in Evening may all belong to Health. Selecting Health should show those habits together while preserving their section placement. Morning answers “when”; Health answers “which area.” User does not need to duplicate habits or rearrange their day to see the same area together.

Category filtering can narrow what is displayed, but it must not silently redefine what the section's Start action will run. Start should show/confirm its included steps clearly.

Use one habit record. If Brush teeth genuinely occurs morning and evening, model two scheduled occurrences of that habit with separate completion state. Merely viewing the same occurrence through a category must not create another check-in. Moving sections, changing names or switching day plans must not rewrite historical completions. A session crossing midnight should retain explicit tracking-date attribution and allow correction.

## 5. Free versus paid

| Capability | Recommended boundary | Reason |
|---|---|---|
| Default sections; create, rename, reorder, remove custom sections | Free, without an artificial section count cap | Makes the basic tracker fit the user's actual day. Custom-segment demand exists; a universal willingness to pay for it has not been established. |
| Optional time windows, ordinary scheduling, section assignment, basic icons/colours | Free | Functional scheduling and readable defaults; consistent with the existing free baseline. |
| Create categories and filter habits | Free | Core organisation of the free unlimited habit list. Avoid replacing a habit cap with an organisation cap. |
| Direct check-off and basic optional guided execution | Free | A complete daily use loop. Timer purchase evidence exists, but the product strategy is a generous complete core; this is a deliberate product choice, not proof that timers cannot sell. |
| Premium themes, section cover art, extended palettes, alternate app icons and widget designs | One-time Plus | Matches the business report's actual personalisation examples. Attractive defaults and accessibility remain free. |
| Save/switch entire day-plan variants, rotating roster automation, reusable nested sequences | Later Power/Plus scope, not initial requirement | MyRoutine modes and Routinery subroutine/variation requests provide a basis for investigation. Stronger purchase evidence exists for day modes than for every proposed automation. Ordinary irregular scheduling must still work free. |

The [Business Model, Free Baseline and Moat report](</Users/lalith/Desktop/store reviews/Research Reports/Business Model and Monetization/Habit Tracker — Business Model, Free Baseline and Moat.md:170>) describes paid personalisation as theme packs, palettes, photo covers, app icons, widget designs, sounds and haptic styles. It separately places ordinary schedules in the free baseline. **“Anything the user customises is paid” is not what that boundary says.**

Free custom sections are not proven to maximise revenue. They are the recommendation that best matches the chosen “best free tier” strategy and observed schedule-fit needs. Existing paid groups/timers in Grit, Do Habits or MyRoutine demonstrate monetisability in those products; they do not compel us to gate the same utility. Cosmetic payer co-occurrence in the business report is also not causal proof of cosmetic conversion.

Do not add a new subscription solely for section names, time windows or a basic timer. Preserve the existing one-time Plus direction for paid visual/power additions.

## 6. What this decision does and does not assert

High confidence: users need flexible organisation; some users need guided execution; forcing all users into timers is wrong; duplicated containers and history damage cause real friction.

Moderate confidence: customisable sections with optional guided execution and secondary category filtering is the best synthesis for this proposed habit tracker. Exact UI composition and naming are design inferences supported by adjacent evidence, not a directly tested winning interface.

Not established: market-wide numerical majority, guaranteed retention/conversion uplift, all users preferring one label, or absence of demand for advanced routines. These are not reasons to leave the feature decision unresolved.

**Build decision: Day sections first, optional Start within them, Categories as a filter. Functional customisation free; premium appearance and later day-plan automation in Plus.**

## 7. Follow-up decision: sub-habits / steps

**Recommendation: include optional, one-level Steps inside a habit, free. Do not introduce recursively nested, independently scheduled sub-habits in the initial product.** This is an extension of the model, not another competing organisation system. Day sections remain the higher-priority foundation.

### Two needs hidden inside the same term

“Morning routine → Make bed, Brush teeth, Read” is largely a container request; the existing Day section model already covers it. “Music practice → Breathing, Vocal warm-up, Practice a song” describes how one activity is carried out. Day sections alone do not cover this second need without filling Today with tiny entries.

If a child needs its own independent frequency, reminder, target and streak, it should be a normal habit inside a section. If it helps the user complete one recurring activity, it can be a Step. This is a product distinction, not a claim that every user naturally uses these words consistently.

### Additional evidence checked

- **HabitKit:** original reviews `11526306665` and `13692456434` explicitly request a morning parent containing individually checkable actions; the former asks for the parent to complete when the children are complete. The report's 11 requests combine subhabits, folders and pages; they are not 11 pure subhabit requests. Much of this evidence supports our existing section design.
- **Awesome Habits:** original `11063416316` explicitly requests Music as the main task, breathing and vocal warm-up as subtasks, with time tracking per subtask. The reviewer expresses purchase intent blocked by the missing functionality. This is direct evidence of steps inside one activity, but one stated purchase intention is not actual conversion. Original `12933186432` also requests subtasks. The report's seven mentions bundle subtasks, habit stacks and routine views; they must not be presented as seven identical step requests.
- **Routinery:** originals `13942902589` (tidying a room inside a night routine), `13624660676` (bathroom routine inside a morning routine) and `9017685503` (a multi-step shower sequence usable independently and within morning) show a real decomposition/reuse need. R05-069 reports 12 subroutine requests. Reusable linked routines are richer than a simple checklist; a one-level Steps feature would only partially serve that advanced demand.
- **Dear Me:** original `11646116789`, a premium user, requests subtasks alongside durations and numeric progress and says other apps are needed. This is a bundle of unmet needs, not isolated willingness to pay for subtasks.
- **Habitify:** official [Checklist versus Task documentation](https://intercom.help/habitify-app/en/articles/10501774-compare-checklist-vs-task) distinguishes recurring checklist actions for completing a habit from one-off preparation tasks. It confirms a real implementation pattern, not demand size.
- A [Habitify feedback request](https://feedback.habitify.me/p/enhanced-tracking-with-habitify-checklists) asks to preserve and analyse checklist-item history. This is a small qualitative signal for richer tracking, not evidence that everyone needs independent child statistics or will pay for them.

Raw-review locations: [HabitKit](</Users/lalith/Desktop/store reviews/App Store Reviews/7. Habit Tracker - HabitKit - Streaks & Accountability/reviews.jsonl:829>), [Awesome Habits](</Users/lalith/Desktop/store reviews/App Store Reviews/41. Awesome Habits - Habit Tracker - Streaks, days since & goals/reviews.jsonl:521>), [Routinery](</Users/lalith/Desktop/store reviews/App Store Reviews/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD/reviews.jsonl:3081>), [Dear Me](</Users/lalith/Desktop/store reviews/App Store Reviews/9. Dear Me - Daily Routine Tracker - Self Care & ADHD Habit Planner/reviews.jsonl:1145>).

Do not use R52-210's sole cited review `8577613263` as an example supporting subtasks: raw verification shows that review discusses limited social sharing and innovation, not subtasks. The inherited 62-count CORE_SUBTASK theme was not independently recounted in this follow-up and is not necessary for the recommendation.

### Product behaviour

Example hierarchy: Morning section → Skincare habit → Wash face / Moisturise / Sunscreen steps. Another habit such as Read stays alongside Skincare. UI says **Add steps**, not Add sub-habit. Steps stay collapsed under their habit by default, with a compact indicator such as “2 of 3 steps.” No steps-under-steps and no separate Sub-habits tab.

1. The parent supplies the recurrence and scheduled occurrence. Each new occurrence gets a fresh checklist. Morning and evening occurrences have separate check states; this is not a blind midnight reset.
2. Completing all steps completes that occurrence of the parent habit. Incomplete steps remain visible as partial progress. “2 of 3 steps” is a count, not a claim that two-thirds of the effort or benefit was achieved.
3. Parent completion counts once in daily habit totals. Children do not each create another completed habit or independent streak. Users needing independent child goals use normal habits.
4. Offer an explicit **Mark all done** shortcut and undo for people who completed everything without logging each step. Do not require a timer or many taps for ordinary completion.
5. For a step that does not apply today, allow a clearly recorded **Not needed today** exclusion from that occurrence's required checklist. It is not a completed step, must not delete the template, and excluding every step must not automatically count the parent as done. This behaviour is a design proposal, not a directly validated preference.
6. Preserve historical step names/check states when future steps are edited or removed. Past completion must not change because the checklist changed today. Basic dated history stays free; no separate child analytics screen is needed initially.
7. In guided mode, step through the expanded actions with their parent context visible. Optional step durations can share the existing timer mechanism; do not simultaneously count a parent timer and its child timers. The parent completes when its applicable steps do. Untimed checklist use remains supported.

Simple repeat counts are a different need: drinking eight glasses does not require eight identically named steps. Use a quantity goal. A one-off setup action such as buying running shoes should not become a recurring checklist item by default.

### Monetisation and scope

Creating, renaming, reordering, completing and reviewing basic steps should be **free**, without a special paid step-count cap. This is functional decomposition, consistent with free Day sections and the complete tracking baseline. It is a strategy choice supported by concrete need, not proof that nobody would pay for subtasks.

Keep paid value in the existing appearance/depth/power direction. Reusable linked sequences, saved variants and advanced analysis may later fit Plus, but this research does not establish their conversion potential. Do not expand the initial Steps feature into a project-management hierarchy to manufacture a premium tier.

**Include Steps as optional free habit detail. Keep independent habits in Day sections; reserve reusable nested routine systems for later work.**
