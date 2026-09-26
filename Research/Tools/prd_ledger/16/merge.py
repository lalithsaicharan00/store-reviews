"""Stage 3 merge for report 16."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C191","product-rule","Never cap the tier someone has already paid for","Report 16: Pro was capped at 3 habits, then 6, for 29 months; a cap on the paid tier has no monetisation function (there is no higher tier to drive to) and two of three buyers who paid specifically to escape the free cap hit the next one and rated 3★ — 'A paid user pays $40/year just to create only 6 habits simultaneously?'")
add("C192","product-rule","A trial must end in a usable free tier, not a cliff","Report 16: a well-liked no-card 28-day trial that dropped to a one-habit tier read as a bait-and-switch — 'it encourages people to start habits and continue them for three weeks and then hits you with a steep bill' — and was the fastest-growing negative (2.4% → 7.2%). Taper, warn earlier and in-app, or keep the streak read-only.")
add("C193","must-never-break","Lapsed subscribers keep a usable free tier and read-only history","Report 16: a cancelled payer could not edit, view or even complete the one habit the free tier allows — 'It's my habit for walking my dog, who is recently deceased… I guess the app is bricked for me now.' A lapsed subscriber with read-only history is a resubscription candidate; one whose data is hostage is a permanent loss.")
add("C194","dont","Do not paywall content the user already bought elsewhere","Report 16: the daily lessons and articles restate the Atomic Habits book; paywalling them was the packaging decision reviewers found hardest to forgive ('I already read the book which only cost me $15 one time') and praise for the content fell 6.8% → 1.2% once it went behind the wall. Content free, slots paid was the corpus's proposal.")
add("C195","dont","Premium pricing on a trust-based personal brand spends the brand","Report 16: $120/yr on the official Atomic Habits app produced the lowest-rated theme in the corpus — personal attacks on James Clear ('How to ruin your brand overnight'; 'changed my view of James') — plus 69 'cash grab / greedy / predatory' reviews with zero 5★; the only negative theme still growing in 2026.")

ext("C007", " Report 16: a free tier of ONE habit drew 76 complaints at mean 2.22 ('a habit tracker that tracks one habit is not a habit tracker') and could not do trial work; 20 reviewers defended the earn-a-slot constraint at 3–6 habits (mean 4.60) — loved at 3–6, hated at 1.")
ext("C003", " Report 16: the price fell ~67% ($119.99 → $40/yr) and the objection rate did not move (31% → 30%); 37 reviews asked for a one-time SKU and Streaks was named eight times, every time for its one-time price — 'I will not rent a checklist'.")
ext("C069", " Report 16: the press-and-hold fill with a haptic reward was the product's most-praised craft ('Pavlovian in a good way'; 'I'm beginning to crave that feeling') — praise fell three-quarters after a redesign replaced the circles with a list.")
ext("C188", " Report 16: 'why in the world does ticking a box require connectivity!' — 9 reviews, zero 5★; a remote worker without internet for days could not use the app.")
ext("C065", " Report 16: 17 confirmed payers rated 1.21 stars below everyone else; five of the seven billing complaints in the corpus came from them.")
ext("C010", " Report 16: logging only today and yesterday cost earned streaks ('I forgot to log 2 days ago… my streak is permanently reset'); 33 requests from mostly 3–4★ users, unshipped for 31 months.")
ext("C076", " Report 16: a reviewer alleged the beta list was asked to 'overcome outdated reviews'; 23 self-identified beta testers were strongly bimodal and the launch rating was spent within six weeks.")
ext("C062", " Report 16 (contested): the price backlash was STRONGER in high-spend markets — a value-comparison effect ('not worth it at any price', measured against Streaks, Notion, Procreate) — while the rest of the world's complaint was language.")
ext("C002", " Report 16: the public 4.81 sat 1.21 stars above the written 3.60 — the largest gap in the set — with only 5.6% of raters writing, two-to-one about money.")

M = {
 "R16-003":["C065","C002","C064"], "R16-004":["C007","C147","C133"], "R16-005":["C191","C007"], "R16-006":["C007","C024"], "R16-007":["C192","C109","C147"],
 "R16-008":["C193","C176"], "R16-009":["C065","C033","C029","C152","C036"], "R16-010":["C003","C064","C004"], "R16-011":["C003","C025","C064"],
 "R16-012":["C002"], "R16-013":["C070","C116","C006"], "R16-014":["C185"], "R16-015":["C069","C119"], "R16-016":["C195","C025"],
 "R16-017":["C031","C034","C035","C188","C075"], "R16-018":["C080","C010","C171"], "R16-020":["C076","C054"], "R16-023":["C015","C041"],
 "R16-024":["C063","C093"], "R16-025":["C192","C110"], "R16-026":["C064"], "R16-027":["C194","C133"], "R16-029":["C003","C065"],
 "R16-030":["C043","C143","C019","C173"], "R16-031":["C012","C057","C006"], "R16-032":["C015"], "R16-033":["C035","C077","C040","C039","C036","C085","C028"],
 "R16-034":["C092","C025"], "R16-035":["C002"], "R16-036":["C042"], "R16-037":["C002","C147"], "R16-038":["C007","C191","C003","C027","C010","C043","C080","C188","C021","C022","C141"],
 "R16-039":["C005","C003"], "R16-041":["C070","C002"], "R16-042":["C002","C064"], "R16-043":["C185","C007","C194"],
 "R16-044":["C065","C033","C029","C193"], "R16-045":["C007","C191","C192","C060"], "R16-046":["C003","C064","C004"], "R16-047":["C003","C064"],
 "R16-048":["C092","C026","C025"], "R16-049":["C036","C029","C059","C193"], "R16-050":["C002"], "R16-052":["C062"], "R16-053":["C062","C064"],
 "R16-054":["C062","C003"], "R16-055":["C062","C195"], "R16-056":["C062","C027","C064"], "R16-057":["C027"], "R16-058":["C027","C035","C026","C092"],
 "R16-059":["C002","C076"], "R16-060":["C031","C075"], "R16-061":["C192","C195","C043"], "R16-062":["C003","C191","C064"], "R16-063":["C194","C069","C119"],
 "R16-064":["C080"], "R16-065":["C007","C191","C010","C027","C080","C043","C188"], "R16-066":["C007","C133"], "R16-067":["C191"], "R16-068":["C031","C075"],
 "R16-069":["C193"], "R16-070":["C036","C029"], "R16-071":["C003"], "R16-072":["C194"], "R16-073":["C025","C060"], "R16-074":["C092","C025"],
 "R16-075":["C192"], "R16-076":["C010"], "R16-077":["C080"], "R16-078":["C188"], "R16-079":["C043","C143","C173"], "R16-080":["C069","C119"],
 "R16-081":["C027"], "R16-082":["C110","C181"],
}
# unattached (nuance register): 001-002 header/method, 019 method detail, 021 composition, 022 inventory, 028 theme tables, 040 band tables, 051 storefront tables, 083 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/16/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/16/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values() if not x.get("merged_into")).items()))
