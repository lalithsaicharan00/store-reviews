import json, re
R = 6
rep = open("App Store Reports/6. Streak Tracker - StreakUp - Habit Builder & Breaker (REPORT).md").read().split("\n")
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
c(72, "§8.1 Shape of the corpus quarter table (verbatim)", "timeline",
  "Quarterly shape: the app launched 6 Aug 2025, first review 1 Sep 2025; 2026 Q3 holds 17 of 44 reviews",
  "n/a", "mixed", table("## 8.1 Shape of the corpus", 0), "none", "verbatim", "app-specific", [])
c(73, "§8.1 three comparable windows table (verbatim)", "timeline",
  "Three windows: rating and 1–2★ share improved sharply in May–Aug 2026 while negative-monetization share stayed flat",
  "n/a", "mixed", table("## 8.1 Shape of the corpus", 1), "none", "verbatim", "app-specific", [])
c(74, "§8.2 Trend 1 — the rating improved, and the improvement is real but partly compositional", "timeline",
  "The rating improved (mean 3.33 → 4.30, 1–2★ share 33.3% → 4.3%) under a fast release cadence (v1.13.4 thirteen months after launch) — but partly compositionally: the latest window has proportionally more short low-information 5★s, and negative-monetization share did not improve at all (44.4% → 33.3% → 34.8%); what fell away was the clone and doesn't-work criticism, launch-window artefacts from Dec 2025",
  "shipped continuously; pricing unchanged in effect", "mixed", "mean 3.33 → 3.50 → 4.30; 1–2★ 33.3% → 33.3% → 4.3% (one review); neg-monetization 44.4% → 33.3% → 34.8%; volume 9 → 12 → 23", "none", "observed, partly compositional", "yes",
  ["14491149862","13531820409","13557096013"],
  side="a rising rating can hide a flat monetization-anger share",
  cond="no version field in the data — trends may reflect audience mix as much as product change")
c(75, "§8.3 Trend 2 — the free cap became *more* discussed, not less", "insight",
  "After the cap was raised 1 → 2 the complaint migrated from 'this app is a scam' to 'I like this app, please let me have more streaks' — the later cap complaints rate higher, a better problem to have and a clearer buy signal",
  "cap raised 1 → 2", "blocked-conversion", "5 of 7 cap complaints in May–Aug 2026 (21.7% of window) at mean 3.4 vs earlier two at 1.0", "undecided", "observed (small n)", "yes",
  ["13969396065","14267106974","14346310474","14372026009","14477924333","13185604622"])
c(76, "§8.4 Trend 3 — the lifetime SKU appeared mid-corpus and was received well", "timeline",
  "The lifetime SKU appeared mid-corpus and was received well: first evidence of a lifetime purchase 9 Apr 2026 ($14.99 'forever choice'), demand for it 20 Jun 2026, first explicit framing as new 23 Jun 2026 ('which is nice')",
  "added $14.99 lifetime alongside $11.99 yearly", "purchase-driver", "9 Apr 2026 → 20 Jun 2026 → 23 Jun 2026; 3 of 4 paid-evidence reviewers engage, all positively in principle", "product-rule", "clearest packaging signal", "yes",
  ["13939159292","14203637124","14214912053"],
  side="its launch also opened the lifetime+subscription double-billing path (R06-011)")
c(77, "§8.5 What persisted, unfixed, across all 13 months", "timeline",
  "Four things persisted unfixed across all 13 months: the free-streak cap as a rating drag (Sep 2025 → Aug 2026), price confusion/distrust (Sep 2025 → Aug 2026), counter-mode confusion (Jan → Apr 2026), and the multi-log-per-day gap (Nov 2025 → Aug 2026 — nine months, same request, both from paying-intent users)",
  "none of the four addressed", "complaint", "1. cap 13185604622 → 14477924333; 2. price 13185604622 → 14491149862; 3. mode 13628759209 → 13994050917; 4. multi-log 13390634274 → 14471219702", "do", "observed", "yes",
  ["13185604622","14477924333","14491149862","13628759209","13994050917","13390634274","14471219702"])

# ---- PART 9 — PRODUCT IMPLICATIONS ----
c(78, "Part 9 Immediate — fix before anything else (days, not sprints) table (verbatim)", "data-caveat",
  "Immediate fixes (days, not sprints): lifetime double-charge audit, quote-vs-charge reconciliation, IAP availability by storefront, in-app manage/refund link, can't-add-widget",
  "n/a", "complaint", table("## Immediate — fix before anything else"), "none", "verbatim", "app-specific",
  ["13939159292","13771926913","14203637124","13390634274","14389534229"])
c(79, "Part 9 Monetization — repackage, don't reprice table (verbatim)", "data-caveat",
  "Monetization actions — repackage, don't reprice: raise the cap well above 2, lead with lifetime, one stable price, paywall at the moment of need, stop selling themes/icons",
  "n/a", "complaint", table("## Monetization — repackage, don't reprice"), "none", "verbatim", "app-specific", ["13185604622"])
c(80, "Part 9 Product — converts 3–4★ into 5★ table (verbatim)", "data-caveat",
  "Product actions that convert 3–4★ into 5★: explicit mode choice, count completions not days, market widget and day boundary, deliberate broken-streak handling for sensitive categories",
  "n/a", "mixed", table("## Product — converts 3–4★ into 5★"), "none", "verbatim", "app-specific",
  ["13628759209","13994050917","13085620460","14292633754","13390634274","14471219702","13672386764","14349062008","13837160367","14311507310"])
c(81, "Part 9 #1", "must-never-break",
  "Audit the lifetime-purchase flow: reproduce trial → lifetime and check whether buying lifetime cancels/refunds an active subscription — every trial user who upgrades may be paying twice",
  "double charge reported", "complaint", "1 review; named, reproducible path", "must-never-break", "immediate", "yes", ["13939159292"], cond="evidence: R06-011")
c(82, "Part 9 #2", "must-never-break",
  "Reconcile the paywall's quoted price with the actual charge ($1.99/mo quoted, $20.99 charged) — a refund, chargeback and App Review risk, not just a rating risk",
  "quote ≠ charge", "1★-burst", "1 review", "must-never-break", "immediate", "yes", ["13771926913"], cond="evidence: R06-010")
c(83, "Part 9 #3", "market",
  "Check IAP availability by storefront, starting with India — a 5★ user with intent to buy could not transact; highest expected-revenue defect in the corpus",
  "IAP unavailable (IN)", "blocked-conversion", "1 review", "must-never-break", "immediate", "yes", ["14203637124"], cond="evidence: R06-016")
c(84, "Part 9 #4", "must-have",
  "Add a visible in-app 'Manage / cancel / request refund' link to Apple's subscription management — both billing complaints were filed as public 1★/3★ reviews because there was no other route",
  "no in-app route", "complaint", "3 reviews", "must-have", "immediate", "yes", ["13771926913","13939159292","13390634274"], cond="evidence: R06-012")
c(85, "Part 9 #5", "must-never-break",
  "Investigate 'can't add widget' — the most-loved feature failing to install is disproportionately costly",
  "widget install failure", "complaint", "1 review", "must-never-break", "immediate", "yes", ["14389534229"], cond="evidence: R06-055")
c(86, "Part 9 #6", "monetization",
  "Raise the free cap well above 2 — test 5, or unlimited-with-cosmetics-paid — as an experiment with conversion and rating as joint metrics; do not ship blind",
  "2-streak cap", "blocked-conversion", "§0.2, §8.3 — 7 reviews, mean 3.00, 5 of them in the last 4 months", "build-free", "experiment", "yes", [], cond="evidence: R06-007, R06-075; see R06-035 on the cosmetics fallback")
c(87, "Part 9 #7", "monetization",
  "Lead with the one-time/lifetime SKU — three of four paid-evidence reviewers engage with it positively; four separate reviewers reject subscriptions outright",
  "lifetime secondary to yearly", "purchase-driver", "§1.3, §8.4 — 3 of 4; 4 reject subscriptions", "product-rule", "recommendation", "yes", [], cond="evidence: R06-040")
c(88, "Part 9 #8", "must-never-break",
  "Publish one clear price on the paywall and keep it stable — reviewers quoted $1.99, ~$5, $11.99, $14.99 and $20.99 in eleven months",
  "incoherent ladder", "1★-burst", "§0.4 — 4 'greed' reviews, mean 1.00", "must-never-break", "recommendation", "yes", [], cond="evidence: R06-014")
c(89, "Part 9 #9", "dont",
  "Move the paywall from app-launch to the moment of need (attempting streak #3, or attempting a freeze)",
  "paywall on launch", "1★-burst", "1 explicit complaint; supported by cap-complainers already liking the app", "do", "recommendation", "yes", ["13185604622"], cond="evidence: R06-042")
c(90, "Part 9 #10", "monetization",
  "Stop selling Premium on themes and icons — not one of 44 reviewers mentions them; sell the freeze and the streak count",
  "Premium = unlimited streaks + themes + icons", "none", "§1.1 — 0 of 44", "dont", "recommendation", "unknown", [], cond="evidence: R06-033, R06-034")
c(91, "Part 9 #11", "must-have",
  "Make the Tracker-vs-Counter mode choice explicit at streak creation, with one line explaining each — two 1★s are people in the wrong mode; two more asked for a mode that already ships",
  "mode choice invisible", "churn", "4 reviews", "must-have", "recommendation", "yes", ["13628759209","13994050917","13085620460","14292633754"], cond="evidence: R06-023, R06-024")
c(92, "Part 9 #12", "feature",
  "Support counting completions, not just days — 'twice a day', '3× per week'; nine months of the same request, including one paid churn",
  "one log per day", "churn", "2 reviews", "must-have", "recommendation", "yes", ["13390634274","14471219702"], cond="evidence: R06-057")
c(93, "Part 9 #13", "do",
  "Market the two things users say are unique — the widget and the user-defined day boundary; both are buried in the listing and both are the reason people switched",
  "buried in listing", "praise", "7 widget mentions; 1 switched because of the day boundary", "do", "recommendation", "yes", ["13672386764"], cond="evidence: R06-018, R06-019, R06-022")
c(94, "Part 9 #14", "do",
  "Decide deliberately how a broken streak is handled for sensitive categories (self-harm, substances) — supportive copy and a resource link vs the current neutral reset; the app is rated 12+",
  "neutral reset", "praise", "3 reviews", "do", "recommendation", "yes", ["14349062008","13837160367","14311507310"], cond="evidence: R06-062")
c(95, "Part 9 Research questions this corpus cannot answer — does raising the cap to 5 increase or decrease revenue?", "data-caveat",
  "Research: does raising the free cap to 5 increase or decrease revenue? 44 reviews cannot tell — needs a live A/B test with conversion, ARPU and rating tracked together",
  "n/a", "none", "report gives none", "research", "open", "yes", [])
c(96, "Part 9 Research questions — how common is the lifetime + subscription double charge?", "data-caveat",
  "Research: how common is the lifetime + subscription double charge? One review — check the billing ledger, not the reviews",
  "n/a", "none", "1 review", "research", "open", "yes", [])
c(97, "Part 9 Research questions — what is the actual retention curve after the streak breaks?", "data-caveat",
  "Research: what is the retention curve after a streak breaks? Every review is from someone still engaged — the corpus is structurally blind to churn",
  "n/a", "none", "report gives none", "research", "open", "yes", [])
c(98, "Part 9 Research questions — are the two clone accusations reputational noise or a real ASO/positioning problem?", "data-caveat",
  "Research: are the two clone accusations (Streaks, Days Since) reputational noise or a real ASO/positioning problem? Two reviews cannot separate these",
  "n/a", "none", "2 reviews", "research", "open", "yes", ["13531820409","13557096013"])
c(99, "Part 10 method and limitations (skimmed)", "data-caveat",
  "Method per the appendix: all 44 reviews hand-coded single-pass with no second coder and no automated classification; no version field so nothing is attributed to a release; is_edited unreliable and unused; themes non-exclusive (one review carries six labels); the 1 → 2 cap change is inferred from review text, not a changelog; 4 paid-evidence reviewers is a qualitative finding, not a 100% failure rate; written reviews are ~12% of US raters and over-represent grievance — the right lens for a fix list, the wrong one for overall satisfaction",
  "n/a", "none", "44 records, 0 duplicates, 13 by_country files reconcile; rating distribution {5:24, 4:7, 3:5, 2:0, 1:8}; mean 3.886", "none", "method", "yes", ["13531820409","14414628073","14389534229","14417731278"])

with open("Tools/prd_ledger/6/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
