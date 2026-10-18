"""Account and backup pages (14 Oct 2026, Current Work 112): what people say about where their data lives, why an
account is needed, Plus on another phone or platform, and family plans. Run from Research/Temp/account-pages."""
import json, re, glob, os, collections
ROOT = "../.."
P = {
 'OWN_CLOUD': r"(my|your|their|user'?s?) own (google ?drive|drive|icloud|cloud|dropbox|storage)"
              r"|(stored|stores|saved|saves|kept|keeps|lives?|stays?) (only )?(in|on|to) (my|your|the user'?s?) (google ?drive|icloud|drive|cloud)"
              r"|(not|never|isn'?t|aren'?t|no) (stored |saved |kept )?(on|in) (their|the developer'?s?|your|any|a) (servers?|cloud)"
              r"|(your|my) data (stays|is stored|is kept|lives|remains) (on|in)",
 'WHY_ACCOUNT': r"why (do|would|should|must) (i|you|we|one) (need|have|make|create)( to (make|create|have))? an? (account|login|log-?in|sign ?up)"
                r"|(force[ds]?|forcing|require[ds]?|requiring|have to|need to|must) (to )?(create|make|sign ?up|register|log ?in|sign ?in)\w*( for)? an? ?(account)?.{0,60}(just|only|simply) (to|for)"
                r"|account (is )?(only|just) (for|to|used for) "
                r"|(no|without an?|doesn'?t need an?|don'?t need an?|no need for an?) (account|sign ?up|login|registration)",
 'PURCHASE_MOVE': r"(bought|paid|purchased|premium|pro version|lifetime|subscription|unlock\w*).{0,90}(new phone|new iphone|new device|android|iphone|ipad|switch\w*|another (phone|device)|other (phone|device)|reinstall\w*)"
                  r".{0,90}(again|restore\w*|lost|gone|pay|recogni[sz]e|transfer\w*|carry|not (work|show|there))",
 'RESTORE_PURCHASE': r"restore (my |the )?(purchase|premium|pro|subscription|lifetime)|(purchase|premium|pro|subscription) (won'?t|doesn'?t|didn'?t|not|isn'?t) (restor|transfer|carr|show)",
 'FAMILY': r"family (plan|sharing|share|pack|members?|subscription|license|licence|version|account)|share (it |premium |pro |the purchase )?with (my )?(family|wife|husband|partner|kids|daughter|son)",
 'WHERE_DATA': r"where (is|are|does|do) (my|the) (data|habits|backups?|information|info) (stored|saved|kept|go)|where (is|are) (it|they|everything) (stored|saved)"
               r"|who (can|could) (see|read|access) (my|the) (data|habits|info)",
}
TOPIC = re.compile(r"habit|streak|data|progress|backup|back up|restor|history|account|sync|record|log|purchase|premium|pro|paid|family|privacy|private", re.I)
RX = {k: re.compile(v, re.I) for k, v in P.items()}
out = open("candidates.jsonl", "w"); counts = collections.Counter(); apps = collections.defaultdict(set); total = 0
bystore = collections.Counter()
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"{ROOT}/{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for i, line in enumerate(open(f)):
            r = json.loads(line); total += 1
            text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip(" —")
            hits = [k for k, rx in RX.items() if rx.search(text)]
            if not hits or not TOPIC.search(text): continue
            for h in hits: counts[(store,h)] += 1; apps[h].add(app)
            out.write(json.dumps({"key": f"{store}{app.split('.')[0]}#{i}", "store": store, "app": app, "review_id": r["review_id"],
                                  "rating": r.get("rating"), "date": (r.get("date") or "")[:10],
                                  "loc": r.get("country") or r.get("language"), "hits": hits, "text": text}, ensure_ascii=False) + "\n")
print("reviews scanned", total)
for k in P: print(k, {s: counts[(s,k)] for s in "APN"}, "apps", len(apps[k]))
