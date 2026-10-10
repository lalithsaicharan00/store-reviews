import os
D = os.path.dirname(os.path.abspath(__file__))  # matches.jsonl comes from scan.py (Research/Temp/no-account-backup/); copy it here to re-run
import json,collections,sys
keys=json.load(open(os.path.join(D,"keys.json"))); rows={}
for l in open(os.path.join(D,"matches.jsonl")):
    r=json.loads(l); rows[r["id"]]=r
seen=set(); codes={}
for l in open(os.path.join(D,"codes.txt")):
    if l.startswith("#") or not l.strip(): continue
    k,c=l.split()
    assert k in keys, k; assert k not in seen, k; seen.add(k)
    codes[k]=c.split(",")
assert set(keys)==seen, set(keys)-seen
print("validated:",len(seen),"coded, 0 unknown, 0 duplicates")
by=collections.defaultdict(lambda: collections.defaultdict(list))
for k,cs in codes.items():
    r=rows[keys[k]]
    for c in cs: by[c][r["store"]].append((r["rating"],r["app"],keys[k]))
print(f'{"code":16}{"App n":>7}{"★":>6}{"apps":>5}{"Play n":>8}{"★":>6}{"apps":>5}{"all":>6}')
for c in sorted(by,key=lambda c:-sum(len(v) for v in by[c].values())):
    a=by[c].get("App",[]); p=by[c].get("Play",[])
    f=lambda x:(f"{len(x):7}{(sum(i[0] for i in x)/len(x) if x else 0):6.2f}{len(set(i[1] for i in x)):5}")
    print(f"{c:16}{f(a)}{f(p).replace('   ',' ',0)}{len(a)+len(p):6}")
json.dump({k:v for k,v in codes.items()},open(os.path.join(D,"codes.json"),"w"))
