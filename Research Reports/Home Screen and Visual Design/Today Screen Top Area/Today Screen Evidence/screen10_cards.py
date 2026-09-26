"""Card round 2 screens: streak units / big streak numbers; progress numbers on the list; frequency wording."""
import json, re, sys
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
# streak shown in weeks / months / years, or weekly-habit streaks
F["STRKUNIT"]=re.compile(r"""\b(?:weekly|monthly)\s+streaks?\b|\bstreaks?\s+(?:in|by|of|counted\s+in|for)\s+(?:weeks|months|years)\b|\b\d+\s*[- ]?(?:week|month|year)s?\s+streak\b|\bstreaks?\b[^.!?]{0,50}\b(?:weekly|non[- ]daily|x\s+times\s+a\s+week|times\s+(?:a|per)\s+week)\b[^.!?]{0,30}\bhabits?\b""",X)
# big streaks and how the count is shown
F["STRKBIG"]=re.compile(r"""\b(?:[1-9]\d{2,3}|1,\d{3})\s*[- ]?days?\s+streak\b|\bstreak\s+of\s+(?:[1-9]\d{2,3}|1,\d{3})\s+days\b|\b(?:[1-9]\d{2,3}|1,\d{3})\s+days?\s+(?:in\s+a\s+row|straight)\b""",X)
# streak display complaints / wishes
F["STRKSHOW"]=re.compile(r"""\bstreaks?\b[^.!?]{0,40}\b(?:display|shown|showing|shows|visible|see|number|count(?:er)?)\b[^.!?]{0,40}\b(?:list|main|home|today|card|next\s+to|beside)\b""",X)
# progress numbers on the list for timed / measured habits
F["PROGLIST"]=re.compile(r"""\b(?:minutes|mins|time\s+spent|steps|pages|glasses|amount|value|progress|count)\b[^.!?]{0,40}\b(?:on|in)\s+(?:the\s+)?(?:main|home|today|habit)\s+(?:screen|page|list|view|tab)\b|\b(?:main|home|today)\s+(?:screen|page|list|view)\b[^.!?]{0,40}\b(?:only\s+shows?|doesn'?t\s+show|shows?)\b[^.!?]{0,30}\b(?:minutes|steps|progress|count|number|value|percentage)""",X)
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Temp/today-top/cand/C_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:70],"text":text},ensure_ascii=False)+"\n")
    print(h)
