import json, re
R = 12
rep = open("App Store Reports/12. That Girl - Routine Planner - Cute Daily Calendar Schedule (REPORT).md").read().split("\n")
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(67, "Part 9 Immediate — billing integrity #1 Fix the paid-access path end to end", "must-never-break",
  "Fix the paid-access path end to end — subscription recognition, Restore Purchase, account login (HTTP 400), new-device restore; every other monetization improvement is worthless while a paid user can be locked out",
  "entitlement failures", "1★-burst", "33 (8.17% global / 41.25% of paid) mean 1.15, rising through 2025", "must-never-break", "recommendation (immediate)", "yes", [])
c(68, "Part 9 Immediate — billing integrity #2 Make the support address work and publish it in-app", "must-have",
  "Make the support address work and publish it in-app — an unreachable address converts recoverable bugs into 1★ 'scam' reviews and refund requests",
  "support email bounces", "1★-burst", "15 (3.71%); 5 say the address does not exist", "must-have", "recommendation (immediate)", "yes", [])
c(69, "Part 9 Immediate — billing integrity #3 Fix 'Restore Purchase' redirecting to the privacy policy", "must-never-break",
  "Fix Restore Purchase redirecting to the privacy policy — named identically by two GB reviewers a year apart, a specific reproducible defect",
  "restore button mis-wired", "1★-burst", "2 identical reports a year apart", "must-never-break", "recommendation (immediate)", "yes",
  ["12608420898","14151717931"])
c(70, "Part 9 Immediate — billing integrity #4 Triage the cross-account events report", "must-never-break",
  "Triage the report of events appearing from another account — a data-boundary defect warrants investigation regardless of frequency",
  "possible data leak", "complaint", "n=1", "must-never-break", "recommendation (immediate)", "yes",
  ["13812177642"])
c(71, "Part 9 Immediate — disclosure #5 Move 'purchase required to access any content' into the first screenshot and the subtitle", "do",
  "Move 'purchase required to access any content' from the description body into the first screenshot and the subtitle — the sentence already exists; nobody reads it in place",
  "disclosure buried in description", "blocked-conversion", "162 (40.10%)", "do", "recommendation (immediate)", "yes", [])
c(72, "Part 9 Immediate — disclosure #6 Move any rating request to after first meaningful use; standard SKStoreReviewController only", "dont",
  "Move any rating request to after first meaningful use, using only the standard SKStoreReviewController flow with no incentive, no instruction and no gating",
  "pre-use 5★ instruction", "1★-burst", "23 (5.69%), 11.1% of 2026", "dont", "recommendation (immediate)", "yes", [])
c(73, "Part 9 Immediate — disclosure #7 Collapse the SKU ladder", "dont",
  "Collapse the SKU ladder — three weekly and three yearly SKUs at different prices are visible to every prospect on the store page and read as manipulation",
  "10 SKUs, duplicate names", "1★-burst", "8 describe exit-offer; 42 use 'scam'", "dont", "recommendation (immediate)", "yes", [])
c(74, "Part 9 Near-term product #8 Ship a home-screen widget", "feature",
  "Ship a home-screen widget — the highest-value-per-effort item on the list",
  "absent", "complaint", "9 requests, all 2024+, mean 2.44, one 5★", "build-free", "recommendation (near-term)", "yes", [])
c(75, "Part 9 Near-term product #9 Fix time editing; #10 Fix recurring tasks incl. weekday-only repeats; #11 Make calendar sync work or stop advertising it", "must-never-break",
  "Fix time editing (start/end overwriting each other, no AM/PM toggle, military-time lock), fix recurring tasks including weekday-only repeats and reminders that carry day to day (the oldest unfixed request, 3y10m), and make Google/Apple Calendar sync actually work or stop advertising it ('it said it was doing it but just kept loading')",
  "three open defects", "complaint", "time 8 (repro still open 2026); recurring 8 over 3y10m; sync 8", "must-never-break", "recommendation (near-term)", "yes",
  ["14056969118","12021381513"])
c(76, "Part 9 Near-term product #12 Stop forcing the food photo; let preset daily tasks be disabled; allow unit choice in the water tracker", "must-have",
  "Stop forcing the food photo, let preset daily tasks be disabled, allow unit choice in the water tracker — the most detailed feature critique is the specification",
  "forced defaults, no unit choice", "complaint", "13 customisation reviewers, 10 US", "must-have", "recommendation (near-term)", "yes",
  ["10037371405"])
c(77, "Part 9 Near-term product #13 Ship an iPad layout", "feature",
  "Ship an iPad layout — currently iPhone-only; 'Please make an iPad version so I can buy the lifetime subscription!' is a stated purchase blocker",
  "iPhone only", "blocked-conversion", "n=1 stated blocker; 7 Watch/iPad requests", "build-paid", "recommendation (near-term)", "yes",
  ["11678330257"])
c(78, "Part 9 Monetization #14 Introduce a genuinely functional free tier or a working trial — the single largest lever", "monetization",
  "Introduce a genuinely functional free tier or a working trial — the single largest lever in the corpus: 188 blocked, 172 left without paying; even a 3-day trial that WORKS addresses the 2025–26 complaint shape",
  "hard paywall, broken trial", "blocked-conversion", "188 (46.53%); 172 never paid", "build-free", "recommendation", "yes", [])
c(79, "Part 9 Monetization #15 Let people see the planner before the paywall — the gate is protecting a proposition that cannot survive inspection", "product-rule",
  "Let people see the planner before the paywall — 13 reviewers who got in say it is not differentiated from Apple Calendar, so the current gate is protecting a proposition that cannot survive inspection; fixing that is a product problem, and hiding it is not a solution",
  "hard paywall over an undifferentiated product", "churn", "13 (3.22%) mean 1.38", "product-rule", "recommendation", "yes", [])
c(80, "Part 9 Monetization #16 Localise to DE, PT-BR, ES, FR, IT, ZH-Hant", "market",
  "Localise to DE, PT-BR, ES, FR, IT, ZH-Hant — 16% of reviews are non-English against an English-only build; one reviewer names localisation + price as a conditional purchase",
  "English only", "blocked-conversion", "64 of 404 (15.84%)", "build-free", "recommendation", "yes",
  ["9014887127"])
c(81, "Part 9 Monetization #17 Reconsider the gendered brand in more markets — treat the es/mx rename as an existing A/B result", "tactic",
  "Reconsider the gendered brand in more markets — the developer already ships a gender-neutral name in es/mx, the two highest-rated storefronts sampled; treat that as an existing A/B result worth extending and measuring",
  "gendered brand with a neutral variant in two storefronts", "mixed", "es 4.84, mx 4.78", "research", "recommendation", "yes", [])
c(82, "Part 9 For a competitor entering this category — #1 hard paywall with no trial produces a 61.63% one-star base; #5 aesthetic alone does not retain", "product-rule",
  "For a competitor: a hard paywall with no trial produces a 61.63% one-star written-review base — the mechanism is not price sensitivity, it is the inability to evaluate; ship an evaluable free tier and you differentiate on the axis 188 reviewers named; aesthetic alone does not retain (11 of 17 design-praisers rated 1–2★)",
  "n/a", "blocked-conversion", "1★ 249 of 404 (61.63%); 188 blocked; 11 of 17 aesthetic at 1–2★", "product-rule", "competitor lesson", "yes", [])
c(83, "Part 9 For a competitor #2 The praised job-to-be-done is narrow and clear — plan my day for me; #3 onboarding: ship narrated AND skippable; #4 six named unmet requests", "do",
  "For a competitor: the praised job is narrow and clear — 'plan my day for me so I stop losing track of it', disproportionately voiced by ADHD and autistic users — build for that explicitly; narrated personalisation converts and unskippability cost 21 reviews, so ship both narrated and skippable; widgets, Watch, iPad, weekday-repeat, working sync and 12-hour time are a backlog someone else has already validated",
  "n/a", "praise", "outcome praise 22 mean 4.95; onboarding 21 against; 6 named requests", "do", "competitor lesson", "yes",
  ["12286335035","13203951770","9013967197"])
c(84, "Part 9 Research questions this corpus cannot answer; part 9 #1; part 9 #2; part 9 #3; part 9 #4; part 9 #5; part 9 #6", "data-caveat",
  "Research questions: did the 2024 5★ step-change come from the rating prompt, a product improvement, or both; was the water/food/journal set actually removed in 2024 or did the reviewer lose access via the entitlement bug; why is the rating-prompt complaint 1.48% in the US vs 5.69% globally; actual trial→paid and refund rates; does the ES/MX gender-neutral rename outperform controlling for market; is 'WSTR: Daily Planner Schedule' (same developer, ID 6478762880) the 'exact same app with another name' a reviewer alleges",
  "n/a", "none", "6 questions", "research", "research questions", "yes",
  ["11901631540","12215752061"])

with open("Tools/prd_ledger/12/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
