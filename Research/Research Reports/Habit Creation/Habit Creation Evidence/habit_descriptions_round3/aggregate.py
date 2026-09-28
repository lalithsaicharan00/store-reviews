"""Merge hand codes with their sentences and review ids. Output: Temp/mental-model/coded.jsonl + printed stats."""
import json, glob, re, collections
src = {}
for l in open("Temp/mental-model/habit_candidates.jsonl"):
    d = json.loads(l); src[("k", d["k"])] = d
for l in open("Temp/mental-model/dropped3_num.jsonl"):
    d = json.loads(l); src[("d", d["d"])] = d
for i, l in enumerate(open("Temp/mental-model/rejects.jsonl"), 1):
    d = json.loads(l); src[("r", i)] = d
rows = {}; bad = []
for kind, pat in (("k", "codes/b*.txt"), ("d", "dcodes/d*.txt"), ("r", "rcodes/r*.txt")):
    for f in sorted(glob.glob("Temp/mental-model/" + pat)):
        for line in open(f):
            line = line.strip()
            if not line or not line[0].isdigit(): continue
            parts = line.split()
            n = int(parts[0]); codes = parts[1].split(","); star = "*" in parts[2:]
            if (kind, n) not in src: bad.append((f, n)); continue
            rows[(kind, n)] = {"src": kind, "n": n, "codes": codes, "quote": star, **{k: src[(kind, n)][k] for k in ("id", "store", "app", "rating", "date", "s")}}
out = open("Temp/mental-model/coded.jsonl", "w")
for r in rows.values(): out.write(json.dumps(r, ensure_ascii=False) + "\n")
print("statements", len(rows), "bad refs", bad[:5], "unique reviews", len({r['id'] for r in rows.values()}))
CODE = re.compile(r"^(L|Q|N)?(Dn|Wn|Mn|Yn|W1|M1|Y1|D|W|M|Y|I|S|H|T|0|C|X)?(A)?(?::([trx]))?$")
inst = collections.Counter(); unk = collections.Counter()
for r in rows.values():
    for c in r["codes"]:
        if not CODE.match(c): unk[c] += 1
        inst[c] += 1
print("habit instances", sum(inst.values()), "unknown", unk.most_common(10))
