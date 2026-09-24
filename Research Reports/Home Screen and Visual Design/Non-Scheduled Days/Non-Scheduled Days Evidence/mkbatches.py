"""Tiers + reading batches. idx = 0-based position in candidates.jsonl.
A  = OFF or PEN together with any other family (off-day / penalty talk)         -> read ALL
O  = OFF only (off-day words, no display/schedule words)                          -> read ALL
B  = strong weekday-schedule term within 200 chars of a display word (non-A)      -> read ALL
R  = everything else (generic 'schedule', 'frequency', 'weekdays' ...)            -> random sample 300, seed 20260924"""
import json, re, os, random
exec(open('screen.py').read().split("def recs")[0])
D = r"(?:mon|tue|tues|wed|thu|thur|thurs|fri|sat|sun)(?:day)?s?"
STRONG = re.compile(r"""
 \b(?:specific|certain|particular|selected|select|chosen|choose|specified|individual|custom|set|designated)\s+(?:week\s*)?days\b
 | \b(?:only|just)\s+(?:on\s+)?(?:"""+D+r"""|weekdays|weekends|work\s*days)\b | \b"""+D+r"""\s*(?:,|and|&|/|\+)\s*"""+D+r"""\b
 | \bdays?\s+of\s+(?:the\s+)?week\b | \bnot\s+(?:every\s*day|daily|everyday)\b | \bevery\s+other\s+day\b | \bnon[\s-]?daily\b
 | \b(?:\d|two|three|four|five|six|twice|once)\s+(?:times|days|x)\s+(?:a|per|each|every)\s+week\b | \b\d\s*x\s*(?:a|per)\s+week\b | \btimes\s+per\s+week\b | \bweekly\s+(?:goal|target|habit|frequency)s?\b
 | bestimmte[n]?\s+(?:wochen)?tage|an\s+bestimmten\s+tagen|mal\s+pro\s+woche|d[ií]as?\s+espec[ií]ficos|ciertos\s+d[ií]as|veces\s+(?:por|a\s+la)\s+semana|jours?\s+(?:sp[ée]cifiques|pr[ée]cis)|certains\s+jours|fois\s+par\s+semaine|dias\s+espec[ií]ficos|certos\s+dias|vezes\s+por\s+semana|giorni\s+specifici|alcuni\s+giorni|volte\s+a\s+settimana|belirli\s+g[üu]nler|определ[её]нн\w*\s+дн|раз\s+в\s+неделю|曜日|特定の日|週に?\d回|星期几|指定日期|特定日期|每周\d次|요일|주\s*\d회|bepaalde\s+dagen|określone\s+dni
""", re.I|re.X)
rows=[json.loads(l) for l in open('candidates.jsonl')]
def near(t):
    for m in STRONG.finditer(t):
        w=t[max(0,m.start()-200):m.end()+200]
        if F['DSP'].search(w): return True
    return False
tiers={'A':[],'O':[],'B':[],'R':[]}
for i,r in enumerate(rows):
    f=set(r['fams'])
    if ('OFF' in f or 'PEN' in f) and len(f)>1: tiers['A'].append(i)
    elif f=={'OFF'}: tiers['O'].append(i)
    elif near(r['text']): tiers['B'].append(i)
    else: tiers['R'].append(i)
random.seed(20260924); tiers['Rs']=sorted(random.sample(tiers['R'],300))
json.dump(tiers,open('tiers.json','w'))
ALL=dict(F); ALL['STR']=STRONG
def window(t):
    t=re.sub(r'\s+',' ',t)
    if len(t)<=900: return t
    spans=[]
    for rx in (F['OFF'],F['PEN'],STRONG):
        for m in rx.finditer(t): spans.append((max(0,m.start()-300),min(len(t),m.end()+300)))
    spans.sort(); merged=[]
    for a,b in spans:
        if merged and a<=merged[-1][1]: merged[-1]=(merged[-1][0],max(b,merged[-1][1]))
        else: merged.append((a,b))
    return t[:150]+' … '+' … '.join(t[a:b] for a,b in merged[:5])
os.makedirs('batches',exist_ok=True)
for tier in ('A','O','B','Rs'):
    ids=tiers[tier]
    for b in range(0,len(ids),60):
        with open(f'batches/{tier}{b//60:02d}.txt','w') as o:
            for i in ids[b:b+60]:
                r=rows[i]; o.write(f"#{i} [{r['store']}|{r['folder'][:30]}|{r['rating']}★] {window(r['text'])}\n")
import collections
print({k:len(v) for k,v in tiers.items()})
for k in ('A','O','B'):
    print(k, collections.Counter(rows[i]['store'] for i in tiers[k]))
