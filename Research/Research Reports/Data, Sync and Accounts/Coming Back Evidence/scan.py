"""Coming back (14 Oct 2026): gaps the 9 Oct onboarding study didn't cover. Run from Research/Temp/comeback (it reads
../onboarding-returning/candidates.jsonl to skip reviews already read, and the corpora two levels up). Writes candidates.jsonl."""
import json, re, glob, os, collections
ROOT = "../.."
P = {
 'DRIVE': r"google ?drive.{0,140}(restor\w*|back ?up\w*|recover\w*|found|find|account|sync\w*|transfer\w*|import\w*|lost|gone|empty|nothing)"
          r"|(restor\w*|back ?up\w*|recover\w*|import\w*).{0,100}google ?drive",
 'WRONG_CLOUD': r"(different|wrong|another|other|second|old|new|work|personal) (google|gmail|apple|icloud) (account|id|e-?mail)"
                r"|(different|wrong|another|other|second|old) (e-?mail|account).{0,80}(drive|icloud|backup|restor\w*)"
                r"|(drive|icloud|backup|restor\w*).{0,80}(different|wrong|another|other|second) (e-?mail|account|google|gmail|apple id)",
 'OLD_PHONE': r"(old|previous|former|last) (phone|iphone|device|handy|ipad).{0,60}(broke|broken|lost|stolen|died|dead|smashed|cracked|water|stopped working|won'?t turn on|bricked|reset)"
              r"|(broke|broken|lost|stolen|died|dead|smashed|cracked|dropped) (my )?(phone|iphone|device).{0,140}(data|habits|streak|progress|backup|restor\w*|history|everything)",
 'CODE_MOVE': r"(transfer|move|moving|migrat\w*|switch\w*|send|sync)\w* .{0,60}(code|qr|scan\w*|nearby|bluetooth|wi-?fi|both (phones|devices))"
              r"|(code|qr).{0,40}(transfer|move|new phone|other phone|other device)",
 'CROSS': r"(iphone|ios|apple|ipad).{0,60}(to|from|and|switch\w*|moved?) .{0,20}(android|samsung|pixel|galaxy|google phone)"
          r"|(android|samsung|pixel|galaxy).{0,60}(to|from|and|switch\w*|moved?) .{0,20}(iphone|ios|apple)",
 'WHICH_BACKUP': r"(which|choose|select|pick|latest|newest|recent|older|old|wrong) (back ?up|backup file|restore point)"
                 r"|back ?up (from|dated|of) (\w+ )?(days?|weeks?|months?) ago",
}
TOPIC = re.compile(r"habit|streak|data|progress|backup|back up|restor|history|account|transfer|sync|record|log", re.I)
RX = {k: re.compile(v, re.I) for k, v in P.items()}
seen = set()
old = "../onboarding-returning/candidates.jsonl"
if os.path.exists(old):
    for l in open(old): seen.add(json.loads(l)["review_id"])
out = open("candidates.jsonl", "w"); counts = collections.Counter(); apps = collections.defaultdict(set); total = 0; skipped = 0
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"{ROOT}/{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for i, line in enumerate(open(f)):
            r = json.loads(line); total += 1
            text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip(" —")
            hits = [k for k, rx in RX.items() if rx.search(text)]
            if not hits or not TOPIC.search(text): continue
            if r["review_id"] in seen: skipped += 1; continue
            for h in hits: counts[h] += 1; apps[h].add(app)
            out.write(json.dumps({"key": f"{store}{app.split('.')[0]}#{i}", "store": store, "app": app, "review_id": r["review_id"],
                                  "rating": r.get("rating"), "date": (r.get("date") or "")[:10],
                                  "loc": r.get("country") or r.get("language"), "hits": hits, "text": text}, ensure_ascii=False) + "\n")
print("reviews scanned", total, "already read on 9 Oct", skipped)
for k in P: print(k, counts[k], "apps", len(apps[k]))
