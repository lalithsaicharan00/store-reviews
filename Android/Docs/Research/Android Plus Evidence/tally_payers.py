"""Validate coded_payers.py against the samples and tally side by side.

Run from Research/:  python -I "../Android/Docs/Research/Android Plus Evidence/tally_payers.py"
Checks: every sampled cite coded once, no unknown cites, every cite exists in its reviews.jsonl with the same id.
Writes tally_payers.md.
"""
import importlib.util, json, os, sys
from collections import Counter

R = os.getcwd()
OUT = os.path.join(R, "..", "Android", "Docs", "Research", "Android Plus Evidence")
spec = importlib.util.spec_from_file_location("coded", os.path.join(OUT, "coded_payers.py"))
coded = importlib.util.module_from_spec(spec); spec.loader.exec_module(coded)

HABIT_ONLY_EXCLUDE = {  # apps in the samples that are not habit trackers (routine coaching, to-do, gym, self-care pet)
    "P": {"12", "4", "122", "126", "84", "97", "11", "129", "5", "49", "8"},
    "A": {"24", "4", "10", "68", "9", "5", "18", "67", "88"},
}

def check(store, name, codes):
    sample = json.load(open(os.path.join(OUT, f"sample-{name}.json")))
    missing = [c for c in sample if c not in codes]
    extra = [c for c in codes if c not in sample]
    assert not missing and not extra, (store, missing[:5], extra[:5])
    rows = {json.loads(l)["cite"]: json.loads(l) for l in open(os.path.join(OUT, f"payers_{name}.jsonl"), encoding="utf-8")}
    folder = "Play Store Reviews" if store == "P" else "App Store Reviews"
    dirs = {d.split(".")[0]: d for d in os.listdir(os.path.join(R, folder))}
    for c in sample:
        app, line = c[1:].split("#")
        with open(os.path.join(R, folder, dirs[app], "reviews.jsonl"), encoding="utf-8") as f:
            for i, l in enumerate(f):
                if i == int(line):
                    assert json.loads(l)["review_id"] == rows[c]["id"], c
                    break
    return sample

def tally(codes, cites):
    tags = [codes[c].split() for c in cites]
    paid = [t for t in tags if t[0] == "PAID"]
    n = len(paid)
    cnt = Counter(x for t in paid for x in set(t[1:]))
    npc = Counter(x for t in tags if t[0] == "NP" for x in set(t[1:]))
    return len(tags), n, cnt, npc

lines = ["# Payer samples, hand-coded (250 per store, seed 20261011)", ""]
res = {}
for store, name, codes in (("P", "play", coded.PLAY), ("A", "app", coded.APP)):
    sample = check(store, name, codes)
    res[store] = {"all": tally(codes, sample),
                  "habit": tally(codes, [c for c in sample if c[1:].split("#")[0] not in HABIT_ONLY_EXCLUDE[store]])}
for scope in ("all", "habit"):
    tp, ta = res["P"][scope], res["A"][scope]
    lines += [f"## Scope: {scope} apps", "",
              f"Sampled: Play {tp[0]}, App Store {ta[0]}. Real payers: Play {tp[1]}, App Store {ta[1]}.", "",
              "| Code (among real payers) | Play | App Store |", "|---|---|---|"]
    keys = sorted(set(tp[2]) | set(ta[2]), key=lambda k: -(tp[2][k] + ta[2][k]))
    for k in keys:
        lines.append(f"| {k} | {tp[2][k]} ({100*tp[2][k]/max(tp[1],1):.0f}%) | {ta[2][k]} ({100*ta[2][k]/max(ta[1],1):.0f}%) |")
    lines += ["", "| Code (among non-payers) | Play | App Store |", "|---|---|---|"]
    keys = sorted(set(tp[3]) | set(ta[3]), key=lambda k: -(tp[3][k] + ta[3][k]))
    for k in keys:
        lines.append(f"| {k} | {tp[3][k]} | {ta[3][k]} |")
    lines.append("")
open(os.path.join(OUT, "tally_payers.md"), "w", encoding="utf-8").write("\n".join(lines))
print("\n".join(lines))
