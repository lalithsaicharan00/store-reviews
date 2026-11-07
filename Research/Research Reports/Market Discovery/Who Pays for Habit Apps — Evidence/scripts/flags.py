#!/usr/bin/env python3
# Step 3: one pass over every in-scope review: paid? which groups? how long? Saved so nothing has to be re-run.
import json,sys
from multiprocessing import Pool
from scope import in_scope
from paid import classify,TRAP
from seg import segs
from pay_gate import gate
def work(l):
    r=json.loads(l)
    if not in_scope(r): return None
    t=r['t']; tier=''
    if gate(t): tier,hit=classify(t)
    w=len(t.split()) if t.isascii() or any(c==' ' for c in t[:200]) else len(t)//3
    return json.dumps({'k':f"{r['s']}|{r['app'].split('.')[0]}|{r['id']}",'s':r['s'],'app':r['app'],'st':r['st'],'loc':r['loc'],'d':r['d'],'w':w,'tier':tier,'trap':bool(TRAP.search(t)) if tier else False,'g':segs(t)},ensure_ascii=False)
if __name__=='__main__':
    with Pool(8) as p, open('flags.jsonl','w') as o:
        n=0
        for x in p.imap(work,open('corpus.jsonl'),chunksize=2000):
            if x: o.write(x+'\n'); n+=1
    print(n)
