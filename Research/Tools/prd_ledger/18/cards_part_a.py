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

# ---- header / method ----
c(1, "header lines 1-10; §1.6 External sources; §10.6", "positioning",
  "MyRoutine / 마이루틴 (App Store ID 1518956326) — 'Organize your day · Built around your real life' — a Korean routine/habit tracker with to-dos, diary, timer and a light social layer; the decision it informs is how to price and package a habit app people genuinely love when five years of monetisation changes have converted its most loyal users into its angriest reviewers",
  "developer Minding. co., Ltd.; bundle com.minding.myroutine; category Productivity; KR listing 4.8★ from ~25,000 ratings, US 4.8★ from ~3.3K, version 34.28 (accessed 10 Sep 2026); KR store title now includes 'ADHD 하루 계획표 앱'; store rank 18", "mixed",
  "2,048 written reviews, 29 storefronts, 6 Jul 2020 → 6 Sep 2026 (75 calendar months); written mean 3.824", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Four things to know; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Limitations and judgement calls; §10.1 counting rules; §10.3 method audit trail", "data-caveat",
  "Method: overwhelmingly a Korean corpus — 1,599 of 2,048 (78.08%) KR, JP 223 (10.89%), US 84 (4.10%); only these three clear the 50-review bar, so every 'global' figure is Korea-weighted; storefront ≠ language (13 of 84 US reviews in Korean; 16 languages read, none discarded); public rating ~1 star above written (KR 4.8★ vs written 3.824, gap 0.98; KR-only written 3.949 gap 0.85) — the report describes the population motivated enough to type, not the average user; counts come from a keyword classifier manually audited — floors, not measurements; signal bands: <0.1 ignore, 0.1–<0.5 weak, 0.5–<1 emerging, 1–<3 meaningful, 3–5 very strong, >5 high-priority",
  "n/a", "none", "2,048/2,048 read; denominator 2,048 non-exclusive themes; 29 storefronts; 75 months", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "§0.1 The product is loved. The business model is what people write about; family table (verbatim)", "insight",
  "Two theme families dominate and point in opposite directions: praise for design/cuteness/intuitiveness (164, 8.01%, 4.46★) and habit-formed/life-changed (131, 6.40%, 4.54★) versus free-tier restriction blocking core use (139, 6.79%, 2.32★), trial/auto-billing/refund disputes (144, 7.03%, 2.90★), data loss (123, 6.01%, 3.27★) and crash/won't launch (111, 5.42%, 3.15★) — all six high-priority; a genuinely differentiated product with a monetisation and reliability problem of equal size, and reviews praising the product and condemning the paywall are frequently the same reviews",
  "loved product, disliked business model", "mixed", table("## 0.1 The product is loved"), "product-rule", "high-priority (>5%)", "yes", [])
c(4, "§0.2 The single most consequential mechanic in the corpus: the free tier blocks the check-off button", "product-rule",
  "The paywall does not gate advanced features — it gates marking a habit done, the one action the product exists to perform; tapping 'achieve/complete' produces a purchase sheet instead of a check mark; 'the free version can't even check things off… then it isn't a routine app at all' (rated 5★ deliberately so more people see it); 'You can write habits down. You just can't complete them. You write them and get alarms'; final KR review in corpus: habits 1–6 check fine, the 7th throws a purchase sheet — 'I was 90% ready to buy… I just lost all feeling for it and deleted it'; called 'Predatory dark pattern' (AU) and 'an unscrupulous method' (JP)",
  "free tier blocks the check-off / completion action", "1★-burst", "139 reviews (6.79%, high-priority, mean 2.32★)", "product-rule", "high-priority", "yes",
  ["13977781381","13666442337","14517754076","12576858445","13534993454","14484116611","12495446710","13894901307","14393820099","14261275910","14468573022","13868908368","13894400612","14065497753","14047366673","14068889624","12036038200"])
c(5, "§0.2 One Hong Kong reviewer supplies the mechanic nobody else spells out", "insight",
  "The binding free limit is completions, not habits: the free tier advertises 10 habits, but ticking a habit consumes the short-memo quota capped at 14 per week — two check-offs a day; if accurate this single quota explains five years of users reporting the app 'stops working on day 3 / day 5 / day 6 / day 10' — the advertised limit is the number of habits, the binding limit is the number of completions; a habit tracker whose free tier meters completions teaches new users in their first week that the product does not work, precisely when a habit-formation product must prove it does — the highest-leverage finding in the corpus",
  "check-offs metered via a 14/week short-memo quota on the free tier", "blocked-conversion", "n=1 explicit (hk, 1★, Aug 2026) explaining the 139-review theme", "product-rule", "high-priority (mechanism from close reading)", "yes",
  ["14393820099"], "the app 'stops working on day 3/5/6/10' pattern across five years", "if the HK account is accurate")
c(6, "§0.3 The price ladder itself is generating fraud accusations; plan/price table (verbatim)", "monetization",
  "An unusually wide ladder of concurrently-live price points — five simultaneous annual prices in the US ($17.99–$39.99) and four in Korea (₩25,000–₩33,000), monthly ₩3,500/₩3,900 or $4.99/$5.99, lifetime ₩69,000/₩89,000 or $79.99; a distinct repeating pattern inside billing disputes is 'I paid, and then the app immediately offered me a cheaper price' — paid ₩33,000 then shown ₩25,000 after the tutorial; charged both ₩33,000 and ₩25,000; '40% off' advertised at ₩28,000 charged ₩33,000, re-subscribed and charged again — ₩61,000 total; chose ₩33,000 charged ₩45,000; Taiwan reproduces it exactly ('the promo price and the actual card charge differed by 2×'); JP ¥2,900 checkout → ¥4,150 charged; users do not read this as a pricing experiment, they read it as fraud (詐欺 / 詐騙 / scam / fraudulent / Abzocke / 사기 / 피싱앱 수준)",
  "multiple concurrent price points per plan; discount banners not honoured at checkout", "1★-burst", "144 trial/billing/refund disputes (7.03%, high-priority, mean 2.90★); " + table("## 0.3 The price ladder"), "must-never-break", "high-priority", "yes",
  ["14143250366","14146289685","13829350794","11881028381","13420003023","13734105920","12417115787","13773500213","14160907779","14215712231","14291964350","12109687708","13994502099","14344435230","14286926161","14488115233"],
  "Taiwan is the lowest-rated storefront in the corpus at 2.60 mean and billing is essentially the whole story there")
c(7, "§0.4 (a) Charged before they could evaluate", "must-never-break",
  "The trial converts, or appears to convert, immediately — 'isn't this deception?'; asked for monthly, charged annual; 'in my case there was no free period' (jp); app frozen since minute 10, still charged a full year (id); reproduced in KR, JP, TW, ID, BR, DE",
  "trial charges before evaluation is possible", "1★-burst", "11 named IDs across 6 storefronts inside the 144-review billing theme", "must-never-break", "high-priority (within billing theme)", "yes",
  ["10402774146","10504712330","10656594581","10665782696","10808234292","13735625152","13997904350","14196174434","12806633553","11785990316","13751955979"])
c(8, "§0.4 (b) Paid and then locked out", "must-never-break",
  "Entitlement failures — the purchase succeeded and the app still demands payment: ₩33,000 annual still capped at 8 routines; lifetime buyers denied Pro; ¥8,890 lifetime paid via PayPay never applied; subscription active in iOS settings, premium unusable; a TW lifetime holder accidentally bought an annual, cancelled it, and the lifetime entitlement was deleted too",
  "entitlement not applied after successful purchase; cancelling one plan deletes another", "churn", "25 reviews (1.22%, meaningful, mean 2.44★); 9.94% of confirmed payers (16 of 161)", "must-never-break", "meaningful", "yes",
  ["14201976473","14183433420","14171622208","14442984779","14486310873","14133850956","11032526889","10682135962","9962008254","11902546307","12068983875","11854385750","12777592140","14247429732","14031409160"])
c(9, "§0.4 The worst single case in the corpus", "must-never-break",
  "A lifetime buyer (¥6,890) lost power mid-session; on restart the app reset to onboarding, deleted every routine and all five routine modes, then demanded a Pro subscription; support e-mailed with purchase screenshots did not reply for over a week, including to a follow-up asking merely whether the case was open — 'Please don't turn the app I loved into the app I hate'; the clearest statement of how the product loses its best customers",
  "state reset + entitlement loss + silent support", "churn", "n=1 posted twice (jp, 1★, Jun–Jul 2026)", "must-never-break", "single case, exceptional", "yes",
  ["14238803827","14248568509"])
c(10, "§0.5 Five years of removing things people already had; removal table (verbatim)", "timeline",
  "Capabilities users already possessed were withdrawn, usually to create Pro value, and every withdrawal produced a rating trough: ~Sep 2021 iPad landscape withdrawn; 2022 15-routine cap begins blocking check-off not just creation; Apr 2022 free use effectively time-limited; 24–26 Oct 2022 interstitial ad on every check-off (17+ reviews in following weeks); late 2022/early 2023 web/desktop discontinued; May 2023 highlighter free→Pro; Nov 2023 to-do list free→Pro; Dec 2023–Jan 2024 free routines 15→8, short memo →5/week, highlighter →1 colour, friend-invite bonus routines revoked; Jul 2024→2025 condition-check, weight/number trackers, statistics moved behind Pro (and partly back); Sept 2024 routine/to-do split, weekly view removed, Challenge removed",
  "serial feature withdrawal to create Pro value", "1★-burst", table("## 0.5 Five years of removing"), "product-rule", "close reading, illustrative IDs", "yes",
  ["7762347992","8199492162","8601996746","9223090299","9513306665","9892001293","10598930656","10754519109","11536013545"])
c(11, "§0.5 iPad landscape mode withdrawn (~Sep 2021)", "feature",
  "iPad landscape mode was withdrawn around Sep 2021 — '가로모드 중단이요..?'; one reviewer: 'landscape only, and I'd buy'",
  "removed iPad landscape", "blocked-conversion", "5 IDs", "must-have", "close reading", "yes",
  ["7762347992","7891611908","7960129120","8049542760","8107694384"])
c(12, "§0.5 Interstitial ad on every check-off (24–26 Oct 2022)", "anti-pattern",
  "An interstitial ad on every check-off shipped 24–26 Oct 2022 and produced 17+ protest reviews in the following weeks",
  "interstitial ad on the core action", "1★-burst", "17+ reviews in following weeks", "dont", "close reading (dated burst)", "yes",
  ["9223090299","9223234624","9223910581","9228413942","9230911524","9230913085","9239767151","9242285983","9245789487","9247722324","9256280526","9257333050","9259537674","9260428008","9349646831"])
c(13, "§0.5 Web / desktop version discontinued (late 2022 / early 2023)", "feature",
  "The web/desktop version was discontinued in late 2022/early 2023 — one user had subscribed for a year because of desktop",
  "removed web/desktop", "churn", "4 IDs", "paid", "close reading", "yes",
  ["9513306665","9878312095","9791158691","10179190547"])
c(14, "§0.5 Highlighter moved free → Pro (May 2023)", "feature",
  "The highlighter was moved from free to Pro in May 2023 — 'you take away what already existed?'; later cut to 1 colour on free",
  "free feature moved behind paywall", "complaint", "n=1 named + Dec 2023 batch", "product-rule", "close reading", "yes", ["9892001293"])
c(15, "§0.5 To-do list moved free → Pro (Nov 2023)", "feature",
  "The to-do list was moved from free to Pro in Nov 2023, hitting among others a teacher using it with a class; 9 named IDs incl. JP",
  "free feature moved behind paywall", "1★-burst", "9 named IDs", "product-rule", "close reading", "yes",
  ["10598930656","10602078683","10626638051","10645526932","10656234239","10656594581","10666557187","10775337514","10787375859"])
c(16, "§0.5 Dec 2023 – Jan 2024 free-tier cuts and friend-invite bonus revoked", "monetization",
  "Dec 2023–Jan 2024: free routines cut 15→8, short memo →5/week, highlighter →1 colour, and friend-invite bonus routines revoked; JP called it '改悪' (a change for the worse); a user who recruited friends to earn 23 free routines had the earned quota revoked — 'my friends and family all deleted the app, but I'm still here'",
  "cut free caps and revoked earned referral rewards", "1★-burst", "9 named IDs + 1", "product-rule", "close reading", "yes",
  ["10754519109","10772477035","10773481361","10773703235","10729003648","10570170204","10883150036","10914801439","10788981444","10857167531"])
c(17, "§0.5 Trackers and statistics moved behind Pro and partly back (Jul 2024 → 2025)", "feature",
  "Condition-check, weight/number trackers and statistics moved behind Pro and partly back; one reviewer notes the flip-flop fragmented their data",
  "paywall flip-flop on trackers/statistics", "complaint", "5 IDs", "dont", "close reading", "yes",
  ["11536013545","12350930181","12497207499","12706210535","11815241341"])
c(18, "§0.5 The argument users make is remarkably uniform: monetise new capability, don't confiscate old capability", "product-rule",
  "Across five years, three languages and dozens of reviewers the argument is uniform — monetise new capability, don't confiscate old capability: 'take back what you gave and people resent it'; 'blocking features existing members were using well and charging for them, or forcing people to Pro by shrinking features, is wrong… it may work short-term but long-term I doubt it'",
  "confiscation-led monetisation", "complaint", "8 named IDs stating the principle", "product-rule", "close reading", "yes",
  ["10656234239","10729003648","10737428561","10773481361","10904269033","10987139394","11646296464","13496310680"])
c(19, "§0.6 September 2024: the app removed the exact thing that made people pay for it", "timeline",
  "32 reviews between 6 Sep 2024 and 29 Jan 2025 protest one redesign, mean 4.25★ — the loyal paying base, not churned free users; before: routines and one-off to-dos interleaved in a single reorderable time-ordered list; after: two separate tabs; interleaving expressed when a to-do had to happen and expressed priority for free — separated it's 'barely different from writing tasks in the Notes app'; one subscribed for a year because of the merged view and it was removed days later; one paid and the split shipped the next day; a 22-day-streak 1-year subscriber has stopped opening the app; ADHD US user: 'The best features are gone now and I'm going back to using the notes app'; still requested 19 months later by paying users; nobody asked for the split — one clear defender plus a handful who came to prefer it",
  "split the interleaved routine+to-do list into two tabs", "churn", "32 reviews (1.56%, meaningful, mean 4.25★) 6 Sep 2024–29 Jan 2025; still asked Apr–May 2026", "product-rule", "meaningful", "yes",
  ["11700463203","11727453236","11714930552","11729996278","11702770360","11703079091","11701377230","13922137845","14128340502","11703838844","12118393284"])
c(20, "§0.6 Routine + to-do in one time-ordered list (the feature itself)", "feature",
  "Routines and one-off to-dos interleaved in a single reorderable time-ordered list was the purchase reason for several annual subscribers and MyRoutine's one advantage over dedicated to-do apps; removing it forfeited that advantage without matching to-do apps on their own ground",
  "had it, removed Sep 2024", "purchase-driver", "32 protest reviews mean 4.25★; ≥2 subscribed because of it", "must-have", "meaningful", "yes",
  ["11700463203","11727453236","11752441594","11714930552"])
c(21, "§0.6 Weekly view removed (collateral, Sep 2024)", "feature",
  "Weekly view — used to verify '3× per week' habits and to compare trend on numeric habits — was removed in the same Sep 2024 release; 8 named IDs incl. Singapore",
  "removed weekly view", "complaint", "8 IDs", "must-have", "close reading", "yes",
  ["11696910432","11700553046","11710196595","11712906881","11756484782","11834968287","11932729042","11707812003"])
c(22, "§0.6 Challenge feature removed (collateral, Sep 2024)", "feature",
  "Challenge (fixed-duration goals) was removed in the Sep 2024 release; one user had bought a year because of Challenge; 6 IDs incl. VN",
  "removed fixed-duration challenges", "churn", "6 IDs", "undecided", "close reading", "yes",
  ["11689998104","11699658192","11752441594","11846983639","12185895649","11781517701"])
c(23, "§0.7 The onboarding is a conversion leak with an identifiable shape", "anti-pattern",
  "Onboarding is the lowest-rated theme in the report — 34 reviews, mean 2.03★ — and these reviewers never reached the product: (1) the survey is long and feels like a funnel — 'makes you fill out a survey then wants you to pay BEFORE YOU EVEN SEE THE APP'; 'I might've paid for this, if I could have seen literally anything past the questionnaire'; a Pro subscriber was forced through the questionnaire again; (2) it plans for you — 'you don't lead the plan, they do', titled 'an app that wants to turn you into a very ordinary machine'; 'They won't let me write my own routine'; (3) it excludes anyone without a 9-to-5 weekday life — shift worker: 'MY routine not your routine'; 3-shift, parent, night worker; (4) a pledge you must sign — 'I will become a better version of myself'; (5) no skip button, and it re-runs on existing accounts — restore-purchase loop returns you to onboarding; 'Don't treat me like an idiot'",
  "long mandatory survey → suggested plan → pledge signature → paywall, no skip, re-runs on existing accounts", "blocked-conversion", "34 reviews (1.66%, meaningful, mean 2.03★ — lowest of any theme)", "dont", "meaningful", "yes",
  ["14031934887","13848157788","13218586893","13729043534","11481732875","14407318888","14437815273","12445646540","13390879707","12762108716","12098514129","13515738048","12495446710","10785117382","12245337065","12132150109","12784378291","14082437879","14232098480","12802740109","13953352894","12265439660"])
c(24, "§0.7 (3) It excludes anyone without a 9-to-5 weekday life", "audience",
  "Shift workers, 3-shift workers, parents and night workers are excluded by onboarding questions that assume a 9-to-5 weekday life — 'I do shift work and that's not an option. I wanted to create my own routine not have you suggest one for me. Hence the name of your app. MY routine not your routine' — the sharpest positioning critique in the corpus",
  "onboarding assumes 9-to-5", "blocked-conversion", "4 IDs (au, kr ×2, ph)", "must-have", "close reading", "yes",
  ["12445646540","12245337065","12132150109","12784378291"])
c(25, "§0.7 (4) A pledge you must sign", "dont",
  "A forced pledge signature — 'I will become a better version of myself' — before proceeding reads as 'spiritual or self-improvement-cult vibe' and repelled a JP reviewer; a CA reviewer hit a signature step it wouldn't let them complete",
  "mandatory pledge signature in onboarding", "blocked-conversion", "2 IDs", "dont", "close reading", "yes",
  ["14082437879","13848157788"])
c(26, "§0.8 What people actually love — and it is not the tracker (list)", "insight",
  "The praise clusters the roadmap should protect: (1) the traffic light with a user-set completion threshold, (2) rest/postpone/skip instead of pass-fail, (3) the routine timer, (4) a light social layer explicitly not a social network, (5) ADHD/executive-function fit, (6) routine + to-do in one time-ordered list — the thing removed in Sept 2024",
  "differentiated on motivation mechanics, not the tracker", "praise", "six clusters; see individual cards", "must-have", "very strong / meaningful", "yes", [])
c(27, "§0.8 (1) The traffic light (신호등) with a user-set completion threshold", "feature",
  "A green day at ~60–80% completion, not 100%, with the threshold user-set: 'with apps that show percentage you aim for 100 and suffer; with this you switch to \"green light is good enough\"' (jp, ADHD/ASD); 'if you get too absorbed in routines it becomes compulsive… with a 60% check and the green light, the sense of achievement feels like 100%'; 'I never feel guilted or pressured like some other habit tracking apps' (au)",
  "free; user-set threshold for a daily green/yellow/red light", "praise", "92 reviews (4.49%, very strong, mean 4.24★) on the light/streak/badge system", "must-have", "very strong", "yes",
  ["9744682977","11978551289","12492881974","13268786498","9514694714","6529483781"])
c(28, "§0.8 (2) Rest / postpone / skip instead of pass-fail", "feature",
  "Rest, postpone-a-day and skip options instead of an unconditional yes/no — 'the sense of deprivation when you miss a routine is smaller'",
  "has rest/postpone/skip", "praise", "2 named IDs within the 92-review light theme", "free", "close reading", "yes",
  ["10367219461","6859591028"])
c(29, "§0.8 (3) The routine timer (shipped ~Nov 2024)", "feature",
  "The routine timer (~Nov 2024) is praised and converts: one sets every routine to 1 minute purely to defeat activation energy — 'and then I actually started???'; a US user values the 30-second voice warning",
  "routine timer with voice warning", "purchase-driver", "46 reviews (2.25%, meaningful, mean 4.37★)", "must-have", "meaningful", "yes",
  ["12353891566","11993264527","14045116089","13503736524","12822094053","12815650430"])
c(30, "§0.8 (4) A light social layer that is explicitly not a social network", "feature",
  "A light social layer — see other routiners for motivation 'but it isn't like SNS, which is nice'; a teacher chose it over rivals because the social features are lighter; following a friend described as an 'exchange diary'",
  "light social layer (follow, see others' routines)", "praise", "66 reviews (3.22%, very strong, mean 4.45★)", "undecided", "very strong", "yes",
  ["7835571277","10598930656","10492723138"])
c(31, "§0.8 (5) ADHD / executive-function fit", "audience",
  "Reviewers self-identifying with ADHD, ASD, depression, burnout or 무기력 rate the app highly; ADHD is now in the KR store title itself ('ADHD 하루 계획표 앱')",
  "positions on ADHD in the KR title", "praise", "36 reviews (1.76%, meaningful, mean 4.53★)", "do", "meaningful", "yes",
  ["11067291310","11993264527","12428102869","11888055232","12121119977","13842532454"])
c(32, "§0.9 Too soft — the 'shield' (방패) invalidates the streak", "feature",
  "The shield (~Aug 2025) preserves a streak through a missed day and users experience that as a lie — 'the streak number feels fake so motivation actually drops… I get complacent thinking I can skip today since the number won't disappear'; 'auto-shielded on days I didn't do it, so a green light on a failed day is meaningless… the tail wagging the dog'; an annual payer (jp) notes the green-light cut-off rules changed silently; one asks for an on/off toggle",
  "automatic streak shield, not optional", "complaint", "6 IDs", "product-rule", "close reading", "yes",
  ["13260473006","13104946209","13765930951","13056561637","13769975479","14415129984"])
c(33, "§0.9 Too hard — the streak is a quitting trigger", "insight",
  "An ADHD reviewer states the design principle outright: 'streaks motivate some people, but for others a broken streak is the feature that makes them quit the routine — people diagnosed with ADHD are likely the latter; I'd like to be able to hide this UI'; another wants the light off entirely because 'I can only finish my routine near the end of the day, so I have to sit in red all day and it makes me uncomfortable'",
  "streak and light not hideable", "complaint", "5 IDs", "product-rule", "close reading", "yes",
  ["13842532454","12424534015","12618795582","12719246363","11116355780"])
c(34, "§0.9 And too easy for others", "feature",
  "Others find the light too easy: green achievable while skipping the hard habits; wants a 'must-do' habit that gates the light; wants a 90% threshold; wants a 100% star above the green light; wants mini/normal/focus intensity levels — shipped as 미니/플러스/맥스 in Jun 2026, then reported as repeatedly resetting",
  "single light threshold; intensity levels shipped Jun 2026 but reset", "mixed", "6 IDs", "undecided", "close reading", "yes",
  ["10806031465","10647565568","13819171699","13842882389","13657572874","14184795326"])
c(35, "§0.9 Conclusion: motivation intensity is not a product decision, it is a per-user setting", "product-rule",
  "Motivation intensity must be dial-able in both directions as a per-user setting — the threshold already is configurable; the streak, the shield, the light itself and the cheer messages are not",
  "threshold configurable; streak/shield/light/cheers not", "mixed", "synthesis of §0.9 (17 IDs)", "product-rule", "close reading", "yes",
  ["13842532454","13260473006","12424534015"])
c(36, "§0.10 Reliability is a paid-user problem, not a free-user problem; payer-vs-global table (verbatim)", "must-never-break",
  "Among 161 confirmed payers (7.86%, mean 3.53★) theme rates are materially worse than global on the things that destroy trust in a record-keeping product: entitlement failure 9.94% vs 1.22%; data loss 12.42% vs 6.01%; trial/billing 14.29% vs 7.03%; cross-device/web/Mac sync 6.21% vs 2.69%; order/future-date edit restriction 8.70% vs 6.35% — payers have more data to lose, more devices to sync and a contractual expectation; 'not a single day without a crash… if you take money you have to deliver… how many years must I wait for it to stabilise'; Pro across iPhone/iPad/Mac: check-ins sync instantly, structural edits corrupt state, 'same problem for years, exhausting; if it isn't fixed I'll switch'; all weight-log history vanished — 'if I'd known records could all disappear I wouldn't have paid'; a lifetime buyer left for TodoMate",
  "reliability failures concentrated among payers", "churn", table("## 0.10 Reliability is a paid-user problem"), "must-never-break", "high-priority (payer cohort)", "yes",
  ["10673432472","13972678934","11442003118","13450548328","11427388698","10985703210","10983549558","13023417712","14504465163"])

with open("Tools/prd_ledger/18/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
