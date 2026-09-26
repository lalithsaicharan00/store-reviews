"""Draw a reading sample per mode from candidates.jsonl -> read/batch-XX.txt (deduplicated across modes).
Per mode: up to K reviews, ~70% from 1-3 stars, ~20% from the native (non-habit) corpus; seeded."""
import json, random, os, collections
OUT = os.path.dirname(os.path.abspath(__file__))
K = 25
rnd = random.Random(20260926)
C = [json.loads(l) for l in open(f'{OUT}/candidates.jsonl', encoding='utf-8')]
by = collections.defaultdict(list)
for c in C:
    for m in c['modes']:
        if m != 'LOSS':
            by[m].append(c)
seen, order = set(), []
for m in sorted(by):
    pool = by[m]
    k = 40 if m == 'POS_MIGRATE' else K
    habit = [c for c in pool if c['store'] in 'AP']; native = [c for c in pool if c['store'] == 'N']
    want = []
    if m == 'POS_MIGRATE':
        groups = [([c for c in habit if c['rating'] >= 4], 32), ([c for c in native if c['rating'] >= 4], 8)]
    else:
        groups = [([c for c in habit if c['rating'] <= 3], int(k*.6)), ([c for c in habit if c['rating'] >= 4], int(k*.2)),
                  ([c for c in native if c['rating'] <= 3], int(k*.2))]
    for g, n in groups:
        g = [c for c in g if c['key'] not in seen]
        rnd.shuffle(g)
        want += g[:n]
    for c in want:
        if c['key'] in seen: continue
        seen.add(c['key']); order.append((m, c))
os.makedirs(f'{OUT}/read', exist_ok=True)
B = 60
for b in range(0, len(order), B):
    with open(f'{OUT}/read/batch-{b//B+1:02d}.txt', 'w', encoding='utf-8') as f:
        for m, c in order[b:b+B]:
            t = c['text'];  t = t if len(t) <= 900 else t[:900] + ' …'
            f.write(f"[{c['key']}] drawn:{m} | {c['rating']}★ {c['date']} {c['loc']} v{c['ver']} | {c['app'][:40]}\n{t}\n\n")
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open(f'{OUT}/read/sample-index.json', 'w'))
print(len(order), 'reviews in', (len(order)+B-1)//B, 'batches'); print({m: len(by[m]) for m in sorted(by)})
