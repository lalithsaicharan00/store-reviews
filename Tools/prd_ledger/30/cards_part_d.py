"""Cards added from the validator + blind-pass diff (report 30)."""
import json
R = 30
P = "Tools/prd_ledger/30/cards.jsonl"
cards = [json.loads(l) for l in open(P) if l.strip()]
for k in cards:
    if k["id"] == "R30-089":
        k["where"] = "§8.4 Research questions Part 8 #1, Part 8 #2, Part 8 #3, Part 8 #4, Part 8 #5 — " + k["where"].split("— ",1)[1]
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))
c(91, "Warning #1 / §2.3 / §7.3 — tactic: two seeded 5★ launch-review campaigns (EN Jul–Sep 2025, ES/NL Nov–Dec 2025) and their outcome", "tactic",
  "Tactic and outcome: two phrase-bank 5★ campaigns seeded the launch rating — 83 of 166 reviews (50%) from a five-phrase list in several languages, one English-language wave (Jul–Sep 2025, GB+US 38) and one Spanish/Dutch wave (Nov–Dec 2025, ES+CL 16), a Dutch sentence concatenating all five phrases posted on the Russian storefront; outcome: a public 4.4★ (4.9★ US listing) that is a decaying artefact — the campaigns stopped after January 2026, the half-year mean fell 4.65 → 3.17 → 3.00, the organic 1★ rate rose 12.5% → 44.4%, and the US and GB storefronts are commercially unmeasured because they contain almost nothing else",
  "seeded 5★ phrase-bank campaigns", "5★-burst", "83/166 (50%) all 5★; mean 4.65 → 3.00; organic 1★ 12.5% → 44.4%", "dont", "high", "yes",
  ["13403875241","13404072755","13442553415","12928535001","13406815450"])
c(92, "§3.3 / §7.2 — tactic: raising the free cap by one habit (2 → 3) in response to cap complaints, and its outcome", "tactic",
  "Tactic and outcome: the developer answered the cap complaint by raising the free limit from 2 to 3 habits between February and April 2026; the complaint continued at the same rate and with the same ratings (1★, 3★, 4★), the listing kept saying 2, and a reviewer had already named 5 as the floor — an increment below the threshold of evaluability changes nothing",
  "cap 2 → 3", "complaint", "12 say 2, then 3 say 3; same ratings", "product-rule", "high", "yes",
  ["14007543484","14262833547","14438894096","13139338718"])
with open(P, "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards total")
