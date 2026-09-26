"""verify_report_ids.py REPORT -> every backticked review ID in the report must exist in the source reviews.jsonl,
at the folder/line recorded in cited-reviews.json; every E-reference in the text must be defined in Appendix C."""
import json, re, sys, glob, os
ROOT = "/Users/lalith/Desktop/store reviews/Research"
rep = open(sys.argv[1]).read()
cites = json.load(open(os.path.join(ROOT, "Research Reports/Day Structure and Organization/Day Structure Evidence/Whole-Corpus Coding/cited-reviews.json")))["cites"]
ids_in_report = set(re.findall(r"`([0-9a-f-]{8,})`", rep))
base = {"App Store": "App Store Reviews", "Google Play": "Play Store Reviews"}
bad = []
by_id = {c["id"]: c for c in cites.values()}
for rid in sorted(ids_in_report):
    c = by_id.get(rid)
    if not c: bad.append(f"{rid}: not in cited-reviews.json"); continue
    f = os.path.join(ROOT, base[c["store"]], c["folder"], "reviews.jsonl")
    with open(f) as fh:
        for n, l in enumerate(fh, 1):
            if n == c["line"]:
                if json.loads(l)["review_id"] != rid: bad.append(f"{rid}: line {n} of {f} holds another id")
                break
        else: bad.append(f"{rid}: line {c['line']} beyond end of {f}")
defined = set(re.findall(r"^\| (E\d+) \|", rep, re.M))
used = set()
for a, b in re.findall(r"E(\d+)(?:–E(\d+))?", rep.split("## Appendix C")[0]):
    lo = int(a); hi = int(b) if b else lo
    used |= {f"E{k}" for k in range(lo, hi + 1)}
print(f"IDs in report: {len(ids_in_report)} | bad: {len(bad)} | E-refs used: {len(used)} | defined: {len(defined)} | undefined: {sorted(used - defined, key=lambda x:int(x[1:]))} | unused: {len(defined - used)}")
for b_ in bad: print("  ", b_)
