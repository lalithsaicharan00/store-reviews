import json, collections
exec(open('codes.py').read()); exec(open('loss_codes.py').read())
c = [json.loads(l) for l in open('candidates.jsonl')]
by = {x['key']: x for x in c}
lo = sorted([x for x in c if x['modes'] == ['LOSS']], key=lambda x: (x['app'], x['key']))
assert len(L) == len(lo) == 643 and sorted(L) == list(range(643))
LK = {lo[i]['key']: v for i, v in L.items()}
# validation
assert set(C) == {x['key'] for x in c if set(x['modes']) - {'LOSS'}}
for d in (C, LK):
    for k, v in d.items():
        assert len(v) == len(set(v)), k
        assert not ('NR' in v and len(v) > 1), k
def tab(D, title):
    cnt = collections.defaultdict(list)
    for k, v in D.items():
        for code in v: cnt[code].append(k)
    print(f"\n== {title} ({len(D)} read; on topic {sum(1 for v in D.values() if v != ['NR'])})")
    print(f"{'code':26}{'n':>5}{'apps':>6}{'mean':>6}{'1★%':>6}")
    for code, ks in sorted(cnt.items(), key=lambda x: -len(x[1])):
        r = [by[k]['rating'] for k in ks]; apps = {by[k]['app'] for k in ks}
        print(f"{code:26}{len(ks):5}{len(apps):6}{sum(r)/len(r):6.2f}{100*r.count(1)/len(r):6.0f}")
    return cnt
m = tab(C, 'main set'); l = tab(LK, 'loss stories')
json.dump({'main': C, 'loss': LK}, open('coded.json', 'w'), indent=0)
# cross-tabs for loss
loss = {k: v for k, v in LK.items() if any(x.startswith('L_') for x in v)}
print('\nloss stories with a cause:', len(loss))
free = {k: v for k, v in loss.items() if 'X_PAID' not in v}
offphone = {'L_CRASH_REINSTALL', 'L_DELETE', 'L_NEWPHONE'}
for name, grp in [('all', loss), ('no paid mention', free)]:
    n = len(grp); op = sum(1 for v in grp.values() if offphone & set(v)); bug = sum(1 for v in grp.values() if 'L_APP_BUG' in v)
    left = sum(1 for v in grp.values() if 'O_LEFT' in v); dem = sum(1 for v in grp.values() if 'O_DEMOTIVATED' in v)
    r = [by[k]['rating'] for k in grp]
    print(f"{name}: n={n} mean={sum(r)/n:.2f} 1★={100*r.count(1)/n:.0f}% offphone-preventable={op} ({100*op/n:.0f}%) app-bug={bug} ({100*bug/n:.0f}%) left={left} ({100*left/n:.0f}%) demotivated={dem}")
for cause in ['L_APP_BUG', 'L_CRASH_REINSTALL', 'L_NEWPHONE', 'L_DELETE', 'L_ACCOUNT', 'L_OTHER']:
    g = [k for k, v in loss.items() if cause in v]; r = [by[k]['rating'] for k in g]
    print(f"{cause:20} n={len(g):4} mean={sum(r)/len(g):.2f} 1★={100*r.count(1)/len(g):.0f}% left={sum(1 for k in g if 'O_LEFT' in loss[k])} paid={sum(1 for k in g if 'X_PAID' in loss[k])}")
