"""Round-2: count user vocabulary across the corpus (habit apps vs native to-do/calendar apps)."""
import re, json, collections
from screen import recs
from common import NONHABIT_PLAY
P={
 'hide completed':r'\bhide\s+(?:the\s+|all\s+)?completed\b','hide done':r'\bhide\s+(?:the\s+)?done\b','hide finished':r'\bhide\s+(?:the\s+)?finished\b','hide checked':r'\bhide\s+(?:the\s+)?checked\b',
 'show completed':r'\bshow\s+(?:the\s+|all\s+)?completed\b',
 'filter by':r'\bfilter(?:ing)?\s+(?:\w+\s+)?by\b','sort by':r'\bsort(?:ing)?\s+(?:\w+\s+)?by\b','group by':r'\bgroup(?:ing)?\s+(?:\w+\s+)?by\b','view by':r'\bview\s+(?:\w+\s+)?by\b',
 'categories':r'\bcategor(?:y|ies)\b','tags':r'\btags?\b','groups':r'\bgroups?\b','areas':r'\b(?:life\s+)?areas?\b','folders':r'\bfolders?\b','lists':r'\blists\b',
 'time of day':r'\btimes?\s+of\s+(?:the\s+)?day\b','sections':r'\bsections?\b','parts of the day':r'\bparts?\s+of\s+(?:the|my)\s+day\b','morning/evening routine':r'\b(?:morning|evening|night)\s+routines?\b',
 'this week':r'\bthis\s+week\b','last 7 days':r'\b(?:last|past|previous)\s+(?:7|seven)\s+days\b',
 "what's left":r"\bwhat(?:'|’)?s\s+left\b|\bwhat\s+is\s+left\b",'due today':r'\bdue\s+today\b','due now':r'\bdue\s+now\b',
 'filter':r'\bfilters?\b','default view':r'\bdefault\s+(?:view|screen|tab|page)\b',
}
R={k:re.compile(v,re.I) for k,v in P.items()}
cnt={'habit':collections.Counter(),'native':collections.Counter()};tot=collections.Counter()
for store,folder,line,r,text in recs():
    if store=='play' and folder.startswith(NONHABIT_PLAY): ctx='native'
    elif store=='native': ctx='native'
    else: ctx='habit'
    tot[ctx]+=1
    for k,rx in R.items():
        if rx.search(text): cnt[ctx][k]+=1
json.dump({'tot':tot,'cnt':cnt},open('vocab_counts.json','w'),indent=1)
for k in P: print(f"{k:24} habit={cnt['habit'][k]:6} todo/native={cnt['native'][k]:6}")
print(tot)
