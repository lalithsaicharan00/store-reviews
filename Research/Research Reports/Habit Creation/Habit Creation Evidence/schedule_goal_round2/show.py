import json, sys, re
# usage: show.py theme stores(App,Play,Native) start end [window] [match-regex]
theme, stores, start, end = sys.argv[1], sys.argv[2].split(","), int(sys.argv[3]), int(sys.argv[4])
w = int(sys.argv[5]) if len(sys.argv) > 5 else 220
mf = re.compile(sys.argv[6], re.I) if len(sys.argv) > 6 else None
h = [r for r in json.load(open("Temp/schedule-goal/hits.json"))[theme] if r["store"] in stores and (not mf or mf.search(r["match"]))]
print("total", len(h))
for i, r in enumerate(h[start:end], start):
    t = re.sub(r"\s+", " ", r["text"]).replace("&#39;", "'").replace("&quot;", '"').replace("&#34;", '"').replace("&amp;", "&")
    m = t.lower().find(r["match"].lower().replace("&#39;", "'"))
    m = max(m, 0)
    a, b = max(0, m - w), min(len(t), m + len(r["match"]) + w)
    s = ("…" if a else "") + t[a:b] + ("…" if b < len(t) else "")
    print(f"[{i}] {r['id']} {r['app'][:18]}|{r['rating']}| {s}")
