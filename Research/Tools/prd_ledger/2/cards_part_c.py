import json, re
R = 2
rep = open("App Store Reports/2. Daily Habits - Habit Tracker - Habit List and Routine Tracker (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- 6.1 US ----
c(75, "§6.1 US table (verbatim)", "market", "US store themes (n=98, mean 3.80, 23.5% 1–2★) — full table",
  "n/a", "mixed", table(311, 327), "none", "high-priority", "yes", [])
c(76, "§6.1 note 1", "insight", "The US buys at double the global rate (7.14% vs 5.80%) and rates lowest (3.80) — the commercially damaging combination",
  "n/a", "churn", "US confirmed purchase 7.14% vs 5.80% global; US mean 3.80 vs 4.15", "must-never-break", "high-priority", "yes", [],
  side="the market most willing to pay is the one most hurt by broken paid features")
c(77, "§6.1 note 2", "feature", "Onboarding is a US-specific weakness (6.12%) not seen elsewhere: 'very complicated interface', 'too many steps compared to its competition', 'the UI is pretty inscrutable at first', asks for tutorials and a replayable intro",
  "no tutorial; swipe-to-complete and break-a-habit toggle undiscoverable", "complaint", "6 US (6.12%) HIGH-PRIORITY", "must-have", "high-priority (US)", "yes",
  ["1494919328","6485340419","1835255000","2459382527","5288840112","3297361804"],
  cond="Part 8 #15: skippable, replayable tour")
c(78, "§6.1 note 3", "audience", "ADHD framing exists but is marginal here (3 reviews, 3.06% of US) versus 7.08% in report 1's app — this product was never positioned for that audience",
  "not positioned for ADHD", "praise", "3 US (3.06%)", "do", "very strong (US) but small n", "yes", ["9175173155","8207109946","8106352419","3713698872"],
  side="audience share follows positioning, not just product fit")
c(79, "§6.1 note 4", "market", "Localisation is a non-issue for the US (0%)", "English", "none", "0% of US", "none", "ignore (US)", "yes", [])
c(80, "§6.1 note 5", "insight", "One unrebutted privacy objection: 'That's a whole lotta tracking going on by the developer… not to have my data sold'",
  "tracking/analytics SDKs visible to the user", "complaint", "1 review (2022, 1★)", "do", "single review", "yes", ["9189481747"],
  side="in an abandoned app nobody answers privacy concerns; a privacy statement in-app pre-empts this")
c(81, "§6.1 table row 'Groups / accountability'", "feature", "Groups / accountability is a 'very strong' US theme (3.06%)",
  "groups/sharing exist, free", "praise", "3 US (3.06%)", "research", "very strong (US), n=3", "yes", [])
c(82, "§6.1 table row 'Compared against competitors'", "positioning", "In the US, 'compared against competitors' ties crashes as the top theme (8.16%)",
  "n/a", "praise", "8 US (8.16%)", "do", "high-priority (US)", "yes", [])

# ---- 6.2 ----
c(83, "§6.2 table (verbatim)", "market", "High-review-volume markets [limited evidence below n=50] — full table",
  "n/a", "mixed", table(340, 348), "none", "limited evidence", "yes",
  ["2493571137","5938382344","7232398007","5423974093","5726080829","2165186932","1962124981","1650678342","1816542296","10872403505","5891978522","5403701988","1520975020","5229271933","2008072626","7897418954","2188276454","3693806025"],
  side="review volume is a disclosed engagement proxy, not download or spend data")
c(84, "§6.2 table row Germany", "feature", "German users report reminders firing per time-of-day instead of per habit",
  "reminders grouped by time block", "complaint", "2 IDs [limited evidence]", "must-never-break", "limited evidence", "yes", ["2165186932","1962124981"],
  cond="per-habit reminder times are the expectation")
c(85, "§6.2 table row Brazil", "market", "Brazil is the best-rated market (4.65, 0% 1–2★) and asks for Portuguese and a louder notification sound",
  "no Portuguese", "praise", "n=20 [limited evidence]", "do", "limited evidence", "yes", ["2008072626","7897418954","2188276454","3693806025"])
c(86, "§6.2 Japan paragraph", "market", "Japan is the clearest market-level failure (3.30, 25% 1–2★): four complaint classes stack — off-by-one date, tap latency growing with habit count, data loss, missing Japanese — yet Japanese users still tried it after testing ~10 rivals and praised the buy-once model",
  "no Japanese; date bug; lag; data loss", "1★-burst", "n=20 [limited evidence], mean 3.30", "do", "limited evidence", "yes",
  ["1479044283","1480026316","1597898439","4115836897","1639153995","1664490322","3488095225","1543097703","1560960588","4089300870","1489024032","6376581104","9966969216","3562883708","3825826319","10424885681"],
  side="tap latency that grows with habit count is a performance bug that hits the most engaged users hardest")

# ---- 6.3 ----
c(87, "§6.3", "market", "High-ARPU markets (qualitative grouping) hold 53.4% of reviews at mean 3.99 vs 4.33 for the rest — the people most able to pay are the least satisfied",
  "n/a", "complaint", "276 of 517 (53.4%) at 3.99 vs 4.33 for 241; [group defined by convention, not data — directional]", "must-never-break", "directional", "yes", [])

# ---- 6.4 ----
c(88, "§6.4 + table", "market", "Localisation: 14 requests (2.71%, mean 3.50) across 8 languages — Japanese 4, Spanish 3, Russian 3, Portuguese 2, French 2; the app never shipped a non-English UI; 'localization is very desirable, since you are selling the app in the Russian App Store'",
  "English only", "blocked-conversion", "14 (2.71%), mean 3.50; " + table(360, 366), "do", "meaningful", "yes",
  ["1489024032","6376581104","9966969216","4089300870","2087834366","4316991688","6185785453","1481301722","1517984752","1482400655","2008072626","7897418954","1785316005","2182349196"])

# ---- 6.5 ----
c(89, "§6.5", "data-caveat", "60 of 61 storefronts fall below the 50-review threshold (419 reviews, mean 4.23); no standalone conclusion is drawn from any of them",
  "n/a", "none", "60 storefronts, 419 reviews, mean 4.23", "none", "method", "yes", [])

# ---- PART 7 ----
c(90, "Part 7 era table (verbatim)", "timeline", "Four eras: A 2016–17 launch n=164 mean 3.97 19.5% 1–2★; B 2018–19 maturity 161/4.19/13.0%; C 2020–21 final updates 107/4.21/14.0%; D 2022–26 post-abandonment 85/4.31/11.8%",
  "n/a", "mixed", table(380, 385), "none", "high-priority", "app-specific", [])
c(91, "Part 7 theme-by-era table (verbatim)", "timeline", "Theme share by era (% of that era's reviews) — full table",
  "n/a", "mixed", table(389, 400), "none", "high-priority", "app-specific", [])
c(92, "Part 7 'Fixed'", "timeline", "The off-by-one date bug is the one clear engineering win: 6.7% → 1.9% → 0.0%, gone after 2019 and never mentioned again",
  "fixed the date bug by 2019", "praise", "6.7% (A) → 1.9% (B) → 0.0% (C, D)", "must-never-break", "high-priority", "yes", [])
c(93, "Part 7 'Got worse, then went quiet'", "timeline", "Crashes (6.7% → 3.7% → 8.4%) and data loss (6.1% → 1.9% → 7.5%) spiked in 2020–21 with iOS 14 / 14.5; the drop to ~2% afterwards is not a fix — it is the sound of users having left",
  "iOS 14 regressions never fixed; last code change May 2021", "1★-burst", "era C crashes 8.4%, data loss 7.5%; era D 85 reviews vs 164 in era A", "must-never-break", "high-priority", "yes",
  ["7232398007","7580228017","7271771390","6734756659"],
  side="an unmaintained app becomes an OS-release liability; falling complaint share after abandonment is attrition, not repair")
c(94, "Part 7 'Grew as everything else shrank'", "insight", "After abandonment the only reasons anyone writes about the app are the two pricing themes — unlimited-free (3.0% → 8.2%) and cheap-one-time (0.6% → 8.2%); long-term users value the free tier and buy-once price and have made peace with the rest",
  "unlimited free + one-time price", "praise", "unlimited-free 8.2%, one-time 8.2% in era D; one user has updated the same review since 2017", "product-rule", "high-priority", "yes",
  ["13629753462","12145789866","13550599009","13955224346"],
  side="generous free tier + one-time price is what keeps a product alive with zero development")
c(95, "Part 7 'competitive scrutiny collapsed'", "timeline", "Discovery-stage competitive comparison collapsed from 11.0% (2016–17) to 3.5% — the app stopped being evaluated by new shoppers around 2018",
  "n/a", "none", "11.0% → 3.7% → 3.7% → 3.5%", "none", "high-priority", "app-specific", [],
  side="comparison mentions are a proxy for new-user acquisition")
c(96, "Part 7 'Support flipped'", "tactic", "Support flipped: every positive support mention is from 2016–2018 ('kept the promise of responding in 48 hours', 'support persisted with me and it worked'); every negative one is later or unanswered ('I click on App Support, nothing happens')",
  "responsive support early, none later", "mixed", "6 positive IDs (2016–18) vs 3 negative (later)", "must-have", "clear mechanism", "yes",
  ["1490152355","1490259621","1488986466","1520975020","3504776374","6682336849","1650678342","5403701988","6467272815"],
  side="a 48-hour response promise, kept, earns rating upgrades; an App Support link that does nothing is noticed")
c(97, "Part 7 'No AI'", "insight", "No AI-related expectation appears anywhere in the corpus — zero mentions across 517 reviews and 11 years",
  "no AI", "none", "0 of 517", "dont", "negative evidence", "yes", [])

# ---- PART 8 ----
c(98, "Part 8 #1", "must-never-break", "Local-first, durable storage with a restore path — data loss is 4.26% at mean 1.95 and is what turned paying customers into refund requests; no feature matters more",
  "no durable storage / restore path", "1★-burst", "4.26%, mean 1.95", "must-never-break", "high-priority", "yes", [], cond="evidence: R02-041, R02-056")
c(99, "Part 8 #2", "must-never-break", "Never let the app freeze on check-off; tap latency must not grow with habit count — Japan's payers waited 5+ seconds",
  "crashes; lag grows with habit count", "1★-burst", "crashes 14 of 47 1★; 3 lag IDs", "must-never-break", "high-priority", "yes", ["1639153995","1664490322","3488095225"], cond="evidence: R02-040, R02-062, R02-086")
c(100, "Part 8 #3", "must-never-break", "Get the date right in every surface and every timezone — widget, Watch and app must agree; this developer solved it once",
  "date bug across surfaces", "complaint", "2.71%", "must-never-break", "meaningful", "yes", [], cond="evidence: R02-057, R02-092")
c(101, "Part 8 #4", "feature", "If you ship an Apple Watch app, it must actually sync — 12 of 15 Watch mentions are failures at mean 2.33, and it was a stated purchase reason",
  "Watch app broken", "1★-burst", "12/15 negative, mean 2.33", "must-never-break", "meaningful", "yes", [], cond="evidence: R02-042, R02-058")
c(102, "Part 8 #5", "must-never-break", "Never write to the user's calendar without exact, reversible, correctly-sized events — one user needed Apple support to repair their phone",
  "calendar sync corrupts the calendar", "1★-burst", "1.74%, mean 2.11", "must-never-break", "meaningful", "yes", ["1650678342"], cond="evidence: R02-059")
c(103, "Part 8 #6", "product-rule", "Keep the one-time purchase — 19 reviews at mean 4.84 name it as the reason to buy; the app's only durable competitive weapon against subscription rivals",
  "one-time Pro", "purchase-driver", "19 (3.68%), mean 4.84", "product-rule", "very strong", "yes", [], cond="evidence: R02-020, R02-094")
c(104, "Part 8 #7", "product-rule", "Do not gate the habit cap — unlimited-free is the highest-rated theme in the corpus (mean 4.97) and earns the word-of-mouth a tiny marketing budget cannot buy",
  "unlimited habits free", "5★-burst", "mean 4.97, 29/30 5★", "build-free", "high-priority", "yes", [], cond="evidence: R02-037, R02-047; contrast report 1 (cap of 6+ held constant)")
c(105, "Part 8 #8", "product-rule", "Make the paid tier things that actually work — this app charged for sync, calendar and stats, shipped all three broken, and paying users ended a full star below free ones; ship the paid feature before you sell it",
  "sold broken paid features", "1★-burst", "payers 3.10 vs 4.15", "product-rule", "high-priority", "yes", [], cond="evidence: R02-017, R02-024, R02-031")
c(106, "Part 8 #9", "must-never-break", "Fix the purchase flow — 1.55% of all reviews are people who tried to give money and couldn't",
  "purchase/signup errors", "blocked-conversion", "1.55%", "must-never-break", "meaningful", "yes", ["5819047278"], cond="evidence: R02-028")
c(107, "Part 8 #10", "feature", "'X times per week' scheduling — the single most-requested model change and a churn cause on its own",
  "missing", "complaint", "2.32%", "must-have", "meaningful", "yes", ["8509313946"], cond="evidence: R02-068")
c(108, "Part 8 #11", "feature", "Manual habit reordering — trivial to build, requested for eight straight years, mean 4.33",
  "missing", "complaint", "1.74%, mean 4.33", "build-free", "meaningful", "yes", [], cond="evidence: R02-070")
c(109, "Part 8 #12", "feature", "Customisable, louder reminder sounds — the cheapest 5★ upgrade available",
  "missing", "complaint", "1.93%, mean 4.10", "build-free", "meaningful", "yes", [], cond="evidence: R02-044, R02-069")
c(110, "Part 8 #13", "feature", "Weekly / monthly / yearly review screens — the top 4★ blocker",
  "stats thin", "complaint", "2.51%", "build-paid", "meaningful", "yes", [], cond="evidence: R02-067")
c(111, "Part 8 #14", "feature", "Keep personal photos on habits — rare, loved, and no competitor in this corpus offers it",
  "own photos as icons", "praise", "6 IDs", "undecided", "small, distinctive", "yes", [], cond="evidence: R02-050")
c(112, "Part 8 #15", "feature", "Onboarding — a skippable, replayable tour of swipe-to-complete and the break-a-habit toggle",
  "no tour", "complaint", "6.12% of US", "must-have", "high-priority (US)", "yes", [], cond="evidence: R02-077")
c(113, "Part 8 #16", "do", "Lead with 'unlimited habits, free, no subscription' — it is what every advocate in this corpus says unprompted",
  "n/a", "praise", "the two era-D themes at 8.2% each", "do", "high-priority", "yes", [], cond="evidence: R02-047, R02-094")
c(114, "Part 8 #17", "do", "If you have sibling apps, integrate them or say plainly that you don't — assumed integration drove purchases that ended in 1★",
  "no integration", "1★-burst", "2 purchases → 1★", "do", "weak count, clear mechanism", "yes", ["2109039905","7232398007"], cond="evidence: R02-035, R02-073")
c(115, "Part 8 #18", "dont", "Do not ship and walk away — abandonment is visible to users within about a year and the app becomes an iOS-release liability for paying users with no recourse",
  "abandoned May 2021", "complaint", "abandonware 1.74%; iOS 14 broke it for payers", "dont", "high-priority", "yes", ["6185785453"], cond="evidence: R02-004, R02-093")
c(116, "Part 8 #19", "dont", "Do not spam rating prompts or cross-promote to paying customers",
  "rating prompts + cross-promo", "complaint", "3 IDs", "dont", "emerging", "yes", ["1484050413","3342902073","7598926605"], cond="evidence: R02-065")
c(117, "Part 8 #20", "dont", "Do not seed launch reviews — two users spotted it in week one and said so publicly, and it permanently contaminates your own analytics baseline",
  "possibly seeded launch", "complaint", "2 IDs", "dont", "inference", "yes", ["1479044283","1484864417"], cond="evidence: R02-008")

# ---- Appendix ----
c(118, "Appendix — method", "data-caveat", "Method: 517 records, zero duplicates, 100% reconciliation with by_country and manifest; all reviews read in full in 17 languages; regex candidates then hand-curated ID lists (false positives: 'add' vs ADHD, 'productive' vs the app); non-exclusive theme membership; one external source (Apple lookup API, 2026-09-09); n=517 is small (one review = 0.19%); only the US clears 50; eras have shrinking samples (164/161/107/85)",
  "n/a", "none", "517 reviews; 5★ 314 / 4★ 89 / 3★ 36 / 2★ 31 / 1★ 47; mean 4.145; is_edited true on 4", "none", "method", "yes", ["1816542296"],
  cond="report 2 uses the older part structure (Parts 0–8 + Appendix, no Part 9)")

with open("Tools/prd_ledger/2/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
