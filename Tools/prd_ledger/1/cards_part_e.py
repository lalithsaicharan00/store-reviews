import json
R = 1
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=None))

# ---- 6.4 China ----
c(137, "§6.4 bullets 2-3", "insight", "The review campaign gave China rank and volume, not revenue — volume collapsed from ~2,225/month (Apr 2022) to 20–40/month once the campaign ended, and only 0.86% of CN reviews show purchase signal",
  "campaign ended ~Nov 2022", "none", "~2,225 reviews/month peak → 20–40/month from Nov 2022 through 2026; purchase signal 0.86%", "dont", "high-priority", "yes", [],
  side="incentivised review volume does not persist and does not convert")
c(138, "§6.4 bullet 4", "monetization", "China's free cap was 3 habits throughout 2021–22 versus 5–6 elsewhere — a stricter free tier in the home market",
  "region-specific free cap", "complaint", "3 in CN vs 5–6 elsewhere", "research", "stated", "yes", [],
  cond="pairs with 'you must pay just to reach the home page, minimum 48' (14506100308)")
c(139, "§6.4 bullet 6", "anti-pattern", "The review-for-premium campaign backfired reputationally: ~30 low-rated CN reviews attack the forced-review mechanic and ~15 say the promised membership never arrived",
  "campaign with unreliable reward delivery", "1★-burst", "~30 attacking the mechanic; ~15 'reward not delivered'; global 'review reward not delivered' 60 (0.11%)", "dont", "moderate", "yes",
  ["8038625627","8047806930","7751058710","7684468117","7823151695","8123994664","8110096979","9132316564","13567434379","9509273829","8945741828","8987285663","8663298319","8470403381"],
  side="an incentive you fail to deliver is worse than no incentive")
c(140, "§6.4 bullet 7", "must-have", "China-specific complaint cluster: no account login → membership and data lost on reinstall or new phone; iPhone↔iPad not syncing on the same Apple ID; persistent Android requests (one payer switched to Android and lost everything)",
  "no account; iCloud-only sync; iOS only", "complaint", "6 + 4 + 4 IDs", "must-have", "moderate", "yes",
  ["8217401004","12122244165","9615294074","12453093486","13691170318","14213711567","9208648018","9223945846","12107547777","8470619548","9023942437","10025596797","7970081682","13349826027"],
  cond="the no-account problem is global; Android is a cross-platform continuity ask")
c(141, "§6.4 bullet 8", "do", "China discovery is Xiaohongshu + Bilibili UP主 + Zhihu + Douban — the analogue of TikTok in the US",
  "n/a", "praise", "8 IDs", "do", "qualitative", "yes", ["8002039077","8061243582","8509035588","8513588102","8554398766","7641461501","10049341224","12304607260"])
c(142, "§6.4 bullet 9", "tactic", "Becoming visibly responsive (2025–26) produced revised 5★ reviews: users reported bugs, saw them fixed, and came back to raise their rating",
  "developer responsive on Xiaohongshu and in-app from 2025", "5★-burst", "'dev responsive' 98 global (0.17%); non-CN share peaked 0.73% in 2024; 6 IDs of returning reviewers", "do", "weak count, clear mechanism", "yes",
  ["13449875017","12513590440","11883092530","13666901262","14075111063","14056363586"],
  side="'I reported it twice, the author fixed it, so I came back to give 5 stars'")

# ---- 6.5 global rollup: themes not yet carded ----
c(143, "§6.5 row 'Social referral'", "insight", "Social referral is an emerging theme globally (0.52%)",
  "n/a", "praise", "293 (0.52%) EMERGING", "do", "emerging", "yes", [])
c(144, "§6.5 row 'No-trial-before-pay'", "monetization", "'No trial before pay' is a weak but present complaint (217 reviews)",
  "no free trial of Premium", "complaint", "217 (0.38%) WEAK", "research", "weak", "yes", [])
c(145, "§6.5 row 'Parents/kids use'", "audience", "Parents tracking kids' habits is a weak but distinct use case",
  "n/a", "praise", "118 (0.21%) WEAK; grouping/profiles requests cite 'my kids' (R01-102)", "research", "weak", "yes", [])
c(146, "§6.5 row 'Chronic illness / meds'", "audience", "People tracking medication and chronic illness are a distinct audience",
  "n/a", "praise", "90 (0.16%) WEAK; Part 8 #19 groups them with ADHD and students", "do", "weak", "yes", [])
c(147, "§6.5 row 'Fitness/health use'", "audience", "Fitness / health use is a 'meaningful' global theme (1.85%)",
  "n/a", "praise", "1,049 (1.85%) MEANINGFUL", "do", "meaningful", "yes", [])
c(148, "§6.5 row 'Focus timer'", "feature", "The focus timer is an 'emerging' global theme",
  "has a focus timer", "praise", "452 (0.80%) EMERGING", "undecided", "emerging", "yes", [])
c(149, "§6.5 caution", "data-caveat", "For product decisions weight the US and rich-market columns far more heavily than the global column, which is diluted by 22,136 contentless reviews",
  "n/a", "none", "method note", "none", "method", "yes", [])

# ---- PART 7 ----
c(150, "Part 7 table rows 1-2", "insight", "Confirmed purchases and lifetime/one-time praise both rose steadily as a share of non-China reviews, peaking in 2025–26",
  "n/a", "purchase-driver", "confirmed purchase 0.73% (2019) → 5.35% (2025) → 4.69% (2026); lifetime praise 1.28% → 3.18% (2026)", "product-rule", "high-priority", "yes", [],
  side="as subscription fatigue grew in the market, the lifetime SKU became a bigger reason to buy")
c(151, "Part 7 table row 'Price too expensive'", "timeline", "'Too expensive' peaked in 2024 (1.13%) as the lifetime price passed $8–9",
  "raised lifetime price", "complaint", "0.18% (2019) → 1.13% (2024) → 0.71% (2026)", "research", "moderate", "yes", [])
c(152, "Part 7 table row 'Billing errors'", "timeline", "Billing complaints peaked in 2025 at 0.90% of non-CN reviews — nearly 10× the 2019–2023 level",
  "billing errors rose", "1★-burst", "0–0.19% (2019–23) → 0.39% (2024) → 0.90% (2025) → 0.40% (2026)", "must-never-break", "high-priority", "yes", [])
c(153, "Part 7 table row 'Crashes'", "timeline", "Crash share of non-CN reviews: 17.32% in 2020 (fragile launch era) → 2.43% in 2023 (best) → 5–6.5% in 2024–26",
  "n/a", "1★-burst", "1.47 / 17.32 / 7.67 / 4.12 / 2.43 / 6.47 / 5.55 / 5.32 (% by year 2019–2026)", "must-never-break", "high-priority", "yes", [])
c(154, "Part 7 table row 'ADHD'", "timeline", "ADHD framing peaked at 4.07% of non-CN reviews in 2023 and has fallen since (1.16% in 2025)",
  "positioned as ADHD planner", "praise", "0.37 (2019) → 4.07 (2023) → 1.16 (2025) → 1.67 (2026)", "do", "moderate", "yes", [],
  cond="the audience is still there; the app stopped earning their reviews as reliability fell")
c(155, "Part 7 table rows 'Mood/journal', 'Apple Health'", "timeline", "Mood/journal and Apple Health mentions both peaked in 2025 (2.13% each) after the features shipped",
  "shipped mood/journal Dec 2023; broadened Health integration", "praise", "mood/journal 0 → 2.13% (2025); Apple Health 0.9% → 2.13% (2025)", "research", "moderate", "yes", [])
c(156, "Part 7 table row 'Widget'", "timeline", "Widget mentions held at 5–6.5% of non-CN reviews every year 2020–2025, then dipped to 4.21% in 2026",
  "widgets since 2020", "praise", "5.40 / 6.28 / 6.00 / 6.50 / 6.31 / 6.06 / 4.21 (2020–2026)", "build-free", "high-priority", "yes", [],
  cond="the 2026 dip follows the Apr 2024 widget paywall and widget-reliability bugs")
c(157, "Part 7 table row 'Account/login request'", "timeline", "Account/login requests are rising (0 → 0.32% in 2026) as more users change phones",
  "no account", "complaint", "0 (2019–21) → 0.32% (2026)", "must-have", "weak but rising", "yes", [])
c(158, "Part 7 '2023 peak quality'", "timeline", "2023 was the best year in the app's history: US mean 4.54, crashes at 2.43%, scholarship program running, ADHD positioning at its strongest — the only sour note was the new free cap",
  "stable app + scholarship + ADHD positioning", "5★-burst", "US mean 4.54; crashes 2.43%; ADHD 4.07%; free cap complaint 1.07%", "do", "high-priority", "yes", [],
  side="the winning configuration is on record: reliability + generosity + a clear audience")
c(159, "Part 7 '2026 partial recovery'", "timeline", "2026 partial recovery came from shipping localisation, loosening the free cap back to 6, and the developer becoming responsive — monthly means climbed back to 4.0–4.16",
  "shipped languages, loosened cap, became responsive", "praise", "localisation 8.06% → 3.02%; mid-2026 monthly means 4.0–4.16", "do", "high-priority", "yes", [])
c(160, "Part 7 'story in one line'", "insight", "The product got better at features and worse at trust: quality of the OFFER fell (more paywalls, billing errors, broken family plan, no support) while quality of the APP mostly held — ratings followed the offer, not the app",
  "n/a", "churn", "synthesis of Part 7", "product-rule", "high-priority", "yes", [],
  side="feature work cannot compensate for a deteriorating offer")
c(161, "Part 7 'AI' section", "insight", "Nobody in this category is asking for AI — 6 of 56,653 reviews mention it (0.011%), one uses 'AI slop' as an insult, and users repeatedly ask for the opposite: no bloat, no fancy stuff",
  "no AI features", "none", "6 reviews (0.011%), far below the 0.1% ignore threshold; 1 genuine request (AI to build a schedule)", "dont", "high-priority (negative evidence)", "yes",
  ["10828370613","12071506651","12146111608","14398239845","14449350393","14499683590"],
  cond="Part 8 #23: don't build AI, build reliability instead")

with open("Tools/prd_ledger/1/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
