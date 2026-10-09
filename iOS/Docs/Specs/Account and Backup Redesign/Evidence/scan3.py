# 10 Oct 2026: for people who sync across devices, do they want a separate backup (iCloud/Drive/file) too? What goes wrong?
import json, re, glob, os, sys, collections
sys.stdout.reconfigure(encoding="utf-8")
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", "..", "..", "Research")  # the repo's Research/ folder
P = {
 "WANT_BACKUP_BESIDES_SYNC": r"(sync|synced|syncing|cloud).{0,80}\b(also|additional|separate|independent|extra|second|local|offline)\b (backup|copy|export)|(backup|export).{0,50}\bin case\b.{0,40}(sync|server|cloud|company|app)|sync (is|isn'?t|is not) (a |the same as a )?backup",
 "SYNC_SPREAD_LOSS": r"(sync\w*).{0,80}(deleted|wiped|erased|overwrote|overwritten|lost|disappeared).{0,60}(all|both|every|other) (devices|device|phones|my devices)|(deleted|wiped|erased|gone) (on|from) (all|both|every) (my )?(devices|phones)",
 "SYNC_DUPLICATES": r"(sync\w*).{0,60}(duplicat\w*|doubled|twice|two copies|multiple copies)",
 "SERVER_GONE": r"(server|servers|company|app) (shut ?down|went down|closed|is down|was down|stopped working).{0,80}(lost|gone|data|habits)",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
hits = collections.defaultdict(list); n = 0
for f in glob.glob(os.path.join(ROOT, "App Store Reviews", "*", "reviews.jsonl")) + glob.glob(os.path.join(ROOT, "Play Store Reviews", "*", "reviews.jsonl")):
    store = "A" if "App Store" in f else "P"; app = os.path.basename(os.path.dirname(f))
    for line in open(f, encoding="utf-8"):
        try: r = json.loads(line)
        except: continue
        n += 1; t = (r.get("title") or "") + " " + (r.get("body") or r.get("content") or r.get("text") or "")
        for k, rx in RX.items():
            if rx.search(t): hits[k].append({"id": r.get("review_id") or r.get("reviewId"), "app": store+":"+app, "stars": r.get("rating") or r.get("score"), "text": re.sub(r"\s+", " ", t.strip())})
json.dump(hits, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "hits3.json"), "w", encoding="utf-8"), ensure_ascii=False)
print("scanned", n)
for k in P:
    h = hits[k]; s = [x["stars"] for x in h if isinstance(x["stars"], (int, float))]
    print(k, len(h), "apps", len({x['app'] for x in h}), "mean", round(sum(s)/len(s), 2) if s else None)
