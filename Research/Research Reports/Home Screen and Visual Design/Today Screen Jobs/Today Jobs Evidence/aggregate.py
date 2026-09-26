import json,glob,html,re,collections,unicodedata
from common import cite, ctx
rows=json.load(open('read_set.json'))
codes={}
for f in sorted(glob.glob('codes/B*.txt')):
    for l in open(f):
        l=l.rstrip('\n')
        if not l.strip(): continue
        p=l.split('\t'); codes[int(p[0])]=(p[1].split(','),p[2] if len(p)>2 else '')
def norm(s):
    s=html.unescape(html.unescape(s)); s=unicodedata.normalize('NFKC',s)
    s=s.replace('’',"'").replace('‘',"'").replace('“','"').replace('”','"').replace('&#39;',"'")
    return re.sub(r'\s+',' ',s).lower()
bad=[]
for i,(cs,q) in codes.items():
    t=norm(rows[i]['text'])
    parts=[x.strip() for x in re.split(r'\s*\.\.\.\s*|…',q) if x.strip()]
    for p in parts:
        if norm(p) not in t: bad.append((i,cite(rows[i]),p[:60]))
print('coded reviews',len(codes),'quote mismatches',len(bad))
for b in bad[:40]: print(b)

# ---- counts
out={}
C=collections.defaultdict(list)
for i,(cs,q) in codes.items():
    for c in cs: C[c].append(i)
def summ(ids):
    rs=[rows[i] for i in ids]
    apps=len({(r['store'],r['folder']) for r in rs})
    hab=sum(1 for r in rs if ctx(r)=='habit')
    stars=[r['rating'] for r in rs if r.get('rating')]
    return dict(n=len(ids),apps=apps,habit=hab,adjacent=len(ids)-hab,mean=round(sum(stars)/len(stars),2) if stars else None)
res={c:summ(ids) for c,ids in C.items()}
for c,v in sorted(res.items(),key=lambda x:-x[1]['n']): print(f"{c:15} {v}")
# MANYN numbers
nums=[]
for i in C['MANYN']:
    m=re.findall(r'\b(\d{1,3})\b',codes[i][1]+' '+rows[i]['text'][:0])
split=json.load(open('split_1669.json'))
print('rule-coded CJK', {k:len(v) for k,v in split['cj_rule'].items()})
print('dropped scroll noise', len(json.load(open('filter_630.json'))['drop']))
json.dump({'res':res,'ids':{c:[cite(rows[i]) for i in ids] for c,ids in C.items()}},open('agg_glance.json','w'),ensure_ascii=False,indent=0)
