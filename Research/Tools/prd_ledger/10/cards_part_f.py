import json, re
R = 10
rep = open("App Store Reports/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker (REPORT).md").read().split("\n")
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

# ---- PART 8 ----
c(132, "§8.1 Method — three time resolutions; Baseline volume and sentiment table (verbatim)", "timeline",
  "Time-trend method (half-year buckets for families, calendar years for themes, month/day for incidents) and baseline year table; the one-star rate has more than tripled while volume stayed high — the single most important background fact",
  "n/a", "1★-burst", table("Baseline volume and sentiment") + " ; 1★ 1.11% → 4.00%; 2021 (n=531) indicative only; 2026 partial through 7 Sep (n=11,594); 2021H1 (n=11) never used", "none", "verbatim", "app-specific", [])
c(133, "§8.1 Family rates by half-year table (verbatim)", "timeline",
  "Family rates by half-year 2021H2–2026H2: billing, monetization, reliability, data-integrity, product-change, values, gamification, positive-core",
  "n/a", "mixed", table("Family rates by half-year"), "none", "verbatim", "app-specific", [])
c(134, "§8.2 (a) 4 May 2022 — crash on launch", "timeline",
  "4 May 2022 crash-on-launch: a clean, closed incident mostly from first-time users who had just installed after seeing an ad — resolved within days and never recurred at that magnitude; proof the corpus detects such events at day resolution",
  "launch crash after an update during an ad campaign", "1★-burst", "128 reviews on 4 May vs ~90/day baseline; mean 3.72 vs 4.87 monthly; 34 one-star; 42 crash-tagged in one day; 3–6 May: 400 reviews, 46 crash-tagged, 34 one-star", "must-never-break", "day-level", "yes",
  ["8636217694","8636379393","8636383341","8637099622","8637858391"],
  side="a launch crash during an acquisition campaign hits first-time users who then never return")
c(135, "§8.2 (b) February 2026 — the 'Wonderland' event crash; The severity multiplier here is the streak mechanic", "timeline",
  "February 2026 'Wonderland' event crash: the Queen of Hearts event's 'grow potion' enlarged the pet and the app then crashed on load ('since my birb drank the giant potion the app crashes constantly. My birb is a giant and that seems to be too much to handle for my phone'); consequences: lost streaks of 47–600+ days, inability to run a backup because the app crashed before it could, paid subscriptions unusable for weeks — the severity multiplier is the streak mechanic: in 2022 a crash cost a session, in 2026 a crash costs a 600-day streak",
  "monthly event shipped a crash; streaks amplify the cost", "1★-burst", "120 crash-tagged reviews in Feb 2026 vs 15 in Jan and 1–15 monthly norm 2023–24; 20 on 2 Feb, 11 on 3 Feb, 10 on 4 Feb, 9 on 6 Feb; monthly 1★ 4.85%; 67 reviews mention Wonderland at mean 3.40; lost streaks 47/70/142/300/400+/600+ days", "must-never-break", "month/day-level", "yes",
  ["13707568156","13711835469","13718339682","13743955362","13743566701","13725395996","13767997910","13711833057","13704583556","13707818559","13750797974","13737744762"])
c(136, "§8.3 Trend 2 — Reliability is the fastest-worsening dimension, and events are the named cause", "timeline",
  "Reliability is the fastest-worsening dimension and monthly events are the named cause: the 2024 trough is real (the app got measurably more stable) and the 2026 spike is a regression; reviewers blame the monthly event cadence for shipping unstable code — 'Instead of doing things to improve the stability of the app, the finch team just keeps launching events that feels like they haven't tested anything'",
  "monthly content events without a crash gate", "1★-burst", "reliability 1.89% (2022H1) → 4.80% (2026H1); crash 0.80% (2022) → 0.53% → 0.36% (2024) → 0.52% → 2.03% (2026); D-event-bug 0.07/0.05/0.08/0.06 → 0.32% (2026); June 2026: 14 event-bug + 42 data-loss reviews; D-streak-bug 0.01/0.01/0.17/0.39 → 0.74%", "must-never-break", "trend", "yes",
  ["14154438154","14224222208","14130446306","13977961683","14225501459","14083723197","13513453625","14224706579"])
c(137, "§8.4 Trend 3 — Data integrity broke down in H2 2025 and has not recovered; the problem statement changing to 'it told me my pet data got corrupted'", "timeline",
  "Data integrity broke down in H2 2025 and has not recovered; the problem statement changed from 'I deleted the app and lost everything' (user-initiated, 2022–23) to 'it told me my pet data got corrupted' (app-initiated, unprompted, from 2025) — a more serious failure because the user did nothing and the standard recovery path (a manual backup they may never have made) is unavailable",
  "app-initiated data corruption with no automatic backup", "1★-burst", "data-integrity 0.42% → … → 1.73% (2025H2) → 1.76% (2026H1) → 1.49% (2026H2); D-data-loss 0.46% (2022) → 0.46% → 0.56% → 1.08% (2025) → 1.47% (2026); monthly 22 (Jul 2025), 20 (Nov), 21 (Dec), 21 (Jan 2026), 28 (Feb), 42 (Jun 2026) vs 1–13 norm", "must-never-break", "trend", "yes",
  ["12595515502","12881347765","12925432031","13033899041","13683756253","13732070192","14145164297","14242421063","14373848758","14381587355"])
c(138, "§8.5 Trend 4 — A five-year pattern of removing what people bought the app for table (verbatim)", "timeline",
  "Sixteen dated product changes 2022–2026 with themes, counts, means and review IDs: bird redesign, house leaked then withdrawn, paywall creep, beta sync lockout, Feb 2024 UI redesign, Tree Town non-user friends removed, streaks introduced, Journeys → Self-Care Areas, Guardian/AI ads controversy, hiring-ethics allegations, auto mood check-ins removed, exact-time goal scheduling removed, multi-add of goals removed, friends house view → tree only, Special Quests/milestones removed, colour palettes restricted",
  "repeated removals", "complaint", table("## 8.5 Trend 4") + " ; generic feature-removal 0.02% (2022) → 0.03% → 0.12% → 0.11% → 0.32% (2026), 16×", "product-rule", "verbatim", "app-specific", [])
c(139, "§8.5 Paywall creep on previously-free items row (M-paywall)", "product-rule",
  "Paywall creep on previously-free items from November 2022 onward is the largest single monetization theme, though its rate is falling",
  "moved free items behind Plus", "complaint", "M-paywall 715 mean 4.38; 1.20% (2022) → 0.85% (2026); 4★ band 141 (3.03%)", "product-rule", "meaningful", "yes",
  ["9337272695","9364974191","9386542212","9479031601","9771124109","9138911582"])
c(140, "§8.5 'Beta' account sync locks users out (Mar 2023)", "timeline",
  "A 'beta' account-sync rollout in March 2023 locked users out of their accounts",
  "beta sync shipped to all", "1★-burst", "~12 D-login-account reviews in the month", "must-never-break", "dated", "yes",
  ["9686931072","9699066698","9699388738","9712101197","9714150379","9723946025"])
c(141, "§8.5 Major UI redesign Feb 2024 (U-ui-change)", "timeline",
  "The February 2024 major UI redesign drew a backlash cluster",
  "redesign", "complaint", "24 U-ui-change reviews in 2024, mean 3.57; U-ui-change 94 total mean 3.53", "dont", "dated", "yes",
  ["10906118540","10909346801","10917010011","10983032325","11031925790"])
c(142, "§8.5 Streaks introduced ~mid-2024 row", "timeline",
  "Streaks were introduced around mid-2024 and immediately generated pressure complaints",
  "streaks added", "complaint", "U-streak-pressure 24 in 2024, mean 3.96", "dont", "dated", "yes",
  ["11350735942","11396970425","11401527483","11548301986","11591661994","11688717901"])
c(143, "§8.5 The Journeys removal is the sharpest single case", "anti-pattern",
  "The Journeys removal (Apr–May 2025) is the sharpest single case: Journeys rewarded cumulative, non-consecutive progress; the Self-Care Areas replacement rewards consecutive streaks; the app's audience is people whose progress is by definition not consecutive — 'They removed the component that gave users a sense of levelling… and replaced it with daily streaks'; 'as someone with severe chronic illness, the Journeys feature was incredible… I've regretfully canceled my subscription'; a clinician: 'only 1 of 2 apps I actually recommend to my clients — all adults with ADHD'",
  "replaced cumulative-progress reward with consecutive-streak reward", "churn", "U-journeys-removed 49 total, 36 in 2025, mean 2.76 (lowest product-change theme), 21 of 49 one-star; Journeys 1,006 vocabulary mentions", "product-rule", "dated, sharp", "yes",
  ["12557701970","12674347241","12682396517","12778041860","12655037808","14299934656","12596071096","12559327482","12547227541","13365769674","13420079481"])
c(144, "§8.5 The mood check-in removal is the second sharpest", "anti-pattern",
  "The automatic mood check-in removal (Oct–Nov 2025) is the second sharpest, and its argument is about accessibility rather than reward: an automatic prompt is a memory aid, and moving it behind a button destroys the dataset for exactly the users who need it — 'my mood data is now almost empty for the last three months even though I do the emotion exercise multiple times a day'",
  "auto mood prompt moved behind a button", "complaint", "U-moodcheckin-removed 64 total, mean 3.77, 49 in 2025H2–2026; mood tracking 953 vocabulary mentions", "product-rule", "dated", "yes",
  ["13860027170","13305396533","13425412408","13414089882","13855090245","14256888213","14352654672","14129375665","14114531927"])
c(145, "§8.5 Exact-time goal scheduling removed (Nov 2025 – Jan 2026); Multi-add of goals as a list removed", "timeline",
  "Exact-time goal scheduling was removed (Nov 2025–Jan 2026) and multi-add of goals as a list was removed (Dec 2025–Feb 2026)",
  "removed timed goals and list multi-add", "complaint", "U-timedgoals-removed 9 total mean 3.11; multi-add ~10 reviews", "product-rule", "dated, small", "yes",
  ["13372364201","13414781377","13523723252","13591367850","13501873014","13504992115","13595168865"])
c(146, "§8.5 smaller dated changes: bird redesign Mar 2022; house leaked then withdrawn Jul–Aug 2022; Tree Town non-user friends removed May 2024; friends house view → tree only Jun 2026; Special Quests / milestones removed Jun–Jul 2026; Colour palettes restricted Aug–Sep 2026", "timeline",
  "Smaller dated changes each drew a cluster: bird redesign (Mar 2022), a house/nest feature leaked then withdrawn (Jul–Aug 2022), Tree Town non-user 'friends' removed (May 2024), friends' house view reduced to tree only (Jun 2026), Special Quests / milestones removed (Jun–Jul 2026), colour palettes restricted (Aug–Sep 2026)",
  "repeated removals and restrictions", "complaint", "~15, ~6, ~5, ~8, 37 (2026 U-feature-removed-generic), ~10", "product-rule", "dated, small", "app-specific",
  ["8431474054","8927346914","11249547975","14141621712","14213362996","14374387869"])
c(147, "§8.5 Guardian/AI ads controversy Jan & May 2025; Hiring-ethics allegations May 2025", "timeline",
  "A Guardian/AI-ads controversy (Jan & May 2025) and hiring-ethics allegations about unpaid design work (May 2025) each produced dated clusters; hiring ethics is the lowest-mean content theme",
  "AI-generated ads; alleged unpaid design work in hiring", "complaint", "C-ai 62 in 2025, mean 4.35 (156 total); C-hiring-ethics 8 in 2025, mean 1.67", "dont", "dated", "yes",
  ["12213043459","12219142669","12728967109","12686511039","13253481318","12684393117","12705023244","12709962941","12716829097"])
c(148, "§8.6 Trend 5 — 2026: the product's values become a subject of the reviews; June 2026 DC/Supergirl month; Why this matters more than 127 reviews should", "timeline",
  "2026: the product's values become a subject of the reviews — public-domain themes (Wizard of Oz, Alice in Wonderland) were tolerated with unease; the June 2026 DC/Supergirl month was not; objections repeat almost word for word: 'you are charging me and advertising to me' (a 575-day-streak multi-year subscriber), 'this month should have been Pride', 'criticism was suppressed', and the rollout was broken as well as unwanted; it continued with a July 1950s drive-in theme drawing a racial/heteronormative-representation critique and a September film tie-in; the people most offended are the people paying",
  "sponsored IP monthly events from June 2026", "churn", "content/values family 0.69% (2022H1) → 1.42% (2025H1) → 1.89% (2026H1) → 2.93% (2026H2); C-brand-collab 2/5/3/10/107 by year, mean 3.09; 80 name Supergirl, 68 in June 2026, mean 2.99; June 2026: 14 event-bug, 42 data-loss, 104 one-star reviews; 8.0× over-represented among payers", "dont", "trend", "yes",
  ["14136600404","14117246332","14134408387","14154691963","14131417726","14259430571","14261659918","14497986029","14507114042"])
c(149, "§8.7 Trend 6 — Monetisation complaints are flat-to-down; billing complaints are not", "timeline",
  "Monetisation complaints are flat-to-down while billing complaints rise 4–7×: users have largely stopped arguing about the price and started arguing about the transaction — a solvable problem, and a different problem from the one a pricing change would address",
  "price stable; billing mechanics failing", "1★-burst", "M-paywall 1.20% (2022) → 0.85% (2026) falling; M-price-high 0.57% → 1.22% (2024 peak) → 0.72% falling; M-should-be-free flat 0.25–0.41%; M-trial-no-reminder 0.07% → 0.38% (2025) → 0.28% up 4–5×; M-trial-charged 0.06% → 0.38% → 0.24% up 4–6×; M-refund-denied 0.04% → 0.21% → 0.19% up ~5×; M-not-free 0.04% → 0.28% up 7×", "must-never-break", "trend", "yes", [])
c(150, "§8.8 Trend 7 — The benefit signal is thinning; Read together with §8.5, this is one story", "timeline",
  "The benefit signal is thinning: the therapeutic tool-set is mentioned less and less as it moves further behind menus and paywalls, while the task-tracking and collection layers stay prominent — precisely what hundreds of long-form reviewers assert has happened",
  "tools buried; collection game foregrounded", "complaint", "P-mental-health 15.44% (2021) → 14.02 → 13.55 → 11.78 → 10.67 → 9.30% (2026); P-tools 15.63% → 7.98 → 5.24 → 5.57 → 4.08 → 2.65%; P-companion 2.64% → 1.32%; positive-core 30.40% (2022H1) → 23.08% (2026H2); P-motivation flat 15.2% → 13.0%; P-social 3.03% → 3.09%", "product-rule", "trend", "yes",
  ["13828330334","14268143502","14425330451","13456598701","14420113173","13688122090","12551489443","10983032325"])
c(151, "§8.9 Trends explicitly NOT claimed", "data-caveat",
  "Trends explicitly NOT claimed: no trend in pronoun objections (flat 0.06–0.10%), no trend in safety-content complaints (the 2022 'schedule time for suicide' cluster is a closed incident), no trend in community moderation (declining slightly), no seasonality claim (volume tracks marketing and events), no claim about 2026H2 beyond the partial period",
  "n/a", "none", "C-pronouns-objection 0.10/0.06/0.07/0.08/0.07%; C-safety 0.51% → 0.41%; C-community-mod 0.35% → 0.22%; 2026H2 n=2,080 (Jul–7 Sep)", "none", "method", "yes", [])

with open("Tools/prd_ledger/10/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
