"""Batch-end consolidation after report 62 (Report Synthesis Prompt, run order step 5). Closes the 52–62 batch; consolidate_60.py ran two reports earlier.
Covers the canonical points created or extended by reports 52-62 (C269-C278 and every older point they touched).
Over canonical.json only. Merges true duplicates, widens a title its evidence has outgrown, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/62/merge.py.
"""
import json, glob
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 62 (batch end)"

def merge(src, dst, title=None, section=None, note="", statement_add=""):
    s, d = C[src], C[dst]
    if s.get("merged_into"): return
    moved = [c for c in s["cards"] if c not in d["cards"]]
    d["cards"] += moved
    d["reports"] = sorted(set(d["reports"]) | set(s["reports"]))
    d["merged_from"].append({"from": src, "title": s["title"], "section": s["section"], "cards": s["cards"], "when": WHEN, "note": note})
    if title: d["title"] = title
    if section: d["section"] = section
    # the source statement is carried over whole, so no evidence is lost
    add = statement_add + " [Merged from " + src + ": " + s["statement"] + "]"
    if s["statement"] not in d["statement"]: d["statement"] += add
    s["merged_into"] = dst; s["cards"] = []; s["reports"] = []
    s["merged_from"].append({"into": dst, "when": WHEN})

def narrow(cid, title, note, statement_add=""):
    x = C[cid]
    if any(m.get("narrowed") == WHEN for m in x["merged_from"]): return
    x["merged_from"].append({"narrowed": WHEN, "old_title": x["title"], "note": note})
    x["title"] = title
    if statement_add and statement_add not in x["statement"]: x["statement"] += statement_add

# 1. true duplicates — a title-overlap sweep of the 187 live points touched by reports 52–62 (Jaccard ≥ 0.3 on title tokens)
#    surfaced only C066/C144, C063/C109 and C019/C102, each a different decision (a feature vs a bundle; a research question vs a
#    must-never-break; a quit mode vs an inverse counter). C278 (name collision) is distinct from C184 (gendered branding).
#    C143 (count N times a day) and C048 (units / partial progress) both took report 62 evidence and stay separate: count vs value.
#    No merge this pass; C277 → C214 was already folded in by consolidate_60.py.

# 2. a title the attached evidence has outgrown
narrow("C231", "Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings",
       note="reports 59, 60 and 62 attached three kinds of evidence beyond the original per-storefront rating split: removing one storefront (RU) removes billing complaints but not praise (59); a US-vs-rest split that is a funnel-stage split — bought-and-disappointed vs stopped-at-the-door (60); and written-vs-public gaps of up to −3.56 stars per storefront with a 5★ band that is 17.6% non-endorsements (62) — the point is now about what the review channel measures, not only about one billing-driven rating gap",
       statement_add=" (Consolidation after report 62: the title was widened from 'Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone' to cover the channel dimension the batch added; the original storefront finding stays in the statement.)")

json.dump(L, open(P, "w"), indent=1, ensure_ascii=False)
live = [x for x in L if not x.get("merged_into")]
print(f"{len(L)} entries, {len(live)} live; merged away this pass: {[x['id'] for x in L if any(m.get('into') and m.get('when') == WHEN for m in x['merged_from'])]}")

# 3. integrity check: every attached card exists; reports derived from cards; no card lost
allcards = {}
for f in glob.glob("Tools/prd_ledger/*/cards.jsonl"):
    for l in open(f):
        if l.strip():
            c = json.loads(l); allcards[c["id"]] = c
bad = 0
attached = set()
for x in live:
    for cid in x["cards"]:
        if cid not in allcards: print("  missing card", x["id"], cid); bad += 1
        attached.add(cid)
    rep = sorted({allcards[c]["report"] for c in x["cards"] if c in allcards})
    if rep != sorted(x["reports"]): x["reports"] = rep
for x in L:
    if x.get("merged_into"):
        assert not x["cards"], x["id"]
        assert not C[x["merged_into"]].get("merged_into"), (x["id"], "chain")
# every card that named a canonical point is still reachable through a live point
for c in allcards.values():
    for cid in c.get("canonical", []):
        tgt = cid
        while C[tgt].get("merged_into"): tgt = C[tgt]["merged_into"]
        if c["id"] in C[tgt]["cards"]: continue
        # earlier passes split cards off into a new point (merged_from: split_to); follow that lineage
        homes = [x["id"] for x in live if c["id"] in x["cards"]]
        lineage = {m["split_to"] for m in C[tgt]["merged_from"] if m.get("split_to") and c["id"] in m.get("cards", [])}
        if not (set(homes) & lineage): print("  unreachable", c["id"], cid, "->", tgt, homes); bad += 1
json.dump(L, open(P, "w"), indent=1, ensure_ascii=False)
print("integrity:", "ok" if not bad else f"{bad} problems")
