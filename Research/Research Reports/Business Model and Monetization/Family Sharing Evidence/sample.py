"""Draw the reading set. Core family modes: every App Store + Play match, all six modes.
Household and profile modes: a sample capped per app. Native apps: a few per mode for contrast."""
import json, random, collections, os
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../..'))
TMP = os.path.join(ROOT, 'Temp', 'backlog1-family')
rnd = random.Random(20261027)
C = [json.loads(l) for l in open(f'{TMP}/candidates.jsonl', encoding='utf-8')]
by = collections.defaultdict(list)
for c in C:
    for m in c['modes']: by[m].append(c)
CORE = {'FAMILY_SHARING': 1000, 'FAMILY_PLAN': 1000, 'SHARE_PURCHASE': 1000, 'BUY_AGAIN_PERSON': 1000, 'HOUSEHOLD_USE': 1000, 'KID_PROFILES': 1000}
SAMPLE = {}
def capped(pool, n, cap):
    pool = pool[:]; rnd.shuffle(pool); out, per = [], collections.Counter()
    for c in pool:
        if per[c['app']] < cap: out.append(c); per[c['app']] += 1
        if len(out) >= n: break
    return out
seen, order = set(), []
def add(m, cs):
    for c in cs:
        if c['key'] not in seen: seen.add(c['key']); order.append((m, c))
for m, n in CORE.items(): add(m, sorted([c for c in by[m] if c['store'] in 'AP'], key=lambda c: c['key']))
for m, n in SAMPLE.items(): add(m, capped([c for c in by[m] if c['store'] in 'AP'], n, 5))
for m in list(CORE) + list(SAMPLE): add(m, capped([c for c in by[m] if c['store'] == 'N'], 3, 1))
os.makedirs(f'{TMP}/read', exist_ok=True)
for b in range(0, len(order), 70):
    with open(f'{TMP}/read/batch-{b//70+1:02d}.txt', 'w', encoding='utf-8') as f:
        for m, c in order[b:b+70]:
            t = c['text']; t = t if len(t) <= 700 else t[:700] + ' …'
            f.write(f"[{c['key']}] {m} | {c['rating']}★ {c['date']} {c['loc']} | {c['app'][:26]}\n{t}\n\n")
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open(f'{TMP}/read/sample-index.json', 'w'))
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open('sample-index.json', 'w'))
print(len(order), 'in', (len(order)+69)//70, 'batches', collections.Counter(m for m, _ in order))
