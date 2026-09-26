import json, re
R = 10
rep = open("App Store Reports/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
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

# ---- HEADER ----
c(1, "header lines 1-8", "positioning",
  "Finch: Self-Care Pet (App Store ID 1528595748) is a self-care habit/journal app built around emotional attachment to one virtual bird pet, monetised by a 'Finch Plus' subscription with a free trial and a Guardian sponsored-membership programme; by far the largest corpus in the set — 70,041 written reviews at mean 4.7631, 87.88% five-star",
  "developer Finch Care Public Benefit Corporation; bundle com.finch.finch; store rank 10 in this set; 121 storefronts; 13 May 2021 → 7 Sep 2026 (5 yr 4 mo); free download with Finch Plus subscription", "praise",
  "70,041 reviews; 5★ 61,550 (87.88%) · 4★ 4,655 (6.65%) · 3★ 1,333 (1.90%) · 2★ 742 (1.06%) · 1★ 1,761 (2.51%); mean 4.7631; 100% coverage, zero duplicate IDs, exact manifest reconciliation", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; §1.1 Files and schema; §1.2 Coverage and reconciliation; §1.3 Processing method; §1.4 What is not claimed; §1.5 Known limitations and biases; §10.1 counting rules", "data-caveat",
  "Method: denominator 70,041, non-exclusive themes, standard signal bands; corpus is 87.9% five-star so every complaint rate is compressed (a 0.8% theme is 560 reviews and can be 8–9% of the 1★ band) — segment rates are always labelled with their own denominator; NO external sources used, prices/features/release timings are [corpus-derived]; three-layer method: 88-theme compound regex rules over all 70,041 records + complete human reading of all 3,836 ≤3★ reviews + ~1,200 4★ reviews + two validation passes (~85–92% precision on complaint themes, recall unmeasured, so ALL complaint counts are lower bounds); automated theme detection is English-only so every theme rate for 21 non-English storefronts (de, fr, es, mx, br, ru, cn, jp, tr, it, pt, pl, cz, dk, se, no, fi, nl, at, ch, be — 3,840 reviews, 5.48%) is a floor; 40.92% of reviews (28,662) matched no theme (median body 79 chars, 89.5% five-star, mean 4.806; tag rate 81.8% for 200+ char bodies, 68.2% for ≤3★); votes sparse (2,605 reviews, 3.72%); date-of-writing not date-of-experience (977 edits); paid cohort (1,381) is a conservative floor biased toward billing grievances; no conversion/retention/revenue, no causal claims, no public-rating-vs-written gap computable; deduplication not applied (120 groups / 284 records of identical generic praise kept)",
  "n/a", "none", "70,041 / 70,041 parsed; 121 by_country files exact; ratings 1:1761 2:742 3:1333 4:4655 5:61550; mean 4.7631 matches manifest; 0 empty bodies/titles; is_edited 977 (1.39%); signal bands <0.1% ignore · 0.1–0.5% weak · 0.5–1% emerging · 1–3% meaningful · 3–5% very strong · >5% high-priority", "none", "method", "yes", [])
c(3, "§1.1 Files and schema table (verbatim); §1.2 Coverage and reconciliation table (verbatim)", "data-caveat",
  "Files, schema and reconciliation tables",
  "n/a", "none", table("## 1.1 Files and schema") + " ;; " + table("## 1.2 Coverage and reconciliation"), "none", "verbatim", "app-specific", [])

# ---- FIVE THINGS ----
c(4, "⚠️ Read these five things — 1. The paying cohort is the only cohort whose satisfaction is collapsing; EXECUTIVE SUMMARY #1 Paid-user sentiment is in free-fall while the headline rating is not; §6.1", "insight",
  "The paying cohort is the only cohort whose satisfaction is collapsing, and it has collapsed by 1.4 stars while the public rating barely moves: the headline number is held up by an ever-growing base of new free users while the monetised cohort curdles — the single most important number in the corpus",
  "subscription (Finch Plus) with free trial; free tier generous", "churn",
  "1,381 paid-evidence reviews (1.97%); paid mean 4.40 (2022) → 4.01 (2023) → 3.82 (2024) → 3.19 (2025) → 2.96 (2026); non-paid mean 4.785 overall; corpus mean 4.864 → 4.645; in 2026 36.7% of paid-evidence reviews are 1★ (92/251)", "product-rule", "high-priority (headline)", "yes", [],
  cond="paid cohort is a floor biased toward billing grievances (§6.2)")
c(5, "⚠️ 2. 'You promised to remind me before charging' is the highest-intensity complaint in the corpus; EXECUTIVE SUMMARY #2 The trial-to-subscription flow is the largest reputational liability; §4.2; §6.3", "must-never-break",
  "'You promised to remind me before charging' is the highest-intensity complaint: the app states it will warn users before the trial converts, reviewers say it does not, or that they were charged immediately on starting the 'free' trial; with cancellation friction and refund refusal this is the worst-rated family in the corpus, repeated verbatim across five years, 20+ storefronts and every language — and it is NOT a pricing objection (only 92 of 596 price complaints come from payers vs 241 of 404 billing disputes)",
  "free trial with a promised pre-charge reminder that reviewers say never arrives", "1★-burst",
  "M-trial-no-reminder 160 reviews mean 1.98; M-trial-charged 149 mean 1.79; billing-dispute family 404 (0.58%, EMERGING) mean 1.97, 244 are 1★; 17.45% of all paid-evidence reviewers (241/1,381) are in it", "must-never-break", "high-priority (headline)", "yes", [])
c(6, "⚠️ 3. Data loss is a structural product defect, not an incident, and it is getting worse; EXECUTIVE SUMMARY #3 Local-only storage is the second liability; §4.3; §8.4", "must-never-break",
  "Data loss is a structural defect, not an incident: progress is stored on-device, backup is manual and opt-in, and the standard support remedy is a new bird plus 5,000 rainbow stones — offered to users who had 20,000–200,000 stones and multi-year streaks; in an app whose entire retention mechanic is emotional attachment to one pet this converts the greatest strength into the greatest liability",
  "local-only storage; manual opt-in backup; remedy = new pet + 5,000 stones", "1★-burst",
  "551 reviews (0.79%, EMERGING globally; 9.09% of all 1★); data-integrity family (D-data-loss + D-no-backup + D-login-account + D-sync-devices) 0.42% (2022H1) → 1.76% (2026H1); 37 explicit 'no automatic backup'; 90 'cannot log back in'", "must-never-break", "high-priority (headline)", "yes", [])
c(7, "⚠️ 4. Two dated engineering failures visible at day resolution; §8.2 Trend 1", "timeline",
  "Two dated engineering failures visible at day resolution: 4 May 2022 crash-on-launch (largest quality event in the app's history at that time) and February 2026 'Wonderland / Queen of Hearts' event whose growth-potion animation made the pet oversized and crashed the app on load — reviewers named the exact trigger",
  "monthly event shipped a crash", "1★-burst",
  "4 May 2022: 128 reviews that day vs ~90/day baseline, mean 3.72, 34 one-star, 42 crash reports in one day; Feb 2026: 120 crash-tagged reviews in one month (2.03% of all 2026 reviews vs 0.36–0.53% baseline 2023–2024), peak 20 crash reports on 2 Feb 2026", "must-never-break", "high-priority (headline)", "yes", [])
c(8, "⚠️ 5. In June 2026 the monthly event became a paid movie tie-in; EXECUTIVE SUMMARY #6 Sponsored IP events broke a stated brand promise; §8.6", "dont",
  "In June 2026 the monthly event became a paid DC/Supergirl movie tie-in and the reaction is the clearest values-breach signal in five years: subscribers say they are now paying to be advertised to, in a mental-health app, in a month they expected to be Pride — this theme did not meaningfully exist before 2025; 857 reviewers had praised Finch specifically for being ad-free",
  "sponsored IP monthly event (June 2026)", "complaint",
  "C-brand-collab 127 reviews mean 3.09; 107 (84%) in 2026, 68 in June 2026 alone; 2 in 2022, 5 in 2023, 3 in 2024; 8.0× over-represented among paid-evidence reviewers; ad-free praise 857 (1.22%)", "dont", "high-priority (headline)", "yes", [])
c(9, "⚠️ What is genuinely working, and is worth more than all of the above; EXECUTIVE SUMMARY What must be protected", "insight",
  "What is genuinely working is worth more than all the problems: nearly a third of the corpus carries a core-benefit theme at 4.89; mental-health benefit, life-change claims, ADHD/neurodivergent self-identification, clinician recommendation and free-tier/ad-free praise — each of these is directly threatened by a decision described elsewhere in the report",
  "free tier generous and ad-free; gentle tone; companion pet", "praise",
  "core-benefit 20,883 (29.82%) mean 4.89; P-mental-health 8,398 (11.99%); P-life-changed 2,686 (3.83%) mean 4.97; P-adhd-nd 5,157 (7.36%); P-therapist-rec 381 (0.54%); P-free-generous 857 (1.22%); non-punitive tone 476 mean 4.87; companionship 1,309", "must-never-break", "high-priority", "yes", [])

# ---- EXECUTIVE SUMMARY ----
c(10, "EXECUTIVE SUMMARY headline", "insight",
  "Finch is a beloved product with a 4.76 mean rating whose written record shows five years of steadily accumulating trust damage, concentrated almost entirely on people who have paid",
  "subscription self-care pet", "mixed", "mean 4.76 over 70,041; paid cohort 4.40 → 2.96", "product-rule", "headline", "yes", [])
c(11, "EXECUTIVE SUMMARY #4 Reliability is now the fastest-growing complaint family; §8.3 Trend 3", "must-never-break",
  "Reliability is now the fastest-growing complaint family and the corpus attributes it directly to monthly event releases",
  "monthly content events ship bugs", "1★-burst",
  "reliability family 1,648 (2.35%, MEANINGFUL) mean 3.32; 1.89% (2022H1) → 4.80% (2026H1); crash reports 0.36% of 2024 → 2.03% of 2026 reviews; D-event-bug 0.06% of 2025 → 0.32% of 2026", "must-never-break", "meaningful, rising", "yes", [])
c(12, "EXECUTIVE SUMMARY #5 Every major feature removal produced a measurable, dated backlash, and none were reversed; §8.5 Trend 4", "product-rule",
  "Every major feature removal produced a measurable, dated backlash and none were reversed in the corpus: Journeys → Self-Care Areas, automatic mood check-ins and affirmations, exact-time goal scheduling; generic 'you removed a feature I used' grew 16×",
  "removed Journeys (Apr–May 2025), auto mood check-ins/affirmations (Oct 2025+), exact-time goal scheduling (Nov 2025–Jan 2026)", "complaint",
  "Journeys 49 reviews mean 2.76 (36 in 2025); mood check-ins 64 mean 3.77 (49 in 2025H2–2026); timed goals 9 mean 3.11; U-feature-removed-generic 0.02% (2022) → 0.32% (2026), 16×", "product-rule", "meaningful", "yes", [])
c(13, "EXECUTIVE SUMMARY #7 Gamification is now producing measurable harm alongside its benefit; §4.5", "contradiction",
  "Gamification is now producing measurable harm alongside its benefit: streaks (added ~mid-2024) generate their own defect stream and their own pressure stream — the most common single sentence in the family is that the app now punishes a missed day in a product bought specifically because the user misses days",
  "streaks added mid-2024; streak repair monetised", "complaint",
  "gamification-harm family 1,948 (2.78%, MEANINGFUL); D-streak-bug 171 mean 3.26, 0.01% (2023) → 0.74% (2026); U-streak-pressure 96 mean 3.96", "dont", "meaningful", "yes", [])
c(14, "EXECUTIVE SUMMARY #8 A large, coherent, unserved accessibility and internationalisation demand; §4.6; §7.4", "feature",
  "A large, coherent, unserved accessibility and internationalisation demand — none are complaints about a broken thing, they are people asking to be able to keep paying",
  "English-only; no dark mode; no Apple Watch; no Apple Health; no cross-device sync; no Family Sharing", "blocked-conversion",
  "accessibility 597 (0.85%); localisation 292 (0.42%); dark mode 90; Apple Watch 92; Apple Health 608; cross-device sync 31; Family Sharing 30; Russia localisation 18.45% of all RU reviews; China 26.42%", "build-free", "emerging", "yes", [])
c(15, "EXECUTIVE SUMMARY #9 A values conflict runs in both directions and cannot be resolved by picking a side; §4.7", "insight",
  "A values conflict runs in both directions and cannot be resolved by picking a side: some object to being asked the pet's pronouns and delete on that screen, some object to LGBTQ+ content, and MORE complain there is not enough representation (these are the loyal users); the only intervention the corpus supports is optionality, not editorial change",
  "pet pronoun question in onboarding; Pride content; inclusive design", "mixed",
  "428 discuss pronouns; 54 object to being asked (mean 3.24); 109 object to LGBTQ+ content (mean 3.50); 111 want MORE representation (mean 4.57); 116 ask for religious items; 16 for a national flag", "product-rule", "meaningful", "yes", [])
c(16, "EXECUTIVE SUMMARY The prioritised ask", "do",
  "The prioritised ask: make the trial reminder real and provable; ship automatic cloud backup on by default; stop shipping monthly events without a crash gate; stop removing features people bought the app for; and decide explicitly whether the product is a self-care tool with a game attached or a collection game with self-care attached — because 2,000+ reviewers say it has silently become the second",
  "n/a", "none", "2,000+ reviewers in the gamification-harm family", "do", "recommendation", "yes", [])

with open("Tools/prd_ledger/10/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
