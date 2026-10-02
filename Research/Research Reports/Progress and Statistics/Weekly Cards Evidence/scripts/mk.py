import json,sys
a,b=int(sys.argv[1]),int(sys.argv[2]); codes=dict(x.split(":",1) for x in sys.argv[3].split(";") if x)
ids=[json.loads(l)["n"] for l in open("read.jsonl") if a<=json.loads(l)["n"]<b]
with open(f"codes_{a:04d}.txt","w") as f:
    for n in ids: f.write(f"{n}:{codes.get(str(n),'NA')}\n")
print(len(ids),"coded",sum(1 for i in ids if str(i) in codes))
