import pathlib,json,re,collections,sys
sys.stdout.reconfigure(encoding='utf-8')
root=next(p for p in pathlib.Path(__file__).resolve().parents if (p/'RULEBOOK.md').exists())
out=root/'Research/Temp/widget_oct5_scan'
out.mkdir(exist_ok=True)
pattern=re.compile(r'widget|widjet|widge|ウィジェット|위젯|小组件|小部件|桌面组件|виджет|ويدجت|ودجت|ویجت|विजेट',re.I)
stats={'records':0,'files':0,'candidates':0,'stores':{},'method':'Multilingual lexical candidate inventory only; not human theme coding or preference measurement. Includes direct numbered app folders; insufficient-volume subfolders excluded.'}
with (out/'candidate_index.jsonl').open('w',encoding='utf-8') as target:
 for prefix,folder in [('A','App Store Reviews'),('P','Play Store Reviews')]:
  count=hits=files=0
  for path in sorted((root/'Research'/folder).glob('*/reviews.jsonl')):
   app=re.match(r'(\d+)\.',path.parent.name)
   if not app: continue
   files+=1
   with path.open(encoding='utf-8') as stream:
    for i,line in enumerate(stream):
     obj=json.loads(line); count+=1
     txt=obj.get('title','')+' '+obj.get('body',obj.get('text',''))
     if pattern.search(txt):
      hits+=1
      target.write(json.dumps({'ref':prefix+app[1]+'#'+str(i),'id':obj.get('review_id'),'source':str(path.relative_to(root)).replace('\\','/'),'rating':obj.get('rating'),'date':obj.get('date')},ensure_ascii=False)+'\n')
  stats['stores'][folder]={'records':count,'files':files,'lexical_candidates':hits}
  stats['records']+=count;stats['files']+=files;stats['candidates']+=hits
(out/'summary.json').write_text(json.dumps(stats,indent=2),encoding='utf-8')
print(json.dumps(stats))
