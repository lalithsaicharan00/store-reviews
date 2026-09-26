import json, re, glob, os
ROOT='/Users/lalith/Desktop/store reviews/Research'
PROF=re.compile(r"\bprofile (tab|page|screen|section|icon|button|menu)|\b(me|account|you) tab\b|tab (called|named|labell?ed) .?(me|profile|you)\b|\bprofile\b.{0,40}\b(useless|unnecessary|pointless|don.?t need|never use|waste|why)\b|\b(useless|unnecessary|pointless|don.?t need|never use|waste)\b.{0,40}\bprofile\b", re.I)
ALL=re.compile(r"\b(see|view|show|list|display|find|manage|browse|overview of)\b.{0,25}\b(all|every one of|each of)\b.{0,12}\b(my |the |of my |of the )?(habits|routines|goals)\b|\ball (my |of my )?habits\b.{0,30}\b(in one place|at once|list|page|screen|overview|view)\b|\b(habit list|list of (all )?(my )?habits|habits? library|library of habits|manage habits|habit manager|all habits (tab|page|screen|view))\b", re.I)
LIB=re.compile(r"\b(habit (library|templates?|ideas|suggestions)|guided (habits?|programs?|courses?|journeys?|plans?)|pre-?made habits|predefined habits|suggested habits|habit packs?)\b", re.I)
out={'PROF':[],'ALL':[],'LIB':[]}
for store,base in [('A','App Store Reviews'),('P','Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m=re.match(r'(\d+)\.',os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d+'reviews.jsonl'): continue
        for i,l in enumerate(open(d+'reviews.jsonl',encoding='utf-8').read().split('\n')):
            if not l.strip(): continue
            r=json.loads(l); t=((r.get('title') or '')+' || '+(r.get('body') or r.get('text') or '')).replace('\n',' ')
            for k,rx in [('PROF',PROF),('ALL',ALL),('LIB',LIB)]:
                if rx.search(t): out[k].append({'id':f'{store}{m.group(1)}#{i}','app':os.path.basename(d.rstrip('/')),'rating':r.get('rating'),'text':t})
for k,v in out.items():
    json.dump(v,open(f'{k}.json','w'),ensure_ascii=False)
    with open(f'{k}.tsv','w') as f:
        for h in v:
            t=h['text']; rx={'PROF':PROF,'ALL':ALL,'LIB':LIB}[k]; mm=rx.search(t); a=max(0,mm.start()-220)
            f.write(f"{h['id']}\t{h['rating']}\t{t[a:a+520]}\n")
    print(k,len(v))
