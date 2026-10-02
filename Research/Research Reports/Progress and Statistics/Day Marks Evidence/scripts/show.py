import json, re, sys
sys.path.insert(0, 'Temp/heatmap_expect')
rows = json.load(open('Temp/heatmap_expect/tagged.json'))
exec(open('Temp/heatmap_expect/tag.py').read().split("RX =")[0])  # loads C
code = sys.argv[1]; w = int(sys.argv[2]) if len(sys.argv) > 2 else 170
rx = re.compile(C[code], re.I)
sel = [r for r in rows if code in r['codes']]
for i, r in enumerate(sel):
    t = r['text'].replace('\n', ' ')
    m = rx.search(t); a = max(0, m.start() - w); b = min(len(t), m.end() + w)
    print(f"{i}|{r['r']}★|{r['lang']}|{r['app'].split('. ',1)[-1][:14]}| …{t[a:b]}…")
