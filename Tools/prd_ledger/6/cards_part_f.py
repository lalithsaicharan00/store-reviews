import json, re
R = 6
rep = open("App Store Reports/6. Streak Tracker - StreakUp - Habit Builder & Breaker (REPORT).md").read().split("\n")
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


# ---- gaps from validate.py: product-rule and tactic kinds ----
c(100, "§4.1 The paywall implied a capability the product does not have; §1.2", "product-rule",
  "Never let the paywall imply a capability the product does not have — a buyer who pays for a feature that isn't there turns a feature request into a refund cause and a cancellation",
  "Pro implied multiple daily check-ins; product has none", "churn", "1 paid churn (2.27%), 4★; 'there are free ones with basic'", "product-rule", "weight raised by a paid churn", "yes",
  ["13390634274"])
c(101, "Part 0 §2 cap too tight to demonstrate value; §8.3", "product-rule",
  "A free quantity cap must sit above the number of things a normal user tracks: a cap below that (gym + water + no doomscrolling is already three) cannot demonstrate value and generates public complaint; raising 1 → 2 did not fix it and the ask is for unlimited or near-unlimited",
  "2-streak cap", "blocked-conversion", "7 cap complaints (15.91%), mean 3.00; 1 → 2 raise followed by 1-in-9 → 5-in-23", "product-rule", "high-priority (n = 7)", "yes",
  ["13185604622","14477924333","14214912053"],
  cond="contrast report 5, where a 2-routine cap sat above core value (morning + night) and was tolerated")
c(102, "Part 0 §4 users are objecting to not knowing the price; Part 9 #8", "product-rule",
  "One clear price on the paywall, kept stable — users who cannot tell what the price is call the app greedy and a scam regardless of the price level",
  "five prices in eleven months", "1★-burst", "greed cluster 4 (9.09%), mean 1.00", "product-rule", "high-priority (n = 4)", "yes",
  ["13628759209","13185604622"])
c(103, "Part 0 §2 cap moved once; §8.3 — tactic outcome", "tactic",
  "Tactic: StreakUp raised the free allowance from 1 streak to 2 (between Sep 2025 and Apr 2026). Outcome: the cap-complaint rate rose (1 in the first 9 reviews → 5 in the last 23; 11.1% → 8.3% → 21.7% by window), but the complaints' tone moved from 'scam' (mean 1.0) to 'love it, want more' (mean 3.4)",
  "raised cap 1 → 2", "mixed", "1-in-9 → 5-in-23; window share 11.1% → 8.3% → 21.7%; mean 1.0 → 3.4", "undecided", "observed (small n); inferred from text, no changelog", "yes",
  ["13185604622","13969396065","14477924333"],
  cond="a small raise inside a quantity-gated model; a large raise was not tried")
c(104, "§8.4 lifetime SKU appeared mid-corpus — tactic outcome; Part 0 §3", "tactic",
  "Tactic: StreakUp added a $14.99 lifetime 'forever' SKU next to the $11.99 yearly plan in spring 2026. Outcome: welcomed ('which is nice'), actively sought (an IN user tried to buy it), and bought — but the upgrade path from an active trial/yearly subscription double-billed the buyer",
  "added lifetime alongside subscription", "purchase-driver", "3 of 4 paid-evidence reviewers engage, all positively in principle; 1 double charge ($25.98)", "product-rule", "clearest packaging signal", "yes",
  ["13939159292","14203637124","14214912053"],
  side="a new SKU must ship with its cross-grade billing path tested")

with open("Tools/prd_ledger/6/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
