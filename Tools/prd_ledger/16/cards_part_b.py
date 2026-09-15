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

# ---- PART 1 ----
c(19, "§1.1 Files used table (verbatim); §1.2 Schema; §1.3 Coverage and reconciliation table (verbatim); §1.4 Processing method; §1.6 External sources table (verbatim)", "data-caveat",
  "Files, schema, reconciliation and method detail: 57 themes built from a full chronological read in 12 batches; hybrid classification — praise themes by multilingual regex, every high-stakes theme hand-audited review by review with recorded add/remove sets; the price theme uses proximity logic (8 false positives removed, 32 misses added by hand); the paid cohort audited line by line (146 candidates → 19 removed as book/journal/competitor purchases, 3 ambiguous excluded); purchase intent excluded throughout",
  "n/a", "none", table("## 1.1 Files used") + " ;; " + table("## 1.3 Coverage and reconciliation") + " ;; " + table("## 1.6 External sources"), "none", "method", "yes",
  ["10975681427","10983622751","12616174078","10983135069","11054245890","10980935471","11489179909"])
c(20, "§1.5 Limitations — launch-window dominance; selection bias; a launch-day review-solicitation campaign is visible; no version field; external data not refreshed; small samples; language coverage; small themes are floors", "data-caveat",
  "Limitations: launch-window dominance is the biggest (58.05% of reviews in the first six weeks — where a finding depends on the app today, use the P4 2026 column); a launch-day review-solicitation campaign is visible — a reviewer alleges the beta list was asked to 'overcome outdated reviews', 23 reviews self-identify as beta testers and are strongly bimodal; no version field; no live store data; 72 of 76 storefronts under 50; hand-curated small themes are floors",
  "beta testers asked to post reviews at launch", "mixed", "678 of 1,168 (58.05%) launch; beta testers 23 (1.97%), 47.8% 5★ / 47.8% 1–2★; regex praise themes ±3–5%", "none", "method", "yes",
  ["10977084069"])
c(21, "§1.7 Corpus composition — by period table (verbatim); by quarter table (verbatim); launch-day detail", "timeline",
  "Corpus composition by period and quarter: launch P1 mean 3.88 then a post-launch floor around 3.0–3.4; all post-launch reviews combined mean 3.22; the 27 Feb 2024 spike (171 reviews) is the largest single day and where the price backlash peaks",
  "n/a", "mixed", table("## 1.7 Corpus composition") + " ;; " + table("## 1.7 Corpus composition", 1) + " ; post-launch n=490 mean 3.22, 22.0% 1★, 35.9% 5★; 24 Feb 69 (4.49), 25 Feb 74 (4.47), 26 Feb 70 (3.94), 27 Feb 171 (3.84), 28 Feb 71 (4.08), 29 Feb 44 (3.80); US 542 (46.4%), GB 103, CA 73, AU 52 = 65.4%", "none", "verbatim", "app-specific", [])

# ---- PART 2 ----
c(22, "§2.1 Feature inventory derived from reviews table (verbatim)", "feature",
  "Feature inventory: guided habit template ('I will [X] at [time] at [place] so I can become [identity]') free for 1 habit; press-and-hold haptic logging free; reminders free; further habits Pro (cap 6, 3 before ~11 Mar 2024); Mindset tab Pro (free at launch, paywalled by late Mar 2024); accountability partner Pro; widget widely buggy; detailed history Pro; focus session/timer from ~Sep 2024; Hall of Fame with no removal path; Spotify link; does not exist at any tier: back-logging beyond yesterday, undo/unlog, dark mode, any non-English language, iPad/Watch/Mac/Android, offline logging; Family Sharing asked once",
  "see table", "mixed", table("## 2.1 Feature inventory"), "research", "verbatim", "app-specific",
  ["10976218757","10979085353","10976048976","10975917055","10992375879","11108307273","10992039334","12959086974","11749997696","12430398320","12554662027","11094114464","10990662644","11207909936","10983856203"])
c(23, "§2.1 Guided habit template — 'I will [X] at [time] at [place] so I can become [identity]'; Accountability partner (Pro); Hall of Fame with no removal path; Undo / unlog does not exist", "feature",
  "Smaller inventory findings: a guided implementation-intention template for creating a habit; an accountability partner (invite a friend) behind Pro; a 'Hall of Fame' archive with no removal path; no undo/unlog of a completion",
  "template free; partner Pro; no undo", "mixed", "undo 9 reviews; partner 3 IDs; hall of fame 1", "research", "small", "yes",
  ["10976218757","11108307273","11129229740","13019922003","12430398320","11094114464","11113140619"])
c(24, "§2.2 Monetisation model — the trial does not auto-charge; there is almost no upsell nagging", "monetization",
  "Two things are genuinely well designed and reviewers say so: the 28-day full-Pro trial requires no card and does not auto-charge ('I respect that the app doesn't force you to subscribe to get the free trial… Moral behavior is noticed and appreciated!'), and there is almost no upsell nagging — an unusually low rate for a subscription app",
  "no-card 28-day trial; no nag", "praise", "nag complaints only 8 (0.68%); 3 cited praise IDs", "build-free", "emerging", "yes",
  ["10986971491","11061933855","10985371106"])
c(25, "§2.2 Both assets are destroyed by the shape of the drop-off — a no-pressure trial that ends in an unusable free tier reads as a worse trick than a nagging one", "insight",
  "Both assets are destroyed by the shape of the drop-off: a no-pressure trial that ends in an unusable free tier reads to reviewers as a WORSE trick than a nagging one, because they only discover the wall after three weeks of investment",
  "28-day trial → 1-habit tier", "1★-burst", "bait-and-switch 41 (3.51%)", "product-rule", "very strong", "yes", [])
c(26, "§2.2 Prices reported by reviewers — highest and lowest", "monetization",
  "Highest reported prices: A$200/yr, £215/yr if billed monthly, C$150/yr, CHF 120/yr, ¥18,000/yr; lowest: $40/yr (Mar 2026) and $5/mo (Jul 2026); no one-time purchase has ever existed",
  "subscription only, monthly or annual", "complaint", "6 cited IDs", "research", "reported", "app-specific",
  ["11002040769","10985301089","11113968468","10990115203","11846275530","13853134874","14287877372"])
c(27, "§2.2 The paid feature reviewers most resent losing is the Mindset content — material they already bought; the core packaging error stated plainly", "product-rule",
  "The paid feature reviewers most resent losing is not habit slots but the Mindset content, because they correctly identify it as material they already bought — 'since I already read the book which only cost me $15 one time why would I pay anywhere close to that monthly to get the same information'; 'Shameful that they're taking away features and driving away loyal supporters' — the core packaging error: Atoms paywalls the two things its audience already owns (the ideas, and the willingness to track) and gives away the one thing that costs nothing to give (a second habit slot)",
  "Mindset content paywalled after being free at launch; habit slots gated", "1★-burst", "3 cited IDs; Mindset 59 mentions", "product-rule", "argued from corpus", "yes",
  ["11010361389","11097642923","12819752757"])

with open("Tools/prd_ledger/16/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
