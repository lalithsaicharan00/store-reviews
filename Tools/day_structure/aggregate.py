"""aggregate.py -> validate the hand-coded cls/*.txt map and count every code.

Checks: ranges contiguous and cover 0..N-1, every index appears at most once, every code known,
remap applied. Writes coded.jsonl (one row per relevant review) and summary.json."""
import json, os, re, collections

IDX = [json.loads(l) for l in open("index.jsonl")]
N = len(IDX)
assert [r["i"] for r in IDX] == list(range(N)), "index not dense"

KNOWN = set("""T+ T? TC TF TM TA TV TE TO TH TR
G+ G? GF GV GL GS GD GN
R+ R? RF RC RS RU HT
S+ S? ST SP SF SN
$ L W I D""".split())

# remap: "idx OLD->NEW"
REMAP = collections.defaultdict(list)
for l in open("remap.txt"):
    l = l.strip()
    if not l or l.startswith("#"): continue
    i, ch = l.split()
    old, new = ch.split("->")
    REMAP[int(i)].append((old, new))

errors = []
ranges = []
codes = {}
for fn in sorted(os.listdir("cls")):
    m = re.fullmatch(r"(\d+)-(\d+)\.txt", fn)
    if not m: errors.append(f"bad filename {fn}"); continue
    a, b = int(m[1]), int(m[2]); ranges.append((a, b, fn))
    for ln, l in enumerate(open(os.path.join("cls", fn)), 1):
        l = l.strip()
        if not l or l.startswith("#"): continue
        parts = l.split()
        i = int(parts[0]); cs = parts[1:]
        if not a <= i < b: errors.append(f"{fn}:{ln} index {i} outside range")
        if i in codes: errors.append(f"{fn}:{ln} duplicate index {i}")
        bad = [c for c in cs if c not in KNOWN]
        if bad: errors.append(f"{fn}:{ln} unknown codes {bad}")
        if not cs: errors.append(f"{fn}:{ln} no codes")
        if len(set(cs)) != len(cs): errors.append(f"{fn}:{ln} repeated code")
        codes[i] = cs

ranges.sort()
pos = 0
for a, b, fn in ranges:
    if a != pos: errors.append(f"gap/overlap before {fn}: expected {pos}, got {a}")
    pos = b
if pos != N: errors.append(f"coverage ends at {pos}, index has {N}")

for i, chs in REMAP.items():
    if i not in codes: errors.append(f"remap index {i} not coded"); continue
    for old, new in chs:
        if old not in codes[i]: errors.append(f"remap {i}: {old} not present"); continue
        codes[i] = [new if c == old else c for c in codes[i]]
        codes[i] = list(dict.fromkeys(codes[i]))

print("records in index:", N, "| coded (relevant):", len(codes), "| errors:", len(errors))
for e in errors[:40]: print("  ", e)

FLAGS = {"$", "L", "W", "I", "D"}
coded = []
for i in sorted(codes):
    r = IDX[i]
    coded.append({"i": i, "store": r["store"], "folder": r["folder"], "line": r["line"], "id": r["id"],
                  "rating": r["rating"], "date": r["date"], "lang": r["lang"], "fam": r["fam"], "codes": codes[i]})
with open("coded.jsonl", "w") as f:
    for c in coded: f.write(json.dumps(c, ensure_ascii=False) + "\n")

def app_key(c): return f'{c["store"]}:{c["folder"]}'
per_code = collections.defaultdict(lambda: {"n": 0, "app": 0, "play": 0, "D": 0, "$": 0, "L": 0, "W": 0, "I": 0,
                                           "apps": collections.Counter(), "ratings": collections.Counter()})
for c in coded:
    fl = set(c["codes"]) & FLAGS
    for k in c["codes"]:
        if k in FLAGS: continue
        p = per_code[k]; p["n"] += 1; p[c["store"]] += 1; p["ratings"][c["rating"]] += 1
        p["apps"][app_key(c)] += 1
        for g in fl: p[g] += 1

fam_of = lambda k: {"T": "TOD", "G": "GRP", "R": "RTN", "H": "RTN", "S": "SUB"}[k[0]]
summary = {"N_index": N, "N_coded": len(coded), "errors": errors,
           "by_store_index": collections.Counter(r["store"] for r in IDX),
           "by_store_coded": collections.Counter(c["store"] for c in coded),
           "codes": {}}
# family-level unique review counts (non-D and all)
famcount = collections.defaultdict(lambda: {"all": 0, "habit_context": 0})
for c in coded:
    fams = {fam_of(k) for k in c["codes"] if k not in FLAGS}
    for fm in fams:
        famcount[fm]["all"] += 1
        if "D" not in c["codes"]: famcount[fm]["habit_context"] += 1
summary["families"] = famcount
for k, p in sorted(per_code.items()):
    summary["codes"][k] = {"n": p["n"], "app": p["app"], "play": p["play"], "D": p["D"], "$": p["$"], "L": p["L"],
                           "W": p["W"], "I": p["I"], "n_apps": len(p["apps"]),
                           "top_apps": p["apps"].most_common(6),
                           "ratings": dict(sorted(p["ratings"].items()))}
json.dump(summary, open("summary.json", "w"), ensure_ascii=False, indent=1, default=dict)

print("\nfamily unique reviews (all / excluding one-off to-do context D):")
for fm, v in famcount.items(): print(f"  {fm}: {v['all']} / {v['habit_context']}")
print("\ncode  n  (app/play)  D  $  L  W  apps  top")
for k, v in summary["codes"].items():
    top = ", ".join(f'{a.split(":")[0][0]}{a.split(":")[1].split(".")[0]}={n}' for a, n in v["top_apps"][:4])
    print(f'{k:3} {v["n"]:5} ({v["app"]}/{v["play"]}) D{v["D"]} ${v["$"]} L{v["L"]} W{v["W"]} I{v["I"]} apps={v["n_apps"]}  {top}')
