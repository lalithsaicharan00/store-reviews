# Tally of hand labels in cal-codes.py over cal-read.txt. Run: python3 -I cal-tally.py
import runpy,collections as C
K=runpy.run_path('cal-codes.py')['K']
L=[l.split('|',7) for l in open('cal-read.txt').read().split('\n') if l]
def f(i,k):
    o=[]
    for p in K[i].split('|'):
        if p.startswith(k+'='): o+=p[len(k)+1:].split(',')
        elif p==k: o.append(k)
    return o
on=[i for i in K if f(i,'s') and f(i,'d')!=['app'] and f(i,'d')!=['dev']]
print('candidates read',len(L),'| about connecting a habit app to a calendar',len(on),'| "use your calendar instead" (alt)',sum('alt' in K[i] for i in K))
s=C.Counter(x for i in on for x in f(i,'s')); print('stance',dict(s))
d=C.Counter(x for i in on for x in f(i,'d')); print('direction (all)',dict(d))
dw=C.Counter(x for i in on if 'W' in f(i,'s') for x in f(i,'d')); print('direction among requests',dict(dw))
c=C.Counter(x for i in on for x in f(i,'c')); print('calendar named',dict(c))
st=C.Counter(L[i][1] for i in on); print('store',dict(st))
p=C.Counter(x for i in on for x in f(i,'pay')); print('pay',dict(p),'| left/won\'t use without it',sum('left' in K[i] for i in on))
apps=C.Counter(L[i][2] for i in on); print('top apps',apps.most_common(12))
print('avg rating requests %.2f'%(sum(int(L[i][5]) for i in on if 'W' in f(i,'s'))/sum('W' in f(i,'s') for i in on)))
print('paid BECAUSE of it:',[(L[i][2],L[i][3]) for i in on if 'R' in f(i,'pay')])
print('broken:',[(L[i][2][:14],L[i][3]) for i in on if 'K' in f(i,'s')])
