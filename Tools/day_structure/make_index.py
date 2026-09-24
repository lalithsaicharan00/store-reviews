"""Stable index of habit-tier candidates, ordered TOD, RTN, SUB, GSTAT, GRP. Writes index.jsonl."""
import json
C=[c for c in json.load(open("candidates2.json")) if c["tier"]=="habit"]
pri={"TOD":0,"RTN":1,"SUB":2,"GSTAT":3,"GRP":4}
C.sort(key=lambda c:(min(pri[f] for f in c["fam"]),c["store"],c["folder"],c["line"]))
with open("index.jsonl","w") as w:
    for i,c in enumerate(C): c["i"]=i; w.write(json.dumps(c,ensure_ascii=False)+"\n")
print(len(C))
