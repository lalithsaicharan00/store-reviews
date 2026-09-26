"""Stage 3 merge for report 5."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C120","must-have","Sequential routine timer with spoken next step and live finish-time estimate","Report 5's product thesis: removes the need to hold a schedule in working memory and says continuously whether you are still on time; 162 reviewers report they stopped being late. The voice needs an off switch.")
add("C121","must-have","Untimed / checklist mode as a per-routine toggle","A real minority of the ADHD audience finds a mandatory timer anxiety-inducing; the fix is an option per routine, not a separate object.")
add("C122","must-never-break","Background battery and thermals","A background timer that drains 30–90% of daily battery and heats the device is report 5's worst non-billing theme (mean 2.94) and loses subscribers who otherwise love the app.")
add("C123","must-have","Notification escalation must be user-configurable, never silently retuned","Some users depend on an un-dismissable alarm, others are driven out by it; a global default serves both badly; removing it broke wake-ups for loyal subscribers.")
add("C127","product-rule","Never show ads to paying subscribers","Including reward-gated features like streak savers; a 30-second unskippable ad to a payer is the most reliable way to turn an advocate into a 1★.")
add("C130","do","Use the lead-user market as the beta cohort","Report 5's home market (Korea) carries the deepest engineering feedback and most detailed feature specs — and uses the review page as a support desk.")
add("C131","dont","No default-on social feed in a personal tool","Unwanted by a vocal minority, and a child-safety liability when minors and adults share a feed on a 17+ app.")
add("C132","dont","Do not sell in a storefront where the app cannot function","Seven years of 'will not open' from mainland China, with users charged for an app that shows 'no network'.")
add("C133","product-rule","Gate on capability, not on quantity","A quantity cap set above the point of core value is noticed, tolerated and does not convert; move the wall to analytics, sync, Watch, widgets, icons, family sharing. See Research Reports/Feature Gating vs Quantity.md.")
C["C038"]["statement"] += " Night routines that cross midnight must log to the day they started, honouring a user 'day ends at' setting."
C["C036"]["title"] = "A support channel that exists, is reachable outside the app, and answers"
C["C036"]["statement"] += " Report 5: the only support link was inside an app that would not launch; email went unanswered while public review replies were same-day."
C["C090"]["title"] = "Destructive actions on widgets, quick surfaces and running routines need confirmation or undo"
C["C089"]["title"] = "Promos, giveaways and gift codes must work exactly as advertised"
C["C089"]["statement"] += " Report 5's '1+1' gift code could not be used by the buyer and expired in three months — six years of disputes."
C["C061"]["title"] = "Goodwill conversion — a generous free tier and 'support the devs'"
C["C061"]["statement"] += " Report 5: the dominant purchase path was years of free use followed by upgrading to scale it or to say thanks."

M = {
 "R05-003":["C120","C042"], "R05-004":["C002"], "R05-005":["C002","C065"], "R05-006":["C120"], "R05-007":["C120"],
 "R05-008":["C042"], "R05-009":["C007","C133"], "R05-010":["C031","C039"], "R05-011":["C022","C059"], "R05-013":["C007"],
 "R05-014":["C120","C007"], "R05-015":["C009"], "R05-016":["C011"], "R05-017":["C074","C049"], "R05-018":["C001"],
 "R05-019":["C127","C001"], "R05-020":["C003"], "R05-021":["C064"], "R05-022":["C061","C007"], "R05-023":["C007"],
 "R05-024":["C022"], "R05-025":["C004"], "R05-026":["C061"], "R05-027":["C065"], "R05-028":["C127"],
 "R05-029":["C109","C029"], "R05-030":["C089"], "R05-031":["C003"], "R05-032":["C092"], "R05-033":["C001","C082"],
 "R05-034":["C094"], "R05-038":["C006"], "R05-039":["C042","C006"], "R05-041":["C120","C121"], "R05-042":["C024"],
 "R05-043":["C007","C061"], "R05-044":["C059"], "R05-045":["C118"], "R05-047":["C031"], "R05-048":["C110","C007"],
 "R05-049":["C030"], "R05-050":["C009","C023"], "R05-051":["C083"], "R05-052":["C046"], "R05-053":["C120"],
 "R05-054":["C132"], "R05-055":["C122"], "R05-056":["C039"], "R05-057":["C123","C001"], "R05-058":["C034","C035"],
 "R05-059":["C036"], "R05-060":["C027"], "R05-061":["C121"], "R05-062":["C090"], "R05-063":["C038"],
 "R05-064":["C131","C103"], "R05-065":["C028"], "R05-066":["C042"], "R05-067":["C037","C068"], "R05-069":["C043","C045"],
 "R05-070":["C044","C051"], "R05-071":["C080"], "R05-073":["C036","C112","C130"], "R05-074":["C027","C034"], "R05-075":["C027"],
 "R05-077":["C132"], "R05-080":["C022","C007"], "R05-081":["C119"], "R05-082":["C056","C093"], "R05-083":["C002"],
 "R05-084":["C039"], "R05-085":["C123"], "R05-086":["C122"], "R05-087":["C090"], "R05-088":["C034","C035"],
 "R05-089":["C038"], "R05-090":["C036","C112"], "R05-091":["C133","C007"], "R05-092":["C003"], "R05-093":["C037"],
 "R05-094":["C127"], "R05-095":["C109"], "R05-096":["C089"], "R05-097":["C094"], "R05-098":["C121"],
 "R05-099":["C043","C045"], "R05-100":["C009","C023"], "R05-101":["C046"], "R05-102":["C027"], "R05-103":["C028"],
 "R05-104":["C131","C103"], "R05-105":["C132"], "R05-106":["C059","C036"], "R05-109":["C123","C121"], "R05-110":["C007","C133"],
}
# unattached: 001 002 012 035 036 037 040 046 068 072 076 078 079 107 108
cards = [json.loads(l) for l in open("Tools/prd_ledger/5/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/5/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values()).items()))
