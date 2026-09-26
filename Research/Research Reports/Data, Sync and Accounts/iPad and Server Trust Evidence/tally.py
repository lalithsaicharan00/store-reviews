"""Tally the hand-coded sample: per code n (habit stores A+P / native N), apps, mean rating, 1★ share; precision per drawn mode."""
import json, collections
rows = json.load(open('coded.json'))
drawn = {s['key']: s['drawn'] for s in json.load(open('read/sample-index.json'))}
by = collections.defaultdict(list)
for r in rows:
    for c in r['codes']:
        if c != 'NR': by[c].append(r)
out = []
out.append(f"{'code':22}{'AP':>5}{'A':>5}{'P':>5}{'N':>4}{'apps':>5}{'mean':>6}{'1★%':>6}")
for c in sorted(by, key=lambda c: -len(by[c])):
    v = by[c]; ap = [r for r in v if r['store'] in 'AP']
    if not ap: continue
    out.append(f"{c:22}{len(ap):5}{sum(r['store']=='A' for r in v):5}{sum(r['store']=='P' for r in v):5}{sum(r['store']=='N' for r in v):4}"
               f"{len({r['app'] for r in ap}):5}{sum(r['rating'] for r in ap)/len(ap):6.2f}{100*sum(r['rating']==1 for r in ap)/len(ap):6.1f}")
out.append('\nprecision by drawn mode (habit stores): relevant / read')
pm = collections.defaultdict(lambda: [0, 0])
for r in rows:
    if r['store'] not in 'AP': continue
    m = drawn[r['key']]; pm[m][1] += 1; pm[m][0] += r['codes'] != ['NR']
for m, (a, b) in sorted(pm.items()): out.append(f"  {m:18}{a:5}/{b:<5}{100*a/b:5.0f}%")
open('tally.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
