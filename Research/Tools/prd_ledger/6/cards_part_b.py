import json, re
R = 6
rep = open("App Store Reports/6. Streak Tracker - StreakUp - Habit Builder & Breaker (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
        elif l.startswith("#") and blocks == [] and k == 0 and False: pass
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))


# ---- PART 1 — MONETIZATION ----
c(28, "§1.1 The model, reconstructed from reviews + listing table (verbatim)", "data-caveat",
  "Free/paid split reconstructed from reviews + listing: both modes, widget, reminders, backfill, trophies and sharing are free; streaks beyond 2, Streak Freeze and custom themes & icons are paid; multiple check-ins per task per day does not exist at any tier",
  "n/a", "mixed", table("## 1.1 The model"), "none", "verbatim", "app-specific",
  ["14292633754","14271116952","13085620460","13767758923","13994050917","14372026009","13628759209","13093308789","13845360166","14214912053","14346310474","14477924333","14267106974","13969396065","13390634274","14471219702"])
c(29, "§1.1 Streak Tracker mode (manual check-in) row", "feature",
  "Streak Tracker mode (manual daily check-in) is free and ships alongside the counter; the one reviewer who names both modes rates 5★",
  "free", "praise", "Both modes (auto + manual) 1 (2.27%), mean 5.00", "build-free", "meaningful (n = 1)", "yes",
  ["14292633754","14271116952"])
c(30, "§1.1 Notifications / reminders row; Part 3 Notifications work row; §4.2 no notification-failure complaints", "feature",
  "Notifications/reminders are free and draw no complaints: the one notification mention is positive and there are zero notification-failure reports",
  "free reminders", "praise", "Notifications work 1 (2.27%), mean 5.00; 0 notification-failure complaints", "build-free", "meaningful (n = 1)", "yes",
  ["14292633754"])
c(31, "§1.1 Backfill / edit a missed day row; Part 3 row", "feature",
  "Backfilling or editing a missed day is free and is named as a reason for 5★: 'you can edit your calendar in case you miss a day… It's free too'",
  "free backfill", "praise", "1 (2.27%), mean 5.00", "build-free", "meaningful (n = 1)", "yes", ["14271116952"])
c(32, "§1.1 Trophies (Spark → Legend), sharing to socials row; Part 3 Trophies / gamification and Social sharing of milestones rows", "feature",
  "Trophy tiers (Spark → Legend) and sharing milestones to socials are free and praised by free users",
  "free trophies + social share", "praise", "Trophies / gamification 2 (4.55%), mean 5.00; Social sharing of milestones 1 (2.27%), mean 5.00", "build-free", "very strong band (n = 2)", "yes",
  ["13093308789","13845360166"])
c(33, "§1.1 Streak Freeze PAID row; §1.3 #3; Part 4 Streak Freeze locked behind paywall row; Part 9 #10", "feature",
  "Streak Freeze is paid; one reviewer names it both as a complaint ('streak freezes and unlimited streaks is only available if you pay') and as a thing worth having — the report says sell the freeze and the streak count, not cosmetics",
  "paid Streak Freeze", "mixed", "Streak Freeze locked 1 (2.27%), mean 4.00; only explicit source", "build-paid", "weak (n = 1)", "yes",
  ["14214912053"])
c(34, "§1.1 A note on the paid feature set; Part 9 #10", "monetization",
  "Cosmetics carry part of the price tag and none of the perceived value: the listing sells Premium as 'unlimited streaks, custom themes & icons', reviewers only ever ask for the first — zero of 44 reviews mention themes or icons in any context; stop selling Premium on themes and icons",
  "custom themes & icons paid", "none", "0 of 44 mention themes or icons", "dont", "observed absence", "unknown", [],
  cond="n = 44; a streak-counter audience; contrast report 3 where widget customisation was the #1 purchase trigger and report 1 where icon themes were a minor purchase factor")
c(35, "§1.1 cosmetics note vs Part 9 #6 'unlimited-with-cosmetics-paid'", "contradiction",
  "Report 6 contradicts itself on cosmetics: Part 9 #6 proposes testing 'unlimited-with-cosmetics-paid' while Part 9 #10 says stop selling Premium on themes and icons because zero of 44 reviewers mention them — so the fallback paid layer if the cap is lifted is unvalidated",
  "n/a", "none", "0 of 44 mention cosmetics; #6 vs #10", "research", "internal tension", "yes", [],
  cond="resolve before copying the 'unlimited free, cosmetics paid' model; report 3 found widget customisation sells, report 6 finds themes/icons don't register")
c(36, "§1.2 Direct paid-user evidence — 4 reviewers (9.09%), mean 3.25 table (verbatim)", "data-caveat",
  "Only four reviewers give direct evidence of a transaction or attempt — the narrowest and most important denominator; segment rates on n = 4 must not be generalised; purchase evidence excludes the reviewer who only approves of lifetime",
  "n/a", "mixed", "4 (9.09%), mean 3.25; " + table("## 1.2 Direct paid-user evidence"), "none", "verbatim (segment n = 4)", "app-specific",
  ["13390634274","13771926913","13939159292","14203637124"])
c(37, "§1.2 Every single purchase or purchase attempt in this corpus went wrong", "must-never-break",
  "Every purchase or purchase attempt in the corpus went wrong — four for four: one bought the wrong thing because the paywall over-promised, two were over-billed, one could not pay at all; zero reviewers report a satisfying purchase",
  "checkout path fails in 4 different ways", "complaint", "4 of 4 paid-evidence reviewers; 0 satisfying purchases; not a rate — a qualitative fact about the checkout path", "must-never-break", "unambiguous qualitatively", "yes",
  ["13390634274","13771926913","13939159292","14203637124"],
  cond="appendix: emphatically not a claim that 100% of purchases fail; no conversion rate is claimed")
c(38, "§1.2 13390634274 row; §4.1 The paywall implied a capability the product does not have; Part 4 Cancelled subscription row", "anti-pattern",
  "The paywall implied a capability the product does not have: a user bought Pro at $1.99 to get multiple daily check-ins, found it doesn't exist and cancelled — 'Thankfully I only paid $1.99 as I will now cancel — there are free ones with basic'; that is the difference between a feature request and a refund cause",
  "Pro sold without multi-log; buyer expected it", "churn", "1 (2.27%), 4★, CA; Cancelled subscription 1 (2.27%), mean 4.00", "dont", "weight raised: a paying customer who churned", "yes",
  ["13390634274"])
c(39, "§1.3 What would trigger a purchase #1 More streaks", "insight",
  "The stated purchase trigger is a short list, led by more streaks — 'I'm personally a go-getter so I would like to have more than 2 streaks'; demand is explicit and repeated",
  "unlimited streaks paid", "purchase-driver", "4 reviewers name more streaks", "undecided", "explicit, repeated", "yes",
  ["14214912053","14477924333","14346310474","14372026009"],
  cond="tension: the same demand is the #1 complaint — whether it converts or just costs stars is research question #1")
c(40, "§1.3 #2 A lifetime/one-time option instead of a subscription; §8.4; Part 9 #7", "monetization",
  "Lead with the one-time/lifetime SKU: three of the four paid-evidence reviewers engage with it (one asked to buy it, one bought it, one welcomed it — 'They did add a new feature where you can pay to have a lifetime subscription (which is nice)'), all positively in principle, while four separate reviewers object to subscriptions as such",
  "yearly $11.99 subscription + $14.99 lifetime (added mid-corpus)", "purchase-driver", "3 of 4 paid-evidence reviewers engage with lifetime; 4 reject subscriptions; 'the clearest packaging signal in the corpus'", "product-rule", "clearest packaging signal", "yes",
  ["14203637124","13939159292","14214912053","14491149862","14307898374","14205874183","13185604622"])
c(41, "§1.3 subscription objection quote; §0.1", "monetization",
  "A 1★ review whose entire body is 'You gotta pay a subscription😭' — a subscription as such, not its price, is the objection",
  "subscription required for more than 2 streaks", "1★-burst", "1 (2.27%), 1★, NO; May–Aug 2026's only 1–2★", "product-rule", "quoted (n = 1)", "yes",
  ["14491149862"])
c(42, "§1.4 Upsell pressure; Part 4 Upsell nagging on every launch row; Part 9 #9", "dont",
  "The paywall surfaces on launch rather than at the point of need — 'every time I open the app it begs me for money'; move it to the moment of need (attempting streak #3, or attempting a freeze)",
  "upsell on every app open", "1★-burst", "1 explicit (2.27%), mean 1.00; aligns with the greed cluster (4, mean 1.00)", "dont", "weak alone; aligned with the angriest cluster", "yes",
  ["13185604622","14205874183","14491149862"],
  side="cap-complainers already like the app, so a need-time paywall reaches people with intent")
c(43, "§1.4 'make it free / pls'; Part 4 Price objection / 'make it free' row", "monetization",
  "Price objection / 'make it free': a 3★ that says only 'make it free / pls', and a UA reviewer objecting to a ~5-dollar subscription ('5 баксов')",
  "yearly/monthly subscription", "complaint", "6 (13.64%), mean 2.00", "research", "high band (n = 6)", "yes",
  ["13185604622","13939159292","13969396065","14205874183","14307898374","14491149862"])

# ---- PART 2 — RATING DRIVERS ----
c(44, "Part 2 5★ — n = 24 (54.55%)", "insight",
  "5★ is driven by four things in order: a behaviour-change outcome achieved (9, all 5★), the widget (6 of 7 mentions 5★), simplicity, and perceived free-ness (3 reviews praise the app as free, mean 5.00)",
  "n/a", "5★-burst", "5★ n = 24 (54.55%); outcome 9; widget 6 of 7; simplicity 4 named; free-ness 3 at 5.00", "do", "observed", "yes",
  ["13837160367","13891333657","14311507310","14349062008","13845360166","13672386764","14389534229","13795256017","14093501015","13466777630","13767758923","14146487084","14271116952"])
c(45, "Part 2 5★ tension with Part 0.2; Part 3 Perceived as free / generous free tier row", "contradiction",
  "The same free tier reads as generous to some and as a trap to others, and the difference appears to be how many habits the user is tracking — 'completely free' 5★s track one or two things, cap complainers track more",
  "2-streak free tier", "mixed", "Perceived as free / generous free tier 3 (6.82%), mean 5.00 vs Free streak cap 7 (15.91%), mean 3.00", "research", "inference", "yes",
  ["13767758923","14093501015","14271116952","14477924333","14214912053"],
  cond="a quantity cap is judged by each user against their own count — it cannot be generous and tight at once; supports gating on capability rather than quantity")
c(46, "Part 2 5★ low-information reviews", "data-caveat",
  "6 of the 24 five-star reviews carry effectively no product information ('Good', 'Worth it', 'Super simple et super efficace' borderline); 'Max verstappen' is pure noise, retained in all denominators",
  "n/a", "none", "6 of 24 5★ low-information", "none", "observed", "yes",
  ["13466777630","14184863622","14351962860","14417731278","14414628073","13872472954"])
c(47, "Part 2 4★ — n = 7 (15.91%) — the 'almost, but the cap' band", "insight",
  "The 4★ band is 'good app, but…': four of seven name a specific gap — cancelled over a missing feature, cap + freeze, must log daily, cap; the remaining three are low-information",
  "n/a", "mixed", "4★ n = 7 (15.91%); 4 of 7 'good app, but'", "do", "observed", "yes",
  ["13390634274","14214912053","14471219702","14477924333","13276224447","13564532421","14456589309"])
c(48, "Part 2 3★ — n = 5 (11.36%) — 100% monetization", "insight",
  "The 3★ band is 100% monetization and the most convertible band in the corpus: not one of the five is about a bug, a crash or a missing feature other than the paywall, and every one says or implies they like the app — it converts on packaging alone",
  "n/a", "complaint", "3★ n = 5 (11.36%), 5 of 5 monetization", "do", "observed", "yes",
  ["13939159292","14205874183","14267106974","14307898374","14346310474"])
c(49, "Part 2 1★ — n = 8 (18.18%) table (verbatim)", "data-caveat",
  "1★ drivers: paywall/price/greed 4, billing over-charge 1, clone accusation 2, mode confusion read as a bug 1, 'app doesn't work' 1 (same review as a clone)",
  "n/a", "1★-burst", "1★ n = 8 (18.18%); " + table("## 1★ — n = 8"), "none", "verbatim", "app-specific",
  ["13185604622","13628759209","13969396065","14491149862","13771926913","13531820409","13557096013","13994050917"])
c(50, "Part 2 1★ Only one of the eight 1★ reviews alleges the app is broken; Part 4 'App doesn't work' row", "insight",
  "Only one of the eight 1★ reviews alleges the app is broken, with no detail; seven of eight are about money, expectations or comparison — there is no reliability crisis, there is a trust and packaging crisis",
  "n/a", "1★-burst", "1 of 8 alleges broken ('App doesn't work' 1, 2.27%, mean 1.00); 7 of 8 money / expectations / comparison", "product-rule", "observed", "yes",
  ["13531820409"],
  cond="a 13-month-old, local-only, single-device app; contrast report 5 where reliability produced the volume of 2–3★")

with open("Tools/prd_ledger/6/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
