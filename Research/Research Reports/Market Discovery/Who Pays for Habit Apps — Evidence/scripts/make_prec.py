import json,random,re,collections
from seg import SEG
AB={'adhd':'AD','autism':'AU','depression_anxiety':'DA','serious_mh':'MH','therapy_client':'TC','professional_helper':'PR','chronic_illness':'CI','recovery_quit':'RQ','student':'ST','teen_minor':'TN','parent':'PA','for_child':'CH','couple_friends':'CF','shift_work_jobs':'JB','tech_founder':'TF','faith':'FA','older_adult':'OA'}
EN={'en','us','gb','ca','au','nz','ie','in','za','sg','ph'}
pool=collections.defaultdict(list)
for l in open('flags.jsonl'):
    r=json.loads(l)
    if r['tier'] or r['st']<4 or r['loc'] not in EN: continue
    for g in r['g']:
        if g in AB: pool[g].append(r['k'])
random.seed(41); pick={}
for g,ks in pool.items(): pick[g]=random.sample(ks,min(24,len(ks)))
want={k for v in pick.values() for k in v}; txt={}
for l in open('corpus.jsonl'):
    r=json.loads(l); k=f"{r['s']}|{r['app'].split('.')[0]}|{r['id']}"
    if k in want: txt[k]=re.sub(r'\s+',' ',r['t'].replace('&#39;',"'"))
n=4000; out=[]
with open('readP.txt','w') as f:
    for g,ks in pick.items():
        f.write(f"## {AB[g]} pool {len(pool[g])}\n")
        for k in ks:
            t=txt[k]; m=SEG[g].search(t); s=m.start() if m else 0
            f.write(f"{n} {t[max(0,s-70):s+70]}\n"); out.append({'i':n,'k':k,'g':AB[g]}); n+=1
json.dump(out,open('readP.json','w'))
print(n-4000,{AB[g]:len(v) for g,v in pool.items()})
