# Tally of hand labels in 1-together-codes.py. Run: python3 -I 1-together-tally.py
import json,runpy,collections as C
K=runpy.run_path('1-together-codes.py')['K']
L=[l.split('|',5) for l in open('1-together-read.txt').read().split('\n') if l]
assert all(0<=k<len(L) for k in K)
rows=[]
for k,c in K.items():
    i,rid,cc,r,ym,t=L[k]; parts=c.split('|')
    rows.append(dict(i=k,id=rid,cc=cc,r=int(r),y=ym[:4],codes=set(p for p in parts if p in 'UWBNAFPKR' and len(p)==1),who=[p for p in parts if p in ('f','p','k','fam','g','x')]))
def show(sel,title):
    rel=[x for x in sel if x['codes'] & set('UWBA')]  # about doing habits with others
    print(f'\n== {title}: reviews about doing habits with other people: {len(rel)}')
    c=C.Counter(); 
    for x in rel:
        for k in x['codes']: c[k]+=1
    for k,n in [('U','do it / like it / chose app for it'),('W','want it / plan to / ask for more'),('B','say it is broken'),('A','blocked: friends on Android'),('P','say they paid'),('F','complain it is paywalled')]:
        print(f'  {k} {n:40} {c[k]}')
    w=C.Counter(x['who'][0] if x['who'] else 'x' for x in rel); print('  with whom:',dict(w))
    print('  avg rating %.2f'%(sum(x['r'] for x in rel)/len(rel)))
    print('  by year:',sorted(C.Counter(x['y'] for x in rel).items()))
    n=[x for x in sel if 'N' in x['codes']]; print('  do NOT want it (N):',len(n))
    k=[x for x in sel if 'K' in x['codes'] and not x['codes']&set('UWBA')]; print('  parent tracking a child (K only):',len(k))
show(rows,'ALL')
show([x for x in rows if x['cc']!='cn'],'OUTSIDE CHINA')
show([x for x in rows if x['cc']=='cn'],'CHINA')
show([x for x in rows if x['cc']=='us'],'US')
