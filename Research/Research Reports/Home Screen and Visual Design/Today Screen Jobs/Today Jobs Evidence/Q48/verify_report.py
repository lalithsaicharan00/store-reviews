"""Check every "quote" `ID` pair in a report against the review at that line."""
import json,html,unicodedata,sys,re,glob
def norm(s): s=unicodedata.normalize('NFKC',html.unescape(html.unescape(s))); return ' '.join(s.replace('’',"'").replace('‘',"'").replace('“','"').replace('”','"').lower().split())
ROOT='/Users/lalith/Desktop/store reviews/Research/'
DIRS={'A':'App Store Reviews','P':'Play Store Reviews'}
def review(cid):
    m=re.match(r'([APN])(\d+)#(\d+)$',cid); s,n,i=m.groups()
    d=glob.glob(f"{ROOT}{DIRS[s]}/{n}. */reviews.jsonl")
    if len(d)!=1: return None
    L=open(d[0]).read().split('\n'); i=int(i)
    if i>=len(L): return None
    r=json.loads(L[i]); return ' '.join(str(r.get(k,'')) for k in ('title','content','text','review','body'))
t=open(sys.argv[1]).read(); ok=bad=0
for q,cid in re.findall(r'"([^"]{6,})"\s*`([APN]\d+#\d+)`',t):
    r=review(cid)
    if r is None: print('NO REVIEW',cid); bad+=1
    elif norm(q) in norm(r): ok+=1
    else: print('MISMATCH',cid,q); bad+=1
ids=set(re.findall(r'`([APN]\d+#\d+)`',t))
for cid in ids:
    if review(cid) is None: print('MISSING ID',cid); bad+=1
print(ok,'quotes ok,',bad,'problems,',len(ids),'ids')
