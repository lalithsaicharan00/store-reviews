import json, os, glob, sys, html
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from review_classification import MAP
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), *['..']*3))
base = {'P': 'Play Store Reviews', 'N': 'Native Store Reviews'}
cache = {}
def text(cite):
    tag, rest = cite[0], cite[1:]; num, idx = rest.split('#')
    if (tag, num) not in cache:
        d = glob.glob(os.path.join(ROOT, base[tag], f'{num}.*'))[0]
        cache[(tag, num)] = open(os.path.join(d, 'reviews.jsonl'), encoding='utf-8').read().split('\n')
    r = json.loads(cache[(tag, num)][int(idx)])
    return ' '.join(html.unescape((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or '')).split())
bad = n = 0
for th, items in MAP.items():
    for c, frag in items.items():
        n += 1
        if ' '.join(frag.split()) not in text(c): bad += 1; print('MISMATCH', th, c, frag)
print(f'{n} citations, {bad} mismatches')
