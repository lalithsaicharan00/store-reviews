"""Cards for report 34 — Part 7 (US), Part 8 (trends), Part 9 (competitor lessons), Part 10 (implications)."""
import sys; sys.path.insert(0, "Tools/prd_ledger/34")
from _lib import c, table, save

# Part 7
c(176, "§7.1 Eligibility and scope — only the US clears 50 (265, 35.7%); the only country section is the US per the owner; high-spend and high-review-volume market groups not produced at the owner's request", "data-caveat",
  "Country scope: only the US clears the 50-review threshold (265 of 743, 35.7%); next gb 34, ca 33, in 32, de 26; all 478 non-US reviews (75 storefronts) used as one comparison group, no standalone conclusions for other storefronts; high-spend and high-review-volume market groups not produced at the owner's request (the latter would be the US alone)",
  "n/a", "mixed", "US 265 (35.7%); non-US 478 / 75 storefronts", "none", "eligibility", "app-specific", [])
c(177, "§7.2 United States — ratings 5★ 210 (79.2%) · 4★ 27 · 3★ 11 · 2★ 5 · 1★ 12 (4.5%); non-US mean 4.582, 5★ 79.7%, 1★ 5.2%; US reviews longer (short 10.9% vs 19.5%); only 6 of the 27 burst reviews from the US; by era table (verbatim)", "market",
  "US ratings and composition: 5★ 210 (79.2%), 4★ 27 (10.2%), 3★ 11 (4.2%), 2★ 5 (1.9%), 1★ 12 (4.5%), mean 4.577 vs non-US 4.582 (5★ 79.7%, 1★ 5.2%); US reviews are longer (short 10.9% vs 19.5%); only 6 of the 27 June-2023 burst reviews are US; by era US / non-US mean — E1 4.31 / 4.74 (the first cap and data-loss reviews), E2 4.73 / 4.70, E3 4.64 / 4.62, E4 4.49 / 4.53, E5 4.43 / 4.38 — the same downward drift",
  "n/a", "mixed", table("**By era:**"), "none", "US standalone", "app-specific", ["2953267303","3850157156","3959889582","4968235247"])
c(178, "§7.2 US themes vs non-US (verbatim table)", "market",
  "US themes (265) vs non-US (478): competitor named 19.62% vs 9.62% (2×); 'best' 18.87% vs 11.92%; year grid 17.74% vs 12.13%; monetisation positive 12.08% vs 6.69%; explicit payer 9.06% vs 5.65%; customisation 7.92% vs 2.30% (3.4×); friction 7.92% (mean 2.29) vs 11.92% — lower in the US; life outcome 7.17% vs 3.35%; price fair 6.79% vs 3.35%; streak 6.42% vs 2.09% (3×); reminders praised 4.53% vs 0.84% (5×); free cap 3.77% (mean 2.00) vs 6.07% — lower share, harsher mean; explicit churn 3.40% vs 1.05% (3×); one-time / lifetime praised 3.02% vs 1.46%; watch/iPad/Mac/sync 3.02% vs 2.09%; back-fill praise 2.64% vs 0.63%; no trial 1.51% (mean 2.00) vs 0.63%; localisation 1.13% vs 3.35%; data lost 1.13% vs 0.21% (anecdotal n=3); n < 5 anecdotal",
  "n/a", "mixed", table("**US themes, with US signal labels"), "research", "US standalone", "app-specific", [])
c(179, "§7.2 What is distinctive about the US #1 — a comparison-shopping market: one US review in five names rivals or says it tried many (4.81 mean) — 'I've tried every unit tracker and even subscribed to them all, and this is the best one'", "market",
  "US is a comparison-shopping market: one US review in five names rivals or says it tried many, as 4.81-mean verdicts — 'I've tried every unit tracker and even subscribed to them all, and this is the best one'; 'I downloaded (and eventually deleted) several habit tracking apps'; 'i've tried a million different habit tracker apps'",
  "n/a", "praise", "52 (19.62%), mean 4.81", "none", "US high-priority", "yes", ["10653375848","10773056833","10890223306"])
c(180, "§7.2 US #2 — US reviewers explain the mechanism: streak and year-grid praise 3× and 1.5× non-US, often with a method (Don't Break The Chain, Seinfeld, GitHub commits, '80% consistent')", "market",
  "US reviewers explain the mechanism: streak praise 3× and year-grid praise 1.5× the non-US rate, often citing a method — 'Don't Break The Chain', Seinfeld, GitHub commits, '80% consistent'",
  "n/a", "praise", "streak 6.42 vs 2.09; year grid 17.74 vs 12.13", "none", "US high-priority", "yes", ["6886056651","5242717566","14284351778","8746143988"])
c(181, "§7.2 US #3 — US reviewers pay and say so: 24 explicit payers, mean 4.71 ('More than SIX years using this app')", "market",
  "US reviewers pay and say so: 24 explicit payers (9.06%), mean 4.71 — 'More than SIX years using this app'",
  "n/a", "purchase-driver", "24 (9.06%), mean 4.71", "none", "US high-priority", "yes", ["3307938448","4462219747","4497735688","10791117607","11286612018","13881561697","13919822858"])
c(182, "§7.2 US #4 — less wall friction, but when it hits, they leave: 9 of the 14 explicit churn reviews are from the US", "market",
  "In the US the wall hits less often but ends in departure: friction 7.92% (vs 11.92%), yet 9 of the 14 explicit churn reviews are US — the cap (2), another app with more free habits, ADHD can't afford, $9/$20/$40 with a 3-day trial, no iPad/Mac, another app suited better, reminders, calendar editing",
  "n/a", "churn", "9 of 14 churn (US 3.40% vs 1.05%)", "research", "US very strong", "yes",
  ["2953267303","3850157156","12108620259","12221998930","12738794859","11077980453","12887838325","13505537432","13559189439"])
c(183, "§7.2 US #5 — the sharpest disclosure and trial complaints are US reviews", "market",
  "The sharpest disclosure and trial complaints come from US reviewers",
  "n/a", "complaint", "4 reviews; no trial US 1.51% (mean 2.00) vs 0.63%", "do", "US meaningful (anecdotal n<5)", "yes", ["11348148556","12233797625","11939700468","12738794859"])
c(184, "§7.2 US by star band — 1★ (12): cap 4, gated features 3, trial, data loss, reminders (payer), promotion 'scam', gibberish; 2★ (5); 3★ (11); 4★ (27): requests 18 of 27 (66.7%) — notes on missed days, quantities, Mac/iPad, actionable notifications, past-date editing", "market",
  "US by star band: 1★ (12) — cap 4, gated features 3, trial 1, data loss 1, reminders 1 (a payer), the promotion 'scam' 1, gibberish 1; 2★ (5) — nagging, Shortcuts, cap/churn 2, price; 3★ (11) — mostly price or cap, disclosure, data loss, reminders, rating prompt, gated colours; 4★ (27) — requests 18 of 27 (66.7%): notes on missed days, quantities, Mac/iPad, actionable notifications, past-date editing",
  "n/a", "mixed", "1★ 12; 2★ 5; 3★ 11; 4★ 27 (requests 66.7%)", "none", "US standalone (small bands)", "app-specific",
  ["2953267303","3850157156","11348148556","13036244176","3959889582","6433058881","14415373834","11939700468","4968235247","5535050975","10087293260","7920968910","7879946381","11817893086","12108620259","12221998930","12738794859","5526275566","11554013205","12124114850","12233797625","10781087412","13505537432","13586879451","13629525960","13583853777","13432208041","11077980453","10052127570","10100128513","10732085902","13559189439"])
c(185, "§7.2 US 1★ — 'the promotion scam': free-lifetime promotion did not deliver for a US reviewer", "anti-pattern",
  "A giveaway that does not deliver becomes a 1★: 'Scam of free life time subscription' (US, 1★) during the June 2023 free-lifetime promotion; promo failed 1",
  "free-lifetime promo", "1★-burst", "n=1 (1★)", "dont", "anecdotal", "yes", ["10087293260"])
c(186, "§7.3 Global vs US comparison (verbatim table) — Interpretation: US reviewers compare, pay and articulate; non-US hit the cap and English-only UI more and write shorter; overall rating identical", "market",
  "Global vs US: mean 4.577 / 4.582 / 4.580; competitor 19.62 / 9.62 / 13.19%; payer 9.06 / 5.65 / 6.86%; friction 7.92 / 11.92 / 10.50%; cap 3.77 / 6.07 / 5.25%; churn 3.40 / 1.05 / 1.88%; localisation 1.13 / 3.35 / 2.56%; short 10.9 / 19.5 / 16.4% — US reviewers compare, pay and articulate; non-US reviewers hit the cap and the English-only UI more often and write shorter reviews; the overall rating is identical, so the difference is in why people rate, not how high; no cultural generalisation beyond measured differences",
  "n/a", "mixed", table("## 7.3 Global vs US comparison"), "research", "US standalone", "yes", [])
c(187, "§7.3 non-US reviewers hit the cap more often (6.07% vs 3.77%) and the English-only UI (localisation 3.35% vs 1.13%)", "market",
  "Outside the US the 2-habit cap and English-only UI bite harder: cap 6.07% vs 3.77% and friction 11.92% vs 7.92%; localisation requests 3.35% vs 1.13% — non-English markets face both a price wall and a language wall",
  "2-habit cap, English only", "complaint", "cap 6.07 vs 3.77; friction 11.92 vs 7.92; localisation 3.35 vs 1.13", "product-rule", "non-US aggregate (75 storefronts, none ≥ 50)", "yes", [])
# Part 8
c(188, "§8.1 Method — five eras from product events; year figures where narrower; 2026 (n=39) small; June 2023 burst isolated where it distorts E3; no trend from a single month or < 5 reviews", "data-caveat",
  "Trend method: five eras defined from product events, rates as % of era; year figures where an event is narrower; 2026 (n = 39) flagged small; the June 2023 burst isolated where it distorts E3; no trend claimed from a single month or from fewer than 5 reviews",
  "n/a", "none", "report gives none", "none", "method", "yes", [])
c(189, "§8.2 Trend 1 — Ratings drift down after 2022 (verbatim table): mean 4.53 → 4.71 → 4.63 → 4.51 → 4.40; substantive 4.49 → 4.77 → 4.65 → 4.44 → 4.43; 5★ 71.7 → 87.6 → 75.8 → 76.1 → 76.0; 1–2★ 5.7 → 5.2 → 3.3 → 7.5 → 11.0; by year 4.91 (2022) → 4.60 → 4.56 → 4.44 → 4.26 (2026); driver monetisation friction; reliability does not rise in step", "timeline",
  "Ratings drift down after 2022, driven by monetisation friction, not reliability: mean E1 4.53 → E2 4.71 → E3 4.63 → E4 4.51 → E5 4.40; substantive mean 4.49 → 4.77 → 4.65 → 4.44 → 4.43; 5★ share 71.7 → 87.6 → 75.8 → 76.1 → 76.0%; 1–2★ share 5.7 → 5.2 → 3.3 → 7.5 → 11.0%; by year 4.91 (2022, n = 35) → 4.60 → 4.56 → 4.44 → 4.26 (2026, n = 39)",
  "n/a", "complaint", table("## 8.2 Trend 1"), "product-rule", "high-priority in E5", "yes", [])
c(190, "§8.3 Trend 2 — The wall became the story (verbatim table): friction 5.7 → 8.4 → 6.5 → 16.4 → 14.3; cap 3.8 → 2.8 → 3.9 → 9.7 → 7.1; price 1.9 → 4.4 → 2.0 → 5.2 → 1.9; other gated 1.9 → 0.8 → 0.7 → 1.5 → 3.2; no trial 1.9 → 0.8 → 0.0 → 0.7 → 1.9; monetisation positive 13.2 → 8.4 → 8.5 → 6.0 → 9.7", "timeline",
  "The wall became the story: friction (% of era) E1 5.7 → E2 8.4 → E3 6.5 → E4 16.4 → E5 14.3; free cap 3.8 → 2.8 → 3.9 → 9.7 → 7.1; price objection 1.9 → 4.4 → 2.0 → 5.2 → 1.9; other gated feature 1.9 → 0.8 → 0.7 → 1.5 → 3.2; no trial 1.9 → 0.8 → 0.0 → 0.7 → 1.9; monetisation positive 13.2 → 8.4 → 8.5 → 6.0 → 9.7; friction doubled from E3 to E4 (10 → 22 reviews) as review volume grew and widgets launched; in E5 the objection shifts from habit count toward features behind the paywall (widgets, colours, notes) and the trial; the 2026 4-habit reports are too few to show an effect",
  "n/a", "complaint", table("## 8.3 Trend 2"), "product-rule", "high-priority", "yes", ["13597043858","14316571521"])
c(191, "§8.3 In E5 the objection shifts from habit count toward features behind the paywall (widgets, colours, notes) and the trial", "timeline",
  "As a paywall matures, the objection moves from the habit count to everyday features behind it: in E5 'other gated feature' rose to 3.2% (from 0.7–1.5%) and no-trial to 1.9% while the cap fell from 9.7% to 7.1%",
  "features gated in E5", "complaint", "other gated E5 3.2; no trial E5 1.9; cap 9.7 → 7.1", "product-rule", "high-priority (trend)", "yes", [])
c(192, "§8.4 Trend 3 — Widgets: request, launch, praise, next request (verbatim table): request 1.9 → 3.2 → 11.1 → 1.5 → 1.3; praise 0.0 → 0.4* → 0.0 → 11.2 → 5.2; interactive 0 → 0 → 0 → 2.2 → 2.6; broken 0 → 0 → 0 → 3.0 → 0.6", "timeline",
  "Ship the most-requested feature and it becomes the most-praised one — a clean before/after: widget request E1 1.9 → E2 3.2 → E3 11.1 → E4 1.5 → E5 1.3%; widget praise 0.0 → 0.4 (one probably misattributed review) → 0.0 → 11.2 → 5.2%; interactive-widget request 0 → 0 → 0 → 2.2 → 2.6%; widget broken 0 → 0 → 0 → 3.0 → 0.6% — the corpus's strongest evidence that the developer's roadmap follows reviews",
  "widgets shipped Mar 2024", "praise", table("## 8.4 Trend 3"), "do", "very strong", "yes", ["7611242355"])
c(193, "§8.5 Trend 4 — Praise shifted from 'useful' to 'beautiful and the best' (verbatim table): core 77.4 → 74.7 → 64.7 → 59.0 → 66.2; simplicity 50.9 → 39.4 → 32.0 → 35.1 → 35.1; utility 24.5 → 18.5 → 9.2 → 6.0 → 9.1; design 34.0 → 18.1 → 25.5 → 25.4 → 19.5; developer 13.2 → 8.8 → 4.6 → 6.0 → 5.2; generic 1.9 → 8.8 → 11.1 → 11.2 → 10.4; short 5.7 → 13.7 → 24.8 → 17.2 → 15.6", "timeline",
  "Praise shifted from 'useful' to 'beautiful and the best' as the audience widened: core praise E1 77.4 → 74.7 → 64.7 → 59.0 → 66.2%; simplicity 50.9 → 39.4 → 32.0 → 35.1 → 35.1; utility ('helps me') 24.5 → 18.5 → 9.2 → 6.0 → 9.1; design 34.0 → 18.1 → 25.5 → 25.4 → 19.5; developer praised 13.2 → 8.8 → 4.6 → 6.0 → 5.2; generic only 1.9 → 8.8 → 11.1 → 11.2 → 10.4; short reviews 5.7 → 13.7 → 24.8 → 17.2 → 15.6 — early reviews were long and personal from Reddit-sourced early adopters who talk to 'Kevin'; from E3 reviews are shorter and generic (June 2023 burst, in-app prompt, wider audience), so the fall in core-praise share partly reflects mix change, not less satisfaction",
  "n/a", "praise", table("## 8.5 Trend 4"), "none", "high-priority", "yes", [])
c(194, "§8.6 Trend 5 — Reliability stays low; one release spike: 7.5% (E1, 4) → 2.0 → 1.3 → 6.7% (E4, 9) → 2.6; E4 spike = widget launch rendering + April 2024 crash fixed in a day; E5 reliability reports fewer but land on payers and on launch", "timeline",
  "Reliability stays low with one release spike: union 7.5% (E1, 4 reviews) → 2.0 → 1.3 → 6.7% (E4, 9 reviews) → 2.6%; E4's spike is the widget launch (rendering) and one bad release (Apr 2024 launch crash, fixed in a day); E5's reliability reports are fewer but land on payers (reminders, widget) and on launch (20–30 attempts)",
  "n/a", "complaint", "7.5 → 2.0 → 1.3 → 6.7 → 2.6", "must-never-break", "very strong in E4 only", "yes",
  ["11081066933","11138339931","11520002759","11740378083","11145404810","11147450348","13505537432","12326097524","13744408241"])
c(195, "§8.7 Trend 6 — Trust events cluster in 2025–26: data & entitlement trust 3.8% (E1, data loss) → 0.8 → 0.7 → 1.5 → 1.9% (E5, 3); not a trend by count, flagged because of consequence", "timeline",
  "Data & entitlement trust by era: 3.8% (E1, data loss) → 0.8 → 0.7 → 1.5 → 1.9% (E5, 3 reviews — export shutdown, lifetime complaint, one-time option removal); not a trend by count, flagged because of consequence",
  "n/a", "complaint", "3.8 → 0.8 → 0.7 → 1.5 → 1.9", "must-never-break", "weak individually", "yes", [])
c(196, "§8.8 Trend 7 — Localisation demand arrived with the promotion: 1.9% (E1) → 0.0 → 7.2% (E3, 11) → 3.7 → 1.3; Chinese requests began on 29 June 2023, the day of the burst", "timeline",
  "Localisation demand by era: 1.9% (E1) → 0.0 (E2) → 7.2% (E3, 11 reviews) → 3.7 → 1.3%; Chinese requests began on 29 June 2023, the day of the promotion burst",
  "n/a", "complaint", "1.9 → 0.0 → 7.2 → 3.7 → 1.3", "build-free", "meaningful in E3", "yes", ["10084467787"])
c(197, "§8.9 Trends explicitly NOT claimed — no AI trend (no review mentions AI, ChatGPT or an AI feature); no ADHD trend (five reviews over eight years); no effect of the 4-habit free tier (two reviews); no monthly trend within E5; no conversion, retention or churn rate", "data-caveat",
  "Non-claims: no AI trend — no review in the corpus mentions AI, ChatGPT or an AI feature; no ADHD trend — five reviews over eight years, all positive or mixed; no effect of the 4-habit free tier (two reviews); no monthly trend within E5 (small n); no conversion, retention or churn rate — the review is not a funnel",
  "n/a", "none", "AI 0; ADHD 5; 4-habit 2", "none", "explicit non-claims", "yes", ["7196952603","10335392591","10858613272","12221998930","13882752696"])
c(198, "§8.9 No AI trend — no review mentions AI, ChatGPT or an AI feature", "insight",
  "Users of a simple habit tracker do not ask for AI: across 743 reviews over eight years (2018–2026) no review mentions AI, ChatGPT or an AI feature",
  "no AI", "none", "0 of 743", "research", "explicit non-claim", "yes", [])
# Part 9
c(199, "Part 9 #1 — a year-at-a-glance grid is a differentiator in its own right (104 at 4–5★; several say no other app does it)", "positioning",
  "A year-at-a-glance grid is a differentiator in its own right: 104 reviews rated 4–5★ praise it, and several say no other app does it",
  "year grid free", "praise", "104 (4–5★)", "build-free", "competitor lesson", "yes", ["10791779600","9730846797"])
c(200, "Part 9 #2 — restraint is a feature: simplicity praised in 37%; 'hokey games', 'cutesy interfaces' and 'decision fatigue' named as reasons they left rivals", "product-rule",
  "Restraint is a feature: simplicity is praised in 37% of reviews and reviewers name 'hokey games', 'cutesy interfaces' and 'decision fatigue' as reasons they left rivals",
  "minimal", "praise", "275 (37.01%)", "product-rule", "competitor lesson", "yes", ["6713570145","11286612018","11257213711"])
c(201, "Part 9 #3 — a 2-habit free tier converts believers and repels evaluators: both the top purchase trigger and 40.5% of 1★", "insight",
  "A 2-habit free tier converts believers and repels evaluators: it is both the top purchase trigger and 40.5% of 1★ reviews",
  "2-habit cap", "mixed", "40.5% of 1★; top trigger", "undecided", "competitor lesson", "yes", [])
c(202, "Part 9 #4 — never surprise users with the wall: disclosure complaints are few but come from people who searched for 'free'", "product-rule",
  "Never surprise users with the wall: disclosure complaints are few but come from people who searched for 'free'",
  "limit disclosed late", "complaint", "3 (mean 2.33)", "product-rule", "competitor lesson", "yes", ["12233797625","11348148556"])
c(203, "Part 9 #5 — offer lifetime, then keep the promise: lifetime is a reason to buy; withdrawing it is a reason for 2★", "product-rule",
  "Offer lifetime, then keep the promise: lifetime is a reason to buy, withdrawing it is a reason for 2★",
  "lifetime", "mixed", "one-time praise 15 (4.87); lifetime complaint 2★", "must-never-break", "competitor lesson", "yes", ["11286612018","11583264179","14138883204"])
c(204, "Part 9 #6 — local-first privacy wins praise, but add optional sync; otherwise data loss and single-device use follow", "product-rule",
  "Local-first privacy wins praise, but add optional sync — otherwise data loss and single-device use follow",
  "local only", "mixed", "privacy 7; loss 4; platforms 18", "build-free", "competitor lesson", "yes", [])
c(205, "Part 9 #7 — ship the most-requested feature and it becomes the most-praised one (widgets, E3 → E4)", "do",
  "Ship the most-requested feature and it becomes the most-praised one (widgets: request 11.1% of E3 → praise 11.2% of E4)",
  "widgets", "praise", "11.1% → 11.2%", "do", "competitor lesson", "yes", [])
# Part 10
P = [
 (206, 1, "do", "State the free limit and the plans on the store page and on the first screen, before the user builds habits", "3 disclosure complaints; the wall arrives at habit #3; cap = 40.5% of 1★", "do", ["11348148556","12233797625","10455939599","3850157156"]),
 (207, 2, "do", "Move the rating prompt after setup and after a streak milestone; cut onboarding promos", "Warning 4; 3 reviews", "do", ["13586879451","9821511278","13288687749"]),
 (208, 3, "dont", "Stop upgrade nagging for users who stay within the free tier", "nagging 4 (mean 2.00)", "dont", ["7879946381","8233664049"]),
 (209, 4, "must-never-break", "Restore CSV export for everyone; never gate data exit or deletion behind payment", "both lock-in reviews 1★", "must-never-break", ["13731751322","12046497872"]),
 (210, 5, "must-never-break", "Honour existing lifetime licences and publish what 'lifetime' covers; if the one-time option is withdrawn in a storefront, say so on the paywall", "2 reviews", "must-never-break", ["13392990758","14138883204"]),
 (211, 6, "must-never-break", "Fix the reminder time picker — a paying user threatens to cancel; repeated Mar 2026", "2 reviews", "must-never-break", ["13505537432","13868583107"]),
 (212, 7, "must-never-break", "Fix widget rendering (tinted mode, missing days, widgets disabling) and the 2026 launch failure", "widget broken 5; launch 1", "must-never-break", ["11740378083","11081066933","11520002759","12326097524","13744408241"]),
 (213, 8, "monetization", "Test the free tier: 2 habits (control) vs 3–4 habits vs 2 habits with a 14–21-day full trial; measure conversion and 1★ rate; the 2026 '4 habits' reports suggest this may already be under way", "evaluation argument is the plurality of 78 friction reviews", "research", ["2953267303","9899413299","10904298957"]),
 (214, 9, "product-rule", "Keep at least one widget and basic colours in the free tier — gated features have the worst mean of any theme with n ≥ 5 (1.55); widgets are the top new praise", "gated 1.55; widget praise 24", "build-free", ["12760639157","13629525960"]),
 (215, 10, "monetization", "Offer a real trial (7–14 days) with a reminder before the charge; a 3-day trial is called too short", "7 trial complaints", "build-paid", ["12738794859","11939700468"]),
 (216, 11, "monetization", "Test a student or regional price and seasonal sales — affordability complaints; a 50% offer converted; New-Year months are the busiest", "cannot afford 4; 50% offer 1; Jan peaks 34", "research", ["10795711876","11097867630","12221998930","13560914935"]),
 (217, 12, "monetization", "Keep a lifetime option visible — a named purchase trigger and a US differentiator (one-time praise 3.02% US vs 1.46% non-US)", "3.02% vs 1.46%", "build-paid", ["11286612018","11583264179"]),
 (218, 13, "feature", "Interactive widgets (check off from the home screen)", "7 requests, all after launch; widget demand union 37 (4.98%)", "build-free", ["11412519740","13731564617"]),
 (219, 14, "feature", "Quantity habits with partial completion (8 of 10 glasses counts as progress)", "11 requests", "build-free", ["13432208041","10088647035"]),
 (220, 15, "feature", "Notes on missed days, and open a day's note from the calendar", "9 requests", "undecided", ["13583853777","11400095925","10569299689"]),
 (221, 16, "feature", "Optional iCloud sync, then iPad/Mac and Watch — iCloud keeps the no-server privacy stance", "demand union 18; data loss 4; a named departure", "build-free", ["11077980453"]),
 (222, 17, "feature", "Edit days directly in the month calendar; configurable day start — one reviewer left the app over calendar editing", "6 requests", "build-free", ["13559189439","9082639448","10732085902"]),
 (223, 18, "feature", "Statistics: month %, all habits in one grid, counts instead of streaks", "14 requests", "build-free", ["8746143988","12464367645"]),
 (224, 19, "feature", "Bad-habit mode and a skip / sick-day state", "6 + 5 requests", "build-free", ["11475674157","11872013641"]),
 (225, 20, "feature", "Localisation: Chinese, Russian, Spanish, French, Ukrainian — none hostile", "19 requests", "build-free", ["10084467787","10750194157"]),
 (226, 21, "product-rule", "Keep gamification optional — demand is split", "5 requests vs many praising absence", "product-rule", ["5389230957","10128198936"]),
 (227, 22, "data-caveat", "Research question: what is the free tier today, by storefront and cohort (2 or 4 habits)? Are widgets free?", "unanswerable from reviews", "research", ["13597043858","14316571521","12760639157","13467704260"]),
 (228, 23, "data-caveat", "Research question: is lifetime still sold, and are older lifetime licences recognised after updates?", "unanswerable from reviews", "research", ["13392990758","14138883204"]),
 (229, 24, "data-caveat", "Research question: why was CSV export disabled, and for whom?", "unanswerable from reviews", "research", ["13731751322"]),
 (230, 25, "data-caveat", "Research question: did a free-lifetime promotion run on ~29 June 2023, and did it deliver? (one reviewer says it did not)", "unanswerable from reviews", "research", ["10087293260"]),
 (231, 26, "data-caveat", "Research question: what share of new users hit the 2-habit wall in their first session, and how many convert vs uninstall?", "unanswerable from reviews", "research", []),
 (232, 27, "monetization", "Experiment — free-tier design: cap 2 vs 3 vs 4; trial vs none — measuring conversion, D30 retention and 1★ rate", "experiment", "research", []),
 (233, 28, "do", "Experiment — disclosure placement: limit shown before vs at habit #3", "experiment", "research", []),
 (234, 29, "feature", "Experiment — widget in free tier vs paid-only", "experiment", "research", []),
 (235, 30, "do", "Experiment — rating-prompt timing: after setup vs after a 7-day streak", "experiment", "research", []),
]
SEC = {1:"10.1",2:"10.1",3:"10.1",4:"10.2",5:"10.2",6:"10.2",7:"10.2"}
for seq, num, kind, claim, mag, d, ids in P:
    sec = SEC.get(num) or ("10.3" if num <= 12 else "10.4" if num <= 21 else "10.5" if num <= 26 else "10.6")
    c(seq, f"Part 10 #{num} (§{sec})", kind, claim, "report recommendation", "none", mag, d, "report recommendation", "yes", ids)
save("a")
