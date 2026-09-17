"""Batch-end consolidation after report 75 (Report Synthesis Prompt, run order step 5). Closes the 64–75 batch; consolidate_70.py ran five reports earlier.
Covers the canonical points created or extended by reports 64-75 (C279-C293 and every older point they touched).
Over canonical.json only. Merges true duplicates, widens a title its evidence has outgrown, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/75/merge.py.
"""
import json, glob
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 75 (batch end)"

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

# 1. true duplicates — a title-overlap sweep of the 174 live points touched by reports 64–75 (Jaccard ≥ 0.25 on title tokens)
#    surfaced only pairs adjudicated in earlier passes (C063/C109, C066/C144, C023/C069, C147/C176, C016/C102, C204/C194, …).
#    The three points created since consolidate_70 were checked by hand:
#    C291 (a non-payment route past the cap must be visible at the wall) vs C270 (earned capacity reads as generosity) / C238 (rewarded-ad unlock)
#      — C270 and C238 are offers; C291 is about the offer's discoverability, a different decision;
#    C292 (a preset never writes data on selection) vs C223 (undo is a visible button) / C262 (never gate recovery) — a data-integrity rule vs an undo affordance;
#    C293 (raising the cap by a couple of slots does not buy back sentiment) vs C007 (generous fixed cap) / C222 (hard cap with a valve)
#      — C007 says where to set it and C222 how to defend it; C293 is the negative result about moving it.
#    No merge this pass.

# 2. titles the attached evidence has outgrown
narrow("C181", "If the app is paid-only or trial-gated, say so in the subtitle, first screenshot and first screen — a free download that stops after N days is 'paid-only' to the person who hits the wall",
       note="reports 74 and 75 attached the trial-gated shape: a listing that enumerates every feature and never the ~1-week free window (27 of 30 1★ in report 74), and a free-download listing that names subscriptions but never the habit cap (report 75); the original rule covered only outright paid-only apps",
       statement_add=" (Consolidation after report 75: title widened from 'If the app is paid-only, say so in the subtitle and first screenshot' to cover trial-gated apps; the original evidence stays in the statement.)")
narrow("C236", "A free-tier limit must announce itself before the user invests — at install, at setup and at the wall — never silently stop a visible progress signal",
       note="reports 71, 74 and 75 attached the disclosure-timing shape: cap complaints from reviewers who met the wall after setting up (report 71 'both object to discovering the wall after investing in setup'), an in-app trial clock proposed so 'day 8 is never a surprise' (report 74), and a cap stated on neither the listing nor onboarding (report 75); the original point was about a progress signal stopping silently",
       statement_add=" (Consolidation after report 75: title widened from 'A free-tier limit must announce itself — never silently stop a visible progress signal' to name when the announcement has to happen; the report 40-era evidence stays in the statement.)")

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
