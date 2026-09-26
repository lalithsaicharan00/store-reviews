import json, re
R = 8
rep = open("App Store Reports/8. Onrise - Habit Tracker & Focus - Build habits, focus & journal (REPORT).md").read().split("\n")
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
  "Onrise — Habit Tracker & Focus (App Store ID 1547137474) is a solo-indie habit tracker + Pomodoro focus timer + journal that is completely free — no in-app purchases, no subscription, no ads, no account, no server-side data; 850 written reviews at mean 4.533",
  "developer Maximilian Munker (solo indie); bundle me.onrise; site onrise.me; Productivity; 4+; original release 3 Jan 2021; v1.1.9 25 Aug 2026 ('Refreshed for iOS 26 with Liquid Glass navigation, redesigned Wrapped stories'); iOS 13.0+, 20.5 MB; listing languages NL, EN, FR, DE, HI, IT, ES, SV; store rank 8 in this set", "praise",
  "850 reviews, 67 storefronts, 9 Jan 2021 → 6 Sep 2026 (5 yr 8 mo); 5★ 601 (70.71%) · 4★ 165 (19.41%) · 3★ 42 (4.94%) · 2★ 20 (2.35%) · 1★ 22 (2.59%); US store 4.836 on 2,547 ratings", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Part 10 method (skimmed)", "data-caveat",
  "Method: denominator 850, non-exclusive themes; only US (188), DE (114), CA (89), IN (78) clear 50 — 469 reviews (55.2%), the other 63 storefronts (381) are [limited evidence]; hybrid classification — 15 broad praise themes by multilingual regex (±3–5%; 1–2★ members inspected, ~0.3% observed error), every request, bug and money theme hand-curated (the multi-daily regex returned 38 candidates of which 22 were genuine; rebuilt from the read to 36); no version, device or OS field; only 9.4% of raters write; many reviews written in the first days of use (over-measures onboarding, under-measures retention); 2021 (n=25) and 2022 (n=51) swing on 1–2 reviews; only 3 stated uninstalls — silent churn invisible; market-group definitions are external judgements",
  "n/a", "none", "850 records, 0 duplicates, reconciles with by_country and manifest; 62 themes; bands <0.1% ignore … >5% high-priority", "none", "method", "yes", [])
c(3, "⚠️ Read this before anything else: Onrise has no monetization at all", "data-caveat",
  "Onrise has no monetization at all, confirmed three ways — listing price Free, zero of 850 reviews report paying, subscribing, restoring or refunding, and all 27 'premium/pro/upgrade' mentions describe a competitor's paywall or note that Onrise has none — so this report is a natural experiment in what a habit tracker's reviews look like with price off the table; Part 1 analyses unmonetized willingness to pay and the acquisition engine 'free' buys",
  "free, no IAP, no subscription, no ads, no donation mechanism", "none", "0 of 850 paid; 27 premium mentions all about competitors", "none", "method", "app-specific", [])

# ---- PART 0 ----
c(4, "Part 0 §1 ('Free' is not a pricing decision here — it is the product's entire market position); §8.4", "positioning",
  "'Free' is the product's entire market position, not a pricing decision: reviewers say the absence of a paywall is the reason they chose it — 'The app is completely free, I can't even find its premium version'; '(3) doesn't push you to pay for a premium version since it doesn't exist!'; the most-voted review: 'I created a few quick habits expecting to see that pop up after 5 habits but it never did… I wasn't sure if there was a catch' — a business-model position in a category where every competitor gates 3–5 habits behind a subscription, doing all the acquisition work, and the single most fragile asset in the product",
  "free, no paywall, no subscription, no IAP", "praise",
  "praise_free_nopaywall 285 (33.53%, HIGH-PRIORITY), mean 4.81, 88.4% 5★; money talk 308 (36.24%) — second-largest theme behind simplicity (42.71%), ahead of design (26.94%); 274 of 601 5★ (45.6% segment rate); free praise by year 4.0% (2021) → 29.4% → 32.1% → 36.7% → 32.1% → 39.0% (2026), no fatigue", "product-rule", "high-priority", "app-specific",
  ["11533284738","12534773715","10972915619","12502921315"],
  cond="only a differentiator while competitors paywall; it cannot be walked back without converting praise into the category's standard complaint")
c(5, "Part 0 §2 (Not one of the 42 one- and two-star reviews is a price complaint) table (verbatim)", "data-caveat",
  "Reasons behind all 42 one- and two-star reviews, read individually",
  "n/a", "1★-burst", table("## 2. Not one of the 42"), "none", "verbatim", "app-specific", ["13650696629"])
c(6, "Part 0 §2 Interpretation — the headline finding", "insight",
  "Not one of the 42 one- and two-star reviews is a price complaint — remove the paywall and rating damage does not disappear, it relocates entirely to reliability (42.9%) and capability (31.0%); in the seven other apps in this set monetization is the dominant source of rating damage",
  "no price", "1★-burst", "42 1–2★ (4.94%): broken 18 (42.9%), missing capability 13 (31.0%), UI friction 7 (16.7%), off-topic 3 (7.1%), price 0 (0.0%), paywall misconception 1 (2.4%)", "product-rule", "headline", "yes", [],
  cond="free apps still get 1★s — for reliability and missing capability; monetization choices move ratings in paid apps")
c(7, "Part 0 §2 The one apparent exception — a positioning failure; Part 9 #17", "anti-pattern",
  "Category norms are so strong that a user assumed a free cap that does not exist and left 1★ — 'Because you should let us make more routines for free' — a positioning failure: the app's biggest differentiator (no paywall) is absent from the store listing",
  "no cap, but listing never says so", "1★-burst", "1 (1★, HR, Jan 2026)", "do", "quoted (n = 1)", "yes",
  ["13650696629"])
c(8, "Part 0 §3 (The rating decline is a reliability story with a clear trough and a clear recovery) period and quarter tables (verbatim)", "timeline",
  "By year and by quarter: 1★ rate went from ~1% in 2023–2024 to 4.2–4.8% in 2025–2026 (~4×); 2025Q3 is the worst quarter in the app's history",
  "n/a", "1★-burst", table("## 3. The rating decline", 0) + " || " + table("## 3. The rating decline", 1), "none", "verbatim", "app-specific", [])
c(9, "Part 0 §3 2025Q3 is the worst quarter in the app's history", "must-never-break",
  "The worst quarter was hard functional failures in a nine-week window: 'It doesn't allow me to confirm the creation of habits'; a white screen on open; 'the widget isn't showing my habits anymore'; 'it does not save the marks. The next day all boxes are empty'; 'I hit the create button and nothing happens'",
  "create flow, launch, widget and save paths broke in 2025", "1★-burst", "2025Q3 n=49, mean 4.184, 12.2% 1–2★; 5 of its 6 1–2★ are hard functional failures (6 Aug – 10 Sep 2025); bug_white_screen 4 (0.47%), 2.25; bug_cannot_create 4 (0.47%), 2.00", "must-never-break", "high-priority", "yes",
  ["12982290428","13032792258","13089378849","13098030502","13120591145","12002553577","13343619642"])
c(10, "Part 0 §3 functional-failure cluster table (verbatim)", "timeline",
  "The app broke and was then fixed: the functional-failure cluster (create failure, white screen, data loss, widget dead, can't-log-today, crashes/lag) tracks the rating curve, and 2026 has the lowest rate in five years — the rating has not yet recovered to match",
  "stalled then resumed development", "1★-burst", "43 (5.06%), mean 2.79, 48.8% 1–2★; " + table("## 3. The rating decline", 2), "must-never-break", "high-priority", "yes", [])
c(11, "Part 0 §4 (The staleness is documented by reviewers, in their own words, with dates); §8.2", "anti-pattern",
  "Staleness is visible to users and they say so with dates: 'a shame nothing has been updated for a long time'; 'last version update was a year ago'; title 'Hope you're still working on it'; 'Must be outdated and should be removed from Apple Apps listings' (1★); 'i dont know how creators of this app make money but I hope you don't delete or abandon this app' — clustered exactly in the 2024–2025 trough, then zero in 2026",
  "no updates ~mid-2024 → resumed 2026", "mixed", "abandonment_concern 7 (0.82%, EMERGING), mean 4.29, 14.3% 1–2★; Jul 2024 – Dec 2025; 0 of 146 in 2026", "dont", "emerging", "yes",
  ["11867322000","12146578302","12600586522","12936436921","13343619642","13486858510","11504152895"])
c(12, "Part 0 §4 The Wrapped 2022 button — the single most damning artefact", "dont",
  "Never leave dated, year-branded content live: a 'Wrapped 2022' button still in settings in a July 2025 build dated the product by three years inside its own settings screen — 'I only hope this isn't a failed project nobody cares about any more'",
  "Wrapped 2022 button live in 2025", "complaint", "1 review (5★, DE, Jul 2025); 'the single most damning artefact in the corpus'", "dont", "quoted (n = 1)", "yes",
  ["12936436921"])
c(13, "Part 0 §5 (Development resumed in 2026 and reviewers noticed — this is measurable) table (verbatim)", "timeline",
  "What shipped and when, with the effect on complaint rates: optional reminders, monthly/yearly summaries, custom habit names, tick from the widget",
  "n/a", "praise", table("## 5. Development resumed"), "none", "verbatim", "app-specific",
  ["8492731197","9494382068","10420089265","7893057575","13742512516","14254399815","10105619469","13581401872","14326501421","11940800533","14502932053"])
c(14, "Part 0 §5 The optional-reminders fix; §8.3 Trend 2 — shipping against reviews demonstrably works here", "tactic",
  "Tactic: the developer made reminders optional after review feedback — 'They've made notifications optional and added a widget after getting feedback from reviews'. Outcome: the app's #1 friction theme went to literally zero and stayed there — the strongest evidence in the corpus that shipping against review feedback works",
  "forced reminders → optional (~mid-2023)", "praise", "forced-reminder complaints 17.6% of 2022 (9/51) → 0.6% of 2023 → 0.0% of 2025–26 (0/383); forced_reminder (historical) 11 (1.29%), mean 4.36; DE 5.26%", "do", "strongest single evidence", "yes",
  ["8492731197","9494382068","10420089265"])
c(15, "Part 0 §5 Monthly / yearly summaries row; §4.2; §8.3", "feature",
  "Monthly / yearly summaries ('At a Glance', 'Wrapped') shipped free ~Jan 2026 and halved stats requests — 'Love the update that brought us the monthly and yearly summaries. Very cool and enjoy the data!'",
  "free, shipped ~Jan 2026", "praise", "stats requests 6.8% of 2025 → 3.4% of 2026", "build-free", "observed", "yes",
  ["13742512516","14254399815","14359179692"])
c(16, "Part 0 §6 (The #1 unmet need is intra-day completion — and it is the only theme getting *louder*) year table; Part 6 #1; Part 9 #7", "feature",
  "The #1 unmet need is intra-day completion and it is the only theme getting louder: the app asks for a frequency, then gives one binary tick — 'It asks how many time you want to a habit… but then this serves no function. You still only get one tick box'; 'I can't mark done 1/4 and then increase that through the day'; 'it would be great if the habit checkbox would increment with each click until you hit your target'; one explicit uninstall ('it wouldn't let me break the habit into small units — mark each glass of water drunk')",
  "one binary tick per day regardless of target", "churn",
  "36 (4.24%, VERY STRONG), mean 3.94, 27.8% 5★; " + table("## 6. The #1 unmet need") + "; 4★ band 17 of 165 (10.3%, #2); 3★ band 7 of 42 (16.7%, #2); rating penalty −0.59; US 7.98% vs DE 0.88% vs IN 0.00%", "must-have", "very strong, rising", "yes",
  ["11761511083","13752957984","14329423801","13748024897","13440800887","13501714015","9035653031","14516137596"])
c(17, "Part 0 §6 want_log_quantity sibling cluster; Part 6 #12", "feature",
  "Log how much was done, not just that it was done — 'having 5 minutes of something as the minimum, but logging 15 minutes for the day bc you felt like doing extra'",
  "binary only", "praise", "want_log_quantity 9 (1.06%, MEANINGFUL), mean 4.56, 0% 1–2★", "undecided", "meaningful", "yes",
  ["8326639521","8529598311","10765406993","10841977769","10942821621","11507981724","12766580589","13651287093","13803466455"])
c(18, "Part 0 §7 ('I can't check off today' is a small, sharp, high-severity usability failure) table (verbatim)", "data-caveat",
  "The eleven 'can't check off today' reports with country, rating, date and quote",
  "n/a", "1★-burst", table("## 7. "), "none", "verbatim", "app-specific",
  ["12164874968","12189113218","12214950748","12219310786","12683838260","12919299992","13990708296","10029070611","10759265147","11240015364","8922203790"])
c(19, "Part 0 §7 This is the highest-severity open item in the corpus; Part 2 1★; §8.6; Part 9 #1", "must-never-break",
  "Users cannot mark a habit complete on the day they did it — 'I can only select tomorrow'; 'couldn't mark my gym task as completed because it was after the reminder'; 'If I do something on Monday it'll show that I did it on Tuesday' — a timezone / day-boundary defect or reminder-gated logging window that breaks the product's only core action, still reported Apr 2026 after the fix wave; the highest-severity open item",
  "day-boundary / logging-window defect", "1★-burst",
  "11 (1.29%, MEANINGFUL), mean 2.73, 45.5% 1–2★ (second-worst rating profile); 6 of 11 dated Jan 2025 – Apr 2026; 3 of 11 in a 14-day Jan 2025 window; 1★ band 3 of 22 (13.6%)", "must-never-break", "highest severity", "yes",
  ["12164874968","12189113218","12214950748","12219310786","13990708296","12919299992"])
c(20, "Part 0 §8 (There is real, articulate, unmonetized willingness to pay — but it is tip-shaped, not subscription-shaped) table (verbatim)", "data-caveat",
  "The thirteen explicit willingness-to-pay statements with date and what was offered",
  "n/a", "purchase-driver", table("## 8. There is real"), "none", "verbatim", "app-specific",
  ["8082446036","9011596308","9473744662","9853721563","9979231109","10066041778","10117160205","10153094810","10529311558","13920667278","14051428806","14359179692","14491074038"])
c(21, "Part 0 §8 Read the shape, not just the volume", "monetization",
  "Willingness to pay is tip-shaped, not subscription-shaped: of 13 statements, 6 name a one-time purchase, a tip or a premium add-on and exactly one names a subscription ($4.99/month, only for features that don't exist yet); one reviewer states the trade-off in a sentence — 'If there would be some subs I wouldn't use it, but I could buy it for 5-10 bucks if it provided the full experience forever'",
  "nothing to buy", "purchase-driver", "wtp_explicit 13 (1.53%, MEANINGFUL), mean 4.85, 84.6% 5★; 6 one-time/tip/add-on vs 1 subscription; DE 5 of 13", "product-rule", "meaningful", "yes",
  ["13920667278","9979231109","10153094810","14051428806","14359179692","10117160205"])
c(22, "Part 0 §8 Donate requests; §1.4 friction 1; Part 9 #13", "monetization",
  "Users ask for a donate / tip button that does not exist — 'Würde dem Dev gern einen Kaffee spendieren'; 'give us a way to support you, developer'; 'Would consider donating a few bucks if option existed on the app' — a tip jar gates nothing, carries zero rating risk, and gives the product a visible reason to exist",
  "no donation mechanism", "blocked-conversion", "want_donate 7 (0.82%, EMERGING), all 5★, mean 5.00; DE 3 of 7; 6 of 7 from high-spend storefronts", "build-paid", "emerging", "yes",
  ["7389309906","9108984672","9735019567","10529311558","10814895538","12356113785","13440800887"])
c(23, "Part 0 §8 an equal and opposite cohort that explicitly fears monetization; §8.4", "monetization",
  "An equal and opposite cohort warns against monetizing — every one 5★: 'I hope this app will never go on the payment route'; 'I pray that this app stays free and the same!'; 'Pls keep this free!!'; 'I just hope that you won't turn this app into a money pool'",
  "free", "praise", "fear_monetization 12 (1.41%, MEANINGFUL), mean 5.00, 100% 5★; appeared from 2023, peaked 2025 (2.5%) when the app looked abandoned", "product-rule", "meaningful", "yes",
  ["9748794188","11340230450","11504152895","11928071645","12123545257","12136485316","12138446509","12254605947","12370363395","13140531683","13920667278"])
c(24, "Part 0 §8 read together they describe a precise permitted move; Part 9 #14", "product-rule",
  "20 reviewers volunteered money to a product with no way to take it and 12 warned against taking it — read together they describe the one permitted move: an optional one-time tip or a paid add-on tier, with everything that exists today staying free forever; a subscription that gates existing capability is the one move this corpus rules out",
  "free, nothing paid", "mixed", "20 (2.35%) volunteer money; 12 (1.41%) fear monetization", "product-rule", "meaningful", "yes",
  ["13920667278"], cond="applies to an app whose whole position is 'free'; the gate must be additive, never subtractive")
c(25, "Part 0 §9 (The public rating is 0.14–0.46 stars above what people write) table (verbatim)", "data-caveat",
  "Written reviews sit below tap-only ratings in 11 of 13 storefronts (the two exceptions are the smallest); only 9.4% of raters write (677 written vs 7,184 ratings); the public 4.8 is collected at moments of satisfaction — the written corpus says 4.47 for 2026",
  "n/a", "mixed", table("## 9. The public rating"), "do", "observed", "yes", [])
c(26, "Part 0 §10 (What people actually love: it does three things and gets out of the way)", "insight",
  "The praise stack is unusually coherent: simplicity, the money position, design, no ads, the developer, and the 3-in-1 bundle — the app does three things and gets out of the way",
  "minimal, free, no ads", "praise", "simplicity 363 (42.71%), mean 4.70, 77.7% 5★; free 285 (33.53%), 4.81; design 229 (26.94%), 4.64; no ads 88 (10.35%), 4.78, 84.1% 5★; developer 67 (7.88%), 4.79; all-in-one 58 (6.82%), 4.72, zero 1–2★", "product-rule", "high-priority", "yes", [])
c(27, "Part 0 §10 The bundle is genuinely load-bearing; Part 3 praise_journal, praise_focus_pomodoro, praise_allinone", "feature",
  "The 3-in-1 bundle (habit tracker + Pomodoro focus timer + journal) is load-bearing, not decoration, and none of its three parts draws a 1–2★: 'It has only 3 functions… All 3 are built with the greatest simplicity'; 'nice to have several apps in one… keep your home screen tidy without switching between 3 apps'; 'No cutesy cartoons, no advice I didn't ask for, no gratuitous cheerleading, no reminders I don't want'",
  "free habits + focus timer + journal", "praise", "journal 65 (7.65%), mean 4.68, 0.0% 1–2★; focus/Pomodoro 61 (7.18%), 4.67, 0.0% 1–2★; all-in-one 58 (6.82%), 4.72, 0.0% 1–2★; high-spend journal 9.60%, all-in-one 8.40%", "undecided", "high-priority", "yes",
  ["10115617410","14051428806","11590224125"])
c(28, "Part 0 §10 32 reviews explicitly describe abandoning a paid competitor; Part 3 switched_from_paid", "positioning",
  "Users abandon paid competitors for Onrise — the purest positive signal in the corpus — including one who left a competitor the moment it added a paywall: 'definitely #2 behind Emphasis (which I don't use anymore because they added a paywall)'",
  "free alternative", "5★-burst", "switched_from_paid 32 (3.76%, VERY STRONG), mean 4.94, 93.8% 5★, zero 1–2★; US 13 (6.91%)", "product-rule", "very strong", "yes",
  ["10278427560"], side="a competitor's re-paywall is a user-acquisition event for a free rival")
c(29, "Part 0 §10 Notably, reviewers almost never name competitors", "positioning",
  "Onrise wins on a category-level objection ('they all charge'), not head-to-head comparison: the competitive set is described generically ('50 apps', 'a bunch of habit trackers'); named mentions are rare",
  "n/a", "praise", "named mentions: Atomic Habits/Atoms 5, Fabulous 2, Emphasis, TickTick, Notion, Obsidian, Study Bunny, InnerGrow, Loop 1 each", "none", "observed", "yes", [])

with open("Tools/prd_ledger/8/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
