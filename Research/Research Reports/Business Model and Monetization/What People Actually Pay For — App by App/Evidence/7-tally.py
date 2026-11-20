# Tally of hand-read HabitKit labels (7-codes.py) over 7-all-reviews.txt. Run: python3 7-tally.py
import re, collections as C
exec(open('7-codes.py').read())
L=[l for l in open('7-all-reviews.txt').read().split('\n') if l]
rows=[]
for l in L:
    n,st,cc,r,ym,txt=l.split('|',5); rows.append(dict(n=int(n),st=st,r=int(r),y=ym[:4],t=txt))
def f(n,key):
    c=K.get(n,''); out=[]
    for part in c.split('|'):
        if part.startswith(key+'='): out+=part[len(key)+1:].split(',')
    return out
print('reviews',len(rows),C.Counter(x['st'] for x in rows))
print('\nby year (A=App Store,P=Play):'); 
for y in sorted(set(x['y'] for x in rows)):
    a=[x for x in rows if x['y']==y]; print(' ',y,'A',sum(x['st']=='A' for x in a),'P',sum(x['st']=='P' for x in a),
      '| payers',sum(f(x['n'],'pay')==['Y'] for x in a),'| want-to-pay',sum(f(x['n'],'pay')==['I'] for x in a))
pay=[x for x in rows if f(x['n'],'pay')==['Y']]; intent=[x for x in rows if f(x['n'],'pay')==['I']]
print('\nPAYERS',len(pay),C.Counter(x['st'] for x in pay),'avg rating %.2f'%(sum(x['r'] for x in pay)/len(pay)))
print('INTEND',len(intent),C.Counter(x['st'] for x in intent))
w=C.Counter(); nowhy=0
for x in pay:
    ws=f(x['n'],'why')
    if not ws: nowhy+=1
    for k in set(ws): w[k.split(':')[0] if not k.startswith('other') else k]+=1
print('payers giving a reason',len(pay)-nowhy,'none',nowhy)
for k,v in w.most_common(): print('  ',k,v)
d=C.Counter(); dp=C.Counter(); anyd=0
for x in rows:
    ds=f(x['n'],'disc')
    if ds: anyd+=1
    for k in set(ds):
        k2=k.split('-')[0] if k.startswith('social:YouTube') else k
        d[k2]+=1
        if f(x['n'],'pay')==['Y']: dp[k2]+=1
print('\nreviews saying anything about how they found it',anyd)
for k,v in d.most_common(): print('  ',k,v,'(payers %d)'%dp[k])
yt=C.Counter(k for x in rows for k in f(x['n'],'disc') if k.startswith('social:YouTube'))
print('YouTube detail',yt)
