import json
R = 1
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=None))

# ---- PART 8: the report's own recommendations, one card each ----
c(162, "Part 8 #1", "must-never-break", "Never take money incorrectly: single price shown, no trial-to-charge traps, refunds honoured, receipts clear",
  "billing errors ×21 in 1★", "1★-burst", "billing errors ×21 over-represented in 1★ reviews", "must-never-break", "high-priority", "yes", [], cond="evidence: R01-041, R01-063")
c(163, "Part 8 #2", "must-have", "Ship an account system from day one — no-account is the root cause of lost purchases, lost data and failed multi-device sync, the top three complaints from people who paid",
  "no account system", "churn", "×12–16 over-represented in the paid cohort", "must-have", "high-priority", "yes", [], cond="evidence: R01-048, R01-140")
c(164, "Part 8 #3", "must-never-break", "Make sync actually work, and prove it — sync is the #1 differentiator buyers name and the #1 thing that breaks; if it is the paid feature it must be flawless",
  "paid iCloud sync that fails", "churn", "lift ×9.8 among buyers; sync failure ×12.8 among buyers", "must-never-break", "high-priority", "yes", [], cond="evidence: R01-015, R01-025")
c(165, "Part 8 #4", "must-never-break", "Harden the year-end report — it is the best emotional moment and the most reliable outage (Jan 2020, Dec 2020, Jan 2021, Dec 2024, Jan 2026)",
  "year-end report crashes every year", "1★-burst", "five incidents in six years", "must-never-break", "high-priority", "yes", [], cond="evidence: R01-095")
c(166, "Part 8 #5", "product-rule", "Never re-paywall a free feature — pick your free tier once and hold it",
  "re-paywalled four times", "1★-burst", "×12 lift on 1★", "product-rule", "high-priority", "yes", [], cond="evidence: R01-059, R01-052, R01-056, R01-057")
c(167, "Part 8 #6", "product-rule", "Lead with a one-time lifetime purchase — 'not a subscription' is the strongest pricing signal in the dataset",
  "lifetime SKU", "purchase-driver", "22.4% of everyone who paid names it", "product-rule", "high-priority", "yes", [], cond="evidence: R01-031, R01-123, R01-150")
c(168, "Part 8 #7", "monetization", "Price it low and anchor against subscription competitors — 'cheaper than a coffee' is a 4.79-mean framing",
  "lifetime priced below competitors' yearly", "purchase-driver", "mean 4.79 for price-fair reviews", "product-rule", "very strong", "yes", [], cond="evidence: R01-032, R01-089")
c(169, "Part 8 #8", "tactic", "Run a scholarship / hardship program and never stop it — 91 of 101 mentions are 5★ at a perfect 5.00; it also solves broken payment rails in RU/TR/AR/PK; killing it in 2025 removed the app's best review source",
  "ran then stopped", "5★-burst", "91/101 5★, mean 5.00 among those", "do", "emerging", "yes", [], cond="evidence: R01-035, R01-036")
c(170, "Part 8 #9", "monetization", "Set the free cap generously (6+) and leave it alone — cap complaints carry ×7.5 lift on 2★",
  "cap drifted 2–6", "complaint", "×7.5 lift on 2★", "build-free", "high-priority", "yes", [],
  cond="evidence: R01-008, R01-009, R01-070; note the report recommends a generous fixed cap, not unlimited — 'unlimited' is the #2 purchase reason (R01-014)")
c(171, "Part 8 #10", "monetization", "If you ship a family plan, make it discoverable in-app — this app's family plan has mean 1.65 across 52 complaints purely because nobody can find how to use it",
  "family plan via Apple Family Sharing with no in-app affordance", "1★-burst", "mean 1.65 across 52 complaints", "research", "high-priority", "yes", [], cond="evidence: R01-043, R01-134")
c(172, "Part 8 #11", "feature", "Flexible frequency: every-X-days, specific weekdays, bi-weekly, quarterly, yearly, and custom total-over-a-window — the #1 unmet functional need worldwide",
  "missing", "complaint", "highest 4★ lift in the dataset (×4.2)", "must-have", "high-priority", "yes", [], cond="evidence: R01-072, R01-105")
c(173, "Part 8 #12", "feature", "Interactive widget check-off without opening the app",
  "not interactive for most of its life", "purchase-driver", "×5.2 lift among buyers", "undecided", "small, very high intent", "yes", [], cond="evidence: R01-030, R01-104")
c(174, "Part 8 #13", "feature", "Grouping / folders / multiple profiles — me, my kids, work, pet",
  "missing", "complaint", "#2 feature request (R01-102)", "undecided", "meaningful", "yes", [], cond="evidence: R01-074, R01-102")
c(175, "Part 8 #14", "feature", "Cumulative totals ('47 hours read this year'), not just streaks — and offer total days instead of consecutive days to reduce streak anxiety",
  "streaks only", "complaint", "4 + 1 IDs", "undecided", "weak", "yes", [], cond="evidence: R01-110, R01-113")
c(176, "Part 8 #15", "must-never-break", "Editing a habit must never wipe its history",
  "fixed late 2025", "complaint", "fix produced a returning 5★ (13449875017)", "must-never-break", "weak count", "yes", ["13449875017"], cond="evidence: R01-092")
c(177, "Part 8 #16", "feature", "Apple Watch + Apple Health done properly, including a Watch timer and two-way sync — small volume, very high purchase intent",
  "half-built Watch app; Health integration", "purchase-driver", "lift ×4.2–×5.8 among buyers", "build-paid", "small, very high intent", "yes", [], cond="evidence: R01-028, R01-029, R01-098")
c(178, "Part 8 #17", "feature", "A Mac app — 3★ lift ×4.8; several users volunteered to pay extra for it",
  "broken M1 build only", "blocked-conversion", "3★ lift ×4.8", "build-paid", "strong", "yes", ["8965466270","9503979717"], cond="evidence: R01-073, R01-099, R01-108")
c(179, "Part 8 #18", "feature", "Shortcuts / Siri / URL scheme — power users who will evangelise",
  "missing", "complaint", "4★ lift ×2.7", "undecided", "moderate", "yes", [], cond="evidence: R01-075, R01-107")
c(180, "Part 8 #19", "audience", "Aim at ADHD and neurodivergent users — highest-fit, highest-satisfaction audience; also students and people tracking medication / chronic illness",
  "ADHD in the title", "praise", "ADHD 7.08% of US at mean 4.79; students mean 4.87", "do", "high-priority", "yes", [], cond="evidence: R01-061, R01-120, R01-146")
c(181, "Part 8 #20", "product-rule", "Stay minimal and ad-free — 'simple/clean' is 32.2% of US reviews, 'no ads' has the highest mean of any theme (4.91), and every request for more features is paired with 'but don't make it complicated'",
  "minimal, ad-free", "praise", "32.2% of US; no-ads mean 4.91", "product-rule", "high-priority", "yes", [], cond="evidence: R01-060, R01-077")
c(182, "Part 8 #21", "do", "Offer a design that isn't pastel/cute-by-default — a recurring complaint from men and from users wanting a premium look",
  "pastel/cute default", "complaint", "recurring, uncounted", "do", "repeated", "yes", [], cond="evidence: R01-116")
c(183, "Part 8 #22", "do", "Localise early — it directly unlocks revenue: Spanish 182 requests, Portuguese 162, French 48, Russian 44, Turkish 43, Arabic, Korean; users state plainly they would buy in their language; Japan proved it mid-2026",
  "localised late, language by language", "blocked-conversion", "639 localisation reviews; 8.06% of non-CN reviews in 2025", "do", "high-priority", "yes", [], cond="evidence: R01-037, R01-069, R01-128, R01-132")
c(184, "Part 8 #23", "dont", "Don't build AI — 0.011% demand; build reliability instead",
  "no AI", "none", "6 of 56,653 reviews", "dont", "high-priority (negative evidence)", "yes", [], cond="evidence: R01-161")
c(185, "Part 8 #24", "dont", "Do not run review-for-premium campaigns — it gave this app 40,991 Chinese reviews, a #1 rank and a fake 4.8 average, but 0.86% purchase signal, a reputational backlash, and a dataset its own developer can no longer read honestly",
  "ran one 2019–2022", "1★-burst", "40,991 reviews; 0.86% purchase signal; ~45 backlash reviews", "dont", "high-priority", "yes", [], cond="evidence: R01-002, R01-137, R01-139")
c(186, "Part 8 #25", "dont", "Do not gate reviews — two users caught it, one called it an Apple ToS violation, one documented a critical review being deleted",
  "gated reviews", "complaint", "9 explicit complaints", "dont", "weak count, reputational", "yes", [], cond="evidence: R01-005")

# ---- Appendix method: one data-caveat card ----
c(187, "Appendix — method", "data-caveat", "Method: every review processed; all 1–3★ and substantive reviews read individually; contentless reviews aggregated by frequency; 62 themes applied across 20+ languages; four denominators; three regex false-positive classes corrected",
  "n/a", "none", "56,653 reviews; 62 themes; 45 countries with 50+ reviews", "none", "method", "yes", [],
  cond="this report predates the current Store Review Analysis Prompt structure (no Part 9 appendix, different part numbering)")

with open("Tools/prd_ledger/1/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
