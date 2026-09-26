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


# ---- PART 4 — remaining themes ----
c(74, "Part 4 ui_confusion; Part 2 2★", "must-have",
  "UI/UX confusion (forced reminders, notification nagging, layout, janky animations) is the worst-profile complaint — no reviewer carrying it gives 5★",
  "layout / flow friction", "1★-burst", "ui_confusion 11 (1.29%, MEANINGFUL), mean 2.91, 45.5% 1–2★, 0.0% 5★; 2★ band 5 of 20 (25.0%)", "must-have", "meaningful", "yes",
  ["9386826805","12547660463","11904827409"])
c(75, "Part 4 want_colors_custom; Part 6 #8; Part 9 #12", "feature",
  "A habit's colour cannot be changed after creation — you must delete the habit and lose all its history to recolour it: data loss disguised as a settings limitation",
  "colour fixed at creation", "complaint", "want_colors_custom 20 (2.35%, MEANINGFUL), mean 4.35, 0.0% 1–2★; penalty −0.18", "must-have", "meaningful", "yes",
  ["12470711816"])
c(76, "Part 4 want_apple_watch; Part 6 #9; Part 9 #15", "feature",
  "The Apple Watch app is the best paid-add-on candidate in the corpus: additive, pure upside (zero 1–2★), and the only feature two reviewers independently volunteered to pay for — 'Mit Apple Watch Integration würde ich hierfür auch sehr gerne Geld zahlen'; 'You can make this a premium feature as I know this is not an easy task'",
  "absent", "purchase-driver", "want_apple_watch 18 (2.12%, MEANINGFUL), mean 4.61, 0.0% 1–2★, 66.7% 5★; penalty +0.08; SE 2 of 18", "build-paid", "meaningful", "yes",
  ["8082446036","10117160205"])
c(77, "Part 4 want_ipad_mac; Part 6 #10", "feature",
  "iPad-native / macOS apps are wanted, most in Germany; one user's iPad landscape layout broke after an update",
  "absent; iPad landscape regressed", "complaint", "want_ipad_mac 11 (1.29%, MEANINGFUL), mean 4.45, 0.0% 1–2★; DE 6 (5.26%, HIGH)", "undecided", "meaningful", "yes",
  ["12082430684","13676828438"])
c(78, "Part 4 want_folders_groups; Part 6 #11", "feature",
  "Folders / routines / lists for sorting habits — named in the corpus's only subscription-price statement ($4.99/month for folders and daily journal prompts)",
  "absent", "purchase-driver", "want_folders_groups 9 (1.06%, MEANINGFUL), mean 4.22, 0.0% 1–2★; penalty −0.31", "build-paid", "meaningful", "yes", ["14359179692"])
c(79, "Part 4 want_social_share; Part 6 #13", "feature",
  "Shared habits / accountability buddy: a 'Habit Buddy' invite exists but does not report back, so users still ask for it",
  "Habit Buddy invite that doesn't report progress", "complaint", "want_social_share 9 (1.06%, MEANINGFUL), mean 4.33, 0.0% 1–2★; 4★ band 6 (3.6%)", "research", "meaningful", "yes",
  ["9083174395","6903454353"])
c(80, "Part 4 want_todo_list; Part 6 #14", "feature",
  "A to-do list for non-repeating tasks alongside habits — 'I hope to see maybe a todo list app from devs'",
  "absent", "praise", "want_todo_list 7 (0.82%, EMERGING), mean 4.71, 71.4% 5★", "research", "emerging", "yes", ["14001076337"])
c(81, "Part 4 want_skip_vacation; Part 6 #15", "feature",
  "Skip day / vacation mode / streak freeze is requested",
  "absent", "complaint", "want_skip_vacation 7 (0.82%, EMERGING), mean 4.29, 28.6% 5★", "undecided", "emerging", "yes", [])
c(82, "Part 4 want_reorder; Part 6 #16", "feature",
  "Reordering habits was requested and shipped by Jul 2026 — 'very customizable even down to the color, order, frequency'",
  "shipped by Jul 2026", "praise", "want_reorder 6 (0.71%, EMERGING), mean 4.50", "build-free", "emerging", "yes", ["14326501421"])
c(83, "Part 4 want_week_start; Part 6 #17", "feature",
  "A Monday week start is requested (FR, AT) — and one user saw their week start on a Wednesday",
  "week start not configurable", "complaint", "want_week_start 6 (0.71%, EMERGING), mean 4.33, 16.7% 1–2★", "must-have", "emerging", "yes",
  ["12137639810","14363873344","10029070611"])
c(84, "Part 4 want_health_integration; Part 6 #18", "feature",
  "Apple Health integration is a small request — and power-user integrations are largely absent from this corpus",
  "absent", "complaint", "want_health_integration 5 (0.59%, EMERGING), mean 4.20; penalty −0.33", "research", "emerging", "yes", [])
c(85, "Part 4 want_mood_tracker; Part 6 #19", "feature",
  "A mood tracker inside the journal is asked only by 5★ users",
  "absent", "praise", "want_mood_tracker 3 (0.35%, Weak), mean 5.00, 100% 5★; penalty +0.47", "research", "weak", "yes", [])
c(86, "Part 4 want_app_lock; Part 6 #20", "feature",
  "Face ID / passcode lock is a tiny request",
  "absent", "none", "want_app_lock 2 (0.24%, Weak), mean 4.50", "research", "weak", "yes", [])
c(87, "Part 4 streak_bug_confusion", "must-never-break",
  "Streak and count miscounts erode trust — 'You track 4 times you did a habit, it'll show 6'",
  "count / streak display errors", "1★-burst", "streak_bug_confusion 7 (0.82%, EMERGING), mean 3.71, 14.3% 1–2★; praise_streak 36 (4.24%), mean 4.36", "must-never-break", "emerging", "yes", ["8922203790"])
c(88, "Part 4 perf_lag_crash; §7.1 CA", "must-never-break",
  "Lag and crashes are the single worst-rated theme — every reviewer carrying it gives 1–2★ — and three of the four are Canadian",
  "lag / crashes", "1★-burst", "perf_lag_crash 4 (0.47%, Weak), mean 1.50, 100.0% 1–2★; CA 3 of 4 (3.37% of CA)", "must-never-break", "weak, maximal severity", "yes",
  ["11648694059","8021289450"])

# ---- PART 5 — AUDIENCE ----
c(89, "Part 5 WHO ACTUALLY USES THIS — The escapee", "audience",
  "The escapee: has downloaded 5–50 habit trackers and hit a paywall in each — 'I tried around 50 apps but either they were too expensive or bad ui, this app is literal gold'",
  "free alternative", "5★-burst", "32 explicit (switched_from_paid), mean 4.94, 93.8% 5★", "do", "very strong", "yes", ["10435965488"])
c(90, "Part 5 The minimalist", "audience",
  "The minimalist actively wants fewer features — 'The developers understand that unnecessary features are a detractor to the app and should be minimized'",
  "minimal", "praise", "praise_simplicity 363 (42.71%)", "product-rule", "high-priority", "yes", ["11926768986"])
c(91, "Part 5 The cost-constrained", "audience",
  "The cost-constrained cannot pay at all — 'thank you for making the app accessible and free for those who… cannot afford to pay a monthly fee'; 'In my country I can't use credit cards and almost every habit tracker on the App Store requires a premium account' — for them free is access, not value-for-money",
  "free", "praise", "several quoted; emerging markets 166 reviews at mean 4.602", "do", "quoted", "yes",
  ["11770290555","10640982313","11504152895","12339105908"])
c(92, "Part 5 Who is missing: power users", "insight",
  "Power users are missing: almost no demand for tags, dependencies, habit stacking (1), Shortcuts/automation (2) or Health integration (5) — Onrise's users are not the users who would pay for the kind of Pro tier competitors sell",
  "n/a", "none", "habit stacking 1; Shortcuts 2; Health 5", "research", "observed", "yes",
  ["13724827992","8529598311","14004377053"],
  cond="a free app selects for minimalists and escapees; a Pro tier built for power users would have no buyers here")

# ---- PART 6 — REQUESTS ----
c(93, "Part 6 WHAT THE FEATURE REQUESTS ACTUALLY SAY table (verbatim)", "data-caveat",
  "Requests ranked by volume, rating penalty and inferred cost; the two pure-upside clusters (zero 1–2★, above-corpus mean) are the multi-habit widget (41) and the Apple Watch app (18) — both additive, neither risks simplicity, and Watch is the most-named paid add-on candidate",
  "n/a", "mixed", table("# PART 6"), "none", "verbatim", "app-specific", [])

# ---- PART 7 — COUNTRY ----
c(94, "§7.1 The four eligible storefronts (≥50 reviews) table (verbatim)", "market",
  "US / DE / CA / IN rating distributions against the 63 other storefronts",
  "n/a", "mixed", table("## 7.1 The four eligible", 0), "none", "verbatim", "app-specific", [])
c(95, "§7.1 Canada is the weakest eligible storefront (4.416) and it is a 2★ problem specifically; finding 4", "market",
  "Canada is the weakest eligible storefront and it is a 2★ problem — every CA two-star is a usability or reliability failure (crashes, notification nagging, preset-habits-only, frequency options, trapped widget popup, janky animations, can't log today), none about price — while Canada also leads on praising no ads and the free position: the most price-position-aware and least tolerant of jank",
  "n/a", "complaint", "CA 89: mean 4.416; 2★ 6.7% (3× corpus 2.35%); perf_lag_crash 3 of 4; no ads 19.10%; free 41.57%", "none", "standalone (n ≥ 50)", "app-specific",
  ["8021289450","9386826805","10967703803","11083479860","11904827409","12547660463","13990708296"])
c(96, "§7.1 Signal labels applied at country level table (verbatim)", "market",
  "Country-level signal labels for simplicity, free, design, no ads, sync, multi-daily, stats, iPad/Mac, forced reminder, widget broken, WTP, switched from paid",
  "n/a", "mixed", table("### Signal labels applied"), "none", "verbatim", "app-specific", [])
c(97, "§7.1 finding 2 — Germany is the willingness-to-pay market", "market",
  "Germany is the willingness-to-pay market: 5 of the 13 WTP statements and 3 of 7 donate requests are German; DE also most wants iPad/Mac, historically drove the forced-reminder complaint, and writes the longest, most structured feedback (one 14-item numbered feature list)",
  "n/a", "purchase-driver", "DE 114: wtp_explicit 5 (4.39%, VERY STRONG); donate 3 of 7; want_ipad_mac 6 (5.26%); forced_reminder 6 (5.26%); simplicity 51.75%", "do", "standalone (n ≥ 50)", "app-specific",
  ["11593270170","8082446036","9011596308","14051428806"])
c(98, "§7.1 finding 3 — The US is where the intra-day gap is felt", "market",
  "The US is where the intra-day completion gap is felt — and where competitor-switching is most narrated",
  "n/a", "complaint", "US 188: want_multi_daily_checkin 15 (7.98%, HIGH) vs DE 0.88% vs IN 0.00%; switched_from_paid 13 (6.91%)", "none", "standalone (n ≥ 50)", "app-specific", [])
c(99, "§7.2 High-spend markets table (verbatim)", "market",
  "High-spend markets (US, JP, GB, DE, CA, FR, AU, KR, CN — a market-definition choice) rate Onrise lower than the rest of the world and complain more, but all 13 WTP statements and 6 of 7 donate requests come from them: if a paid add-on is ever built, DE and US are where the demand was voiced",
  "n/a", "mixed", table("## 7.2 High-spend") + " ; over-index: simplicity 45.20%, design 28.60%, journal 9.60%, all-in-one 8.40%; WTP 13 of 13 and donate 6 of 7 from high-spend (UA, IT the only exceptions)", "research", "definitional grouping", "yes", [],
  cond="contrast report 7, where high-spend markets rated higher")
c(100, "§7.3 High-review-volume storefronts table (verbatim)", "market",
  "The markets that write the most rate the lowest (gap 0.11); GB is the weakest of the six (4.297, [limited evidence]) with the corpus's largest store-vs-written gap (−0.46) — review volume is an engaged-writer proxy, not downloads",
  "n/a", "mixed", table("## 7.3 High-review-volume"), "none", "verbatim", "app-specific", [])
c(101, "§7.4 Emerging markets", "market",
  "Emerging markets are the most satisfied group and use the app differently: on older or replaced devices (device-migration data loss), relying heavily on the widget, without the journal/focus extras — and framing free as access, not value-for-money",
  "free", "praise", "IN, PH, VN, ID, MX, BR, TR, EG, NG, PK, LK, ZA = 166 (19.5%), mean 4.602, 1–2★ 3.0%; sync 9.64% vs 4.35%; widget requests 6.02% vs 4.82%; widget mentions 13.86% vs 10.12%; focus issues 5.42% vs 3.76%", "research", "grouping", "yes",
  ["11504152895","12339105908"])
c(102, "§7.5 Sub-50 storefronts — limited-evidence notes", "market",
  "Sub-50 notes [limited evidence]: Sweden produced the only 1★ over the can't-log-today defect and 2 of 18 Watch requests; France holds both French localization requests although FR is a listed language (a five-minute check of the in-app language switch); Vietnam and Italy are the only storefronts where the written mean meets or exceeds the store rating",
  "n/a", "mixed", "63 storefronts, 381 reviews (44.82%), mean 4.575; SE 19 (4.526); FR 25 (4.600); VN 13; IT 16", "none", "limited evidence", "app-specific",
  ["12164874968","12266958159","13599411580"])

with open("Tools/prd_ledger/8/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
