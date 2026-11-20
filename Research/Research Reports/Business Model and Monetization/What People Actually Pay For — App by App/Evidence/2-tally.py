# Tally of hand labels in 2-codes.py over 2-all-reviews.txt. Run: python3 -I 2-tally.py
import runpy,collections as C
K=runpy.run_path('2-codes.py')['K']
L=[l.split('|',5) for l in open('2-all-reviews.txt').read().split('\n') if l]
def f(n,key):
    out=[]
    for p in K.get(n,'').split('|'):
        if p.startswith(key+'='): out+=p[len(key)+1:].split(',')
    return out
pay=[i for i in range(len(L)) if f(i,'pay')==['Y']]
print('reviews',len(L),'| paid',len(pay),'avg %.2f'%(sum(int(L[i][2]) for i in pay)/len(pay)),'| intend',sum(f(i,'pay')==['I'] for i in range(len(L))),'| got Pro free (launch promo)',sum(f(i,'pay')==['F'] for i in range(len(L))))
w=C.Counter(); nowhy=0
for i in pay:
    ws=f(i,'why'); nowhy+= not ws
    for k in set(ws): w[k]+=1
print('payers who say why',len(pay)-nowhy,'| never say',nowhy)
for k,v in w.most_common(): print('  ',k,v)
GIVE={'stats','sync','widget','cap'}; GOOD={'onetime','cheap','worth','support','longuse'}
g=C.Counter()
for i in pay:
    ws=set(f(i,'why'))
    if ws&GOOD: g['goodwill / price']+=1
    if ws&GIVE: g['on the giveaway list (stats, sync, widget, cap)']+=1
    if ws-GOOD-GIVE: g['anything else']+=1
print('groups (a payer can be in more than one):',dict(g))
print('anything else:',[(L[i][0],L[i][1],f(i,'why')) for i in pay if set(f(i,'why'))-GOOD-GIVE])
t=C.Counter(k for i in range(len(L)) for k in f(i,'tog')); print('doing habits with others (free Groups):',dict(t))
