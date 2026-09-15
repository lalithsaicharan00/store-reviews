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

# ---- PART 2 ----
c(18, "§2.1 Store facts table (verbatim)", "positioning",
  "Store facts: v4.3.8 (15 May 2025, release notes 'Bug fix.'), first release 15 Dec 2021, English only, iPhone only (no iPad), iOS 17+, 79.5 MB, price label Free with IAPs; description states 'fully paid and purchase is required to access any content… Continued use requires an active subscription, which can be one-time, monthly or yearly'; Spanish storefronts renamed gender-neutral 'Daily Routine Planner Schedule'",
  "see table", "none", table("## 2.1 Store facts"), "none", "external", "app-specific", [])
c(19, "§2.2 The price ladder, from Apple's own IAP list table (verbatim); three separate 'Weekly Subscription' SKUs", "monetization",
  "The price ladder has ten SKUs: three 'Weekly Subscription' at $7.00 / $6.99 / $2.99, three yearly at $24.00 / $5.99 / $4.00, two 'One-Time Payment' at $9.00 / $4.99, plus Monthly $8.00 and 12 Weeks $29.99 — external corroboration of what reviewers describe from inside: a price that changes when you try to leave",
  "10 SKUs with duplicate names; weekly / monthly / yearly / one-time", "1★-burst", table("## 2.2 The price ladder"), "dont", "external + 8 reviews", "yes", [])
c(20, "§2.2 price_dark_pattern — exit-offer / discount-ladder pricing", "dont",
  "Exit-offer / discount-ladder pricing: 'just to make you pay a life time… for 17,99. Then, when you are about to close the app… it says Wait don't go and changes the offer to 5.99'; '90% off from $4,990 to $499… then when you try to leave… suddenly the price drops to $89. It just feels so gross'; 'the wait don't go have it for £4 per year like that isn't another major red flag'; a countdown timer that still does not grant access; a 10× regional price change ($0.49 → $5/week); a hidden one-time offer found by swiping from the bottom-left; and a 5★ who left because of the exit discount",
  "'wait don't go' exit discount, timers, hidden offers", "1★-burst", "price_dark_pattern 8 (1.98%, MEANINGFUL) mean 2.00; 2022-07 → 2026-03", "dont", "meaningful", "yes",
  ["12242542425","13638785503","13817544776","12134476768","11588201167","8840832305","12573300694","13279632399"])
c(21, "§2.3 Feature inventory derived from reviews table (verbatim); Free tier: none", "feature",
  "Feature inventory from reviews: narrated onboarding + questionnaire (the only free part); day/week/month calendar with time blocks, task list, reminders, habit/streak tracking, preset 'that girl' morning/night routines, water tracker, food log with MANDATORY photo, focus timer, affirmations/journal (possibly removed), Google Calendar sync (advertised, reported broken), account + cross-device restore (reported broken), themes/'vibe' picker — all paid; widgets, Apple Watch and iPad absent; free tier: none — no reviewer describes using any core feature without paying",
  "everything paid except onboarding", "mixed", table("## 2.3 Feature inventory"), "research", "verbatim", "app-specific",
  ["13606114222","8252268729","8913316700","13746755144","9102457965","8983147178","10037371405","10118932887","12021381513","12383283769","13366086371","9852078271","11678330257"])
c(22, "§2.3 Food/meal log with mandatory photo", "feature",
  "The food/meal log requires a photo — a mandatory step reviewers name as friction",
  "mandatory photo to log a meal", "complaint", "3 cited reviews", "dont", "low", "yes",
  ["10037371405","10907660652","11511872399"])
c(23, "§2.3 Apple Watch app absent — 3 requests; iPad app absent (iPhone-only listing)", "feature",
  "Apple Watch and iPad apps are absent — Watch requested 3 times, iPad confirmed missing externally (iPhone-only listing)",
  "absent", "complaint", "Apple Watch / iPad requested 7 (1.73%, MEANINGFUL) mean 3.14", "undecided", "meaningful", "yes",
  ["9852078271","12425415800","12178849529","11678330257","14151717931"])
c(24, "§2.4 One product regression is documented (feature removal after update)", "timeline",
  "One documented regression: 'It had a water tracker, motivational quotes, food tracker, emotional journal, task tracker, and the calendar… once it was updated all those features were gone' (Nov 2024) — n=1, weak, but consistent with the 2026 'just a calendar/to do list' and 'no routines or trackers' complaints; flagged as a research question, not a finding",
  "features removed in an update (n=1)", "churn", "1 (0.25%, WEAK)", "research", "weak", "app-specific",
  ["11901631540","13937741808"])

# ---- PART 3 ----
c(25, "Part 3 GLOBAL FINDINGS all themes ranked table (verbatim)", "data-caveat",
  "Thirty-one themes ranked with direction, n, %, signal, mean and window",
  "n/a", "mixed", table("# PART 3 — GLOBAL FINDINGS"), "none", "verbatim", "app-specific", [])
c(26, "Part 3 #4 No free trial / can't test first", "monetization",
  "No free trial / can't test first is the fourth-largest theme",
  "no trial (early corpus); a trial later appeared and broke", "blocked-conversion", "no_trial 62 (15.35%, HIGH-PRIORITY) mean 1.35; 2022-01 → 2026-07", "undecided", "high-priority", "yes", [])
c(27, "Part 3 #6 Price objection", "monetization",
  "Price objection is a high-priority theme in its own right ('$14.99 this is crazy… $30.00 per month that is more than the lifetime option'; 'it costs 5$/permonth')",
  "weekly $2.99–$7, monthly $8, yearly $4–$24, one-time $4.99–$9", "complaint", "price objection 50 (12.38%, HIGH-PRIORITY) mean 1.72", "research", "high-priority", "yes",
  ["11588201167","11453056321"])
c(28, "Part 3 #15 Customisation too limited; #16 English text quality / typos; #25 Notifications missing or unreliable; #26 Language not available (non-EN); #27 Cannot plan ahead / calendar depth", "feature",
  "Mid-size complaint themes: customisation too limited; English text quality / typos (2022–Feb 2023 only, since fixed); notifications missing or unreliable; app not available in the user's language; cannot plan ahead / calendar depth",
  "limited customisation; English only; shallow calendar", "complaint", "customisation 13 (3.22%, VERY STRONG) mean 1.92; typos 12 (2.97%) mean 1.58, 2022-01 → 2023-02; notifications 6 (1.49%) mean 2.83; language 5 (1.24%) mean 2.60; plan-ahead 5 (1.24%) mean 3.80", "build-free", "meaningful–very strong", "yes", [])
c(29, "Part 3 #19 Promotional 'free lifetime' not honoured; §8 Trend 9", "must-never-break",
  "A promotional 'free lifetime' giveaway was not honoured — a bounded, closed incident (Jul 2024 – May 2025)",
  "promo promised lifetime access, not delivered", "1★-burst", "8 (1.98%, MEANINGFUL) mean 1.50; 2024-07 → 2025-05", "must-never-break", "meaningful, closed", "yes", [])
c(30, "Part 3 #28 Gender targeting objection; §2.1 gender-neutral rename in Spanish storefronts", "audience",
  "A gender-targeting objection exists at emerging band — and the developer renamed the app gender-neutral in Spanish storefronts",
  "'That Girl' branding; renamed in es/mx", "complaint", "4 (0.99%, EMERGING) mean 2.00", "research", "emerging", "app-specific", [])
c(31, "Part 3 #29 Privacy / data-harvesting concern", "must-have",
  "Privacy / data-harvesting concerns appear at emerging band, all 1★",
  "questionnaire collects personal data pre-paywall", "complaint", "3 (0.74%, EMERGING) mean 1.00", "must-have", "emerging", "yes", [])
c(32, "Part 3 #30 ADHD / autism use case", "audience",
  "ADHD / autism users name the pre-planned day as the benefit",
  "structured day plan", "praise", "3 (0.74%, EMERGING) mean 3.67", "do", "emerging", "yes",
  ["12286335035","13203951770"])
c(33, "§3.1 Unmet needs, cleanly separated from broken features table (verbatim)", "insight",
  "Complaint types: pricing objection is 51% of the corpus (the product working, the gate rejected — does not say the product is bad); broken existing capability 22.5% (defect tickets, not roadmap); genuine new-capability requests 5.9% (widgets, Watch/iPad, non-English, plan-ahead depth); expectation gap ~162 (fixable with store copy, not engineering); trust/integrity 15.8%",
  "n/a", "mixed", table("## 3.1 Unmet needs"), "none", "classification", "yes", [])
c(34, "§3.1 One expectation gap is unique — expected a community", "positioning",
  "One unique positioning gap: 'I was expecting a community where I could connect with like minded girls. It's just another habit tracker' — the 'That Girl' brand promises a social identity; the product delivers a solo planner",
  "brand implies community; product is solo", "complaint", "n=1 (0.25%, WEAK)", "research", "weak", "app-specific",
  ["9078005343"])

# ---- PART 4 ----
c(35, "Part 4 WHO IS IN THIS CORPUS table (verbatim); overlap note — 16 reviews in both blocked and paid groups", "audience",
  "Corpus segments: blocked-never-paid-never-used 172 (mean 1.31); self-identified payers 80 (1.31); sustained users 22 (4.95); praised-onboarding-only pre-use 9 (5.00); content-free 8; 16 reviews are in both the blocked and paid groups — people who complained about the gate and paid anyway ('Even so, I'll buy it because it looks very attractive')",
  "n/a", "mixed", table("# PART 4 — WHO IS IN THIS CORPUS") + " ; overlap 16", "none", "segments", "app-specific",
  ["11914052843","11500680241","13817502722","12982453369","11586279561"])

with open("Tools/prd_ledger/12/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
