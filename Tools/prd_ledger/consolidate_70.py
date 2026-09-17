"""Consolidation pass after report 70 (Report Synthesis Prompt, run order step 5).
Covers the canonical points created or extended by reports 64-70 (C279-C290 and every older point they touched).
Over canonical.json only. Merges true duplicates, widens a title its evidence has outgrown, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/70/merge.py.
"""
import json, glob
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 70"

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

# 1. true duplicates — a title-overlap sweep of the 148 live points touched by reports 64–70 (Jaccard ≥ 0.28 on title tokens)
#    surfaced only C063/C109, C066/C144 and C023/C069, all adjudicated as distinct decisions in earlier passes.
#    The twelve new points were checked by hand against their nearest neighbours and each is a different decision:
#    C279 (AI must consume its input) vs C056 (no AI on demand grounds) / C148 (deliver what ads show);
#    C280 (app-blocking focus mode unlocks) vs C066 (focus timer) / C272 (timers survive backgrounding);
#    C281 (brief creators to state the price) vs C218 (listing copy true) / C286 (no ads in an unshipped language) / C058 (discovery channels);
#    C282 (a generated plan persists and is editable) vs C203 (user authors the routine first) / C266 (programme escalates on completion);
#    C283 (never sell by inventing a deficiency) vs C095 (neutral tone on failure);
#    C284 (verify the rendered price string) vs C113 (one stable disclosed price);
#    C287 (cancel before any retention offer) vs C112 (in-app cancellation) / C180 (no exit offers on the paywall);
#    C288 (denied-notification recovery path) vs C039 (reminders fire) / C123 (notification controls);
#    C289 (one quiet-mode switch for the voice) vs C123 / C095 / C207 (hide surfaces);
#    C290 (guide goals down to a bad-day size) vs C006 (stay minimal) / C203.
#    No merge this pass.

# 2. a title the attached evidence has outgrown
narrow("C285", "A paid add-on is never bought on a single tap — its own price on the button, its own confirmation (never the trial's stored authorisation), 'no thanks' by default and worded neutrally, repeat taps ignored, and a clear way to turn it off",
       note="created by report 67 for a $29.99 workbook charged against the trial's card authorisation; reports 68 and 70 attached the same failure in other shapes — a $57 add-on on the next screen after an intro plan with a confirmshaming decline ('no I do not wish to improve my health'), and a message-pack purchase screen that 'makes mis-purchases easy' with no way to turn the pack off — so the rule now covers every one-tap add-on, not only one that reuses a trial authorisation",
       statement_add=" (Consolidation after report 70: title widened from 'Never charge a one-off add-on on a single tap against the authorisation just given for a trial — …' to cover the report 68 and 70 shapes; the report 67 finding stays in the statement.)")

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
