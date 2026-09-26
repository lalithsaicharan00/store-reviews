"""Cards for report 24 — header, How to read this, Executive summary, Part 1."""
import json, re
R = 24
rep = open("App Store Reports/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help (REPORT).md").read().split("\n")
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

c(1, "header lines 1-9; §12.4 External sources", "positioning",
  "Fabulous — Daily Habit Tracker · Morning Routines & ADHD Help (App Store ID 1203637303) — a freemium-subscription coaching app with a limited free tier, premium sold as annual / 3-monthly / 'bimonthly' plans plus a paid 'trial set-up fee' and a bundle covering sister apps (Clarify, Shape, Elixir, Lumière, Lune, Ambiance, Sphere); billing runs substantially outside Apple IAP through the developer's own web checkout — the single fact behind the largest finding",
  "developer of record Fabulous; bundle co.thefabulous.app; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 24; off-Apple web billing", "mixed",
  "43,469 reviews · 146 storefronts · 23 Nov 2017 → 6 Sep 2026; mean 3.751; 5★ 25,163 (57.89%) / 4★ 4,601 (10.58%) / 3★ 1,828 (4.21%) / 2★ 1,464 (3.37%) / 1★ 10,413 (23.96%)", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Seven warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §12.1 counting rules; §12.3 validation; §12.5 Reproduction; §12.6 Completion checklist; §12.7 one-paragraph version", "data-caveat",
  "Method: 43,469/43,469 read in full in 260 batches, country-then-date order, coverage verified programmatically (0 missing, 0 extra); 57-theme multilingual regex classifier with five disclosed corrections before use (religious objection 901→195 because 'cult' matched 'difficult'; ADHD 1,569→933 because 'add' matched the verb; coaching 6,433→6,095 because 'kind' matched 'kind of'; repetitive content 285→103 because 'repeat' matched 'charged repeatedly'; religion-censorship rebuilt 2→14); residual false-positive tail in scam language (10 of 3,468 about art plagiarism); 1,435 of 3,468 scam-language reviews carry no other billing theme but are one-line billing complaints (mean 1.107); two composites — bill_core (9 dispute themes) and bill_any (adds refund, support failure, price, bundle); corpus is bimodal (57.89% 5★, 23.96% 1★, 7.58% middle) and back-weighted (2024–26 = 24.47% at mean 2.662 vs 2020–21 = 40.16% at 4.244); theme rates under-count in zh/ja/ko/th/ru/he/ar — China mainland only 15.3% Latin-script so its billing rate 0.24% is an artefact (its rating 3.431, 28.6% 1★ is real); 'scam' is a word not a legal finding; no version field; review-selection bias runs both ways — in-app review prompt on day 1–3 inflates early praise, billing disputes arrive at renewal months later; not every reviewer is a payer (11,200, 25.77% discuss the transaction); storefront ≠ nationality ≠ language; prices are testimony in mixed currencies; no download/revenue/retention/refund-outcome data",
  "n/a", "none", "43,469/43,469; 146 storefronts; 0 empty bodies/titles; 9,582,733 characters; 99 duplicate groups (338 records) kept; is_edited 1,412 (3.25%, many visible downgrades after a later charge); 3,197 (7.35%) with votes", "none", "method", "yes",
  ["13061180549","13802373157","14003379751","2049293486","5090340749","12823158693","13873071118"])
c(3, "Executive summary #1 — off-Apple subscription billing is the defining fact and the single largest theme", "must-never-break",
  "Off-Apple subscription billing is the defining fact of the corpus: core billing disputes — charged after cancelling, unable to cancel, charge invisible in Apple Subscriptions, refused refund, unauthorised or duplicate charge, a 'free' trial that charged — are the single largest theme, at mean 1.110 with 94.2% 1★; the mechanism is stated repeatedly: sold through the developer's web checkout, so it does not appear in Apple Subscriptions, cancelling in the App Store does not stop it, and Apple cannot refund a charge it never processed",
  "subscription sold via own web checkout outside Apple IAP", "1★-burst",
  "5,791 (13.32%, high-priority), mean 1.110, 94.2% 1★; bill_any 6,612 (15.21%)", "product-rule", "high-priority", "yes",
  ["2268729711","7100144631","8998006088","11677442443","12030528331","12480865958","13002991015","13373884371","13667952251","13983220851"])
c(4, "Executive summary #2 — the failure is dated: begins Q4 2023 and never recovers", "timeline",
  "The billing failure is dated: quarterly core-billing rate 5.4% (2023Q1) → 5.0% (Q2) → 6.6% (Q3) → 12.0% (Q4) → 16.5% (2024Q1) → 33.1% (2024Q4) → 52.3% (2025Q2) → 51.0% (2026Q1) while the mean fell 4.181 → 2.074 — a step change between 2023Q3 and 2024Q1 and a second larger one in 2024Q4; era means E1 3.485 · E2 4.244 · E3 4.205 · E4 2.662",
  "billing model changed late 2023", "1★-burst", "5.4% → 12.0% → 16.5% → 33.1% → 52.3% → 51.0%; mean 4.181 → 2.074; E4 2.662", "product-rule", "very strong", "yes", [])
c(5, "Executive summary #3 — the product itself is genuinely well-liked; small-steps pacing is the highest-rated theme of any size", "insight",
  "The product is genuinely well-liked and that has changed less than the rating: coaching/motivation praised (mean 4.483), 'life-changing' (mean 4.799, 88.7% 5★), art/design praised (4.089), and the small-steps pacing — the refusal to let users over-commit — is the highest-rated theme of any size in the corpus (4.692)",
  "gentle, constrained coaching pacing", "praise", "coaching 6,095 (14.02%, mean 4.483); life-changing 4,468 (10.28%, mean 4.799, 88.7% 5★); design 2,969 (6.83%, 4.089); small steps 1,817 (4.18%, mean 4.692)", "do", "high-priority", "yes",
  ["1948880555","5325209035","6021355606","6785291083","7190336108","7658661973","8179896888","9471116676","11494466523"])
c(6, "Executive summary #4 — the 1★ and 5★ populations are not arguing about the same product; the small 2–3★ band is led by navigation and clutter", "insight",
  "The 1★ and 5★ populations are talking about different things — 1★ about billing (scam language 32.2%, refund 15.4%, charged-after-cancel 14.9%, cannot-cancel 10.2%), 5★ about the product (coaching 18.2%, life-changing 15.8%, routine-built 10.6%, design 7.2%); the tiny 2–3★ band is the only one where product criticism dominates, led by confusing navigation and cluttered UI — the billing problem masks a separate, smaller, genuine UX problem, and fixing one will not fix the other",
  "n/a", "mixed", "2–3★ band 3,292 (7.58%)", "must-have", "interpretation", "yes", [])
c(7, "Executive summary #5 — marketed to ADHD users, who are its angriest segment; 201 accuse it of exploiting the condition it advertises to", "audience",
  "The app is marketed to ADHD users and ADHD users are its angriest segment (mean 2.747 vs 3.751; 54.2% 1–2★); within it 201 reviews (mean 1.159) explicitly accuse the app of exploiting the condition it advertises to — 'they know because of your poor executive function that you won't take the extra effort to find the cancel button'",
  "positions on ADHD; cancellation hard to find", "churn", "933 (2.15%, meaningful), mean 2.747, 54.2% 1–2★ vs 41.2% 4–5★; 201 exploitation accusations, mean 1.159", "product-rule", "meaningful", "yes",
  ["7280196965","11706534401","11946441313","12195847716","12369933325","12644539764","13161684157","13458992785","13667737208","13961791199"])
c(8, "Executive summary #6 — the interface is the second problem and the opposite of what the app promises; grows independently of billing", "anti-pattern",
  "The interface is the product's second problem and the opposite of its promise — an app sold as a focus aid for ADHD is itself overstimulating: confusing/unintuitive (mean 2.338) and cluttered/overwhelming (mean 3.068); this grows steadily and independently of billing: 1.90% (E1) → 2.72% (E2) → 2.96% (E3) → 4.26% (E4)",
  "busy, gamified, content-heavy UI", "complaint", "confusing 1,507 (3.47%, very strong, mean 2.338); cluttered 1,324 (3.05%, very strong, mean 3.068); 1.90% → 2.72% → 2.96% → 4.26%", "must-have", "very strong", "yes",
  ["1980329123","5654554957","6670783764","7280199018","8449184231","9617541402","11583598458","12674646598","13654261115"])
c(9, "Executive summary #7 — in-app advertising of sister apps is a paid-subscriber grievance, and it is new; bundle subscriptions not knowingly bought", "dont",
  "In-app advertising of the developer's own sister apps is a paid-subscriber grievance (mean 1.932) and being subscribed to a bundle one did not knowingly buy is worse (mean 1.398); both are essentially absent before 2022 and concentrate in E4 — sister-app ads 0.11% → 0.21% → 0.50% → 2.03%; bundle complaints 0.30% → 0.06% → 0.17% → 2.62%",
  "upsells sister apps inside a paid app; sells a multi-app bundle at onboarding", "1★-burst", "ads 308 (0.71%, emerging, mean 1.932); bundle 324 (0.75%, mean 1.398); E4 2.03% and 2.62%", "dont", "emerging", "yes",
  ["11624316237","12183418883","12699901526","13133491407","13457132791","13940867104","12238712030","12420478007","13272341928","13584041512","14087096771"])
c(10, "Executive summary #8 — the forced first habit ('drink water', then 'eat breakfast') is a small theme with an outsized narrative footprint", "feature",
  "Users cannot skip the forced first habit 'drink water' (then 'eat breakfast') — a weak count but unusually consistent wording across eleven years and many languages, recurring inside larger complaints as the concrete example of 'not personalised'",
  "forced starter habit, unskippable", "complaint", "124 (0.29%, weak), mean 2.452", "product-rule", "weak but persistent", "yes",
  ["2059294945","4219672380","5251295013","6031701613","7231330364","8128909538","9936616848","11852321733","12846167630"])
c(11, "Executive summary #9 — the billing collapse is concentrated in English-language storefronts; Latin America is a different business", "market",
  "The billing collapse concentrates in English-language and some European storefronts (Ireland 24.5%, Finland 26.4%, Poland 25.4%, Ukraine 25.0%, UK 19.9%, Australia 19.7%, Canada 18.0%, Netherlands 17.5%, US 15.3%) against Latin America (Brazil 3.00%, Mexico 2.98%, Peru 3.01%, Ecuador 2.47%, Dominican Rep. 3.85%), corroborated by language-neutral ratings (Brazil 4.266, Mexico 4.381, Peru 4.511, Ecuador 4.593 vs UK 3.368, Australia 3.436, Ireland 3.266, Finland 2.361); even in E4 Brazil holds 4.002 at 7.49% billing vs the US's 2.560 at 42.63%",
  "web billing reaches some markets and not others", "mixed", "core-billing rate ie 24.5 · fi 26.4 · pl 25.4 · ua 25.0 · gb 19.9 · au 19.7 · ca 18.0 · nl 17.5 · us 15.3 vs br 3.00 · mx 2.98 · pe 3.01 · ec 2.47 · do 3.85; E4 br 4.002 / 7.49% vs us 2.560 / 42.63%", "research", "very strong", "yes", [])
c(12, "Executive summary #10 — cheapest unshipped wins in evidence order", "do",
  "Cheapest unshipped wins in evidence order: move subscription billing into Apple IAP (or make web billing visible and cancellable in one step) → stop selling bundles during onboarding without an explicit priced confirmation → honour cancellations already confirmed by e-mail → remove sister-app advertising from paid accounts → let users skip or replace the first habit → a low-stimulus 'just my routine' home screen → per-weekday and shift-work scheduling → let users backfill a missed day",
  "none shipped as of Sep 2026", "complaint", "report gives none (ranked list)", "do", "summary ranking", "yes", [])
c(13, "§1.3 is_edited — many are visible downgrades added after a later charge", "timeline",
  "1,412 edited reviews (3.25%) — many are visible downgrades added after a later charge, the opposite of report 23's edit-after-fix upgrades", "renewal charges turn 5★ into 1★ edits", "churn", "1,412 (3.25%)", "must-never-break", "corpus-level fact", "yes", ["12823158693","13873071118"])
c(14, "§1.4 #5 Disclosed residual error — 1,435 of 3,468 scam-language reviews carry no other billing theme, one-line 'Scam' at mean 1.107", "data-caveat",
  "41.4% of scam-language reviews are one-word or one-line billing complaints ('Scam', 'Fraud', 'Thieves') with no other theme — consistent with the billing population; a 0.29% false-positive tail is about art plagiarism (Monument Valley comparisons)",
  "n/a", "1★-burst", "1,435 of 3,468 (41.4%), mean 1.107; 10 (0.29%) false positives", "none", "method", "yes", ["2049293486","5090340749"])
c(15, "§1.5 The China storefront is effectively unclassified — rating 3.431, 28.6% 1★, worse than corpus", "market",
  "China mainland is effectively unclassified (only 15.3% of 1,250 reviews contain Latin-script words) but its language-neutral rating is real and worse than the corpus — mean 3.431, 28.6% 1★; China has real dissatisfaction this classifier cannot read",
  "n/a", "complaint", "n=1,250; mean 3.431; 28.6% 1★; billing 0.24% (artefact)", "research", "limited by method", "app-specific", [])
c(16, "§1.5 Review-selection bias — in-app review prompt on day 1–3 ('they asked me to review it now which I find kind of ridiculous')", "data-caveat",
  "Fabulous solicits reviews in-app during the first days of use — dozens of 5★ reviews say so ('they asked me to review it now which I find kind of ridiculous') — while billing complaints arrive at renewal months or years later; the two samples are drawn at different lifecycle points",
  "early in-app review prompt", "5★-burst", "dozens of 5★ say so explicitly", "dont", "disclosed bias", "yes", ["14003379751","13061180549","13802373157"])
c(17, "§1.6 Ratings table (verbatim) — U-shaped: extremes hold 81.85%, middle 7.58%", "data-caveat",
  "Rating distribution is U-shaped: the two extremes hold 81.85% of reviews and the 2–3★ middle 7.58%", "n/a", "mixed", table("**Ratings (denominator 43,469):**"), "none", "corpus-level fact", "app-specific", [])
c(18, "§1.6 Volume and mean by year table (verbatim) — 2019 dip (3.350, bill_core 10.09%), 2020–22 plateau ~4.23, collapse 2024 3.331 → 2025 2.387 → 2026 2.053", "timeline",
  "Per-year n, mean, 5★%, 1★% and bill_core%: a 2019 dip (3.350, 31.4% 1★, billing 10.09%), a 2020–2022 plateau at ~4.23–4.26 with billing ~4–5%, then 2024 3.331 (23.56%) → 2025 2.387 (44.90%) → 2026 2.053 (49.72%, 67.8% 1★)",
  "n/a", "mixed", table("**Volume and mean by year (denominator = that year's n):**"), "none", "corpus-level fact", "app-specific", [])
c(19, "§1.6 Eras table (verbatim) — E1 Nov 2017–Dec 2019 3.485 / 8.80%; E2 2020–21 4.244 / 4.12%; E3 2022–23 4.205 / 5.49%; E4 Jan 2024–Sep 2026 2.662 / 38.00%", "timeline",
  "Eras chosen from the shape of the data: E1 (Nov 2017–Dec 2019, n=5,578, 12.83%, mean 3.485, bill_core 8.80%), E2 (2020–21, 17,459, 40.16%, 4.244, 4.12%), E3 (2022–23, 9,795, 22.53%, 4.205, 5.49%), E4 (Jan 2024–Sep 2026, 10,637, 24.47%, 2.662, 38.00%)",
  "n/a", "mixed", table("**Eras used throughout this report**"), "none", "corpus-level fact", "app-specific", [])
c(20, "§1.6 Most-voted reviews — all positive and all pre-2024; the voting population predates the billing collapse", "data-caveat",
  "The highest-voted reviews (556, 175, 166, 160, 133, 124, 106, 96 votes) are all positive and all pre-2024 — the voting population predates the billing collapse",
  "n/a", "praise", "top 8 votes 556 → 96", "none", "corpus-level fact", "app-specific",
  ["7145509593","3354419782","6061329076","4009086528","8959985525","2188974205","6880068846","3842317360"])

with open("Tools/prd_ledger/24/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
