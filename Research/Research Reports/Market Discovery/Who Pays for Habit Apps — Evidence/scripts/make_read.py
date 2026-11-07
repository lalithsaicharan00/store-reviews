import json,random,re,collections
from seg import SEG
A=['adhd','add_caps','autism','depression_anxiety','serious_mh','therapy_client','professional_helper','chronic_illness','recovery_quit','student','teen_minor','parent','for_child','couple_friends','shift_work_jobs','tech_founder','faith','older_adult']
B=['pet_cozy','gamer','fitness_weight','quantified_self','self_improver','trait_struggler','life_crisis']
fl={}
for l in open('flags.jsonl'):
    r=json.loads(l)
    if r['tier']: fl[r['k']]=r
print('paid any',len(fl))
txt={}
for l in open('corpus.jsonl'):
    r=json.loads(l); k=f"{r['s']}|{r['app'].split('.')[0]}|{r['id']}"
    if k in fl: txt[k]=r
def excerpt(k,gs,limit=330):
    t=re.sub(r'\s+',' ',txt[k]['t'].replace('&#39;',"'").replace('&amp;','&'))
    if len(t)<=limit+60: return t
    head=t[:190]; parts=[head]
    spans=[]
    pm=re.search(re.escape(fl[k].get('hit','')) if False else r"paid|pay|bought|purchas|subscri|premium|lifetime|worth|upgrad",t[190:],re.I)
    if pm: spans.append(190+pm.start())
    for g in gs:
        m=SEG[g].search(t,190)
        if m: spans.append(m.start())
    for s in sorted(set(spans))[:2]:
        parts.append('…'+t[max(190,s-55):s+85])
    return ' '.join(parts)
setA=[k for k,r in fl.items() if set(r['g'])&set(A)]
print('setA',len(setA))
rest=[k for k,r in fl.items() if k not in set(setA) and set(r['g'])&set(B)]
print('rest B-only',len(rest))
random.seed(11); random.shuffle(setA)
out=[]
for i,k in enumerate(setA):
    r=fl[k]; g=[x for x in r['g'] if x in A]
    out.append({'i':i,'k':k,'st':r['st'],'app':r['app'].split('. ',1)[1][:12],'g':g,'trap':r['trap'],'x':excerpt(k,g)})
json.dump(out,open('readA.json','w'),ensure_ascii=False)
tok=sum(len(o['x']) for o in out); print('chars',tok)
json.dump(rest,open('restB.json','w'))
