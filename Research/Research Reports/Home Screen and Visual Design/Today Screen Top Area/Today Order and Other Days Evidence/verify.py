"""Check every cited review exists at its index and contains its quoted fragment. Run: python3 -I verify.py"""
import json, os, glob, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from review_classification import MAP
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), *[".."] * 4))
base = {'A': 'App Store Reviews', 'P': 'Play Store Reviews'}
cache = {}
def review(cite):
    tag, rest = cite[0], cite[1:]
    num, idx = rest.split('#')
    if (tag, num) not in cache:
        d = [p for p in glob.glob(os.path.join(ROOT, base[tag], f'{num}.*'))]
        cache[(tag, num)] = open(os.path.join(d[0], 'reviews.jsonl'), encoding='utf-8').read().split('\n')
    r = json.loads(cache[(tag, num)][int(idx)])
    return ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or '')), r.get('rating')
bad = 0; n = 0
for theme, items in MAP.items():
    for cite, frag in items.items():
        n += 1
        t, _ = review(cite)
        if frag not in t:
            bad += 1; print('MISMATCH', theme, cite, '|', frag)
print(f'{n} citations, {bad} mismatches')
