import json, re
R = 9
rep = open("App Store Reports/9. Dear Me - Daily Routine Tracker - Self Care & ADHD Habit Planner (REPORT).md").read().split("\n")
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


# ---- PART 3 — RATINGS ----
c(72, "Part 3 5★ — n = 658 (51.37% of corpus) table (verbatim); Caution", "data-caveat",
  "The 5★ band is partly a rating-prompt artefact: 318 of 658 (48.3%) carry no theme; 'great, but I wish it were free' is a 5★ sentence (31); 25 happy subscribers exist; but 11 five-stars are refund requests and 9 are outright mismatches",
  "n/a", "5★-burst", table("## 5★ — n = 658") + " ; 17 of 658 (2.6%) refund requests or mismatches", "none", "verbatim", "app-specific", [])
c(73, "Part 3 5★ Representative 5★ with substance", "insight",
  "Five-stars with substance are about organisation and change — a chronic procrastinator 100 days in; 'my life CHANGED'; 'the first time in my life I paid for an app. It deserves every bit'",
  "n/a", "5★-burst", "P-org 100 (15.2% of 5★); P-outcome 94 (14.3%)", "none", "observed", "yes",
  ["12024330293","12221935483","14309372488","13571506850","12244252131","13270893215"])
c(74, "Part 3 4★ — n = 96 (7.49%) — the 'one thing away' band table (verbatim)", "insight",
  "The 4★ band is where paying customers write feature specs — an annual subscriber's four numbered improvements calling the price fair; German 5- and 8-point lists ('then 5 stars would be more than deserved'); these are the reviews to build from",
  "n/a", "mixed", table("## 4★ — n = 96") + " ; 17.7% of 4★ paid", "do", "verbatim", "app-specific",
  ["13005854395","12464161947","12699837651","11646116789"])
c(75, "Part 3 3★ — n = 103 (8.04%) — value-uncertainty band table (verbatim)", "insight",
  "3★ is 'I can't tell if this is worth it': 'what's the difference between the subscription and the free version? It isn't explained at all'; 'With all the interruptions of purchasing a subscription, discovering the app is very difficult'; stars docked for the pre-use rating prompt and the missing trial",
  "n/a", "complaint", table("## 3★ — n = 103"), "none", "verbatim", "app-specific",
  ["12399224524","12127963469","13175470414"])
c(76, "Part 3 2★ — n = 88 (6.87%) — the buyer's-remorse band table (verbatim)", "insight",
  "2★ is buyer's remorse — more than a third paid: 'nothing more than a to do list… I expected all the tools (journal and other trackers)'; 'after the purchase I realised it only has the function of marking whether you did the task'",
  "n/a", "churn", table("## 2★ — n = 88"), "none", "verbatim", "app-specific",
  ["12209118679","11552361877"])
c(77, "Part 3 1★ — n = 336 (26.23%) — a quarter of the corpus theme and primary-cause tables (verbatim)", "data-caveat",
  "1★ themes and primary causes: money refund/cancel/overcharge ~36%, paywall/no trial/price/upsell ~28%, thin product ~22%, defects ~21%, funnel ~12% (non-exclusive)",
  "n/a", "1★-burst", table("## 1★ — n = 336", 0) + " || " + table("## 1★ — n = 336", 1), "none", "verbatim", "app-specific", [])
c(78, "Part 3 1★ 41.1% of one-star reviewers paid money", "insight",
  "The one-star band is not people who wouldn't pay — 41.1% of one-star reviewers paid and then could not get the product, the value, or their money back; only 5 of 336 carry no theme",
  "n/a", "1★-burst", "PAID 138 of 336 (41.1%); 5 of 336 unclassified", "must-never-break", "observed", "yes", [])

# ---- PART 4 — PAID USERS ----
c(79, "§4.1 The paid cohort table (verbatim)", "must-never-break",
  "Paying customers are the angriest users: they rate the app 1.57 stars below the corpus and 61% give one star — negatively selected (satisfied subscribers rarely write), so not a satisfaction rate, but the composition of their complaints is diagnostic and it is not about price",
  "226 explicit payers", "1★-burst", table("## 4.1 The paid cohort") + " ; 226 (17.64%) is a floor", "must-never-break", "segment rate", "yes", [])
c(80, "§4.2 What paying customers actually complain about table (verbatim)", "data-caveat",
  "Paid-cohort complaint themes (segment rates, denominator 226): refund 43.8%, regret 22.1%, thin 20.8%, cancel 13.7%, loading 12.4%, support 9.3%, price 8.4%",
  "n/a", "1★-burst", table("## 4.2 What paying"), "none", "verbatim", "app-specific", [])
c(81, "§4.2 Price objections come from non-buyers; buyers complain about value, delivery and refunds", "insight",
  "Price objections come from non-buyers; buyers complain about value, delivery and refunds — and Russian subscribers pay and then cannot use the product, asking for a refund in the same sentence",
  "n/a", "complaint", "M-price 19 of 123 paid (8.4%); 97 of 102 refund, 50 of 50 regret, 31 of 34 cancel, 15 of 17 guarantee, 10 of 10 trial-trap from paid; B-load 28 of 66 paid (12.4%)", "product-rule", "segment rates", "yes",
  ["13511607324","13523804710","13527113749","13588434539","14134826933","14137219709","13129532846","13734613349"])
c(82, "§4.5 mechanic 4 — M-payfail: money left the account but Plus never activated", "must-never-break",
  "Money left the account but Plus never activated",
  "purchase not entitled", "1★-burst", "M-payfail 16 (1.25%, MEANINGFUL), mean 1.81; 12 of 16 paid; RU 6", "must-never-break", "meaningful", "yes",
  ["11687224311","12442228880","12650182347","12791514383","12609778626","13711157656"])
c(83, "§0.2 M-scam; §5.4 CL", "insight",
  "Explicit fraud / theft accusations are the lowest-rated money theme — Chile has the highest scam-accusation rate per review",
  "hard paywall + refund friction", "1★-burst", "M-scam 30 (2.34%, MEANINGFUL), mean 1.20; 15 paid; CL 3 of 24", "none", "meaningful", "yes",
  ["11825830145"])
c(84, "§0.2 M-regret; §4.2", "insight",
  "Paid, then regretted it — every regret statement comes from a buyer",
  "pre-experience purchase", "churn", "M-regret 50 (3.90%, VERY STRONG), mean 1.56; 50 of 50 paid (22.1% of paid cohort); 2★ band 12 (13.6%)", "none", "very strong", "yes", [])
c(85, "§4.3 What triggers a purchase — stated by buyers themselves", "insight",
  "Four of five purchase triggers are pre-experience — a social/video ad promising a capability, the end-of-quiz 'your plan is ready, you only need to pay $700 pesos', the −50% newcomer timer, the onboarding breathing demo — and the only post-experience trigger, genuine early delight ('paid for a year within the first minute'; 'the first app I ever wanted to pay for'), is the rarest; the funnel converts before the product can prove itself, so the product must be retroactively good enough to justify a purchase already made",
  "funnel engineered to convert pre-use", "purchase-driver", "5 trigger patterns; triggers 1–4 pre-experience", "product-rule", "structural reading", "yes",
  ["12633273226","11789743896","12755295856","11718643683","14134826933","12286738501","11472460295","12966178467","12645661722","11805353050","14309372488","12769176601"])
c(86, "§4.4 What buyers say they got — the value gap table (verbatim)", "insight",
  "The value gap in buyers' own words: a coach vs a self-filled checklist, guided exercises vs one onboarding animation, a personalised plan vs generic presets, journal vs a paywalled text box, much more than free vs 'not much' — 'I'm a paying user. But I genuinely don't know what extra it gives me… it's full of extremely superficial plans'",
  "n/a", "churn", table("## 4.4 What buyers"), "none", "verbatim", "app-specific",
  ["11860805909","12052410758","11672639638","12971647904","11698858385","12206654248","12587805273","12400544803","12164091003","13632737127"])
c(87, "§4.5 Refund and churn mechanics — four failure modes; Part 7 §7.1 #3", "must-have",
  "Four refund/churn failure modes, all documented: the guarantee was not executed; the in-app refund path is a dead end; cancelling stops renewal but does not refund and users don't understand it; billing errors — and support is the amplifier; build a real in-app support and refund path to convert ~100 public refund complaints into private tickets",
  "email support; dead-end refund UI", "1★-burst", "21 of 25 X-support are payers; ~100 public refund complaints", "must-have", "high-priority", "yes",
  ["11567513705","13065540266","12571528769"])
c(88, "§4.5 Counter-evidence worth noting — P-support", "tactic",
  "Tactic: developer replies to reviews fix individual problems. Outcome: a Turkish user who lost their subscription edited the review after the developer's response — 'Following your reply I reopened the app… my subscription is usable again, thanks'; others were refunded or helped",
  "replies to some reviews", "praise", "P-support 4; 11 reviews marked is_edited", "do", "weak", "yes",
  ["12745580868","12827787443","13534159613","13622846328"])
c(89, "§4.6 The honest limits of this section", "data-caveat",
  "Limits: review text yields no conversion, renewal, churn or refund rate; the paid cohort is negatively selected and its 25 five-star payers under-represented; PAID is a floor",
  "n/a", "none", "226 paid (floor); 25 paid 5★", "none", "method", "yes", [])

with open("Tools/prd_ledger/9/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
