import json, re
R = 12
rep = open("App Store Reports/12. That Girl - Routine Planner - Cute Daily Calendar Schedule (REPORT).md").read().split("\n")
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
c(49, "§7.1 Eligibility; §7.2 United States table (verbatim)", "market",
  "Only the US clears 50 (135, 33.42%); US distribution and theme divergences vs global",
  "n/a", "mixed", "US n=135 mean 2.26; 1★ 76 (56.30%), 2★ 13, 3★ 11, 4★ 5, 5★ 30 (22.22%); " + table("## 7.2 United States"), "none", "verbatim", "app-specific", [])
c(50, "§7.2 What is genuinely US-specific", "market",
  "US reviewers evaluate the product, not just the gate (10 of 13 customisation and 9 of 12 typo complaints; the most detailed feature critique — water tracker locked to litres, food log requiring a photo, preset daily tasks that cannot be turned off); US carries 6 of 8 promo-not-honoured reviews (the AppAdvice giveaway was a US-channel event) and 11 of 21 onboarding fights; the 5★-prompt complaint is nearly absent in the US (2 of 23) — a real divergence of unknown cause, not evidence the prompt is not shown",
  "n/a", "mixed", "US paywall 34.07% vs 40.10% global; praise 30.37% vs 22.52%; outcome praise 8.89% vs 5.45%; customisation 7.41% vs 3.22%; rating prompt 1.48% vs 5.69%", "research", "eligible (n=135)", "app-specific",
  ["10037371405","12136171638","12015499097","12060522005","11514752409","11514719694","11513929479"])
c(51, "§7.3 High-review-volume markets table (verbatim); refund and support failures are roughly twice as prevalent outside the top-8", "market",
  "Top-8 written-review storefronts (US, GB, DE, AU, CA, FR, BR, IT) vs rest of world: the one material difference is that refund and support failures are roughly twice as prevalent outside the top 8 — small-storefront users are more likely to be charged and stranded (UA alone contributes 4 of 21 refund complaints from 9 reviews)",
  "n/a", "1★-burst", table("## 7.3 High-review-volume"), "research", "small denominators", "app-specific", [])
c(52, "§7.4 High-spend markets table (verbatim); the markets that generate the most revenue are also where the billing defect does the most damage; JP limited evidence; store averages 4.63–4.84 in all thirteen", "market",
  "The high-spend group (US, GB, DE, CA, AU, FR, JP) is not more forgiving and not less blocked — slightly more payers and slightly more entitlement failures, so the revenue markets are where the billing defect does the most damage; JP's only two reviews are both negative (HTTP 400 after subscribing; 'Pure fishing app'); every one of thirteen sampled storefronts shows a store average between 4.63 and 4.84 — the 2.10 written mean diverges in all thirteen",
  "n/a", "1★-burst", table("## 7.4 High-spend markets") + " ; ratings US 5,825 · GB 1,576 · DE 961 · CA 841 · AU 670 · FR 637 · IT 529 · MX 397 · ES 380 · NL 369 · PL 234 · BR 245 · UA 120", "research", "group", "app-specific",
  ["12265074054","12602582289"])
c(53, "§7.5 Localisation — a structural finding, not a country finding", "market",
  "The app declares English only, yet 16% of reviews are written in another language; five reviewers explicitly ask for their language (a 5★ whose entire review is the Simplified Chinese request; a 1★ partly because 'the interface is English only') and one names the trade directly: 'If the app would be a little bit cheaper and it would be in german too I would buy it' — English-only shipping is costing paying customers in DE, BR, FR, IT, TW and CN storefronts holding ~2,800 of the 12,784 ratings sampled; counter-evidence: one ES 5★ praises the English as clear enough",
  "English only", "blocked-conversion", "64 of 404 (15.84%) non-English: de 15, pt 13, fr 12, es 8, it 7, zh 5, sv 1, nl 1, ru/uk 1, ko 1; explicit asks 5 (1.24%, MEANINGFUL) mean 2.60", "build-free", "meaningful", "yes",
  ["9014887127","8161641833","10906821521","10911615115","10923103793","11635792003"])
c(54, "§7.6 Storefront naming — an ASO fact; gendered brand objection", "tactic",
  "In es/mx the app is listed gender-neutral as 'Daily Routine Planner Schedule' and those two storefronts carry the two highest store averages in the set (es 4.84, mx 4.78) — causation not established, but four reviewers object to the gendered brand ('not just for girls'; 'I don't think a todo app should be targeted at one certain gender'; 'Scam app preying on young girls'), so the rename is a deliberate, testable positioning decision already made in one market pair",
  "gendered brand; neutral rename in es/mx", "mixed", "gender objection 4 (0.99%); es 4.84, mx 4.78", "research", "emerging", "yes",
  ["13702266709","13546083732","12412345383","9741292848"])
c(55, "§7.7 Small-storefront caveat — two single-review observations recorded as limited evidence: full failure chain; cross-account data leakage", "must-never-break",
  "Two single-review severity flags: a Belarus review with the full failure chain in one record (paid, charged, blocked, support unreachable), and a Malaysia review — 'has events that does not belong to my email' — the only record suggesting cross-account data leakage, flagged for triage because a data-boundary defect is a security concern regardless of frequency",
  "possible cross-account data leak (n=1)", "1★-burst", "n=1 each [limited evidence]; 52 of 58 storefronts <20 reviews, 22 exactly one", "must-never-break", "limited evidence / security carve-out", "yes",
  ["11614195867","13812177642"])

# ---- PART 8 ----
c(56, "Part 8 TIME-TREND method; period table (verbatim)", "timeline",
  "Five periods (2021 folded into 2022; 2026 partial to 16 Aug): the mean rose from 1.68 (P1) and 1.46 (P2) to 2.29 / 2.19 / 2.48 as the 5★ share stepped up from 6.8% to 24–27% from 2024",
  "n/a", "mixed", table("# PART 8 — TIME-TREND ANALYSIS"), "none", "verbatim", "app-specific", [])
c(57, "§8 Trend 1 — The paywall complaint never goes away", "timeline",
  "The paywall complaint never goes away: it falls after 2023 but never drops below a third of all reviews in any period — the longest-running unresolved theme, unresolved by design",
  "hard paywall by design", "1★-burst", "52.3% → 61.5% → 36.0% → 33.9% → 33.3%", "product-rule", "persistent", "yes", [])
c(58, "§8 Trend 2 — 'No free trial' collapses after 2022; a trial appears and then breaks", "timeline",
  "'No free trial' collapses after 2022 and then a trial appears and breaks: the 2022 cohort is unanimous that no trial exists; from 2025 reviewers describe a trial that shows as subscribed but 'doesn't move past the subscription screen', 'once i got the 3 day free trial it just glitched and won't move forward', 'They gave a free trial but it doesn't work' — the complaint changed shape from 'there is none' to 'it doesn't work'",
  "3-day trial introduced 2023–25, does not reliably grant access", "1★-burst", "35.2% → 23.1% → 8.0% → 6.3% → 14.3%", "must-never-break", "trend", "yes",
  ["8944662701","8992840051","9380396109","8988433850","9086515342","12608420898","12605461922","12601413294"])
c(59, "§8 Trend 3 — Entitlement failure is the growth defect. Worsening.", "timeline",
  "Entitlement failure is the growth defect: 2025 is the worst year on record for paid users locked out of what they bought, and the last shipped version (15 May 2025) carries release notes reading only 'Bug fix.'",
  "entitlement defect unfixed", "1★-burst", "3.4% → 0% → 8.0% → 12.6% → 7.9%; absolute 3 → 0 → 8 → 16 → 5", "must-never-break", "trend", "yes", [])
c(60, "§8 Trend 4 — The onboarding was fixed. The corpus's one clear win; note the cost of the delay", "timeline",
  "The onboarding was fixed — a 16-review spike Feb–Aug 2024 then near-silence, most likely a skip control — the corpus's one clear win; the cost of the delay: the spike coincides with the arrival of a large negative 2024 cohort",
  "skip control added mid-2024 (inferred)", "praise", "0 → 1 → 16 (16.0% of 2024) → 1 (0.8%) → 3 (4.8%)", "must-have", "clear", "yes", [])
c(61, "§8 Trend 5 — The 5-star prompt appears in 2024 and is more discussed in 2026 than ever; correlation with 5★ count not causal", "timeline",
  "The 5-star prompt first appears Feb 2024 and is more discussed in 2026 than ever; the 5★ count steps up in exactly the same period (1 in 2023, then 24, 29, 17) — correlated in time, but the corpus cannot establish causation; both are also consistent with a genuine 2024 product improvement",
  "pre-use rating prompt since 2024", "mixed", "0 → 0 → 9 (9.0%) → 7 (5.5%) → 7 (11.1%); 5★ 1 → 24 → 29 → 17", "dont", "trend, non-causal", "yes",
  ["10905116935","14210464046","13960253250","14138334719"])
c(62, "§8 Trend 6 — Reliability is getting worse, not better; calendar-sync and time-editing bugs new since 2024 and still open", "timeline",
  "Reliability is getting worse: two sub-themes new since Dec 2024 and still open in mid-2026 — calendar-sync failure and time-editing/12h-format bugs",
  "unfixed 2024 regressions", "1★-burst", "bugs 11.4% → 3.8% → 9.0% → 16.5% → 17.5%; sync first 2024-12 latest 2026-06; time bug first 2024-12 latest 2026-07", "must-never-break", "trend", "yes",
  ["12021381513","13812177642","14329102917"])
c(63, "§8 Trend 7 — The typo problem was fixed and has not returned; it took roughly 13 months", "timeline",
  "The typo problem ('everywhere it is meant to say lunch, it instead says launch'; 'gonna gonna gonna I can't take it serious') was fixed and has not returned — a genuine completed remediation that took roughly 13 months and cost 12 reviews at mean 1.58",
  "English text quality fixed by Feb 2023", "complaint", "12 complaints 2022-01 → 2023-02, then 0 across 259 reviews", "do", "closed", "yes",
  ["8200241804","9525710586"])
c(64, "§8 Trend 8 — Widgets became a demand only after 2024", "timeline",
  "Widget demand is new: zero requests before Nov 2024, then 1 / 7 / 1 — current, from retained users",
  "no widget", "complaint", "0 before 2024-11; 1 (2024), 7 (2025), 1 (2026); group mean 2.44", "build-free", "trend", "yes", [])
c(65, "§8 Trend 9 — The promo giveaway is a bounded, closed incident", "timeline",
  "The lifetime-access promo giveaway (AppAdvice code) is a bounded, closed incident with two failure modes — the offer never appeared, or the entitlement was granted then lost or charged — no occurrences after May 2025",
  "promo entitlement not honoured", "1★-burst", "8 reviews 2024-07-20 → 2025-05-28", "must-never-break", "closed", "yes",
  ["11514752409","12136171638","12060522005"])
c(66, "§8 What persisted, unfixed, across the entire window table (verbatim); weekday-only repeat gap three years and ten months", "timeline",
  "Persistent unfixed themes across all periods: paywall, price, bugs, recurring tasks broken, notifications unreliable, parity with the built-in calendar; a request for weekday-specific repeating reminders in Jul 2022 recurs as 'no ability to have things repeat only on weekdays' in May 2026 — three years and ten months, same gap",
  "no weekday-only repeat", "complaint", table("## What persisted, unfixed"), "must-have", "persistent", "yes",
  ["8927844988","14082922244"])

with open("Tools/prd_ledger/12/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
