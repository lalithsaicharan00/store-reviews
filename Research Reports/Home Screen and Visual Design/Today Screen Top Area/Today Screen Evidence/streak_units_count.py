"""Count how reviewers phrase streak lengths: N-day vs N-week / N-month / N-year (habit apps)."""
import re, sys, json, collections
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
NUM=r'(?:\d[\d,]*|one|two|three|four|five|six|seven|eight|nine|ten|a|an)'
RX={u:re.compile(rf'\b{NUM}\s*[- ]?\+?\s*{u}s?[- ](?:long\s+)?streak\b|\bstreak\s+of\s+{NUM}\s+{u}s?\b',re.I) for u in ['day','week','month','year']}
BIG=re.compile(r'\b(\d[\d,]*)\s*[- ]?days?[- ]streak\b|\bstreak\s+of\s+(\d[\d,]*)\s+days\b',re.I)
c=collections.Counter(); big=collections.Counter(); fin=collections.Counter()
for store,folder,line,r,text in recs():
    if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
    for u,rx in RX.items():
        if rx.search(text): c[u]+=1; fin[(u,folder.startswith('10.') and store=='app')]+=1
    for m in BIG.finditer(text):
        n=int((m.group(1) or m.group(2)).replace(',',''))
        big['>=365' if n>=365 else '>=100' if n>=100 else '>=30' if n>=30 else '<30']+=1
print(dict(c)); print(dict(big)); print({f'{k[0]}|finch={k[1]}':v for k,v in fin.items()})
json.dump({'units':c,'day_sizes':big},open('streak_units_count.json','w'))
