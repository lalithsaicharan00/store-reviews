"""Stage 3 merge for report 48."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C264", "product-rule", "Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product",
    "Report 48: a mid-2021 redesign of history logging that multiplied the taps to back-fill days drew ten reviews in three months (May–Aug 2021 window n = 78, mean 3.86★, 28.2% 1–2★ — 'Latest update forces you to double click for every single activity'; 'turning a 10 second daily update to about 60'), disproportionately from long-term users (7) and payers (6); the developer restored the one-click behaviour and the reinstatement was welcomed by name, after which too-many-taps fell to 0.24% — 'log-entry friction is uniquely expensive for this product' because simplicity of logging (817 reviews, 18.56%, mean 4.84 — 'open the app, click a check mark, exit') is its most load-bearing quality. Report 47 (DotHabit): a long-press → record screen → done flow counted as too many taps by 14 (mean 2.86) with one-tap logging requested since 2019. Related: [[C240]] (nothing between tap and done), [[C159]], [[C229]] (a deliberate gesture must complete the log, not open a form).")
add("C265", "research", "Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps",
    "Report 48 (Strides): four tracker types — Habit (yes/no), Target (a number by a date), Average (rolling mean), Project (milestones, %) — are the defining feature and the differentiator: 485 reviews (11.02%, mean 4.82★) — 'I don't want to reduce everything to the binary yes/no' (2013) repeated in structure in 2024; a reviewer lists seven rivals before 'Strides is the only app that does both'; highest in GB (13.79%), AU (14.52%), IN (16.90%); bad-habit / 'less is better' inversion praised by 105; goal pacing (the projected-date and 'am I on pace' maths only Target and Project provide) praised by 56 at 4.97★ — 'This theme, not streaks or design, is why people switch to Strides'. The cost is a decade of setup confusion (118 reviews at 2–3% in every era, concentrated on choosing between the four types) and yes/no semantics that turn ambiguous for bad habits (12). Related: [[C108]] (goals / targets), [[C048]] (flexible units / partial progress), [[C019]] (quit-habit mode), [[C136]] (choose the mode at creation), [[C135]].")

ext("C001", " Report 48: the Strides story is the cap variant — a free tier of ~10 trackers (Oct 2015) tightened to 7 (mid-2018) and 3 (2020 on): 'free cap too low' rose 0.00% → 0.32% → 1.59% → 7.00% → 9.87% of E5 and 12.1% of the last 24 months, the only negative theme still growing, while 'free is enough' fell 7.82% → 4.81% — 'as the free tier shrank, satisfaction with it fell and complaints about it rose, roughly in proportion'; 17 reviews record a feature removed from free (mean 2.82).")
ext("C002", " Report 48: 72.38% of 4,402 reviews praise the product (mean 4.84) and 14.04% attack how it is sold (2.53) — those 618 supply 51.0% of all 1–2★; the 4★ band withholds the fifth star mostly over price (8.4%) and the cap (6.2%); five monetisation regimes over 11 years each produced their own complaint family; 'Nothing in this corpus suggests users dislike Strides. A large, repeated minority dislikes the deal.'")
ext("C003", " Report 48: 58 want a one-time purchase (several naming $10–$20), 48 reject subscriptions in principle, and 28 accept the model but call a $79.99–$149.99 lifetime 'disproportionate for a tracker' (mean 2.46; China frames it as a quarter of a second-hand iPhone); 23 payers name a lifetime purchase (mean 4.52); reviewers who leave for Habitify cite 'one time $10 and comparable features'.")
ext("C004", " Report 48: price complaints fell from 21.43% of the 2015 conversion era to 4.69% of 2022–26 — 'pricing anger has migrated from \"too expensive\" to \"I can't try it\"'; Canada (9.47%), Australia (9.68%), Germany (10.92%) and China (10.96%) are the price-sensitive storefronts; 73 say it is worth it at 4.97★.")
ext("C005", " Report 48: 453 'best of many' (10.29%, mean 4.89) and 105 competitor-named (3.16) describe one trade — wins on tracking flexibility, loses on price model; rivals Streaks, Habitify, Productive, Way of Life, Done, HabitBull, Habit, Loop, TickTick; 'reviewers concede Strides is more powerful and leave anyway' — 'no evidence of a capability gap that is losing users… repeated evidence of a packaging gap that is'.")
ext("C006", " Report 48: simplicity 817 (18.56%, 4.84) at 16–22% in every era for eleven years, coexisting with four tracker types — 'the most robust habit tracker without being bloated'; reviewers mean both fast to log and uncluttered to look at.")
ext("C007", " Report 48 (the counter-case to a fixed cap): a cap that moved 10 → 7 → 3 produced the corpus's only growing grievance (211, 4.79%, mean 2.68) — 'No one has just one habit they need to track'; the three-tracker tier 'cannot show' a multi-goal product; the 2015–18 era with ~10 free trackers produced the highest ratings (4.62★), the most free-tier gratitude (7.82%) and a growing payer base; report's E1: raise the tier until the differentiator is demonstrable.")
ext("C008", " Report 48: unlimited custom reminders per tracker with the user's own message text are free and praised by 224 (5.09%, 4.87) — reminders faulted by 78 at a stable ratio.")
ext("C009", " Report 48: widgets arrived ~2020 and interactivity was later removed (12 praise at 5.00, 20 requests, 14 widget bugs).")
ext("C011", " Report 48: better reports / trends is the top open request (76, mean 4.07, still open Aug 2026) and comes almost entirely from people who like the app — the report's candidate next paid feature.")
ext("C013", " Report 48: cross-device sync is the paid feature most often named as the purchase reason; multi-platform praise recovered from 0.78% to 3.13% with the Mac app (Mar 2022), yet sync failure is the one reliability theme that never improved (11 / 12 / 12 / 13 per era) and is the most common reliability complaint in 2022–26.")
ext("C014", " Report 48: several alerts per day per tracker with user-written text — 224 praise (4.87), free.")
ext("C015", " Report 48: shared / partner accountability requested by 22 (mean 4.45), including a coach who would move 100 clients onto the app if it existed.")
ext("C016", " Report 48: no skip / vacation mode (13) and weekly goals that still demand a daily answer (21 weekday-scheduling) are 'the two structural scoring complaints', sustained across all five eras from otherwise-happy users — report's change #10.")
ext("C019", " Report 48: bad-habit / 'less is better' tracking (a limit, not a goal; red / green inverts) praised by 105 (2.39%, 4.81) — a quit-smoking reviewer benchmarked 10+ rivals; yes / no semantics turn ambiguous in bad-habit logging (12).")
ext("C020", " Report 48: CSV export is premium, praised and occasionally broken (16 requests, 4 export bugs).")
ext("C021", " Report 48: Apple Health auto-logging of steps / weight and Siri Shortcuts voice logging praised by 17 (rising to 1.56% of 2022–26); 3 Health sync bugs.")
ext("C022", " Report 48: Watch app and complication praised by 24 (4.67) when working, faulted by 12 (2.33) when blank; 8 want a complication.")
ext("C023", " Report 48: widget interactivity was removed after arriving ~2020; the request persists (20).")
ext("C024", " Report 48: streak motivation 144 at mean 4.96 — the highest of any theme with n > 100 ('I can't bear to see it go'); 507-day and 1,000-day streaks; gamified rewards requested by 17 (4.47); a 2013–14 points system was disliked (10).")
ext("C027", " Report 48: Russia (10.13% no-localization, requests 2013–17) and China (12.33%) are the clearest localization signals; a 2022 review celebrates Chinese localization arriving; rest-of-world raises localization four times as often as high-spend markets; the listing reached 10 languages.")
ext("C029", " Report 48: billing problem 23 (2.52) — 1 / 4 / 6 / 12 by era, the fastest-growing monetisation fault: charged $39.99 instead of the agreed $4.99; charged the full year at the start of a 7-day trial; charged twice after cancelling before the trial ended, blocking other App Store purchases; 'another active subscriber using the same receipt'; paid subscription not recognised after an update (3); 23 refund requests at mean 1.04★ — the lowest-mean theme with n > 10.")
ext("C030", " Report 48: sync failure is the only reliability theme that never improved — 48 (1.09%, 2.65), flat at 11–13 per era since 2015, now the most common reliability complaint; the 2015 v3.0 sync rewrite shipped with crash-on-launch (29.55% of the era), duplicated trackers (20) and data loss (25).")
ext("C031", " Report 48: two crash crises — iOS 8 / iPhone 6 (late 2014, crash on adding a tracker and on the back button, 20 reviews Sep–Dec 2014) and the v3.0 release (81 crash-on-launch reviews in 2015) — then a 2020 iOS 13 / 14 freeze (25 reviews) that vanished; the crash union fell from 37.3% of E2 to 2.9% of E5 — 'fixed, and stayed fixed… defended, not revisited'; crash / won't open is 23.3% of all 1★.")
ext("C034", " Report 48: data loss 58 (1.32%, 1.67), 25 in the 2015 sync rewrite; 36 of the 484 one-stars; Australia over-indexes (3.23%).")
ext("C035", " Report 48 (counter-evidence on mandatory accounts): forcing an account and online sync on a local tracker in Jan 2015 drew 39 reviews at mean 1.64 — 'a privacy objection, distinct from price' — strongest in Germany (5.04%, the largest over-index of any theme in any storefront; one review invokes German consumer law); iCloud sync later replaced the account; login / account failures 21 (1.86).")
ext("C036", " Report 48: support is reachable only inside the app, so users whose app will not open have no route — 14 reviews (1.08% of 2022–26 and growing) are 1★ reviews written as support tickets, nine from payers; the report's fix #3: publish a support e-mail on the website and the listing; separately 29 got no response (1.55).")
ext("C038", " Report 48: timezone / date bugs 26 (3.35, 2014–22); wrong counts / stats 85 (2.59) across every era; day-boundary 2.")
ext("C039", " Report 48: notification bugs 78 (1.77%, 2.64) at a stable ratio against 224 reminder praise; notification overload 12 (2.33).")
ext("C042", " Report 48: ADHD is the lowest-rated segment (13, mean 3.77) in a corpus where every other segment averages 4.6+; students 24, mental health 23 (4.78), health / medical 24.")
ext("C043", " Report 48: arbitrary cadences such as every-other-day requested by 35 (3.97); weekday scheduling — weekly goals that still demand a daily answer — 21 (3.57).")
ext("C044", " Report 48: a Mac app from ~March 2022 was welcomed by long-term users and lifted multi-platform praise to 3.13%; the web app (2015 – ~2019) was discontinued and its removal is still resented — 17 want it or Android back (0.84% of 2022–26), Windows users in particular lost access.")
ext("C045", " Report 48: tags / filters / a Today list are premium; requested by 26 (4.12).")
ext("C046", " Report 48: Siri Shortcuts praised (17 with Health); an API or IFTTT / Zapier automation requested by 11 (4.18).")
ext("C048", " Report 48: numeric Target and rolling Average trackers are the reason 485 reviewers chose the app; flexible units requested by 13 and true time-duration HH:MM by 8 — see [[C265]].")
ext("C052", " Report 48: gamified rewards requested by 17 (4.47); the 2013–14 points system drew 10 complaints and was dropped.")
ext("C057", " Report 48: 62 call the UI dated (3.63, rising to 1.68% of E5) while 14 praise its plainness ('does not include \"cute\" graphics') — the report: do not redesign for novelty; the tap-count lesson is the larger risk.")
ext("C059", " Report 48: 103 praise shipped updates and the public feature-voting board (4.80); 55 confirm a specific fix (4.78); Australia has the highest dev-listens rate anywhere (6.45%); several reviewers raise their rating in place after contact.")
ext("C061", " Report 48: 'free is enough' 248 (5.63%, 4.82) — the load-bearing praise of the freemium era; 38 payers describe months or years of free use before paying 'to support the developers'; pay-to-support-dev 7–9 at 5.00 — 'sustained free use first, then payment as endorsement'.")
ext("C062", " Report 48: high-spend markets (US, JP, GB, DE, CA, AU, FR, KR, CN; 77.81%) hold 82.6% of identified payers, complain about price and the model more and about the cap less; the UK is the most paid-engaged storefront (6.51% payers vs 3.91%); Japan (18) and Korea (24) are nearly absent — a distribution gap, not a sentiment one; Brazil is the highest-rated and least analytical storefront.")
ext("C064", " Report 48: one-time requesters name $10–$20; the lifetime at $79.99–$149.99 is rejected by 28 who accept the model; Canada is the most price-sensitive storefront (9.47%) with praise intact — 'Canadians like the app and resent the deal more than anyone else'.")
ext("C065", " Report 48: 172 payers (3.91%) average 3.92 vs 4.24 — 84 (48.8%) also report a problem (billing 12, refund 8, no support reply 8, crash 9, sync 6); 31 one-star reviews are from payers — 'the most expensive failure mode in the corpus'; 'The paid experience fails at exactly the moments it matters.'")
ext("C066", " Report 48: a built-in timer requested by 5–6; time-duration HH:MM units by 8.")
ext("C067", " Report 48: fitness / weight 95 (2.16%, 4.87) is the largest segment — 80 lbs lost, 31 lbs and 26 inches; behaviour-change claims 267 (4.95) rising to 8.18% of 2022–26.")
ext("C073", " Report 48: can't edit / delete a log entry 32 (3.22); backfill history praised by 13.")
ext("C075", " Report 48: confusing setup 118 (2.68%, 3.11) has sat at 2–3% in E1, E3, E4 and E5 — 'a decade of onboarding friction that no redesign has removed', concentrated on choosing between Habit / Target / Average / Project and on where deletion lives; the existing goal-setting course (credited by 27) could be surfaced at first run.")
ext("C076", " Report 48: 3 reviews claim fake reviews (1.33); no burst or brigading pattern found — the Jan 2015 spike spans 20 storefronts with unrelated texts.")
ext("C078", " Report 48: the Jan 2015 subscription launch shipped with a broken release — 81 crash-on-launch, 25 data-loss and 20 duplicate-tracker reviews in the same window — and reviewers linked the two: 'they were asked to start paying for an app that had just stopped working'; the 19 Jan – 30 Sep 2015 window averaged 2.06★ with 73.2% 1–2★.")
ext("C080", " Report 48: dark mode requested by 11 (4.64).")
ext("C082", " Report 48: no ads in any era — 33 praise it, zero complain; two reviewers propose ads instead of the paywall, which the report reads as hostility to the cap rather than endorsement of ads.")
ext("C092", " Report 48: China's lifetime objection is cost-of-living framed (a lifetime plan near a quarter of a second-hand iPhone); price sensitivity clusters in CA / AU / DE / CN.")
ext("C093", " Report 48: a full-screen / post-log upgrade prompt introduced around July 2024 drew 6 nag reviews in three months from long-term free users who say it reduced their willingness to pay ('I might even consider paying money for the app. But I darn sure will not… as long as the nag screen is still in place'); one records it being softened and raised their rating — 'the only monetization mechanic in the corpus that users say actively reduced their intent to pay'.")
ext("C094", " Report 48: review-prompt nag 9 (2.22); a prompt existed 2013–15 and ~2021; the prompt-driven share of 379 five-star low-information reviews is unknowable.")
ext("C095", " Report 48: non-punitive framing praised by 39 (0.89%, 4.90).")
ext("C096", " Report 48: 25 reviews object to being forced to create an account and go online for a local tracker — a privacy objection distinct from price, strongest in Germany.")
ext("C104", " Report 48: the 2015 conversion was announced as grandfathering prior purchasers and 14 say it was not honoured ('bait and switch', 'SCAM', 'Rent what you've paid for'); the cap reductions of 2018–20 arrived unannounced and were discovered by users deleting a tracker and finding the slot gone (23, mean 2.22).")
ext("C108", " Report 48: numeric Target (a number by a date) and Project (milestones, %) trackers with a pace line and projected completion date are what 485 reviewers switched for; goal pacing praised by 56 at 4.97 — see [[C265]].")
ext("C109", " Report 48: trial terms 26 (1.65) — charged the full year at the start of a 7-day trial; charged twice after cancelling before the trial ended; refund requests concentrate in 2019+ trial and auto-renew disputes.")
ext("C110", " Report 48: 48 reviews (mean 1.65, rising 0.49% → 2.05% of E5) invested setup effort before meeting an undisclosed 3-tracker wall — 'I lost my time encoding 3 trackers for nothing'; 'Wish i knew before i downloaded and set everything up' — the report's fix #1: disclose the limit on the listing and at first run, 'the cheapest 1★ in the corpus to eliminate… about the surprise, not the price'.")
ext("C112", " Report 48: cancellation difficulty 4 (1.25), retained as compliance-adjacent.")
ext("C116", " Report 48: a free goal-setting course / handbook is credited by 27–29 reviewers (4.93) and several convert from it — a companion-content funnel rather than a paid layer.")
ext("C119", " Report 48: the 2021 history-logging redesign is the one self-inflicted UX wound (see [[C264]]); 62 call the UI dated but the report advises against redesign for novelty.")
ext("C133", " Report 48: the cap is the dominant mechanical purchase trigger ('I'll probably upgrade to the paid version soon to get more trackers') but a 3-tracker cap on a multi-goal product blocks evaluation — 'You are not allowing a certain group of people try out your app'; multiple reviewers propose the split themselves: pay once for capacity, subscribe for sync / reports.")
ext("C134", " Report 48: five-star reviews are simplicity 23.7%, flexible tracker types 13.7%, best of many 13.6%, behaviour change 8.4%; US reviewers talk about outcomes and accountability more than anyone else.")
ext("C136", " Report 48: a decade of setup confusion (118 at 2–3% every era) concentrates on choosing between Habit / Target / Average / Project and on ambiguous yes / no semantics for bad habits (12) — the mode choice needs teaching at creation.")
ext("C141", " Report 48: an iPad app was requested 2013–15 (9) and landscape iPad 2015–16 (8); iPad is now supported.")
ext("C147", " Report 48: 43 state an intention to pay that the current terms defeat (4.12) — 'I will pay for an app after I use it for a couple weeks and have grown to appreciate the app'; 38 payers describe long free use before paying.")
ext("C152", " Report 48: charged the full year at the start of a 7-day trial; a receipt shared by 'another active subscriber'.")
ext("C155", " Report 48: the web app (2015 – ~2019) was discontinued and Windows users lost access — 17 still ask for it; widget interactivity was removed after shipping.")
ext("C159", " Report 48: 'open the app, click a check mark, exit' is what simplicity means to 817 reviewers — see [[C264]].")
ext("C171", " Report 48: accessibility 6 (3.50).")
ext("C172", " Report 48: per-entry notes praised by 21 (4.95), requested by 14; whether notes are free is disputed in-thread.")
ext("C175", " Report 48: paid subscription not recognised after an update (3); the 2015 v3.0 release lost data for 25 and duplicated trackers for 20.")
ext("C186", " Report 48: the corpus's defining event — a paid app converted on 19 Jan 2015 to a $4.99/month subscription with a mandatory account; nine months at 2.21★ with 68.2% 1–2★ (February 1.66★, 83.9%), 92 'broken bargain' reviews (paid-then-subscription 60, forced account 25, grandfather promise broken 14 — 'Rent what you've paid for'); reversed in October 2015 (free unlimited tier) and the mean jumped to 4.62 — 'The recovery is as clear as the crash'; the theme is extinct after 2016 but still 10.7% of all one-stars.")
ext("C191", " Report 48: 23 users who built history on 10 or 7 free trackers found the cap shrunk under them (mean 2.22) — retroactive reduction lands on the longest-tenured users; fix #2: never reduce existing users' free capacity.")
ext("C209", " Report 48: 39 reviews (1.64) objected to a forced account on a local tracker in 2015–18; the complaint ended when iCloud sync replaced the account.")
ext("C212", " Report 48: refund requests 23 at mean 1.04★ — the lowest-mean theme in the corpus with n > 10.")
ext("C218", " Report 48: the listing states 3 free trackers while reviewers report 10 / 8 / 7 / 6 / 5 / 4 / 3 / 2 / 1 across eras; 48 hit an undisclosed wall after setup (1.65★) — disclose the limit on the listing and at first run.")
ext("C219", " Report 48: users who deleted a tracker to make room found the slot gone (23, mean 2.22, 'the most damaging variant') — fix #2: restore slots freed by deletion.")
ext("C222", " Report 48: the pressure valve reviewers propose is a cheap, narrow tier that only unlocks trackers — pay once for capacity, subscribe for sync / reports (58 one-time requesters, $10–$20); 15 ask to raise the free cap.")
ext("C223", " Report 48: can't edit / delete a log 32 (3.22).")
ext("C227", " Report 48: end dates and archiving requested by 23 (4.09).")
ext("C229", " Report 48 (counter-evidence): a redesign that made every log a double click cost ten reviews in three months from loyal payers — see [[C264]].")
ext("C230", " Report 48: duplicate entries 32 (2.31), 20 of them in the 2015 sync rewrite.")
ext("C231", " Report 48: 'Praise is remarkably uniform; grievance is local' — simplicity and flexibility land within a few points everywhere while price sensitivity clusters in CA / AU / DE / CN and localization in RU / CN; China splits sharpest (crash 12.33%, localization 12.33%, simplicity at 5.00★).")
ext("C236", " Report 48: the cap 'announces itself' only after setup — 48 reviews at 1.65★ met the wall after investing effort.")
ext("C240", " Report 48: a post-log upgrade prompt (Jul 2024) is 'the only monetization mechanic in the corpus that users say actively reduced their intent to pay' (6 in three months); the 2021 logging redesign added taps to the same moment and was rolled back.")
ext("C246", " Report 48: no ads in eleven years — 33 praise, 0 complaints; the report's first 'do not change'.")
ext("C253", " Report 48: notification overload 12 (2.33) against 224 reminder praise — custom text and per-tracker control keep the ratio stable.")
ext("C254", " Report 48: a Today list exists but is premium (tags / filters / Today); a 3-tracker free tier keeps the overview small.")
ext("C256", " Report 48: no vacation / illness handling that leaves a streak or an average intact (13); weekend 'misses' on weekday habits (21).")

M = {
 "R48-003":["C062"], "R48-005":["C002"], "R48-006":["C186","C104","C078","C035"], "R48-007":["C001","C007","C110","C218","C191"], "R48-008":["C031","C030"],
 "R48-009":["C265","C006","C005","C134"], "R48-010":["C065","C036","C029"], "R48-011":["C036","C059"], "R48-012":["C264","C119"], "R48-013":["C007","C133","C147"],
 "R48-014":["C002"], "R48-015":["C032"], "R48-016":["C094","C076"],
 "R48-018":["C265","C019","C048","C108"], "R48-019":["C024","C014","C008","C108"], "R48-020":["C022","C009","C023","C021","C046","C044","C155","C020","C116","C013"],
 "R48-021":["C015","C098","C046","C066","C051","C016","C043"], "R48-022":["C186","C001","C007","C035"], "R48-023":["C007","C133","C045","C172"], "R48-024":["C246","C082"], "R48-025":["C003","C218"],
 "R48-027":["C006","C265","C005"], "R48-028":["C007","C031","C024","C036","C075","C019","C005"], "R48-029":["C067","C038","C039","C011","C186","C013","C057","C003","C034","C059","C110","C030"],
 "R48-030":["C061","C095","C035","C027","C043","C020","C230","C223","C264","C036","C003","C045","C109","C038","C022","C042","C227","C029","C191","C212"],
 "R48-031":["C015","C172","C035","C043","C009","C021","C052","C044","C001","C020","C222","C104","C040","C073","C048","C093","C042","C036","C016","C022","C253","C136","C046","C080","C141","C094","C066","C171","C112","C076"],
 "R48-032":["C002"], "R48-033":["C006","C264"], "R48-034":["C265","C108"], "R48-035":["C005"], "R48-036":["C067","C134"], "R48-037":["C024","C108","C265"], "R48-038":["C036","C059"], "R48-039":["C061","C001"],
 "R48-040":["C007","C110","C219","C191","C218","C236"], "R48-041":["C004","C003"], "R48-042":["C186","C104","C209","C096","C035"], "R48-043":["C031","C030","C034","C230","C038","C039"],
 "R48-044":["C075","C136","C264","C016","C043","C057"], "R48-045":["C036"], "R48-046":["C011","C015","C043","C045","C227","C020","C222","C080","C046"],
 "R48-048":["C134","C061"], "R48-049":["C002","C004"], "R48-050":["C004","C007"], "R48-051":["C005","C004"], "R48-052":["C031","C065","C186"], "R48-054":["C094"],
 "R48-055":["C065"], "R48-056":["C133","C061","C013","C116"], "R48-057":["C147","C003","C133"], "R48-058":["C065"], "R48-059":["C029","C109","C152","C033"], "R48-060":["C036","C065"], "R48-061":["C212","C029","C112"],
 "R48-062":["C005","C004"], "R48-063":["C003","C064","C110","C222"], "R48-064":["C005","C133"],
 "R48-066":["C062"], "R48-067":["C134","C062"], "R48-068":["C064","C004"], "R48-069":["C062"], "R48-070":["C059","C231"], "R48-071":["C035","C096","C209"], "R48-072":["C027","C092","C231"],
 "R48-073":["C062"], "R48-074":["C062","C231"], "R48-075":["C231"], "R48-076":["C231"],
 "R48-078":["C186","C078","C104"], "R48-079":["C001","C007","C219"], "R48-080":["C004"], "R48-081":["C031","C030"], "R48-082":["C264","C229","C119"], "R48-083":["C093","C240"], "R48-084":["C104","C191"],
 "R48-085":["C044","C021","C022","C155"], "R48-086":["C006","C075","C246","C059"],
 "R48-087":["C110","C218","C236"], "R48-088":["C191","C219"], "R48-089":["C036"], "R48-090":["C029","C109"], "R48-091":["C030"], "R48-092":["C007","C133","C147"], "R48-093":["C222","C003"], "R48-094":["C093","C240"],
 "R48-095":["C264","C159"], "R48-096":["C016","C043","C256"], "R48-097":["C246","C082"], "R48-098":["C265","C006"], "R48-099":["C057","C119"], "R48-100":["C036","C059"], "R48-101":["C007","C222","C075","C011"],
 "R48-102":["C218","C007"], "R48-103":["C062","C094","C093"], "R48-104":["C067","C042","C140"], "R48-105":["C218","C172"], "R48-106":["C082","C057","C186"],
}
# unattached (nuance register): 001 positioning, 002 method, 004 warnings, 017 inventory table, 026 master table, 047 distribution, 053 cross-tab, 065 storefront table, 077 era method
cards = [json.loads(l) for l in open("Tools/prd_ledger/48/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/48/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
