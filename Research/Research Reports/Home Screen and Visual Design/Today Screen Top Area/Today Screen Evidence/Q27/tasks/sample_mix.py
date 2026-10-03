"""Seeded sample (seed 20261003) of mix_strong.json: 80 habit-tier ORD, 50 habit-tier SEP-only, all todo-tier. Writes mix_sample.jsonl + mbatchNN.txt"""
import json, random
C=json.load(open("mix_strong.json")); rnd=random.Random(20261003)
ordp=[c for c in C if c["tier"]=="habit" and "ORD" in c["s"]]
sepp=[c for c in C if c["tier"]=="habit" and c["s"]==["SEP"]]
todo=[c for c in C if c["tier"]=="todo"]
rnd.shuffle(ordp); rnd.shuffle(sepp)
S=[dict(c,drawn="ORD") for c in ordp[:80]]+[dict(c,drawn="SEP") for c in sepp[:50]]+[dict(c,drawn="TODO") for c in todo]
print(len(ordp),len(sepp),len(todo),len(S))
with open("mix_sample.jsonl","w") as w:
    for c in S: w.write(json.dumps(c,ensure_ascii=False)+"\n")
for b in range(0,len(S),25):
    with open(f"mbatch{b//25:02d}.txt","w") as f:
        for c in S[b:b+25]: f.write(f"{c['cite']} ★{c['rating']} [{c['folder'][:30]}] {c['drawn']} {c['text']}\n\n")
