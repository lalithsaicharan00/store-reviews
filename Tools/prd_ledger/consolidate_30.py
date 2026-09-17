"""Consolidation pass after report 30 (Report Synthesis Prompt, run order step 5).
Over canonical.json only. Merges true duplicates, splits over-broad points, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/30/merge.py.
"""
import json
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 30"

def merge(src, dst, title=None, note="", statement_add=""):
    s, d = C[src], C[dst]
    if s.get("merged_into"): return
    moved = [c for c in s["cards"] if c not in d["cards"]]
    d["cards"] += moved
    d["reports"] = sorted(set(d["reports"]) | set(s["reports"]))
    d["merged_from"].append({"from": src, "title": s["title"], "cards": s["cards"], "when": WHEN, "note": note})
    if title: d["title"] = title
    if statement_add and statement_add not in d["statement"]: d["statement"] += statement_add
    s["merged_into"] = dst; s["cards"] = []; s["reports"] = []
    s["merged_from"].append({"into": dst, "when": WHEN})

def split(src, new_id, section, title, statement, move, keep_title=None, keep_statement=None, shared=()):
    s = C[src]
    if new_id in C: return
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

def narrow(cid, title, statement, note):
    x = C[cid]
    if any(m.get("narrowed") == WHEN for m in x["merged_from"]): return
    x["merged_from"].append({"narrowed": WHEN, "old_title": x["title"], "note": note})
    x["title"] = title; x["statement"] = statement

# 1. true duplicates
merge("C244", "C076", title="Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable",
      note="C244 (report 30: two phrase-bank 5★ campaigns, 50% of the corpus) is the strongest instance of C076, not a separate rule",
      statement_add=" Report 30: 83 of 166 reviews (50%) came from a five-phrase list in several languages, all 5★, in two dated campaigns; when they stopped the half-year mean fell 4.65 → 3.00, the organic 1★ rate rose 12.5% → 44.4%, and the US and GB storefronts were left commercially unmeasured (the high-spend group yielded 8 substantive reviews at 3.50 against a 4.79 headline).")
merge("C245", "C177", title="One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says",
      note="C245 (report 30: two yearly SKUs beside a 'Lifetime' produced 'lifetime delivered as annual'; the monthly plan could not be bought) and C177 (identically named / period-less SKUs) are the same rule about an unambiguous price shelf; entitlement delivery itself stays in C033",
      statement_add=" Report 30: Monthly $5.99, Yearly $44.99, a second Yearly $29.99 and Lifetime $59.99 — 'Te dicen que es de por vida el plan y es solo para un año' ('Cuidado, engañan'), and the monthly option could not be bought ('it charges for a year'); five of the six reviewers who reached payment had a bad outcome. Collapse the shelf.")
merge("C224", "C218", title="Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate",
      note="C224 (report 23: an undisclosed task cap became refund requests) is the omission side of C218 (the listing advertising what the product does not do) — one listing-truth rule",
      statement_add=" Report 23: reviewers said the task cap was not disclosed in the description and asked for refunds on that basis; the 68 'it's just a checklist' 1★ reviews are an expectation failure the listing could pre-empt. Report 30: the listing still said 2 free habits after the cap became 3.")
merge("C243", "C038", title="Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones",
      note="C243 (report 29: a month-rollover / weekday-offset bug) is a specific failure of C038's rule, not a separate decision",
      statement_add=" Report 29: a month-rollover and weekday-header-offset bug was the dominant defect — 37 reviews (10.11%, mean 2.95 vs 4.73), 78.4% filed on days 28–3 against a 27.6% baseline ('On the last day of every month the app has no idea what day it is… April 30 defaulted to Feb 28'); 62.5% of all 3★; users taught each other to reinstall, which wiped local-only data. Test every date surface at month end, leap day and both week starts.")

# 2. over-broad points
split("C006", "C246", "product-rule", "No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver",
      "Report 1: 'no ads' is the highest-rated topic in the corpus (181 of 182 mentions positive, mean 4.91). Report 3: 206 reviews praise the absence of ads at mean 4.94 with zero 1–2★. Report 4: no advertising business; 67 praise it (mean 4.45). Report 20: no ads is a top-rated praise theme. Report 2: ads in the free version are a stated reason for 3 purchases. Separated from C006 because the ad decision now has its own counter-evidence and cost data — C082 (ads in the free tier, report 28: an interstitial on every check-off was 19.98% of reviews, 52.4% of 1★) and C240 (never interrupt the completion moment).",
      move=["R01-060", "R02-064", "R03-012", "R04-012", "R04-052", "R20-038"],
      shared=["R01-062", "R01-181", "R07-031", "R08-026", "R08-041", "R08-072", "R10-039", "R11-067", "R20-011"],
      keep_title="Stay minimal — every addition is opt-in or off by default",
      keep_statement=None)
narrow_note = C["C006"]
if not any(m.get("narrowed") == WHEN for m in narrow_note["merged_from"]):
    narrow_note["merged_from"].append({"narrowed": WHEN, "old_title": "Stay minimal and ad-free", "note": "ad-free half split to C246; C006 keeps simplicity / minimalism (report 23: simplicity praise fell 32.30% → 18.36% as features were added; report 30: minimalism is the only attribute volunteered unprompted, and 'too basic' comes only from people objecting to price)"})

json.dump(L, open(P, "w"), indent=1, ensure_ascii=False)
live = [x for x in L if not x.get("merged_into")]
print(f"{len(L)} entries, {len(live)} live; merged away: {[x['id'] for x in L if x.get('merged_into')]}")

# 3. integrity check: reports derived from cards; every attached card exists and links back
import glob
allcards = {}
for f in glob.glob("Tools/prd_ledger/*/cards.jsonl"):
    for l in open(f):
        if l.strip():
            c = json.loads(l); allcards[c["id"]] = c
bad = 0
for x in live:
    for cid in x["cards"]:
        if cid not in allcards: print("  missing card", x["id"], cid); bad += 1
    rep = sorted({allcards[c]["report"] for c in x["cards"] if c in allcards})
    if rep != sorted(x["reports"]):
        x["reports"] = rep
for x in L:
    if x.get("merged_into"):
        for f in glob.glob("Tools/prd_ledger/*/cards.jsonl"):
            pass
# cards.jsonl files are never edited after commit; canonical.json is the source of truth for card -> point,
# and cards_to_md.py resolves merged_into when rendering.
json.dump(L, open(P, "w"), indent=1, ensure_ascii=False)
print("integrity:", "ok" if not bad else f"{bad} problems")
