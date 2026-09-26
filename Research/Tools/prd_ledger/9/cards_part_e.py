import json, re
R = 9
rep = open("App Store Reports/9. Dear Me - Daily Routine Tracker - Self Care & ADHD Habit Planner (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
        elif l.startswith("#") and blocks == [] and k == 0 and False: pass
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))


# ---- PART 6 — TIME ----
c(106, "§6.1 Method period table (verbatim)", "data-caveat",
  "Three periods aligned to release history (P1 launch 14 May – 31 Dec 2024 n=464, P2 2025 n=641, P3 1 Jan – 4 Sep 2026 n=176); half-year buckets where shape matters; no trend claimed below 5 per period; headline ratings are almost flat, the composition underneath is not",
  "n/a", "none", table("## 6.1 Method"), "none", "method", "app-specific", [])
c(107, "§6.2 Trend 1 theme-by-period and half-year tables (verbatim)", "timeline",
  "Theme rates by period and by half-year: defects doubled, loading rose 24×, money flat, refunds / guarantee / trial trap / thin product / onboarding freeze improved",
  "n/a", "mixed", table("## 6.2 Trend 1", 0) + " || " + table("## 6.2 Trend 1", 1), "none", "verbatim", "app-specific", [])
c(108, "§6.2 Trend 1 — Reliability replaced monetization as the growth complaint", "timeline",
  "Reliability replaced monetization as the growth complaint — loading failures began in 2025 H2 and peaked in 2026 H1 — but the 2026 rating recovery happens despite it because it is one storefront's crisis (Russia), not a global regression; the 'quicker loading' release shipped one day before the corpus ends, so its effect is unmeasured",
  "backend degradation from mid-2025", "1★-burst", "BUG-any 10.56% → 13.57% → 22.16%; B-load 0.65% → 5.46% → 15.91% (24×); 2025 H2 13.1%, 2026 H1 17.2%, 2026 H2 11.9%; MONEY-any 31.47% → 36.35% → 31.25%", "must-never-break", "observed", "yes", [])
c(109, "§6.3 Trend 2 (b) The Apr 2025 sort-order regression", "timeline",
  "An April 2025 change broke chronological task sorting across four countries in the same week — tasks started appearing alphabetically or randomly; an annual subscriber says it persisted ~6 weeks with no support reply; one recurrence in Apr 2026 — a cross-market regression reviewers detected within days that the star rating never showed",
  "sort order regressed Apr 2025", "complaint", "B-order 5 (0.39%), mean 2.00; 4 in Apr 2025 (IN, DE, TR, MX); 1 in Apr 2026", "must-never-break", "weak, dated", "yes",
  ["12548475613","12571528769","12571797731","12577110521","13915239677"])
c(110, "§6.5 Trend 4 — Upsell pressure is the one complaint getting monotonically worse table (verbatim)", "anti-pattern",
  "The funnel is being tuned harder while the product improves — upsell complaints quintupled, onboarding-length and ad-mismatch complaints rose, while refunds and 'just a checklist' fell — so upsell pressure is now the fastest-growing source of one-star reviews: 'an excellent example of how to show tons of different paywall pages to users and don't let them use the app'",
  "more paywall screens over time", "1★-burst", table("## 6.5 Trend 4"), "dont", "observed", "yes",
  ["13808808716","13810012694","13813415532","13917372875","14276958495","14413735582","14451743287","14497068096","14503775552","13753570537","14139653785","13776099933","13675689954"])
c(111, "§6.6 Trend 5 — New in 2026: an AI coach, and a safety question with it; Part 7 §7.1 #4", "feature",
  "A 2026 AI coach ('Mimi') with a hard free message cap is valued ('please raise the coach chat limit — it's genuinely good to talk to') but cut one user off mid-crisis: 'I was in a very difficult moment, I went to talk to Mimi and the chat hit the limit… I was almost having a collapse… I'm still breaking down in tears' — rate-limiting an emotional-support conversation in a 4+ ADHD/self-care app is a product-safety decision, not a pricing one",
  "AI coach, free with a message cap, more messages paid", "mixed", "X-ai 5 (0.39% globally, 2.84% of P3), all 2026; 2 say Mimi is valuable; 1 cut off mid-crisis", "must-never-break", "safety", "yes",
  ["14302044695","13810246956","13860369435","14084062489","14507626498"])
c(112, "§6.7 Trend 6 — Seasonality", "timeline",
  "New-Year seasonality is large but it is volume, not sentiment — measure any funnel change against a January baseline, and treat a January release as the highest-exposure moment of the year",
  "n/a", "mixed", "Jan–Feb 2025 = 239 reviews (18.7% of corpus in two months); peak Feb 2025 131; Jan 2026 47 vs ~20/month; 2025 Q1 mean 3.59 vs corpus 3.51", "do", "observed", "yes", [])
c(113, "§6.8 Trends explicitly NOT claimed", "data-caveat",
  "Not claimed: any trend in request themes (counts below 10 per period), any cause for the 2026 rating recovery (P3 n=176 with a different country mix), anything about the Japanese IME bug beyond 'Aug 2024, never again'",
  "n/a", "none", "report gives none", "none", "method", "yes", [])

# ---- PART 7 — PRODUCT IMPLICATIONS ----
c(114, "§7.1 Immediate — do these before anything else table (verbatim)", "data-caveat",
  "Seven immediate actions with what they rest on and expected effect",
  "n/a", "1★-burst", table("## 7.1 Immediate"), "none", "verbatim", "app-specific", [])
c(115, "Part 7 §7.1 #1 Fix the Russia backend reachability problem", "must-never-break",
  "Fix the Russia backend reachability problem as an infrastructure / CDN / regional-endpoint issue, not client performance",
  "RU unreachable", "1★-burst", "52 of 113 RU minute-long loads; 6 VPN-only; 36 RU paid; RU written 2.38", "must-never-break", "immediate", "app-specific", [], cond="evidence: R09-030, R09-092")
c(116, "Part 7 §7.1 #2 Remove the rating prompt from the sign-up flow", "dont",
  "Remove the rating prompt from the sign-up flow — removes an App Store Review Guideline exposure and restores the rating as a usable metric",
  "prompt inside onboarding", "mixed", "13 asked before use; 9 mismatches; +1.35 gap", "dont", "immediate", "yes", [], cond="evidence: R09-070, R09-071")
c(117, "Part 7 §7.1 #3 Build a real in-app support and refund path", "must-have",
  "Build a real in-app support and refund path — converts ~100 public refund complaints into private tickets",
  "email only", "1★-burst", "25 no-response, 21 paid", "must-have", "immediate", "yes", [], cond="evidence: R09-016, R09-087")
c(118, "Part 7 §7.1 #4 Rate-limit nothing in the AI coach's crisis path, and add a handoff", "must-never-break",
  "Rate-limit nothing in the AI coach's crisis path, and add a handoff — non-negotiable in a 4+ ADHD/self-care app",
  "message cap applies mid-crisis", "1★-burst", "1 reviewer cut off mid-crisis", "must-never-break", "immediate (safety)", "yes", ["14507626498"], cond="evidence: R09-111")
c(119, "Part 7 §7.1 #5 Clinically review the in-app depression and ADHD screens", "must-never-break",
  "Clinically review the in-app depression and ADHD screens — a false-negative for a suicidal user, scaremongering at teenagers, generic ADHD content",
  "unvalidated screens", "complaint", "3 reviews", "must-never-break", "immediate (safety)", "yes", ["11976398530","14069820135"], cond="evidence: R09-027")
c(120, "Part 7 §7.1 #6 Display currency explicitly in every storefront", "must-never-break",
  "Display currency explicitly in every storefront — cheap, and removes a fraud perception",
  "ambiguous currency", "complaint", "19 M-unclear; 4 of 74 MX", "must-never-break", "immediate", "yes", [], cond="evidence: R09-096")
c(121, "Part 7 §7.1 #7 Add an audible completion/alarm option", "feature",
  "Add an audible completion/alarm option — fixes a whole market's (SA) core complaint",
  "silent push", "complaint", "9 G-sound + 12 B-notif", "build-free", "immediate", "yes", ["11836191831"], cond="evidence: R09-056")
c(122, "§7.2 The single highest-leverage change: let people see the product before they pay — The evidence and Expected effect", "product-rule",
  "Let people see the product before they pay — the claim with more evidence than anything else in the corpus: deduplicated, 159 reviews say 'let me look before you charge me' at mean 1.79 while 28 say the free tier is already usable; it may not raise revenue per install but should cut the scam, regret and refund reviews and convert the 55-review 'I'd pay if I could look first' cohort that currently converts at zero",
  "hard paywall before use", "blocked-conversion", "M-notrial 52 + M-wall 75 + M-latereveal 18 + M-nag 59 → 159 deduplicated (12.41%), mean 1.79; targets M-scam 30 (1.20), M-regret 50, M-refund 102", "product-rule", "highest-leverage", "yes", [])
c(123, "§7.2 Part A — Ship a real trial, everywhere", "monetization",
  "Ship a real trial everywhere — not 24 hours; reviewers ask for 3 days to 1 week — and eliminate the storefront inconsistency",
  "trial in some storefronts only", "blocked-conversion", "asks: '3 Tage', '1 haftalık', '1-2 gün', '1-2 Wochen'", "undecided", "recommendation", "yes",
  ["11854298993","12523888830","12636034921","12683497729"], cond="evidence: R09-009, R09-042")
c(124, "§7.2 Part B — Cap the upsell at one interstitial per session, and add 'don't show again'", "dont",
  "Cap the upsell at one interstitial per session and add 'don't show again'",
  "interstitial on nearly every open", "1★-burst", "M-nag 2.16% → 4.84% → 10.23%", "dont", "recommendation", "yes", ["12360368631"], cond="evidence: R09-010, R09-110")
c(125, "§7.2 Part C — State the free/paid split on a single screen", "must-have",
  "State the free/paid split on a single screen",
  "blank membership page", "complaint", "19 M-unclear", "must-have", "recommendation", "yes", ["11878902945","13021325704"], cond="evidence: R09-045")
c(126, "§7.3 Product — close the promise/delivery gap table (verbatim)", "data-caveat",
  "The G-thin → G-guide → O-mislead chain (99 + 21 + 20) is one problem: the app markets a coach and ships a checklist — nine actions",
  "n/a", "churn", table("## 7.3 Product"), "none", "verbatim", "app-specific", [])
c(127, "Part 7 §7.3 #1 Make the guided breathing exercise re-runnable from the habit itself", "feature",
  "Make the guided breathing exercise re-runnable from the habit itself — the most specific, most repeated, cheapest high-impact request in the corpus",
  "onboarding-only", "churn", "21 G-guide in 6 languages", "must-have", "recommendation", "yes", ["12885713029","12699837651","12609839103","13309724057"], cond="evidence: R09-022")
c(128, "Part 7 §7.3 #2 Attach a 'how to do this' body to every preset habit", "feature",
  "Attach a 'how to do this' body to every preset habit — turns the paid Discover library from a name list into content",
  "bare titles", "complaint", "G-thin + G-guide", "must-have", "recommendation", "yes", ["12357846588","12710666495"], cond="evidence: R09-052")
c(129, "Part 7 §7.3 #3 Ship the frequency model reviewers describe", "feature",
  "Ship the frequency model reviewers describe — N× per day, any N days per week, explicit weekdays, skip/holiday",
  "limited scheduling", "complaint", "22 G-freq", "must-have", "recommendation", "yes", ["11668735422","12695260948"], cond="evidence: R09-050")
c(130, "Part 7 §7.3 #4 Make preset habits editable and everything deletable", "feature",
  "Make preset habits editable and everything deletable — the listing already claims you can",
  "locked presets", "complaint", "20 G-noedit + 15 G-nodelete", "must-have", "recommendation", "yes", ["14400137816"], cond="evidence: R09-051")
c(131, "Part 7 §7.3 #5 Group/categorise the day", "feature",
  "Group / categorise the day so cleaning, self-care and study don't collapse into one list",
  "one list", "complaint", "13 G-group + 8 G-order + 8 G-dup", "must-have", "recommendation", "yes", ["13099009549","12464161947","11491997138"], cond="evidence: R09-053")
c(132, "Part 7 §7.3 #6 Expand icons, emoji and colours", "feature",
  "Expand icons, emoji and colours — low cost, all from engaged users",
  "6 colours, 60 emoji", "complaint", "14 G-icons, mean 3.57", "undecided", "recommendation", "yes", ["11607493158","11703804318"], cond="evidence: R09-054")
c(133, "Part 7 §7.3 #7 Backfill and forward-planning", "feature",
  "Backfill and forward-planning — tick off yesterday; plan more than 3–4 days ahead",
  "no backfill", "churn", "6 + 6", "must-have", "recommendation", "yes", ["12847151988","14066249834"], cond="evidence: R09-057")
c(134, "Part 7 §7.3 #8 Fix the four localizations reviewers say are machine-translated", "market",
  "Fix the four localizations reviewers say are machine-translated: JA, HE (including RTL), RU, AR — two reviewers subscribed for a year before discovering the problem",
  "machine translation", "1★-burst", "14 G-l10n, mean 1.79", "do", "recommendation", "yes", [], cond="evidence: R09-067")
c(135, "Part 7 §7.3 #9 Widgets, dark mode, iPad, Apple Watch — in that order of demand", "feature",
  "Widgets, dark mode, iPad, Apple Watch — in that order of demand; charging for widgets specifically is argued to be unfair",
  "absent or paid", "complaint", "11 + 4 + 7 reviews", "undecided", "recommendation", "yes", ["12451223326"], cond="evidence: R09-037, R09-039")
c(136, "§7.4 Positioning — protect what already works", "product-rule",
  "Protect what already works while fixing the rest: the daily organise-and-tick loop, the warmth that makes motivation and ADHD perfect-scoring (make affirmations optional, don't remove them), Turkish localization quality (extend it to other languages rather than dilute it), and the free tier (market it)",
  "warm tone; usable free tier", "praise", "P-org 106 + P-outcome 101 at 4.92; P-motiv 32 and P-adhd 16 at 5.00; P-free 28", "product-rule", "recommendation", "yes", ["13860369435","11647652906"], cond="evidence: R09-018, R09-019, R09-046, R09-068")
c(137, "Part 7 #1 (§7.5 experiment 1) Trial length A/B (3 vs 7 days) in DE, FR, US", "data-caveat",
  "Experiment: trial length A/B (3 vs 7 days) in DE, FR, US — hypothesis: high-spend markets convert better with a trial because the blocker is trust, not price; measure refund rate and 1★ rate, not just conversion",
  "n/a", "none", "report gives none", "research", "experiment", "yes", [], cond="evidence: R09-009, R09-101")
c(138, "Part 7 #2 (§7.5 experiment 2) Upsell frequency cap", "data-caveat",
  "Experiment: cap interstitials at one per session — hypothesis: it reduces 1★ volume more than it reduces revenue",
  "n/a", "none", "report gives none", "research", "experiment", "yes", [], cond="evidence: R09-110")
c(139, "Part 7 #3 (§7.5 experiment 3) Onboarding length", "data-caveat",
  "Experiment: a skippable quiz — hypothesis: raises completion in RU/IN without reducing conversion",
  "n/a", "none", "O-long mean 1.31, 15 of 35 RU", "research", "experiment", "yes", [], cond="evidence: R09-025")
c(140, "Part 7 #4 (§7.5 experiment 4) Guided-content re-run", "data-caveat",
  "Experiment: make the breathing exercise repeatable — hypothesis: measurably reduces thin-product / misleading-ad sentiment and 7-day churn",
  "n/a", "none", "21 G-guide", "research", "experiment", "yes", [], cond="evidence: R09-022")
c(141, "Part 7 #5 (§7.5 experiment 5) Post-purchase onboarding", "do",
  "Experiment: a post-purchase 'here's what you just unlocked' flow — because four of five purchase triggers are pre-experience, it should reduce regret and refund requests",
  "no post-purchase onboarding", "churn", "M-regret 50", "research", "experiment", "yes", [], cond="evidence: R09-085")
c(142, "§7.6 Research questions — What is the actual trial-to-paid, renewal and refund rate?", "data-caveat",
  "Research: actual trial-to-paid, renewal and refund rates are unknowable from reviews",
  "n/a", "none", "report gives none", "research", "open", "yes", [])
c(143, "§7.6 Research questions — Is the Russia loading failure server-side, CDN, or a sanction-related dependency?", "data-caveat",
  "Research: is the Russia loading failure server-side, CDN, or a sanction-related dependency? Requires telemetry",
  "n/a", "none", "report gives none", "research", "open", "app-specific", [])
c(144, "§7.6 Research questions — How large is the silent satisfied-paying population?", "data-caveat",
  "Research: how large is the silent satisfied-paying population? The 226 paid reviewers are negatively selected by definition",
  "n/a", "none", "226 (floor)", "research", "open", "yes", [])
c(145, "§7.6 Research questions — Did the Feb 2025 removal of the money-back guarantee reduce conversion, or only reduce refunds?", "data-caveat",
  "Research: did removing the money-back guarantee reduce conversion, or only refunds?",
  "n/a", "none", "report gives none", "research", "open", "yes", [])
c(146, "§7.6 Research questions — Do the ADHD/depression screens have any clinical validation?", "data-caveat",
  "Research: do the ADHD / depression screens have any clinical validation?",
  "n/a", "none", "report gives none", "research", "open", "yes", [])
c(147, "§7.6 Research questions — What do the ~40,000 star-only raters think?", "data-caveat",
  "Research: what do the ~40,000 star-only raters think? Given the in-onboarding prompt, that population may be substantially prompt-driven",
  "n/a", "none", "~40,555 ratings", "research", "open", "yes", [])

with open("Tools/prd_ledger/9/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
