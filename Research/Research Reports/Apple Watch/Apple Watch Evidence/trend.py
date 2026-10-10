import json, collections
exec(open('codes.py').read())
d = json.load(open('watch_app.json'))
yr = collections.defaultdict(collections.Counter)
for i,c in CODES.items():
    y = d[i]['date'][:4]
    yr[y]['all'] += 1
    for k in 'WPSBC': 
        if k in c: yr[y][k]+=1
for y in sorted(yr): print(y, dict(yr[y]))
# apps that have a watch app: any P/B/S/C/X/U
has = collections.defaultdict(collections.Counter)
for i,c in CODES.items():
    a = d[i]['app']
    if c in ('N','H'): continue
    has[a]['n']+=1
    if 'P' in c: has[a]['P']+=1
    if set(c)&set('BSXUDZYJQ'): has[a]['prob']+=1
    if 'W' in c: has[a]['W']+=1
print()
for a,c in sorted(has.items(), key=lambda x:-x[1]['n'])[:25]:
    print(f"{a[:30]:30} n={c['n']:4} P={c['P']:4} prob={c['prob']:4} W={c['W']:4}")
