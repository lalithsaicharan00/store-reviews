"""Quit round 2: live ticking counters, start/reset dates, and quit-habit types (abstain / reduce / log each / chores)."""
import json, re, sys
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
QUITCTX=re.compile(r'\b(?:quit\w*|sober\w*|sobriety|relaps\w*|addict\w*|bad\s+habits?|smok\w*|vap\w*|alcohol|drink\w*|porn|nofap|nicotine|days\s+since|abstain\w*|abstinence|clean|vice|counter|reset\w*)\b',re.I)
F={}
F["LIVE"]=re.compile(r"""\b(?:seconds?|live|real[- ]?time|tick(?:ing|s)?\s*(?:up|by|away)?|count(?:ing|s)?\s+up|stopwatch|to\s+the\s+(?:second|minute)|minute\s+by\s+minute|hours?,?\s+minutes?(?:,?\s+(?:and\s+)?seconds?)?)\b""",X)
F["DATES"]=re.compile(r"""\b(?:start(?:ing)?|quit|reset|sober|clean|last)\s+date\b|\bdate\s+(?:i|you)\s+(?:quit|started|stopped|last)\b|\bsince\s+(?:the\s+)?date\b|\b(?:back[- ]?date|backdat\w+|edit\w*\s+the\s+(?:start|date))\b""",X)
F["REDUCE"]=re.compile(r"""\b(?:cut(?:ting)?\s+(?:back|down)|reduc(?:e|ing|tion)|moderat(?:e|ion|ing)|limit(?:s|ing)?\s+(?:my|the|to|how)|less\s+than\s+\d|no\s+more\s+than|fewer\s+than|at\s+most\s+\d|allowance|harm\s+reduction|drink\s+less|smoke\s+less)\b""",X)
F["LOGEACH"]=re.compile(r"""\b(?:log|track|count|record|tally|mark)\w*\s+(?:each|every)\s+(?:time|cigarette|drink|slip|relapse|urge|craving|occurrence|instance)\b|\bhow\s+(?:many|often)\s+(?:times\s+)?i\s+(?:smoke|drink|relapse|slip|do\s+it|did\s+it)\b|\bcount\s+(?:how\s+many|the\s+number)\b""",X)
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Temp/today-top/cand/Q2_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        if not QUITCTX.search(text): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:70],"text":text},ensure_ascii=False)+"\n")
    print(h)
