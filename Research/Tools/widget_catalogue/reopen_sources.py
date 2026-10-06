import json, re, pathlib, collections, hashlib, urllib.request, sys
sys.stdout.reconfigure(encoding='utf-8')

root = next(p for p in pathlib.Path(__file__).resolve().parents if (p/'RULEBOOK.md').exists())
research = root / 'Research'
base = research / 'Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets'
out = base / 'Widgets'
out.mkdir(exist_ok=True)
report = (base / 'Home Screen Cards and Widgets.md').read_text(encoding='utf-8')
sections = report[report.index('## 6. Widgets'):report.index('## 7.')]
index = report[report.index('**Widgets**', report.index('## 9.')):]
free = (research / 'Research Reports/Business Model and Monetization/Free Plan Design — Habit Cap, Widgets and an Honest Listing.md').read_text(encoding='utf-8')
free = free[free.index('## 6. Widgets'):free.index('## 7. Apple Watch')]
previous = json.loads((base / 'Widgets/Historical Research/iPhone Widget Evidence/primary_reviews.json').read_text(encoding='utf-8'))
refs = set(re.findall(r'[AP]\d+#\d+', sections + index + free)) | {r['ref'] for r in previous}
files = {}
for prefix, folder in [('A','App Store Reviews'),('P','Play Store Reviews')]:
    for path in (research/folder).glob('*/reviews.jsonl'):
        m = re.match(r'(\d+)\.',path.parent.name)
        if m: files[prefix+str(int(m[1]))] = path
grouped = collections.defaultdict(list)
for ref in refs:
    app, num = ref.split('#'); grouped[app].append((int(num),ref))
records=[]
for app, wanted in grouped.items():
    if app not in files: raise ValueError('Missing app '+app)
    byindex=dict(wanted)
    with files[app].open(encoding='utf-8') as stream:
        for i,line in enumerate(stream):
            if i not in byindex: continue
            obj=json.loads(line)
            records.append({'ref':byindex[i],'source':str(files[app].relative_to(root)).replace('\\','/'),'source_index':i,'id':str(obj.get('review_id',obj.get('id',obj.get('reviewId','')))),'record':obj})
if len(records)!=len(refs): raise ValueError('Unresolved source indices')
old_tick=(research/'Research Reports/Home Screen and Visual Design/Widgets — Tick Without Opening the App.md').read_text(encoding='utf-8')
extra_ids=set(re.findall(r'`(\d{8,})`',old_tick))
seen={r['ref'] for r in records}
for app,path in files.items():
    if not app.startswith('A'): continue
    with path.open(encoding='utf-8') as stream:
        for i,line in enumerate(stream):
            obj=json.loads(line); ref=app+'#'+str(i)
            if (str(obj.get('review_id')) in extra_ids or app=='A56') and ref not in seen:
                records.append({'ref':ref,'source':str(path.relative_to(root)).replace('\\','/'),'source_index':i,'id':str(obj['review_id']),'record':obj})
                seen.add(ref)
records.sort(key=lambda x:(x['ref'][0],int(x['ref'].split('#')[0][1:]),x['source_index']))
(out/'Verified Review Sources.json').write_text(json.dumps(records,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps({'reopened':len(records),'app_store':sum(r['ref'][0]=='A' for r in records),'play_store':sum(r['ref'][0]=='P' for r in records),'apps':len({r['ref'].split('#')[0] for r in records}),'prior_coding_available':(research/'Temp/homescreen/codes').exists()}))
start=int(sys.argv[1]) if len(sys.argv)>1 else 0
for r in records[start:start+35]:
    v=r['record']; print(r['ref'],v.get('rating',v.get('score')),v.get('date',v.get('at')),v.get('country',v.get('language','')),v.get('title',''),v.get('body',v.get('text',v.get('content',''))))
