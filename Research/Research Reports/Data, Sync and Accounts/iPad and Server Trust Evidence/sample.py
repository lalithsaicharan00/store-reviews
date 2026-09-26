"""Draw the reading set. Trust modes: every App Store + Play match (small enough to read in full).
Segment modes: a sample capped per app, weighted to App Store. Native apps: a few per mode for contrast."""
import json, random, collections, os
rnd = random.Random(20261026)
C = [json.loads(l) for l in open('candidates.jsonl', encoding='utf-8')]
by = collections.defaultdict(list)
for c in C:
    for m in c['modes']: by[m].append(c)
FULL = ['FORCED_ACCOUNT', 'ICLOUD_PREF', 'LOCAL_ONLY', 'SERVER_DISTRUST', 'PRIVACY_POS', 'NO_ACCOUNT_PRAISE']
SAMPLE = {'IPAD_SYNC': 150, 'IPAD': 120, 'ICLOUD': 100, 'IPAD_APP_REQ': 50, 'MULTI_DEVICE': 50, 'MAC': 30, 'TABLET_OTHER': 30}
def capped(pool, n, cap):
    pool = pool[:]; rnd.shuffle(pool); out, per = [], collections.Counter()
    for c in pool:
        if per[c['app']] < cap: out.append(c); per[c['app']] += 1
        if len(out) >= n: break
    return out
seen, order = set(), []
def add(m, cs):
    for c in cs:
        if c['key'] in seen: continue
        seen.add(c['key']); order.append((m, c))
for m in FULL:
    add(m, sorted([c for c in by[m] if c['store'] in 'AP'], key=lambda c: c['key']))
for m, n in SAMPLE.items():
    habit = [c for c in by[m] if c['store'] in 'AP']
    add(m, capped(habit, n, 6))
for m in FULL + list(SAMPLE):
    add(m, capped([c for c in by[m] if c['store'] == 'N'], 3, 1))
os.makedirs('read', exist_ok=True)
for b in range(0, len(order), 70):
    with open(f'read/batch-{b//70+1:02d}.txt', 'w', encoding='utf-8') as f:
        for m, c in order[b:b+70]:
            t = c['text']; t = t if len(t) <= 700 else t[:700] + ' …'
            f.write(f"[{c['key']}] {m} | {c['rating']}★ {c['date']} {c['loc']} | {c['app'][:26]}\n{t}\n\n")
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open('read/sample-index.json', 'w'))
print(len(order), 'in', (len(order)+69)//70, 'batches', collections.Counter(m for m, _ in order))
