# Does "a unit means a counter" hold? A: people with a numeric habit who want a single tick.
# B: people who want the amount tracked, or partial credit, instead of yes/no.
import json, glob, re
ROOT = "/Users/lalith/Desktop/store reviews/Research/"
files = glob.glob(ROOT + "App Store Reviews/*/reviews.jsonl") + glob.glob(ROOT + "Play Store Reviews/*/reviews.jsonl")
units = r"(pages?|minutes?|mins?|glasses|cups?|litres?|liters?|steps|km|miles?|reps|push-?ups|chapters?|ounces|oz|ml|hours?|times)"
A = re.compile(r"((have|had|need|forced) to (enter|type|input|put in|log|add) (the |a |in )?(number|amount|value|quantity|count|minutes|pages)"
               r"|(don'?t|do not|didn'?t) (want|need) to (enter|type|input|log|count|track) (the |every |each )?(number|amount|value|quantity|minutes|pages|glass)"
               r"|(just|simply|only) (want|need|like) to (tick|check|mark)( it)?( off| as)?( done| complete)?"
               r"|(one|single) (tap|click|press) to (complete|finish|mark|check)"
               r"|mark (it |the habit )?(as )?(done|complete)[a-z]* (without|instead of) (entering|typing|adding|logging))", re.I)
B = re.compile(r"(not (always |just |everything is )?(a )?(yes|yes/no|yes or no)|more than (a )?(yes|yes/no|yes or no|just done)|(track|log|record|count) (how many|how much|the amount|the number|quantit)"
               r"|partial (progress|credit|completion|day)|half (done|a day)|only did (half|part)|(\d+) (of|out of) (\d+) " + units + ")", re.I)
out = {"A": [], "B": []}
for f in files:
    app = f.split("Research/")[1].split("/reviews")[0]
    for line in open(f, encoding="utf-8"):
        r = json.loads(line)
        t = f"{r.get('title') or ''} {r.get('body') or r.get('text') or r.get('content') or ''}".replace("&#39;", "'")
        if not re.search(r"\bhabit", t, re.I) and "habit" not in app.lower(): continue
        for k, p in (("A", A), ("B", B)):
            m = p.search(t)
            if m: out[k].append((app, r.get("review_id"), r.get("rating") or r.get("score"), (r.get("date") or "")[:10], t[max(0, m.start()-220): m.start()+330]))
for k, v in out.items(): print(k, len(v))
json.dump(out, open("unit_tick_hits.json", "w"), ensure_ascii=False)
