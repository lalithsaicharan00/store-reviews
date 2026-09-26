import json, random, collections, os
rnd = random.Random(20260927)
C = [json.loads(l) for l in open('candidates.jsonl', encoding='utf-8')]
by = collections.defaultdict(list)
for c in C:
    for m in c['modes']: by[m].append(c)
seen, order = set(), []
for m in sorted(by, key=lambda m: len(by[m])):
    habit = [c for c in by[m] if c['store'] in 'AP']; native = [c for c in by[m] if c['store'] == 'N']
    if len(by[m]) <= 60:
        pick = habit + rnd.sample(native, min(5, len(native)))
    else:
        low = [c for c in habit if c['rating'] <= 3]; high = [c for c in habit if c['rating'] >= 4]
        pick = rnd.sample(low, min(16, len(low))) + rnd.sample(high, min(4, len(high))) + rnd.sample(native, min(5, len(native)))
    for c in pick:
        if c['key'] in seen: continue
        seen.add(c['key']); order.append((m, c))
os.makedirs('read', exist_ok=True)
for b in range(0, len(order), 70):
    with open(f'read/batch-{b//70+1:02d}.txt', 'w', encoding='utf-8') as f:
        for m, c in order[b:b+70]:
            t = c['text']; t = t if len(t) <= 650 else t[:650] + ' …'
            f.write(f"[{c['key']}] {m} | {c['rating']}★ {c['date']} {c['loc']} | {c['app'][:28]}\n{t}\n\n")
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open('read/sample-index.json', 'w'))
print(len(order), 'in', (len(order)+69)//70, 'batches')
