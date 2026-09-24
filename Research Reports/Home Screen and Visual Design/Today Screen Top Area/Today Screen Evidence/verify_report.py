import re,json,glob,html,sys
ROOT="/Users/lalith/Desktop/store reviews"
rep=open(sys.argv[1]).read()
base={'A':'App Store Reviews','P':'Play Store Reviews','N':'Native Store Reviews'}
def load(c):
    s,rest=c[0],c[1:]; n,line=rest.split('#')
    f=glob.glob(f"{ROOT}/{base[s]}/{n}. */reviews.jsonl")
    assert len(f)==1,(c,f)
    ls=open(f[0]).read().split('\n')
    r=json.loads(ls[int(line)])
    return html.unescape((r.get('title') or '')+' '+(r.get('body') or r.get('text') or r.get('content') or ''))
norm=lambda s: re.sub(r'\s+',' ',s.replace('’',"'").replace('&#39;',"'")).lower()
cites=sorted(set(re.findall(r'`([APN]\d+#\d+)`',rep)))
bad=0
for c in cites:
    try: load(c)
    except Exception as e: print('BAD ID',c,e); bad+=1
# quotes immediately preceding a cite: "..." `X`
for q,c in re.findall(r'"([^"]{6,300})"\s*(?:\([^)]*\))?\s*`([APN]\d+#\d+)`',rep):
    t=norm(load(c)); frags=[norm(x).strip(' .,') for x in re.split(r'…',q) if x.strip(' .,')]
    miss=[f for f in frags if f not in t]
    if miss: print('QUOTE MISMATCH',c,'|',q,'| missing:',miss); bad+=1
print('ids',len(cites),'problems',bad)
