import json, re
R = 16
rep = open("App Store Reports/16. Atoms - from Atomic Habits - The official Atomic Habits app (REPORT).md").read().split("\n")
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
c(44, "§5.1 The confirmed-payer cohort — 17 reviewers table (verbatim); cohort statistics; by period; by storefront", "monetization",
  "The confirmed-payer cohort, line by line: two 5★ brand-trust buyers, one who paid three times ($360) and never got the entitlement, buyers who hit the 6-cap, a £/¥ buyer whose price halved shortly after ('the only benefit I received was three extra months'), a yearly buyer whose week of history was wiped, refund refusals, an auto-renewal with no warning, a cancelled user bricked out of the free tier, a payer whose logging stopped, and a monthly payer expecting 'some content other than the content of the book'",
  "subscription", "churn", "17 (1.46%) mean 2.41; 5★ 3 · 4★ 1 · 3★ 3 · 2★ 3 · 1★ 7 (41.2%); by period 0.44% → 2.76% → 3.16% → 2.41%; US 11, GB 2, DE 1, IN 1, JP 1, MX 1; high-spend 1.80% vs 0.60%; " + table("## 5.1 The confirmed-payer cohort"), "must-never-break", "segment", "yes",
  ["10983459334","11001807368","11015185142","11335015431","11440730982","11846275530","11858415210","11990095414","12102686500","12165173158","12555745003","12859435506","12988241997","13573785597","13573892543","13837724169","14201996700"])
c(45, "§5.2 What made people pay — four triggers, three weak; no 'tried the free tier for weeks then bought' trigger exists", "insight",
  "Only four purchase triggers: brand trust bought sight-unseen (the only trigger producing 5★ — subscribed on day 3); hitting the 1-habit wall — and both such buyers then hit the 6-cap and rated 3★ (buying to escape a cap and finding another cap is the clearest conversion trap); sunk cost after the trial ('I had gotten so invested… it felt like a let down'); a price drop (exactly one upgraded rating); there is no trigger in the shape 'I tried the free tier for weeks and then decided to buy' — a 1-habit tier cannot produce it",
  "brand trust; cap escape; sunk cost", "purchase-driver", "17 payers; 2 brand 5★; 2 cap-escape 3★; 1 price-drop", "product-rule", "segment", "yes",
  ["10983459334","11858415210","13573785597","11335015431","12482534390","13616010098","11980741663"])
c(46, "§5.3 Barrier 1 — the annual price at every price point; stated willingness-to-pay table (verbatim); the modal counter-offer is a one-time purchase between $10 and $30", "monetization",
  "Reviewers' own reservation prices cluster far below every price Atoms has charged: $8–$30 one-time, $2–$5 a month, $15–$60 a year — the modal counter-offer is a one-time purchase between $10 and $30, which Atoms has never offered",
  "$40–120/yr subscription", "blocked-conversion", table("## 5.3 What stopped people from paying"), "build-paid", "very strong", "yes",
  ["10989617169","11089032952","12600470632","13613868361","12073746265","12119950937","10985973020","11090921707","11112458066","11749997696","10993506021","11054245890","11260133910","11494012970","11369268665","12377474964","13395934202","11000421781","11108307273"])
c(47, "§5.3 Barrier 2 — subscription aversion as a category position: a habit app specifically should not be a subscription because it has no ongoing cost", "insight",
  "Subscription aversion is a category position, not generic grumbling: reviewers argue a habit app specifically should not be a subscription because it has no running cost — 'Subscriptions make sense if there is running cost associated with an application but this isn't the case here'; 'the app is built once and from then only needs basic maintenance'; 'The irony in that the book encourages you to cancel subscriptions yet pushes its own'",
  "subscription", "complaint", "136 (11.64%) mean 2.32", "product-rule", "high-priority", "yes",
  ["13182902229","11685719155","11667634559"])
c(48, "§5.3 Barrier 5 — regional pricing; Barrier 6 — a willing buyer could not complete the purchase (UPI); Barrier 7 — no book-buyer recognition", "market",
  "Regional pricing objections are the most detailed in the corpus — a Peruvian reviewer computes that 69.90 PEN is 6.82% of the minimum wage and the PPP-adjusted price should be ~16.42 PEN; an Indian reviewer tried 30–40 times to subscribe via UPI and could not (a lost sale from someone who wanted to pay); book buyers expected recognition",
  "single global price; UPI payments fail", "blocked-conversion", "regional 11 (0.94%); UPI n=1 [limited evidence]; book-buyer 18 (1.54%)", "do", "emerging", "yes",
  ["11001435276","10983856203","10996090984","12513582477","13456206729","11390526677","11261255351"])
c(49, "§5.4 Post-purchase experience and churn table (verbatim); support is the aggravating factor in all of them; when support arrives the review is edited upward", "must-never-break",
  "At least 7 of 17 payers describe a broken post-purchase experience — entitlement not applied, charged unexpectedly / refund refused, data wiped while subscribed, locked out of the free tier after cancelling, price halved shortly after paying full; support is the aggravating factor in all of them, and the one counter-case is instructive: 'Update - Many thanks to dev team for reaching out!' — when support arrives, the review is edited upward; stated churn names Streaks, Apple Reminders or paper",
  "post-purchase failures; support unreachable", "churn", "7 of 17 (41.2% segment; 0.60% corpus); " + table("## 5.4 Post-purchase experience") + " ; support unreachable 7 (0.60%) mean 2.14; churn 55 (4.71%) mean 2.00, 10 name the alternative", "must-have", "segment", "yes",
  ["11015185142","11990095414","12165173158","12988241997","11858415210","13837724169","13573892543","11846275530","11011057187"])
c(50, "§5.5 The people who think it is free — every one is a 5★ that has not yet met the paywall", "data-caveat",
  "Ten reviews praise Atoms for being free ('I can't believe all of it's been free? … a gift from James to his worldwide community'); nine are dated 2025–26 — users still inside the 28-day trial; every one is a 5★ that has not yet met the paywall, the clearest measure of how much rating value the trial generates before it is spent",
  "28-day trial", "praise", "10 (0.86%) mean 4.80, 90% 5★; 9 dated 2025–26", "none", "emerging", "app-specific",
  ["13019922003","14186561740","12858987458"])

with open("Tools/prd_ledger/16/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
