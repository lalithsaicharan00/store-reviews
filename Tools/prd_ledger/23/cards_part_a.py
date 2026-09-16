"""Cards for report 23 — header, How to read this, Executive summary, Part 1."""
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

c(1, "header lines 1-9; §12.4 External sources", "positioning",
  "Streaks — The habit-forming to-do list (App Store ID 963034692) — a paid-up-front, one-time-purchase habit tracker with no subscription, no IAP and no ads; a healthy corpus (mean 4.19, 63% 5★) whose story is product limits and post-2021 reliability regression, not monetisation abuse",
  "developer of record Crunchy Bagel Pty Ltd (Adelaide, Australia); bundle com.streaksapp.streak; extracted 8 Sep 2026; analysis 10 Sep 2026; store rank 23; paid-up-front one-time purchase, never free except promotions", "praise",
  "7,270 reviews · 93 storefronts · 1 Jun 2015 → 6 Sep 2026; mean 4.194; 5★ 4,586 (63.08%) / 4★ 1,154 (15.87%) / 3★ 538 (7.40%) / 2★ 342 (4.70%) / 1★ 650 (8.94%)", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Six warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §12.1 counting rules; §12.3 validation", "data-caveat",
  "Method: 7,270/7,270 read in full in 30 batches, country-then-date order, original language; 50-theme multilingual regex classifier validated by reading, three over-matching patterns corrected before use (crash 138→46 because 'hang' matched inside 'changing'; price 153→123 to explicit objection wording; limit 724 split into 620 asking-for-more and 118 defending); watch/widget/sync split into mention / negative / positive subsets; corpus is front-weighted (2015–2017 = 3,400 = 46.8%; 2025–26 = 401 = 5.5%) so recent findings rest on small samples; theme rates under-count in Japanese, Korean, Chinese, Thai and Russian — country comparisons lead with rating distributions; the app changed shape three times (cap 6 → 12 in v3.0 late Jul 2017 → 24 in v7 late Jul 2021) so 'only N tasks' is the same complaint against three products; no version field; 'paid evidence' ≠ paying customers because everyone paid — Part 7 isolates people who talk about the transaction; storefront ≠ nationality ≠ language (Catalan in es, Spanish in ar, Russian/Ukrainian in hr/pl); no download/revenue/retention data; rating is not a feature preference (457 of 620 capacity requests are 4–5★); signal bands <0.1% ignore … >5% high-priority",
  "n/a", "none", "7,270/7,270; 93 storefronts; 0 empty bodies; 2 duplicate title+body groups (6 records) kept; is_edited 12 (several are visible upgrades after a developer fix); 1,221 (16.80%) with community votes; 21 storefronts ≥50 = 6,689 (92.01%)", "none", "method", "yes", [])
c(3, "Executive summary #1 — capacity is the largest request in twelve years and raising the cap twice did not settle it", "feature",
  "Task capacity (more tasks/pages/screens) is the single largest product request over twelve years; the developer raised the cap 6 → 12 (Jul 2017) → 24 (Jul 2021) and the request simply re-anchored on the new number — it was the top request in every large market and every year",
  "hard cap on habit count: 6, then 12, then 24 — raised twice, never made optional", "complaint",
  "620 reviews (8.53%, high-priority) ask for more; 74 in 2015, 118 in 2016, 60 in 2021, 27 in 2024; 118 (1.62%) defend the limit", "undecided", "high-priority", "yes",
  ["1210218319","1435204171","2118562647","3652626817","5996825854","6094260232","9405934613","12880039039","13458083376"],
  cond="the cap is a design constraint, not a paywall — everyone has paid")
c(4, "Executive summary #1 — 118 reviews actively defend the limit", "insight",
  "A minority of users actively defend the task cap as the reason the app works — the constraint itself is a value proposition for them",
  "hard cap defended by users", "praise", "118 reviews (1.62%, meaningful) defend the limit vs 620 asking for more", "undecided", "meaningful", "yes",
  ["1223740791","1465200157","6819955202","10779334259","13400151593"])
c(5, "Executive summary #2 — simplicity is the moat and generates the capacity complaint", "insight",
  "Simplicity/minimalism is the highest-volume positive theme by a wide margin, and it is the same property that generates the capacity complaint — the constraint is the value proposition and the top objection at once; any capacity change must be an opt-in that leaves the default untouched",
  "minimal, constrained design", "praise", "1,780 reviews (24.48%, high-priority) praise simplicity, mean 4.58, 76.9% 5★", "product-rule", "high-priority", "yes", [],
  cond="capacity beyond the default must be opt-in, default untouched")
c(6, "Executive summary #3 — reliability, not pricing, turned the ratings curve down; post-2021", "timeline",
  "The rating decline is a post-2021 reliability story: annual mean fell 4.58 (2016) → 4.02 (2021) → 3.92 (2022) → 3.81 (2024) → 3.71 (2025) → 3.29 (2026), tracked by sync complaints (1.4% of 2015–17 reviews → 7.60% of reviews from Jan 2022, mean 2.90) and data loss (60 of 81 total after the iCloud sync rewrite, 3.38% of post-2022 reviews, mean 2.03)",
  "iCloud sync rewrite (2021) followed by sync and data-loss regressions", "1★-burst",
  "annual mean 4.58 → 4.02 → 3.92 → 3.81 → 3.71 → 3.29; sync 135 of 1,776 post-Jan-2022 reviews (7.60%, mean 2.90); data loss 81 (1.11%) total, 60 (3.38% since Jan 2022, mean 2.03)", "must-never-break", "high-priority", "yes",
  ["8479907454","8646756790","8851969812","10125490424","11174051475","11217881769","11764467723","12257280896","13219722364","14156559364"])
c(7, "Executive summary #4 — Apple Watch is the strongest differentiator and most fragile surface", "feature",
  "Apple Watch is the app's strongest differentiator and its most fragile surface — 38.5% of Watch mentions are negative and Watch sync/complication failure is the most commonly cited reason a five-year user leaves; in Japan and Korea the Watch is the dominant topic",
  "Apple Watch app with complications, included in the one-time price; sync/complication failures", "mixed",
  "626 reviews (8.61%, high-priority) mention the Watch; 241 (38.5%) negative, mean 3.13 vs 4.35 for the rest; Japan 13.3% of storefront, Korea 13.5%", "must-never-break", "high-priority", "yes",
  ["1352113408","3355577958","4640524404","7946379003","8798302019","10510343633","10741780773","11748040853","12008652692","13235319229"])
c(8, "Executive summary #5 — the interface wins design awards and loses users", "anti-pattern",
  "The UI is described as unintuitive, confusing or undiscoverable — the worst rating profile in the corpus; three actions recur: deleting a task, editing a task, and undoing an accidental completion; 'shake to undo' is named as unacceptable across a dozen markets",
  "gesture-driven, undiscoverable delete/edit/undo; shake-to-undo", "complaint",
  "250 reviews (3.44%, very strong), mean 2.66, 31.6% 1★", "must-have", "very strong", "yes",
  ["1946127158","3241868349","3801615694","5374792981","9143311516","10130810601","11129306077","12074352723","13091898748","13176889519"])
c(9, "Executive summary #6 — the one-time price is a stated purchase reason; the objection is small and shrinking", "monetization",
  "'No subscription / one-time purchase' is a genuine, repeatedly stated purchase reason that grows as a share over time (3.61% pre-2017 → 8.00% post-2021); the price objection is small, and named prices rose ~2.5× over eleven years without the objection rate rising with it",
  "one-time purchase; price $3.99 (2015–16) → ~$5 (2017–21) → $7.99–$8 (2019–24) → $9.99–$10 (2024–26)", "purchase-driver",
  "398 (5.47%, high-priority) praise one-time, mean 4.43; 3.61% E1 → 8.00% E3; 123 (1.69%, meaningful) object to price, mean 2.21, 50.4% 1★; objection rate 1.75% E1 → 2.21% E3", "build-paid", "high-priority", "yes", [])
c(10, "Executive summary #7 — record effort beyond the goal, asked in seven languages", "feature",
  "A specific unbuilt feature is asked for in seven languages: record over-achievement or partial progress — the binary complete/incomplete model is named as demotivating and as the reason people keep a second app",
  "absent — binary completion only; 'I read 90 minutes, my goal was 30, and it stops counting'; '4 of 8 glasses shows an ✗'", "complaint",
  "77 reviews (1.06%, meaningful)", "undecided", "meaningful", "yes",
  ["1230386714","9145507788","9592238918","11936906855","12209604326","13566507177","11968580277","14106848070"])
c(11, "Executive summary #8 — widget capability regressed and users noticed for four years", "timeline",
  "The interactive Today-view widget was lost around iOS 14 (Sept 2020) and users asked for it back through 2026 — a capability regression tracked for four years",
  "interactive Today-view widget removed ~Sept 2020; non-interactive replacement", "complaint",
  "318 (4.37%) mention the widget; 134 (42%) negative, mean 3.40", "must-never-break", "very strong", "yes",
  ["6448871007","6472011768","6540711760","6935238940","7824788952","9100003341","10006367703","11748639117","13580820001","13909346620"])
c(12, "Executive summary #9 — neurodivergent users are a growing, high-satisfaction segment the app was not marketed to", "audience",
  "Self-identified ADHD, autism, executive dysfunction, depression, memory-injury and PTSD users are a growing, high-satisfaction segment the app never marketed to; several arrive on a therapist's or doctor's recommendation",
  "not marketed to neurodivergent users; the constrained design suits them", "praise",
  "73 (1.00%, meaningful), mean 4.45, 68.5% 5★; 0.66% E1 → 0.70% E2 → 1.90% E3; 28 mention therapist/coach/doctor/physio, mean 4.50", "do", "meaningful", "yes",
  ["8577993480","8266328218","9514806382","10779334259","11121463145","11285333857","12845331532","13274948716","13528928858"])
c(13, "Executive summary #10 — cheapest unshipped wins in evidence order", "do",
  "Cheapest unshipped wins in evidence order: fix iCloud/Watch sync integrity → optional capacity beyond 24 → an undo button that is not a shake gesture → record-beyond-goal / partial progress → restore an interactive widget → plain-language onboarding for delete/edit → longer history and a year view",
  "none of these shipped as of Sep 2026", "complaint", "report gives none (ranked list)", "do", "summary ranking", "yes", [])
c(14, "§1.3 Coverage — is_edited records are visible upgrades after a developer fix", "insight",
  "Several of the 12 edited reviews are visible rating upgrades after a developer fix — fixes bring reviewers back",
  "developer fixes cause reviewers to edit ratings upward", "praise", "12 is_edited records", "do", "limited evidence", "yes",
  ["9775440687","8551938079","3964933428","8545693662","11583805884","11475255452","11266371820","11217881769","8631829289","8547420011","8545368780","1853307561"])
c(15, "§1.6 Corpus composition — ratings table (verbatim)", "data-caveat",
  "Rating distribution table", "n/a", "none", table("**Ratings (denominator 7,270):**"), "none", "corpus-level fact", "app-specific", [])
c(16, "§1.6 Corpus composition — by-year table (verbatim)", "timeline",
  "Per-year volume, mean, 5★ share and 1★ share, 2015–2026: three golden years (2015–17, mean 4.51–4.58) then a step down in 2018 (3.96, 1★ 12.4%) and a slow slide to 3.29 with 24.6% 1★ in 2026",
  "n/a", "mixed", table("**By year:**"), "none", "corpus-level fact", "app-specific", [])
c(17, "§1.6 Corpus composition — storefronts", "market",
  "93 storefronts; 21 clear the 50-review threshold (us, gb, cn, ca, de, au, ru, kr, jp, mx, es, fr, it, br, nl, se, in, tr, ch, tw, pl) and account for 92.01% of the corpus",
  "n/a", "none", "21 storefronts = 6,689 of 7,270 (92.01%)", "none", "corpus-level fact", "app-specific", [])
c(18, "§1.6 Most community-endorsed reviews table (verbatim)", "data-caveat",
  "The community-endorsement ranking is dominated by feature requests from satisfied 5★ users; the top two (313 and 231 net votes, both cn) are about recording effort the binary model discards — an independent signal for Part 4.4",
  "n/a", "praise", table("**Most community-endorsed reviews (by net upvotes):**"), "undecided", "corpus-level fact", "yes",
  ["9145507788","3372029447","2100236937","3721242401","8642992805","3524837176","2056232018","2429989150","6592885718","4899831817","3225476511","1933748530"])
c(19, "§1.6 community-endorsed — connect consecutive completed days visually (231 votes)", "feature",
  "The second most-endorsed review in the corpus asks to connect consecutive completed days visually on the calendar",
  "absent", "complaint", "231 net votes, cn, 5★, 2018-11-02", "undecided", "single review, community-endorsed", "yes", ["3372029447"])
c(20, "§1.6 community-endorsed — a habit with a floor but no ceiling (126 votes); longer cycles (80 votes)", "feature",
  "Community-endorsed requests: a habit with a floor but no ceiling (126 votes) and longer cycles — fortnightly, monthly, bimonthly (80 votes)",
  "absent", "complaint", "126 and 80 net votes, cn, 5★", "undecided", "community-endorsed single reviews", "yes", ["8642992805","2056232018"])
c(21, "§1.6 community-endorsed — plain-language in-app instructions (66 votes); machine-translated Chinese help text (52 votes)", "feature",
  "Community-endorsed: plain-language in-app instructions (66 votes, us, 3★) and a request to fix machine-translated Chinese help text (52 votes, cn, 4★)",
  "help text machine-translated in Chinese; no plain-language instructions", "complaint", "66 and 52 net votes", "must-have", "community-endorsed single reviews", "yes", ["3225476511","1933748530"])

with open("Tools/prd_ledger/23/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
