import json,glob,re,collections
idx=json.load(open('indexed_full.json'))
valid=set("CAL YEAR WEEK CHART PCT STRK TOT ALL RPT PAT GRP QST DAYD LONG EXP MILE VIS GEN PART FORG STAT BF XGATE XWRONG XTHIN XFIND XCONF XSHAME XBUG XLOST XNONDAILY XREMOVED XCLUTTER".split())
codes={}
bad=[];dup=[]
for f in sorted(glob.glob('cls/b*.txt')):
    for line in open(f):
        line=line.strip()
        if not line: continue
        i,c=line.split(':',1); i=int(i)
        if i in codes: dup.append(i)
        cs=[] if c=='NA' else c.split(',')
        for x in cs:
            if x.lstrip('?') not in valid: bad.append((i,x))
        if len(set(cs))!=len(cs): dup.append(('intra',i))
        codes[i]=cs
print('records',len(codes),'expected',len(idx))
print('unknown idx',[i for i in codes if i>=len(idx) or i<0][:5])
print('missing',[i for i in range(len(idx)) if i not in codes][:5])
print('dups',dup[:10],'bad codes',bad[:20])
def app(r): 
    n=r['folder'].split('.')[0]; return ('A' if r['store']=='app' else 'P')+n
json.dump({str(k):v for k,v in codes.items()},open('codes_all.json','w'))
coded=[i for i,c in codes.items() if c]
print('relevant (non-NA)',len(coded), 'NA',len(codes)-len(coded))
T=collections.defaultdict(list)
for i,cs in codes.items():
    for x in cs: T[x].append(i)
rows=[]
for k,v in T.items():
    apps=set(app(idx[i]) for i in v); st=sum(idx[i]['rating'] for i in v)/len(v)
    rows.append((len(v),k,len(apps),round(st,2),v[:6]))
rows.sort(reverse=True)
for r in rows: print(r)
