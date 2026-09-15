import json, re
R = 7
rep = open("App Store Reports/7. Habit Tracker - HabitKit - Streaks & Accountability (REPORT).md").read().split("\n")
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

c(1, "header lines 1-8", "positioning",
  "Habit Tracker — HabitKit (App Store ID 6443918070) is a solo-indie GitHub-contribution-grid habit tracker: no ads, no account, local-only data, Pro sold as monthly/yearly subscription OR one-time lifetime; 882 written reviews at mean 4.562 — the healthiest product in the set",
  "developer Sebastian Roehl (solo indie); bundle com.roehl.habitkit; Productivity; 4+; English-only listing (app itself supports 15+ languages); store rank 7 in this set", "praise",
  "882 reviews, 70 storefronts, 27 Nov 2022 → 6 Sep 2026; 5★ 692 (78.46%) · 4★ 95 (10.77%) · 3★ 35 (3.97%) · 2★ 19 (2.15%) · 1★ 41 (4.65%); US store 4.852 on 2,405 ratings", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Part 10 method (skimmed)", "data-caveat",
  "Method: denominator 882, non-exclusive themes, signal bands on global share and separately per eligible country; only US (211), DE (107), GB (89), CA (56) clear 50; [external] facts never mixed into corpus %; hybrid classification — broad praise themes by multilingual regex (±3–5% relative error), every high-stakes theme and the paid cohort hand-curated from ID lists (small-n themes are floors); paid cohort audited (14 regex false positives removed, 15 added, intent excluded, 10 'inferred-only' held out); no version field so release attributions come from the undated public changelog; 178 non-English reviews read in-language; Sep 2026 partial; survivor bias in paid cohort; in-app prompt timing unknown",
  "n/a", "none", "882 records, 0 duplicates, 70 by_country files reconcile; 60 themes; bands <0.1% ignore, 0.1–0.5% weak, 0.5–1% emerging, 1–3% meaningful, 3–5% very strong, >5% high-priority", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "Part 0 §1 (This is the healthiest product in the set — and its rating is still sliding, for reasons that are all fixable)", "insight",
  "HabitKit is not a troubled app — 78.46% 5★, dense specific praise, top three themes are product themes (simplicity 38.10%, design 34.58%, the developer himself 15.08%), nothing suggests a broken core loop — yet its rating is sliding monotonically for reasons that are all fixable",
  "healthy core loop", "mixed", "simplicity 38.10%, design 34.58%, developer 15.08%; mean 4.79 → 4.42 across four cohorts", "product-rule", "high-priority", "yes", [])
c(4, "Part 0 §1 cohort table (verbatim)", "timeline",
  "The rating falls across four annual cohorts on healthy samples: 1★ rate multiplied ~5.8× (1.4% → 8.1%) and 5★ fell 13.3 points — a consistent trend, not noise",
  "n/a", "1★-burst", table("## 1. This is the healthiest"), "none", "verbatim", "app-specific", [])
c(5, "Part 0 §1 And the cause is almost entirely monetization; Part 2 1★", "insight",
  "The cause of the slide is almost entirely monetization, not product quality: of 41 one-star reviews, 21 (51.2%) are paywall / price / free cap and 4 (9.8%) paid and could not get what they paid for; only 4 are the app malfunctioning and 3 about confusion — 'The product is winning. The packaging is losing.'",
  "4-habit cap, Pro-gated widgets, €35 lifetime", "1★-burst", "1★ n = 41: 21 (51.2%) paywall/price/cap; 4 (9.8%) paid-but-broken; 4 malfunction; 3 confusing", "product-rule", "high-priority", "yes", [])
c(6, "Part 0 §2 (The 4-habit free cap is the single most damaging decision in the product); Part 4 #4; Part 2 2★; Part 6 #2; §8.4", "monetization",
  "The 4-habit free cap is the single most damaging decision in the product: it does not convert the people it blocks — zero of the 27 complainers show any evidence of having paid — it produces a bad review and a churn; top 2★ theme by a distance",
  "free tier = 4 habits, unchanged Feb 2023 → Aug 2026 (18 dated reports: 15 say 4, two 5, one 3)", "churn",
  "27 (3.06%, VERY STRONG), mean 2.56, 55.6% 1–2★, 7.4% 5★; 0 of 27 paid; 2★: 8 of 19 (42.1%); outside high-spend 4.2% vs 2.3%; long tail 4.5% vs 2.4%; CA 7.1%; span 3y 7m (9589360229 6 Feb 2023 → 14463193980 23 Aug 2026)", "build-free", "very strong", "yes",
  ["9589360229","10100430683","11058226263","11333683156","11530931211","11713771657","12224917759","12297500345","12499305420","13030220021","13513014070","13677605567","13838060940","14316598205"])
c(7, "Part 0 §2 Counter-evidence that matters; Part 9 #5", "insight",
  "The cap is not universally hated: 11 reviewers name the same cap and are fine with it — all 11 are 5★ — so it is hated by people who need 5–8 habits and loved by people who need 3–4: a segmentation problem with a cheap fix (raise the cap to 6–8), not a pricing problem; move the wall past the 5-to-8-habit user, who is the likeliest future power user and payer",
  "4-habit cap", "mixed", "11 (1.25%), all 5★ vs 27 complainers at 2.56", "build-free", "very strong", "yes",
  ["10842857261","10882654265","11602928681","11714676984","12068026268","12238453493","12273297032","13727963896","13813261463","14407894713","14463193980"],
  cond="the wall should sit above the typical user's habit count and below the power user's (10+) needs — folders, colours, stats")
c(8, "Part 0 §2 3½-year-old constraint that has never been revisited", "contradiction",
  "A cap held perfectly stable for 3½ years was still the top 2★ theme — stability alone does not rescue a cap set too low; this qualifies the 'never change the cap' rule from earlier reports (stable AND high enough)",
  "4-habit cap unchanged since Feb 2023", "churn", "18 dated confirmations over 3½ years; still producing reviews in the last 60 days", "product-rule", "very strong", "yes",
  ["9589360229","14463193980"],
  cond="contrast report 1 (a drifting cap angered users) and report 6 (a 1 → 2 raise did not help)")
c(9, "Part 0 §3 (Putting home-screen widgets behind the paywall costs more rating than it earns revenue); Part 4 #12; §8.4", "feature",
  "Putting home-screen widgets behind the paywall costs more rating than it earns revenue: 13 reviews object to Pro-gated widgets at mean 2.23 with not one 5★ — the only theme in the corpus with a zero 5★ rate — against 8 who name the widget as the thing that made them buy; widgets are simultaneously the best-loved feature and the most resented paywall",
  "all home-screen widgets Pro", "complaint",
  "objection 13 (1.47%, MEANINGFUL), mean 2.23, 53.8% 1–2★, 0% 5★; purchase trigger 8 (0.91%), mean 4.88; widget praise 84 (9.52%), mean 4.69; span 2y 5m (10771302089 1 Jan 2024 → 14093446153 22 May 2026)", "build-free", "meaningful", "yes",
  ["10771302089","12781411049","13905806444","13575345887","12622891075"])
c(10, "Part 0 §3 The argument reviewers actually make", "product-rule",
  "Users argue a widget is an OS feature you should not charge for — 'something that's built into the operating system'; 'isn't the no widgets without subscription thing a bit overkill?'; 'I'm all for pro features being add-ons but the widget?!' — the objection is to the category of thing gated, not the price",
  "widgets Pro-only", "1★-burst", "13 objections, 0 at 5★", "product-rule", "meaningful", "yes",
  ["10771302089","12781411049","13905806444"])
c(11, "Part 0 §3 free-one/paid-many proposal; Part 6 #3; Part 9 #6", "monetization",
  "Make one widget free and more widgets paid — the model reviewers designed themselves: 'only making one widget free and making more widgets paywalled, kinda like Widgy'; widgets are the strongest daily-engagement surface (one user runs three home-screen pages of them), so a free widget creates the habit that later justifies Pro",
  "zero free widgets", "blocked-conversion", "13 objections at 2.23 (0% 5★); 8 widget buyers at 4.88", "build-free", "recommendation", "yes",
  ["12622891075","14305420985"], side="also reduces the Pro-entitlement widget failures' blast radius")
c(12, "Part 0 §4 (Eight people paid and did not get the product — this is the highest-severity finding); Part 4 #20; §8.3; Part 9 #1", "must-never-break",
  "Eight paying customers' Pro entitlement did not unlock — a 100% segment rate (every one is in the paid cohort); stable across 15 months and four platforms (widget, restore, macOS carry-over), the newest instance is the most recent review in the whole corpus (6 Sep 2026); two rated 5★ while reporting it — an open receipt-validation / widget-timeline bug; fix, then proactively email the eight",
  "Pro purchased, widgets still show 'Upgrade to HabitKit Pro' / restore fails / Pro does not carry to Mac", "1★-burst",
  "8 (0.91%, EMERGING), mean 2.25, 75% 1–2★, 100% of them payers; 0.00% (P1) 0.00% (P2) 1.62% (P3) 1.52% (P4) — emerged 2025, still open Sep 2026", "must-never-break", "highest severity", "yes",
  ["12836329335","13105035694","13398478371","13430341774","13693601586","14351190258","14519062888","12450937418"])
c(13, "Part 0 §4 table (verbatim)", "data-caveat",
  "The eight paid-but-not-delivered cases, by country, rating and date",
  "n/a", "1★-burst", table("## 4. Eight people paid"), "none", "verbatim", "app-specific",
  ["12836329335","13105035694","13398478371","13430341774","13693601586","14351190258","14519062888","12450937418"])
c(14, "Part 0 §4 [external] FAQ; §7.2 finding 2; Part 9 #1", "anti-pattern",
  "An offline-first app gated its widget on a live network entitlement check: the developer's FAQ tells affected users to 'disable VPN/DNS filters' and email an 'RC ID' (RevenueCat) — and the failures are 4× more common outside high-spend markets (PH, UA, BR, PL, MM), where those network conditions are likelier; cache entitlement locally and render the widget optimistically from the last-known-good receipt",
  "widget extension blocks on RevenueCat network check", "1★-burst", "paid-but-broken 1.7% outside high-spend vs 0.4% inside (4×)", "must-never-break", "highest severity", "yes",
  ["13430341774","13105035694","12836329335","13693601586","14351190258"],
  side="a serviceability bug with a geographic distribution")
c(15, "Part 0 §4 12450937418; Part 4 #31 No lock-screen widget; Part 9 #20", "anti-pattern",
  "Creator content is driving purchases against features the app does not have: a user bought an annual plan to get a lock-screen widget seen on YouTube — it does not exist",
  "no lock-screen widget", "complaint", "1 (2★, IN, 22 Mar 2025); No lock-screen widget 2 (0.23%), mean 4.50", "dont", "weak", "yes",
  ["12450937418"], side="worth a creator brief so videos show what actually ships")
c(16, "Part 0 §5 (No cross-device sync is the biggest *product* gap, and it is 2½ years old and unfixed); Part 4 #1; Part 6 #1; §8.4; Part 9 #11", "feature",
  "No cross-device / iCloud sync is the biggest product gap: the #1 theme in the recoverable 3★/4★ band, persistent for three years, and a conversion blocker with named willingness to pay — 'If you could sync it across multiple devices I would totally be willing to buy the lifetime pass'; 'I probably wouldn't have subscribed if I had noticed this sooner'; 'for a Pro plan, it should include sync'",
  "absent (local-only); FAQ: 'currently in development'", "blocked-conversion",
  "54 (6.12%, HIGH-PRIORITY), mean 3.85, 33.3% 5★, 13.0% 1–2★; 18.9% of 4★, 31.4% of 3★; 0.70% (P1) → 7.26% → 7.14% → 7.07%; span 3y 4m (9806367856 10 Apr 2023 → 14378210199 2 Aug 2026); US 9.0%, DE 7.5%, GB 3.4%, CA 5.4%", "build-paid", "high-priority", "yes",
  ["12386725682","13473841112","13833569208","12139974588","9806367856","14378210199"],
  side="also eliminates the data-loss cluster and the 'changed phones, lost everything' churn",
  cond="must ship opt-in, end-to-end, CloudKit private database to keep the privacy promise (7 praise local-only storage)")
c(17, "Part 0 §5 [external] sync 'is currently in development' relayed by a reviewer", "tactic",
  "Tactic: the developer tells users sync is in development (FAQ, and personally) — the roadmap message is reaching some users and buying goodwill, with one 5★ reviewer relaying it",
  "communicates roadmap for the top missing feature", "praise", "1 reviewer (5★, IN) relays it", "do", "weak", "yes",
  ["13346250530"])
c(18, "Part 0 §5 The tail of this gap is data loss; Part 4 #26", "must-never-break",
  "The tail of the no-sync gap is data loss: users lost their history on reinstall, on a new phone (one switched to Tiimo), by accidental delete, and by historical entries silently vanishing",
  "local-only storage, no backup by default", "churn", "5 (0.57%), mean 2.20, 60.0% 1–2★", "must-never-break", "emerging", "yes",
  ["10001495366","12211144791","13499288017","14016661342","13952801052"])
c(19, "Part 0 §6 (The developer is a top-5 product asset, and reviewers say so by name); Part 3 #3", "insight",
  "The developer is a top-5 product asset and reviewers name him ('Sebastian', 'Seb'): replies in hours to days, a widget bug fixed within an hour, a fix in two days, a proposed day-note feature shipped, a reviewer upgrading his review after both requests shipped — 'best support services I've ever seen from any app on the app store'",
  "solo developer answers personally and ships user requests", "praise", "133 (15.08%, HIGH-PRIORITY), mean 4.85, 93.2% 5★; CA 23.2% (highest)", "do", "high-priority", "yes",
  ["12762466887","11364312275","11551214646","13432617886","14466920687","11426923525"])
c(20, "Part 0 §6 The counter-case is small but real and recent; Part 9 #2", "must-have",
  "Put a support address in the app, visibly: the two reviewers who could not reach the (famously responsive) developer produced two 1★s — 'I can't find any way to contact customer support'; 'The developer also doesn't respond to emails, so there's no way to get support' — both paying, both 2026; a discoverability fix, not a staffing one",
  "support not findable in-app", "1★-burst", "2 (0.23%, Weak), both 1★, both payers, both 2026", "must-have", "weak, high cost", "yes",
  ["13952801052","14351190258"])
c(21, "Part 0 §7 (What actually makes people love this app: the GitHub grid, and doing nothing else)", "insight",
  "Three tightly coupled praise clusters describe one product decision — the GitHub grid and doing nothing else: simplicity / no bloat, design / visual appeal, and the grid heat-map itself, which reviewers spontaneously call 'GitHub', 'contribution graph', 'commits', 'Seinfeld / don't break the chain'",
  "minimal grid-first tracker", "praise", "simplicity 336 (38.10%), mean 4.86, 89.9% 5★; design 305 (34.58%), mean 4.78; grid 73 (8.28%), mean 4.73", "product-rule", "high-priority", "yes", [])
c(22, "Part 0 §7 tried multiple competitors and switched; Part 3 #4", "positioning",
  "Switchers are the purest positive signal in the corpus: people who explicitly tried multiple competitors and chose HabitKit — named losers Atoms/James Clear, Habitify, Productive, Notion, Todoist, HabitMate, superhabit — 'Many of the others (even Atoms from James Clear) is over complicated and almost… distracting'",
  "simplest in the category", "praise", "126 (14.29%), mean 4.96, 96.0% 5★, zero 1–2★; US 19.4%", "do", "high-priority", "yes",
  ["12134207623"])
c(23, "Part 0 §8 (The public rating is 0.24–0.44 stars higher than what people write) table (verbatim)", "data-caveat",
  "Written reviews run below tap-only ratings in all eight storefronts checked — tap ratings are collected in-app at a moment of satisfaction; the written corpus is the leading indicator, and it says 4.42 for 2026",
  "n/a", "mixed", table("## 8. The public rating"), "do", "observed", "yes", [])
c(24, "Part 0 §9 (A late-2026 UI redesign is producing the app's first design backlash); Part 4 #21; §8.3; Part 9 #3", "timeline",
  "A late-2026 redesign produced the app's first design backlash, a tight dated cluster: 'the latest redesign of the 5-day screen does not work… I'm going to hunt for an alternative app'; 'not what I paid £29.99 for… Why is everything bigger?'; 'the compact view isn't very compact anymore'; 'Liked it better with words' — three of five quoted are payers; [external] 1.16.0 'A refreshed look', 1.17.1 compact-list changes; balanced by 'Love the new look'; 3 weeks old — watch, don't over-read",
  "shipped refreshed look + compact-list changes Aug 2026", "1★-burst",
  "7 (0.79%, EMERGING), mean 2.43, 57.1% 1–2★; 6 of 7 dated Aug 2026+; 0.00% → 0.43% → 0.00% → 3.03%; paid cohort 3 of 7 (42.9%); both GB instances are payers", "must-never-break", "emerging", "yes",
  ["14447636722","14452015607","14452046441","14462152671","14488967268","14467718205"],
  side="repro: iPhone 14 with display zoom + large text; fix with a text-size / density option or an opt-out")

with open("Tools/prd_ledger/7/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
