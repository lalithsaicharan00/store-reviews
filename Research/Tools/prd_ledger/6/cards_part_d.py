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


# ---- PART 5 — AUDIENCE ----
c(60, "Part 5 WHO ACTUALLY USES THIS table (verbatim)", "data-caveat",
  "Use cases in the text are narrower than the listing implies: quitting a bad habit 4, general goals 3, fitness 2, hygiene 2 (teeth-brushing 2×/day), creative practice 1 (writing a first draft)",
  "n/a", "praise", table("# PART 5"), "none", "verbatim", "app-specific",
  ["13837160367","13891333657","14311507310","14349062008","13845360166","13672386764","14468692280","14471219702","14389534229","13093308789","13795256017","14093501015"])
c(61, "Part 5 habit-breaking over-represented; All four abstinence reviewers rated 5★", "audience",
  "Habit-breaking (abstinence streaks) is over-represented relative to habit-building and produces the strongest emotional reviews: all four abstinence reviewers rated 5★ — the segment the product fits best and the one Streak Counter mode was built for",
  "Streak Counter mode (auto-increment unless reset)", "praise", "4 abstinence reviewers, 4 × 5★", "do", "small n, unanimous", "yes",
  ["13837160367","13891333657","14311507310","14349062008"],
  side="abstinence users often track several streaks at once, so they are the segment least served by the 2-streak cap")
c(62, "Part 5 Safety-adjacent, and it needs a decision; Part 9 #14", "audience",
  "The app is being used as a self-harm recovery aid — 'This app helped me get over my self harm and I am forever grateful' — on a 12+ app with no visible crisis-resource surface; decide deliberately whether a broken self-harm or substance streak shows supportive copy and a resource link instead of the current neutral reset — right now the decision has been made by default",
  "neutral reset, no resource link", "praise", "1 (2.27%), 5★, US; recorded not as a trend", "do", "safety-adjacent", "yes",
  ["14349062008","13837160367","14311507310"])
c(63, "Part 5 Recommendation: do not build for these communities", "dont",
  "Do not build for the NoFap / semen-retention communities that already use the app — they come with their own community norms",
  "used by those communities unprompted", "praise", "2 reviews (stopping masturbation; semen retention), both 5★", "dont", "recommendation", "yes",
  ["13837160367","14311507310"])

# ---- PART 6 — REQUESTS ----
c(64, "Part 6 WHAT THE FEATURE REQUESTS ACTUALLY SAY table (verbatim)", "data-caveat",
  "Only five reviews (11.36%) contain an actionable request: optional manual check-in, check-off list + accountability, multiple logs per day, log when goal accomplished, more customization",
  "n/a", "mixed", "5 (11.36%); " + table("# PART 6"), "none", "verbatim", "app-specific",
  ["13085620460","13628759209","13390634274","14471219702","13557096013"])
c(65, "Part 6 feature request — optional manual check-in alongside counter mode", "feature",
  "Optional manual check-in alongside counter mode is requested as a future feature ('that could be something to add in the future') by a 5★ user sitting in counter mode — it already ships",
  "ships (Streak Tracker mode) but invisible", "praise", "1 (2.27%), 5★", "must-have", "discovery failure", "yes",
  ["13085620460","14292633754"])

# ---- PART 7 — COUNTRY ----
c(66, "§7.1 No storefront qualifies for standalone analysis table (verbatim)", "market",
  "Per-storefront table — every row [limited evidence]; largest storefront US at 23; all 44 counted in every global number",
  "n/a", "mixed", table("## 7.1 No storefront qualifies"), "none", "verbatim, limited evidence", "app-specific", [])
c(67, "§7.1 The only observation strong enough to record", "market",
  "English-speaking storefronts carry the monetization anger: US + CA + GB = 32 reviews (72.7%) at mean 3.88 hold 13 of the 16 negative-monetization reviews (81.3%), while the 10 non-English-storefront reviews average 4.10 and contribute 3 — fragile, possibly just that English speakers write more and longer, and not evidence that non-English markets accept the pricing (UA and NO both object to price)",
  "same pricing everywhere", "complaint", "US+CA+GB 32 (72.7%), mean 3.88, 13/16 neg-monetization (81.3%); non-English 10, mean 4.10, 3/16", "research", "limited evidence", "unknown",
  ["14307898374","14491149862"])
c(68, "§7.2 High-spend markets — [limited evidence, cannot be assessed]", "contradiction",
  "Monetization complaints come from the highest-willingness-to-pay markets, not from price-sensitive ones — the opposite of the usual pattern — which reinforces that the problem is packaging clarity, not the price point itself",
  "n/a", "complaint", "35 reviews across US/GB/CA/AU/FR (79.5% high-spend); zero JP or DE", "product-rule", "limited evidence", "yes", [],
  cond="contrast reports 3–5, where price complaints came from IN/TR/UA/BR/MX/SA and regional pricing was the fix; no spend or download data — storefront review volume is a disclosed engagement proxy, never downloads")
c(69, "§7.3 High-review-volume markets", "market",
  "The US is the only high-volume storefront and the worst-rated one with more than two reviews: 3.96 written vs 4.10 for all non-US and vs its own 4.65 tap rating; every billing complaint and 4 of 7 cap complaints are US",
  "n/a", "complaint", "US 23 of 44 (52.27%); 3.96 vs 4.10 non-US; tap 4.65; 2/2 billing, 4/7 cap", "none", "limited evidence", "app-specific",
  ["13771926913","13939159292"])
c(70, "§7.4 Small-storefront caveat", "data-caveat",
  "Nine storefronts have one review each (FR and IN two): a single review moves those means by up to 4 full stars — NG at 1.00 and NO at 1.00 are single reviewers, not markets, given no standalone weight",
  "n/a", "none", "AU, BR, IL, TR, CZ, UA, NG, NO at n = 1; FR, IN at n = 2", "none", "method", "yes", [])
c(71, "Part 9 research questions — Are DE/JP/ES/IT genuinely absent, or unmonetised?; §4.2 no localization complaints", "market",
  "The listing declares six languages but four of them (DE, JP-adjacent, ES, IT) produced zero reviews — localisation may be shipped but unmarketed; research whether those markets are absent or just unmonetised",
  "EN, FR, DE, IT, PT, ES declared", "none", "0 reviews from DE, JP, ES, IT; 0 localization complaints; 4 non-English reviews (FR ×2, pt-BR, ru)", "research", "open question", "unknown", [])

with open("Tools/prd_ledger/6/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
