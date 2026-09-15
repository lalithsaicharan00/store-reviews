"""Stage 3 merge for report 7."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C139","must-never-break","Cache entitlements locally — never block a paid surface on a live server check","Report 7: widgets that re-checked Pro against a network service showed 'Upgrade' to paying users for 15 months (100% payers, mean 2.25), 4× more often in markets with VPN/DNS filtering; render from the last-known-good receipt.")
add("C140","do","Market the generic-tracker use case","Report 7: users track medication, migraines, supplements for a pet, art-project days — any yes/no daily thing — at mean 4.91, while the listing only says 'build habits'.")
add("C141","must-have","Native iPad layout","A stretched phone UI on iPad does more rating damage than a missing Watch app and is cheaper to fix — a layout, not a new product (report 7).")
add("C142","must-have","Surface existing features where users look","Features hidden behind 'Advanced Options' or unexplained modes are rated as missing — including by payers who bought and then believed the feature absent; report 7's weekly goals, multi-habit widget and notifications.")
C["C007"]["statement"] += " Report 7: a 4-habit cap held unchanged for 3½ years was still the top 2★ theme (0 of 27 complainers paid) while 11 users said 4 was plenty — stable is not enough if the level binds the 5–8-habit user."
C["C009"]["statement"] += " Report 7: with every widget Pro, the widget paywall was the only theme with zero 5★ reviews, while widgets were the best-loved feature; users proposed one free widget, more with Pro."
C["C013"]["statement"] += " Report 7: absent for 3+ years, sync was the #1 3★/4★ theme with named willingness to pay; ship it opt-in and end-to-end (CloudKit private database) to keep a no-account privacy promise."

M = {
 "R07-003":["C002"], "R07-005":["C002"], "R07-006":["C007","C133"], "R07-007":["C007","C133"], "R07-008":["C007"],
 "R07-009":["C009"], "R07-010":["C009"], "R07-011":["C009","C107"], "R07-012":["C033","C065"], "R07-014":["C139","C033"],
 "R07-015":["C114"], "R07-016":["C013"], "R07-017":["C059"], "R07-018":["C034"], "R07-019":["C059"],
 "R07-020":["C036"], "R07-021":["C006","C012"], "R07-022":["C005","C006"], "R07-024":["C119"], "R07-026":["C064"],
 "R07-028":["C011"], "R07-029":["C020","C114"], "R07-030":["C014"], "R07-031":["C008","C006"], "R07-033":["C065"],
 "R07-035":["C065"], "R07-036":["C003"], "R07-037":["C009","C107"], "R07-038":["C009","C107"], "R07-039":["C007"],
 "R07-040":["C061"], "R07-041":["C061","C007"], "R07-042":["C064"], "R07-043":["C005","C064"], "R07-044":["C064"],
 "R07-045":["C064"], "R07-046":["C063"], "R07-047":["C077","C003"], "R07-048":["C027","C132"], "R07-049":["C037"],
 "R07-050":["C003"], "R07-051":["C093"], "R07-056":["C013"], "R07-058":["C007"], "R07-061":["C080"],
 "R07-062":["C004","C061"], "R07-063":["C012"], "R07-064":["C095"], "R07-065":["C042"], "R07-066":["C140"],
 "R07-068":["C005"], "R07-069":["C046"], "R07-070":["C031"], "R07-071":["C096"], "R07-072":["C035","C013","C096"],
 "R07-074":["C002"], "R07-076":["C141"], "R07-077":["C044"], "R07-078":["C022"], "R07-079":["C065","C031"],
 "R07-080":["C075"], "R07-082":["C021"], "R07-083":["C015"], "R07-084":["C027"], "R07-086":["C049"],
 "R07-087":["C045"], "R07-088":["C142","C043"], "R07-089":["C038"], "R07-090":["C016","C043"], "R07-091":["C038"],
 "R07-092":["C039","C142"], "R07-093":["C123"], "R07-094":["C056"], "R07-095":["C029","C033"], "R07-098":["C012"],
 "R07-099":["C012"], "R07-100":["C045","C133"], "R07-101":["C019"], "R07-102":["C028"], "R07-104":["C107","C142"],
 "R07-107":["C062"], "R07-108":["C064"], "R07-109":["C119"], "R07-110":["C092"], "R07-112":["C092","C007"],
 "R07-113":["C007"], "R07-116":["C023","C059"], "R07-118":["C006"], "R07-119":["C006"], "R07-121":["C033","C139"],
 "R07-122":["C036"], "R07-123":["C119"], "R07-124":["C038"], "R07-125":["C007","C133"], "R07-126":["C009","C107"],
 "R07-127":["C003","C077"], "R07-128":["C092"], "R07-129":["C063"], "R07-130":["C093"], "R07-131":["C013","C096"],
 "R07-132":["C142","C043"], "R07-133":["C141"], "R07-134":["C080"], "R07-135":["C016","C038"], "R07-136":["C042","C095","C134"],
 "R07-137":["C140","C134"], "R07-138":["C027"], "R07-139":["C058","C114"], "R07-141":["C007"], "R07-142":["C007","C133"],
 "R07-144":["C033"], "R07-145":["C003"],
}
# unattached (nuance register): verbatim tables, method/data caveats, 004 cohort trend, 053/054 5★ notes, 081 churn, 085 hide-completed, 096 absences, 105-106/111/113-115 market tables, 140/143 research
cards = [json.loads(l) for l in open("Tools/prd_ledger/7/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/7/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values()).items()))
