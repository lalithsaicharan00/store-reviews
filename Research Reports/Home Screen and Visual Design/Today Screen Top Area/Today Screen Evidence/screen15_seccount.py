"""Section counts: do people want done/total per part of day, remaining-only, or no count?"""
import json, re, sys
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
ITEM=r'(?:habits?|tasks?|things|items?|goals?|routines?|to-?dos?|dailies)'
PART=r'(?:morning|afternoon|evening|night|section|routine|time\s+of\s+day|category|group)'
F={}
F["LEFT"]=re.compile(rf"""\bhow\s+many\s+{ITEM}\s+(?:are\s+|i\s+have\s+)?(?:left|remaining|to\s+go|still\s+to\s+do)\b|\b(?:number|count)\s+of\s+(?:remaining|uncompleted|incomplete|unfinished|pending)\s+{ITEM}\b|\b{ITEM}\s+(?:left|remaining)\s+(?:for\s+)?(?:today|the\s+day)\b""",X)
F["XOFY"]=re.compile(rf"""\b\d+\s*(?:/|of|out\s+of)\s*\d+\s+{ITEM}\b|\b(?:completed|done|finished)\s+\d+\s*(?:/|of|out\s+of)\s*\d+\b""",X)
F["SECPROG"]=re.compile(rf"""\b(?:progress|percentage|count|counter|number|ring|bar)\b[^.!?]{{0,30}}\b(?:for|of|per|in)\s+(?:each|every|the)\s+{PART}\b|\b{PART}\s+(?:progress|completion|percentage|count)\b""",X)
F["COUNTNOISE"]=re.compile(rf"""\b(?:numbers?|counts?|counters?|percentages?|fractions?|stats)\b[^.!?]{{0,40}}\b(?:clutter\w*|distract\w*|stress\w*|overwhelm\w*|anxious|pressure|unnecessary|don'?t\s+need|pointless|hide|remove|turn\s+off)\b""",X)
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Temp/today-top/cand/SC_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:70],"text":text},ensure_ascii=False)+"\n")
    print(h)
