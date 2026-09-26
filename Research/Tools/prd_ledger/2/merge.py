"""Stage 3 merge for report 2: attach cards to canonical.json, creating new points where nothing fits."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C071","dont","Never ship and walk away","Abandonment is visible to users within a year; the app becomes an OS-release liability for paying users with no recourse, while the store rating quietly rises on survivorship.")
add("C072","must-never-break","Writes to shared system stores (calendar, health) must be exact and reversible","A paid calendar sync that corrupts the user's calendar is the most severe complaint class in report 2.")
add("C073","free","Manual habit reordering","Trivial, requested for years by 5★ users; best effort-to-goodwill ratio.")
add("C074","free","Customisable, louder reminder sounds","Asked by happy users; the cheapest 5★ upgrade.")
add("C075","must-have","Skippable, replayable onboarding tour","Hidden gestures (swipe-to-complete, mode toggles) confuse new users; a US-specific 6% complaint in report 2.")
add("C076","dont","Never seed launch reviews","Users spot it in week one and say so; it contaminates the analytics baseline permanently.")
add("C077","must-never-break","Purchase and signup flow must not leak buyers","People who try to pay and cannot (errors, rejected emails, promos that fail to apply) leave 2–4★ and money on the table.")
add("C078","product-rule","Ship the paid feature working before you sell it","Paid features carry a higher reliability bar; selling broken sync/calendar/stats put payers a full star below free users.")
add("C079","undecided","Personal photos as habit icons","Rare, loved, and no competitor in report 2's corpus offers it.")
add("C080","free","Colour themes / dark mode","'Only green' draws requests; cheap.")
add("C082","research","Ads in the free tier","A mild negative and a minor purchase reason in report 2; 'no ads' is the best-rated topic in report 1.")
add("C083","must-never-break","Performance must not degrade with habit count","5+ second taps for the most engaged (paying) users; lag is a churn cause on its own.")
add("C085","do","Address tracking / privacy visibly","One unrebutted 1★: 'a whole lotta tracking going on by the developer'.")
add("C087","dont","Never imply cross-app integration you don't have","Sibling apps raised expectations of integration; the purchases it drove ended in 1★.")
add("C088","dont","No rating-prompt or cross-promo spam, especially to payers","Small but consistent complaint.")
# widen two existing titles
C["C038"]["title"] = "Dates, streaks and statistics correct on every surface (incl. DST / timezone)"
C["C038"]["statement"] += " Off-by-one dates across app/widget/Watch were report 2's longest-lived bug."
C["C049"]["title"] = "Mood tracker / journal / habit notes"

M = {
 "R02-003":["C002"], "R02-004":["C071"], "R02-006":["C062"], "R02-008":["C076"], "R02-009":["C002"],
 "R02-010":["C007"], "R02-011":["C003","C004"], "R02-013":["C013","C030"], "R02-014":["C072"], "R02-015":["C011"],
 "R02-016":["C017"], "R02-017":["C078","C065"], "R02-018":["C007","C008","C009","C019","C022","C015","C079"],
 "R02-020":["C003"], "R02-021":["C013","C030"], "R02-022":["C060"], "R02-023":["C082"], "R02-024":["C065"],
 "R02-025":["C065"], "R02-026":["C065","C034"], "R02-027":["C029","C065"], "R02-028":["C077"], "R02-029":["C027"],
 "R02-030":["C011","C007"], "R02-031":["C078"], "R02-032":["C065"], "R02-033":["C078","C007"], "R02-034":["C077"],
 "R02-035":["C087"], "R02-037":["C007"], "R02-038":["C005"], "R02-040":["C031"], "R02-041":["C034"],
 "R02-042":["C022"], "R02-044":["C074"], "R02-046":["C006"], "R02-047":["C007"], "R02-048":["C008","C039"],
 "R02-049":["C009"], "R02-050":["C079"], "R02-051":["C009"], "R02-052":["C072"], "R02-053":["C005"],
 "R02-055":["C031","C034"], "R02-056":["C034"], "R02-057":["C038"], "R02-058":["C022"], "R02-059":["C072"],
 "R02-060":["C039"], "R02-061":["C075"], "R02-062":["C083"], "R02-063":["C057"], "R02-064":["C082","C006"],
 "R02-065":["C088"], "R02-067":["C011"], "R02-068":["C043"], "R02-069":["C074"], "R02-070":["C073"],
 "R02-071":["C049"], "R02-072":["C080"], "R02-073":["C087"], "R02-074":["C009","C071"], "R02-076":["C065","C062"],
 "R02-077":["C075"], "R02-078":["C042"], "R02-079":["C027"], "R02-080":["C085"], "R02-081":["C015"],
 "R02-082":["C005"], "R02-084":["C039"], "R02-085":["C027","C074"], "R02-086":["C027","C083","C038","C034"],
 "R02-087":["C062","C065"], "R02-088":["C027"], "R02-092":["C038","C059"], "R02-093":["C031","C034","C071"],
 "R02-094":["C003","C007"], "R02-096":["C036","C059"], "R02-097":["C056"], "R02-098":["C034"], "R02-099":["C031","C083"],
 "R02-100":["C038"], "R02-101":["C022"], "R02-102":["C072"], "R02-103":["C003"], "R02-104":["C007"],
 "R02-105":["C078"], "R02-106":["C077"], "R02-107":["C043"], "R02-108":["C073"], "R02-109":["C074"],
 "R02-110":["C011"], "R02-111":["C079"], "R02-112":["C075"], "R02-113":["C003","C007"], "R02-114":["C087","C060"],
 "R02-115":["C071"], "R02-116":["C088"], "R02-117":["C076"], "R02-119":["C036"], "R02-120":["C022"], "R02-121":["C007"],
}
# unattached (nuance register): 001 002 005 007 012 019 036 039 043 045 054 066 075 083 089 090 091 095 118
cards = [json.loads(l) for l in open("Tools/prd_ledger/2/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/2/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical points; {len(cards)-len(null)} attached; {len(null)} unattached: {null}")
both = [x["id"] for x in C.values() if set(x["reports"]) >= {1,2}]
print(f"{len(both)} points now supported by both reports:", both)
