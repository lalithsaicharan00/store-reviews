import json,re,glob,os
ROOT='/Users/lalith/Desktop/store reviews'
skip=re.compile(r'^(84\. Tasks|126\. To Do|97\. To-do|111\. My Study|100\. To Do|121\. Bordio|117\. Tiimo|122\. Hevy)')
T={
 # names for the stats place
 'progress (tab/page/screen/section)': r"\bprogress (tab|page|screen|section|view)\b",
 'stats/statistics (tab/page/...)': r"\b(stats|statistics) (tab|page|screen|section|view)\b",
 'insights (tab/page/...)': r"\binsights? (tab|page|screen|section|view)\b",
 'history (tab/page/...)': r"\bhistory (tab|page|screen|section|view)\b",
 'analytics (tab/page/...)': r"\banalytics (tab|page|screen|section|view)\b",
 'report(s) (tab/page/...)': r"\breports? (tab|page|screen|section|view)\b",
 'overview (tab/page/...)': r"\boverview (tab|page|screen|section)\b",
 # names for the list of all habits
 'habit list / list of habits': r"\bhabits? list\b|\blist of (all )?(my )?habits\b",
 'all habits (page/tab/view/...)': r"\ball habits (page|tab|view|screen|section|list)\b|\"all habits\"",
 'my habits (page/tab/...)': r"\bmy habits (page|tab|screen|section|list)\b",
 'habit manager / manage habits': r"\bhabit manager\b|\bmanage (my )?habits\b",
 'master list': r"\bmaster list\b",
}
C={k:re.compile(v,re.I) for k,v in T.items()}
counts={k:0 for k in T}; ex={k:[] for k in T}
for store,base in [('A','App Store Reviews'),('P','Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        name=os.path.basename(d.rstrip('/')); m=re.match(r'(\d+)\.',name)
        if not m or skip.match(name) or not os.path.exists(d+'reviews.jsonl'): continue
        for i,l in enumerate(open(d+'reviews.jsonl',encoding='utf-8').read().split('\n')):
            if not l.strip(): continue
            r=json.loads(l); t=(r.get('title') or '')+' || '+(r.get('body') or r.get('text') or '')
            for k,rx in C.items():
                mm=rx.search(t)
                if mm:
                    counts[k]+=1
                    if len(ex[k])<400: ex[k].append((f'{store}{m.group(1)}#{i}',r.get('rating'),t[max(0,mm.start()-150):mm.end()+150].replace('\n',' ')))
for k,v in counts.items(): print(f'{v:5}  {k}')
json.dump(ex,open('examples.json','w'),ensure_ascii=False)
