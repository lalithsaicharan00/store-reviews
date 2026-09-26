import json, re
R = 12
rep = open("App Store Reports/12. That Girl - Routine Planner - Cute Daily Calendar Schedule (REPORT).md").read().split("\n")
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
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(1, "header lines 1-10", "positioning",
  "That Girl: Routine Planner (App Store ID 1597753705) — 'Cute Daily Calendar Schedule' — a hard-paywall, onboarding-heavy aesthetic routine/day planner; the report's decision question is whether that model is viable and what a competitor entering this space should build, price and avoid",
  "developer Solowei Group LTD (artistId 1683543614); Productivity (secondary Health & Fitness); hard paywall — 'fully paid and purchase is required to access any content'; store rank 12", "1★-burst",
  "404 written reviews, 58 storefronts, 18 Dec 2021 → 16 Aug 2026; written mean 2.10 vs store aggregate 4.83 across 5,825 US ratings", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Part 1 SCOPE AND METHOD table (verbatim); §10.3–10.5 method", "data-caveat",
  "Method: denominator 404, non-exclusive themes (one review can carry six labels), standard bands; full manual read of all 404 records in original language with a regex classifier run independently and disagreements adjudicated record-by-record in favour of the manual reading; only the US (135) clears 50 (next GB 40, DE 20, AU 18, CA 17); 0 duplicate pairs, 0 empty bodies, is_edited true for 1; vote_sum 94 total (too sparse); reconciliation exact",
  "n/a", "none", table("# PART 1 — SCOPE AND METHOD"), "none", "method", "yes", [])
c(3, "⚠️ Two warnings — 1. The star rating in this corpus is not a clean sentiment measure for this app", "data-caveat",
  "The star rating is not a clean sentiment measure: 23 reviewers describe an in-app prompt asking for 5 stars during onboarding before use; two of the 77 five-star reviews say in plain text they rated 5 because they were told to; 14 of 77 five-star reviews carry text contradicting the rating — treat 5★ counts as an upper bound on satisfaction",
  "rating prompt inside onboarding", "mixed", "23 (5.69%); 2 of 77 coerced; 14 of 77 (18.18% of 5★) contradict", "dont", "high-priority", "yes",
  ["13814071134","13279632399"])
c(4, "⚠️ Two warnings — 2. Written reviews are ~2.4% of ratings", "data-caveat",
  "Written reviews are ~2.4% of ratings; written reviewers skew to complainers AND, for this app, to people who escaped the onboarding rating prompt — the 4.83 store average and the 2.10 written mean describe two different populations, and neither alone describes the product",
  "n/a", "none", "12,784 ratings vs 309 written across 13 storefronts (2.42%); 4.83 vs 2.10", "none", "method", "yes", [])

# ---- PART 0 ----
c(5, "Part 0 §1 This is not a habit-tracker review corpus. It is a paywall corpus.", "product-rule",
  "This is a paywall corpus: nearly half of everything written was written by people who never used the app — they hit the payment gate and did not pay; the paywall complaint is the largest thing in the corpus in every one of five time periods ('Didn't even get to see the app. Told me I had to pay'; 'it's listed here as a free download')",
  "hard paywall; nothing usable before payment", "blocked-conversion", "188 of 404 (46.53%, HIGH-PRIORITY) complain about the gate — paywall_block 162 (40.10%) mean 1.30 (134 are 1★) + no_trial 62 (15.35%); 172 (42.57%) hit the gate and did not pay, mean 1.31", "product-rule", "high-priority", "yes",
  ["8192594330","8916870417","8933371666","9375776581","12185804645","12691620078","13726769977","14284089819","14337005478"])
c(6, "Part 0 §1 The listing does disclose it — a discovery and framing failure, not an honesty failure", "insight",
  "The listing does disclose the paywall in body text ('fully paid and purchase is required to access any content') but the price label still reads Free — 162 reviewers hit an expectation gap the listing technically closes, which makes this a discovery and framing failure fixable at the top of the funnel, not in the product",
  "'Free' label + paid-only disclosure buried in description", "blocked-conversion", "162 paywall_block reviews despite disclosure", "do", "high-priority", "yes", [])
c(7, "Part 0 §2 Every reviewer who says they paid is unhappy. Not most — every one.; table (verbatim)", "must-never-break",
  "Every reviewer who says they paid is unhappy: zero five-star reviews among 80 self-identified paying customers is the most consequential single fact — whatever drives the 4.83 store average, it is not paying customers writing about the product they bought; the people who love the app and the people who bought it are almost entirely different people (none of the 22 sustained-outcome reviewers is in the paid group)",
  "hard paywall subscription", "churn", "80 paid (19.80%); 5★ 0 · 4★ 2 · 3★ 7 · 2★ 5 · 1★ 66 (82.50%); segment mean 1.31; praise_outcome 22 mean 4.95, 0 paid; 8 of 91 praise reviewers paid (8.79%); " + table("## 2. Every reviewer who says they paid"), "must-never-break", "high-priority", "yes", [])
c(8, "Part 0 §3 The number-one thing paying customers report is that payment did not grant access; failure-mode table (verbatim)", "must-never-break",
  "The number-one thing paying customers report is that payment did not grant access: paywall re-appears immediately after paying, 'no subscription found', Restore Purchase fails or redirects to the privacy policy, login error HTTP 400 after paying, cannot create account / crash at sign-in after paying, re-purchase demanded on a new device, charged and never gained access — a billing-integrity regression that did not exist early and grew",
  "entitlement / login failures after payment", "1★-burst", "33 (8.17%, HIGH-PRIORITY) mean 1.15 (31 of 33 1★); 32 of 33 also state they paid → 40.00% of 80 paid; 3.4% (2022) → 8.0% (2024) → 12.6% (2025) → 7.9% (2026); " + table("## 3. The number-one thing"), "must-never-break", "high-priority, rising", "yes",
  ["8923490272","11633047802","12320146758","12608420898","14151717931","13718655958","12265074054","13716961590","12383283769","9145314921","12842761978"])
c(9, "Part 0 §4 Support is a dead end, and refunds are the second-order damage", "must-have",
  "Support is a dead end — five reviewers say the listed support email does not exist or bounces, one of them a 5★ whose entire text is a plea for help — and refunds are the second-order damage: the angriest cluster in the corpus, a quarter of paying reviewers; the chain is mechanical and repeats across countries: hard paywall → entitlement failure → no support → refund attempt → 1★ 'scam'",
  "support email bounces; refunds denied or unroutable", "1★-burst", "support unreachable 15 (3.71%, VERY STRONG), 5 bounce; refunds 21 (5.20%, HIGH-PRIORITY) mean 1.05 (20 of 21 1★), 25.00% of 80 paid; 'scam' or equivalent 42 (10.40%)", "must-have", "high-priority", "yes",
  ["12162547099","12122344254","13194937352","13812177642","11839685862","12013949215","12192898307","11617090482","8560736398","12630584133","14335809799"])
c(10, "Part 0 §5 The in-app 5-star prompt is a compliance and data-integrity risk, and it is getting more visible", "dont",
  "The in-app 5-star prompt during onboarding is a compliance and data-integrity risk that is getting more visible: 'It said I had to give them 5 starts so here I am xx' (5★); reviewers draw the inference publicly — 'it makes you rate the app 5 stars which is probably why the ratings are good'; two independent reviewers in different countries named the exact 4.8 aggregate; concentrated in GB, PL, IT, CA, NL, MX and almost absent from the US; not proof of a guideline violation, but a material share perceive the request as coerced and the 4.83 vs 2.10 gap is visible to prospects",
  "asks for 5★ during onboarding before use", "1★-burst", "23 (5.69%, HIGH-PRIORITY); 0% (2022–23) → 9.0% (2024) → 5.5% (2025) → 11.1% (2026); 2 of 23 in US", "dont", "high-priority, rising", "yes",
  ["13814071134","13279632399","11586279561","13638785503","13096698945"])
c(11, "Part 0 §6 The onboarding is the best-loved and most-hated part of the product; the onboarding converts, the product does not retain", "contradiction",
  "The onboarding — a narrated, unskippable explainer plus questionnaire — is the best-loved and most-hated part of the product: 'making them unskippable is insane', 'perky American reading everything out, you can't swipe through it faster' vs 'I love the way it has music at the start and it speaks!'; nine of 77 five-star reviews praise the onboarding while implying they have not used the product — the onboarding converts, the product does not retain ('The intro before you purchase seems to have more thought put into it then the actual app itself')",
  "long narrated unskippable onboarding with questionnaire", "mixed", "against 21 (5.20%, HIGH-PRIORITY); for 5 cited; 9 of 77 5★ (11.69%) praise onboarding pre-use", "must-have", "high-priority", "yes",
  ["11396873201","10913036513","11500680241","11512469934","11511872399","11626061734","10923103793","11193945325","13096698945","10907144601","14337005478","12809171419","12663975904","10978019411","11652586176","14118054672","12990607438","11538597964","13366086371","13691510671","11513175352","11586279561"])
c(12, "Part 0 §6 The onboarding complaint peaked in 2024 and drops to 1 review in 2025 — the corpus's clearest evidence of a fix that landed; §8 Trend 4", "timeline",
  "The unskippable-onboarding complaint peaked in 2024 and dropped to one review in 2025 — the corpus's clearest evidence of a fix that landed",
  "onboarding made skippable (inferred)", "praise", "16 of 21 in 2024 (16.0% of 2024 reviews) → 1 in 2025", "do", "clear", "yes", [])
c(13, "Part 0 §7 When people do get in, the app is judged as a worse version of the calendar they already have", "insight",
  "When people do get in, the app is judged as a worse version of the calendar they already have — 'a glamourized version of the FREE Reminders app', 'fewer features than Apple's free Calendar app', 'There are no routines or trackers in the app. It's just a calendar/to do list. they charge you before you can see that' — the single most dangerous finding for the paid proposition: a paywall is defensible only if what is behind it is differentiated",
  "calendar/to-do behind a hard paywall", "churn", "13 (3.22%, VERY STRONG) mean 1.38", "product-rule", "very strong", "yes",
  ["8985632836","12236900050","13766147453","13937741808","12558262311","8252268729","9975565509","9314712194","12033069615","14005091328","11586279561","12982453369","14329102917"])
c(14, "Part 0 §8 Reliability is the growth complaint, and it is accelerating; defect table (verbatim)", "must-never-break",
  "Reliability is the growth complaint and it is accelerating: edits/tasks not saved and data lost; setting a task time crashes or rewrites the other time with no AM/PM (military-time only) — the cleanest bug report in the corpus, still open; recurring/repeat tasks broken or absent; calendar sync (Google/Apple/Family Sharing) does not work; app closes at the end of the intro",
  "multiple open defects", "1★-burst", "52 (12.87%, HIGH-PRIORITY); 11.4% (2022) → 3.8% (2023) → 9.0% (2024) → 16.5% (2025) → 17.5% (2026); " + table("## 8. Reliability is the growth complaint"), "must-never-break", "high-priority, rising", "yes",
  ["8980705761","14029446237","12111794304","14056969118","8913316700","12178849529","8608302704"])
c(15, "Part 0 §9 The clearest, cheapest unmet need is a widget", "feature",
  "The clearest, cheapest unmet need is a home-screen widget — asked by otherwise-happy paying users ('Love it but needs widgets… I forget all the time to use this app cause I don't have a widget'); the highest-mean complaint theme (retained users, not churned prospects); every request is dated 2024 or later; it names the exact retention mechanism the app lacks — a passive surface that reminds people the app exists",
  "no widget", "complaint", "9 (2.23%, MEANINGFUL) mean 2.44; 1 in 2024, 7 in 2025, 1 in 2026", "build-free", "meaningful", "yes",
  ["13550565309","12667337121","11973399697","14357143421","12178849529","12722697888","12215752061","12341288794","12892920714"])
c(16, "Part 0 §10 What people genuinely love: being told what their day looks like", "insight",
  "What people genuinely love is being told what their day looks like — 'the day is planned for me, so I stop losing track of it' — 'I suffer with autism… I lose track of time… but that girl made sure I DID have a plan'; 'I have adhd and this app is literally helping me'; 'I used to be rushed… now with everything organised it feels like a breeze'",
  "pre-planned day schedule", "praise", "praise 91 (22.52%); praise_outcome 22 (5.45%, HIGH-PRIORITY) mean 4.95", "must-have", "high-priority", "yes",
  ["12286335035","13203951770","13936002411","11585180763","10283941160","14135703563","13949586588","11755587287","9333260206","10972036961","11142925263","11418401764","11429621110","11540185663","11561379247","12566742489","12980084882","14118054672","11513175352","13108916516","12599834461","13563108066"])
c(17, "Part 0 §10 17 reviewers praise the aesthetic explicitly — beauty is real and it is not sufficient", "insight",
  "Beauty is real and it is not sufficient: 4 of the 17 reviewers who praise the aesthetic rated 1★ and 7 rated 2★ — 'Super cute app, with a beautiful introduction and you can really see the thought put into it. But then it costs 5$/permonth'",
  "aesthetic-led product", "mixed", "17 (4.21%) praise aesthetic; 4 are 1★, 7 are 2★", "insight", "very strong", "yes",
  ["11453056321"])

with open("Tools/prd_ledger/12/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
