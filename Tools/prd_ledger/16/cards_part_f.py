import json, re
R = 16
rep = open("App Store Reports/16. Atoms - from Atomic Habits - The official Atomic Habits app (REPORT).md").read().split("\n")
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

# ---- PART 6 ----
c(51, "§6.1 The four eligible storefronts table (verbatim); Signal labels applied at country level table (verbatim)", "market",
  "The four eligible storefronts compared on 18 themes, with country-level signal labels",
  "n/a", "mixed", table("## 6.1 The four eligible storefronts") + " ;; " + table("### Signal labels applied at country level"), "none", "verbatim", "app-specific", [])
c(52, "§6.1 US — the least price-hostile eligible market; friction is feature-shaped as much as price-shaped", "market",
  "US is the biggest and least price-hostile eligible market — highest 5★, highest Mindset praise, the only market with a meaningful confirmed-payer population, and the source of nearly every back-logging, dark-mode and habit-model request; its friction is feature-shaped as much as price-shaped, though 68 of the 153 price-driven 1★ are American",
  "n/a", "mixed", "US 542: mean 3.71, 5★ 55.0%, price 27.68% vs GB 49.5% / CA 50.7%, Mindset 6.83%, payers 11 of 17", "research", "eligible", "app-specific", [])
c(53, "§6.1 GB — the worst eligible market; British reviewers like the app more and buy it less than anyone", "market",
  "GB is the worst eligible market — lowest mean, highest 1–2★, lowest 5★ — and simultaneously the market with the highest design praise anywhere: British reviewers like the app more and buy it less than anyone; the GBP launch price was the harshest reported (£17.99/month, £215/year billed monthly) and GB reviewers quote it more precisely than any other market",
  "£17.99/mo launch price", "1★-burst", "GB 103: mean 3.20, 1–2★ 42.7%, 5★ 37.9%, design praise 25.24%, price 49.51%", "research", "eligible", "app-specific",
  ["10985301089","10983462054","10984285648","10984727994","10988031483","10995055502","11013822277","11043323186","11051827720"])
c(54, "§6.1 CA — the moral-objection market; the two most-voted reviews in the corpus are Canadian", "market",
  "Canada is the moral-objection market: highest price-objection and cash-grab rates (2.5× global), highest lifetime-purchase and cheaper-tier demand, highest bait-and-switch, lowest design praise — Canadians are least likely to soften criticism with a compliment; the two most-voted reviews in the corpus are Canadian (a structured three-point business critique; 'Don't get Pro… Buy the Atomic Habits book and use the free version alongside it'); zero confirmed payers in 73 reviews",
  "n/a", "1★-burst", "CA 73: price 50.68%, cash-grab 15.07%, one-time 6.85%, cheaper tier 9.59%, bait-and-switch 6.85%, design praise 8.22%, payers 0", "research", "eligible", "app-specific",
  ["10979802836","10978295534"])
c(55, "§6.1 AU — the brand-damage market; Australians did not negotiate, they left", "market",
  "Australia is the brand-damage market: highest simplicity praise and a healthy 5★ share, but the highest brand-betrayal rate anywhere (HIGH-PRIORITY at country level, including 'How to ruin your brand overnight'); A$200/year is the highest annual figure in any currency; zero cheaper-tier requests — Australians did not negotiate, they left",
  "A$200/yr launch price", "churn", "AU 52: simplicity 26.92%, 5★ 51.9%, brand betrayal 5.77% (3 of 16 global), cheaper-tier 0.00%", "research", "eligible", "app-specific",
  ["11044837304","11002040769","10983653724","10990130470"])
c(56, "§6.2 High-spend markets table (verbatim); the price backlash is stronger in high-spend markets — a value-comparison effect; rest of world's complaint is language", "market",
  "Three findings, the first counter-intuitive: the price backlash is STRONGER in high-spend markets — not affordability but value comparison (high-spend reviewers price Atoms against Netflix, Spotify, Notion, Procreate and Streaks by name and say 'not worth it at any price'; lower-spend markets say 'too expensive for my country'); the rest of the world's complaint is language (8.8× the localisation rate); buyers are 3× concentrated in high-spend markets (directional only)",
  "n/a", "mixed", table("## 6.2 High-spend markets"), "product-rule", "group (labelled assumption)", "yes", [])
c(57, "§6.3 High-review-volume storefronts table (verbatim); the localisation gap is a market-access problem; the book is in ~60 languages, the app in one", "market",
  "The 66 small storefronts rate Atoms 0.22 stars higher, complain about price less, and are the overwhelming majority of the language problem: all 36 localisation requests — Spanish 14, Turkish 4 (a Turkish 5★ that is only a request for Turkish is the 5th most-voted review), Russian 3, French 3, German 2, plus singles; a Spanish user uninstalled over it; the book is published in ~60 languages and the app in one — the single widest gap between brand reach and product reach in the corpus",
  "English only", "blocked-conversion", "top-10 923 (79.0%) vs other 66 245; " + table("## 6.3 High-review-volume storefronts") + " ; localisation 36 (3.08%)", "build-free", "very strong", "yes",
  ["10983171894","11292115448","12184498108","13352260332","10984029494","12668682597","13399884794","14276815734"])
c(58, "§6.4 Sub-50 storefronts — limited-evidence notes: DE worst-rated of any size; FR/NL/CH/PL/TR price-dominated; PH/SE/BR/CO/NZ purely positive; CN login broken; IN UPI failure", "market",
  "Sub-50 notes [limited evidence]: Germany is the worst-rated storefront of any size ('nothing more than an alarm clock providing statistics on how often it rings… does not justify a price higher than a full-fledged office suite'; store rating 4.59, lowest of the large markets); FR/NL/CH/PL/TR all price-dominated, Poland zero 5★; PH/SE/BR/CO/NZ almost purely positive with zero 1–2★; China: 2 of 3 reviews are storefront-specific sign-up failures (verification code rejected); India just under threshold with the only failed-purchase report (UPI) and 3 regional-pricing objections",
  "CN sign-up broken; €20/mo in DE", "mixed", "DE 39: mean 2.92, 1–2★ 46.2%, 5★ 17.9%, 14 quote €20/mo or €129/yr; PL 9 mean 2.56, 0 5★; CN 3; IN 41 mean 3.90", "research", "limited evidence", "app-specific",
  ["10985727014","11755036634","12630024377","11261255351"])

with open("Tools/prd_ledger/16/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
