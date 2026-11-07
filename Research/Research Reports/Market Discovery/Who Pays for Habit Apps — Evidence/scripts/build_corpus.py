#!/usr/bin/env python3
# Step 1: every review from every habit/routine app, both stores, in one file.
import json, os, glob, hashlib, collections, re
R='/Users/lalith/Desktop/store reviews/Research'
play=json.load(open(R+'/Tools/play_curation.json'))
cats={x['package']:x.get('category') for x in play['include']}
out=open('corpus.jsonl','w'); stats=collections.Counter(); perapp=collections.Counter()
seen=set(); dup=0
apps=[]
for store,base in (('ios',R+'/App Store Reviews'),('play',R+'/Play Store Reviews')):
    for d in sorted(os.listdir(base)):
        p=f'{base}/{d}/reviews.jsonl'
        if not os.path.exists(p): continue
        n=0
        for l in open(p):
            try:r=json.loads(l)
            except: stats['bad']+=1; continue
            if store=='ios':
                text=((r.get('title') or '')+' . '+(r.get('body') or '')).strip(); loc=r.get('country')
            else:
                text=(r.get('text') or '').strip(); loc=r.get('language')
            key=(store,d,r.get('review_id'))
            if key in seen: dup+=1; continue
            seen.add(key)
            out.write(json.dumps({'id':r['review_id'],'s':store,'app':d,'loc':loc,'st':r.get('rating'),'d':(r.get('date') or '')[:10],'t':text,'a':r.get('author'),'v':r.get('vote_count') or r.get('thumbs_up') or 0,'pkg':r.get('package')},ensure_ascii=False)+'\n')
            n+=1
        stats[store]+=n; apps.append((store,d,n))
out.close()
print(stats,'dup',dup,'apps',len(apps))
json.dump(apps,open('apps.json','w'),ensure_ascii=False,indent=0)
for s,d,n in sorted(apps,key=lambda x:-x[2])[:25]: print(s,n,d)
