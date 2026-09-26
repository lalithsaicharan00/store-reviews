"""Consolidation pass after report 50 (Report Synthesis Prompt, run order step 5).
Covers the canonical points created or extended by reports 31-50 (C247-C268 and every older point they touched).
Over canonical.json only. Merges true duplicates, widens a title its evidence has outgrown, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/50/merge.py.
"""
import json, glob
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 50"

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

# 1. true duplicates
merge("C260", "C189",
      title="Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating",
      note="C260 (report 46: rude or price-defending public replies and pressure to change a rating) and C189 (reports 13, 25, 31, 43: copy-paste and argumentative replies) are one rule about how a developer responds in public; both lower ratings after the reply")
merge("C253", "C123",
      title="Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned",
      note="C253 (reports 36, 43, 46, 48: restraint and fine control are why users switched; heavy nagging is accepted only when the user sets the frequency) is the same decision as C123 (reports 5, 7, 24: escalation must be user-configurable; all-or-nothing settings make users disable everything)")
merge("C248", "C127",
      title="Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps",
      note="C248 (reports 31, 33, 47: upsells and cross-promotion shown to payers and lifetime buyers; a rating prompt shown to payers) and C127 (reports 5, 10, 18, 24, 28, 50: ads, sponsored events and renewal nags shown to subscribers) are one rule: a paying user sees no monetisation interruption")
merge("C259", "C075",
      title="Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in",
      note="C259 (report 43: no guide, tutorial or FAQ for eleven years) is the help-screen half of the same need C075 covers (hidden gestures and product vocabulary that new users cannot decode); one learnability requirement")
merge("C257", "C008",
      title="Daily check-in and reminders are free — never paywall the reminder",
      note="C257 (report 42: reminders behind the paywall were the gate most often named, and the phone's own alarm substitutes) is the rule form of C008's free-tier line; reports 13 and 25 on C008 already showed exact-time reminders were the most resented gate")

# 2. a title the attached evidence has outgrown
narrow("C191", "Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled",
       note="reports 48 and 50 attached retroactive free-cap reductions (10 → 7 → 3; 5 → 3) to this point; the evidence is about taking back capacity already in use, paid or free — cap size itself stays in C007, slot reuse in C219",
       statement_add=" (Consolidation after report 50: the title was widened from 'Never cap the tier someone has already paid for' because the Report 48 and Report 50 evidence is free users losing capacity they had already filled — grandfathering is the fix in both.)")

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
