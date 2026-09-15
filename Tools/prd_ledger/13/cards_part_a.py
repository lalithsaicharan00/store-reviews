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

c(1, "header lines 1-8", "positioning",
  "Productive — Habit Tracker (App Store ID 983826477) is an eleven-year-old daily habit checklist that converted from a $3.99 one-time purchase to a subscription in August 2017; the second-largest corpus in the set",
  "developer Mosaic S.r.l.; bundle com.beHappy.Productive; subscription (weekly / yearly) after 2017; store rank 13", "mixed",
  "19,850 written reviews, 115 storefronts, 3 Jun 2015 → 2 Sep 2026; mean 3.51; extracted 8 Sep 2026", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; ⚠️ Five warnings; §1.1–1.5 files, schema, coverage, method, limitations; §9.1–9.2", "data-caveat",
  "Method: denominator 19,850, non-exclusive themes, standard bands; the corpus is heavily a billing-dispute sample (25.76% 1★) — do not read mean 3.51 as product quality; regex classifier with 90 themes and patterns in 23 languages, coverage differs by language so themes are under-counted never over-counted (M-free-limit fires on 4.9% of US vs 0.4% of CN reviews — a coverage artefact), so cross-country comparison leads with rating distributions; paid-evidence split into voluntary purchase vs involuntary charge and never merged; corpus back-weighted to 2015–2020 (82.5%), only 627 reviews (3.16%) from 2024–26 [small sample]; no version field — release attribution is date-based or reviewer-stated; direct reading of the full 2015–19 1★ stream (875) plus seven residual-closure loops (37.24% → 10.64% unclassified, all read, no new theme survived); D-stuck-updating hand-audited 43 of 46 true positives (93.5%); prices are reviewer-reported; developer replies not in corpus",
  "n/a", "none", "19,850 / 19,850 parsed; 0 duplicate IDs; 115/115 storefronts reconcile; 0 empty bodies; no deduplication (121 repeats are legit); edited 353 (1.78%); upvoted 1,040 (5.24%)", "none", "method", "yes", [])
c(3, "§1.6 Corpus composition rating table (verbatim); year table (verbatim); script distribution", "timeline",
  "Corpus composition by rating and year: 2015–16 mean 4.75–4.77 with 1★ ~1%, then a straight-line fall from 2017 to 2.37 in 2026; script distribution Latin 86.2%, Han 7.6%, Cyrillic 2.8%, Hangul 2.8%, Kana 0.26%, Arabic 0.25%",
  "n/a", "mixed", table("## 1.6 Corpus composition") + " ;; " + table("## 1.6 Corpus composition", 1) + " ; scripts: Latin 17,112 (86.2%), Han 1,510 (7.6%), Cyrillic 550, Hangul 546, Kana 52, Arabic 49, Thai 28, Hebrew 3", "none", "verbatim", "app-specific", [])

# ---- EXECUTIVE SUMMARY ----
c(4, "EXECUTIVE SUMMARY #1 This app was loved, and then the business model destroyed it. The date is knowable.", "timeline",
  "This app was loved and then the business model destroyed it, and the date is knowable: for two years one of the best-rated products in its category; in August 2017 the developer converted a $3.99 one-time purchase into a recurring subscription and by many accounts revoked the entitlement of people who had already paid; ratings fell in a straight line and never recovered — the clearest monetisation-damage case in the corpus set",
  "one-time → subscription Aug 2017; prior buyers' entitlement revoked", "1★-burst", "2015 mean 4.75, 2016 4.77 (5★ 81–83%, 1★ ~1%) → 2017 4.40 → 2018 2.85 → 2026 2.37", "product-rule", "very strong", "yes", [])
c(5, "EXECUTIVE SUMMARY #2 For every reviewer who says they chose to buy, there is one who says they were charged without consent", "must-never-break",
  "For every reviewer who says they chose to buy, there is one who says they were charged without consent — the two populations are nearly the same size; that ratio, not the price, is the company's core problem",
  "trial auto-converting; undisclosed recurring charge", "1★-burst", "voluntary 836 (4.21%) mean 3.06; involuntary 856 (4.31%) mean 1.27, 89.0% 1★", "must-never-break", "high-priority", "yes", [])
c(6, "EXECUTIVE SUMMARY #3 Price rose roughly 25× and the complaint followed it", "monetization",
  "Price rose roughly 25× and the complaint followed it exactly: $3.99 one-time → $19.99–$24/yr → $30/yr → $40–60/yr → $80–100/yr and $3.99/week; 'price is too high' went from 2.9% of 2015 reviews to 26.7% of 2025 reviews and by 2025 is the most-cited theme after generic sentiment",
  "$3.99 one-time (2015–16) → $80–100/yr or $3.99/week (2024–26)", "complaint", "price-too-high 2.9% (2015) → 26.7% (2025), 9× rise", "product-rule", "very strong", "yes", [])
c(7, "EXECUTIVE SUMMARY #4 China and Korea are not weak markets. They are billing-complaint markets.", "market",
  "China and Korea are not weak markets, they are billing-complaint markets: China 73.3% 1★ with 42.6% carrying auto-charge language; Korea 24.7% ask for a refund and 24.7% cannot cancel (~10× global); a large share traces to Douyin (TikTok China) advertising that reviewers say did not disclose the price",
  "ads on Douyin without price disclosure; auto-charge", "1★-burst", "CN 1,337 mean 1.84, 73.3% 1★, 42.6% auto-charge; KR 571 mean 2.84, 24.7% refund, 24.7% cannot cancel; CN+KR 9.6% of corpus, 27.8% + 11.4% of paid-evidence", "dont", "high-priority", "app-specific", [])
c(8, "EXECUTIVE SUMMARY #5 A specific, diagnosable, still-unfixed reliability bug that bricks the app on launch", "must-never-break",
  "A specific, diagnosable, still-unfixed bug bricks the app on launch — stuck on 'Update in progress' — in three waves (Nov 2019, Oct 2020, Sep 2025 → Aug 2026); one 2026 review states the root cause: 'Will not launch without internet — stuck on update in progress until internet is available'; a local habit tracker that cannot open offline is a fixable, high-severity defect",
  "launch blocked on a network update check", "1★-burst", "three waves; 46 hand-audited reviews (43 true positives)", "must-never-break", "weak by volume, severe by nature", "yes",
  ["14453446467"])
c(9, "EXECUTIVE SUMMARY #6 The thing users actually pay for is small, and the company has never priced it that way", "insight",
  "The thing users actually pay for is small and the company never priced it that way: satisfied voluntary buyers describe one benefit — a simple daily checklist with reminders that produces a felt sense of accomplishment; they do not describe content, coaching or AI, while the app added Challenges and Explore content tabs (2020–22) that reviewers mostly asked to hide",
  "simple checklist core + unwanted content tabs", "purchase-driver", "P-utility 44.3% of voluntary-buyer reviews; P-worth-paying 25.5%", "product-rule", "high-priority (segment)", "yes", [])
c(10, "EXECUTIVE SUMMARY #7 The cheapest unshipped wins are unambiguous", "do",
  "The cheapest unshipped wins in order of evidence weight: honest pre-download price disclosure; a working in-app cancel path; cross-device sync (rising to 7.4% by 2026); Arabic and other localisation (Saudi Arabia 20.5%); flexible scheduling (specific weekdays, every-N-days, N-times-per-week); habit reordering that persists",
  "n/a", "none", "sync 2.50% global → 7.4% (2026); SA localisation 20.5%", "do", "recommendation", "yes", [])

with open("Tools/prd_ledger/13/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
