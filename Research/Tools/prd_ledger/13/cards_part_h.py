import json, re
R = 13
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(73, "§8.1 #1 Let the trial start without first authorising a subscription", "must-never-break",
  "Let the trial start without first authorising a subscription — trial ends, THEN ask; removes the corpus's single largest 1★ cause",
  "subscription-first trial", "1★-burst", "M-trial-autocharge 1,102 (5.55%) mean 1.20, 999 one-star", "must-never-break", "recommendation (immediate)", "yes", [])
c(74, "§8.1 #2 Send a pre-charge reminder 48h before the trial converts, by push and email", "must-never-break",
  "Send a pre-charge reminder 48h before the trial converts, by push and email — reviewers repeatedly say they simply forgot and were given no warning",
  "no pre-charge reminder", "1★-burst", "5 cited IDs", "must-never-break", "recommendation (immediate)", "yes",
  ["2761367882","3245169646","2922764410","4547651109","6437141830"])
c(75, "§8.1 #3 Put a working 'Manage / cancel subscription' link inside the app", "must-have",
  "Put a working 'Manage / cancel subscription' link inside the app — would address ~1 in 4 Korean reviews on its own",
  "no in-app cancel", "1★-burst", "M-cancel-hard 448 (2.26%) mean 1.54; KR 24.7%", "must-have", "recommendation (immediate)", "yes", [])
c(76, "§8.1 #4 Never default the trial to the most expensive tier; show the price before the Apple sheet", "must-never-break",
  "Never default the trial to the most expensive tier — let the user pick and show the price before the Apple sheet; removes the 'I never chose this plan' complaint",
  "defaults to dearest annual tier", "1★-burst", "M-price-tiers 42 mean 1.95", "must-never-break", "recommendation (immediate)", "yes",
  ["3272238239","2380437896","2072447786","3013464875"])
c(77, "§8.1 #5 State the price and the subscription requirement in the store listing's first line", "do",
  "State the price and the subscription requirement in the store listing's first line — reviewers quote 'Productive is a free tool' back verbatim; converts a trust complaint into an expectation",
  "listing says 'free tool'", "1★-burst", "M-not-free 379 (1.91%) mean 1.73", "do", "recommendation (immediate)", "yes",
  ["2603968263","3279151694","3608386362"])
c(78, "§8.1 #6 Stop the exit-intent discount", "dont",
  "Stop the exit-intent discount — halving the price the moment someone declines tells every full-price buyer they overpaid",
  "49% exit discount", "complaint", "M-exit-discount 36", "dont", "recommendation (immediate)", "yes",
  ["6883350995","4581049748","3537334343","4356723890"])
c(79, "§8.1 #7 Retire canned public replies", "dont",
  "Retire canned public replies — answer the specific complaint or do not reply; the cheapest rating repair available",
  "canned public replies", "1★-burst", "C-canned-reply 20 mean 1.40, zero 5★; D-support 57 mean 1.35", "dont", "recommendation (immediate)", "yes", [])
c(80, "§8.1 Regional priority — ship to China and South Korea first; explicit in-app confirmation step required in China", "do",
  "Regional priority: ship the billing fixes to China and South Korea first — 9.6% of the corpus but 62.4% of all involuntary-charge reviews; in China password-free payment means an explicit in-app confirmation step is required, not optional",
  "no confirmation before charge in CN", "1★-burst", "CN+KR 534 of 856 involuntary (62.4%)", "do", "recommendation (immediate)", "yes", [])
c(81, "§8.2 Immediate — the launch-failure bug: a habit tracker must open offline and must never gate its local data behind a network call", "must-never-break",
  "Fix the blocking on-launch update path: a habit tracker must open offline and must never gate its local data behind a network call — make the migration non-blocking, cache locally, never wipe on reinstall",
  "network-blocked launch; wipe on reinstall", "1★-burst", "D-stuck-updating 46; Oct 2020 5.9% of month", "must-never-break", "recommendation (immediate)", "yes",
  ["14453446467","12844697075"])
c(82, "§8.3 Near-term product table (verbatim)", "feature",
  "Near-term build priorities: make iCloud sync work and show sync state in the UI; flexible scheduling (weekdays, every-N-days, N-times-per-week that scores correctly); reordering that persists; per-entry notes (the largest pure request); numeric goals; Arabic then Portuguese, Turkish, Traditional Chinese; back-dating a missed check-off (named since the corpus's second-ever review, 2015); data export (unaddressed for eleven years, also a trust signal); let users hide Challenges/Explore",
  "n/a", "complaint", "sync 497; scheduling 79+34+155; reorder 77+22; notes 251; quantity 165; localisation 164; backdate 29; export 41; challenges 122", "build-free", "recommendation (near-term)", "yes",
  ["9402208057","3743847782","5747144309","7806022477","5907419362","5343328336","6078869840","2804919606","8389382415","5951908643","1233009943","9948539388","10245447172"])
c(83, "§8.3 #1 Make iCloud sync actually work, and show sync state in the UI", "must-never-break",
  "Make iCloud sync actually work and show sync state in the UI — the fastest-worsening dimension",
  "sync broken, no state shown", "complaint", "D-sync 497 (2.50%); 8.90% of 3★; 0.9% → 5.7% across eras", "must-never-break", "recommendation (near-term)", "yes", [])
c(84, "§8.4 #1 Sell the thing people say they'd buy — a perpetual 'Pro' unlock alongside the subscription", "monetization",
  "Sell the thing people say they'd buy: 239 reviews request a one-time purchase, in every year 2017–2026 and inside 5★ reviews — a perpetual 'Pro' unlock alongside the subscription would convert a population that currently converts at zero",
  "subscription only", "blocked-conversion", "M-want-onetime 239 (1.20%)", "build-paid", "recommendation", "yes",
  ["2054778874","1809268653","8833995869"])
c(85, "§8.4 #2 Move the first paywall behind engagement — three separate days", "product-rule",
  "Move the first paywall behind engagement: the actual purchase trigger is hitting the cap while engaged, yet the paywall fires 3–15 times in the first three minutes — delay the first interstitial until the user completes habits on three separate days",
  "paywall before engagement", "blocked-conversion", "cap-trigger in 836 buyers; 3–15 interstitials in first 3 minutes", "product-rule", "recommendation", "yes", [])
c(86, "§8.4 #3 Re-examine the price ladder — weekly billing is the format most associated with the word 'immoral'", "dont",
  "Re-examine the price ladder: weekly billing at $3.99–€6 draws uniquely hostile reactions and is the format most associated with the word 'immoral' in this corpus",
  "weekly tier", "1★-burst", "M-price-high 26.7% of 2025 [small sample]", "dont", "recommendation", "yes", [])
c(87, "§8.4 #4 Price by market — 'three meals' vs 'fourteen meals'", "do",
  "Price by market — the same USD price is 'three meals' in one market and 'fourteen meals' in another; China's mean of 1.84 is not a product verdict",
  "single global price", "complaint", "CN mean 1.84", "do", "recommendation", "yes",
  ["5525308783"])
c(88, "§8.4 #5 Do not gate exact reminder times — a habit app's core mechanic", "product-rule",
  "Do not gate exact reminder times — a habit app's core mechanic, the most-resented single gate in the corpus, and free competitors provide it",
  "exact reminder times paid", "complaint", "U-exact-time 227 (1.14%) mean 3.90", "product-rule", "recommendation", "yes",
  ["2246849667","2172919142","2544359717","6953060121"])
c(89, "§8.5 What a competitor entering this category gets free from this corpus", "insight",
  "For a competitor: the core need is small and well-specified — reminder → tick → visible streak; a one-time purchase option is a live differentiator requested continuously across eleven years; ADHD/neurodivergent and mental-health users are self-identifying under-served segments; Arabic is an open market; the trust bar is on the floor — honest pre-download pricing and a working cancel button would be positioning, not table stakes",
  "n/a", "none", "P-utility 5,565; M-want-onetime 239; P-adhd-nd 463 (2.33%); P-mentalhealth 100 mean 4.34; SA 20.5%", "do", "competitor lesson", "yes", [])
c(90, "§8.6 Research questions this corpus cannot answer; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5; part 8 #6; part 8 #7", "data-caveat",
  "Research questions: actual trial→paid conversion and how much is unintended; how many subscribers sync successfully; would a perpetual unlock cannibalise or expand; did the Oct 2020 launch failure cause churn; is the weekly tier net-positive despite rating damage; what share of Douyin installs understood they were purchasing; does the app still collect location and why",
  "n/a", "none", "7 questions", "research", "research questions", "yes", [])

with open("Tools/prd_ledger/13/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
