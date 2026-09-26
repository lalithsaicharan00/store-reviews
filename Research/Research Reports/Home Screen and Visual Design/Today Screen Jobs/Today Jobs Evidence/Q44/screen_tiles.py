"""Q44: grid/tile layouts vs list rows; truncated names; tap targets in tiles. Full corpus."""
import json,re,collections,sys
sys.path.insert(0,"../today-top")
from screen import recs
X=re.I|re.X
F={}
F["T1_GRID"]=re.compile(r"""
 \b(?:grid|tiles?|tiled|two[\s-]?columns?|2[\s-]?columns?|three[\s-]?columns?|columns|bubbles?|circles?|squares?|blocks?|boxes)\b.{0,30}\b(?:view|layout|mode|display|design|format|style)\b
 | \b(?:grid|tile|card|list|compact)\s+(?:view|layout|mode)\b.{0,60}\b(?:grid|tile|card|list|compact)\s+(?:view|layout|mode)\b
 | \b(?:side\s+by\s+side|more\s+than\s+one\s+per\s+row|per\s+row|in\s+a\s+row)\b.{0,40}\b(?:habits?|tasks?|circles?|icons?)
""",X)
F["T2_TRUNC"]=re.compile(r"""
 \b(?:names?|titles?|text|labels?|habits?|words)\b.{0,30}\b(?:(?:get|gets|are|is|being)\s+)?(?:cut\s+off|truncated?|abbreviated|don.?t\s+fit|doesn.?t\s+fit|too\s+long\s+to\s+(?:fit|show|display))
 | \b(?:cut\s+off|truncat\w+)\b.{0,30}\b(?:names?|titles?|habits?|text)
""",X)
if __name__=="__main__":
    outs={k:open(f"cand/{k}.jsonl","w") for k in F}; hit=collections.Counter()
    for store,folder,line,r,text in recs():
        for k,rx in F.items():
            m=rx.search(text)
            if m: hit[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print(dict(hit))
