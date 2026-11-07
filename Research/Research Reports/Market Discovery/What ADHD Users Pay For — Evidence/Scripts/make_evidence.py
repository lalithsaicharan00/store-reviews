import csv,os,shutil,glob,html,json
from tally import *
g={};exec(open('codes2/quit.py').read(),g);Q=g['Q']
D="/Users/lalith/Desktop/store reviews/Research/Research Reports/Market Discovery/What ADHD Users Pay For — Evidence"
os.makedirs(D+'/Codes',exist_ok=True);os.makedirs(D+'/Scripts',exist_ok=True)
with open(D+'/Payers.csv','w',newline='') as f:
    w=csv.writer(f);w.writerow(['number','store','app','app_group','stars','date','language_or_market','review_id','status','read','group','said_paid_for','credited','gaps','quit_reasons','text'])
    for r in sorted(rows,key=lambda x:x['i']):
        o=r['o'];grp='child' if r['ch'] else 'suspected' if r['sus'] else 'main'
        w.writerow([r['i'],o['s'],o['app'],appname(o),o.get('st'),o.get('d'),o.get('loc'),o['id'],r['st'],'full' if r['i']<5000 else 'money sentence',grp,' '.join(r['B']),' '.join(r['H']),' '.join(r['M']),Q.get(r['i'],''),html.unescape(o['t'])])
with open(D+'/Surprise Charges.csv','w',newline='') as f:
    w=csv.writer(f);w.writerow(['number','store','app_group','stars','review_id','text'])
    for i in sorted(S):
        k=inv.get(i)
        if k in idx:
            o=idx[k];w.writerow([i,o['s'],appname(o),o.get('st'),o['id'],html.unescape(o['t'])])
with open(D+'/Cited Non-Payers.csv','w',newline='') as f:
    w=csv.writer(f);w.writerow(['number','store','app_group','stars','review_id','text'])
    for i in [1779,5603,5621,5631,5731,6810]:
        o=idx[inv[i]];w.writerow([i,o['s'],appname(o),o.get('st'),o['id'],html.unescape(o['t'])])
for p in glob.glob('codes/*.py')+glob.glob('codes2/*.py'):
    shutil.copy(p,D+'/Codes/'+os.path.basename(p).replace('.py','')+('_w' if 'codes2' in p else '')+'.py')
for p in ['apps.json','paid.py','pool.py','make_batches.py','remake.py','wide2.py','tally.py','final.py','mx.py','an.py','quotes.py','collect.py','make_evidence.py']:
    if os.path.exists(p): shutil.copy(p,D+'/Scripts/'+p)
print(len(rows),'rows',len([i for i in S if inv.get(i) in idx]),'S')
