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


# ---- PART 1 — MONETIZATION ----
c(25, "Part 1 intro; §1.1 The model, reconstructed from the corpus + listing — prices table (verbatim)", "timeline",
  "Prices reviewers actually report: monthly ≈ $2 / £1.99, yearly ≈ $12–13, lifetime ≈ $30 / €35 / £29.99; the lifetime price roughly doubled between Dec 2022 ($15) and late 2024 (€35)",
  "free download; Pro = monthly / yearly subscription OR one-time lifetime; no ads; no account; local-only data", "mixed",
  "212 reviews (24.04%) touch money; " + table("## 1.1 The model", 0), "none", "verbatim", "app-specific",
  ["9410648676","11174986923","11526306665","11530931211","11818567731","11942193233","11994502139","12076054585","12032382845","12163780356","12481828605","12533700383","13275907556","13596249635","13621381288","14093446153","14452015607","14374370548","14463193980"])
c(26, "§1.1 Reading: every too-expensive complaint after Oct 2024 is about lifetime; §8.3 price objection two peaks", "monetization",
  "Every explicit 'too expensive' complaint dated after Oct 2024 is about the lifetime number, never the monthly one — and the price objection has two peaks (2024 and 2026), both following a lifetime price increase (to €35 in late 2024; still €35/£29.99 in 2026 while a $12/year SKU exists); correlation only, no causal claim",
  "lifetime $15 (Dec 2022) → €35 (late 2024)", "complaint", "price objection 0.00% (P1) → 2.99% (P2) → 0.65% (P3) → 3.03% (P4)", "research", "correlation", "yes",
  ["11818567731","11942193233","11994502139","14093446153"],
  cond="raising the lifetime price draws price objections even in the markets that praise lifetime most")
c(27, "§1.1 Free / paid split as reviewers experience it table (verbatim)", "data-caveat",
  "Free/paid split as reviewers experience it: 4 habits, calendar, archive, streaks, one reminder, categories, Shortcuts, backfill free; unlimited habits, widgets, charts & statistics, export/import, compact-list configuration, 2nd/3rd reminder Pro; no ads for everyone",
  "n/a", "mixed", table("### Free / paid split"), "none", "verbatim", "app-specific",
  ["12313286063","14374370548","13779234074","10771302089","12760644253","13018758207","13905806444","12183236954","13059439732","11031287982","11530931211","13904375498","13188634050","13680396177","12336116396"])
c(28, "§1.1 Charts & statistics Pro; Part 3 #10; §7.3", "feature",
  "Charts & statistics are Pro and praised where used — and are one of the two paid features users most want to preview before buying ('I wish I could see how the charts are before purchasing')",
  "Pro", "praise", "Charts & statistics praise 41 (4.65%, VERY STRONG), mean 4.59, 78.0% 5★; top-10 volume storefronts 5.8% vs long tail 1.9%", "build-paid", "very strong", "yes",
  ["12183236954","13059439732","11031287982"])
c(29, "§1.1 Discrepancy worth naming; Part 4 #33 Export locked / GDPR objection", "feature",
  "Data export/import is Pro while the store listing advertises 'IMPORT AND EXPORT — Switching phones and don't want to lose your data?' with no sign it is paywalled; users hit exactly that — 'you cant even import/export if you change devices without also paying for it'; 'I cannot export my data without buying the subscription. It is against GDPR.'",
  "export/import Pro; listing implies free", "1★-burst", "Export locked / GDPR objection 2 (0.23%), mean 1.00, 100% 1–2★", "build-free", "weak, severe", "yes",
  ["11530931211","13904375498"], side="a rights/regulatory framing, not a price objection")
c(30, "§1.1 compact-list configuration and 2nd/3rd reminder Pro [external]; Part 4 #25; Part 6 #13", "feature",
  "A 2nd/3rd reminder per habit at different times shipped as a Pro feature (changelog 1.14), as did compact-list configuration (1.13); the request is asked by satisfied users",
  "Pro", "praise", "Wants multiple reminders per habit 6 (0.68%), mean 4.50, 0% 1–2★", "build-paid", "emerging", "yes", [])
c(31, "§1.1 Calendar, archive, streaks, reminders(1), categories, Shortcuts, backfill Free; No ads row; Part 3 #17", "feature",
  "The core loop is free — calendar, archive, streaks, one reminder per habit, categories, Shortcuts, backfill — and there are no ads for anyone; 'no ads' reviews are all 5★",
  "free", "praise", "No ads 7 (0.79%), mean 5.00, 100% 5★", "build-free", "emerging", "yes",
  ["13188634050","13680396177","12336116396"])
c(32, "§1.2 The explicit-paid cohort — 75 reviewers (8.50%) table (verbatim)", "data-caveat",
  "Explicit-paid cohort vs rest of corpus (first-person purchase statements only; 10 inferred-only excluded)",
  "n/a", "mixed", table("## 1.2 The explicit-paid cohort", 0) + " ; distribution 5★ 48 · 4★ 11 · 3★ 3 · 2★ 6 · 1★ 7; US 28, DE 8, CA 7, GB 5; by year 2023 3 (2.11%) · 2024 17 (7.26%) · 2025 30 (9.74%) · 2026 25 (12.63%)", "none", "verbatim", "app-specific", [])
c(33, "§1.2 Paying reviewers rate 0.44 stars lower and are 3× more likely to leave 1–2★", "must-never-break",
  "Paying reviewers rate 0.44 stars lower and are 3× more likely to leave 1–2★ — the central monetization fact in this corpus; the share of reviewers who declare a purchase rose every year, so the buyer base is growing and increasingly vocal",
  "paid cohort 75", "complaint", "paid 4.16 vs rest 4.60; 5★ 64.0% vs 79.8%; 1–2★ 17.3% vs 5.8%; declared payers 2.11% → 7.26% → 9.74% → 12.63%", "must-never-break", "segment rate (n = 75)", "yes", [])
c(34, "§1.2 What paying reviewers over-index on table (verbatim)", "data-caveat",
  "Paid-cohort over-indexes against an 8.5% baseline: pro_entitlement_broken 100%, bug_reported 43.8%, subscription_objection 40.0%, redesign_complaint 42.9%, praise_onetime_price 35.6%",
  "n/a", "mixed", table("### What paying reviewers over-index"), "none", "verbatim", "app-specific", [])
c(35, "§1.2 The free-tier grievances and the buyer grievances are two disjoint populations", "insight",
  "Free-tier grievances and buyer grievances are two disjoint populations: payers never appear in cap complaints (0 of 27), widget-paywall objections (0 of 13) or upsell nagging (0 of 8) — free-tier complaints tell you why people don't buy; paid complaints (bugs, broken entitlement, subscription objection, redesign) tell you why buyers churn",
  "n/a", "mixed", "cap 0/27, widget paywall 0/13, upsell 0/8 in paid cohort; bug_reported 7 of 16 (43.8%), subscription objection 22 of 55 (40.0%), redesign 3 of 7 (42.9%), price objection 4 of 15 (26.7%)", "product-rule", "segment rates", "yes", [],
  cond="read each complaint theme against the population that produced it before deciding what to fix")
c(36, "§1.3a The one-time / lifetime option is the single most cited reason to pay; Part 3 #9; §7.2 finding 3; Part 9 #7", "monetization",
  "The one-time / lifetime option is the single most cited reason to pay — 'If you're NOT a fan of subscription based services, then THIS IS THE APP FOR YOU… You're not renting this product, it is yours to keep'; one reviewer says lifetime is why he did not drop to 4★ over the habit cap, another would give a bonus star for it",
  "lifetime SKU ≈ $30 / €35 / £29.99", "purchase-driver",
  "45 (5.10%, HIGH-PRIORITY), mean 4.71, 77.8% 5★; 16 confirmed payers (35.6% segment rate); high-spend group 7.2% vs rest 2.0%", "product-rule", "high-priority", "yes",
  ["11999151976","13685738378","13657506354","13344667636","9334266709"])
c(37, "§1.3b Widgets as purchase trigger", "feature",
  "Widgets are a real purchase trigger for some: 'Probably upgrading to paid soon for widget feature'; 'the widgets alone are worth the money'",
  "widgets Pro", "purchase-driver", "8 (0.91%), 3 confirmed payers, mean 4.88", "undecided", "emerging", "yes",
  ["11371105238","13198372302","14274998448","14363513442"])
c(38, "§1.3b vs §0.3 widget paywall", "contradiction",
  "Widgets behind the paywall both sell and repel: 8 buyers name them as the reason to pay (mean 4.88) while 13 object (mean 2.23, zero 5★) — the report resolves it with one free widget and more with Pro, which keeps a paid layer without gating the category",
  "all widgets Pro", "mixed", "8 triggers at 4.88 vs 13 objections at 2.23 (0% 5★)", "build-free", "resolved by recommendation", "yes",
  ["12622891075","13198372302","13905806444"],
  cond="contrast report 3, where widget variants were the #1 purchase trigger with the base widget free")
c(39, "§1.3c Hitting the habit cap", "insight",
  "Hitting the habit cap does convert some users — 'Ich hab mir sofort die Pro Version geholt, weil ich auch noch mehr als 4 Gewohnheiten tracken wollte'; 'Instantly went for the pro subscription cause I wanted to add habits for everything' — but none of them are among the 27 who complain about it",
  "4-habit cap", "purchase-driver", "4 quoted buyers; 0 of 27 complainers paid", "undecided", "quoted", "yes",
  ["14374370548","13779234074","14028004356","12132760416"])
c(40, "§1.3d Supporting the indie developer — a genuine, repeated motive, not politeness", "insight",
  "Supporting the indie developer is a genuine, repeated purchase motive, not politeness: 'I mostly subscribed to be supportive'; 'I like to support independent creators'; 'you also value user data and privacy… 5 stars – you have a new pro subscriber'; a developer from his own region",
  "solo indie, privacy-first", "purchase-driver", "5 quoted buyers", "do", "quoted", "app-specific",
  ["11339667935","12934931415","12639428322","13843530419","13003206041"],
  cond="depends on a visible, named, likeable indie maker")
c(41, "§1.3e A trial period of using the free tier first", "insight",
  "The free tier is doing real trial work for the buyers it does not annoy: buyers describe delays of 6 weeks, a month, a week, two months before upgrading, or monthly then yearly within a week",
  "4-habit free tier as de facto trial", "purchase-driver", "5 quoted buyers with stated delays", "build-free", "quoted", "yes",
  ["12159772330","12934931415","13596249635","14469978356","13603385121"])
c(42, "§1.4 Barrier 1 — the €35/$30 lifetime price, specifically; Part 4 #10", "monetization",
  "Barrier 1 is the €35/$30 lifetime price specifically — 'The app does not have enough features to justify the $13 pro. $5 or $10 would be more acceptable'; 'Ich hab schon bis zu 500€ für Apps bezahlt. Aber hier reden wir über die Simpelste Utility vorstellbar'",
  "lifetime €35 / $30", "complaint", "Price too high 15 (1.70%, MEANINGFUL), mean 2.73, 46.7% 1–2★; paid cohort 4 of 15 (26.7%)", "research", "meaningful", "yes",
  ["11942193233","12076054585","14093446153","13621381288","12032382845"])
c(43, "§1.4 an explicit competitive churn at a stated price point", "positioning",
  "An explicit competitive churn at a stated price point: '35€ for lifetime access for (essentially) an automated excel sheet was just too much… I found a great habit tracker app for 6.99€ (lifetime)' — a simple utility is benchmarked against cheap lifetime competitors",
  "€35 lifetime", "churn", "1 (3★, DE) — the only reviewer who names a competitor's price and switches", "research", "quoted (n = 1)", "yes",
  ["11942193233"])
c(44, "§1.4 CA$40 — bought, resents it, 5★", "monetization",
  "A buyer who pays and resents it: 'making people pay 40$ CA for lifetime usage. It's taking advantage of people. I still paid it because I don't feel like returning to other apps, but that's an abusive amount' — rated 5★",
  "CA$40 lifetime (~US$30)", "mixed", "1 (5★, CA)", "research", "quoted (n = 1)", "yes", ["12076054585"])
c(45, "§1.4 cross-platform price-parity objection", "market",
  "Cross-platform price-parity objection: '$2 a month. Too pricy for me, twice the cost of same subscription on android'",
  "$2/month on iOS", "1★-burst", "1 (1★, US)", "research", "quoted (n = 1)", "yes", ["12032382845"])
c(46, "§1.4 Barrier 2 — no trial; Part 4 #22; Part 9 #9", "monetization",
  "Barrier 2 is no trial: users ask to try before paying, and the features they most want to preview are exactly charts and widgets — the two things a screenshot cannot convey; add a real trial for those two",
  "no trial", "blocked-conversion", "Wants trial before buying 7 (0.79%, EMERGING), mean 4.14, 14.3% 1–2★", "undecided", "emerging", "yes",
  ["10332746889","12181661428","11031287982","14248083289","11920130040"])
c(47, "§1.4 Barrier 3 — a willing buyer literally could not give the developer money; Part 9 #7", "must-never-break",
  "Subscription → lifetime is not possible in-app: two 5★ customers in the same week (11 Jul 2026) tried to switch and could not — 'I wanna buy the lifetime subscription but I can't find it anywhere, it only shows month or yearly'; [external] the FAQ says this is by design: cancel the subscription, let it expire, then buy lifetime",
  "no in-app cross-grade from subscription to lifetime", "blocked-conversion", "2 (5★, US + ES), same week; [limited evidence] but mechanism documented", "must-never-break", "limited evidence, documented", "yes",
  ["14288167581","14289596763"], cond="contrast report 6, where the lifetime purchase did not cancel the running subscription and double-billed")
c(48, "§1.4 Barrier 4 — China storefront cannot buy at all; §7.4 CN", "market",
  "The China storefront looks unserved rather than under-served: 2 of 4 CN reviews are purchase failures ('无法购买会员' — cannot purchase membership; '怎么开会员 / 怎么设置中文啊' — how do I buy / how do I set Chinese?) and a third asks for Chinese, on a 100% English-only listing",
  "EN-only listing; purchase fails in CN", "blocked-conversion", "4 CN reviews total: 2 purchase failures, 2 Chinese requests [limited evidence]", "research", "limited evidence", "unknown",
  ["11442530087","11183018670","11385868721"])
c(49, "§1.4 Barrier 5 — no Family Sharing; Part 4 #32; Part 6 #17", "feature",
  "No Family Sharing loses sales: 'after I paid for it I couldn't let my family use it? Paying for Pro Lifetime would have felt much better if my kids could use it too'; 'it doesn't support family sharing so I will probably uninstall it and try another'",
  "absent", "churn", "2 (0.23%, Weak), mean 4.00 — one lost expansion sale (payer), one stated churn", "research", "weak", "yes",
  ["12266571361","14057511657"])
c(50, "§1.5 Subscription aversion is loud but mostly non-fatal; Part 4 #2", "insight",
  "Subscription aversion is loud but mostly non-fatal: the theme is bimodal (32 of 55 are 5★ praising that a subscription is NOT required) and 22 of 55 are confirmed payers who subscribed while complaining — the lesson is not 'drop subscriptions' but that the lifetime SKU is doing enormous defensive work and must stay visible and purchasable",
  "subscription + lifetime", "mixed",
  "55 (6.24%, HIGH-PRIORITY), mean 3.84, 27.3% 1–2★; 32 of 55 5★, 15 1–2★; 22 of 55 payers (40%); 4.93% → 5.13% → 6.17% → 8.59%; DE 9.3%, US 8.1%", "product-rule", "high-priority", "yes", [])
c(51, "§1.6 Upsell pressure is small — and that's an asset; Part 4 #19; Part 9 #10", "product-rule",
  "Do not solve the conversion problem by adding upsell pressure — this corpus explicitly rewards its absence: 'I personally hate when developers force users into buying a subscription… by nagging with constant ads… Habitkit is one of the rare gems among many slop apps'; 'no te bloquea todo ni te insiste en hacer el upgrade'; the few complaints ('wayyyy too many ads of premium', 'Annoying popups' Aug 2026) are the exception",
  "light upsell", "praise", "Upsell nagging 8 (0.91%), mean 3.25, 37.5% 1–2★; 0 of 8 are payers", "product-rule", "defended position", "yes",
  ["13206904375","11714676984","14088197028","12253135804","14488967268"])

with open("Tools/prd_ledger/7/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
