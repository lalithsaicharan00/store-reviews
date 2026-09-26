import json
R = 1
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=None))

# ---- header ----
c(1, "header line 3-6", "positioning",
  "The app is the category leader: #1 rank in 59 storefronts, 530,893 ratings at 4.78, 56,653 reviews across 127 storefronts",
  "market leader in the habit category", "mixed",
  "530,893 ratings, 4.78 store avg; 56,653 reviews; #1 in 59 storefronts; Feb 2019 → Sep 2026",
  "none", "corpus-level fact", "app-specific", [],
  cond="store-level 4.78 is inflated by the China review campaign (see R01-002)")

# ---- PART 0 ----
c(2, "Part 0 §1 line 29-34", "tactic",
  "Review-for-premium campaign ('leave a review → 3–6 months free Premium', 评论送会员) ran in China 2019–~2022 and turned China into 72% of the corpus",
  "ran the campaign 2019 to ~2022, then stopped", "5★-burst",
  "China = 40,991 of 56,653 reviews (72.4%), mean 4.82; 1,340 CN reviews (3.3% of CN) say outright they review only for the membership; 21,751 CN reviews (53.1%) under 12 chars at mean 4.86; CN 2021+2022 alone = 32,336 reviews at 4.85",
  "dont", "high-priority", "yes",
  ["8904637743","8910739685","8677766507","8513158580","8354830730","7966619964","7523226507","6642189102","5194031778","3916981057"],
  side="produced the #1 rank and the 4.8 store average; but only 0.86% of CN reviewers show any purchase signal (see R01-036) and the developer's own dataset became unreadable",
  cond="home-market campaign; see Part 8 #24 for the report's verdict")

c(3, "Part 0 §2 line 36", "data-caveat",
  "39.1% of all reviews are under 12 characters — four in ten reviews contain zero product information",
  "n/a", "mixed", "22,136 reviews (39.1%) under 12 chars, mean 4.86", "none", "corpus-level fact", "yes", [],
  side="any count in this report is diluted by this filler; the report counts them in every denominator")

c(4, "Part 0 §3 line 38-52", "insight",
  "Outside China the honest rating is ~4.29 and falling toward 3.8; the US 1★ rate more than tripled 2023→2026 (5.4% → 18.1%)",
  "store shows 4.67; non-China reality is ~4.29", "complaint",
  "US mean 4.61 (2019) → 3.81 (2020, 16.2% 1★) → 4.54 (2023, best) → 3.73 (2025, 16.8% 1★) → 3.87 (2026, 18.1% 1★); non-CN monthly mean bottomed at 3.14 in Dec 2024 (65 of 227 reviews 1★) and never returned to 2023 levels",
  "product-rule", "high-priority", "yes", [],
  side="the report says: design against the non-China numbers — the honest baseline for an app of this quality is ~4.29 trending to 3.8",
  cond="2020 dip = crash incidents (Part 4); 2024–2026 decline = paywall regressions + family plan + crashes (§1.6)")

c(5, "Part 0 §3 line 54", "anti-pattern",
  "Review-gating (route to the App Store only if the rating is high; swallow low ratings in-app) and deleting a critical review were both caught by users",
  "gates the review prompt; deleted at least one critical review", "complaint",
  "9 explicit gating/fake-review complaints; one UK user documented the routing; a Polish user called it an Apple ToS violation; one CN user documented a deleted critical review (Aug 2025)",
  "dont", "weak signal (n=9) but reputational", "yes",
  ["8836869044","6197402388","12993356431","12117289603","8707927339","8423423589","8258057981","7611186789","4640019537","11067543951","13173072726"])

# ---- 1.1 ----
c(6, "§1.1 line 65-66", "monetization",
  "Headline product is a one-time 'Lifetime' purchase, with yearly and monthly subscriptions alongside it and a Family Lifetime plan from ~mid-2024; the free tier is a hard cap on habits plus most analytics locked",
  "lifetime + yearly + monthly + family lifetime; free = capped habits, analytics locked", "mixed",
  "model description; purchase-driver evidence in §1.3 (22.4% of paid cohort cite 'not a subscription')",
  "product-rule", "high-priority", "yes", [],
  cond="the lifetime SKU is the one buyers name; subscriptions exist but are not what people praise")

c(7, "§1.1 line 68-83 price table", "monetization",
  "Lifetime price climbed steadily from $4.99 (2019) to ~$10 (2026) in the US, with regional pricing in 12 markets and a time-limited discount promo in China",
  "US lifetime $4.99 → $5.99 → $6 → $6.99 → $7 → $8 → $8.99 → $9.74 → ~$10; yearly $3.49–$8; family ~$12.99. CN ¥30 → ¥40 → ¥48, yearly ¥22, ¥18 as a 24-hour / 40%-off promo. UK £3.99–£5 → £8; EU €3.49–€10; AU A$8–10; CA C$8–12; BR R$27–50 (yearly R$12.90–19.90); MX MX$149–200; IN ₹999–1299; TR ₺200 (yearly ₺20–21); VN 91k–299k₫; ID Rp89k–150k; SG S$12.98 (family S$19.98)",
  "mixed", "prices as reviewers reported paying them; no counts", "research", "reported prices", "yes",
  ["7703914833","8271993504","10886897549","9470654295"],
  side="'cheaper than a coffee' framing in §1.3 is anchored on these price points",
  cond="prices doubled over 7 years while the rating fell — the report does not claim causation")

c(8, "§1.1 line 85", "anti-pattern",
  "The free habit cap was changed repeatedly — 3, unlimited, 5, 6, 4, even 2, back to 6 — as live A/B testing, and it visibly angers people",
  "A/B tests the free cap; 3 (2019 and China throughout) → unlimited (2020–mid 2021) → 5 (2023) → 6 → 4 → 2 → 6 (2026)", "complaint",
  "report calls it 'live A/B testing' that 'visibly angers people'; cap complaints carry ×7.5 lift on 2★ (Part 8 #9)",
  "dont", "high-priority", "yes", ["8599736021","13711763153","13742648539"],
  cond="different users see different caps at the same time and compare notes in reviews")

# ---- 1.2 free/paid table ----
c(9, "§1.2 row 1", "feature", "Habit creation is free only up to a cap, and the cap is the #1 monetization complaint",
  "free up to cap (3–6, drifting)", "complaint", "'#1 monetization complaint'; cap-related 2★ lift ×7.5 (Part 8)", "build-free", "high-priority", "yes", [],
  cond="Part 8 #9 recommends a generous cap (6+) held constant; see R01-016 for 'unlimited' as a paid driver")
c(10, "§1.2 row 2", "feature", "Daily check-in and one basic reminder per habit are free and draw no complaints",
  "free", "praise", "reaction: 'fine' (no complaint signal)", "build-free", "stated without count", "yes", [])
c(11, "§1.2 row 3", "feature", "Icons, colours and a basic widget are free — loved, and they drive 5★ reviews",
  "free (icons, colours, basic widget)", "5★-burst", "reaction: 'loved, drives 5★'; customisation 7.5% of buyers (lift ×2.7), widget 7.1% (lift ×3.1) in §1.3",
  "build-free", "high-priority", "yes", [],
  cond="some widgets are free here whereas other apps lock all widgets behind paywall — the free basic widget is what earns the 5★")
c(12, "§1.2 row 4", "feature", "Backfilling missed days is free up to 7 days back and paid beyond that; users accept the split",
  "free ≤7 days, paid beyond", "praise", "reaction: 'fine'", "build-free", "stated without count", "yes", ["11578392138","12625167724"],
  cond="a 7-day free window is the tolerated boundary")
c(13, "§1.2 row 5", "feature", "Weekly / monthly / yearly reports are paid and are the #1 stated reason people pay",
  "paid", "purchase-driver", "'#1 stated reason people pay'; §1.3: 4.5% of buyers by keyword, dominant in qualitative read; 'reports were the reason I paid' (11309506354)",
  "build-paid", "high-priority", "yes", ["11309506354","9185761050","11061030490"],
  cond="were free in 2020–mid 2021 and moved behind paywall Jan 2022 (regression #1, §1.6); yearly stats locked days before year-end Dec 2024 (regression #4)")
c(14, "§1.2 row 6", "feature", "Unlimited habits is paid and is the #2 reason people pay",
  "paid", "purchase-driver", "'#2 reason'", "undecided", "high-priority", "yes", [],
  cond="contradicts the free-cap complaint (R01-009): the cap sells, but it also produces the #1 complaint; Part 8 recommends a generous fixed cap rather than none")
c(15, "§1.2 row 7", "feature", "iCloud sync / multi-device is paid, the #3 reason people pay, and the #1 source of paid-user anger",
  "paid; device/iCloud-local, no account system", "purchase-driver",
  "#3 purchase reason; strongest true differentiator among buyers (9.0% of buyers, lift ×9.8, §1.3); sync failure ×12.8 over-represented among buyers; 34 angry payers (9.6% of angry payers) say sync doesn't work after paying (§1.5)",
  "must-never-break", "high-priority", "yes", ["6736804782","9223945846","6561137344","6142665297","5360258264"],
  cond="if sync is the paid feature it must be flawless (Part 8 #3)")
c(16, "§1.2 row 8", "feature", "Multiple reminders per habit is paid and a moderate purchase reason",
  "paid (first reminder free)", "purchase-driver", "reaction: 'moderate'; reminders 7.8% of buyers, lift ×2.0 (§1.3)", "build-paid", "moderate", "yes", [],
  cond="moved behind paywall Jan 2022 (§1.6)")
c(17, "§1.2 row 9", "feature", "Shared / group habits ('一起养成') is paid, a strong purchase driver, and the worst-executed feature in the app",
  "paid; exists; broken", "purchase-driver",
  "5.0% of buyers, lift ×5.4 — 'high-intent buy reason' (§1.3); 24 angry payers (6.8%) say shared habits are broken (§1.5)",
  "research", "high-priority", "yes", ["11994782701","12624096933","11309506354","9114508292","13627620738"],
  side="demand is proven even though the implementation fails; a working version would inherit the purchase intent")
c(18, "§1.2 row 10", "feature", "Skip / holiday mode is paid and a minor purchase factor",
  "paid", "purchase-driver", "reaction: 'minor' (grouped with passcode and icon themes)", "undecided", "minor", "yes", [],
  cond="moved behind paywall Jan 2022 with reports, multi-reminder and sync (§1.6)")
c(19, "§1.2 row 10", "feature", "Passcode lock is paid and a minor purchase factor",
  "paid", "purchase-driver", "reaction: 'minor'", "research", "minor", "yes", [])
c(20, "§1.2 row 10", "feature", "App-icon themes are paid and a minor purchase factor",
  "paid", "purchase-driver", "reaction: 'minor'", "undecided", "minor", "yes", [])
c(21, "§1.2 row 11", "feature", "Quit-habit (戒除) mode is paid and well received",
  "paid; shipped Sep 2023", "praise", "reaction: 'well received'", "research", "stated without count", "yes", ["13711763153","13811111971","11131185906"],
  cond="see Research Reports/Quit Habit Decision.md")
c(22, "§1.2 row 12", "feature", "Data export is paid; it is requested a lot but rarely triggers a purchase",
  "paid", "complaint", "'requested a lot, rarely a purchase trigger'; export 2.9% of buyers, lift ×3.7 (§1.3)", "build-free", "moderate", "yes", [],
  cond="charging for it generates requests, not revenue")

# ---- 1.3 purchase triggers ----
c(23, "§1.3 line 106", "insight", "Explicit purchase confirmations are 8.5× denser in the US than in the corpus overall",
  "n/a", "purchase-driver", "759 reviews confirm a purchase: 1.34% globally, 4.14% of US ('very strong signal in the US')", "none", "very strong (US)", "yes", [])
c(24, "§1.3 table row 1", "insight", "Simple/clean design is what buyers mention most, but it is table stakes, not a differentiator",
  "simple, clean design", "purchase-driver", "29.2% of buyers, lift ×1.4 — 'table stakes, gets them in the door'", "must-have", "high-priority", "yes", [],
  cond="see R01-095 (Part 8 #20): 32.2% of US reviews mention simple/clean")
c(25, "§1.3 table row 2", "insight", "iCloud sync / multi-device is the strongest true differentiator among buyers",
  "paid", "purchase-driver", "9.0% of buyers, lift ×9.8 — highest lift in the table", "build-paid", "high-priority", "yes", [],
  cond="and the thing that breaks most (R01-015)")
c(26, "§1.3 table row 6", "insight", "Buyers shopped around before paying — competitor comparison is over-represented among buyers",
  "n/a", "purchase-driver", "6.6% of buyers, lift ×3.3", "do", "strong", "yes", [],
  side="positioning against named competitors matters at the point of purchase")
c(27, "§1.3 table row 8", "feature", "Streaks / gamification are a moderate purchase factor",
  "has streaks", "purchase-driver", "5.0% of buyers, lift ×2.4", "undecided", "moderate", "yes", [])
c(28, "§1.3 table row 10", "feature", "Apple Health integration is a small-volume but very-high-intent purchase reason",
  "has Apple Health integration", "purchase-driver", "1.8% of buyers, lift ×5.8", "build-paid", "small, very high intent", "yes", [],
  cond="Part 8 #16: do Watch + Health properly, two-way")
c(29, "§1.3 table row 11", "feature", "Apple Watch is a small-volume but very-high-intent purchase reason",
  "has a Watch app", "purchase-driver", "2.1% of buyers, lift ×4.2", "build-paid", "small, very high intent", "yes", [],
  cond="Part 8 #16 asks for a Watch timer and two-way sync")
c(30, "§1.3 table row 13", "feature", "Interactive widget check-off (mark done without opening the app) is a small but very-high-intent purchase reason",
  "widgets are interactive", "purchase-driver", "1.2% of buyers, lift ×5.2", "undecided", "small, very high intent", "yes", [],
  cond="Part 8 #12 lists it as a product priority")
c(31, "§1.3 'three stated reasons' #1", "insight", "People pay BECAUSE it is a one-time purchase and not a subscription — this is the top stated reason, not the price",
  "one-time lifetime SKU", "purchase-driver",
  "430 reviews globally (0.76%), 134 in the US (2.47%), 22.4% of the entire paid cohort; 'the strongest pricing signal in the dataset' (Part 8 #6)",
  "product-rule", "high-priority", "yes",
  ["13050724508","11365943784","13441875727","9660134870","8880295585","8504863858","8201740274","7514260455","7096262291","5234071883","12158584332","11138747548"],
  cond="distinct from 'price is low' (R01-032): subscription fatigue is the reason, fairness is second")
c(32, "§1.3 'three stated reasons' #2", "insight", "The price being low / fair is the #2 stated reason to pay, and those reviews are near-perfect",
  "lifetime priced 'cheaper than a coffee'", "purchase-driver",
  "608 globally (1.07%), 176 US (3.24%), 11.7% of paid cohort, mean rating 4.79; framing: 'cheaper than a coffee', '$30/yr apps vs this'",
  "product-rule", "very strong (US)", "yes",
  ["11373452581","11711652533","9747144434","8686832314","14133562629","12448613807","10481350467","9904151511"],
  cond="anchored against subscription competitors (Part 8 #7)")
c(33, "§1.3 'three stated reasons' #3", "insight", "The reports board is the #3 stated reason to pay and is under-counted by keyword matching",
  "paid reports", "purchase-driver", "keyword count 4.5% of buyers but 'dominant in the qualitative read'; 'I paid for the weekly/monthly/yearly report' appears constantly",
  "build-paid", "high-priority", "yes", ["9185761050","11061030490","9809815444","8571612933","7932327023","6122442517","5543456646","12120837089","9248742785","14107403167","11309506354"])
c(34, "§1.3 bonus driver", "insight", "'Support the devs' is a small, pure-margin purchase motive with very high ratings",
  "n/a", "purchase-driver", "51 reviews (0.09% global, 0.40% US), mean 4.69", "do", "weak signal", "yes",
  ["10317808778","11670063988","8183543609","13769603363","13078191322","9610116256","3712021994"],
  side="goodwill toward an indie developer converts to purchases")
c(35, "§1.3 scholarship block", "tactic",
  "The scholarship / 'request a discount' program is the cleanest 5★ generator in the entire dataset — and it appears to have been switched off in 2025",
  "ran ~2022–2024: users who could not afford it were given Premium free or discounted; share of non-CN reviews 0.96% (2023) → 1.20% (2024) → 0.06% (2025) → 0.24% (2026)", "5★-burst",
  "101 reviews (0.18% global, 0.72% US — emerging), mean 4.83; 91 of them 5★ at a perfect 5.00 mean", "do", "emerging (US)", "yes",
  ["11448581403","10241954935","10994557868","10542758525","8470641817","10783884891","11141716858","11085172531","10530819803","12869585099","11138164446","10857255564","10825043878","10755398022","10562374061"],
  side="also solves the payment-rails problem in Russia, Argentina, Turkey, Algeria, Pakistan where cards fail; killing it removed the highest-rated review source the app had",
  cond="Part 8 #8: run it and never stop it")
c(36, "§1.3 scholarship block", "market",
  "Payment rails fail in Russia, Argentina, Turkey, Algeria and Pakistan — users there cannot pay by card even when they want to",
  "no alternative payment path except the scholarship program", "blocked-conversion",
  "named markets: RU, AR, TR, DZ, PK; no count given", "do", "stated without count", "yes", [],
  side="a hardship/discount program doubles as the workaround")
c(37, "§1.3 blocked conversion", "insight",
  "74 happy users say they WOULD pay but are held back by one missing thing — most often that the app is not in their language",
  "not localised into ES, PT, JA etc.", "blocked-conversion",
  "74 reviews (0.13%), mean 4.74 — 'happy users held back by one missing thing'", "do", "weak signal, high rating", "yes",
  ["10659457233","8900768368","8695040986","8372953300","8261669660","8100585477","8007363760","7845331523","7671263640","7592934351","7301224156","7184849491","5324970906","5220698156","5141351490","4653085671","9213458913","12563756399","9490334380"],
  cond="'If it were in Spanish I would buy it' (ES), 'would only be worth buying Premium if it were in Portuguese' (PT), 'I'd consider paying if it supported Japanese' (JP)")

# ---- 1.4 paid cohort ----
c(38, "§1.4 line 143-147", "insight", "Paying customers rate the app a full point lower than everyone else, and more than one in five paying customers leaves a 1★",
  "n/a", "churn", "1,261 paid-signal reviews (2.23%); paid-cohort mean 3.66 vs corpus 4.67; 5★ 52.1%, 4★ 12.4%, 3★ 7.4%, 2★ 5.6%, 1★ 22.5% (284)",
  "must-never-break", "high-priority", "yes", [],
  side="the features people pay for are the ones that break (R01-046)")
c(39, "§1.4 country table", "market",
  "Purchase-signal density by country: NZ, ZA, UAE, CZ, PT, PL, PH, CA, MY, US, DE, IN, AU, UA, UK, RU all 5.8–9.6% of that country's reviews; China 0.86%; Brazil 1.6%, Mexico 2.7%, Spain 2.2%, France 2.3%",
  "n/a", "purchase-driver",
  "US 395 paid-signal (7.3%); CA 65 (7.4%); UK 59 (5.8%); DE 36 (6.9%); IN 46 (6.9%); AU 31 (6.7%); CN 352 (0.86%); BR 12 (1.6%); MX 10 (2.7%); ES 6 (2.2%); FR 7 (2.3%)",
  "do", "high-priority", "yes", [],
  side="Brazil, Mexico, Spain, France have heavy volume but weak purchase signal and all four are dominated by localisation complaints (Part 6)",
  cond="US supplies 9.6% of reviews but 8.5× the purchase-signal density of China")

# ---- 1.5 churn in paid cohort ----
c(40, "§1.5 line 180", "insight", "28.2% of everyone who paid left a 1–2★ review",
  "n/a", "churn", "355 reviews from paying users rating 1–2★ = 28.2% of paid cohort", "must-never-break", "high-priority", "yes", [])
c(41, "§1.5 table row 1", "must-never-break", "Billing errors — wrong amount, double charge, surprise renewal — are the #1 cause of angry paying customers",
  "billing errors occur", "1★-burst", "76 angry payers (21.4% of angry payers); billing errors ×21 over-represented in 1★ reviews (Part 8 #1)",
  "must-never-break", "high-priority", "yes",
  ["13073833210","12205808839","10835369648","13661881043","12149887715","8755673958","7693838370","6851547705","6463794681","5917864038","5489264041","4800753374","14030009468","13285661066","11777084667","9144813573"],
  cond="Part 8 #1: single price shown, no trial-to-charge traps, refunds honoured, receipts clear")
c(42, "§1.5 table row 2", "must-never-break", "Crashes are the #2 cause of angry paying customers, and 13.4% of all buyers mention one",
  "recurring crash incidents (Part 4)", "1★-burst", "62 angry payers (17.5%); crashes ×7.1 over-represented among buyers; 13.4% of all buyers mention a crash",
  "must-never-break", "high-priority", "yes", ["12122611216","11791686984","9294699968","6660918412","5534625595","11210732518","12268266592","11442496849","8823075411"])
c(43, "§1.5 table row 3", "monetization", "The Family plan exists — and it is broken because it is Apple Family Sharing with no in-app affordance, so buyers cannot find how to use it",
  "Family Lifetime plan launched ~mid-2024 via Apple Family Sharing, nothing in-app", "1★-burst",
  "40 angry payers (11.3%) in §1.5; 52 low-rated in §1.6 at mean 1.65; 0% of complaints before 2024 → 1.94% of all non-CN reviews in 2025",
  "research", "high-priority", "yes",
  ["12159515360","13594757077","12444775035","14383144623","11575579529","13245020706","12221978847","14092312477","12516217190","12165765645","11908724929"],
  side="there is demand for a family plan (people bought it); the failure is discoverability, not the plan itself",
  cond="Part 8 #10: if you ship a family plan, make it discoverable in-app")
c(44, "§1.5 table row 5", "must-never-break", "Restore-purchase failing is a top-5 cause of angry paying customers",
  "restore purchase breaks (no account; iCloud-local)", "1★-burst", "27 angry payers (7.6%)", "must-never-break", "high-priority", "yes",
  ["11941969340","9283876341","8535955220","7699737797","6751638144","6424767276","5640209527","5250831446","12858504950","12166995821"],
  cond="root cause is the missing account system (R01-047)")
c(45, "§1.5 table row 7", "must-never-break", "Data loss hits paying users and is ×10.6 over-represented among buyers",
  "data is device/iCloud-local; lost on phone change or update", "1★-burst", "22 angry payers (6.2%); data loss ×10.6 lift among buyers",
  "must-never-break", "high-priority", "yes", ["10194996668","9185761050","6883915010","5973855372","13859944372","9114508292","14457171713","12498095858","11937944304"])
c(46, "§1.5 table row 8 + lift list", "must-have", "There is no support channel at all — and that is the single most over-represented complaint among buyers (×34.7)",
  "no support channel", "1★-burst", "11 angry payers (3.1%) but ×34.7 lift among buyers vs corpus-wide", "must-have", "high-priority", "yes",
  ["12940542679","12008055880","11941969340","11309506354","9283876341","12394406411","11804171737","11374078493"])
c(47, "§1.5 'most damaging pattern' + lift list", "insight", "The features people pay for (sync, sharing, multi-device) are exactly the features that break",
  "n/a", "churn", "lift among confirmed buyers: no support channel ×34.7, account/login missing ×15.8, sync failure ×12.8, data loss ×10.6, streak/stat miscount ×10.2, crashes ×7.1",
  "must-never-break", "high-priority", "yes", [])
c(48, "§1.5 root cause", "must-have", "No account system is the root cause of lost purchases, lost data and failed sync — a new phone means a lost purchase and lost data",
  "no account system; everything device/iCloud-local", "complaint", "109 reviews ask for an account; ×12.0 over-represented in the paid cohort; ×15.8 lift (account/login missing) among buyers",
  "must-have", "high-priority", "yes", ["11264641334","12107547777","9660134870","8997324792","8514386778","7773632660","6852994319","6725198105","4038017855","11323614404"],
  cond="Part 8 #2: ship an account system from day one")
c(49, "§1.5 lift list", "must-never-break", "Streak / statistics miscounts are ×10.2 over-represented among buyers",
  "streak and stat miscount bugs", "complaint", "×10.2 lift among buyers; no raw count in this section", "must-never-break", "high-priority", "yes", [],
  cond="Part 4 'persistent multi-year unfixed bugs' has the detail")

with open("Tools/prd_ledger/1/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
