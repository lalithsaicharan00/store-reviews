# Run: python3 -I 1-trigger-tally.py   (counts come only from the hand labels in 1-trigger-codes.py)
import json,runpy,collections
T=runpy.run_path('1-trigger-codes.py')['T']
ids=json.load(open('1-payer-final-ids.json'))
R={}
for l in open('../../../../App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl'):
    r=json.loads(l); R[r['review_id']]=r
missing=[n for n in range(len(ids)) if n not in T]; assert not missing, missing
P=[n for n in range(len(ids)) if T[n]!='notpaid']
GROUP={'offer':'A','discount':'A',
       'cap':'B','reports':'B','widget':'B','sync':'B','watch':'B','health':'B','backup':'B','reminders':'B','backfill':'B','trial':'B',
       'family':'C','share':'C',
       'like':'D','longuse':'D','cheap':'D','support':'D','rec':'D','other':'D',
       'lockout':'E','unknown':'U'}
NAME={'A':'Bought on the spot, at the purchase screen or a time-limited price','B':'Needed something the free version lacks (outgrew it)','C':'Bought for other people (family plan, sharing)','D':'Goodwill/value only: liked it, used it long, cheap, to support, recommended','E':'Locked out until they paid','U':'Paid, but the review never says why (almost all are complaints)'}
def run(sel,title):
    n=len(sel); c=collections.Counter(); g=collections.Counter(); rat=collections.defaultdict(list)
    for i in sel:
        cs=T[i].split(','); gs=set(GROUP[x] for x in cs)
        for x in cs: c[x]+=1; rat[x].append(R[ids[i]]['rating'])
        for x in gs: g[x]+=1
    known=n-g['U']
    print(f'\n===== {title}: {n} payers, {known} ({100*known/n:.0f}%) show what made them pay')
    print('GROUPS (a review can be in more than one):')
    for k in 'ABCDEU': print(f'  {k} {NAME[k]:72} {g[k]:4}  {100*g[k]/n:5.1f}% of payers  {100*g[k]/known if k!="U" else 0:5.1f}% of those who say')
    print('DETAIL:')
    for k,v in c.most_common():
        print(f'  {k:10} {v:4}  {100*v/n:5.1f}% of payers  {100*v/known if k!="unknown" else 0:5.1f}% of those who say   avg {sum(rat[k])/len(rat[k]):.2f}★')
run(P,'ALL STOREFRONTS')
run([i for i in P if R[ids[i]]['country']!='cn'],'OUTSIDE CHINA')
run([i for i in P if R[ids[i]]['country']=='us'],'US')
run([i for i in P if R[ids[i]]['country']=='cn'],'CHINA')
