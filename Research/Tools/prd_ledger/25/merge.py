"""Stage 3 merge for report 25."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C234","free","Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells","Report 25: statistics of any kind were paywalled in every era and the calendar view by 2026 ('Pay to even look at calendar'); the reviews that name it average 1.40 and one explains why — for someone at rock bottom, free statistics are the motivation; gating it removes the reason to upgrade rather than creating one. The report predicts, counter-intuitively, that free statistics increase conversion and proposes the A/B. Sits beside C011 (paid weekly/monthly/yearly reports): the basic progress view is free, the deep report is the paid layer.")
add("C235","must-have","A first-run failure escape hatch — skip setup / continue offline, with a visible error state","Report 25: 51 reviews (3.90%, mean 1.63; 1.3% → 5.8% across eras) describe the app freezing on or just after onboarding with the main screen unresponsive to touch; four say reinstalling does not help and then delete the app; one names iCloud sync as the stuck state. A 'skip setup / continue offline' path and a visible error would turn some of those 1★ reviews into support tickets.")

ext("C007", " Report 25: a 3-habit free cap on a product titled 'Routines & Goals Planner' is the single largest fact in a 1,309-review corpus — 138 complaints (10.54%, mean 2.13) and 298 (22.77%) of all monetisation friction, 56% of every 1★; the cap prevents a purchase decision, not just usage ('how do you expect me to subscribe without trying anything??'), and reviewers name their own acceptable number — median 8–10; 19 defend the cap and 64 call the price fair, so the level is not the problem, the gate placement is. Cap complaints fall (17.4% → 6.7%) only because reviewers increasingly describe the whole app as locked.")
ext("C222", " Report 25: 19 reviewers (mean 4.32) defend a 3-habit free cap on principle ('helps me to only keep track of what is the most important to me') while 138 object — and the objectors name the number they would accept, median 8–10.")
ext("C147", " Report 25: 'I could not evaluate the product' outweighs 'too expensive' — ~31 of 55 price objections are gate objections; every positive trial review describes having had enough product access to form a judgement; a survey-then-paywall sequence is the lowest-mean theme in the corpus (1.17) because it spends the highest-intent moment and then gates it.")
ext("C182", " Report 25: an onboarding questionnaire followed by an immediate paywall — 'I did the whole survey and at the end I had to pay'; 'first 10 minutes of test… then it turns out you need a subscription' — every such reviewer left 1–2★ (mean 1.17).")
ext("C133", " Report 25: gating expanded over time from a habit count to statistics, the calendar view, group creation and — from Nov 2025 — editing the starter habits the onboarding itself created ('You need to get the premium to edit habits, even the ones they start you out with'), which turns a reduced product into a demo; weak by rate (5, mean 1.20), high by consequence.")
ext("C200", " Report 25: from Nov 2025 editing an existing habit — including the ones onboarding created — was reported as paid; five 1–2★ reviews, zero before that date; 'never gate editing of habits the onboarding created'.")
ext("C003", " Report 25: the lifetime option is a stated purchase driver (44 mentions, 3.36%, mean 3.95; 8 name it as the deciding factor — 'you dont have to do subscription stuff thank you'); subscription fatigue is explicit in German ('One-time payment €50 or subscription. No, on principle'), French and US reviews; one Brazilian buyer could not find the lifetime option and thought only monthly existed.")
ext("C004", " Report 25: the lifetime price roughly doubled ($24.99 → $49) between early 2024 and mid-2025 and price objection stayed flat (3.8% → 4.9% → 3.8%); 64 reviews (mean 4.31) call the price cheap or fair ('less than 30 euros for life'; 'Premium is 1000% worth it').")
ext("C064", " Report 25: only ~12 of 55 price objections are about the level ('£25 for a basic box checker'; '$40??? it's a simple app'); ~8 are stated inability to pay (a student, a child); US names the highest figures ($13/mo, $49 lifetime); Argentina (n=40, mean 2.95, friction 40%) is the most hostile storefront.")
ext("C163", " Report 25: the most specific repeated billing claim is that a 7-day trial renews into the annual plan when monthly was selected ('charged 25,000 pesos when I had chosen the monthly option'; 'You can't choose to be renewed to the 1 month subscription'); make trial→plan mapping explicit and let the user pick the post-trial plan.")
ext("C109", " Report 25: the trial is a net-negative topic (21, mean 2.62, 10 1★) — card required up front, charged inside the window ('it says cost 0 in the trial selector and they charged me 1,500 pesos'), renewal into the wrong plan, and uncertainty about whether cancelling is possible; billing disputes stepped up ~5× after 2024 (0.8% → 3.9%).")
ext("C112", " Report 25: two reviewers could not find subscription settings in the app at all — 'I looked for five minutes… Is that even legal?'")
ext("C113", " Report 25: $24.99 shown and $42 charged; €29.99 lifetime followed by two further €6.99 charges; a German purchase sheet showing no price at all; Mexican reviewers unable to tell whether the price is pesos or dollars (four say so in the review) — show the local currency unambiguously and confirm displayed equals charged.")
ext("C092", " Report 25: price-display confusion is a Mexico-specific repeated issue — three reviewers cannot tell pesos from dollars, others name MXN 500, 40, 300, 599 and 299.99 — a pricing-display problem that is cheap to fix; Argentina's hostility (mean 2.95) warrants a look at its pricing display and trial mechanics.")
ext("C033", " Report 25: 'already paid, asked to pay again' — 8 reviews across a 16-month window (Mar 2025 → Jul 2026), including a lifetime purchase that restore does not recognise ('every time I enter the app it tells me to remove them or to buy the subscription to keep my habits'); emerging by rate, severe by kind, and the persistence argues against a one-off outage.")
ext("C139", " Report 25: three independent reports in three storefronts (fr, fr, nl) that the app stopped working immediately after payment — specific enough to reproduce against the entitlement path.")
ext("C065", " Report 25: explicit payers' mean fell 4.23 → 3.16 → 2.68 across eras (n=13/25/19) while the headline fell 0.27; 14% of payers raise a billing dispute, 8.8% lost access to something bought, 8.8% hit a reliability failure; 52 of 302 one-star reviews (17.2%) show paid evidence — failed customers, not non-buyers venting.")
ext("C031", " Report 25: a post-onboarding freeze — the main screen stops responding to touch — is the fastest-rising negative theme (51, 3.90%, mean 1.63; 1.3% → 2.9% → 5.8%; 27 of 34 E3 reports in May–Jul 2026; Colombia 18%, Germany 7.8%, GB 0%); iPhone 11 and iOS 26.x named, reinstalling does not fix it, one reviewer says it survived two updates; every one of these users got zero value.")
ext("C188", " Report 25: one reviewer names iCloud sync as the stuck state on first run ('shows synchronising with iCloud and nothing happens') — a first-run data path, not rendering; add a skip-setup / continue-offline path.")
ext("C093", " Report 25: navigation-blocking upsell sheets — '10 popups in 20 seconds which kills the use'; 'not even my first second on the app 4 ads asking for payment'; a 5-second forced delay on the premium prompt; 'a habit app that starts right away with dark patterns' — 35 reviews (2.67%, mean 1.80); cap the prompt to one dismissible surface per session; a French reviewer notes explosive pop-ups are actively harmful for ADHD users in an app marketed to them.")
ext("C137", " Report 25: move the paywall to after first value, not after the onboarding survey — the survey-then-paywall sequence averages 1.17.")
ext("C094", " Report 25: an onboarding review prompt — 'Why won't it progress without me writing a review?'; 'in the middle of the onboarding questions the app interrupts me to ask me to rate' — pushed ≤25-character reviews from 7.2% to 33.4% of the corpus (150 of 196 5★ in 2026) and median body length from 156 to 53 characters; the all-records mean falls 0.27 while the substantive mean falls 0.73, and 1★ share (16.1% → 26.6%) is the only trustworthy trend line; 43 reviews (mean 4.21) are from people who say they have not used the app yet. A prompt at first launch buys a store rating and costs your own telemetry.")
ext("C150", " Report 25: eight reviewers say the app asked for a review before they had used it, and one says it would not proceed without a review — if that gate existed, the 5★ share is not a satisfaction measurement for that period.")
ext("C042", " Report 25: ADHD/autism/OCD self-identified users are the highest-satisfaction segment (41, 3.13%, mean 4.44, 32 5★; plus 24 at mean 4.67 describing executive difficulty without a diagnosis; three arrive via a clinician including a psychologist recommending it to clients) — and they supply the sharpest paywall anger ('just another app trying to profit off of your disability'); ADHD vocabulary is 4.8× more common in high-spend markets, a diagnosis-prevalence difference not a needs difference.")
ext("C213", " Report 25: the same segment that rates the product highest (ADHD, mean 4.44) writes the most cutting paywall criticism — pop-ups 'hyper désagréable et malvenu pour des TDAH'; 'profit off of your disability'.")
ext("C183", " Report 25: an app titled 'Routine / Planner for ADHD' models whether a habit happened, not when — per-habit clock time with a notification at that time is the biggest unshipped feature (29, mean 3.41, 17 of them 4–5★; 9.0% of the 4★ band), clustering with one-off tasks (10), every-N-minutes reminders (4), an hour-by-hour agenda view (4) and long-term goals (7); buyers who expected time structure found a checklist ('Just a to-do list app'; 'I get to see all the things I haven't done and feel bad' — a £29.99 purchaser). Whoever ships routine scheduling rather than routine checking takes the ADHD-planner positioning.")
ext("C008", " Report 25: a specific clock time per habit with a notification at that time — not a generic reminder — was absent and is the top request from satisfied users (29; 4★ band 9.0%).")
ext("C050", " Report 25: one-off, non-repeating tasks in a separate list or tab requested by 10 (7 of them 4★) alongside the time-of-day request.")
ext("C014", " Report 25: an optional intra-day recurring reminder (every N minutes until completed) requested by 4, including a paying user's medication use case.")
ext("C043", " Report 25: flexible scheduling primitives are a stated reason to choose the app — an every-N-days reminder ('the ONLY APP I've found'), N×/week, skip, vacation mode, a custom day-start for shift workers (capped at 11:45); a weekly habit cannot be pinned to a chosen day.")
ext("C170", " Report 25: a day-start time setting exists for shift workers but is capped at 11:45.")
ext("C011", " Report 25 (counter-evidence): paywalling all statistics — success %, graphs, per-habit calendar — averaged 1.40 and 'removes the motivation loop the category sells'; keep the basic progress view free, sell the deep report.")
ext("C082", " Report 25: six reviewers volunteer 'show me ads instead' of a paywall — ads-as-alternative is requested, not complained about; the app has none.")
ext("C214", " Report 25: among people who hit the paywall the comparison set is Apple Reminders, Health, Notes and a paper notebook (nine reviews explicitly) — a free tier must beat Reminders, not beat Streaks; ~7 reviewers would rather the app were honestly paid up front than 'fake-free'.")
ext("C181", " Report 25: ~7 reviewers ask for the app to be paid up front instead of 'fake-free' — an honest paid listing is preferred to a free download that gates at habit four.")
ext("C005", " Report 25: 37 (2.83%, mean 4.16) arrive after abandoning a named competitor — Streaks 6 (outgrew it), Habitify 4 (cluttered, no widget completion), Habitica 3 (became work), Strides 3 (dull colours, weak sound), Done 2 (buggy), HabitKit/Ripples 2 (better heat-map widget), Me+, Tiimo (calendar import) — 'I have tried them all and this is the one'; among gated users the frame is Apple Reminders and paper.")
ext("C006", " Report 25 (both sides): 126 praise simplicity and 27 call it confusing; 65 praise configurability and others say 'so many options and no guidance that you get lost in configuration' — complexity is both the top praise and a top complaint; any simplification must be opt-in.")
ext("C119", " Report 25: complexity is both the top praise and a top complaint (126 vs 27; 65 vs 'too many icons to pick from') — any simplification must be opt-in.")
ext("C075", " Report 25: confusing/no-guidance 27 (2.06%, mean 2.70); two Brazilian reviewers ask for a tutorial video; comprehension failures worth designing against — how to structure a bad habit ('smoked' or 'didn't smoke'), pinning a weekly habit to a day, stopping a repeat, whether the app is iOS-only.")
ext("C036", " Report 25: a solo developer answering within a day ('feature requests implemented in less than 24hrs'; 'I can't believe one developer made this') is a purchase trigger — 'After testing the app and interacting with the developer… I've decided to pay without any hesitation' — but support praise thinned 3.0% → 1.6% → 0.9% and one 1★ says the developer 'preferred to argue about what I could see on my end'.")
ext("C059", " Report 25: a Turkish localisation request made eight times in Jan–Jun 2026 was answered on 27 Jul 2026 ('Türkçe dil desteği sonundaaa! 🌟') — the clearest shipped-fix-visible-in-reviews event in the corpus.")
ext("C189", " Report 25: 'the developer preferred to argue about what I could see on my end' — an argumentative support reply ended a trial.")
ext("C027", " Report 25: localisation demand is new and growing (0% → 1.0% → 2.7%; Turkish 9, Korean 3, Italian 3, Russian/Ukrainian 3, Chinese 2, Japanese 1); Korea and China are 100% 5★ and 75%/50% localisation requests ('If there is Chinese, it will definitely be loved by the Chinese market') — reached only by users tolerant of an English UI; Turkish shipped Jul 2026 and the review stream responded.")
ext("C062", " Report 25 (third corpus in a row): high-spend and high-volume storefront groups are indistinguishable (3.74 vs 3.73) and only marginally above the tail (3.62); monetisation friction is identical (22.5% vs 23.0%) — the paywall objection is global, not a low-income-market phenomenon; what differs is the mix (rich markets praise the price and buy lifetime; the rest hit the launch blocker and billing).")
ext("C021", " Report 25: two-way Apple Health is a purchase trigger (32, 2.44%) with a weak tail of demonstrably wrong mappings — weight read as an entry count, steps off by 568, running only measurable in minutes, step counting starting at 04:00 (9, 0.69%).")
ext("C072", " Report 25: Apple Health values read wrongly — weight interpreted as entry-count, steps off by 568 — in an app whose Health integration is otherwise praised.")
ext("C022", " Report 25: the Watch app (21 mentions, mean 4.48, 0 1★) is part of a praised Apple-platform surface (Watch + Mac + widgets + Shortcuts + Health), but one reviewer says it was 'suddenly removed' (Oct 2025) and another that the listing advertised Watch support that could not be installed.")
ext("C218", " Report 25: the App Store listing showed Apple Watch support that could not be installed.")
ext("C155", " Report 25: an Apple Watch app reported 'suddenly removed' (Oct 2025) and Vision Pro support withdrawn — single reports, recorded not asserted.")
ext("C009", " Report 25: widgets (Home, Lock Screen, Control Center) are almost purely positive (30, mean 4.43, 0 1★); custom icons and colours with hex input; one lifetime buyer asks for a minimal heat-map widget like HabitKit/Ripples.")
ext("C040", " Report 25: widget stopped working / not interactive / font fixed (6, 0.46%).")
ext("C046", " Report 25: Siri Shortcuts exist; a Mac app and formerly Vision Pro; Shortcuts gaps 1.")
ext("C044", " Report 25: a Mac app is part of the included platform surface (8 mentions, mean 4.00).")
ext("C030", " Report 25: cross-device sync not updating 14 (1.07%, mean 3.29), flat across eras.")
ext("C034", " Report 25: data loss / reset to zero 12 (0.92%), flat ~1%; archive/delete destroys history (4) — 'archive losing history defeats the point of archiving'.")
ext("C041", " Report 25: archiving or deleting a habit destroys its history (4); preserve history through archive and restore.")
ext("C038", " Report 25: over-achievement carries into the next day (exceeding a goal pre-completes tomorrow) and logging a bad habit at 200% is rewarded as success (7, 0.53%).")
ext("C019", " Report 25: a 'bad habit' mode exists and counts against the cap; a bad-habit limit exceeded at 200% is scored as success; a long review asks whether to name it 'smoked' or 'didn't smoke'.")
ext("C073", " Report 25: habit/group order resets itself (11, 0.84%) — two long-term users left over it; make reordering a drag gesture.")
ext("C066", " Report 25: a built-in timer that keeps counting past the goal is praised at mean 4.60 (15, 1.15%).")
ext("C048", " Report 25: measurement units — count, minutes, distance, custom steps — and track-only habits with no goal number.")
ext("C045", " Report 25: groups and sub-groups are a praised paid feature (customisation 65, mean 4.49); group creation reported locked on free.")
ext("C108", " Report 25: a layer of long-term goals sitting above habits is requested by very satisfied users (7, mean 4.71).")
ext("C015", " Report 25: friends / accountability / leaderboard requested by 10 fans (mean 4.80); no social feature exists.")
ext("C172", " Report 25: a notes / journal / mood field per day requested by 7 (mean 4.43).")
ext("C049", " Report 25: a Russian lifetime buyer with ADHD proposes a mood/energy tracker so the statistics screen can answer why a habit failed.")
ext("C012", " Report 25: statistics weak/unreadable (8) — rework the screen around 'why did I miss it'; a heat-map widget like HabitKit/Ripples requested.")
ext("C016", " Report 25: vacation/pause, skip-a-day ('Jump'), mark-not-done ('Cancel') and archive all exist and are praised.")
ext("C020", " Report 25: CSV export exists but is described as weak (3).")
ext("C058", " Report 25: Instagram / TikTok / Reels ads are a stated acquisition channel for buyers; three arrive via a clinician.")
ext("C002", " Report 25: a bimodal corpus (55% 5★, 23% 1★) where the 1★ band is 56% money and 11% the app not starting, and the 5★ band is converted power users plus prompt-driven one-liners — two populations reviewing two products.")
ext("C134", " Report 25: reviewers say the app feels first-party ('went back to check if the app was made by apple') and 37 switched from named competitors — the listing can lead with configurability and Apple-platform depth; measurable outcomes are claimed (45 kg lost in 8 months).")
ext("C057", " Report 25: native Apple design language reads as premium — ''Apple' design all over it'.")
ext("C095", " Report 25: 'I clicked, paid £29.99 and I don't even know why. It's a list of aims for the day, I get to see all the things I haven't done and feel bad' — a checklist without a forgiving frame reads as guilt.")
ext("C216", " Report 25: a paying user describes the day view as 'all the things I haven't done' and feeling bad — the un-forgiving frame is a churn reason.")
ext("C203", " Report 25: an onboarding questionnaire suggests starter habits (free) — and from Nov 2025 those starter habits could not be edited without paying.")
ext("C071", " Report 25: a solo developer's fast turnaround (24-hour fixes) thinned across eras (support praise 3.0% → 0.9%) while a launch blocker survived two release cycles.")
ext("C231", " Report 25: Argentina (mean 2.95, monetisation friction 40%, billing 10%) and the Spanish-language block (blocker 36% more common, paywall register markedly more hostile) vs Great Britain (mean 4.06, zero blocker, zero confusing-UX) — the same product, different market experience; check Argentine pricing display and trial mechanics.")

M = {
 "R25-003":["C094","C150"], "R25-004":["C007"], "R25-005":["C007","C147"], "R25-006":["C147","C007","C064"], "R25-007":["C065"], "R25-008":["C031","C235"],
 "R25-009":["C005","C134","C021","C022","C009"], "R25-010":["C163","C109","C112"], "R25-011":["C093","C213"], "R25-012":["C042","C213","C058"], "R25-013":["C183","C008","C050","C014"],
 "R25-014":["C031","C147","C163","C033","C008","C093","C027"], "R25-015":["C059"], "R25-016":["C094","C150"], "R25-017":["C007"], "R25-018":["C002"], "R25-019":["C094"], "R25-021":["C002"],
 "R25-024":["C007","C009"], "R25-025":["C019"], "R25-026":["C048","C066"], "R25-027":["C045"], "R25-028":["C234","C011"], "R25-029":["C024","C101"], "R25-030":["C021","C022","C009","C044","C046","C030"],
 "R25-031":["C016"], "R25-032":["C020"], "R25-033":["C203","C170"], "R25-034":["C200","C133","C203"], "R25-035":["C051","C035","C015","C183","C027"],
 "R25-036":["C003","C064"], "R25-037":["C003"], "R25-038":["C004","C064"], "R25-039":["C133"], "R25-040":["C036","C059","C071"], "R25-041":["C036","C189"],
 "R25-043":["C007","C147"], "R25-044":["C147"], "R25-045":["C007"], "R25-046":["C006"], "R25-047":["C024"], "R25-048":["C009","C045"], "R25-049":["C004","C061"], "R25-050":["C057"],
 "R25-051":["C064"], "R25-052":["C031"], "R25-053":["C003"], "R25-054":["C029","C109"], "R25-055":["C042"], "R25-056":["C005"], "R25-057":["C093"], "R25-058":["C031"], "R25-059":["C021"],
 "R25-060":["C009"], "R25-061":["C008","C183"], "R25-062":["C075"], "R25-063":["C042"], "R25-064":["C199"], "R25-065":["C109","C063"], "R25-066":["C027"], "R25-067":["C022"], "R25-068":["C036"],
 "R25-069":["C222"], "R25-071":["C066"], "R25-072":["C030"], "R25-073":["C034"], "R25-074":["C073"], "R25-075":["C083"], "R25-076":["C050"], "R25-077":["C015"], "R25-078":["C021","C072"],
 "R25-079":["C033"], "R25-080":["C012"], "R25-081":["C150","C094"], "R25-082":["C044"], "R25-083":["C038","C019"], "R25-084":["C172","C049"], "R25-085":["C108"],
 "R25-087":["C182","C137"], "R25-088":["C082"], "R25-089":["C002","C065"], "R25-090":["C064","C147"], "R25-091":["C181","C214"], "R25-092":["C004","C222"], "R25-093":["C007","C147"],
 "R25-094":["C134"], "R25-095":["C057","C134"], "R25-096":["C043","C170","C016"], "R25-097":["C061"], "R25-099":["C108"], "R25-101":["C030","C034","C073","C021","C040","C041","C038","C022"],
 "R25-102":["C038","C019"], "R25-103":["C155","C218"], "R25-104":["C075","C019"], "R25-105":["C005"], "R25-106":["C214","C005"],
 "R25-107":["C031","C188","C235"], "R25-108":["C031"], "R25-109":["C007"], "R25-110":["C007","C222"], "R25-111":["C147","C007"], "R25-112":["C093"], "R25-113":["C182","C137"], "R25-114":["C147","C007"],
 "R25-115":["C163","C109","C113","C112","C029"], "R25-116":["C033"], "R25-117":["C163","C033"], "R25-118":["C183","C008","C050","C014","C108"], "R25-119":["C183","C214"],
 "R25-120":["C094","C002"], "R25-121":["C183","C050"], "R25-122":["C007","C012"], "R25-123":["C007"], "R25-124":["C002","C065"], "R25-125":["C006","C119"],
 "R25-127":["C065"], "R25-128":["C003","C036","C058","C021"], "R25-129":["C036"], "R25-130":["C058"], "R25-131":["C045","C066","C006"], "R25-132":["C065","C033","C139"], "R25-133":["C139","C065"],
 "R25-134":["C109","C163","C147"], "R25-135":["C094","C150"], "R25-136":["C094"],
 "R25-138":["C064","C042"], "R25-139":["C092","C113"], "R25-140":["C075","C183"], "R25-141":["C093","C139"], "R25-142":["C095"], "R25-143":["C003","C031","C113"], "R25-144":["C007"],
 "R25-145":["C062","C042"], "R25-146":["C062"], "R25-147":["C231","C031"], "R25-148":["C231","C064"], "R25-149":["C027","C059"], "R25-150":["C031"], "R25-152":["C027"], "R25-153":["C049","C009","C012"],
 "R25-156":["C094"], "R25-157":["C031"], "R25-158":["C109","C029"], "R25-159":["C065"], "R25-160":["C094"], "R25-161":["C133","C007"], "R25-162":["C027","C059"],
 "R25-164":["C007"], "R25-165":["C147"], "R25-166":["C214"], "R25-167":["C183","C008"], "R25-168":["C003"], "R25-169":["C042","C213"], "R25-170":["C027"], "R25-171":["C234","C011"], "R25-172":["C094"],
 "R25-173":["C031"], "R25-174":["C235","C188"], "R25-175":["C033"], "R25-176":["C139"], "R25-177":["C007","C147"], "R25-178":["C234"], "R25-179":["C200","C133"], "R25-180":["C093"], "R25-181":["C137","C182"],
 "R25-182":["C163"], "R25-183":["C112"], "R25-184":["C092","C113"], "R25-185":["C113"], "R25-186":["C008","C183"], "R25-187":["C050"], "R25-188":["C014"], "R25-189":["C012","C049"], "R25-190":["C073"],
 "R25-191":["C041"], "R25-192":["C021","C072"], "R25-193":["C038","C019"], "R25-194":["C027"],
}
# unattached (nuance register): 001-002 header/method, 020 monthly table, 022 storefronts, 023 inventory table, 042 theme table, 070 life-changing,
# 086 weak rows, 098 requests table, 100 screen-time habits, 126 denominators, 137 country table, 151 kz/ph, 154 varies table, 155 method, 163 non-claims, 195-196 questions/experiments
cards = [json.loads(l) for l in open("Tools/prd_ledger/25/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/25/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
