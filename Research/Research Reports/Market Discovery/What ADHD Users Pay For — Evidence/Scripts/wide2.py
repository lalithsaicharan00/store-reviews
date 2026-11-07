import json,re,collections
exec(open('make_batches.py').read().split("led=json.load")[0])
led=json.load(open('ledger.json'))
PW=re.compile(r"\b(paid|payed|paying|i pay|we pay|purchas\w*|bought|buy it|subscri\w*|lifetime|worth it|worth the|worth every|worth paying|upgrad\w*|went pro|going pro|gone pro|got pro|got premium|got the pro|premium|plus|annual|yearly|investment|invest\w*|money|\$\d|£\d|€\d|pagu\w*|compr\w*|gekauft|bezahlt|abo\b|achet\w*|abonn\w*|vale|costo)\b",re.I)
key=lambda o:f"{o['s']}|{o['app'].split('.')[0]}|{o['src']}|{o['id']}"
A=[o for o in P if key(o) not in led and PW.search(o['t']) and not (o['trap'] and (o['st'] or 5)<=2)]
B=[o for o in P if key(o) in led and o['trap'] and (o['st'] or 5)<=2]
C=[o for o in P if key(o) not in led and o['trap'] and (o['st'] or 5)<=2]
print(len(A),len(B),len(C))
def sents(t):
    t=re.sub(r'\s+',' ',t.replace('&#39;',"'").replace('&amp;','&'))
    ss=re.split(r"(?<=[.!?])\s+",t)
    return ' | '.join(s[:200] for s in ss if PW.search(s))[:300]
print(sum(len(sents(o['t'])) for o in A),sum(len(sents(o['t'])) for o in B))
print(collections.Counter((o['st']) for o in A))
PW2=re.compile(r"\b(paid|payed|paying|i pay|we pay|purchas\w*|bought|buy it|subscri\w*|lifetime|worth it|worth the|worth every|worth paying|upgrad\w*|went pro|going pro|gone pro|got pro|got premium|got the pro|premium|annual|yearly|invest\w*|\$\d+|£\d+|€\d+|pagu\w*|compr[eéoa]\w*|gekauft|bezahlt|abo\b|achet\w*|abonn\w*|vale|costo)\b|\bPlus\b",re.I)
def sents2(t):
    t=re.sub(r'\s+',' ',t.replace('&#39;',"'").replace('&amp;','&'))
    ss=re.split(r"(?<=[.!?])\s+",t)
    return ' | '.join(s[:170] for s in ss if PW2.search(s))[:240]
import os
L2=json.load(open('ledger2.json')) if os.path.exists('ledger2.json') else {}
n=max(L2.values())+1 if L2 else 5000
A2=[o for o in A if PW2.search(o['t'])]
for o in A2:
    k=key(o)
    if k not in L2: L2[k]=n;n+=1
json.dump(L2,open('ledger2.json','w'))
print('A2',len(A2))
rd=json.load(open('w_read.json')) if os.path.exists('w_read.json') else []
todo=[o for o in A2 if L2[key(o)] not in rd]
todo.sort(key=lambda o:L2[key(o)])
lines=[f"#{L2[key(o)]} {o['st']} {o['s'][0]} {o['app'].split('. ',1)[-1][:10]}: {sents2(o['t'])}" for o in todo]
for f in os.listdir('.'):
    if re.fullmatch(r'w\d+\.txt',f): os.remove(f)
for c in range(0,len(lines),420):
    open(f'w{c//420}.txt','w').write('\n'.join(lines[c:c+420]))
print(len(lines),sum(map(len,lines)))
Bl=[f"#{led[key(o)]} {o['st']} {o['s'][0]} {o['app'].split('. ',1)[-1][:10]}: {sents2(o['t'])}" for o in sorted(B,key=lambda o:led[key(o)])]
open('wb.txt','w').write('\n'.join(Bl));print(len(Bl),sum(map(len,Bl)))
