"""Theme counts: reviews, apps, mean rating; habit apps (App/Play Store) vs built-in apps."""
import json, glob, collections
rs = [json.loads(l) for l in open("../../../Temp/onboarding-returning/candidates.jsonl")]
codes = {}
for f in sorted(glob.glob("cls/*.txt")):
    for line in open(f):
        head = line.split(" | ")[0].split()
        codes[int(head[0])] = head[1:]
on = [i for i, c in codes.items() if c != ["NR"]]
print("candidates", len(rs), "on topic", len(on), "apps", len({rs[i]["app"] for i in on}),
      "habit", sum(rs[i]["store"] != "N" for i in on), "built-in", sum(rs[i]["store"] == "N" for i in on))
t = collections.defaultdict(list)
for i, c in codes.items():
    for k in c:
        if k != "NR": t[k].append(i)
print(f"{'code':16} {'n':>4} {'apps':>4} {'mean':>5} {'habit':>5} {'1star%':>6}")
for k, ids in sorted(t.items(), key=lambda kv: -len(kv[1])):
    r = [rs[i]["rating"] for i in ids]
    print(f"{k:16} {len(ids):4} {len({rs[i]['app'] for i in ids}):4} {sum(r)/len(r):5.2f} {sum(rs[i]['store']!='N' for i in ids):5} {100*sum(x==1 for x in r)/len(r):5.0f}%")
json.dump({k: [rs[i]["review_id"] for i in v] for k, v in t.items()}, open("theme_ids.json", "w"), indent=0)
