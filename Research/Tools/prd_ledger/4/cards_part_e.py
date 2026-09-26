import json, re
R = 4
rep = open("App Store Reports/4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 7 ----
c(81, "§7.1 table (verbatim)", "timeline", "Reviews by year: 2022 269 (3.26); 2023 5,788 (3.71); 2024 8,954 (4.00); 2025 3,660 (4.10); 2026 1,794 (4.03) — volume peaked Jan 2024 (1,514 in one month) and fell to a fifth; either acquisition slowed or review prompting changed",
  "n/a", "mixed", table(526, 532), "none", "high-priority", "app-specific", [])
c(82, "§7.2 quarterly table (verbatim)", "timeline", "Quarterly n, mean, 1–2★, billing cluster, paywall block, trial deception 2022–2026 Q3 — full table",
  "n/a", "mixed", table(538, 556), "none", "high-priority", "app-specific", [])
c(83, "§7.2 Event A", "timeline", "Event A — the 2023 Q2 trough (mean 2.73, 51.4% 1–2★): paywall 13.2%, billing 13.0% and quiz 4.8% complaints all peaked together; whatever the app did in Q3 2023 — volume jumped 3× and the mean recovered to 3.79 — worked",
  "unknown fix in 2023 Q3", "1★-burst", "2.73 → 3.79 in one quarter", "none", "high-priority", "app-specific", [],
  side="a monetisation funnel can be fixed fast enough to show in one quarter")
c(84, "§7.2 Event B", "timeline", "Event B — the Jan–Feb 2024 billing spike: monthly billing-cluster 4.2% (Dec) → 8.1% (Jan) → 15.1% (Feb) → 8.5%; trial-deception 9.3% of all February 2024 reviews — a discrete regression, not a trend",
  "a billing/trial regression shipped ~Jan 2024", "1★-burst", "15.1% billing cluster in Feb 2024", "must-never-break", "high-priority", "yes",
  ["10930935136","10933044729","10983020319","11005436107","10941969952","10941523544","10915214872","10869856053","10863840021","10885363042","10802505019"],
  side="billing regressions are shippable bugs — monitor the trial→charge path per release")
c(85, "§7.2 Event C", "timeline", "Event C — the mid-2025 free-tier tightening: mean 4.29 → 3.61 in one quarter; paywall-block 6.8% → 15.4%; free task cap 0.5% → 2.0% of reviews and above 1% since; fourteen months later the mean has recovered only to 4.12, still below the 4.38 peak",
  "free cap introduced mid-2025", "1★-burst", "4.29 → 3.61; not recovered to peak after 14 months", "product-rule", "high-priority", "yes", [])
c(86, "§7.3", "timeline", "Improved: billing cluster 13.0% (2023 Q2) → 3.8% (2026 Q3) with the 2024 Q1 relapse; localisation eliminated in ES/PT/FR/DE; 'can't edit future days' 1.35% → 0.22%; scheduling flexibility 2.49% → 0.67%; quiz complaints 4.8% → 0.3%",
  "several real fixes shipped", "praise", "five themes improved", "none", "high-priority", "yes", [],
  side="a shorter quiz and a fixed future-day editor both show as near-elimination of the complaint")
c(87, "§7.4", "timeline", "Worsened: free task cap 0.03% → 1.32–2.04%; 'used to be better/free' 3.2% of 3★ and 3.6% of 2★ post-2025; paywall-block never returned to its 2025 Q1 low (6.7% → 8.4–10.6%); unserved-language requests (RU, TR, PL, NL, VI) flat or rising while served languages went to zero",
  "tightened free tier; stopped localising", "complaint", "four themes worsened", "product-rule", "high-priority", "yes", [])
c(88, "§7.5", "timeline", "Persisted unchanged for five years: notification/alarm reliability (0.9–1.3% every year), backup / iCloud / account portability (0.28–1.12%), upsell pop-ups (1.0–6.3% every quarter, never absent)",
  "never fixed", "complaint", "three chronic themes", "must-never-break", "high-priority", "yes", [],
  side="chronic reliability themes at ~1% per year are a permanent rating tax")

# ---- PART 8 ----
c(89, "Part 8 #1", "must-never-break", "Rebuild the trial/plan-selection screen so '7-day free trial' and 'charged now' cannot be confused — show the exact charge date and amount on the confirmation",
  "ambiguous trial screen", "1★-burst", "789 (3.86%) directly; 1,247 (6.09%) cluster", "must-never-break", "high-priority", "yes", [], cond="evidence: R04-005, R04-006")
c(90, "Part 8 #2", "must-have", "Make the paywall's dismiss control unmissable — a full-width 'Continue with the free version' button, not a corner X",
  "corner X", "1★-burst", "up to a material share of 1,903 (9.30%)", "must-have", "high-priority", "yes", [], cond="evidence: R04-007")
c(91, "Part 8 #3", "must-never-break", "Fix Brazilian (and LatAm/APAC) trial provisioning as a P0 — BR runs 7–11× the global billing-complaint rate",
  "per-storefront billing defect", "1★-burst", "7–11× global", "must-never-break", "high-priority", "yes", [], cond="evidence: R04-075")
c(92, "Part 8 #4", "must-have", "Put in-app cancellation and a working support path in the app — 169 cancellation + 48 no-response reviews at mean ~1.2, several escalating to lawyers and denied Apple refunds",
  "cancel by email; no replies", "1★-burst", "169 + 48", "must-have", "emerging", "yes", [], cond="evidence: R04-033, R04-034")
c(93, "Part 8 #5", "must-never-break", "Fix notification and alarm delivery, including sound and app-closed behaviour — it breaks the core promise for paying and ADHD users alike",
  "unreliable notifications", "1★-burst", "212, mean 2.82", "must-never-break", "meaningful", "yes", [], cond="evidence: R04-055, R04-069")
c(94, "Part 8 #6", "must-have", "Ship iCloud backup / account restore on new device — disproportionately hits payers",
  "no backup/restore", "1★-burst", "154 + 115 + 55", "must-have", "emerging", "yes", [], cond="evidence: R04-032, R04-058")
c(95, "Part 8 #7", "dont", "Show the price before the quiz, not after it — the quiz theme has a 1.98 mean and 71.9% 1–2★; every one of those reviews is a wasted acquisition",
  "price after a 10–20 min quiz", "1★-burst", "256, mean 1.98", "dont", "meaningful", "yes", [], cond="evidence: R04-009, R04-078")
c(96, "Part 8 #8", "product-rule", "Reconsider the free daily-task cap, or raise it well above 6 — it reversed a two-year rating recovery and produced the 'got greedy' vocabulary now in 286 reviews",
  "cap of 4–7", "1★-burst", "286 (1.40%) 'used to be better'", "build-free", "high-priority", "yes", [], cond="evidence: R04-008, R04-085")
c(97, "Part 8 #9", "must-never-break", "Stabilise the price and retire the spin-wheel — users report $19.99–$59.99 for the same thing; that inconsistency is what 'scam' language attaches to",
  "variable price + gimmick", "1★-burst", "≥9 price points; 583 scam accusations", "must-never-break", "high-priority", "yes", [], cond="evidence: R04-014, R04-036")
c(98, "Part 8 #10", "monetization", "Add a one-time / lifetime SKU — small explicit demand (20) but it is the standard objection format in this category and would convert the 'I'd pay, just not monthly' segment",
  "subscription only", "blocked-conversion", "20 (0.10%)", "product-rule", "ignore-band, category norm", "yes", [], cond="evidence: R04-042")
c(99, "Part 8 #11", "market", "Introduce regional pricing for LatAm, India, Turkey, SE Asia — Chile's 6.2% price-complaint rate and India's 41.2% 1–2★ rate both point here",
  "single global price", "blocked-conversion", "CL price 6.2%; IN 1–2★ 41.2%", "do", "meaningful (in-market)", "yes", [], cond="evidence: R04-073, R04-075")
c(100, "Part 8 #12", "feature", "Full task editing: rename, reorder, drag, duplicate — 399 reviews (1.95%) and the top complaint among PAYING users",
  "editing gated/limited", "complaint", "399 (1.95%)", "build-free", "meaningful", "yes", [], cond="evidence: R04-019, R04-057, R04-060")
c(101, "Part 8 #13", "feature", "Finish flexible scheduling: weekly, monthly, every-N-days, X-times-per-week, time windows — improving but still 0.67% of 2026 reviews at mean 2.77",
  "partially shipped", "complaint", "332 (1.62%)", "must-have", "meaningful", "yes", [], cond="evidence: R04-056")
c(102, "Part 8 #14", "feature", "Ship the widget properly and let users check off from it — 151 reviews (0.74%, mean 3.79, 39.1% 5★), currently a POSITIVE theme with a clear ask: 'make you cross off the tasks directly from the widget' (35 votes)",
  "widget exists, not interactive", "mixed", "151 (0.74%), mean 3.79", "build-free", "emerging", "yes", ["10220454829","12010228356"])
c(103, "Part 8 #15", "feature", "Apple Watch — 34 reviews (0.17%, weak) but mean 3.68 and asked for by payers",
  "no Watch app", "complaint", "34 (0.17%), mean 3.68", "undecided", "weak", "yes", ["14294898131","10778781877"])
c(104, "Part 8 #16", "audience", "Lead with ADHD / executive-function support — 4.51% of the corpus, 62.4% 5★, and the segment that pays for outcomes",
  "already markets ADHD via TikTok", "purchase-driver", "922 (4.51%), 62.4% 5★", "do", "high-priority", "yes", ["10874402938"], cond="evidence: R04-048, R04-069")
c(105, "Part 8 #17", "feature", "Keep the content library — workouts, meditation, soundscapes, sleep — it is what separates Me+ from 'a fancy Reminders app'",
  "content library", "praise", "484 + 148 + 259", "build-paid", "meaningful", "yes", [], cond="evidence: R04-051, R04-072")
c(106, "Part 8 #18", "dont", "Review the 4+ age rating against the weight-loss and shame framing — 455 kid/teen reviews and 89 shame/ED reviews, with a 46-vote 1★ leading on it",
  "4+ rating with diet framing", "1★-burst", "455 + 89", "dont", "meaningful (safety)", "yes", [], cond="evidence: R04-067, R04-068")
c(107, "Part 8 research questions", "data-caveat", "Open questions the corpus cannot answer: is the immediate charge a billing defect or intended non-trial-plan behaviour; what is the actual free cap today; does the discount wheel raise net revenue or mostly generate refunds; why did review volume fall ~80% from its 2024 Q1 peak",
  "n/a", "none", "4 research questions", "research", "open", "yes", [])

with open("Tools/prd_ledger/4/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
