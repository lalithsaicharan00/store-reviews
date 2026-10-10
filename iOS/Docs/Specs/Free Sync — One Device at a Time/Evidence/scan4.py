# 11 Oct 2026: phone + iPad/tablet sync on the free plan? Reactions to sync being paid vs free.
import json, re, glob, os, sys, collections
sys.stdout.reconfigure(encoding="utf-8")
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", "..", "..", "Research")  # the repo's Research/ folder
DEV = r"(ipad|tablet|tab\b|other device|second device|multiple devices|all (my )?devices|between devices|across devices|phone and (my )?(ipad|tablet|computer|mac|laptop))"
P = {
 "SYNC_PAID_COMPLAINT": r"(sync\w*)[^.!?]{0,80}(only|just)?\s*(for|in|with|behind|requires?|need)\s*(a\s*)?(premium|pro|plus|paid|subscription|pay(ing)?)|(pay|paid|premium|pro|subscription)[^.!?]{0,40}(just|only)? ?(to|for) (sync|use (it )?on (my )?(ipad|tablet))",
 "SYNC_FREE_PRAISE": r"(free)[^.!?]{0,60}(sync\w*)|(sync\w*)[^.!?]{0,60}(for free|is free|free of charge)",
 "PAID_FOR_SYNC": r"(bought|paid|purchased|upgraded|subscribed|got (the )?(premium|pro))[^.!?]{0,80}(sync\w*|use (it )?on (my )?(ipad|tablet|both))",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
DX = re.compile(DEV, re.I)
hits = collections.defaultdict(list); n = 0
for f in glob.glob(os.path.join(ROOT, "App Store Reviews", "*", "reviews.jsonl")) + glob.glob(os.path.join(ROOT, "Play Store Reviews", "*", "reviews.jsonl")):
    store = "A" if "App Store" in f else "P"; app = os.path.basename(os.path.dirname(f))
    for line in open(f, encoding="utf-8"):
        try: r = json.loads(line)
        except: continue
        n += 1; t = (r.get("title") or "") + " " + (r.get("body") or r.get("content") or r.get("text") or "")
        if not DX.search(t): continue
        for k, rx in RX.items():
            if rx.search(t): hits[k].append({"id": r.get("review_id") or r.get("reviewId"), "app": store+":"+app, "stars": r.get("rating") or r.get("score"), "text": re.sub(r"\s+", " ", t.strip())})
json.dump(hits, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "hits4.json"), "w", encoding="utf-8"), ensure_ascii=False)
print("scanned", n)
for k in P:
    h = hits[k]; s = [x["stars"] for x in h if isinstance(x["stars"], (int, float))]
    print(k, len(h), "apps", len({x['app'] for x in h}), "mean", round(sum(s)/len(s), 2) if s else None)
