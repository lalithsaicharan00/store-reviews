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

c(1, "header line 3-6", "positioning",
  "Me+ is a subscription-first routine planner with a 4.80 store rating on 247,686 US ratings whose 20,465 written reviews average 3.93; localised in EN, FR, DE, PT, ES; VIP at $39.99/yr and $9.99/mo",
  "developer ENERJOY PTE. LTD., bundle alarm.smart.awake.sleep.health; free download; auto-renewing 'VIP' subscription; content library (workouts, meditation, sleep sounds); mascot; age rating 4+", "mixed",
  "20,465 reviews, 136 storefronts, Jan 2022 → Sep 2026; v2.8.9 (29 Jun 2026); first released 7 Jan 2022", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this", "data-caveat",
  "Method: bands against all 20,465 and separately against each of 43 storefronts with ≥50 reviews (19,318, 94.4%); 93 storefronts hold 1,147 (5.6%, mean 4.03) with no standalone claims; one review = 0.0049%; non-exclusive themes",
  "n/a", "none", "43 eligible storefronts", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "Part 0 summary + §1 table", "data-caveat",
  "The gap between the store rating (4.80 on 247,686 tap ratings) and the written corpus (3.93; 60.1% 5★, 16.8% 1★) is the story: people who tap five stars say nothing, people who write do so because something happened — here, overwhelmingly a charge",
  "n/a", "mixed", table(35, 41), "none", "high-priority", "yes", [],
  side="a 4.8 store rating can coexist with one in six written reviews being 1★")
c(4, "Part 0 §2 + table", "insight",
  "Money, not product quality, produces one-star reviews: 57.1% of 1★ reviews mention a monetization theme (vs 4.9% of 5★); 3,805 reviews (18.59%) touch monetization at mean 2.30 and 62.2% 1–2★ — nothing else in the corpus is remotely this large or this negative",
  "aggressive subscription funnel", "1★-burst", "3,805 (18.59%), mean 2.30, 62.2% 1–2★; " + table(49, 55), "product-rule", "high-priority", "yes", [])
c(5, "Part 0 §3 + table", "must-never-break",
  "The billing-integrity cluster is the most severe finding: 1,247 reviews (6.09%, mean 1.32, 91.3% 1–2★) allege a broken trial, unexpected charge, refused refund or impossible cancellation — 'free trial' charged immediately 789 (3.86%), unauthorised charge 429, refund demanded 551, scam accusation 583, cannot cancel 169",
  "'7-day free trial' that many users say charged them at once", "1★-burst", table(65, 72), "must-never-break", "high-priority", "yes",
  ["10885363042","10930935136","11235083153","11419095674","11021690984","10848781536","11064050589","10845950237","12294261448","11757840008","13687854445","9913482153"],
  side="consistent across five years and dozens of countries: user selects a plan expecting to be billed after seven days and is billed within minutes")
c(6, "Part 0 §3 'two competing readings'", "anti-pattern",
  "The likely mechanic: the 7-day trial is attached to only one plan, and selecting a different plan bills at once — 'In order to use the free trial you have to subscribe'; whether a billing defect or a deliberately ambiguous plan-selection screen, the outcome is identical and it costs roughly one in six written reviews",
  "trial attached to one SKU only; plan picker ambiguous", "1★-burst", "~1 in 6 written reviews", "dont", "high-priority (inference labelled)", "yes",
  ["12547182143","10970088378","10073412863"],
  cond="a trial must apply to whatever plan the user picks, or the picker must say which plan carries it")
c(7, "Part 0 §4", "anti-pattern",
  "The paywall has a dismiss button users cannot find — 75 reviews (0.37%, 46.7% 5★) exist only to teach others 'press the cross in the top right corner' — direct evidence that a material share of the 1,903 (9.30%, mean 2.69) 'you must pay to use it' reviews are a discoverability failure, not a pricing decision; one user read those reviews and still could not proceed",
  "hard-to-find X on the paywall; no correction of 'it's not free' claims", "complaint", "75 (0.37%) tutorials; 1,903 (9.30%) 'must pay' at mean 2.69, 50.1% 1–2★", "dont", "high-priority (by consequence)", "yes",
  ["10797845407","11976134626","11993331188","10564522089","11593006260","11193769864","12262785068","14349334637","10970386222"],
  side="users are doing the app's onboarding job in the reviews; the app never corrected the belief that it is paid-only",
  cond="a visible, obvious 'continue free' path is a rating decision")
c(8, "Part 0 §5 + table", "timeline",
  "Mid-2025 a hard cap on free daily tasks (typically 4–7) was introduced and reversed a two-year rating recovery: cap complaints 6 in 2022–24 → 15 in 2025 Q3 (2.04%); overall mean fell 4.29 (2025 Q2) → 3.61 (2025 Q3) and paywall complaints 6.8% → 15.4%; 'I used to have at least 15'",
  "introduced a free task cap of 4–7/day in mid-2025", "1★-burst", "57 (0.28%), mean 2.58; " + table(102, 110), "product-rule", "weak count, unambiguous timing", "yes",
  ["13492344866","13684033797","13323699685","14279264893","14251626693","14426594797","13028782607","14518936346","13037009395","13595977240","13877919125","14496354181","13249657539","12837015409"],
  side="the cap converted a 'free app with paid extras' into a 'trial app'; carried disproportionately by long-tenure users so it reads as betrayal, not a price objection",
  cond="one paying user lost the capability too")
c(9, "Part 0 §6", "anti-pattern",
  "The onboarding quiz amplifies every monetization complaint: 256 reviews (1.25%, mean 1.98, 71.9% 1–2★), never 'the quiz is bad' but always 'the quiz took my time and then asked for money' — '20 minutes to find out it's not free'; only 30 of 12,308 5★ reviews mention it",
  "15–20 minute personalisation quiz before the paywall", "1★-burst", "256 (1.25%), mean 1.98, 71.9% 1–2★; 0.2% of 5★", "dont", "meaningful", "yes",
  ["9810435432","11180746949","10037507184","10399986849","12092842548","10918157672","13307691745","9611806730","10934136621","10740385550","10990423353"],
  side="a long quiz before a paywall is 'almost purely a churn amplifier' — sunk time turns a price objection into anger")
c(10, "Part 0 §7", "insight",
  "The product underneath is genuinely good — 26.46% discuss organisation outcomes (mean 4.29), 17.82% are strong endorsements ('changed my life', mean 4.77, 2.1% 1–2★), 6.96% are ADHD/anxiety/depression/OCD/autism users (4.14), 5.40% praise design; the most-voted English review (178 votes) praises a free tier that later reviewers say no longer exists",
  "good routine planner under an aggressive funnel", "praise", "5,416 (26.46%) at 4.29; 3,646 (17.82%) at 4.77; 1,424 (6.96%) at 4.14; 1,106 (5.40%)", "product-rule", "high-priority", "yes",
  ["10234553092","9856023384"],
  side="'Unlike countless other planner apps out there you don't have to pay to actually be able to use the app' — the review that carried the app is three years old")

with open("Tools/prd_ledger/4/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
