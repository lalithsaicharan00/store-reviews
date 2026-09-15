import json, re
R = 13
rep = open("App Store Reports/13. Productive - Habit Tracker - Daily Routine & Goals Planner (REPORT).md").read().split("\n")
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

# ---- PART 5 ----
c(47, "§5.1 The evidence base, stated honestly table (verbatim); the two populations are the same size", "data-caveat",
  "Transaction language is split because people mention money mainly when it went wrong: voluntary purchase vs involuntary charge are the same size (review-visible ratio 1:1); reported as one group the mean is 1.85, an artefact; no conversion, churn, renewal, revenue or subscriber count is claimable",
  "n/a", "mixed", "1,736 (8.75%) transaction language; " + table("## 5.1 The evidence base"), "none", "method", "yes", [])
c(48, "§5.2 Voluntary buyers — n = 836, mean 3.06; bimodal, not unhappy; themes table (verbatim); geography", "monetization",
  "Voluntary buyers are bimodal, not unhappy: 37% five-star and 33% one-star; within them utility, 'worth paying' and recommend are heavily over-represented; 'The premium account is really worth it. I bought it at least 2 years ago'; '$12 a year. Netflix is $15 a month, so that seemed fine'; 'well worth the money. And I'm a broke college student'; the 1★ third are people who bought and then objected to a price rise, model change or defect — a renewal-risk population",
  "annual subscription", "mixed", "836 (4.21%) mean 3.06; 5★ 311 (37.2%) · 4★ 75 · 3★ 85 · 2★ 86 · 1★ 279 (33.4%); " + table("## 5.2 Voluntary buyers") + " ; geography US 476 (57%), GB 69, CA 45, AU 33, BR 24, RU 23, DE 22, KR 17", "build-paid", "segment", "yes",
  ["4579753907","3137332075","4968659911","3573097080","1630174450","1358897750","1399170502","1402716583","1539169002","1652748005","1678598831","1812076040","4158416940","5858474870","6138703058","7191015742","1339259899","1299340618"])
c(49, "§5.2 Interpretation — the purchase trigger: hitting the habit cap while already engaged", "insight",
  "Buyers name a single trigger with striking consistency: hitting the habit cap while already engaged — 'I purchased premium for a year so I can have more activities'; 'I upgraded pretty early on so I could have more habits to work on' — the cap converts, but only for users who got far enough in to care; that is why the aggressive first-minute paywall is self-defeating: it fires before engagement exists",
  "habit cap as the paid trigger; interstitials before engagement", "purchase-driver", "836 voluntary buyers; cap-trigger stated repeatedly", "product-rule", "segment", "yes",
  ["1812076040","1652748005"])
c(50, "§5.3 Involuntary charges — n = 856, mean 1.27; geography table (verbatim); the mechanics reviewers describe", "must-never-break",
  "Involuntary charges: 89% one-star; half from mainland China and 11% from Korea; the mechanics in reviewers' own accounts: the trial cannot start without first authorising a subscription; the plan defaults to the most expensive annual tier ('I didn't even get to choose, it just charged the highest'); no cancel control in the app and the subscription does not appear in Apple's list until after the charge; the charge lands after the app was deleted; in China password-free payment (免密支付) means no authentication step interrupts the charge; refunds declined with support redirecting to Apple and Apple back",
  "subscription-first trial defaulting to the dearest tier; no in-app cancel", "1★-burst", "856 (4.31%) mean 1.27; 1★ 762 (89.0%); M-trial-autocharge 84.3%, M-refund 20.6%, M-cancel-hard 13.2%; " + table("## 5.3 Involuntary charges"), "must-never-break", "high-priority", "yes",
  ["3272238239","2380437896","3233093755","2178452576","3183095608","3163329581","2266470444","3366758790","2475980289"])
c(51, "§5.4 Upgrade barriers table (verbatim)", "monetization",
  "Upgrade barriers: objection to the subscription model itself, price level, wants one-time purchase, free tier too small to evaluate the paid tier, cannot try before committing a payment method, upgrade prompts prevent evaluation, purchase fails",
  "n/a", "blocked-conversion", table("## 5.4 Upgrade barriers"), "research", "segment", "yes",
  ["2274339164","2404027318","2013556192","2593975724","2267301153","2286844068","1465724209"])
c(52, "§5.4 The interstitial problem, quantified by reviewers themselves; delay the first interstitial until the user has completed habits on three separate days", "dont",
  "Users count the paywalls: '3 separate screens telling me to go premium' in one minute; 'asked to join a free premium trial 3 times within the first minute'; '4 times in 1 minute during registration'; 'more than 10 pop ups' in five minutes; '15 notifications in the first 3 minutes'; '3 full screen countdowns to subscribe during setup' with the dismiss hidden; 'unable to close until I closed the app manually'; many say they would have paid had they been allowed to try first — the clearest experiment: delay the first interstitial until the user has completed habits on three separate days",
  "multiple full-screen countdown paywalls in the first minute", "blocked-conversion", "M-upsell-nag 397 (2.00%) mean 2.27; 5 'would have paid' IDs", "dont", "meaningful", "yes",
  ["6044246844","6277521468","8467812056","7160729894","6364577409","8778546806","9018706622","2475980289","3243630686","9232056269","10227478057","8166604351"])
c(53, "§5.5 Post-purchase problems affecting people who did pay table (verbatim)", "must-never-break",
  "Post-purchase problems among payers: charged twice / wrong tier, entitlement revoked or lost after an update, sync doesn't work despite paying, data/streak loss, reminders don't fire, crashes",
  "n/a", "churn", table("## 5.5 Post-purchase problems"), "must-never-break", "segment", "yes", [])
c(54, "§5.5 The entitlement-revocation cluster (M-paid-lost) — the 2017 conversion's permanent scar, and it recurs", "timeline",
  "The entitlement-revocation cluster is the 2017 conversion's permanent scar and it recurs: Aug 2017 one-time purchasers found 'my purchase was worthless as I have been downgraded to the free version'; since then subscriptions silently expire after an update ('I got the year subscription… then it said it needed to be updated. NOW! I have zero days left instead of like 353')",
  "revoked one-time entitlements; subscriptions expiring on update", "1★-burst", "M-paid-lost 84 (0.42%) mean 2.10; 60 in paid segment (3.46%)", "must-never-break", "weak volume, strategic", "yes",
  ["2047285228","1710960363","1711139434","1717245795","2022210088","2086725532","2138643008","3060816879","1742078444","4548741361","4550145452","2632403649","6971182110","3686854032"])

with open("Tools/prd_ledger/13/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
