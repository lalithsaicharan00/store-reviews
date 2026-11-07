import json,re,os,random
P=json.load(open('pool.json'))
M=re.compile(r"\b(premium|paid|paying|i pay|we pay|pay for|pay the|paid version|pro version|pro\b|full version|plus\b|lifetime|subscri\w*|membership|upgrad\w*|purchas\w*|bought|buy\b|worth (it|the|every|paying|my|each|a)|money|one[- ]time|annual|yearly)\b",re.I)
S=re.compile(r"\b(i|we|i've|ive)\b[^.!?]{0,50}\b(paid|pay|paying|bought|purchased|subscribed|subscribe|upgraded|upgrade|got|have|use|using|renewed|signed up|invested|spent)\b[^.!?]{0,50}\b(premium|plus|pro|paid|subscription|lifetime|full version|membership|annual|yearly|monthly|month|year|\$|money|app)\b",re.I)
PAY=re.compile(r"paid|pay|bought|purchas|subscri|premium|lifetime|upgrad|worth|\$|pro version|plus\b|money",re.I)
led=json.load(open('ledger.json')) if os.path.exists('ledger.json') else {}
n=len(led)
new=[]
for o in P:
    k=f"{o['s']}|{o['app'].split('.')[0]}|{o['src']}|{o['id']}"
    o['k']=k
    if k in led: continue
    if M.search(o['t']) and (o['tier'] or S.search(o['t'])): new.append(o)
new.sort(key=lambda o:(o['app'].split('. ',1)[-1][:10].lower(),o['s']))
def ex(t):
    t=re.sub(r'\s+',' ',t.replace('&#39;',"'").replace('&amp;','&'))
    if len(t)<=720: return t
    h=t[:400]; rest=t[400:]
    ms=[m.start() for m in PAY.finditer(rest)]
    if not ms: return h+' …'+rest[-160:]
    s=ms[0]; return h+' …'+rest[max(0,s-110):s+200]
b=sorted(int(f[1:-4]) for f in os.listdir('.') if re.fullmatch(r'b\d+\.txt',f)); nb=(b[-1]+1) if b else 0
for c in range(0,len(new),130):
    L=[]
    for o in new[c:c+130]:
        led[o['k']]=n; 
        L.append(f"#{n} {o['st']}★ {o['s'][0]} {o['app'].split('. ',1)[-1][:14]}{' T' if o['trap'] else ''}: {ex(o['t'])}")
        n+=1
    open(f'b{nb}.txt','w').write('\n'.join(L)); nb+=1
json.dump(led,open('ledger.json','w'))
print('new',len(new),'ledger',n,'batches',nb)
