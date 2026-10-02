"""Weekly habit cards research (2 Oct 2026): what people want to see, per habit type, over a week.
Screens every habit-app review for type-specific wording; tighten.py then keeps hits with a statistics or display word
within 120 characters of that wording."""
import json, glob, re, os, collections
from patterns import T
ROOT = "/home/user/store-reviews/Research"
ADJ_PLAY = {84,85,95,96,97,100,111,121,122,126,127,129,131}
P = {k: re.compile(v, re.I) for k, v in T.items()}
hits = collections.defaultdict(dict); tot = 0
for store, pat in [("app", "App Store Reviews/*/reviews.jsonl"), ("play", "Play Store Reviews/*/reviews.jsonl")]:
    for f in sorted(glob.glob(os.path.join(ROOT, pat))):
        folder = f.split("/")[-2]; n = int(folder.split(".")[0])
        if store == "play" and n in ADJ_PLAY: continue
        for line in open(f):
            r = json.loads(line); tot += 1
            text = " ".join(((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).split())
            for k, p in P.items():
                if p.search(text):
                    hits[k][str(r["review_id"])] = {"id": str(r["review_id"]), "store": store, "app": folder, "stars": r.get("rating"), "date": (r.get("date") or "")[:10], "text": text}
print("scanned", tot)
json.dump({k: list(v.values()) for k, v in hits.items()}, open("type_hits_all.json", "w"), ensure_ascii=False)
for k, v in hits.items(): print(k, len(v))
