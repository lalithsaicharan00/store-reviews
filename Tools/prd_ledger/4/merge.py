"""Stage 3 merge for report 4."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C109","must-never-break","A free trial must be a real trial","It must apply to whichever plan the user picks, and the confirmation must show the exact charge date and amount; a trial that bills at once produced 789 reviews at mean 1.35 in report 4 and must be verified per storefront (Brazil ran 7–11× the global rate).")
add("C110","must-have","An obvious 'continue free' path on the paywall — the free/paid boundary must be legible","Users wrote 75 reviews teaching each other where the hidden X was while 1,903 said the app was paid-only; legibility of what is free is a rating decision.")
add("C111","dont","No long quiz before the price; show the price up front","A 10–20 minute quiz followed by a paywall turns a price objection into anger (mean 1.98, 71.9% 1–2★); 'lower the yearly price a bit and show it at the very beginning'.")
add("C112","must-have","In-app cancellation","Cancel-by-email with no reply converts recoverable disputes into permanent 1★, legal threats and denied refunds.")
add("C113","must-never-break","One stable, disclosed price — no discount wheels","Users in the same market reported $19.99–$59.99 for the same thing; that inconsistency is what 'scam' language attaches to; a rigged or broken gimmick makes it worse.")
add("C114","dont","Ads must match the app","Advertised features that are absent create a 'scam' cohort before first open (0.62%, mean 2.42).")
add("C116","paid","Content library (workouts, meditation, sleep, journal) as the paid layer","Gives a routine app something to sell beyond the core loop and separates it from 'a fancy Reminders list'.")
add("C117","research","Mascot / companion character","Small, pure praise in report 4; category norm in pet-style apps.")
add("C118","paid","Preset routines / templates / programs","Paywalled in report 4 with little complaint.")
add("C119","must-never-break","Updates must not regress layout or lose progress","'Everything I dreamt of… then Boom… updated! Now the interface is simply ugly, the progress is gone'; layout regressions hit neurodivergent users hardest.")
C["C103"]["title"] = "Vulnerable users — recovery, mental-health and minors — are a sensitive surface"
C["C103"]["statement"] += " In report 4: 455 kid/teen reviews who cannot pay, and 89 shame / diet-framing reviews in a 4+ app."
C["C073"]["title"] = "Manual reordering, renaming and editing of habits/tasks — free"
C["C073"]["statement"] += " In report 4 rename/reorder was gated and it was the top complaint among paying users."

M = {
 "R04-003":["C002"], "R04-004":["C002","C065"], "R04-005":["C109","C029"], "R04-006":["C109"], "R04-007":["C110"],
 "R04-008":["C007","C001"], "R04-009":["C111"], "R04-010":["C002","C001"], "R04-011":["C003"], "R04-012":["C006","C082"],
 "R04-013":["C113","C109"], "R04-014":["C113"], "R04-015":["C007"], "R04-016":["C118"], "R04-017":["C116"],
 "R04-018":["C018"], "R04-019":["C073"], "R04-020":["C007","C008"], "R04-021":["C110"], "R04-022":["C065"],
 "R04-023":["C007"], "R04-024":["C113"], "R04-025":["C061","C007"], "R04-026":["C042"], "R04-027":["C109","C029"],
 "R04-028":["C116"], "R04-029":["C065"], "R04-030":["C065"], "R04-031":["C065"], "R04-032":["C034","C035"],
 "R04-033":["C112","C036"], "R04-034":["C029"], "R04-035":["C093"], "R04-036":["C113"], "R04-037":["C109"],
 "R04-038":["C110"], "R04-039":["C007","C001"], "R04-040":["C112","C036"], "R04-041":["C111","C113"], "R04-042":["C003"],
 "R04-044":["C002"], "R04-046":["C002"], "R04-048":["C042"], "R04-049":["C057"], "R04-050":["C024"],
 "R04-051":["C116"], "R04-052":["C006"], "R04-053":["C117"], "R04-055":["C039"], "R04-056":["C043"],
 "R04-057":["C073"], "R04-058":["C034","C035"], "R04-059":["C119"], "R04-060":["C073"], "R04-061":["C007"],
 "R04-062":["C064"], "R04-063":["C075","C006"], "R04-064":["C114"], "R04-065":["C001"], "R04-066":["C031"],
 "R04-067":["C103"], "R04-068":["C103"], "R04-069":["C042"], "R04-070":["C103"], "R04-071":["C068"],
 "R04-072":["C005","C116"], "R04-075":["C109"], "R04-076":["C109"], "R04-077":["C110"], "R04-078":["C111","C064"],
 "R04-079":["C027"], "R04-084":["C109","C029"], "R04-085":["C007","C001"], "R04-086":["C027","C043","C111"], "R04-087":["C001","C027"],
 "R04-088":["C039","C034","C093"], "R04-089":["C109"], "R04-090":["C110"], "R04-091":["C109"], "R04-092":["C112","C036"],
 "R04-093":["C039"], "R04-094":["C034","C035"], "R04-095":["C111"], "R04-096":["C007","C001"], "R04-097":["C113"],
 "R04-098":["C003"], "R04-099":["C092"], "R04-100":["C073"], "R04-101":["C043"], "R04-102":["C023","C009"],
 "R04-103":["C022"], "R04-104":["C042"], "R04-105":["C116"], "R04-106":["C103"], "R04-109":["C114","C058","C042"],
 "R04-110":["C057"], "R04-111":["C007"],
}
# unattached: 001 002 043 045 047 054 073 074 080 081 082 083 107 108
cards = [json.loads(l) for l in open("Tools/prd_ledger/4/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/4/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values()).items()))
