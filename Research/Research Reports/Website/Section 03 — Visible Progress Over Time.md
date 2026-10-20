# Section 03 — Visible Progress Over Time

Written by Codex, 12 October 2026. Current Work 93. Research-backed website proposal; design first, implementation waits for approval.

## What this section should convey

**Your small actions leave a visible record over time.** After the hero explains the app and the second section shows personal habit fit, the next proposed visitor question is **“Can I see that my efforts are adding up?”**

Use **Small actions. Visible progress.** This matches the existing store screenshot language. Supporting copy: **See your week, month and year. Your totals, patterns and streaks.** Show one clear native progress example, not a dashboard of invented numbers or a promise that the app guarantees a better life.

This order is a reasoned recommendation under W6. No source measures Often Enough website visitor intent or proves that progress is literally third in a universal ranking. Research supports the user need; the position follows the two sections already designed.

## Research scope and confidence

Re-read **32 complete original reviews across 16 app/store datasets**, dated **23 August 2016–27 March 2026**. Selection is purposive: all 18 prior streak-placement leads, followed by 14 unique earlier website-audit leads covering progress, simplicity, recovery, offer clarity and trust. These were looked up again in their original JSONL sources; 32 found, no duplicate source/ID pairs. The full originals, current source paths/line numbers and hand-written interpretations are retained in `Research/Temp/website-section3/reviews.json` and `reading-map.json`.

App Store body and Play Store text were both read; Chinese and Japanese originals were interpreted directly. The Loop record's language metadata says German but its text is English. Streaks `5320800014` is a negative written review with a five-star rating; keep that contradiction. Productive `8501717309` alleges a review burst; the allegation is not independently established and is not used as fact. Unrelated malformed rows in source files were bypassed for targeted lookup; all selected originals parsed and were found. This is not a whole-corpus recoding, market share estimate, measured benefit or conversion experiment.

The earlier [comprehensive Progress study](<../Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>), [individual Progress research](<../Habit Details Research/Original Reports/Progress and Statistics/Individual Habit Progress — Research and Recommended Experience.md>) and [streak-placement study](<../Habit Details Research/Final UX Pass/Streak Placement — Shared Header or Progress.md>) provide broader context. Their large corpus figures remain attributed earlier findings; they were not freshly re-audited in this pass. The [day-mark study](<../Progress and Statistics/Day Marks — Heat Map, Rule and Palette.md>) uses rating as sentiment for style mentions; that is not proof that every high-rating reviewer praised the chart.

## What the full originals say

| Need | Representative originals | Design consequence |
|---|---|---|
| Visible history can attract interest and make effort tangible | HabitKit 13605202758, 12949502025; Habit Tracker 6345193240 | Lead with a visual record, not a long feature list. |
| Progress over weeks/months matters beyond one streak | HabitKit 10260406195, 12458258118; Streaks 10796378002; Onrise 13591528677 | Mention week/month/year, and keep previous effort visible. |
| Totals should be useful and scoped clearly | Productive 8501717309; EZ Habit ef38a67d-2614-43ae-b7fe-8d9dcc4a58b4 | Show real units and an explicit period; no opaque score. |
| Streaks help some people and burden others | Streaks 1437821189; Days Since 8404418658; HabitKit 11650437167 | Streaks are one supported fact, not the entire promise or a guilt mechanism. |
| Clear, accurate counting is a condition of trust | Habitify 13572292515; HabitKit 13578452293; Habit Tracker 6345193240 | Use the actual native demo with intact values; no fabricated chart implying efficacy. |
| Simplicity and low effort remain essential | HabitKit 13891858507, 11650437167; HelloHabit 13366668018 | One headline, short supporting copy and one focused proof image. |

## Why this message comes next

| Candidate | What it answers | Placement |
|---|---|---|
| Progress over time | What do I get from tracking my habits? | **Third:** a distinct benefit after personal fit, with tangible product proof. |
| Easy daily logging / reminders / widgets | Will it be easy to keep using? | Strong adjacent need; Today is already visible in the hero and routines/widgets have a dedicated draft section next. Refine it separately. |
| Privacy, offline data and backup | Can I trust it with my history? | Required later trust section; not omitted or contradicted. No server claim changes here. |
| Tasks alongside habits | Can I also keep one-time to-dos? | Retain as a separate section immediately after progress. An adjacent capability does not explain the core tracking payoff as directly. |
| Free / one-time Plus | What will it cost? | Already signposted in the hero, with a fuller comparison later. |

## Primary external guidance, with scope limits

- [NN/g: UX Guidelines for Ecommerce Product Pages](https://www.nngroup.com/articles/ecommerce-product-pages/) (2019, opened 12 Oct 2026): product pages should answer questions with concise descriptions and accurate images that show use. Applied here to an app download page; it does not establish this exact section order.
- [Vaghefi and Tulu: The Continued Use of Mobile Health Apps](https://mhealth.jmir.org/2019/8/e12983/) (2019): 17 participants, 34 interviews and 193 diaries over two weeks. Clear progress feedback, flexible goal management and convenient data entry emerged as useful; perceived effort also affected continued use. Health-app context and short study; no conversion, universal habit-building or health outcome claim is transferred.
- [Bergevi et al.: User Perceptions of eHealth and mHealth Services](https://humanfactors.jmir.org/2022/2/e34278/PDF) (2022): synthesis includes progress tracking, self-monitoring and readable visuals among appreciated techniques; cognitively demanding and time-consuming services can be disliked. This broader health context supports clarity, not a statistical rank among our website sections.

## Current product and accuracy check

- `iOS/Habits/Progress/ProgressScreen.swift`: Week/Month/Year, one card per habit, read-only progress, configurable percentages/streaks, period navigation.
- `iOS/Habits/Progress/WeekCards.swift` and `HeatMap.swift`: each habit's real unit and goal scope, graded partial progress and neutral day states. It does not create an invented overall habit-strength score.
- `iOS/Habits/AllHabits/HabitProgressTab.swift`: overall recorded totals, current/best streaks, milestones and open Week/Month/Year cards.
- Current [Overall record spec](<../../../iOS/Docs/Specs/Habit Progress — Overall Record and Streaks/README.md>) and `iOS/Design Rules — Don't Regress.md` reviewed for relevant Progress rules. Older report layouts do not override current code/decisions.
- Tasks remain separate from habit progress. Skip/pause/history handling is factual, not a motivation guarantee. Planned Android output is not shown as a finished Android app.

## Visual plan and asset provenance

Keep the third section light gray after the white habit examples. Use shared SF Pro styles and semantic neutral tokens; centered phone introduction, left-aligned desktop/tablet introduction. Reuse a meaningful chart emoji from the existing licensed Noto family.

The proof is a **real iPhone simulator capture**, `ProgressUITests/testOpenSwitchAndBack()`, attachment `p01-week`, captured 10 Oct 2026 in the existing store-screenshot run2 manifest. Source PNG: `Research/Temp/store-screenshots/captures/run2/C3583B8A-1301-4133-94EE-4A8D700C92B4.png`, 1206×2622, SHA-1 `6bef82203dd66fff5de789b5801ca99f82418984`. It shows Read, 20 min a day, 6 of 6 ended days reached, 2 h 12 min this week, six goal-met squares and today's partial square. The website will show the **whole Read card** through a clean rounded viewport; no numbers or marks are repainted. The original image stays intact. Context label: **4–10 Oct · A week of reading**. Native capture is product-content imagery explicitly permitted by the user's earlier brief, not a flattened website.

Do not use the inspected individual-habit year screenshot: an Apple Intelligence notification covers it. Do not reuse the store's partial month crop: it cuts through the calendar and contains surrounding background. These are evidence of why visual inspection matters (U9), not reasons to remove real product proof.

Fixed layout and one static image need no graphics engine, moving particles or autoplay (S19). At implementation, create optimized responsive derivatives and measure low-end devices; Figma and PNG byte counts are not performance results.

Preserve the accepted hero and second-section internals. Keep the user's tasks section as the following separate section, with its existing text and layout. Replace the supplied third-section roots in place and provide standalone responsive reviews.

## Complete per-review index

The hand-written map below records every selected original, including counterevidence and adjacent concerns. Dates, full bodies, source paths and current line numbers resolve in the accompanying scratch originals. No source is silently dropped.

| Original ID | Interpretation tags | Reading |
|---|---|---|
| 7573610950 | counterweight | Percentages/comparisons/logs add cognitive burden for this person; keep marketing proof focused. |
| 6345193240 | overview,partial,layout | Visible month/year reports led to upgrade; partial day mismatch and buried charts undermine clarity. |
| 8501717309 | totals,trust | Wants a total rather than manually counting a year; review-burst allegation is unverified. |
| 1437821189 | streak,recent | Recent week/month facts and a streak motivate this reviewer; do not transfer life-changing claim. |
| 10193651577 | trend,quit,widget | Requests comparison of quit runs over time; widget duration formats matter. No health outcome promise. |
| 8404418658 | counterweight | Longest/average runs feel harmful for this person; not everyone wants prominent streak comparison. |
| 13572292515 | correctness,period | Broken quit statistics and weekly habits in daily averages erode trust. |
| 1760651629 | recovery,streak | Best record should remain visible after a break; quick reorder is separate. |
| 9405916639 | trend | Wants progression of streak lengths rather than current/best alone. |
| f9c34729-82c4-4f1d-b6e5-7e73b8a26f97 | totals,recovery | Japanese: easy use, but return-to-one count discourages; wants cumulative and consecutive totals. |
| 6ad5d1f7-2278-4299-b010-aa527f8432fc | clarity,streak | Requests simpler graph interpretation and highlighted current/longest. Do not copy failure terminology. |
| fa7ace69-ea88-42c9-924c-1a5ecb21aa77 | trend,price | Wants a streak-history graph; rejects recurring cost. |
| 9560249714 | visibility | Dislikes removal of the main-page streak count. |
| 1768efc5-64a0-4cc8-919b-6f3918229ff6 | visibility | Countable habits should expose streaks like yes/no habits. Metadata German; body is English. |
| 13366668018 | ease,counterweight,checklist | Praises concise organization; asks for reusable checklist notes and per-habit streak hiding. |
| 7539356424 | period | Weekly goal should drive weekly streak display rather than daily. |
| 13578452293 | trust,correctness | Missing cloud sync affects willingness to pay; impossible weekly streak damages credibility. |
| ef38a67d-2614-43ae-b7fe-8d9dcc4a58b4 | period,clarity | Wants this-month totals and weekly view, not lifetime total under monthly context. |
| 13891858507 | ease | Praises efficient, uncluttered recording; annual purchase is not evidence everyone rejects subscriptions. |
| 13605202758 | visual,discovery | Visualization itself attracted reviewer to app. ADHD benefit is personal testimony, not our claim. |
| 11999151976 | ease,widget,price | Customization/widgets and perceived value led to one-time payment; not evidence for a specific page rank. |
| 11530931211 | offer,trust | Free limit and gated import/export feel misleading; state ours accurately elsewhere. |
| 10260406195 | visual,recovery | Longer visible history feels less discouraging after a difficult week than complex alternatives. |
| 12458258118 | visual,recovery | Previous progress remains encouraging after days/weeks away; avoids guilt. |
| 12949502025 | visual,ease,recovery | Discovered via video; simple UX and growing habit record encourage return. |
| 11650437167 | counterweight,ease,trust | Prefers self-directed simplicity; streak/journal/motivation extras distract; export matters. |
| 11533284738 | offer,ease | Likes free simple offering; other app's unlimited-free model is not ours. |
| 12534773715 | offer | Values useful free app with no upsell; not evidence for task-section priority. |
| 10972915619 | offer,device | Skeptical of free claims; dislikes iPad fit. Product availability/price stay explicit. |
| 13591528677 | visual,year | Likes simple/free app and requests 365-day heat map. |
| 10796378002 | period,history | Wants longer than 30 days: months/year/all time. |
| 5320800014 | clarity,overview | Complains about inaccessible multi-habit progress and difficult navigation despite five-star rating. |

## Delivery status

Research and Figma proposal complete for review. Four standalone final renders inspected at 1440/768/390/320. All twelve Home/review copies have shared SF Pro styles, the unchanged native source hash and no website-text overflow. Hero and second-section text/dimensions/internal text geometry are unchanged. Tasks remain immediately after progress with their text/dimensions preserved in all eight prior copies. Final section heights are 527.32/783.15/514.12/476.21px. [Current handoff](<../../../website/Design Handoff.md>) / [manifest](<../../../website/Design Previews/Section 03 Round 01/manifest.json>). User approval, website implementation and real-phone acceptance remain separate. No app/runtime change, CI dispatch, commit, push or publication.
