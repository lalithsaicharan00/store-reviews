"""pick.py CODE [N] [maxlen] -> short habit-context examples for CODE, spread across apps (for choosing citations)."""
import json,sys,collections
IDX=[json.loads(l) for l in open("index.jsonl")]
C=[json.loads(l) for l in open("coded.jsonl")]
code=sys.argv[1]; n=int(sys.argv[2]) if len(sys.argv)>2 else 8; ml=int(sys.argv[3]) if len(sys.argv)>3 else 300
rows=[c for c in C if code in c["codes"] and "D" not in c["codes"] and len(IDX[c["i"]]["text"])<=ml]
seen=collections.Counter(); out=[]
for c in sorted(rows,key=lambda c:(len(IDX[c["i"]]["text"])<80, c["i"])):
    a=c["store"][0]+c["folder"].split(".")[0]
    if seen[a]>=2: continue
    seen[a]+=1; out.append(c)
    if len(out)>=n: break
for c in out:
    print(f'{c["i"]}|{c["store"][0]}{c["folder"].split(".")[0]}|{c["rating"]}|{" ".join(c["codes"])}| {IDX[c["i"]]["text"][:ml]}')
