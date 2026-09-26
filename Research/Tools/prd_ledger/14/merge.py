"""Stage 3 merge for report 14."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text

ext("C093", " Report 14: the cleanest before/after in the set — rating-and-upsell pop-ups on every launch drew six star-docking reviews in nine weeks ('I docked one star for this'; 'Deleted'), and removing them produced unsolicited 5★ praise ('They removed the pop ups. Nice!!') and a named edge over a rival still 'begging for an upgrade within the first minute'.")
ext("C094", " Report 14: at least three reviews existed only because the app demanded one ('Happy now??'; a body reading 'Review'), polluting the ratings data.")
ext("C077", " Report 14: two willing buyers in 2020 could not complete the purchase ('When I click upgrade button, it only appears an orange screen and then disappears') — the checkout broke in the app's final months.")
ext("C034", " Report 14: data lost on update was the only theme with a perfect 1★ record and the corpus's only 'stay away' review; it recurred 5.5 years later ('backdate all my progress by memory (again)').")
ext("C003", " Report 14: a $1.99–$3 one-time unlock produced zero refund, unexpected-charge or restore complaints in 70 reviews — a materially cleaner record than the subscription apps in the set.")
ext("C007", " Report 14: a 3-habit free cap drew its only 1★ free-tier complaint; the report's reading is that the cap must be generous enough to create the streak that creates the desire to pay.")
ext("C071", " Report 14: a solo-developer app broke at each major iOS transition ('Same thing happened with iOS 13 and it took them a while to fix it'), went five years without an update, and the last thing the corpus records is the product and its checkout failing at once.")
ext("C188", " Report 14: 'works fully offline' was one of two named reasons a reviewer chose this app over rivals already tried.")

M = {
 "R14-003":["C006","C005","C002"], "R14-004":["C093","C094"], "R14-005":["C094","C002","C093"], "R14-006":["C034","C175"],
 "R14-007":["C031","C071","C175"], "R14-008":["C077","C007","C003","C061"], "R14-009":["C036","C059","C089"], "R14-011":["C027"],
 "R14-015":["C188","C019","C143"], "R14-016":["C003","C007","C104"], "R14-018":["C011","C008","C024","C010","C059"],
 "R14-019":["C007","C075","C071"], "R14-020":["C059"], "R14-021":["C027","C141","C011","C143","C080","C075","C043","C009"],
 "R14-022":["C043","C014"], "R14-023":["C005","C006","C188","C010"], "R14-024":["C059"], "R14-025":["C093","C077"],
 "R14-026":["C027"], "R14-027":["C093","C094"], "R14-028":["C031","C034"], "R14-029":["C093","C007","C071"],
 "R14-031":["C007","C137","C063","C061"], "R14-032":["C077","C093","C011","C104"], "R14-033":["C003","C029"], "R14-034":["C027","C062"],
 "R14-037":["C031","C034"], "R14-038":["C093","C094"], "R14-039":["C031","C071","C059"], "R14-040":["C077","C071"], "R14-041":["C006","C071"],
 "R14-042":["C034","C175","C153"], "R14-043":["C031","C175"], "R14-044":["C093","C094"], "R14-045":["C077"], "R14-046":["C038"],
 "R14-047":["C043","C014"], "R14-048":["C011","C012"], "R14-049":["C188","C010","C134"], "R14-050":["C071"], "R14-051":["C027"],
 "R14-052":["C141","C009","C080","C143","C171"], "R14-053":["C003","C063"], "R14-054":["C007"], "R14-055":["C137","C093"],
 "R14-056":["C036","C059"], "R14-058":["C093","C094"],
}
# unattached (nuance register): 001-002 header/method, 010 cannot claim, 012 solicited-ratings caveat, 013 composition, 014 inventory,
# 017 theme tables, 030 evidence base, 035 year table, 036 review-volume hole, 057 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/14/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/14/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values() if not x.get("merged_into")).items()))
