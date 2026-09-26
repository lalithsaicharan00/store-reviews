import json, re
R = 13
rep = open("App Store Reports/13. Productive - Habit Tracker - Daily Routine & Goals Planner (REPORT).md").read().split("\n")
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
c(55, "§6.1 Eligibility and method; §6.2 All 42 eligible storefronts table (verbatim)", "market",
  "42 of 115 storefronts have ≥50 reviews; 73 storefronts hold 813 reviews (4.10%); per-storefront n, mean, 1★%, 5★%, paid-evidence%; theme rates compared within a language only, cross-country leads with rating distribution and paid-evidence share",
  "n/a", "mixed", table("## 6.2 All 42 eligible storefronts"), "none", "verbatim", "app-specific", [])
c(56, "§6.3 Group A — high-review-volume markets table (verbatim)", "market",
  "Top-8 review-volume storefronts (71.94% of corpus): US healthy (complaints about model and price, not conduct); China a billing-dispute corpus; UK and Australia mirror the US; Canada price-sensitive (sub-objection 11.6% vs US 8.5%); Brazil 'not free' complaint 11.1% (5.8× global); Korea a refund/cancellation corpus; Germany the strongest anti-subscription stance (16.7%)",
  "n/a", "mixed", table("## 6.3 Group A") + " ; 14,281 reviews (71.94%)", "research", "group", "app-specific", [])
c(57, "§6.4 Group B — high-spend markets table (verbatim); the defining insight: the correlation runs through conduct, not price tolerance", "market",
  "The storefronts where money is discussed most are the two with the worst ratings, and the correlation runs through conduct not price tolerance: in the US 6.5% discuss a transaction and the mean is 3.88; in China 36.1% and 1.84 — 51.1% of all involuntary-charge reviews in the corpus come from China",
  "n/a", "1★-burst", table("## 6.4 Group B") + " ; CN 437 of 856 involuntary (51.1%)", "product-rule", "group", "app-specific", [])
c(58, "§6.5 China — the corpus's worst market; a specific, dated acquisition problem — Douyin advertising; mechanism: password-free payment", "market",
  "China is the worst market and it is a marketing-and-billing failure, not product-market fit: a Douyin (TikTok China) paid-acquisition campaign from mid-2019 drove high-intent installs into a trial that opened an annual ¥208 subscription, in a payment environment (password-free payment, 免密支付, WeChat balance) with no friction to catch the mistake — 'everyone who sees this on Douyin, don't click through'; '¥200+ after the 7-day trial… In the US it's three meals' money; in China it's about 14 meals'; the counterfactual: a Douyin user who liked the app and planned to buy gave 5★",
  "Douyin ads → trial → ¥208/yr auto-charge with no auth step", "1★-burst", "CN 1,337 mean 1.84; 73.3% 1★, 14.7% 5★; auto-charge 42.6% (7.7× global); paid-evidence 36.1%; monthly spikes 2019-07 (99), 2020-02 (134), 2020-05 (112), 2020-03 (82); ¥208 cited 43× (2019), 54× (2020)", "dont", "high-priority", "app-specific",
  ["6028565692","5901610531","5525308783","5921822925","5972284336","5906879974","6437141830","7235327975","5682690700","5637324239","5959939024","5789787004","5494092368","5307809011","4538118097","3163329581","2266470444","3237593845","4596135051"])
c(59, "§6.6 South Korea — n = 571; Korea's problem is almost entirely cancellation discoverability", "market",
  "Korea is a refund/cancellation corpus following a near-template: downloaded, deleted the same day, charged a full year later, cannot locate the subscription in Apple's settings, requesting cancellation and refund in the review itself; two Korean reviewers wrote public how-to-cancel instructions for other users — a strong signal the in-app path did not exist; an in-app 'Manage subscription' link and a pre-charge reminder email would address roughly a quarter of all Korean reviews",
  "no in-app cancel path; no pre-charge reminder", "1★-burst", "KR 571 mean 2.84; 42.4% 1★, 31.3% 5★; refund 24.7% (9.4× global); cannot cancel 24.7% (10.9×); paid-evidence 34.7%; ₩22,000–38,000/yr", "must-have", "high-priority", "yes",
  ["2502496417","3358473617","3401042634","3188103086","4544409043","3153827976","3155492207","2697826231","3126692841","3220644612","3366758790","3407642979","4549292785","4599438088","4594513464","3370259939","3069605383"])
c(60, "§6.7 Localisation — the clearest country-specific product gap table (verbatim); Arabic is the single largest unserved language", "market",
  "Localisation is the clearest country-specific gap and Arabic is the single largest unserved language: one in five Saudi reviews asks for it, with requests from Oman, Morocco, UAE, Kuwait, Qatar, Bahrain, Jordan; also Taiwan, Turkey, Brazil, Russia; as a share the request keeps rising to 2.9% in 2026",
  "Arabic absent", "blocked-conversion", "U-localization 164 (0.83%); " + table("## 6.7 Localisation") + " ; 5 (2015) → 29–30/yr (2019–20); 2.9% (2026, n=68)", "build-free", "emerging globally, high-priority in SA", "yes",
  ["8272266849","9376522201","10247463002","10494385578","10912704838","10219606844","9560705598","11656689372"])
c(61, "§6.7 Two distinct localisation defects: wrong language served; advertised languages that do not exist", "must-never-break",
  "Two localisation defects: the wrong language served ('I am from Turkey but this app language is Korean. I can't turn it into Turkish or English' — 41 net votes, the 5th most-upvoted review; a Czech user served Italian, Ukrainians served Russian) and advertised languages that do not exist ('Fake Czech — it's not in Czech at all, as shown in the photos and description')",
  "locale detection wrong; listing claims unshipped languages", "1★-burst", "4 wrong-language IDs; 1 fake-language ID (2025)", "must-never-break", "weak volume, high visibility", "yes",
  ["1789316870","3343174115","8800823899","6475424640","12911930158"])
c(62, "§6.8 What does not vary by country — core product praise is universal; every market difference traces to commerce, payments, or language", "insight",
  "Core product praise is universal — utility and simplicity appear at similar rates in every Latin-script storefront, and the highest-rated storefronts are simply the ones with the fewest billing complaints; there is no evidence the product concept fails in any market — every market difference traces to commerce, payments or language",
  "n/a", "praise", "SG 4.29, ID 4.11, NO 3.97, NZ 3.93 — fewest billing complaints", "product-rule", "stable", "yes", [])
c(63, "§6.9 Sub-50 storefronts [limited evidence] — Arabic demand beyond Saudi; Portugal and Ireland pattern with Brazil and UK", "market",
  "Sub-50 storefronts: Arabic-language demand extends past Saudi Arabia (Oman, Morocco, Kuwait, Qatar, Bahrain, Jordan); Portugal and Ireland sit just under threshold and pattern with Brazil and the UK",
  "n/a", "blocked-conversion", "73 storefronts, 813 reviews (4.10%); OM 10, MA 4, KW 12, QA 7, BH 6, JO 6; PT 48, IE 48", "research", "limited evidence", "app-specific", [])

with open("Tools/prd_ledger/13/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
