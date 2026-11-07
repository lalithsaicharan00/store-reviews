import json,random,re,collections
B=['pet_cozy','gamer','fitness_weight','quantified_self','self_improver','trait_struggler','life_crisis']
fl={}
for l in open('flags.jsonl'):
    r=json.loads(l)
    if r['tier']: fl[r['k']]=r
txt={}
for l in open('corpus.jsonl'):
    r=json.loads(l); k=f"{r['s']}|{r['app'].split('.')[0]}|{r['id']}"
    if k in fl: txt[k]=r
def ex(k,limit=300):
    t=re.sub(r'\s+',' ',txt[k]['t'].replace('&#39;',"'").replace('&amp;','&'))
    if len(t)<=limit+80: return t
    m=re.search(r"paid|pay|bought|purchas|subscri|premium|lifetime|worth|upgrad|купил|подписк|comprei|compré|결제|구매|課金|買|购买|付费|会员",t[190:],re.I)
    s=t[:200]
    if m: s+=' …'+t[max(200,190+m.start()-60):190+m.start()+110]
    return s
restB=json.load(open('restB.json'))
# Payers who name no group at all, and who chose (no surprise-charge words)
none=[k for k,r in fl.items() if not r['g'] and not r['trap'] and r['w']>=12]
print('no group, chose, 12+ words',len(none),'all no group',sum(1 for r in fl.values() if not r['g']))
random.seed(23); b=random.sample([k for k in restB if not fl[k]['trap']],120); n=random.sample(none,240)
for name,ks,base in (('readB',b,2000),('readC1',n[:120],3000),('readC2',n[120:],3120)):
    o=[]
    with open(name+'.txt','w') as f:
        for i,k in enumerate(ks):
            r=fl[k]; f.write(f"{base+i} {r['st']} {r['app'].split('. ',1)[1][:10]} {','.join(x[:4] for x in r['g'])}|{ex(k)}\n"); o.append({'i':base+i,'k':k})
    json.dump(o,open(name+'.json','w'))
print(collections.Counter(g for k in b for g in fl[k]['g'] if g in B))
print(collections.Counter(fl[k]['s'] for k in n))
