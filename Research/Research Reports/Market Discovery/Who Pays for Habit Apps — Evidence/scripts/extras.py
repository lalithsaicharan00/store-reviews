import json,collections,math,sys,re
sys.path.insert(0,'codes')
from lift_core import bucket
import samples as SM, precision as PR
exec(open('tally2.py').read().split("rows=[json.loads")[0])
H=json.load(open('hand_codes.json'))
rows=[json.loads(l) for l in open('flags.jsonl')]; fl={r['k']:r for r in rows}
P={k:h for k,h in H.items() if h['status']=='P'}
named={k:h for k,h in P.items() if h['true']}
MIND={'AD','AU','DA','MH','TC'}; BODY={'CI'}
print('mind union',sum(1 for h in named.values() if set(h['true'])&MIND),'mind+body',sum(1 for h in named.values() if set(h['true'])&(MIND|BODY)))
print('AD&DA',sum(1 for h in named.values() if {'AD','DA'}<=set(h['true'])), 'family roles',sum(1 for h in named.values() if set(h['true'])&{'PA','CH','CF'}))
print('life roles',sum(1 for h in named.values() if set(h['true'])&{'ST','JB','TF','OA','TN'}))
# unique tier B identities
Bk=json.load(open('readB.json')); Bi={o['i'] for o in Bk}
ids=set(i for v in SM.B_G.values() for i in v); print('B with identity',len(ids),'of',len(Bk))
# Exclude reviews coded N or S (shouldn't exist)
print('overlap with N/S',ids&(set(SM.B_N)|set(SM.B_S)))
scale=925/120
for k,v in SM.B_G.items(): print(k,len(v),round(len(v)*scale))
print('B est identity',round(len(ids)*scale))
# need share among named vs not
named_need=sum(1 for h in named.values() if 'need' in h['why'])
print('named need',named_need,len(named), 'said any',sum(1 for h in named.values() if h['why']))
print('why among named',collections.Counter(w for h in named.values() for w in h['why']))
# stars and store of chose
print('stars named',collections.Counter(fl[k]['st'] for k in named))
print('app of named',collections.Counter(fl[k]['app'].split('. ',1)[1][:18] for k in named).most_common(12))
# all machine payers by app (no trap)
pa=collections.Counter(r['app'].split('. ',1)[1][:18] for r in rows if r['tier'] and not r['trap']); print('payers by app',pa.most_common(12))
# Money view
d=json.load(open('/Users/lalith/Desktop/store reviews/Research/Research Reports/Market Discovery/Habit App Revenue Evidence — 21 October 2026/revenue_evidence.json'))
rev=collections.Counter()
for x in d['ios_shortlist']: rev[x['name'][:6].lower()]+=x.get('monthly') or 0
for x in d['android_candidates']:
    if x.get('confidence') in ('medium-low',): rev[x['name'][:6].lower()]+=x.get('monthly') or 0
print(rev.most_common(12))
mix=collections.defaultdict(collections.Counter)
for k,h in named.items():
    a=fl[k]['app'].split('. ',1)[1][:6].lower()
    mix[a]['_n']+=1
    for g in h['true']: mix[a][g]+=1
tot=collections.Counter();W=0
for a,m in rev.items():
    if mix[a]['_n']<5: print('skip',a,mix[a]['_n'],m); continue
    W+=m
    for g,c in mix[a].items():
        if g!='_n': tot[g]+=m*c/mix[a]['_n']
print('money-weighted among named, apps covered',W)
for g,v in tot.most_common(): print(g,round(100*v/W,1))
print({a:mix[a]['_n'] for a in rev})
# OR with no denominator correction
EN={'en','us','gb','ca','au','nz','ie','in','za','sg','ph'}
pos=[r for r in rows if r['st']>=4 and r['loc'] in EN]
st=collections.defaultdict(list)
for r in pos: st[(r['app'],bucket(r['w']))].append(r)
w=.81
def OR(g,p,noapp=None):
    num=den=0
    for s,rs in st.items():
        if noapp and noapp in s[0]: continue
        a=b=c=d_=0
        for r in rs:
            h=H.get(r['k']); isg=(g in h['true']) if h else any(AB.get(x)==g for x in r['g'])
            y=(1.0 if h['status']=='P' else 0.0) if h else (w if r['tier'] else 0.0)
            if isg: a+=y; b+=(1-y)*(1 if h else p)
            else: c+=y; d_+=1-y
        n=a+b+c+d_
        if n: num+=a*d_/n; den+=b*c/n
    return num/den if den else float('nan')
print('group  OR p=1  OR p  no-Finch p=1')
for g in NAME: print(g,round(OR(g,1),2),round(OR(g,PR.TRUE[g]/24),2),round(OR(g,1,'Finch'),2))
print('set A P rate 4-5 stars',sum(1 for k,h in H.items() if fl[k]['st']>=4 and h['status']=='P')/sum(1 for k in H if fl[k]['st']>=4))
