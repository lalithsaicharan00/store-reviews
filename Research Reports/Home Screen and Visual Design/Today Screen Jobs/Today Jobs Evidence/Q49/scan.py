import json, re, glob, os
ROOT='/Users/lalith/Desktop/store reviews'
rx=re.compile(r"\b(colou?r(s|ful|ed|ing|ize|ise)?|pastel|monochrom\w*|rainbow|tint\w*|vibrant|colou?r[- ]?cod\w*|couleurs?|farbe\w*|colori?|cores?|цвет\w*|renk\w*)\b|색|色|カラー", re.I)
out=[]
for store,base in [('A','App Store Reviews'),('P','Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        name=os.path.basename(d.rstrip('/'))
        m=re.match(r'(\d+)\.',name)
        if not m: continue
        f=d+'reviews.jsonl'
        if not os.path.exists(f): continue
        lines=open(f,encoding='utf-8').read().split('\n')
        for i,l in enumerate(lines):
            if not l.strip(): continue
            r=json.loads(l)
            t=(r.get('title') or '')+' || '+(r.get('body') or r.get('content') or r.get('text') or '')
            if rx.search(t):
                out.append({'id':f"{store}{m.group(1)}#{i}",'app':name,'rating':r.get('rating') or r.get('score'),'text':t})
json.dump(out,open('hits.json','w'),ensure_ascii=False)
print(len(out))
from collections import Counter
c=Counter(h['app'] for h in out); print(c.most_common(25))
