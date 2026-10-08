import json, collections, statistics
rows = {json.loads(l)["n"]: json.loads(l) for l in open("read.jsonl")}
coded = {int(k): v for k, v in json.load(open("coded.json")).items()}
def grp(r):
    if r["store"] in "AP": return "habit"
    a = r["app"]
    return "notes" if a.startswith("3.") else "keep" if a.startswith("7.") else "sheets" if a.startswith("9.") else "otherNative"
by = collections.defaultdict(lambda: collections.defaultdict(list))
for n, cs in coded.items():
    r = rows[n]
    for c in cs:
        if c == "NR": continue
        by[c][grp(r)].append(n)
rel = sum(1 for cs in coded.values() if cs != ["NR"])
print("relevant reviews", rel, "of", len(coded))
print(f"{'code':16} {'all':>5} {'habit':>5} {'apps':>4} {'★':>4} | {'notes':>5} {'keep':>5} {'sheets':>6} {'other':>5}")
for c, g in sorted(by.items(), key=lambda kv: -sum(len(v) for v in kv[1].values())):
    alln = [n for v in g.values() for n in v]
    h = g.get("habit", [])
    apps = len({rows[n]["app"] for n in h})
    stars = statistics.mean(rows[n]["rating"] for n in alln)
    print(f"{c:16} {len(alln):5} {len(h):5} {apps:4} {stars:4.2f} | {len(g.get('notes',[])):5} {len(g.get('keep',[])):5} {len(g.get('sheets',[])):6} {len(g.get('otherNative',[])):5}")
json.dump({c: {k: v for k, v in g.items()} for c, g in by.items()}, open("tally.json", "w"))
# relevant per group
rg = collections.Counter(grp(rows[n]) for n, cs in coded.items() if cs != ["NR"])
print(rg)
print("habit apps with any relevant review:", len({rows[n]['app'] for n, cs in coded.items() if cs != ['NR'] and rows[n]['store'] in 'AP'}))
