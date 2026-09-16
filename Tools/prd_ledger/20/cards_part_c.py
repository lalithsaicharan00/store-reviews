import json, re
R = 20
rep = open("App Store Reports/20. Habit — Daily Tracker - Crush your goals like a boss (REPORT).md").read().split("\n")
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
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").replace("`","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 4 ----
c(52, "§4.1 The distribution is bimodal, and the middle is nearly empty", "data-caveat",
  "5★ 41.35% · 4★ 9.93% · 3★ 6.45% · 2★ 6.25% · 1★ 36.02% — 77.4% at one extreme or the other; the signature of a product that was excellent and then did something to its users, not of quality variance", "n/a", "mixed", "77.4% at extremes", "none", "rating band", "app-specific", [])
c(53, "§4.2 5★ — n = 1,674 (41.35%); 93% predate the conversion; 23 are amended reviews after restoration", "insight",
  "5★ is earned by minimalism (773 = 46.2% of band), design (346 = 20.7%), outcomes (52), unlimited-free (51), ad-free (46); 93% of 5★ predate the conversion — a photograph of E1; 26 say the review prompt is why they wrote; 23 five-star reviews carry revoked-purchase — amended reviews by users restored in Feb 2021 who came back and raised their score",
  "n/a", "praise", "1,674 (41.35%); 93% pre-conversion; 23 amended upward", "do", "rating band", "yes",
  ["6979960168","6997900077","7003059038","7004585831","7010504987","7024664717","7037625817","7040631651"])
c(54, "§4.3 4★ — the 'one thing away' band; almost none of those things were ever built", "insight",
  "4★ is defined by a single named blocker — streaks (22 = 5.5%), notes (20), multi-per-day (20), broken widget (18), categories (16), iPad (15), sync (15), Apple Watch (15); the most commercially useful band: people who liked it enough to rate it well and said exactly what would make it a 5, and almost none of it was ever built",
  "n/a", "mixed", "402 (9.93%)", "none", "rating band", "yes", [])
c(55, "§4.4 3★ — the ambivalence band: 'Both the Best and Most Annoying App I've Ever Used'", "insight",
  "3★ carries praise and grievance in the same review — minimalism 43 / subscription 41 / design 28 / pop-ups 26 / revocation 26 / widget 22; the archetype: 'Both the Best and Most Annoying App I've Ever Used'", "n/a", "mixed", "261 (6.45%)", "none", "rating band", "yes", ["7041165859"])
c(56, "§4.5 2★ — the buyer's-remorse band; broken widget peaks here", "insight",
  "2★: subscription 64 (25.3%) / pop-ups 41 / revocation 34 / broken widget 33 (13.0% — the band's peak) / price 28; design and minimalism still appear (28, 32) — people who still like the app rating it down on commercial conduct alone", "n/a", "churn", "253 (6.25%); widget 13.0% of band", "none", "rating band", "yes", [])
c(57, "§4.6 1★ — the breach band (verbatim table); the seventh row is the finding", "insight",
  "1★ (1,458): subscription 636 (43.6%), revoked 515 (35.3%), one-time model 200, data loss 183 (12.6%), price 181, pop-ups 134, P-simple 131 (9.0%), support silent 124, cancel/refund 106, widget 99, restore fail 70; 131 one-star reviews praise the product's simplicity in the same breath as condemning the company — 'I thought I found the holy grail for habits: simple, beautiful… Now the app has gone with a subscription model, effectively leaving all the previous Premium users with nothing'",
  "n/a", "1★-burst", table("## 4.6 1★"), "product-rule", "rating band", "yes", ["6927013041"])
c(58, "§4.7 Support conduct is a rating multiplier — worth roughly +2.3 stars on every recoverable incident", "insight",
  "Among 148 support-silence reviews the mean is 1.33; among the 30 Feb–Dec 2021 reviews that record being restored or fixed the mean is 3.63 (10 5★, 11 4★) — the same defect produces 1.33 or 3.63 depending entirely on whether anyone answered; a support function would have been worth roughly +2.3 stars on every recoverable incident",
  "n/a", "mixed", "1.33 (n=148) vs 3.63 (n=30): +2.3 stars", "must-have", "very strong", "yes", [])

# ---- PART 5 ----
c(59, "§5.1 The evidence base, stated honestly (verbatim table) — payers rated 2.06 stars lower", "monetization",
  "908 reviews (22.43%) with payment evidence average 1.55 vs 3.61 for the 3,140 without — paying customers rated the product 2.06 stars lower than non-payers; in a healthy product the relationship is inverted; here paying was the thing that exposed you to harm; a floor, not a conversion rate",
  "n/a", "1★-burst", table("## 5.1 The evidence base"), "must-never-break", "high-priority cohort", "yes", [])
c(60, "§5.2 #1 The widget — the most-named purchase trigger and the feature that most often didn't work", "insight",
  "The widget is by a wide margin the single most-named purchase trigger and the feature that most often didn't work — the corpus's central commercial irony", "sold on the widget; widget broken", "purchase-driver", "7 named trigger IDs; 113 payer widget complaints", "must-never-break", "close reading", "yes",
  ["6866660903","6898884130","6932683997","7516808714","9525119894","12141943563","12240298551"])
c(61, "§5.2 #2 Support/gratitude, not utility — pre-2021 purchases were donations", "insight",
  "A large share of pre-2021 purchases were donations — 'I'll definitely choose the highest one because this developer deserves the best'; 'I bought the paid function not because I needed it, but as a thank you'", "goodwill conversion", "purchase-driver", "6 named IDs; 35 praise the model at 4.83", "do", "close reading", "yes",
  ["4772030419","4910351390","4905355436","5537329915","6667551973","6798059205"])
c(62, "§5.2 #3–5 Dark mode, unlimited habits (under duress), backup/iCloud as purchase triggers", "insight",
  "Other named triggers: dark mode; unlimited habits post-2021 under duress; backup/iCloud", "n/a", "purchase-driver", "4 + 2 + 3 named IDs", "build-paid", "close reading", "yes",
  ["6921346177","6938362371","6975061472","9354551485","6940257847","7266229179","6924711463","6926653399","7104682610"])
c(63, "§5.2 #6 The pricing model itself — people bought because it wasn't a subscription", "insight",
  "'I bought your app precisely because it wasn't a subscription' — the pricing model itself was the purchase reason, which is why the conversion felt like betrayal rather than a price change", "one-time model as purchase reason", "purchase-driver", "n=1 explicit + 35 model-praise", "product-rule", "close reading", "yes", ["6927136939"])
c(64, "§5.3 What paid users complain about (verbatim table) — the paid experience was materially worse", "must-never-break",
  "Among 908 payers: revoked purchase 52.0%, subscription model 50.7%, one-time model 18.6%, widget broken 12.4%, price 12.1%, support silent 10.7%, data loss 10.0%, cancel/refund 8.7%, restore fail 7.6%, dark mode 4.3%; 76.8% of all revocation complaints, 62.1% of widget complaints, 75.8% of restore failures and 65.5% of support complaints come from the ~22% who paid",
  "n/a", "1★-burst", table("## 5.3 What paid users complain about"), "must-never-break", "payer cohort", "yes", [])
c(65, "§5.4 Upgrade barriers — why people who liked it didn't buy", "monetization",
  "Barriers: price/model mismatch — 'I will NEVER EVER PAY A SUBSCRIPTION FOR THIS APP… If you were to make it a paid app, I would definitely purchase it'; value not demonstrated before the ask — 'first the consumer must see the value of the product. And what do you have? Every 2 seconds a subscribe banner'; reviews as deterrent — people read the reviews and did not install; feature-parity failure by 2022+ — 'a glorified reminder tool… overpriced and under delivers massively'",
  "subscription-only; upsell before value; no parity", "blocked-conversion", "4 + 4 + 5 + 1 named IDs", "product-rule", "close reading", "yes",
  ["8537740813","7470777218","9459852981","10684402507","7410157966","7181761042","8260890448","12025762934","7411209420","7874758944","8321275133","9909767891","12176789557","12233815050"])
c(66, "§5.4 Reviews as deterrent — people read the reviews and did not install", "insight",
  "Five reviewers report reading the reviews and deciding not to install — the review record itself became an acquisition barrier", "n/a", "blocked-conversion", "5 named IDs", "none", "close reading", "yes",
  ["7411209420","7874758944","8321275133","9909767891","12176789557"])
c(67, "§5.5 Refund, cancellation and post-purchase problems — three failure modes", "must-never-break",
  "125 reviews (3.09%, mean 1.28): refund requested and ignored (Feb 2021; several report Apple refunding where the developer would not); cannot cancel (2022–2025; one alleges the path breaks FTC transparency expectations); charged without intent — trial-to-paid surprises and accidental Touch-ID purchases during onboarding",
  "refund ignored; cannot cancel; accidental charges", "1★-burst", "125 (3.09%, very strong, mean 1.28)", "must-never-break", "very strong", "yes",
  ["6943651180","6955346810","7039272649","6937584026","9371176438","9511675705","9568655119","9583675777","10751290760","12425016323","9037646067","7199706726","7712053776","7744703720","8883167931","12463560595"])
c(68, "§5.5 The Feb 2021 remediation, and why it was insufficient", "timeline",
  "From ~5 Feb 2021 the developer began responding (a form reply signed 'Marlene') and by ~15–17 Feb an update (1.14.1) made Restore Purchases work; 30 reviews record restoration, many revised upward — but (a) it took three weeks of daily 1★ inflow; (b) the initial remedy was one free year, not permanent restoration, rejected as inadequate ('either update my purchases as originally agreed upon or refund what I paid'); (c) it was never announced ('4 stars after premium was restored, but not 5 because the devs ignored us for so long and have not acknowledged the issue'); (d) it did not hold — revocation reports recur Apr 2021, May 2022, Oct 2023, Sep 2024, Mar 2025, Aug 2025, Jan 2026",
  "late, partial, unannounced, non-durable remediation", "mixed", "30 restored (mean 3.63); recurrences across 7 dates 2021–2026", "product-rule", "very strong", "yes",
  ["6958039907","6972336692","6969229255","7026534551","7176715543","8632062766","10531496818","11696455228","12421451179","12999175131","13669398619"])

with open("Tools/prd_ledger/20/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
