"""Cards for report 34 — Part 2 (product & money model) and Part 3 (global findings)."""
import sys; sys.path.insert(0, "Tools/prd_ledger/34")
from _lib import c, table, save

# §2.1
c(42, "§2.1 Feature inventory derived from reviews (verbatim table)", "data-caveat", "Feature inventory with free/paid state as reviewers describe it", "n/a", "mixed", table("## 2.1 Feature inventory"), "none", "inventory", "app-specific", [])
c(43, "§2.1 One-tap daily check-off on a Today list, with haptics — free", "feature",
  "One-tap daily check-off on a Today list, with haptics, is free and is what 'simple' means to reviewers ('only takes one touch'; 'only takes two clicks … the haptics'); haptics praised in 3",
  "free", "praise", "inventory; haptics 3 (weak)", "build-free", "inventory", "yes", ["5483779509","8439520479","13714210053","3249145216"])
c(44, "§2.1 Monthly calendar view (added ~April 2020), weekly view — free", "feature",
  "A monthly calendar view (added ~Apr 2020, 'the new changes to see your habits in a monthly view') and a weekly view are free",
  "free", "praise", "inventory", "build-free", "inventory", "yes", ["5755729025","7978390766","10830863058"])
c(45, "§2.1 Streak count, success %, all-time stats; trophy on a streak — free (stats screen 'a bit too simple' in free)", "feature",
  "Streak count, success %, all-time stats and a trophy on a streak are free; the free stats screen is called 'a bit too simple'",
  "free basic stats", "mixed", "inventory", "build-free", "inventory", "yes", ["3944773451","6897036135","11886940987","4720994358","13827396231"])
c(46, "§2.1 Frequency: daily; x days per week (added ~April 2019); weekly and monthly; 'no need to set days' — free", "feature",
  "Flexible frequency — daily, x days per week (added ~Apr 2019 on request), weekly and monthly, 'no need to set days' — is free; flexible frequency praised in 13 (1.75%, mean 4.92)",
  "free", "praise", "13 (1.75%), mean 4.92", "build-free", "meaningful", "yes", ["3954949955","4462219747","5263624340","12356034152","13627360138"])
c(47, "§2.1 Back-filling past days; import of old data; long-press to mark yesterday — import listed as Premium in 2019", "feature",
  "Back-filling past days (night-shift use) and long-press to mark yesterday are free and praised (10, 1.35%, mean 4.90); import of old data was listed as Premium in 2019",
  "back-fill free; import Premium 2019", "praise", "10 (1.35%), mean 4.90", "build-free", "meaningful", "yes", ["3944773451","4497735688","10732085902","12073306064"])
c(48, "§2.1 Reminders: several per habit, per-week schedules — free; 'only 2 reminders without paying' (probably the habit cap)", "feature",
  "Reminders — several per habit ('3 reminders a day'), per-week schedules — are free and praised in 16 (2.15%, mean 4.69); one reviewer says 'only 2 reminders without paying' (probably the habit cap)",
  "free", "praise", "16 (2.15%), mean 4.69", "build-free", "meaningful", "yes", ["4455008126","4462219747","9730342132","12124114850"])
c(49, "§2.1 Notes per completed day — Paid", "feature",
  "Notes per completed day (from Dec 2019) are Premium ('the paid versions allow you to put notes in'); notes praised in 11 (1.48%, mean 4.91) and gated notes appear among the worst-rated 'have to pay' complaints",
  "paid", "mixed", "notes praised 11 (1.48%), mean 4.91", "undecided", "meaningful", "yes", ["5291008046","5653262510","6484426109","11810063518","8181313423","13605658579"])
c(50, "§2.1 Colours per habit (incl. hex code), emoji in titles, alternate app icons, dark mode — Paid in part: dark mode and app colour, colours", "feature",
  "Customisation — per-habit colours including a hex code, emoji in titles, alternate app icons, dark mode — is praised (32, 4.31%, mean 4.97) and partly Premium: dark mode and app colour (2019) and custom colours are paid ('Cant' use colours without paying' among the worst-rated gates)",
  "partly paid (dark mode, app colour, colours)", "mixed", "customisation praised 32 (4.31%), mean 4.97", "undecided", "very strong", "yes", ["5732133041","10801319167","13325880808","3413286186","4462219747","4497735688","13629525960","13919822858"])
c(51, "§2.1 Habit templates; archive; hide/show; reorder — free", "feature",
  "Habit templates, archive, hide/show and reorder are free",
  "free", "praise", "inventory", "build-free", "inventory", "yes", ["11306521525","12088715354","13325880808","6713570145"])
c(52, "§2.1 Share cards for social media — free (2021 'ready made posts for bragging')", "feature",
  "Share cards for social media (2021, 'ready made posts for bragging'; 'send screenshots of main grid to friends') are free and praised in 6 (0.81%, mean 5.00)",
  "free", "praise", "6 (0.81%), mean 5.00", "build-free", "emerging", "yes", ["7906994184","10032640576","14088036663"])
c(53, "§2.1 Local-first data: on the device / iCloud device backup; manual export/import (CSV); backup file — CSV export disabled in 2026; backup described as paid", "feature",
  "Local-first data — stored on the device ('my data isn't stored on a server'), iCloud device backup, manual CSV export/import and a backup file — with no account; privacy praised in 7 (0.94%, mean 4.29); CSV export was disabled in 2026 and backup described as paid",
  "local-first, no account; export disabled 2026", "mixed", "privacy 7 (0.94%), mean 4.29", "must-have", "emerging", "yes", ["4497735688","6791860731","3550808186","4122355171","11674162846","13731751322","12046497872"])
c(54, "§2.1 In-app 'in progress' roadmap list — free", "tactic",
  "An in-app 'in progress' roadmap list tells users what is coming and wins goodwill: 'I saw developer already listed it as incoming, this informing and communicative attitude was a huge plus for me'",
  "in-app roadmap", "praise", "2 reviews", "do", "weak", "yes", ["13247369835","13882752696"])
c(55, "§2.1 Not present — Apple Watch app; iPad, Mac or web app, and cross-device sync", "feature",
  "No Apple Watch app (requested 2021 → 2025; 6, 0.81%) and no iPad, Mac or web app or cross-device sync (8, 1.08%; 'I'd even pay for separate versions as long as they synced'); a watch / iPad / Mac / web / sync union of 18 (2.42%, mean 4.67); one departure was to an app with iPad and Mac apps",
  "absent", "complaint", "Watch 6 (0.81%); iPad/Mac/web 8 (1.08%); union 18 (2.42%), mean 4.67", "research", "meaningful", "yes",
  ["7044468569","13081471282","10581767784","11077980453","12188850466","12138400882","5975293048"])
c(56, "§2.1 Not present — iCloud / cloud sync", "feature",
  "No iCloud / cloud sync: 6 requests (0.81%, mean 4.67), one after losing data on a factory reset; no sync caused a problem for 3",
  "absent (local only)", "complaint", "6 (0.81%); no-sync problem 3", "must-have", "emerging", "yes", ["6729639375","7344582690","10187448442","12427980996"])
c(57, "§2.1 Not present — quantities / partial completion (8 of 10 glasses)", "feature",
  "No quantity / multiple-per-day / partial-completion habits: 11 requests (1.48%, mean 4.27) — push-ups, '5 bottles of water', 'twice a day', 'I Drank 80oz … I wanna be able to track that'",
  "absent", "complaint", "11 (1.48%), mean 4.27", "build-free", "meaningful", "yes", ["10088647035","13432208041","3233116539","12270557790"])
c(58, "§2.1 Not present — notes on days a habit was not done", "feature",
  "No notes on missed days, photos, or viewing a note from the calendar: 9 requests (1.21%, mean 4.44), e.g. a 'No Spend' habit",
  "absent", "complaint", "9 (1.21%), mean 4.44", "undecided", "meaningful", "yes", ["11400095925","13583853777","10965345926","9082639448","10569299689"])
c(59, "§2.1 Not present — bad-habit / quit mode, skip or sick day", "feature",
  "No bad-habit / quit mode (6, 0.81%; 'I'd rather not see TO DO next to bad habits') and no skip / pause / 'incomplete' or sick day (5, 0.67%; 'i am sick and cannot swim … i dont want to loose my results')",
  "absent", "complaint", "quit 6 (0.81%), mean 4.17; skip/pause 5 (0.67%), mean 4.40", "build-free", "emerging", "yes", ["11475674157","11872013641","4122355171","13827396231","11811674754"])
c(60, "§2.1 Not present — Apple Health", "feature",
  "No Apple Health integration: 2 requests (weak)", "absent", "complaint", "2", "research", "weak", "yes", ["6729639375","12150912789"])
c(61, "§2.1 Not present — Localisation: English only for most reviewers", "feature",
  "English-only UI for most reviewers ('Only english'): localisation requested in 19 (2.56%, mean 4.32)", "absent", "complaint", "19 (2.56%)", "build-free", "meaningful", "yes", ["11768720231","12121063578","13381269097"])
c(62, "§2.1 Not present — Complete a habit from the notification", "feature",
  "Cannot complete a habit from the notification: 2 requests", "absent", "complaint", "2", "build-free", "weak", "yes", ["10052127570","10100128513"])
# §2.2
c(63, "§2.2 Timeline of the business (verbatim table)", "timeline",
  "The business timeline reviewers lived: Jul 2018 launch (found via Reddit), 2 free habits, one-time Premium ~$5 → Dec 2018 'lifetime premium' wording → Apr 2019 weekly habits on request → Jul 2019 one-time $9, 'no subscription' → Oct 2019 subscription (£3.99/mo) → 2020 '$40 total', CA$7.99/mo, CA$19.99/yr, CA$55 once; Apr 2020 monthly view → iOS 14 widget requests from Oct 2020 → 2021 share cards, notifications stop after an update → Dec 2021 alternate icon stops changing (also 2023, 2024) → 28–30 Jun 2023 free-lifetime promotion burst → Jun 2023 – Jan 2024 Chinese / Russian / Ukrainian requests → Dec 2023 developer points to long-press → mid-Mar 2024 widgets ship (not interactive) → 10–11 Apr 2024 launch crash fixed a day later → Sep 2024 widget turns white with iOS 18 tint → Dec 2024 delete requires paid backup → Jun 2025 $9/mo, $20/yr, $40 lifetime, 3-day trial → Jul 2025 'Evoday' → Nov 2025 one-time option 'gone' → Dec 2025 50% offer £9.99/yr, reminder picker broken → Jan–Jul 2026 free tier 4 habits, €9.99–20/yr, 'only in Abo' → Feb 2026 CSV export disabled, 20–30 launches to load → Mar 2026 reminder only at current time → Jun–Jul 2026 lifetime 'wont be working' vs 'you only pay once'",
  "eight years of iterative change", "mixed", table("## 2.2 Timeline of the business"), "none", "corpus-level fact", "app-specific",
  ["2949637870","2953267303","3307938448","3503457494","3954949955","4462219747","4924456384","5526275566","6028222005","5755729025","6576140378","7906994184","6830197392","8172167468","10083799946","10084467787","10732085902","11062493236","11145404810","11740378083","12046497872","12738794859","12842151586","13392990758","13560914935","13505537432","13597043858","13731751322","13744408241","13868583107","14138883204","14284351778"])
c(64, "§2.2 Jul 2018 launch found via Reddit; found via Reddit / social / reviews 6 (0.81%, mean 5.00)", "tactic",
  "Launching through Reddit and word of mouth found the early users: the app was found via Reddit at launch (Jul 2018), and 6 reviews (0.81%, mean 5.00, 3.8% of E1) say they found it via Reddit, social media or reviews",
  "Reddit launch", "praise", "6 (0.81%), mean 5.00; E1 3.8%", "do", "emerging", "yes", ["2949637870"])
c(65, "§2.2 10–11 Apr 2024 update crashes on launch; fixed a day later", "timeline",
  "A launch crash fixed within a day did no visible lasting damage: the 10–11 Apr 2024 update crashed on launch ('after the April 10th 2024 update'; 'the 2024.4 update') and was fixed a day later; reliability union 6.7% of E4, then 2.6% of E5",
  "fast hotfix", "complaint", "crash 3 (weak); reliability E4 6.7% → E5 2.6%", "must-never-break", "weak", "yes", ["11145404810","11147450348"])
c(66, "§2.2 Sep 2024 widget turns white with iOS 18 tinted home screen; widget broken 5 (0.67%)", "must-never-break",
  "Widgets must render on every home-screen mode: in Sep 2024 the widget turned white with the iOS 18 tinted home screen, and widget rendering broke for 5 (0.67%, mean 3.40, 3.0% of E4); 'stunning but have some minor errors'",
  "widget rendering bugs", "complaint", "5 (0.67%), mean 3.40; E4 3.0%", "must-never-break", "emerging", "yes", ["11740378083","11138339931"])
c(67, "§2.2 Dec 2021 alternate app icon stops changing after an update (also 2023, 2024); 4 (0.54%)", "must-never-break",
  "An alternate app icon that stops changing after updates recurred three times (Dec 2021, 2023, 2024): 4 reviews (0.54%, mean 4.00)",
  "alternate icon broken repeatedly", "complaint", "4 (0.54%), mean 4.00", "must-never-break", "emerging", "app-specific", ["8172167468","10209615596","10781087412"])
c(68, "§2.2 2021 notifications stop firing after one update; reminders not firing / broken 5 (0.67%)", "must-never-break",
  "Reminders stop firing after updates: notifications stopped after one 2021 update, and reminders not firing / broken in 5 (0.67%, mean 3.40)",
  "reminder regressions", "complaint", "5 (0.67%), mean 3.40", "must-never-break", "emerging", "yes", ["6830197392","13505537432","13868583107"])
c(69, "§2.2 Feb 2026 app needs 20–30 launches to load", "must-never-break",
  "The app must open on the first launch: in Feb 2026 a reviewer had to open it 20–30 times to get it to load (rated 5★ nonetheless)",
  "load failure 2026", "complaint", "n=1", "must-never-break", "weak", "yes", ["13744408241"])
c(70, "§2.2 Jul 2025 name 'Evoday' appears; renamed four times on one app ID", "positioning",
  "The same app ID has carried four names — 'Habit Tracker' (2018), 'Super Habit(s)' (2020–23), 'Daily Habits' (2023–25), 'Evoday' (from Jul 2025) — without visible rating effect; reviewers keep using old names",
  "renames", "mixed", "report gives none", "research", "corpus-level fact", "app-specific", ["12842151586","5580664864","9667437355"])
# §2.3
c(71, "§2.3 The gate — habit count 2 from 2018 to 2025, reported as 4 in 2026; other Premium features: dark mode and app colour (2019), data import (2019), notes, custom colours, widgets (for some), backup", "monetization",
  "The free gate: habit count 2 from 2018 to 2025 (dozens of reviews), reported as 4 in 2026 ('Up to 4 habits was free'; '4 habits in free account') — the cap may have been raised or tested; other Premium features — dark mode and app colour (2019), data import (2019), notes, custom colours, widgets (for some users) and backup",
  "2 → 4 habits (2026?)", "complaint", "dozens; 2026 two reviews report 4", "product-rule", "corpus-level fact", "yes",
  ["2953267303","5353795347","9839460397","12902043009","13597043858","14316571521"], cond="2 vs 4 unresolved (storefront, version or A/B)")
c(72, "§2.3 Price ladder (verbatim table)", "monetization",
  "Price ladder per reviewers: 2018 – mid-2019 one-time $5 → $9, 'no subscription'; Oct 2019 – 2020 £3.99/month, '$40 total', CA$7.99/mo, CA$19.99/yr, CA$55 once, 'buy outright option'; 2021–23 monthly and annual, $40 lifetime, €10/month; 2024 $40 lifetime, $20/year, €9.99/month, 'half a hundred dollars' CA$ lifetime; 2025 $9/month, $20/year, $40 lifetime, 3-day trial, 50% off £9.99/yr, one-time option 'gone'; 2026 €9.99–€20/year, 'only in Abo', 'you only pay once', lifetime 'won't be working'",
  "one-time → subscription + lifetime", "mixed", table("| Period | What an upgrade cost"), "research", "corpus-level fact", "app-specific",
  ["2953267303","3307938448","4462219747","4497735688","4924456384","5526275566","6028222005","6515336308","6831122754","6884995801","9342516160","9459937898","9607739351","10795711876","10904298957","11121787202","11554013205","11580982926","12738794859","13560914935","13392990758","13597043858","13600419608","13740072982","14284351778","14138883204"])
c(73, "§2.3 Interpretation — entry price moved from a $5–9 one-off to ~$20 a year or ~$40 once with a ~$9 monthly; the lifetime option is valued: 15 reviews (mean 4.87)", "monetization",
  "Keep a lifetime option: the entry price moved from a $5–9 one-off (2018–19) to ~$20 a year or ~$40 once with a ~$9 monthly, and the lifetime option is valued — 15 reviews praise one-time / lifetime pricing (2.02%, mean 4.87; 7.5% of E1) — 'not a lot of apps offer this'; 'you only pay once which is refreshing in the current year'",
  "lifetime ~$40 beside subscriptions", "purchase-driver", "15 (2.02%), mean 4.87", "build-paid", "meaningful", "yes", ["12625098281","14284351778","11286612018","11583264179"])
c(74, "§2.3 Interpretation — reviewers disagree whether lifetime is still sold (Nov 2025 'gone', Feb 2026 'only subscription', Jul 2026 'pay once')", "contradiction",
  "Reviewers disagree about whether lifetime is still sold — Nov 2025 'gone', Feb 2026 'only subscription' ('leider nur im Abo'), Jul 2026 'pay once' — possibly a storefront or experiment difference; plan availability that differs by user reads as removal",
  "lifetime availability inconsistent", "mixed", "3 dated reviews", "research", "limited evidence", "yes", ["13392990758","13740072982","14284351778"])
c(75, "§2.3 Interpretation — the trial is inconsistent: 'no free trial' (2022, 2024, 2026) vs 'the free trial lasts only 3 days' (2025)", "contradiction",
  "The trial is inconsistent: 'no free trial' in 2022, 2024 and 2026 vs 'the free trial lasts only 3 days' in 2025",
  "trial inconsistent", "blocked-conversion", "4 dated reviews", "research", "limited evidence", "yes", ["9342516160","11939700468","13827396231","12738794859"])
c(76, "§2.3 Dec 2025 50% offer £9.99/year", "tactic",
  "A 50% discount offer (£9.99/year, Dec 2025) appears around New Year; a discount is mentioned in 1 review — no outcome measurable",
  "seasonal discount", "mixed", "1 (weak)", "research", "weak", "yes", ["13560914935"])
# §2.4
c(77, "§2.4 Responsive and personal — 52 praise the developer; 31 name 'Kevin'; features built on request; visible replies that changed ratings", "tactic",
  "Outcome of replying to reviews and building requested features: visible developer replies changed ratings ('Updated to 4 stars - thank you devs for the response!'; 'I appreciate the thorough response'), features were built on request (weekly habits; a German reviewer's suggestion; 'He promised to integrate this feature and let me know as soon as it's released'), and 31 reviews name the developer 'Kevin' (4.17%, mean 4.77)",
  "named solo developer replies and ships requests", "praise", "developer praise 52 (7.00%), mean 4.96; 'Kevin' 31 (4.17%), mean 4.77", "do", "high-priority", "yes",
  ["10732085902","11077980453","3954949955","8400091910","6393157189"])
c(78, "§2.4 Signals reviewers find troubling — onboarding promotions: 'Too many promo on start up, not clear how to mark first day'", "dont",
  "Do not open with promotions before the user has marked a first day: 'Too many promo on start up, not clear how to mark first day'",
  "onboarding promos", "complaint", "n=1", "dont", "weak", "yes", ["13288687749"])
c(79, "§2.4 Signals reviewers find troubling — upgrade nagging (4, 0.54%, mean 2.00)", "dont",
  "Do not nag free users who do not need Premium: upgrade nagging / promo pop-ups 4 reviews (0.54%, mean 2.00) — 'constantly being nagged to upgrade to premium. I only track one thing'; 'Very annoying pop ups asking you to upgrade'",
  "upgrade pop-ups", "complaint", "4 (0.54%), mean 2.00", "dont", "emerging", "yes", ["7879946381","8233664049"])
c(80, "§2.4 Signals reviewers find troubling — support doesn't respond to emails (single report)", "must-have",
  "Answer support e-mail: a single report says 'Support doesn't respond to emails' in an app whose main asset is a responsive developer; support contact positive in 7 (0.94%, mean 4.57)",
  "support mostly responsive", "complaint", "unresponsive 1; positive 7 (0.94%), mean 4.57", "must-have", "weak", "yes", ["10904298957"])

# §3.1
c(81, "§3.1 Complete ranked theme table (verbatim), 74 themes + weak row", "data-caveat", "Master theme table, denominator 743", "n/a", "mixed", table("## 3.1 Complete ranked theme table"), "none", "corpus-level fact", "app-specific", [])
T = [
 (82,"#4 Unmet needs — all requests (union)","insight","Requesters are mostly happy: unmet needs (all requests) 113 (15.21%, high-priority), mean 4.48; 54.5% of all 4★ carry a request — requests are what separate 4★ from 5★","113 (15.21%), mean 4.48; 64 5★; E1 26.4%","build-free","mixed"),
 (83,"#8 Helps build / track habits","insight","'Helps build / track habits' 95 (12.79%, mean 4.98), falling from 24.5% of E1 to 6.0% of E4 as praise shifted to 'beautiful and best'","95 (12.79%), mean 4.98; E1 24.5 → E4 6.0 → E5 9.1","none","praise"),
 (84,"#10 Generic only","data-caveat","Generic-only reviews (no specific theme) 71 (9.56%), mean 4.82 — rise from 1.9% of E1 to ~11% of E3–E4","71 (9.56%), mean 4.82","none","praise"),
 (85,"#11 Monetisation positive (union)","monetization","Positive monetisation 64 (8.61%, mean 4.91): 34 price fair, 15 lifetime praised, 17 free tier enough, 12 accept / defend the cap","64 (8.61%), mean 4.91; E1 13.2%","none","praise"),
 (86,"#14 Motivating / accountability","insight","Motivating / accountability praised 46 (6.19%, mean 4.96)","46 (6.19%), mean 4.96","build-free","praise"),
 (87,"#17 Concrete life outcome","insight","Concrete life outcomes 35 (4.71%, mean 4.94): diabetic weight loss 'finally got under 200 pounds', '26 days off sugar', 'helped me quit smoking', 25-day water streak, songwriting 5-week streak, London lockdowns","35 (4.71%), mean 4.94; US 7.2 vs non-US 3.3","none","praise"),
 (88,"#18 Price fair / worth it","monetization","Price fair / worth it 34 (4.58%, mean 4.91), 9.4% of E1, US 6.8% vs 3.3%","34 (4.58%), mean 4.91","build-paid","praise"),
 (89,"#22 Streak / don't-break-the-chain praised","feature","Streak / don't-break-the-chain praised 27 (3.63%, mean 4.93) — 'Don't Break The Chain only makes sense if you can actually see your chain!'","27 (3.63%), mean 4.93; E3 0.0","build-free","praise"),
 (90,"#25 Reliability (union)","insight","Reliability problems are rare and forgiven: reliability union 24 (3.23%, mean 3.75, 3 1★), 7.5% of E1, 6.7% of E4 (the Apr 2024 spike), 2.6% of E5 — bugs are reported politely, often at 4–5★","24 (3.23%), mean 3.75; E1 7.5 E4 6.7 E5 2.6","must-never-break","mixed"),
 (91,"#28 Long-term user (≥ 1 year stated)","insight","Long-term users (≥ 1 year stated) 17 (2.29%) all rate 5.00","17 (2.29%), mean 5.00","none","praise"),
 (92,"#29 Free tier sufficient / 'it's free'","monetization","Free tier sufficient / 'it's free' 17 (2.29%, mean 5.00) — some users only ever need two habits","17 (2.29%), mean 5.00","none","praise"),
 (93,"#32 Explicit churn / intent to leave","insight","Explicit churn / intent to leave 14 (1.88%, mean 2.21, 5 1★), 3.9% of E5, US 3.4% vs 1.0% — the review is the exit interview","14 (1.88%), mean 2.21; E5 3.9; US 3.4 vs 1.0","none","churn"),
 (94,"#33 Request: more statistics / overviews","feature","More statistics / overviews requested 14 (1.88%, mean 4.64): month %, all habits in one grid, counts ('percentage by month'); statistics praised 11 (1.48%, mean 4.55)","request 14 (1.88%); praise 11 (1.48%)","build-free","complaint"),
 (95,"#35 Free cap accepted / defended","insight","Free cap accepted / defended 12 (1.62%, mean 4.92) — 'The 2 habit cap is actually well thought out. It stops me from overdoing the habits'; 'I understand why more than two habits is premium, as app developers need money, too'","12 (1.62%), mean 4.92","none","praise"),
 (96,"#41 An update improved it","insight","'An update improved it' 10 (1.35%, all 5★)","10 (1.35%), mean 5.00","none","praise"),
 (97,"#42 Conditional purchase intent","monetization","Conditional purchase intent 10 (1.35%, mean 4.40) — would buy if a named feature or price existed ('If I was paying, this app would be amazing')","10 (1.35%), mean 4.40","research","blocked-conversion"),
 (98,"#43 Data & entitlement trust (union)","must-never-break","Data & entitlement trust union 10 (1.35%, mean 2.80, 3 1★): data lock-in, lifetime removed / not honoured, entitlement lost, data lost","10 (1.35%), mean 2.80","must-never-break","complaint"),
 (99,"#46 Replaced paper / bullet journal","positioning","Replaced paper / bullet journal 7 (0.94%, mean 4.86) — 'I was drawing habit tables by hand'","7 (0.94%), mean 4.86","none","praise"),
 (100,"#51 Request: scheduling options","feature","Scheduling options requested 7 (0.94%, mean 4.43): every other day, monthly targets","7 (0.94%), mean 4.43; E1 5.7","build-free","complaint"),
 (101,"#52/#60 Regression (union) / an update broke something","must-never-break","Regressions (update broke / feature removed) 7 (0.94%, mean 4.29); an update broke something 6 (0.81%, mean 4.83)","7 (0.94%), mean 4.29; 6 (0.81%), mean 4.83","must-never-break","complaint"),
 (102,"#55 Confusing / hard to use","dont","Confusing / hard to use 6 (0.81%, mean 1.67, 4 1★): onboarding promos, hidden gestures, low contrast in dark mode","6 (0.81%), mean 1.67","dont","complaint"),
 (103,"#59 Request: easier past-date editing / day start after midnight","feature","Easier past-date editing and a day start after midnight 6 (0.81%, mean 4.50) — 'My day always ends after midnight' (Habitica's day-start setting cited); edit from the calendar view","6 (0.81%), mean 4.50","build-free","complaint"),
 (104,"#63 Free-lifetime promotion mentioned","data-caveat","Free-lifetime promotion mentioned 5 (0.67%, mean 4.20), 2.6% of E3","5 (0.67%), mean 4.20","none","mixed"),
 (105,"#68 Request: badges / celebration / sounds","feature","Badges, celebration, sounds requested 5 (0.67%, mean 4.80) — a 'celebration' when all habits are done","5 (0.67%), mean 4.80","undecided","complaint"),
 (106,"#69 Objection to subscriptions as a model","monetization","Objection to subscriptions as a model 4 (0.54%, mean 3.25) — 'leider nur im Abo'","4 (0.54%), mean 3.25","build-paid","complaint"),
 (107,"#71 Cannot afford","audience","Cannot afford 4 (0.54%, mean 4.00): 'broke college student', Vietnam, ADHD 'I don't have the money', 'can't wait til I can budget enough'","4 (0.54%), mean 4.00","research","blocked-conversion"),
 (108,"#72 Data / history lost","must-never-break","Data / history lost 4 (0.54%, mean 3.50), including 5★ 'Lost all data' and loss after a factory reset without sync","4 (0.54%), mean 3.50","must-never-break","complaint"),
 (109,"#74 Gibberish / off-topic","data-caveat","Gibberish / off-topic 4 (0.54%, mean 4.00)","4 (0.54%)","none","mixed"),
]
for seq, w, kind, claim, mag, d, react in T:
    c(seq, f"§3.1 theme table {w}", kind, claim, "see §3.1", react, mag, d, "theme-table signal", "yes", [])
c(110, "§3.1 theme table weak rows (n = 1–3) — limit not disclosed 3 (2.33); no sync caused a problem 3; crash 3; other bug 3; review prompt 3; too basic 3 (1.67); student/child 3; haptics 3; themes request 3; export/Shortcuts request 3; neutral 3; lifetime removed/not honoured 2 (2.50); data lock-in 2 (1.00); complete-from-notification 2; reminder improvements 2; Health 2; categories 2; medical/recovery use 2; entitlement lost 1; refund 1; feature removed 1; promo failed 1; discount 1; renewal 1; fixed 1; low contrast 1; support unresponsive 1; friends sharing 1; religious use 1", "data-caveat",
  "Weak rows (n = 1–3, 0.13–0.40%): limit not disclosed 3 (mean 2.33); no sync caused a problem 3; crash 3; other bug 3; review prompt 3; too basic 3 (mean 1.67); student/child 3; haptics 3; themes request 3; export/Shortcuts request 3; neutral 3; lifetime removed/not honoured 2 (2.50); data lock-in 2 (1.00); complete-from-notification 2; reminder improvements 2; Health 2; categories 2; medical/recovery use 2; entitlement lost 1; refund 1; feature removed 1; promo failed 1; discount 1; renewal 1; fixed 1; low contrast 1; support unresponsive 1; friends sharing 1; religious use 1",
  "see §3.1", "mixed", "≤3 each, ≤0.40%", "none", "weak", "yes", [])
c(111, "§3.1 Positive themes restricted to reviews rated 4–5★ — simplicity 273 (36.74%) · design 156 (21.00%) · 'best' 107 (14.40%) · year grid / calendar 104 (14.00%) · competitor comparison 95 (12.79%) · utility 95 (12.79%) · developer 52 (7.00%) · motivation 46 (6.19%) · life outcome 35 (4.71%) · price fair 33 (4.44%) · customisation 32 (4.31%) · streak 27 (3.63%) · widgets 24 (3.23%)", "data-caveat",
  "Positive themes restricted to 4–5★: simplicity 273 (36.74%) · design 156 (21.00%) · 'best' 107 (14.40%) · year grid / calendar 104 (14.00%) · competitor comparison 95 (12.79%) · utility 95 (12.79%) · developer 52 (7.00%) · motivation 46 (6.19%) · life outcome 35 (4.71%) · price fair 33 (4.44%) · customisation 32 (4.31%) · streak 27 (3.63%) · widgets 24 (3.23%)",
  "n/a", "praise", "as stated", "none", "corpus-level fact", "yes", [])
c(112, "§3.1 Kept despite small counts — data lock-in (2, both 1★): data-exit restrictions carry legal and trust consequences out of proportion to their count; lifetime entitlement (2) concerns paid entitlement", "product-rule",
  "Data-exit restrictions and lifetime entitlement are kept despite n = 2 each because of their nature: data lock-in (2, both 1★, mean 1.00) carries legal and trust consequences out of proportion to its count; lifetime entitlement disputes (2, mean 2.50) concern paid entitlement",
  "export disabled; backup gated; lifetime disputes", "churn", "lock-in 2 (1.00, 100% 1★); lifetime 2 (2.50)", "product-rule", "kept despite small counts", "yes",
  ["12046497872","13731751322","13392990758","14138883204"])
# §3.2
c(113, "§3.2 The findings with the worst rating profile (verbatim table)", "data-caveat", "Themes with n ≥ 3 ranked by mean rating, with % 1★ and why it matters", "n/a", "mixed", table("## 3.2 The findings with the worst rating profile"), "none", "corpus-level fact", "app-specific",
  ["13731751322","12760639157","13605658579","10828741313","13288687749","10732085902","10630623535","6028222005","7879946381"])
c(114, "§3.2 Data lock-in — 'forced to keep paying … if you don't want to lose all your history'", "product-rule",
  "Never make data exit a reason to keep paying: data lock-in (export disabled, backup gated) — 2 reviews at mean 1.00, 100% 1★ — 'forced to keep paying … if you don't want to lose all your history'",
  "export disabled, backup gated", "churn", "2, mean 1.00, 100% 1★", "product-rule", "kept despite small count", "yes", ["13731751322","12046497872"])
c(115, "§3.2 Other gated feature — widgets, notes and colours behind the paywall read as 'pay to use it' ('Horrível tem que pagar'); 72.7% 1★", "product-rule",
  "Everyday features behind the paywall read as 'pay to use it': other gated features (widgets, notes, colours) 11 reviews, mean 1.55, 72.7% 1★ — 'Horrível tem que pagar' ('Horrible, you have to pay') — worse than the cap itself (2.44)",
  "widgets / notes / colours paid", "complaint", "11, mean 1.55, 72.7% 1★ (vs cap 2.44, 38.5%)", "product-rule", "meaningful", "yes", ["12760639157","13605658579","10828741313"])
c(116, "§3.2 Too basic 3 (1.67, 66.7% 1★) — 'such a basic system that i can so easily replicate on my agenda'", "insight",
  "'Too basic' is a price objection from a paywalled user: 3 reviews, mean 1.67, 66.7% 1★ — 'such a basic system that i can so easily replicate on my agenda'",
  "simple app with paywall", "complaint", "3, mean 1.67", "none", "weak", "yes", ["6028222005"])
c(117, "§3.2 Low contrast in dark mode", "feature",
  "Low contrast in dark mode makes the app confusing for some (1 review, within confusing / hard to use at mean 1.67)",
  "dark mode contrast", "complaint", "1", "must-have", "weak", "yes", ["10630623535"])
c(118, "§3.2 Interpretation — the low end is almost entirely about access; reliability rare (3.23%) and forgiven (3.75): 'the product rarely breaks; the business model is what users push back on'", "insight",
  "The low end of the distribution is almost entirely about access — blocked by the paywall, not told about it, unable to try, unable to take data out; reliability problems are rare (3.23%) and forgiven (mean 3.75, the mildest negative, bugs reported politely often at 4–5★) — the product rarely breaks, the business model is what users push back on",
  "reliable app, strict paywall", "complaint", "access themes 1.00–3.16 vs reliability 3.75", "product-rule", "interpretation", "yes", [])
# §3.3
c(119, "§3.3 Reading the monetisation objection correctly (verbatim table) — evaluation plurality; disclosure small, sharp; trial E5-heavy; value steady; affordability small; feature gates E5-heavy; model small", "insight",
  "The 78 friction reviews make seven different arguments (manual, overlapping split): 'two habits is too few to judge the app' (evaluation) is the plurality ('Give the user 21 days of all bells and whistles … Once you hook them on, charge them'; 'at least five'); 'you didn't tell me' (disclosure) small and sharp ('I searched for free apps and this one came up'; 'I just wish it was said earlier (for example, here)'); 'let me try it first' (trial) E5-heavy ('a pity you can't preview … before buying'; '40$ … seriously without trying the app'); 'too expensive for what it is' steady ($40 vs an indie game; £3.99/month vs Netflix £7.99; €9.99/month 'completely of the charts'); 'I can't afford it' small; 'don't gate the basics' E5-heavy (widgets, notes, colours, backup); 'not another subscription' small",
  "2-habit cap", "complaint", table("## 3.3 Reading the monetisation objection correctly"), "product-rule", "qualitative split", "yes",
  ["2953267303","9899413299","10904298957","12154681308","13036244176","11348148556","12233797625","10455939599","3850157156","11939700468","13702002766","13827396231","12738794859","9342516160","11554013205","4924456384","6028222005","11121787202","9607739351","10795711876","11097867630","12221998930","6836775244","12760639157","13605658579","13629525960","12046497872","13740072982","10854224657"])
c(120, "§3.3 'Give the user 21 days of all bells and whistles … Once you hook them on, charge them' (2018)", "monetization",
  "A reviewer proposes the trial design directly: 'Give the user 21 days of all bells and whistles … Once you hook them on, charge them' (2018) — a habit-length full trial instead of a 2-habit wall",
  "no full trial", "blocked-conversion", "n=1 quote", "build-paid", "anecdotal", "yes", ["2953267303"])
c(121, "§3.3 'I searched for free apps and this one came up'; 'I just wish it was said earlier (for example, here)'; 'I got this because it was free'", "do",
  "Say in the store listing that the app is limited-free: users arrive from 'free app' searches ('I searched for free apps and this one came up'; 'I got this because it was free') and ask for the limit to be stated 'earlier (for example, here)' — i.e. on the App Store page",
  "limit not in listing", "complaint", "4 quotes (disclosure argument)", "do", "small, sharp", "yes", ["12233797625","10455939599","3850157156","11348148556"])
c(122, "§3.3 Against these sit 64 positive monetisation reviews (mean 4.91); 'The 2 habit cap is actually well thought out'; HabitKit comparison", "contradiction",
  "The same 2-habit cap is defended by others: 64 positive monetisation reviews (mean 4.91) — 'The 2 habit cap is actually well thought out. It stops me from overdoing the habits'; 'I understand why more than two habits is premium'; 'HabitKit … too many limitations on the free version. With Evoday, you can track two activities … and still have some access to widgets'",
  "2-habit cap", "praise", "64 (mean 4.91); cap defended 12", "undecided", "meaningful", "yes", ["9212886099","6836775244","13467704260"],
  cond="cap tolerated when disclosed and when the user tracks few habits")
c(123, "§3.3 Interpretation — what turns a free user into a 1★ is hitting the wall without warning, with no way to evaluate the paid product, and seeing everyday features (widgets, colours, notes) behind it", "product-rule",
  "The cap itself is tolerated by many; what turns a free user into a 1★ is hitting the wall without warning, with no way to evaluate the paid product, and seeing everyday features (widgets, colours, notes) behind it",
  "2-habit cap, gated extras, inconsistent trial", "1★-burst", "friction 78 → 75.7% of 1★", "product-rule", "interpretation", "yes", [])
# §3.4
c(124, "§3.4 What the product genuinely does well (verbatim table)", "data-caveat", "Strengths with 4–5★ counts and evidence", "n/a", "praise", table("## 3.4 What the product genuinely does well"), "none", "corpus-level fact", "app-specific", [])
c(125, "§3.4 Simple, uncluttered, fast to log 273 — 'no busy visuals, no hokey games'; 'Forget cutesy interfaces, overuse of emojis'; 'too many bells and whistles and I get decision fatigue'", "positioning",
  "Positioned against gamified and cute rivals: simple, uncluttered, fast to log is praised by 273 at 4–5★ — 'no busy visuals, no hokey games'; 'Forget cutesy interfaces, overuse of emojis'; 'Some other apps have too many bells and whistles and I get decision fatigue'",
  "minimal", "praise", "273 (4–5★)", "product-rule", "high-priority", "yes", ["5483779509","6713570145","11286612018","11257213711"])
c(126, "§3.4 Calm, native-feeling design 156 — 'Feels like it was made by Apple'; 'Native iOS gem'; 'The whole app just feels calm and clear'", "insight",
  "A calm, native-feeling iOS design is praised by 156 at 4–5★ — 'Feels like it was made by Apple'; 'Native iOS gem'; 'The whole app just feels calm and clear'",
  "native iOS look", "praise", "156 (4–5★); design 166 (22.34%), mean 4.77", "build-free", "high-priority", "yes", ["9459813565","11298677390","10327221465"])
c(127, "§3.4 The year grid / calendar — the differentiator: 'Don't Break The Chain only makes sense if you can actually see your chain!'; 'Much more useful than only knowing your longest streak'; 'You can spot patterns you didn't realize existed'", "insight",
  "Why the year grid works: seeing the whole chain beats a streak number — 'Don't Break The Chain only makes sense if you can actually see your chain!'; 'Much more useful than only knowing your longest streak'; 'see my daily efforts as a part of the big picture of my life'; 'You can spot patterns you didn't realize existed' (104 at 4–5★)",
  "year heatmap free", "praise", "104 (4–5★)", "build-free", "high-priority", "yes", ["6886056651","9580051830","11682869403","14284351778"])
c(128, "§3.4 Neurodivergent users 5 — 'apps designed specifically for ADHD … too detailed … This app is simple with just the right amount of detail'; 'MUST. FILL. BOXES.'", "audience",
  "ADHD users prefer a simple general tracker over ADHD-specific apps: 5 self-identified (0.67%, mean 4.40) — 'apps designed specifically for ADHD … too detailed … This app is simple with just the right amount of detail'; 'MUST. FILL. BOXES.' — while one ADHD user cannot afford Premium",
  "simple tracker", "praise", "5 (0.67%), mean 4.40", "build-free", "emerging", "yes", ["10858613272","13882752696","7196952603","10335392591","12221998930"])
# §3.5
c(129, "§3.5 Unmet needs table (verbatim) — requests 113 (15.21%, mean 4.48; 54.5% of all 4★)", "data-caveat", "Requests where the capability did not exist for that reviewer", "n/a", "complaint", table("**Requests — the capability did not exist"), "none", "corpus-level fact", "app-specific",
  ["6576140378","10552434405","10611037724","10637884382","11412519740","12450993343","13731564617","14516919955","3944773451","8746143988","10760628732","12464367645","12471035847","3233116539","10088647035","12270557790","13432208041","10965345926","11400095925","13583853777","9082639448","10569299689","3307938448","10581767784","11077980453","12188850466","3232869436","8674756630","11802277055","7044468569","11310906473","12106386358","13081471282","6729639375","7344582690","10187448442","12427980996","4122355171","11475674157","13827396231","13559189439","11872013641","11811674754","10033720467"])
c(130, "§3.5 Broken — alternate app icon (4), widget rendering (5), reminders (5), launch crashes (3), Shortcuts, template name in notifications", "must-never-break",
  "Broken capabilities (existed, then stopped): alternate app icon (4), widget rendering (5), reminders (5), launch crashes (3), Shortcuts (1), template name in notifications (1)",
  "various regressions", "complaint", "4 / 5 / 5 / 3 / 1 / 1", "must-never-break", "emerging", "yes", ["11817893086","12088715354"])
c(131, "§3.5 Misunderstandings — long-press to mark yesterday ('That solves 90% of the struggle'); 'No widgets!!' two months after widgets shipped; 'not clear how to mark first day'", "insight",
  "Hidden gestures and paywalled surfaces look like missing features: a reviewer asked for an easier way to mark yesterday and the developer pointed to the existing long-press ('That solves 90% of the struggle'); 'No widgets!!' (May 2024) two months after widgets shipped — either the paywall or discoverability; 'not clear how to mark first day'",
  "undiscoverable gestures", "complaint", "4 reviews", "do", "weak", "yes", ["10732085902","11266485331","9918184824","13288687749"])
c(132, "§3.5 A real split in demand — five ask for more gamification while many praise its absence; any gamification should be optional", "contradiction",
  "Gamification demand is split: five reviewers ask for more gamification while many praise its absence ('I don't need gamification'; 'no hokey games') — any gamification should be optional",
  "no gamification", "mixed", "5 requests vs many praising absence", "product-rule", "interpretation", "yes", ["5389230957","7660503998","10128198936","6713570145"])
# §3.6
c(133, "§3.6 Competitors named — 98 (13.19%, mean 4.85, 89 5★); arrivals from Streaks, Ladder, HabitKit, a tracker that stopped working, ADHD apps, paper", "positioning",
  "This app is overwhelmingly the destination: arrivals from Streaks ('Switching to Super Habit feels like a breath of fresh air'), Ladder, HabitKit (too limited free), a tracker 'that stopped working', ADHD-specific apps, bullet journals and paper (7); departures only a handful — to an app with more free habits, to one with iPad and Mac apps, 'another one worked best for me', 'on the hunt for another'",
  "destination", "praise", "98 (13.19%), mean 4.85, 89 5★", "none", "high-priority", "yes",
  ["6886056651","7672593618","12362414599","13467704260","10791117607","10858613272","12108620259","11077980453","12887838325","12221998930"])
c(134, "§3.6 Reference points — Atomic Habits, the Seinfeld 'don't break the chain' method, #100DaysOfCode, the GitHub contribution graph, Habitica's day-start setting", "positioning",
  "The mental models reviewers bring: Atomic Habits, the Seinfeld 'don't break the chain' method, #100DaysOfCode, the GitHub contribution graph, and Habitica's day-start setting",
  "n/a", "praise", "report gives none", "none", "qualitative", "yes", ["10100128513","13462278457","5242717566","5354055938","6662280821","14284351778","9082639448"])
save("a")
