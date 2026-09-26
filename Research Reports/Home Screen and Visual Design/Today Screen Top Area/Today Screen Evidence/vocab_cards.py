"""Contexts for 'weekly progress' vs 'week view' wording (C1 naming)."""
import json, re, sys, random
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
P=re.compile(r'\b(?:daily|weekly|monthly|yearly|annual)\s+progress\b',re.I)
V=re.compile(r'\b(?:day|daily|week|weekly|month|monthly|year|yearly|annual)\s+views?\b',re.I)
out=open('/Users/lalith/Desktop/store reviews/Temp/today-top/cand/C_VOCAB.jsonl','w')
for store,folder,line,r,text in recs():
    if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
    for k,rx in (('P',P),('V',V)):
        m=rx.search(text)
        if m: out.write(json.dumps({"k":k,"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0),"text":text},ensure_ascii=False)+"\n")
