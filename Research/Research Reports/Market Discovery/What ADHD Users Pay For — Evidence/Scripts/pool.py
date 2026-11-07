# Every review that names ADHD, from the old corpus and the new ADHD apps; then who may have paid.
import json,os,re,collections,hashlib
from paid import classify,TRAP
R='/Users/lalith/Desktop/store reviews/Research'
ADHD=re.compile(r"\b(a\.d\.h\.d\.?|adhd\w*|audhd\w*|au-dhd|adhs\w*|tdah|tdha|attention deficit)",re.I)
ADDW=re.compile(r"(?:\b(?:I have|I've got|with|my|have|has|diagnosed|got|severe|inattentive|of)\s+ADD\b(?![- ]on))|\bADD\s+(?:brain|person|people|mind|meds|medication|diagnosis|adult)\b")
ADDCAP=re.compile(r"\bADD\b")
WIDE=re.compile(r"\b(paid|pay|paying|pays|purchas\w*|bought|buy|buying|premium|pro\b|plus\b|subscri\w*|lifetime|upgrad\w*|worth|money|price\w*|\$|£|€|trial|membership|cost\w*|fee|fees|one[- ]time|annual\w*|yearly|monthly|invest\w*|refund\w*|charged|bezahl\w*|gekauft|abo\b|pagu\w*|compr\w*|suscri\w*|assinatura|achet\w*|abonn\w*|payé)",re.I)
def ok(t): return bool(ADHD.search(t) or ADDW.search(t))
seen=set();out=[];st=collections.Counter()
def add(store,app,src,r,text,loc):
    n=re.sub(r'\W+','',text.lower())[:200]
    k=hashlib.md5((store+n).encode()).hexdigest()
    if k in seen: st['dup']+=1;return
    seen.add(k)
    if not ok(text): return
    tier,hit=classify(text)
    out.append({'id':str(r['id']),'s':store,'app':app,'src':src,'st':r['st'],'d':r['d'],'loc':loc,'t':text,'tier':tier,'trap':bool(TRAP.search(text)),'wide':bool(WIDE.search(text))})
# new first, so a fresher copy wins
for store,sub in (('ios','App Store'),('play','Play Store')):
    b=f'{R}/ADHD App Reviews/{sub}'
    for d in sorted(os.listdir(b)):
        p=f'{b}/{d}/reviews.jsonl'
        if not os.path.exists(p): continue
        for l in open(p):
            try:x=json.loads(l)
            except: continue
            if store=='ios': text=((x.get('title') or '')+' . '+(x.get('body') or '')).strip();loc=x.get('country')
            else: text=(x.get('text') or '').strip();loc=x.get('language')
            st['new_'+store]+=1
            add(store,d,'new',{'id':x['review_id'],'st':x.get('rating'),'d':(x.get('date') or '')[:10]},text,loc)
for l in open('../audience/corpus.jsonl'):
    r=json.loads(l); st['old']+=1
    add(r['s'],r['app'],'old',r,r['t'],r['loc'])
json.dump(out,open('pool.json','w'),ensure_ascii=False)
print(st,len(out))
print('tier',collections.Counter(o['tier'] for o in out))
print('wide',sum(o['wide'] for o in out),'tier or wide',sum(1 for o in out if o['tier'] or o['wide']),'tier no trap',sum(1 for o in out if o['tier'] and not o['trap']),'trap',sum(o['trap'] for o in out))
print(collections.Counter((o['s'],o['app'][:30]) for o in out if o['tier']).most_common(25))
