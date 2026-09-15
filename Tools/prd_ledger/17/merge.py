"""Stage 3 merge for report 17."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C196","product-rule","A subscription is a promise of continued delivery — back it with a visible cadence","Report 17: an app relaunched on a subscription went 3.5 years without a release while still charging; four of its last six reviews were about abandonment and the one paying 3★ stated the deal plainly — 'If we can get iPad and watch apps along with more regular debugging, I will keep paying. Otherwise, I am switching to Blocos.' Subscribers believe they are funding development; when it stops, the subscription has no story, and a 'lifetime' tier sold against a dormant build compounds the grievance.")
add("C197","undecided","Shift the whole day's schedule at once (global schedule shift)","Report 17: 'there is no other app that allows you to easily globally shift a schedule, rather than moving all tasks individually… invaluable for my erratic work and sleep schedule… jet lag' — named as the one capability no competitor matches, and absent from the store listing. Single source, high value.")
add("C198","must-have","Edit one instance of a repeating block without changing the series; a slipped block pushes the ones after it","Report 17: two independent 4★ users — 'I can only change ALL workout blocks in the sequence for today and everyday going forward'; adding ten minutes to a block made the next one overlap 'rather than being pushed to 7:16am'. A time-blocking app whose blocks cannot absorb a real day's slippage fails when most needed; 'If these two features are added it is definitely 5⭐️.'")
add("C199","research","System calendar integration — see appointments inside the plan","Report 17: calendar integration existed in the predecessor, was removed at relaunch ('I loved seeing my appointments, too'), and four years later is the single feature keeping the most recent payer from switching to a competitor. Reports 12 and 13 also carry calendar-integration requests.")

ext("C186", " Report 17: an abandoned one-time-purchase app relaunched as a subscription with no grandfathering, no discount and the old app left broken split one loyal base into delighted returners (4.46) and betrayed buyers (1.17); the reviewer listed the three remedies himself — grandfather, discount, or leave the old app working — none was done.")
ext("C147", " Report 17: seven reviewers rated an app they never saw ('Can't even look at the settings or examine how the app will handle cancelation'); confirmed payers averaged 3.63 against 1.14 for those blocked at the paywall — the strongest argument in a 38-review corpus for letting people in.")
ext("C075", " Report 17: a product with its own vocabulary ('what is a sequence? What is a block? What is an activity?') asked for 'a day of experimenting'; users who got through the first day gave 5★, those who didn't quit at 30 minutes — while the paywall demanded payment before that day.")
ext("C071", " Report 17: a developer who in early 2022 emailed users personally when their feature shipped had gone silent by 2023 — not an absence of ability but its exhaustion; bug reports at each iOS transition then had nobody to fix them.")
ext("C003", " Report 17 (contested): a $64.99 lifetime beside a $19.99 annual — 3.25 years of payback demanded up front from a developer with an abandonment history — drew 'three times the price of a premium word processor'; the lifetime option must be credible, not just present.")
ext("C120", " Report 17: a timeline-first day scheduler that 'queues up duties as the time approaches' was called irreplaceable by nearly a quarter of its reviewers and helped one with time blindness; a paying user proposed backward scheduling from a fixed anchor (work out the latest start for a pre-sleep sequence).")

M = {
 "R17-003":["C186","C061"], "R17-004":["C002","C147"], "R17-005":["C147","C182","C110"], "R17-006":["C003","C004","C196"], "R17-007":["C186","C003"],
 "R17-008":["C196","C071"], "R17-009":["C120","C005"], "R17-010":["C197"], "R17-011":["C042","C183","C059"], "R17-012":["C075","C147"],
 "R17-013":["C027"], "R17-016":["C199"], "R17-017":["C198"], "R17-018":["C186","C147","C003"], "R17-020":["C031","C120","C039"],
 "R17-021":["C059"], "R17-022":["C141","C198","C199","C022","C075","C044","C013","C120"], "R17-023":["C120"], "R17-024":["C005","C199","C197"],
 "R17-025":["C061","C120"], "R17-026":["C198","C199","C141","C044","C075"], "R17-027":["C196","C199"], "R17-028":["C075","C196"],
 "R17-029":["C147","C186","C002"], "R17-030":["C075","C061","C031"], "R17-031":["C147","C182"], "R17-032":["C061","C196"],
 "R17-033":["C147","C003","C186"], "R17-034":["C196","C029","C059"], "R17-035":["C027"], "R17-037":["C147","C002"], "R17-038":["C196","C071"],
 "R17-039":["C147"], "R17-040":["C031","C071"], "R17-041":["C059","C071"], "R17-042":["C141","C199","C120"], "R17-043":["C147","C110","C112"],
 "R17-044":["C075"], "R17-045":["C198"], "R17-046":["C196","C071"], "R17-047":["C141","C022","C044","C013"], "R17-048":["C199"],
 "R17-049":["C197","C134"], "R17-050":["C120","C042"], "R17-051":["C003"], "R17-052":["C186"], "R17-053":["C196"], "R17-054":["C059","C036"],
 "R17-056":["C186"], "R17-057":["C196","C071"], "R17-058":["C059","C036"],
}
# unattached (nuance register): 001-002 header/method, 014 composition, 015 inventory, 019 theme tables, 036 period table, 055 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/17/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/17/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values() if not x.get("merged_into")).items()))
