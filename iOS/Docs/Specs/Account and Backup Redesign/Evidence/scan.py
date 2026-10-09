# Fresh scan for the Account screen (10 Oct 2026): what people want to see/do there.
import json, re, glob, os, sys, collections
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", "..", "..", "Research")  # the repo's Research/ folder
P = {
 "FIND_LOGIN": r"(can'?t|cannot|couldn'?t|unable to|no way to|don'?t see|didn'?t see) (find|see|locate)? ?(the |a |any )?(log ?in|sign ?in)|where (do i|can i|to|is the|is) (log ?in|sign ?in)|no (log ?in|sign ?in) (button|option)|(log ?in|sign ?in) (button|option) (is )?(hidden|missing|nowhere)",
 "LOGIN_VS_SIGNUP": r"already (have|had|made|created) an? account|only (lets?|let) (me|you) (sign up|create)|(sign up|create an account) instead of (log|sign)|asks? me to (sign up|create an account) (again|even though)|new account (instead|again)|created a (second|new) account (by mistake|accidentally)",
 "SEE_ACCOUNT": r"(which|what) (account|email) (am i|i'?m|i am|is) (logged|signed)|(logged|signed) in (as|with which)|(see|view|check|show) (my )?(account|profile) (info|details|page|settings)|account (page|screen|settings|section|tab)|profile (page|screen|section|tab)",
 "WHY_ACCOUNT": r"why (do|would|should) (i|you|we) (need|have|want) (to (create|make|have) )?an? account|point (of|in) (creating |making |having )?an? account|what('?s| is| does) (the )?(account|signing in|logging in) (for|do|give)|benefits? of (an |the |having an )?account",
 "FORCED": r"(forc(e|es|ed|ing)|requir(e|es|ed|ing)|make[sd]? you|have to|must) (to )?(create|make|sign up|register|log ?in|sign ?in)( for)? an? ?(account)?",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
hits = collections.defaultdict(list)
files = glob.glob(os.path.join(ROOT, "App Store Reviews", "*", "reviews.jsonl")) + glob.glob(os.path.join(ROOT, "Play Store Reviews", "*", "reviews.jsonl"))
n = 0
for f in files:
    app = os.path.basename(os.path.dirname(f)); store = "A" if "App Store" in f else "P"
    for line in open(f, encoding="utf-8"):
        try: r = json.loads(line)
        except: continue
        n += 1
        t = ((r.get("title") or "") + " " + (r.get("body") or r.get("content") or r.get("text") or ""))
        for k, rx in RX.items():
            if rx.search(t): hits[k].append({"id": r.get("review_id") or r.get("reviewId"), "app": store + ":" + app, "stars": r.get("rating") or r.get("score"), "text": t.strip()})
out = os.path.join(os.path.dirname(__file__), "hits.json")
json.dump(hits, open(out, "w", encoding="utf-8"), ensure_ascii=False, indent=0)
print("reviews scanned", n)
for k in P: 
    h = hits[k]; s = [x["stars"] for x in h if isinstance(x["stars"], (int, float))]
    print(k, len(h), "apps", len({x['app'] for x in h}), "mean", round(sum(s)/len(s),2) if s else None)
