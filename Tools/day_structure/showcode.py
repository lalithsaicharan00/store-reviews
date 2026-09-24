"""showcode.py CODE [start] [count] -> compact text of reviews hand-coded with CODE (for sub-typing)."""
import json,sys,re
src=open("screen.py").read().split("def recs")[0]; exec(src)
IDX=[json.loads(l) for l in open("index.jsonl")]
code=sys.argv[1]; s=int(sys.argv[2]) if len(sys.argv)>2 else 0; n=int(sys.argv[3]) if len(sys.argv)>3 else 100
rows=[json.loads(l) for l in open("coded.jsonl")]
rows=[c for c in rows if code in c["codes"] and "D" not in c["codes"]][s:s+n]
for c in rows:
    t=IDX[c["i"]]["text"].replace("\n"," ")
    if len(t)>420:
        spans=[]
        for k in c["fam"]:
            for m in F[k].finditer(t): spans.append((max(0,m.start()-150),min(len(t),m.end()+150)))
        spans.sort(); mg=[]
        for a,b in spans:
            if mg and a<=mg[-1][1]: mg[-1]=(mg[-1][0],max(b,mg[-1][1]))
            else: mg.append((a,b))
        t=" … ".join(t[a:b] for a,b in mg[:2]) or t[:420]
    print(f'{c["i"]}|{c["store"][0]}{c["folder"].split(".")[0]}|{c["rating"]}|{" ".join(c["codes"])}| {t[:600]}')
