"""Q45: icon size / recognising habits by icon; check-off buttons on tiles, grids and circles. Full corpus."""
import json,re,collections,sys
sys.path.insert(0,"../today-top")
from screen import recs
X=re.I|re.X
F={}
F["I1_ICONSIZE"]=re.compile(r"""
 \b(?:bigger|larger|smaller|tiny|small|huge|big|large)\s+icons?\b
 | \bicons?\b.{0,25}\b(?:too\s+(?:small|tiny|big|large)|are\s+(?:small|tiny|huge|big)|hard\s+to\s+(?:see|read|tell)|bigger|larger)\b
""",X)
F["I2_ICONRECOG"]=re.compile(r"""
 \bicons?\b.{0,40}\b(?:at\s+a\s+glance|recogni[sz]e|tell\s+(?:them|habits?|apart)|identify|distinguish|find\s+(?:it|them|my))\b
 | \b(?:at\s+a\s+glance|recogni[sz]e|tell\s+apart|identify|distinguish)\b.{0,40}\bicons?\b
""",X)
F["I3_TILECHECK"]=re.compile(r"""
 \b(?:grid|tiles?|circles?|bubbles?|squares?)\b.{0,50}\b(?:check\s*(?:mark|box)|tick|button|tap(?:ped)?\s+by\s+(?:mistake|accident)|accidentally)\b
 | \b(?:accidentally|by\s+accident|by\s+mistake)\b.{0,40}\b(?:tap\w*|click\w*|check\w*|mark\w*)\b.{0,40}\b(?:grid|tiles?|circles?|icons?)\b
""",X)
if __name__=="__main__":
    outs={k:open(f"cand/{k}.jsonl","w") for k in F}; hit=collections.Counter()
    for store,folder,line,r,text in recs():
        for k,rx in F.items():
            m=rx.search(text)
            if m: hit[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print(dict(hit))
