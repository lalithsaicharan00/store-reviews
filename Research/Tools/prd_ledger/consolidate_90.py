"""Batch-end consolidation after report 90 (Report Synthesis Prompt, run order step 5).
Closes the 76-90 batch (reports 76, 77, 79, 82, 83, 84, 85, 86, 88, 89, 90) as one batch, as instructed:
consolidate_83.py ran mid-batch after report 83 and this pass re-covers that ground together with 84-90.
Covers the canonical points created or extended by reports 76-90 (C294-C308 and every older point they touched).
Over canonical.json only. Merges true duplicates, widens titles the evidence has outgrown, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/90/merge.py.
"""
import json, glob
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 90 (batch end, 76-90)"

def merge(src, dst, title=None, section=None, note="", statement_add=""):
    s, d = C[src], C[dst]
    if s.get("merged_into"): return
    moved = [c for c in s["cards"] if c not in d["cards"]]
    d["cards"] += moved
    d["reports"] = sorted(set(d["reports"]) | set(s["reports"]))
    d["merged_from"].append({"from": src, "title": s["title"], "section": s["section"], "cards": s["cards"], "when": WHEN, "note": note})
    if title: d["title"] = title
    if section: d["section"] = section
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

def link(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text

# 1. true duplicates
#    A title-overlap sweep (Jaccard on title tokens, stop-words removed) of the fifteen points created in this batch
#    (C294-C308) against the 279 live points returned six pairs at or above 0.13 and none above 0.20. Each was read in full:
#      C306 (third-party ad code never sits on the launch path) vs C159 (launch-to-core-action path with no interstitials, J=0.20)
#        — C159 is an attention rule about screens the user must dismiss; C306 is a reliability rule about code that can crash before
#          the first screen renders. Report 90's ad banner showed no interstitial at all: it crashed the app (64 reports in six days).
#      C306 vs C242 (never monetise by routing the user's device or bandwidth, J=0.13) — C242 is about what the monetisation does to the
#        user; C306 is about where its code runs. Kept apart, cross-linked.
#      C296 (the free tier must let the differentiator be experienced) vs C191 (never shrink a tier someone already holds, J=0.17)
#        — C191 is about taking capacity away, C296 about what the free slice must contain in the first place.
#      C299 (never attach an app subscription to another product's checkout) vs C152 (a promised pre-charge trial reminder must arrive, J=0.14)
#        — different mechanisms: where the subscription is sold vs what must be sent before the charge.
#      C305 (say 'one-time, not a subscription' wherever the price appears) vs C003 (lead with a one-time lifetime purchase, J=0.14)
#        — C003 is the pricing decision, C305 the labelling rule that makes it legible; report 89's five subscription-believers rate
#          a one-time app 2.20★ against 4.60★ for those who read it correctly. Cross-linked, not merged.
#      C297 (a cap's acceptability is set by the bundle around it) vs C001 (never move a free feature behind the paywall, J=0.13)
#        — C001 is a change over time, C297 a comparison at one moment.
#    No merge this pass. Every new point keeps a distinct mechanism; the overlaps are handled with cross-links below.

link("C159", " (Consolidation after report 90: distinguish [[C306]] — an ad SDK that crashes the app before the first screen renders is a reliability failure, not an attention one; the launch path must be both uninterrupted and unbreakable.)")
link("C242", " (Consolidation after report 90: see [[C306]] for the other half of the rule — what third-party monetisation code may do to the user is one question, where it is allowed to run is another.)")
link("C003", " (Consolidation after report 90: see [[C305]] — a one-time price only earns its goodwill if it is labelled as one; report 89's five subscription-believers rate the same one-time app 2.20★ against 4.60★ for readers who understood it.)")
link("C191", " (Consolidation after report 90: see [[C296]] — this rule is about taking capacity away; C296 is about what the free slice has to contain before anyone pays.)")

# 2. titles the attached evidence has outgrown
narrow("C031", "Crashes and launch failures are the largest complaint by volume — and one bad release can outweigh a year of goodwill in a week",
       note="reports 84-90 attached the single-release shape the old title did not name: report 90 is the clearest case in the series — BUG_CRASH 65 (10.59%), 64 of them in the seven days after 1.2.0, 92.8% of that week's reviews, taking the era mean to 2.41 against 4.62-4.70 in every other era and producing 40 of the corpus's 62 one- and two-star reviews for all time, with the fix (1.2.1, six days later) ending the wave completely (30 later reviews, no crash, 4.70) and the cumulative public rating barely moving; report 89 by contrast has zero crash reports in 253 reviews over five years. The ledger now holds both the chronic and the acute shape",
       statement_add=" (Consolidation after report 90: title widened from 'Crashes / launch failures' to carry the single-release burst pattern — how fast one release can produce a year's worth of one-star reviews, and how completely a fast fix ends it; see [[C306]] and [[C156]].)")
narrow("C082", "Ads in the free tier — viable only off the logging path, off the launch path and out of harmful categories, and they turn 'free' praise into the churn segment",
       note="reports 84, 89 and 90 attached what the stub title never said: report 90 shows the whole arc in one corpus — PRAISE_NO_FEW_ADS 19 from day one ('great that there are no ads'), the first complaint on 2024-06-12, U:ads_negative 20 (3.26%, mean 2.65) of whom 6 deleted the app and 7 carry a lost-user signal against 5 of the 536 reviews with no money code ('reviews that criticise ads are the churn segment'), gambling ads served to addiction-recovery users, and finally an ad banner on the launch path that crashed the app for a week; report 89 records an ad-supported option reviewers could not select and two who would take ads over a paywall",
       statement_add=" (Consolidation after report 90: title widened from 'Ads in the free tier' to state the three placement constraints and the churn finding; see [[C240]], [[C269]], [[C306]], [[C307]].)")
narrow("C019", "Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset",
       note="report 90 is the first dedicated quit-tracker corpus in the series (614 reviews, mean 4.40, U:praise_any 77.52%) and it specifies the mode the old one-line title only named: time since quitting to the second, unlimited habits, a personal record, an attempts counter and a relapse button that stores a dated note with a reason; the mechanism is loss aversion on a large number ('breaking big numbers hurts far more than the urge to smoke'), the audience includes self-harm (13), drugs (8) and clinical contexts (3), and the vocabulary itself is a design surface ('the words refusal, bad habits, relapse are so-so')",
       statement_add=" (Consolidation after report 90: title widened from 'Quit-habit / bad-habit mode' to name what the mode consists of; see [[C308]] for the relapse-logging rule and [[C307]] for the ad-category rule that follows from the audience.)")
narrow("C217", "An unexplained number reads as broken — explain the score, and any rule that moves it by itself, on-screen",
       note="report 90 extends the rule past computed metrics to automatic rules: a goal ladder that advances on its own (1, 7, 30 days, a month, 100 years) with no visible control produced U:goal_setting 25 (4.07%) from otherwise satisfied users — GOAL_HOWTO_QUESTION 13 ('tapped everything, can't see where to change the goal'; 'spent the first day trying to understand why my goal is one day') and GOAL_STEPS_RIGID 15, including a 13-year-sober reviewer facing a 100-year target; report 86 and 77 carried the metric case",
       statement_add=" (Consolidation after report 90: title widened from 'An unexplained metric reads as broken' to cover automatic rules as well as computed scores — a target the app changes by itself needs the same one-line explanation.)")

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
for x in live:
    for cid in x["cards"]:
        if cid not in allcards: print("  missing card", x["id"], cid); bad += 1
    rep = sorted({allcards[c]["report"] for c in x["cards"] if c in allcards})
    if rep != sorted(x["reports"]): x["reports"] = rep
for x in L:
    if x.get("merged_into"):
        assert not x["cards"], x["id"]
        assert not C[x["merged_into"]].get("merged_into"), (x["id"], "chain")
for c in allcards.values():
    for cid in c.get("canonical", []):
        tgt = cid
        while C[tgt].get("merged_into"): tgt = C[tgt]["merged_into"]
        if c["id"] in C[tgt]["cards"]: continue
        homes = [x["id"] for x in live if c["id"] in x["cards"]]
        lineage = {m["split_to"] for m in C[tgt]["merged_from"] if m.get("split_to") and c["id"] in m.get("cards", [])}
        if not (set(homes) & lineage): print("  unreachable", c["id"], cid, "->", tgt, homes); bad += 1
json.dump(L, open(P, "w"), indent=1, ensure_ascii=False)
print("integrity:", "ok" if not bad else f"{bad} problems")
print("batch 76-90 points:", [x["id"] for x in live if x["id"] >= "C294"])
