import json, re, collections
C=[json.loads(l) for l in open("mix_cand.jsonl")]
S = {
 "ORD": re.compile(r"re-?order|re-?arrang|\bsort(ed|ing|s)?\b(?!\s+of)|drag|\b(the|in|own|an?|custom|same|that)\s+order\b|order\s+(of|them|it|my)|\bordenar|\bordem\b|\borden\b|at\s+the\s+(top|bottom)|on\s+top|to\s+the\s+(top|bottom)|(above|below)\s+(the\s+|my\s+)?(habits?|tasks?|to-?dos?)|(habits?|tasks?|to-?dos?)\s+(above|below|first)", re.I),
 "SEP": re.compile(r"separat\w*|\bmix\w*|mixed\s+(in|up|together)|\btogether\b|same\s+(list|screen|page|view|place|section)|clutter\w*|\bbur(y|ied)\b|push\w*\s+(down|up)|distinguish|differentiat|tell\s+(them\s+|the\s+two\s+)?apart|\bsplit\b|(own|different|separate)\s+(list|section|tab|page|screen|category)|in\s+one\s+(place|list|screen|view)|one\s+list|single\s+list|combin\w*|merg\w*|integrat\w*|separad|junt|mezcl|misturad", re.I),
}
cnt=collections.Counter()
for c in C:
    c["s"]=[k for k,p in S.items() if p.search(c["text"])]
    for k in c["s"]: cnt[(c["tier"],k)]+=1
    cnt[(c["tier"], "any" if c["s"] else "none")]+=1
print(sorted(cnt.items()))
json.dump([c for c in C if c["s"]], open("mix_strong.json","w"), ensure_ascii=False)
