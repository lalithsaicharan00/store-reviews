"""Consolidation pass after report 10 (Report Synthesis Prompt, run order step 5).
Over canonical.json only. Merges true duplicates, splits over-broad points, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
"""
import json
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 10"

def merge(src, dst, title=None, note=""):
    s, d = C[src], C[dst]
    if s.get("merged_into"): return
    moved = [c for c in s["cards"] if c not in d["cards"]]
    d["cards"] += moved
    d["reports"] = sorted(set(d["reports"]) | set(s["reports"]))
    d["merged_from"].append({"from": src, "title": s["title"], "cards": s["cards"], "when": WHEN, "note": note})
    if title: d["title"] = title
    s["merged_into"] = dst; s["cards"] = []; s["reports"] = []
    s["merged_from"].append({"into": dst, "when": WHEN})

def split(src, new_id, section, title, statement, move, keep_title=None, keep_statement=None, shared=()):
    """Cards in `move` go to the new point; cards in `shared` stay on both."""
    s = C[src]
    if new_id in C: return  # already split on a previous run
    n = dict(id=new_id, title=title, statement=statement, section=section, cards=[], reports=[],
             merged_from=[{"split_from": src, "when": WHEN}])
    for cid in move + list(shared):
        assert cid in s["cards"], (src, cid)
        n["cards"].append(cid)
    for cid in move:
        if cid not in shared: s["cards"].remove(cid)
    n["reports"] = sorted({int(c[1:3]) for c in n["cards"]})
    s["reports"] = sorted({int(c[1:3]) for c in s["cards"]})
    s["merged_from"].append({"split_to": new_id, "cards": move, "when": WHEN})
    if keep_title: s["title"] = keep_title
    if keep_statement: s["statement"] = keep_statement
    C[new_id] = n; L.append(n)

def attach(dst, cards):
    d = C[dst]
    if any(m.get("attached") == cards for m in d["merged_from"]): return
    for cid in cards:
        if cid not in d["cards"]: d["cards"].append(cid)
    d["reports"] = sorted({int(c[1:3]) for c in d["cards"]})
    d["merged_from"].append({"attached": cards, "when": WHEN, "note": "existing cards re-attached during consolidation"})

# 1. true duplicates
merge("C146", "C032", title="New Year peak-season robustness — year-end report and January onboarding",
      note="C146 (harden onboarding before January) is the same rule as C032 (never ship risk into late December) on a different surface")
C["C032"]["statement"] += " The New Year cohort is the largest of the year and judges onboarding, not retention — every create-flow or first-day defect is amplified ~2× in January (reports 8, 9)."
merge("C088", "C094", note="rating-prompt spam to payers was already the negative half of C094; cross-promo spam folded in")
C["C094"]["statement"] += " Cross-promoting the developer's other apps inside the product draws the same complaint (report 2)."

# 2. over-broad points
split("C049", "C172", "free", "Per-day / per-habit notes and journal text",
      "A note field on each check-in is pure upside and requested by happy users (reports 2, 3, 7); a single cramped line is the common complaint; charging for journal text while mood is free drew complaints (report 9).",
      move=["R02-071", "R03-078", "R03-111", "R05-017", "R07-086", "R08-027"], shared=["R09-036"],
      keep_title="Mood tracker", keep_statement="Meaningful praise where shipped; mentions rose after launch (report 1); asked for only by 5★ users (report 8); an automatic mood prompt is a memory aid and moving it behind a button destroyed users' mood datasets (report 10).")
split("C045", "C173", "undecided", "Sub-tasks / sub-routines nested inside a habit or routine",
      "'Shower routine' reused inside 'morning routine'; sub-habits are what heavy users ask for after categories (reports 1, 5, 7).",
      move=["R05-069", "R05-099"], shared=["R01-074", "R01-102", "R07-087"],
      keep_title="Grouping / folders / categories / tags", keep_statement="#2 feature request in report 1; the highest-mean request in report 3 (zero 1–2★, power users tracking 20–100 counters); named in report 8's only subscription-price statement.")
split("C045", "C174", "research", "Multiple profiles (me, kids, pet, work)",
      "Requested alongside folders in report 1 — separate people or contexts inside one app.",
      move=[], shared=["R01-074", "R01-102", "R01-174"])
split("C119", "C175", "must-never-break", "Updates must not break function or wipe progress",
      "'Then Boom… updated! Now… the progress is gone' (report 4); a nine-week window of hard functional failures (report 8); an update broke chronological sorting across four countries in one week (report 9); near-daily forced updates are themselves a complaint (report 10).",
      move=["R05-081", "R08-009", "R09-109", "R10-090"], shared=["R04-059"],
      keep_title="Redesigns must not regress layout — ship a density / text-size option or an opt-out",
      keep_statement="A compact-list redesign produced a dated backlash (report 7) while a Liquid Glass refresh drew none (report 8); layout regressions hit neurodivergent users hardest (report 4); a Feb 2024 redesign and continuous UI churn drew a backlash cluster (report 10).")

# 3. existing backup must-have cards belong on the new automatic-backup point as well
attach("C153", ["R03-076", "R03-102", "R04-032", "R04-058", "R04-094", "R05-088", "R08-059", "R08-120"])

json.dump(L, open(P, "w"), indent=1, ensure_ascii=False)
live = [x for x in L if not x.get("merged_into")]
print(f"{len(L)} entries, {len(live)} live; merged away: {[x['id'] for x in L if x.get('merged_into')]}")

# 4. housekeeping found by the integrity check: C038's reports list lacked report 3 although an R03 card is attached
L = json.load(open(P)); C = {x["id"]: x for x in L}
x = C["C038"]
exp = sorted({int(c[1:3]) for c in x["cards"]})
if exp != sorted(x["reports"]):
    x["merged_from"].append({"fixed_reports": {"from": x["reports"], "to": exp}, "when": WHEN})
    x["reports"] = exp
    json.dump(L, open(P, "w"), indent=1, ensure_ascii=False)
    print("C038 reports corrected ->", exp)
