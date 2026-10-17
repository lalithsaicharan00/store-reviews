"""Swipe: act on release or reveal-and-tap? (16 Oct 2026). Every review in all three stores mentioning a swipe."""
import json, re, os, glob, sys
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
OUT = os.path.join(ROOT, 'Temp', 'swipe-act')
SW = re.compile(r'\bswip\w*', re.I)
files = [('A', d) for d in sorted(glob.glob(os.path.join(ROOT, 'App Store Reviews', '*')))]
files += [('P', d) for d in sorted(glob.glob(os.path.join(ROOT, 'Play Store Reviews', '*')))]
files += [('N', d) for d in sorted(glob.glob(os.path.join(ROOT, 'Native Store Reviews', '*')))]
out = open(os.path.join(OUT, 'hits.jsonl'), 'w'); n = tot = 0
for tag, d in files:
    f = os.path.join(d, 'reviews.jsonl')
    if not os.path.exists(f): continue
    num = os.path.basename(d).split('.')[0]
    for i, line in enumerate(open(f, encoding='utf-8')):
        try: r = json.loads(line)
        except Exception: continue
        t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip(); tot += 1
        if SW.search(t):
            n += 1
            out.write(json.dumps({'cite': f'{tag}{num}#{i}', 'id': r.get('review_id') or r.get('reviewId') or r.get('id'), 'app': os.path.basename(d), 'rating': r.get('rating') or r.get('score'), 'text': t[:1500]}) + '\n')
print(tot, n)
