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


# ---- PART 3 — PRAISE ----
c(48, "Part 3 WHAT PEOPLE PRAISE (full table) (verbatim)", "data-caveat",
  "Twenty praise themes with n, %, mean, 1–2★%, 5★% and signal",
  "n/a", "praise", table("# PART 3"), "none", "verbatim", "app-specific", [])
c(49, "§3.1 The developer is a named asset", "insight",
  "The developer is a named asset — '¡Gracias Maximilian!'; 'Bless developers like Maximilian Munker' — with documented responsiveness ('the developer actually takes people's feedback into consideration!'; 'Auch der Support ist sehr schnell und freundlich!')",
  "solo developer, responsive", "praise", "praise_developer 67 (7.88%, HIGH), mean 4.79, 89.6% 5★", "do", "high-priority", "yes",
  ["12117330361","8306583064","11869217620","9494382068","10399402927"])
c(50, "§3.2 ADHD is a small, perfect-scoring segment", "audience",
  "ADHD users are a small, perfect-scoring segment and the mechanism they name is flexible completion without guilt — 'it provides the flexibility in the task completions within a week/month so I don't feel the pressure of my todos' — precisely what frequency confusion breaks for fixed-schedule users: same feature, two populations, opposite outcomes",
  "flexible X-per-period completion", "praise", "adhd 5 (0.59%, EMERGING), all 5★, mean 5.00; +3 procrastination / executive-function", "do", "emerging", "yes",
  ["13846753254","14385616593","13203214681"])
c(51, "§3.3 What people actually track table (verbatim); Part 5 The student", "audience",
  "Students are the largest named use case and the Pomodoro timer is the reason — 'a wonderful thing for me - a college student'; also fitness, mental health, quitting, medication, chores, ADHD",
  "focus timer bundled free", "praise", table("## 3.3 What people actually track"), "do", "keyword scan", "yes",
  ["10288751850","13089862446","12339105908","12459196344","12738414001","12136485316","14406483115","9568937085","13226885529"])
c(52, "§3.3 a therapist recommending it to clients", "tactic",
  "A clinician recommends the app to clients because it is free and ad-free — 'I'm a therapist and I recommend this app for clients. Harnessing the power of having visual signals of progress is important… PLUS it's free and no ads' — a distribution channel the free position created",
  "free, no ads", "5★-burst", "1 (5★, CA)", "do", "quoted (n = 1)", "yes", ["10841075611"])

# ---- PART 4 — COMPLAINTS ----
c(53, "Part 4 COMPLAINTS AND UNMET NEEDS (full table) (verbatim)", "data-caveat",
  "Thirty-seven complaint / request themes; 32.1% of reviews (273) carry at least one feature request, 16.2% (138) report a bug, defect or confusion, 55.6% (473) are pure praise with neither",
  "n/a", "complaint", table("# PART 4"), "none", "verbatim", "app-specific", [])
c(54, "§4.1 History and backfill: the second-biggest structural gap; Part 6 #2; Part 9 #9", "feature",
  "Backfill is capped at roughly six or seven days and history is hard to see — 'Derzeit kann ich sie nur 6 Tage rückwirkend abhaken'; 'Please add ability to backfill missed check in the calendar beyond one week'; 'Every week is a new week, you can't go back and see how your habits have been tracked so far' — the lowest mean of any request theme; the summary partly fixed viewing, editing remains open",
  "backfill window ~7 days", "complaint", "want_backfill_past 27 (3.18%, VERY STRONG), mean 3.52, 14.8% 5★, 14.8% 1–2★; rating penalty −1.01; 5.5% of 2025 → 2.7% of 2026; 3★ band 7 of 42 (16.7%); 1★ band 2", "must-have", "very strong", "yes",
  ["12248277514","11587754660","13922090666","13237495965","14159912572","14516137596","13182431485"])
c(55, "§4.1 backfill 7-day wall vs report 1 bounded backfill", "contradiction",
  "A bounded backfill window (~7 days) is report 8's worst-rated request (mean 3.52) — against report 1, where users accepted a bounded free backfill window",
  "~7-day backfill in a free app", "complaint", "27 at 3.52 (penalty −1.01)", "must-have", "cross-report tension", "yes", [],
  cond="report 8's users also lack stats/history views, so the window is the only way back; report 1 paired a bounded window with rich history views and a paid unlock")
c(56, "§4.2 Stats and analytics: shipped, but not finished; Part 6 #3", "feature",
  "Stats and analytics are the classic withheld-star request (low 5★ share, zero 1–2★): the shipped monthly/yearly summary helped, but users still want graphs and heat maps — 'a heat map for the past 365 days'; 'a graphical representation of all the habits like in Obsidian'; 'a graph view'",
  "tables / summaries, no graphs", "complaint", "want_stats_analytics 47 (5.53%, HIGH), mean 4.11, 29.8% 5★, 0.0% 1–2★; 4★ band 24 (14.5%); 3★ band 9 (21.4%); penalty −0.42; oldest Feb 2021, newest Aug 2026", "undecided", "high-priority", "yes",
  ["6940011305","14212944580","14461713243","12380782408","13591528677","13241851409"])
c(57, "§4.2 But the shipped feature has an off-by-one defect, reported twice independently; Part 9 #2", "must-never-break",
  "The flagship 2026 feature shipped with an off-by-one: the monthly summary never includes the last day of the month — 'I completed all my habits for January, but according to this new feature I completed only 30 of 31 days… Maybe you just missed a line in the code?' (1★); 'even if you do the habit all 30 days… it always says 29/30 or 97%' — almost certainly a one-line date-range bug that turned the flagship feature into a 1★",
  "month summary excludes last day", "1★-burst", "2 independent reports 3 months apart (Feb 2026 1★, May 2026 4★); bug_monthly_summary 2 (0.24%), mean 2.50", "must-never-break", "weak, trust-critical", "yes",
  ["13742512516","14018076544"])
c(58, "§4.3 Sync, backup, and device migration: the top gap in emerging markets table (verbatim)", "market",
  "Sync/backup demand by market group: India 14.10%, emerging group 9.64%, high-volume group 5.13%, US 2.66%",
  "n/a", "complaint", table("## 4.3 Sync"), "none", "verbatim", "app-specific", [])
c(59, "§4.3 sync/backup/device migration; Part 6 #5; Part 9 #11", "must-have",
  "Backup and device migration, not multi-device convenience, is the need: 'I recently reset my iPhone. Now after installing the app, there is no login option. All my habit records are gone'; 'If the app is uninstalled all the user data will be lost'; 'I just wish it has icloud saving but I realize if something is free like this, the devs cant afford such' — a local encrypted backup file plus iCloud Drive document sync answers it without a server, an account or a revenue model",
  "local-only, no backup, no account", "churn", "want_sync_backup_account 37 (4.35%, VERY STRONG), mean 4.30, 5.4% 1–2★; 4★ band 13 (7.9%); + 12 export + 9 data loss; 4.6% of 2025 → 2.7% of 2026", "must-have", "very strong", "yes",
  ["10544874717","12874016631","13668962217","11943323917"],
  cond="free, no-account app — the fix must not need a server")
c(60, "§4.3 India names this at 5.3× the US rate; §7.1 finding 1", "market",
  "India is the sync/backup market: device reset and replacement wipe habit history, and India's only 1★ is exactly this ('Unable to send tracker that I created to a different device')",
  "no device transfer", "1★-burst", "IN 11 / 78 (14.10%, HIGH) vs US 5 / 188 (2.66%) — 5.3×; emerging group 16 / 166 (9.64%)", "must-have", "standalone (n ≥ 50)", "yes",
  ["12874016631","10544874717","13668962217"])
c(61, "Part 4 data_loss", "must-never-break",
  "Data loss is the worst-rated reliability theme — 'it does not save the marks. The next day all boxes are empty'; a 1★ who lost data twice",
  "local storage lost", "1★-burst", "data_loss 9 (1.06%, MEANINGFUL), mean 2.67, 66.7% 1–2★; 2★ band 5 of 20 (25.0%)", "must-never-break", "meaningful", "yes",
  ["13098030502","14021302236","10544874717"])
c(62, "§4.4 The frequency model is the most-misunderstood part of the product table (verbatim)", "data-caveat",
  "Five frequency walls: seven circles for a 1×/3×-a-week habit; no 'every N days'; no weekday-only habits; weekly units expressed only in days; the x-per-y setting has no visible effect",
  "n/a", "complaint", table("## 4.4 The frequency model"), "none", "verbatim", "app-specific",
  ["11475373489","12694560233","13411041482","13522897637","12544035274","12961057018","11401964014","12013003790","11083479860","11234227951","12142373319","11246565899","14045501473","14359179692","11552052382","11761511083","11507981724"])
c(63, "§4.4 segmentation problem, not a bug — fix is display, not logic; Part 6 #6; Part 9 #8", "feature",
  "Show circles only on days a habit is actually scheduled: the flexible-frequency model is praised by the users it fits ('the only habit tracker I have found that is able to handle my 3 day a week (but ANY day of the week) habits') and opaque to fixed-schedule users ('a weekly habit must be set to every 7 days, which isn't totally intuitive') — a rendering change, not a model change",
  "seven circles shown regardless of schedule", "complaint", "frequency_confusion 25 (2.94%, MEANINGFUL), mean 3.76, 12.0% 1–2★, 16.0% 5★; penalty −0.77; 4★ band 14 (8.5%)", "must-have", "meaningful", "yes",
  ["14254399815","13813008711","14045501473","11475373489"])
c(64, "§4.5 Focus timer: the most-requested small fixes table (verbatim)", "data-caveat",
  "Focus-timer asks ranked: custom durations, alarm doesn't sound, Live Activity / Lock Screen countdown, resets when backgrounded, auto-start break, screen sleeps, stopwatch/flowmodoro, per-habit focus stats",
  "n/a", "complaint", table("## 4.5 Focus timer"), "none", "verbatim", "app-specific", [])
c(65, "§4.5 focus timer requests; Part 6 #7", "feature",
  "The focus timer is liked and wants finishing: arbitrary durations (not just 5/15/25/60), a Live Activity / Lock Screen / Dynamic Island countdown, auto-start break, keep the screen awake, a stopwatch/flowmodoro mode, per-habit focus stats",
  "presets only; no Live Activity", "praise", "focus_timer_issue 32 (3.76%, VERY STRONG), mean 4.34; 4★ band 14 (8.5%); 4.2% of 2025 → 1.4% of 2026; emerging markets 5.42%", "undecided", "very strong", "yes",
  ["10320051165","11497359189","12427747362","10730989325","11575357275","8306583064","10278427560","11298218335","10102584778"])
c(66, "§4.5 The alarm-doesn't-sound cluster; Part 9 #4", "must-never-break",
  "The focus-timer alarm does not fire when another app is opened, the screen is off or the ringer is silent, and one timer resets when backgrounded — 'sometimes the focus/break timer doesn't go off if I open another app or if I turn off the screen despite the volume being turned on' — an audio-session / notification-category configuration, not a feature",
  "alarm silent in background", "complaint", "7 reviews Jan 2024 → Aug 2026; resets on backgrounding 14397732532 (IN, 2★, Aug 2026)", "must-never-break", "emerging", "yes",
  ["10808472591","12031614206","12187537484","10562486460","9878233995","11099294310","14397732532"])
c(67, "§4.6 The widget: best-loved surface and biggest defect surface at once; Part 6 #4; Part 9 #10", "feature",
  "The widget is the best-loved surface and the biggest defect surface at once; the dominant ask is to show more than one habit — 'you can only track one habit from it. If the dev can provide a more up front view of all of your habits on the widget, this would be my daily used app!' — plus lock-screen widgets and more sizes (tap-to-tick now shipped); a pure-upside request going back to Jan 2021",
  "free single-habit widget; tap-to-tick shipped mid-2026", "praise",
  "widget mentions 86 (10.12%), mean 4.40; positive-only 28 (3.29%), 4.61; want_widget_better 41 (4.82%, VERY STRONG), mean 4.56, 0.0% 1–2★, penalty +0.03; widget requests 4.6% of 2025 → 2.1% of 2026; emerging markets 13.86% mentions, 6.02% requests", "build-free", "very strong", "yes",
  ["12155711592","11746712561","10269783945","11116741104","12171578935","10076496123","10371841156","10832112045","13539393763","6862625618","14502932053"])
c(68, "§4.6 This is a placeholder-string leak in the widget timeline that survived three years; Part 9 #3", "must-never-break",
  "The widget shipped a placeholder-string leak for three years: it renders the word 'habit' in several languages instead of data — 'Leider funktioniert das widget nicht und zeigt nur das Wort Gewohnheit in verschiedenen Sprachen an'; 'Shows no data, mo datos, keine daten'",
  "widget timeline shows localized placeholder", "complaint", "widget_broken 13 (1.53%, MEANINGFUL), mean 3.62, 15.4% 1–2★; Dec 2022 → Jan 2026; IN 4 (5.13%, HIGH)", "must-never-break", "meaningful", "yes",
  ["9436912627","9586149656","10256806517","10275032045","10967037964","11029352763","11093636426","11783886827","11971548857","13089378849","13098030502","13274217621","13609169075"])
c(69, "§4.6 trapped by the widget-onboarding overlay", "anti-pattern",
  "A promotional widget-onboarding modal blocked the app on small screens for at least 20 months: a full-screen 'Never miss a habit again. Add widgets to your Home Screen' prompt with an unreachable dismiss button — 'I can't x out the ad… and I can't use the app now'; 'The Never miss a habit again screen is literally causing me to do just that'",
  "undismissable full-screen promo on small screens", "1★-burst", "bug_widget_popup 4 (0.47%, Weak), mean 3.75, 25.0% 1–2★; Apr 2023 → Nov 2024", "dont", "weak, blocking", "yes",
  ["9874416341","11040279138","11904827409","9667803845"])
c(70, "§4.7 'You can only pick from preset habits' — a discoverability failure, not a missing feature", "must-have",
  "Custom habits existed but a prominent preset picker hid the free-text path for three years — 'Wieso kann ich keine eigene Gewohnheit abtippen?… Daher nur 1 Stern, weil unbrauchbar' (the only 1★ of 2023); 'i just wish i could write in my own habit… learning a language isn't an option' — cost at least one 1★, one 2★ and eleven withheld stars for a feature that already existed",
  "preset picker prominent; custom path hidden 2023–2025, fixed ~late 2025", "1★-burst", "custom_habit_blocked 13 (1.53%, MEANINGFUL), mean 3.77, 15.4% 1–2★; 2.5% of 2025 → 0.7% of 2026", "must-have", "meaningful", "yes",
  ["10105619469","12355873345","10153674169","11590224125","13581401872"])
c(71, "§4.8 Notifications", "must-never-break",
  "Reminders fail three ways: they silently stop arriving after a few days ('then they suddenly disappear and I completely forget all about the app. this cycle keeps happening'), ghost notifications keep firing for deleted habits, and AM/PM cannot be set ('instead of it ringing at a.m. it rings at p.m.' — a 1★ from an enthusiastic user)",
  "reminder delivery and 12/24h picker defects", "1★-burst", "notif_problem 19 (2.24%, MEANINGFUL), mean 3.47, 15.8% 1–2★; 3★ band 5 (11.9%); 4★ band 8 (4.8%)", "must-never-break", "meaningful", "yes",
  ["12544716257","12664737710","14051523206","11980385792","12954786100","14096147270","14430310526","11311660298","11997469592","13724690797"])
c(72, "§4.9 What is *not* in this corpus — and that is informative", "insight",
  "Informative absences: zero price/paywall objections, zero ad complaints, zero account/login complaints, zero AI mentions or AI demand in a 2026 productivity corpus, and almost zero gamification demand — several praise that streaks and rewards can be turned off ('No cutesy cartoons… no gratuitous cheerleading'; 'I just wanted a simple ticker and didn't care about streaks and rewards, and you can turn all of that off')",
  "no AI, optional gamification", "praise", "0 price, 0 ads, 0 AI; gamification wish 1", "dont", "absence", "yes",
  ["11824366215","11590224125","10121460935"])
c(73, "§4.9 Only 5 localization requests despite 8 shipped languages", "market",
  "Unlocalized markets are not complaining, they are just smaller: only 5 localization requests despite 8 shipped languages — French requested although FR is listed (shipped in between, or the in-app language switch is not discoverable), plus Russian, Chinese, and a user who wanted to contribute a translation and couldn't; RU, ZH, TR, PT, PL, JA, KO are absent from the listing yet contributed 46 reviews at mean 4.72",
  "8 listing languages", "none", "want_localization 5 (0.59%, EMERGING), mean 4.40; unlocalized storefronts 46 reviews at 4.72", "research", "emerging", "yes",
  ["12266958159","13599411580","13115546891","12680364504","10640982313"],
  cond="contrast reports 1–5, where missing localisation blocked revenue — in a free app it blocks nothing")

with open("Tools/prd_ledger/8/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
