"""Second screen (habit apps only: App Store + habit Play apps) for Q1/Q2 wording the first screen missed:
SPACE = wasted-space complaints; TOP = anything about the top of the main screen; ROLL = day rollover / which-day confusion."""
import json, re, os
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
F["SPACE"]=re.compile(r"(?:wast\w*|takes?\s+up|taking\s+up|eats?\s+up|uses?\s+up|occup\w+)\s+(?:\w+\s+){0,4}(?:space|room|real\s*estate|(?:half|third|quarter)\s+of\s+the\s+screen)|(?:space|room)\s+(?:is\s+)?wasted|unnecessary\s+(?:space|padding)|too\s+much\s+(?:white\s*|empty\s+|blank\s+)?space",X)
F["TOP"]=re.compile(r"(?:at|on|in|across)\s+the\s+(?:very\s+)?top(?:\s+of\s+(?:the\s+)?(?:screen|page|app|home\s*(?:screen|page)|main\s+(?:screen|page)|list|today))?|\btop\s+(?:bar|section|part|area|banner|row|header|of\s+the\s+(?:screen|page|app))\b|\bheader\b|\btitle\s+bar\b",X)
F["ROLL"]=re.compile(r"(?:after|past)\s+midnight|\b(?:day|date)\s+(?:resets?|changes?|rolls?\s+over|switch\w*|starts?|begins?|ends?)\s+at\b|(?:new\s+day|next\s+day)\s+(?:starts|begins|kicks\s+in)|\bday\s+(?:start|end|reset)\s+time|stay\s+up\s+(?:late|past)|night\s+shift|go\s+to\s+(?:bed|sleep)\s+after\s+(?:midnight|12)|(?:counts?|logs?|record\w*)\s+(?:it\s+)?(?:as|for|on)\s+the\s+(?:next|wrong)\s+day",X)
if __name__=="__main__":
    outs={k:open(f"cand/S2_{k}.jsonl","w") for k in F}; n=0; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        n+=1
        for k,rx in F.items():
            m=rx.search(text)
            if m:
                h[k]+=1
                outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print("habit reviews",n,h)
