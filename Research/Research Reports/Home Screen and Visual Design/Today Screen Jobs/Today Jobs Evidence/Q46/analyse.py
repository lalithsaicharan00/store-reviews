import json,collections,statistics as st,re
from common import read_codes, cite
rows=json.load(open('all.json')); codes=read_codes('C')
def val(v):
    v=v.strip()
    if '-' in v:
        a,b=v.split('-'); return (float(a)+float(b))/2
    return float(v)
D=collections.defaultdict(list)   # code -> list of (value, idx)
flags={}
for i,(cs,q) in codes.items():
    f=set(c for c in cs if '=' not in c); flags[i]=f
    if 'DUP' in f: continue
    for c in cs:
        if '=' in c:
            k,v=c.split('=',1)
            try: D[k].append((val(v),i))
            except: pass
def stats(xs):
    xs=sorted(xs); n=len(xs)
    q=lambda p: xs[min(n-1,int(round(p*(n-1))))]
    return dict(n=n,mean=round(st.mean(xs),1),median=st.median(xs),mode=collections.Counter(xs).most_common(3),p10=q(.1),p25=q(.25),p75=q(.75),p90=q(.9),p95=q(.95),max=xs[-1])
BK=[(1,1,'1'),(2,2,'2'),(3,3,'3'),(4,5,'4–5'),(6,7,'6–7'),(8,10,'8–10'),(11,15,'11–15'),(16,20,'16–20'),(21,30,'21–30'),(31,1e9,'31+')]
def buckets(xs):
    n=len(xs); out=[]; cum=0
    for a,b,l in BK:
        c=sum(1 for x in xs if a-0.25<=x<=b+0.49); cum+=c
        out.append((l,c,round(100*c/n,1),round(100*cum/n,1)))
    return out
own=[(v,i) for v,i in D['OWN']]
own_all=[v for v,i in own]
own_uncap=[v for v,i in own if 'CAP' not in flags[i]]
own_cap=[v for v,i in own if 'CAP' in flags[i]]
res={}
for name,xs in [('OWN all',own_all),('OWN uncapped',own_uncap),('OWN capped',own_cap),('START',[v for v,i in D['START']]),('ENOUGH',[v for v,i in D['ENOUGH']]),('GT (not enough)',[v for v,i in D['GT']]),('FREEWANT',[v for v,i in D['FREEWANT']]),('WANT',[v for v,i in D['WANT']]),('ADVICE',[v for v,i in D['ADVICE']]),('PAST',[v for v,i in D['PAST']])]:
    if xs: res[name]=stats(xs); print(name,res[name])
print('\nUNCAPPED buckets');[print(b) for b in buckets(own_uncap)]
print('\nALL buckets');[print(b) for b in buckets(own_all)]
# by store / app
by=collections.defaultdict(list)
for v,i in own:
    if 'CAP' in flags[i]: continue
    by[rows[i]['store']].append(v)
for k,xs in by.items(): print(k,stats(xs))
app=collections.defaultdict(list)
for v,i in own:
    if 'CAP' in flags[i]: continue
    app[rows[i]['folder']].append(v)
print('\nper app (n>=8)')
for k,xs in sorted(app.items(),key=lambda x:-len(x[1])):
    if len(xs)>=8: print(k[:30],len(xs),st.median(xs),round(st.mean(xs),1))
for k in ['ENOUGH','GT','FREEWANT']:
    print(k,sorted(collections.Counter(v for v,i in D[k]).items()))
json.dump({k:[[v,cite(rows[i]),rows[i]['rating'],rows[i]['folder'],sorted(flags[i])] for v,i in D[k]] for k in D},open('values.json','w'),ensure_ascii=False)
