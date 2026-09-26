# Blind pass — report 20
Generated without access to cards.jsonl.

1. Header: Product is Habit — Daily Tracker (App Store ID 1445651730), tagline "Crush your goals like a boss"; developer of record at extraction Kodeon, Inc., bundle com.habit.habytracker.iosappplication.
2. Header: Corpus is 4,048 reviews across 82 storefronts, 27 Dec 2018 → 8 Aug 2026; extracted 8 Sep 2026 via itunes MZStore userReviewsRow.
3. Header: Mean rating 3.144; distribution 5★ 1,674 / 4★ 402 / 3★ 261 / 2★ 253 / 1★ 1,458.
4. How to read: every quantified finding gives count / percentage / denominator / time window / signal label / review IDs; IDs are App Store review_id, greppable against reviews.jsonl.
5. How to read: signal thresholds — <0.1% ignore by default; 0.1–<0.5% weak; 0.5–<1% emerging; 1–<3% meaningful; 3–5% very strong; >5% high-priority.
6. How to read #1: the corpus is two products — a beloved free habit tracker (Dec 2018 – 26 Jan 2021) and a monetised subscription app (27 Jan 2021 onward); global percentages average across both and understate both, so read era-relative rates.
7. How to read #2: the global mean 3.14 is an artefact of that split; pre-conversion mean 4.56 (n=2,066), post-conversion mean 1.62 (n=1,982); almost nobody experienced a "3-star" product.
8. How to read #3: volume is event-driven, not organic — 61.5% of the corpus (2,491 reviews) falls in two windows: the Jan–Feb 2021 pricing conversion and the Mar 2025 data wipe; review volume measures anger events, not usage.
9. How to read #4: 2019 volume is partly manufactured — the app shipped a review prompt whose decline button read "let the developers be sad"; 26 reviews (0.64%) explicitly say the prompt is why they wrote; true rate is certainly higher; inflates 2019's 5★ count; disclosed selection bias.
10. How to read #5: theme counts are non-exclusive; 917 reviews (22.65%) carry no theme — overwhelmingly short pure-sentiment posts ("Отлично", "Great app") with mean 3.80; counted in all denominators, add no thematic signal.
11. Exec #1: a single product decision destroyed the app, dated to the day — on 27 January 2021 the developer converted a "pay once, yours forever" IAP into an annual subscription.
12. Exec #1: on 27 Jan 2021 the developer revoked the entitlements of everyone who had already paid.
13. Exec #1: on 27 Jan 2021 the previously-unlimited free tier was capped at 3 habits.
14. Exec #1: daily review volume went from 2 (26 Jan) to 61 (27 Jan) to 135 (28 Jan); mean rating for those days 1.15–1.36.
15. Exec #1: 615 reviews (15.19%, high-priority) describe losing a purchase they had already made.
16. Exec #2: the thing they broke was the only differentiator — pre-conversion the app's entire market position was "the one habit tracker that gives you unlimited habits for free, with no subscription", said unprompted by 5★ reviewers for two years.
17. Exec #2: capping the free tier at 3 habits deleted the product's reason to exist; 63 reviews (1.56%) say exactly this; 99 (2.45%) complain about the 3-habit cap specifically.
18. Exec #3: the App Store listing still advertised the removed feature for years — reviews from Jan 2021 through Sep 2023 quote the live listing verbatim: "Unlimited amount of habits. You don't need to pay a penny."
19. Exec #3: 24 reviews (0.59%, emerging) call this false advertising by name; the cheapest fix in the report, unmade for over two years.
20. Exec #4: the paid tier never delivered its headline feature — the widget, the single most-cited reason people upgraded, did not work.
21. Exec #4: 182 reviews (4.50%, very strong) report a broken or absent widget; 113 of those (12.4% of all payers) are from confirmed payers.
22. Exec #4: the widget was still being reported broken in 2025, five years after first report, with an in-app FAQ acknowledging it and offering "restart your phone" as the fix.
23. Exec #5: support does not exist — 148 reviews (3.66%, very strong) report contacting support and getting nothing; among payers the segment rate is 10.7%.
24. Exec #5: the in-app "Contact Us" link pointed at a dead email address for years; the Instagram account stopped posting; this converts every recoverable bug into a permanent 1★.
25. Exec #6: in March 2025 they wiped everyone's data — version 1.41.0/1.42.x (13–15 Mar 2025) erased multi-year habit histories globally.
26. Exec #6: 233 reviews (5.76%, high-priority) report data loss; 126 of them (78.3% of that window) land in the 7 weeks after 13 Mar 2025; users reported losing 2, 3, 4 and 5 years of tracking.
27. Exec #6: the claimed fix (1.42.1) did not work for many; backup-to-iCloud was itself paywalled.
28. Exec #7: active billing-integrity problem still live in 2026 — 28 reviews (0.69%, emerging by volume, severe by nature) report the app advertising a discounted subscription (e.g. $5.99, 499₽, 85% off) then charging full price ($39.99, 3,150₽).
29. Exec #7: billing-mismatch reports run Dec 2021 to Apr 2025 across gb/us/ru/de/ua/kz/ca/lt; below threshold on volume but a consumer-protection exposure, not a UX nitpick.
30. Exec #8: the product people loved is fully documented and still buildable — a clean spec for a tracker people were delighted by: minimal (27.45%), beautiful (13.27%), unlimited, ad-free.
31. Exec #8: the genuine differentiator is a non-streak "habit strength" percentage that decays instead of resetting (0.94% explicit praise, but the highest-affection language in the corpus).
32. Exec #8: that decay model was itself broken by the 2021 rewrite and never restored.
33. Exec lesson: this is the most complete natural experiment in the category on what happens when you take back what you sold — 4.56-mean darling to 1.62-mean cautionary tale in one release, never recovered in the following five years.
34. §1.1: files used — reviews.jsonl (4,048 records primary corpus), by_country/*.jsonl (82 per-storefront files), manifest.json (extraction metadata), _state.json (extractor state, not used analytically).
35. §1.2: schema fields on every record — review_id, app_id, app_name, country, country_name, rating, title, body, author, date (ISO-8601 UTC), vote_count, vote_sum, is_edited.
36. §1.2: no version field exists — release attribution is inferred from review dates and from version numbers users type themselves (1.41.0, 1.42.1, 1.14.0, 1.14.1 appear in review text).
37. §1.3: reconciliation — 4,048 lines parsed, sum of by_country files = 4,048 exact match, 82 country files match manifest.storefronts_with_reviews, manifest.reviews_per_country identical for all 82.
38. §1.3: 4,048 unique review_ids, zero duplicate IDs; 0 exact duplicate title+body pairs — no deduplication performed or needed; 0 empty bodies.
39. §1.3: manifest.rating_distribution and manifest.mean_rating 3.144 identical to recount; date range 2018-12-27T14:13:58Z → 2026-08-08T16:32:53Z; 92 distinct months.
40. §1.3: is_edited = true on 51 reviews (1.26%), mean 2.84.
41. §1.3: denominator for all global percentages is 4,048; no record excluded for any reason (length, language, age, low information).
42. §1.4: all 4,048 reviews were read in date order in 22 batches, original language preserved (Russian, German, Spanish, French, Portuguese, Polish, Ukrainian, Italian, Turkish, Chinese, Japanese, Korean, Thai, Vietnamese, Swedish, Dutch, Arabic and others), not machine-translated.
43. §1.4: theme taxonomy was built from that reading, not from a keyword guess-list; a multilingual regex classifier of 49 themes covers English plus Russian, German, Spanish, French, Portuguese, Polish, Ukrainian, Italian and CJK phrasings for high-volume themes.
44. §1.4: validated by random per-theme sampling; three false-positive classes were found and fixed.
45. §1.4 fix 1: negated praise counted as complaint ("it doesn't constantly bug me about premium" scored as nagging) — negation guard added.
46. §1.4 fix 2: discount percentage alone counted as billing fraud ("70% off" is not a mis-charge) — tightened to require an explicit price-mismatch clause.
47. §1.4 fix 3: praise-vs-grievance collision — "one-time purchase" and "unlimited habits" appear in both 5★ praise and 1★ revocation; split into P-onetime-praise / P-unlimited-free (praise) and M-onetime-model / N-unlimited-removed (grievance), gated on rating and co-occurring revocation markers; post-fix praise-class means moved to 4.83 and 4.94.
48. §1.4: aggregated globally, by rating band, by storefront, by era, and by paid/non-paid cohort.
49. §1.5: recall is imperfect on low-volume themes; short non-English feature requests are the weakest area; themes below ~0.5% are floors, not exact counts.
50. §1.5: N-percent-confusion (0.49%) and N-checks-disappear (0.17%) are certainly undercounted — more instances seen while reading than the classifier caught.
51. §1.5: _paid is a text-evidence flag, not ground truth — 908 reviews (22.43%) state or strongly imply payment; real payer share unknowable; never read as a conversion rate.
52. §1.5: review-prompt selection bias in 2019 (disclosed).
53. §1.5: anger-event selection bias in 2021 and 2025 — silent satisfied users are systematically absent, especially post-2021.
54. §1.5: storefront ≠ nationality ≠ language — many ru reviews are in English, many us reviews in Spanish or Russian; "country" means storefront.
55. §1.5: survivorship in the tail — after mid-2021 most people who would have complained had already left; E3/E4/E5 rates are computed on a shrinking self-selected base.
56. §1.6 by year: 2018 n=1 mean 5.00 (first review 27 Dec); 2019 n=1,332 mean 4.75 (growth + review-prompt era); 2020 n=680 mean 4.24 (steady; iOS 14 widget promised).
57. §1.6 by year: 2021 n=1,475 mean 1.68 (conversion year); 2022 n=147 mean 2.05; 2023 n=121 mean 1.94; 2024 n=85 mean 2.07.
58. §1.6 by year: 2025 n=195 mean 1.44 (data-wipe year); 2026 n=12 mean 2.58 (partial, to 8 Aug).
59. §1.6 era E1 pre-conversion: 2018-12-27 → 2021-01-26, n=2,066 (51.0%), mean 4.56, 1,555 5★ / 67 1★.
60. §1.6 era E2 conversion + fallout: 2021-01-27 → 2021-06-30, n=1,258 (31.1%), mean 1.57, 66 5★ / 932 1★.
61. §1.6 era E3 long tail: 2021-07-01 → 2025-03-12, n=528 (13.0%), mean 1.93, 40 5★ / 305 1★.
62. §1.6 era E4 data wipe: 2025-03-13 → 2025-04-30, n=161 (4.0%), mean 1.31, 4 5★ / 135 1★.
63. §1.6 era E5 after: 2025-05-01 → 2026-08-08, n=35 (0.9%), mean 2.51, 9 5★ / 19 1★.
64. §1.6: storefront concentration — top 5 (us, ru, ca, gb, de) = 2,816 = 69.6% of corpus; Russia is the second-largest storefront at 23.5%, unusually high for the category and material to every global average.
65. §2.1: feature inventory is derived from what users describe; no external source consulted; nothing from marketing copy.
66. §2.1: create named habits with free text and emoji — universal; free, then capped at 3 after Jan 2021.
67. §2.1: tap to check off and back-fill previous days — universal, heavily praised; free throughout.
68. §2.1: habit-strength % ("2-day rule" / 91-day model) — free; decay behaviour broke in 2021 (4249750910, 5548125389, 7556821463, 8294993952).
69. §2.1: 5-day strip on home screen — free; persistent complaint that users want 7 days (4002933043, 6212755668, 6391933344).
70. §2.1: per-habit calendar + line graph — free (4786240616, 6425334871).
71. §2.1: frequency expressed as "N times in M days" — free; no weekday selection, ever (4547198891, 5985102033).
72. §2.1: one reminder per habit with custom message text — free; custom text widely loved (4406637526, 4760160029).
73. §2.1: "extended"/rich notifications — paid (4556013072, 6924164885).
74. §2.1: colour per habit (random by default) — 3 free, rest paid (3902556063, 5915798121).
75. §2.1: dark mode — was free-ish, became paid after Jan 2021 (5507533196, 9354551485).
76. §2.1: widget (Today-view, never Home Screen) — paid and largely non-functional (6503718035, 9954684066).
77. §2.1: manual iCloud backup/restore — paid after Jan 2021 (5963669614, 12486017227).
78. §2.1: drag to reorder habits — free, buggy (5085465606, 6124395270).
79. §2.1: no account / no signup — praised, and the root cause of data loss (3989149597, 6038787492).
80. §2.1: Apple Watch app never shipped (62 requests).
81. §2.1: iPad-native app never shipped (43 complaints).
82. §2.1: cross-device sync never shipped (84 mentions).
83. §2.1: streak counter never shipped (71 requests).
84. §2.1: notes/journal per day never shipped (79 requests).
85. §2.1: categories/folders never shipped (58 requests).
86. §2.1: multiple check-ins per day never shipped (54 requests).
87. §2.1: bad-habit / "failed" marking never shipped (34 requests).
88. §2.1: data export never shipped (9 requests).
89. §2.1: across 92 months the corpus records no significant new capability shipping; the only material changes users report are the paywall (2021), a widget that never worked, and two data-destroying updates; 6939282534 (us, 1★): "ZERO updates, content, features... NOTHING that justifies a yearly subscription fee."
90. §2.2: before 27 Jan 2021 pricing was pay-what-you-want, one-time, non-crippling — three tiers, user's choice, identical features.
91. §2.2: pre-conversion amounts reported — $2.99 / $4.99 / $14.99 (4035547945), £4.99 / £6.98 / £14.99 (4945935338), €5.49 (6922843265), 449₽ / 490₽ / 500₽ (6926974009, 7290434920, 6927207629), ₹399 (6956239325), CHF 5 (6172057750).
92. §2.2: the pay-what-you-want model was itself a marketing asset — 4945935338 (gb, 5★): "£4.99 to say thank you, £6.98 for liking the app and £14.99 for loving it and buy the developers a bottle of champagne."
93. §2.2: 35 reviews (0.86%) praise the pricing model explicitly, mean 4.83.
94. §2.2: after 27 Jan 2021 annual subscription full price as reported — $39.99 (us), £38.99 (gb), €43.99/44/45 (de/es/nl), CAD $52.99 (ca), AUD $65.99/66 (au), 3,150₽ → 3,199₽ (ru), HUF 15,500 (hu), PLN ~150–200 (pl), EGP 600+ (eg).
95. §2.2: promo prices offered — $11.99, $19.99, $9.99, $5.99, £11.99, 900–970₽, 499₽, €13.49.
96. §2.2: the multiple is the finding — US one-time $4.99 became $39.99 per year, ~8× first-year increase and unbounded thereafter; Russian 449₽ once became 3,150₽/year, a 7× annual multiple.
97. §2.2: 84 reviews (2.08%) quote the full annual price; 68 (1.68%) quote the old one-time price; both cohorts have a mean of ~1.5.
98. §2.3 free tier post-2021: 3 habits, 3 colours, light theme, 1 basic reminder per habit, calendar + graph, back-fill.
99. §2.3 paid tier (annual sub): unlimited habits, all colours, dark mode, extended notifications, manual iCloud backup/restore, widget (advertised; frequently non-functional).
100. §2.3 trial: inconsistent — several users report being charged immediately on what they believed was a trial (7199706726, 6973740694, 7744703720, 12463560595).
101. §2.3 unclear: whether legacy lifetime entitlements survive a device change — evidence says often not (11331516789, 12851060314, 13813023344, 9496355399).
102. §2.4 dark pattern 1: the non-expiring countdown — a "limited time offer" timer that resets on expiry forever, reported continuously Jan 2021 → Mar 2025; 6960081353 (gb): "When the premium offer ending counter finishes it just resets back to 60 hours." (7285176283, 7159264561, 7016202698, 9598232878).
103. §2.4: the countdown is part of the 225-review N-aggressive-popup cluster (5.56%, high-priority).
104. §2.4 dark pattern 2: full-screen interstitial on every launch with a small/low-contrast dismiss control; 6927664461 (us): "Dark patterns make bad UX!"
105. §2.4 dark pattern 3: add-habit button routed to the paywall, including after the user deleted a habit to make room (7266229179, 7090282099, 8381455001, 7266633441); this mechanic converted annoyance into uninstalls.
106. §2.4 dark pattern 4: promo price advertised, full price charged — 28 reviews.
107. §2.4 dark pattern 5: the review prompt whose decline option was "let the developers be sad" — 26 reviews say it worked on them; 9069346040 and 7133029560 call it emotionally manipulative and dock stars for it.
108. §3.1 #1: P-simple (minimal, easy, uncluttered) — 1,111 (27.45%), high-priority, mean 4.25, 42.8% of E1.
109. §3.1 #2: N-subscription-model — 829 (20.48%), high-priority, mean 1.56, 48.4% of E2.
110. §3.1 #3: N-revoked-purchase — 615 (15.19%), high-priority, mean 1.37, 41.3% of E2.
111. §3.1 #4: P-design (beautiful, aesthetic, colours) — 537 (13.27%), high-priority, mean 4.16, 20.8% of E1.
112. §3.1 #5: M-onetime-model (old pricing referenced) — 275 (6.79%), high-priority, mean 1.81, 17.2% of E2.
113. §3.1 #6: N-price-too-high — 242 (5.98%), high-priority, mean 1.52, 13.0% of E2.
114. §3.1 #7: N-data-loss — 233 (5.76%), high-priority, mean 1.43, 78.3% of E4.
115. §3.1 #8: N-aggressive-popup — 225 (5.56%), high-priority, mean 1.80, 12.6% of E2.
116. §3.1 #9: N-widget-broken — 182 (4.50%), very strong, mean 1.94, 12.1% of E3.
117. §3.1 #10: N-support-silent — 148 (3.66%), very strong, mean 1.33, 13.0% of E4.
118. §3.1 #11: X-widget-mention (neutral) — 128 (3.16%), very strong, mean 2.30, 7.4% of E3.
119. §3.1 #12: N-cancel-refund — 125 (3.09%), very strong, mean 1.28, 6.8% of E2.
120. §3.1 #13: N-habit-cap-3 — 99 (2.45%), meaningful, mean 1.94, 6.6% of E3.
121. §3.1 #14: N-restore-fail — 91 (2.25%), meaningful, mean 1.59, 5.8% of E2.
122. §3.1 #15: N-dark-mode — 89 (2.20%), meaningful, mean 2.69, 2.0% of E1.
123. §3.1 #16: N-sync-backup — 84 (2.08%), meaningful, mean 2.43, 9.9% of E4.
124. §3.1 #17: N-notes-journal — 79 (1.95%), meaningful, mean 3.66, 2.9% of E1.
125. §3.1 #18: P-outcome (real behaviour change) — 71 (1.75%), meaningful, mean 4.17, 2.4% of E1.
126. §3.1 #19: N-streak-count — 71 (1.75%), meaningful, mean 3.72, 2.4% of E1.
127. §3.1 #20: N-unlimited-removed — 63 (1.56%), meaningful, mean 1.51.
128. §3.1 #21: N-no-watch — 62 (1.53%), meaningful, mean 4.15, 2.4% of E1.
129. §3.1 #22: N-notifications — 59 (1.46%), meaningful, mean 3.07.
130. §3.1 #23: N-categories — 58 (1.43%), meaningful, mean 3.57, 2.0% of E1.
131. §3.1 #24: P-unlimited-free — 54 (1.33%), meaningful, mean 4.94, 2.6% of E1.
132. §3.1 #25: N-multi-per-day — 54 (1.33%), meaningful, mean 3.87, 2.1% of E1.
133. §3.1 #26: P-no-ads — 49 (1.21%), meaningful, mean 4.86, 2.3% of E1.
134. §3.1 #27: N-no-ipad — 43 (1.06%), meaningful, mean 3.33.
135. §3.1 #28: P-forgiving-algo — 38 (0.94%), emerging, mean 3.95.
136. §3.1 #29: P-onetime-praise — 35 (0.86%), emerging, mean 4.83.
137. §3.1 #30: N-bad-habits — 34 (0.84%), emerging, mean 3.94.
138. §3.1 #31: N-colors — 33 (0.82%), emerging, mean 3.76.
139. §3.1 #32: N-widget-request — 28 (0.69%), emerging, mean 3.82.
140. §3.1 #33: N-billing-mismatch — 28 (0.69%), emerging (severe), mean 1.64.
141. §3.1 #34: N-crash — 27 (0.67%), emerging, mean 2.52.
142. §3.1 #35: P-review-nag (prompt-driven) — 26 (0.64%), emerging, mean 4.54.
143. §3.1 #36: N-compact-layout — 26 (0.64%), emerging, mean 4.27.
144. §3.1 #37: P-custom-reminder — 25 (0.62%), emerging, mean 4.60.
145. §3.1 #38: N-7days (only 5 days shown) — 25 (0.62%), emerging, mean 3.32.
146. §3.1 #39: N-false-advertising — 24 (0.59%), emerging, mean 1.21.
147. §3.1 #40: N-weekday-select — 22 (0.54%), emerging, mean 3.64.
148. §3.1 #41: N-percent-confusion — 20 (0.49%), weak (undercounted), mean 3.30.
149. §3.1 #42: N-privacy — 17 (0.42%), weak, mean 1.94.
150. §3.1 #43: N-no-account — 16 (0.40%), weak, mean 2.19.
151. §3.1 #44: N-localization — 10 (0.25%), weak, mean 3.70.
152. §3.1 #45: N-export — 9 (0.22%), weak, mean 4.44.
153. §3.1 #46: N-checks-disappear — 7 (0.17%), weak (undercounted), mean 2.14.
154. §3.1 #47: N-archive — 4 (0.10%), weak, mean 4.50.
155. §3.1 #48: N-timezone — 3 (0.07%), ignore by default, mean 4.00.
156. §3.2: trust family (N-revoked-purchase ∪ N-restore-fail ∪ N-cancel-refund ∪ N-billing-mismatch ∪ N-false-advertising ∪ N-support-silent) = 810 reviews, 20.01% of corpus, mean 1.39.
157. §3.2: union of every feature-gap theme (watch, iPad, sync, streaks, notes, categories, multi-per-day, weekday, export, archive, colours, compact, 7-day, bad habits) = 513 reviews, 12.67%, mean 3.57.
158. §3.2: trust complaints outnumber feature complaints by 1.58× and carry 2.2 stars less — the single most important structural fact; the app did not fail on features, it failed on keeping promises.
159. §3.3: five lowest-mean themes — N-false-advertising 24 @ 1.21; N-cancel-refund 125 @ 1.28; N-support-silent 148 @ 1.33; N-revoked-purchase 615 @ 1.37; N-data-loss 233 @ 1.43.
160. §3.3: N-false-advertising read — the listing described a product that no longer existed.
161. §3.3: N-cancel-refund read — money taken, no exit, no reply.
162. §3.3: N-support-silent read — the multiplier on every other defect.
163. §3.3: N-revoked-purchase read — the core breach.
164. §3.3: N-data-loss read — the thing a tracker exists to prevent.
165. §3.3: every one of the five lowest-mean findings is an integrity failure, not a capability gap; none requires new product surface to fix.
166. §3.4: minimalism — 1,111 (27.45%), 42.8% of E1, mean 4.25; reviewers frame it against competitors, having tried 5, 10, 20 cluttered or gamified trackers (3601977788, 4423183878, 4633148866, 4836612463).
167. §3.4: visual design — 537 (13.27%), 20.8% of E1, mean 4.16; colour-filling bubbles that grow with habit strength; described as the reason they open the app (3940095679, 4121063134, 4497709123, 4723686998).
168. §3.4: unlimited habits free — 54 explicit (1.33%), mean 4.94, the highest-mean theme in the corpus (3608816066, 3895739282, 3999790253, 4184551703).
169. §3.4: no ads — 49 (1.21%), mean 4.86 (3601977788, 3904267605, 3980990590, 4120408877).
170. §3.4: the forgiving habit-strength model — 38 explicit (0.94%), mean 3.95; the real differentiator; missing a day reduces the score instead of zeroing a streak, preventing the "what the hell" abandonment spiral.
171. §3.4: 6179162507 (us, 5★): "most focus too much on 'streaks'... missing one day and breaking my streak tends to send me into a spiral where I give up."
172. §3.4: 7556821463 (de, 5★) explains the strength model as logarithmic rather than linear and calls it "much closer to psychological reality" (also 4249750910, 5548125389, 6213055572, 6815111095).
173. §3.4: custom reminder text — 25 (0.62%), mean 4.60; users write their own motivational line and get it back in the notification; small feature, outsized affection (3892496995, 4035547945, 4406637526, 4760160029).
174. §3.4: documented outcomes — 71 (1.75%), mean 4.17; medication adherence, exercise, study, sobriety, hydration.
175. §3.4: 8294993952 (ru, 5★) credits the app with discipline that led to moving country, starting a relationship, founding a company — "and it all starts with 'make your bed every day'."
176. §3.5: genuine capability gaps are polite requests with high ratings — these people wanted to stay.
177. §3.5 gap: notes/journal per day — 79, mean 3.66, most-requested single feature.
178. §3.5 gap: streak counter — 71, mean 3.72, requested alongside, not instead of, the % model.
179. §3.5 gap: Apple Watch app — 62, mean 4.15, highest-mean gap, asked by fans.
180. §3.5 gap: categories/folders — 58, mean 3.57, scales with habit count.
181. §3.5 gap: multiple check-ins per day — 54, mean 3.87; water, medication, teeth are the canonical examples.
182. §3.5 gap: iPad-native app — 43, mean 3.33.
183. §3.5 gap: bad-habit / "failed" marking — 34, mean 3.94, distinct from good-habit tracking.
184. §3.5 gap: specific weekdays — 22, mean 3.64; "3× a week" ≠ "Mon/Wed/Fri".
185. §3.5 gap: data export — 9, mean 4.44.
186. §3.5 gap: archive completed habits — 4, mean 4.50.
187. §3.5 broken: widget non-functional — 182, mean 1.94.
188. §3.5 broken: data loss — 233, mean 1.43.
189. §3.5 broken: restore purchase fails — 91, mean 1.59.
190. §3.5 broken: notifications wrong/absent — 59, mean 3.07.
191. §3.5 broken: crashes — 27, mean 2.52.
192. §3.5 broken: check marks disappearing — 7, mean 2.14.
193. §3.5 misunderstanding: the habit-strength percentage — 20 classified (0.49%, undercounted); a weekly habit completed once shows 4%, not 100%; the developer's public answer (~91 repetitions to reach 100%) reads as arbitrary (4839534150, 5364934470, 5698098227, 5865009022).
194. §3.5: the percentage confusion is a documentation failure, not a maths failure, and the one complaint that is cheap to fix.
195. §3.5 pricing objections: 242 N-price-too-high + 829 N-subscription-model want the product but reject the model; many state a price they would pay — $5–15 one-time recurs constantly.
196. §3.5: 6922110474 (us): "I would be willing to pay $10-$15 per year, but even the promo price of $20 is too high."
197. §3.6: 145 reviews (3.58%) name an alternative; the winner of the churn is unambiguous.
198. §3.6 competitor: Streaks — 26, mean 3.23.
199. §3.6 competitor: Done — 4, mean 4.25.
200. §3.6 competitor: Habitica — 3, mean 2.00.
201. §3.6 competitor: Habit List — 3, mean 2.67.
202. §3.6 competitor: Todoist — 3, mean 3.00.
203. §3.6 competitor: Productive — 2, mean 4.50.
204. §3.6 competitor: Tally — 2, mean 3.50.
205. §3.6 competitor: (Not Boring) Habits — 2, mean 4.00.
206. §3.6 competitor: Fabulous — 2, mean 3.50.
207. §3.6 competitors named once each: Loop, Strides, TickTick, Notion, Onrise, Way of Life.
208. §3.6: Streaks is named as the destination 26 times, overwhelmingly in Feb 2021, explicitly because it is a one-time purchase; 6921814497 (us): "I'm gonna use Streaks, even though I like this app better. $40 a year, this ain't worth."
209. §3.6: 6928343835 (us) lists Streaks' advantages — Apple Health, custom icons, multiple reminders, Apple Watch support, updated iOS 14 widget — a complete competitive gap analysis written by a churning customer.
210. §4.1: distribution is bimodal — 5★ 41.35%, 4★ 9.93%, 3★ 6.45%, 2★ 6.25%, 1★ 36.02%; 77.4% of reviews are at one extreme; signature of a product that was excellent then did something to its users, not quality variance.
211. §4.2: 5★ band (n=1,674, 41.35%) earned by minimalism (773 = 46.2% of band), design (346 = 20.7%), documented outcomes (52 = 3.1%), unlimited-free (51 = 3.0%), ad-free (46 = 2.7%).
212. §4.2: 93% of 5★ reviews predate the conversion — the band is essentially a photograph of E1.
213. §4.2 caveat: 26 reviews in the 5★ band say outright the review prompt is why they wrote; true prompt-driven share is higher.
214. §4.2: 23 reviews in the 5★ band carry N-revoked-purchase — these are amended reviews by users restored in Feb 2021 who raised their score (6979960168, 6997900077, 7003059038, 7004585831).
215. §4.3: 4★ band (n=402, 9.93%) is the "one thing away" band — minimalism (132) and design (76) lead, but defined by a single named blocker: streaks (22 = 5.5%), notes (20), multi-per-day (20), broken widget (18), categories (16), iPad (15), sync (15), Apple Watch (15).
216. §4.3: the 4★ band is the most commercially useful — people liked the product enough to rate it well and said exactly what would make it a 5; almost none of it was ever built.
217. §4.4: 3★ band (n=261, 6.45%) is the ambivalence band — praise and grievance in the same review: minimalism 43 / subscription objection 41 / design 28 / pop-ups 26 / revocation 26 / broken widget 22.
218. §4.4: 7041165859 (us) is the 3★ archetype: "Both the Best and Most Annoying App I've Ever Used."
219. §4.5: 2★ band (n=253, 6.25%) is the buyer's-remorse band — subscription objection 64 (25.3%) / pop-ups 41 / revocation 34 / broken widget 33 (13.0%, the band's peak) / price 28.
220. §4.5: design (28) and minimalism (32) still appear in 2★ — people who still like the app rating it down on commercial conduct alone.
221. §4.6: 1★ band (n=1,458, 36.02%) is the breach band — N-subscription-model 636 (43.6%), N-revoked-purchase 515 (35.3%), M-onetime-model 200 (13.7%), N-data-loss 183 (12.6%), N-price-too-high 181 (12.4%), N-aggressive-popup 134 (9.2%).
222. §4.6: 1★ band continued — N-support-silent 124 (8.5%), N-cancel-refund 106 (7.3%), N-widget-broken 99 (6.8%), N-restore-fail 70 (4.8%).
223. §4.6: P-simple appears in 131 one-star reviews (9.0% of band) — they praise the product's simplicity in the same breath as condemning the company; not a quality problem.
224. §4.6: 6927013041 (gb): "I thought I found the holy grail for habits: simple, beautiful… Now the app has gone with a subscription model, effectively leaving all the previous Premium users with nothing."
225. §4.7: among 148 support-silence reviews the mean is 1.33, third-lowest of any theme; of 30 reviews Feb–Dec 2021 recording being restored or fixed, mean is 3.63 (5★: 10, 4★: 11).
226. §4.7: the same defect produces 1.33 or 3.63 depending entirely on whether anyone answered — a support function would have been worth roughly +2.3 stars on every recoverable incident.
227. §5.1: 908 reviews (22.43%) contain explicit textual evidence of payment — a floor, not a conversion rate; payers over-represented among reviewers.
228. §5.1: payment-evidence cohort 908 (22.43%) mean 1.55 vs no-payment-evidence 3,140 (77.57%) mean 3.61.
229. §5.1: paying customers rated the product 2.06 stars lower than non-payers; in a healthy product this is inverted; here paying exposed you to harm.
230. §5.2 trigger 1: the widget — by a wide margin the single most-named purchase trigger (6866660903, 6898884130, 6932683997, 7516808714); also the feature that most often didn't work — the corpus's central commercial irony.
231. §5.2 trigger 2: support/gratitude, not utility — a large share of pre-2021 purchases were donations; 4772030419 (ca): "I'll definitely choose the highest one because this developer deserves the best"; 4910351390 (ru): bought "as a 'thank you'" (also 4905355436, 5537329915).
232. §5.2 trigger 3: dark mode (6921346177, 6938362371, 6975061472, 9354551485).
233. §5.2 trigger 4: unlimited habits, post-2021, under duress (6940257847, 7266229179).
234. §5.2 trigger 5: backup/iCloud (6924711463, 6926653399, 7104682610).
235. §5.2 trigger 6: the pricing model itself — people bought because it wasn't a subscription; 6927136939 (ru): "I bought your app precisely because it wasn't a subscription"; this is why the conversion felt like betrayal rather than a price change.
236. §5.3 payer segment rates (denominator 908): N-revoked-purchase 472 (52.0%) of global 615; N-subscription-model 460 (50.7%) of 829; M-onetime-model 169 (18.6%) of 275.
237. §5.3 payer segment rates: N-widget-broken 113 (12.4%) of 182; N-price-too-high 110 (12.1%) of 242; N-support-silent 97 (10.7%) of 148.
238. §5.3 payer segment rates: N-data-loss 91 (10.0%) of 233; N-cancel-refund 79 (8.7%) of 125; N-restore-fail 69 (7.6%) of 91; N-dark-mode 39 (4.3%) of 89.
239. §5.3: segment rates are not comparable to the global thresholds in §3.1.
240. §5.3 concentration: 76.8% of revocation complaints, 62.1% of widget complaints, 75.8% of restore failures and 65.5% of support complaints come from the ~22% of reviewers who paid — the paid experience was materially worse than the free one.
241. §5.4 barrier: price/model mismatch — "I'd pay once; I won't rent"; 8537740813 (gb): "I will NEVER EVER PAY A SUBSCRIPTION FOR THIS APP... If you were to make it a paid app, I would definitely purchase it" (also 7470777218, 9459852981, 10684402507).
242. §5.4 barrier: value not demonstrated before the ask — 7410157966 (ru): "first the consumer must see the value of the product. And what do you have? Every 2 seconds a 'subscribe' banner" (also 7181761042, 8260890448, 12025762934).
243. §5.4 barrier: reviews as deterrent — people report reading the reviews and not installing (7411209420, 7874758944, 8321275133, 9909767891).
244. §5.4 barrier: feature parity failure — by 2022+ competitors offered Watch apps, Home Screen widgets, Health integration and multi-daily tracking at lower prices; 12233815050 (ae): "literally just a glorified reminder tool... overpriced and under delivers massively."
245. §5.5: 125 reviews (3.09%, mean 1.28) concern refunds or cancellation, in three failure modes.
246. §5.5 mode 1: refund requested, ignored — dominant in Feb 2021; several report Apple refunding where the developer would not (6943651180 de, 6955346810 us, 7039272649 ca, 6937584026 se).
247. §5.5 mode 2: cannot cancel — reported 2022–2025; 9371176438 (us) alleges the cancellation path breaks FTC transparency expectations (also 9511675705, 9568655119, 9583675777, 10751290760).
248. §5.5 mode 3: charged without intent — trial-to-paid surprises and accidental Touch-ID purchases during onboarding (7199706726, 7712053776, 7744703720, 8883167931, 12463560595).
249. §5.5: Feb 2021 remediation — from ~5 Feb 2021 the developer began responding with a form reply signed "Marlene"; by ~15–17 Feb an update users cite as 1.14.1 made Restore Purchases work again; 30 reviews record restoration, many revised upward.
250. §5.5 remediation flaw (a): it took three weeks of daily 1★ inflow.
251. §5.5 remediation flaw (b): the initial remedy offered was one free year, not permanent restoration, rejected as inadequate — 6958039907 (us): "either update my purchases as originally agreed upon or refund what I paid" (6972336692, 6969229255).
252. §5.5 remediation flaw (c): it was never announced — 7026534551 (ca): "4 stars after premium was restored, but not 5 stars because the devs ignored us for so long and have not acknowledged the issue."
253. §5.5 remediation flaw (d): it did not hold — revocation reports recur 2021–2026: 7176715543 (nl, Apr 2021), 8632062766 (ca, May 2022), 10531496818 (ca, Oct 2023), 11696455228 (gb, Sep 2024), 12421451179 (ca, Mar 2025), 12999175131 (at, Aug 2025), 13669398619 (ru, Jan 2026).
254. §6.1: 11 storefronts have ≥50 reviews and are analysed individually — us, ru, ca, gb, de, au, ua, pl, es, fr, in; together 3,310 reviews = 81.8%.
255. §6.1: 71 storefronts fall below 50 (738 reviews = 18.2%); included in global calculations, no standalone conclusions except where labelled [limited evidence].
256. §6.2 us: n=963, mean 3.13, revoked 18.8%, sub-model 20.0%, price 7.0%, data loss 8.4%, pop-ups 6.7%, widget 5.6%, support 4.7%, 3-cap 2.9%, simple 30.0%, design 16.9%.
257. §6.2 ru: n=951, mean 3.28, revoked 7.9%, sub-model 19.7%, price 2.2%, data loss 3.8%, pop-ups 4.7%, widget 0.5%, support 1.7%, 3-cap 2.4%, simple 31.4%, design 11.6%.
258. §6.2 ca: n=442, mean 3.45, revoked 19.0%, sub-model 19.7%, price 7.0%, data loss 4.1%, pop-ups 6.1%, widget 5.4%, support 4.1%, 3-cap 1.8%, simple 35.5%, design 16.1%.
259. §6.2 gb: n=298, mean 2.74, revoked 26.2%, sub-model 28.5%, price 13.4%, data loss 8.7%, pop-ups 11.1%, widget 5.7%, support 4.4%, 3-cap 4.0%, simple 25.8%, design 11.4%.
260. §6.2 de: n=162, mean 2.52, revoked 13.0%, sub-model 29.0%, price 8.0%, data loss 6.2%, pop-ups 6.8%, widget 8.0%, support 3.7%, 3-cap 1.9%, simple 20.4%, design 19.1%.
261. §6.2 au: n=114, mean 2.81, revoked 27.2%, sub-model 34.2%, price 14.0%, data loss 10.5%, pop-ups 11.4%, widget 5.3%, support 9.6%, 3-cap 2.6%, simple 21.1%, design 11.4%.
262. §6.2 ua: n=111, mean 3.24, revoked 9.9%, sub-model 12.6%, price 0.9%, data loss 2.7%, pop-ups 3.6%, widget 3.6%, support 2.7%, 3-cap 2.7%, simple 12.6%, design 5.4%.
263. §6.2 pl: n=72, mean 2.44, revoked 30.6%, sub-model 25.0%, price 1.4%, data loss 12.5%, pop-ups 5.6%, widget 5.6%, support 8.3%, 3-cap 8.3%, simple 8.3%, design 13.9%.
264. §6.2 es: n=71, mean 2.63, revoked 2.8%, sub-model 11.3%, price 16.9%, data loss 1.4%, pop-ups 1.4%, widget 4.2%, support 1.4%, 3-cap 1.4%, simple 28.2%, design 8.5%.
265. §6.2 fr: n=66, mean 3.03, revoked 10.6%, sub-model 16.7%, price 7.6%, data loss 1.5%, pop-ups 1.5%, widget 3.0%, support 1.5%, 3-cap 0.0%, simple 34.8%, design 13.6%.
266. §6.2 in: n=60, mean 3.07, revoked 13.3%, sub-model 28.3%, price 10.0%, data loss 8.3%, pop-ups 1.7%, widget 8.3%, support 3.3%, 3-cap 3.3%, simple 26.7%, design 13.3%.
267. §6.3: Group A (high-review-volume) = us, ru, ca, gb, de; n=2,816 = 69.6% of corpus, mean 3.19; this group is the corpus for practical purposes; its two largest members behave very differently and drive most global averages.
268. §6.4: the corpus contains no revenue, download or spend data; Group B (high-spend) is defined from general knowledge of App Store consumer-spend rankings — us, gb, de, ca, au, fr; Japan qualifies commercially but has only 8 reviews so is excluded.
269. §6.4: Group B membership is an analyst assumption, not a fact established by this corpus or a verified source; treat as a lens; review volume is not used as a spend proxy anywhere.
270. §6.4: Group B n=2,045 (50.5%), mean 3.06 vs ru+ua n=1,062, mean 3.28 (delta −0.22).
271. §6.4: Group B vs ru+ua — revoked purchase 19.3% vs 8.1% (+11.2 pts); price too high 8.4% vs 2.1% (+6.3); data loss 7.0% vs 3.7% (+3.3); widget broken 5.8% vs 0.8% (+5.0); support silence 4.8% vs 1.8% (+3.0).
272. §6.4: revocation and delivery grievances are concentrated in exactly the markets that generate revenue — Group B reports revocation at 2.4× the ru/ua rate and broken widgets at 7×; the damage landed hardest on the highest-value cohort.
273. §6.5: Russia (n=951, mean 3.28) is 23.5% of the corpus and rates the app higher than the US, UK, Germany or Australia despite the same product — the corpus's biggest anomaly.
274. §6.5 reason 1: timing — Russian reviews are weighted to 2019 when the app was free, ad-free, unlimited and the "let the developers be sad" prompt was harvesting reviews; Russian 5★ reviews are frequently one line ("Отлично", "Супер", "Ничего лишнего").
275. §6.5 reason 2: the widget complaint is almost absent in Russia — 0.5% vs 5.6% in the US — because Russian users largely did not buy the widget; a purchase-exposure difference, not a satisfaction difference.
276. §6.5 reason 3: Russian price objections are absolute, not comparative — 3,150₽/year called simply unaffordable or absurd for a checkbox app (6925082543, 6925476346, 7183192208, 7389399093), not framed as a broken bargain.
277. §6.5 reason 4: when Russians were exposed they reacted identically — 75 Russian revocation complaints are among the angriest; the top two most-upvoted reviews in the corpus are Russian revocation complaints (6918320995, 39 net votes; 6919032834, 27).
278. §6.5: do not read Russia's 3.28 as evidence the product worked better there; it reflects when those users arrived and what they bought.
279. §6.6 Poland (n=72, mean 2.44): highest revocation rate in the corpus (30.6%) and highest data-loss rate (12.5%); clearest "good app, terrible policy" split (10861684977, 12418376691).
280. §6.6 Germany (n=162, mean 2.52): highest subscription-objection rate among large markets (29.0%) and the most legally-framed language ("Abzocke", "Betrug", "Fall für die Aufsichtsbehörde" — 6931210500, 6944765620, 6970697308, 7048580615).
281. §6.6 Germany: also has the highest design-praise rate (19.1%) — they liked it and were angriest about it.
282. §6.6 Australia (n=114, mean 2.81): worst combination of revocation (27.2%), subscription objection (34.2%), price (14.0%) and support silence (9.6%); AUD $65.99/year is the highest price point reported anywhere.
283. §6.6 United Kingdom (n=298, mean 2.74): 26.2% revocation, 13.4% price, 11.1% pop-ups; £38.99 repeatedly called disproportionate.
284. §6.7 Spain (n=71, mean 2.63): revocation only 2.8% (lowest of any eligible market) but price objection 16.9% (highest); Spanish users arrived after the conversion so never lost anything, they simply refused €43.99.
285. §6.7: the grievance profile follows arrival date, not nationality.
286. §6.7 France (n=66, mean 3.03): 34.8% simplicity praise (highest alongside Canada), 0% habit-cap complaints, low everything else — a predominantly E1 cohort.
287. §6.8: feature requests are strikingly uniform by country — Apple Watch, notes, streaks, categories, multi-per-day and weekday selection appear at similar rates in every measurable storefront; no localisation-specific product need in the corpus.
288. §6.9 [limited evidence]: only 10 reviews (0.25%, weak) raise language.
289. §6.9: the app shipped Russian-first UI to some non-Russian users (5548679381 cn, 5121688833 fr, 5303861781 ch — a German user asking how to get English).
290. §6.9: Chinese support existed and was later lost — 13178312149 (2025): "why no Chinese, there was Chinese a few years ago."
291. §6.9: translation quality criticised in German and Spanish (6880333515, 6219859799, 6528512849).
292. §6.9: Ukrainian was requested and never added (8870732609).
293. §6.10 [limited evidence]: 71 sub-50 storefronts, 738 reviews; nothing supports a standalone conclusion.
294. §6.10: small storefronts skew to the extremes — cy (n=3) 1.00, si (n=3) 1.33, sk (n=3) 1.33, rs (n=2) 1.00, ec (n=2) 1.00 are all post-conversion arrivals; cr (n=4) 5.00, ve (n=3) 4.67, ng (n=5) 4.80 are all E1.
295. §6.10: Asian storefronts skew positive and early — vn (40) 4.03, ph (38) 4.08, cn (35) 4.06, tw (17) 4.06, id (18) 4.33; E1-weighted, and the widget failure barely reaches them.
296. §6.10: South Korea (n=15, mean 2.40) is the most negative small market — 5 of 15 reviews are revocation or premium-not-working reports (6923303445, 6926102098, 6932463780, 6939881361, 6946432090).
297. §7.1 method: trends assessed by monthly volume and mean, era-relative theme rates, and date-anchored event windows; a trend is claimed only where volume supports it, otherwise listed in §7.8 as not claimed.
298. §7.2 [very strong] Trend 1 daily table: 2021-01-25 n=1 mean 5.00; 01-26 n=2 mean 2.00; 01-27 n=61 mean 1.15; 01-28 n=135 mean 1.36; 01-29 n=127 mean 1.22; 01-30 n=67 mean 1.27; 01-31 n=60 mean 1.32; 02-01 n=62 mean 1.23.
299. §7.2: monthly context — Dec 2020 = 38 reviews mean 4.29 → Jan 2021 = 503 reviews mean 1.54 → Feb 2021 = 485 mean 1.60.
300. §7.2: a 13× volume increase and a 2.75-star collapse in 24 hours; the mean never recovered — every subsequent year sits between 1.44 and 2.58.
301. §7.3 [very strong] Trend 2: the free tier was gutted at the same moment — pre-conversion unlimited habits was the headline; post-conversion the cap is 3; N-habit-cap-3 runs at 6.6% of E3.
302. §7.3: N-habit-cap-3 registers 0.48% in E1 (10 reviews) but all ten are praise-context false positives — 5★ reviews thanking this app for not capping habits while describing competitors that do (3918690923, 4225873197, 4226652382, 5616772165); genuine E1 rate effectively zero.
303. §7.3: N-unlimited-removed (63 reviews) is entirely post-conversion.
304. §7.3: the cap behaved as a lifetime cap, not a concurrent one — users who deleted a habit to make room could not add a replacement (7266229179, 7266633441, 7090282099, 7451472900); this turned a pricing decision into a functional dead end.
305. §7.4 [very strong] Trend 3: aggressive monetisation UX arrived and never left — N-aggressive-popup 12.6% of E2 → 8.1% of E3.
306. §7.4: N-aggressive-popup registers 0.82% in E1 (17 reviews) but these are praise-context false positives — users praising the app for not nagging (4152251500, 4658115513, 4907892894, 6716937579); genuine E1 rate effectively zero.
307. §7.4: the non-expiring countdown is reported Jan 2021 to Mar 2025 — over four years of a "limited time offer" (6920136171 Jan 2021, 7130719014 Mar 2021, 7696949663 Aug 2021, 8774978626 Jun 2022, 9598232878 Feb 2023, 10403199089 Sep 2023, 12548894139 Apr 2025).
308. §7.5 [very strong] Trend 4: the widget — promised 2020, broken through 2025, never fixed.
309. §7.5 timeline: Apr 2019 — a Today-view widget ships as a paid feature and works (3995542358, 4474121227).
310. §7.5 timeline: Sep–Dec 2020 — iOS 14 arrives; users ask for the Home Screen widget; the listing/store screenshots show one; purchases begin specifically for it (6460660006, 6744055213, 6777922510).
311. §7.5 timeline: Jan 2021 onward — the widget is broken or absent for large numbers of payers; the in-app FAQ's first question addresses it; the fix offered is "restart your phone"; it doesn't work.
312. §7.5 timeline: 2022–2025 still reported — 8625708859 (May 2022), 9365771044 (Dec 2022), 10034018726 (Jun 2023), 11099954846 (Mar 2024), 12456466846 (Mar 2025).
313. §7.5 clarification: even when present it was the Today-view widget, not a Home Screen widget — 9954684066 (us, 2023) and 9400779376 (us, 2022) both bought expecting Home Screen placement.
314. §7.5: 182 reviews, mean 1.94, five years, no fix — the clearest sustained delivery failure in the report.
315. §7.6 [very strong] Trend 5: support degraded from responsive to absent — in 2019 the developer answered reviews and fixed reported bugs: 6319774608 (us) documents a bug fixed and the developer following up; 4702811610 (ru) changed a rating after a developer reply; 6560591296 (cn) praises a same-day fix in Oct 2020.
316. §7.6: N-support-silent runs 0.05% of E1 (a single review) → 6.6% of E2 → 8.0% of E3 → 13.0% of E4.
317. §7.6: from 2022 users report the in-app "Contact Us" pointing to a dead email address with an autoresponder telling them to write elsewhere (8651373725, 11655625375, 11590913646, 9623996845).
318. §7.6: the Instagram account — the app's other stated support channel — has been dormant since 2019 (6937097883, 11408456954).
319. §7.7 [very strong] Trend 6 daily table: 2025-03-13 n=3 mean 2.33; 03-14 n=30 mean 1.30; 03-15 n=25 mean 1.20; 03-16 n=18 mean 1.50; 03-17 n=12 mean 1.17; 03-18 n=14 mean 1.14.
320. §7.7: an update users identify as 1.41.0 (13 Mar 2025) erased habit histories globally; in the E4 window (13 Mar – 30 Apr 2025) 126 of 161 reviews (78.3%) report data loss.
321. §7.7: reported losses — 5 years (12426668716, 12427371564), 4 years (12420755807, 12468809976), 3 years (12428057196, 12429581990), 2 years (12419464329, 12432752145).
322. §7.7 aggravating 1: the advertised fix (1.42.1) did not work for many (12432192929, 12433912249, 12434390238, 12434443412).
323. §7.7 aggravating 2: a second, ongoing bug appeared — checking off a new day wiped prior progress (12435186760, 12436537687, 12436240564, 12440851208).
324. §7.7 aggravating 3: recovery was paywalled — iCloud backup is a premium feature and manual; 12486017227 (md): "Why should a premium subscriber even have to think about whether a backup was created? These are basic things that should happen by default" (also 12424709744, 12421785170, 12440071394).
325. §7.7 aggravating 4: no communication — 12448085062 (us): "There has been no communication whatever about this disaster."
326. §7.7: the data wipe is the reason 2025 (mean 1.44) is the app's worst year on record — worse even than 2021.
327. §7.8 not claimed: any 2026 trend — 12 reviews, volume far too small.
328. §7.8 not claimed: improvement after the Feb 2021 restoration — E3's mean (1.93) is only marginally above E2's (1.57) and computed on a collapsed, self-selected base; no genuine recovery claimable.
329. §7.8 not claimed: localisation trend — 10 reviews total.
330. §7.8 not claimed: privacy trend — 17 reviews across 7 years; two isolated flare-ups (Jul 2019 privacy-policy critique 4498682042; Jan 2020 Facebook-data question 5462587159) do not constitute a trend.
331. §7.8 not claimed: crash trend — 27 reviews clustered on two dated incidents (Jun 2019 add-habit crash; 20 Oct 2020 launch failure, fixed next day with users praising the speed: 6557009066, 6560591296).
332. §7.8 not claimed: any causal claim that a developer change caused the conversion.
333. §7.9 [weak, 14 reviews]: 14 reviews (0.35%) reference an owner or developer change.
334. §7.9: 6927714116 (de, Jan 2021) states the app "got bought out by the 'Reflectly' developer"; 6962322574 (gb, Feb 2021) addresses the developer directly as "Reflect X ApS."
335. §7.9: others infer ownership change from behaviour — 7020673861 (ru): "it feels like the owner changed: the policy was updated and all the data was wiped"; 7039457424 (us): "New owners possibly?"
336. §7.9: by 2025 users address the developer as "kodeon ai" (12431520165), matching the manifest.json developer field Kodeon, Inc.
337. §7.9 established: the stated developer at extraction (Kodeon, Inc.) differs from the entity a UK reviewer addressed in Feb 2021 (Reflect X ApS), and the conversion coincided with a visible change in monetisation philosophy.
338. §7.9 not established: any specific corporate transaction, its date, or that it caused the conversion; treat as user-reported context only.
339. §8 framing: every recommendation ties to a numbered finding; split into fixes, product bets, and research.
340. §8.1 F1: honour every legacy entitlement permanently and verifiably (→ §3.2, §5.3, §7.2) — 615 revocation reports, mean 1.37, 52% of payers; Feb 2021 patch was partial and did not hold, recurrences to Jan 2026.
341. §8.1 F1: restore on the receipt, not on local state; make it survive reinstall and device change; publish a note saying it is done.
342. §8.1 F2: fix the App Store listing (→ §3.1 #39) — it promised "unlimited habits… without paying a penny" for at least two years after that stopped being true; 24 reviews (mean 1.21); zero engineering cost.
343. §8.1 F3: kill the non-expiring countdown and the launch interstitial (→ §2.4, §7.4) — 225 reviews; a four-year "limited time offer" is a documented reason people uninstalled.
344. §8.1 F3: cap the paywall at one dismissible prompt per session with a durable "no."
345. §8.1 F4: audit the promo-price-to-charge path (→ §3.1 #33) — 28 reports spanning Dec 2021 → Apr 2025 across 8 storefronts; low volume, high exposure; reproduce it or prove it cannot happen.
346. §8.1 F5: stand up a support channel that answers (→ §4.7) — 148 reports mean 1.33 vs 3.63 for people who were helped; fix the dead "Contact Us" address first; even an autoresponder with a real queue is worth ~2 stars per incident.
347. §8.1 F6: make backup automatic, free, and continuous (→ §7.7) — paywalling the recovery path for a data-loss event caused by your own update is the single most damaging decision in the 2025 window.
348. §8.1 F6: automatic daily local + iCloud snapshots, restore available to free users.
349. §8.1 F6: ship regression tests on the migration path — the same class of bug fired in Jan 2021 and again in Mar 2025.
350. §8.1 F7: make the free tier viable again and at minimum fix the delete-then-add dead end (→ §7.3) — the 3-habit cap behaving as a lifetime cap is almost certainly a bug that converts a pricing choice into a broken app.
351. §8.1 F7: 3 free habits is below the threshold of usefulness for this category; 7–10 free habits with paid depth elsewhere is the defensible line.
352. §8.2 P1: ship the widget properly or stop selling it (→ §7.5) — 182 reviews, five years, the #1 named purchase trigger; ship a real Home Screen widget (iOS 14+) with direct check-off.
353. §8.2 P1: if the widget cannot be shipped, remove it from the paywall copy and screenshots immediately and refund on request.
354. §8.2 P2: add a streak counter alongside the percentage (→ §3.5) — 71 requests, mean 3.72; nobody asks to replace the percentage; users want the streak for daily dopamine and the strength score for the honest long-run picture.
355. §8.2 P3: explain the percentage (→ §3.5) — 20 classified (undercounted); a one-screen explainer ("a weekly habit completed once shows 4% because the score measures strength over ~91 repetitions") plus an optional "this period" toggle; cheapest satisfaction win available.
356. §8.2 P4: multiple check-ins per day (→ §3.5) — 54 requests; water, medication, brushing teeth; table stakes against Streaks and Productive.
357. §8.2 P5: specific weekdays, not just "N times in M days" (→ §3.5) — 22 requests plus a large share of the notification complaints; "Gym Mon/Wed/Fri" is not expressible today.
358. §8.2 P6: notes per day (→ §3.5) — 79 requests, the single most-requested feature, mean 3.66.
359. §8.2 P7: categories/folders plus a compact row option (→ §3.5) — 58 + 26 requests; they co-occur, both being what happens when a power user exceeds ~8 habits.
360. §8.2 P8: Apple Watch app (→ §3.5) — 62 requests at mean 4.15, asked for by the happiest users and named explicitly in churn-to-Streaks reviews.
361. §8.3 D1: fix the habit-strength decay (→ §3.4; 7303014090, 7330745927, 7641636642, 8231849401, 7464605501) — users report that after 2021 the percentage stopped decaying, habits sat at 100% after weeks of non-completion.
362. §8.3 D1: the forgiving-but-decaying model was the product's one genuine intellectual differentiator; it broke and nobody fixed it; 7303014090 (us): "Please bring that algorithm back!"
363. §8.3 D1: this is the highest-leverage product item in the report because it is the only feature no competitor has.
364. §8.4 monetisation 1: this audience will pay — they paid voluntarily at self-chosen prices when nothing forced them; 35 wrote 4.83-mean reviews praising the model.
365. §8.4 monetisation 2: this audience will not rent a checkbox — stated willingness-to-pay clusters at $5–15 one-time, or $10–15/year at the very top end; $39.99/year is rejected in every market, every language, for seven years.
366. §8.4 monetisation 3: the price is not the objection, the broken bargain is — Spain (never lost anything) complains about price 16.9% but revocation 2.8%; high-spend markets (did lose something) complain about revocation at 19.3%.
367. §8.4 recommendation: offer a lifetime unlock alongside any subscription, priced in the $15–25 band, and grandfather every legacy purchaser into it free; multiple users say they would buy this (7470777218, 8537740813, 8053917590, 9459852981).
368. §8.4: a lifetime unlock converts the corpus's loudest grievance into its most-praised historical asset.
369. §8.5 competitor lesson 1: the positioning gap is wide open — "unlimited habits, one-time price, no subscription" was a winning position this product abandoned; 26 reviewers walked to Streaks for it.
370. §8.5 competitor lesson 2: the forgiving-decay model is unclaimed and the most emotionally resonant mechanic in the corpus, particularly for ADHD and perfectionist users who describe streak-resets as actively harmful (6179162507, 6815111095, 11139240840).
371. §8.5 competitor lesson 3: the feature checklist is written — Home Screen widget, Watch app, streak and strength, multi-daily check-ins, weekday scheduling, notes, categories, automatic free backup, iPad; roughly 400 reviews of specification.
372. §8.5 competitor lesson 4: trust is the moat, not features — a visible honest pricing promise plus a support address that answers would outperform any feature in this category.
373. §8.6 research question: what share of the installed base actually paid, and what share churned versus stayed silent (reviews over-represent the angry).
374. §8.6 research question: did the subscription conversion increase revenue — it destroyed reputation; the corpus says nothing about the P&L.
375. §8.6 research question: did the Feb 2021 restoration reach everyone or only those who complained loudly — recurrence reports through 2026 suggest the latter, but cannot be established from reviews.
376. §8.6 research question: why did the widget fail — every user-side report is consistent with an entitlement/extension bug, but no diagnostic data exists.
377. §8.6 research question: what actually happened in March 2025 — migration bug, backend change, or entitlement reset; users describe symptoms, not causes.
378. §8.6 research question: is the product still maintained — last substantive review activity is thin and 2026 volume (12 reviews) is too small to say.

## Diff against cards.jsonl (done after the blind pass)

378 blind lines checked against 109 cards — mechanically (token / number / review-ID overlap) and then by hand for the 29 lines whose only match was a verbatim table card (R20-002 method, R20-014 inventory, R20-028 theme table, R20-041 gap table, R20-048 defect table). 21 of the 29 were schema / reconciliation / classifier-validation detail already carried on the method card R20-002. Gaps found and fixed:

| blind line | gap | fix |
|---|---|---|
| 73 | extended / rich notifications are paid — existed only inside the inventory table card R20-014 | new R20-110 (feature) → C014 |
| 74, 138 | per-habit colour: 3 free / rest paid, and the `N-colors` theme (33, 0.82%, mean 3.76) — inventory table and theme table only | new R20-111 (feature) → C009 |
| 78 | drag-to-reorder is free but buggy — inventory table only | new R20-112 (feature) → C073 |
| 123 | `N-sync-backup` 84 (2.08%, 9.9% of E4) and "cross-device sync never shipped (84 mentions)" — theme table and inventory table only | new R20-113 (feature) → C013, C030 |
| 141 | `N-crash` 27 (0.67%, mean 2.52) — theme table only; §7.8 named the two dated incidents but no card carried the count | new R20-114 (must-never-break) → C031 |
| 192 | check marks disappearing — 7, mean 2.14, undercounted — defect table and theme table only | new R20-115 (must-never-break) → C041 |

Everything else had a matching card. Two rules added to `Report Synthesis Prompt.md` (feature-inventory rows with a gate or defect state; theme-table rows at Emerging or above) so the same gap cannot recur.
