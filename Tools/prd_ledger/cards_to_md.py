#!/usr/bin/env python3
"""Render one report's cards.jsonl as a readable Markdown file next to it (cards.md).

    python3 Tools/prd_ledger/cards_to_md.py <N>
    python3 Tools/prd_ledger/cards_to_md.py research_quit_habit   (research-document folders)

cards.jsonl stays the source of truth; cards.md is a view and is regenerated on demand.
"""
import json, sys, os, glob
from collections import OrderedDict

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
KIND_ORDER = ["product-rule","must-have","must-never-break","feature","monetization","tactic","insight",
              "audience","market","timeline","positioning","anti-pattern","dont","do","contradiction","data-caveat"]
KIND_LABEL = {
 "product-rule":"Product rules","must-have":"Must-haves","must-never-break":"Must never break",
 "feature":"Features","monetization":"Monetization","tactic":"Tactics the app used","insight":"Insights (the why)",
 "audience":"Audiences","market":"Markets and languages","timeline":"Dated events and trends",
 "positioning":"Positioning","anti-pattern":"Anti-patterns","dont":"Things not to do","do":"Things to do",
 "contradiction":"Contradictions","data-caveat":"Data caveats and method"}

RESEARCH = {"research_quit_habit": "Quit Habit Decision.md",
            "research_feature_gating": "Feature Gating vs Quantity.md"}

def main(n):
    folder = os.path.join(ROOT, "Tools", "prd_ledger", str(n))
    cards = [json.loads(l) for l in open(os.path.join(folder, "cards.jsonl")) if l.strip()]
    if str(n) in RESEARCH:
        source = "Research Reports/" + RESEARCH[str(n)]
        heading = "Cards — research document: " + RESEARCH[str(n)][:-3]
    else:
        n = int(n)
        source = "App Store Reports/" + os.path.basename(glob.glob(os.path.join(ROOT, "App Store Reports", f"{n}. *.md"))[0])
        heading = f"Cards — report {n}"
    canon = {c["id"]: c for c in json.load(open(os.path.join(ROOT, "Tools", "prd_ledger", "canonical.json")))}
    # canonical.json is the source of truth for card -> point (consolidation may merge or split points after a
    # report's cards were committed); fall back to the card's own field only if the ledger has nothing for it
    rev = {}
    for cid, x in canon.items():
        if x.get("merged_into"): continue
        for k in x["cards"]: rev.setdefault(k, []).append(cid)

    groups = OrderedDict((k, []) for k in KIND_ORDER)
    for c in cards: groups.setdefault(c["kind"], []).append(c)

    out = [f"# {heading}", "", f"Source: `{source}`  ", 
           f"{len(cards)} cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.", "",
           "## Contents", ""]
    for k, v in groups.items():
        if v: out.append(f"- [{KIND_LABEL[k]}](#{KIND_LABEL[k].lower().replace(' ', '-').replace('(', '').replace(')', '')}) — {len(v)}")
    out.append("")

    for k, v in groups.items():
        if not v: continue
        out += [f"## {KIND_LABEL[k]}", ""]
        for c in v:
            out.append(f"### {c['id']} — {c['claim']}")
            out.append("")
            out.append(f"- **Where:** {c['where']}")
            out.append(f"- **This app does:** {c['this_app_does']}")
            out.append(f"- **User reaction:** {c['user_reaction']}")
            out.append(f"- **Magnitude:** {c['magnitude']}")
            out.append(f"- **Direction for us:** {c['direction']} · **Report confidence:** {c['report_confidence']} · **Generalisable:** {c['generalisable']}")
            if c.get("side_effects"): out.append(f"- **Side effects:** {c['side_effects']}")
            if c.get("conditions"): out.append(f"- **Conditions:** {c['conditions']}")
            if c.get("review_ids"): out.append(f"- **Review IDs:** " + ", ".join(f"`{r}`" for r in c["review_ids"]))
            links = rev.get(c["id"]) or c.get("canonical") or []
            if links:
                out.append("- **Canonical:** " + "; ".join(f"{cid} {canon[cid]['title']}" for cid in links))
            else:
                out.append("- **Canonical:** — (nuance register)")
            out.append("")
    path = os.path.join(folder, "cards.md")
    open(path, "w").write("\n".join(out))
    print(path, f"({len(out)} lines)")

if __name__ == "__main__":
    main(sys.argv[1])
