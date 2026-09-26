"""Card research screen (habit apps): time shown on list, card clutter, view vocabulary."""
import json, re, collections, sys
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Research/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
F["TIMESHOW"]=re.compile(r"""\b(?:show|see|display|add|put|include|view)\w*\s+(?:the\s+)?(?:reminder\s+|scheduled\s+|set\s+)?times?\b[^.!?]{0,50}\b(?:main|home|list|card|screen|page|overview|today|habit\s+list|habits)\b|\b(?:main|home|list|overview|today)\s+(?:screen|page|view|list)\b[^.!?]{0,40}\b(?:no|without|doesn'?t\s+show|lacks?)\s+(?:the\s+)?times?\b|\bsee\s+the\s+time\s+(?:you|i)\s+(?:have\s+)?set\b|\btime\s+(?:rather|instead)\s+(?:than|of)\b""",X)
F["CARDCLUT"]=re.compile(r"""\b(?:too\s+much|so\s+much|lots\s+of|too\s+many)\s+(?:info|information|details?|numbers|stuff|things|icons|data)\b[^.!?]{0,40}\b(?:card|row|habit|list|screen|main)|\b(?:card|row|habit|list)s?\b[^.!?]{0,30}\b(?:cluttered|busy|crowded|overwhelming|messy)""",X)
VOC={'view':r'\b(?:day|daily|week|weekly|month|monthly|year|yearly|annual)\s+views?\b','layout':r'\b(?:day|daily|week|weekly|month|monthly|year|yearly)\s+layouts?\b','progress':r'\b(?:daily|weekly|monthly|yearly|annual)\s+progress\b','mode':r'\b(?:day|daily|week|weekly|month|monthly|year|yearly)\s+mode\b'}
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Research/Temp/today-top/cand/C_{k}.jsonl","w") for k in F}; h={k:0 for k in F}; v=collections.Counter(); VR={k:re.compile(x,re.I) for k,x in VOC.items()}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
        for k,rx in VR.items():
            if rx.search(text): v[k]+=1
    print(h); print(dict(v)); json.dump(v,open('/Users/lalith/Desktop/store reviews/Research/Temp/today-cards/view_vocab.json','w'))
