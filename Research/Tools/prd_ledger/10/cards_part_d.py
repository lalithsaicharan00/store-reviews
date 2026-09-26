import json, re
R = 10
rep = open("App Store Reports/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker (REPORT).md").read().split("\n")
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
c(93, "Part 5 5★ band table (verbatim); 4★ band table (verbatim); 3★ band table (verbatim); 2★ band table (verbatim); 1★ band table (verbatim)", "data-caveat",
  "Per-band theme tables for all five star bands (band denominators)",
  "n/a", "mixed", "5★: " + table("## 5★ — n = 61,550") + " ;; 4★: " + table("## 4★ — n = 4,655") + " ;; 3★: " + table("## 3★ — n = 1,333") + " ;; 2★: " + table("## 2★ — n = 742") + " ;; 1★: " + table("## 1★ — n = 1,761"), "none", "verbatim", "app-specific", [])
c(94, "Part 5 5★ band — 25,648 five-star reviews carry no theme at all; 702 five-star reviews carry a billing, reliability or product-change complaint", "data-caveat",
  "The 5★ band is dominated by four benefit claims; 41.67% of it carries no theme (median 79 chars, 'Love it', 'So cute'); the important nuance is that 702 five-star reviews carry a billing, reliability or product-change complaint — people who love the app and report a defect anyway",
  "n/a", "praise", "5★ n=61,550 (87.88%); P-motivation 10,318 (16.76% of band); P-cute-design 9,409 (15.29%); P-recommend 9,210 (14.96%); P-mental-health 7,870 (12.79%); untagged 25,648 (41.67%); 702 (1.14%) carry a complaint", "none", "band analysis", "app-specific", [])
c(95, "Part 5 5★ band — reviewers pick their star rating to be seen rather than to express satisfaction, in both directions", "data-caveat",
  "A handful of reviewers say outright they picked their star rating to be seen rather than to express satisfaction — in both directions: rating down to get the developers' attention ('I'm only making this one star so you can see it… This app is awesome') and rating up so the review sits near the top ('The worst (i only gave it 5 stars so you could see)') — star rating is a weak proxy for satisfaction in both directions; no finding rests on rating alone",
  "n/a", "mixed", "~11 hand-verified reviews, well below any threshold", "none", "methodological point", "yes",
  ["10174564913","14351670200","10924185515","12428506521","14082597695","12663718459","14483561352","13697877845","14105215358","13343247063","12426654413"])
c(96, "Part 5 4★ band — the 'one thing away' band; The four-star band is where the platform gaps live", "insight",
  "The 4★ band is the highest-signal band for roadmap purposes — praise plus a single named blocker — and it is where the platform gaps live: Apple Health, Apple Watch, dark mode and cross-device sync all peak here relative to global share; these reviewers are telling you the exact price of their fifth star",
  "n/a", "praise", "4★ n=4,655 (6.65%); U-more-pet 174 (3.74% of band); U-overwhelm 142 (3.05%); M-paywall 141 (3.03%); M-price-high 101 (2.17%); D-crash 96; U-boring 94; D-data-loss 78; U-localization 76; U-accessibility 68; U-economy 61; D-widget-bug 40; U-apple-health 38; U-dark-mode 26; U-apple-watch 18; D-sync-devices 12", "build-free", "band analysis", "yes", [])
c(97, "Part 5 3★ band — the value-uncertainty band", "insight",
  "Three stars overwhelmingly means 'I like this and something is broken' — crashes and data loss together are 13.7% of the band; it is not lukewarm users, it is frustrated fans",
  "n/a", "complaint", "3★ n=1,333 (1.90%); D-crash 94 (7.05% of band); D-data-loss 89 (6.68%); U-overwhelm 58 (4.35%); M-paywall 36; M-price-high 36; U-localization 34; P-motivation 123 (9.23%); P-adhd-nd 106 (7.95%)", "must-never-break", "band analysis", "yes", [])
c(98, "Part 5 2★ band — the buyer's-remorse band", "insight",
  "Two-star reviewers are frequently long-term users writing a farewell: they establish that the app worked, then explain what broke it (P-adhd-nd and P-motivation are high in this band)",
  "n/a", "churn", "2★ n=742 (1.06%); D-crash 70 (9.43% of band); D-data-loss 51 (6.87%); U-overwhelm 39 (5.26%); M-trial-no-reminder 29 (3.91%); M-price-high 28; M-paywall 25; P-adhd-nd 61 (8.22%); P-motivation 58 (7.82%)", "must-never-break", "band analysis", "yes", [])
c(99, "Part 5 1★ band — the churn band; Reading the one-star band correctly is the key analytical move; Implication: the one-star population is highly recoverable", "insight",
  "Reading the 1★ band correctly is the key analytical move: a large share of one-star reviews are written by people who explicitly say the app helped them — detractors of a specific transaction or failure, not of the product; the band is ~30% reliability, ~14% billing dispute, ~19% monetization broadly, ~8% values/content, and only a small residue of 'not for me' — so the one-star population is highly recoverable and almost none of it is a product-market-fit problem",
  "n/a", "1★-burst", "1★ n=1,761 (2.51%); D-data-loss 160 (9.09%); D-crash 151 (8.57%); M-trial-charged 99 (5.62%); M-trial-no-reminder 92 (5.22%); P-adhd-nd 92; P-mental-health 86; P-recommend 78; M-refund-denied 71 (4.03%); D-support 71; M-not-free 68 (3.86%); M-price-high 62; D-streak-bug 45; M-paywall 38; C-community-mod 37; C-pronouns 36; M-cancel-hard 36; C-brand-collab 35; C-age-rating 33; D-* union 526 (~30%); billing 244 (~14%); monetization 413 (~19%); values 133 (~8%)", "must-never-break", "band analysis", "yes", [])
c(100, "Part 5 1★ band M-not-free row; §6.3 M-not-free", "monetization",
  "'Advertised free but isn't' / false-advertising claims are a distinct 1★ theme",
  "listed free with trial defaulting to annual", "1★-burst", "M-not-free 126 global, 68 one-star (3.86% of 1★ band); 18 paid (7.2× lift)", "dont", "weak", "yes", [])

# ---- PART 6 ----
c(101, "§6.1 The paid cohort table (verbatim); §6.1 The trend is the finding table (verbatim)", "data-caveat",
  "Paid-cohort metrics and the year-by-year paid-sentiment trend",
  "n/a", "churn", table("## 6.1 The paid cohort") + " ;; " + table("## 6.1 The paid cohort", 1), "none", "verbatim", "app-specific", [])
c(102, "§6.1 The paid cohort — paid mean 3.661, 1★ 23.24%; trial-mention reviews; paid+trial", "monetization",
  "The paid cohort rates 1.1 stars below non-payers, nearly a quarter of it is one-star, and reviews mentioning both a purchase and a trial average 2.19",
  "subscription with trial", "churn", "paid 1,381 (1.97%) mean 3.661; 5★ 763 · 4★ 118 · 3★ 90 · 2★ 89 · 1★ 321 (23.24%); non-paid mean 4.785; trial-mention 588 (0.84%) mean 3.238; paid+trial 178 mean 2.185", "product-rule", "meaningful", "yes", [])
c(103, "§6.1 The trend is the finding; The damage is concentrated on the people paying for the product", "timeline",
  "Paid-cohort satisfaction fell every single year for five years while the whole corpus barely moved; trial-mentioning reviewers track the same way",
  "subscription", "churn", "paid mean 5.00 (2021, n=16) → 4.40 (2022, 275) → 4.01 (2023, 222) → 3.82 (2024, 260) → 3.19 (2025, 357) → 2.96 (2026, 251); 1★ share of paid 0% → 8.7% → 15.3% → 20.8% → 32.8% → 36.7%; corpus mean 4.864 → 4.645; 5★ share 91.70% → 83.15%; trial-mention mean 3.87 → 3.62 → 3.13 → 2.83 → 3.22", "product-rule", "high-priority trend", "yes", [])
c(104, "§6.2 The honest limits of this section — paid cohort biased toward grievance; two reasons the trend survives", "data-caveat",
  "The paid cohort is a text signal biased toward grievance and its absolute mean is not an estimate of subscriber satisfaction; the TREND survives because the bias is constant across years, and because the paid cohort's positive themes hold up — paying users report MORE benefit, not less; their falling rating is a falling opinion of the transaction, not of the product's value",
  "n/a", "mixed", "P-motivation 18.75% of paid vs 15.96% global; P-mental-health 13.90% vs 11.99%; P-tools 12.89% vs 5.35% (2.4× lift); 1.44-star fall 2022→2026", "product-rule", "method", "yes", [])
c(105, "§6.3 What paying customers actually complain about table (verbatim)", "data-caveat",
  "Paid-cohort complaint lifts: 24 themes with paid n, % of paid cohort, global n and lift",
  "n/a", "churn", table("## 6.3 What paying customers"), "none", "verbatim", "app-specific", [])
c(106, "§6.3 The shape of this table is the argument — Paying users are not primarily complaining that Finch costs too much", "insight",
  "The five highest paid-cohort lifts are all billing-mechanics failures, not price and not product: paying users are not primarily complaining that Finch costs too much — they are complaining about how they were charged, and about not being able to undo it",
  "trial/billing mechanics", "churn", "M-refund-denied 47.1×; M-trial-charged 32.7×; M-trial-no-reminder 28.2×; M-unauthorized 23.9×; M-cancel-hard 23.1×; price only 7.8× (6.66% of paid reviews)", "must-never-break", "high-priority", "yes", [])
c(107, "§6.3 The second cluster is a relationship cluster", "insight",
  "The second paid-cohort cluster — support, community moderation, brand collabs, feature removal, UI churn, AI — is a relationship cluster: the sound of a paying base that feels the company has stopped listening",
  "n/a", "churn", "D-support 13.2×; C-brand-collab 8.0×; C-community-mod 7.0×; U-feature-removed-generic 6.6×; U-ui-change 6.5×; C-ai 4.2×", "dont", "segment lifts", "yes", [])
c(108, "§6.3 M-guardian, P-free-generous, U-accessibility, U-apple-health, M-upsell-pressure rows in paid table", "monetization",
  "Payers over-index on the Guardian programme, on praising the free tier, on accessibility and Apple Health requests, and on upsell-pressure complaints",
  "n/a", "mixed", "M-guardian 92 paid (6.66%, 6.6×); P-free-generous 71 (5.14%, 4.2×); U-accessibility 44 (3.19%, 3.7×); U-apple-health 34 (2.46%, 2.8×); M-upsell-pressure 15 (1.09%, 8.5×; global 90)", "research", "segment lifts", "yes", [])
c(109, "§6.4 The trial worked and they wanted to keep it", "monetization",
  "Purchase trigger: the trial worked and they wanted to keep it — 'you start out with the plus version as a free trial and once we lost it we aren't as interested'",
  "7-day Plus trial", "purchase-driver", "4 cited reviews; no conversion rate claimed", "build-paid", "thin evidence", "yes",
  ["11833081713","9807397020","12777430846","14497912306"])
c(110, "§6.4 Cosmetic/colour variety was the specific hook", "monetization",
  "Purchase trigger: cosmetic and colour variety — 'I started getting finch plus solely because I found the extra color options in the seasonal items & larger shop selection very motivating to get my tasks done'",
  "Plus = more colours, larger shop", "purchase-driver", "3 cited reviews", "build-paid", "thin evidence", "yes",
  ["14378349434","14497912306","12783240976"])
c(111, "§6.4 Monthly event completion", "monetization",
  "Purchase trigger: completing the monthly event (paid reward track / micropet)",
  "seasonal pass with paid track", "purchase-driver", "3 cited reviews", "build-paid", "thin evidence", "app-specific",
  ["13929170868","14455889030","13741508287"])
c(112, "§6.4 Support the developers / because it works", "monetization",
  "Purchase trigger: support the developers because it works — 'even though I don't make a lot of money I make it a priority to pay for this app because I know how much joy it brings me'; 'I use this app every day… and I think I'm worth $40'",
  "goodwill conversion", "purchase-driver", "4 cited reviews", "build-paid", "thin evidence", "yes",
  ["11112718539","13005792453","12547227541","8456836129"])
c(113, "§6.4 Gifted or sponsored first; §6.6 The Guardian programme is a strategic asset the corpus rates highly", "tactic",
  "The Guardian sponsored-membership programme is a strategic asset: one of very few monetisation-adjacent themes with a positive mean, functioning as both a conversion path and a goodwill generator, described warmly by both receivers and givers; the friction is that it is hard to APPLY for and opaque about whether sponsorship reached a real person ('they advertise a guardian program to cover people like me but there is no way to apply')",
  "Guardian: pay to sponsor another user's subscription", "purchase-driver", "M-guardian 708 mentions, mean 4.76, 92 with purchase evidence; Guardian programme 449 feature-vocabulary mentions", "do", "meaningful, positive mean", "yes",
  ["13583950351","12963211313","11377452881","12745041087","14491292042","14262792225","9977710032","11401527483","9723946025","12771102574","10246078752","14131024327","14142344100"])
c(114, "§6.4 No conversion rate is claimed and none can be", "data-caveat",
  "Direct purchase-trigger evidence is thinner than complaint evidence; no conversion rate is claimed",
  "n/a", "none", "report gives none", "none", "method", "yes", [])
c(115, "§6.5 Cancellation and refund drivers, in order", "timeline",
  "Cancellation and refund drivers in order from the paid cohort's own text: 1 billing surprise (largest), 2 data loss while subscribed, 3 feature removal (Journeys, mood check-ins, timed goals), 4 sponsored IP events ('I was a paid subscriber for 1.5 years and I just canceled my subscription because of the supergirl theme'), 5 ethics / AI / hiring, 6 support silence, 7 price at renewal (a renewal quote higher than the original)",
  "n/a", "churn", "billing 241 of 1,381; data loss 48 paid; feature removal 8 cited; IP events 8 cited; ethics 7; support 4; renewal price 4", "must-never-break", "ordered by evidence", "yes",
  ["13411041280","12547227541","13475103522","13523723252","14186200268","12705023244","13894921431","12515242428"])
c(116, "§6.5 #7 Price at renewal — renewal quote higher than the original", "monetization",
  "Price at renewal is a distinct, smaller cancellation driver — triggered by a renewal quote higher than the original price",
  "renewal price rises vs intro price", "churn", "4 cited reviews", "dont", "small", "yes",
  ["12515242428","12222994297","12155763925","14300275597"])

with open("Tools/prd_ledger/10/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
