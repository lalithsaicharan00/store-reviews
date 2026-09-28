# Keyword floors for: (A) part of day WITHOUT a clock time / reminder; (B) forced to set a time or reminder;
# (C) wanting BOTH a part of the day and a reminder; (D) reminder time should place/sort the habit.
import json, glob, re, collections
ROOT = "/Users/lalith/Desktop/store reviews/Research/"
files = glob.glob(ROOT + "App Store Reviews/*/reviews.jsonl") + glob.glob(ROOT + "Play Store Reviews/*/reviews.jsonl")
P = r"(morning|afternoon|evening|night|time of (the )?day|part of (the )?day|section)"
pats = {
 "A_part_not_time": rf"({P}.{{0,120}}(not|rather than|instead of|without|no need for|don'?t want|don'?t need)( a| an)? (specific|exact|set|particular|precise)? ?(time|hour|reminder|notification|alarm)s?)|((not|rather than|instead of|without)( a| an)? (specific|exact|set|particular|precise) (time|hour).{{0,120}}{P})",
 "B_forced_time": r"(forced|force[sd]? (me|you|us)|have to|must|need to|required|requires|make[s]? (me|you)) (to )?(set|pick|choose|enter|put|add|select|give|assign)( in)? (a|an|the)? ?(specific |exact |set )?(time|reminder|notification|alarm)",
 "C_both": rf"({P}.{{0,150}}\b(reminders?|notifications?|notify|alert)\b)|(\b(reminders?|notifications?)\b.{{0,150}}{P})",
 "D_sort_by_time": r"(sort|order|arrange|organi[sz]e)[a-z]* (my |the |them |habits |tasks |list )*(by|according to|based on) (the )?(reminder|time|times|schedule)",
}
res = collections.defaultdict(list)
for f in files:
    app = f.split("Research/")[1].split("/reviews")[0]
    for i, line in enumerate(open(f, encoding="utf-8")):
        r = json.loads(line)
        t = f"{r.get('title') or ''} {r.get('body') or r.get('content') or r.get('text') or ''}".replace("&#39;", "'")
        for k, p in pats.items():
            if re.search(p, t, re.I): res[k].append((app, i, r.get("rating") or r.get("score"), t[:700]))
for k, v in res.items(): print(k, len(v))
json.dump(res, open("need_hits.json", "w"), ensure_ascii=False, indent=0)
