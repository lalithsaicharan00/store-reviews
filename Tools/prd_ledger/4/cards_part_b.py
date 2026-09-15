import json, re
R = 4
rep = open("App Store Reports/4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- 1.1 ----
c(11, "§1.1 bullet 1", "monetization", "Free download with a subscription-gated 'VIP' tier at $39.99/year or $9.99/month",
  "subscription only", "mixed", "listing text 2026-09-09", "research", "external source", "yes", [])
c(12, "§1.1 bullet 2", "monetization", "No advertising business: only 55 reviews (0.27%) complain about ads and most mean subscription pop-ups; 67 (0.33%, mean 4.45, 74.6% 5★) explicitly praise the absence of ads",
  "no third-party ads", "praise", "55 (0.27%) complaints; 67 (0.33%) praise at 4.45", "product-rule", "weak", "yes", ["10558237535","10144485344","11808709309"])
c(13, "§1.1 bullet 3", "tactic", "A 7-day trial exists on at least one plan, and a discount wheel / 'limited time offer' mechanic runs throughout 2022–2026",
  "trial on one plan; spin-the-wheel discounts", "mixed", "present 2022–2026", "dont", "stated", "yes", [],
  cond="the wheel is named in 26 reviews and reported rigged or broken by several (§1.6)")
c(14, "§1.1 price table + bold", "monetization", "The price spread is the finding: users in the same market and period report $19.99, $29.99, $30, $39.99, $44 and $59.99; combined with the discount wheel nobody can tell another user what the app costs — exactly the condition under which 'scam' language spreads; 'I selected 1 month at 69.90 and 89.90 was debited'",
  "inconsistent, undisclosed pricing; discount wheel", "1★-burst", table(153, 166), "must-never-break", "high-priority", "yes",
  ["10623112709","10568183655","12305346345","11444190900","12867585648","13462407141","10674600761","11465293117","12192965094","10213537631","10449883273","9915339274","13130109012","14400482233","12824631044","14492111472","10874510575","10780491946","10635080982","12419775649","11843514371","10336428805","11534848272","12864390376","11995827805","13045944281","11330094474","13613637863","14511513737","12916905050","10531986957","11005436107","11235083153","10405795762","10930935136","10483361084"],
  side="a single, stable, disclosed price is a trust feature")

# ---- 1.2 ----
c(15, "§1.2 table row 1", "feature", "More than ~4–7 daily tasks/habits is paywalled from mid-2025",
  "free task cap 4–7/day", "1★-burst", "6 IDs; see R04-008", "build-free", "meaningful (timing)", "yes",
  ["13492344866","13684033797","14279264893","13028782607","13595977240","14496354181"])
c(16, "§1.2 table row 2", "feature", "Preset routines / templates / 'programs' are paywalled",
  "templates paid", "complaint", "4 IDs", "build-paid", "weak", "yes", ["13905359641","12941236061","10338746865","12946905191"])
c(17, "§1.2 table row 3-4", "feature", "Workout, meditation, course and reflection/journal content is paywalled — the content library is the paid layer",
  "content library paid", "purchase-driver", "3 + 1 IDs; content is a stated purchase reason (§1.3)", "build-paid", "weak", "yes", ["10338746865","12363238702","12009622937"],
  cond="a routine app that bundles a content library has something to sell that is not the core loop")
c(18, "§1.2 table row 5", "feature", "Themes, backgrounds and icons are paywalled",
  "cosmetics paid", "complaint", "1 ID", "build-paid", "single review", "yes", ["11996279048"])
c(19, "§1.2 table row 6", "feature", "Renaming and reordering tasks is paywalled — reported by two PAYING users as still restricted",
  "rename/reorder gated", "complaint", "2 paying-user IDs", "build-free", "weak, severe", "yes", ["10080398097","9690694863"],
  side="gating basic editing of the user's own tasks is felt even by subscribers")
c(20, "§1.2 'usable free' line", "feature", "Confirmed usable free: creating your own routine within the cap, check-offs, streaks, mood check-ins, water tracking, alarms, sleep sounds, some quizzes — 'I did all of this without even buying premium'; 'o gratuito tem tudo'",
  "free core loop plus mood/water/alarms/sleep sounds", "praise", "5 IDs", "build-free", "stated", "yes",
  ["11808709309","10932819511","11104177160","11602799352","11881173938"])
c(21, "§1.2 bold", "insight", "413 reviews (2.02%) 'praise' the free tier at a mean of only 3.43 because the same vocabulary is used by people saying 'it's free' and people saying 'it says free but isn't' — the clearest evidence that the free/paid boundary is not legible to users",
  "illegible free/paid boundary", "mixed", "413 (2.02%), mean 3.43", "must-have", "meaningful", "yes", [],
  side="legibility of what is free is itself a product requirement")

# ---- 1.3 ----
c(22, "§1.3 opening", "insight", "319 reviews (1.56%) contain first-person purchase evidence in six languages; full list in §9.8",
  "n/a", "purchase-driver", "319 (1.56%)", "none", "meaningful", "yes", [])
c(23, "§1.3 trigger row 1", "insight", "Purchase trigger: wanted the full routine after the free cap blocked them",
  "cap → upgrade", "purchase-driver", "3 IDs", "undecided", "weak", "yes", ["13249657539","12938776811","10080398097"],
  cond="the cap does convert some — but see R04-008 for what it costs")
c(24, "§1.3 trigger row 2", "tactic", "Purchase trigger: a discount / sale converted them — 'I bought the yearly subscription when it was on sale'",
  "sales and discount offers", "purchase-driver", "3 IDs", "research", "weak", "yes", ["10833842651","11189969039","10456692189"])
c(25, "§1.3 trigger row 3", "insight", "Purchase trigger: gratitude — the free tier already worked: 'I subscribed to VIP only out of gratitude, because the free version has everything'",
  "generous free tier", "purchase-driver", "2 IDs", "product-rule", "weak", "yes", ["11104177160","11808709309"],
  side="generosity converts through goodwill — the same mechanism as report 2's 'support the developer'")
c(26, "§1.3 trigger row 4", "audience", "Purchase trigger: the ADHD outcome was worth paying for — 'I have severe ADHD and this is a game changer… it triggers my dopamine like crazy'",
  "ADHD-friendly routine loop", "purchase-driver", "2 IDs", "do", "weak", "yes", ["10874402938","11572989949"])
c(27, "§1.3 trigger row 5", "must-never-break", "Accidental purchases — a trial they did not intend: 'Comprei sem querer', 'Accidentally subscribed for a year', 'Accidental purchase too easy'",
  "purchase too easy to trigger", "1★-burst", "6 IDs, mostly 1★", "must-never-break", "weak", "yes",
  ["11452497897","9915339274","11095996568","10972171193","10373609190","9891617898"])
c(28, "§1.3 trigger row 6", "feature", "Purchase trigger: the content library (sleep scoring, soundscapes, meditation)",
  "content library paid", "purchase-driver", "1 ID", "build-paid", "single review", "yes", ["10490388620"])

# ---- 1.4 ----
c(29, "§1.4 table (verbatim)", "insight", "Confirmed payers (n=319) vs corpus: mean 1.87 vs 3.93; 1★ 60.8% vs 16.80%; refund demanded 23.5%; trial-deception 19.7%; scam 13.5%; cancellation difficulty 9.7%; unexpected charge 8.5%; bugs 6.6%; strong endorsement 2.8%",
  "n/a", "1★-burst", table(202, 214), "none", "high-priority", "yes", [])
c(30, "§1.4 disclosure", "data-caveat", "The payer cohort is severely selection-biased: people state 'I paid' mainly when angry about having paid; read it as 'when a subscriber writes about the subscription it is almost always about billing', not 'subscribers are unhappy'",
  "n/a", "none", "segment rate, not population rate", "none", "method", "yes", [],
  side="applies to every payer table in this ledger: the direction is robust, the level is not")
c(31, "§1.4 positive payers", "insight", "The 45 positive payers (4–5★, mean 4.49, zero 1–2★) value the OUTCOME, not the feature list — 'I DID ALL OF MY TASKS USING ME+'; 'I don't mind paying the small amount'",
  "n/a", "purchase-driver", "45 payers, mean 4.49", "do", "weak", "yes",
  ["10874402938","11572989949","10833842651","11808709309","10490388620","11110151999","9715195066","10327263723","11104177160","11996279048"])
c(32, "§1.4 'what paying users complain about'", "must-have", "Paying users who change phones cannot restore — account portability is the complaint payers make that free users do not; small counts but every one is a paying customer at risk",
  "no reliable restore / account portability", "complaint", "6 IDs, all payers", "must-have", "weak, all payers", "yes",
  ["10951060325","11052130385","10343032731","10850211623","13249657539","10786069222"])

# ---- 1.5 ----
c(33, "§1.5", "must-have", "Cancellation and support are the compounding failure: 169 (0.83%) cannot cancel (mean 1.22); 48 (0.23%, mean 1.29) say support never replied — 'there is literally NO WAY to cancel'; 'emailed you three times over a month'; 'I am engaging a lawyer'",
  "cancel-by-email only; unanswered support", "1★-burst", "169 (0.83%) mean 1.22; 48 (0.23%) mean 1.29, 89.6% 1–2★", "must-have", "emerging", "yes",
  ["11171231611","8951936828","10121356710","10859158478","10455594542","9504313939","9954546989","11181234690","9982043369","11052130385"],
  side="'cancel anytime' promised, cancel-by-email delivered, no reply — the worst experiences in the corpus")
c(34, "§1.5 Apple refunds", "must-never-break", "Several reviewers report Apple refunds being DENIED — which turns a billing dispute into a permanent 1★",
  "n/a", "1★-burst", "5 IDs", "must-never-break", "weak", "yes", ["10336428805","9896180923","13949866906","9913482153","10859158478"],
  side="when the platform refund fails, the app's own refund path is the last chance to avoid a 1★")

# ---- 1.6 ----
c(35, "§1.6", "anti-pattern", "Upsell pressure — pop-ups, spin-the-wheel offers, constant premium prompts, even push notifications that turn out to be upsells — 417 reviews (2.04%, mean 3.11) spread across ALL star bands (5.4% of 2★, 3.6% of 4★, 0.9% of 5★): an irritant that caps ratings rather than a cause of 1★; 'Every time I even ATTEMPT to add a habit, it gives me an ad pop up to buy premium'",
  "aggressive in-app upsell incl. notification bait", "complaint", "417 (2.04%), mean 3.11", "dont", "meaningful", "yes",
  ["10027403829","9336675533","12965568824","13092753937","13587281349","9590692794","11981627164","10422172003","9254743485"],
  side="'I'm broke dude, I am using a free app to try and get better mentally' — upsells on a mental-health surface read as cruelty",
  cond="push notifications that open an upsell instead of the task are a specific betrayal")
c(36, "§1.6 wheel", "anti-pattern", "26 reviews name the spin-the-wheel discount specifically; several report it rigged or broken",
  "gamified discount wheel", "complaint", "26 reviews", "dont", "weak", "yes", ["10319071373","10795829089","10422172003"],
  side="a gimmick that fails is worse than no gimmick; it feeds the 'scam' vocabulary")

# ---- 1.7 ----
c(37, "§1.7 #1", "must-never-break", "The trial/plan-selection screen bills people who believed they had 7 days — 789 reviews, mean 1.35; nothing else is close",
  "trial misfires", "1★-burst", "789 (3.86%), mean 1.35", "must-never-break", "high-priority", "yes", [], cond="evidence: R04-005, R04-006")
c(38, "§1.7 #2", "dont", "The paywall's dismiss affordance is invisible — 1,903 'must pay' reviews vs 75 explaining the X exists",
  "hidden X", "1★-burst", "1,903 vs 75", "dont", "high-priority", "yes", [], cond="evidence: R04-007")
c(39, "§1.7 #3", "product-rule", "The mid-2025 free task cap turned tenured free users into detractors",
  "free cap introduced", "1★-burst", "57 reviews; mean fell 4.29 → 3.61 that quarter", "product-rule", "high-priority (timing)", "yes", [], cond="evidence: R04-008")
c(40, "§1.7 #4", "must-have", "Cancellation and support are dead ends, converting recoverable disputes into permanent 1★ and legal threats",
  "no cancel path, no support replies", "1★-burst", "169 + 48", "must-have", "emerging", "yes", [], cond="evidence: R04-033")
c(41, "§1.7 #5", "dont", "Price is inconsistent and undisclosed until after a 10–20 minute quiz",
  "price hidden behind quiz; varies", "1★-burst", "≥9 price points; 256 quiz complaints", "dont", "high-priority", "yes", [], cond="evidence: R04-009, R04-014")
c(42, "§1.7 #6", "monetization", "No one-time / lifetime option — only 20 reviews (0.10%) ask for one, but the ask is unanimous where it appears",
  "subscription only", "blocked-conversion", "20 (0.10%)", "product-rule", "ignore-band, unanimous", "yes", ["10930935136","12009622937","11483126752"])

with open("Tools/prd_ledger/4/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
