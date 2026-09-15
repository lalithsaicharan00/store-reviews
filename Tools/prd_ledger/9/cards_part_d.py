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


# ---- PART 5 — COUNTRY ----
c(90, "§5.1 The six eligible storefronts table (verbatim)", "market",
  "TR / RU / BR / MX / US / FR side by side: n, mean, 1★, 5★, money, bug and paid shares",
  "n/a", "mixed", table("## 5.1 The six"), "none", "verbatim", "app-specific", [])
c(91, "§5.1 TR — Türkiye (n=471) — the home market and the volume engine table (verbatim)", "market",
  "Türkiye is where the refund crisis lives and also the strongest positive signal: the commercial problem is Turkish, the technical one is not (defect rate 7.6%); Turkish reviewers use the review field as a customer-service channel (one pastes a transaction UUID) and price sensitivity is expressed in lira (₺200, ₺300, ₺350, ₺400 for three months, ₺699.99/yr)",
  "home market", "mixed", "TR 471 (36.77%), mean 3.71; refund 59 of 102 (57.8%); cancel 27 of 34 (79.4%); paid 102 of 226 (45.1%); P-outcome 45, P-org 39, P-motiv 16; " + table("### TR — "), "none", "standalone (n ≥ 50)", "app-specific",
  ["11912344269","12279199321","13036253065","13601192854","13477378855","11946780140","11521594260","11496072461","13565016167","12577004433","12257289655"])
c(92, "§5.1 RU — Russia (n=113) — a market in structural failure table (verbatim)", "market",
  "Russia is a market in structural failure — 56.6% report a defect ('it turns out to be a mass problem') while carrying the highest paid density: Russians buy a product they then cannot run; Russians are also the least tolerant of a long, sales-heavy onboarding",
  "app unreachable, heavy funnel", "1★-burst", "RU 113 (8.82%), written 2.38 vs public 4.65 (+2.27); paid 31.9%; O-long 15 of 35; M-nag 26 of 59; " + table("### RU — "), "must-never-break", "standalone (n ≥ 50)", "app-specific",
  ["14137219709","12390854923","12391307827","12769176601","13142125739","13511607324","13523804710","13527113749","13588434539","13383801339","13445786577","13438625866","13909300706"])
c(93, "§5.1 RU — B-vpn and M-payfail point to sanction/payment-rail complications", "market",
  "Russia's payment rails and reachability are sanction-bound: 'my country is under sanctions, and purchases are impossible'; a request for QR/SBP payment inside the app; 'Why place an app in the Russian store that doesn't work without a VPN?'",
  "App Store billing only; unreachable without VPN", "blocked-conversion", "B-vpn 6 (all RU, 5.3%); M-payfail 6 RU", "research", "standalone (n ≥ 50)", "app-specific",
  ["12885713029","12868940633","12574094311"])
c(94, "§5.1 BR — Brazil (n=104) — the healthiest large market table (verbatim)", "market",
  "Brazil is the healthiest large market — negatives at roughly half the global intensity — and the strongest ADHD constituency relative to size ('Best app for ADHD')",
  "n/a", "praise", "BR 104 (8.12%), mean 4.02, 68.3% 5★, defects 8.7%, money 21.2%; ADHD 4 of 17; " + table("### BR — "), "none", "standalone (n ≥ 50)", "app-specific",
  ["11487094036","11629856310","13437517000"])
c(95, "§5.1 BR — X-copycat compare Dear Me to Me+ Daily Planner", "positioning",
  "Users compare Dear Me to Me+ Daily Planner (report 4) — one prefers Me+ but keeps Dear Me as a second option 'because it has more free things'",
  "similar routine planner", "mixed", "X-copycat 2 (both BR)", "none", "weak", "yes",
  ["11423187788","12153938882"])
c(96, "§5.1 MX — Mexico (n=74) — the best-rated eligible market table (verbatim); Part 7 §7.1 #6", "market",
  "Mexico is the clearest 'organisation works' market and the only one with a currency-clarity problem: users ask whether the displayed price is dollars or pesos, and the ambiguity 'makes me suspect a scam' — display currency explicitly in every storefront",
  "ambiguous currency display", "complaint", "MX 74 (5.78%), mean 4.09, defects 4.1%; P-org 20.3% (highest single-theme rate of any eligible country); M-unclear 4 (5.4%); " + table("### MX — "), "must-never-break", "standalone (n ≥ 50)", "app-specific",
  ["12785281626","11661389308","12316153273","12885327706"])
c(97, "§5.1 MX — inclusive Spanish drew explicit objections [limited evidence]", "market",
  "Inclusive Spanish ('todes', 'nosotres', 'perfectE') drew explicit objections from two otherwise-positive Mexican reviewers",
  "inclusive-language Spanish copy", "complaint", "O-inclusive 2 (2.7% of MX) [limited evidence]", "research", "limited evidence", "app-specific",
  ["13005363984","13193031233"])
c(98, "§5.1 US — United States (n=59) — the value-scrutiny market table (verbatim)", "market",
  "The US is the value-scrutiny market: reviewers name dollar amounts and do the value calculation out loud ('$17 a month or $60 a year' for 'literally nothing more than a to do list'); both trial-trap cases are US; and it produced the corpus's most detailed review — a full UX audit (navigation, 'Get Rid of Cellulite' filed next to 'Abusive Relationships', shallow ADHD content, undocumented free/paid split, ToS trial disclaimer, sign-up review prompt) that the product team should read in full",
  "n/a", "complaint", "US 59 (4.61%), mean 3.75, money 35.6%; " + table("### US — "), "none", "standalone (n ≥ 50)", "app-specific",
  ["13316643309","12209118679","11583765638","13966657008","11552283550","13245012766","13021325704"])
c(99, "§5.1 FR — France (n=50) — the worst-performing eligible market table (verbatim)", "market",
  "France is the worst eligible market because three problems compound — the Nov–Dec 2024 onboarding freeze ('je continue à tergiverser' screen), the highest paid-routine gating ('the proposed routines are all paid'), and billing incidents — plus the only consumer-rights framing (droit de rétractation); when it lands, praise is strong ('I've been looking for one like this for 40 years')",
  "n/a", "1★-burst", "FR 50 (3.90%), mean 2.64, 42.0% 1★, money 48.0% (highest); " + table("### FR — "), "none", "standalone (n ≥ 50)", "app-specific",
  ["11965618346","11982010915","11986632519","11989133850","12620617170","12221358308","11777093103","12190059793","13065540266","12081200617","11854126799","12145044555","13099009549"])
c(100, "§5.2 High-spend markets (defined group) table (verbatim)", "market",
  "The high-spend group (US, JP, GB, DE, FR, CA, AU — external convention, not derived from the corpus) rates Dear Me half a star lower than everyone else, praises it less, and complains more about money and defects; distinctive themes are price, thin product, wall, no trial, nag, regret, confusion, misleading ads, one-time guidance",
  "n/a", "complaint", table("## 5.2 High-spend"), "none", "verbatim", "app-specific", [])
c(101, "§5.2 Three conclusions — trial demand loudest where willingness to pay is highest; the German market is the clearest case of a recoverable loss", "market",
  "Trial demand is loudest exactly where willingness to pay is highest, and Germany is the clearest recoverable loss: German negatives are almost entirely 'great concept, no trial, too many pop-ups' rather than 'bad product', and Germans write the corpus's longest constructive feature lists",
  "no trial; heavy upsell", "blocked-conversion", "M-notrial high-spend 7.2% vs 4.06% global; DE n=37 [limited evidence] mean 2.76: M-notrial 6, M-nag 6, G-guide 4, G-noedit 4", "do", "limited evidence (DE)", "yes",
  ["11854298993","12291766651","12683497729","12190313843","12311267967","12636034921","12464161947","12699837651","12364035523"])
c(102, "§5.3 High-review-volume storefronts (defined group) table (verbatim)", "market",
  "The high-volume group carries the corpus but splits almost perfectly by outcome — BR + MX (178 reviews, mean 4.05) vs RU + FR (163 reviews, mean 2.46) — and the difference is defect load and funnel tolerance, not language or price (review volume is not a downloads or revenue proxy)",
  "n/a", "mixed", table("## 5.3 High-review") + " ; carries 88 of 102 refunds, 79 of 123 price, 60 of 66 loading, 178 of 226 paid", "none", "verbatim", "app-specific", [])
c(103, "§5.4 Sub-50 storefronts — limited-evidence notes table (verbatim)", "market",
  "Sub-50 notes [limited evidence]: IL ₪200 and Hebrew quality; SA the alarm market with a storefront-dependent trial; ES an outsized won't-open cluster (5 of 26); JP all IME defects; CL highest scam rate; CO highest-rated with no defects; IN pays ₹649 then stuck loading; ID the best feature-request review; CH 1.25 ('A trap!'); BY all 1★; GB warmest ADHD testimonials plus streaks lost in a Jan 2026 update",
  "n/a", "mixed", table("## 5.4 Sub-50"), "none", "limited evidence", "app-specific",
  ["11890679534","12513379051","11690398268","12479597871","11836191831","12400853104","12566381104","13028589549","13468042404","12289082436","12959504851","12960927081","11668735422","12272862926","11825830145","13546243872","13550392481","13572792664","13580713380"])
c(104, "§5.5 What does not vary by country", "insight",
  "What does not vary by country: praise content is universal (organise and life change top in TR, BR, MX, US, CO, ES, IL — the value proposition translates), 'just a checklist' appears everywhere (not a cultural response), and nobody anywhere asks for data export",
  "n/a", "mixed", "G-thin TR 7.9%, US 13.6%, BR 6.7%, RU 7.1%, MX 6.8%, FR 8.0%; export 0", "none", "observed", "yes", [])
c(105, "§5.6 What varies sharply by country table (verbatim)", "market",
  "What varies sharply: refund friction (TR, RU), loading failure (RU, ES, IN), onboarding-length intolerance (RU, IN), upsell intolerance (RU, DE, TR), trial demand (DE, SA, TR, RU), currency confusion (MX), text-input/RTL/translation defects (JP, IL, RU)",
  "n/a", "mixed", table("## 5.6 What varies"), "none", "verbatim", "app-specific", [])

with open("Tools/prd_ledger/9/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
