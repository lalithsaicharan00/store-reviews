"""Stage 3 merge for report 6."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C134","do","Lead the store listing with what users actually love","Report 6's most-loved feature (the free widget) was one bullet at the bottom of the description and its differentiators (no daily check-in, user-defined day boundary) were not marketed at all — yet they are why people switched.")
add("C135","free","Offer both check-in tracking and auto-counting (no daily check-in) per item","A counter that runs on its own until you declare a break is report 6's differentiator against every check-off tracker, and fits abstinence streaks best.")
add("C136","must-have","When an item can be tracked more than one way, make the user choose the mode at creation","Report 6: users who landed in the auto-count mode by default read it as the app fabricating progress (1★), and users asked for a mode that already shipped.")
add("C137","do","Show the paywall at the moment of need, not on app open","Surface the upgrade when the user tries the gated action (the third streak, a freeze); an upsell on every launch reads as 'begs me for money' and feeds the greed cluster.")
add("C138","dont","Never let the paywall imply a capability the product lacks","A buyer who paid for a feature that isn't there cancels and says 'there are free ones'; it turns a feature request into a refund cause.")
C["C007"]["statement"] += " Report 6: raising a 1-streak cap to 2 did not reduce complaints — the ask was unlimited — though the tone moved from 'scam' to 'love it, want more'."
C["C133"]["statement"] += " Report 6 contests the 'icons' part: the listing sold Premium on themes and icons and zero of 44 reviewers mentioned them."

M = {
 "R06-003":["C002"], "R06-004":["C002"], "R06-005":["C002"], "R06-007":["C007","C133"], "R06-008":["C007","C133"],
 "R06-009":["C007"], "R06-010":["C029"], "R06-011":["C029"], "R06-012":["C112","C036"], "R06-013":["C113"],
 "R06-014":["C113"], "R06-015":["C005","C064"], "R06-016":["C077"], "R06-018":["C009"], "R06-019":["C134"],
 "R06-020":["C135","C019"], "R06-021":["C135","C038","C134"], "R06-022":["C038"], "R06-023":["C136"], "R06-024":["C136","C075"],
 "R06-025":["C005"], "R06-029":["C135"], "R06-030":["C008","C039"], "R06-031":["C010"], "R06-032":["C024","C101"],
 "R06-033":["C016"], "R06-034":["C018","C133"], "R06-035":["C133","C018"], "R06-037":["C065","C077","C029"], "R06-038":["C138"],
 "R06-039":["C007"], "R06-040":["C003"], "R06-041":["C003"], "R06-042":["C137","C093"], "R06-043":["C064"],
 "R06-045":["C133","C007"], "R06-048":["C002"], "R06-050":["C002"], "R06-052":["C006"], "R06-055":["C040"],
 "R06-057":["C043"], "R06-059":["C034"], "R06-061":["C019"], "R06-062":["C103","C095"], "R06-063":["C103"],
 "R06-065":["C135","C136"], "R06-068":["C092","C002"], "R06-071":["C027"], "R06-075":["C007"], "R06-076":["C003"],
 "R06-081":["C029"], "R06-082":["C029"], "R06-083":["C077"], "R06-084":["C112","C036"], "R06-085":["C040"],
 "R06-086":["C007","C133"], "R06-087":["C003"], "R06-088":["C113"], "R06-089":["C137"], "R06-090":["C018","C133"],
 "R06-091":["C136","C075"], "R06-092":["C043"], "R06-093":["C134"], "R06-094":["C103","C095"], "R06-095":["C007","C133"],
 "R06-096":["C029"], "R06-098":["C005"], "R06-100":["C138"], "R06-101":["C007","C133"], "R06-102":["C113"],
 "R06-103":["C007"], "R06-104":["C003","C029"],
}
# unattached (nuance register): 001 002 006 017 026 027 028 036 044 046 047 049 051 053 054 056 058 060 064 066 067 069 070 072 073 074 077 078 079 080 097 099
cards = [json.loads(l) for l in open("Tools/prd_ledger/6/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/6/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values()).items()))
