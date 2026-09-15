import json, re
R = 17
rep = open("App Store Reports/17. Daily Routine - Organise your time into blocks (REPORT).md").read().split("\n")
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

# ---- PART 5 ----
c(31, "§5.1 The evidence base table (verbatim); people who get inside this product rate it more than two and a half stars higher than people who don't", "monetization",
  "Paid evidence is substantial for a small corpus: 11 state they paid (8 for this app, 3 for classic only and refused this one); confirmed payers of this app average 3.63 against 1.14 for those blocked at the paywall — people who get inside rate it more than two and a half stars higher; directional (n=8 vs 7), but the strongest argument in the corpus for letting people in",
  "hard paywall", "mixed", table("## 5.1 The evidence base") + " ; payers of this app 8 (21.05%) mean 3.63: 5★ 3, 4★ 3, 3★ 1, 2★ 2", "product-rule", "counts", "yes",
  ["7886496270","8417841619","10884354864","7859394020","8013032927","8557538403","13441826130","8776556254","8827339965"])
c(32, "§5.2 What made people pay — the classic app's reputation cashed in immediately (patronage); no alternative; the most fragile revenue there is", "insight",
  "Purchase driver #1 is the classic app's reputation cashed in immediately — payment as patronage before evaluating the new product ('I instantly subscribed to the yearly subscription to give my full support'; 'I put both feet in and bought the full version'; 'I am happy to support your efforts!'; 'My hope is that… the developer will continue to meet our needs') — the most fragile revenue there is, advanced against a promise of continued development that stopped in Jan 2023; driver #2 is no alternative ('It's worth the money'; 'I am a loyal subscriber and I hope this app is here to stay')",
  "relaunch on legacy goodwill", "purchase-driver", "3 patronage payers; 2 no-alternative payers", "product-rule", "counts", "yes",
  ["8013032927","7859394020","7886496270","8417841619","10884354864"])
c(33, "§5.3 What stopped people from paying — five barriers in order", "monetization",
  "Five barriers in order: no way to evaluate before paying (the largest theme); the $64.99 lifetime price (3.25-year payback demanded up front from a developer with an abandonment history); subscription-model rejection (being asked to rent what they previously owned); no grandfathering for classic buyers; bug level vs price ('I hesitate to buy/subscribe. The price of one-time purchase is too expensive for the app with many bugs' — a positive-leaning user talking themselves out of a purchase)",
  "hard paywall; $64.99 lifetime; no grandfathering", "blocked-conversion", "paywall 7 (18.42%) 1.14; price 5 (13.16%) 1.60; sub model 5 (13.16%) 1.40; grandfathering 3; bugs-vs-price 1", "product-rule", "counts", "yes",
  ["8874399635","11033875205","13120304447"])
c(34, "§5.4 Post-purchase experience and churn — a complete churn cycle; churn driver #1 is non-delivery of continued development; the payment plumbing works", "must-never-break",
  "The corpus documents a complete churn cycle among payers — paid and waited ('I kept my subscription going for a few months hoping it would approach quality of legacy app'), paid and could not learn it, still paying while evaluating a competitor, loved it and watching it decay; churn driver #1 is non-delivery of continued development, not a product defect — users bought a trajectory and the trajectory stopped; notably absent in all 38: any refund request, charge-after-cancel, failed restore or billing error — the payment plumbing works, the value proposition behind it does not; the one support interaction converted perfectly — the problem is not capability or care, it is sustained capacity",
  "subscription with no delivery; billing clean", "churn", "4 churn narratives; 0 billing complaints of 38; 1 support interaction → 5★", "must-never-break", "counts", "yes",
  ["8776556254","8827339965","13441826130","13193213543","8244932708"])

# ---- PART 6 ----
c(35, "Part 6 MARKET AND LANGUAGE NOTES (limited evidence)", "market",
  "Limited-evidence market notes: the US holds nearly half of reviews and every other storefront has 4 or fewer; 18 of 30 crawled storefronts returned nothing (GB, AU, FR, IT, JP, KR) — with an English-only listing and no iPad build the reach appears narrow; India's 4 reviews are 3 negative (noise, n=4); the 3 non-English reviews are all positive and two ask for features",
  "English only; narrow reach", "mixed", "us 18 (47.37%); in 4 (3 negative); non-English 3 all 5★", "research", "limited evidence", "app-specific",
  ["8644242601","9992175230","11033875205","7850343184","8417841619","11035825108","14333713628"])

# ---- PART 7 ----
c(36, "§7.1 Method — two anchors: relaunch Sep 2021 and final release 1.1.4 (9 Jan 2023); period table (verbatim); by year", "timeline",
  "Time-trend method anchored on the relaunch (Sep 2021) and the final release (9 Jan 2023): before the final update mean 3.25 (n=24), after 2.93 (n=14)",
  "n/a", "mixed", table("## 7.1 Method") + " ; by year 2021 10 (4.30) · 2022 13 (2.62) · 2023 6 (2.50) · 2024 3 (3.67) · 2025 4 (2.50) · 2026 2 (3.00)", "none", "verbatim", "app-specific", [])
c(37, "§7.2 Trend 1 — The goodwill was spent within 16 months; the reviewers changed before the app did", "timeline",
  "The goodwill was spent within 16 months — Era 1 → Era 2 is a 1.68-star fall: 9 of 10 Era 1 reviews reference the classic and 6 of 10 celebrate the return; in Era 2 paywall complaints appear for the first time and legacy grievance turns hostile — the reviewers changed before the app did: Era 1 was the existing fanbase, Era 2 the general public meeting a hard paywall",
  "relaunch goodwill then hard paywall", "1★-burst", "4.30 (n=10) → 2.62 (n=13)", "product-rule", "largest movement", "yes",
  ["8863711662","8874399635","9289248731"])
c(38, "§7.3 Trend 2 — Emerging and now dominant: abandonment, again; table (verbatim)", "timeline",
  "Abandonment did not exist as a theme before 2025 and now dominates: four of the corpus's last six reviews are about the app not being updated, and the listing confirms the cause (last release 9 Jan 2023) — the clearest and most recent trend, forecasting the churn of the remaining paying base",
  "no release since Jan 2023", "churn", table("## 7.3 Trend 2"), "must-never-break", "clear, recent", "yes",
  ["13120304447","13193213543","13441826130","14384355988"])
c(39, "§7.4 Trend 3 — Persistent: paywall complaints, from 2022 to 2025; zero in Era 1 because those reviewers already knew what the app was", "timeline",
  "Paywall complaints are a steady drip from Jul 2022 to Jan 2025, unchanged by anything the developer did; zero in Era 1 because those reviewers already knew what the app was and wanted to pay — the theme begins the moment the audience widens",
  "hard paywall", "1★-burst", "7 across Jul 2022 – Jan 2025; 0 in Era 1", "product-rule", "persistent", "yes",
  ["8863711662","9289248731","9471017050","9992175230","10024637302","10621025077","12167506108"])
c(40, "§7.5 Trend 4 — Persistent: bugs across the whole lifespan; OS-transition fragility with nobody shipping fixes after Jan 2023", "timeline",
  "Bug reports span the full corpus — 'Since the latest iOS update, opening the app results in just a black screen' — the same OS-transition fragility, and after Jan 2023 there is no longer anyone shipping fixes for it",
  "black screen after iOS update; no fixes", "1★-burst", "2021 (2), 2022 (3), 2025 (2)", "must-never-break", "persistent", "yes",
  ["7849996761","7859394020","8776556254","9086558708","9244113250","13120304447","13193213543"])
c(41, "§7.6 Trend 5 — Fixed, briefly: responsive development in early 2022 — the corpus documents not an absence of ability but its exhaustion", "timeline",
  "The one counter-trend: early 2022 shows a developer actively shipping and personally engaging ('the dev emailed me personally when they implemented it'), with 4★ reviews anticipating 5★ once features land; that capacity is gone by 2023 — the corpus documents not an absence of ability but its exhaustion, a resourcing or business-viability problem behind every other finding",
  "responsive dev, then dormant", "praise", "Jan 2022 window: 1 support 5★, 2 anticipatory 4★", "do", "counter-trend", "yes",
  ["8244932708","7780256223","8013032927"])
c(42, "§7.7 What persisted unchanged — the core value proposition; the unmet platform asks; calendar integration", "insight",
  "Persisted unchanged over five years: the core value proposition (praised Sep 2021 → Jul 2026 with no erosion), the unmet iPad ask (2022, 2023, 2025, still absent), and calendar integration removed at relaunch and still the blocking gap four years later",
  "n/a", "mixed", "value praised 5 dates; iPad 3 dates; calendar 2021 + 2025", "must-have", "persistent", "yes",
  ["7866331165","9504102829","10884354864","13441826130","14333713628","8275228824","9957602682","7780256223"])

# ---- PART 8 ----
c(43, "§8.1 I1 Open a real free tier or a genuinely inspectable trial — cancellation flow visible before payment details are taken", "product-rule",
  "Open a real free tier or a genuinely inspectable trial — let users build a schedule before any payment wall, and make the cancellation flow visible before payment details are taken; 5 of 12 one-star reviews come from people who never saw the product",
  "hard paywall", "blocked-conversion", "N1 7 (18.42%) mean 1.14; payers 3.63 vs blocked 1.14", "product-rule", "recommendation (immediate)", "yes",
  ["9289248731"])
c(44, "§8.1 I2 Ship an onboarding tutorial that defines block, activity and sequence — use the reviewer's content brief verbatim", "must-have",
  "Ship an onboarding tutorial that defines block, activity and sequence — one reviewer wrote the content brief; the curve is real but surmountable ('a day of experimenting') and a paywall that demands payment before that day is fatal",
  "no tutorial; unique vocabulary", "complaint", "N3 7 (18.42%); N9 3 (7.89%)", "must-have", "recommendation (immediate)", "yes",
  ["8827339965","7866331165","8644242601"])
c(45, "§8.1 I3 Fix single-instance editing of repeating blocks, and make 'reality' edits cascade", "must-never-break",
  "Fix single-instance editing of repeating blocks and make reality edits cascade to later blocks — two independent, precisely specified reports from 4★ users; a time-blocking app whose blocks can't absorb slippage fails at its core promise",
  "no single-instance edit; no cascade", "complaint", "N11 2 (5.26%), both 4★", "must-never-break", "recommendation (immediate)", "yes",
  ["7780256223","8557538403"])
c(46, "§8.1 I4 Ship something. Anything. A dated changelog and a public roadmap; §8.1 I5 Decide the app's future honestly — stop selling the lifetime tier if development cannot resume", "must-never-break",
  "Ship something — a dated changelog and a public roadmap immediately: charging a monthly subscription against a 3.5-year-old build is the central credibility problem; and decide the app's future honestly and say so publicly — if development cannot resume, stop selling the $64.99 'lifetime' tier, which compounds the exact grievance that produced five one-star reviews",
  "subscription + lifetime sold on a dormant build", "churn", "N8 4 (4 of last 6 reviews); N5 5; last release 9 Jan 2023", "must-never-break", "recommendation (immediate)", "yes",
  ["13441826130","7849996761"])
c(47, "§8.2 B1 iPad app; B5 Apple Watch, Mac, iCloud sync", "feature",
  "iPad is the most-requested single item (2022, 2023, 2025; continued payment contingent on it); Watch, Mac and iCloud sync are 1–2 reviewers each but together the platform story behind five reviews all rated 3★+",
  "iPhone only; no sync", "blocked-conversion", "iPad 3; Watch 2; Mac 1; iCloud 1; N7 5 (13.16%) mean 4.20", "build-paid", "recommendation", "yes",
  ["8275228824","9957602682","13441826130","11035825108","7859394020"])
c(48, "§8.2 B2 Restore calendar integration — the only thing keeping the last paying reviewer from switching to Blocos", "feature",
  "Restore calendar integration — a capability the classic app had and this one removed; the only thing keeping the most recent paying reviewer from switching to Blocos, a competitor gap that closes on its own timeline",
  "removed at relaunch", "churn", "N10 2 (5.26%)", "must-have", "recommendation", "yes",
  ["7780256223","13441826130"])
c(49, "§8.2 B3 Market global schedule shifting as the headline differentiator — absent from the listing", "do",
  "Market global schedule shifting as the headline differentiator — the one capability a user says no competitor matches, absent from the store listing; nine reviewers searched for an alternative and failed and the listing does not tell prospects why they will fail too",
  "moat unmarketed", "praise", "P6 n=1; P1 9 (23.68%)", "do", "recommendation", "yes",
  ["7886496270"])
c(50, "§8.2 B4 Build backward scheduling from a fixed anchor; B6 Position explicitly for time blindness / ADHD", "feature",
  "Build backward scheduling from a fixed anchor (auto-calculate the latest start time for a sequence) — a natural extension of a timeline-first model; and test positioning explicitly for time blindness / ADHD, a specific underserved clinical use case a timeline-first scheduler suits",
  "absent; unpositioned", "praise", "n=1 each", "research", "recommendation", "yes",
  ["8557538403"])
c(51, "§8.3 M1 Retire or reprice the $64.99 lifetime tier", "monetization",
  "Retire or reprice the $64.99 lifetime tier — 3.25 years of the $19.99 annual demanded up front from a developer who has abandoned a paid app once; the tier generates objections and its credibility depends on a promise the release history contradicts",
  "$64.99 lifetime vs $19.99/yr", "complaint", "N5 5 (13.16%) mean 1.60", "undecided", "recommendation", "yes",
  ["9289248731"])
c(52, "§8.3 M2 Offer classic buyers something, even now — a discount, a credit, or a free year; M3 Never break a legacy app you are migrating away from", "product-rule",
  "Offer classic buyers something even now — a discount, a credit or a free year (the reviewer listed three remedies; none done; the omission produced the angriest cluster from the most loyal historical customers); and never break a legacy app you are migrating away from — a paying customer publicly concluded the developer sabotaged a product they owned, and that perception is permanent",
  "no migration offer; classic left broken", "1★-burst", "N4 6 (15.79%) mean 1.17", "product-rule", "recommendation", "yes",
  ["11033875205","9289248731","8776556254","7849996761"])
c(53, "§8.3 M4 Tie subscription pricing to a visible delivery cadence — subscribers believe they are funding development", "product-rule",
  "Tie subscription pricing to a visible delivery cadence — 'If we can get iPad and watch apps along with more regular debugging, I will keep paying'; subscribers here believe they are funding development, and when it stops the subscription has no story",
  "subscription without delivery", "churn", "N6 5 (13.16%); N8 4", "product-rule", "recommendation", "yes",
  ["13441826130"])
c(54, "§8.3 M5 Keep doing personal support — highest return per unit of effort", "do",
  "Keep doing personal support — the single support interaction produced a 5★ and the phrase 'a work of art'; highest return per unit of effort available",
  "personal dev email", "praise", "n=1 → 5★", "do", "recommendation", "yes",
  ["8244932708"])
c(55, "§8.4 Research questions this corpus cannot answer; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5", "data-caveat",
  "Research questions: is the developer still operating (every recommendation is conditional on this); actual free→paid conversion and silent paywall bounce; did the classic app genuinely ship a deliberate crash dialog; how many classic buyers migrated vs churned; would a functional free tier convert better than the hard gate (the 3.63-vs-1.14 gap is the clearest A/B candidate)",
  "n/a", "none", "5 questions", "research", "research questions", "yes",
  ["9289248731"])

with open("Tools/prd_ledger/17/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
