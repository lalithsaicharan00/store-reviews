# 10 Oct 2026: do upgrades / signing in that change or remove things upset people? and new-device expectations with an account.
import json, re, glob, os, sys, collections
sys.stdout.reconfigure(encoding="utf-8")
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", "..", "..", "Research")  # the repo's Research/ folder
P = {
 "UPGRADE_REMOVED": r"(after|since|once) (i )?(upgrad\w*|bought (premium|pro|plus)|went (premium|pro)|paid|subscrib\w*).{0,80}(lost|removed|gone|disappear\w*|no longer|can'?t (find|see|use)|missing)",
 "SIGNIN_CHANGED": r"(after|since|once|when) (i )?(signed|logged) (in|up).{0,80}(lost|gone|disappear\w*|removed|missing|reset|changed|different)",
 "NEWDEVICE_SIGNIN_OK": r"(new (phone|iphone|device|ipad|tablet)).{0,120}(just|simply|only had to) (sign|log)(ged)? ?in.{0,60}(all|everything|data|habits|progress).{0,20}(there|back|restored|synced)",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
hits = collections.defaultdict(list); n=0
for f in glob.glob(os.path.join(ROOT, "App Store Reviews", "*", "reviews.jsonl")) + glob.glob(os.path.join(ROOT, "Play Store Reviews", "*", "reviews.jsonl")):
    store = "A" if "App Store" in f else "P"; app = os.path.basename(os.path.dirname(f))
    for line in open(f, encoding="utf-8"):
        try: r = json.loads(line)
        except: continue
        n += 1; t = (r.get("title") or "") + " " + (r.get("body") or r.get("content") or r.get("text") or "")
        for k, rx in RX.items():
            if rx.search(t): hits[k].append({"id": r.get("review_id") or r.get("reviewId"), "app": store+":"+app, "stars": r.get("rating") or r.get("score"), "text": re.sub(r"\s+"," ",t.strip())})
json.dump(hits, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "hits2.json"), "w", encoding="utf-8"), ensure_ascii=False)
print("scanned", n)
for k in P:
    h = hits[k]; s = [x["stars"] for x in h if isinstance(x["stars"], (int, float))]
    print(k, len(h), "mean", round(sum(s)/len(s), 2) if s else None)
    for x in h[:40]: print(f'  [{x["stars"]}] {x["app"][:24]} {x["id"]}: {x["text"][:230]}')
