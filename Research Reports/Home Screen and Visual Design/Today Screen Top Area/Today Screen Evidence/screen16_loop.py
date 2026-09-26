"""Loop (Play 3) main-screen table: cell content, columns, streaks, strength %, names/density, bad habits."""
import json, re, collections
F={
 "CELLNUM":r"\b(?:numbers?|numeric|values?|measurable|quantit\w*|amounts?|counts?)\b[^.!?]{0,50}\b(?:main\s+(?:screen|page)|home\s+(?:screen|page)|list|cells?|columns?|boxes?|grid|table|instead\s+of\s+(?:a\s+)?(?:tick|check))\b|\b(?:shows?|display\w*)\s+(?:the\s+)?(?:number|value|amount)\b",
 "TICKX":r"\b(?:ticks?|check\s*marks?|checkmarks?|crosses|x\s*marks?|x's)\b[^.!?]{0,50}\b(?:confus\w*|unclear|hard\s+to|can'?t\s+tell|difference|mean|grey|gray|colou?r)\b",
 "COLUMNS":r"\b(?:last\s+)?(?:\d|five|seven|5|7)\s+days\b[^.!?]{0,40}\b(?:main\s+(?:screen|page)|home|shown|visible|columns?|see)\b|\b(?:more|fewer|less)\s+(?:days|columns)\b|\bscroll\w*\s+(?:back|left|right|horizontal\w*)\b[^.!?]{0,30}\bdays?\b",
 "STREAK":r"\bstreaks?\b",
 "STRENGTH":r"\b(?:strength|score|percentage|percent|%|circle|ring)\b[^.!?]{0,40}\b(?:confus\w*|understand|mean\w*|unclear|misleading|weird|why|how\s+is|calculat\w*)\b",
 "DENSITY":r"\b(?:names?|titles?|text|font)\b[^.!?]{0,30}\b(?:cut\s+off|truncat\w*|too\s+(?:small|long)|don'?t\s+fit|shortened|dots)\b|\b(?:compact|dense|cramped|clean|minimal\w*)\b[^.!?]{0,30}\b(?:layout|design|ui|interface|screen|list|table)\b",
 "BADHABIT":r"\b(?:bad|negative|quit\w*|break\w*)\s+habits?\b",
}
R={k:re.compile(v,re.I) for k,v in F.items()};h=collections.Counter();out={k:[] for k in F}
for i,l in enumerate(open('/Users/lalith/Desktop/store reviews/Play Store Reviews/3. Loop Habit Tracker/reviews.jsonl')):
    if not l.strip(): continue
    r=json.loads(l);t=(r.get('title') or '')+' '+(r.get('body') or r.get('text') or r.get('content') or '')
    for k,rx in R.items():
        m=rx.search(t)
        if m: h[k]+=1; out[k].append({'id':f'P3#{i}','rating':r.get('rating') or r.get('score'),'m':m.group(0)[:60],'text':t})
json.dump(out,open('loop_screen.json','w'),ensure_ascii=False); print(dict(h))
