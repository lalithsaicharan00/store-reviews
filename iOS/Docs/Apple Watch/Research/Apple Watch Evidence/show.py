import json, re, sys
d = [x for x in json.load(open("watch_all.json")) if x["store"] == "App "]
json.dump(d, open("watch_app.json", "w"), ensure_ascii=False)
PAT = re.compile(r"apple ?watch|watch ?os|watch app|watch version|on (my|the) watch|from (my|the) watch|my watch|the watch|complication|smart stack|wrist|reloj|montre|apple-?watch|uhr|ウォッチ|워치|手表|手錶|relógio|orologio|smartwatch", re.I)
a, b = int(sys.argv[1]), int(sys.argv[2])
for i in range(a, min(b, len(d))):
    t = d[i]["text"].replace("\n", " "); m = PAT.search(t); s = max(0, (m.start() if m else 0) - 150)
    print(f"{i}|{d[i]['app'][:12]}|{d[i]['rating']}|{d[i]['date'][:7]}| {t[s:s+340]}")
