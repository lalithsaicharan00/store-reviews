import json, re, sys
R = 2
rep = open("App Store Reports/2. Daily Habits - Habit Tracker - Habit List and Routine Tracker (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- header / how to read ----
c(1, "header line 3-6", "positioning",
  "Daily Habits is an abandoned free habit tracker: last updated 18 May 2021 (v1.5.1), 517 reviews across 61 storefronts, 299 US ratings at 4.40",
  "developer Olha Ievenko / XWaveSoft, bundle com.xwavesoft.habits; sibling apps Be Focused and Focus Matrix; free download, ad-supported, one-time Pro", "mixed",
  "517 reviews, 61 storefronts, Nov 2016 → Aug 2026; 299 US ratings at 4.40; last update 18 May 2021", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this", "data-caveat",
  "Method: signal bands applied against two denominators only (all 517, and the US n=98 — the only storefront over the 50-review bar); one review = 0.19%, so every band boundary is soft",
  "n/a", "none", "60 other storefronts hold 419 reviews (mean 4.23) — counted globally, no standalone claims; bands <0.1 ignore / 0.1–0.5 weak / 0.5–1 emerging / 1–3 meaningful / 3–5 very strong / >5 high-priority",
  "none", "method", "yes", [], cond="a five-review swing moves a theme a full band")

# ---- PART 0 ----
c(3, "Part 0 summary line", "insight",
  "A well-liked, genuinely differentiated free habit tracker was killed by data loss, crashes and five years of silence — and its headline rating went UP while it died",
  "stopped development May 2021", "churn", "executive summary; supporting numbers in R02-004..008", "product-rule", "high-priority", "yes", [],
  side="a rising store rating can hide a dying product")
c(4, "Part 0 §1", "timeline",
  "Development stopped in May 2021 — 5 years 4 months without an update — and reviewers had been noticing since 2019",
  "no update since v1.5.1, 18 May 2021", "complaint", "9 explicit abandonment complaints (1.74%, mean 2.89), from 2019 (DE, NI) to 2026 (IT)", "dont", "meaningful", "yes",
  ["5229271933","5080536455","6185785453","10872403505","13788341591"],
  side="users read silence as abandonment years before the store listing shows it")
c(5, "Part 0 §2 + year table", "data-caveat",
  "Review volume fell 96% (100/yr in 2019 → 4 in 2026) while the mean rose from 4.19 to 4.31 — survivorship, not recovery; nothing shipped after May 2021",
  "n/a", "mixed", table(41, 53), "none", "high-priority", "yes", [],
  side="do not read a rising average as improvement when volume collapses",
  cond="2017 was the worst year: mean 3.74, 25.3% 1–2★")
c(6, "Part 0 §3", "market",
  "The US — the largest and richest market — is the worst-rated one (3.80 vs 4.15 global, 23.5% 1–2★ vs 15.1%); Japan worse still at 3.30; the highest-rating markets write the shortest reviews",
  "n/a", "complaint", "US mean 3.80, 23.5% 1–2★; global 4.15, 15.1%; JP 3.30 [limited evidence n=20]; BR 4.65, GB 4.45 with shortest reviews", "none", "high-priority", "yes", [],
  side="engaged Western users are the honest signal")
c(7, "Part 0 §4", "data-caveat",
  "A quarter of the corpus is near-empty: 132 reviews (25.5%) under 40 characters averaging 4.52 — short reviews inflate the rating; Vietnam is 14 reviews, 13 of them 5★, mostly 'Good' / 'Ok'",
  "n/a", "none", "132 (25.5%) under 40 chars, mean 4.52 vs corpus 4.15; VN 14 reviews, 13 5★, mean 4.93", "none", "high-priority", "yes",
  ["4088257905","4173137456","4707702065","5720578554","1634520759"])
c(8, "Part 0 §5", "data-caveat",
  "The launch window (Nov–Dec 2016) looks partly seeded: generic non-native 5★ reviews within days of release, two reviewers called it out, and a free-Pro giveaway ran at launch",
  "possibly seeded launch reviews + free-Pro giveaway at launch", "mixed",
  "Nov–Dec 2016 = 65 reviews at 4.32 / 66.2% 5★ vs 4.12 / 60.0% for the rest; inference from style and timing, not proof", "dont", "flagged with caution", "yes",
  ["1478551952","1478933026","1485661227","1478389236","1478560873","1479031508","1478508225","1478967168","1478263216","1479044283","1484864417","1483240079","1482736956","1484186051"],
  side="'the obviously machine-translated 5-star reviews actually make a bad impression' (JP); 'the positive reviews are LIES' (RU) — seeded reviews are noticed and cost trust",
  cond="discount the first two months rather than treating them as baseline")
c(9, "Part 0 'what this means'", "insight",
  "The honest read is ~3.8–4.0 among engaged Western users, and the decline is entirely self-inflicted through reliability, not competition",
  "n/a", "churn", "synthesis of Part 0", "must-never-break", "high-priority", "yes", [])

# ---- 1.1 ----
c(10, "§1.1 bullet 1", "monetization",
  "Free download, ad-supported, with an unusually generous free tier — unlimited habits — which is the app's single strongest differentiator and is given away",
  "unlimited habits free; ads in free tier", "praise", "unlimited-habits praise is the top theme (5.80%, Part 3)", "build-free", "high-priority", "yes", [],
  cond="report calls the free tier 'too good relative to a broken Pro' (§1.6 #3) — the problem is Pro, not the free tier")
c(11, "§1.1 bullet 2", "monetization",
  "Pro is a one-time in-app purchase — US $3.99 (2016), ~C$4, €1 in a promo — repeatedly described as 'minuscule' / 'cheap'",
  "one-time Pro at ~$4", "purchase-driver", "price points from 5 reviews; 19 buyers cite one-time fee (§1.3)", "product-rule", "high-priority", "yes",
  ["1484186051","9175173155","5727003954","10949884121","2911210521"])
c(12, "§1.1 bullet 3", "data-caveat",
  "One reviewer calls it a subscription; isolated and contradicted by the listing and by 18 other reviewers praising the one-time fee — treat as reviewer error",
  "one-time purchase", "none", "1 vs 18", "none", "isolated", "yes", ["7418712220"])

# ---- 1.2 Pro feature table ----
c(13, "§1.2 table row 1", "feature",
  "Cross-sync between iOS devices is a paid Pro feature and is reported broken by 12 reviews (2.32%, mean 2.92)",
  "paid; broken", "1★-burst", "12 (2.32%), mean 2.92", "must-never-break", "meaningful", "yes",
  ["1520975020","1709883514","1517984752","1519202196","3626745558","11151750805","10872403505","10424885681","1816542296","1777981808","3385244633","1856430373"],
  cond="the Pro headline feature; 6 buyers name it as the reason they paid (§1.3)")
c(14, "§1.2 table row 2", "feature",
  "Calendar-app sync is a paid Pro feature reported broken by 9 reviews (1.74%) at the lowest mean in the table (2.11) — and it damages the user's calendar",
  "paid; broken; spawns duplicate / phantom events", "1★-burst", "9 (1.74%), mean 2.11", "research", "meaningful", "yes",
  ["1650678342","1508808010","1484435569","4494723296","1639153995","2493571137","1816432913","9974150902","5683048621"],
  side="Part 4: infinite duplicate events, a phantom '2001' event — a paid feature that harms data outside the app")
c(15, "§1.2 table row 3", "feature",
  "Extended statistics is a paid Pro feature reported deficient by 13 reviews (2.51%, mean 3.31) — the most-complained-about Pro item",
  "paid; deficient", "complaint", "13 (2.51%), mean 3.31", "build-paid", "meaningful", "yes",
  ["4733959513","5078666035","1570623231","3654077349","3687308474","1512585333","8194482136","11707492556","1534636069","1526282800","1508808010","1891116934","2380499734"],
  cond="per-habit analytics locked in free is a paywall-friction complaint (§1.5)")
c(16, "§1.2 table row 4", "feature",
  "Passcode lock with Touch ID is a paid Pro feature; one user had the app crash on launch with passcode set and had to delete it, losing everything; another reports a Touch ID 'peek' leak",
  "paid; buggy", "complaint", "2 (0.39%), mean 3.00", "research", "weak", "yes", ["5747344195","3342902073"],
  side="a lock that crashes the app is a data-loss path")
c(17, "§1.2 bold sentence", "insight",
  "Every single feature you are asked to pay for is a documented failure point — 35 reviews (6.77%, HIGH-PRIORITY, mean 2.83) report a broken or deficient Pro capability; the free tier is the part that works",
  "Pro = sync + calendar + stats + passcode, all failing", "1★-burst", "35 reviews (6.77%), mean 2.83", "must-never-break", "high-priority", "yes", [],
  side="paid features carry a higher reliability bar than free ones")
c(18, "§1.2 free-tier list", "feature",
  "Free-tier capabilities confirmed working: unlimited habits, per-habit reminders, morning/afternoon/evening/night grouping, custom icons and personal photos, habit library/presets, break-a-bad-habit mode, archive, streaks and % completion, Today Widget + 3D Touch, Apple Watch app, groups/sharing",
  "all of these free", "praise", "list from listing + reviews; no counts", "build-free", "stated", "yes", [],
  cond="this is an unusually rich free tier: Watch app, bad-habit mode, photos as icons and sharing are paid elsewhere")

# ---- 1.3 ----
c(19, "§1.3 line 92", "insight", "30 reviews (5.80%, HIGH-PRIORITY) confirm a purchase",
  "n/a", "purchase-driver", "30 (5.80%)", "none", "high-priority", "yes", [])
c(20, "§1.3 table row 1", "insight",
  "The #1 stated reason to pay is the one-time fee, not a subscription — 19 buyers (3.68%) at mean 4.84; 'the strongest and cleanest thing this product has'",
  "one-time ~$4 Pro", "purchase-driver", "19 (3.68% global), mean 4.84; 19 of 30 buyers", "product-rule", "very strong", "yes",
  ["5902712831","9923794823","4874970421","5460594340","8188213087","10949884121","5727003954","10424885681","2911210521","9175173155","3606113071","5263275131","1667083196","7418712220","12488497405","13550599009"],
  side="'compared to the other 2 dozen habit apps I looked at that charge that fee on a monthly basis'; 'available for a fraction of the price' of the Atomic Habits app")
c(21, "§1.3 table row 2", "feature", "Cross-device sync is the #2 stated reason to pay (6 buyers) — and it is the Pro feature that breaks",
  "paid; broken", "purchase-driver", "6 of 30 buyers", "build-paid", "moderate", "yes", ["1816542296","3626745558","1520975020","1777981808","4402829597","11151750805"])
c(22, "§1.3 table row 3", "tactic", "'Support the developer / already own their other apps' is the #3 reason to pay (5 buyers) — brand trust from sibling apps Be Focused and Focus Matrix converts",
  "publishes an app family", "purchase-driver", "5 of 30 buyers", "do", "moderate", "yes", ["1481812475","8731669029","13788341591","7232398007","2109039905"],
  cond="but two of these buyers assumed cross-app integration that does not exist and left 1★ (§1.6 #5)")
c(23, "§1.3 table row 4", "monetization", "Removing ads is a stated reason to pay for 3 buyers",
  "ads in free tier; Pro removes them", "purchase-driver", "3 of 30 buyers", "research", "weak", "yes", ["5819047278","5727003954","4025884406"],
  cond="one buyer says 'paying only removes the ads, I didn't feel much benefit' (§1.5)")

# ---- 1.4 ----
c(24, "§1.4 table + bold", "insight",
  "Paying reduces satisfaction by more than a full star: confirmed payers rate 3.10 vs 4.15, 40% of payers leave 1–2★ (vs 15.1%), 10 of 30 payers left one star — 'the most consequential finding in the dataset'",
  "Pro features fail", "churn", "payers n=30: mean 3.10, 1–2★ 40.0%, 5★ 33.3%; corpus: 4.15, 15.1%, 60.7%", "must-never-break", "high-priority", "yes", [])
c(25, "§1.4 line 120", "insight", "47% of confirmed payers (14/30) report a broken feature or stability failure: 37% hit data loss, crashes or crippling lag; 23% hit a broken Pro feature specifically",
  "n/a", "churn", "14/30 broken; 11/30 data loss/crash/lag; 7/30 broken Pro feature", "must-never-break", "high-priority", "yes", [])
c(26, "§1.4 one-star payer table (verbatim)", "timeline", "The ten one-star payers, in full — what each paid for and what happened",
  "Watch sync failed then wiped the app; habits vanished twice; 5+ s lag + infinite calendar duplicates; crashed permanently after an hour of setup; bought for cross-app integration that does not exist; Watch never synced; calendar sync failed then all data disappeared with no support reply; progress wiped twice losing six months; crashes on iOS 14; all habits gone on day two", "1★-burst",
  table(124, 135), "must-never-break", "high-priority", "yes",
  ["1816542296","1777981808","1639153995","1695627701","2109039905","4402829597","5403701988","6379792275","7232398007","8106352419"],
  side="this list IS the churn analysis; the common thread is data loss after paying")
c(27, "§1.4 refund line", "must-never-break", "Refund / regret language appears in 8 reviews (1.55%) with a mean rating of exactly 1.00",
  "no refund path visible", "1★-burst", "8 (1.55%), mean 1.00", "must-never-break", "meaningful", "yes",
  ["3313222571","5403701988","9488272822","1816542296","1639153995","9929028369","1695627701","2109039905"])

# ---- 1.5 ----
c(28, "§1.5 opening + bullets", "must-never-break",
  "8 reviews (1.55%) describe people who tried to pay and could not, or were confused out of it: purchase errors, signup that rejects a valid custom-domain email, 'impossible to create an account', a launch promo that failed to apply",
  "purchase and signup flow leak buyers", "blocked-conversion", "8 (1.55%); one says 'I'm happy to pay for this app (solely to remove the ads)' and is blocked by the signup form", "must-never-break", "meaningful", "yes",
  ["2127688409","6152405859","1520975020","1477051291","5819047278","1483218187","1482736956","1484186051"],
  side="account creation that fails 'same as all this developer's other apps' — a shared backend bug leaks across the app family",
  cond="iPad accepted payment but would not sync it back to iPhone")
c(29, "§1.5 localisation line", "market", "One explicit localisation-gated purchase: a Peruvian user would buy today if the app were in Spanish",
  "English only", "blocked-conversion", "1 review", "do", "single review", "yes", ["4316991688"])
c(30, "§1.5 paywall friction", "monetization",
  "Paywall friction — 6 reviews (1.16%, mean 2.67): 'quite restricted', no completion feedback in free, per-habit analytics and stats locked, and 'paying only removes the ads, I didn't feel much benefit'",
  "per-habit stats and completion feedback locked; Pro perceived as an ad-removal fee", "complaint", "6 (1.16%), mean 2.67", "build-free", "meaningful", "yes",
  ["4064205077","5378260946","8194482136","5548521598","1534636069","4025884406"],
  side="from the user's seat Pro reads as an ad-removal fee because its three real features don't work",
  cond="locking per-habit stats in the free tier draws 3★ from otherwise-positive users")

# ---- 1.6 ----
c(31, "§1.6 #1", "must-never-break", "Every paid feature is broken — sync, calendar, stats — the entire Pro bundle (6.77% of all reviews)",
  "Pro bundle fails", "1★-burst", "6.77%", "must-never-break", "high-priority", "yes", [], cond="evidence: R02-013..017")
c(32, "§1.6 #2", "insight", "Paying makes people angrier, not happier — payers rate 3.10 vs 4.15",
  "n/a", "churn", "3.10 vs 4.15", "must-never-break", "high-priority", "yes", [], cond="evidence: R02-024")
c(33, "§1.6 #3", "monetization", "The free tier is too good relative to a broken Pro — unlimited habits free is the top praise theme (5.80%) and Pro adds nothing that reliably works",
  "unlimited free; Pro broken", "mixed", "5.80% praise for unlimited habits", "research", "high-priority", "yes", [],
  cond="the report's framing is that Pro must offer something that works, not that the free tier should shrink")
c(34, "§1.6 #4", "must-never-break", "The purchase and signup flow itself leaks buyers (1.55%), including a user who says outright he wants to pay",
  "purchase/signup errors", "blocked-conversion", "1.55%", "must-never-break", "meaningful", "yes", [], cond="evidence: R02-028")
c(35, "§1.6 #5", "anti-pattern", "Cross-app integration was implied by the sibling apps and never delivered — it drove at least two purchases and both ended in 1★, and three more reviews ask for it",
  "no integration between Daily Habits, Be Focused and Focus Matrix", "1★-burst", "2 purchases → 1★; 3 further requests", "dont", "weak count, clear mechanism", "yes",
  ["2109039905","7232398007","8731669029","6467272815","9974150902"],
  side="an app family raises expectations of integration; either deliver it or say plainly it does not exist")

with open("Tools/prd_ledger/2/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
