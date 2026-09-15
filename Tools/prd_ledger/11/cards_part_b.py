import json, re
R = 11
rep = open("App Store Reports/11. Daily Habits - Streak Tracker - Morning Routine & Goal Planner (REPORT).md").read().split("\n")
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

# ---- PART 2 ----
c(22, "Part 2 5★ band — the single most reliable route to 5 stars is 'it is simple and it does not get in my way'; recurring 5★ drivers", "insight",
  "The most reliable route to 5★ is 'it is simple and it does not get in my way': 17 of 27 five-star reviews praise simplicity; other drivers — it's free, no pressure / no infantilization, concrete outcome or motivation, switched from competitors, low-information praise",
  "minimal free tracker", "praise", "5★ n=27 (81.82%); simplicity 17; free 6 of 7; no-pressure 4; outcome 4; switched 3; low-info 10", "product-rule", "band analysis", "yes",
  ["9592340459","12076364194","12119209447","13952453631","14462951464"])
c(23, "Part 2 5★ band Notable: three 5★ reviews carry an unmet feature request in the same body — volunteering a roadmap", "insight",
  "Four 5★ reviews carry an unmet feature request in the same body (cloud backup, statistics, reordering ×2): these users are not withholding stars over missing features, they are volunteering a roadmap — a high-trust audience",
  "n/a", "praise", "4 of 27 five-star reviews with a request", "do", "band analysis", "yes",
  ["9327859322","9332848196","10016901878","11490387774"])
c(24, "Part 2 4★ band — every one names a specific, nameable gap; table (verbatim); 6869680821 is genuinely ambiguous", "insight",
  "All three 4★ reviews are constructive 'almost' reviews naming a specific gap — a 2021 'Limited to 3 day usage?' (ambiguous: trial limit, history window or misunderstanding; coded onboarding_limit_confusion, not used for any quantified finding), no dark theme, no month view / date filter / search — and two of the three gaps now appear in the listing as shipped",
  "n/a", "complaint", table("## 4★ — n = 3"), "build-free", "n=3", "yes",
  ["6869680821","9809639708","10985521600"])
c(25, "Part 2 3★ — n = 0; the August 2026 reviews are a discontinuity", "data-caveat",
  "There is no 3★ review at all — reviewers are either satisfied (30 of 33 at 4–5★) or feel wronged (3 of 33 at 1–2★, all Aug 2026); the August reviews are not mild dissatisfaction sliding down the scale, they are a discontinuity",
  "n/a", "none", "3★ n=0; 4–5★ 30; 1–2★ 3", "none", "band analysis", "app-specific", [])
c(26, "Part 2 2★ band; 1★ band — both paid users, both use fraud language; segment rate 2 of 2", "must-never-break",
  "The 2★ reviewer is still asking for help (title simply 'Support'); both 1★ reviewers are paid users using fraud language ('Avoid this app - appears to be a scam now'; 'Purchase fraud') — 100% of 1★ reviews are paid users reporting lost entitlement",
  "entitlement failure", "1★-burst", "2★ n=1; 1★ n=2 (6.06%); segment 2 of 2 one-star are paid", "must-never-break", "n=3", "yes",
  ["14446220984","14438257886","14472099021"])

# ---- PART 3 ----
c(27, "Part 3 WHAT PEOPLE PRAISE full table (verbatim)", "insight",
  "Sixteen praise themes with n, %, band, mean and IDs",
  "n/a", "praise", table("# PART 3 — WHAT PEOPLE PRAISE"), "none", "verbatim", "app-specific", [])
c(28, "Part 3 Practical / fit for purpose; Usability / friendly interface; Stability / works reliably; Accountability; Would recommend", "insight",
  "Smaller praise themes: practical / fit for purpose, friendly interface, stability, accountability, would recommend",
  "n/a", "praise", "practical 3 (9.09%); usability 2 (6.06%); stability 1; accountability 1; recommend 1 — all mean 5.00", "none", "n≤3", "yes",
  ["9758570716","12269558510","14462951464","13469176367","13476851347","11375045777","8756804446"])
c(29, "§3.1 Use cases users describe table (verbatim); two of six explicitly do not want a coaching product", "audience",
  "Six jobs-to-be-done each named once: a reminder layer over an existing routine ('simply a shortcut to remember things'), starting new habits, following up on existing habits, deliberately seeking a simple tracker, day planning / task tracking, plain counting — two of the six explicitly do not want a coaching product, the same audience as 'no infantilization', directly in tension with the AI-coach positioning",
  "plain tracker; AI-coach listing", "praise", table("## 3.1 Use cases"), "research", "n=1 each", "yes",
  ["8756804446","10874846443","9758570716","11375045777","12076364194","12119209447"])

# ---- PART 4 ----
c(30, "Part 4 COMPLAINTS AND UNMET NEEDS full table (verbatim); 11 of 33 contain any criticism; this corpus criticises politely", "data-caveat",
  "11 of 33 reviews contain any criticism or unmet need and eight of the eleven are 4–5★ — this corpus criticises politely; sixteen complaint themes with type classification",
  "n/a", "mixed", "11 of 33 (33.33%, mean 3.73); " + table("# PART 4 — COMPLAINTS AND UNMET NEEDS"), "none", "verbatim", "app-specific", [])
c(31, "Part 4 Lag / performance; Dated visual design (12221849177)", "feature",
  "A satisfied 5★ RU reviewer notes lag and a dated visual design alongside praise for being free without imposed junk",
  "dated UI, some lag", "praise", "1 review each", "research", "n=1", "app-specific",
  ["12221849177"])
c(32, "§4.1 Distinguishing the four complaint types — No reviewer objects to a price point; zero 'too expensive' complaints", "insight",
  "No reviewer in this corpus objects to a price point — zero 'too expensive' complaints; the one money complaint is about being charged TWICE, not the amount; the monetization damage is entirely about execution and disclosure; complaint types: broken paid capability (3, highest severity), missing capability (7), pricing objection (0), misunderstanding (possibly 1)",
  "IAPs $1.99–$14.99", "none", "0 price objections of 33", "product-rule", "absence finding", "yes",
  ["14438257886","6869680821"])
c(33, "§4.2 What is not in this corpus", "data-caveat",
  "Absences that narrow the problem space: no price objections, no data-loss reports (but fear of data loss drives purchase), no sync/multi-device complaints, no ads complaints despite the paid twin implying ads, no AI feedback, no widget feedback despite the listing headline, no accessibility complaints beyond evening eye-strain, no privacy, no onboarding complaints after 2021, no localization complaints despite 6 languages across 18 storefronts",
  "n/a", "none", "0 of 33 for each", "none", "absence findings", "app-specific", [])

# ---- PART 5 ----
c(34, "Part 5 WHO ACTUALLY USES THIS table (verbatim); the first two segments are the same audience the AI-coach positioning speaks past", "audience",
  "Five hypothesised segments with named witnesses: the already-organised adult (memory aid, not a coach — no alarms, no gamified pressure, no mascot); the simplicity refugee (tested ~6 apps, deleted all others, hit 3-habit caps elsewhere — wants to not be re-complicated); the long-tenure archivist (3 years of local history, needs export/backup and a durable entitlement); the analytical reviewer (month/year views, filters, search, per-task stats); the motivated beginner (badges, per-habit reminders); the first two are the audience the AI-coach positioning speaks past — four reviewers chose this product because it was quieter than the alternatives",
  "quiet, minimal tracker", "praise", table("# PART 5 — WHO ACTUALLY USES THIS"), "do", "hypotheses (n=1–4 each)", "yes",
  ["8756804446","11375045777","13685904641","12076364194","13469176367","11904287504","14438257886","9332848196","10985521600","9327859322","9592340459","10874846443","12249396648"])

# ---- PART 6 ----
c(35, "§6.1 Purchase triggers — only one stated motivation, and it is defensive; §6.2 Buyer value delivered: none", "monetization",
  "Only one purchase motivation is stated and it is defensive — data retention under threat; the other two paid reviewers name the SKU ('VIP', 'lifetime') but give no reason; buyer value delivered: none in every case — access worked briefly (one week / a few months / partial term) and then stopped; a satisfied user's 'sorry that I didn't buy' shows the ask is registered without resentment when the free tier is intact",
  "paywall over history; entitlements fail", "churn", "1 stated trigger; 3 of 3 buyers got no lasting value", "must-never-break", "n=3", "yes",
  ["14438257886","14446220984","14472099021","12221849177"])
c(36, "§6.3 Upgrade barriers and monetization friction table (verbatim)", "monetization",
  "Eight upgrade barriers and what fixes each: entitlement does not persist and restore fails (receipt validation + restore audit); active subscription re-prompted (same); no reachable support channel (in-app contact + SLA); three SKUs one display name (App Store Connect metadata); in-app lifetime $5 dearer than standalone app (pricing decision); no paywall disclosure in listing (listing copy); paywall retrofitted without notice (grandfathering policy)",
  "see table", "1★-burst", table("## 6.3 Upgrade barriers"), "must-never-break", "n=3 + listing", "yes",
  ["14446220984","14472099021","14438257886","12249396648","13476851347"])
c(37, "§6.3 Paywall retrofitted over previously-free features without notice — fixable by grandfathering policy", "product-rule",
  "A paywall retrofit over previously-free features needs a grandfathering policy — existing users who had the features free must keep them",
  "no grandfathering", "1★-burst", "1 complaint contradicted by 2 earlier 'all free' reviews", "product-rule", "recommendation", "yes",
  ["14438257886","12249396648","13476851347"])
c(38, "§6.4 Refund and churn drivers — churn is trust-driven and expressed in the storefront because there is no support queue", "insight",
  "No refund request appears; two of three paid users publicly warned others off; churn is not price-driven but trust-driven, and it is expressed in the storefront rather than a support queue because there is no support queue the reviewers could find",
  "no in-app support channel", "churn", "2 of 3 paid users warn others off; 0 refund requests", "must-have", "n=3", "yes",
  ["14438257886","14472099021"])
c(39, "§6.5 What cannot be claimed", "data-caveat",
  "Cannot be claimed: no conversion rate (reviewers are not a sample of users); no claim that most purchases fail (reviewers with a working purchase have little reason to write — a qualitative finding that a defect exists, not a failure rate); no revenue impact",
  "n/a", "none", "n=3", "none", "method", "yes", [])

with open("Tools/prd_ledger/11/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
