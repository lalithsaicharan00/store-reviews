import json,re,glob,collections,csv,pathlib
R=pathlib.Path(__file__).resolve().parents[2]; O=R/'Temp/progress-week'
src=(R/'Research Reports/Progress and Statistics/Progress Evidence/scripts/screen.py').read_text(); env={}; exec(src.split('def recs():')[0],env)
context=re.compile('|'.join(p.pattern for k,p in env['F'].items() if k!='QUIT'),re.I|re.X)
week=re.compile(r'week(ly)?\s*(view|overview|report|summary|grid|calendar)|seven.days|7.day.view|all.{0,15}habits.{0,25}(one|glance|week)|semanal|hebdomadaire|wochen(ansicht|übersicht)|недельн.{0,12}(вид|обзор)|haftalık.{0,10}(görünüm|özet)|週表示|週一覧|週間.{0,8}(表示|一覧)|周视图|週視圖|주간.{0,8}(보기|통계)',re.I)
visual=re.compile(r'clean|beautiful|clutter|confus|too much|can.t tell|dots?|rings?|minimal|simple|overwhelm|visual|legend|易懂|清晰|简洁|簡潔|混乱|點|圆环|見やす|分かり|わかり|ごちゃ|깔끔|혼란|복잡|übersichtlich|unübersichtlich|verwirr|schön|klar|confus|lisib|épur|beau|sencill|limpi|bonit|confus|clar|simples|bonit|pulit|semplic|bello|непонят|нагляд|красив|просто|karış|sade|güzel|جميل|واضح|مربك|sederhana|bingung|đẹp|đơn giản',re.I)
marks=re.compile(r'(dots?|rings?|circles?|marks?|symbols?|icons?|legend|colou?rs?|score).{0,65}(mean|confus|understand|tell|explain)|(confus|understand|can.t tell|explain).{0,65}(dots?|rings?|circles?|marks?|symbols?|icons?|legend|score)|点.{0,8}(意味|わか)|色.{0,8}(分か|意味)|颜色.{0,10}(不懂|含义)|Bedeutung.{0,15}(Farbe|Kreis)',re.I)
tot=collections.Counter(); hits=[]; dates=[]
for store in ['App','Play','Native']:
 for f in sorted(R.glob(f'{store} Store Reviews/*/reviews.jsonl')):
  for n,l in enumerate(f.open(),1):
   r=json.loads(l);tot[store]+=1;t=(r.get('title') or '')+' — '+(r.get('body') or r.get('text') or '')
   if ((week.search(t) and visual.search(t)) or marks.search(t)) and any(p.search(t) for k,p in env['F'].items() if k!='QUIT'):
    hits.append(dict(store=store,folder=f.parent.name,line=n,id=r['review_id'],date=r.get('date'),rating=r.get('rating'),language=r.get('language') or r.get('country'),text=t))
(O/'hits.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in hits))
(O/'scan_summary.json').write_text(json.dumps(dict(denominators=tot,hits=len(hits),by_store=collections.Counter(r['store'] for r in hits)),indent=2))
print((O/'scan_summary.json').read_text())
