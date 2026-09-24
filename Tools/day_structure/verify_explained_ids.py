"""verify_explained_ids.py REPORT -> check every backticked review ID against its source reviews.jsonl line,
and that every E/N reference used in the body is defined in the appendices."""
import json, re, sys, os
ROOT = "/Users/lalith/Desktop/store reviews"
EV = os.path.join(ROOT, "Research Reports/Day Structure Evidence/Whole-Corpus Coding")
rep = open(sys.argv[1]).read()
cites = {}
cites.update(json.load(open(os.path.join(EV, "cited-reviews.json")))["cites"])
cites.update(json.load(open(os.path.join(EV, "cited-reviews-explained.json")))["cites"])
base = {"App Store": "App Store Reviews", "Google Play": "Play Store Reviews"}
by_id = {c["id"]: c for c in cites.values()}
bad = []
ids = set(re.findall(r"`([0-9a-f-]{8,})`", rep))
for rid in ids:
    c = by_id.get(rid)
    if not c: bad.append(f"{rid} unknown"); continue
    f = os.path.join(ROOT, base[c["store"]], c["folder"], "reviews.jsonl")
    with open(f) as fh:
        for n, l in enumerate(fh, 1):
            if n == c["line"]:
                if json.loads(l)["review_id"] != rid: bad.append(f"{rid} mismatch at {f}:{n}")
                break
defined = set(re.findall(r"^\| ([EN]\d+) \|", rep, re.M))
body = rep.split("## Appendix A")[0]
used = set()
for p, a, b in re.findall(r"\b([EN])(\d+)(?:–[EN](\d+))?", body):
    lo = int(a); hi = int(b) if b else lo
    used |= {f"{p}{k}" for k in range(lo, hi + 1)}
print(f"IDs: {len(ids)} bad: {len(bad)} | refs used: {len(used)} defined: {len(defined)} undefined: {sorted(used-defined)} unused-defined: {len(defined-used)}")
for x in bad: print(" ", x)
