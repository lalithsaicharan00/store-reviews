import json, re
R = 18
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 9 ----
c(138, "§9.1 I1. Stop metering completions", "product-rule",
  "Stop metering completions — cap habits if you must, never cap check-offs; a habit tracker that refuses to record a completion on day 3–6 is demonstrating that it does not work to a user currently deciding whether it works",
  "meters completions on the free tier", "1★-burst", "139 reviews (6.79%, mean 2.32★); 19.6% of all 1★; most explicit lost sale ('90% ready to buy')", "product-rule", "recommendation (immediate)", "yes",
  ["14517754076","14393820099"])
c(139, "§9.1 I2. Show one price per plan per storefront", "product-rule",
  "Show one price per plan per storefront; never surface a discount to someone who has just paid — if a cheaper offer exists, apply it; make the refund path reachable in-app",
  "4–5 concurrent prices per plan; discount shown post-purchase; refund path dead-ends", "1★-burst", "144 billing disputes; fraud accusations in six languages", "must-never-break", "recommendation (immediate)", "yes",
  ["14143250366","11881028381","13994502099"])
c(140, "§9.1 I3. Fix entitlement propagation, and instrument it", "must-never-break",
  "Fix entitlement propagation and instrument it — a lifetime purchase that stops working is not a bug, it is the end of the customer relationship; add a purchase-state self-check on launch and an in-app restore that actually restores without dumping the user into onboarding",
  "entitlements fail; restore loops to onboarding", "churn", "25 (1.22%, mean 2.44★); every JP instance 1★", "must-never-break", "recommendation (immediate)", "yes",
  ["14238803827","13953352894"])
c(141, "§9.1 I4. Never re-run onboarding on an existing or paying account, and add a skip button", "must-have",
  "Never re-run onboarding on an existing or paying account, and add a skip button — a Pro subscriber forced back through the questionnaire and a lifetime buyer whose data was replaced by two survey-chosen routines are the same defect",
  "onboarding re-runs; no skip", "churn", "onboarding theme mean 2.03★ (lowest)", "must-have", "recommendation (immediate)", "yes",
  ["14437815273","14238803827"])
c(142, "§9.1 I5. Fix the Japanese feedback form and the Taiwanese price/refund flow", "do",
  "Fix the Japanese feedback form (Japan cannot report bugs) and the Taiwanese price/refund flow (TW at 2.60★ almost entirely from billing) — both are days of work in top-tier spend markets",
  "broken JP form; TW promo-price mismatch", "1★-burst", "JP 3 IDs; TW 12/35 billing", "do", "recommendation (immediate)", "app-specific",
  ["13757721182","13576075338","13712167027"])
c(143, "§9.1 I6. Label paid features before use, and never destroy user work at the paywall", "product-rule",
  "Label paid features before use and never destroy user work at the paywall — two users each spent an hour building routines, paid to save them, and lost the work anyway; two were paywalled on features documented as free",
  "paywall after work is done; work lost", "1★-burst", "4 named IDs", "product-rule", "recommendation (immediate)", "yes",
  ["12433476315","12536725596","12350930181","13894400612"])
c(144, "§9.2 M1. Move to an 'unlimited free core, paid depth' model", "product-rule",
  "Move to an 'unlimited free core, paid depth' model — monetise new capability, not existing capability; the corpus already names what people will pay for: export, statistics with trend, routine modes, timer with time tracking, Apple Watch parity, themes, web/Mac — every one additive",
  "confiscation model", "mixed", "five years of reviews in three languages; §5.5 backlog", "product-rule", "recommendation", "yes",
  ["10729003648","13587898854","13064048672"])
c(145, "§9.2 M2. Ship a genuine, permanent free tier and say so on the listing", "product-rule",
  "Ship a genuine, permanent free tier and say so on the listing — the reviews that convert best are from people who used the app free for a week or a month first; the reviews that generate refund demands are from people charged before they could evaluate; the current arrangement optimises for the second",
  "trial-first, evaluate-later", "blocked-conversion", "3 conversion IDs vs 11 charged-before-evaluation IDs", "product-rule", "recommendation", "yes",
  ["8363704388","8961449067","10995640730"])
c(146, "§9.2 M3. Add a student/child tier or a family option", "monetization",
  "Add a student/child tier or a family option — students, teens and children appear repeatedly and sympathetically, including a teacher using it with a whole class until the to-do list went paid; the store rates the app 'all ages' while the onboarding age bracket starts at '18 and under'",
  "no student/family tier", "blocked-conversion", "8 named IDs (§5.3 #6)", "research", "recommendation", "yes",
  ["10598930656","12857404582"])
c(147, "§9.2 M4. Stop marketing to people who have already paid", "product-rule",
  "Stop marketing to people who have already paid — remove the promo bar, the Dynamic Island countdown and the annual-upsell nag for anyone with an active plan; 'a pro member should be a pro member regardless of whether they are paying monthly or yearly'",
  "upsells active subscribers", "complaint", "4 named IDs (§5.4 #5); promo-nag 40 (1.95%, 2.40★)", "product-rule", "recommendation", "yes",
  ["13492813619","12862293051"])
c(148, "§9.2 M5. Keep the lifetime tier and protect it absolutely", "monetization",
  "Keep the lifetime tier and protect it absolutely — 34 lifetime buyers at mean 4.12★ are the most committed segment; two of the corpus's most damaging reviews are lifetime buyers who lost their entitlement",
  "lifetime tier present but entitlement fragile", "mixed", "34 lifetime (1.66%), mean 4.12★", "build-paid", "recommendation", "yes",
  ["14238803827","14031409160"])
c(149, "§9.3 P1. Restore an optional merged routine + to-do view", "feature",
  "Restore an optional merged routine + to-do view as a toggle, not a replacement — a minority genuinely prefers the split", "removed; requested back", "churn", "32 reviews mean 4.25★; ≥4 subscribers named it as purchase trigger", "must-have", "recommendation", "yes",
  ["11700463203","12118393284","12287914815"])
c(150, "§9.3 P2. Make reordering direct, and allow editing any date", "feature",
  "Make reordering direct (long-press to drag) and allow editing any date — remove the 'you cannot edit future dates' restriction introduced ~Jun 2023; the most-repeated single request in the corpus", "restricted reorder and future-date edit since ~Jun 2023", "complaint", "130 (6.35%), five years, mean 4.07★", "must-have", "recommendation", "yes",
  ["8790036022","13853005780"])
c(151, "§9.3 P3. Build statistics that answer 'am I getting better?'", "feature",
  "Build statistics that answer 'am I getting better?' — per-habit achievement %, trend over weeks/months, annual view, a calendar of green/yellow/red; two reviews specify the requirement precisely", "statistics behind Pro, no trend/charts", "complaint", "57 reviews", "paid", "recommendation", "yes",
  ["10444375042","10851299280"])
c(152, "§9.3 P4. Ship export", "feature",
  "Ship export — asked continuously since the app's fifth month and named as a purchase condition twice; export is also the honest answer to five years of data-loss reports: it lets users protect themselves", "no export", "blocked-conversion", "18 reviews, mean 4.44★", "free", "recommendation", "yes",
  ["6164039764","13587898854","14102776480"])
c(153, "§9.3 P5. Aggregate the diary", "feature",
  "Aggregate the diary — people write daily reflections for years and cannot read them back except one date at a time", "diary entries not browsable together", "complaint", "22 reviews, mean 4.68★ — highest-rated request theme", "undecided", "recommendation", "yes",
  ["9774376446","12024794472"])
c(154, "§9.3 P6. Make the motivation system configurable in both directions", "product-rule",
  "Per-user toggles for streak display, the shield, the traffic light itself and cheer-message frequency; default the shield to off", "streak/shield/light/cheers not configurable", "mixed", "§0.9: 17 IDs", "product-rule", "recommendation", "yes",
  ["13842532454","13260473006"])
c(155, "§9.3 P7. Finish routine modes", "feature",
  "Finish routine modes — right feature, wrong execution: switching a mode rewrites past days' lights, modes apply forward-only rather than per-date, edits inside a mode don't persist, and it is buried in Settings", "modes shipped buggy", "complaint", "5 named IDs", "must-never-break", "recommendation", "yes",
  ["13685716991","13812236928","13795524849","14108692347","13556531783"])
c(156, "§9.3 P8. Apple Watch and widget parity with the timer", "feature",
  "Apple Watch and widget parity with the timer — Japan and the US both rate the timer as a high-priority strength and both ask for it on the watch and in the widget", "timer absent from watch and widget", "complaint", "JP 6.28%, US 8.33% timer; 4 named IDs", "paid", "recommendation", "yes",
  ["13431240197","13435011015","12736883056","14127953337"])
c(157, "§9.3 P9. Let users hide what they don't use", "must-have",
  "Let users hide what they don't use — complexity is high-priority in all three eligible storefronts (KR 6.75%, JP 10.76%, US 8.33%) and rising as features accumulate; an ADHD user asks to hide social, recommendations, to-do, diary and streaks; another asks them explicitly not to add more", "no way to hide surfaces", "complaint", "complexity 149 (7.28%); KR 6.75 / JP 10.76 / US 8.33%", "must-have", "recommendation", "yes",
  ["13842532454","11064706172"])
c(158, "§9.4 Q1. The app is named MyRoutine and the onboarding builds *its* routine", "do",
  "Let people write their own habit first and answer questions later, or never — 'MY routine not your routine'", "onboarding builds a suggested routine before the user's own", "blocked-conversion", "n=1 sharpest + onboarding 34 (2.03★)", "must-have", "recommendation (positioning)", "yes", ["12445646540"])
c(159, "§9.4 Q2. Serve irregular schedules in onboarding, not just in Pro", "audience",
  "Serve irregular schedules in onboarding, not just in Pro — shift workers, night workers, parents and students are a repeating, articulate, paying segment; the questions currently assume a weekday 9-to-5", "irregular schedules only served by Pro modes", "blocked-conversion", "6 named IDs", "do", "recommendation (positioning)", "yes",
  ["12245337065","12784378291","12132150109","12580123414","13795524849","12478377114"])
c(160, "§9.4 Q3. The ADHD positioning is real — earn it", "do",
  "The ADHD positioning is real (highest-rated theme cluster, now in the store title) — earn it: configurable streaks, hideable UI, no punitive paywall on completion", "positions on ADHD ahead of the product", "mixed", "ADHD 36 (1.76%, 4.53★)", "do", "recommendation (positioning)", "yes",
  ["13842532454","11067291310"])
c(161, "§9.5 Research questions this corpus cannot answer; part 9 #1; part 9 #2; part 9 #3; part 9 #4; part 9 #5; part 9 #6", "data-caveat",
  "Research questions: (1) is the completions quota (14/week) real, current and global — verify in code and store metadata; (2) why do some US/CA users describe the app as 'completely free' in the same months KR/JP users are blocked — regional config, cohort assignment, or quota not yet reached; (3) the actual conversion effect of each paywall tightening — the corpus shows the sentiment cost precisely and the revenue benefit not at all; (4) what proportion of the 4.8★ / 25,000 tap-through ratings comes from users who hit the completion wall — the 0.98-star gap is the most important unexplained number; (5) is the GB/AU 5★ cluster of June 2025 organic; (6) do routine modes actually retain shift workers or only win them back briefly",
  "n/a", "none", "6 questions", "research", "research questions", "yes",
  ["14393820099","11432555244","12230682122","13866825904","14454264522","13795524849"])

with open("Tools/prd_ledger/18/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
