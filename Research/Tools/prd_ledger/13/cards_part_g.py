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

# ---- PART 7 ----
c(64, "§7.1 Method — four eras", "timeline",
  "Four eras: paid app (2015-06 → 2017-07) mean 4.73; subscription conversion (2017-08 → 2018-12) 3.09; scale and paid acquisition (2019–20) 3.18; decline (2021–26) 2.85",
  "n/a", "mixed", "Era 1 5,104 reviews 4.73; Era 2 2,812 3.09; Era 3 8,454 3.18; Era 4 3,480 2.85; 136 months", "none", "method", "app-specific", [])
c(65, "§7.2 Trend 1 — The subscription conversion. Dated, decisive, permanent; monthly table (verbatim); evidence for the conversion; aggravating context", "timeline",
  "The subscription conversion is dated, decisive and permanent: the mean fell 1.79 stars in nine months (Aug 2017 → Apr 2018) and the corpus has not seen a month above 4.0 since Sep 2017; 'They replaced the one-time purchase with a subscription without a word about it in the update notes'; 'Unannounced switch to subscription model… including those who had already paid'; 'Bait & Switch!'; aggravating context in the same window: the app was renamed from 'Balanced', the predecessor pulled, and ownership reportedly moved to an ad company",
  "one-time → subscription Aug 2017, unannounced, prior buyers downgraded; rebrand", "1★-burst", table("## 7.2 Trend 1") + " ; M-sub-objection 6.9% (2017) → 17.3% (2018); M-trial-autocharge 0.3% → 8.4%; M-cancel-hard 0.2% → 5.1%; 140 1–2★ reviews Aug–Dec 2017", "product-rule", "very strong", "yes",
  ["1709443938","1710045692","1711354112","1717245795","1714126118","1795269347","1742078444","2022210088","1944811074","2048313987","2994148554","1798982614","1879018954","1709611336"])
c(66, "§7.3 Trend 2 — Price rose ~25×, and complaints tracked it exactly table (verbatim); weekly billing is a distinct escalation", "timeline",
  "Price complaints tracked the price exactly year by year; the 2024 introduction of WEEKLY billing is a distinct escalation with its own reaction — '$3.99 WEEKLY to track my habits is insane'; '29.90 per week. Per week! I didn't even test it'; 'I used the app when it was affordable, 5 euro a month… but now 6€ A WEEK'; '24€ a month to track habits… that is immoral'",
  "weekly tier added 2024; $100/yr by 2025", "1★-burst", table("## 7.3 Trend 2"), "dont", "very strong", "yes",
  ["11156001886","12283821466","12289420481","12827096820","11737276918","11782257948"])
c(67, "§7.4 Trend 3 — App-bricking launch failure. Three waves, still unfixed in 2026; waves table (verbatim); the root cause is stated; the strongest candidate for 'fix this week'", "must-never-break",
  "The app performs a blocking, network-dependent data migration on launch ('Why is there even an update inside the app? Those are loaded via the App Store'); when it fails or the device is offline the app is unopenable — a design error, not just a bug — and the Oct 2020 wave also destroyed data on reinstall ('lost almost 3 years of habit tracking'); hits paying subscribers; recurred across seven years; the strongest 'fix this week' candidate in the report",
  "blocking network update check on launch", "1★-burst", table("## 7.4 Trend 3") + " ; Oct 2020 peak 5.9% of 287 reviews; 43 of 46 true positives", "must-never-break", "weak by volume, severe by nature", "yes",
  ["5111443326","6513718209","6557166073","6525723770","6515887759","6569375125","13099718036","14453446467","12844697075"])
c(68, "§7.5 Trend 4 — Sync failure is the fastest-worsening product dimension; yearly table (verbatim)", "timeline",
  "Sync failure is the fastest-worsening product dimension — a 10× rise from 2015 to 2021 sustained through 2026 ('iCloud sync broken, fixed, now broken again'); the 2024 dip is sampling noise, not a fix",
  "iCloud sync unreliable", "complaint", table("## 7.5 Trend 4") + " ; 8.90% of 3★", "must-never-break", "meaningful, worsening", "yes",
  ["1313972378","1379830019","3070069271","3386723296","4356794558","5778564141","6806854391","9346061306","9717725547","6792537279"])
c(69, "§7.6 Trend 5 — Content tabs arrived in 2020, peaked, and were not wanted", "anti-pattern",
  "Challenges/Explore content tabs arrived in 2020, peaked and were not wanted — 'Please get rid of the challenges and explore tabs, or make it so we can hide them… I will not pay for a subscription to an app that is 50% entirely useless and unhelpful content'; the company invested in content while the corpus asked for sync, reordering, flexible scheduling and honest billing; content did not move ratings",
  "content tabs added 2020, partly paid, not hideable", "complaint", "U-challenges 6 (2019) → 45 (2020) → 29 → 21 → 11 → 3 → 0; means 2020 3.16, 2021 2.91, 2022 2.74", "dont", "emerging, then fading", "yes",
  ["9948539388","8091736452","6536839803","8536372117","8035852270","10245447172"])
c(70, "§7.7 Trend 6 — Privacy: two separate, dated flare-ups; location collection has no stated product purpose", "must-have",
  "Privacy: a Jul 2017 privacy-policy revision triggered an 11-review backlash in one month (one reviewer about to upgrade stopped); 2024–26 a modern concern — 'By far the worst user and metadata tracking policy of any of the habit trackers'; a long-time user read disclosure to law enforcement plus location tracking and deleted; location collection has no stated purpose and reviewers say so ('Keeps nagging about turning location on… No, you don't need it')",
  "location prompts; broad data policy", "complaint", "C-privacy 38 mean 1.55; Jul 2017 n=11 in one month", "must-have", "weak, reputationally sharp", "yes",
  ["1669007653","1669583149","1672427701","1701657469","11792920885","13792517171","6803835963","6044332210","4511478137","2920926816"])
c(71, "§7.8 Trend 7 — What never changed in eleven years table (verbatim)", "timeline",
  "Nine themes present at material rates in every era and never fixed: must pay to use, free tier too small, upgrade interstitials (worsening), sync (worsening), localisation (worsening), no Android/web/macOS, no export, reminders unreliable, exact reminder times gated (discussed less only because engaged users left)",
  "n/a", "complaint", table("## 7.8 Trend 7"), "must-never-break", "persistent", "yes", [])
c(72, "§7.9 Trends explicitly NOT claimed", "data-caveat",
  "Not claimed: that review-volume decline (4,398 → 68) indicates usage decline (volume follows prompt policy, store changes and paid acquisition — the 2019–20 spike is substantially Chinese acquisition); reliable 2024–26 theme rates at fine granularity; that the 2020 free-tier reversal caused any rating change; developer intent behind any dark pattern",
  "n/a", "none", "n=413/146/68 for 2024–26", "none", "method", "yes", [])

with open("Tools/prd_ledger/13/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
