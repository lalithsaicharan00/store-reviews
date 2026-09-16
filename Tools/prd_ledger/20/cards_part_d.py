import json, re
R = 20
rep = open("App Store Reports/20. Habit — Daily Tracker - Crush your goals like a boss (REPORT).md").read().split("\n")
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

# ---- PART 6 ----
c(69, "§6.1 Eligibility", "market",
  "11 storefronts have ≥50 reviews (us, ru, ca, gb, de, au, ua, pl, es, fr, in) = 3,310 = 81.8%; 71 storefronts below 50 (738, 18.2%) are in every global calculation but draw no standalone conclusion", "n/a", "none", "11 eligible; 3,310 (81.8%)", "none", "method", "app-specific", [])
c(70, "§6.2 The eligible-country table (verbatim)", "market",
  "Per-country own-denominator rates (n, mean, revoked, sub-model, price, data loss, pop-ups, widget, support, 3-cap, simple, design): us 963 3.13 18.8/20.0/7.0/8.4/6.7/5.6/4.7/2.9/30.0/16.9; ru 951 3.28 7.9/19.7/2.2/3.8/4.7/0.5/1.7/2.4/31.4/11.6; ca 442 3.45 19.0/19.7/7.0/4.1/6.1/5.4/4.1/1.8/35.5/16.1; gb 298 2.74 26.2/28.5/13.4/8.7/11.1/5.7/4.4/4.0/25.8/11.4; de 162 2.52 13.0/29.0/8.0/6.2/6.8/8.0/3.7/1.9/20.4/19.1; au 114 2.81 27.2/34.2/14.0/10.5/11.4/5.3/9.6/2.6/21.1/11.4; ua 111 3.24 9.9/12.6/0.9/2.7/3.6/3.6/2.7/2.7/12.6/5.4; pl 72 2.44 30.6/25.0/1.4/12.5/5.6/5.6/8.3/8.3/8.3/13.9; es 71 2.63 2.8/11.3/16.9/1.4/1.4/4.2/1.4/1.4/28.2/8.5; fr 66 3.03 10.6/16.7/7.6/1.5/1.5/3.0/1.5/0.0/34.8/13.6; in 60 3.07 13.3/28.3/10.0/8.3/1.7/8.3/3.3/3.3/26.7/13.3",
  "n/a", "mixed", table("## 6.2 The eligible-country table"), "none", "≥50 storefronts", "app-specific", [])
c(71, "§6.3 Group A — high-review-volume markets", "market",
  "Top five storefronts us, ru, ca, gb, de = 2,816 = 69.6%, mean 3.19 — this group is the corpus for practical purposes; its two largest members (us, ru) behave very differently and their difference drives most global averages", "n/a", "mixed", "2,816 (69.6%), mean 3.19", "none", "method", "app-specific", [])
c(72, "§6.4 Group B — high-spend markets (verbatim table) — the damage landed hardest on the highest-value cohort", "market",
  "High-spend group (analyst assumption, disclosed: us, gb, de, ca, au, fr; JP excluded at n=8) n=2,045 (50.5%), mean 3.06 vs ru+ua 1,062 at 3.28; revoked purchase 19.3% vs 8.1% (+11.2 pts); price 8.4% vs 2.1%; data loss 7.0% vs 3.7%; widget broken 5.8% vs 0.8% (7×); support silence 4.8% vs 1.8% — the revocation and delivery grievances are concentrated in exactly the markets that generate revenue; Group B reports revocation at 2.4× the ru/ua rate",
  "n/a", "1★-burst", table("**Group B: us, gb, de, ca, au, fr"), "must-never-break", "very strong", "yes", [])
c(73, "§6.5 Russia — n = 951, mean 3.28 (the corpus's biggest anomaly)", "market",
  "Russia (23.5% of corpus) rates higher than US/UK/DE/AU despite the same product because: Russian reviews are weighted to 2019 when the app was free and the guilt prompt was harvesting one-line 5★ ('Отлично', 'Супер', 'Ничего лишнего'); the widget complaint is almost absent (0.5% vs 5.6% US) because Russians largely did not buy it — a purchase-exposure difference, not satisfaction; price objections are absolute not comparative (3,150₽/year called simply unaffordable for a checkbox app); when Russians were exposed they reacted identically — Russian revocation complaints (75) are among the angriest and the top two most-upvoted reviews in the entire corpus are Russian revocation complaints (39 and 27 net votes); do not read 3.28 as the product working better there",
  "n/a", "mixed", "n=951, mean 3.28; widget 0.5%; revocation 75; top upvotes 39 / 27", "none", "≥50 storefront", "app-specific",
  ["6925082543","6925476346","7183192208","7389399093","6918320995","6919032834"])
c(74, "§6.6 The worst-rated eligible markets — Poland, Germany, Australia, United Kingdom", "market",
  "Poland (72, 2.44): highest revocation (30.6%) and data-loss (12.5%) rates, the clearest 'good app, terrible policy' split; Germany (162, 2.52): highest subscription objection among large markets (29.0%) and the most legally-framed language ('Abzocke', 'Betrug', 'Fall für die Aufsichtsbehörde'), also the highest design-praise rate (19.1%) — they liked it and were angriest; Australia (114, 2.81): worst combination of revocation 27.2%, subscription 34.2%, price 14.0%, support silence 9.6%; AUD $65.99/year the highest price point reported anywhere; UK (298, 2.74): 26.2% revocation, 13.4% price, 11.1% pop-ups; £38.99 repeatedly called disproportionate",
  "n/a", "1★-burst", "pl 2.44, de 2.52, gb 2.74, au 2.81", "none", "≥50 storefronts", "app-specific",
  ["10861684977","12418376691","6931210500","6944765620","6970697308","7048580615"])
c(75, "§6.7 Spain and France — the outliers that prove the mechanism: grievance follows arrival date, not nationality", "insight",
  "Spain (71, 2.63): revocation only 2.8% — lowest of any eligible market — but price objection 16.9%, the highest; Spanish users largely arrived after the conversion, never lost anything, and simply refused €43.99; France (66, 3.03): 34.8% simplicity praise (highest alongside Canada), 0% cap complaints — a predominantly E1 cohort; the grievance profile follows arrival date, not nationality",
  "n/a", "mixed", "es revocation 2.8% / price 16.9%; fr simple 34.8%", "none", "≥50 storefronts", "yes", [])
c(76, "§6.8 What does not vary by country — feature requests are strikingly uniform", "market",
  "Apple Watch, notes, streaks, categories, multi-per-day and weekday selection appear at similar rates in every storefront with enough volume; there is no localisation-specific product need in this corpus", "n/a", "none", "uniform across 11 eligible storefronts", "none", "≥50 storefronts", "yes", [])
c(77, "§6.9 Localisation [limited evidence]", "market",
  "Only 10 reviews (0.25%) raise language, but coherently: the app shipped Russian-first UI to some non-Russian users (cn, fr, ch — a German user asking how to get English); Chinese support existed and was later lost ('why no Chinese, there was Chinese a few years ago', 2025); translation quality criticised in German and Spanish; Ukrainian requested and never added",
  "Russian-first UI leaked; Chinese localisation removed", "complaint", "10 (0.25%, weak)", "do", "limited evidence", "yes",
  ["5548679381","5121688833","5303861781","13178312149","6880333515","6219859799","6528512849","8870732609"])
c(78, "§6.10 Sub-50 storefronts [limited evidence]", "market",
  "Small storefronts skew to the extremes — cy/si/sk/rs/ec at 1.00–1.33 are all post-conversion arrivals, cr/ve/ng at 4.67–5.00 all E1; Asian storefronts skew positive and early (vn 40 4.03, ph 38 4.08, cn 35 4.06, tw 17 4.06, id 18 4.33 — E1-weighted, widget failure barely reaches them); South Korea (15, 2.40) is the most negative small market with 5 of 15 revocation or premium-not-working reports",
  "n/a", "mixed", "71 storefronts, 738 reviews", "none", "limited evidence", "app-specific",
  ["6923303445","6926102098","6932463780","6939881361","6946432090"])

# ---- PART 7 ----
c(79, "§7.1 Method", "data-caveat",
  "Trends assessed by monthly volume and mean, era-relative theme rates, and date-anchored event windows; a trend is claimed only where volume supports it, otherwise listed as not claimed", "n/a", "none", "method", "none", "method", "yes", [])
c(80, "§7.2 Trend 1 — The conversion. Dated to the day, permanent (verbatim table)", "timeline",
  "Daily: 25 Jan 2021 n1 5.00; 26 Jan n2 2.00; 27 Jan 61 at 1.15; 28 Jan 135 at 1.36; 29 Jan 127 at 1.22; 30 Jan 67 at 1.27; 31 Jan 60 at 1.32; 1 Feb 62 at 1.23; monthly: Dec 2020 38 reviews mean 4.29 → Jan 2021 503 at 1.54 → Feb 2021 485 at 1.60 — a 13× volume increase and a 2.75-star collapse in 24 hours; the mean never recovered — every subsequent year sits between 1.44 and 2.58",
  "one-release collapse", "1★-burst", table("## 7.2 Trend 1"), "product-rule", "very strong", "yes", [])
c(81, "§7.3 Trend 2 — The free tier was gutted at the same moment; the cap behaved as a lifetime cap", "timeline",
  "The free cap of 3 runs at 6.6% of E3 (E1 hits are praise-context false positives — 5★ thanks for not capping); N-unlimited-removed (63) is entirely post-conversion; worse, the cap behaved as a lifetime cap, not a concurrent one — users who deleted a habit to make room could not add a replacement, turning a pricing decision into a functional dead end",
  "3-habit lifetime cap", "1★-burst", "6.6% of E3; 63 unlimited-removed; 6 lifetime-cap IDs", "product-rule", "very strong", "yes",
  ["3918690923","4225873197","4226652382","5616772165","6169817900","7266229179","7266633441","7090282099","7451472900","8381455001","7436424719"])
c(82, "§7.4 Trend 3 — Aggressive monetisation UX arrived and never left; over four years of a 'limited time offer'", "timeline",
  "Aggressive pop-ups 12.6% of E2 → 8.1% of E3 (E1 hits are praise for not nagging); the non-expiring countdown is reported Jan 2021 → Mar 2025 — over four years of a 'limited time offer'", "permanent fake countdown", "1★-burst", "12.6% E2 → 8.1% E3; 7 dated IDs Jan 2021–Apr 2025", "dont", "very strong", "yes",
  ["4152251500","4658115513","4907892894","6716937579","6920136171","7130719014","7696949663","8774978626","9598232878","10403199089","12548894139"])
c(83, "§7.5 Trend 4 — The widget: promised 2020, broken through 2025, never fixed", "timeline",
  "Apr 2019 a Today-view widget ships paid and works; Sep–Dec 2020 iOS 14 arrives, users ask for the Home Screen widget, screenshots show one, purchases begin specifically for it; Jan 2021 onward broken or absent for large numbers of payers, the in-app FAQ's first question addresses it with 'restart your phone'; still reported May 2022, Dec 2022, Jun 2023, Mar 2024, Mar 2025; even when present it was the Today-view widget, not Home Screen — buyers in 2022 and 2023 expected Home Screen placement; 182 reviews, mean 1.94, five years, no fix — the clearest sustained delivery failure in the report",
  "sold on a Home Screen widget it never had", "1★-burst", "182 (4.50%), mean 1.94; 2019 → 2025", "must-never-break", "very strong", "yes",
  ["3995542358","4474121227","6460660006","6744055213","6777922510","8625708859","9365771044","10034018726","11099954846","12456466846","9954684066","9400779376"])
c(84, "§7.6 Trend 5 — Support degraded from responsive to absent", "timeline",
  "In 2019 the developer answered reviews and fixed reported bugs — a bug fixed and followed up, a rating changed after a reply, a same-day fix praised (Oct 2020); by 2021 gone: support-silent 0.05% of E1 → 6.6% of E2 → 8.0% of E3 → 13.0% of E4; from 2022 the in-app 'Contact Us' pointed to a dead email with an autoresponder telling users to write elsewhere, and the Instagram account — the other stated support channel — dormant since 2019",
  "responsive → dead address", "churn", "0.05% → 6.6% → 8.0% → 13.0% by era", "must-have", "very strong", "yes",
  ["6319774608","4702811610","6560591296","8651373725","11655625375","11590913646","9623996845","6937097883","11408456954"])
c(85, "§7.7 Trend 6 — March 2025: the data wipe (verbatim table); four aggravating factors", "timeline",
  "Daily: 13 Mar 2025 n3 2.33; 14 Mar 30 at 1.30; 15 Mar 25 at 1.20; 16 Mar 18 at 1.50; 17 Mar 12 at 1.17; 18 Mar 14 at 1.14; update 1.41.0 erased histories globally — 126 of 161 E4 reviews (78.3%) report data loss; losses of 5, 4, 3 and 2 years; aggravating: (1) the advertised fix 1.42.1 did not work for many; (2) a second ongoing bug — checking off a new day wiped prior progress; (3) recovery was paywalled — iCloud backup premium and manual: 'Why should a premium subscriber even have to think about whether a backup was created? These are basic things that should happen by default'; (4) no communication — 'There has been no communication whatever about this disaster'; the reason 2025 (1.44) is the worst year on record",
  "global wipe; broken fix; paid manual backup; silence", "1★-burst", table("## 7.7 Trend 6"), "must-never-break", "very strong", "yes",
  ["12426668716","12427371564","12420755807","12468809976","12428057196","12429581990","12419464329","12432752145","12432192929","12433912249","12434390238","12434443412","12435448827","12442437668","12435186760","12436537687","12436240564","12440851208","12486017227","12424709744","12421785170","12440071394","12448085062"])
c(86, "§7.7 Second, ongoing bug — checking off a new day wiped prior progress", "must-never-break",
  "After the March 2025 wipe a second bug appeared: checking off a new day wiped prior progress", "check-off destroys history", "1★-burst", "4 IDs", "must-never-break", "close reading", "yes",
  ["12435186760","12436537687","12436240564","12440851208"])
c(87, "§7.8 Trends explicitly NOT claimed", "data-caveat",
  "Not claimed: any 2026 trend (12 reviews); improvement after Feb 2021 restoration (E3 1.93 vs E2 1.57 on a collapsed self-selected base); localisation (10); privacy (17 across 7 years, two isolated flare-ups — a Jul 2019 privacy-policy critique and a Jan 2020 Facebook-data question); crash trend (27, clustered on a Jun 2019 add-habit crash and a 20 Oct 2020 launch failure fixed next day with users praising the speed); any causal claim that the developer change caused the conversion",
  "n/a", "none", "6 non-claims", "none", "method", "app-specific",
  ["4498682042","5462587159","6557009066","6560591296"])
c(88, "§7.8 20 Oct 2020 launch failure fixed next day — users praised the speed", "tactic",
  "A 20 Oct 2020 launch failure was fixed the next day and users praised the speed", "fast fix", "praise", "2 IDs", "do", "close reading", "yes", ["6557009066","6560591296"])
c(89, "§7.9 The ownership question — reported, not established [weak, 14 reviews]", "data-caveat",
  "14 reviews (0.35%) reference an owner or developer change: one states the app 'got bought out by the Reflectly developer' (Jan 2021), one addresses the developer as 'Reflect X ApS' (Feb 2021), others infer it — 'it feels like the owner changed: the policy was updated and all the data was wiped'; by 2025 users address 'kodeon ai', matching the manifest developer Kodeon, Inc.; established: the developer of record differs from the entity addressed in 2021 and the conversion coincided with a visible change in monetisation philosophy; not established: any transaction, date, or causation",
  "possible ownership change at conversion", "none", "14 (0.35%, weak)", "research", "weak", "app-specific",
  ["6927714116","6962322574","7020673861","7039457424","12431520165"])

with open("Tools/prd_ledger/20/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
