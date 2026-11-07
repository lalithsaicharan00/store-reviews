import json,re,os
exec(open('make_batches.py').read().split("led=json.load")[0])
led=json.load(open('ledger.json'))
done=json.load(open('read_upto.json')) if os.path.exists('read_upto.json') else {'upto':235,'seq':0}
rows=[]
n=max(led.values())+1 if led else 0
for o in P:
    k=f"{o['s']}|{o['app'].split('.')[0]}|{o['src']}|{o['id']}"; o['k']=k
    if k not in led:
        if M.search(o['t']) and (o['tier'] or S.search(o['t'])): led[k]=n;n+=1
        else: continue
    if led[k]<=done['upto']: continue
    if o['trap'] and (o['st'] or 5)<=2: continue
    rows.append(o)
rows.sort(key=lambda o:led[o['k']])
def ex(t):
    t=re.sub(r'\s+',' ',t.replace('&#39;',"'").replace('&amp;','&'))
    if len(t)<=620: return t
    h=t[:360]; rest=t[360:]
    ms=[m.start() for m in PAY.finditer(rest)]
    if not ms: return h+' …'+rest[-140:]
    s=ms[0]; return h+' …'+rest[max(0,s-90):s+170]
for f in os.listdir('.'):
    if re.fullmatch(r'r\d+\.txt',f): os.remove(f)
nb=0
for c in range(0,len(rows),110):
    L=[f"#{led[o['k']]} {o['st']}★ {o['s'][0]} {o['app'].split('. ',1)[-1][:14]}{' T' if o['trap'] else ''}: {ex(o['t'])}" for o in rows[c:c+110]]
    open(f'r{nb}.txt','w').write('\n'.join(L)); nb+=1
json.dump(led,open('ledger.json','w'))
print('to read',len(rows),'batches',nb,'chars',sum(len(ex(o['t'])) for o in rows))
