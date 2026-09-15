import json, re
R = 8
rep = open("App Store Reports/8. Onrise - Habit Tracker & Focus - Build habits, focus & journal (REPORT).md").read().split("\n")
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


# ---- PART 8 — OVER TIME ----
c(103, "§8.1 Method", "data-caveat",
  "Time method: yearly buckets (2021 n=25, 2022 n=51, 2023 n=162, 2024 n=229, 2025 n=237, 2026 n=146), quarterly only from 2024 (34–84 per quarter); 2021–2022 reported as counts; Sep 2026 partial (4 reviews); no version field — release attribution from dated reviewer reports plus current release notes",
  "n/a", "none", "2021 25 · 2022 51 · 2023 162 · 2024 229 · 2025 237 · 2026 146", "none", "method", "yes", [])
c(104, "§8.2 Trend 1 — a real quality regression in 2025, and a real recovery in 2026", "timeline",
  "The causal chain: development stalled (last update ~mid-2024) → iOS moved on → widget, create flow, day-boundary and launch paths broke → functional failures rose to 7.2% of 2025 → 2025Q3 mean fell to 4.184 with 12.2% 1–2★ → development resumed → functional failures fell to 2.7% of 2026, the lowest in five years; abandonment concern appears only in 2024–2025 and is absent from all 146 reviews of 2026",
  "paused development ~mid-2024 → resumed 2026", "1★-burst", "functional failures 5.2% (2024) → 7.2% (2025) → 2.7% (2026); 2025Q3 4.184 / 12.2%; abandonment 7 in 2024–25, 0 in 2026", "dont", "high-priority", "yes", [],
  side="a pause is not neutral: OS updates break a frozen app")
c(105, "§8.3 Trend 2 — shipping against reviews demonstrably works here table (verbatim)", "timeline",
  "Four fixes and their before/after complaint rates — the forced-reminder theme, the single largest friction in 2022, was eliminated to zero and stayed there for two years and 383 reviews",
  "n/a", "praise", table("## 8.3 Trend 2"), "do", "verbatim", "app-specific", [])
c(106, "§8.4 Trend 3 — the free position has held constant and never eroded", "timeline",
  "Five years in, the free position is praised at the highest rate in the app's history — no fatigue effect, no sign it stopped being remarkable — while fear of monetization appeared only from 2023 and peaked in 2025, when the app looked abandoned",
  "free since 2021", "praise", "praise_free_nopaywall 4.0% (2021) → 29.4% → 32.1% → 36.7% → 32.1% → 39.0% (2026); fear_monetization peak 2.5% (2025)", "product-rule", "observed", "app-specific", [])
c(107, "§8.5 Trend 4 — the residual complaint is now capability, not reliability table (verbatim)", "timeline",
  "2025 → 2026: functional failures, stats, custom habits, backfill and focus-timer complaints all fell; sync held; multi-daily check-in is the only complaint theme rising; design and simplicity praise are declining monotonically (design 60.0% in 2021 → 15.1%; simplicity peak 48.8% in 2023 → 34.2%) — partly novelty decay and reviewer-base broadening, while the app added a summary, colours, ordering and an iOS 26 redesign",
  "n/a", "mixed", table("## 8.5 Trend 4"), "none", "verbatim", "app-specific", [])
c(108, "§8.5 There is no design *backlash* in the corpus — zero reviews complain about the Aug 2026 Liquid Glass refresh", "contradiction",
  "Onrise's Aug 2026 iOS 26 Liquid Glass refresh drew zero complaints — against report 7, where HabitKit's Aug 2026 compact-list redesign produced a dated 1★/2★ backlash within weeks",
  "platform-native visual refresh (Liquid Glass navigation, redesigned Wrapped stories)", "none", "0 redesign complaints", "none", "absence", "yes", [],
  cond="a platform-native refresh that keeps layout and density differs from a redesign that changes text size, density and labels (report 7)")
c(109, "§8.6 Trend 5 — New Year seasonality is real and large", "timeline",
  "New Year seasonality is large and the January cohort judges onboarding, not retention: reviews are written in the first days ('I'm only on my second day'; 'I have never written a review before this one'), so every onboarding defect — create flow, preset picker, can't-log-today, widget overlay — is amplified ~2× in January; the can't-log-today cluster itself sits in January 2025",
  "n/a", "mixed", "January reviews 2021: 7 · 2022: 1 · 2023: 20 · 2024: 21 · 2025: 49 · 2026: 31; Jan 2025 = 20.7% of 2025; can't-log-today 3 of 11 in a 14-day Jan 2025 window", "do", "observed", "yes",
  ["13581401872","12138019597"])

# ---- PART 9 — PRODUCT IMPLICATIONS ----
c(110, "Part 9 #1 Immediate — Fix the day-boundary / can't log today defect", "must-never-break",
  "Fix the day-boundary / 'can't log today' defect — it breaks the product's only core action; highest severity in the corpus",
  "defect open Apr 2026", "1★-burst", "11 reviews, mean 2.73, 45.5% 1–2★, concentrated in January", "must-never-break", "immediate", "yes", ["13990708296"], cond="evidence: R08-019")
c(111, "Part 9 #2 Fix the monthly-summary off-by-one", "must-never-break",
  "Fix the monthly-summary off-by-one — the last day of the month is excluded; almost certainly a one-line date-range bug",
  "summary excludes last day", "1★-burst", "2 independent reports", "must-never-break", "immediate", "yes", ["13742512516","14018076544"], cond="evidence: R08-057")
c(112, "Part 9 #3 Fix the widget placeholder-string leak", "must-never-break",
  "Fix the widget placeholder-string leak ('no data / mo datos / keine daten') — reported as recently as Jan 2026",
  "localized placeholder instead of data", "complaint", "13 reviews across three years", "must-never-break", "immediate", "yes", ["13609169075"], cond="evidence: R08-068")
c(113, "Part 9 #4 Make the focus-timer alarm fire when backgrounded or silenced", "must-never-break",
  "Make the focus-timer alarm fire when backgrounded or silenced and stop the timer resetting on backgrounding — an audio-session / notification-category configuration",
  "alarm silent / timer resets", "complaint", "7 reviews Jan 2024 → Aug 2026", "must-never-break", "immediate", "yes", ["14397732532"], cond="evidence: R08-066")
c(114, "Part 9 #5 Audit the reminder time picker for 12/24-hour locales", "must-never-break",
  "Audit the reminder time picker for 12/24-hour locales — a user could not set AM, which cost a full star from an enthusiastic user",
  "AM/PM picker defect", "1★-burst", "1 (1★, US, Feb 2026)", "must-never-break", "immediate", "yes", ["13724690797"], cond="evidence: R08-071")
c(115, "Part 9 #6 Answer the unanswered data-export request", "must-have",
  "Answer the user who asked for their data in March 2025 and was still unanswered in October — whatever the export roadmap, an unanswered data-access request is exposure that costs nothing to close",
  "unanswered", "1★-burst", "1 review", "must-have", "immediate", "yes", ["13311871983"], cond="evidence: R08-034")
c(116, "Part 9 #7 Product — converts 4★ into 5★ — Ship intra-day completion: tap the checkbox N times to fill N/N", "feature",
  "Ship intra-day completion — tap the checkbox N times to fill N/N — paired with quantity logging",
  "one tick per day", "churn", "36 reviews, mean 3.94, 8.2% of 2026, #2 blocker in 4★ and 3★ bands, one stated uninstall", "must-have", "recommendation", "yes", ["13440800887"], cond="evidence: R08-016, R08-017")
c(117, "Part 9 #8 Show circles only on days a habit is actually scheduled", "feature",
  "Show circles only on scheduled days — a rendering change that keeps the praised flexible-frequency logic and removes the confusion",
  "seven circles always", "complaint", "25 reviews, mean 3.76", "must-have", "recommendation", "yes", ["14254399815","13813008711"], cond="evidence: R08-063")
c(118, "Part 9 #9 Extend backfill from ~7 days to an unbounded calendar", "feature",
  "Extend backfill from ~7 days to an unbounded calendar — the 7-day wall makes the app feel like it 'starts over'",
  "~7-day window", "complaint", "27 reviews, mean 3.52 (worst request mean)", "must-have", "recommendation", "yes", ["13237495965","13182431485"], cond="evidence: R08-054")
c(119, "Part 9 #10 Ship a multi-habit widget and lock-screen widgets", "feature",
  "Ship a multi-habit widget and lock-screen widgets — zero 1–2★, above-corpus mean, pure upside with no simplicity risk",
  "single-habit widget", "praise", "41 reviews; oldest Jan 2021", "build-free", "recommendation", "yes", ["6862625618"], cond="evidence: R08-067")
c(120, "Part 9 #11 Local encrypted backup + iCloud Drive document sync — no account, no server", "feature",
  "Local encrypted backup plus iCloud Drive document sync — no account, no server — preserving the no-account privacy posture while closing the largest reliability anxiety",
  "no backup", "churn", "37 sync + 12 export + 9 data-loss; India 14.10%", "must-have", "recommendation", "yes", ["9853721563","10309724588","11943323917"], cond="evidence: R08-059, R08-060")
c(121, "Part 9 #12 Let users change a habit's colour after creation", "feature",
  "Let users change a habit's colour after creation — today recolouring means deleting the habit and losing all history",
  "colour fixed", "complaint", "20 reviews", "must-have", "recommendation", "yes", ["12470711816"], cond="evidence: R08-075")
c(122, "Part 9 #13 Monetization — the permitted moves, and the forbidden one — Add a tip jar / buy the developer a coffee one-time IAP", "monetization",
  "Add a tip jar / 'buy the developer a coffee' one-time IAP — zero rating risk because it gates nothing, and it answers the abandonment anxiety by giving the product a visible reason to exist",
  "no tip option", "blocked-conversion", "7 asked unprompted (all 5★); 13 more would pay", "build-paid", "recommendation", "yes", [], cond="evidence: R08-022, R08-038")
c(123, "Part 9 #14 If a paid tier is ever built, make it a one-time purchase or an additive add-on", "product-rule",
  "If a paid tier is ever built, make it a one-time purchase or an additive add-on — never a gate on anything that is free today",
  "free", "mixed", "6 of 13 WTP one-time/add-on vs 1 subscription; 12 fear monetization", "product-rule", "recommendation", "yes", ["13920667278"], cond="evidence: R08-021, R08-024")
c(124, "Part 9 #15 The Apple Watch app is the best paid-add-on candidate in the corpus", "monetization",
  "Make the Apple Watch app the paid add-on — demand and willingness to pay are attached to the same additive feature, and it does not touch the free tier",
  "absent", "purchase-driver", "18 requests, mean 4.61, zero 1–2★; 2 volunteered to pay", "build-paid", "recommendation", "yes", ["8082446036","10117160205"], cond="evidence: R08-076")
c(125, "Part 9 #16 Do not gate the widget, unlimited habits, the journal, or the focus timer. Ever.", "product-rule",
  "Do not gate the widget, unlimited habits, the journal or the focus timer — ever: they are the reason 32 reviewers left paid competitors, and gating any converts the corpus's strongest asset into the category's standard complaint",
  "all free", "praise", "free 33.53%, unlimited 4.35%, journal 7.65%, focus 7.18% of the corpus", "product-rule", "recommendation", "yes", [], cond="evidence: R08-004, R08-027, R08-028")
c(126, "Part 9 #17 Positioning — Say free forever, no subscription, no ads, no account in the App Store subtitle", "do",
  "Say 'free forever, no subscription, no ads, no account' in the App Store subtitle and first description line — the listing leads with behaviour-design language and never mentions the price model, so a third of reviewers discover it by surprise and one assumed a paywall",
  "listing silent on price model", "praise", "33.53% free praise; 1 paywall misconception 1★", "do", "recommendation", "yes", ["10972915619","13650696629"], cond="evidence: R08-004, R08-007")
c(127, "Part 9 #18 Publish a one-line how this app is funded / what data it collects note in-app", "do",
  "Publish a one-line 'how this app is funded / what data it collects' note in-app — three reviewers speculated publicly and one escalated to a 1★ tracking accusation",
  "no statement", "1★-burst", "3 reviews", "do", "recommendation", "yes", ["14220350355"], cond="evidence: R08-037")
c(128, "Part 9 #19 Re-request reviews from the 2025 cohort", "tactic",
  "Re-request reviews from the 2025 cohort: the trough was caused by defects that are now fixed, but the written corpus prospective users read still carries 17 functional-failure reports from a version that no longer exists",
  "defects fixed, reviews stale", "complaint", "17 functional-failure reports in 2025; store aggregate 4.83 on 7,184 ratings across 13 storefronts", "do", "recommendation", "yes", [], cond="evidence: R08-010, R08-104")
c(129, "Part 9 Research questions — What is retention?", "data-caveat",
  "Research: retention is unmeasured — 55.6% of reviews are pure praise and many are written on day 1–3 ('second day', 'my first day', 'After testing it out for 5mins'); the corpus measures first impressions, not habit formation",
  "n/a", "none", "473 pure praise (55.6%)", "research", "open", "yes", ["13581401872","11638684551","12146578302"])
c(130, "Part 9 Research questions — Would a tip jar actually convert?", "data-caveat",
  "Research: would a tip jar actually convert? 20 volunteers among 850 writers (9.4% of raters) is sentiment, not a demand curve",
  "n/a", "none", "20 / 850", "research", "open", "yes", [])
c(131, "Part 9 Research questions — Is the can't log today bug timezone-related?", "data-caveat",
  "Research: is the can't-log-today bug timezone-related? Symptoms come from SE, SG, HU, ID, AU, US, CA but no devices, locales or timezones — needs instrumentation, not more reviews",
  "n/a", "none", "7 storefronts", "research", "open", "yes", [])
c(132, "Part 9 Research questions — How many users hit the preset-habit picker and left without reviewing?", "data-caveat",
  "Research: how many users hit the preset-habit picker and left without reviewing? 13 wrote about it; the silent cohort is unmeasurable here",
  "n/a", "none", "13 (floor)", "research", "open", "yes", [])
c(133, "Part 9 Research questions — Does the widget failure correlate with a specific iOS version?", "data-caveat",
  "Research: does the widget failure correlate with a specific iOS version? No version field exists",
  "n/a", "none", "report gives none", "research", "open", "yes", [])
c(134, "Part 9 Research questions — What did the 2024–2025 development pause cost in installs?", "data-caveat",
  "Research: what did the 2024–2025 development pause cost in installs? Review volume actually rose in 2025 (237 vs 229), so the corpus cannot see it",
  "n/a", "none", "2024 229 → 2025 237", "research", "open", "yes", [])

with open("Tools/prd_ledger/8/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
