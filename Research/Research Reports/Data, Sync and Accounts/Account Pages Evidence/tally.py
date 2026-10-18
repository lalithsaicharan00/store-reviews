"""Tally codes.txt against candidates.jsonl: reviews, apps, mean stars per code; habit-app stores (A, P) only unless noted."""
import json, collections
rows={json.loads(l)['key']:json.loads(l) for l in open("candidates.jsonl")}
codes=collections.defaultdict(set)
for l in open("codes.txt"):
    if l.strip() and not l.startswith('#'):
        k,c=l.split()
        for x in c.split(','): codes[x].add(k)
for c,ks in sorted(codes.items(), key=lambda x:-len(x[1])):
    rs=[rows[k] for k in ks]; st=[r['rating'] for r in rs if r['rating']]
    apps={r['app'] for r in rs}; ones=sum(1 for s in st if s==1)
    print(f"{c:24} n={len(ks):4} apps={len(apps):3} mean={sum(st)/len(st):.2f} 1★={ones/len(st):.0%}  A={sum(r['store']=='A' for r in rs)} P={sum(r['store']=='P' for r in rs)} N={sum(r['store']=='N' for r in rs)}")
on=set().union(*[v for k,v in codes.items() if k!='off'])
print("read", len({k for v in codes.values() for k in v}), "on topic", len(on), "apps", len({rows[k]['app'] for k in on}))
