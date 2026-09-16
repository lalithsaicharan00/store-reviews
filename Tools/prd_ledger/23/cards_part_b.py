"""Cards for report 23 — Part 2 (product & monetisation) and Part 3 (global findings)."""
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

# ---- §2.1 feature inventory
c(22, "§2.1 Feature inventory table (verbatim)", "data-caveat",
  "Feature inventory attested in reviews, with earliest/latest IDs — everything is behind the one-time price", "n/a", "mixed",
  table("## 2.1 Feature inventory derived from reviews"), "none", "inventory", "app-specific", [])
c(23, "§2.1 Up to N habit tasks as press-and-hold circles; pages/boards of 6", "feature",
  "The product is up to N press-and-hold task circles arranged in colour-themed pages of 6 — N went 6 (2015–Jul 2017) → 12 (Jul 2017–Jul 2021) → 24 (Jul 2021–); pages went 1 → 2 → 4",
  "hard cap on task count, raised twice; pages of 6", "mixed", "cap 6 → 12 → 24; pages 1 → 2 → 4", "undecided", "inventory", "app-specific",
  ["1207369743","14519191137","1702122919","7693289034","8299170626"])
c(24, "§2.1 Press-and-hold to complete (haptic + sound); §3.3 #2", "feature",
  "Completion is a deliberate press-and-hold with haptic and sound, not a tap — praised as physically satisfying and as a guard against accidental taps, and criticised by some",
  "press-and-hold completion, included", "mixed", "attested inside themes 1 and 3 (no separate count)", "build-free", "inventory", "yes",
  ["1233132153","1565085180","1787711554","1762948125","8699216106","11414032824"])
c(25, "§2.1 'Today or yesterday?' retroactive completion; calendar view + retroactive edit of history", "feature",
  "Retroactive completion ('today or yesterday?', toggleable) and a calendar view with retroactive edit of history (added ~Mar 2016) — both included",
  "backfill via prompt and calendar, included", "praise", "inventory rows; backfill theme 76 (1.05%)", "build-free", "inventory", "yes",
  ["1219787545","1276619599","11525453355","1341315616","1342117011"])
c(26, "§2.1 Per-task custom reminder times; 'smart' auto reminders — timing algorithm widely disliked", "feature",
  "Per-task custom reminder times plus 'smart' auto reminders whose timing algorithm is widely disliked",
  "custom + algorithmic reminders, included; algorithm disliked", "complaint", "inventory row; see Part 6.5", "product-rule", "inventory", "yes",
  ["1276150206","1535900378","13111371180"])
c(27, "§2.1 App badge count of outstanding tasks with active-hours window — named as the core motivator", "feature",
  "An app-badge count of outstanding tasks, with an active-hours window, is named by many as the core motivator",
  "badge count with active hours, included", "praise", "inventory row", "build-free", "inventory", "yes", ["1276454729","5393033193"])
c(28, "§2.1 Apple HealthKit read auto-completes tasks; §3.3 #4", "feature",
  "HealthKit read (steps, flights, weight, sleep, mindful minutes, workouts, water, calories) auto-completes tasks — named repeatedly as the thing that removes the friction that killed every other habit app they tried",
  "HealthKit auto-completion, included", "praise", "277 (3.81%, very strong), mean 4.35", "build-paid", "very strong", "yes",
  ["1212736010","1457370530","9466989950","1458766203","2423668555","3927825569","12539768742"])
c(29, "§2.1 Apple Watch app + complications since watchOS 2 (2015)", "feature",
  "An Apple Watch app with complications has existed since watchOS 2 (2015), included in the price",
  "Watch app + complications, included", "mixed", "626 mentions (8.61%)", "build-paid", "inventory", "yes", ["1223650339","1261995475","13857668076"])
c(30, "§2.1 Today-view widget (interactive) — removed ~Sept 2020; Home/Lock-screen widgets (non-interactive)", "feature",
  "The interactive Today-view widget (Jan 2017) was removed ~Sept 2020 and replaced by non-interactive Home/Lock-screen widgets (iOS 14+)",
  "interactive widget removed; non-interactive replacement", "complaint", "inventory rows; widget theme 318 (4.37%)", "must-never-break", "inventory", "yes",
  ["1530309387","6442941072","12159511186"])
c(31, "§2.1 Negative ('don't') tasks — added v3.0, Jul 2017", "feature",
  "Negative ('don't') tasks were added in v3.0, Jul 2017", "quit-habit mode, included", "praise", "inventory row", "build-free", "inventory", "yes",
  ["1698660564","1727430072","4088195832"])
c(32, "§2.1 Times-per-day / per-week / per-month scheduling — yearly still absent", "feature",
  "Times-per-day, per-week and per-month scheduling exist; yearly is still absent", "flexible frequency, partial", "mixed", "inventory row; see Part 4.5", "must-have", "inventory", "yes",
  ["1295254379","2641215473","9405395737"])
c(33, "§2.1 Timed tasks + built-in Pomodoro — break cycle reported broken 2022", "feature",
  "Timed tasks and a built-in Pomodoro exist; the Pomodoro break cycle was reported broken in 2022", "timers included; Pomodoro break broken 2022", "complaint", "inventory row", "must-never-break", "inventory", "yes",
  ["3225476511","6332134320","8631830521"])
c(34, "§2.1 Statistics: streak, best, 7-day, 30-day, all-time, graphs — history depth complained of", "feature",
  "Statistics (streak, best, 7-day, 30-day, all-time, graphs) exist; history depth is complained of", "stats included; shallow history", "mixed", "inventory row; stats depth theme 46 (0.63%)", "undecided", "inventory", "yes",
  ["1698329281","3627186417","9594705817"])
c(35, "§2.1 CSV export", "feature", "CSV export exists and is included", "export included", "praise", "inventory row", "build-free", "inventory", "yes", ["1268393434","1313240975","8790139019"])
c(36, "§2.1 iCloud sync across iPhone / iPad / Watch / Mac (Sept 2018 →)", "feature",
  "iCloud sync across iPhone, iPad, Watch and Mac has existed since Sept 2018; the Mac app was a separate purchase in some periods", "sync included; Mac separately sold at times", "mixed", "inventory row; sync theme 348 (4.79%)", "must-never-break", "inventory", "yes",
  ["3240963794","13491181225"])
c(37, "§2.1 Siri Shortcuts / URL actions / NFC — power-user favourite", "feature",
  "Siri Shortcuts, URL actions and NFC triggers exist and are a power-user favourite", "automation included", "praise", "theme 26: 72 (0.99%, emerging), mean 3.94", "undecided", "emerging", "yes",
  ["1345417377","3206247831","9827682106"])
c(38, "§2.1 Custom app icon + theme colours — distinctive, cited as a delight; §3.3 #6", "feature",
  "Custom app icons and theme colours are included and frequently cited as a delight — a small feature with an outsized response", "customisation included", "praise", "324 (4.46%, very strong), mean 4.51", "build-free", "very strong", "yes",
  ["1704396672","1841745643","12480462420","1819984390","3797909975"])
c(39, "§2.1 Archive / pause tasks — pause-breaks-streak bug", "feature",
  "Archive/pause exists but a pause-resets-the-streak bug is reported", "pause included, buggy", "complaint", "theme 29: 57 (0.78%, emerging), mean 3.89", "must-never-break", "emerging", "yes",
  ["6565948711","8266328218","12490481767","10656649260","10772984090","11138802961"])
c(40, "§2.1 Per-completion notes — shipped ~Mar 2023 after long request", "feature",
  "Per-completion notes shipped ~Mar 2023 after being long requested; a later review asks for note navigation", "notes shipped 2023", "praise", "theme 37: 43 (0.59%, emerging), mean 4.00", "build-free", "emerging", "yes",
  ["9681201325","13439093120"])
c(41, "§2.1 Task sharing / accountability partner — weak / one-way", "feature",
  "Task sharing / accountability partner exists but is described as weak and one-way", "sharing included, weak", "complaint", "theme 38: 28 (0.39%, weak), mean 4.07", "research", "weak", "yes",
  ["9210832228","11023193240","10201893958","14513963633"])
c(42, "§2.1 Family Sharing", "monetization", "Family Sharing is supported on the one-time purchase", "Family Sharing on", "praise", "inventory row", "do", "inventory", "yes", ["1925820330","9367716405"])
c(43, "§2.1 macOS app — separately purchased at times; §2.2 Mac app model change", "monetization",
  "A macOS app exists; it was reported as a separate purchase in 2020–2021, then included in the universal purchase from late 2021 — a real, dated model change; the strict classifier caught 1 'Mac charged separately' review but manual reading found at least 8 (weak, ~0.11%)",
  "Mac app separate purchase 2020–21 → universal purchase late 2021", "complaint", "≥8 reviews (~0.11%, weak; classifier row 49 shows 1 — a known miss)", "do", "weak", "yes",
  ["5894140234","8319272939","12530776051","6674999158","6647868915","6853278337","7723975238","5960818396","5924527558","8094189480","9007693160","9443737606","6946517071","7212017077"])
c(44, "§2.1 'Break It Down' AI step generation — only mention asks for it to be removed", "feature",
  "'Break It Down' AI step generation (May 2026) is mentioned once — and the reviewer asks for it to be removed", "AI feature added 2026", "complaint", "1 review", "dont", "single review", "yes", ["14069398191"])
c(45, "§2.1 Medication tracker — single mention", "feature", "A medication tracker (Sep 2025) is mentioned once", "medication tracker added 2025", "none", "1 review", "research", "single review", "yes", ["13180845529"])

# ---- §2.2 monetisation
c(46, "§2.2 Monetisation model table (verbatim)", "data-caveat", "Monetisation table", "n/a", "mixed", table("## 2.2 Monetisation model"), "none", "corpus-level fact", "app-specific", [])
c(47, "§2.2 Model — paid up-front, one-time; everything behind the price; no free tier", "monetization",
  "Paid up-front, one-time — no subscription, no consumable IAP, no ads; every feature is behind the price and there is no free or premium tier; a handful wrongly believed it was free (promo redemptions or confusion)",
  "paid-only one-time purchase", "purchase-driver", "398 (5.47%) name the model as a reason to buy; 3 reviews believed it was free", "build-paid", "high-priority", "yes",
  ["10028224650","7641339972","8274159929"])
c(48, "§2.2 Free acquisition promo — Starbucks 'Pick of the Week' 2015–2016; ten-year retention", "tactic",
  "A Starbucks 'Pick of the Week' free promo in 2015–2016 drew reviewers at mean 4.62, and one of them is still using the app in July 2025 — ten-year retention from a free promo",
  "one-off free promotion via Starbucks", "praise", "13 reviews (0.18%, weak), mean 4.62; one still active Jul 2025", "do", "weak", "yes",
  ["1276154024","1305108155","1311263979","1313390731","1343836916","1374387287","1389903668","1391137306","12871227227"])
c(49, "§2.2 Bundle — Streaks + Streaks Workout (+ HealthFace)", "monetization",
  "Streaks is sold in a bundle with the developer's Streaks Workout and HealthFace apps", "app-family bundle", "none", "4 reviews cited", "do", "limited evidence", "yes",
  ["1519665903","2130326760","7992811619","10781985066"])
c(50, "§2.2 Named price ladder 2015→2026; ~2.5× with no rise in objection rate", "monetization",
  "Named price ladder from review text: 2015–16 $3.99 / £2.99 / €3.99 / ¥15–18 / ₽15 · 2017–21 $4.99–5.99 / £4.99 / €5.49 / ¥25–30 / ₩5,900 / ₺14 / ₹250 / A$7.99 · 2022–24 $7.99–8 / €6 / CA$9–10 / R$25 · 2025–26 $9.99–10 / £6 / A$9.99 / €6 — roughly 2.5× nominal over eleven years with no rise in the price-objection rate",
  "one-time price raised ~2.5× 2015→2026", "mixed", "~2.5× price; objection rate E1 1.75% → E3 2.21%", "build-paid", "meaningful", "yes",
  ["1209935398","1223253220","1312829048","1863150756","1821681612","3674856943","5190340051","9608304681","11438051593","12868795563","12687610729","13288491780","14469956788"])
c(51, "§2.2 Refund friction — Apple controls it; reviewers address Apple through the review field", "monetization",
  "Refund requests are the lowest-mean theme; Apple, not the developer, controls refunds on a paid-up-front app, and several reviewers are addressing Apple through the review field",
  "paid-up-front — refunds via Apple only", "complaint", "79 (1.09%, meaningful), mean 1.75, 70.9% 1★", "must-have", "meaningful", "yes",
  ["11474891367","11478493003","9789072827","10238906445"])
c(52, "§2.2 Accidental purchase — 6 reviews, 4 kr 2 cn, below threshold but clusters", "data-caveat",
  "Accidental purchases are below threshold but cluster geographically (4 Korea, 2 China)", "paid-up-front buy-by-mistake", "complaint", "6 (0.08%, ignore-by-default)", "research", "below threshold", "yes",
  ["1949276046","2310465385","5759175647","6723289341","6731172815","7538677717"])
c(53, "§2.2 Interpretation — the pricing model is a competitive asset; a cohort arrived after a competitor revoked purchased premium features", "positioning",
  "The one-time model is a competitive asset, not a liability: dozens chose Streaks over a better-featured competitor because rivals were subscriptions, and an entire cohort arrived after a competitor revoked already-purchased premium features",
  "one-time purchase as the positioning against subscription rivals", "purchase-driver", "8 representative reviews; cohort event in 6957986652", "build-paid", "interpretation", "yes",
  ["5227808774","6957986652","7271400285","7632443555","8575876614","10725318285","12642801382","13920320198"],
  side="the revocation event in report 20 (Habit — Daily Tracker, Jan 2021) is visible from the receiving side here")

# ---- §3.1 theme table: one card per theme at emerging or above (rule from report 20); verbatim table card
c(54, "§3.1 Complete ranked theme table (verbatim)", "data-caveat", "Master theme table, 49 themes, denominator 7,270", "n/a", "mixed",
  table("## 3.1 Complete ranked theme table"), "none", "corpus-level fact", "app-specific", [])
T = [
 (55,"#1 Simplicity / minimalism praised","insight","Simplicity/minimalism praised — the highest-volume theme","1,780 (24.48%, high-priority), mean 4.58, 1★ 3.1%, 5★ 76.9%","product-rule","praise"),
 (56,"#2 Design / beauty praised","feature","Design / beauty praised","945 (13.00%, high-priority), mean 4.38, 1★ 4.2%, 5★ 68.1%","do","praise"),
 (57,"#3 Streak motivation / accountability works; §3.3 #3","insight","Streak psychology works — the highest-satisfaction theme; reviewers describe getting out of bed to preserve a streak","902 (12.41%, high-priority), mean 4.75, 1★ 0.7%, 5★ 81.2%","build-free","praise"),
 (58,"#4 'It works' / changed my behaviour","insight","'It works' / changed my behaviour","762 (10.48%, high-priority), mean 4.77, 1★ 1.0%, 5★ 84.1%","none","praise"),
 (59,"#5 Apple Watch mentioned","feature","Apple Watch mentioned (all framings)","626 (8.61%, high-priority), mean 3.88, 1★ 12.1%, 5★ 52.7%","must-never-break","mixed"),
 (60,"#6 Capacity: asks for more tasks/pages","feature","Capacity — asks for more tasks/pages","620 (8.53%, high-priority), mean 3.96, 1★ 6.9%, 5★ 40.3%","undecided","complaint"),
 (61,"#7 One-time purchase / no subscription praised","monetization","One-time purchase / no subscription praised","398 (5.47%, high-priority), mean 4.43, 1★ 4.8%, 5★ 71.4%","build-paid","purchase-driver"),
 (62,"#8 Sync mentioned","feature","Sync mentioned (all framings)","348 (4.79%, very strong), mean 3.51, 1★ 16.1%, 5★ 37.9%","must-never-break","mixed"),
 (63,"#9 Customisation (icons, colours, app icon) praised","feature","Customisation praised","324 (4.46%, very strong), mean 4.51, 1★ 1.9%, 5★ 69.8%","build-free","praise"),
 (64,"#10 Widget mentioned","feature","Widget mentioned (all framings)","318 (4.37%, very strong), mean 3.84, 1★ 8.2%, 5★ 42.1%","must-never-break","mixed"),
 (65,"#11 Apple Health integration praised","feature","Apple Health integration praised","277 (3.81%, very strong), mean 4.35, 1★ 5.4%, 5★ 66.8%","build-paid","praise"),
 (66,"#12 UI unintuitive / undiscoverable","anti-pattern","UI unintuitive / undiscoverable — worst rating profile","250 (3.44%, very strong), mean 2.66, 1★ 31.6%, 5★ 18.4%","must-have","complaint"),
 (67,"#13 Sync — complaint-framed","must-never-break","Sync — complaint-framed subset","223 (3.07%, very strong), mean 3.08, 1★ 23.3%","must-never-break","complaint"),
 (68,"#14 Rewards / badges / gamification requested","feature","Rewards / badges / gamification requested — by happy users","136 (1.87%, meaningful), mean 4.43, 1★ 1.5%, 5★ 61.8%","research","complaint"),
 (69,"#15 Price objection","monetization","Price objection","123 (1.69%, meaningful), mean 2.21, 1★ 50.4%, 5★ 13.8%","research","complaint"),
 (70,"#16 Capacity limit defended as a feature","insight","Capacity limit defended as a feature","118 (1.62%, meaningful), mean 4.22, 1★ 5.9%, 5★ 57.6%","undecided","praise"),
 (71,"#17 Multiple-times-per-day / partial increments","feature","Multiple-times-per-day / partial increments (largely shipped 2016; residual is partial-progress display)","111 (1.53%, meaningful), mean 3.90, 1★ 2.7%, 5★ 37.8%","must-have","complaint"),
 (72,"#18 Frequency flexibility (weekly/monthly/yearly/every-N)","feature","Frequency flexibility (weekly/monthly/yearly/every-N)","101 (1.39%, meaningful), mean 4.06, 1★ 5.0%, 5★ 45.5%","must-have","complaint"),
 (73,"#19 Notifications broken / mistimed / annoying","must-never-break","Notifications broken / mistimed / annoying","97 (1.33%, meaningful), mean 3.48, 1★ 18.6%, 5★ 38.1%","must-never-break","complaint"),
 (74,"#20 Data loss","must-never-break","Data loss","81 (1.11%, meaningful), mean 2.17, 1★ 45.7%","must-never-break","churn"),
 (75,"#21 Refund requested / billing confusion","monetization","Refund requested / billing confusion","79 (1.09%, meaningful), mean 1.75, 1★ 70.9%, 5★ 13.9%","must-have","complaint"),
 (76,"#22 Undo / unmark impossible","feature","Undo / unmark impossible","77 (1.06%, meaningful), mean 3.38, 1★ 14.3%, 5★ 32.5%","must-have","complaint"),
 (77,"#23 Record beyond goal / partial progress","feature","Record beyond goal / partial progress","77 (1.06%, meaningful), mean 4.00, 1★ 3.9%, 5★ 39.0%","undecided","complaint"),
 (78,"#24 Backfill older days","feature","Backfill older days","76 (1.05%, meaningful), mean 3.75, 1★ 9.2%, 5★ 40.8%","build-free","complaint"),
 (79,"#25 ADHD / autism / mental-health use","audience","ADHD / autism / mental-health use","73 (1.00%, meaningful), mean 4.45, 1★ 5.5%, 5★ 68.5%","do","praise"),
 (80,"#26 Siri / Shortcuts / automation","feature","Siri / Shortcuts / automation","72 (0.99%, emerging), mean 3.94, 1★ 9.7%, 5★ 55.6%","undecided","mixed"),
 (81,"#27 Updates (praised or blamed)","timeline","Updates praised or blamed","62 (0.85%, emerging), mean 3.84, 1★ 16.1%, 5★ 56.5%","none","mixed"),
 (82,"#28 Widget — bug / regression","must-never-break","Widget — bug / regression subset","57 (0.78%, emerging), mean 3.16, 1★ 12.3%, 5★ 17.5%","must-never-break","complaint"),
 (83,"#29 Archive / pause / vacation mode","feature","Archive / pause / vacation mode","57 (0.78%, emerging), mean 3.89, 1★ 5.3%, 5★ 42.1%","undecided","mixed"),
 (84,"#30 Day-boundary / midnight reset","feature","Day-boundary / midnight reset (a configurable day boundary)","54 (0.74%, emerging), mean 4.02, 1★ 3.7%, 5★ 44.4%","research","complaint"),
 (85,"#31 More / custom icons","feature","More / custom icons requested","54 (0.74%, emerging), mean 4.20, 1★ 1.9%, 5★ 53.7%","build-free","complaint"),
 (86,"#32 Support praised","do","Support praised (theme also catches no-response complaints)","49 (0.67%, emerging), mean 3.88, 1★ 16.3%, 5★ 57.1%","do","mixed"),
 (87,"#33 Watch — explicit bug wording","must-never-break","Watch — explicit bug wording subset","49 (0.67%, emerging), mean 2.57, 1★ 36.7%, 5★ 20.4%","must-never-break","complaint"),
 (88,"#34 Statistics depth / year view","feature","Statistics depth / year view requested","46 (0.63%, emerging), mean 3.93, 1★ 6.5%, 5★ 50.0%","undecided","complaint"),
 (89,"#35 Crash / freeze / won't open","must-never-break","Crash / freeze / won't open","46 (0.63%, emerging), mean 2.80, 1★ 34.8%, 5★ 26.1%","must-never-break","complaint"),
 (90,"#36 List view / more per page / smaller icons","feature","List view / more per page / smaller icons (density control)","45 (0.62%, emerging), mean 3.56, 1★ 8.9%, 5★ 24.4%","undecided","complaint"),
 (91,"#37 Notes / journal per completion","feature","Notes / journal per completion","43 (0.59%, emerging), mean 4.00, 1★ 11.6%, 5★ 51.2%","build-free","complaint"),
]
for seq, w, kind, claim, mag, d, react in T:
    c(seq, f"§3.1 theme table {w}", kind, claim, "see §3.1", react, mag, d, "theme-table signal", "yes", [])
c(92, "§3.1 theme table #38–#48 weak/ignore rows", "data-caveat",
  "Weak and ignore-band themes: social/accountability partner 28 (0.39%, mean 4.07); review-prompt nagging 25 (0.34%, mean 2.72, 40% 1★); accessibility/VoiceOver 19 (0.26%, mean 3.79); end-date/long-term goal 17 (0.23%, mean 4.76, 0% 1★); localisation/translation quality 16 (0.22%, mean 3.38); no free trial 15 (0.21%, mean 2.40, 40% 1★); auto-completing without user action 11 (0.15%, mean 3.00); Health data not syncing/miscounting 9 (0.12%, mean 3.78); iPad layout not optimised 8 (0.11%, mean 4.25); battery drain/device heat 4 (0.06%, mean 2.00); ads for developer's other apps 4 (0.06%, mean 3.00)",
  "see §3.1", "mixed", "11 weak/ignore rows as listed", "none", "weak/ignore", "yes", [])
c(93, "§3.1 #39 Review-prompt nagging — weak but 40% 1★", "dont",
  "Review-prompt nagging is a weak theme with a bad rating profile", "in-app review prompt nags", "complaint", "25 (0.34%, weak), mean 2.72, 1★ 40.0%", "dont", "weak", "yes", [])
c(94, "§3.1 #43 No free trial — weak, 40% 1★", "monetization",
  "'No free trial' on a paid-up-front app is a weak theme with a bad rating profile", "no trial — paid before use", "blocked-conversion", "15 (0.21%, weak), mean 2.40, 1★ 40.0%", "research", "weak", "yes", [])
c(95, "§3.1 #40 Accessibility / VoiceOver; #46 iPad layout not optimised", "feature",
  "Accessibility/VoiceOver (19) and iPad layout (8) are weak themes", "VoiceOver gaps; iPad layout not optimised", "complaint", "19 (0.26%, mean 3.79); 8 (0.11%, mean 4.25)", "must-have", "weak", "yes", [])
c(96, "§3.1 #44 Auto-completing without user action; #45 Health data not syncing", "must-never-break",
  "Tasks auto-completing without user action (11) and Health data not syncing/miscounting (9) — weak reliability signals around HealthKit automation", "HealthKit auto-complete misfires", "complaint", "11 (0.15%, mean 3.00, 27.3% 1★); 9 (0.12%, mean 3.78)", "must-never-break", "weak", "yes", [])
c(97, "§3.1 #48 Ads for developer's other apps", "dont", "Ads for the developer's other apps drew a handful of complaints", "cross-promotes own apps", "complaint", "4 (0.06%, ignore), mean 3.00", "dont", "ignore", "yes", [])

# ---- §3.2 worst rating profiles
c(98, "§3.2 Five findings with the worst rating profile (verbatim table)", "data-caveat",
  "Worst-rating-profile themes: refund 79 (1.75, 70.9% 1★ — Korea/China accidental or expectation-mismatch purchases); price objection 123 (2.21, 50.4% — AU/CA/DE and the 'just a checklist' argument, not the level); data loss 81 (2.17, 45.7% — the only theme that destroys a long-tenure customer outright); UI unintuitive 250 (2.66, 31.6% — the largest destroyer of new customers, kills before day 3); Watch bug 49 (2.57, 36.7% — kills the customers who bought for the Watch)",
  "n/a", "churn", table("## 3.2 The five findings with the worst rating profile"), "must-never-break", "very strong", "yes", [])
c(99, "§3.2 Interpretation — two churn mechanisms with different timing", "insight",
  "Two distinct churn mechanisms with different timing: UX confusion churns people in week one ('wasted several hours'; 'deleted after 20 minutes'); data loss and Watch sync churn people in year three-to-eight ('used Streaks for some years… deeply, deeply disappointed')",
  "new-user churn via UX; long-tenure churn via data loss/sync", "churn", "UI 250 mean 2.66; data loss 81 mean 2.17; Watch bug 49 mean 2.57", "must-never-break", "interpretation", "yes",
  ["11125249667","9212927813","12257280896","11194503416"])

# ---- §3.3 what it does well
c(100, "§3.3 #1 Constraint as a feature — 'it does one thing and does it well'", "positioning",
  "The most-repeated sentence pattern in the corpus is a variant of 'it does one thing and does it well' — constraint is the feature", "deliberately constrained", "praise", "1,780 (24.48%), mean 4.58", "product-rule", "high-priority", "yes",
  ["1223740791","1298650488","1421300604","1509068759","1512340737","1853756058","6819955202","9491330601","11820002198"])
c(101, "§3.3 #3 Streak psychology — reviewers get out of bed to preserve a streak", "insight",
  "Streak psychology is the highest-satisfaction theme — reviewers describe getting out of bed to preserve a streak", "streaks as the core mechanic", "praise", "902 (12.41%), mean 4.75, 0.7% 1★", "build-free", "high-priority", "yes",
  ["1303004020","1537030013","2434415319","10359178881"])
c(102, "§3.3 #5 Apple Watch complication when it works — positive subset", "feature",
  "The Watch complication, when it works, is a top-rated strength — the positive subset is large and highly rated", "Watch complication", "praise", "positive subset 385 reviews, mean 4.35", "build-paid", "very strong", "yes",
  ["1264562226","1536186077","3546399508","9673544391"])
c(103, "§3.3 #7 The gold-theme completion state", "feature",
  "The gold-theme completion state (all tasks done turns the screen gold) is named specifically by 5★ reviewers — a delight moment", "gold completion state", "praise", "80 5★ reviews (1.7% of 5★)", "build-free", "emerging", "yes",
  ["1457647167","1566830363","5578733348","7894034801","11813889503"])
c(104, "§3.3 #8 Support responsiveness — genuine praise and genuine failures", "do",
  "Support responsiveness is praised (developer answers, fixes bring edited upgrades) but the theme also catches genuine no-response failures, which depress its mean", "developer support usually answers; some silences", "mixed", "49 (0.67%), mean 3.88", "do", "emerging", "yes",
  ["1281532474","1456207719","3410092782","4899831817","8545693662","10386986461","11330947652","13295337482","2168151281","3324443697","6513442179","7429308689","11693785508","12008652692"])

# ---- §3.4 unmet needs
c(105, "§3.4 Unmet needs table (verbatim)", "data-caveat", "Unmet needs (never-existed requests) separated from bugs", "n/a", "complaint", table("**These are requests for something that has never existed (not bugs):**"), "none", "corpus-level fact", "app-specific", [])
c(106, "§3.4 Rewards, badges, milestones, levels requested", "feature",
  "Rewards, badges, milestones and levels are requested — by satisfied users (mean 4.43)", "absent", "complaint", "136 (1.87%, meaningful), mean 4.43", "research", "meaningful", "yes",
  ["1210125866","1509518865","1523739770","3720818929","4001139449","8657817540","9466333042"])
c(107, "§3.4 Multiple-per-day / partial increments — largely shipped 2016; residual is partial-progress display", "feature",
  "Multiple-per-day / partial increments was largely shipped in 2016; residual complaints are about how partial progress is displayed", "shipped 2016; partial display remains", "complaint", "111 (1.53%, meaningful)", "must-have", "meaningful", "yes",
  ["1265283854","1298183337","1389005299","1949109997","5852474728"])
c(108, "§3.4 Frequency flexibility — yearly, every-N-weeks, specific dates", "feature",
  "Frequency flexibility requested: yearly, every-N-weeks, specific dates", "absent for yearly / every-N-weeks / specific dates", "complaint", "101 (1.39%, meaningful)", "must-have", "meaningful", "yes",
  ["1397447028","2056232018","3596141272","9405395737","10397702118","11315859157","12537226420","14320549167"])
c(109, "§3.4 Notes / journal per completion — shipped ~2023; note navigation requested", "feature",
  "Notes per completion were requested from 2015 and shipped ~2023; the residual request is navigation between notes", "shipped ~2023", "praise", "43 (0.59%, emerging)", "build-free", "emerging", "yes",
  ["1233211017","3524837176","5856256123","8267273982","9721628471","13439093120"])
c(110, "§3.4 List view / density control", "feature", "A list view or density control (more per page, smaller icons) is requested", "absent", "complaint", "45 (0.62%, emerging)", "undecided", "emerging", "yes",
  ["1277986745","4179487203","8299170626","10475031837","11548743644","13528143060","14156553445"])
c(111, "§3.4 Longer history / year heat-map", "feature", "Longer history and a year heat-map view are requested", "absent", "complaint", "46 (0.63%, emerging)", "undecided", "emerging", "yes",
  ["1384736153","3911574614","9579170708","10796378002","13611043861","13647744905","13991866349"])
c(112, "§3.4 Social / accountability partner", "feature", "A social / accountability-partner layer is requested (existing sharing is weak)", "weak sharing exists", "complaint", "28 (0.39%, weak)", "research", "weak", "yes",
  ["1210438949","3634054860","6893100721","8009347972","9210832228","14513963633"])
c(113, "§3.4 End-date / countdown / long-term goal", "feature", "An end-date, countdown or long-term goal is requested by very happy users", "absent", "complaint", "17 (0.23%, weak), mean 4.76, 0% 1★", "research", "weak", "yes",
  ["2190673897","3219243457","5234693852","7442733954","11136317227"])
c(114, "§3.4 Broken things are bugs, not unmet needs — sync, Watch, widgets, notifications, pause, timers, crash", "data-caveat",
  "The report separates bugs (sync, Watch complications, widgets, notifications, pause-resets-streak, timers, crash-on-launch) from unmet needs and analyses them in Part 6", "n/a", "none", "report gives none (taxonomy note)", "none", "method", "yes", [])

# ---- §3.5 competitors
c(115, "§3.5 Competitors named table (verbatim)", "positioning",
  "Competitors named: Momentum 14 (4.64, 'switched from'); Strides 13 (3.38, both directions — some leave to Strides over the cap); Productive 6 (4.67, 'Streaks is simpler / not a subscription'); Habitify 5 (4.20, year calendar view Streaks lacks); Habitica 3 (4.67, reward economy Streaks lacks); Apple Reminders 9 (3.67, 'Reminders does this free'); Way of Life / HabitBull / Coach.me / Lift / Done / Balanced / Haby / BlockyTime / Force of Habit ≤2 each",
  "n/a", "mixed", table("## 3.5 Competitors named in the corpus"), "do", "corpus-level fact", "yes",
  ["6958109120","8791401709","9827682106","6494025558","4001139449","9606373591","11837678069","10302560850","1757402194","1518802719","5054446330","13301938915","11926602326","11968580277"])
c(116, "§3.5 Interpretation — the competitive frame is Apple Reminders below and subscription rivals above", "positioning",
  "The competitive frame is not other habit apps — it is Apple's own Reminders on the low end ('does this free') and subscription rivals on the high end; Streaks wins the second comparison decisively and loses the first to a specific segment",
  "one-time paid vs free built-in vs subscription rivals", "mixed", "Reminders named 9 (mean 3.67); subscription-rival switchers dozens", "do", "interpretation", "yes", ["9606373591","11837678069"])

with open("Tools/prd_ledger/23/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
