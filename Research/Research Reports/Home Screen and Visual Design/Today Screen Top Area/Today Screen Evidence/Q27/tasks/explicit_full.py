"""Same explicit-placement pattern as explicit.py, over every review in every corpus (not only mix_cand)."""
import json, os, sys, re
sys.path.insert(0, ".."); import screen
src=open("explicit.py").read(); ns={}
exec(src.split("out=[c")[0].replace('C=[json.loads(l) for l in open("mix_cand.jsonl")]','C=[]'), ns)
P=ns["P"]; out=[]
for store, folder, n, i, r, text in screen.recs():
    m=P.search(text)
    if m: out.append({"cite": f"{screen.LET[store]}{n}#{i}", "folder": folder, "tier": screen.tier(store,n), "rating": r.get("rating"), "text": text})
print(len(out))
with open("explicit_full.jsonl","w") as w:
    for c in out: w.write(json.dumps(c,ensure_ascii=False)+"\n")
with open("explicit_full.txt","w") as f:
    for c in out:
        m=P.search(c["text"]); s=max(0,m.start()-300); e=min(len(c["text"]),m.end()+300)
        f.write(f"{c['cite']} ★{c['rating']} {c['tier']} [{c['folder'][:30]}] …{c['text'][s:e]}…\n\n")
