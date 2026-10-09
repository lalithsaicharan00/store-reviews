import json, sys, collections, importlib.util
c = {x['key']: x for x in json.load(open('/home/user/store-reviews/Research/Temp/58-candidates.json'))}
spec = importlib.util.spec_from_file_location('m', sys.argv[1]); m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
mode = sys.argv[2] if len(sys.argv) > 2 else None
if mode:
    exp = {k for k, x in c.items() if mode in x['modes']}
    print('missing codes:', len(exp - set(m.C)), 'unknown keys:', len(set(m.C) - set(c)))
cnt, apps, stars = collections.Counter(), collections.defaultdict(set), collections.defaultdict(list)
for k, v in m.C.items():
    for code in v.split():
        cnt[code] += 1; apps[code].add(c[k]['app'].split('.')[0] + k[0]); stars[code].append(c[k]['rating'])
for code, n in cnt.most_common():
    print(f"{code:22} {n:4}  apps={len(apps[code]):3}  mean★={sum(stars[code])/n:.2f}")
print('total coded', len(m.C))
