"""Stage 3 merge for report 9."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C147","product-rule","Let people use the product before they pay","Users forgive a price; they do not forgive paying blind. Report 9's hard paywall before any experience produced 159 'let me look before you charge me' reviews at mean 1.79, and buyers who paid before seeing the product became the angriest cohort (mean 1.94).")
add("C148","must-have","The paid product must deliver what the ads and onboarding demonstrate","Report 9 showed an interactive guided-breathing coach in its ads and onboarding, then never offered it again — 'it's just a checklist' became the worst-rated major theme (99 reviews, mean 1.45), half of them from payers.")
add("C149","must-never-break","Respect Reduce Motion — no rapid flashing animation","A self-care app's fast animation was reported as a seizure/vertigo risk (report 9, promoted as a safety finding despite one review).")
add("C150","dont","Never ask for a rating before the user has used the app","Report 9 put the rating prompt inside sign-up: users were asked for 5★ before seeing the app, the public rating ran 1.35 stars above written reviews, and Apple's guidelines forbid it.")
add("C151","must-never-break","Never cap or paywall a support conversation mid-crisis","Report 9's AI coach hit its free message cap while a user was 'almost having a collapse'; an emotional-support chat needs an uncapped crisis path and a handoff to real help.")
C["C063"]["statement"] += " Report 9: no trial in most storefronts drew 52 explicit requests, several saying they would have bought — and a trial offered in the US but not Saudi Arabia was compared in public."
C["C093"]["statement"] += " Report 9: upsell-pressure complaints quintupled (2.16% → 4.84% → 10.23%) as the funnel was tuned harder, becoming the fastest-growing 1★ source."
C["C089"]["statement"] += " Report 9: an advertised 3-month money-back guarantee was not honoured (17 reviews); withdrawing the claim zeroed those complaints and halved refund complaints."
C["C132"]["statement"] += " Report 9: in Russia 46% of reviews say the app loads for minutes or only works over a VPN, while 32% of Russian reviewers had paid."

M = {
 "R09-003":["C147"], "R09-004":["C002"], "R09-008":["C147","C002"], "R09-009":["C063","C147"], "R09-010":["C093"],
 "R09-011":["C112","C036"], "R09-012":["C089"], "R09-013":["C089"], "R09-014":["C112"], "R09-015":["C029"],
 "R09-016":["C036"], "R09-019":["C042","C095"], "R09-020":["C042","C093"], "R09-021":["C148","C114"], "R09-022":["C148"],
 "R09-023":["C114","C148"], "R09-025":["C111"], "R09-026":["C148","C111"], "R09-027":["C103"], "R09-030":["C132","C031"],
 "R09-031":["C145","C031"], "R09-032":["C027"], "R09-033":["C031","C034"], "R09-035":["C118"], "R09-036":["C049"],
 "R09-037":["C009"], "R09-038":["C117"], "R09-039":["C022","C141"], "R09-040":["C020"], "R09-041":["C113"],
 "R09-042":["C109"], "R09-043":["C109"], "R09-044":["C113","C093"], "R09-045":["C110"], "R09-046":["C110","C061"],
 "R09-047":["C007"], "R09-050":["C043","C143","C016"], "R09-051":["C073","C114"], "R09-052":["C118","C148"], "R09-053":["C045","C073"],
 "R09-054":["C080"], "R09-055":["C048","C143"], "R09-056":["C074"], "R09-057":["C010"], "R09-058":["C011"],
 "R09-059":["C050"], "R09-060":["C149"], "R09-061":["C039"], "R09-062":["C095","C103"], "R09-063":["C057"],
 "R09-064":["C117"], "R09-065":["C114"], "R09-066":["C005","C148"], "R09-067":["C027"], "R09-068":["C027"],
 "R09-070":["C150","C094"], "R09-075":["C110"], "R09-076":["C148"], "R09-078":["C065"], "R09-079":["C065"],
 "R09-081":["C065"], "R09-082":["C033","C077"], "R09-083":["C002"], "R09-084":["C065"], "R09-085":["C147"],
 "R09-086":["C148"], "R09-087":["C112","C036"], "R09-088":["C059"], "R09-091":["C112"], "R09-092":["C132"],
 "R09-093":["C026","C132"], "R09-094":["C042"], "R09-095":["C005"], "R09-096":["C113"], "R09-099":["C145"],
 "R09-101":["C063","C147"], "R09-108":["C031","C132"], "R09-109":["C119"], "R09-110":["C093"], "R09-111":["C151","C103"],
 "R09-112":["C146"], "R09-115":["C132","C031"], "R09-116":["C150"], "R09-117":["C036","C112"], "R09-118":["C151"],
 "R09-119":["C103"], "R09-120":["C113"], "R09-121":["C074"], "R09-122":["C147"], "R09-123":["C063","C109"],
 "R09-124":["C093"], "R09-125":["C110"], "R09-127":["C148"], "R09-128":["C148","C118"], "R09-129":["C043","C143"],
 "R09-130":["C073"], "R09-131":["C045"], "R09-132":["C080"], "R09-133":["C010"], "R09-134":["C027"],
 "R09-135":["C009","C141","C022"], "R09-136":["C095","C110","C027"], "R09-137":["C063"], "R09-138":["C093"], "R09-139":["C111"],
 "R09-140":["C148"], "R09-141":["C148"], "R09-143":["C132"], "R09-144":["C065"], "R09-145":["C089"],
 "R09-146":["C103"], "R09-147":["C150"],
}
# unattached (nuance register): header/method, verbatim tables, 005 prioritised ask, 018 organise loop, 028 onboarding exclusions, 071 mismatch, 072-074/077 band notes, 080 paid table, 089 limits, 090/097/098/100/102-107 market & trend tables, 113/114/126 notes, 142 research
cards = [json.loads(l) for l in open("Tools/prd_ledger/9/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/9/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values()).items()))
