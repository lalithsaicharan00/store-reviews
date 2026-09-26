"""Cards for report 23 — Part 6 (reliability) and Part 7 (paid-user analysis)."""
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

# ---- §6.1 sync
c(143, "§6.1 Sync — the single largest reliability finding; complaint volume by year", "must-never-break",
  "Sync is the single largest reliability finding: complaint-framed sync runs at 1.42% of 2015–2017 reviews → ~3% 2018–2021 → 7.60% from Jan 2022 (135 of 1,776, mean 2.90); complaint volume by year 2015 (3) · 2016 (7) · 2017 (11) · 2018 (14) · 2019 (14) · 2020 (14) · 2021 (25) · 2022 (60) · 2023 (40) · 2024 (24) · 2025 (10) · 2026 (1); only 22 (0.30%) frame it as working well",
  "iCloud sync; migrated to direct iCloud sync incl. Watch in Q1 2022", "1★-burst",
  "348 (4.79%) mention; 223 (3.07%, very strong) complaint-framed, mean 3.08, 23.3% 1★; 22 (0.30%) positive; 1.42% → ~3% → 7.60%", "must-never-break", "very strong", "yes", [])
c(144, "§6.1 Failure modes table (verbatim) — overwrite with older state, resurrecting deleted tasks, Watch completion never reaches phone, un-completes seconds later, timers desync", "must-never-break",
  "Sync failure modes in reviewers' words: a device overwrites newer state with its own older state; deleted tasks resurrect and duplicates spawn; Watch completion never reaches the phone or reverts; a completion 'un-completes' seconds later; timers desync between devices",
  "last-writer-wins state replacement", "complaint", table("**What the failure actually looks like, in reviewers' words:**"), "must-never-break", "very strong", "yes",
  ["8285279048","9146983436","9137837352","9049751475","10387927049","11764467723","12530776051","13491181225","8479907454","8651289566","8731274237","8906562435","9208912188","9775440687","10324021127","10395558775","11049048698","12257280896","8798302019","8846625627","9298414949","10629577342","11917241363","12008652692","12630378882","12360238604","10815885619","10848160093","11289290761","13433485005","7353753973","7461351458","10258730446","11753082193"])
c(145, "§6.1 The most technically precise diagnosis — immutable timestamped events applied in order, not last-writer-wins", "insight",
  "A reviewer describes the correct sync architecture: immutable timestamped events applied in order rather than last-writer-wins state replacement; another reaches the same conclusion and recommends abandoning iCloud entirely",
  "last-writer-wins iCloud sync", "complaint", "2 named reviews (us Jan 2024; ca Dec 2025)", "must-never-break", "single reviews, technically precise", "yes", ["10815885619","13491181225"])
c(146, "§6.1 Dated context — a Q1 2022 migration to direct iCloud sync, complaint spike the same quarter, visible recoveries within weeks; a migration with a long damaging tail", "timeline",
  "The developer communicated a migration to direct iCloud sync (including Watch) in Mar 2022; the complaint spike is the same quarter, with visible recoveries within weeks (several edited reviews upgraded after a fix) — a migration with a long, damaging tail, not a permanent break",
  "sync migration Q1 2022", "1★-burst", "2022 sync complaints 60 (peak year); 5 visible recoveries", "must-never-break", "very strong", "yes",
  ["8482253962","8547420011","8533524002","8545693662","8602070916","8603884304"])

# ---- §6.2 data loss
c(147, "§6.2 Data loss — the theme that destroys long-tenure customers; by year", "must-never-break",
  "Data loss destroys customers with 3–8 years of history ('Loved for Years! But… today half of my tasks disappeared'; 'my 3+ years record to null'; 'It's like I'm a brand new user'; one jp reviewer edited three annual updates into the same review reporting the same unfixed bug); by year 2015 (2) · 2016 (1) · 2017 (2) · 2018 (2) · 2019 (1) · 2020 (7) · 2021 (6) · 2022 (17) · 2023 (10) · 2024 (22) · 2025 (8) · 2026 (3)",
  "history lost after sync/update", "churn", "81 (1.11%, meaningful), mean 2.17, 45.7% 1★; since Jan 2022 60 of 1,776 = 3.38%, mean 2.03; 2024 peak 22", "must-never-break", "meaningful", "yes",
  ["11174051475","11194503416","12257280896","9919429252","10325632518","8646756790","13219722364"])
c(148, "§6.2 Mitigation exists and is under-surfaced — Settings > Manage Data > Backups discovered by support, not the user", "must-have",
  "An in-app backup/restore path (Settings > Manage Data > Backups) exists but is repeatedly discovered by support rather than the user; several reviewers upgrade their rating on learning it exists",
  "backup/restore exists, hidden", "mixed", "5 support-discovery reviews; 3 rating upgrades", "must-have", "emerging", "yes",
  ["8527464658","8553855848","10386986461","11764467723","12123846705","8123743895"])

# ---- §6.3 Watch
c(149, "§6.3 Apple Watch — dated failure clusters table (verbatim)", "timeline",
  "Watch failure clusters: 2016 crashes/blank on launch; watchOS 7 (Sept 2020) crashes on Series 3 (fixed — reviewer edited); 2021–22 completion state not filling/mirroring; watchOS 10 (Sept 2023) complications stop working, scrolling lags; 2024–26 blank widget/complication persists",
  "Watch app breaks on each watchOS generation", "complaint", table("**Recurring, dated failure clusters:**") + " ; 626 mentions; 241 negative mean 3.13; 385 positive mean 4.35; explicit-bug 49 mean 2.57, 36.7% 1★", "must-never-break", "very strong", "yes",
  ["1352113408","1449725752","1466396959","6441670191","6446009730","6440060785","6476714883","6542874341","6541375195","7946379003","8233725311","8367240361","8388284847","8632520605","8707802136","8798302019","10404405452","10478388756","10553775551","10661343816","10741780773","10788221893","10933686853","11031307784","11985122698","12765977300","13235319229","14342620356","13857668076","13817900785"])
c(150, "§6.3 The Watch is also the reason people bought — 'I bought this for the Watch and it doesn't work' are the highest-value churn events", "must-never-break",
  "Explicit 'I bought this for the Watch and it doesn't work' reviews are the highest-value churn events in the corpus — the purchase intent and the failure are the same feature",
  "Watch sold as differentiator, fails", "churn", "11 explicit reviews; ≥15 name the Watch as the reason to buy", "must-never-break", "very strong", "yes",
  ["4436945996","4727429074","5132838929","5982716099","6194996941","7629771235","8378091564","8004581061","11991690974","12444581527","13857668076"])
c(151, "§6.3 Support quote — 'inferring they don't have an Apple Watch for testing'", "data-caveat",
  "One reviewer says support implied they don't have an Apple Watch for testing — unverifiable, but if even partly accurate it explains the multi-year persistence of the Watch pattern",
  "possible lack of device testing", "complaint", "1 review (gb, 2★, Nov 2024)", "must-never-break", "single review, unverifiable", "yes", ["12008652692"])

# ---- §6.4 widget
c(152, "§6.4 Widget — interactive Today widget shipped Jan 2017 to enthusiasm, lost ~Sept 2020 (iOS 14), asked back for five years", "timeline",
  "The interactive Today-view widget shipped Jan 2017 to enthusiastic reviews and disappeared around iOS 14 (Sept 2020); the corpus asks for it back continuously for five years — partly an Apple platform change, but a five-year gap during which it is one of the top three reasons for a downgrade from a previously-happy user",
  "interactive widget lost at iOS 14, never restored", "complaint", "318 (4.37%) mention; 134 (42%) negative, mean 3.40; 36 ask-for-it-back reviews cited 2020–2026", "must-never-break", "very strong", "yes",
  ["1530309387","1531472191","1531881769","1536414302","6448871007","6450707909","6455100488","6468889405","6472011768","6479919170","6497553818","6513983000","6540711760","6578603034","6612962225","6631801383","6935238940","6984267893","6997151494","7674489529","7824788952","7840251545","7988574963","8342488137","8765021191","9088972747","9096741812","9100003341","10006367703","10314758774","10755555945","11504358422","11748639117","11809717150","11837678069","12024208955","12445413324","13580820001","13909346620","13817900785"])
c(153, "§6.4 Widgets rendering blank or losing configuration", "must-never-break",
  "Separately from the regression, widgets render blank or lose their configuration", "widget blank/loses config", "complaint", "explicit widget-bug theme 57 (0.78%, emerging), mean 3.16; 20 blank/config reviews cited", "must-never-break", "emerging", "yes",
  ["9387245377","9455902784","9641838960","9649773036","9792360211","10070473577","10100299749","10228970452","10841143428","10893470805","10911821923","11027982834","11192838845","11736228113","11849294138","12159511186","12415259889","13684634678","13156243989","12367233200"])

# ---- §6.5 notifications
c(154, "§6.5 Notifications don't fire — Thailand cluster 4 of 22 (18.2%) [limited evidence]", "must-never-break",
  "Notifications don't fire; Thailand is a visible cluster at 4 of 22 Thai reviews (18.2%), the highest rate of any storefront (limited evidence, n=22)",
  "reminders silently fail", "complaint", "97 (1.33%, meaningful), mean 3.48, 18.6% 1★ (whole theme); Thailand 4/22 = 18.2%", "must-never-break", "meaningful; Thailand limited evidence", "yes",
  ["1509948676","3143064934","4150625737","4868602988","5254725068","5453539364","5918724806","5968862073","6036356305","6486871534","7397407229","11583805884","11836157878","12715249124","13747526653","3630312469","5608136878","5150089330","6825459841","7151647360"])
c(155, "§6.5 Notifications fire wrongly — reminding about completed tasks, all at once at night, ignoring Do Not Disturb, interrupting a meditation to say meditate", "must-never-break",
  "Notifications fire wrongly: reminders for already-completed tasks, all firing at once at night, ignoring Do Not Disturb, and interrupting a meditation to tell you to meditate",
  "smart reminders misfire", "complaint", "within 97 (1.33%)", "must-never-break", "meaningful", "yes",
  ["5902840519","3413523915","6107839995","8934368362","12696000566","12697390401","13060174375","1362498037","1452654162","1563725433","3658903640","13175015249"])
c(156, "§6.5 Reminder tone framed as loss — 'you will lose your streak of X days' — asked in four languages to reframe positively", "product-rule",
  "The reminder is framed as loss ('You will lose your streak of X days if you don't do this today'); reviewers in four languages ask for it to be reframed positively — one long German review calls it 'pedagogy from the early 20th century'; a cheap change with a clear rationale",
  "loss-framed reminder copy", "complaint", "4 reviews in 4 languages", "product-rule", "limited evidence", "yes",
  ["7473616926","10648344883","11042287057","13098714560"])

# ---- §6.6 crash
c(157, "§6.6 Crash / freeze — iPhone X freeze-on-close 2017–18, iOS 14-era freeze, stuck splash screen 2023–26; device heat", "must-never-break",
  "Crashes cluster on three dated bugs — iPhone X freeze-on-close 2017–18, an iOS 14-era freeze, and a stuck-splash-screen bug 2023–26 — plus two device-heat and one CPU/battery report",
  "dated crash bugs", "complaint", "46 (0.63%, emerging), mean 2.80, 34.8% 1★; heat 2, battery 1", "must-never-break", "emerging", "yes",
  ["2101542261","2111079436","2668847666","2378622100","6473643467","6478212597","6515761598","6695773000","10097034521","11103745511","11208612733","12303464340","12376090252","14346355348","7768856624","11902630521","13710105898"])

# ---- §6.7 pause
c(158, "§6.7 Pause resets the streak — paused days marked as missed; reported 2023–2024 with no visible fix", "must-never-break",
  "Pausing a task and un-pausing it marks the paused days as missed and destroys the streak — defeating the feature's entire purpose; reported across 2023–2024 with no visible fix in later reviews",
  "pause/vacation mode breaks the streak it exists to protect", "complaint", "57 (0.78%) mention archive/pause; 5 named defect reviews", "must-never-break", "emerging", "yes",
  ["10656649260","10772984090","10709012497","11138802961","11219449203"])

# ---- §7.1
c(159, "§7.1 Framing — everyone paid; the useful split is transaction-discussing reviewers (735, mean 3.52) vs everyone else (mean 4.27); the gap is dissonance, not a payment problem", "data-caveat",
  "Every reviewer paid or redeemed a promo — no free tier, trial, upgrade path or subscription; the useful segmentation is reviewers who explicitly discuss the transaction versus everyone else, and talking about money in a paid-app review signals dissonance (unusual satisfaction or regret), not a payment problem",
  "paid-only", "mixed", "735 (10.11%), mean 3.52 vs 6,535, mean 4.27 — 0.75-point gap", "none", "method", "yes", [])

# ---- §7.2 purchase triggers
c(160, "§7.2 Purchase triggers table (verbatim)", "monetization",
  "Named purchase triggers in evidence order: no subscription (398); Apple Watch (named as the reason in ≥15); Apple Health (277 mentions); recommendation from a person (28 therapist/coach/doctor/physio, mean 4.50); Atomic Habits / habit literature (14, mean 4.79); media / Apple editorial (17, mean 2.53); Starbucks promo (13, mean 4.62); podcast/blog (12, mean ~4.6)",
  "n/a", "purchase-driver", table("Named purchase triggers, in evidence order:"), "do", "corpus-level fact", "yes",
  ["5227808774","6957986652","7271400285","7632443555","8575876614","9592334909","10725318285","12642801382","13920320198","13681908485","4727429074","5132838929","5982716099","6194996941","7629771235","8378091564","12345694464","13634662993","3226175029","5352820364","6651711303","12539768742"])
c(161, "§7.2 Recommendation from a person — therapist / coach / doctor / physio; a psychologist recommending it to ADHD clients", "audience",
  "A professional recommendation (therapist, coach, doctor, physio) is a named purchase trigger with high satisfaction; one review is a psychologist recommending it to ADHD clients",
  "recommended by clinicians", "purchase-driver", "28 mention therapist/coach/doctor/physio, mean 4.50", "do", "meaningful", "yes",
  ["1458069420","5578733348","7140084696","10055294004","11221418136","11941219130","13400151593"])
c(162, "§7.2 Atomic Habits / habit literature — 14 name Atomic Habits (mean 4.79); Mini Habits, Power of Habit, Deep Work, Power of Full Engagement", "do",
  "Habit literature is an acquisition channel: 14 name Atomic Habits (mean 4.79); others name Mini Habits, The Power of Habit, Deep Work and The Power of Full Engagement",
  "not marketed on the books", "purchase-driver", "14 Atomic Habits, mean 4.79; 4 other books", "do", "limited evidence", "yes",
  ["5482928002","6683980837","8295352711","8551272137","9594186310","9984193559","13036198091","13587842405","1496269982","1797731097","1733290107","1437821189"])
c(163, "§7.2 Apple editorial / Design Award traffic has the lowest mean of any channel (2.53) — 'I trusted the award and was disappointed' [weak, n=17]", "insight",
  "Reviews that name the Apple Design Award or editorial placement have the lowest mean of any acquisition channel — every one is 'I trusted the award and was disappointed'; award-driven traffic arrives calibrated to 'best app', not to a deliberately constrained tracker, and converts into the 'no value' 1★ block (hypothesis, n=17)",
  "won an Apple Design Award; featured editorially", "churn", "17 reviews, mean 2.53 — weak, hypothesis", "do", "weak (n=17)", "yes",
  ["1400446995","1526417758","2186911032","3658903640","4651536264","5132838929","9496499610","9558726188"])
c(164, "§7.2 Podcast / blog channel — Daring Fireball, MacBreak Weekly, Do By Friday, Diary of a CEO", "do",
  "Podcast and blog mentions (Daring Fireball, MacBreak Weekly, Do By Friday, Diary of a CEO) are a small high-satisfaction acquisition channel", "earned media", "purchase-driver", "12, mean ~4.6", "do", "limited evidence", "yes",
  ["1390169236","1390723056","1417753375","1328979417","1783173167","9469351381"])

# ---- §7.3
c(165, "§7.3 What buyers value once they've paid (verbatim table)", "data-caveat",
  "Within the 735 transaction-discussing reviews: simplicity 173 (23.5%), design 137 (18.6%), price objection 115 (15.6% vs 2.10% global broad regex), no subscription 102 (13.9%), capacity 96 (13.1%), Watch 80 (10.9%), refund 54 (7.3% vs 1.09% global)",
  "n/a", "mixed", table("Within the 735 transaction-discussing reviews:"), "none", "corpus-level fact", "app-specific", [])
c(166, "§7.3 'Worth it' vs 'not worth it' — 3.2 : 1 in favour", "monetization",
  "'Worth it / worth every penny' outnumbers 'not worth it' 3.2 : 1 — the cleanest value read in the corpus", "one-time price judged worth it", "purchase-driver",
  "136 (1.87%) worth it, mean 4.72; 42 (0.58%) not worth it, mean 1.69; ratio 3.2:1", "build-paid", "meaningful", "yes",
  ["7177668861","7743170609","7894034801","8643437714","9057932829","9344624735","11510502627","11968241720","12642801382","13647744905","1420547074","1466396959","1712407241","1922531600","2100236937","3339756991","4592779297","7199898184","10383442127","10451316703"])

# ---- §7.4
c(167, "§7.4 Price objection examined — by storefront and era; flat despite ~2.5× price rise", "monetization",
  "Price objection distribution: us 41, au 18, ca 12, de 12, gb 12, cn 10, nz 3, es/ru/se 2; rate by storefront au 5.7% (highest of any 50+ storefront), de 3.8%, ca 3.6%, gb 2.6%, cn 2.5%, us 1.3%; by era E1 1.75% → E2 2.41% → E3 2.21% — flat despite a ~2.5× nominal price rise",
  "raised the one-time price ~2.5×", "complaint", "123 (1.69%, meaningful), mean 2.21, 50.4% 1★; au 5.7%", "build-paid", "meaningful", "yes", [])
c(168, "§7.4 The objection is almost never about the absolute number — it is feature-per-dollar, paired with the cap or 'Reminders does this free'; '12 tasks for ¥610 — are you making fun of users?'", "insight",
  "The price objection is consistently feature-per-dollar, not the absolute number, and is usually paired with the capacity cap or with 'Reminders does this free' — the pricing power is real; what is missing is justification at the point of purchase, because the listing does not pre-empt the two objections that produce almost all price complaints",
  "listing does not pre-empt the cap and the 'checklist' objection", "complaint", "all 123 read", "do", "meaningful", "yes",
  ["1213415787","1273715314","1398416447","1400446995","2074625050","3606167716","5190340051","6598286675","9484848485","12456594252","12687610729"])

# ---- §7.5
c(169, "§7.5 Refunds — accidental purchase: Korea 14 (6.5% of storefront, highest anywhere) and China 5; Touch ID / one-tap purchase with no confirmation", "market",
  "Accidental purchases drive refund requests in Korea (14 refund reviews, 6.5% of that storefront — the highest anywhere) and China (5); several describe Touch ID / one-tap purchase with no confirmation; ~19 accidental-purchase reviews by reading vs 6 by strict regex",
  "paid-up-front with one-tap purchase", "complaint", "Korea 14 (6.5%); China 5; ~19 by reading", "research", "meaningful (Korea)", "yes",
  ["1949276046","2310465385","5759175647","6723289341","6731172815","7538677717","1835478035","1837678339","8207366467"])
c(170, "§7.5 Refunds — expectation mismatch: buyer discovers the cap or the 'checklist' reality", "monetization",
  "The second refund source is expectation mismatch — the buyer discovers the cap or the 'it's a checklist' reality after paying and wants the money back", "paid before use, no trial", "blocked-conversion", "8 representative reviews within 79", "do", "meaningful", "yes",
  ["9540311476","10238906445","11450516665","11474891367","11478493003","12595616102","12277830068","12729571609"])
c(171, "§7.5 Charge-amount confusion — price shown vs amount debited differed (au, ru, tr, mx) [weak, n=7]", "must-never-break",
  "A small cluster says the price shown and the amount debited differed (au, ru, tr, mx) — most likely tax/VAT or currency conversion, not developer behaviour, but a recurring, avoidable trust event",
  "displayed price ≠ charged amount in some storefronts", "complaint", "7 (0.10%, weak)", "must-never-break", "weak (n=7)", "yes",
  ["1821681612","2863100772","3565187204","4550475560","5452308394","12692528270","14197653464"])
c(172, "§7.5 Nothing supports a claim of deceptive billing — one payment through Apple; refund friction is Apple's process", "data-caveat",
  "Nothing in the corpus supports a claim of deceptive billing: the developer takes one payment through Apple, and the refund friction reviewers describe is Apple's process — several reviewers say so", "single Apple payment", "none", "report gives none (non-claim)", "none", "non-claim", "yes", [])

with open("Tools/prd_ledger/23/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
