"""Apple Watch app research (10 Oct 2026): every review that talks about a watch app. Machine inventory, then hand reading."""
import json, re, glob, os, collections
ROOT = "/Users/lalith/Desktop/store reviews/Research"
STRONG = re.compile(r"apple ?watch|watch ?os|watch app|watch version|on (my|the) watch|from (my|the) watch|my watch|the watch|complication|smart stack|wrist|"
                    r"reloj|montre connectée|sur (ma|la) montre|apple-?watch|uhr-app|auf der uhr|アップルウォッチ|ウォッチ|애플워치|워치|手表|手錶|relógio|orologio|smartwatch|galaxy watch|wear ?os|pixel watch|garmin|fitbit", re.I)
NOT = re.compile(r"\bwatch(ing|ed)? (an? |the )?(ad|ads|video|videos|advert|commercial)", re.I)
out = []; per = collections.Counter()
for corpus in ["App Store Reviews", "Play Store Reviews"]:
    for path in glob.glob(f"{ROOT}/{corpus}/*/reviews.jsonl"):
        app = os.path.basename(os.path.dirname(path))
        for line in open(path):
            r = json.loads(line); t = (r.get("title") or "") + ". " + (r.get("body") or r.get("text") or "")
            m = STRONG.search(t)
            if m and not (NOT.search(t) and not re.search(r"apple ?watch|watch app|complication", t, re.I)):
                out.append({"store": corpus[:4], "app": app, "id": r.get("review_id"), "rating": r.get("rating"),
                            "date": (r.get("date") or r.get("updated") or "")[:10], "text": t[:900]})
                per[(corpus[:4])] += 1
json.dump(out, open("watch_all.json", "w"), ensure_ascii=False)
print(len(out), per)
c = collections.Counter(x["app"][:30] for x in out if x["store"] == "App ")
print(c.most_common(15))
