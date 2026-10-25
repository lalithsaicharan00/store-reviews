import json, collections
from progress_fill_classification import C
pool = {r['id']: r for r in json.load(open('pool.json'))}
unknown = [i for i in C if i not in pool]
print('coded', len(C), 'pool', len(pool), 'unknown', unknown)
cnt = collections.Counter(); stars = collections.defaultdict(list); apps = collections.defaultdict(collections.Counter)
for i, codes in C.items():
    for k in codes:
        cnt[k] += 1; stars[k].append(pool[i]['rating']); apps[k][pool[i]['app']] += 1
for k, n in cnt.most_common():
    print(f"{k:3} {n:4}  mean★ {sum(stars[k])/n:.2f}  apps {len(apps[k])}  top {apps[k].most_common(6)}")
print('X (read, off-topic):', len(pool) - len(C))
