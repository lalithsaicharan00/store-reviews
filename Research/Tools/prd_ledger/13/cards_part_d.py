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

# ---- PART 4 ----
c(38, "§4.1 5★ table (verbatim); §4.2 4★ table (verbatim); §4.3 3★ table (verbatim); §4.4 2★ table (verbatim); §4.5 1★ table (verbatim)", "data-caveat",
  "Per-band theme tables for all five star bands",
  "n/a", "mixed", "5★: " + table("## 4.1 5★") + " ;; 4★: " + table("## 4.2 4★") + " ;; 3★: " + table("## 4.3 3★") + " ;; 2★: " + table("## 4.4 2★") + " ;; 1★: " + table("## 4.5 1★"), "none", "verbatim", "app-specific", [])
c(39, "§4.1 'Do X, get 5 stars': ship a reminder that fires, a list that is quick to tick, and a visible streak", "insight",
  "'Do X, get 5 stars': ship a reminder that fires, a list that is quick to tick, and a visible streak — that is the whole formula; 39.93% of five-star reviewers describe utility, only 8.84% mention design",
  "reminder + checklist + streak", "praise", "5★ n=9,571 (48.22%); P-utility 39.93% of 5★; P-design 8.84%", "must-have", "band analysis", "yes", [])
c(40, "§4.1 837 five-star reviews still complain about price or the subscription model", "monetization",
  "837 five-star reviews (8.75% of 5★) still complain about price or the subscription model — people who love the product telling you the pricing is wrong anyway: '100% recommendable. The only mistake I find is the monthly, quarterly or annual payment. It would be better to charge only once. It would attract more users, trust me' (20 votes); a Turkish 5★ titled 'Very expensive'",
  "subscription", "complaint", "837 of 9,571 5★ (8.75%); M-price-high 456 + M-sub-objection 428 in 5★", "product-rule", "band analysis", "yes",
  ["2054778874","1809268653","11178911368"])
c(41, "§4.2 The 4★ band is the product backlog", "insight",
  "The 4★ band is the product backlog: feature requests are 3.6× concentrated here vs 5★; the most frequent named items — notes on habits, flexible frequency, sync, widget, reordering that sticks, a higher free cap",
  "n/a", "praise", "4★ n=2,431; G-feature-request 12.75% of 4★ vs 3.52% of 5★; D-sync 3.58%; D-widget 2.55%; M-free-limit 5.47%", "build-free", "band analysis", "yes", [])
c(42, "§4.3 3★ is where reliability surfaces — engaged multi-device users, the highest-value population to fix things for", "insight",
  "3★ is where reliability surfaces: sync runs 3.6× its global rate and iPad 4.0× — engaged multi-device users who paid attention long enough to find the sync bug, the highest-value population to fix things for and the most under-served",
  "sync and iPad broken", "complaint", "3★ n=1,505; D-sync 8.90%; D-ipad 5.58%; D-crash 3.26%", "must-never-break", "band analysis", "yes", [])
c(43, "§4.4 2★ is 'beautiful, but I can't get in'", "insight",
  "2★ is 'beautiful, but I can't get in': the free-limit theme peaks here — the characteristic review praises the interface then says the free tier is too small to evaluate",
  "3–5 habit free cap", "blocked-conversion", "2★ n=1,230; M-free-limit 12.36% (2.9× global); 28.05% contain praise", "product-rule", "band analysis", "yes", [])
c(44, "§4.5 The 1★ population has four causes, in order; 551 one-star reviews still contain praise language; protest votes about commerce from satisfied users", "insight",
  "The 1★ population has four causes in order — money taken without perceived consent, the subscription model itself, price level, can't use it without paying — and 551 one-star reviews still contain praise ('this app is truly remarkable… I feel like I'm ripping you off for only $3.99… sorry for the one star'; a recovering addict describing a month clean): a large share are protest votes about commerce from satisfied users, the most reversible kind of 1★ there is",
  "n/a", "1★-burst", "1★ n=5,113 (25.76%); M-trial-autocharge 999 (19.54%); M-sub-objection 973 (19.03%); M-pay-required 950 (18.58%); M-price-high 897 (17.54%); M-refund 427 (8.35%); M-cancel-hard 345 (6.75%); praise in 1★ 551 (10.78%); P-utility 494 (9.66%)", "product-rule", "band analysis", "yes",
  ["1417054726","3044712205"])
c(45, "§4.6 Themes that cut across the rating line table (verbatim)", "contradiction",
  "Themes on both sides of the rating line: price and subscription objections from fans who keep using it; stats praised when present and resented when gated; icons loved by most and called 'childish' by some; the Skip function genuinely praised but too rigid for others; the Watch app beloved when working and dead for long stretches; Challenges enjoyed by some, 'please let me hide it' from others",
  "n/a", "mixed", table("## 4.6 Themes that cut across"), "none", "verbatim", "yes",
  ["1233009943","5395232140","2873841903","2957074134","9948539388"])
c(46, "§4.7 Support conduct is a rating multiplier", "dont",
  "Support conduct is a rating multiplier: a copy-paste reply that restates Apple's cancellation instructions without addressing the complaint, sometimes posted publicly under the review — multiple reviewers edited their reviews DOWNWARD afterwards ('If you're just going to copy-paste an answer again, don't leave one at all'; 'our team won't be able to prioritize the specific issue you encountered'); a cheap, high-leverage fix fully under the company's control",
  "public canned replies", "1★-burst", "D-support 57 mean 1.35; C-canned-reply 20 mean 1.40, zero 5★", "dont", "weak volume, maximal damage", "yes",
  ["3369796254","2982642975","3366758790","10784706921","1858671482","3320840012","4458988543","5188692960","5747695972","5932232366","6554315923","8281301323","11089158134","11437814220"])

with open("Tools/prd_ledger/13/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
