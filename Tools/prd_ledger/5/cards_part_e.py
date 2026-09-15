import json, re
R = 5
rep = open("App Store Reports/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD (REPORT).md").read().split("\n")
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
c(72, "§7.1 table (verbatim)", "market", "The nine eligible storefronts: n, mean, 1–2★, 5★ and 14 theme rates — full table",
  "n/a", "mixed", table(487, 498), "none", "high-priority", "yes", [])
c(73, "§7.2", "market", "Korea is not a review market, it is an unstaffed support desk: 19.06% of the corpus but 62.6% of all billing-integrity complaints (57 of 91) because Korean users post refund and cancellation requests directly into the App Store review — often while rating 5★; 'I was charged by mistake and looked everywhere for where to ask, but there's no way to find it' — an in-app, Korean-language, self-service cancel/refund path would remove the majority of Korea's negative reviews at a stroke; Korea is also the lead-user market (deepest Watch/sync/crash feedback, most detailed feature specs) and should be the beta cohort",
  "no in-app support/refund path; KR users use reviews as tickets", "1★-burst", "KR 637 reviews (19.06%); 57/91 billing complaints; 9 refund-request-at-5★ IDs", "must-have", "high-priority", "yes",
  ["11462945038","11729876017","11850519257","11940731530","13449732100","13548970666","11360391292","10174413491","8102214925","10940540257","13449391599","9712944707"],
  side="a channel artifact: KR billing numbers overstate KR-specific defects and understate them elsewhere — disclosed",
  cond="the home market of a non-US developer can behave as its support channel; treat it as the beta cohort")
c(74, "§7.3 Japan", "market", "Japan is the worst eligible storefront (3.77, 21.3% 1–2★) despite the highest ADHD-identification rate outside North America (19.0%) and strong timer praise — the gap is entirely engineering and language: data loss 9.0% (3.3× global), battery 4.1%, translation 3.6% (4.6×), Watch 5.0%; Japanese reviewers write the longest, most technically precise defect reports (a five-revision running log of regressions) — 'Japan is telling you exactly what is broken and rating you accordingly'",
  "n/a", "1★-burst", "JP n=221, mean 3.77; data loss 9.0%, translation 3.6%", "must-never-break", "high-priority (in-market)", "yes", ["13323018578","12925478996"])
c(75, "§7.3 Germany", "market", "Germany has the highest 1–2★ rate of any eligible market (23.5%, mean 3.84): crashes 7.4% (highest), translation 7.4% (9.5× global), subscription objection 8.8%, cap 8.8% — and a cheap, sharp, six-year-old locale gripe: no 24-hour time format, week starting Sunday, unchangeable date format (2020 → still unfixed Feb 2026)",
  "no 24h clock, Sunday week start, fixed date format", "complaint", "DE n=68, 1–2★ 23.5%; locale gripe 2020–2026", "do", "meaningful (in-market)", "yes", ["6799961112","13799067782"],
  side="the same EU locale asks as report 1 (week-start, date format); six years is the cost of ignoring them")
c(76, "§7.4", "market", "Australia (4.49, 7.1% 1–2★, 72.4% 5★, life-change 18.4% — 2× global) and Mexico (4.39, 71.4% 5★, essentially zero reliability complaints) are the healthy markets — and AU ALSO has the highest cap-mention rate (9.2%): further proof that naming the cap is not the same as churning over it",
  "n/a", "praise", "AU n=98; MX n=56", "none", "meaningful", "yes", ["8810965416","12459764181","13763004001"])
c(77, "§7.5", "market", "China: the app does not work at the storefront level — 23 reviews (0.69%) report it will not open, register, or shows a network error, continuously Aug 2021 → Jan 2026; CN mean 2.77, 46.7% 1–2★ on 30 reviews; a backend/auth endpoint unreachable from the mainland — and 'paid and it's completely unusable, always shows no network': the app is taking money in a market where it cannot function; enter properly or withdraw",
  "backend unreachable from mainland China; still sold there", "1★-burst", "23 (0.69%); CN 30 reviews at 2.77", "dont", "limited evidence, seven-year single-cause pattern", "yes",
  ["7716753605","9542524738","9642437584","9708023091","10359901346","11157656351","11607673178","11810774152","12541720254","12661622269","12748667037","12966673910","13128697638","13216388903","9567925230"],
  side="selling in a storefront where the app cannot connect is a billing-integrity issue as well as a reliability one")
c(78, "§7.6", "data-caveat", "77 storefronts under 50 reviews hold 502 (15.0%, mean 4.06, 17.3% 1–2★); no standalone claims except disclosed exceptions: the CN cluster, the NL sync-deletes-data report, SE/TH/PL Watch reports, single-review language requests",
  "n/a", "none", "502 (15.0%)", "none", "method", "yes", [])

# ---- PART 8 ----
c(79, "§8.1 table (verbatim)", "timeline", "Reviews by year 2019–2026 with mean, 1–2★, 5★ — the story is a V: quality degraded from 2020 (4.45) to a floor in 2023 (3.76; 2023 Q2 at 3.25), then recovered and held ~4.2 for three years; volume more than doubled in 2025 (review prompt and/or Forbes/App-of-the-Day exposure)",
  "n/a", "mixed", table(533, 543), "none", "high-priority", "app-specific", [],
  side="a recovery from a 3.25 quarter to a stable 4.2 is achievable — reliability work shows in rating")
c(80, "§8.2 table (verbatim)", "timeline", "Themes that genuinely improved: Watch defects 8.8% → 0.2% (solved); crash 7.9% → 2.0%; subscription objection 12.5% → 5.9% (halved — the free tier is doing its job); free-cap complaints 7.3% → 4.1%; refund requests 3.4% → 0.6%; dark mode requests 2.2% → 0.2% (shipped); bad translation 2.0% → 0.2% (improved, not fixed)",
  "fixed Watch, crashes, dark mode; softened cap and refunds", "praise", table(548, 557), "none", "high-priority", "yes", [],
  side="a generous free tier halves subscription objections over time")
c(81, "§8.3 table (verbatim)", "timeline", "Themes that worsened or emerged: notification loop ~0% → 3.7% (new regression, currently the top defect); widget gaps 2.4% → 3.9% (shipped but under-deliver); ads 0.6% → 1.6% (peak 2.6% 2025); AI-features objection 0% → 1.0% (new); social tab objection new; battery fixed once, regressed twice",
  "n/a", "complaint", table(560, 568), "must-never-break", "high-priority", "yes", [])
c(82, "§8.3 AI objection", "insight", "The AI objection is new (9 reviews, 0.27%, all 2025–26) and specific: not anti-AI in general but about AI features added to a product chosen for its RESTRAINT — 'Recent AI features are disappointing, wish I could turn them off'; 'a horoscope in a routine app? terrible… looks like it's to boost engagement'; the horoscope feature launched two unskippable 30-second ads for a lifetime-premium holder",
  "added AI features and a horoscope", "complaint", "9 (0.27%), 2025–26", "dont", "emerging", "yes",
  ["14264972849","14279579894","14022962408","14049946488"],
  side="engagement features bolted onto a minimalist tool read as betrayal; cf. report 1 (0.011% AI demand)",
  cond="if AI features ship, they must be optional and off by default")
c(83, "§8.4 table (verbatim)", "timeline", "The persistent five, unfixed across the life of the app: no undo / accidental done (Jan 2020 → Feb 2026); icon skin-tone diversity (Jun 2020 → Jun 2026); 24-hour clock / week-start / date format (Dec 2020 → Feb 2026); untimed checklist mode (Nov 2020 → Jan 2026); routine start-order / reordering bugs (Jan 2020 → Nov 2025)",
  "five six-year-old open items", "complaint", table(573, 580), "must-have", "high-priority", "yes",
  ["5432864399","13702441710","6063452130","14221471353","6799961112","13799067782","6661289869","13657298374","5415561492","13433400135"],
  side="small, cheap items left open for six years accumulate into a rating ceiling")

# ---- PART 9 ----
c(84, "Part 9 #1", "must-never-break", "Kill the notification loop — 33 lifetime reports, 12 in May 2026, mean 3.00; punishes the exact trait the product sells to; the biggest rating delta for the least work",
  "notification loop regression", "1★-burst", "33; 12 in one month", "must-never-break", "high-priority", "yes", [], cond="evidence: R05-010")
c(85, "Part 9 #2", "must-have", "Make the notification escalation ladder user-configurable (once / escalating / until-started, per routine) and stop silently retuning it — some depend on the un-dismissable buzz, others are driven out by it",
  "one global alarm behaviour", "mixed", "5 IDs", "must-have", "clear mechanism", "yes", ["13667837214","14371016110","14447685280","12780143141"], cond="evidence: R05-057")
c(86, "Part 9 #3", "must-never-break", "Fix background battery and thermals — mean 2.94, 43.5% 1–2★, the worst non-billing theme; at least one reviewer will not renew because of it; audit the background timer, consider Live Activity instead of a wake-locked foreground timer",
  "background timer", "1★-burst", "62 (1.86%)", "must-never-break", "meaningful", "yes", [], cond="evidence: R05-055")
c(87, "Part 9 #4", "must-never-break", "Add a first-class undo/back on the running routine and separate the pause and done buttons — reported continuously since January 2020, trivially fixable",
  "no undo", "complaint", "42 (1.26%)", "must-never-break", "meaningful", "yes", [], cond="evidence: R05-062")
c(88, "Part 9 #5", "must-have", "Guarantee data durability: prompt for account creation BEFORE the first routine is saved; make sync non-destructive; add a visible manual backup/restore",
  "account optional; sync destructive", "1★-burst", "91 (2.72%)", "must-have", "meaningful", "yes", ["8120137325"], cond="evidence: R05-058")
c(89, "Part 9 #6", "must-never-break", "Fix day-boundary handling for night routines — log to the day the routine STARTED and honour the user's 'day ends at' setting",
  "midnight boundary", "complaint", "14 (0.42%)", "must-never-break", "weak", "yes", [], cond="evidence: R05-063")
c(90, "Part 9 #7", "must-have", "Put an in-app, localised support and cancellation path one tap from the home screen — and make it reachable when the app fails to launch (a web fallback); this alone would materially clean up Korea's review page",
  "support hidden, in-app only", "1★-burst", "97 (2.90%) + KR 57 billing tickets", "must-have", "high-priority", "yes", [], cond="evidence: R05-059, R05-073")
c(91, "Part 9 #8", "monetization", "Stop gating on routine count; gate on capability — the cap is named by 168 reviewers of whom 116 rate 4–5★: visible, accepted, and NOT converting because morning+night satisfies the core job; move the wall to analytics/history, cross-device sync, Apple Watch, widgets, icon library, family sharing; raise the free cap to 3–4 and take the goodwill",
  "gates on quantity (2 routines)", "mixed", "168 named; 116 at 4–5★; 42 ask for 3–4", "build-paid", "high-priority", "yes", [],
  side="'repackage, don't reprice' — the report's clearest monetisation directive; matches Research Reports/Feature Gating vs Quantity.md",
  cond="evidence: R05-009, R05-023")
c(92, "Part 9 #9", "product-rule", "Ship — and prominently surface — the lifetime purchase; asked for continuously 2020–2026 (46 reviews at 3.76, from fans); 2026 reviews suggest it exists but is under-marketed; one bought within five minutes of finding it",
  "lifetime SKU shipped 2026, under-marketed", "purchase-driver", "46 (1.38%)", "product-rule", "meaningful", "yes", ["13987336109"], cond="evidence: R05-020, R05-031")
c(93, "Part 9 #10", "monetization", "Ship a family plan — five reviews, every one an explicitly blocked purchase, plus a parent segment rating 4.40; lowest-volume / highest-intent request in the corpus",
  "no family plan", "blocked-conversion", "5 (0.15%)", "research", "weak count, highest intent", "yes", [], cond="evidence: R05-067")
c(94, "Part 9 #11", "product-rule", "Remove ads for paying subscribers unconditionally, including reward-gated features like streak savers — a 30-second unskippable ad to a subscriber produced the most damaging recent payer review; not a revenue trade-off, a trust liability",
  "ads shown to payers", "1★-burst", "ads 5.8% of payers", "product-rule", "meaningful", "yes", ["14021959851"], cond="evidence: R05-019, R05-028, R05-033")
c(95, "Part 9 #12", "must-never-break", "Fix the trial→charge flow — make the trial state explicit, send a pre-charge reminder email (none is sent), never bill on login to a pre-existing account",
  "trial ambiguity; no pre-charge email; billed on login", "1★-burst", "31 at 1.55", "must-never-break", "emerging", "yes", ["14438727762","13666735555"], cond="evidence: R05-029")
c(96, "Part 9 #13", "dont", "Retire or fully honour the 1+1 gift promo — twelve reviews, six years, still generating disputes in 2026; the fine print is the problem",
  "misleading promo", "1★-burst", "12 (0.36%)", "dont", "weak", "yes", [], cond="evidence: R05-030")
c(97, "Part 9 #14", "dont", "Move the review prompt off routine-completion — it fires at the highest-frequency event and generates 1★s from people who already reviewed",
  "prompt on every completion", "complaint", "27 (0.81%)", "dont", "emerging", "yes", [], cond="evidence: R05-034")
c(98, "Part 9 #15", "feature", "Ship an untimed/checklist mode as a per-routine TOGGLE (not a separate object) — 69 reviews at 4.26 plus 15 who say the timer causes anxiety; directly addresses the 'almost' band",
  "checklist as separate object", "complaint", "69 + 15", "must-have", "meaningful", "yes", [], cond="evidence: R05-061")
c(99, "Part 9 #16", "feature", "Ship per-task day/interval scheduling and sub-routines together — 48 combined reviews at 3.72/4.42; they solve the same root problem (forced whole-routine duplication to vary one step) which is also what pushes people into the routine cap; the highest-leverage feature work in the report",
  "monolithic routines", "complaint", "48 combined", "must-have", "meaningful", "yes", [], cond="evidence: R05-069")
c(100, "Part 9 #17", "feature", "Deliver the widget / Lock Screen / Live Activity story properly — 92 reviews and the largest over-index in the 3–4★ band; users want to run the routine without opening the app; today the widget frequently renders blank or fails to advance",
  "widget blank / stuck", "complaint", "92 (2.75%)", "build-free", "meaningful", "yes",
  ["12811011494","14018416858","13253617539","11264671674","10696429419","14191150102"], cond="evidence: R05-050")
c(101, "Part 9 #18", "feature", "Finish Shortcuts/auto-start — 37 reviews; several users built alarm→routine automations and then LOST them to an update; the last manual step in an app whose thesis is removing manual steps",
  "automation hooks regressed", "complaint", "37 (1.11%)", "undecided", "meaningful", "yes", ["12956851447","13186621588"], cond="evidence: R05-052")
c(102, "Part 9 #19", "do", "Human-translate the UI, or ship English-only honestly — translation complaints average 2.73 stars; priority DE, JA, PT-BR, FR; and fix the DE/CH locale basics: 24-hour clock, Monday week start, system date format — six years old, cheap, disproportionately punished",
  "machine translation; no locale settings", "1★-burst", "26 at 2.73; locale gripe 2020–2026", "do", "meaningful", "yes", [], cond="evidence: R05-060, R05-075")
c(103, "Part 9 #20", "do", "Add icon skin-tone variants — four reviews over six years, one a standing 1★; cheap; no defensible reason it is still open",
  "pale-skin default icons", "complaint", "4", "do", "weak", "yes", [], cond="evidence: R05-065")
c(104, "Part 9 #21", "dont", "Make the social feed opt-in, hideable and adult-only — or remove it; two credible reports of minors surfaced to adult accounts on a 17+ app full of self-identified 9–13-year-olds; the one finding with regulatory as well as product risk",
  "public feed default-on with minors", "1★-burst", "2 reports + ≥9 self-identified minors", "dont", "child-safety", "yes", [], cond="evidence: R05-064")
c(105, "Part 9 #22", "market", "Decide about China — seven years of 'the app will not open', plus at least one user charged where the product does not function; fix endpoint reachability and localise, or geo-restrict the storefront",
  "sold where it cannot connect", "1★-burst", "23 (0.69%)", "dont", "limited evidence, coherent", "yes", [], cond="evidence: R05-077")
c(106, "Part 9 #23", "tactic", "Treat review replies as the retention channel they demonstrably are (nine visible star-upgrades, 37 praising responsiveness) — but public replies are fast while email goes unanswered for months: a channel imbalance to correct, not a virtue to lean on",
  "fast public replies, slow email", "mixed", "9 upgrades; 37 praise; 1 damning comparison", "do", "meaningful", "yes", ["13769267096"], cond="evidence: R05-044, R05-059")
c(107, "Part 9 research questions", "data-caveat", "Open questions: is the trial→immediate-charge a billing defect or a plan-selection UX failure; does raising the free cap to 3–4 raise or lower paid conversion; what share of 5★ users would pay for family sharing; did the 2026 lifetime plan cannibalise subscriptions or expand the payer base (only three reviews mention it)",
  "n/a", "none", "4 research questions", "research", "open", "yes", [])
c(108, "Part 10 method and limitations (skimmed)", "data-caveat", "Method per the appendix: 3,342 records, full reconciliation, hand-validated multilingual themes across KR/JP/DE/FR/ES/PT/NL and others; payer cohort n=120 is a segment rate; KR billing figures are a channel artifact; CN and single-review language findings flagged limited evidence",
  "n/a", "none", "3,342 reviews; 86 storefronts; 9 eligible", "none", "method", "yes", [])

with open("Tools/prd_ledger/5/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
