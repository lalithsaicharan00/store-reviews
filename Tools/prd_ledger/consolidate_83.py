"""Batch-end consolidation after report 83 (Report Synthesis Prompt, run order step 5). Closes the 76–83 batch (reports 76, 77, 79, 82, 83); consolidate_75.py ran at the previous batch end.
Covers the canonical points created or extended by reports 76-83 (C294-C301 and every older point they touched).
Over canonical.json only. Merges true duplicates, widens a title its evidence has outgrown, records every change in merged_from.
Nothing is deleted: a merged-away point keeps its entry with merged_into set and its cards moved to the target.
Run after Tools/prd_ledger/83/merge.py.
"""
import json, glob
P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "consolidation after report 83 (batch end)"

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

# 1. true duplicates — a title-overlap sweep (Jaccard on title tokens, stop-words removed) of the eight points created this batch
#    against the 272 live points returned no pair at or above 0.18. Each new point was then checked by hand against its nearest neighbours:
#    C294 (the review corpus keeps advertising the old pricing model) vs C186 (never revoke what earlier buyers paid for) / C218 (listing copy stays true)
#      — C186 is the entitlement, C218 the listing; C294 is the third surface, the accumulated reviews, and the counter-measure is on the paywall and listing;
#    C295 (backup/sync infrastructure reachable in every storefront) vs C132 (do not sell where the app cannot function) / C153 (backup on by default)
#      — C132 is the whole app, C153 the default; C295 is the provider choice for one subsystem (Dropbox blocked in China, report 76);
#    C296 (the free tier must let the differentiator be experienced) vs C147 (let people use the product before they pay) / C182 (a pre-use hard paywall)
#      — C147 is 'use before pay' in general; C296 says what the free slice must contain: the thing being sold (report 77: forgiving multi-habit momentum at a 1-habit cap);
#    C297 (a cap's acceptability is set by the bundle around it) vs C007 / C222 / C293 — where to set it, how to defend it, why raising it fails; C297 is the bundle effect (report 79: same cap, widget gated);
#    C298 (a public roadmap converts and becomes a promise) vs C196 (a subscription is a promise of continued delivery) / C239 (origin story builds trust)
#      — C196 is cadence, C239 is narrative; C298 is the artefact that names future features and is held against the developer;
#    C299 (never attach an app subscription to another product's checkout by default) vs C285 (a paid add-on is never bought on one tap) / C210 (bill through the App Store)
#      — C285 is in-app add-ons, C210 the rail; C299 is the bundle-into-physical-goods shape (report 82);
#    C300 (a headline rating far above its reviews is a signal to audit) vs C231 (audit the funnel per market; written reviews under-rate the app)
#      — C231 treats the gap as a known bias to correct for; C300 treats a two-star gap as a finding to investigate, with report 83 as the counter-case;
#    C301 (support form and account deletion must not live behind the surface most likely to break) vs C036 (a support channel reachable outside the app)
#      — C036 says a channel must exist outside the app; C301 is a placement rule for the in-app one (report 83: Settings tab blank, support form inside it).
#    No merge this pass.

# 2. titles the attached evidence has outgrown
narrow("C043", "Flexible / custom frequency — N times per week, specific weekdays, counts — with non-scheduled days neutral in the statistics",
       note="reports 76, 77, 79 and 83 attached the shape of the request and its cost: the one structural request for fifteen years, in 15 of 16 calendar years, the most frequent 4★ reason and 2.39× over-represented among purchasers (report 76); the only feature requested twice by otherwise-happy 4★ users, and thesis-inconsistent for a forgiving tracker (report 77); a gym habit done 3×/week can never build a streak and a pre-committed fifth star (report 79); every-N-days, weekly counts and reps (report 83); reports 76 and 77 both specify that non-scheduled days must be neutral and excluded from percentages because users emulate frequency with skip and corrupt their own stats",
       statement_add=" (Consolidation after report 83: title widened from 'Flexible / custom frequency' to name the three shapes and the statistics rule; the earlier evidence stays in the statement.)")
narrow("C003", "Lead with a one-time lifetime purchase — and keep it visibly on the shelf if a subscription is ever added beside it",
       note="reports 76, 77 and 79 attached the post-subscription shape: a $4.99 unlock sustained a 4.62★ corpus for 13 years and reviewers still ask for lifetime after the 2023 switch (report 76 §8.6 a published lifetime price beside the subscription); a lifetime SKU is the only monetization attribute praised by name and its existence is contradicted across three reviews (report 77 §8.1.3 'if a lifetime SKU exists, say so'); twelve reviewers chose the app because it was not a subscription and §8.6 E5 tests a lifetime-forward paywall (report 79); the original rule covered only the launch offer",
       statement_add=" (Consolidation after report 83: title widened from 'Lead with a one-time lifetime purchase' to cover what happens to the lifetime SKU once a subscription is introduced; the original evidence stays in the statement.)")

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
