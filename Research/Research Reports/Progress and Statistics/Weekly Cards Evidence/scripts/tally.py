"""Tally hand codes per group. Remaps applied (documented in codebook):
quit rows: PSTREAK -> RUN (longest run), CLEAN -> RUN (days since last slip);
best_day / confusing rows: PSTREAK -> STREAK (plain best streak)."""
import json,glob,collections,sys
rows=[json.loads(l) for l in open('read.jsonl')]
codes={}
for f in sorted(glob.glob('codes_*.txt')):
    for line in open(f):
        line=line.strip()
        if line:
            n,c=line.split(':',1); codes[int(n)]=c
GROUPS=[('times_day',0,87),('partial',88,259),('amount',260,273),('time',274,331),('amount_time',332,894),
('checklist',895,1024),('weekly_goal',1025,1363),('monthly_goal',1364,1420),('every_n',1421,1466),('limit',1467,1475),
('quit',1476,2339),('best_day',2340,2746),('notes_week',2747,2757),('confusing',2758,2993)]
def grp(n):
    for g,a,b in GROUPS:
        if a<=n<=b: return g
def norm(n,c):
    out=set()
    for t in c.split(','):
        t=t.strip()
        if t=='NA': continue
        p,k=(t[0],t[1:]) if t[0] in '+?-' else ('=',t)
        g=grp(n)
        if g=='quit' and k in('PSTREAK','CLEAN'): k='RUN'
        if g in('best_day','confusing','notes_week') and k=='PSTREAK': k='STREAK'
        out.add((p,k))
    return out
coded={n:norm(n,c) for n,c in codes.items()}
json.dump({n:sorted(f'{p}{k}' for p,k in s) for n,s in coded.items()},open('coded_final.json','w'))
def table(sel,label):
    cnt=collections.defaultdict(lambda: collections.Counter()); apps=collections.defaultdict(set); ids=collections.defaultdict(list)
    for n in sel:
        for p,k in coded[n]:
            cnt[k][p]+=1; apps[k].add(rows[n]['app']); ids[k].append(n)
    tot={k:sum(v.values()) for k,v in cnt.items()}
    print(f'\n== {label}: {len(sel)} reviews, {sum(1 for n in sel if coded[n])} coded non-NA')
    for k in sorted(tot,key=lambda k:-tot[k]):
        v=cnt[k]
        print(f'{k:8} {tot[k]:4}  +{v["+"]:<3} ?{v["?"]:<3} -{v["-"]:<3} ={v["="]:<3} apps {len(apps[k]):3}  e.g. {ids[k][:6]}')
for g,a,b in GROUPS: table(range(a,b+1),g)
table(range(0,2994),'ALL')
