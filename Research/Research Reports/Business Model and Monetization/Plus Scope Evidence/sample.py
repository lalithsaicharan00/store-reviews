"""Draw the reading set: iPad-paywall 130, Watch-paywall 100, happy lifetime payers 50; at most 8 per app."""
import json, random, collections, os
HERE = os.path.dirname(os.path.abspath(__file__))
WORK = os.path.join(HERE, '../../../Temp/plus-scope')
rnd = random.Random(20260928)
C = [json.loads(l) for l in open(f'{WORK}/candidates.jsonl', encoding='utf-8')]
by = collections.defaultdict(list)
for c in C:
    for m in c['modes']: by[m].append(c)
def capped(pool, n, cap):
    pool = pool[:]; rnd.shuffle(pool); out, per = [], collections.Counter()
    for c in pool:
        if per[c['app']] < cap: out.append(c); per[c['app']] += 1
        if len(out) >= n: break
    return out
seen, order = set(), []
for m, n in [('IPAD_PAYWALL', 130), ('WATCH_PAYWALL', 100), ('PAYER_LIFETIME_POS', 50)]:
    for c in capped(by[m], n, 8):
        if c['key'] in seen: continue
        seen.add(c['key']); order.append((m, c))
os.makedirs(f'{WORK}/read', exist_ok=True)
for b in range(0, len(order), 70):
    with open(f'{WORK}/read/batch-{b//70+1:02d}.txt', 'w', encoding='utf-8') as f:
        for m, c in order[b:b+70]:
            t = c['text']; t = t if len(t) <= 600 else t[:600] + ' …'
            f.write(f"[{c['key']}] {m} | {c['rating']}★ {c['date']} {c['loc']} | {c['app'][:26]}\n{t}\n\n")
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open(f'{HERE}/sample-index.json', 'w'))
print(len(order), collections.Counter(m for m, _ in order))
