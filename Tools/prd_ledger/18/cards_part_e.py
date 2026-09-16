import json, re
R = 18
rep = open("App Store Reports/18. MyRoutine - Organize your day - Built around your real life (REPORT).md").read().split("\n")
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

# ---- PART 7 ----
c(114, "§7.1 The three eligible storefronts (≥50 reviews) — theme comparison table (verbatim)", "market",
  "KR / JP / US own-denominator rates: free-tier restriction 6.38% / 8.07% / 8.33% (all HIGH); trial/billing 7.07% / 5.38% / 2.38%; entitlement failure 1.19% / 2.24% (mean 1.00★) / 0; data loss 6.32% / 6.28% / 2.38%; crash 5.69% / 3.14% / 10.71%; widget 11.57% / 7.62% / 11.90%; order/edit 7.44% / 2.69% / 4.76%; complexity 6.75% / 10.76% / 8.33%; localisation 0.31% / 3.14% / 0; timer 1.31% / 6.28% / 8.33%; ADHD 1.44% / 3.14% / 5.95%; social 3.69% / 0.90% / 3.57%; merged view 2.75% / 0.45% / 1.19%; confirmed payer 8.94% / 6.28% / 3.57%; design praise 7.44% / 12.11% / 11.90%; life change 6.13% / 9.87% / 5.95%",
  "n/a", "mixed", table("## 7.1 The three eligible storefronts"), "none", "≥50 storefronts", "app-specific", [])
c(115, "§7.1 Korea (n=1,599, mean 3.95) — the home market and the whole business", "market",
  "Korea is the only storefront where the social layer is very strong (3.69%) and where the merged routine+to-do view matters at scale; the paywall history is lived in full there; Korean reviews are the longest and most structured — several read as unpaid product consultancy; KR-specific mechanics: KakaoTalk login breaks repeatedly on PC/Mac, KakaoTalk is the only support channel and is closed at weekends, and reviewers ask for KakaoPay and Kakao gifting",
  "KakaoTalk login/support; no KakaoPay", "mixed", "n=1,599 (78.08%), mean 3.95; confirmed payer 8.94%", "do", "≥50 storefront", "app-specific",
  ["10444375042","10851299280","11700463203","14184795326","13042903108","8221813827","8472416777","8572620032","10816022292","10574355802","11697109244","13244453495"])
c(116, "§7.1 Japan (n=223, mean 3.37 — 0.58 below Korea) — three fixable causes", "market",
  "Japan's deficit has three fixable causes: (1) localisation (3.14% very strong vs 0.31% KR) — Japanese Instagram ads led to an app that opened in Korean with a KakaoTalk login ('the Japanese is odd', half-Korean UI), largely fixed by 2 Sep 2022 but Korean push notifications persisted into 2023 and the terms page is English-only, which is why one reviewer refused to trial; (2) entitlement failures are catastrophic — 5 reviews, every one 1★ (mean 1.00); (3) the support channel is broken (feedback form rejects valid emails, text invisible in dark mode); strengths: timer 6.28% (vs 1.31% KR), ADHD fit 3.14%; JP uniquely asks for auto-advancing timers and Apple Watch timer parity",
  "shipped JP marketing before JP localisation; broken JP support form", "mixed", "n=223 (10.89%), mean 3.37; localisation 7 (3.14%); entitlement 5 (mean 1.00★); timer 14 (6.28%)", "do", "≥50 storefront", "yes",
  ["8991795108","9042880275","9000746331","9041592638","9044125551","10540063845","12024690867","14238803827","14248568509","14247429732","14179422656","12777592140","13757721182","13576075338","13712167027","9744682977","14328062792","14045116089","13435011015","12428102869","13431240197"])
c(117, "§7.1 Japan — auto-advancing timers (unique JP request)", "feature",
  "Japanese reviewers uniquely ask for auto-advancing timers (next routine starts automatically when the previous one ends)", "timer does not auto-advance", "complaint", "4 JP IDs", "undecided", "close reading", "yes",
  ["14328062792","14045116089","13435011015","12428102869"])
c(118, "§7.1 United States (n=84, mean 3.82) — two populations", "market",
  "The US storefront is two populations: Korean-diaspora users (13 of 84 in Korean) who hit the timezone bug (US daylight saving unhandled; asks for a refund), and native English users for whom ADHD fit (5.95%, the highest of any storefront) and the timer (8.33%) dominate praise while crashes (10.71%) and sign-in requirements dominate criticism; several US teen/child reviewers describe the app as completely free — the opposite of KR/JP in the same period — either the free tier is enforced differently or they had not yet hit the completion quota: a research question, not a finding",
  "n/a", "mixed", "n=84 (4.10%), mean 3.82; ADHD 5 (5.95%); timer 7 (8.33%); crash 9 (10.71%)", "research", "≥50 storefront", "app-specific",
  ["7667185054","8850150608","10288775267","8288427147","8592955634","11951042522","11067291310","11993264527","12292226361","12234125678","12244913951","11432555244","11538265895","12230682122","13866825904"])
c(119, "§7.1 US Korean-diaspora timezone bug (incl. DST unhandled)", "must-never-break",
  "Korean-diaspora users in the US/CA hit a timezone bug — the day rolls on Korean time; US daylight saving is unhandled; one asks for a refund; span 2021-08 → 2024-11", "timezone tied to KR", "churn", "6 IDs; theme 11 (0.54%)", "must-never-break", "close reading", "yes",
  ["7667185054","8850150608","10288775267","8288427147","8592955634","11951042522"])
c(120, "§7.2 High-spend markets — definition and its limits; high-spend storefront table (verbatim)", "market",
  "High-spend group present (US, JP, KR, GB, DE, CA, AU, FR, TW) = 1,996 of 2,048 (97.46%); review volume is not used as a download or revenue proxy; per storefront: kr 1,599 (3.95) paywall history/reliability/reorder; jp 223 (3.37) localisation/entitlement/support; us 84 (3.82) crashes/sign-in/onboarding, ADHD strength; tw 35 (2.60) billing/refund; gb 23 (3.48) paywall/onboarding/sign-in; au 17 (3.71) onboarding excludes shift workers, 'predatory' paywall; ca 15 (3.20) onboarding length + paywall, timezone; fr 6 (2.83) localisation, complexity; de 2 (1.00) billing",
  "n/a", "mixed", table("**High-spend group present in the corpus"), "none", "market table", "app-specific", [])
c(121, "§7.2 Taiwan is the clearest, most fixable market failure in the corpus", "market",
  "Taiwan: 35 reviews, mean 2.60 — 1.35 stars below Korea — and the cause is not the product: 12 of 35 (34.3%) are billing complaints describing one mechanism — the promotional price shown is not the price charged and the refund path dead-ends; Traditional Chinese is largely Simplified wording with untranslated strings ('a paid app should mind this detail'); product complaints are ordinary; fixing the TW price/refund flow and zh-Hant strings is a high-yield, low-engineering intervention in a top-tier spend market",
  "promo price ≠ charged price; refund dead-end; zh-Hant is really zh-Hans", "1★-burst", "n=35, mean 2.60; billing 12 (34.3%)", "do", "sub-50 but severe", "yes",
  ["13994502099","14344435230","14286926161","14196174434","14257555510","14341166322","14458138589","14249011988","14258618311","14130826250","14029976650","14031409160","13819899467","13895676942","14209593301","14011038948","14026637069"])
c(122, "§7.2 Hong Kong (n=7, mean 1.29) — lowest-rated storefront; limited evidence", "market",
  "Hong Kong is the lowest-rated storefront (n=7, mean 1.29) — 6 of 7 are paywall or bug reports in Cantonese, none a product-quality complaint; below threshold, flagged for investigation not action", "n/a", "1★-burst", "n=7, mean 1.29", "research", "limited evidence", "app-specific",
  ["14393820099","14429093675"])
c(123, "§7.3 High-review-volume storefronts", "market",
  "High-review-volume storefronts by this corpus: kr, jp, us — 1,906 reviews, 93.07%; review volume reflects where the app has been marketed, not where it has most users", "n/a", "none", "1,906 (93.07%)", "none", "method", "app-specific", [])
c(124, "§7.4 Sub-50 storefronts — limited-evidence notes (gb, au, ca, hk, nl, fr, vn, th, de, ru, br, lt)", "market",
  "Sub-50 notes: gb (23, 3.48) corroborates onboarding friction on a Pro account, sign-in failure, the listing/feature mismatch on the timer, the corpus's only defence of the pricing and its clearest autistic-user usability report; au (17, 3.71) the sharpest positioning critique, 'predatory dark pattern', a teen's age-gate/age-rating mismatch; ca (15, 3.20) three independent onboarding-abandonment reviews, one noting the in-app support link resolves to an ad; nl (5, 2.40) Dutch translation unintelligible and the displayed price moved 'from over 200 to 68 to 19.90', destroying trust; ads added to the free tier May 2026; fr (6, 2.83) French advertised but unavailable Feb 2023, working by May 2023; vn (7, 4.14) and th (3, 4.67) the most positive small storefronts, price the only reservation; de, ru, br, lt all 1★, all billing or paywall",
  "n/a", "mixed", "12 storefronts under 50", "none", "limited evidence", "app-specific",
  ["14437815273","14379439679","14331337303","14031166609","13149940985","12445646540","13894901307","12857404582","13218586893","13729043534","13848157788","13724277153","14117739778","9641708600","9977436595","11925026971","13172565846","10650286400"])
c(125, "§7.4 nl — displayed price moved 'from over 200 to 68 to 19.90', destroying trust", "monetization",
  "A Dutch reviewer saw the displayed price move 'from over 200 to 68 to 19.90' — wildly moving prices destroy trust even before a charge", "price shown changes drastically", "complaint", "n=1", "must-never-break", "limited evidence", "yes", ["13724277153"])
c(126, "§7.4 ca — in-app support link resolves to an ad", "anti-pattern",
  "A CA reviewer notes the in-app support link resolves to an ad", "support link → ad", "complaint", "n=1", "dont", "limited evidence", "yes", ["13729043534"])
c(127, "§7.4 gb — clearest autistic-user usability report", "audience",
  "The GB storefront contains the corpus's clearest autistic-user usability report", "n/a", "mixed", "n=1", "do", "limited evidence", "yes", ["13149940985"])

# ---- PART 8 ----
c(128, "§8.1 Method — era table (verbatim)", "timeline",
  "Eras anchored to dated clusters of ≥10 reviews: E1 launch/web era/feature build-out 2020-07-06→2022-10-23 n419 mean 4.217; E2 ads era + first restrictions 2022-10-24→2023-11-14 n264 4.064; E3 paywall tightening (to-do → Pro, cap 15→8) 2023-11-15→2024-08-31 n319 3.527; E4 split/rebuild/bundles/timer/modes 2024-09-01→2025-11-30 n656 3.930; E5 modes + billing crisis 2025-12-01→2026-09-06 n390 3.303",
  "n/a", "mixed", table("## 8.1 Method"), "none", "era definition", "app-specific", [])
c(129, "§8.2 Trend 1 — Worsening and dominant: monetisation friction (verbatim table)", "timeline",
  "Monetisation friction by era E1→E5: free-tier restriction 2.63 / 2.65 / 10.97 / 6.10 / 11.79%; trial/billing 0.95 / 5.30 / 8.15 / 8.08 / 12.05%; entitlement failure 0 / 0 / 1.25 / 0.46 / 4.36%; promo-nag 1.19 / 0 / 3.13 / 2.13 / 2.56%; confirmed payer 3.82 / 5.30 / 9.09 / 7.77 / 13.08%; two spikes, two causes — E3's paywall spike is the Nov 2023–Jan 2024 tightening; E5's is worse: billing disputes and entitlement failures rising together while the payer share hits its all-time high — in E5 4.36% of all reviews are from someone who paid and could not use what they bought, a 9.5× increase over E3",
  "monetisation friction worsening", "churn", table("## 8.2 Trend 1"), "product-rule", "era series", "yes", [])
c(130, "§8.3 Trend 2 — Improving then regressing: stability (verbatim table)", "timeline",
  "Stability by era E1→E5: crash 7.40 / 4.17 / 8.15 / 4.27 / 3.85%; lag 4.77 / 4.17 / 3.76 / 1.83 / 5.38%; data loss 3.58 / 7.95 / 6.58 / 6.25 / 6.41%; crashes improved from the Dec-2020 epidemic and the Nov-2023 wave; lag was solved by E4 and regressed sharply in E5 (1.83% → 5.38%) coinciding with routine modes, intensity levels and note/tracker features; data loss has never improved — 6–8% in every era after E1, five years running, the single most durable defect",
  "data loss never fixed; lag regressed with feature load", "churn", table("## 8.3 Trend 2"), "must-never-break", "era series", "yes", [])
c(131, "§8.4 Trend 3 — The widget: from the top request to the top bug surface", "timeline",
  "Widget mentions are the largest single theme (214, 10.45%) and their character inverts: before Dec 2021 31 reviews mean 4.77★, pure requests (one would have paid for it); after launch the top defect surface — blank widgets, disappearing from the picker, wrong weekday, false 'all done', check-off opening the app, routine widget rendering to-dos, font too large; the single most-repeated widget request across five years and every language is 'let me check off without launching the app' — some builds fixed it (jp, Jul 2025) then it regressed",
  "widget shipped, then became the top bug surface; interactive check-off fixed then regressed", "mixed", "214 (10.45%); pre-launch 31 at 4.77★; 11 defect IDs; 4 request IDs 2021→2025", "must-never-break", "era series", "yes",
  ["8039445612","11601155435","11557007642","11554836033","12458833524","13210725274","13597417182","13924535491","14128340502","11599563000","10106353303","13282158897","8173262340","9556123553","10861517833","13101423234","12926497490","13278083524"])
c(132, "§8.5 Trend 4 — Emerging and now central: ADHD and neurodivergent positioning (verbatim table)", "timeline",
  "ADHD/neuro theme by era: E1 0.72% · E2 1.89% · E3 0% (classifier; qualitatively present) · E4 3.05% · E5 1.54%; the KR title now reads 'ADHD 하루 계획표 앱'; the corpus supports the positioning (mean 4.53★, specific mechanism praise) but the same population is most damaged by streak mechanics and the onboarding excludes exactly the irregular-schedule lives ADHD users often have — the positioning is ahead of the product",
  "ADHD positioning in title; product not yet aligned", "mixed", table("## 8.5 Trend 4"), "do", "era series", "yes",
  ["13842532454","12445646540"])
c(133, "§8.6 Trend 5 — Persisted unchanged across all five years (verbatim table)", "timeline",
  "Unresolved in every era and still open in the last month: reorder friction / can't edit future dates 2020-12→2026-09; data loss 2020-12→2026-09; widget check opens the app 2021-12→2026; diary/memo aggregation missing 2022-01→2026-02; no export 2020-11→2026-03 (asked for Excel export in the app's 5th month); statistics without charts or trend 2022→2026; timezone wrong for overseas users 2021-08→2024-11; UI vocabulary confusion (습관 vs 루틴 vs 모드) 2022→2026; a typo in a daily popup ('오늘도 수고 많았아요') still unfixed after a year",
  "nine defects/gaps persisted five years", "complaint", table("## 8.6 Trend 5"), "must-never-break", "era series", "yes",
  ["6813254462","13853005780","6755246776","14496075544","8173262340","14128340502","8278766556","13700701827","6164039764","13843048940","10444375042","14184795326","7667185054","11951042522","12272956378","13439818706","14232607477","14462318051"])
c(134, "§8.6 UI vocabulary confusion (습관 vs 루틴 vs 모드)", "feature",
  "UI vocabulary confusion — 습관 (habit) vs 루틴 (routine) vs 모드 (mode) — persists 2022→2026", "overlapping product vocabulary", "complaint", "3 IDs", "must-have", "close reading", "yes",
  ["12272956378","13439818706","14232607477"])
c(135, "§8.6 A typo in a daily popup still unfixed after a year", "anti-pattern",
  "A typo in a daily popup ('오늘도 수고 많았아요') is still unfixed after a year — a visible signal of neglect on the most-seen surface", "unfixed typo on a daily surface", "complaint", "n=1, ≥2025 → Aug 2026", "do", "close reading", "yes", ["14462318051"])
c(136, "§8.7 Trend 6 — What genuinely improved", "tactic",
  "What improved: bundles + timer (Nov 2024) answered a 2021 request for nested/grouped routines and won loud approval; routine modes (Dec 2025) answered the shift-work request first raised in 2022 and won back a churned subscriber ('神✨'; a KR nurse: 'rain in a drought') though execution is still buggy; dark mode shipped (requested from Dec 2020, present by Feb 2025); widget, Apple Watch, month view and one-tap complete all shipped after sustained request campaigns; responsiveness is visible and valued — several upgrade their rating after a developer reply; 'how is it that everything I think of gets improved one by one??'; the pattern: MyRoutine ships what users ask for, roughly 18–36 months later, and often breaks something else in the same release",
  "ships requests 18–36 months later; often breaks something else", "praise", "6 rating-upgrade IDs; 4 buggy-modes IDs", "do", "close reading", "yes",
  ["6874709836","7765093968","11391766303","12023625379","12815650430","8532953584","14454264522","13795524849","14108692347","13812236928","13685716991","6800233288","12343142427","8519301616","11103012143","12023009972","13039376354","14374239484","14479635630"])
c(137, "§8.7 Routine modes won back a churned subscriber", "tactic",
  "Routine modes (Dec 2025) answered a 2022 shift-work request and won back a churned JP subscriber — a shipped long-standing request re-converts churned users", "shipped a 3-year-old request", "purchase-driver", "n=1 returning churned user + 1 KR nurse", "do", "close reading", "yes",
  ["14454264522","13795524849","8532953584"])

with open("Tools/prd_ledger/18/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
