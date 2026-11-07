import json,collections
H=json.load(open('hand_codes.json'))
fl={}
for l in open('flags.jsonl'):
    r=json.loads(l)
    if r['k'] in H: fl[r['k']]=r
rev={'Finch':1700000,'Me+':100000,'Productive':70000,'Fabulous':58000}
# 'Routine' = Routinery / Routine Planner corpus; check names first
names=collections.Counter(fl[k]['app'].split('. ',1)[1][:28] for k,h in H.items() if h['status']=='P' and h['true'])
print(names.most_common(14))
mix=collections.defaultdict(collections.Counter)
for k,h in H.items():
    if h['status']!='P' or not h['true']: continue
    a=fl[k]['app'].split('. ',1)[1]
    for key in rev:
        if a.startswith(key):
            mix[key]['_n']+=1
            for g in h['true']: mix[key][g]+=1
for k in rev: print(k,dict(mix[k].most_common(7)))
W=sum(rev[k] for k in rev if mix[k]['_n']>=10)
tot=collections.Counter()
for k in rev:
    if mix[k]['_n']<10: continue
    for g,c in mix[k].items():
        if g!='_n': tot[g]+=rev[k]*c/mix[k]['_n']
print('covered',W,[(g,round(100*v/W,1)) for g,v in tot.most_common(10)])
# without Finch
W2=W-rev['Finch']; t2=collections.Counter()
for k in rev:
    if k=='Finch' or mix[k]['_n']<10: continue
    for g,c in mix[k].items():
        if g!='_n': t2[g]+=rev[k]*c/mix[k]['_n']
print('no Finch',W2,[(g,round(100*v/W2,1)) for g,v in t2.most_common(8)])
