"""Outcomes by the free habit limit the reviewer names, combining this pass (coded.json) with the earlier free-plan
sample (../Free Plan Evidence/coded.json, codes mapped: CAP_OK→ENOUGH, CAP_COMPLAIN→NOT_ENOUGH, CAP_LEFT→LEFT,
CAP_REFUSE→REFUSE, CAP_PAID→PAID, CAP_WILLPAY→WILLPAY, CAP_SURPRISE→SURPRISE, CAP_CHANGED→CHANGED_DOWN, N<k>→CAP<k>).
Paid-app caps (PAIDAPP, DESIGN_CAP) are left out. Writes tally.txt."""
import json, os, re, collections, statistics
HERE = os.path.dirname(os.path.abspath(__file__))
M = {'CAP_OK': 'ENOUGH', 'CAP_COMPLAIN': 'NOT_ENOUGH', 'CAP_LEFT': 'LEFT', 'CAP_REFUSE': 'REFUSE', 'CAP_PAID': 'PAID',
     'CAP_WILLPAY': 'WILLPAY', 'CAP_SURPRISE': 'SURPRISE', 'CAP_CHANGED': 'CHANGED_DOWN', 'CAP_STATED': 'STATED'}
rows = []
for r in json.load(open(f'{HERE}/../Free Plan Evidence/coded.json')):
    cs = [M.get(c, c) for c in r['codes']]
    cs = [('CAP' + c[1:]) if re.match(r'^N\d+$', c) else c for c in cs]
    rows.append({**r, 'codes': cs, 'src': 'free-plan'})
for r in json.load(open(f'{HERE}/coded.json')):
    rows.append({**r, 'src': 'limit'})
OUT = ['ENOUGH', 'NOT_ENOUGH', 'LEFT', 'REFUSE', 'PAID', 'WILLPAY', 'SURPRISE', 'CHANGED_DOWN', 'STATED']
g = collections.defaultdict(list)
for r in rows:
    if 'PAIDAPP' in r['codes'] or 'DESIGN_CAP' in r['codes'] or 'PAIDAPP_CAP' in r['codes']: continue
    caps = [int(c[3:]) for c in r['codes'] if re.match(r'^CAP\d+$', c)]
    if not caps or not any(c in OUT for c in r['codes']): continue
    k = caps[0]; k = k if k <= 8 else (10 if k <= 11 else 12 if k <= 15 else 99)
    g[k].append(r)
out = ['cap | n | apps | mean★ | 1★% | enough | not enough | left | refuse | paid | will pay | surprise | lowered | '
       'enough share (enough / enough+not+left+refuse) | buy share ((paid+will pay)/n) | top apps']
for k in sorted(g):
    rs = g[k]; c = lambda x: sum(x in r['codes'] for r in rs)
    neg = c('NOT_ENOUGH') + c('LEFT') + c('REFUSE')
    apps = collections.Counter(r['app'][:18] for r in rs)
    out.append(f"{k if k < 12 else ('12-15' if k == 12 else '16+')} | {len(rs)} | {len(apps)} | {statistics.mean(r['rating'] for r in rs):.2f} | "
               f"{100*sum(r['rating'] == 1 for r in rs)/len(rs):.0f} | " + ' | '.join(str(c(x)) for x in OUT[:-1]) +
               f" | {100*c('ENOUGH')/max(1, c('ENOUGH')+neg):.0f}% | {100*(c('PAID')+c('WILLPAY'))/len(rs):.1f}% | " +
               ', '.join(f'{a} {v}' for a, v in apps.most_common(4)))
want = collections.Counter(int(c[4:]) for r in rows for c in r['codes'] if re.match(r'^WANT\d+$', c))
out += ['', 'numbers asked for (WANT, both passes): ' + ', '.join(f'{k}: {v}' for k, v in sorted(want.items()))]
cg = collections.Counter(c for r in rows if r['src'] == 'limit' for c in r['codes'] if not re.match(r'^(CAP|WANT)\d+$', c))
out += ['this pass, other codes: ' + ', '.join(f'{k} {v}' for k, v in cg.most_common())]
open(f'{HERE}/tally.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
