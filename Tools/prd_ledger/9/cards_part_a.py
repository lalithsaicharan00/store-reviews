import json, re
R = 9
rep = open("App Store Reports/9. Dear Me - Daily Routine Tracker - Self Care & ADHD Habit Planner (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
        elif l.startswith("#") and blocks == [] and k == 0 and False: pass
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(1, "header lines 1-8", "positioning",
  "Dear Me — Daily Routine Tracker (App Store ID 6475956795) is a Turkish routine/habit planner built around pre-made routine templates in an illustrated, beaver-mascot, emotionally warm shell, sold as 'Self Care & ADHD Habit Planner' behind a hard 'Plus Membership' paywall; 1,281 written reviews at mean 3.509, bimodal",
  "developer Fitself Dijital Hizmetler Anonim Şirketi (Türkiye); bundle com.kompanion.habit.ios; Health & Fitness; 4+; first release 27 Jun 2024; v1.1.46 3 Sep 2026; listing Free with Plus IAPs $6.99 / $16.99 / $27.99 / $39.99 / $79.99; store rank 9 in this set", "mixed",
  "1,281 reviews, 62 storefronts, 14 May 2024 → 4 Sep 2026; 5★ 658 (51.37%) · 4★ 96 (7.49%) · 3★ 103 (8.04%) · 2★ 88 (6.87%) · 1★ 336 (26.23%); public 4.86 on ~40,555 ratings across 8 storefronts", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Part 8 method (skimmed)", "data-caveat",
  "Method: denominator 1,281, non-exclusive themes; six storefronts clear 50 — TR 471, RU 113, BR 104, MX 74, US 59, FR 50 (871, 68.0%), the other 56 (410) are [limited evidence]; every review read in its original language (TR, RU, PT, ES, FR, DE, HE, AR, JA, IT, ID, NL); fully manual classification into 101 codes (ambiguous boundaries M-price/M-wall, G-thin/G-guide, M-refund/M-cancel double-assigned); PAID is a floor (explicit text only); 339 short reviews deliberately unclassified but kept in denominators; safety findings (X-safety, G-a11y) promoted above their band; storefront skew — TR is 36.77% of the corpus and RU contributes 78.8% of loading complaints; no version, cohort or telemetry data; external data snapshot 9 Sep 2026",
  "n/a", "none", "1,281 records, reconciles with 62 by_country files and manifest; 0 duplicate IDs; one duplicate title+body kept; bands <0.1% ignore … >5% high-priority", "none", "method", "yes", [])
c(3, "⚠️ Read these three things before anything else — 1. This is a hard-paywall product", "monetization",
  "This is a hard-paywall product and money is the single biggest thing reviewers talk about: the listing is Free, but the core loop is gated behind a 'Plus Membership' subscription with five price points and, per the corpus, no free trial in most storefronts",
  "hard paywall; Plus $6.99–$79.99; no trial in most storefronts", "1★-burst", "434 of 1,281 (33.88%, HIGH-PRIORITY) carry a money theme, mean 2.13", "product-rule", "high-priority", "yes", [])
c(4, "EXECUTIVE SUMMARY headline", "insight",
  "Dear Me is a well-loved product wrapped in an acquisition funnel that is actively destroying its own reputation, sold to a paying cohort that rates it 1.94 stars",
  "hard paywall, long quiz, rating prompt in sign-up, heavy upsell", "mixed", "paid cohort 226 at 1.94; praise themes 297 at 4.78; money themes 434 at 2.13", "product-rule", "headline", "yes", [])
c(5, "EXECUTIVE SUMMARY The prioritised ask", "do",
  "The prioritised ask: fix Russia's backend; remove the rating prompt from sign-up; build a real support and refund path (damage control) — then ship a genuine trial in every storefront, cap the upsell at one interstitial per session, and make the breathing exercise re-runnable (the growth thesis)",
  "n/a", "none", "report gives none beyond the sections cited", "do", "recommendation", "yes", [])

# ---- PART 0 ----
c(6, "§0.1 The shape of this corpus is unusual and it matters table (verbatim)", "data-caveat",
  "The corpus is bimodal — 51.37% 5★ alongside 26.23% 1★, only 22.40% in between — two nearly disjoint populations: a large low-information positive mass (318 of the 339 unclassified reviews are 5★ one-to-four-word praise like 'Çok güzel', 'Muito bom', emoji) next to a large, highly articulate negative mass; only one of them tells you what to build",
  "n/a", "mixed", table("## 0.1 The shape"), "none", "verbatim", "app-specific", [])
c(7, "§0.2 The paywall is the product's defining decision money-theme table (verbatim)", "data-caveat",
  "Money supergroup broken into sixteen themes (price, refund, wall, nag, no trial, regret, cancel, gated, scam, unclear, late reveal, guarantee, overcharge, payfail, trial trap, one-time)",
  "n/a", "1★-burst", table("## 0.2 The paywall"), "none", "verbatim", "app-specific", [])
c(8, "§0.2 Price level is not the main problem — access is", "product-rule",
  "Price level is not the main problem — access is: 'great app, wish it were free' is often a 5★ sentence, while being made to pay before you can see anything scores the lowest; reviewers forgive the price, they do not forgive paying blind",
  "hard paywall before use", "blocked-conversion", "M-price 123 (9.60%), mean 2.70 (highest money mean), 31 are 5★; M-wall 75 (5.85%), 1.69; M-latereveal 18 (1.41%), 1.39", "product-rule", "high-priority", "yes",
  ["11285454916","11946302259","12294156269","12305015226"])
c(9, "§0.2 The 'no free trial' complaint is the highest-leverage single fix in the corpus; §5.2 conclusion 1; Part 7 §7.2 Part A", "monetization",
  "No free trial is the highest-leverage single fix, and reviewers specify the remedy and say they would have bought: 'The single biggest missing thing is a trial period… because there's no such option, 7 out of 10 people just choose not to buy' (20 helpful votes); 'I'm happy to pay for an app… but I don't want to buy one blind'; 'I'd want to buy an app like this, but I'm giving up because I don't want to pay and then fight a refund process'",
  "no trial in most storefronts", "blocked-conversion",
  "M-notrial 52 (4.06%, VERY STRONG), mean 1.83; + WTP 4 → 'I would pay if you let me look first' cohort 55 (4.29%); high-spend group 7.2%; DE 6 (16.2% of DE); asks 3 days – 1 week", "undecided", "very strong", "yes",
  ["11642792565","11854298993","12291766651","12025237180","12683497729","12636034921"])
c(10, "§0.2 Upsell pressure is getting worse, not better; §6.5; Part 7 §7.2 Part B", "dont",
  "Upsell pressure is getting worse and reviewers count the pop-ups: 'already asked 6× after downloading'; 'attacked 10 times in 10 minutes'; 'In 1 minute they offered it 3 times'; 'showed me banner about paid subscription 4 times during my first app opening' — and an ADHD user: 'if they irritated me this much, what is that if not a provocation for people with ADHD?'",
  "'Newcomer discount' / −50% interstitial on nearly every open", "1★-burst",
  "M-nag 59 (4.61%, VERY STRONG), mean 1.80; 2.16% (2024) → 4.84% (2025) → 10.23% (2026); RU 26 of 59 (23.0% of RU); high-spend 6.7%; 1★ band 35 (10.4%)", "dont", "very strong, rising", "yes",
  ["12311292481","12373899765","12919946354","12650117268","13917372875","13860369435","12360368631"])
c(11, "§0.3 The refund pipeline is the app's largest reputational liability; §4.5", "must-never-break",
  "The refund pipeline is the largest reputational liability — a support and policy-execution failure, not a pricing complaint: the in-app refund request produced 'an empty box', users could not find the option at all, and invoking the EU right of withdrawal was 'impossible'",
  "in-app refund path dead-ends", "1★-burst",
  "M-refund 102 (7.96%, HIGH-PRIORITY), mean 1.73; 99 of 226 paid (43.8% segment rate); TR 59 of 102 (57.8%, 12.53% of TR); 9.70% (2024) → 7.80% → 3.98% (2026)", "must-never-break", "high-priority", "yes",
  ["11567513705","11480287005","11912344269","13065540266"])
c(12, "§0.3 advertised money-back guarantee that was not honoured; §1.2", "anti-pattern",
  "An advertised '3-month unconditional money-back guarantee' in the purchase flow was not honoured — 'Below it said you have a satisfaction guarantee… The company does not keep to it. Repeated contact with customer service changes nothing'",
  "guarantee shown in purchase flow, refunds refused", "1★-burst", "M-guarantee 17 (1.33%), mean 1.41; all Jul 2024 – Feb 2025; 15 of 17 paid", "dont", "meaningful", "yes",
  ["11443158584","11511771422","11547216103","11651186782","11789743896","11801485653","11804618993","11818368934","11844359918","11895224084","11912344269","12017205465","12121079900","12178773869","12183108635","12317099799","12334700954"])
c(13, "EXECUTIVE SUMMARY One thing that already got fixed; §6.4 Trend 3 — The money-back guarantee was quietly withdrawn, and the refund complaint rate halved", "tactic",
  "Tactic: the guarantee claim was removed from the purchase flow around Dec 2024 – Feb 2025 ('the money-back guarantee is no longer mentioned'). Outcome: guarantee complaints went to zero, trial-trap complaints to zero, and refund complaints halved — removing a promise the business could not keep measurably reduced the worst category of complaint",
  "withdrew the guarantee claim", "praise", "M-guarantee 2.80% (P1) → 0.62% → 0.00%; M-trialtrap 1.51% → 0.47% → 0.00%; M-refund 9.70% → 7.80% → 3.98%", "do", "observed (two readings, corpus supports this one)", "yes",
  ["12017205465"], cond="whether it reduced conversion is unknown (research question)")
c(14, "§0.3 cancellation itself failed or was unclear; §4.5 mechanic 3", "must-have",
  "Cancellation fails or is misunderstood: cancelling stops renewal but does not refund, and users do not understand that — 'If cancelling is only so it doesn't renew after a year' — many neutral or positive-rated users asking in public because they had nowhere else to ask",
  "cancel = stop renewal only, not explained", "complaint", "M-cancel 34 (2.65%, MEANINGFUL), mean 2.03; 31 of 34 paid; TR 27 of 34 (79.4%)", "must-have", "meaningful", "yes",
  ["11936253199","12133402020","11895224084","12652692645","13477378855"])
c(15, "§0.3 charged an amount different from what was displayed; §4.5 mechanic 4; §5.1-FR", "must-never-break",
  "Billing does not match what was shown: annual shown as ₺199.99 and more taken; 'subscribed at 49, they took 114'; 'supposed to pay 39.99 but it charged me 56'; double-charged on a plan switch; charges after deletion; a discount pop-up that completed an Apple Pay annual purchase while the user was trying to dismiss it; a €20 annual subscription that appeared without bank details ever being entered",
  "charge ≠ displayed price", "1★-burst", "M-overcharge 16 (1.25%, MEANINGFUL), mean 1.50; 15 of 16 paid", "must-never-break", "meaningful", "yes",
  ["11539871453","12264639015","13966657008","12221358308","11935551837","13610891124","13565016167","11777093103","12190059793"])
c(16, "§0.3 no support response at all; §4.5 Support is the amplifier; Part 7 §7.1 #3", "must-have",
  "No support response at all, and people ask for help in public reviews because they cannot find in-app support — 'I couldn't find any support contacts anywhere, so I had to write this as a review'; one asks for an in-app support section instead of an email address",
  "email-only support, often unanswered", "1★-burst", "X-support 25 (1.95%, MEANINGFUL), mean 1.52; 21 of 25 paid", "must-have", "meaningful", "yes",
  ["12178773869","12571528769","12754744101","13860369435","11695609359","12901421019"])
c(17, "§0.4 What people actually love praise table (verbatim)", "data-caveat",
  "Praise themes: organises my day, life change, easy, design, motivating, free tier usable, ADHD/mental health, reminders, presets, tests",
  "n/a", "praise", table("## 0.4 What people"), "none", "verbatim", "app-specific", [])
c(18, "§0.4 praise converges on two things; §7.4", "insight",
  "Praise is narrow and consistent: 'it organises my day' and 'it changed my life' are the product — every roadmap item should be tested against whether it makes the daily organise-and-tick loop better",
  "daily routine checklist", "praise", "praise themes 297 (23.19%), mean 4.78; P-org 106 (8.27%), 4.92; P-outcome 101 (7.88%), 4.92; MX P-org 20.3%", "product-rule", "high-priority", "yes",
  ["12024330293","12221935483","14309372488"])
c(19, "§0.4 P-motiv and P-adhd are the only two themes with a perfect 5.00 mean; §7.4", "audience",
  "Motivation and ADHD / mental-health benefit are the only two themes with a perfect 5.00 mean and zero reviews below 5★ — the warmth (mascot, colour, affirmations, encouragement) is the emotional core: 'The best app for people with ADHD… the only app that didn't make me recoil'; 'this app just takes cares of me like a person'",
  "warm, mascot-led tone", "5★-burst", "P-motiv 32 (2.50%), mean 5.00; P-adhd 16 (1.25%), mean 5.00; ADHD mentions 17, 16 positive; BR 4 of 17 ADHD", "do", "meaningful, perfect-scoring", "yes",
  ["13270893215","13546243872","12631417278","11604948163","12808430071","13437517000"])
c(20, "§0.4 Note the ADHD paradox", "contradiction",
  "The ADHD paradox: the subtitle sells ADHD support and 16 of 17 ADHD mentions are positive, but the most detailed ADHD review says the ADHD content is one generic routine, 'totally oblivious to what it's like for someone with ADHD to actually create habits' — and the constant paywall banners are themselves 'a provocation for people with ADHD'",
  "'ADHD Habit Planner' subtitle; one generic ADHD routine; heavy upsell", "mixed", "16 of 17 positive vs the most detailed review at 2★", "research", "qualitative", "yes",
  ["13021325704","13860369435"], cond="warm tone satisfies ADHD users; marketing to ADHD without ADHD-specific content invites the sharpest critics")
c(21, "§0.5 'It's just a checklist' is the #1 product criticism, and it has a specific cause; §5.5", "anti-pattern",
  "'It's just a checklist' is the #1 product criticism and the worst-rated major theme — the app markets a coach and ships a checklist, and nearly half of those saying so paid; it is not cultural, it appears at the same rate in every market",
  "routine checklist sold as coaching", "1★-burst",
  "G-thin 99 (7.73%, HIGH-PRIORITY), mean 1.45 (lowest with n>20), 74 are 1★; 47 paid (20.8% of paid cohort); 1★ band 74 (22.0%), 2★ band 15 (17.0%); TR 7.9%, US 13.6%, BR 6.7%, RU 7.1%, MX 6.8%, FR 8.0%; high-spend 9.6%; 8.84% (2024) → 8.27% → 2.84% (2026)", "must-have", "high-priority", "yes",
  ["12209118679","11552361877","12400544803"])
c(22, "§0.5 G-guide — guided breathing exercise shown in onboarding only; Part 7 §7.3 #1", "feature",
  "The specific cause: an animated guided-breathing exercise with the beaver (4-7-8 technique) runs once during onboarding and is never available again — 'why draw a beaver just for the first time?'; 'the breathing exercise from the introduction is not available afterwards. That was one of the things that convinced me'; 'there was misleading advertising… I took the subscription for that'; 'that's not inside the app. It's just to trick you'",
  "onboarding-only guided exercise", "churn", "G-guide 21 (1.64%, MEANINGFUL), mean 2.33; six languages; high-spend 3.8%; DE 4", "must-have", "meaningful, specific, cheap", "yes",
  ["12885713029","12699837651","12645661722","12754744101","11830287049","12238297592","12609839103","13309724057","11607493158"])
c(23, "§0.5 O-mislead — the acquisition creative and the onboarding demo promise an interactive coach", "anti-pattern",
  "Advertised features are not in the app: the acquisition creative and onboarding demo promise an interactive coach and the product delivers a checklist — the gap is the churn",
  "ads show guided/interactive features", "1★-burst", "O-mislead 20 (1.56%, MEANINGFUL), mean 1.40; 12 of 20 paid; 0.22% (2024) → 2.34% → 2.27%; high-spend 4.3%", "dont", "meaningful", "yes",
  ["12645661722","12754744101","12755295856"])
c(24, "§0.6 The onboarding funnel is long, personal, and — reviewers say — fake table (verbatim)", "data-caveat",
  "Onboarding/marketing funnel themes: too long, misleading, ad-driven, forced rating, not personal, privacy, age gate, gender, inclusive language, signature step",
  "n/a", "1★-burst", "onboarding criticism 98 (7.65%, HIGH-PRIORITY), mean 1.93; " + table("## 0.6 The onboarding"), "none", "verbatim", "app-specific", [])
c(25, "§0.6 O-long — the quiz/intro is too long; Part 7 #3 (§7.5 experiment 3)", "dont",
  "The mandatory onboarding quiz is too long and reviewers time it: 'you need to spend at least 10 minutes on the creators' quest'; 'a wild and useless half-hour onboarding'; 'I tried answering them for 5 minutes and couldn't reach the sign in page'",
  "unskippable personal quiz before sign-in and paywall", "1★-burst", "O-long 35 (2.73%, MEANINGFUL), mean 1.31 (second-lowest with n>20); RU 15 of 35 (13.3% of RU); IN 3; 1.51% (2024) → 3.12% → 4.55% (2026); 1★ band 28", "dont", "meaningful", "yes",
  ["12572307741","13601275869","14276958495","12863200655"])
c(26, "§0.6 O-notpersonal — the 'personalised plan' is not personalised", "anti-pattern",
  "The 'personalised plan' is not personalised: 'They say your personalised plan is ready and push you to pay. Don't pay — there is no plan'; 'Fake calculations to waste time and pretend there's personalization'; 'Why did I take the test at the start if the approach is the same for everyone?'",
  "quiz output = generic presets", "1★-burst", "O-notpersonal 11 (0.86%, EMERGING), mean 1.55", "dont", "emerging", "yes",
  ["11472460295","11717508221","13521538789","12587805273"])
c(27, "§0.6 One review is worth calling out on its own for safety reasons; EXECUTIVE SUMMARY finding 7; Part 7 §7.1 #5", "audience",
  "Safety: a 4+-rated Health & Fitness app administers depression and ADHD self-assessments — a friend who was suicidal was given a benign depression result; the ADHD test is 'needless scaremongering especially for teenagers' — and rate-limits an emotional-support chat; it needs a clinical-safety review regardless of volume",
  "in-app depression/ADHD screens without evident validation", "complaint", "3 reviews (0.23%), promoted under the safety carve-out", "must-never-break", "safety carve-out", "yes",
  ["11976398530","14069820135","14507626498"])
c(28, "§0.6 O-agegate, O-gender, O-inclusive, O-privacy, O-signature; §5.1-FR gender critique", "audience",
  "Smaller onboarding exclusions: age brackets stop at 50/59; content written for women only; objections to inclusive Spanish ('todes'); personal-data/permission concerns; a handwritten-signature commitment step — and a French 4★ asking the developer to stop depicting only women doing housework in promo clips",
  "women-first content and marketing; capped age brackets", "complaint", "O-agegate 5 (0.39%), 2.60; O-gender 5 (0.39%), 2.00; O-inclusive 2 (0.16%), 2.00; O-privacy 6 (0.47%), 1.50; O-signature 1", "research", "weak", "yes",
  ["12035339575","13005363984","13193031233"])
c(29, "§0.7 Reliability: one country carries almost the whole problem defect table (verbatim)", "data-caveat",
  "Twenty defect themes with concentration by country and date",
  "n/a", "1★-burst", "defect themes 175 (13.66%), mean 2.01; " + table("## 0.7 Reliability"), "none", "verbatim", "app-specific", [])
c(30, "⚠️ 3. The app has a severe, geographically concentrated reliability failure; §0.7 The Russia cluster is a distinct engineering problem; Part 7 §7.1 #1", "must-never-break",
  "A severe reliability failure concentrated in one country: in Russia the app loads for minutes, shows 'network error', never populates widgets, and six users say it only works over a VPN — most likely backend/CDN reachability, degrading since mid-2025, while Russian users keep paying; the v1.1.46 release notes ('Things just got a whole lot faster! Enjoy quicker loading') show the developer knows",
  "backend unreachable from RU", "1★-burst",
  "B-load 66 (5.15%, HIGH-PRIORITY), mean 2.12 — RU 52 of 66 (46.02% of RU vs 1.20% non-RU); 56.64% of RU report a defect vs 12.9% elsewhere; B-vpn 6 (all RU); RU paid 36 of 113 (31.9%); RU written 2.38 vs public 4.65", "must-never-break", "high-priority", "app-specific",
  ["12574094311","13189159142","13684764082","13936354959","14274931059","14413735582","14137219709"],
  cond="a regional infrastructure failure hidden by a single global star rating")
c(31, "EXECUTIVE SUMMARY two dated regressions; §0.7 B-onboard Nov 2024 spike; §6.3 Trend 2 (a) The Nov 2024 onboarding freeze", "timeline",
  "A November 2024 onboarding freeze locked users out of the app entirely: a procrastination question whose 'continue' control was off-screen and unscrollable ('the picture of the woman and the wardrobe'; one on an iPhone 6; an update did not fix it) — detectable within days from written reviews, invisible in the star rating",
  "unscrollable onboarding screen on small devices", "1★-burst", "B-onboard 21 (1.64%), mean 1.52; 10 in Nov 2024 alone (DE 4, FR 4, also CH, IT, BR, TR); 9 in 2025, 1 in 2026; 2.37% → 1.40% → 0.57%", "must-never-break", "observed", "yes",
  ["11953340146","11987084380","11982010915","11965618346","11986632519","11989133850"])
c(32, "§0.7 B-ime Japanese text input broken; §2.5 Japanese", "market",
  "Japanese custom-habit text entry was broken (kanji conversion and dakuten) in August 2024 — a subscriber bought the annual plan and then could not type — and Japanese written sentiment never recovered after the fix",
  "IME input broken Aug 2024", "1★-burst", "B-ime 7 (0.55%), mean 1.86, JP 7 of 7, Aug 2024 only; JP n=25 mean 2.80 [limited evidence]", "must-never-break", "emerging", "app-specific",
  ["11614598675","11624500796"])
c(33, "§0.7 remaining defect themes (B-create, B-login, B-check, B-dataloss, B-ui, B-widget, B-tablet, B-offline, B-rtl, B-cal, B-sig, B-discover)", "must-never-break",
  "The rest of the defect load: new habits won't save, users logged out and cannot sign back in, completed tasks un-complete themselves, routines and history disappear, text truncated, widgets blank (RU), iPad layout unusable, planning requires a network connection, Hebrew renders reversed, wrong weekday, signature field rejects input, Discover tab errors (Jan 2026)",
  "multiple defects", "1★-burst", "B-create 16 (1.25%), 2.12; B-login 15 (1.17%), 1.87; B-check 12 (0.94%), 2.75; B-dataloss 5, 1.60; B-ui 5, 1.40 (FR 3); B-widget 5 (RU 5); B-tablet 2, 1.00; B-offline 2, 1.00; B-rtl 1; B-cal 3; B-sig 2; B-discover 2", "must-never-break", "meaningful to weak", "yes",
  ["12513379051","13580713380"])

with open("Tools/prd_ledger/9/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
