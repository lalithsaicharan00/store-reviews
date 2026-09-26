"""How reviewers name the quit-habit category (section name candidates)."""
import re, sys, json, collections
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Research/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
W={'bad habits':r'\bbad\s+habits?\b','breaking habits':r'\bbreak(?:ing)?\s+(?:bad\s+)?habits?\b','quitting':r'\bquitting\b','quit habits':r'\bquit\s+habits?\b','habits to quit':r'\bhabits?\s+(?:to|i\s+want\s+to)\s+quit\b','negative habits':r'\bnegative\s+habits?\b','cutting back/down':r'\bcut(?:ting)?\s+(?:back|down)\b','limit':r'\blimit(?:ing)?\s+(?:my\s+)?(?:intake|drinks?|coffee|sugar|screen|habits?)\b','sober':r'\bsobriety\b|\bsober\b','abstain':r'\babstain\w*|\babstinence\b'}
R={k:re.compile(v,re.I) for k,v in W.items()};c=collections.Counter()
for store,folder,line,r,text in recs():
    if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
    for k,rx in R.items():
        if rx.search(text): c[k]+=1
print(c.most_common()); json.dump(c,open('quit_words.json','w'))
