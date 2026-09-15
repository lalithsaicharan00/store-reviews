import json
R = 1
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=None))

# ---- 1.6 monetization mistakes timeline ----
c(50, "§1.6 row 2019", "timeline", "Launch state 2019: 3 free habits, $4.99 lifetime, and the review→6-months-free campaign begins",
  "3 free habits; $4.99 lifetime; CN review campaign", "mixed", "dated event; no count", "none", "timeline", "app-specific", ["3916981057"])
c(51, "§1.6 row 2020–mid 2021", "timeline", "2020–mid 2021 was the goodwill peak: effectively unlimited free habits and free reports — 'can't believe it's free'",
  "unlimited free habits, reports free", "praise", "'peak can't-believe-it's-free goodwill'; no count", "none", "timeline", "yes", [],
  cond="what followed (regressions) is measured against this peak")
c(52, "§1.6 row Jan 2022", "timeline", "Paywall regression #1 (Jan 2022): reports, multi-reminder, iCloud sync and skip moved behind Premium; non-CN review volume spiked to 429/month",
  "moved four free features behind paywall", "1★-burst", "non-CN volume spikes to 429/month", "dont", "high-priority", "yes", ["7242990766","7482039026"])
c(53, "§1.6 row Feb–Mar 2023", "timeline", "Paywall regression #2 (Feb–Mar 2023): free habit cap introduced at 5, with some users seeing 3 or 6 (an A/B test)",
  "introduced a free habit cap of 5 / 3 / 6", "complaint", "dated event", "dont", "high-priority", "yes", ["9825676857","9641681083","9803224178"])
c(54, "§1.6 row Sep 2023", "timeline", "Quit / bad-habit mode shipped Sep 2023", "shipped quit mode", "praise", "dated event", "none", "timeline", "app-specific", ["13811111971","11131185906"])
c(55, "§1.6 row Dec 2023", "timeline", "Mood tracker + journal shipped Dec 2023", "shipped mood tracker and journal", "praise", "dated event; §3: mood/journal 316 (0.6%) global, 71 US (1.3%), mean 4.66", "research", "meaningful (US)", "yes", ["11907169613","12461799977"])
c(56, "§1.6 row Apr 2024", "timeline", "Paywall regression #3 (Apr 2024): report/calendar widget moved behind Premium AND a crash-on-launch regression on Apr 27–29 → 94 crash reviews in 3 days; the rating never fully recovered",
  "re-paywalled the widget and shipped a launch crash the same month", "1★-burst", "94 crash reviews in 3 days; 'the rating never fully recovered after Apr 2024'", "dont", "high-priority", "yes",
  ["11214694671","11209749389","11208599895","11208339326","11207697641","11212491544"],
  side="two failures landing together compound; the report treats Apr 2024 as the turning point")
c(57, "§1.6 row Dec 2024", "timeline", "Paywall regression #4 (Dec 2024): yearly stats locked days before year-end, plus a 'minutes became hours' bug (goal values ×60) landing in New Year resolution season → worst month on record (mean 3.14)",
  "locked yearly stats right before year-end; shipped a unit-conversion bug", "1★-burst", "worst month on record, non-CN mean 3.14; 65 of 227 reviews 1★", "dont", "high-priority", "yes",
  ["12123611133","12133136766","12210864361","12144843194","12128653261","12127927438","12122368495"],
  cond="timing: the year-end report is the app's best emotional moment (Part 8 #4) — locking it or breaking it at year-end is maximally costly")
c(58, "§1.6 row 2025–2026", "timeline", "2025–2026: the free cap was loosened back to 6 and non-members can check in freely; sentiment partially recovered",
  "loosened cap to 6; free check-in", "praise", "'sentiment partially recovers'", "none", "timeline", "yes", ["13711763153","12338410317","13623783514","13624181624"],
  cond="recovery is partial only; 2025 mean still 3.73")
c(59, "§1.6 pattern line", "product-rule", "Every time a free feature moved behind the paywall the rating dropped and stayed down — it never fully recovered after April 2024",
  "four paywall regressions 2022–2024", "1★-burst", "paywall regression ('it used to be free') ×12.0 lift on 1★, ×6.3 on 2★, 75 reviews at mean 2.84 (Part 2)", "product-rule", "high-priority", "yes",
  ["7242990766","7482039026","9825676857"],
  cond="Part 8 #5: pick your free tier once and hold it")

# ---- PART 2 rating drivers ----
c(60, "Part 2 5★ table row 1", "insight", "'No ads' is the highest-rated topic in the corpus — 181 of 182 mentions are positive",
  "ad-free", "praise", "5★ lift ×1.12; 1 low rating out of 182; mean 4.91", "must-have", "weak count, best mean", "yes", [],
  cond="Part 8 #20: stay minimal and ad-free")
c(61, "Part 2 5★ table rows 2-3", "audience", "Students / exam-prep and ADHD / neurodivergent users are the highest-satisfaction audiences",
  "positions as ADHD planner in the title", "praise", "students 5★ lift ×1.10, mean 4.87; ADHD ×1.09, mean 4.83; ADHD = 7.08% of US reviews at mean 4.79 (Part 8 #19)", "do", "high-priority", "yes", [],
  side="also people tracking medication and chronic illness (Part 8 #19)",
  cond="Part 8 #19: aim at ADHD/neurodivergent users")
c(62, "Part 2 5★ 'translation'", "insight", "The 5★ recipe: clean, ad-free tracker, aimed at ADHD/students, priced as a cheap one-time buy, given away to people who can't afford it",
  "n/a", "5★-burst", "synthesis of the 5★ lift table", "do", "high-priority", "yes", [])
c(63, "Part 2 1★ table row 1 + sentence 1", "must-never-break", "Taking money incorrectly is the fastest route to 1★ — billing errors are ×21.3 over-represented in 1★ and 100% of US billing complaints are 1–3★",
  "billing errors", "1★-burst", "×21.3 on 1★, ×3.9 on 2★; 102 reviews, mean 1.89; 100% of US billing complaints 1–3★", "must-never-break", "high-priority", "yes", [])
c(64, "Part 2 1★ table rows 2-4 + sentence 2", "insight", "Charging for something and then not delivering it is the second-fastest route to 1★ — restore purchase, family plan and broken sync all sit above ×9",
  "sells sync/family/restore that fail", "1★-burst", "restore purchase ×13.9 on 1★ (49, mean 2.51); family plan ×12.7 (73, mean 2.55); sync failure ×7.6 / ×10.0 on 2★ (134, mean 2.93); shared-habit failure ×11.7 / ×11.2 (66, mean 2.33)", "must-never-break", "high-priority", "yes", [])
c(65, "Part 2 1★ table row 7", "must-never-break", "Crashes are the largest complaint by volume: 1,072 reviews at mean 2.98",
  "recurring crashes", "1★-burst", "1,072 reviews, mean 2.98, ×8.6 on 1★, ×8.3 on 2★", "must-never-break", "high-priority", "yes", [])
c(66, "Part 2 1★ table row 10", "must-never-break", "Reminders not firing is a strong 1★ driver",
  "reminders sometimes fail", "complaint", "66 reviews; ×6.6 on 1★, ×4.1 on 2★", "must-never-break", "moderate", "yes", [],
  cond="reminders that work are also a top praise item (Part 3: 9.4% of US at 4.59) — same feature, both directions")
c(67, "Part 2 1★ table row 11", "insight", "Simply having paid is a 1★ risk factor: confirmed buyers are ×6.7 over-represented in 1★",
  "n/a", "churn", "confirmed purchase ×6.7 on 1★, ×4.1 on 2★", "must-never-break", "high-priority", "yes", [])
c(68, "Part 2 1★ table row 12", "must-never-break", "A broken widget is a strong 1–2★ driver",
  "widgets break", "complaint", "60 reviews; ×5.2 on 1★, ×7.8 on 2★", "must-never-break", "moderate", "yes", [])
c(69, "Part 2 1★ table row 14", "market", "Missing localisation is the largest non-crash complaint: 639 reviews at mean 3.54, ×6.5 on 2★",
  "English (and Chinese) only for most of its life; Japanese added mid-2026", "complaint", "639 reviews, mean 3.54; ×4.4 on 1★, ×6.5 on 2★, ×5.5 on 3★", "do", "high-priority", "yes", [],
  cond="Part 6 has the per-language counts; §1.3 shows it blocks purchases")
c(70, "Part 2 1★ table row 15", "monetization", "The free habit cap draws 296 complaints and is ×7.5 over-represented in 2★",
  "free cap 3–6", "complaint", "296 reviews; ×4.0 on 1★, ×7.5 on 2★", "build-free", "high-priority", "yes", [],
  cond="cap complaints land in 2★ more than 1★ — annoyance, not rage")
c(71, "Part 2 1★ table row 16", "monetization", "'Too expensive' draws 209 complaints at moderate lift, even at a ~$10 lifetime price",
  "lifetime ~$10 by 2026", "complaint", "209 reviews; ×3.4 on 1★, ×3.2 on 2★", "research", "moderate", "yes", [],
  cond="price rose from $4.99 to ~$10 (R01-007); 'cheap/fair' is simultaneously a 5★ driver (R01-032)")
c(72, "Part 2 3–4★ list", "feature", "Custom frequency (every X days, specific weekdays, bi-weekly, quarterly, yearly, total-over-a-window) is the #1 unmet functional need and the highest 4★ lift in the dataset",
  "missing", "complaint", "4★ lift ×4.2, 3★ ×3.9 — 'the classic great app, but…'; Part 5 ranks it #1", "must-have", "high-priority", "yes", [],
  cond="Part 8 #11")
c(73, "Part 2 3–4★ list", "feature", "A Mac / Windows / web version is the strongest 3★ driver; several users volunteered to pay extra for it",
  "iPhone/iPad only", "blocked-conversion", "3★ lift ×4.8", "build-paid", "strong", "yes", ["8965466270","9503979717"],
  cond="Part 8 #17")
c(74, "Part 2 3–4★ list", "feature", "Sub-tasks / folders / grouping / multiple profiles is a mid-band gap",
  "missing", "complaint", "2★ lift ×2.7, 4★ ×2.3", "undecided", "moderate", "yes", [],
  cond="Part 8 #13: 'me, my kids, work, pet'")
c(75, "Part 2 3–4★ list", "feature", "Shortcuts / Siri / URL-scheme automation is asked for by power users who evangelise",
  "missing", "complaint", "4★ lift ×2.7", "undecided", "moderate", "yes", [],
  cond="Part 8 #18")
c(76, "Part 2 3–4★ list", "insight", "Localisation, sync, Watch and Health also sit in the 3–4★ band — these users already like the app and would move to 5★ if the gap were closed",
  "n/a", "blocked-conversion", "localisation 3★ ×5.5; iCloud sync 3★ ×5.0 / 2★ ×6.4; Apple Watch 3★ ×4.7 / 2★ ×5.7; Apple Health 4★ ×2.8", "do", "strong", "yes", [])

# ---- PART 3 praise ----
c(77, "Part 3 table row 1", "insight", "Simple / clean / beautiful UI is the dominant praise: 21.1% of all reviews, 32.2% of US",
  "minimal design", "praise", "11,969 global (21.1%); 1,750 US (32.2%), HIGH-PRIORITY, mean 4.74", "must-have", "high-priority", "yes", [],
  cond="Part 8 #20: every request for more features is paired with 'but don't make it complicated'")
c(78, "Part 3 table row 2", "feature", "Reminders that work are the #2 praise item",
  "reliable reminders (mostly)", "praise", "2,162 global (3.8%); 508 US (9.4%), HIGH-PRIORITY, mean 4.59", "must-have", "high-priority", "yes", [])
c(79, "Part 3 table row 3", "feature", "Icon / colour / theme customisation is praised at 'very strong' band with mean 4.70",
  "free icons and colours; paid icon themes", "praise", "1,550 global (2.7%); 255 US (4.7%), VERY STRONG, mean 4.70", "build-free", "very strong", "yes", [])
c(80, "Part 3 table row 4", "feature", "Widgets are a high-priority praise item in the US",
  "free basic widget; paid report/calendar widget since Apr 2024", "praise", "1,297 global (2.3%); 373 US (6.9%), HIGH-PRIORITY, mean 4.45", "build-free", "high-priority", "yes", [],
  cond="mean 4.45 is the lowest among praise items — widgets also break (R01-068)")
c(81, "Part 3 table row 5", "feature", "Streaks / progress feedback is a high-priority praise item",
  "streaks + grid views", "praise", "1,202 global (2.1%); 391 US (7.2%), HIGH-PRIORITY, mean 4.73", "build-free", "high-priority", "yes", [])
c(82, "Part 3 table row 6", "feature", "Reports / stats board is praised at 'meaningful' band",
  "paid reports", "praise", "1,009 global (1.8%); 69 US (1.3%), MEANINGFUL, mean 4.69", "build-paid", "meaningful", "yes", [])
c(83, "Part 3 table row 8", "feature", "Flexible units / partial progress (drag to 60% instead of a binary tick) is an emerging praise item and a named reason for choosing this app over competitors",
  "progress bar with partial check-in", "praise", "371 global (0.7%); 40 US (0.7%), EMERGING, mean 4.53; 'genuinely differentiating'", "undecided", "emerging", "yes",
  ["8484864815","7533159455","9599419869"])
c(84, "Part 3 table row 9", "feature", "Quit-bad-habit mode is praised at 'meaningful' band in the US",
  "paid quit mode since Sep 2023", "praise", "271 global (0.5%); 85 US (1.6%), MEANINGFUL, mean 4.69", "research", "meaningful (US)", "yes", [])
c(85, "Part 3 table row 10", "feature", "Mood / journal is praised at 'meaningful' band in the US",
  "mood tracker + journal since Dec 2023", "praise", "316 global (0.6%); 71 US (1.3%), MEANINGFUL, mean 4.66", "research", "meaningful (US)", "yes", [])
c(86, "Part 3 'specific things' bullet 2", "insight", "Week / month / year grid views are the emotional payoff — 'filling the squares' is the retention mechanic",
  "grid views", "praise", "named repeatedly; no count", "must-have", "qualitative", "yes", ["8631367041","10586793226","11007512932"])
c(87, "Part 3 'specific things' bullet 3", "feature", "The check-off sound and haptic are named as a reason to keep coming back",
  "sound + haptic on check-off", "praise", "named; no count", "build-free", "qualitative", "yes", ["12817953072","8746818428"])
c(88, "Part 3 'specific things' bullet 4", "tactic", "The developer's app family (Minimalist To-Do, Card Budget, Budget) drives cross-buying on brand trust — an under-used monetization asset",
  "publishes several minimalist apps under one brand", "purchase-driver", "9 IDs cited; 'users cross-buy on brand trust'; no count", "do", "qualitative", "yes",
  ["8409037626","8551806489","8552974691","8586441242","8420279444","11168340470","11210031835","12156175776","9470194755"])
c(89, "Part 3 competitors paragraph", "positioning", "Competitors are named in 9% of US reviews; US buyers anchor the price against Done ($29.99) and HabitBull ($20/yr)",
  "n/a", "purchase-driver", "1,142 mentions (2.02% global, 9.01% US — HIGH-PRIORITY)", "do", "high-priority", "yes",
  ["10947705264","11520612891","8157182844","10633728275","10850980761","13825611867","10793490908"],
  side="named: Streaks, Habitica, HabitBull, Habitify, Way of Life, Productive, Fabulous, Done, Loop, Finch, me+, Structured, Tally, HabitNow, TickTick, Todoist, Notion, Forest, Atoms, Strides, HabitShare; CN: 小日常, iBetter, 番茄ToDo, 滴答清单, 指尖时光, 目标地图, FastLog, 人升")

with open("Tools/prd_ledger/1/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
