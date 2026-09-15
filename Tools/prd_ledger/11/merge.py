"""Stage 3 merge for report 11."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C176","product-rule","Never let fear of losing history be the reason people pay","Report 11: the only stated purchase motive was 'I had 3 years worth of history I didn't want to lose' on an app with no export or backup; when the entitlement then failed, the loyal long-tenure user became the 1★ 'scam' review. Sell durability (backup, export, long-history analytics) as a gain, never gate access to what the user already built.")
add("C177","must-have","Every IAP SKU has a distinct name that states its period or 'one time'","Report 11: three SKUs shared the identical display name 'Habits PRO Functions' at $1.99 / $6.99 / $8.99 and none named a period, while reviewers described 'annual', 'VIP' and 'lifetime' purchases — neither the user nor support could tell what had been bought.")
add("C178","do","A quiet, adult, non-gamified tracker is a positioning some users actively seek","Report 11: 'Functional, no frills and no infantilization. I tested half a dozen similar apps before finding this one'; 'I hate apps that demand set times'; 'without any imposed junk' — four of 33 reviewers chose the app for what it refuses to do, and three switched from gamified competitors. A live tension with the pet/mascot category norm.")
add("C179","dont","Do not run a paid twin app beside the free app","Report 11: a separate 'Lifetime Premium' binary collected one rating in six years, ran a version behind, undercut the in-app lifetime SKU by $5 and created a second entitlement surface that plausibly fed the 'lifetime subscription… suddenly cancelled' confusion.")

ext("C001", " Report 11: an app whose third-largest praise theme was 'it's free' ('all functions are free', Dec 2025) retrofitted a paywall by Apr 2026 with no disclosure; five years without a sub-4★ review ended in three 1–2★ reviews in nine days.")
ext("C033", " Report 11: 3 of 3 paid reviewers lost purchased access — a lifetime non-consumable expired, a subscription re-locked after a week and reinstall did not restore, an active annual term was re-charged — and two titled their reviews 'scam' and 'Purchase fraud'.")
ext("C007", " Report 11: 'First app that has more than 3 habits' was a reviewer's entire body — no cap was the acquisition wedge against the category, and whether it survived the paywall retrofit is unknown.")
ext("C036", " Report 11: 'there is no way in app to talk with developer or team' — with no support queue, billing bugs were filed as public 1★ fraud accusations instead.")
ext("C104", " Report 11: the store description still discloses no paywall at all (0 mentions of premium/subscription/free/unlock) after the retrofit; a grandfathering rule for pre-2026 users is the recommended fix.")

M = {
 "R11-003":["C001","C065","C033"], "R11-004":["C001","C033","C002"], "R11-005":["C033","C029","C036"], "R11-006":["C001","C104"],
 "R11-007":["C176","C020","C153"], "R11-008":["C113","C110","C177"], "R11-009":["C082"], "R11-010":["C006","C095","C093"],
 "R11-011":["C178","C005","C117"], "R11-012":["C007","C001"], "R11-013":["C073","C012"], "R11-014":["C012","C011","C080","C153"],
 "R11-015":["C062","C092"], "R11-017":["C008","C101","C012"], "R11-018":["C056"], "R11-019":["C179"], "R11-020":["C033","C065"],
 "R11-021":["C061"], "R11-022":["C006","C095"], "R11-024":["C080","C012"], "R11-026":["C033","C065"], "R11-029":["C178","C140"],
 "R11-031":["C057"], "R11-032":["C064","C029"], "R11-034":["C178","C153"], "R11-035":["C033","C176"], "R11-036":["C033","C036","C113","C110"],
 "R11-037":["C001","C104"], "R11-038":["C036"], "R11-041":["C027"], "R11-042":["C092","C062"], "R11-046":["C134"],
 "R11-048":["C001","C033"], "R11-049":["C001","C061"], "R11-050":["C059"], "R11-052":["C153","C073","C012"],
 "R11-054":["C033","C029"], "R11-055":["C033"], "R11-056":["C036"], "R11-057":["C177"], "R11-058":["C059"], "R11-059":["C110"],
 "R11-060":["C001","C104"], "R11-061":["C179"], "R11-062":["C153","C020","C013"], "R11-063":["C073"], "R11-065":["C007"],
 "R11-066":["C013","C133","C176"], "R11-067":["C006","C093","C082"], "R11-068":["C092"], "R11-069":["C056","C178"],
}
# unattached (nuance register): 001-002 header/method, 016 inventory table, 023 5★ roadmap volunteers, 025 no-3★ band, 027-028 praise tables,
# 030/033/039 complaint table & absences & limits, 040/043-045/047 market & language tables, 051 length trend, 053 overwritten-review caveat,
# 064 verify shipped state, 070 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/11/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/11/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values() if not x.get("merged_into")).items()))
