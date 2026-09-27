"""Draw the reading set from the habit stores (A App Store, P Play Store). Prompt modes and every Google Drive and
cloud-failure mode: every match. iCloud sync and the no-nag praise: a sample capped per app."""
import json, random, collections, os
HERE = os.path.dirname(os.path.abspath(__file__))
WORK = os.path.join(HERE, '../../../Temp/backlog4-signin')
rnd = random.Random(20260927)
C = [json.loads(l) for l in open(f'{WORK}/candidates.jsonl', encoding='utf-8')]
by = collections.defaultdict(list)
for c in C:
    for m in c['modes']: by[m].append(c)
FULL = ['SIGNIN_NO_SKIP', 'SIGNIN_NAG', 'BACKUP_NAG', 'CLOUD_BACKUP_FAIL', 'DRIVE_BACKUP', 'DRIVE_SYNC', 'DRIVE_AUTH', 'ICLOUD_BACKUP']
SAMPLE = {'ICLOUD_SYNC': 110, 'NO_NAG_PRAISE': 60}
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
    add(m, capped([c for c in by[m] if c['store'] in 'AP'], n, 6))
os.makedirs(f'{WORK}/read', exist_ok=True)
for b in range(0, len(order), 70):
    with open(f'{WORK}/read/batch-{b//70+1:02d}.txt', 'w', encoding='utf-8') as f:
        for m, c in order[b:b+70]:
            t = c['text']; t = t if len(t) <= 700 else t[:700] + ' …'
            f.write(f"[{c['key']}] {m} | {c['rating']}★ {c['date']} {c['loc']} | {c['app'][:26]}\n{t}\n\n")
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open(f'{HERE}/sample-index.json', 'w'))
print(len(order), 'in', (len(order)+69)//70, 'batches', collections.Counter(m for m, _ in order))
