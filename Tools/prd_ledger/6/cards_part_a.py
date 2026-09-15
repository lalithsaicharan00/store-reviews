import json, re
R = 6
rep = open("App Store Reports/6. Streak Tracker - StreakUp - Habit Builder & Breaker (REPORT).md").read().split("\n")
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

c(1, "header lines 1-6", "positioning",
  "Streak Tracker — StreakUp (App Store ID 6749051240) is a 13-month-old streak counter ('Habit Builder & Breaker') with two modes — Streak Tracker (manual check-in) and Streak Counter (auto-increments, you only declare a break) — rated 4.65 on 188 US ratings; listing claims 'Most features are free! Premium is only required to unlock unlimited streaks, custom themes & icons'",
  "developer Explora SAS (artist 'Explora (Apps)'), bundle com.aura.streaktracker, site with-aura.com; free download; first released 6 Aug 2025; v1.13.4 on 31 Aug 2026; Productivity (secondary Health & Fitness); 12+; 81 MB; min iOS 15.1; listing declares EN, FR, DE, IT, PT, ES; store rank 6 in this set", "praise",
  "44 reviews, 13 storefronts, 1 Sep 2025 → 30 Aug 2026; US 188 ratings @ 4.65 (Apple lookup 9 Sep 2026)", "none", "corpus-level fact", "app-specific", [],
  cond="a very young, very small corpus — the smallest in the set so far")
c(2, "How to read this; ⚠️ The threshold table barely applies at this sample size — read counts, not percentages; Part 9 preamble", "data-caveat",
  "Method: n = 44, one review = 2.27%, so a single review lands in 'Meaningful' and three reviews clear 'high-priority' — the raw count is the primary unit and the percentage is decoration; every finding is a hypothesis with named witnesses, not a measured rate; no storefront reaches the 50-review bar (US largest at 23) so every country statement is [limited evidence]; Part 9 recommendations are 'prioritised hypotheses to act on and instrument — not conclusions from a measured population'",
  "n/a", "none", "n = 44; one review = 2.27%; bands: <0.1% ignore, 0.1–0.5% weak, 0.5–1% emerging, 1–3% meaningful, 3–5% very strong, >5% high-priority; largest storefront US 23", "none", "method", "yes", [],
  cond="applies to every numeric claim from report 6; confidence scoring must weight report 6 by count, not by %")

# ---- PART 0 ----
c(3, "Part 0 executive summary line", "insight",
  "A genuinely liked, genuinely differentiated streak counter is converting its own goodwill into 1★ reviews because the free tier caps at 2 streaks, the upsell is loud, the price ladder is incoherent, and at least two people were billed an amount they did not agree to — while the one thing users unanimously love, the widget, is free and barely mentioned in the store listing",
  "2-streak cap, launch upsell, shifting prices, billing defects; free widget buried in listing", "mixed",
  "report gives none beyond the sections below (47.73% touch money; 7 cap complaints; 2 billing failures; 7 widget mentions)", "product-rule", "headline", "yes",
  [], side="the goodwill is still there — the damage is recoverable by packaging, not product work")
c(4, "Part 0 §1 (Nearly half the written corpus is about money, and it is where all the damage is)", "insight",
  "Nearly half the written corpus is about money and all the damage is there: 21 of 44 (47.73%) touch monetization, 16 (36.36%) are negative about it at mean 2.44 vs corpus 3.89; 6 of 8 one-star reviews (75%, 7 of 8 counting the body 'You gotta pay a subscription😭') and all 5 three-star reviews are monetization complaints",
  "freemium with 2-streak cap + subscription + lifetime", "1★-burst",
  "21/44 (47.73%) touch monetization; 16/44 (36.36%) negative, mean 2.44 vs corpus 3.89; 1★: 6 of 8 (75%), 7 of 8 incl. 14491149862; 3★: 5 of 5; distribution 24 / 7 / 5 / 0 / 8", "product-rule", "high-priority (n-limited)", "yes",
  ["13185604622","13531820409","13557096013","13628759209","13771926913","13969396065","14491149862","13939159292","14205874183","14267106974","14307898374","14346310474"])
c(5, "Part 0 §1 Interpretation", "insight",
  "Interpretation: this app does not have a product problem at its core — it has a packaging and billing problem sitting on top of a product people like; fix the packaging and the 3★ band converts almost mechanically, because every one of those five reviewers said something positive in the same breath",
  "n/a", "mixed", "3★ band = 5 reviews, all monetization, all with praise", "do", "interpretation", "yes",
  ["13939159292","14205874183","14267106974","14307898374","14346310474"],
  side="packaging fixes (cap, one price, paywall timing, lifetime-first) are cheaper than feature work and aim at the most convertible band")
c(6, "Part 0 §1; Part 2 2★ — n = 0", "data-caveat",
  "There are zero two-star reviews (distribution 24 / 7 / 5 / 0 / 8): people are either happy or angry about the paywall — no one lands in the 'disappointed but not angry' zone; the app produces enthusiasm or grievance",
  "n/a", "mixed", "2★ n = 0 of 44", "none", "observed", "unknown", [],
  cond="contrast report 5, where 2★ was the peak of reliability complaints — a missing 2★ band signals no engineering frustration")
c(7, "Part 0 §2 (The 2-streak free cap is the single most-named thing in the corpus); §1.1; Part 4 table; §8.3; Part 9 #6", "monetization",
  "The 2-streak free cap is the single most-named thing in the corpus and the median cap-complainer likes the app: ratings 1, 1, 4, 3, 3, 5, 4 — 'Love the app, just wish i could have more than 2 streaks without paying' (4★); 'it's got all it needs to have u can only have 2 streaks on the free plan tho' (5★); 'I'm personally a go-getter so I would like to have more than 2 streaks' (4★)",
  "free tier = 2 streaks (was 1); unlimited streaks paid", "blocked-conversion",
  "7 of 44 (15.91%), mean 3.00 (Part 4: 'Free streak cap (1→2)' 7, 15.91%, 3.00); 5 of 7 in May–Aug 2026 (21.7% of that window) at mean 3.4 vs earlier two at 1.0; 4 of 7 are US", "build-free", "high-priority (n = 7)", "yes",
  ["13185604622","13969396065","14214912053","14267106974","14346310474","14372026009","14477924333"],
  side="the ask in the text is for unlimited or near-unlimited, not for 3",
  cond="a streak counter where users track several streaks at once (gym + water + no doomscrolling is already three); contrast report 5, where a 2-routine cap sat above the point of core value and was tolerated")
c(8, "Part 0 §2 This is a conversion problem being paid for in stars", "insight",
  "The cap is a conversion problem being paid for in stars: these are people who hit the wall, did not buy, and rated on the way past; the cap does two jobs and fails at both — too tight to demonstrate value, loud enough to generate public complaint",
  "2-streak cap", "blocked-conversion", "7 cap complaints; ratings 1,1,4,3,3,5,4", "product-rule", "interpretation", "yes",
  ["14477924333","14372026009","14214912053","14346310474"],
  cond="holds when the cap lands below the number of things a normal user wants to track")
c(9, "Part 0 §2 The cap moved once already, and it did not solve the problem; §1.1 free-tier change", "timeline",
  "The free cap moved once and it did not solve the problem: the earliest cap complaint (26 Sep 2025) says 'only one streak'; every cap complaint from 18 Apr 2026 onward says two — the allowance was raised 1 → 2 and the complaint rate went up, not down; going from 1 to 2 was not enough and there is no evidence 3 would be either",
  "raised free allowance 1 → 2 between Sep 2025 and Apr 2026", "complaint",
  "1 cap complaint in the first 9 reviews → 5 in the last 23; " + table("## 8.3 Trend 2"), "undecided", "observed (small n)", "yes",
  ["13185604622","13969396065","14267106974","14346310474","14372026009","14477924333"],
  cond="an incremental cap raise inside a quantity-gated model; the ask is for unlimited")
c(10, "Part 0 §3 (Two people were charged amounts they did not agree to — highest-severity finding); Part 9 #2", "must-never-break",
  "Charge-vs-quote mismatch: a user quoted $1.99/month was charged $20.99 — 'Said it was $1.99/month and charged my card $20.99?? I want my money back, this is not right' — the highest-severity class of finding, a refund, chargeback and App Review risk, not just a rating risk",
  "paywall quote does not match the charge", "1★-burst", "1 of 44 (2.27%), 1★, US, 21 Feb 2026; billing-integrity failures 2 of 44 (4.55%) both unresolved in text", "must-never-break", "highest-severity", "yes",
  ["13771926913"])
c(11, "Part 0 §3 lifetime double-billing; §1.2; Part 4 Billing double-charge row; Part 9 #1", "must-never-break",
  "Buying the lifetime unlock does not cancel the in-flight annual subscription, so the user pays both: 'I was on the free trial, and decided to purchase the 14.99 forever choice. But come to find out they charge the 11.99 yearly and the 14.99. So I paid 25.98 and can't figure out how to get the 11.99 back' — a specific, reproducible failure mode; if the flow does not cancel/refund, every trial user who upgrades to lifetime is double-billed",
  "lifetime purchase leaves trial→yearly subscription active", "complaint", "1 of 44 (2.27%), 3★, US, 9 Apr 2026; $11.99 + $14.99 = $25.98", "must-never-break", "highest-severity", "yes",
  ["13939159292"],
  side="the reviewer gave 3★ while over-billed by $11.99 and led with 'I like the app' — a person who wanted to stay",
  cond="any app selling both a subscription and a lifetime SKU with a trial that auto-converts")
c(12, "Part 0 §3 Both reviews are also unanswered support tickets; Part 4 Refund requested in public row; §4.2; Part 9 #4", "must-have",
  "Both billing complaints are unanswered support tickets posted into the App Store — what people do when they cannot find an in-app refund path; add a visible in-app 'Manage / cancel / request refund' link to Apple's subscription management",
  "no visible in-app manage/refund route", "complaint", "Refund requested in public: 2 (4.55%), mean 2.00", "must-have", "meaningful (n = 2)", "yes",
  ["13771926913","13939159292","13390634274"])
c(13, "Part 0 §4 (The price ladder is incoherent) table (verbatim)", "timeline",
  "Price ladder reconstructed from reviewers: five different numbers in eleven months from six reviewers in a corpus of 44",
  "n/a", "complaint", table("## 4. The price ladder is incoherent"), "none", "verbatim", "app-specific",
  ["13390634274","13771926913","14307898374","13628759209","13939159292"])
c(14, "Part 0 §4 mechanism behind the greed theme; Part 4 Distrust row; §1.4; Part 9 #8", "must-never-break",
  "The incoherent price ladder is the mechanism behind the 'greed' theme: users are not objecting to a price, they are objecting to not knowing the price — publish one clear price on the paywall and keep it stable",
  "$1.99, ~$5, $11.99, $14.99 quoted/charged, $20.99 charged", "1★-burst",
  "Distrust / 'greedy' / deceptive: 4 of 44 (9.09%), mean 1.00 — the angriest cluster in the corpus; 5 prices in 11 months", "must-never-break", "high-priority (n = 4)", "yes",
  ["13185604622","13531820409","13628759209","13969396065"])
c(15, "Part 0 §4 value math; Part 4 Value-for-money objection row", "positioning",
  "Users benchmark a streak app against free iPhone Reminders and do the value math aloud: 'I can set a reminder list on in my iPhone reminders for $0. What is the $11.99 for?' — and conclude the app is a scam",
  "$11.99/yr for a streak counter", "1★-burst", "Value-for-money objection (does too little for the price): 2 (4.55%), mean 2.00", "do", "quoted (n = 2)", "yes",
  ["13628759209","14307898374"],
  side="a thin product invites comparison with the free OS app — the paid layer must be visibly more than a reminder list")
c(16, "Part 0 §5 (A willing buyer could not give the company money); Part 4 IAP unavailable row", "must-never-break",
  "A willing buyer could not pay: a 5★ review whose entire body is 'In app purchases are not available. I want to buy the life time subscription for this app' — the single highest-value defect by expected revenue, and it costs nothing to check; may be an India-storefront IAP configuration, an age/region gate or a client bug; needs a same-day answer",
  "IAP unavailable for at least one user (IN)", "blocked-conversion", "1 of 44 (2.27%), 5★, IN, 20 Jun 2026", "must-never-break", "highest expected revenue", "yes",
  ["14203637124"])
c(17, "Part 0 §6 (What people actually love); Part 3 Behaviour-change outcome row; Part 2 5★", "insight",
  "Every reviewer who reports a concrete behaviour-change outcome rated 5★ — quitting a bad habit, self-harm recovery, fitness, writing a first draft, general discipline",
  "streak counter", "5★-burst", "9 of 44 (20.45%), mean 5.00, zero exceptions", "do", "high-priority", "yes",
  ["13093308789","13672386764","13795256017","13837160367","13845360166","13891333657","14093501015","14349062008","14389534229","14311507310"])
c(18, "Part 0 §6a The widget; Part 3 Widget (positive) row; Part 2 5★", "feature",
  "The widget is the most-loved feature and is free — for some users the widget IS the product: 'I lwk js use for the widget'; 'I added this to my widgets which is really helping me to do my works irrespective of my mood'; 'you don't have to check it in the app since they have widgets'",
  "free home-screen widget", "praise", "7 mentions (15.91%), mean 5.00; Part 3 positive 6 (13.64%), mean 5.00; 6 of the 7 widget mentions are 5★", "build-free", "high-priority", "yes",
  ["13085620460","13093308789","13767758923","13795256017","13845360166","14372026009","14389534229"])
c(19, "Part 0 §6a widget buried in the listing; Part 9 #13", "do",
  "Market what users say is unique — the widget and the user-defined day boundary; the widget is the most-loved feature yet is one bullet at the bottom of the store description, and the day boundary is the reason at least one user switched",
  "widget = one bullet at the bottom of the listing; day boundary not marketed", "praise", "7 widget mentions; 1 switcher on day boundary", "do", "meaningful", "yes",
  ["13672386764","14372026009","13795256017"])
c(20, "Part 0 §6b No daily check-in required; Part 3 row", "feature",
  "Streak Counter mode — no daily check-in, you only declare when you broke the streak — is praised by the very first review: 'I really like that you don't need daily check-ins, but rather only declare if you broke your streak'",
  "free Streak Counter mode (auto-increment, reset on break)", "praise", "2 mentions (4.55%), mean 5.00 ('structurally important')", "build-free", "very strong band, n = 2", "yes",
  ["13085620460","13767758923"])
c(21, "Part 0 §6b differentiator; §6c positioning asset", "positioning",
  "The no-check-in counter is the app's actual differentiator against every check-off habit tracker on the store, and the user-defined day boundary is a positioning asset nobody at Explora appears to be marketing",
  "differentiated but unmarketed", "praise", "report gives none (2 + 1 reviews)", "do", "interpretation", "yes",
  ["13085620460","13672386764"])
c(22, "Part 0 §6c The user defines what 'a day' means; Part 3 User-defined day boundary row", "feature",
  "The user defines when their day ends — a BR reviewer switched from competitors specifically because of the midnight-boundary problem: 'Every app is locked to clock hours and I like to count my day based on when I wake up and when I go to sleep… Traditional apps make me lose my goal when I actually didn't lose it! Here I can log the truth of what I live'",
  "user-defined day boundary", "praise", "1 (2.27%), mean 5.00; the most detailed review in the corpus", "must-have", "meaningful (n = 1)", "yes",
  ["13672386764"], side="the midnight boundary is 'a known killer in this category'")
c(23, "Part 0 §7 (The same 'no check-in' design is also the top source of confusion and 1★ churn); Part 4 Counter mode read as a tracking bug row", "anti-pattern",
  "The same no-check-in design is the top source of confusion and 1★ churn: users in Streak Counter mode read it working as designed as a bug — 'The streaks keep moving whether I enter data or not' is a person who thinks the app is fabricating their progress, a trust failure not a UX nit; another wanted a checklist and asks 'Am I missing something?'",
  "counter mode auto-increments with no explanation of the mode", "churn", "2 × 1★; Counter mode read as a tracking bug 1 (2.27%), mean 1.00", "do", "second-most-actionable product finding", "yes",
  ["13628759209","13994050917"])
c(24, "Part 0 §7 Both modes ship; Part 6 discovery failure; Part 4 Wants manual check-off row; Part 9 #11", "must-have",
  "Make the Tracker-vs-Counter mode choice explicit at streak creation with one line explaining each: both modes ship ('An automatic tracker and manual tracker both are good') but onboarding does not make users choose, so a subset lands in the wrong mode and rates 1★ — and 2 of the 5 feature requests ask for a mode that already exists, a discovery failure not a feature gap",
  "both modes ship; choice invisible", "churn", "Wants manual check-off / accountability 2 (4.55%), mean 3.00; 2 of 5 actionable requests (11.36%) ask for an existing feature; 2 × 1★ in the wrong mode", "must-have", "meaningful", "yes",
  ["14292633754","13085620460","13628759209","13994050917"],
  cond="any app with more than one tracking model per item")
c(25, "Part 0 §8 (Two reviewers call it a clone, and both are 1★); §8.2 launch-window artefacts", "positioning",
  "Two reviewers call it a clone and both are 1★: 'Terrible app a clone of streaks' (Streaks by Crunchy Bagel) and 'literally a copy of the app Days Since but it's both more expensive and has less features, let alone the horrible UI and lack of customizability' — Days Since is report 3 in this set, so users compare these products directly, and StreakUp loses on customization and price, not core function",
  "near-identical concept to Streaks and Days Since at a higher price", "1★-burst", "2 of 44 (4.55%), mean 1.00; both Dec 2025 (launch window)", "research", "not a trend (n = 2)", "yes",
  ["13531820409","13557096013"],
  side="cross-report link: report 3 (Days Since) and the Streaks app (report 23)")
c(26, "Part 0 §9 (The public rating is 0.7 stars higher than what people write) table (verbatim)", "data-caveat",
  "The 4.65 badge is not telling the team about the paywall problem: roughly 12% of US raters wrote anything, the written mean sits 0.69 below the tap mean, and 36% of the people who typed complain about money — none of which reaches the dashboard",
  "n/a", "mixed", table("## 9. The public rating is 0.7") + " ; 23 written / 188 US taps ≈ 12%; gap 0.69", "do", "observed", "yes", [],
  cond="the written-vs-tap gap is the normal direction; its size is what matters")
c(27, "Part 0 §9 Length confirms it", "data-caveat",
  "Short reviews inflate; the app's real feedback lives in the long ones: 12 of 44 bodies (27.3%) are under 40 characters and average 4.17 stars, while the 32 substantive reviews average 3.78 with 21.9% one-and-two-star",
  "n/a", "none", "12/44 (27.3%) < 40 chars, mean 4.17; 32 substantive, mean 3.78, 21.9% 1–2★", "none", "observed", "yes", [])

with open("Tools/prd_ledger/6/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
