import json, os, glob, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from competitors_classification import APPS
ROOT = "/Users/lalith/Desktop/store reviews/Research"
def review(ref):
    tag, rest = ref[0], ref[1:]; n, i = rest.split("#")
    base = "App Store Reviews" if tag == "A" else "Play Store Reviews"
    d = glob.glob(os.path.join(ROOT, base, f"{n}. *"))[0]
    for k, line in enumerate(open(os.path.join(d, "reviews.jsonl"), encoding="utf-8")):
        if k == int(i):
            r = json.loads(line); return ((r.get("title") or "") + ". " + (r.get("body") or r.get("text") or r.get("content") or ""))
bad = 0; n = 0
for app in APPS:
    for ref, q in app[5]:
        n += 1; t = review(ref)
        if t is None or q.lower() not in t.lower(): bad += 1; print("MISMATCH", ref, q)
print(f"{n} quotes checked, {bad} mismatches")
from collections import Counter
m = Counter(a[2] for a in APPS); c = Counter(a[3] for a in APPS)
both = sum(1 for a in APPS if a[2] == "yes" and a[3] == "yes"); neither = sum(1 for a in APPS if a[2] == "no" and a[3] == "no")
print("apps", len(APPS), "milestones", dict(m), "celebrations", dict(c), "both", both, "neither", neither)
