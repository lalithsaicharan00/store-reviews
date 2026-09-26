"""Cards for report 34 — Part 4 (clusters), Part 5 (ratings), Part 6 (payers)."""
import sys; sys.path.insert(0, "Tools/prd_ledger/34")
from _lib import c, table, save

# §4.1
c(135, "§4.1 Cluster 1 — The 2-habit wall (verbatim symptom table)", "data-caveat", "Symptoms of the 2-habit wall with evidence", "n/a", "complaint", table("## 4.1 Cluster 1"), "none", "corpus-level fact", "app-specific",
  ["3850157156","11348148556","10904298957","12108620259","12154681308","9342516160","5964636301","10829968552","11114378387","11540693274","10668865820","12760639157","12738794859","13629525960","13597043858","14316571521"])
c(136, "§4.1 The wall arrives at habit #3, during setup — 'I added 2, tried to add the third and was prompted to pay'", "dont",
  "Do not put the wall inside first-run setup: it arrives at habit #3 while the user is still setting up — 'I added 2, tried to add the third and was prompted to pay'; 'Waits until I made two habits to tell me'",
  "wall at habit #3", "complaint", "cap 39 (5.25%), mean 2.44", "dont", "high-priority", "yes", ["3850157156","11348148556"])
c(137, "§4.1 The cap is stricter than peers — 'Other apps usually have 5 free habits'; 'at least five don't skimp out like that'; 'no 8-10 habits for free'", "market",
  "Reviewers benchmark the free cap against peers: 'Other apps usually have 5 free habits'; 'at least five don't skimp out like that'; 'no 8-10 habits for free' — 2 is below the category norm they expect; one departure was to an app with more free habits",
  "2 free habits", "churn", "4 quotes", "product-rule", "high-priority theme", "yes", ["10904298957","12108620259","12154681308","9342516160"])
c(138, "§4.1 Some reviewers ask for just one more — 'Maybe you could change the maximal Habits to 3'; '3-4 habits'", "monetization",
  "Some reviewers ask for just one or two more free habits — 'Maybe you could change the maximal Habits to 3'; '3-4 habits' (5 reviews); by 2026 the free tier is reported as 4 habits yet one such reviewer still rated 1★ ('limited. :: 4 habits in free account')",
  "2 → reportedly 4 in 2026", "blocked-conversion", "5 asks; 2026 4-habit reports 2 (one still 1★)", "product-rule", "emerging", "yes",
  ["5964636301","10829968552","11114378387","11540693274","10668865820","13597043858","14316571521"])
c(139, "§4.1 The wall now includes features, not only habits — 'Premium is the only usable form — widgets and more than 2 habits are essential'", "monetization",
  "The wall now includes features, not only habits: 'Premium is the only usable form — widgets and more than 2 habits are essential' (3-day-trial reviewer); widgets and colours gated",
  "widgets / colours gated", "complaint", "3 reviews", "product-rule", "E5-heavy", "yes", ["12760639157","12738794859","13629525960"])
c(140, "§4.1 Impact — 15 of 37 1★ (40.5%) are the cap; cap reviews spread 3 at 5★, 7 at 4★, 9 at 3★, 5 at 2★, 15 at 1★; many 4★ reviewers like the app and still resent the cap", "insight",
  "The cap produces the largest single share of 1★ yet is spread across stars: 15 of 37 1★ (40.5%) are the cap (28 of 37, 75.7%, some friction); cap reviews split 3 at 5★, 7 at 4★, 9 at 3★, 5 at 2★, 15 at 1★ — many 4★ reviewers like the app and still resent the cap",
  "2-habit cap", "complaint", "15/37 1★ (40.5%); 3/7/9/5/15 by star", "product-rule", "high-priority", "yes", [])
c(141, "§4.1 Interpretation — the same cap is the most common purchase trigger among payers; it converts people who proved the method on two habits and rejects people who wanted to evaluate it on their real routine", "contradiction",
  "The same 2-habit cap is both the top 1★ cause and the most common purchase trigger: it converts people who have already proven the method on two habits and rejects people who wanted to evaluate the app on their real routine",
  "2-habit cap", "mixed", "cap 15/37 1★; top §6.3 trigger", "undecided", "interpretation", "yes", ["9655320510","13242549122","10791117607"],
  cond="converts users whose two tracked habits succeed; repels users evaluating a full routine")
# §4.2
c(142, "§4.2 Cluster 2 — The widget story (verbatim phase table)", "timeline",
  "Widget story by phase: Oct 2020 – Mar 2024 request (28 of the 30; 'iOS 14 widget would be cool!'; one star withheld; a month-grid widget) → mid-Mar 2024 shipped ('the new widgets are a huge selling point') → 2024–26 praise 24 (15 in E4; 'Widgets are a highlight'; chose the app for its widgets; half-marathon training) → next ask interactive 7 → problems 5 (two of six widgets don't show days; white in tinted mode; 'keeps getting disabled'; 'does not work on iphone :: waste money') → 2025 paywalled 2",
  "widgets shipped after 3.5 years of requests", "mixed", table("## 4.2 Cluster 2"), "build-free", "very strong", "yes",
  ["6580579419","9470823701","10335392591","10552434405","11062493236","11077980453","12172218323","11704110690","11404887985","12926583376","11412519740","13731564617","11081066933","11740378083","11520002759","12326097524","12760639157","12738794859"])
c(143, "§4.2 Interpretation — widgets are the second visible surface of the year-grid idea; 'A widget in the Home Screen is for me more useful than a random notification'; gating them risks turning the most-praised recent feature into a 1★ theme", "product-rule",
  "Keep the widget free: widgets put the streak / year grid on the home screen ('A widget in the Home Screen is for me more useful than a random notification'), 'the new widgets are a huge selling point', and gating them risks turning the most-praised recent feature into a 1★ theme ('Cant use widgets without subscription', 1★)",
  "widgets partly gated 2025", "praise", "praise 24 (3.23%) vs paywalled 2 (1★)", "build-free", "interpretation", "yes", ["11481363538","12760639157","11077980453"])
c(144, "§4.2 widget problems — 'keeps getting disabled'; 'does not work on iphone :: waste money'; two of six widgets don't show days", "must-never-break",
  "A widget that fails for a payer reads as wasted money: 'does not work on iphone :: waste money' (1★ payer), 'keeps getting disabled', two of six widgets don't show days",
  "widget bugs", "complaint", "5 (0.67%), mean 3.40", "must-never-break", "emerging", "yes", ["11081066933","11520002759","12326097524"])
# §4.3
c(145, "§4.3 Cluster 3 — Local-first data: privacy praised (7): 'my data isn't stored on a server!'; 'Privacy focused too, so no servers with your data on'; 'hasn't been larded with privacy-invading trackers'", "insight",
  "No account and on-device data is praised as privacy: 7 reviews (0.94%, mean 4.29) — 'my data isn't stored on a server!'; 'Privacy focused too, so no servers with your data on'; 'hasn't been larded with privacy-invading trackers'",
  "local-first, no account", "praise", "7 (0.94%), mean 4.29", "build-free", "meaningful (cluster)", "yes", ["4497735688","6791860731","5753516491"])
c(146, "§4.3 The same design causes portability complaints — data lost on reinstall, reset or for no reason (4); no sync, explicit backup needed (3); no iPad/Mac/web/Watch (18); exit restricted (2, both 1★)", "must-never-break",
  "Local-only data loses users' history: data lost on reinstall, reset or for no reason (4) — 'after 9 months … All my data has been deleted!'; 'lost my data when I did a factory reset'; 'thought this app supports iCloud sync and re-installed app … lost all data as this app needs backup file'; no sync / manual backup needed (3) — 'iCloud sync doesn't work … I manually import/export'; 'basic sync is missing'",
  "local-only, manual backup file", "complaint", "lost 4; no-sync 3", "must-never-break", "meaningful (cluster)", "yes",
  ["4968235247","7344582690","10781087412","4289434524","3550808186","11674162846"])
c(147, "§4.3 'The only reason i'm going with a competitor at the moment is because I don't always want to use my phone'", "positioning",
  "Lack of iPad / Mac / web loses users to competitors: 'The only reason i'm going with a competitor at the moment is because I don't always want to use my phone' — and they state the conditional return ('A lifetime or yearly purchase with the app across the ecosystem and i'll be right back')",
  "iPhone only", "churn", "demand union 18 (2.42%)", "research", "meaningful", "yes", ["11077980453"])
c(148, "§4.3 Interpretation — portability is the cost of the privacy stance; optional iCloud sync would keep data off the developer's servers while fixing loss, multi-device use and exit", "product-rule",
  "Pair local-first privacy with optional iCloud sync: portability is the cost of the privacy stance, and optional iCloud sync keeps data off the developer's servers while fixing data loss, multi-device use and exit",
  "local only", "mixed", "privacy 7 vs loss 4 + no-sync 3 + platforms 18 + exit 2", "build-free", "interpretation", "yes", [],
  side="also unlocks iPad / Mac and removes reinstall data loss")
# §4.4
c(149, "§4.4 Cluster 4 — Trust events in 2025–26 (verbatim table)", "timeline",
  "Trust events 2025–26, each 1–2 reviews, coinciding with the E5 fall (mean 4.40, 1–2★ 11.0%): one-time option removed after an update (Nov 2025, 3★); 'Lifetime' stops working after a year or two (Jun 2026, 'False claim', 2★); CSV export disabled (Feb 2026, 'Vendor Lock', 1★); paid backup required to delete (Dec 2024, 1★); reminder time picker only offers 'today' near the current time — paid user ('I payed for this app … I might just cancel my membership', Dec 2025, 3★) and the same bug in China (Mar 2026, 5★); 20–30 launch attempts after the last two updates (Feb 2026, 5★ MISRATE); rating prompt before setup finished (Jan 2026, 3★)",
  "trust events", "complaint", table("## 4.4 Cluster 4"), "must-never-break", "weak individually; clustered in E5", "yes",
  ["13392990758","14138883204","13731751322","12046497872","13505537432","13868583107","13744408241","13586879451"])
c(150, "§4.4 Interpretation — a lifetime purchase and a local-first data model are both promises of continuity; the 2025–26 events touch exactly those promises; not yet a trend by count, but the cheapest set of problems to fix", "insight",
  "A lifetime purchase and a local-first data model are both promises of continuity, and the 2025–26 trust events (lifetime removed or unhonoured, export disabled, paid backup to delete) break exactly those promises — not a trend by count, but the cheapest set of problems to fix",
  "continuity promises broken", "churn", "8 events, 1–2 reviews each", "product-rule", "interpretation", "yes", [])
# §4.5
c(151, "§4.5 Cluster 5 — Localisation demand 19 (2.56%), mean 4.32, none 1★ — Chinese 9, Russian 4, Spanish 2, French 2, Ukrainian 1, 'more languages' 1", "market",
  "Localisation demand is polite and language-specific: 19 reviews (2.56%, mean 4.32, none 1★) — Chinese 9 ('I hope Chinese will be supported'; 'strongly calling for a Chinese version'; 'too expensive, and no Chinese'; Traditional Chinese; one on the US storefront), Russian 4 (one on the US storefront), Spanish 2 ('No está disponible en español 😿'), French 2 ('when will French come?'), Ukrainian 1, 'more languages' 1; 10.4% of 4★ carry it",
  "English only", "complaint", "19 (2.56%), mean 4.32; Chinese 9, Russian 4, Spanish 2, French 2, Ukrainian 1", "build-free", "meaningful", "yes",
  ["10084467787","10750194157","11798227360","10114649293","10120710103","3711570099","10790366652","11213904536","14365358902","11768720231","13381269097","11884894981","12121063578","10336343530","10098119560"])
c(152, "§4.5 11 of the 19 arrived in E3 (7.2%), starting the day of the June 2023 burst, which brought reviewers from br, vn, cn and co — the promotion reached non-English users the app could not serve", "timeline",
  "A promotion that reaches non-English markets produces localisation demand the app cannot serve: 11 of the 19 localisation requests arrived in E3 (7.2% of the era), starting the day of the June 2023 free-lifetime burst that brought reviewers from br, vn, cn and co",
  "English-only app promoted globally", "complaint", "11/19 in E3 (7.2%)", "do", "meaningful in E3", "yes", ["10084467787"],
  cond="localise before (or with) a global promotion")
# Part 5
c(153, "§5.1 5★ table (verbatim) and sub-populations — short affective, comparison verdicts, outcome stories, requests filed at 5★ (64), complaints filed at 5★ (5, MISRATE)", "data-caveat",
  "5★ band (591): core praise 77.7%, simplicity 43.7%, design 24.0%, best 17.4%, year grid 16.8%, utility 15.7%, competitor 15.1%, generic 11.0%, request 10.8%, developer 8.5%, payer 7.1%, outcome 5.6%; sub-populations — short affective reviews incl. most of the June 2023 burst; comparison verdicts; outcome stories; 64 requests at 5★ ('Almost Perfect … if you could add … that would make your app perfect'); 5 complaints at 5★",
  "n/a", "praise", table("## 5.1 5★"), "none", "corpus-level fact", "app-specific",
  ["10184986574","13649480321","14284351778","4310058011","5975293048","9265906731","3580101644","4289434524","9342516160","11145404810","13744408241","5475283125"])
c(154, "§5.2 4★ table (verbatim) — 4★ is the feature-request band: any request 42 (54.5%), widget demand 11 (14.3%), localisation 8 (10.4%)", "insight",
  "4★ is the feature-request band — reviewers name the missing piece between 4 and 5: any request 42 of 77 (54.5%), widget demand 11 (14.3%), localisation 8 (10.4%), friction 14 (18.2%), cap 7, quantities 6, price 6 — 'Once widgets launch this will be easily a 5-star application'; 'If that feature is added, this app would be a perfect 5 stars!'; 'the only reason I haven't given it five stars is because I really want a macOS app or web version' (a payer)",
  "n/a", "mixed", table("## 5.2 4★"), "research", "corpus-level fact", "yes", ["10811806786","10569299689","12188850466"])
c(155, "§5.3 3★ table (verbatim) — 3★ is the 'nice app, but the wall' band: monetisation friction 14 (51.9%), cap 9 (33.3%)", "insight",
  "3★ is the 'nice app, but the wall' band: monetisation friction 14 of 27 (51.9%), cap 9 (33.3%), design praised 7 (25.9%), reliability 5, requests 5, price / widget / data trust 3 each",
  "n/a", "complaint", table("## 5.3 3★"), "product-rule", "corpus-level fact", "yes", ["5526275566","10455939599","11852510890","12532587110","13392990758"])
c(156, "§5.4 2★ table (verbatim) — 2★ is the 'I'm leaving' band: friction 9 (81.8%), cap 5 (45.5%), explicit churn 4 (36.4%)", "insight",
  "2★ is the 'I'm leaving' band: friction 9 of 11 (81.8%), cap 5 (45.5%), explicit churn 4 (36.4%); also a Shortcuts bug, nagging, the lifetime complaint and an unclear onboarding",
  "n/a", "churn", table("## 5.4 2★"), "none", "corpus-level fact", "yes", ["12108620259","12221998930","12738794859","13740072982","11817893086","7879946381","14138883204","13288687749"])
c(157, "§5.5 1★ table (verbatim) — the paywall almost alone: friction 28 (75.7%), cap 15 (40.5%), other gated 8 (21.6%), price 7; only 3 reliability; only 2 of 37 payers; register 'Greedy', 'SCAMMT MONEY GRAB AGAIN', 'Another app that makes you pay to use it', 'Mercenário', 'Horrível tem que pagar'", "insight",
  "1★ is driven by the paywall almost alone: friction 28 of 37 (75.7%), cap 15 (40.5%), other gated feature 8 (21.6%), price 7 (18.9%), churn 5, confusing 4, data trust 3, reliability 3 — only 3 of 37 are reliability (data loss, reminders, widget), two more are data lock-in, only 2 of 37 are payers; the register is blunt — 'Greedy', 'SCAMMT MONEY GRAB AGAIN', 'Another app that makes you pay to use it', 'Mercenário', 'Horrível tem que pagar'",
  "n/a", "1★-burst", table("## 5.5 1★"), "product-rule", "corpus-level fact", "yes",
  ["4968235247","5535050975","12326097524","12046497872","13731751322","11326591912","12902043009","12172972006","5074213287","10828741313"])
c(158, "§5.6 Themes that cut across the rating line (verbatim table)", "data-caveat",
  "Cross-band reading: free cap 10 / 9 / 20 (mostly hostile, a quarter from 4–5★); price objection 13 / 3 / 9 (many 'great app, too expensive' 4–5★); widget demand 33 / 3 / 1 (a wish, not a grievance); localisation 17 / 1 / 1 (a wish); reliability 15 / 5 / 4 (forgiven); explicit payer 46 / 2 / 3 (happy); competitor named 95 / 1 / 2 (arrivals)",
  "n/a", "mixed", table("## 5.6 Themes that cut across"), "none", "corpus-level fact", "app-specific", ["9453178276","11097867630"])
c(159, "§5.6 The single most important cross-cutting fact: reviewers love what the app is and push back on what it withholds; the product is not failing, access to it is", "insight",
  "Reviewers love what the app is and push back on what it withholds — the product is not failing, access to it is",
  "strict free tier on a loved product", "mixed", "report gives none beyond §5.6 table", "product-rule", "interpretation", "yes", [])
# Part 6
c(160, "§6.1 Framing this correctly (verbatim table) — explicit payers 51 (6.86%, mean 4.63); one-time / lifetime mention 7; conditional intent 10 (4.40); no conversion rate claimed", "data-caveat",
  "Payer framing: explicit payers (first-person, any language) 51 (6.86%, mean 4.63), of which 7 (0.94%) praise a one-time / lifetime option; conditional intent 10 (1.35%, mean 4.40); global 743 (4.58); no conversion rate is claimed or claimable from review text",
  "n/a", "mixed", table("## 6.1 Framing this correctly"), "none", "method", "app-specific", [])
c(161, "§6.2 Payers are satisfied, and E5 is their weakest era (verbatim table) — E1 10 (18.9%, 4.80) · E2 16 (6.4%, 4.62) · E3 6 (3.9%, 5.00) · E4 6 (4.5%, 4.83) · E5 13 (8.4%, 4.23); split 42/4/2/1/2", "timeline",
  "Payers by era: E1 10 (18.9%, mean 4.80) · E2 16 (6.4%, 4.62) · E3 6 (3.9%, 5.00) · E4 6 (4.5%, 4.83) · E5 13 (8.4%, 4.23); rating split 42 at 5★, 4 at 4★, 2 at 3★, 1 at 2★, 2 at 1★",
  "n/a", "mixed", table("## 6.2 Payers are satisfied"), "none", "segment", "app-specific", [])
c(162, "§6.2 E1 had the highest payer share (18.9%): a $5–9 one-off made 'I bought it' easy", "monetization",
  "A cheap one-off unlock makes buying easy: E1, when Premium was a $5–9 one-time purchase, had the highest payer share of any era (18.9% of reviews vs 3.9–8.4% under subscription + lifetime)",
  "$5–9 one-off (2018–19)", "purchase-driver", "E1 18.9% vs E2 6.4, E3 3.9, E4 4.5, E5 8.4", "build-paid", "segment (self-selected)", "yes", ["3307938448","4462219747"],
  cond="self-reported payers, not conversion; E1 n=53")
c(163, "§6.2 E5 has the lowest payer mean (4.23): all three payers rating 1–2★ in E5 report a broken thing they paid for (widget, reminders, lifetime); payers turn negative when what they bought stops working, not because of price", "insight",
  "Payers turn negative when what they bought stops working, not because of price: E5 has the lowest payer mean (4.23), and every E5 payer rating low reports a broken thing they paid for — a widget, reminders (3★), the lifetime entitlement",
  "paid features broke", "churn", "E5 payer mean 4.23", "must-never-break", "segment", "yes", ["12326097524","13505537432","14138883204"])
c(164, "§6.3 What made people buy (verbatim table)", "data-caveat", "Purchase triggers with evidence", "n/a", "purchase-driver", table("## 6.3 What made people buy"), "none", "segment", "app-specific",
  ["9655320510","13242549122","13044612377","13597043858","10791117607","5293501237","11286612018","11583264179","3503457494","4462219747","4497735688","11737212105","13919822858","10854224657","8181313423","13093527963","13560914935","6884995801"])
c(165, "§6.3 The two free habits proved the method; they needed more — 'Having started with the two free grids I have today purchased the reasonably priced annual subscription'; 'After playing with the Free version (2 habits only) I knew … Bought the Lifetime and I was only 12 hrs into this'", "monetization",
  "The top purchase trigger is the free tier proving the method: 'Having started with the two free grids I have today purchased the reasonably priced annual subscription'; 'I'm so happy with it I went ahead and bought the full version'; 'After playing with the Free version (2 habits only) I knew … Bought the Lifetime and I was only 12 hrs into this'",
  "2 free habits → upgrade", "purchase-driver", "5 evidence reviews (most common trigger)", "build-paid", "segment", "yes", ["9655320510","13242549122","13044612377","13597043858","10791117607"])
c(166, "§6.3 A one-time / lifetime option instead of rent — 'I was able to go pro by paying once instead of a subscription'; 'it's lifetime access, instead of a subscription which was what I was looking for'; 'I hate subscriptions so I paid for lifetime … as an investment'", "monetization",
  "People who hate subscriptions buy lifetime: 'I was able to go pro by paying once instead of a subscription'; 'it's lifetime access, instead of a subscription which was what I was looking for'; 'odio las suscripciones así que pagué la versión lifetime … a modo de inversión'",
  "lifetime option", "purchase-driver", "4 evidence reviews; payer one-time praise 7", "build-paid", "segment", "yes", ["5293501237","11286612018","11583264179","3503457494"])
c(167, "§6.3 Supporting a solo developer — 'helps support an independent developer'; 'I paid the app to support solo developer'", "tactic",
  "Being visibly a solo indie developer converts: 'helps support an independent developer'; 'I paid the app to support solo developer' (5 evidence reviews; developer praise 13 of 51 payers, 25.5%)",
  "solo indie identity", "purchase-driver", "5 reviews; 13/51 payers praise developer", "do", "segment", "yes", ["4462219747","4497735688","11737212105","13919822858","10854224657"])
c(168, "§6.3 Extras: dark mode, colours, notes, import; design and aesthetics — 'aesthetics … made all the difference in my being willing to pay'", "monetization",
  "Cosmetic extras and aesthetics are what payers name as the paid value: dark mode, colours ('the visually appealing extras, such as customizable colors'), notes and import; 'a estética … fez total diferença para que eu estivesse disposta a pagar'",
  "extras paid", "purchase-driver", "6 evidence reviews", "build-paid", "segment", "yes", ["4462219747","4497735688","8181313423","13919822858","13093527963","3503457494"])
c(169, "§6.3 A discount — 'I took advantage of a 50% reduction offer, so I paid £9.99 for a whole year - bargain!'", "tactic",
  "A 50% discount offer converted at least one user: 'I took advantage of a 50% reduction offer, so I paid £9.99 for a whole year - bargain!' (Dec 2025)",
  "50% annual offer", "purchase-driver", "n=1", "research", "anecdotal", "yes", ["13560914935"])
c(170, "§6.3 Long-term use, then renewal — 'my one year anniversary of purchasing this app and I purchased another year again without hesitation'; a year of use, then lifetime", "insight",
  "Long-term users renew or upgrade to lifetime: 'my one year anniversary of purchasing this app and I purchased another year again without hesitation'; a year of use then lifetime",
  "annual → renewal / lifetime", "purchase-driver", "2 reviews", "none", "anecdotal", "yes", ["6884995801","8181313423"])
c(171, "§6.4 What buyers value once they have paid — simplicity 24 (47.1%), competitor comparison 16 (31.4%), price fair 14 (27.5%), design 14 (27.5%), developer 13 (25.5%), 'best' 12 (23.5%), life outcome 8, year grid 8, customisation 8, one-time pricing 7; 'I never buy apps. This is worth it … Take it from a penny pincher'", "insight",
  "Buyers value simplicity and speak in value terms: among 51 payers simplicity 24 (47.1%), competitor comparison 16 (31.4%), price fair 14 (27.5%), design 14 (27.5%), developer 13 (25.5%), 'best' 12 (23.5%), life outcome 8, year grid 8, customisation 8, one-time pricing 7 — 'I never buy apps. This is worth it … Take it from a penny pincher'; 'it's a very small price for what you get'; 'well worth the $20. It's changing my life'",
  "n/a", "praise", "segment rates on 51", "none", "segment", "yes", ["5005862431","13881561697","10965345926"])
c(172, "§6.5 What goes wrong after payment (verbatim table) — reminders 3 (5.9%); requests 8 (15.7%); price/trial 1; widget broken 1; lifetime lost 1; refund 1", "must-never-break",
  "What goes wrong after payment (segment rates on 51): reminders not firing 3 (5.9%) — a German 2019 buyer 'for support' got no notifications and returned the purchase; requests 8 (15.7%, Mac / web, stats, notes, quantities); price or trial objection while paying 1 ('Subtracted a star for cost (I paid for a month so far.)'); widget broken 1 ('waste money'); lifetime entitlement lost 1; refund / returned 1",
  "post-purchase failures", "complaint", table("## 6.5 What goes wrong after payment"), "must-never-break", "segment", "yes",
  ["4411089829","5535050975","13505537432","12188850466","3580101644","9082639448","11636711003","6831122754","12326097524","14138883204"])
c(173, "§6.5 No payer reports a billing dispute or unexpected charge — contrasts with peers where billing integrity is a leading payer theme", "contradiction",
  "No payer reports a billing dispute or unexpected charge — in contrast with peer apps where billing integrity is a leading payer theme; a simple plan shelf with a local-first, no-account app produced no billing complaints",
  "simple billing", "praise", "0 of 51 payers", "none", "segment", "yes", [])
c(174, "§6.6 Trial and upgrade barriers among non-payers — no trial / too short 7 (3.00); conditional intent 10 (4.40): lower price, more free habits first, iPad / Mac / iCloud, budget later, a month's trial on the monthly plan", "monetization",
  "Non-payers name what would convert them: no trial / too short 7 (0.94%, mean 3.00; 'I'm surprised there's no trial before making a commitment'); conditional intent 10 (1.35%, mean 4.40) — a lower price, more free habits first, iPad / Mac / iCloud ('I'd even pay for separate versions'; 'A lifetime or yearly purchase with the app across the ecosystem and i'll be right back'), budget later, and a month's trial on the monthly plan",
  "no/short trial; 2-habit cap", "blocked-conversion", "no trial 7 (3.00); conditional 10 (4.40)", "research", "emerging / meaningful", "yes",
  ["11939700468","13827396231","12738794859","4924456384","11097867630","9899413299","10581767784","11077980453","6836775244","11704110690","9996142813"])
c(175, "§6.7 The lifetime holder is the most sensitive customer — a lifetime purchase is a bet on continuity; their only negatives concern continuity; a lifetime model obliges the developer to honour and migrate, not withdraw", "product-rule",
  "A lifetime model obliges the developer to honour and migrate, not withdraw: a lifetime purchase is a bet on continuity, and lifetime holders' only negative reviews concern continuity — the one-time option disappearing and a lifetime licence that 'won't be working anymore'",
  "lifetime disputes", "churn", "2 reviews", "must-never-break", "interpretation", "yes", ["13392990758","14138883204"])
save("a")
