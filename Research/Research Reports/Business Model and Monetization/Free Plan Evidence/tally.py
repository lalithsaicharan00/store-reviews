"""Tally the hand-coded free-plan sample: per code, and cap outcomes by the cap size the reviewer reports."""
import json, os, collections, statistics, re
HERE = os.path.dirname(os.path.abspath(__file__))
C = {c['key']: c for c in (json.loads(l) for l in open(os.path.join(HERE, '../../../Temp/free-plan/candidates.jsonl'), encoding='utf-8'))}
rows = [r for r in json.load(open(f'{HERE}/coded.json')) if r['codes'] != ['NR']]
payer = lambda r: 'X_PAYER' in r['codes'] or C[r['key']]['paid']
out = [f'on-topic coded reviews: {len(rows)} of {len(json.load(open(f"{HERE}/coded.json")))} read', '',
       f"{'code':22}{'n':>5}{'apps':>6}{'mean':>6}{'1star':>7}{'payers':>7}"]
by = collections.defaultdict(list)
for r in rows:
    for c in r['codes']:
        if not re.match(r'^(N|WANT)\d+$', c): by[c].append(r)
for c, rs in sorted(by.items(), key=lambda x: -len(x[1])):
    out.append(f"{c:22}{len(rs):5}{len({r['app'] for r in rs}):6}{statistics.mean(r['rating'] for r in rs):6.2f}"
               f"{100*sum(r['rating'] == 1 for r in rs)/len(rs):6.0f}%{sum(map(payer, rs)):7}")
# cap outcomes by reported cap
cap = [r for r in rows if any(c.startswith('CAP_') for c in r['codes'])]
def bucket(r):
    ns = [int(c[1:]) for c in r['codes'] if re.match(r'^N\d+$', c)]
    if not ns: return None
    n = ns[0]
    return '1' if n == 1 else '2' if n == 2 else '3' if n == 3 else '4' if n == 4 else '5' if n == 5 else '6-8' if n <= 8 else '10+'
out += ['', 'cap reviews by the free cap the reviewer names (a review can carry several outcomes)',
        f"{'cap':6}{'n':>5}{'mean':>6}{'1star':>7}{'complain':>9}{'ok':>5}{'left':>6}{'refuse':>7}{'paid':>6}{'willpay':>8}{'surprise':>9}{'cant-eval':>10}"]
g = collections.defaultdict(list)
for r in cap:
    b = bucket(r)
    if b: g[b].append(r)
for b in ['1', '2', '3', '4', '5', '6-8', '10+']:
    rs = g[b]
    if not rs: continue
    k = lambda code: sum(code in r['codes'] for r in rs)
    out.append(f"{b:6}{len(rs):5}{statistics.mean(r['rating'] for r in rs):6.2f}{100*sum(r['rating'] == 1 for r in rs)/len(rs):6.0f}%"
               f"{k('CAP_COMPLAIN'):9}{k('CAP_OK'):5}{k('CAP_LEFT'):6}{k('CAP_REFUSE'):7}{k('CAP_PAID'):6}{k('CAP_WILLPAY'):8}{k('CAP_SURPRISE'):9}{k('CANT_EVALUATE'):10}")
want = collections.Counter(int(c[4:]) for r in rows for c in r['codes'] if re.match(r'^WANT\d+$', c))
out += ['', 'numbers reviewers ask for (WANT): ' + ', '.join(f'{k}: {v}' for k, v in sorted(want.items()))]
cc = by['CAP_COMPLAIN']
out += [f"cap complainers who say they paid: {sum(map(payer, cc))} of {len(cc)}",
        f"cap reviews (any CAP_) by payers: {sum(map(payer, cap))} of {len(cap)}"]
open(f'{HERE}/tally.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
