import json, os, sys, glob, importlib.util
here = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location('rc', os.path.join(here, 'review_classification.py')); rc = importlib.util.module_from_spec(spec); spec.loader.exec_module(rc)
ROOT = sys.argv[1] if len(sys.argv) > 1 else os.path.abspath(os.path.join(here, "..", "..", ".."))
dirs = {'A': 'App Store Reviews', 'P': 'Play Store Reviews', 'N': 'Native Store Reviews'}
cache = {}
def text(cite):
    tag, rest = cite[0], cite[1:]; num, idx = rest.split('#')
    d = [x for x in glob.glob(os.path.join(ROOT, dirs[tag], '*')) if os.path.basename(x).split('.')[0] == num][0]
    if d not in cache: cache[d] = open(os.path.join(d, 'reviews.jsonl'), encoding='utf-8').read().split('\n')
    r = json.loads(cache[d][int(idx)])
    return ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')), r
bad = n = 0
for theme, m in rc.T.items():
    for cite, frag in m.items():
        n += 1; t, r = text(cite)
        if frag not in t: bad += 1; print('MISMATCH', theme, cite, frag)
print(n, 'quotes,', bad, 'mismatches'); print({k: len(v) for k, v in rc.T.items()})
