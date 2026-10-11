"""Validate coded.py against candidates.jsonl and tally the codes (App Store habit apps only).
Run: python -I check.py  -> writes tally.txt"""
import json, os, re, collections, importlib.util
HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location('coded', os.path.join(HERE, 'coded.py'))
coded = importlib.util.module_from_spec(spec); spec.loader.exec_module(coded)
cands = {c['key']: c for c in map(json.loads, open(os.path.join(HERE, 'candidates.jsonl'), encoding='utf-8'))}
A = {k: c for k, c in cands.items() if c['store'] == 'A'}
CODES = set(re.findall(r'^  ([A-Z-]+) ', coded.__doc__, re.M)) | {'KIDS', 'NAV', 'NOT-NEEDED'}
unknown = [k for k in coded.CODED if k not in A]
badcode = {k: v for k, v in coded.CODED.items() if set(v) - CODES}
dupes = {k: v for k, v in coded.CODED.items() if len(v) != len(set(v))}
today_unknown = [k for k in coded.TODAY_EVIDENCE if k not in A]
# literal duplicates in the source file (a dict silently keeps the last)
src = open(os.path.join(HERE, 'coded.py'), encoding='utf-8').read()
keys = re.findall(r"^    '(A\d+#\d+)': \[", src, re.M)
srcdupes = [k for k, n in collections.Counter(keys).items() if n > 1]
out = []
out.append(f"App Store candidates read: {len(A)}; coded as about the iPad's layout or use: {len(coded.CODED)}; not layout: {len(A) - len(coded.CODED)}")
out.append(f"unknown keys: {unknown}; bad codes: {badcode}; duplicate codes in one review: {dupes}; repeated keys in source: {srcdupes}; unknown Today keys: {today_unknown}")
tally = collections.Counter(c for v in coded.CODED.values() for c in v)
stars = collections.defaultdict(list); apps = collections.defaultdict(set); years = collections.defaultdict(collections.Counter)
for k, v in coded.CODED.items():
    for c in v:
        stars[c].append(A[k]['rating'] or 0); apps[c].add(k.split('#')[0]); years[c][A[k]['date'][:4]] += 1
out.append(f"\n{'code':12}{'reviews':>8}{'apps':>6}{'mean★':>7}   since 2022")
for c, n in tally.most_common():
    recent = sum(n for y, n in years[c].items() if y >= '2022')
    out.append(f"{c:12}{n:8}{len(apps[c]):6}{sum(stars[c])/n:7.2f}   {recent}")
open(os.path.join(HERE, 'tally.txt'), 'w', encoding='utf-8').write('\n'.join(out) + '\n')
print('\n'.join(out))
