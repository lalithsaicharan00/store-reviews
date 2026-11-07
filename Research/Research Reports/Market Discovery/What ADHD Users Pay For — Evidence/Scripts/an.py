from tally import *
main=[r for r in rows if not r['sus'] and not r['ch']]
full=[r for r in main if r['i']<5000]
print(len(main),len(full))
import collections as C
per=C.defaultdict(list)
for r in main: per[appname(r['o'])].append(r)
for a in sorted(per,key=lambda a:-len(per[a]))[:26]:
    L=per[a]; st=C.Counter(r['st'] for r in L)
    b=C.Counter(x for r in L for x in set(r['B'])); h=C.Counter(x for r in L for x in set(r['B']+r['H'])); m=C.Counter(x for r in L for x in set(r['M']))
    print(a,len(L),dict(st),'| B',b.most_common(5),'| BH',h.most_common(7),'| M',m.most_common(4))
Cc=[r for r in full if r['st']=='C']
print(len(Cc))
L=[]
for r in Cc:
    t=re.sub(r'\s+',' ',r['o']['t'].replace('&#39;',"'"))
    L.append(f"#{r['i']} {r['o']['st']}★ {appname(r['o'])[:10]} M={r['M']}: {t[:260]}")
open('cq.txt','w').write('\n'.join(L));print(sum(map(len,L)))
