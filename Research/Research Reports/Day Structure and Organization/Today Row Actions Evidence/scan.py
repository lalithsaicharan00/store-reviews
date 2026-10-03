"""Today's rows research (3 Oct 2026): swipe actions, tapping a done habit again, deleting, and a tap that opens a
habit's details. Scans every review in App Store, Play Store and native corpora; writes hits per question."""
import json, re, glob, os, collections
ROOT = '/home/user/store-reviews/Research'
HABIT = r'(habit|streak|check|tick|task|log|entry|entries|goal|done|complet|track|routine)'
Q = {
 'swipe': re.compile(r'\bswip(e|ed|es|ing)\b|deslizar|desliz|wisch|glisser|balayer|scorr|свайп|смахн|スワイプ|滑动|左滑|右滑|kaydır', re.I),
 'tapagain': re.compile(r'\b(tap|click|press|touch)\w*\s+(it\s+|on\s+it\s+|the\s+\w+\s+)?again\b|\bun-?(tick|check|mark|do a check|complete)\w*|\b(tap|click|press)\w*\s+(on\s+)?(a\s+|the\s+|an\s+)?(completed|checked|ticked|done|finished)\b|\bdouble[- ]?(tap|click)\w*', re.I),
 'delete': re.compile(r'(accident\w*|by mistake|mistaken\w*|inadvertent\w*|unintention\w*)\W+(?:\w+\W+){0,6}delet\w*|delet\w*\W+(?:\w+\W+){0,6}(accident\w*|by mistake|mistaken\w*)|delete (button|option|icon)|(easy|easily|too easy) to delete', re.I),
 'details': re.compile(r'\b(tap|click|press)\w*\s+(on\s+)?(a\s+|the\s+|any\s+|each\s+)?(habit|task|item|row|card)\w*\W+(?:\w+\W+){0,8}(open|detail|see|page|menu|option|edit|info|history|stat)', re.I),
}
hits = collections.defaultdict(list)
def text_of(r):
    return ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')).strip()
files = glob.glob(ROOT + '/App Store Reviews/*/reviews.jsonl') + glob.glob(ROOT + '/Play Store Reviews/*/reviews.jsonl') + glob.glob(ROOT + '/Native Store Reviews/*/reviews.jsonl')
total = 0
seen = set()
for f in files:
    src = f.split('/Research/')[1].split('/')[0]
    with open(f) as fh:
        for line in fh:
            try: r = json.loads(line)
            except Exception: continue
            rid = r.get('review_id')
            if rid in seen: continue
            seen.add(rid); total += 1
            t = text_of(r)
            if len(t) < 15: continue
            for q, rx in Q.items():
                m = rx.search(t)
                if not m: continue
                if q in ('swipe', 'tapagain') and not re.search(HABIT, t, re.I) and src != 'Native Store Reviews': continue
                hits[q].append({'id': rid, 'app': r.get('app_name'), 'src': src, 'rating': r.get('rating'), 'lang': r.get('language') or r.get('country'), 'text': t})
os.makedirs(ROOT + '/Temp/rowactions', exist_ok=True)
for q, v in hits.items():
    json.dump(v, open(f'{ROOT}/Temp/rowactions/hits_{q}.json', 'w'), ensure_ascii=False)
print('reviews scanned:', total)
for q, v in hits.items():
    print(q, len(v), 'apps', len({h["app"] for h in v}))
