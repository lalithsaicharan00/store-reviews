"""Stage 3 merge for report 12."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C180","dont","No 'wait, don't go' exit discounts or countdown timers on the paywall","Report 12: a lifetime offer at 17.99 that drops to 5.99 when the user tries to close, a '90% off' timer that still grants no access, and a 10× regional price jump were described as 'gross' and 'another major red flag'; 42 reviewers used the word 'scam'. The ladder is also visible to every prospect as ten SKUs on the store page.")
add("C181","do","If the app is paid-only, say so in the subtitle and first screenshot","Report 12: the description already said 'purchase is required to access any content' but the price label read Free — 162 reviewers (40%) wrote a 1★ review having never seen the product. A discovery and framing failure fixable at the top of the funnel.")
add("C182","product-rule","A pre-use hard paywall makes every purchase non-evidence-based and non-durable","Report 12: no reviewer in 404 said they paid because of a feature they had seen working; purchases were made to evaluate, under an exit discount, or on the strength of the intro — and 0 of 80 self-identified payers rated 5★. What the gate protects must be able to survive inspection: 13 buyers said it was a worse version of Apple Calendar.")
add("C183","must-have","A pre-planned, structured day is the outcome ADHD and autistic users praise","Report 12: 'I lose track of time, forget to do things, and never have a plan, but that girl made sure I DID have a plan' — the one narrow, consistent praised outcome (22 reviews, mean 4.95) is being told what the day looks like.")
add("C184","research","Gendered branding narrows the audience; a neutral name is already tested","Report 12: four reviewers objected to a girls-only brand ('I don't think a todo app should be targeted at one certain gender'); the developer ships a gender-neutral name in es/mx, the two highest-rated storefronts in the sample — an existing A/B result to measure.")
add("C185","insight","Aesthetic and a polished onboarding convert; they do not retain","Report 12: 17 reviewers praised the design and 11 of them rated 1–2★; nine 5★ reviews praised the narrated intro before using the product; 'The intro before you purchase seems to have more thought put into it than the actual app itself.' See also report 9's warm shell over a thin product.")

ext("C147", " Report 12: a hard paywall with nothing evaluable produced a paywall corpus — 46.5% of 404 reviews complain about the gate, 172 reviewers left without ever seeing the product, and the theme never dropped below a third of reviews in any year.")
ext("C033", " Report 12: 40% of self-identified payers reported that payment did not grant access (paywall re-appears, 'no subscription found', Restore Purchase redirecting to the privacy policy, HTTP 400 at login, re-purchase demanded on a new device) — rising to 12.6% of all 2025 reviews.")
ext("C150", " Report 12: an in-app instruction to rate 5★ during onboarding — 'It said I had to give them 5 starts so here I am' — was called out by 23 reviewers, two of whom named the exact 4.8 store aggregate; 14 of 77 five-star reviews contradict their own rating.")
ext("C109", " Report 12: a 3-day trial introduced around 2024 shows as subscribed but 'doesn't move past the subscription screen' — the complaint changed shape from 'there is no trial' to 'the trial doesn't work'.")
ext("C036", " Report 12: five reviewers said the listed support email does not exist; refund and support failures were twice as prevalent in small storefronts, where users are charged and stranded.")
ext("C075", " Report 12: an unskippable narrated intro drew 21 complaints peaking at 16% of 2024 reviews, then fell to one review after a skip control landed — the corpus's clearest fix — while the same intro is praised as a conversion asset.")
ext("C177", " Report 12: ten SKUs including three 'Weekly Subscription' and two 'One-Time Payment' entries at different prices, visible on the store page.")
ext("C043", " Report 12: weekday-only repeats were asked for in Jul 2022 and still missing in May 2026 — three years and ten months.")
ext("C009", " Report 12: widget requests appeared only from Nov 2024 and came from retained payers ('I forget all the time to use this app cause I don't have a widget') — the highest-mean complaint theme.")

M = {
 "R12-003":["C150","C002"], "R12-004":["C002"], "R12-005":["C147","C182"], "R12-006":["C181","C110"], "R12-007":["C065","C182","C002"],
 "R12-008":["C033","C029","C065"], "R12-009":["C036","C029","C033"], "R12-010":["C150","C002"], "R12-011":["C075","C185"], "R12-012":["C075","C059"],
 "R12-013":["C182","C005"], "R12-014":["C031","C034","C038","C043","C030"], "R12-015":["C009"], "R12-016":["C183","C042"], "R12-017":["C185"],
 "R12-019":["C177","C113","C180"], "R12-020":["C180","C113","C092"], "R12-021":["C147"], "R12-022":["C048"], "R12-023":["C022","C141"],
 "R12-024":["C155"], "R12-026":["C063","C147"], "R12-027":["C064"], "R12-028":["C027","C039","C012","C059"], "R12-029":["C089"],
 "R12-030":["C184"], "R12-031":["C085"], "R12-032":["C042","C183"], "R12-034":["C015"], "R12-035":["C147","C065"],
 "R12-037":["C002","C150"], "R12-038":["C022","C141","C075","C184"], "R12-039":["C036"], "R12-040":["C185"], "R12-041":["C182","C180","C185","C089"],
 "R12-042":["C185","C075"], "R12-043":["C065","C033"], "R12-044":["C147","C064","C022","C141"], "R12-045":["C022","C141"], "R12-046":["C103","C025"],
 "R12-047":["C065","C033","C036"], "R12-050":["C062"], "R12-051":["C036","C062"], "R12-052":["C062","C002"], "R12-053":["C027"],
 "R12-054":["C184"], "R12-055":["C085","C033"], "R12-057":["C147"], "R12-058":["C109","C063"], "R12-059":["C033"],
 "R12-060":["C075","C059"], "R12-061":["C150","C002"], "R12-062":["C030","C038","C175"], "R12-063":["C059"], "R12-064":["C009"],
 "R12-065":["C089"], "R12-066":["C043","C039","C182"], "R12-067":["C033"], "R12-068":["C036"], "R12-069":["C033"], "R12-070":["C085"],
 "R12-071":["C181"], "R12-072":["C150","C094"], "R12-073":["C177","C180"], "R12-074":["C009"], "R12-075":["C038","C043","C030","C072"],
 "R12-076":["C048","C118"], "R12-077":["C141"], "R12-078":["C147","C063"], "R12-079":["C182"], "R12-080":["C027"], "R12-081":["C184"],
 "R12-082":["C147","C182","C185"], "R12-083":["C183","C075","C009","C022","C141","C043"], "R12-085":["C182","C180","C150","C033","C036"],
}
# unattached (nuance register): 001-002 header/method, 018 store facts, 025 theme table, 033 complaint types, 036-037 band tables & 5★ audit,
# 048 cannot claim, 049 US table, 056 period table, 084 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/12/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/12/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values() if not x.get("merged_into")).items()))
