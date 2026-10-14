import json,glob,collections
rows={json.loads(l)['key']:json.loads(l) for l in open('candidates.jsonl')}
by=collections.defaultdict(list)
for f in sorted(glob.glob('cls/batch-*.txt')):
    for ln in open(f):
        ln=ln.rstrip('\n')
        if ln: k,c,q=ln.split('|',2); by[c].append((k,q))
on=sum(len(v) for c,v in by.items() if c!='OFF')
print('on topic',on,'off',len(by['OFF']))
for c,v in sorted(by.items(), key=lambda x:-len(x[1])):
    if c=='OFF': continue
    rs=[rows[k]['rating'] for k,_ in v if rows[k]['rating']]
    apps={rows[k]['app'] for k,_ in v}
    habit={rows[k]['app'] for k,_ in v if rows[k]['store']!='N'}
    print(f"{c:15} {len(v):4} apps {len(apps):3} mean {sum(rs)/len(rs):.2f} 1star {100*sum(1 for r in rs if r==1)/len(rs):.0f}%  native {sum(1 for k,_ in v if rows[k]['store']=='N')}")
json.dump({c:[k for k,_ in v] for c,v in by.items()}, open('theme_ids.json','w'), indent=0)
