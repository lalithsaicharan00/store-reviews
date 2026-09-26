"""Card research screen 2: stats/history on the list, count increment on the list, timer from the list."""
import json, re, sys
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
F["LISTSTATS"]=re.compile(r"""\b(?:stats|statistics|analytics|graphs?|charts?|history|past\s+(?:days|week)|last\s+(?:7|seven)\s+days|week(?:ly)?\s+(?:dots|circles|strip|bar))\b[^.!?]{0,50}\b(?:main|home|habits?|today)\s+(?:screen|page|list|view|tab)\b|\b(?:main|home|habits?|today)\s+(?:screen|page|list|view|tab)\b[^.!?]{0,50}\b(?:stats|statistics|analytics|graphs?|charts?|history|past\s+(?:days|week)|last\s+(?:7|seven)\s+days)\b""",X)
F["TAPCOUNT"]=re.compile(r"""\b(?:tap|click|press|button)\w*\b[^.!?]{0,40}\b(?:increment|add\s+(?:one|1|a\s+glass)|\+\s?1|count\s+up|increase\s+the\s+count)\b|\b(?:increment|\+1)\s+(?:button|tap)\b""",X)
F["TIMERLIST"]=re.compile(r"""\b(?:start|run|launch)\w*\s+(?:the\s+|a\s+)?timer\b[^.!?]{0,50}\b(?:from|on|in)\s+(?:the\s+)?(?:main|home|list|habit\s+list|today|card|widget)\b|\btimer\s+(?:button|icon)\b""",X)
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Temp/today-top/cand/C_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print(h)
