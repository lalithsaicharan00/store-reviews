"""Final consolidation pass over canonical.json (Report Synthesis Prompt, whole-run step 8).

Runs after every App Store report (70) and both Research Reports documents are carded and merged.
Scope: canonical.json only. Merge true duplicates, split points that became too broad, record everything
in merged_from. Nothing is deleted.

Method and findings of this pass
--------------------------------
1. Duplicate sweep. Jaccard on title tokens (stop-words removed) across all 281 live points,
   C(281,2) = 39,340 pairs. 26 pairs scored >= 0.20; none scored above 0.40. Every pair was read in full.
   Most are artefacts of short titles sharing a common noun ("app", "free", "paywall", "check-off") -
   e.g. C018 App-icon themes vs C112 In-app cancellation (J=0.25) share only "app". Four pairs were
   genuine near-neighbours and each was read statement-first:
     C063 (Free trial before purchase, research, 31 apps) vs C109 (A free trial must be a real trial,
       must-never-break, 36 apps), J=0.40 - the highest score in the sweep. Distinct questions:
       C063 is demand (should a trial exist at all; 52 requests in report 9, five blocked buyers in
       report 28, net-negative trial sentiment in report 31). C109 is integrity (if one ships, it must
       not bill at once: 1,102 auto-charge reviews at mean 1.20 in report 13, 789 at 1.35 in report 4).
       An app can fail C109 while satisfying C063 and vice versa. Kept apart, cross-linked.
     C107 (Widget variants as the paid layer, 15 apps) vs C167 (Cosmetic and colour variety as the paid
       layer, 9 apps), J=0.25. Both are "what a cosmetic tier can sell", but the widget is a functional
       visibility surface - report 3's #1 purchase trigger, report 62's only named purchase trigger and
       credited retention mechanism - whereas C167 is decoration bought after engagement (Habitica's
       cosmetic-only Pro, report 10's colour options, report 36's skins). Gating decisions differ.
       Kept apart, cross-linked.
     C116 (Content library as the paid layer, 13 apps) vs C233 (Content the user paid for is saveable
       and replayable, 1 app), J=0.25. C116 asks whether a content layer sells; C233 is a reliability
       requirement on content already sold (report 24: inability to re-listen is a stated annual renewal
       risk for the app's best customers). Kept apart, cross-linked.
     C001 (Never move a free feature behind the paywall) vs C104 (Never ship a paywall or feature-removal
       change silently), J=0.22 - the act versus its disclosure; already cross-linked in an earlier pass.
   No merge is warranted. Nine prior consolidation passes (10, 20, 30, 50, 60, 62, 70, 75, 83, 90) had
   already merged 17 points away; the residue is genuinely distinct.

2. Over-breadth sweep. Ranked all live points by card count and by the number of distinct card kinds
   they draw. Kind-spread is not evidence of over-breadth here - the card schema deliberately produces
   feature, timeline and insight cards for one point - so the two largest points were read in full:
     C007 (Generous fixed habit cap, 417 cards, 56 apps, 20,673 chars) is one thesis with two halves the
       evidence never separates: the level and its stability. Its neighbours already carry the distinct
       mechanisms - C001 (moving free behind the paywall), C191 (shrinking a held tier), C222 (a hard cap
       with an opt-in valve), C236 (announcing the limit before investment), C293 (a small raise does not
       buy back sentiment), C296 (the free tier must let the differentiator be experienced), C297 (the
       bundle sets the cap's acceptability), C200 (never meter the completion action), C219 (concurrent,
       never lifetime). Splitting further would fragment one argument across nine points. Not split.
     C231 (Audit the funnel per market and per channel, 302 cards, 42 apps) is also one thesis - the same
       product rates differently by storefront because of billing and funnel stage, and written reviews
       under-rate against public ratings. Its data-caveat cards are the per-report method notes that
       support exactly that claim. Not split.

3. Section drift. C019 (Quit-habit mode) sits in section `research`, and Research Reports/Quit Habit
   Decision.md now answers that research question directly. The section is deliberately left unchanged:
   assigning it to free/paid/must-have is a product decision for the PRD (Stage 6), not a ledger
   operation, and the Feature Ledger reports the memo's conclusion as evidence instead.

Net effect: 0 merges, 0 splits, 6 cross-links added. The pass is recorded so the absence of change is
itself auditable.
"""
import json

P = "Tools/prd_ledger/canonical.json"
L = json.load(open(P)); C = {x["id"]: x for x in L}
WHEN = "final consolidation (whole run: 70 App Store reports + 2 research documents)"

def link(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text

def note(cid, text):
    x = C[cid]
    if any(m.get("reviewed") == WHEN for m in x["merged_from"]): return
    x["merged_from"].append({"reviewed": WHEN, "note": text})

link("C063", " (Final consolidation: distinguish [[C109]] — this point is whether a trial should exist at all, which is a demand and conversion question; C109 is whether a shipped trial behaves as advertised, which is a billing-integrity question. The highest title-overlap pair in the final sweep, and deliberately not merged: an app can satisfy one and fail the other.)")
link("C109", " (Final consolidation: distinguish [[C063]] — that point weighs whether to offer a trial; this one governs a trial that already exists. Report 12 is the case that shows they are sequential, not alternative: the complaint there changed shape from 'there is no trial' to 'the trial doesn't work'.)")
link("C107", " (Final consolidation: distinguish [[C167]] — a widget is a functional visibility surface and in reports 3 and 62 it is the named purchase trigger and the credited retention mechanism; C167 is decoration bought after engagement. Gating a functional surface and gating decoration are different decisions with different risk.)")
link("C167", " (Final consolidation: distinguish [[C107]] — cosmetics are the safest paid layer precisely because they are not the mechanism; a widget that shows the number is, so it carries the base-free rule in C107 while pure decoration does not.)")
link("C116", " (Final consolidation: see [[C233]] — this point asks whether a content layer sells; C233 is the reliability requirement on content already sold, and report 24 shows the second failing while the first succeeds.)")
link("C233", " (Final consolidation: see [[C116]] — the paid content layer that C116 evaluates is the same content this point requires to be saveable and replayable; in report 24 the content converts and the missing library is a stated annual renewal risk for the app's best customers.)")

for cid, t in [("C007", "Read in full in the final consolidation: one thesis (the free cap's level and its stability), not split; the distinct mechanisms already live in C001, C191, C200, C219, C222, C236, C293, C296, C297."),
               ("C231", "Read in full in the final consolidation: one thesis (per-storefront divergence in billing and funnel stage, plus the written-review vs public-rating gap); its data-caveat cards are the per-report method notes supporting exactly that claim. Not split."),
               ("C019", "Final consolidation: section deliberately left as `research` although Research Reports/Quit Habit Decision.md answers the question — assigning free/paid/must-have is a Stage 6 product decision, not a ledger operation.")]:
    note(cid, t)

json.dump(L, open(P, "w"), ensure_ascii=False, indent=1)
live = [x for x in L if not x.get("merged_into")]
print(f"final consolidation recorded: {len(L)} points ({len(live)} live, {len(L)-len(live)} merged away); 0 merges, 0 splits, 6 cross-links")
