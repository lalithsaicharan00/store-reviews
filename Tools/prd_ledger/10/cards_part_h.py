"""Gap cards from the blind second pass (report 10), plus two magnitude patches."""
import json
R = 10
cards = [json.loads(l) for l in open("Tools/prd_ledger/10/cards.jsonl") if l.strip()]
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))
c(179, "§7.2 U-childish row; §10.2 U-childish definition", "positioning",
  "The tone and visual style read as childish or condescending to some adults — a complaint that appears only as a per-country row, highest in Australia, the most ADHD-identified market",
  "cute, pastel, pet-first design", "complaint", "U-childish us 0.75% / gb 0.75% / ca 0.84% / au 1.06%", "research", "weak (country table only)", "yes", [])
c(180, "§7.2 M-should-be-free row; §8.7 M-should-be-free flat", "monetization",
  "'Self-care should be free' — a normative objection to charging at all, distinct from a price objection — is small and flat across five years",
  "free tier + subscription", "complaint", "M-should-be-free us 0.34% / gb 0.40% / ca 0.32% / au 0.32%; by year 0.37% → 0.41% → 0.29% → 0.25% → 0.35% (flat)", "none", "weak, flat", "yes", [])
by = {x["id"]: x for x in cards}
by["R10-150"]["magnitude"] = by["R10-150"]["magnitude"].replace("P-companion 2.64% → 1.32%", "P-companion 2.64% → 2.57% → 2.00% → 1.71% → 1.52% → 1.32%")
by["R10-002"]["magnitude"] += "; validation: first classification pass had false positives (M-trial-no-reminder matched 'remind myself', D-support matched 'part of my support system', M-should-be-free matched praise for the free tier) and was rewritten with negative-context exclusions; recall calibrated against keyword probes (1,036 mention 'journey', 80 ≤3★, rule captures 49)"
with open("Tools/prd_ledger/10/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards total")
