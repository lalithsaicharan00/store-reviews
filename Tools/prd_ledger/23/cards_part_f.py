"""Cards for report 23 — Part 9 (time trends), Part 10 (competitor lessons), Part 11 (product implications)."""
import json, re
R = 23
rep = open("App Store Reports/23. Streaks - The habit-forming to-do list (REPORT).md").read().split("\n")
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
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").replace("`","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- §9.1
c(191, "§9.1 Method — two lenses: calendar year and product era cut at the two capacity releases (E1 6 tasks n=2,743; E2 12 tasks n=2,577; E3 24 tasks n=1,950); era table (verbatim)", "data-caveat",
  "Trend method: calendar year and product era, cut at the two capacity releases reviewers themselves date — E1 1 Jun 2015–24 Jul 2017 (6 tasks, n=2,743, 37.7%), E2 25 Jul 2017–27 Jul 2021 (12 tasks, n=2,577, 35.4%), E3 28 Jul 2021–6 Sep 2026 (24 tasks, n=1,950, 26.8%); era boundaries inferred from review text, not metadata; every per-era metric carried verbatim",
  "n/a", "mixed", table("| Metric | E1 | E2 | E3 |"), "none", "method", "app-specific",
  ["1698329281","1702122919","1706205633","7636542975","7641339972","7668026683","7693289034","7713133373"])
# ---- §9.2
c(192, "§9.2 Trend 1 — the rating decline is real, dated, driven by reliability [very strong]: sync 7.1×, data loss 14×, widget bugs 52×; price flat, capacity falls after each release", "timeline",
  "Mean falls 4.56 → 4.08 → 3.83 across three eras (n ≥ 1,950 each); the themes rising in lockstep are sync (1.42% → 10.15%, 7.1×), data loss (0.33% → 4.62%, 14×) and widget bugs (0.04% → 2.10%, 52×); price is flat and capacity falls after each release — neither explains the decline",
  "reliability regressed post-2021", "churn", "mean 4.56 → 4.08 → 3.83; sync 7.1×; data loss 14×; widget bug 52×", "must-never-break", "very strong", "yes", [])
c(193, "§9.2 Confounder — the 2017 App Store review-prompt API change reduced low-effort 5★ volume (1,185 → 468); part of the 2017→2018 step is a platform artefact, but the 2021→2026 continuation is not", "data-caveat",
  "Confounder acknowledged: the 2017 review-prompt API change mechanically reduced low-effort 5★ reviews across all apps (volume 1,185 in 2017 → 468 in 2018), so part of the 2017→2018 step is a platform artefact — but the 2021→2026 continuation is not: volume is roughly flat 2021–2023 while the mean keeps falling and sync/data-loss keeps rising",
  "n/a", "none", "2017 1,185 → 2018 468", "none", "method", "yes", [])
# ---- §9.3
c(194, "§9.3 Trend 2 — the iCloud sync migration is the sharpest single event [very strong]: sync 25 (2021) → 60 (2022) → 40 → 24; data loss 6 → 17 → 22 (2024); tail visible in 2026", "timeline",
  "The iCloud sync migration (Mar 2022) is the sharpest single event: sync complaints 25 (2021) → 60 (2022) → 40 (2023) → 24 (2024), rate 1.42% (2015–17) → 7.60% (Jan 2022 on); data loss 6 (2021) → 17 (2022) → 22 (2024); the tail is still visible in 2026",
  "sync migration 2022", "1★-burst", "sync 25 → 60 → 40 → 24; data loss 6 → 17 → 22", "must-never-break", "very strong", "yes",
  ["8482253962","13491181225","13319734610","14156559364"])
# ---- §9.4
c(195, "§9.4 Trend 3 — capacity complaints fall after each release then rebound; each release buys roughly three years [very strong]", "timeline",
  "Capacity complaints fall after each cap release and then rebound — 8.76% (2016, cap 6) → 5.06% (2017, raised) → 12.18% (2018, cap 12) → 11.90% (2021, raised) → 6.16% (2022, cap 24) → 8.13% (2025); each release buys roughly three years",
  "raised cap twice", "complaint", "8.76 → 5.06 → 12.18 → 11.90 → 6.16 → 8.13%", "undecided", "very strong", "yes", [])
# ---- §9.5
c(196, "§9.5 Trend 4 — simplicity praise is being spent [very strong]: 43% relative decline while UI confusion rises ~8×", "timeline",
  "Simplicity praise fell 32.30% → 20.80% → 18.36% (a 43% relative decline) while UI-confusion complaints rose nearly 8×; reviewers date the loss to the July 2017 feature expansion",
  "feature accretion", "churn", "32.30 → 20.80 → 18.36%; UI confusion ~8×", "product-rule", "very strong", "yes", [])
# ---- §9.6
c(197, "§9.6 Trend 5 — the pricing model becomes a stronger differentiator over time [very strong]: 3.61% → 5.55% → 8.00%", "monetization",
  "'No subscription' praise rose 3.61% → 5.55% → 8.00% across eras — as the category subscription-ised, an eleven-year-old one-time purchase became the reason to choose it; the one competitive position that strengthened",
  "one-time purchase held for eleven years", "purchase-driver", "3.61% → 5.55% → 8.00%", "build-paid", "very strong", "yes", [])
# ---- §9.7
c(198, "§9.7 Trend 6 — neurodivergent adoption nearly triples [meaningful]; several double as the strongest capacity complaints because task decomposition is what executive-function support requires; an explicit accusation of ableism", "audience",
  "Neurodivergent self-identification rose 0.66% → 0.70% → 1.90%, concentrated in 2022–2026 (mean 4.45); several of these reviews double as the strongest capacity complaints because task decomposition is exactly what executive-function support requires — one is an explicit accusation of ableism against the help-page wording",
  "cap hurts the segment most suited to the product", "mixed", "0.66% → 0.70% → 1.90%; 17 reviews 2022–26 cited; mean 4.45", "do", "meaningful", "yes",
  ["8266328218","8428275405","8432447980","8577993480","9514806382","9822595740","9855154146","10779334259","11121463145","11141541374","11285333857","11390335993","12333316832","12845331532","13274948716","13528928858","14469956788","5516647636","6888486242","8975182976","12523694361","13180845529"])
# ---- §9.8
c(199, "§9.8 Trend 7 — the corpus is drying up [very strong]: trailing twelve months 156 reviews (2.15%); 2026 is the worst year on record (mean 3.29, 24.6% 1★, n=118)", "timeline",
  "Monthly volume 2024–2026 fell 59 (Jan 24) → 25 (Dec 24) → 34 (Jan 25) → 12 (Dec 25) → 26 (Jan 26) → 6 (Sep 26, partial); the trailing twelve months supply 156 reviews (2.15%); 2026 is the worst year on record — mean 3.29, 24.6% 1★, 36.4% 5★ (n=118, meaningful but small)",
  "declining review volume", "churn", "TTM 156 (2.15%); 2026 mean 3.29, 24.6% 1★, n=118", "none", "very strong (volume); meaningful but small (2026)", "app-specific", [])
# ---- §9.9
c(200, "§9.9 Trends explicitly NOT claimed — no pricing-damage, monetisation-abuse, AI, support-collapse or competitor-displacement trend", "data-caveat",
  "Trends not claimed: no pricing-damage trend (objections flat across a 2.5× rise); no monetisation-abuse trend (no subscription, paywall shift or revocation in 7,270 reviews); no AI trend (one review, asking for removal); no support-collapse trend (praise 49 and failures appear across all eras without direction); no competitor-displacement trend (≤14 mentions each)",
  "n/a", "none", "report gives none (non-claims)", "none", "non-claim", "yes",
  ["14069398191","2168151281","3324443697","6513442179","7429308689","10450266476","11693785508","12008652692"])

# ---- Part 10 competitor lessons
c(201, "Part 10 #1 — a hard cap is a durable, defensible position and a permanent 6–12% complaint tax; do not adopt the cap without a pressure valve", "product-rule",
  "A hard cap on tracked habits is a durable, defensible product position — and a permanent 6–12% complaint tax; both halves are true; do not adopt a cap without a pressure valve", "hard cap, no valve", "mixed", "6–12% complaint rate every year for twelve years", "product-rule", "very strong", "yes", [])
c(202, "Part 10 #2 — press-and-hold beats tap; copying 'tap to complete' loses something real", "insight",
  "Press-and-hold beats tap: reviewers describe the deliberate friction as the source of satisfaction and as accident-proofing — copying 'tap to complete' loses something real", "press-and-hold", "praise", "attested inside themes 1 and 3", "build-free", "interpretation", "yes", [])
c(203, "Part 10 #3 — HealthKit auto-completion is the single highest-leverage integration in the category", "insight",
  "HealthKit auto-completion is the single highest-leverage integration in this category — it removes the friction that killed every other habit app the reviewer tried", "HealthKit auto-complete", "praise", "277 reviews", "build-paid", "very strong", "yes", [])
c(204, "Part 10 #4 — binary completion throws away the data users most want; ship floor-without-ceiling and a partial-progress calendar state", "product-rule",
  "Binary completion throws away the data users most want; ship a floor-without-ceiling goal model and a partial-progress calendar state", "binary", "complaint", "the two most-upvoted reviews in 7,270", "undecided", "meaningful", "yes", ["9145507788","8642992805"])
c(205, "Part 10 #5 — the Apple Watch is a purchase driver, not a feature; its reliability budget is your main reliability budget", "product-rule",
  "The Apple Watch is a purchase driver, not a feature: people buy for it and churn on it — if you ship a Watch app, its reliability budget is your main reliability budget", "Watch as purchase driver", "churn", "≥15 buy-for-Watch; 241 negative mentions", "must-never-break", "very strong", "yes", [])
c(206, "Part 10 #6 — one-time pricing is a growing wedge, not a legacy handicap", "insight",
  "One-time pricing is a growing wedge, not a legacy handicap — 398 reviews name it and the rate more than doubled across eleven years", "one-time", "purchase-driver", "398; 3.61% → 8.00%", "build-paid", "very strong", "yes", [])
c(207, "Part 10 #7 — loss-framed notifications draw complaints in four languages; frame gains", "product-rule",
  "Loss-framed notifications ('you will lose your streak') draw complaints in four languages — frame gains", "loss-framed copy", "complaint", "4 languages", "product-rule", "limited evidence", "yes", [])
c(208, "Part 10 #8 — never let sync be last-writer-wins", "must-never-break",
  "Never let sync be last-writer-wins — a customer review spells out the correct architecture (append-only timestamped events, merged)", "last-writer-wins", "complaint", "223 sync complaints", "must-never-break", "very strong", "yes", ["10815885619"])
c(209, "Part 10 #9 — undo must be a button; shake-to-undo produced 77 complaints, several ending in deleting the app", "must-have",
  "Undo must be a button — shake-to-undo produced 77 complaints, several of which end in deleting the app", "shake-only undo", "churn", "77 (1.06%)", "must-have", "meaningful", "yes", [])
c(210, "Part 10 #10 — machine-translated help text is visible and expensive; lands hardest in markets already objecting to price", "dont",
  "Machine-translated help text is visible and expensive — German, Chinese, Russian, Swedish, Korean and Taiwanese reviewers all name it, and it lands hardest in the markets already objecting to price", "machine-translated help", "complaint", "6 languages", "dont", "weak but cross-market", "yes", [])

# ---- Part 11 product implications
c(211, "§11.1 R1 — replace last-writer-wins iCloud sync with an append-only, timestamped event log; merge, never overwrite", "must-never-break",
  "R1: replace last-writer-wins iCloud sync with an append-only, timestamped event log — merge, never overwrite; addresses the largest post-2021 rating driver and its downstream data-loss theme", "last-writer-wins", "complaint", "223 reviews, mean 3.08; 7.60% of post-2022", "must-never-break", "very strong", "yes",
  ["10815885619","13491181225","9146983436","11764467723"])
c(212, "§11.1 R2 — make automatic backups visible and recoverable from the first-run tutorial, not from a support email", "must-have",
  "R2: make automatic backups visible and recoverable from the first-run tutorial, not a support e-mail — converts a 1★ catastrophe into a 30-second recovery; several reviewers upgraded on learning the path existed", "backup hidden", "mixed", "4 reviews cited", "must-have", "emerging", "yes",
  ["8527464658","8553855848","10386986461","12123846705"])
c(213, "§11.1 R3 — fix the Watch completion round-trip and complication refresh; publish a Watch-first test matrix", "must-never-break",
  "R3: fix the Watch completion round-trip and complication refresh and publish a Watch-first test matrix — protects the purchase driver in kr/jp and the highest-value churn segment", "Watch round-trip broken", "churn", "241 negative, mean 3.13; 49 explicit bugs, mean 2.57", "must-never-break", "very strong", "yes", ["12008652692"])
c(214, "§11.1 R4 — fix pause/archive so paused days are neutral, not missed", "must-never-break",
  "R4: fix pause/archive so paused days are neutral, not missed — small, self-contained, currently defeats the feature entirely", "pause marks missed", "complaint", "4 reviews cited", "must-never-break", "emerging", "yes",
  ["10656649260","10772984090","11138802961","11219449203"])
c(215, "§11.1 R5 — fix the Korean Hangul composition bug in the task-title field", "must-never-break",
  "R5: fix the Korean Hangul composition bug — trivially cheap, five years unaddressed, hits the storefront with the worst refund rate", "IME bug", "complaint", "4 reports", "must-never-break", "limited evidence", "yes",
  ["5541895076","5747933646","5998909121","6586522274"])
c(216, "§11.2 U1 — add a visible Undo: keep shake-to-undo, add a button and a long-press-to-uncomplete path", "must-have",
  "U1: add a visible Undo — keep shake-to-undo, add a button and a long-press-to-uncomplete path", "shake only", "complaint", "77 reviews, mean 3.38, 12 storefronts", "must-have", "meaningful", "yes", [])
c(217, "§11.2 U2 — add a discoverable Edit/Delete affordance on the task itself", "must-have",
  "U2: add a discoverable Edit/Delete affordance on the task itself", "hidden edit/delete", "complaint", "5 reviews cited within 250", "must-have", "very strong", "yes",
  ["1428576781","3934184360","4219370308","9212927813","13176889519"])
c(218, "§11.2 U3 — replace the icon-only first run with a short, text-labelled walkthrough covering add / complete / edit / delete / undo / pages", "must-have",
  "U3: replace the icon-only first run with a short text-labelled walkthrough covering add / complete / edit / delete / undo / pages — U1–U3 target the worst-rating-profile theme and require no change to the design language", "icon-only tutorial", "complaint", "63 of 650 1★; 66-upvote review asks for exactly this", "must-have", "very strong", "yes",
  ["3225476511","10130810601","11129306077","13611667253"])
c(219, "§11.3 P1 — optional capacity beyond 24, off by default, behind a setting that states the rationale; the default must not change", "feature",
  "P1: optional capacity beyond 24, off by default, behind a setting that states the rationale — the default must not change; the 118 defenders are the reason the other 1,780 like the product", "hard cap", "complaint", "620 asks (8.53%) + 118 defenders", "undecided", "high-priority", "yes", [],
  cond="opt-in only; default untouched")
c(220, "§11.3 P2 — floor-without-ceiling goals + partial-progress calendar state; do not change the streak rule, only what is recorded and shown", "feature",
  "P2: floor-without-ceiling goals and a partial-progress calendar state — a goal of 8 glasses should record 12; a 6-of-8 day should render as a partial ring, not ✗; do not change the streak rule, only what is recorded and shown", "binary", "complaint", "77 reviews + the two most-upvoted", "undecided", "meaningful", "yes",
  ["9145507788","8642992805"], cond="streak rule unchanged")
c(221, "§11.3 P3 — reframe reminder copy from loss to gain; one string change per locale", "product-rule",
  "P3: reframe reminder copy from loss to gain — one string change per locale", "loss-framed", "complaint", "4 reviews", "product-rule", "limited evidence", "yes",
  ["7473616926","10648344883","11042287057","13098714560"])
c(222, "§11.3 P4 — restore an interactive widget path (iOS 17+ App Intents) and stop blank-widget regressions", "feature",
  "P4: restore an interactive widget path (iOS 17+ App Intents) and stop the blank-widget regressions", "no interactive widget since 2020", "complaint", "36 named requests over five years; 20 blank-widget reports", "undecided", "very strong", "yes", [])
c(223, "§11.3 P5 — year heat-map and history beyond two months; the single most-named competitor feature gap (Habitify)", "feature",
  "P5: a year heat-map and history beyond two months — the single most-named competitor feature gap (Habitify)", "two-month history", "complaint", "46 reviews", "undecided", "emerging", "yes",
  ["13647744905","11032222087","13136255685","6494025558"])
c(224, "§11.3 P6 — yearly and arbitrary-interval scheduling (every N weeks, quarterly, specific dates of month)", "feature",
  "P6: yearly and arbitrary-interval scheduling — every N weeks, quarterly, specific dates of the month", "absent", "complaint", "101 frequency reviews", "must-have", "meaningful", "yes",
  ["9436431103","11315859157","12537226420","9989040594","14320549167"])
c(225, "§11.3 P7 — optional density control: a list view or 3×4 layout per page; opt-in only because 8.9% of that theme's reviews are 1★ precisely because the app changed on them", "feature",
  "P7: optional density control — a list view or 3×4 layout, per page, opt-in only: 8.9% of that theme's reviews are 1★ precisely because the app changed on them", "fixed 2×3 grid", "complaint", "45 reviews", "undecided", "emerging", "yes",
  ["10475031837","11548743644","13528143060","14156553445"], cond="opt-in only")
c(226, "§11.4 S1 — state the task cap in the App Store description; reviewers say it is not disclosed and asked for refunds on that basis", "do",
  "S1: state the task cap in the App Store description — reviewers explicitly say it is not disclosed and asked for refunds on that basis", "cap undisclosed in listing", "blocked-conversion", "4 reviews cited", "do", "limited evidence", "yes",
  ["9540311476","5996825854","12880039039","2277807179"])
c(227, "§11.4 S2 — lead the listing with the streak mechanism + HealthKit automation, not 'to-do list'", "do",
  "S2: lead the listing with the streak mechanism and HealthKit automation, not 'to-do list' — the 68 'no value / just a checklist' 1★ reviews are an expectation failure, not a product failure", "listing says to-do list", "complaint", "68 1★ (0.94%)", "do", "emerging", "yes", [])
c(228, "§11.4 S3 — consider a time-limited trial or demo mode; counter-evidence 'There's no trial because it doesn't need one'", "monetization",
  "S3: consider a time-limited trial or a demo mode — 15 reviews name the absence of a trial (mean 2.40) and it appears as a stated regret in refund reviews; counter-evidence: 'There's no trial because it doesn't need one'", "no trial", "blocked-conversion", "15 (0.21%, weak), mean 2.40", "research", "weak", "yes", ["10455680816"])
c(229, "§11.4 S4 — fix German, Chinese, Russian, Swedish and Korean help text and notification strings", "do",
  "S4: fix German, Chinese, Russian, Swedish and Korean help text and notification strings", "poor localisation", "complaint", "see 8.3, 8.5, 8.9", "do", "weak but cross-market", "yes", [])
c(230, "§11.4 S5 — recognise the neurodivergent segment explicitly in the listing and in the capacity rationale; handle carefully — current help-page wording called ableist", "do",
  "S5: recognise the neurodivergent segment explicitly in the listing and in the capacity rationale — it is the fastest-growing high-satisfaction segment (0.66% → 1.90%), arrives on clinical recommendation, and its members are the ones most hurt by the cap; handle carefully: one review calls the current help-page wording ableist", "not addressed", "mixed", "0.66% → 1.90%", "do", "meaningful", "yes", ["5516647636"])
c(231, "Part 11 #1 — capacity valve A/B: unlock pages 5–8 for a cohort; measure 90-day retention and rating delta", "do",
  "Experiment 1: capacity valve A/B — unlock pages 5–8 behind a setting for a random cohort and measure 90-day retention and rating delta against the constrained cohort; the corpus predicts the complaint falls but cannot say whether retention falls", "n/a", "none", "report gives none (experiment)", "research", "experiment", "yes", [])
c(232, "Part 11 #2 — onboarding rewrite: measure day-3 deletion rate against the icon-only tutorial", "do",
  "Experiment 2: onboarding rewrite — measure day-3 deletion rate against the current icon-only tutorial; the corpus predicts a large effect on the 1★ rate", "n/a", "none", "report gives none (experiment)", "research", "experiment", "yes", [])
c(233, "Part 11 #3 — notification copy: loss-framed vs gain-framed; measure completion and notification-disable rate", "do",
  "Experiment 3: notification copy loss-framed vs gain-framed — measure completion rate and notification-disable rate", "n/a", "none", "report gives none (experiment)", "research", "experiment", "yes", [])
c(234, "Part 11 #4 — partial-progress rendering: does replacing ✗ with a partial ring change 30-day retention after a missed goal?", "do",
  "Experiment 4: partial-progress rendering — does replacing ✗ with a partial ring change 30-day retention after a missed goal?", "n/a", "none", "report gives none (experiment)", "research", "experiment", "yes", [])
c(235, "§11.6 Research questions this corpus cannot answer", "data-caveat",
  "Open research questions: what fraction of buyers never review; actual retention and whether the cap raises or lowers it; how many refunds were granted; whether the 2017 and 2021 capacity releases moved revenue or only sentiment; whether the 2022 sync spike is a code regression or an iOS/CloudKit platform change; whether the Apple Design Award still drives installs and at what quality",
  "n/a", "none", "report gives none (questions)", "research", "open questions", "yes", [])

with open("Tools/prd_ledger/23/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
