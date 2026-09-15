# Blind pass — report 10
Generated without access to cards.jsonl.

1. Header: corpus is 70,041 written App Store reviews, 121 storefronts, 13 May 2021 → 7 Sep 2026 (5 yr 4 mo); developer Finch Care Public Benefit Corporation, bundle com.finch.finch.
2. Header: corpus mean rating 4.7631; 5★ 61,550 (87.88%), 4★ 4,655 (6.65%), 3★ 1,333 (1.90%), 2★ 742 (1.06%), 1★ 1,761 (2.51%).
3. Header/§1.2: 70,041 of 70,041 records processed (100%); exact reconciliation with by_country (121 files) and manifest.json; zero duplicate review_ids; zero JSON parse failures; zero empty title/body; zero records excluded.
4. How to read: signal band table — <0.1% Ignore by default; 0.1–0.5% Weak; 0.5–1% Emerging; 1–3% Meaningful; 3–5% Very strong; >5% High-priority.
5. How to read (method caveat): corpus is 87.9% five-star, which compresses every complaint rate; a 0.8% theme is 560 reviews and can be 8–9% of the one-star band; segment rates always labelled with their own denominator.
6. How to read (method caveat): no external sources used; pricing/features/release history are corpus-derived from what reviewers say.
7. How to read (method caveat): automated theme detection is English-only; non-English reviews read by hand but under-tagged (see §2.5).
8. Five things #1: paying cohort is the only cohort whose satisfaction is collapsing — 1,381 reviews (1.97%) have purchase evidence; their mean fell 4.40 (2022) → 4.01 (2023) → 3.82 (2024) → 3.19 (2025) → 2.96 (2026); non-paid mean 4.785 barely moved.
9. Five things #1: in 2026, 36.7% of reviews with purchase evidence are one-star (92/251) — called the single most important number in the corpus.
10. Five things #2: "You promised to remind me before charging" is the highest-intensity complaint — M-trial-no-reminder 160 reviews mean 1.98; M-trial-charged 149 reviews mean 1.79.
11. Five things #2: billing-dispute family = 404 reviews (0.58%, EMERGING) at mean 1.97 — the worst-rated family in the corpus; 17.45% of all paid-evidence reviewers (241/1,381) are in it.
12. Five things #3: data loss is a structural defect — 551 reviews (0.79%, EMERGING; 9.09% of all one-star reviews) report corrupted pet / wiped account / unrecoverable login.
13. Five things #3: data-integrity family (D-data-loss + D-no-backup + D-login-account + D-sync-devices) runs 0.42% (2022H1) → 1.76% (2026H1).
14. Five things #3: mechanism consistent across five years — progress stored on-device, backup manual and opt-in, standard remedy is a new bird plus 5,000 rainbow stones; converts the emotional-attachment strength into liability.
15. Five things #4: 4 May 2022 crash-on-launch — 128 reviews that day vs ~90/day baseline, mean 3.72, 34 one-star, 42 crash reports in a single day.
16. Five things #4: February 2026 "Wonderland / Queen of Hearts" event growth-potion animation made the pet oversized and crashed the app on load — 120 crash-tagged reviews in one month (2.03% of all 2026 reviews vs 0.36–0.53% baseline in 2023–2024), peaking at 20 crash reports on 2 Feb 2026; reviewers named the exact trigger.
17. Five things #5: June 2026 monthly event became a paid movie tie-in — C-brand-collab 127 reviews mean 3.09; 107 (84%) in 2026, 68 in June 2026 alone; subscribers say they are paying to be advertised to in a mental-health app in a month they expected to be Pride.
18. Five things #5: C-brand-collab did not meaningfully exist before 2025 (2 reviews in 2022, 5 in 2023, 3 in 2024).
19. Five things (what works): 20,883 reviews (29.82%) carry a core-benefit theme at mean 4.89.
20. Five things (what works): 8,398 reviews (11.99%) report a concrete mental-health benefit.
21. Five things (what works): 2,686 (3.83%) make an explicit life-change claim at mean 4.97.
22. Five things (what works): 5,157 (7.36%) identify as ADHD/autistic/neurodivergent users.
23. Five things (what works): 381 (0.54%) say a clinician recommended it or they are the clinician.
24. Five things (what works): 857 reviews (1.22%) praise the free tier as generous and ad-free — which makes ad tie-ins and paywall creep more damaging than their raw volume suggests.
25. Exec summary thesis: Finch is a beloved 4.76-mean product whose written record shows five years of accumulating trust damage concentrated almost entirely on people who have paid.
26. Exec #1: paid-evidence mean 4.40 → 2.96 across 2022–2026 while corpus mean went only 4.864 → 4.645; public number held up by growing free base while monetised cohort curdles.
27. Exec #2: trial-to-subscription flow is the largest reputational liability — 404 billing-dispute reviews mean 1.97, 244 one-star; claim repeated verbatim across five years, 20+ storefronts, every language.
28. Exec #2: this is not a pricing objection — only 92 of 596 price complaints come from paying users, whereas 241 of 404 billing disputes do.
29. Exec #3: local-only storage is the second liability and compounding — 551 data-loss reviews, 37 explicit "no automatic backup" reviews, 90 "I cannot log back in" reviews.
30. Exec #3: support's remedy (new pet + 5,000 stones) described by users who had 20,000–200,000 stones and multi-year streaks.
31. Exec #4: reliability is the fastest-growing complaint family — 1,648 reviews (2.35%, MEANINGFUL) mean 3.32; half-year rate 1.89% (2022H1) → 4.80% (2026H1).
32. Exec #4: crash reports went 0.36% of 2024 reviews → 2.03% of 2026 reviews; attributed to monthly event releases — D-event-bug 0.06% of 2025 reviews → 0.32% of 2026 reviews.
33. Exec #5: every major feature removal produced a dated backlash and none were reversed — Journeys → Self-Care Areas (Apr–May 2025; 49 reviews mean 2.76, 36 in 2025).
34. Exec #5: automatic mood check-ins and affirmations removed (Oct 2025 onward; 64 reviews mean 3.77, 49 in 2025H2–2026).
35. Exec #5: exact-time goal scheduling removed (Nov 2025–Jan 2026; 9 reviews mean 3.11).
36. Exec #5: generic "you removed a feature I used" runs 0.02% (2022) → 0.32% (2026), a 16× increase.
37. Exec #6: sponsored IP events broke a stated brand promise — 857 reviewers praised ad-freeness; June 2026 entire monthly theme became a DC/Supergirl promotion; C-brand-collab mean 3.09; 8.0× over-represented among paid-evidence reviewers.
38. Exec #7: gamification-harm family 1,948 reviews (2.78%, MEANINGFUL).
39. Exec #7: streaks (added ~mid-2024) generate a defect stream — D-streak-bug 171 reviews, mean 3.26, 0.01% in 2023 → 0.74% in 2026.
40. Exec #7: streaks generate a pressure stream — U-streak-pressure 96 reviews mean 3.96; most common sentence is that the app now punishes a missed day in a product bought because the user misses days.
41. Exec #8: unserved accessibility/internationalisation demand — 597 accessibility reviews (0.85%), 292 localisation requests (0.42%), 90 dark-mode, 92 Apple Watch, 608 Apple Health, 31 cross-device sync, 30 Family Sharing; these are people asking to keep paying, not complaints about a broken thing.
42. Exec #8: in Russia localisation is 18.45% of all reviews; in China 26.42%.
43. Exec #9: values conflict runs both directions — 428 reviews discuss pet pronouns; 54 object to being asked (mean 3.24) and delete at that screen; 109 object to LGBTQ+ content (mean 3.50); 111 complain there is not enough representation (mean 4.57, loyal users); 116 ask for religious items; 16 for a national flag.
44. Exec #9: the only intervention the corpus supports is optionality, not editorial change.
45. Exec (must protect): free tier's reputation (857), non-punitive tone (476 reviews mean 4.87), companionship effect (1,309), clinician endorsement channel (381) — each directly threatened by a decision elsewhere in the report.
46. Exec (prioritised ask): make the trial reminder real and provable; ship automatic cloud backup on by default; stop shipping monthly events without a crash gate; stop removing features people bought the app for; decide explicitly whether the product is a self-care tool with a game attached or a collection game with self-care attached — 2,000+ reviewers say it has silently become the second.
47. §1.1: schema 13 fields all present; is_edited true for 977 reviews (1.39%), noted but not used as a filter; author ignored except non-empty check.
48. §1.2 (method): no deduplication applied — 120 groups share identical title+body+country, 284 records (0.41%), overwhelmingly short generic praise by different authors; all 70,041 counted in every percentage.
49. §1.3 (method): Layer 1 — exhaustive programmatic classification of all 70,041 records with an 88-theme compound rule set (at least one of A) AND (all of B) AND (none of C); rules reproduced in §10.6.
50. §1.3 (method): Layer 2 — every 1,761 one-star, 742 two-star, 1,333 three-star review read individually in date order (3,836 reviews, 100% of ≤3★); ~1,200 four-star read across four time-stratified batches (2021–22, 2023, 2025, 2026); taxonomy derived from reading.
51. §1.3 (method): Layer 3 — two full classification passes; first pass showed false positives (M-trial-no-reminder matching "remind myself"; D-support matching "part of my support system"; M-should-be-free matching praise for free tier); themes rewritten with negative-context exclusions and re-validated.
52. §1.3 (method): recall calibrated against keyword probes — e.g. 1,036 reviews mention "journey"; 80 are ≤3★; final complaint rule captures 49.
53. §1.3 (method caveat): estimated ~85–92% precision on complaint themes; recall lower and unmeasured; all complaint counts are lower bounds.
54. §1.4 (method caveat): no conversion, retention, revenue or install figures; no causal claims (co-occurrence only, with reviewers naming causes); no claim about public star rating vs written sentiment; no external facts.
55. §1.5 #1 (caveat): severe selection bias in unusual direction — 87.88% five-star; complaint rates are small numbers representing large populations (0.8% = 560 people).
56. §1.5 #2 (caveat): English-only detection — 3,840 reviews (5.48%) from 21 non-English-primary storefronts systematically under-tagged; Russia shows P-mental-health 2.91% vs 11.99% global because written in Russian; every country-level theme rate for de, fr, es, mx, br, ru, cn, jp, tr, it, pt, pl, cz, dk, se, no, fi, nl, at, ch, be is a floor.
57. §1.5 #3 (caveat): 40.92% of reviews (28,662) matched no theme — median body 79 chars vs 203 for tagged; 11,359 have bodies under 60 chars; 25,648 of 28,662 (89.5%) five-star; mean 4.806; tag rate 81.8% for 200+ char bodies and 68.2% for ≤3★; untagged counted in every denominator.
58. §1.5 #4 (caveat): vote_sum/vote_count sparse — only 2,605 reviews (3.72%) have any votes.
59. §1.5 #5 (caveat): date-of-writing not date-of-experience; 977 edits; day-level attribution reliable only for large spikes.
60. §1.5 #6 (caveat): paid-cohort identification conservative — `paid` set only where purchase/charge/subscription/renewal/refund/cancellation stated; silent subscribers counted as non-paid; cohort (1,381) is a floor and biased toward billing grievance, inflating complaint rates and depressing mean.
61. §2.1: product loop — hatch a bird, name it, choose pronouns and colours, dress it; goals generate energy → multi-hour adventure → discovery + item + two-option personality question; goals earn rainbow stones spent in rotating shops.
62. §2.1 feature table: Adventures/exploring 2,290 (3.27%) — core loop; cooldown length is itself a complaint.
63. §2.1 feature table: Finch Plus/premium 2,278 (3.25%).
64. §2.1 feature table: Breathing exercises 1,606 (2.29%) — named more than any other therapeutic tool.
65. §2.1 feature table: Outfits 1,310 (1.87%); Journaling 1,302 (1.86%); Reflections 1,194 (1.70%); Streaks 1,189 (1.70%, added ~mid-2024); Quests 1,153 (1.65%).
66. §2.1 feature table: Journeys 1,006 (1.44%) — removed Apr–May 2025; Mood tracking 953 (1.36%) — auto check-in removed Oct 2025.
67. §2.1 feature table: Micropets 935 (1.33%) — hatched from eggs, monthly event rewards; Gems/stones 766 + 461; Furniture 712 (1.02%).
68. §2.1 feature table: Quizzes/self-assessments 558 (0.80%) — depression, anxiety, ADHD, body image; Shop (Mr. Prickles/Robin's) 509 (0.73%) — random daily rotation, paid re-roll.
69. §2.1 feature table: Widget 493 (0.70%) — chronically broken; Guardian programme 449 (0.64%) — sponsor another user's subscription; First aid kit 444 (0.63%) — crisis tools.
70. §2.1 feature table: Travel 388 (0.55%); Soundscapes 385 (0.55%); Good vibes/gifting 370 (0.53%); Tree Town 325 (0.46%); Insights/weekly report 145 (0.21%).
71. §2.1 feature table: Merch 134 (0.19%) — fulfilment complaints; Self-Care Areas 52 (0.07%) — the Journeys replacement; Pause mode/snooze 54 (0.08%).
72. §2.2 gating: daily goals, checking off, energy, adventures are Free — 857 reviews praise free-tier scope.
73. §2.2 gating: basic outfits/furniture Free with limited rotation — free users report 6–8 shop slots vs 12–16 for Plus.
74. §2.2 gating: breathing exercises Mixed — anxiety breathing exercise reported gated (14338788841).
75. §2.2 gating: soundscapes (animal sounds) and longer timers Paid, reported as previously free (13057118678, 13594995098).
76. §2.2 gating: full shop / colour options / outfit saves Paid (12383429614, 14375332074, 14378349434).
77. §2.2 gating: monthly event micropet (from ~2025) Paid or partially paid, reported as previously free (14455889030, 10529428569).
78. §2.2 gating: goal icon customisation Paid (12187968321, 12241626633).
79. §2.2 gating: Journeys organisation was paid in 2022 era (9130759190).
80. §2.2 gating: cloud backup / account sync Free but opt-in and manual (37 reviews).
81. §2.2 gating: Guardian is a paid add-on (449 mentions); Family Sharing not supported (30 reviews, mean 3.63).
82. §2.2 trial: 7-day free trial is dominant description; 3-day, 2-day and 5-day variants also appear (10132933191, 12814784154, 12752079228, 12675075647).
83. §2.2 tactic: a "one-time offer" discount screen presented during onboarding before the app has been used, stating the discount is lost forever if dismissed — M-fomo-offer 10 reviews, mean 2.90 (10582541234, 11351698438, 11950784924, 13853322399, 13018762164).
84. §2.3 prices: $40 (129 mentions) dominant; $70 (49); $50 (32); $60 (21); $39.99 (17); $10 (16); $100 (15); $20 (15); $35 (11); $30 (11); $9.99 (10); £40 (10); £39.99 (8); $42 (7); $69.99 (6); $49.99 (6); $99.99 (5); £69.99 (5); $34.99 (5); $75 (5).
85. §2.3 prices (hand reading): ¥11,000/yr Japan (13046812794), R1,500 South Africa (11204966534), RM199 Malaysia (13181758667), €45–€80, £30–£120, C$50–C$200, A$30–A$130, ₽3,000–6,000.
86. §2.3 finding: price dispersion is itself a finding — M-price-inconsistent 12 reviews mean 3.75 report a different price quoted to a family member/friend the same day: 13973018233 (parent $34.99, son $41.99 — "That just took all the joy of playing with this today out of my sails"), 13859119520, 12682049848, 12877389441 (support "could not explain the cost differences", range $19.99–$99.99), 12506634709 — WEAK by volume, high-severity trust signal by content.
87. §2.4 monetisation summary: free-to-download; generous free tier; 7-day trial defaulting to an annual subscription; onboarding-time discounted offer with scarcity frame; in-app-currency shops with randomised rotation and paid re-roll; monthly seasonal pass with paid and free reward tracks; Guardian gifting tier; physical merch; from 2026 sponsored IP events.
88. §2.5: 92.11% of reviews (64,513) from four Anglophone storefronts (US 50,932; GB 6,667; CA 4,748; AU 2,166); 5.48% (3,840) from 21 non-English-primary storefronts; 1.36% (956) from 90 storefronts under 50 reviews — an English-language product with a small international tail asking loudly to be served.
89. §3.1: P-motivation 11,175 (15.96%, HIGH-PRIORITY, mean 4.88) — #1 reported benefit.
90. §3.1: P-cute-design 10,074 (14.38%, HIGH-PRIORITY, 4.91) — aesthetics are load-bearing, not decorative.
91. §3.1: P-recommend 9,765 (13.94%, HIGH-PRIORITY, 4.91).
92. §3.1: P-mental-health 8,398 (11.99%, HIGH-PRIORITY, 4.89).
93. §3.1: P-adhd-nd 5,157 (7.36%, HIGH-PRIORITY, 4.76).
94. §3.1: P-tools 3,746 (5.35%, HIGH-PRIORITY, 4.84) — breathing, soundscapes, first aid, journaling.
95. §3.1: P-life-changed 2,686 (3.83%, VERY STRONG, 4.97).
96. §3.1: P-social 2,035 (2.91%, MEANINGFUL, 4.84) — Tree Town, good vibes, friends.
97. §3.1: P-companion 1,309 (1.87%, MEANINGFUL, 4.84) — "not alone", "like a friend".
98. §3.1: P-team-praise 974 (1.39%, MEANINGFUL, 4.90).
99. §3.1: P-free-generous 857 (1.22%, MEANINGFUL, 4.92).
100. §3.1: P-gentle 476 (0.68%, EMERGING, 4.87) — non-punitive tone, "no guilt", "at my own pace".
101. §3.1: P-therapist-rec 381 (0.54%, EMERGING, 4.91).
102. §3.1: P-sobriety 134 (0.19%, WEAK, 4.62) — sobriety/recovery use case.
103. §3.1: core-benefit family (P-mental-health ∪ P-motivation ∪ P-life-changed ∪ P-companion ∪ P-gentle) = 20,883 reviews, 29.82%, mean 4.89.
104. §3.2(a): the externalisation mechanism works — "I will do for the bird what I will not do for myself" is the causal story users tell; 9438141619 (358 net votes, most-endorsed review), 12370795858 ("The fact that I care more about this bird than myself says a lot, but it works"), 11489285888 (76 votes), 8499763457, 8797139022, 10841359117, 13005792453, 12674347241, 8389731820, 9272023003.
105. §3.2(b): non-punitiveness is a named differentiator — 476 reviews mean 4.87; 10243200718 ("unlike other apps, he doesn't get sick or sad if I miss things… without any guilt"), 11745067634, 13005792453, 8389731820, 12939486987, 14187447203, 11824105803, 13609263572, 12060228726, 9668443213.
106. §3.2(b): streak mechanic and Journeys→Self-Care-Areas change are, in reviewers' words, the direct negation of the non-punitive differentiator.
107. §3.2(c): free tier's reputation is a measurable asset — 857 reviews (1.22%, mean 4.92) say the free version is generous and the app does not nag; 8797139022 ("Adorable, Helpful, and Not Annoying"), 8619792409 ("Finally, an app that is actually free… no annoying pop ups"), 8343850932 ("prioritises your mindfulness exercises without pushing its subscription service at all"), 8345380038, 14135326556, 10246078752, 13212308967, 11984368192, 12099230305, 13918020477.
108. §3.2(c): this is the asset the 2026 sponsored-IP events spend down.
109. §3.2(d): clinical channel — 381 reviews (0.54%, mean 4.91) involve a clinician; 13192704866 (psychologist who recommended it and has stopped), 12678214054, 10195590904, 12025813421, 13983749907, 8322398440, 12658276545, 13652698300, 13875198474, 11714664731, 13569423105.
110. §3.2(d): the clinical channel is visibly reversible — 13192704866 and 13434160590 are clinicians publicly withdrawing the recommendation over data loss.
111. §4.1: FAM-monetization-any 2,045 (2.92%, MEANINGFUL, mean 3.73, 413 one-star = 20.2%).
112. §4.1: FAM-gamification-harm 1,948 (2.78%, MEANINGFUL, 4.38, 103 one-star = 5.3%).
113. §4.1: FAM-reliability 1,648 (2.35%, MEANINGFUL, 3.32, 369 one-star = 22.4%).
114. §4.1: FAM-accessibility 1,150 (1.64%, MEANINGFUL, 4.47, 44 one-star = 3.8%).
115. §4.1: FAM-content-values 874 (1.25%, MEANINGFUL, 3.93, 133 one-star = 15.2%).
116. §4.1: FAM-platform-gaps 765 (1.09%, MEANINGFUL, 4.63, 31 one-star = 4.1%).
117. §4.1: FAM-data-integrity 658 (0.94%, EMERGING, 3.14, 181 one-star = 27.5%).
118. §4.1: FAM-billing-dispute 404 (0.58%, EMERGING, 1.97, 244 one-star = 60.4%).
119. §4.1: FAM-product-change 269 (0.38%, WEAK, 3.43, 51 one-star = 19.0%).
120. §4.1: ordering by volume and ordering by damage are almost inverted — billing-dispute is the smallest family and by far the most destructive (60.4% one-star, mean 1.97, 17.45% of all who mention paying).
121. §4.2: M-trial-no-reminder 160 (0.228%, WEAK, mean 1.98, 92 one-star, 89 paid-evidence).
122. §4.2: M-trial-charged 149 (0.213%, WEAK, mean 1.79, 99 one-star, 96 paid-evidence).
123. §4.2: M-refund-denied 98 (0.140%, WEAK, mean 1.48, 71 one-star, 91 paid-evidence).
124. §4.2: M-cancel-hard 66 (0.094%, ignore-by-default on volume, mean 2.18, 36 one-star, 30 paid).
125. §4.2: M-unauthorized 51 (0.073%, mean 2.12, 31 one-star, 24 paid).
126. §4.2: M-double-charge 10 (0.014%, mean 1.60, 5 one-star, 8 paid).
127. §4.2: billing family deduplicated union 404 (0.577%, EMERGING, mean 1.97, 244 one-star, 241 paid).
128. §4.2 (method): four of six billing themes sit below 0.1% but are reported anyway under the financial-integrity carve-out.
129. §4.2 segment rates: billing-dispute family is 13.86% of all one-star reviews (244/1,761) and 17.45% of all paid-evidence reviews (241/1,381).
130. §4.2 mechanism: app says it will notify before trial converts; notification does not arrive; annual charge lands — appears first in 2022 and never stops (2022: 8450449406, 8574557147, 8745256448, 8792010028, 8765821908; 2023: 9377363892, 9511640421, 9519581653, 9589793525, 9605470805, 9856141635, 10520689598, 10806013886; 2024: 10894998349, 10905535264, 10912523297, 11066833964, 11067256399, 11615989107, 11766242787, 11886408015, 11945546326, 11987166475, 12019473575, 12044845149; 2025: 12165793458, 12237075385, 12248065265, 12264515933, 12286126321, 12545712445, 12546094374, 12563279710, 12571177603, 12873547913, 13033899041, 13126279553, 13156907337, 13323080135; 2026: 13684684762, 13689201456, 13700616971, 13706416509, 13719660640, 13726028307, 13929170868, 14020090949, 14150329804, 14275458594, 14395644720, 14443859449, 14512967242).
131. §4.2 quote: "They said 'free 1-week trail and that they would notify use before payment went through' and they did not honor that either of these statements!" (12821877102, 1★, US, 27 Jun 2025).
132. §4.2 quote: "It's kinda lame to market an app heavily towards ADHD and tell you specifically that you'll get a reminder before the free trial ends only to not do exactly that." (12761313447, 1★, DE, 11 Jun 2025).
133. §4.2: why worse than ordinary billing — product is marketed to people who state they cannot reliably remember things (7.36% self-identify ADHD/ND); a promised reminder is the feature, not a courtesy; reviewers make this argument unprompted (11939993235, 11959224161, 12738181086, 13571872699, 13042542238, 14043265448).
134. §4.2: charged at trial *start* is a distinct, more severe claim made 149 times at mean 1.79 (12117168256, 12154514925, 12238194934, 12242821032, 12267858614, 12489141814, 12515680303, 12742313476, 12814366937, 13309759497, 13323080135, 14163733137, 14334922614, 14403016858); whether real charge, pre-auth, or store display artefact cannot be determined from text; 99 of 149 gave one star.
135. §4.2: refund refusal closes the loop — M-refund-denied mean 1.48, lowest-rated theme in the corpus; users routed between developer and Apple with neither accepting responsibility (12409091682, 12518605995, 12655037808, 13005792453, 13869988823, 14020090949, 14242421063, 14275458594, 14466997995, 11753119019, 10405832029).
136. §4.3: D-crash 568 (0.811%, EMERGING, mean 3.07, 151 one-star).
137. §4.3: D-data-loss 551 (0.787%, EMERGING, 3.10, 160 one-star).
138. §4.3: D-support 185 (0.264%, WEAK, 3.10, 71 one-star).
139. §4.3: D-streak-bug 171 (0.244%, WEAK, 3.26, 45 one-star).
140. §4.3: D-lag-perf 149 (0.213%, WEAK, 3.62, 18 one-star).
141. §4.3: D-widget-bug 117 (0.167%, WEAK, 3.91, 6 one-star).
142. §4.3: D-login-account 90 (0.128%, WEAK, 2.89, 27 one-star).
143. §4.3: D-notif-broken 86 (0.123%, WEAK, 3.47, 20 one-star).
144. §4.3: D-goals-bug 83 (0.119%, WEAK, 3.81, 10 one-star).
145. §4.3: D-event-bug 73 (0.104%, WEAK, 3.23, 15 one-star).
146. §4.3: D-no-backup 37 (0.053%, ignore-by-default, 3.08, 11 one-star).
147. §4.3: D-sync-devices 31 (0.044%, 4.16, 0 one-star).
148. §4.3: D-sound-bug 19 (0.027%, 3.47, 2 one-star).
149. §4.3: reliability family union 1,648 (2.354%, MEANINGFUL, 3.32, 369 one-star); segment rate 20.95% of all one-star (369/1,761) and 21.03% of all two-star (156/742).
150. §4.3 data-loss mechanism: progress lives on device; cloud backup manual and opt-in, discovered after loss; failure modes (a) "your pet data got corrupted" with re-hatch only; (b) app deleted/offloaded for storage and unrecoverable; (c) phone change, account unrecoverable; (d) backup file restores empty or fails.
151. §4.3 data-loss IDs across window: 2021 7603837966; 2022 8124198861, 8204557585, 8283657509, 9497993321, 9508357678, 9343658775; 2023 9714150379, 10800489769, 10849610051, 10867863113; 2024 11291619797, 11838113155, 11604912848, 12034463791, 12157120849; 2025 12595515502, 12655037808, 12881347765, 12925432031, 13033899041, 13192704866, 13411041280, 13435820986; 2026 13683756253, 13732070192, 13793063550, 13834130232, 13859108920, 13977008427, 14145164297, 14181823929, 14194313597, 14242421063, 14243659017, 14245428205.
152. §4.3: compensation described as insulting — standard remedy 5,000 stones vs losses of 20,000 (12925432031), 30,000+ (13033899041), 35,000 (10411200153), 40,000 (13923371591), 200,000 (13434160590), plus multi-year streaks and event-exclusive items (13787017447: ~10,000 items lost, 30 offered back).
153. §4.3: data loss hits paying users — 48 of 551 data-loss reviews carry purchase evidence; paid cohort 4.4× over-represented (12595515502, 13411041280, 13732070192, 14156611933, 13646312358, 14273682143).
154. §4.3: data loss described in bereavement language — "It feels like a pet died" (9583838100); "my birb Bean… And now she's gone" (13033899041); "planning the funeral for her birb" (14243659017); "murdered my bird, my heart, and my soul" (13732070192) — the attachment mechanic firing in reverse.
155. §4.3: support closes the loop badly — 185 reviews describe unanswered emails, weeks-long delays, AI/canned replies, "we're a small team" (12508862481, 13005792453, 13192704866, 13756726098, 14225501459, 14366340795, 14251210046, 12907317317, 12518605995, 14207705711, 13428425479, 14025215424); mean 3.10; 48 of 185 (26%) carry purchase evidence, 13.2× over-representation.
156. §4.3: widget is the longest-running unfixed defect — 117 reviews across all five years describe the home-screen widget as a grey/black box or failing to update (2021–22 8028480594, 8063339783, 8095520270, 8224548760, 8286896297, 8337305769; 2023 9504481447, 9534026008, 9550622499, 10233025213, 10241639632; 2024 11832970239, 11843092451, 11856523609, 11938626425; 2025 13215675126, 13298893876, 13559280287; 2026 13720918256, 14361444262, 14407038000); mean 3.91, mostly fans reporting it so it never generated pressure.
157. §4.4: U-ui-change 94 (0.134%, WEAK, 3.53) — peak Feb 2024 redesign; continuous 2025–26.
158. §4.4: U-feature-removed-generic 77 (0.110%, WEAK, 3.13) — peak 2026 (37 of 77).
159. §4.4: U-moodcheckin-removed 64 (0.091%, 3.77) — Oct 2025 – Mar 2026.
160. §4.4: U-journeys-removed 49 (0.070%, 2.76) — Apr–Jun 2025.
161. §4.4: U-timedgoals-removed 9 (0.013%, 3.11) — Nov 2025 – Jan 2026.
162. §4.4: product-change family union 269 (0.384%, WEAK, 3.43); individually small but collectively the corpus's clearest statement about product direction, all dated, all pointing the same way.
163. §4.5: U-overwhelm 1,046 (1.493%, MEANINGFUL, 4.50).
164. §4.5: U-boring 518 (0.740%, EMERGING, 4.39).
165. §4.5: U-economy 196 (0.280%, WEAK, 4.10).
166. §4.5: U-just-checklist 111 (0.158%, WEAK, 4.13).
167. §4.5: U-streak-pressure 96 (0.137%, WEAK, 3.96).
168. §4.5: U-too-many-clicks 84 (0.120%, WEAK, 3.49).
169. §4.5: U-notif-spam 77 (0.110%, WEAK, 3.65).
170. §4.5: U-blob-micropets 52 (0.074%, 3.81).
171. §4.5: U-fomo-events 40 (0.057%, 3.52).
172. §4.5: gamification family union 1,948 (2.781%, MEANINGFUL, 4.38).
173. §4.5: U-overwhelm is the largest single UX complaint — an app sold to people with executive-function difficulty has accumulated so many interstitials that reaching the checklist is itself an executive-function task; 12951667597 ("I don't wanna be required to go through 800 different screens before I can get to the checklist"), 12095378263 (six sequential screens before goal list), 12823843140, 13661516668, 14168702702, 12658682757, 11766242787, 9330701695, 10529428569, 13237881486.
174. §4.5: streaks are a net-negative mechanic in the written record — introduced ~mid-2024; U-streak-pressure is 5 reviews in 2022–23 combined and 24/41/23 in 2024/2025/2026.
175. §4.5 design harm: 96 reviews mean 3.96 say the streak reintroduces the guilt the app was praised for removing and repairing it costs 1,000 gems; 11591661994 ("I dread going into finch because of this new feature"), 11548301986, 11688717901, 12179584982, 12488852403, 14075929805, 12176073009, 13003497273, 14513803336, 11900885112.
176. §4.5 defect harm: 171 reviews mean 3.26 report streak resetting despite eligibility or repair tokens failing (14155454118, 14156037444, 14156043295, 14158910349, 14158945706, 14160185561, 14161950158, 14184548492, 14190841447, 14258840772, 13645979333, 14020891685); 0.01% of 2023 → 0.74% of 2026, a 74× increase.
177. §4.5 economy: 196 reviews object that goals yield 3–12 stones while shop items cost 500–900, shop rotates randomly with paid re-roll, wanted item never appears; 13291611680 (50 tasks for one 250-stone item), 12199427863, 14437464706, 12896721169, 14277989798, 13512928462, 13899596152, 12783240976, 13528610213, 14415321702.
178. §4.5: "It's just a checklist" is the churn thesis, 111 times at mean 4.13 by people still rating highly; 11976062097 ("Just create a Notes app checklist and add it as a widget"), 11688717901, 13649889390, 12241418903, 14263816049, 11584654564, 12966352245.
179. §4.5: U-goal-verification (158 reviews, mean 4.59) is the same observation as a feature request — users check boxes without doing the task and ask to be held accountable.
180. §4.6 (framing): unmet needs are almost all 4–5★ reviews — retention offers from users who already like the product; highest-value section for roadmap.
181. §4.6: more pet interaction / mini-games 829 (1.184%, MEANINGFUL, 4.64) — largest single feature request.
182. §4.6: Apple Health integration 608 (0.868%, EMERGING, 4.69) — mindful minutes, water, medication.
183. §4.6: accessibility (broad) 597 (0.852%, EMERGING, 4.56).
184. §4.6: localisation 292 (0.417%, WEAK, 4.27) — 11+ languages requested.
185. §4.6: completion verification 158 (0.226%, WEAK, 4.59) — photo proof / anti-cheat.
186. §4.6: Apple Watch app 92 (0.131%, WEAK, 4.71) — explicitly to reduce phone use.
187. §4.6: dark mode 90 (0.128%, WEAK, 4.28) — requested since 2022.
188. §4.6: night-shift / non-standard schedule 146 (0.208%, WEAK, 4.64) — also southern-hemisphere seasons.
189. §4.6: cross-device sync 31 (0.044%, 4.16, 0 one-star).
190. §4.6: Family Sharing 30 (0.043%, 3.63) — per-seat pricing objection.
191. §4.6: desktop / web 6 (0.009%, 3.83).
192. §4.6: Apple Health (608, mean 4.69) is the largest ignored integration ask, almost entirely from satisfied users (14408516417, 12160927071, 13818669914, 8601859891, 8323353137, 11470496389, 12397154442, 13053497310, 9878449464).
193. §4.6: Apple Watch (92, mean 4.71) is the most emotionally coherent ask — users want it specifically to stop looking at their phone, the app's own stated goal; 11451565056 ("I got an Apple Watch because I felt like my phone was sucking attention and energy from me… mark off goals accomplished on the watch"), 14471258544, 13919785505, 8316004742, 8310431154, 12865399088.
194. §4.6: dark mode (90 since 2022) is an accessibility issue not a preference — 14284922425 ("a self-care app could keep producing popular cosmetic items for the pets while leaving light-sensitive users without a basic accessibility feature. Cute clothes for the bird were apparently shippable."); 13690970916 (migraine), 13654406960, 14008031999, 13145721783, 12557849777, 13945397134.
195. §4.7: C-age-rating 920 (1.314%, MEANINGFUL, 4.74) — mostly parents, mixed.
196. §4.7: C-pronouns (all mentions) 428 (0.611%, EMERGING, 4.42) — both directions.
197. §4.7: C-safety 335 (0.478%, WEAK, 4.55) — crisis/grief/ED context.
198. §4.7: C-diagnosis-quiz 221 (0.316%, WEAK, 4.86) — mostly neutral/positive.
199. §4.7: C-community-mod 211 (0.301%, WEAK, 3.93) — FB/Discord/Reddit conduct.
200. §4.7: C-ai 156 (0.223%, WEAK, 4.35) — mostly 2025–26.
201. §4.7: C-brand-collab 127 (0.181%, WEAK, 3.09) — 84% in 2026.
202. §4.7: C-religion 116 (0.166%, WEAK, 4.14) — requests + objections.
203. §4.7: C-lgbt-more 111 (0.158%, WEAK, 4.57) — wants more representation.
204. §4.7: C-lgbt-objection 109 (0.156%, WEAK, 3.50) — wants less / opt-out.
205. §4.7: C-privacy 101 (0.144%, WEAK, 3.96) — contacts, phone number, tracking.
206. §4.7: C-pronouns-objection 54 (0.077%, 3.24) — deletes at the pronoun screen.
207. §4.7: C-national-flag 16 (0.023%, 3.00).
208. §4.7: C-review-manip 16 (0.023%, 4.25) — allegation only.
209. §4.7: C-hiring-ethics 9 (0.013%, 1.67) — concentrated May 2025.
210. §4.7: pronoun screen is a measurable but small acquisition leak — 54 reviews describe deleting at pronoun selection (8580844131, 8474636545, 9487215463, 9891211417, 11733826774, 12309043500, 13004599450, 13000860998, 13283702073, 13678224974, 13680058420, 14012193700, 14416401473, 14488479244); peaked 2022 (1.19% of that year's pronoun mentions), flat since; reported because the implied intervention (a skip option) is cheap and non-editorial.
211. §4.7: 111 loyal-user reviews (mean 4.57) complain representation is missing — most often lesbian flag (12280237908, 11159383290, 12379742945, 14144887984, 12484266125), aroace (11477756750, 10928423183), demigirl/demiboy (14347171250).
212. §4.7 safety incident: in 2022 the goal-suggestion system parsed a journal entry about suicidal ideation and generated a goal to "schedule time for suicide" (8197656256, 8249486173, 8310957728).
213. §4.7 safety: in-app depression/anxiety/ADHD quizzes returning severe results to children in a 4+-rated app (10461078232, 11680366668, 9028127653, 8747299439).
214. §4.7 safety: 12943514439 reports a "you can do this" notification immediately after texting about suicide; all safety items reported regardless of volume under the safety carve-out.
215. §4.7: community-moderation stream is a persistent dated reputational drag — 211 reviews describe FB group/Discord/subreddit as heavily moderated and hostile to criticism, with a 2022–23 cluster around a Harry Potter / JK Rowling content decision producing accusations both ways (8779142067, 8786543457, 8809056328, 9344350321, 9696554036, 9954956356, 10427260247, 12039960855, 8714915960, 8996753611, 12023264733 anti-Black moderation allegation, 12205292045, 13454522816, 14372739263, 14201570708, 14260047035, 14154691963); mean 3.93; 29 of 211 with purchase evidence (7.0×).
216. §4.8: merch fulfilment — late, wrong or undelivered physical orders with no support response (12100759969, 12849337898, 14135314999, 14172035895, 14444272993, 13529294099).
217. §4.8: update churn — near-daily updates, large downloads, monthly events requiring an update to unlock (11198114825, 11510475741, 12613070528, 13513453625, 14083723197, 14381189233, 14382450807).
218. §4.8: forced pet ageing / colour change — 22 reviews mean 3.59, made to change pet colour at a growth milestone with no way back (8431474054, 9348919175, 10666674801, 11613982899, 12602358290, 12671877044, 14168221622, 14477855392).
219. §4.8: pet's randomised likes/dislikes — 28 reviews mean 3.79, distress that companion "hates everything I love" (12267413829, 13650646547, 11882249586, 12802871170, 10868115871, 14114392965, 13445215677).
220. Part 5 5★ band (n=61,550, 87.88%): P-motivation 10,318 (16.76%); P-cute-design 9,409 (15.29%); P-recommend 9,210 (14.96%); P-mental-health 7,870 (12.79%); P-adhd-nd 4,414 (7.17%); P-tools 3,339 (5.42%); P-life-changed 2,627 (4.27%); P-social 1,825 (2.97%).
221. Part 5 5★ band: 25,648 five-star reviews (41.67% of band) carry no theme — median body 79 chars.
222. Part 5 5★ band: 702 five-star reviews (1.14% of band) carry a billing, reliability or product-change complaint — people who love the app reporting a defect anyway.
223. Part 5 5★ band (method caveat): ~11 hand-verified reviewers chose their star rating to be seen rather than to express satisfaction — rating down (10174564913, 14351670200, 10924185515, 12428506521, 14082597695, 12663718459, 14483561352) and rating up (13697877845, 14105215358, 13343247063, 12426654413); star rating is a weak proxy for satisfaction in both directions; no finding rests on rating alone.
224. Part 5 4★ band (n=4,655, 6.65%) is the "one thing away" band — praise + a single named blocker; highest-signal band for roadmap.
225. Part 5 4★ band rows: P-motivation 604 (12.98%); P-cute-design 533 (11.45%); P-adhd-nd 484 (10.40%); U-more-pet 174 (3.74%); U-overwhelm 142 (3.05%); M-paywall 141 (3.03%); M-price-high 101 (2.17%); D-crash 96 (2.06%); U-boring 94 (2.02%); D-data-loss 78 (1.68%); U-localization 76 (1.63%); U-accessibility 68 (1.46%); U-economy 61 (1.31%); D-widget-bug 40 (0.86%).
226. Part 5 4★ band: platform gaps live here — U-apple-health (38), U-apple-watch (18), U-dark-mode (26), D-sync-devices (12) peak relative to global share; these reviewers state the exact price of their fifth star.
227. Part 5 3★ band (n=1,333, 1.90%) value-uncertainty band rows: P-motivation 123 (9.23%); P-adhd-nd 106 (7.95%); D-crash 94 (7.05%); D-data-loss 89 (6.68%); U-overwhelm 58 (4.35%); M-paywall 36 (2.70%); M-price-high 36 (2.70%); U-localization 34 (2.55%).
228. Part 5 3★ band: three stars overwhelmingly means "I like this and something is broken" — crashes + data loss = 13.7% of band; frustrated fans not lukewarm users.
229. Part 5 2★ band (n=742, 1.06%) buyer's-remorse band rows: D-crash 70 (9.43%); D-data-loss 51 (6.87%); U-overwhelm 39 (5.26%); M-trial-no-reminder 29 (3.91%); M-price-high 28 (3.77%); M-paywall 25 (3.37%); P-adhd-nd 61 (8.22%); P-motivation 58 (7.82%).
230. Part 5 2★ band: two-star reviewers are frequently long-term users writing a farewell — establish it worked, then explain what broke it.
231. Part 5 1★ band (n=1,761, 2.51%) churn band rows: D-data-loss 160 (9.09%, global 551); D-crash 151 (8.57%, 568); M-trial-charged 99 (5.62%, 149); M-trial-no-reminder 92 (5.22%, 160); P-adhd-nd 92 (5.22%, 5,157); P-mental-health 86 (4.88%, 8,398); P-recommend 78 (4.43%, 9,765); M-refund-denied 71 (4.03%, 98); D-support 71 (4.03%, 185).
232. Part 5 1★ band rows (cont.): M-not-free 68 (3.86%, 126); M-price-high 62 (3.52%, 596); D-streak-bug 45 (2.56%, 171); M-paywall 38 (2.16%, 715); C-community-mod 37 (2.10%, 211); C-pronouns 36 (2.04%, 428); M-cancel-hard 36 (2.04%, 66); C-brand-collab 35 (1.99%, 127); C-age-rating 33 (1.87%, 920).
233. Part 5 1★ band: presence of P-mental-health (86), P-recommend (78), P-adhd-nd (92) inside the one-star band — many one-star reviewers say the app helped them; they are detractors of a transaction or failure, not the product.
234. Part 5 1★ band composition: ~30% reliability (D-* union 526/1,761); ~14% billing dispute (244); ~19% monetization broadly (413); ~8% values/content (133); small residue of "not for me".
235. Part 5 1★ band implication: the one-star population is highly recoverable; almost none is a product-market-fit problem.
236. §6.1: paid cohort 1,381 (1.97%); paid mean 3.661; distribution 5★ 763, 4★ 118, 3★ 90, 2★ 89, 1★ 321 (23.24%); non-paid mean 4.785.
237. §6.1: reviews mentioning a trial 588 (0.84%), mean 3.238; reviews with both paid + trial evidence 178, mean 2.185.
238. §6.1 paid trend by year: 2021 16 (3.01%, mean 5.00, 0 one-star); 2022 275 (1.63%, 4.40, 24 one-star, 8.7%); 2023 222 (1.83%, 4.01, 34, 15.3%); 2024 260 (1.98%, 3.82, 54, 20.8%); 2025 357 (2.26%, 3.19, 117, 32.8%); 2026 251 (2.16%, 2.96, 92, 36.7%).
239. §6.1: over same window whole-corpus mean fell only 4.864 → 4.645 and five-star share 91.70% → 83.15% — damage concentrated on paying users.
240. §6.1: trial-mentioning reviewers track the same way — 3.87 (2022) → 3.62 (2023) → 3.13 (2024) → 2.83 (2025) → 3.22 (2026).
241. §6.2 (method caveat): paid cohort biased toward grievance; its absolute mean is not an estimate of subscriber satisfaction.
242. §6.2: the trend survives the bias because (1) detection rules are constant across years so a 1.44-star fall cannot be explained by the rule set.
243. §6.2: (2) paid cohort's positive themes hold up — P-motivation 18.75% of paid vs 15.96% global; P-mental-health 13.90% vs 11.99%; P-tools 12.89% vs 5.35% (2.4× lift); falling rating is a falling opinion of the transaction, not the product's value.
244. §6.3 paid segment (denominator 1,381): M-refund-denied 91 (6.59%, global 98, lift 47.1×).
245. §6.3: M-trial-charged 96 (6.95%, global 149, 32.7×).
246. §6.3: M-trial-no-reminder 89 (6.44%, global 160, 28.2×).
247. §6.3: M-unauthorized 24 (1.74%, global 51, 23.9×).
248. §6.3: M-cancel-hard 30 (2.17%, global 66, 23.1×).
249. §6.3: D-support 48 (3.48%, global 185, 13.2×).
250. §6.3: M-upsell-pressure 15 (1.09%, global 90, 8.5×).
251. §6.3: D-notif-broken 14 (1.01%, global 86, 8.3×).
252. §6.3: C-brand-collab 20 (1.45%, global 127, 8.0×).
253. §6.3: M-price-high 92 (6.66%, global 596, 7.8×).
254. §6.3: M-not-free 18 (1.30%, global 126, 7.2×).
255. §6.3: C-community-mod 29 (2.10%, global 211, 7.0×).
256. §6.3: M-guardian 92 (6.66%, global 708, 6.6×).
257. §6.3: U-feature-removed-generic 10 (0.72%, global 77, 6.6×); U-ui-change 12 (0.87%, global 94, 6.5×).
258. §6.3: C-religion 13 (0.94%, global 116, 5.7×).
259. §6.3: D-data-loss 48 (3.48%, global 551, 4.4×).
260. §6.3: C-ai 13 (0.94%, global 156, 4.2×); P-free-generous 71 (5.14%, global 857, 4.2×).
261. §6.3: U-accessibility 44 (3.19%, global 597, 3.7×); D-crash 40 (2.90%, global 568, 3.6×); M-paywall 47 (3.40%, global 715, 3.3×).
262. §6.3: U-apple-health 34 (2.46%, global 608, 2.8×); U-overwhelm 50 (3.62%, global 1,046, 2.4×).
263. §6.3: the five highest lifts are all billing-mechanics failures, not price and not product; price is only 7.8× and 6.66% of paid reviews — paying users complain about how they were charged and inability to undo it, not that Finch costs too much.
264. §6.3: second cluster — support (13.2×), community moderation (7.0×), brand collabs (8.0×), feature removal (6.6×), UI churn (6.5×), AI (4.2×) — is a relationship cluster: a paying base that feels the company has stopped listening.
265. §6.4 purchase trigger: the trial worked and they wanted to keep it — 11833081713 ("you start out with the plus version as a free trial and once we lost it we aren't as interested"), 9807397020, 12777430846, 14497912306.
266. §6.4 purchase trigger: cosmetic/colour variety was the specific hook — 14378349434 ("I started getting finch plus solely because I found the extra color options in the seasonal items & larger shop selection very motivating"), 14497912306, 12783240976.
267. §6.4 purchase trigger: monthly event completion (13929170868, 14455889030, 13741508287).
268. §6.4 purchase trigger: support the developers / because it works — 11112718539 ("even though I don't make a lot of money I make it a priority to pay for this app"), 13005792453, 12547227541, 8456836129 ("I think I'm worth $40").
269. §6.4 purchase trigger: gifted or sponsored first — Guardian programme (708 mentions, mean 4.76, 92 with purchase evidence) is both a conversion path and goodwill generator (13583950351, 12963211313, 11377452881, 12745041087).
270. §6.4 (caveat): purchase-trigger evidence is thinner than complaint evidence; no conversion rate is claimed.
271. §6.5 cancellation driver #1: billing surprise — 241 of 1,381 paid reviewers in the billing-dispute family; largest single cancellation driver.
272. §6.5 cancellation driver #2: data loss while subscribed — 48 paid reviewers; explicit cancellations in same review (13411041280, 13033899041, 13434160590, 13646312358, 14273682143, 12912434324).
273. §6.5 cancellation driver #3: feature removal — Journeys (12547227541, 12655037808, 12548369657, 12557722526), mood check-ins (13475103522, 14420113173, 13480507283), timed goals (13523723252).
274. §6.5 cancellation driver #4: sponsored IP events — 14186200268 ("I was a paid subscriber for 1.5 years and I just canceled my subscription because of the supergirl theme"), 14136600404, 14119714580, 14508228351, 14467821531, 14497986029, 14261659918, 14187447203.
275. §6.5 cancellation driver #5: ethics / AI / hiring (12705023244, 12716829097, 12686511039, 12709962941, 13253481318, 13254475935, 14392727188).
276. §6.5 cancellation driver #6: support silence (13894921431, 12273850138, 14220442784, 13428425479).
277. §6.5 cancellation driver #7: price at renewal — smaller, usually a renewal quote higher than original (12515242428, 12222994297, 12155763925, 14300275597).
278. §6.6: Guardian programme is a strategic asset — 708 mentions, mean 4.76, 92 with purchase evidence; one of very few monetisation-adjacent themes with a positive mean; receiving (13583950351, 12963211313, 14491292042, 14262792225) and giving (9977710032, 11401527483, 9723946025).
279. §6.6: Guardian friction — hard to apply for and opaque about whether sponsorship reached a real person; 12745041087 ("they advertise a guardian program to cover people like me but there is no way to apply"), 12771102574, 10246078752, 14131024327, 14142344100.
280. §7.1: 31 storefronts have ≥50 reviews and are analysed individually, covering 69,085 reviews (98.64%); remaining 90 storefronts hold 956 reviews (1.36%) and generate no standalone conclusions except flagged [limited evidence].
281. §7.1 country row: us 50,932, mean 4.777, 1★ 2.39%, 5★ 88.71%.
282. §7.1: gb 6,667, 4.786, 1★ 2.13%, 5★ 88.33%.
283. §7.1: ca 4,748, 4.689, 1★ 3.33%, 5★ 84.06%.
284. §7.1: au 2,166, 4.716, 1★ 2.95%, 5★ 84.76%.
285. §7.1: de 698, 4.692, 1★ 2.58%, 5★ 83.52%.
286. §7.1: se 478, 4.738, 1★ 2.09%, 5★ 84.94%.
287. §7.1: nl 410, 4.671, 1★ 3.17%, 5★ 81.95%.
288. §7.1: fr 273, 4.513, 1★ 4.76%, 5★ 74.73%.
289. §7.1: no 235, 4.757, 1★ 2.13%, 5★ 86.81%.
290. §7.1: nz 232, 4.703, 1★ 3.88%, 5★ 84.91%.
291. §7.1: ru 206, 4.549, 1★ 6.31%, 5★ 79.61%.
292. §7.1: dk 184, 4.647, 1★ 3.26%, 5★ 82.07%.
293. §7.1: be 166, 4.717, 1★ 2.41%, 5★ 83.73%.
294. §7.1: es 151, 4.470, 1★ 5.96%, 5★ 76.82%.
295. §7.1: mx 146, 4.829, 1★ 1.37%, 5★ 91.10%.
296. §7.1: br 142, 4.697, 1★ 2.11%, 5★ 85.92%.
297. §7.1: ie 122, 4.746, 1★ 3.28%, 5★ 86.07%.
298. §7.1: pl 112, 4.902, 1★ 0.00%, 5★ 93.75%.
299. §7.1: ch 111, 4.721, 1★ 1.80%, 5★ 86.49%.
300. §7.1: fi 111, 4.568, 1★ 4.50%, 5★ 77.48%.
301. §7.1: in 100, 4.850, 1★ 1.00%, 5★ 92.00%.
302. §7.1: za 94, 4.830, 1★ 1.06%, 5★ 89.36%.
303. §7.1: at 93, 4.667, 1★ 4.30%, 5★ 81.72%.
304. §7.1: sg 86, 4.663, 1★ 6.98%, 5★ 88.37%.
305. §7.1: ph 76, 4.750, 1★ 2.63%, 5★ 84.21%.
306. §7.1: ae 67, 4.896, 1★ 1.49%, 5★ 94.03%.
307. §7.1: it 59, 4.576, 1★ 5.08%, 5★ 83.05%.
308. §7.1: pt 58, 4.534, 1★ 6.90%, 5★ 81.03%.
309. §7.1: tr 58, 4.638, 1★ 5.17%, 5★ 81.03%.
310. §7.1: cn 53, 4.208, 1★ 5.66%, 5★ 52.83%.
311. §7.1: cz 51, 4.922, 1★ 0.00%, 5★ 92.16%.
312. §7.1 (caveat): where a non-English storefront shows a high theme rate that is a strong finding; where low, uninformative.
313. §7.2: high-review-volume group = us, gb, ca, au (>1,000 reviews each) — a review-volume group, explicitly not a proxy for downloads/revenue; group 64,513 reviews (92.11%), mean 4.769; rest of world 5,528 reviews, mean 4.690.
314. §7.2 group table: U-overwhelm us 1.53% / gb 1.48% / ca 1.60% / au 1.34%.
315. §7.2: C-age-rating us 1.40% / gb 1.17% / ca 1.41% / au 1.34%.
316. §7.2: M-paywall us 1.02% / gb 1.08% / ca 1.39% / au 1.39%.
317. §7.2: M-price-high us 0.81% / gb 0.91% / ca 1.20% / au 1.11%.
318. §7.2: D-crash us 0.76% / gb 0.75% / ca 1.31% / au 0.88%.
319. §7.2: U-boring us 0.76% / gb 0.70% / ca 0.86% / au 1.02%.
320. §7.2: D-data-loss us 0.78% / gb 0.69% / ca 0.93% / au 0.83%.
321. §7.2: U-childish us 0.75% / gb 0.75% / ca 0.84% / au 1.06%.
322. §7.2: C-pronouns us 0.66% / gb 0.33% / ca 0.57% / au 0.74%.
323. §7.2: M-should-be-free us 0.34% / gb 0.40% / ca 0.32% / au 0.32%.
324. §7.2: D-support us 0.25% / gb 0.24% / ca 0.46% / au 0.32%.
325. §7.2: M-trial-no-reminder us 0.22% / gb 0.21% / ca 0.40% / au 0.09%.
326. §7.2: P-mental-health us 12.26% / gb 15.22% / ca 10.66% / au 11.77%.
327. §7.2: P-motivation us 16.23% / gb 14.40% / ca 17.92% / au 18.10%.
328. §7.2: P-adhd-nd us 7.12% / gb 7.48% / ca 8.17% / au 11.40%.
329. §7.2: P-free-generous us 1.27% / gb 0.99% / ca 1.43% / au 1.62%.
330. §7.2: Canada is the group's problem market — lowest mean (4.689), highest one-star (3.33%), highest paywall (1.39%), price (1.20%), crashes (1.31%), data loss (0.93%), support failure (0.46%), trial-reminder failure (0.40%); highest paid-evidence rate in group (2.38% vs US 2.08%) — where the paid experience is worst and most reported.
331. §7.2: Australia has the most neurodivergent-identified base (P-adhd-nd 11.40% vs 7.36% global) and simultaneously the group's highest "too childish" (1.06%) and boredom (1.02%) rates — users came for ADHD support and are most likely to say the gamification is not aimed at them.
332. §7.2: UK reports the strongest mental-health benefit (15.22% vs 11.99%) and the group's lowest one-star rate — the healthiest large market.
333. §7.3 (method): no spend data; a "high-monetisation-exposure" proxy group is defined as storefronts ≥50 reviews whose paid-evidence rate exceeds the corpus rate of 1.97%.
334. §7.3 table: fi 111, paid-evidence 4.50%, billing-dispute 1.80%, mean 4.568.
335. §7.3: pt 58, 3.45%, 1.72%, 4.534.
336. §7.3: za 94, 3.19%, 0.00%, 4.830.
337. §7.3: ie 122, 2.46%, 0.00%, 4.746.
338. §7.3: ca 4,748, 2.38%, 0.95%, 4.689.
339. §7.3: sg 86, 2.33%, 2.33%, 4.663.
340. §7.3: at 93, 2.15%, 1.08%, 4.667.
341. §7.3: us 50,932, 2.08%, 0.55%, 4.777.
342. §7.3: in 100, 2.00%, 0.00%, 4.850.
343. §7.3: au 2,166, 1.99%, 0.60%, 4.716.
344. §7.3: only us, ca, au carry enough volume for stability; others [limited evidence]; stable finding — Canada has the highest paid exposure and highest billing-dispute rate of any large market, 0.95%, nearly double US 0.55% and more than double UK 0.43%.
345. §7.3: inverse group — Denmark (184), Belgium (166), Poland (112) show zero paid-evidence reviews; Poland also zero one-star and second-highest mean (4.902) — markets where the free product does well and paid product is absent from the written record.
346. §7.4: localisation is the single largest country-specific finding — U-localization 292 globally (0.42%, WEAK) but HIGH-PRIORITY at country level.
347. §7.4 table: cn 26.42% (14/53) HIGH-PRIORITY.
348. §7.4: ru 18.45% (38/206) HIGH-PRIORITY.
349. §7.4: tr 18.97% (11/58) HIGH-PRIORITY.
350. §7.4: br 13.38% (19/142) HIGH-PRIORITY.
351. §7.4: es 11.92% (18/151) HIGH-PRIORITY.
352. §7.4: mx 8.90% (13/146) HIGH-PRIORITY.
353. §7.4: fr 6.96% (19/273) HIGH-PRIORITY.
354. §7.4: de 5.87% (41/698) HIGH-PRIORITY.
355. §7.4: at 4.30% (4/93) VERY STRONG; ch 3.60% (4/111) VERY STRONG; pt 3.45% (2/58) VERY STRONG [limited evidence]; jp 15 mentions [limited evidence, n=45].
356. §7.4 (caveat): these rates are floors because rules fire only on English-language requests plus a few native-language markers.
357. §7.4: reviewers state they will not or cannot pay in English — 10089551843 (RU, 37 net votes, fifth most-endorsed review, "Wants see a Russian language.. that's all:)"), 13365815550 (RU, one star for no Russian, will give 5 if added), 13378852631 (BR, 215 million Portuguese speakers), 13145741750 (CA, French is an official language and the app asks personal questions in a second language), 12685853749 (CL, "no pagaré más el plus"), 12782609083 (DE), 12786765767 (FR), 13015580489 (TR), 12591344504 (CN), 12599016250 (JP), 14391291831 (RU), 14297425558 (JP).
358. §7.4: China is the worst-rated eligible storefront (mean 4.208, five-star 52.83% vs 87.88% norm) and 26.42% of its reviews are a language request.
359. §7.4: China contains a political-content complaint about Taiwan listed as a separate travel destination (11915474270, 12869927574) — two reviews, [limited evidence], a market-access risk category.
360. §7.5: accessibility as a market — 597 reviews (0.85%) mean 4.56 from blindness/VoiceOver (7831288958, 8427696106, 10055344806, 11110195517), physical disability/mobility (8427543028, 11467978208, 12047590938, 14249655239, 14176678035), chronic illness (12682396517, 13469175015), motion sensitivity/epilepsy (8432577759, 8517938841, 12097433833), sound sensitivity (13011506116, 14427781194, 14316419666), light sensitivity.
361. §7.5: the recurring structural complaint is that onboarding asks about disability and then ignores the answer — 14249655239 ("I have mobility issues, so I clicked that on the app, ever since, the app has been suggesting that I do things that I've told it I can't do").
362. §7.6: what does NOT vary by country — within the four Anglophone storefronts the complaint shape is stable (overwhelm, paywall, price, crashes, data loss in the same order, within a factor of ~1.8); billing-dispute, data-loss and feature-removal mechanisms are global product problems, not market problems.
363. §7.7 [limited evidence]: 90 sub-50 storefronts, 956 reviews (1.36%), mean 4.717 — indistinguishable from corpus.
364. §7.7 [limited evidence]: Japan (n=45) mean 4.533, and the corpus's only regional price-parity complaint — 13046812794 states Finch Plus is ¥11,000/yr (~$74) vs $40 in the US.
365. §7.7 [limited evidence]: Estonia (n=34), Hong Kong (n=37) both show means below 4.55; no conclusion drawn.
366. §8.1 (method): three time resolutions — half-year buckets (12, 2021H1–2026H2; all from 2022H1 carry ≥2,080 reviews; 2021H1 n=11 never used); calendar years for theme rates (2021 n=531 indicative only; 2026 partial through 7 Sep, n=11,594); month/day for incident detection only.
367. §8.1 year table: 2021 n=531, mean 4.842, 1★ 1.13%, 5★ 91.15%.
368. §8.1: 2022 n=16,820, 4.864, 1★ 1.11%, 5★ 91.70%.
369. §8.1: 2023 n=12,136, 4.810, 1★ 1.61%, 5★ 89.03%.
370. §8.1: 2024 n=13,144, 4.788, 1★ 2.11%, 5★ 88.63%.
371. §8.1: 2025 n=15,816, 4.684, 1★ 4.00%, 5★ 85.65%.
372. §8.1: 2026 (partial) n=11,594, 4.645, 1★ 4.00%, 5★ 83.15%.
373. §8.1: the one-star rate has more than tripled (1.11% → 4.00%) while volume stayed high — the most important background fact.
374. §8.1 half-year table: 2021H2 n=520, mean 4.842, 1★ 1.15%, billing 0.00, monet 3.27, reliab 2.12, data-int 0.58, prod-chg 0.19, values 0.38, gamif 4.23, positive-core 31.92.
375. §8.1: 2022H1 n=10,643, 4.881, 1★ 0.95, billing 0.11, monet 1.97, reliab 1.89, data-int 0.42, prod-chg 0.08, values 0.69, gamif 2.18, pos-core 30.40.
376. §8.1: 2022H2 n=6,177, 4.835, 1★ 1.39, billing 0.39, monet 2.88, reliab 1.80, data-int 0.81, prod-chg 0.18, values 1.00, gamif 2.57, pos-core 32.15.
377. §8.1: 2023H1 n=6,889, 4.811, 1★ 1.67, billing 0.68, monet 3.32, reliab 1.97, data-int 0.89, prod-chg 0.26, values 0.96, gamif 2.41, pos-core 31.17.
378. §8.1: 2023H2 n=5,247, 4.810, 1★ 1.52, billing 0.34, monet 2.50, reliab 1.51, data-int 0.32, prod-chg 0.13, values 1.05, gamif 2.04, pos-core 30.55.
379. §8.1: 2024H1 n=7,357, 4.834, 1★ 1.37, billing 0.30, monet 2.83, reliab 1.32, data-int 0.54, prod-chg 0.33, values 0.82, gamif 2.50, pos-core 31.83.
380. §8.1: 2024H2 n=5,787, 4.730, 1★ 3.04, billing 0.93, monet 3.84, reliab 2.23, data-int 0.79, prod-chg 0.40, values 1.40, gamif 3.77, pos-core 33.04.
381. §8.1: 2025H1 n=9,106, 4.712, 1★ 3.40, billing 0.83, monet 3.12, reliab 1.70, data-int 0.90, prod-chg 0.54, values 1.42, gamif 2.91, pos-core 30.32.
382. §8.1: 2025H2 n=6,710, 4.644, 1★ 4.80, billing 1.18 (peak), monet 3.40, reliab 3.17, data-int 1.73, prod-chg 0.67, values 1.56, gamif 3.43, pos-core 27.72.
383. §8.1: 2026H1 n=9,514, 4.652, 1★ 3.94, billing 0.58, monet 2.90, reliab 4.80 (peak), data-int 1.76, prod-chg 0.61, values 1.89, gamif 3.01, pos-core 25.11.
384. §8.1: 2026H2 n=2,080, 4.612, 1★ 4.28, billing 0.82, monet 2.98, reliab 2.84, data-int 1.49, prod-chg 1.15 (peak), values 2.93 (peak), gamif 3.80, pos-core 23.08 (low).
385. §8.2(a): 4 May 2022 crash on launch — 128 reviews that day vs ~90/day May baseline, mean 3.72 vs 4.87 monthly, 34 one-star, 42 crash-tagged in one day; 3–6 May: 400 reviews, 46 crash-tagged, 34 one-star; mostly first-time users who installed after seeing an ad (8636217694 … 8637858391, 43 IDs listed).
386. §8.2(a): the May 2022 incident resolved within days and never recurred at that magnitude — a clean closed incident, and proof the corpus detects such events at day resolution.
387. §8.2(b): February 2026 Wonderland crash — 120 crash-tagged reviews in Feb 2026 vs 15 in Jan 2026 and a 2023–24 monthly norm of 1–15; daily 20 on 2 Feb, 11 on 3 Feb, 10 on 4 Feb, 9 on 6 Feb; elevated through 20 Feb; monthly one-star 4.85%.
388. §8.2(b): reviewers named the trigger — Queen of Hearts / Alice-in-Wonderland "grow potion" enlarged the pet, then app crashed on load; 13707568156 (DE: "since my birb drank the giant potion the app crashes constantly"), 13711835469, 13712524146, 13712907369, 13716361582, 13717934083, 13718339682 ("just kill the Alice in wonderland Thema we can use the app again"), 13718363548, 13719270017, 13726885801, 13708094324, 13705133623, 13710325280, 13743955362, 13753537085; 67 reviews mention Wonderland/Queen of Hearts directly, mean 3.40.
389. §8.2(b) consequences: lost streaks of 47, 70, 142, 300, 400+ and 600+ days (13743955362, 13743566701, 13725395996, 13767997910, 13711833057, 13704583556); inability to run a backup because the app crashed first; paid subscriptions unusable for weeks (13707818559, 13750797974, 13737744762).
390. §8.2(b): the severity multiplier is the streak mechanic — in 2022 a crash cost a session; in 2026 a crash costs a 600-day streak.
391. §8.3: reliability family 1.89% (2022H1) → 4.80% (2026H1); crash theme by year 0.80% (2022) → 0.53% (2023) → 0.36% (2024) → 0.52% (2025) → 2.03% (2026); the 2024 trough is real (app got more stable) and 2026 is a regression, not a continuation.
392. §8.3: D-event-bug by year 0.07% (2022), 0.05% (2023), 0.08% (2024), 0.06% (2025), 0.32% (2026); June 2026 alone contributed 14 event-bug reviews and 42 data-loss reviews.
393. §8.3: D-streak-bug by year 0.01% (2022), 0.01% (2023), 0.17% (2024), 0.39% (2025), 0.74% (2026) — a defect class that could not exist before streaks shipped.
394. §8.3: reviewers blame the monthly event cadence for shipping unstable code — 14154438154 ("Instead of doing things to improve the stability of the app, the finch team just keeps launching events that feels like they haven't tested anything"), 14224222208, 14130446306, 13977961683, 14225501459, 14083723197, 13513453625, 14224706579.
395. §8.4: data-integrity family by half-year 0.42% → 0.81% → 0.89% → 0.32% → 0.54% → 0.79% → 0.90% → 1.73% (2025H2) → 1.76% (2026H1) → 1.49% (2026H2) — broke down in H2 2025 and has not recovered.
396. §8.4: D-data-loss by year 0.46% (2022), 0.46% (2023), 0.56% (2024), 1.08% (2025), 1.47% (2026); monthly step-change — 22 in Jul 2025, 20 Nov 2025, 21 Dec 2025, 21 Jan 2026, 28 Feb 2026, 42 Jun 2026 vs 2023–24 norm of 1–13 per month.
397. §8.4: the problem statement changed — 2022–23 dominant story "I deleted the app and lost everything" (user-initiated); from 2025 dominant story "it told me my pet data got corrupted" (app-initiated, unprompted): 12595515502 (Apr 2025), 12881347765, 12900566231, 12925432031, 12927945751, 12935512228, 13033899041, 13435820986, 13508532787, 13683756253, 13732070192, 13793063550, 13823631569, 13834130232, 13859108920, 13865948762, 13886009955, 13977008427, 14145164297, 14194313597, 14242421063, 14274791231, 14373848758, 14381587355.
398. §8.4: app-initiated corruption is more serious than the 2022 version because the user did nothing and the standard recovery (a manual backup they may never have made) is unavailable.
399. §8.5 change table: bird redesign / new animations, Mar 2022, ~15 reviews (8431474054, 8433557491, 8423825673, 8428795694, 8430950964, 8602453752, 8450607835).
400. §8.5: house/nest feature leaked then withdrawn, Jul–Aug 2022, ~6 (8927346914, 8928490368, 8931782968, 8931967858, 8934343143, 8940560295).
401. §8.5: paywall creep on previously-free items, Nov 2022 onward, M-paywall 715, mean 4.38 (9337272695, 9364974191, 9386542212, 9479031601, 9771124109, 9138911582).
402. §8.5: "Beta" account sync locks users out, Mar 2023, D-login-account ~12 in month (9686931072, 9699066698, 9699388738, 9712101197, 9714150379, 9723946025).
403. §8.5: major UI redesign, Feb 2024, U-ui-change 24 in 2024, mean 3.57 (10906118540, 10909346801, 10917010011, 10917852575, 10919712068, 10942641436, 10946015163, 10983032325, 10996138525, 10997614001, 11001128510, 11004907223, 11031925790, 11133639611, 10938969089, 10919643786, 10920304817).
404. §8.5: Tree Town non-user "friends" removed, May 2024, ~5 (11249547975, 11250263856, 11252722247, 11254260811, 11256055041).
405. §8.5: streaks introduced ~mid-2024, U-streak-pressure 24 (2024), mean 3.96 (11350735942, 11396970425, 11401527483, 11548301986, 11591661994, 11688717901).
406. §8.5: Journeys → Self-Care Areas, Apr–May 2025, U-journeys-removed 49 total / 36 in 2025, mean 2.76 (full list §10.7).
407. §8.5: Guardian/AI ads controversy, Jan & May 2025, C-ai 62 (2025), mean 4.35 (12213043459, 12219142669, 12728967109, 12686511039, 13253481318).
408. §8.5: hiring-ethics allegations, May 2025, C-hiring-ethics 8 (2025), mean 1.67 (12684393117, 12686511039, 12705023244, 12709962941, 12716829097).
409. §8.5: auto mood check-ins + affirmations removed, Oct–Nov 2025, U-moodcheckin-removed 64 total, mean 3.77 (13305396533, 13306356665, 13342650115, 13344861750, 13397787719, 13410263343, 13412273696, 13414089882, 13420079481, 13425412408, 13442043764, 13475103522, 13480507283).
410. §8.5: exact-time goal scheduling removed, Nov 2025 – Jan 2026, U-timedgoals-removed 9 total, mean 3.11 (13372364201, 13414781377, 13418954795, 13523723252, 13527307155, 13535877318, 13591367850, 13712815939, 13569702591).
411. §8.5: multi-add of goals as a list removed, Dec 2025 – Feb 2026, ~10 (13501873014, 13504992115, 13595168865, 13489561522, 13662364288, 13927178942, 14218873851).
412. §8.5: friends "house" view → tree only, Jun 2026, ~8 (14141621712, 14143079962, 14145326653, 14146681247, 14156325373, 14076986749).
413. §8.5: Special Quests / milestones removed, Jun–Jul 2026, U-feature-removed-generic 37 in 2026, mean 3.13 (14213362996, 14217885463, 14221509378, 14221781843, 14241117951, 14280429752, 14299934656, 14201555063).
414. §8.5: colour palettes restricted, Aug–Sep 2026, ~10 (14374387869, 14375332074, 14378349434, 14399992054, 14452613945, 14499796343, 14501652328).
415. §8.5: generic feature-removal complaints by year 0.02% (2022) → 0.03% (2023) → 0.12% (2024) → 0.11% (2025) → 0.32% (2026) — 16× increase on 2022.
416. §8.5: Journeys removal is the sharpest single case — lowest-rated product-change theme (mean 2.76), 21 of 49 one-star; argument: Journeys rewarded cumulative non-consecutive progress, Self-Care Areas reward consecutive streaks, and the audience's progress is by definition not consecutive; 12557701970 ("They removed the component that gave users a sense of levelling… replaced it with daily streaks"), 12674347241, 12682396517 ("as someone with severe chronic illness, the Journeys feature was incredible… I've regretfully canceled my subscription"), 12778041860, 12655037808, 14299934656 (clinician: "only 1 of 2 apps I actually recommend to my clients — all adults with ADHD"), 12596071096, 12559327482, 12547227541, 13365769674, 13420079481.
417. §8.5: mood check-in removal is the second sharpest, argued on accessibility — an automatic prompt is a memory aid; moving it behind a button destroys the dataset for the users who need it; 13860027170 ("my mood data is now almost empty for the last three months even though I do the emotion exercise multiple times a day"), 13305396533, 13425412408, 13414089882, 13855090245, 14256888213, 14352654672, 14129375665, 14114531927.
418. §8.6: content/values family 0.69% (2022H1) → 1.42% (2025H1) → 1.89% (2026H1) → 2.93% (2026H2) — the product's values become a subject of the reviews in 2026.
419. §8.6: C-brand-collab by year 2 (2022), 5 (2023), 3 (2024), 10 (2025), 107 (2026); mean 3.09, lowest of any content theme.
420. §8.6: public-domain themes (Wizard of Oz, Alice in Wonderland) were tolerated with unease; the June 2026 DC/Supergirl month was not — 80 reviews name Supergirl, 68 in June 2026, mean 2.99.
421. §8.6 objection: "you are charging me and advertising to me" — 14136600404 (575-day streak, multi-year subscriber), 14117246332, 14138680122, 14140955362, 14215941056, 14501663825, 14508228351, 14498576224.
422. §8.6 objection: "this month should have been Pride" — 14134408387, 14134482780, 14134936737, 14139989307, 14229930466, 14147610199, 14132851708.
423. §8.6 objection: criticism was suppressed — 14154691963, 14201570708, 14260047035, 14259246801, 14372739263.
424. §8.6 objection: the rollout was broken as well as unwanted — June 2026 produced the second-worst event-bug cluster (14 event-bug, 42 data-loss, 104 one-star reviews in June 2026): 14131417726, 14131438528, 14131450486, 14131532201, 14131538351, 14131553883, 14132105291, 14132390235, 14132812030, 14134216657, 14141277158, 14142849398, 14146627922.
425. §8.6: July 2026 1950s drive-in theme drew a racial/heteronormative-representation critique (14259430571, 14260154347, 14261659918, 14268143502, 14257917174).
426. §8.6: September 2026 brought a further film tie-in (14497986029, 14498063439, 14499201114, 14499448804, 14506507280, 14507114042, 14511033109).
427. §8.6: why it matters more than 127 reviews — 857 reviewers singled out ad-freeness as the reason they trusted the product; C-brand-collab 8.0× over-represented among paying users; the people most offended are the people paying.
428. §8.7: M-paywall by year 1.20% (2022) → 1.07% → 1.09% → 0.85% → 0.85% (2026) — falling.
429. §8.7: M-price-high 0.57% → 0.86% → 1.22% (2024 peak) → 0.94% → 0.72% (2026) — peaked 2024, now falling.
430. §8.7: M-should-be-free 0.37% → 0.41% → 0.29% → 0.25% → 0.35% — flat.
431. §8.7: M-trial-no-reminder 0.07% → 0.20% → 0.24% → 0.38% → 0.28% — up 4–5×.
432. §8.7: M-trial-charged 0.06% → 0.19% → 0.21% → 0.38% → 0.24% — up 4–6×.
433. §8.7: M-refund-denied 0.04% → 0.14% → 0.14% → 0.21% → 0.19% — up ~5×.
434. §8.7: M-not-free (false-advertising claim) 0.04% → 0.16% → 0.19% → 0.26% → 0.28% — up 7×.
435. §8.7: users have largely stopped arguing about the price and started arguing about the transaction — a solvable problem, different from what a pricing change would address.
436. §8.8: P-mental-health by year 15.44% (2021) → 14.02% → 13.55% → 11.78% → 10.67% → 9.30% (2026).
437. §8.8: P-tools by year 15.63% → 7.98% → 5.24% → 5.57% → 4.08% → 2.65% (2026).
438. §8.8: P-companion 2.64% → 2.57% → 2.00% → 1.71% → 1.52% → 1.32%.
439. §8.8: positive-core family 30.40% (2022H1) → 23.08% (2026H2).
440. §8.8: P-motivation roughly flat (15.2% → 13.0%); P-social rose slightly (3.03% → 3.09%).
441. §8.8: read with §8.5 it is one story — the therapeutic tool-set is mentioned less as it moves behind menus and paywalls while task-tracking and collection layers stay prominent; long-form reviewers assert this (13828330334, 14268143502, 14425330451, 13456598701, 14420113173, 13688122090, 12551489443, 10983032325).
442. §8.9 (not claimed): no trend in pronoun objections — C-pronouns-objection 0.10% (2022), 0.06%, 0.07%, 0.08%, 0.07% (2026), flat and small.
443. §8.9 (not claimed): no trend in safety-content complaints — C-safety 0.51% → 0.41%; the 2022 "schedule time for suicide" cluster is a closed incident.
444. §8.9 (not claimed): no trend in community moderation — 0.35% → 0.22%, slight decline.
445. §8.9 (not claimed): no seasonality — monthly volume tracks marketing and event releases, not calendar season.
446. §8.9 (not claimed): no claim about 2026H2 beyond the data — covers only July–7 Sep (n=2,080); elevated content-values rate (2.93%) consistent with §8.6 but partial.
447. §9.1 F1: make the trial-conversion reminder real and provable — 404 billing-dispute reviews mean 1.97, 244 one-star, 241/1,381 paying reviewers, rate rose 4–6× 2022–2025.
448. §9.1 F1 sub-fix: send the promised pre-charge notification in-app as a blocking card on next open, not only as push (push arrives at 1am and drowns in the app's own notification volume — 13126279553).
449. §9.1 F1 sub-fix: show the exact amount and exact charge date on the trial-acceptance screen and again in Settings, permanently.
450. §9.1 F1 sub-fix: investigate and publicly explain the 149 "charged at trial start" reports (real charges, pre-auths or store artefacts) — 149 people believe it and 99 left one star.
451. §9.1 F1 sub-fix: put a working cancel path inside the app rather than deep-linking to Apple's subscription page (66 M-cancel-hard reviews mean 2.18).
452. §9.1 F2: ship automatic cloud backup on by default — 551 data-loss reviews, 9.09% of the one-star band, family rate quadrupled 2022H1→2026H1; the clearest single engineering ask.
453. §9.1 F2 sub-fix: back up automatically without a manual "create save file" step — 37 reviews did not know a manual backup was required until after the loss.
454. §9.1 F2 sub-fix: never present "pet data corrupted → re-hatch" as the only option; offer server-side recovery, and if impossible restore inventory rather than offering 5,000 stones to someone who lost 30,000.
455. §9.1 F2 sub-fix: fix account recovery — 90 reviews describe email/phone not recognised for accounts that demonstrably exist (friends can still see the bird): 14141439529, 13806982854, 14102886128, 13583950351.
456. §9.1 F2 sub-fix: warn before the destructive path — users delete the app for storage and discover the consequence afterwards, every year, every market.
457. §9.1 F3: gate monthly events behind a crash test — Feb 2026 produced 120 crash-tagged reviews from a single event asset; June 2026 a second cluster; corpus contains the exact repro ("after the growth potion"); a pre-release check across device generations would have prevented the largest quality event and, because of streaks, the largest destruction of user progress.
458. §9.1 F4: fix the widget — 117 reviews over five years, mean 3.91, still open in 2026; longest-running unresolved complaint; cheap goodwill.
459. §9.1 F5: answer support email — 185 reviews, 26% from paying users, 13.2× over-representation; complaints are weeks of silence, canned replies, AI responses repeating three troubleshooting steps; 14366340795 ("Please get some humans involved in your tech support").
460. §9.2 decision: decide explicitly and publicly whether Finch is a self-care tool with a game attached or a collection game with self-care attached, and align the roadmap — the corpus says it drifted to the second without saying so.
461. §9.2 convergence signal: P-tools mentions 15.63% (2021) → 2.65% (2026).
462. §9.2 convergence signal: positive-core family 30.40% (2022H1) → 23.08% (2026H2).
463. §9.2 convergence signal: U-overwhelm 1,046 reviews, MEANINGFUL, largest UX theme.
464. §9.2 convergence signal: feature removals (Journeys, mood check-ins, timed goals, milestones) all replaced by streak/collection mechanics.
465. §9.2 convergence signal: U-streak-pressure + D-streak-bug 0 → 267 reviews since mid-2024.
466. §9.2 convergence signal: C-brand-collab 2 (2022) → 107 (2026).
467. §9.2: long-form reviewers state the drift as a thesis (13828330334, 14268143502, 14420113173, 13688122090, 12551489443, 14425330451, 13456598701, 13828096584, 13971066794); most quoted formulation 13688122090: "a pay-to-play loot box checklist simulator."
468. §9.2: not a recommendation to remove the game — the game is why 10,074 call it cute and 11,175 say it motivates; recommendation is to stop making the therapeutic layer pay for the game layer's growth.
469. §9.2 specific: put First Aid back on the home screen.
470. §9.2 specific: restore an optional automatic mood check-in.
471. §9.2 specific: stop moving breathing/soundscapes/reflections further behind menus.
472. §9.3 P1: restore cumulative, non-streak progress tracking — Journeys removal is the lowest-rated change (mean 2.76); requirement is credit for non-consecutive progress, not the old UI; chronic-illness and ADHD users say streak-only is structurally incompatible with their lives; ship alongside streaks, not instead.
473. §9.3 P2: make every guilt mechanic optional — streak display, streak repair prompts, event countdowns, commitment prompts; 476 reviews praise the app for not guilting them, 96 now say it does; a single "gentle mode" toggle resolves U-streak-pressure and a large share of U-fomo-events.
474. §9.3 P3: reduce the interstitial cost of the core action — 1,046 overwhelm reviews and 84 "too many taps"; ask is a path from launch to checkbox not passing through a quote, mood prompt, event cutscene, visitor, chest, and claim-confirm-claim sequence; 12717371857 counts the claim button appearing three times for one reward.
475. §9.3 P4: let users buy what they can see — catalogue shows items that cannot be purchased, shop rotates randomly, re-roll costs currency; frustration from engaged, currency-rich users most likely to subscribe (13291611680, 14437464706, 12896721169, 13528610213, 14277989798).
476. §9.3 P5: ship the platform integrations people are asking to pay for — Apple Health (608, 4.69), Apple Watch (92, 4.71), cross-device sync (31, 4.16, zero one-star), Family Sharing (30); the stated price of a fifth star and, for Family Sharing, of two or four subscriptions instead of one.
477. §9.3 P6: ship dark mode and finish the accessibility work — 90 dark-mode requests since 2022, 597 accessibility reviews; close the loop onboarding opens: if a user declares a mobility limitation, stop suggesting walks (14249655239).
478. §9.3 P7: localise — English-only is HIGH-PRIORITY in eight storefronts simultaneously (cn 26.4%, tr 19.0%, ru 18.5%, br 13.4%, es 11.9%, mx 8.9%, fr 7.0%, de 5.9%); priority order: German, Spanish (es-419 + es-ES), French, Brazilian Portuguese, Russian, Japanese.
479. §9.3 P8: make the values screens optional in both directions — a "skip pronoun selection" toggle addresses 54 delete-at-onboarding reviews; a show/hide filter for themed cosmetic categories addresses the 109 objection reviews and defuses the framing by giving everyone the same control.
480. §9.3 P8: the 111 reviews asking for more representation have a higher mean (4.57) than the 109 asking for less (3.50) — loyal users; the missing-lesbian-flag complaint recurs 2022–2026 unfixed.
481. §9.4 bullet: stop spending the ad-free reputation — 857 reviews name it as the reason they trust the product; sponsored IP events 8.0× over-represented among paying users, mean 3.09; if partnerships continue, make them opt-in for subscribers.
482. §9.4 bullet: offer a genuine monthly plan and price it visibly — 23 reviews ask directly; default-to-annual is the mechanism behind most of the 404 billing disputes; several say they would have paid monthly (11241544851, 11243997394, 12547404473).
483. §9.4 bullet: offer a one-time purchase tier — 47 reviews ask explicitly, mean 3.62.
484. §9.4 bullet: fix price presentation — 12 reviews report household members quoted different prices the same day; support could not explain; perception is discriminatory pricing inside families.
485. §9.4 bullet: formalise and publicise the Guardian pathway — mean 4.76 across 708 mentions; only consistent complaint is no visible way to apply.
486. §9.4 bullet: do not raise prices to solve the paid-satisfaction problem, and do not cut them either — §8.7 shows price complaints falling while billing complaints rise 4–6×; the problem is the transaction, not the number.
487. §9.5 experiment 1: blocking in-app trial reminder vs push-only — measure billing-dispute review rate and refund requests; expected to move the single worst-rated family.
488. §9.5 experiment 2: "gentle mode" toggle (streak hidden, no repair prompts, no event countdown) — measure retention among self-identified ADHD/chronic-illness users against the 476-review non-punitive praise baseline.
489. §9.5 experiment 3: automatic backup default-on with a one-line disclosure — measure data-loss review rate against the 2025H2–2026H1 baseline of 1.7–1.8%.
490. §9.5 experiment 4: home-screen First Aid button restored — measure P-tools mention rate, which fell 15.63% → 2.65%.
491. §9.5 experiment 5: German + Spanish localisation as a paired test — measure paid-evidence rate in de/es/mx against the current 1.29%/0.66%/0.68%.
492. §9.5 experiment 6: catalogue-direct purchase (buy any owned-catalogue item at a premium) vs random rotation — measure U-economy complaint rate and Plus conversion among high-balance users.
493. §9.6 research question: are the "charged at trial start" reports real charges, pre-authorisations, or store display artefacts? 149 reviews cannot distinguish; server logs can.
494. §9.6 research question: what is the actual rate of data corruption per active user? corpus gives 551 reports, no denominator.
495. §9.6 research question: did any removed feature (Journeys, auto mood check-in, timed goals) improve the metrics it was removed to improve? corpus contains only the cost side.
496. §9.6 research question: do sponsored IP events acquire more users than they cost in cancellations? corpus has 127 cancellations-and-complaints and zero acquisition evidence.
497. §9.6 research question: what is subscriber satisfaction among people who never write about money? paid cohort is 1,381 self-selected reviewers, not a sample.
498. §9.6 research question: why did paid-evidence rate stay flat (1.6–2.3%) while paid sentiment fell 1.44 stars? something changed in the experience, not in who was writing.

## Diff against cards.jsonl (done after the blind pass)

498 blind lines checked against 178 cards — mechanically (token / number / review-ID overlap) and then by hand for lines whose match was only a table card. Gaps found and fixed:

| blind line | gap | fix |
|---|---|---|
| 321 | `U-childish` (tone reads as childish to adults) existed only inside the verbatim §7.2 table card R10-120 and the Australia audience card R10-122 | new R10-179 (positioning) → C057 |
| 323, 430 | `M-should-be-free` (normative objection to charging) existed only inside R10-120 and the §8.7 series card R10-149 | new R10-180 (monetization) → C064 |
| 438 | `P-companion` year series carried only first → last on R10-150 | R10-150 magnitude now carries all six values |
| 51 | §1.3 validation detail (specific false positives, recall probe) absent from the method card | R10-002 magnitude extended |

Everything else had a matching card. Two rules added to `Report Synthesis Prompt.md` so the first and third gaps cannot recur.
