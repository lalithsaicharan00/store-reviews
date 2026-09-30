import json,collections
idx=json.load(open('indexed_full.json'));c=json.load(open('codes_all.json'))
def app(r): return ('A' if r['store']=='app' else 'P')+r['folder'].split('.')[0]
names={}
A=collections.defaultdict(lambda: collections.Counter()); N=collections.Counter(); S=collections.defaultdict(list)
for k,v in c.items():
    r=idx[int(k)]; a=app(r); names[a]=r['folder']
    if not v: continue
    N[a]+=1; S[a].append(r['rating'])
    for x in v: A[a][x]+=1
out=[]
for a,n in N.most_common():
    pr=[(x,y) for x,y in A[a].most_common() if not x.startswith(('X','?'))][:6]
    cp=[(x,y) for x,y in A[a].most_common() if x.startswith('X')][:5]
    ask=[(x,y) for x,y in A[a].most_common() if x.startswith('?')][:4]
    out.append(f"{a} {names[a][:40]} n={n} ★{sum(S[a])/len(S[a]):.2f} | praise {pr} | complain {cp} | ask {ask}")
open('perapp.txt','w').write("\n".join(out)); print("\n".join(out[:60]))
