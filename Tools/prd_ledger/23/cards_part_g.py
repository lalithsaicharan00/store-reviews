"""Cards added from the validator pass (report 23): contradictions and a §11.5 where fix."""
import json
R = 23
P = "Tools/prd_ledger/23/cards.jsonl"
cards = [json.loads(l) for l in open(P) if l.strip()]
for k in cards:
    if k["id"] in ("R23-231","R23-232","R23-233","R23-234"):
        k["where"] = "§11.5 " + k["where"]
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))
c(236, "§8.8 Finding; §8.9 — contradiction with the 'weight rich English-speaking markets' assumption", "contradiction",
  "Contradiction with the ledger's rich-market weighting: in this corpus the high-spend and high-volume storefront groups are statistically indistinguishable from each other (4.22) and only marginally better than the rest of the world (4.12) — there is no high-spend/low-spend product split; what differs by country is which complaint dominates",
  "one-time paid app with no free tier", "none", "Group A 4.22 · Group B 4.22 · rest 4.12", "research", "corpus-level fact", "unknown", [],
  cond="may hold only where everyone pays the same one-time price — no free tier to separate markets by conversion")
c(237, "§2.2 / §7.4 / §9.9 — contradiction with the price-sensitivity assumption: ~2.5× price rise, flat objection rate", "contradiction",
  "Contradiction with the assumption that raising the price raises the objection rate: the one-time price rose ~2.5× nominal over eleven years ($3.99 → $9.99) and the objection rate stayed flat (1.75% → 2.41% → 2.21%); objections are about feature-per-dollar and the cap, not the number",
  "raised one-time price ~2.5×", "mixed", "objection 1.75% → 2.41% → 2.21% across a 2.5× rise", "build-paid", "very strong", "yes", [],
  cond="one-time purchase at single-digit dollars; no subscription anchor")
c(238, "§7.2 — contradiction: Apple Design Award / editorial traffic is the worst-rated acquisition channel [weak, n=17]", "contradiction",
  "Contradiction with the assumption that an Apple award or editorial feature is pure upside: reviews that name the award or editorial placement are the lowest-mean acquisition channel (2.53) — award traffic arrives expecting 'best app' and meets a deliberately constrained tracker",
  "won an Apple Design Award", "churn", "17 reviews, mean 2.53", "do", "weak (n=17), hypothesis", "unknown",
  ["1400446995","1526417758","2186911032","3658903640","4651536264","5132838929","9496499610","9558726188"])
c(239, "Executive summary #2 / §3.3 #1 — contradiction: 'simple is table stakes' vs simplicity as the moat", "contradiction",
  "Contradiction with the reading that simplicity is table stakes rather than a differentiator: here simplicity is the moat — the highest-volume positive theme at 24.48% (mean 4.58) — and measurably degrades as features are added (32.30% → 18.36%); constraint itself is the product",
  "deliberately constrained product", "praise", "1,780 (24.48%), mean 4.58; 32.30% → 20.80% → 18.36%", "product-rule", "high-priority", "yes", [],
  cond="holds for a paid-up-front app whose listing sells constraint; the loss appears when features are added to answer a minority")
with open(P, "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards total")
