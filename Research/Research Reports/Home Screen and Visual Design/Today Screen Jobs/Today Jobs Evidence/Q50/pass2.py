import re, json, collections
from scan import load
noise = re.compile(r"\bfill(s|ed|ing)? (out|in (the|a|my|your|all|those|these|every|each|data|forms?|info|details|survey|questionnaire|gaps?|blanks?))|\bfill(ing)? (up )?(the|a|my) (gap|void|time|form|survey|questionnaire|journal|diary|blank)|\bfull[- ]?fill|\bfilled with (ads|bugs|errors|junk)|\bpre-?fill|\bauto-?fill", re.I)
P = {
 'fill': re.compile(r"\b(fill(s|ed|ing)?( up| in)?|colou?r(s|ed|ing)? in|colou?r(s)? (fills?|up)|light(s)? up)\b", re.I),
 'bar': re.compile(r"\bprogress[- ]?(bars?|lines?|indicators?)\b|\bbars? (fill|grow|go|turn)|barra de progres|fortschrittsbalken|barre de progression|barra di avanzamento|barra de progresso", re.I),
 'ring': re.compile(r"\b(rings?|circles?) (fill|clos|complet)|\bclose (the|my|your) rings?\b|\bprogress (rings?|circles?)\b", re.I),
 'visual': re.compile(r"\b(visual(ly)? (progress|representation|feedback|indicator|cue)|see (my|the|your) progress (at a glance|visually)|visuali[sz]e (my|the|your) progress)\b", re.I),
 'turn': re.compile(r"\b(turns?|goes|go|changes?|change|turning|turned) (to )?(green|colou?red|colou?r|gold|blue|full|grey|gray)\b", re.I),
 'shade': re.compile(r"\b(tint|tinted|shaded|shade|background colou?r)\b", re.I),
}
ctx = re.compile(r"\b(habit|task|row|list|bar|progress|goal|complete|done|check|tick|colou?r|tile|card|button|circle|ring|counter)", re.I)
hits = collections.defaultdict(set); recs = {}
for r in load():
    t = r['text']
    if len(t) < 15: continue
    for k, p in P.items():
        m = p.search(t)
        if m and ctx.search(t):
            # noise guard only for 'fill'
            if k == 'fill' and noise.search(t) and len(P['fill'].findall(t)) <= len(noise.findall(t)):
                continue
            hits[k].add(r['id']); recs[r['id']] = r
for k,v in hits.items(): print(k, len(v))
print('union', len(recs))
apps = collections.Counter(r['app'] for r in recs.values())
print(apps.most_common(25))
out = sorted(recs.values(), key=lambda r:(r['app'], r['id']))
for r in out: r['keys'] = [k for k in hits if r['id'] in hits[k]]
json.dump(out, open('pass2.json','w'))
