"""Union all hand codes per review (keyed by citation id) and count codes. Usage: python3 aggregate.py Q1 [Q1b ...]"""
import json, sys, glob, collections, os
from common import cite, ctx
SRC={'Q1':'q1_read.json','Q1b':'q1b_read.json'}
def load_prefix(p):
    rows=json.load(open(SRC[p])) if p in SRC else json.load(open(f'{p.lower()}_read.json'))
    out={}
    for f in sorted(glob.glob(f'codes/{p}_*.txt')):
        for l in open(f):
            parts=l.rstrip('\n').split('\t')
            if len(parts)<2 or not parts[0].strip(): continue
            i=int(parts[0]); r=rows[i]
            out[(p,i)]=(r,[c for c in parts[1].split(',') if c],parts[2] if len(parts)>2 else '')
    return rows,out
def union(prefixes):
    by={}
    for p in prefixes:
        rows,codes=load_prefix(p)
        # sanity: every row coded exactly once
        coded={i for (_,i) in codes}; assert coded==set(range(len(rows))), (p,len(rows),len(coded),sorted(set(range(len(rows)))-coded)[:10])
        for (_,i),(r,cs,n) in codes.items():
            k=cite(r); e=by.setdefault(k,{'r':r,'codes':set(),'notes':[]})
            e['codes'].update(c for c in cs if c!='X'); 
            if n: e['notes'].append(n)
    return by
if __name__=='__main__':
    by=union(sys.argv[1:])
    rel={k:v for k,v in by.items() if v['codes']}
    print('reviews read',len(by),'relevant',len(rel))
    cnt=collections.Counter(); hab=collections.Counter(); stars=collections.defaultdict(list); apps=collections.defaultdict(set)
    for k,v in rel.items():
        for c in v['codes']:
            cnt[c]+=1; stars[c].append(v['r']['rating'] or 0); apps[c].add(v['r']['folder'])
            if ctx(v['r'])=='habit': hab[c]+=1
    for c,n in cnt.most_common():
        print(f"{c:12} n={n:4} habit={hab[c]:4} apps={len(apps[c]):3} ★{sum(stars[c])/len(stars[c]):.2f}")
    json.dump({k:{'codes':sorted(v['codes']),'notes':v['notes'],'rating':v['r']['rating'],'folder':v['r']['folder'],'ctx':ctx(v['r']),'text':v['r']['text'][:300]} for k,v in rel.items()},open(f"agg_{'_'.join(sys.argv[1:])}.json",'w'),ensure_ascii=False,indent=0)
