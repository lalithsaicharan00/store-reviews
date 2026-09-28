"""verify_ids.py [report.md] — checks every coded ID (codes.py) and, if given, every review ID cited in the report
against the source reviews.jsonl files. Prints unknown IDs and exits 1 if any."""
import json, glob, re, sys, os
here = os.path.dirname(os.path.abspath(__file__))
ids = {"A": set(), "P": set(), "N": set()}
for f in glob.glob("*Store Reviews/*/reviews.jsonl"):
    k = f.split("/")[0][0]  # A(pp) P(lay) N(ative)
    for line in open(f, encoding="utf-8"):
        ids[k].add(json.loads(line)["review_id"])
allids = set().union(*ids.values())
ns = {}; exec(open(os.path.join(here, "codes.py")).read(), ns)
bad = [x for v in ns["CODES"].values() for x in v if x.split(":", 1)[1] not in ids[x[0]]]
print("coded ids:", sum(len(set(v)) for v in ns["CODES"].values()), "unique:", len({x for v in ns["CODES"].values() for x in v}), "unknown:", bad)
dups = {k: len(v) - len(set(v)) for k, v in ns["CODES"].items() if len(v) != len(set(v))}
print("intra-code duplicates:", dups)
if len(sys.argv) > 1:
    t = open(sys.argv[1], encoding="utf-8").read()
    cited = set(re.findall(r"`([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|\d{9,12})`", t))
    miss = sorted(c for c in cited if c not in allids)
    print("report cites:", len(cited), "unknown:", miss)
    bad += miss
sys.exit(1 if bad else 0)
