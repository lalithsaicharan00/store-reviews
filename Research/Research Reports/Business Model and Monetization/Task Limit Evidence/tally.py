"""Tally the hand-coded task-limit classification (cls/batch-*.txt) against the candidate texts.
Writes coded.json (every coded review with its codes and metadata) and tally.txt."""
import json, re, glob, os, collections, statistics
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
C = {json.loads(l)['key']: json.loads(l) for l in open(f'{ROOT}/Temp/task-limit/candidates.jsonl')}
keep = set(json.load(open(f'{ROOT}/Temp/task-limit/keep.json')))
VOCAB = set('TW_HABIT HCAP TCAP SHARED TODO_PAID RECUR_PAID TASKFEAT_PAID NEG OK PAID LEFT WANT_MORE BAIT TASK_FREE_PRAISE ALLINONE TODO_DEMAND HABIT_FOR_TODO WORKAROUND TASK_NO_STATS FREE_ELSEWHERE NO_PAY_FOR_LIST PAIDAPP RECUR_AS_HABIT RECUR_FREE_PRAISE'.split())
coded = {}
for f in sorted(glob.glob(f'{HERE}/cls/batch-*.txt')):
    for l in open(f):
        if not l.strip(): continue
        k, *codes = l.split()
        for c in codes:
            assert c in VOCAB or re.fullmatch(r'N\d+', c), (k, c)
        assert k in keep and k not in coded, k
        coded[k] = codes
out = []
def P(*a): out.append(' '.join(str(x) for x in a))
def stats(keys, label):
    keys = list(keys)
    if not keys: P(f'{label:48} n=0'); return
    r = [C[k]['rating'] for k in keys]; apps = collections.Counter(C[k]['app'] for k in keys)
    cs = collections.Counter(c for k in keys for c in coded[k])
    P(f"{label:48} n={len(keys):4} apps={len(apps):3} mean={statistics.mean(r):.2f} 1★={100*sum(x==1 for x in r)/len(r):4.0f}% "
      f"NEG={cs['NEG']} OK={cs['OK']} PAID={cs['PAID']} LEFT={cs['LEFT']} BAIT={cs['BAIT']} WANT_MORE={cs['WANT_MORE']} FREE_ELSEWHERE={cs['FREE_ELSEWHERE']}")
    P('    top apps: ' + ', '.join(f'{a[:26]} {v}' for a, v in apps.most_common(6)))
has = lambda k, *c: all(x in coded[k] for x in c)
P(f'read {len(keep)} candidates; on topic {len(coded)}; OFF {len(keep)-len(coded)}')
P('\n== code counts =='); cc = collections.Counter(c for v in coded.values() for c in v if not c.startswith('N'))
for c, n in cc.most_common(): P(f'{c:18} {n}')
free_hcap = [k for k in coded if has(k, 'HCAP') and 'PAIDAPP' not in coded[k]]
P('\n== 1. vocabulary: habit caps described as tasks ==')
stats(free_hcap, 'free-tier habit caps (HCAP, not PAIDAPP)')
tw = [k for k in free_hcap if 'TW_HABIT' in coded[k]]
P(f'  of which said in task / to-do / reminder words: {len(tw)} ({100*len(tw)/len(free_hcap):.0f}%)')
pa = [k for k in coded if 'PAIDAPP' in coded[k]]
P(f'  paid-app (Streaks) task=habit caps: {len(pa)}, TW_HABIT {sum("TW_HABIT" in coded[k] for k in pa)}')
P('\n== 2. caps ==')
stats([k for k in coded if 'TCAP' in coded[k]], 'TCAP real one-off task cap')
stats([k for k in coded if 'SHARED' in coded[k]], 'SHARED one cap on habits+tasks')
stats(free_hcap, 'HCAP habit-only cap (free tier)')
for lo, hi, lab in [(1, 3, 'N1-3'), (4, 6, 'N4-6'), (7, 10, 'N7-10'), (11, 999, 'N11+')]:
    ks = [k for k in coded if 'SHARED' in coded[k] and any(re.fullmatch(r'N(\d+)', c) and lo <= int(c[1:]) <= hi for c in coded[k])]
    stats(ks, f'  SHARED {lab}')
P('\n== 3. what is paid ==')
for c in ['RECUR_PAID', 'TODO_PAID', 'TASKFEAT_PAID']:
    stats([k for k in coded if c in coded[k]], c)
P('\n== 4. praise, demand, use ==')
for c in ['TASK_FREE_PRAISE', 'RECUR_FREE_PRAISE', 'ALLINONE', 'TODO_DEMAND', 'HABIT_FOR_TODO', 'RECUR_AS_HABIT', 'WORKAROUND', 'TASK_NO_STATS', 'FREE_ELSEWHERE', 'NO_PAY_FOR_LIST']:
    stats([k for k in coded if c in coded[k]], c)
P('\n== 5. per-app breakdown for key apps ==')
for app_re in ['^4\\. Me\\+', 'HabitNow', 'Tappsk', 'Rabit - Habit Tracke', 'Hizo', '^12\\. Fabulous', 'Productive', 'Do Habits', '^126\\. To Do List', '84\\. Tasks', 'Grit', 'Eden']:
    ks = [k for k in coded if re.search(app_re, C[k]['app'])]
    P(f'-- {app_re}')
    stats(ks, '  all coded')
    for c in ['SHARED', 'TCAP', 'RECUR_PAID', 'TODO_PAID', 'TASK_FREE_PRAISE', 'ALLINONE', 'PAID']:
        sub = [k for k in ks if c in coded[k]]
        if sub: stats(sub, f'  {c}')
P('\n== 6. ALLINONE and PAID together ==')
ai = [k for k in coded if 'ALLINONE' in coded[k]]
P(f'ALLINONE {len(ai)}; with PAID {sum("PAID" in coded[k] for k in ai)}')
json.dump({k: {'codes': v, 'app': C[k]['app'], 'rating': C[k]['rating'], 'date': C[k]['date'], 'loc': C[k]['loc'], 'review_id': C[k]['review_id']} for k, v in coded.items()},
          open(f'{HERE}/coded.json', 'w'), ensure_ascii=False, indent=0)
open(f'{HERE}/tally.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
