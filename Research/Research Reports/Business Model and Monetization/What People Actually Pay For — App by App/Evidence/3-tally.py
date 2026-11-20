# Tally of hand labels in 3-codes.py over 3-pay-read.txt. Run: python3 -I 3-tally.py
import runpy,collections as C
K=runpy.run_path('3-codes.py')['K']
L=[l.split('|',5) for l in open('3-pay-read.txt').read().split('\n') if l]
def f(n,key):
    out=[]
    for p in K.get(n,'').split('|'):
        if p.startswith(key+'='): out+=p[len(key)+1:].split(',')
    return out
for code,name in [('Y','PAID'),('I','WOULD PAY'),('D','WANT TO DONATE/TIP')]:
    sel=[i for i in range(len(L)) if f(i,'pay')==[code]]
    w=C.Counter(); nowhy=0
    for i in sel:
        ws=f(i,'why'); nowhy+= not ws
        for k in set(ws): w[k.split(':')[0] if not k.startswith('other') else k]+=1
    print(f'\n{name}: {len(sel)}  avg {sum(int(L[i][2]) for i in sel)/max(1,len(sel)):.2f}  | say why {len(sel)-nowhy}, never say {nowhy}')
    for k,v in w.most_common(): print('   ',k,v)
GIVE={'widget','backup','sync','stats'}; GOOD={'onetime','cheap','worth','support','longuse','money','offer'}
pay=[i for i in range(len(L)) if f(i,'pay')==['Y']]
g=C.Counter()
for i in pay:
    ws=set(x.split(':')[0] if not x.startswith('other') else x for x in f(i,'why'))
    if ws&GOOD: g['price / goodwill']+=1
    if ws&GIVE: g['giveaway list']+=1
    if ws-GOOD-GIVE: g['anything else']+=1
print('\npayer groups:',dict(g))
print('anything else:',[(i,L[i][3],f(i,'why')) for i in pay if set(f(i,'why'))-GOOD-GIVE])
print('payers by year:',sorted(C.Counter(L[i][3][:4] for i in pay).items()))
