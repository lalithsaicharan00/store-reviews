import json,re,collections
from tally import *
g={};exec(open('codes2/quit.py').read(),g);Q=g['Q']
main=[r for r in rows if not r['sus'] and not r['ch']]
full=[r for r in main if r['i']<5000]
N=len(main);F=len(full)
print('main',N,'full',F,collections.Counter(r['st'] for r in main),collections.Counter(r['o']['s'] for r in main))
print('apps',len({appname(r['o']) for r in main}),'full apps',len({appname(r['o']) for r in full}))
st=collections.Counter(r['o']['st'] if isinstance(r['o'].get('st'),int) else 0 for r in main);print('stars',sorted(st.items()))
L=[('wake','Wake-up alarm/missions'),('nag','Keeps nagging until done'),('rem','Reminders'),('tmr','Timer'),('vis','Visual timeline'),('gr','Step-by-step routines'),('est','See how long things take'),('voice','Voice prompts'),('brk','Break a task into steps'),('cap','Fast capture'),('ai','AI help'),('rew','Rewards/game'),('pet','Pet to care for'),('strk','Streaks'),('wid','Widget'),('cal','Calendar in one place'),('gentle','Gentle, no guilt'),('simple','Simple, not overwhelming'),('small','Tiny steps'),('cust','Customise'),('look','Looks/colour/icons'),('blk','Block apps'),('body','Body doubling'),('learn','Lessons about ADHD'),('comm','Community/coaching'),('track','Tracking/stats'),('mood','Mood'),('calm','Calming'),('unl','Unlimited items'),('share','Sharing'),('list','To-do lists'),('recur','Repeating tasks'),('roll','Rollover of missed tasks'),('sync','Sync'),('noads','No ads'),('dev','Support the maker'),('snd','Sound/focus music'),('plan','Plan the day'),('once','One-time price'),('price','Low price'),('tone','Tone checker'),('cook','Cooking/other tool'),('access','Accessibility'),('try','Tried free first'),('works','It visibly worked'),('now','Paid at once')]
print('\ncode | label | said-paid(all %d) | credited in full read(%d) | apps | gaps(full) '%(N,F))
out=[]
for k,l in L:
    b=[r for r in main if k in r['B']]; h=[r for r in full if k in r['B']+r['H']]; m=[r for r in full if k in r['M']]
    apps=collections.Counter(appname(r['o']) for r in h+[x for x in b if x['i']>=5000])
    out.append((len(h),k,l,len(b),len(apps),len(m),apps.most_common(4)))
for x in sorted(out,reverse=True): print(x[1],'|',x[2],'| B',x[3],'| H',x[0],f'{100*x[0]/F:.1f}%','| apps',x[4],'| M',x[5],'|',x[6])
J={'Routines and time':['gr','tmr','vis','est','voice','plan'],'Not forgetting':['rem','nag','wake','wid','cal','list','recur','cap','sync'],'Getting started':['brk','ai','body','small'],'Staying motivated':['rew','pet','strk','track','gentle'],'Understanding ADHD':['learn','comm'],'Focus':['blk','snd'],'Calm and simple':['simple','look','cust','calm']}
print('\nJOBS')
for j,ks in J.items():
    h=[r for r in full if set(ks)&set(r['B']+r['H'])]; m=[r for r in full if set(ks)&set(r['M'])]; b=[r for r in main if set(ks)&set(r['B'])]
    print(j,'credited',len(h),f'{100*len(h)/F:.1f}%','apps',len({appname(r['o']) for r in h}),'said',len(b),'gap',len(m))
print('\nPLATFORM credited iOS vs Play (full read)')
fi=[r for r in full if r['o']['s'].startswith('a') or r['o']['s'].startswith('i')]; fp=[r for r in full if r not in fi]
print(len(fi),len(fp),collections.Counter(r['o']['s'] for r in full))
for k,l in L:
    a=sum(k in r['B']+r['H'] for r in fi);b=sum(k in r['B']+r['H'] for r in fp)
    if a+b>=20: print(k,a,f'{100*a/max(1,len(fi)):.1f}',b,f'{100*b/max(1,len(fp)):.1f}')
print('\nPER APP')
A=collections.defaultdict(list)
for r in main: A[appname(r['o'])].append(r)
Sids=[i for i in S if inv.get(i) in idx]
Sa=collections.Counter(appname(idx[inv[i]]) for i in Sids)
for a,rs in sorted(A.items(),key=lambda x:-len(x[1])):
    if len(rs)<10: continue
    c=collections.Counter(r['st'] for r in rs)
    f=[r for r in rs if r['i']<5000]
    cr=collections.Counter(x for r in f for x in set(r['B']+r['H'])).most_common(5)
    m=collections.Counter(x for r in f for x in set(r['M'])).most_common(3)
    print(a,len(rs),f"P{c['P']} W{c['W']} C{c['C']} quit {100*c['C']/len(rs):.0f}% S{Sa[a]} full{len(f)}",cr,m)
print('S total',len(Sids),Sa.most_common(12))
print('\nQUIT')
qs=[r for r in main if r['st']=='C' and r['i']<5000]; print('C full',len(qs),'all C',sum(r['st']=='C' for r in main))
qc=collections.Counter(x for r in qs for x in set(Q.get(r['i'],'').split()))
print(qc.most_common()); print('uncoded',[r['i'] for r in qs if r['i'] not in Q])
print('\nSTATUS by platform');print(collections.Counter((r['o']['s'],r['st']) for r in main))
print('\nchild/suspected',sum(r['ch'] for r in rows),sum(r['sus'] for r in rows))
