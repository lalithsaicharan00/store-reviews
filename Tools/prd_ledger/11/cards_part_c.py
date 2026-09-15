import json, re
R = 11
rep = open("App Store Reports/11. Daily Habits - Streak Tracker - Morning Routine & Goal Planner (REPORT).md").read().split("\n")
def table(after, k=0):
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 7 ----
c(40, "§7.1 No storefront qualifies for standalone analysis table (verbatim); storefronts with ratings but zero written reviews", "market",
  "No storefront reaches 50 (largest RU 9); per-storefront written n, mean, span, store ratings and displayed rating for 18 storefronts; IN (30 @ 4.80), FR (19 @ 4.47), DE (15 @ 4.40), UA (13 @ 4.92) plus AU, JP, NL, PL, TR have ratings but zero written reviews; crawl polled 85 storefronts",
  "n/a", "mixed", table("## 7.1 No storefront qualifies"), "none", "verbatim [limited evidence]", "app-specific", [])
c(41, "§7.2 The only observation strong enough to record — Russia", "market",
  "Russia is 27% of the written corpus and 32% of all ratings, with a written mean of 5.00 and the highest displayed rating of any storefront with >10 ratings; three of the nine Russian reviews carry the most substantive positive content and two of them date the free-tier baseline — Russian-language reviewers are this product's most engaged writers (fragile: nine reviews cannot establish a market characteristic)",
  "RU-localised, historically free", "praise", "RU 9 of 33 (27.27%); 170 of 537 ratings (31.7%); written 5.00, displayed 4.95", "research", "limited evidence", "app-specific",
  ["12249396648","13476851347","13469176367"])
c(42, "§7.3 High-spend markets — [limited evidence, cannot be assessed]; This app's audience is not in the high-spend markets", "market",
  "This app's audience is not in the high-spend markets: 86% of its rating base sits outside US/JP/GB/CA/AU/DE/FR, concentrated in RU, MX, CO, BR, CL, IN, AR, ES — a US-anchored $14.99 in-app pack is being shown to a base that is majority Russian and Latin American (a monetization-strategy fact from rating volume, not a review finding)",
  "US-priced IAPs for a RU/LatAm base", "none", "4 written reviews from US/GB/CA (mean 4.50), 0 from JP/AU/DE/FR; high-spend ratings 89 of 623 (14.3%)", "research", "limited evidence / external", "app-specific", [])
c(43, "§7.4 High-review-volume markets — the market and the written corpus are badly misaligned", "market",
  "By rating volume the market is RU, MX, CO, BR, CL (74.7% of ratings) but they contribute only a third of written reviews; MX (76 ratings) and CO (67) contribute one and two written reviews — the misalignment is itself the finding",
  "n/a", "none", "RU+MX+CO+BR+CL 401 of 537 ratings (74.7%) vs 11 of 33 written (33.3%)", "research", "limited evidence", "app-specific", [])
c(44, "§7.5 Small-storefront caveat — IE at 1.00 and PK at 1.00 are single reviewers, not markets", "data-caveat",
  "Twelve storefronts have exactly one review; IE and PK at 1.00 are single reviewers, not markets — their significance comes entirely from what they say, corroborated by a third reviewer in a third country",
  "n/a", "none", "12 single-review storefronts", "none", "method", "app-specific", [])
c(45, "§7.6 Language vs storefront table (verbatim); every Russian-, Spanish-, French- and Italian-language review is 5★", "market",
  "Storefront does not predict language; every Russian, Spanish, French and Italian review is 5★ while all sub-5★ reviews are English — most likely a length-and-detail effect (English reviewers write longer and more critically) plus the two 2026 billing complaints happening to be English, not a cultural finding",
  "n/a", "mixed", table("## 7.6 Language vs storefront"), "none", "n=33", "app-specific",
  ["8800831234","9809639708","10016901878","12119209447","12113191512"])
c(46, "§7.7 Per-storefront naming — an ASO fact worth flagging; table (verbatim)", "tactic",
  "The app carries at least eight different names across storefronts — deliberate per-storefront ASO testing: Spanish-speaking Latin America gets an AI-forward name while Spain does not; the entire English world outside the US gets 'Habit Builder with AI Planner' while the US keeps 'Daily Habits: Streak Tracker'; users in different markets are being sold different promises — a plausible contributor to expectation mismatch, recorded as context (no reviewer complains)",
  "per-storefront app names", "none", table("## 7.7 Per-storefront naming"), "research", "listing check", "yes", [])

# ---- PART 8 ----
c(47, "Part 8 intro; §8.1 Shape of the corpus year table (verbatim); split at the paywall table (verbatim)", "timeline",
  "Corpus shape by year and split at the paywall: 33 reviews over 68 months (0.49/month) — not dense enough for month-level claims",
  "n/a", "mixed", table("## 8.1 Shape of the corpus") + " ;; " + table("## 8.1 Shape of the corpus", 1), "none", "verbatim", "app-specific", [])
c(48, "§8.2 Trend 1 — a five-year plateau of near-perfect ratings, then a cliff; Caution against over-reading (126-day gap)", "timeline",
  "A five-year plateau of near-perfect ratings, then a cliff — confidence high on the discontinuity, low on the magnitude; the corpus is thin at both ends: only 2 reviews Jan–Apr 2026 and a 126-day gap before the first billing complaint, so whatever happened in that gap is visible only through one retrospective reference",
  "paywall retrofit + entitlement failure", "1★-burst", "29 consecutive 4–5★ Jan 2021–Apr 2026 mean 4.897; then 3 of next 4 at 1–2★; 126-day gap 13 Apr → 17 Aug 2026", "must-never-break", "high on direction, low on magnitude", "yes",
  ["13952453631","14438257886"])
c(49, "§8.3 Trend 2 — the free-tier praise runs from 2022 to Dec 2025 and stops", "timeline",
  "Free-tier praise runs Jun 2022 → Dec 2025 and then stops: zero of six reviews after 5 Dec 2025 praise the app for being free, and three of them complain about payment — directionally consistent with the retrofit, moderate confidence",
  "free tier removed", "complaint", "7 'free' praise reviews Jun 2022–Dec 2025; 0 of 6 after; 3 of 6 complain about payment", "product-rule", "moderate", "yes",
  ["8800831234","10285428672","10985521600","11468101739","12221849177","12249396648","13476851347"])
c(50, "§8.4 Trend 3 — feature requests concentrate in 2022–2024 and stop", "timeline",
  "All six feature requests fall between Nov 2022 and Jul 2024 and none after — either shipped (supported for dark theme and period statistics) or the corpus thinned; reordering, cloud backup, date filter and search have no evidence of shipping",
  "some requests shipped, some not", "mixed", "6 requests Nov 2022–Jul 2024; 0 after Jul 2024; 2025–26 has 12 reviews, 10 short praise or billing", "research", "two readings", "app-specific",
  ["9327859322","9332848196","9809639708","10016901878","10985521600","11490387774"])
c(51, "§8.5 Trend 4 — reviews got longer and more substantive, not shorter; table (verbatim)", "data-caveat",
  "Reviews got longer and more substantive, not shorter — the usual late-life drift to short praise does not appear; the recent corpus is the more considered half, a caution against dismissing the Aug 2026 cluster as noise; short bodies inflate the mean everywhere (7 of 33 under 40 chars average 5.00 vs 4.46 for the 26 substantive)",
  "n/a", "none", table("## 8.5 Trend 4") + " ; 7 of 33 (21.2%) under 40 chars mean 5.00; 26 substantive mean 4.46", "none", "low confidence", "yes",
  ["12221849177","12249396648","14438257886","14462951464"])
c(52, "§8.6 What persisted, unfixed, across all five years table (verbatim)", "feature",
  "Persistent gaps across five years: cloud backup / export (first raised Nov 2022, still absent, now load-bearing), drag-to-reorder (2023 and 2024, two 5★ reviewers), date filter / search (2024)",
  "absent", "complaint", table("## 8.6 What persisted"), "build-free", "n=1–2 each", "yes",
  ["9327859322","10016901878","11490387774","10985521600","14438257886"])
c(53, "§8.7 Corpus gaps — One gap is provably a coverage loss: the overwritten April 2026 review", "data-caveat",
  "One corpus gap is provably a coverage loss: a reviewer says 'I posted a review in April' and that review is not in the corpus — the App Store keeps one review per user per app, so the April review was overwritten by the August one; paywall complaints began in April not August, the corpus under-counts repeat reviewers, and the true count of paywall complaints is at least 4",
  "n/a", "none", "7 gaps of 100+ days (511 days Jan 2021→Jun 2022; 298 days Feb→Dec 2025); ≥4 paywall complaints, 3 is a floor", "none", "method", "yes",
  ["14438257886"])

# ---- PART 9 ----
c(54, "Part 9 Immediate — billing integrity #1 Audit receipt validation and entitlement persistence end to end", "must-never-break",
  "Audit receipt validation and entitlement persistence end to end — reproduce a lifetime non-consumable expiring after months, an entitlement re-locking ~7 days after purchase, and an active annual term being re-prompted for payment",
  "entitlements fail", "1★-burst", "3 of 3 paid reviewers lost access; 2 titled 'scam'/'fraud'", "must-never-break", "recommendation (immediate)", "yes",
  ["14472099021","14446220984","14438257886"])
c(55, "Part 9 Immediate — billing integrity #2 Fix Restore Purchases", "must-never-break",
  "Fix Restore Purchases — the only self-service remedy a user has, and it is not working (reinstall did not restore)",
  "restore purchases broken", "1★-burst", "1 review", "must-never-break", "recommendation (immediate)", "yes",
  ["14446220984"])
c(56, "Part 9 Immediate — billing integrity #3 Ship a reachable in-app support channel with a response SLA", "must-have",
  "Ship a reachable in-app support channel with a response SLA — 'there is no way in app to talk with developer or team'; support absence is converting fixable billing bugs into permanent store damage (unanswered tickets filed as public 1–2★ reviews)",
  "no in-app support; email unanswered", "1★-burst", "2 of 33 support unreachable, mean 1.50", "must-have", "recommendation (immediate)", "yes",
  ["14472099021","14446220984"])
c(57, "Part 9 Immediate — billing integrity #4 Rename the three 'Habits PRO Functions' SKUs; state the period in each display name", "must-never-break",
  "Rename the three identically-named SKUs so $1.99 / $6.99 / $8.99 are distinguishable and state the period (or 'one time') in each display name — a user cannot identify what they bought; neither can support",
  "3 SKUs, one name, no period", "complaint", "listing check", "must-never-break", "recommendation (immediate)", "yes", [])
c(58, "Part 9 Immediate — billing integrity #5 Reply to the three reviewers in the App Store and reinstate their access", "do",
  "Reply to the three affected reviewers in the App Store and reinstate their access — three public accusations of fraud, unanswered, on a listing whose displayed rating is 4.86",
  "no developer replies", "1★-burst", "3 unanswered fraud accusations", "do", "recommendation (immediate)", "yes",
  ["14438257886","14446220984","14472099021"])
c(59, "Part 9 Immediate — disclosure #6 State the free/paid split in the store description", "must-have",
  "State the free/paid split in the store description — the current description discloses nothing (0 mentions of premium, subscription, free, unlock or ads) while four IAPs up to $14.99 exist; the core grievance is being charged for what was free with no warning anywhere",
  "no paywall disclosure", "1★-burst", "0 disclosure terms; 4 IAPs", "must-have", "recommendation (immediate)", "yes",
  ["14438257886"])
c(60, "Part 9 Immediate — disclosure #7 Publish and honour a grandfathering rule for pre-2026 users", "product-rule",
  "Publish and honour a grandfathering rule for pre-2026 users — the users being paywalled are the ones who wrote the 4.86 rating",
  "no grandfathering", "1★-burst", "free parity attested 5 Dec 2025, gone by Apr 2026", "product-rule", "recommendation (immediate)", "yes",
  ["13476851347","14438257886"])
c(61, "Part 9 Immediate — disclosure #8 Resolve the two-product pricing conflict", "dont",
  "Resolve the two-product pricing conflict — retire the paid twin (1 rating in 6 years, one version behind) or price it consistently; a user who finds both is asked to pay $5 more for buying inside the product",
  "paid twin $9.99 vs IAP lifetime $14.99", "complaint", "listing check", "dont", "recommendation (immediate)", "yes", [])
c(62, "Part 9 Near-term product #9 Ship export and/or iCloud backup — sell durability, not access", "feature",
  "Ship export and/or iCloud backup — the oldest request and now the mechanism behind the worst review; removes data hostage as a purchase driver, removes catastrophic downside when billing misfires, and makes a POSITIVE upgrade case (backup as a Premium feature) that no reviewer would call a scam",
  "absent", "blocked-conversion", "first raised Nov 2022; 1 purchase driven by data fear", "build-paid", "recommendation (near-term)", "yes",
  ["9327859322","14438257886"])
c(63, "Part 9 Near-term product #10 Add drag-to-reorder, and audit for other one-step-only interactions", "feature",
  "Add drag-to-reorder and audit for other one-step-only interactions — both requesters gave 5★, cheap goodwill, and the pattern likely recurs",
  "one-step reordering", "complaint", "2 reviewers, both 5★", "build-free", "recommendation (near-term)", "yes",
  ["10016901878","11490387774"])
c(64, "Part 9 Near-term product #11 Verify the shipped state of month view, date filter, search and per-task statistics", "do",
  "Verify the shipped state of month view, date filter, search and per-task statistics against the most detailed review's four asks — the listing claims two of four and no user has confirmed post-ship",
  "claimed shipped", "none", "listing claims 2 of 4", "do", "recommendation (near-term)", "app-specific",
  ["10985521600"])
c(65, "Part 9 Near-term product #12 Decide whether the free tier keeps unlimited habits", "product-rule",
  "Decide whether the free tier keeps unlimited habits — this was the acquisition wedge against the category; if it has been capped, that is the highest-risk change the app has made and it is invisible in this corpus",
  "unlimited habits status unknown after retrofit", "purchase-driver", "1 review is the entire wedge evidence", "product-rule", "recommendation (near-term)", "yes",
  ["11904287504"])
c(66, "Part 9 Monetization — repackage around what the corpus actually values: Sell durability, not access", "monetization",
  "This is not a product that needs a cheaper price — it needs a paid tier that adds something rather than removing something: sell durability (backup, export, multi-device, long-history analytics), not access; the one buyer was paying to KEEP what they had rather than to GAIN something",
  "paywall removes; nothing added", "blocked-conversion", "0 price objections; 1 buyer willing to pay for durability", "build-paid", "recommendation", "yes",
  ["12221849177","14438257886"])
c(67, "Part 9 Monetization — Do not sell the quiet", "dont",
  "Do not sell the quiet: four reviewers chose this app because it does not nag, gamify or infantilize — ads and upsell pressure attack the differentiator directly",
  "possible ads in free tier (inferred)", "praise", "4 of 33 chose it for quiet", "dont", "recommendation", "yes",
  ["8756804446","11375045777","12221849177","13685904641"])
c(68, "Part 9 Monetization — Price for the actual base", "monetization",
  "Price for the actual base: 86% of ratings sit outside high-spend storefronts (RU/MX/CO/BR/CL/IN/AR/ES); a US-anchored $14.99 pack is not priced for this audience — rests on external rating-volume data, no reviewer complains about price",
  "US-anchored pricing", "none", "86% of ratings outside high-spend storefronts", "do", "recommendation (external data)", "yes", [])
c(69, "Part 9 Positioning — a live tension the corpus flags but cannot resolve", "contradiction",
  "Positioning tension: the listing now leads with AI while the corpus's strongest positive signal is anti-coaching minimalism ('no infantilization', 'I hate apps that demand set times', 'don't overwhelm me with settings and frills', 'without any imposed junk'); no reviewer has said anything about AI — the highest-risk change is completely unmeasured and the loyal audience selected for the opposite quality; top research priority, not a finding",
  "AI-first listing over a minimalist product", "none", "0 AI mentions; 4 anti-coaching reviews", "research", "recommendation (research)", "yes",
  ["13685904641","8756804446","11375045777","12221849177"])
c(70, "Part 9 Research questions this corpus cannot answer #1–#6; part 9 #1; part 9 #2; part 9 #3; part 9 #4; part 9 #5; part 9 #6", "data-caveat",
  "Research questions: do MX and CO users share the RU/BR themes (largest blind spot: 26.6% of ratings, 9.1% of written); what exactly moved behind the paywall in Q1 2026 and were unlimited habits part of it; how many users were affected by the entitlement defect (the overwritten April review proves undercounting); is the AI habit generator used and by whom; does the free app now show ads; did dark theme and period statistics actually ship and land well",
  "n/a", "none", "MX+CO 143 of 537 ratings, 3 of 33 written", "research", "research questions", "yes", [])

with open("Tools/prd_ledger/11/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
