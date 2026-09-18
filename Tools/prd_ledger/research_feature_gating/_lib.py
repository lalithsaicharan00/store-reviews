import json
R = "Feature Gating vs Quantity.md"
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"RFG-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))
def save(mode):
    with open("Tools/prd_ledger/research_feature_gating/cards.jsonl", mode) as f:
        for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
    print(len(cards), "cards", "written" if mode=="w" else "appended")
