# Numeric needs beyond whole-number counters: decimals, entering a variable amount, and readings (weight, sleep).
import json, glob, re, collections
ROOT = "/Users/lalith/Desktop/store reviews/Research/"
files = glob.glob(ROOT + "App Store Reviews/*/reviews.jsonl") + glob.glob(ROOT + "Play Store Reviews/*/reviews.jsonl")
P = {
 "decimals": r"\b(decimals?|fractions?|half (a |an )?(glass|cup|litre|liter|hour|mile|km|page)|0[.,]5 |1[.,]5 |2[.,]5 )",
 "enter a variable amount": r"((enter|type|input|log|add) (a |the |my )?(custom|exact|specific|actual|different|any) (amount|number|value|quantity)|(each tap|every tap|one tap) (only )?adds|instead of (tapping|clicking) .{0,30}(times|\+)|(increment|step) (of|by) (1|one) only)",
 "readings (weight, sleep, mood score)": r"(track (my )?(weight|sleep hours|hours of sleep|blood pressure|mood score)|log (my )?(weight|sleep)|(weight|sleep) (tracking|tracker|log))",
}
res = collections.defaultdict(list)
for f in files:
    app = f.split("Research/")[1].split("/reviews")[0]
    for line in open(f, encoding="utf-8"):
        r = json.loads(line)
        t = f"{r.get('title') or ''} {r.get('body') or r.get('text') or r.get('content') or ''}".replace("&#39;", "'")
        if not re.search(r"\bhabit", t, re.I) and "habit" not in app.lower(): continue
        for k, p in P.items():
            m = re.search(p, t, re.I)
            if m: res[k].append((app, r.get("review_id"), r.get("rating") or r.get("score"), t[max(0, m.start()-200): m.start()+260]))
for k, v in res.items(): print(k, len(v), "reviews,", len({a for a, *_ in v}), "apps")
json.dump(res, open("numeric_hits.json", "w"), ensure_ascii=False)
