import json,re
H=json.load(open('hits.json'))
skip=re.compile(r'^(84\. Tasks|126\. To Do|97\. To-do|111\. My Study|100\. To Do|121\. Bordio|117\. Tiimo|10\. Finch|122\. Hevy|131\. Skincare|127\. Habit — Online)')
C=r"colou?r(?:s|ed|ing)?\b"
S=re.compile(rf"{C}.{{0,80}}\b(light|lighter|faded|fade|pale|dull|darker|darken\w*|deeper|shades?|tint\w*|opacity|transparen\w*|contrast|hard to (see|read|tell)|can.?t (see|read|tell)|invisible|visible|legib\w*|readab\w*|wash\w* out)\b|\b(light|lighter|faded|fade|pale|dull|darker|darken\w*|deeper|shades?|tint\w*|opacity|transparen\w*|contrast|hard to (see|read|tell)|can.?t (see|read|tell)|invisible|legib\w*|readab\w*|wash\w* out)\b.{{0,80}}{C}",re.I)
P=re.compile(rf"\b(each|every|different|own|individual|separate|unique|various|assign\w*)\s+(\w+\s+){{0,2}}{C}|{C}\s+(for|per|to|of)\s+(each|every|different|individual|all)?\s*(my\s+)?(habit|task|goal|tracker|counter|streak|card|row|categor|item|activit)|{C}[- ]?cod\w*|(habits?|tasks?|goals?|trackers?|counters?)\s+(in|with|by)\s+(different\s+)?{C}|(habit|task|goal|tracker)\s+{C}",re.I)
U=re.compile(rf"\b(same|one|single|uniform|plain|white|neutral|gr[ae]y|monochrom\w*|minimal\w*|less|fewer|without|too many|too much|no)\s+(\w+\s+){{0,2}}{C}|{C}\s+(\w+\s+){{0,2}}(overload|overwhelm\w*|distract\w*|busy|chaotic|clash\w*|garish|loud|too much)|too\s+colou?rful|\bless\s+colou?rful|black and white",re.I)
out={'S':[],'P':[],'U':[]}
seen=set()
for h in H:
    if skip.match(h['app']): continue
    t=re.sub(r'\s+',' ',h['text'])
    if not re.search(C,t,re.I): continue
    k=t.lower()[:160]
    if k in seen: continue
    seen.add(k)
    for name,rx in [('S',S),('P',P),('U',U)]:
        if rx.search(t): out[name].append({**h,'text':t})
for k,v in out.items():
    json.dump(v,open(f'set{k}.json','w'),ensure_ascii=False)
    with open(f'set{k}.tsv','w') as f:
        for r in v:
            t=r['text']
            if len(t)>600:
                ms=[m.start() for m in re.finditer(C,t,re.I)]
                a=max(0,ms[0]-250); t=('…' if a else '')+t[a:a+600]+'…'
            f.write(f"{r['id']}\t{r['rating']}\t{t}\n")
    print(k,len(v))
allids=set(r['id'] for v in out.values() for r in v); print('union',len(allids))
