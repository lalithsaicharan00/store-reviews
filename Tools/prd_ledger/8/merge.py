"""Stage 3 merge for report 8."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C143","must-have","Intra-day completion: tap N times to fill N/N","When a habit's target is more than once a day, each tap should count toward it; one binary tick per day is report 8's #1 unmet need, the only complaint theme still rising, and a stated uninstall.")
add("C144","undecided","Habits, focus timer and journal in one simple app","Report 8's 3-in-1 bundle is load-bearing: none of the three parts draws a 1–2★, and users value not switching between three apps — as long as each part stays minimal.")
add("C145","dont","Every promotional or onboarding modal must be dismissible on the smallest screen","Report 8's full-screen 'add a widget' prompt had an unreachable close button on small iPhones and blocked the app for 20 months.")
add("C146","do","Harden onboarding before January","The New Year cohort is the largest of the year, writes reviews in its first days, and judges onboarding, not retention — every create-flow or first-day logging defect is amplified about 2× in January (report 8).")
C["C097"]["statement"] += " Report 8: in a completely free app, 7 users asked unprompted for a tip jar (all 5★) and 13 more volunteered to pay — mostly one-time, not subscription."
C["C010"]["statement"] += " Report 8 contests it: a ~7-day backfill window in a free app with weak history views was the worst-rated request (mean 3.52)."
C["C001"]["statement"] += " Report 8: a competitor adding a paywall sent its users to a free rival, and free users explicitly warn against gating what is free."
C["C071"]["statement"] += " Report 8: a ~18-month pause let iOS updates break the create flow, widget and launch, and users publicly asked whether the app was abandoned ('Wrapped 2022' still in settings in 2025)."

M = {
 "R08-004":["C001"], "R08-006":["C002"], "R08-007":["C134"], "R08-009":["C031","C119"], "R08-010":["C031","C071"],
 "R08-011":["C071"], "R08-012":["C071"], "R08-014":["C059"], "R08-015":["C011"], "R08-016":["C143"],
 "R08-017":["C048"], "R08-019":["C038"], "R08-021":["C003"], "R08-022":["C097"], "R08-023":["C001"],
 "R08-024":["C001","C003"], "R08-026":["C006"], "R08-027":["C144","C066","C049"], "R08-028":["C001","C005"], "R08-029":["C005"],
 "R08-031":["C007"], "R08-032":["C009"], "R08-033":["C020"], "R08-034":["C036","C020"], "R08-037":["C085"],
 "R08-038":["C097","C071"], "R08-039":["C093"], "R08-041":["C006"], "R08-049":["C059"], "R08-050":["C042"],
 "R08-051":["C042","C066"], "R08-052":["C058"], "R08-054":["C010"], "R08-055":["C010"], "R08-056":["C011"],
 "R08-057":["C038"], "R08-059":["C034"], "R08-060":["C034"], "R08-061":["C034"], "R08-063":["C043","C142"],
 "R08-065":["C066"], "R08-066":["C039"], "R08-067":["C009","C107"], "R08-068":["C040"], "R08-069":["C145","C093"],
 "R08-070":["C142"], "R08-071":["C039"], "R08-072":["C056","C006"], "R08-073":["C027"], "R08-074":["C075"],
 "R08-075":["C041"], "R08-076":["C022"], "R08-077":["C141","C044"], "R08-078":["C045"], "R08-079":["C015"],
 "R08-080":["C050"], "R08-081":["C016"], "R08-082":["C073"], "R08-084":["C021"], "R08-085":["C049"],
 "R08-086":["C017"], "R08-087":["C038"], "R08-088":["C031","C083"], "R08-090":["C006"], "R08-091":["C026"],
 "R08-097":["C097"], "R08-098":["C143"], "R08-102":["C027"], "R08-104":["C071"], "R08-105":["C059"],
 "R08-106":["C001"], "R08-108":["C119"], "R08-109":["C146"], "R08-110":["C038","C146"], "R08-111":["C038"],
 "R08-112":["C040"], "R08-113":["C039"], "R08-114":["C039"], "R08-115":["C036","C020"], "R08-116":["C143"],
 "R08-117":["C043","C142"], "R08-118":["C010"], "R08-119":["C009","C107"], "R08-120":["C034"], "R08-121":["C041"],
 "R08-122":["C097"], "R08-123":["C001","C003"], "R08-124":["C022"], "R08-125":["C001","C009"], "R08-126":["C134"],
 "R08-127":["C085"], "R08-128":["C094","C059"], "R08-130":["C097"], "R08-131":["C038"], "R08-132":["C142"],
 "R08-133":["C040"], "R08-134":["C071"],
}
# unattached (nuance register): verbatim tables, method/data caveats, 5★/4★/3★/2★ band notes, 042 outcomes, 083 week start, 089 escapee, 092 missing power users, 095–101 market notes, 107 trend table, 129 retention
cards = [json.loads(l) for l in open("Tools/prd_ledger/8/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/8/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values()).items()))
