import json, re
R = 4
rep = open("App Store Reports/4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 5 ----
c(69, "Part 5 Audience 1", "audience", "ADHD / neurodivergent / mental-health users (6.96%, mean 4.14) are the highest-affinity segment, already targeted by TikTok ADHD advertising, and describe the app as external executive function — but they are also the MOST sensitive to the two core failures: 'The notifications were too small and quiet'; 'Would have been the perfect app for my adhd… Such a let down'; 'it literally had 10 X my ADHD'",
  "markets to ADHD via TikTok", "mixed", "1,424 (6.96%), mean 4.14", "do", "high-priority", "yes",
  ["9761650498","10234553092","10144485344","11009832175","10603862753","10874402938","13030561157","11737896926","11966341472","12351646655","13546357208","11912129408","13763732961","10093089650","14382272365"],
  side="the audience with the highest affinity has the lowest tolerance for quiet notifications and monetisation friction",
  cond="'I get the impression that it was not done appropriately with a person with ADHD' — targeting an audience without designing for it is noticed")
c(70, "Part 5 Audience 2", "audience", "Students and teenagers — 587 student (2.87%, mean 4.29) + 455 kid/teen (2.22%, mean 4.08) — overwhelmingly positive, structurally unable to pay: 'I am a school student and I don't really have any money'",
  "subscription paywall on a teen/student audience", "praise", "587 + 455", "do", "meaningful", "yes",
  ["11758706305","10355048847","11575208811","10849775714","10431447166"])
c(71, "Part 5 Audience 3", "audience", "Parents managing family routines — 77 reviews (0.38%, mean 4.14) — weak but commercially interesting; the free cap broke exactly this use case ('a free daily app to put my kids chores on')",
  "no family/kids mode; cap blocks multi-kid chore lists", "mixed", "77 (0.38%), mean 4.14", "research", "weak", "yes",
  ["10775929289","11671331301","12949351767","10568183655"])
c(72, "Part 5 Audience 4", "positioning", "General self-improvement adults (the 26.46% organisation theme) risk substitution: 'I could just use Apple Reminders' — 'it is basically a fancy looking reminders list' (16 votes)",
  "checklist that resembles Reminders", "complaint", "6 IDs", "do", "repeated", "yes",
  ["11001127837","10670725080","11045284287","11088318709","11483126752","9893977621"],
  side="a routine app must be visibly more than a reminders list or the paid tier has no justification")

# ---- PART 6 ----
c(73, "Part 6 country table (verbatim)", "market", "All 43 storefronts with ≥50 reviews: n, mean, 1–2★, 5★, trial, charged, refund, scam, paywall, price, nag, quiz, lang, bug, endorse, organ, adhd — full table",
  "n/a", "mixed", table(419, 463), "none", "high-priority", "yes", [])
c(74, "§6.1 market-group table (verbatim)", "market", "Market groups: Anglophone core 13,483 (65.9%, 3.98); high-spend 15,677 (76.6%, 3.95); Latin America 2,446 (12.0%, 3.85, trial 7.2%, charged 7.3%, refund 7.0%); top-6 volume 14,689 (71.8%); sub-50 storefronts 1,147 (5.6%, 4.03)",
  "n/a", "mixed", table(467, 473) + " ; high-spend = US GB CA AU DE FR IT ES NL SE DK NO CH IE NZ FI AT BE SG IL AE SA; review volume is an engagement proxy only", "none", "high-priority", "yes", [])
c(75, "§6.2", "market", "Brazil is a billing emergency, not a review-tone difference: 843 reviews, mean 3.55, 33.8% 1–2★, with unexpected-charge 14.5%, refund 14.8% and trial-deception 13.8% — 7 to 11× the global rate; 41 of 319 confirmed payers (12.9%) on 4.1% of the corpus; 'R$89,90 charged after selecting R$69,90' — the highest-yield single market fix in the corpus",
  "trial provisioning or localised plan screen broken in BR", "1★-burst", "BR n=843, mean 3.55; charged 14.5%, refund 14.8%, trial 13.8%", "must-never-break", "high-priority (in-market)", "yes",
  ["10483361084","10531986957","10806565111","10941969952","10941523544","11005436107","11108259409","10863840021","13949866906","11482610207","10915214872","11021690984","13196254082","13687854445","11340759446","12212305667","10802505019","13149362320","10859158478","12811338830"],
  side="Chile (10.8% trial, 10.8% scam, mean 3.23 — lowest eligible market), Philippines, Vietnam, India, Ukraine show the same shape: a Global-South billing problem systematically worse than the US",
  cond="billing/trial behaviour must be verified per storefront, not just in the US")
c(76, "§6.3", "market", "Canada (mean 3.68, scam accusations 7.5% — 3× the US) and New Zealand (trial-deception 14.4%, the highest of any eligible market) are the Anglophone outliers; multiple NZ reviewers report their Apple accounts blocked by the unpaid charge; 'Predatory scam' (34 votes); 'how are struggling people expected to afford this during a recession'",
  "n/a", "1★-burst", "CA n=948 scam 7.5%; NZ n=118 trial 14.4%", "must-never-break", "meaningful (in-market)", "yes",
  ["10147463845","10217126190","10998909966","10428470955","9827046632","11534199589","14382272365","11757840008","10214812939","11521172768","10859204080","9827545800","10335300190","11487653096","10886918557","11006362767","9896180923","12547182143"])
c(77, "§6.4 France", "market", "France is the paywall-friction market: 17.9% paywall-block rate, highest of any eligible market, yet mean 3.87 and 19.4% strong endorsement — French users like the app and resent the wall",
  "n/a", "complaint", "FR n=464, paywall 17.9%, endorse 19.4%", "research", "meaningful (in-market)", "yes",
  ["12917436383","12009622937","12858504773","13092753937","12175940750"])
c(78, "§6.4 Germany", "market", "Germany is the price market: highest unexpected-charge rate in Europe (4.2%) and 2.4% price complaints — 'Achtung Abofalle' (subscription trap); the clearest pricing advice in the corpus: 'I'd lower the yearly price a bit and show it at the very beginning'",
  "price hidden until after the quiz", "complaint", "DE n=286, charged 4.2%, price 2.4%", "do", "meaningful (in-market)", "yes",
  ["12725840440","10825116155","11981627164","13752329188","12051819932"],
  side="show the price up front — a 5★ user's own recommendation")
c(79, "§6.5 + table", "market", "Localisation is a solved problem in five languages and an open one in six: shipping ES/PT/FR/DE eliminated the complaint in those markets within one year (France 26.4% → 1.9%, Spanish 31.5% → 0.0%, German 15.6% → 0.0%) — the single cleanest cause-and-effect in the dataset; unserved markets are loud: Russian is 51.9% of all Russian reviews and the two most-voted reviews in the entire corpus (180 and 98 votes) are Russian language requests; Turkish 27.8% (2025), Polish 20%, Vietnamese 14.1%, Dutch 11.4%, Arabic 16.0%, plus Japanese, Korean, Indonesian",
  "ships EN/FR/DE/PT/ES; not RU/TR/NL/PL/VI/AR/JA/KO/ID", "blocked-conversion", "454 (2.22%), mean 3.26; " + table(502, 512), "do", "high-priority", "yes",
  ["11898653184","10341079349","11297466959","10215708190","11668948355","13430297128","12537734671","11759403751","10810076621","12166286849","10944912059","10985642638","10864745478","12397000495","10912344506","12208216179"],
  side="non-Latin-script reviews are only 1.69% of the corpus — the under-representation of unserved markets is itself evidence of the gap")
c(80, "§6.6", "data-caveat", "93 storefronts under 50 reviews hold 1,147 (5.6%) at mean 4.03; no standalone claims; quotes flagged [limited evidence]",
  "n/a", "none", "1,147 (5.6%), 4.03", "none", "method", "yes",
  ["13026729877","12874373355","11979793558","13307354054","10294858917"])

with open("Tools/prd_ledger/4/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
