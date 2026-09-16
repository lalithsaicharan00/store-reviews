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

c(1, "header lines 1-8; §9.5 External sources", "positioning",
  "Habit — Daily Tracker (App Store ID 1445651730) — 'Crush your goals like a boss' — a once-beloved free unlimited habit tracker converted on 27 Jan 2021 into a subscription app that revoked prior purchases; the most complete natural experiment in the category on what happens when you take back what you sold",
  "developer of record Kodeon, Inc.; bundle com.habit.habytracker.iosappplication; extracted 8 Sep 2026; store rank 20", "mixed",
  "4,048 reviews · 82 storefronts · 27 Dec 2018 → 8 Aug 2026; mean 3.144; 5★ 1,674 / 4★ 402 / 3★ 261 / 2★ 253 / 1★ 1,458", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Five things to know; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §9.1 counting rules; §9.3 validation approach", "data-caveat",
  "Method: this corpus is two products — a beloved free tracker (Dec 2018–26 Jan 2021, mean 4.56, n=2,066) and a monetised subscription app (27 Jan 2021 onward, mean 1.62, n=1,982); the global mean 3.14 is an artefact of that split — almost nobody experienced a '3-star' product; always read era-relative rates; volume is event-driven — 61.5% (2,491) falls in the Jan–Feb 2021 conversion and Mar 2025 data-wipe windows, so review volume measures anger events not usage; 917 reviews (22.65%) carry no theme (short pure sentiment, mean 3.80); all 4,048 read in 22 batches in original language; 49-theme multilingual regex classifier validated by sampling with three false-positive classes fixed (negated praise; discount % alone; praise-vs-grievance collision on 'one-time purchase'/'unlimited habits'); low-volume themes are floors; _paid is a text-evidence flag (908, 22.43%) not ground truth; no version field; storefront ≠ nationality ≠ language; survivorship in the tail; signal bands <0.1 ignore … >5% high-priority",
  "n/a", "none", "4,048/4,048; 82 storefronts; 92 months; 0 duplicates; is_edited 51 (1.26%, mean 2.84)", "none", "method", "yes", [])
c(3, "Five things to know #4 — The 2019 volume is partly manufactured ('let the developers be sad')", "data-caveat",
  "The app shipped a review prompt whose decline button read 'let the developers be sad'; 26 reviews (0.64%) explicitly say the prompt is why they wrote; the true rate is certainly higher — this inflates 2019's 5★ count and is a disclosed selection bias",
  "guilt-worded review prompt", "5★-burst", "26 (0.64%) explicit; 2019 n=1,332 mean 4.75", "dont", "disclosed bias", "yes", [])
c(4, "Executive summary #1 — A single product decision destroyed this app, and the corpus dates it to the day", "timeline",
  "On 27 Jan 2021 the developer converted a 'pay once, yours forever' IAP into an annual subscription, revoked the entitlements of everyone who had already paid, and capped the previously-unlimited free tier at 3 habits; daily review volume went 2 (26 Jan) → 61 (27 Jan) → 135 (28 Jan) with mean 1.15–1.36; the app went from a 4.56-mean darling to a 1.62-mean cautionary tale in one release and never recovered in five years",
  "revoked lifetime purchases + capped free tier in one release", "1★-burst", "615 reviews (15.19%, high-priority) describe losing a purchase already made; daily volume 2 → 61 → 135; day means 1.15–1.36", "product-rule", "high-priority", "yes", [])
c(5, "Executive summary #2 — The thing they broke was the only thing that differentiated them", "insight",
  "Pre-conversion the app's entire market position was 'the one habit tracker that gives you unlimited habits for free, with no subscription' — said unprompted by 5★ reviewers for two years; capping the free tier at 3 habits deleted the product's reason to exist",
  "differentiator was unlimited free habits", "churn", "63 reviews (1.56%) say exactly this; 99 (2.45%) complain about the 3-habit cap specifically", "product-rule", "meaningful", "yes", [])
c(6, "Executive summary #3 — The App Store listing still advertised the removed feature — for years", "anti-pattern",
  "Reviews from Jan 2021 through Sep 2023 quote the live listing verbatim — 'Unlimited amount of habits. You don't need to pay a penny' — after the feature was removed; the cheapest fix in the report went unmade for over two years",
  "listing advertised a removed free feature for 2.5+ years", "1★-burst", "24 reviews (0.59%, emerging) call it false advertising by name; Jan 2021 → Sep 2023", "dont", "emerging", "yes", [])
c(7, "Executive summary #4 — The paid tier never delivered its headline feature (the widget)", "must-never-break",
  "The widget — the single most-cited reason people upgraded — did not work; still reported broken in 2025, five years after first report, with an in-app FAQ acknowledging it and offering 'restart your phone' as the fix",
  "paid headline feature broken for 5 years", "1★-burst", "182 reviews (4.50%, very strong) broken/absent widget; 113 of those (12.4% of all payers) from confirmed payers", "must-never-break", "very strong", "yes", [])
c(8, "Executive summary #5 — Support does not exist", "must-have",
  "Support does not exist — the in-app 'Contact Us' link pointed at a dead email address for years and the Instagram account stopped posting; this converts every recoverable bug into a permanent 1★",
  "dead support address", "1★-burst", "148 reviews (3.66%, very strong); payer segment rate 10.7%", "must-have", "very strong", "yes", [])
c(9, "Executive summary #6 — In March 2025 they wiped everyone's data", "must-never-break",
  "Version 1.41.0/1.42.x (13–15 Mar 2025) erased multi-year habit histories globally — users lost 2, 3, 4 and 5 years of tracking; the claimed fix (1.42.1) did not work for many; backup-to-iCloud was itself paywalled",
  "global data wipe on update; backup paywalled", "1★-burst", "233 reviews (5.76%, high-priority) data loss; 126 (78.3% of that window) in the 7 weeks after 13 Mar 2025", "must-never-break", "high-priority", "yes", [])
c(10, "Executive summary #7 — An active billing-integrity problem, still live in 2026", "must-never-break",
  "The app advertises a discounted subscription (e.g. $5.99, 499₽, 85% off) and then charges the full price ($39.99, 3,150₽); reports run Dec 2021 → Apr 2025 across gb/us/ru/de/ua/kz/ca/lt — below threshold on volume, a consumer-protection exposure not a UX nitpick",
  "discount shown, full price charged", "1★-burst", "28 reviews (0.69%, emerging by volume — severe by nature); 8 storefronts; Dec 2021–Apr 2025", "must-never-break", "emerging / severe", "yes", [])
c(11, "Executive summary #8 — The product that people loved is fully documented and still buildable", "insight",
  "Strip out the monetisation story and the corpus is an unusually clean specification for a habit tracker people were delighted by: minimal (27.45%), beautiful (13.27%), unlimited, ad-free, and — the genuine differentiator — a non-streak 'habit strength' percentage that decays instead of resetting (0.94% explicit praise, the highest-affection language in the corpus); that decay model was itself broken by the 2021 rewrite and never restored",
  "minimal, beautiful, unlimited, ad-free, decaying strength %", "praise", "minimal 27.45%; beautiful 13.27%; strength-decay praise 0.94%", "must-have", "high-priority", "yes", [])

# ---- PART 1 ----
c(12, "§1.6 Corpus composition — By year (verbatim table)", "timeline",
  "By year: 2018 1 (5.00); 2019 1,332 (4.75, growth + review-prompt era); 2020 680 (4.24, iOS 14 widget promised); 2021 1,475 (1.68, conversion year); 2022 147 (2.05); 2023 121 (1.94); 2024 85 (2.07); 2025 195 (1.44, data-wipe year); 2026 12 (2.58, to 8 Aug)",
  "n/a", "mixed", table("**By year**"), "none", "corpus-level fact", "app-specific", [])
c(13, "§1.6 Corpus composition — By era (verbatim table); storefront concentration", "timeline",
  "Eras: E1 pre-conversion 2018-12-27→2021-01-26 n2,066 (51.0%) mean 4.56, 1,555 5★ / 67 1★; E2 conversion + fallout 2021-01-27→2021-06-30 n1,258 (31.1%) mean 1.57, 66 / 932; E3 long tail 2021-07-01→2025-03-12 n528 (13.0%) 1.93, 40 / 305; E4 data wipe 2025-03-13→2025-04-30 n161 (4.0%) 1.31, 4 / 135; E5 after 2025-05-01→2026-08-08 n35 (0.9%) 2.51, 9 / 19; top 5 storefronts (us, ru, ca, gb, de) = 2,816 = 69.6%; Russia is the second-largest storefront at 23.5% — unusually high and material to every global average",
  "n/a", "mixed", table("**By era**"), "none", "corpus-level fact", "app-specific", [])

with open("Tools/prd_ledger/20/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
