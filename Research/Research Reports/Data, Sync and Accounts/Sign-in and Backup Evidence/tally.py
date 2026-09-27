"""Tally the hand-coded sample: per code n (A App Store / P Play), apps, mean rating, 1★ share, payer share."""
import json, collections, os
HERE = os.path.dirname(os.path.abspath(__file__))
rows = json.load(open(f'{HERE}/coded.json'))
drawn = {s['key']: s['drawn'] for s in json.load(open(f'{HERE}/sample-index.json'))}
by = collections.defaultdict(list)
for r in rows:
    for c in r['codes']:
        if c != 'NR': by[c].append(r)
out = [f"{'code':22}{'n':>5}{'A':>5}{'P':>5}{'apps':>5}{'mean':>6}{'1★%':>6}{'payer':>6}"]
for c in sorted(by, key=lambda c: -len(by[c])):
    v = by[c]
    out.append(f"{c:22}{len(v):5}{sum(r['store']=='A' for r in v):5}{sum(r['store']=='P' for r in v):5}{len({r['app'] for r in v}):5}"
               f"{sum(r['rating'] for r in v)/len(v):6.2f}{100*sum(r['rating']==1 for r in v)/len(v):6.1f}{sum('X_PAYER' in r['codes'] for r in v):6}")
out.append('\nprecision by drawn mode: relevant / read')
pm = collections.defaultdict(lambda: [0, 0])
for r in rows:
    m = drawn[r['key']]; pm[m][1] += 1; pm[m][0] += r['codes'] != ['NR']
for m, (a, b) in sorted(pm.items()): out.append(f"  {m:18}{a:5}/{b:<5}{100*a/b:5.0f}%")
open(f'{HERE}/tally.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
