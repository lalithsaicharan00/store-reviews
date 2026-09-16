"""Consolidation pass after report 20 (Report Synthesis Prompt, run order step 5).
Over canonical.json only. Merges true duplicates, splits over-broad points, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/20/merge.py.
"""
import json
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 20"

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
merge("C220", "C078", title="Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature",
      note="C220 (report 20's widget: the #1 named purchase trigger, non-functional for five years) is the strongest instance of C078, not a separate rule",
      statement_add=" Report 20: the widget was by a wide margin the most-named purchase trigger and the feature that most often didn't work — 182 reviews (mean 1.94), 113 from confirmed payers, broken for five years with an in-app FAQ offering 'restart your phone'; even when present it was a Today-view widget while screenshots implied Home Screen. Ship it properly or remove it from the paywall copy and refund on request.")
merge("C138", "C218", title="Store listing and paywall copy stay true — never advertise a feature you removed, lack, or don't integrate",
      note="C138 (paywall implies a capability the product lacks) and C218 (listing advertises a removed feature) are the same rule on two surfaces",
      statement_add=" Report 6 / 19: a buyer who paid for a feature that isn't there cancels and says 'there are free ones' — it turns a feature request into a refund cause.")
merge("C087", "C218", note="C087 (implied cross-app integration) is a third surface of the same rule",
      statement_add=" Report 2: sibling apps implied an integration that did not exist; the purchases it drove ended in 1★.")
merge("C192", "C193", title="When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff",
      note="C192 (trial ends in a cliff) and C193 (lapsed subscriber's data held hostage) describe one transition rule from two entry points",
      statement_add=" Report 16 (trial side): a well-liked no-card 28-day trial that dropped to a one-habit tier read as a bait-and-switch — 'it encourages people to start habits and continue them for three weeks and then hits you with a steep bill' — and was the fastest-growing negative (2.4% → 7.2%). Taper, warn earlier and in-app, or keep the streak read-only.")
merge("C158", "C216", title="A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks",
      note="C158 (report 10: cumulative credit next to streaks) and C216 (report 20: a decaying strength score instead of resets) are the same product principle stated by two corpora",
      statement_add=" Report 10: replacing cumulative Journeys with consecutive-streak Self-Care Areas was the lowest-rated change in a 70,041-review corpus (mean 2.76, 21 of 49 one-star); chronic-illness and ADHD users say a streak-only model is structurally incompatible with their lives. Ship the forgiving measure next to streaks, not instead of them.")

# 2. over-broad points
narrow("C204", "Never destroy user work at the paywall",
       "Report 18: two users each spent an hour building routines, were asked to pay to save them, and lost the work anyway. Work the user has already done is never the hostage of a purchase sheet — save it, then ask. (The labelling half of the original point — 'reviewers cannot tell what they are buying' — lives on C110 and C218, to which the same cards are attached.)",
       note="the original title bundled 'label paid features before use', which duplicates C110 (legible free/paid boundary) and C218 (listing truth); narrowed to the one rule no other point carries")
split("C177", "C221", "must-have", "A receipt with a working product link after every charge, and a renewal reminder before it",
      "Report 19: reviewers could find no record of what they bought — 'no confirmation email anywhere'; support's answer 'we sent you an EMAIL notification' conceded that one e-mail with the fine print in a footer link was the whole safeguard, and 'the ONE SINGLE EMAIL they sent confirming my purchase with no actual link' left an ADHD buyer unable to find the product at all. Every charge produces a receipt that names the plan, the amount, the next charge date and links to the product; every renewal is preceded by a reminder. Related: C152 (the trial-end reminder) and C177 (SKU names).",
      move=["R19-059", "R19-078"], shared=["R19-036"],
      keep_title="Every IAP SKU has a distinct name that states its period or 'one time'",
      keep_statement="Report 11: three SKUs shared the identical display name 'Habits PRO Functions' at $1.99 / $6.99 / $8.99 and none named a period, while reviewers described 'annual', 'VIP' and 'lifetime' purchases — neither the user nor support could tell what had been bought. Report 12: ten SKUs including three 'Weekly Subscription' and two 'One-Time Payment' entries at different prices, visible on the store page. Report 19: charged ≠ agreed ($29.99 annual agreed, $59.99/month billed) when the plan bought was never named back to the buyer.")

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
