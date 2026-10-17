"""Android swipe expectations (16 Oct 2026): every Play Store review, plus Google Tasks, Microsoft To Do and Keep, mentioning a swipe."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
OUT = os.path.join(ROOT, 'Temp', 'android-swipe')
SW = re.compile(r'\bswip\w*', re.I)
files = [('P', d) for d in sorted(glob.glob(os.path.join(ROOT, 'Play Store Reviews', '*')))]
files += [('N', d) for d in sorted(glob.glob(os.path.join(ROOT, 'Native Store Reviews', '*'))) if re.match(r'(6|7|10)\.', os.path.basename(d))]
out = open(os.path.join(OUT, 'hits.jsonl'), 'w'); n = tot = 0
for tag, d in files:
    f = os.path.join(d, 'reviews.jsonl')
    if not os.path.exists(f): continue
    num = os.path.basename(d).split('.')[0]
    for i, line in enumerate(open(f, encoding='utf-8')):
        try: r = json.loads(line)
        except Exception: continue
        t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or '')).strip(); tot += 1
        if SW.search(t):
            n += 1
            out.write(json.dumps({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d), 'rating': r.get('rating'), 'text': t[:1200]}) + '\n')
print(tot, n)
