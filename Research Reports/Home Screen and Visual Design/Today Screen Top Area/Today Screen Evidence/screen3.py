"""Third screen (habit apps only) for Q2 progress display and Q3 day navigation wording missed by screen.py."""
import json, re
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
F["RINGNUM"]=re.compile(r"\b(?:ring|rings|circle|circles|donut|pie|wheel)\b[^.!?]{0,70}\b(?:number|numbers|percent\w*|%|count|fraction|digits?)\b|\b(?:number|numbers|percent\w*|%|count|fraction)\b[^.!?]{0,70}\b(?:ring|rings|circle|circles|donut|pie chart|wheel)\b",X)
F["PCTDAY"]=re.compile(r"(?:percentage|percent|%)\s+(?:of\s+)?(?:(?:my|the|your|all|today.?s)\s+)?(?:habits|tasks|goals)\s+(?:completed|done|complete)|(?:completion|success|progress)\s+(?:percentage|rate|%)\s+(?:for|of)\s+(?:the|each|today|every)\s+day|(?:day|daily|today).{0,20}\b\d{1,3}\s?%",X)
F["LEFT"]=re.compile(r"how\s+many\s+(?:habits?|tasks?|things|goals?|items?)\s+(?:i\s+have\s+)?(?:left|remaining|to\s+go|i\s+(?:have\s+)?(?:done|completed|finished))|what.?s\s+left\s+(?:to\s+do|for\s+(?:the|to)day)|(?:left|remaining)\s+(?:for|to\s+do)\s+today|\bx\s*/\s*y\b|\b\d+\s+(?:of|/|out\s+of)\s+\d+\s+(?:habits|tasks|goals)\s+(?:done|completed|complete)",X)
F["DAYNAV"]=re.compile(r"(?:check|mark|log|tick|fill|enter|record|complete|update|edit)\w*\s+(?:\w+\s+){0,4}(?:for\s+|on\s+)?yesterday|(?:go|going|swipe|scroll|navigate|jump|move|get)\s+back\s+(?:\w+\s+){0,3}(?:day|days|week|weeks|date|dates|yesterday)|(?:previous|past|prior|earlier)\s+(?:day|days|dates|weeks)|(?:tomorrow|next\s+week|future\s+days?|upcoming\s+days?)",X)
if __name__=="__main__":
    outs={k:open(f"cand/S3_{k}.jsonl","w") for k in F}; n=0; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        n+=1
        for k,rx in F.items():
            m=rx.search(text)
            if m:
                h[k]+=1
                outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print("habit reviews",n,h)
