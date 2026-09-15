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

# ---- PART 2 ----
c(11, "§2.1 Feature inventory derived from reviews table (verbatim)", "feature",
  "Feature inventory from reviews with gating: named habits with icons/colours (free, count-capped), daily check-off (free), time-of-day buckets (free), exact-clock reminder times (PAID — the single most resented gate), streaks/'ideal day' (free), statistics (tiered), notes (limited), timer/Pomodoro (paid, stops when the screen locks), Apple Watch (exists, broken for long periods), widget (long absent then present), iCloud sync (advertised, widely non-functional), network account (sign-up path frequently broken), Siri Shortcuts (broken), Challenges/Explore tabs (~2020, partly paid), templates (free), data export (absent), Android/web/macOS (absent), Apple Health (absent), localisation (effectively absent; screenshots show languages the app lacks)",
  "see table", "mixed", table("## 2.1 Feature inventory"), "research", "verbatim", "app-specific",
  ["2246849667","2544359717","3412849953","6953060121","3489233437","4573131040","1603462276","1313972378","7431388676","6586946528","2344695224","10185998135","8273087572","12911930158"])
c(12, "§2.1 Exact-clock reminder times — Paid, the single most resented gate", "feature",
  "Exact-clock reminder times are paid — repeatedly named as the single most resented gate; free users get only Morning/Afternoon/Evening/Anytime buckets",
  "exact reminder time paywalled", "complaint", "4 cited IDs; named repeatedly", "build-free", "qualitative", "yes",
  ["2246849667","2544359717","3412849953","6953060121"])
c(13, "§2.1 Built-in timer stops when the screen locks", "must-never-break",
  "The paid built-in timer / Pomodoro stops when the screen locks",
  "timer does not run in background", "complaint", "2 cited IDs", "must-never-break", "qualitative", "yes",
  ["3489233437","4573131040"])
c(14, "§2.1 Time-of-day buckets Morning / Afternoon / Evening / Anytime — free", "feature",
  "Free time-of-day buckets (Morning / Afternoon / Evening / Anytime) organise the daily list",
  "buckets free", "praise", "4 cited IDs", "build-free", "qualitative", "yes",
  ["2246849667","2172919142","2412434756","5218534959"])
c(15, "§2.1 Data export — Absent, 'no progress on data export for years'", "feature",
  "Data export is absent — 'no progress on data export for years'",
  "absent", "complaint", "41 reviews", "build-free", "weak", "yes",
  ["2344695224"])
c(16, "§2.1 Localisation screenshots reportedly show languages the app does not have", "dont",
  "Store screenshots reportedly show languages the app does not actually have",
  "listing claims languages not shipped", "complaint", "1 cited ID", "dont", "n=1", "yes",
  ["12911930158"])
c(17, "§2.2 The price ladder, as reviewers reported it table (verbatim); 'not Netflix'", "monetization",
  "Price ladder by year from reviewer-named prices: $3.99 one-time (2015–Jul 2017) → Aug 2017 subscription $9.99–$19.99/yr → 2019–20 $30 dominant, ¥208 → 2021–22 $35–60 → 2023 $50–60 → 2024 $80 (14 mentions), $3.99/week → 2025 $100–120, ₽499/week, €6/week → 2026 $99.99–$168; ~25× in year one and unbounded over years; the most common formulation is that the app is 'not Netflix' and adds no new content to justify recurrence",
  "subscription with rising price and weekly tier", "complaint", table("## 2.2 The price ladder"), "product-rule", "very strong", "yes",
  ["2056030038","2346902589","3216212174","6462684894","9540734229"])
c(18, "§2.3 The free tier moved, and the corpus records it table (verbatim); a reviewer who noticed it happening in real time", "timeline",
  "The free habit allowance was tightened from 5 to 3 around 2018 and relaxed back to 5 around 2020 — corroborated by a reviewer in real time ('rather than listen to feedback, that number has now been dropped to 3'); the tightening coincides with the worst year (mean 2.85) and the reversal did not recover the rating, suggesting the damage by then was billing conduct, not the cap",
  "free cap 5 → 3 (2018) → 5 (2020)", "1★-burst", table("## 2.3 The free tier moved"), "product-rule", "very strong", "yes",
  ["2849109648"])
c(19, "§2.4 Free / paid / trial classification table (verbatim); 239 reviews ask for the one-time purchase back", "monetization",
  "Tiers: free = 3–5 habits, coarse buckets, check-off, streaks, limited stats plus persistent full-screen upgrade interstitials; 7-day trial = full features but requires committing to a subscription first and defaults to the most expensive annual tier; premium = unlimited habits, exact reminder times, full stats, timer, some Challenges; one-time purchase withdrawn Aug 2017 and explicitly asked back by 239 reviews",
  "subscription-first trial; one-time withdrawn", "complaint", table("## 2.4 Free / paid / trial") + " ; one-time asked back 239 (1.20%)", "product-rule", "meaningful", "yes",
  ["3272238239","2380437896","3254598597"])
c(20, "§2.5 Dark-pattern mechanics reviewers describe table (verbatim)", "dont",
  "Seven dark-pattern mechanics counted separately: charged after trial without perceived consent (the dominant negative subject), cannot find a way to cancel, 'free' claim disputed, exit-intent discount that halves the price when you decline ('Here's one star for you. You can buy the rest at a 49% discount'), two different prices for the same term, countdown-timer paywall with hidden dismiss, billing taken outside Apple and un-cancellable in Settings",
  "trial auto-charge, hidden cancel, exit discount, dual pricing, countdown paywall, off-Apple billing", "1★-burst", table("## 2.5 Dark-pattern mechanics"), "dont", "high-priority", "yes",
  ["2276777044","2380437896","2178452576","2603968263","4532521548","6883350995","3013464875","8778546806","8157301628"])
c(21, "§2.5 Billing taken outside Apple, un-cancellable in Settings", "must-never-break",
  "Some billing is taken outside Apple and cannot be cancelled in iOS Settings — the standard cancel path the user knows does not work",
  "off-Apple billing", "1★-burst", "qualitative, 3 IDs", "must-never-break", "qualitative", "yes",
  ["8157301628","8981908261","7352163199"])

with open("Tools/prd_ledger/13/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
