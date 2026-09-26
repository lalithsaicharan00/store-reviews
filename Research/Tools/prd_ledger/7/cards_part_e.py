import json, re
R = 7
rep = open("App Store Reports/7. Habit Tracker - HabitKit - Streaks & Accountability (REPORT).md").read().split("\n")
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


# ---- PART 6 — REQUESTS ----
c(103, "Part 6 WHAT THE FEATURE REQUESTS ACTUALLY SAY table (verbatim)", "data-caveat",
  "Feature requests ranked by volume × rating headroom: sync, raise the cap, one free widget, iPad layout, Watch, findable weekly goals, day notes, colours, sub-habits, multi-habit widget, quit mode, integrations, extra reminders, day boundary, hide completed, API, Family Sharing, accountability partner",
  "n/a", "mixed", table("# PART 6"), "none", "verbatim", "app-specific",
  ["12622891075","14470496356","12139974588","13650913780","12934585259","12108952662","9901846846"])
c(104, "Part 6 #10 Multi-habit widget; Part 4 #16", "feature",
  "Multi-habit widget shipped in 1.15, yet 4 requests are dated 2026 — a discoverability check is needed",
  "shipped 1.15 (Pro)", "complaint", "Wants multi-habit widget 11 (1.25%, MEANINGFUL), mean 4.09, 9.1% 1–2★; 4 requests dated 2026", "must-have", "meaningful", "yes", [])

# ---- PART 7 — COUNTRY ----
c(105, "§7.1 The four eligible storefronts (≥50 reviews) table (verbatim)", "market",
  "US / DE / GB / CA side by side: n, mean, 5★, 1–2★, praise, payers, sync, subscription, price, cap, paywall, churn",
  "n/a", "mixed", table("## 7.1 The four eligible", 0), "none", "verbatim", "app-specific", [])
c(106, "§7.1 Signal labels applied at country level table (verbatim)", "market",
  "Country-level signal labels (each country's own n): CA carries a HIGH-PRIORITY signal on four separate money themes — the only eligible storefront that does",
  "n/a", "complaint", table("### Signal labels applied"), "none", "verbatim", "app-specific", [])
c(107, "§7.1 US (n=211)", "market",
  "US is the biggest and most engaged market and its friction is feature-shaped, not price-shaped: highest payer density, highest sync demand, highest 'tried many apps' rate, the longest feature-specific reviews and nearly all automation praise — sync 19, iPad/Mac 11, only 3 habit-cap complaints",
  "n/a", "mixed", "US 211: payers 13.3%, sync 9.0%, tried-many 19.4%, cap 1.4%, mean 4.61", "research", "standalone (n ≥ 50)", "app-specific", [])
c(108, "§7.1 DE (n=107)", "market",
  "Germany is the best-rated and most product-loyal eligible market and also where the price argument is loudest and most concrete: Germans do not object to paying, they object to €35 for what they read as a utility — all three €35 lifetime reports, and the only reviewer who names a competitor's price and switches, are German",
  "€35 lifetime", "mixed", "DE 107: mean 4.69, 1.9% 1–2★, simplicity 46.7%, subscription objection 9.3%, price objection 3.7%", "research", "standalone (n ≥ 50)", "app-specific",
  ["11818567731","11942193233","11994502139","14093446153"])
c(109, "§7.1 GB (n=89)", "market",
  "GB is the healthiest storefront — zero habit-cap complaints, lowest sync demand, highest life-change rate, peak design praise — and its only negatives are recent: both Aug-2026 redesign complaints are British payers",
  "n/a", "praise", "GB 89: 80.9% 5★, cap 0.0%, sync 3.4%, life change 7.9%, design 46.1%", "none", "standalone (n ≥ 50)", "app-specific",
  ["14447636722","14452015607"])
c(110, "§7.1 CA (n=56) — the problem market; Part 9 #8", "market",
  "Canada is the problem market — lowest mean, highest 1–2★, cap, paywall, price-objection and churn rates — while having the highest developer-praise rate and a high payer rate: Canadians love the maker and resent the price; CA$40 for a US$30 SKU is a ~33% premium, and CA is the only eligible market where price complaints outnumber sync complaints — a CA-specific pricing review is warranted",
  "CA$40 lifetime (~33% over US$30)", "complaint",
  "CA 56: mean 4.50, 1–2★ 8.9%, cap 7.1%, paywall 7.1%, price 5.4%, churn 3.6%, developer praise 23.2%, payers 12.5%; four HIGH money signals", "do", "standalone (n ≥ 50)", "yes",
  ["12076054585","11530931211","12224917759","13645021715","11816451066","11860513242"],
  cond="exchange-rate-driven tier pricing can overshoot in one storefront")
c(111, "§7.2 High-spend markets table (verbatim)", "market",
  "High-spend group (US, JP, GB, DE, CN, KR, CA, FR, AU — a labelled assumption, not verified against a spend dataset) vs rest of world",
  "n/a", "mixed", table("## 7.2 High-spend markets"), "none", "verbatim", "app-specific", [])
c(112, "§7.2 finding 1 — the free cap does nearly twice as much damage outside high-spend markets; Part 9 #8", "market",
  "The free cap does nearly twice as much damage outside high-spend markets — MA, DZ, VN, ID, PT, MX, AR, TR, IT, PL, where $30 lifetime is a materially larger sum: 'People on developer countries could really use a plan that does not cost their minimum income' — consider regional lifetime pricing, or lead with the $12/year SKU in price-sensitive storefronts",
  "one global price ladder", "complaint", "cap complaints rest-of-world 4.2% vs high-spend 2.3%; 1–2★ 9.8% vs 4.8%", "do", "meaningful", "yes",
  ["12090297861"])
c(113, "§7.3 High-review-volume storefronts table (verbatim)", "market",
  "The long tail is not a rounding error: the 60 small storefronts are 30% of the corpus, rate ~0.13 stars lower and complain about the cap almost twice as often — the majority of the cap problem (review volume is a disclosed proxy, not downloads or revenue)",
  "n/a", "complaint", "top-10 US 211, DE 107, GB 89, CA 56, FR 30, BR 29, IN 28, PL 27, AU 20, TR 20 = 617 (70.0%); " + table("## 7.3 High-review-volume"), "none", "verbatim", "app-specific", [])
c(114, "§7.4 Sub-50 storefronts — limited-evidence notes", "market",
  "Sub-50 notes [limited evidence]: FR (n=30) 86.7% 5★ but both 1★s are paywall/usability and the 2★ is the weekly-goal misunderstanding; BR (n=29) has the biggest store-vs-written gap of any storefront (4.882 vs 4.41), 4 of the 54 sync requests and one entitlement failure; CN unserved",
  "n/a", "mixed", "66 storefronts < 50 hold 419 reviews (47.5%); FR 30; BR 29; CN 4", "none", "limited evidence", "app-specific",
  ["10100430683","12091523105","13187090517","13430341774"])

# ---- PART 8 — OVER TIME ----
c(115, "§8.1 Method", "data-caveat",
  "Time method: four comparable cohorts (P1 launch–Dec 2023 n=142, P2 2024 n=234, P3 2025 n=308, P4 Jan–Sep 2026 n=198); no app-version field so release attributions come from the public changelog and reviewers' dated statements; two January spikes (Jan 2025 n=71, Jan 2026 n=36) from New Year resolution seasonality; Sep 2026 partial (6 reviews)",
  "n/a", "none", "P1 142 · P2 234 · P3 308 · P4 198; Jan 2025 71; Jan 2026 36; Sep 2026 6", "none", "method", "yes", [],
  side="New Year produces the biggest review (and likely install) spikes in the category")
c(116, "§8.2 Themes that genuinely improved — interactive widgets", "timeline",
  "Interactive widgets are a clean closed loop: requests to tick a habit from the widget ran Dec 2023 → Jun 2024 then stopped dead once changelog 1.7 'Tappable widgets' shipped — 'Finally added interactivity with the widgets'; 'Since the update the widget works as it should and that makes this the best habit tracker I found'; a reviewer edited his review up to 5★; zero requests after Oct 2025 — proof the team can close a loop",
  "shipped tappable widgets (1.7), Jun 2024", "praise", "widget praise 7.04% (P1) → 14.10% (P2) → 9.09% (P3) → 6.57% (P4); 8 requests Dec 2023–Jun 2024, 0 after Oct 2025", "build-free", "observed", "yes",
  ["10685338852","10690084425","10786717280","10809321944","10854549103","10899303798","11309161661","11426923525","11393534582","11434680073"])
c(117, "§8.3 Themes that worsened or emerged table (verbatim)", "timeline",
  "Worsened / emerged by cohort: 1★ rate, subscription objection, explicit payers, paid-but-broken, redesign, quit requests, price objection, simplicity praise, design praise",
  "n/a", "mixed", table("## 8.3 Themes that worsened"), "none", "verbatim", "app-specific", [])
c(118, "§8.3 The simplicity story is fading; Part 9 #16", "timeline",
  "The simplicity story is fading — the classic feature-creep signature: named by 41.5% of reviewers in 2022–24 and 29.3% in 2026, across the period in which categories, day notes, quit habits, custom values, three view modes and a redesign all shipped; reviewers are already policing it — 'Please, don't clutter it with pointless features and distracting buttons… It's a finished product. And for those who want more of everything — just make them a separate version'; 'Please keep it simple as it is right now'",
  "shipped categories, notes, quit habits, custom values, 3 view modes, redesign", "complaint",
  "simplicity praise 41.55% → 41.45% → 39.61% → 29.29% (−12 points); design praise 47.89% → 30.77% → 34.09% → 30.30%", "product-rule", "high-priority theme in decline", "yes",
  ["13860278748","14193781102","10915115990","12166781464"])
c(119, "Part 9 #16 Protect the simplicity. Ship complexity behind opt-in.", "product-rule",
  "Protect the simplicity: every new mode (sub-habits, integrations, AI) should be invisible by default and opt-in — reviewers said this in advance, repeatedly and unprompted",
  "features shipped visible by default", "complaint", "simplicity praise −12 points", "product-rule", "recommendation", "yes", ["13860278748"], cond="evidence: R07-118")
c(120, "§8.4 The persistent four — unfixed across the entire life of the app table (verbatim)", "timeline",
  "The persistent four — no sync (3y 4m, 54), 4-habit cap (3y 7m, 27), widgets behind paywall (2y 5m, 13), weekly-goal discoverability (3y, 17) — all still producing reviews in the last 60 days of the corpus",
  "none fixed", "complaint", table("## 8.4 The persistent four"), "none", "verbatim", "app-specific",
  ["9806367856","14378210199","9589360229","14463193980","10771302089","14093446153","10266075296","14489689059"])

with open("Tools/prd_ledger/7/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
