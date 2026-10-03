"""Q2 sample (seed 20261003): how people want one-time tasks ordered. From ../cand.jsonl (ORDER family):
 TODO   : to-do tier, matching sample.py STRONG, 1-5 stars: 60
 HTASK  : habit-tier apps that have to-dos (Play 2,8,40,55,61,75,82,134; App 85,59), text names to-dos/tasks and STRONG: 30
Excludes cites already in mix_sample.jsonl. Writes q2_sample.jsonl + qbatchNN.txt"""
import json, random, re, sys
sys.path.insert(0, ".."); 
src=open("../sample.py").read(); STRONG=eval(src.split("STRONG = ")[1].split("\nREM")[0])
rnd=random.Random(20261003)
seen={json.loads(l)["cite"] for l in open("mix_sample.jsonl")}
C=[json.loads(l) for l in open("../cand.jsonl")]
TK=re.compile(r"\bto-?\s?dos?\b|\btasks?\b|tareas|tarefas|aufgaben|t[âa]ches|задач",re.I)
HT={"P2","P8","P40","P55","P61","P75","P82","P134","A85","A59"}
todo=[c for c in C if c["tier"]=="todo" and "ORDER" in c["fam"] and STRONG.search(c["text"]) and c["cite"] not in seen]
ht=[c for c in C if c["cite"].split("#")[0] in HT and "ORDER" in c["fam"] and STRONG.search(c["text"]) and TK.search(c["text"]) and c["cite"] not in seen]
rnd.shuffle(todo); rnd.shuffle(ht)
print("pools", len(todo), len(ht))
S=[dict(c,drawn="TODO") for c in todo[:60]]+[dict(c,drawn="HTASK") for c in ht[:30]]
with open("q2_sample.jsonl","w") as w:
    for c in S: w.write(json.dumps({k:c[k] for k in ("cite","folder","tier","id","rating","date","drawn","text")},ensure_ascii=False)+"\n")
for b in range(0,len(S),30):
    with open(f"qbatch{b//30:02d}.txt","w") as f:
        for c in S[b:b+30]: f.write(f"{c['cite']} ★{c['rating']} [{c['folder'][:28]}] {c['drawn']} {c['text']}\n\n")
