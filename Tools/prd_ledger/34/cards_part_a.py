"""Cards for report 34 — header, warnings, executive summary, Part 1."""
import sys; sys.path.insert(0, "Tools/prd_ledger/34")
from _lib import c, table, save

c(1, "header lines 1-10", "positioning",
  "Habit Tracker – Evoday (App Store ID 1403517519, 'Daily Streaks Calendar & Goals') — a solo / small indie developer reviewers call 'Kevin' (31 reviews name him); the same app ID was called 'Habit Tracker' (2018), 'Super Habit(s)' (2020–23), 'Daily Habits' (2023–25) and 'Evoday' (from Jul 2025); free download with a 2-habit free tier (2018–2025, reported as 4 in 2026); one-time Premium ~$5 → $9 until mid-2019; from autumn 2019 monthly / annual subscription plus lifetime (~$9/mo, ~$20/yr, ~$40 lifetime by 2024–25); no ads; data on the device, no account",
  "developer of record Cosmic Taps SL; bundle com.kevinquisquater.Habits; extracted 8 Sep 2026; analysed 11 Sep 2026; store rank 34", "praise",
  "743 written reviews · 76 storefronts · 13 Jul 2018 → 6 Sep 2026; mean 4.580; US 265 is the only storefront ≥ 50 (next gb 34, ca 33, in 32)", "none", "corpus-level fact", "app-specific",
  ["5288658286","11046696316","13919822858","5580664864","7672593618","10100128513","9667437355","11067277188","12427980996","12842151586","13044612377","13467704260"],
  side="renamed four times on one app ID")
c(2, "How to read this; Seven warnings #2 #5 #6 #7; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations", "data-caveat",
  "Method: all 743 reviews read in full in date order in 6 batches (~125), in every language (English, Spanish, Portuguese, French, German, Italian, Dutch, Swedish, Danish, Polish, Russian, Ukrainian, Chinese, Korean) and hand-coded by one analyst against 95 hand-applied codes, one regex code (KEVIN) and 10 derived unions; a coverage script confirmed 743/743 coded once on the first run; a 29-pattern multilingual recall sweep read every candidate and made 10 corrections; theme counts non-exclusive; signal bands <0.1% ignore · 0.1–0.5% weak · 0.5–1% emerging · 1–3% meaningful · 3–5% very strong · >5% high-priority; denominators 743, eras E1 53 · E2 249 · E3 153 · E4 134 · E5 154, US 265; at this size one review is 0.13% (already 'weak'), four are 0.54% ('emerging'), three US reviews are 1.13% ('meaningful') — treat any theme with n < 5 as anecdotal whatever its label; no version field (release events come from review text, feature dates bracketed by first/last mention); payer evidence self-selected (51 first-person payers, 6.86%, no conversion rate); single rater, no second coder; reconciliation exact — 743 records = 743 unique IDs = sum of 76 by_country files = manifest; rating distribution {5:591, 4:77, 3:27, 2:11, 1:37} matches; mean 4.5801; 0 empty bodies/titles; 0 duplicate-text groups; is_edited 35 (e.g. 10732085902 4★ after a developer tip, 11077980453 after a reply, 11062493236 after widgets shipped); votes too sparse to weight — vote_count non-zero on 31, top 4310058011 (8 votes, a diabetic reviewer's weight-loss story); author ignored as personal data; no download, revenue, retention, churn or refund data; no external source consulted; 672 of 743 (90.4%) carry a specific theme, the 71 generic ones average 4.82",
  "n/a", "none", "743/743 coded once; 10 recall corrections; 31 voted records; 35 edited", "none", "method", "yes",
  ["4310058011","10732085902","11077980453","11062493236"])
c(3, "Seven warnings #1 — the corpus is small and saturated with 5★: 591 of 743 (79.5%) 5★, only 48 (6.5%) 1–2★; every negative theme rests on small counts, read the IDs", "data-caveat",
  "The corpus is small and saturated with 5★: 591 of 743 (79.5%) are 5★ and only 48 (6.5%) are 1–2★, so every negative theme rests on small counts — read the IDs, not the percentages",
  "n/a", "mixed", "591/743 5★ (79.5%); 48 1–2★ (6.5%)", "none", "corpus-level fact", "app-specific", [])
c(4, "Seven warnings #3 — probable promotion burst 28–30 Jun 2023: 27 reviews in three days from 11 storefronts (corpus average ~1 review every four days), mean 4.81, 25 of them 5★, 55.6% with a body ≤ 25 characters; 'Freeeee', 'This App free', 'It let's me add as much habits as I want', 'Scam of free life time subscription'; later 啥时候还有限免呐？; without them the mean is 4.571", "data-caveat",
  "A limited-time free-lifetime promotion around 29 Jun 2023 produced a review burst: 27 reviews in three days from 11 storefronts (the corpus averages about one every four days), mean 4.81, 25 of them 5★, 55.6% with a body of 25 characters or fewer; four mention the app being free ('Freeeee'; 'This App free'; 'It let's me add as much habits as I want'; 'Scam of free life time subscription') and a later Chinese reviewer asks 'When will there be another limited-time free offer?'; without the 27 the corpus mean is 4.571",
  "free-lifetime promo", "5★-burst", "27 in 3 days, 11 storefronts; mean 4.81; 25 5★; 55.6% ≤ 25 chars; mean without them 4.571", "none", "interpretation (probable)", "yes",
  ["10083799946","10085535827","10083139099","10087293260","12597410321"])
c(5, "Seven warnings #3; §2.2 28–30 Jun 2023; §1.6 busiest day 2023-06-29", "tactic",
  "Outcome of a limited-time free-lifetime giveaway (≈29 Jun 2023): it bought a burst of 27 short, mostly 5★ reviews in three days (21 on 29 Jun alone, all 5★, from br 5, us 4, vn 2, in 2, cn 2, co 2 …), shifted the corpus mean by only ~0.01 (4.571 → 4.580), lifted the short-review share of 2023 to 27.1% and of E3 to 24.8%, attracted Chinese / Russian / Ukrainian users who then asked for localisation (Jun 2023 – Jan 2024 wave), and left some who expected it again ('When will there be another limited-time free offer?') and one calling it a 'Scam of free life time subscription'",
  "free-lifetime promotion", "5★-burst", "27 reviews / 3 days; 21 on 2023-06-29 all 5★; 2023 short 27.1%; E3 short 24.8%", "research", "interpretation (probable)", "yes",
  ["10083799946","10085535827","10087293260","12597410321","10084467787","10750194157","10336343530"],
  side="brought in non-English users who then asked for localisation; set an expectation of future free offers",
  cond="promotion inferred from review text and timing, not confirmed")
c(6, "Seven warnings #4; §2.4 review prompting", "dont",
  "Do not ask for a rating before the user has finished setting up: the app prompts in-app, sometimes early — 'you want me to rate it before I even finish setting it up', 'App asks for 5 stars review', 'lovely review pop up' — and prompted reviews skew positive and short",
  "in-app rating prompt, sometimes during setup", "complaint", "3 reviews (qualitative)", "dont", "weak / anecdotal", "yes",
  ["13586879451","9821511278","9613494929"], side="inflates short 5★ share and weakens the rating as a signal")
c(7, "§1.5 Known limitations — MISRATE: 5 reviews carry a star rating that contradicts their text (5★ 'Lost all data'; 5★ 'Greedy developer'; 5★ 'doesn't work after the … update'; 5★ 'I have to open the app 20-30 times to get it to load')", "data-caveat",
  "Rating-vs-text contradictions: 5 reviews carry a star rating contradicting their text — 5★ 'Lost all data', 5★ 'Greedy developer', 5★ 'doesn't work after the … update', 5★ 'I have to open the app 20-30 times to get it to load'; positive themes are also reported as 'rated 4–5★' subsets",
  "n/a", "mixed", "5 MISRATE", "none", "corpus-level fact", "yes", ["4289434524","9342516160","11145404810","13744408241"])
c(8, "§1.5 Known limitations — storefront ≠ nationality ≠ language; one review may be misattributed; reviewers contradict each other on plans", "data-caveat",
  "Storefront is not nationality or language (the US storefront holds Russian and Korean reviews and a request for Chinese); one Canadian 2021 review praising a 'days since' widget is probably about another app since widgets arrived Mar 2024 (kept as written); reviewers contradict each other on whether a trial exists, whether widgets are free, whether lifetime is still sold and 2 vs 4 free habits — reported, not resolved, possibly storefront, version or A/B differences",
  "n/a", "mixed", "report gives none", "none", "limitation", "yes", ["11213904536","13580872804","10120710103","7611242355"])

# Executive summary
c(9, "Executive summary #1 — core praise 507 (68.24%, high-priority), mean 4.87", "insight",
  "The product wins on one idea — see a whole year of a habit at a glance with almost no effort: core praise in 507 reviews (68.24%, high-priority, mean 4.87) — simplicity 275 (37.01%; 273 rated 4–5★; zero 1★), design 166 (22.34%), 'best / the only one that stuck' 107 (14.40%, no 1★), year grid / month calendar / GitHub-like heatmap 105 (14.13%, no 1★)",
  "simple one-tap tracker with year heatmap", "praise", "507 (68.24%), mean 4.87; simplicity 275 (37.01%); design 166 (22.34%); best 107 (14.40%); year grid 105 (14.13%)", "build-free", "high-priority", "yes",
  ["10791779600","9730846797","9667437355","14284351778"])
c(10, "Executive summary #1 — year grid is the one feature reviewers say rivals lack", "feature",
  "A per-habit year grid / 'year in pixels' / GitHub-contribution-style heatmap is the one feature reviewers say rivals lack and it sells the app: 105 reviews (14.13%, no 1★) — 'the only habit tracker I could find with a whole year view'; 'I have never seen another app doing this'; 'The year in pixels completely sold me'; 'the dev is a fan of the GitHub commit tracker because that's basically what I was looking for'",
  "free, per habit, since 2018; monthly view added ~Apr 2020", "purchase-driver", "105 (14.13%), zero 1★", "build-free", "high-priority", "yes",
  ["10791779600","9730846797","9667437355","14284351778","2901595370","11670216762"])
c(11, "Executive summary #1 — this app is where people land after trying others: 98 (13.19%) name a competitor or say they tried many; only one 1★", "positioning",
  "This app is where people land after trying others: 98 reviews (13.19%) name a competitor or say they tried many, and only one of them is 1★ — 'I downloaded all the habit trackers, this is the only one I kept'; 'downloaded like 30 different apps'; 'tried over a dozen apps and always come back to this one'",
  "destination app", "praise", "98 (13.19%); 1 of them 1★", "none", "high-priority", "yes",
  ["10184986574","13649480321","6713570145"])
c(12, "Executive summary #2 — the 2-habit free tier is the main cause of low ratings: monetisation friction 78 (10.50%, high-priority), mean 2.68; in 28 of 37 1★ (75.7%) and 9 of 11 2★", "monetization",
  "A 2-habit free tier is the main cause of low ratings: monetisation friction in 78 reviews (10.50%, high-priority, mean 2.68), present in 28 of the 37 1★ (75.7%) and 9 of the 11 2★; the habit cap alone 39 (5.25%, high-priority, mean 2.44, 15 of them 1★) — 'Only 2 habits for free'; 'Two is really stingy — with three I'd have kept it for decency; with five I'd have started using it, got hooked, and then bought'; 'Other apps usually have 5 free habits'",
  "2 free habits 2018–2025", "complaint", "friction 78 (10.50%) mean 2.68; 28/37 1★ (75.7%); 9/11 2★; cap 39 (5.25%) mean 2.44, 15 1★", "product-rule", "high-priority", "yes",
  ["9839460397","9899413299","10904298957"])
c(13, "Executive summary #2 — 'with three I'd have kept it for decency; with five I'd have started using it, got hooked, and then bought'", "insight",
  "A reviewer spells out the conversion curve of the free cap: 'Two is really stingy — with three I'd have kept it for decency; with five I'd have started using it, got hooked, and then bought' (Russian, translated) — a larger free tier is the route to purchase, not a lost sale; 'Other apps usually have 5 free habits' sets the reference point",
  "2 free habits", "blocked-conversion", "n=1 quote + n=1 benchmark", "product-rule", "anecdotal quote within high-priority theme", "yes",
  ["9899413299","10904298957"])
c(14, "Executive summary #2 — other gated features 11 (1.48%), mean 1.55, the worst-rated theme with n ≥ 5: widgets, notes, colours, backup", "monetization",
  "Gating small extras is rated worse than the habit cap: other gated features — widgets ('Cant use widgets without subscription'), notes, colours, backup — 11 reviews (1.48%) at mean 1.55, the worst-rated theme with n ≥ 5",
  "widgets / notes / colours / backup paid", "complaint", "11 (1.48%), mean 1.55", "product-rule", "meaningful; worst-rated n≥5", "yes",
  ["12760639157","13605658579","13629525960","12046497872"])
c(15, "Executive summary #2 — friction rose sharply after 2024: 5.7% E1, 8.4% E2 → 16.4% E4, 14.3% E5; cap complaints 2.8% E2 → 9.7% E4", "timeline",
  "Monetisation friction rose sharply after 2024 without a price-model change: 5.7% of E1 and 8.4% of E2, then 16.4% of E4 (2024) and 14.3% of E5 (2025–26); cap complaints went from 2.8% of E2 to 9.7% of E4",
  "same 2-habit cap throughout", "complaint", "friction 5.7% → 8.4% → 16.4% → 14.3%; cap 2.8% E2 → 9.7% E4", "product-rule", "high-priority", "yes", [])
c(16, "Executive summary #3 — the objection is mostly about evaluation and disclosure, not only the price level", "insight",
  "The paywall objection is mostly about evaluation and disclosure, not only price: reviewers want to judge the app before paying — not told about the limit before downloading (3), no trial or too short (7), price level (25, mean 3.16)",
  "2-habit cap, trial inconsistent", "complaint", "undisclosed 3; no/short trial 7; price 25 (mean 3.16)", "product-rule", "meaningful", "yes",
  ["11348148556","12233797625","11939700468","12738794859","11554013205"])
c(17, "Executive summary #3 — not told about the limit before downloading (3)", "dont",
  "Do not reveal the free limit only after the user has invested setup: 'Waits until I made two habits to tell me I needed to pay'; 'only to find out AFTER downloading the app that there is a fee' — 3 reviews",
  "limit shown only at the wall", "complaint", "3 (0.40%)", "dont", "weak", "yes", ["11348148556","12233797625"])
c(18, "Executive summary #3 — no trial or too short (7): 'I refuse to pay the min. $9 just to find out if I like it'; 'the free trial lasts only 3 days'", "monetization",
  "No trial, or a 3-day trial, blocks conversion from people who want to evaluate: 7 reviews — 'I refuse to pay the min. $9 just to find out if I like it'; 'the free trial lasts only 3 days'",
  "no trial (2022, 2024, 2026) vs 3-day trial (2025)", "blocked-conversion", "7 (0.94%)", "build-paid", "emerging", "yes", ["11939700468","12738794859"],
  cond="trial existence contradicts across years/storefronts")
c(19, "Executive summary #3 — price level (25, mean 3.16): '$40 … An indie game developed over years … will cost 5 to 25 dollars'", "monetization",
  "Price level objection is mild: 25 reviews at mean 3.16 — '$40 … An indie game developed over years … will cost 5 to 25 dollars' (reviewers anchor the price to other software they buy)",
  "~$40 lifetime, ~$20/yr, ~$9/mo", "complaint", "25 (3.36%), mean 3.16", "undecided", "very strong", "yes", ["11554013205"])
c(20, "Executive summary #4 — ratings are drifting down slowly: era means 4.71 (E2) → 4.63 (E3) → 4.51 (E4) → 4.40 (E5); 1–2★ 3.3% E3 → 7.5% E4 → 11.0% E5 (17/154); 2026 4.26, 15.4% 1–2★ (n=39); driven by the paywall, not reliability", "timeline",
  "Ratings drift down slowly as paywall friction rises, not from reliability: era means 4.71 (E2) → 4.63 (E3) → 4.51 (E4) → 4.40 (E5); 1–2★ share 3.3% of E3 → 7.5% of E4 → 11.0% of E5 (17 of 154); 2026 so far mean 4.26 with 15.4% 1–2★ (n = 39, small)",
  "paywall unchanged, friction rising", "complaint", "4.71 → 4.63 → 4.51 → 4.40; 1–2★ 3.3% → 7.5% → 11.0%; 2026 4.26 / 15.4%", "product-rule", "high-priority in E5", "yes", [])
c(21, "Executive summary #5 — widgets were the #1 request for four years: 30 (4.04%, very strong), peak 11.1% of E3", "feature",
  "Home-screen widgets were the #1 request for four years: 30 requests (4.04%, very strong), peaking at 11.1% of E3 (Jun 2023 – Mar 2024) — 'I'll take one star off for a widget … I promise … to put it back'",
  "absent until ~mid-Mar 2024", "complaint", "30 (4.04%); 11.1% of E3", "must-have", "very strong", "yes", ["10552434405","6576140378","6580579419","6901067746","11004886291"])
c(22, "Executive summary #5 — widgets shipped ~mid-Mar 2024: widget praise 24 (3.23%), 11.2% of E4", "timeline",
  "Shipping a long-requested widget turned it into the top new praise: widgets shipped ~mid-March 2024 ('Thanks to the devs for adding the widgets!') and widget praise reached 24 reviews (3.23%), 11.2% of E4 — 'I use the widget religiously'; one reviewer edited their review up after the launch",
  "widgets shipped Mar 2024 (streak, month overview)", "praise", "24 (3.23%); 11.2% of E4", "build-free", "very strong", "yes", ["11062493236","12172218323","11077980453","11580982926"])
c(23, "Executive summary #5 — the new ask is interactive widgets: 7 (0.94%), all after launch", "feature",
  "After static widgets ship, the next ask is interactive widgets (tick a habit from the widget): 7 reviews (0.94%), all after the launch — 'The widgets still aren't interactive' (Feb 2026); one reviewer calls the widgets interactive (Dec 2024), unresolved",
  "widgets not interactive", "complaint", "7 (0.94%)", "build-free", "emerging", "yes", ["13731564617","11412519740","11977577005","12089656951"])
c(24, "Executive summary #5 — widgets are behind the paywall for some users", "feature",
  "Widgets are behind the paywall for some users and free for others: 'Cant use widgets without subscription' (1★) and a 3-day-trial complaint vs 'still have some access to widgets' in free",
  "widgets mixed free/paid", "complaint", "2–3 reviews", "build-free", "weak", "yes", ["12760639157","12738794859","13467704260"], cond="possibly storefront or A/B difference")
c(25, "Executive summary #6 — CSV export disabled (Feb 2026, 1★)", "must-never-break",
  "Never disable data export: 'Out of nowhere, the developer decided to disable CSV exports … years of data are stuck in this app' (1★, Feb 2026; 'Extremely shady practices here') — a single review, high consequence, in a local-first app with no account where export is the only way out",
  "CSV export disabled 2026", "churn", "n=1, 1★", "must-never-break", "weak individually; high consequence", "yes", ["13731751322"])
c(26, "Executive summary #6 — backup required (and paid) before deleting", "must-never-break",
  "Never require a paid backup before a user can delete or leave: in Dec 2024 deleting required a backup described as paid (1★)",
  "backup paid, required before delete", "complaint", "n=1, 1★", "must-never-break", "weak individually; high consequence", "yes", ["12046497872"])
c(27, "Executive summary #6 — lifetime option removed or not honoured", "must-never-break",
  "Honour lifetime purchases and do not silently remove the one-time option: 'After updating the app this option is gone' (Nov 2025) and 'After a year or two, your \"lifetime\" subscription wont be working anymore' (Jun–Jul 2026)",
  "one-time option removed in some storefronts; lifetime disputes", "churn", "2 reviews", "must-never-break", "weak individually; high consequence", "yes", ["13392990758","14138883204"])
c(28, "Executive summary #6 — reminder time picker broken for a paying user (Dec 2025, Mar 2026)", "must-never-break",
  "Reminders must be settable: the reminder time picker broke for a paying user (Dec 2025) and a reminder could only be set to the current time (Mar 2026)",
  "reminder picker bug", "complaint", "2 reviews", "must-never-break", "weak", "yes", ["13505537432","13868583107"])
c(29, "Executive summary #7 — paying users are satisfied: 51 explicit payers (6.86%), mean 4.63, 42 5★, 3 at 1–2★", "insight",
  "Paying users are satisfied: 51 explicit payers (6.86%), mean 4.63, 42 of them 5★, only 3 at 1–2★; what goes wrong after paying is functional (reminders, a widget, the lifetime entitlement), not price",
  "subscription + lifetime", "praise", "51 (6.86%), mean 4.63; 42 5★; 3 1–2★", "none", "meaningful (self-selected)", "yes", [])
c(30, "Executive summary #7 — buy after the 2 free habits prove the method", "insight",
  "People buy after the free habits prove the method works for them: 'purely because it has been so effective in reinforcing the two habits … and I needed to add more' — the cap converts when the tracked habits succeed",
  "2 free habits", "purchase-driver", "qualitative", "none", "meaningful (payer segment)", "yes", ["13242549122"])
c(31, "Executive summary #7 — buy because a lifetime / one-time option exists", "monetization",
  "A lifetime / one-time option is a stated reason to buy",
  "~$40 lifetime", "purchase-driver", "qualitative (see §6.3)", "build-paid", "meaningful", "yes", ["11286612018","11583264179"])
c(32, "Executive summary #7 — buy to support a solo developer", "insight",
  "Supporting a solo developer is a stated purchase motive",
  "solo dev 'Kevin'", "purchase-driver", "qualitative (see §6.3)", "none", "meaningful", "yes", ["4497735688","11737212105","13919822858"])
c(33, "Executive summary #8 — developer praise 52 (7.00%), mean 4.96; features built on request; in-app 'in progress' roadmap; share fell 13.2% E1 → 5.2% E5; one reports no email reply", "do",
  "A visible, personal developer is an asset that thins as the app grows: developer praise 52 reviews (7.00%, mean 4.96); features built on request ('He listened to the community and implemented weekly habits'; 'has even implemented one of mine'); an in-app 'in progress' roadmap; its share fell from 13.2% of E1 to 5.2% of E5, and one reviewer reports no e-mail reply",
  "named solo dev; builds requests; in-app roadmap", "praise", "52 (7.00%), mean 4.96; 13.2% E1 → 5.2% E5", "do", "high-priority", "yes",
  ["3954949955","8400091910","13247369835","13882752696","10904298957"])
c(34, "Executive summary #9 — United States (265, mean 4.577) is the comparison-shopping market", "market",
  "The US is the comparison-shopping market: relative to the other 478 reviews, US reviewers are twice as likely to name competitors (19.62% vs 9.62%), more likely to say 'best' (18.87% vs 11.92%), to be explicit payers (9.06% vs 5.65%) and to praise the price (6.79% vs 3.35%); they report less monetisation friction (7.92% vs 11.92%) but more explicit churn (9 reviews, 3.40%, vs 1.05%)",
  "n/a", "mixed", "US 265 mean 4.577; competitors 19.62 vs 9.62; best 18.87 vs 11.92; payers 9.06 vs 5.65; price praise 6.79 vs 3.35; friction 7.92 vs 11.92; churn 3.40 vs 1.05", "research", "US-only standalone", "yes", [])
c(35, "Executive summary #10 — cheapest wins, in evidence order (1–6)", "do",
  "Cheapest wins in evidence order: (1) state the free limit on the store page and in onboarding, and delay the rating prompt until after setup; (2) let people evaluate before paying — a real trial, or 3–5 free habits; (3) never gate data exit — restore CSV export for everyone and make backup/delete free; (4) honour and publish what 'lifetime' includes and say clearly which plans are sold; (5) fix the reminder time picker and the widget rendering bugs; (6) ship interactive widgets and quantity (partial-completion) habits",
  "n/a", "mixed", "report gives none (ordering by evidence)", "do", "report recommendation", "yes", [])

# Part 1.6
c(36, "§1.6 Ratings table (verbatim)", "data-caveat", "Rating distribution, denominator 743", "n/a", "mixed", table("**Ratings (denominator 743):**"), "none", "corpus-level fact", "app-specific", [])
c(37, "§1.6 By year table (verbatim)", "timeline", "Per-year volume, mean, 5★/1★/1–2★ share, substantive mean, short share, US n and mean", "n/a", "mixed", table("**By year**"), "none", "corpus-level fact", "app-specific", [])
c(38, "§1.6 Eras used throughout (verbatim table)", "timeline", "Era definitions E1–E5 from product events, with n, mean, 5★/1★/1–2★ and short shares", "n/a", "mixed", table("**Eras used throughout.**"), "none", "corpus-level fact", "app-specific",
  ["4497735688","4924456384","11004886291","11062493236"])
c(39, "§1.6 2022 is the best year: mean 4.91, 94.3% 5★, 0 1★ (n=35); 2026 mean 4.26, 10.3% 1★, 15.4% 1–2★", "timeline",
  "The rating peak came in the quiet, stable years before growth: 2022 mean 4.91, 94.3% 5★, zero 1★ (n = 35); after the 2023 promotion and volume rise the mean fell each year to 4.26 in 2026 (10.3% 1★, 15.4% 1–2★, n = 39)",
  "n/a", "mixed", "2022 4.91 / 94.3% 5★ (n=35) → 2023 4.60 → 2024 4.56 → 2025 4.44 → 2026 4.26", "research", "small annual n", "app-specific", [])
c(40, "§1.6 Languages; Volume — busiest months 2024-01 (34), 2025-01 (34), 2023-06 (33, burst), 2019-12 (24, 4.92); January peaks match New-Year resolution use; busiest day 2023-06-29 21 reviews all 5★", "insight",
  "January is the habit-app season: the busiest months are 2024-01 (34, mean 4.65) and 2025-01 (34, mean 4.53), with 2019-12 (24, mean 4.92), matching New-Year resolution use ('I get to keep up with all of my goals for the new year'); 2023-06 (33, mean 4.82) is the promotion burst; scripts — Latin 716 (96.4%), Cyrillic 14, Chinese 12, Korean 1",
  "n/a", "mixed", "2024-01 34 (4.65); 2025-01 34 (4.53); 2023-06 33 (4.82); 2019-12 24 (4.92); 2023-06-29 21 all 5★", "do", "corpus-level fact", "yes",
  ["3602342510","5353512893","13560914935"])
c(41, "§1.6 Storefronts: 76; only US clears 50 (us 265, 35.7%); gb 34 · ca 33 · in 32 · de 26 · es 22 · fr 21 · br 21 · au 15 · nl 14 · cn 14 · mx 13", "data-caveat",
  "Storefront spread: 76 storefronts, only the US clears 50 (265, 35.7%); next gb 34, ca 33, in 32, de 26, es 22, fr 21, br 21, au 15, nl 14, cn 14, mx 13 — every non-US number is limited evidence; all 478 non-US reviews count in global numbers",
  "n/a", "mixed", "us 265 (35.7%); gb 34; ca 33; in 32; de 26; es 22; fr 21; br 21; au 15; nl 14; cn 14; mx 13", "none", "eligibility", "app-specific", [])
save("w")
