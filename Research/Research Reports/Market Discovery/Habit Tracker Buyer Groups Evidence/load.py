import json,glob,os,pickle,re
R='/home/user/store-reviews/Research/'
EXCL=['Food Delivery','Online Video Calls','Hevy','My Study Life']
EN_C={'us','gb','ca','au','nz','ie','in','za','ph','sg','ng','ke','pk','my','ae','hk','jm','tt','gh'}
rows=[]
for store,base in [('ios','App Store Reviews'),('play','Play Store Reviews')]:
    for d in sorted(glob.glob(R+base+'/*/')):
        name=os.path.basename(d.rstrip('/'))
        if any(e in name for e in EXCL): continue
        f=d+'reviews.jsonl'
        if not os.path.exists(f): continue
        for l in open(f):
            j=json.loads(l)
            if store=='ios':
                txt=((j.get('title') or '')+'. '+(j.get('body') or ''))
                en=j['country'] in EN_C
            else:
                txt=j.get('text') or ''
                en=j.get('language')=='en'
            rows.append((store,name,j['review_id'],j['rating'],en,txt,j.get('date','')[:10]))
pickle.dump(rows,open(R+'Temp/segments/rows.pkl','wb'))
print(len(rows), sum(r[4] for r in rows))
