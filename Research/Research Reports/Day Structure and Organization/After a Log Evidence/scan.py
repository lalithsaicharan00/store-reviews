"""Undo/after-action buttons: do people want them to stay or go? (16 Oct 2026). Every corpus."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
OUT = os.path.join(ROOT, 'Temp', 'undo-timing')
P = re.compile(r"\bundo\b[^.!?\n]{0,90}\b(disappear\w*|vanish\w*|gone|goes away|too fast|too quick\w*|quickly|seconds?|time ?out|timed?|before i (can|could)|stays?|stay(ed)? (there|up|visible)|always (be )?(there|visible)|persist\w*|pop[- ]?up|snackbar|toast|banner|bar|clutter\w*|in the way|cover\w*|block\w*)|\b(disappear\w*|vanish\w*|too fast|too quick\w*|before i (can|could)|snackbar|toast|pop[- ]?up)\b[^.!?\n]{0,60}\bundo\b", re.I)
files = []
for base, tag in [('App Store Reviews','A'),('Play Store Reviews','P'),('Native Store Reviews','N')]:
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d, 'reviews.jsonl')
        if os.path.exists(f): files.append((tag, d, f))
out = open(os.path.join(OUT, 'hits.jsonl'), 'w'); tot = n = 0
for tag, d, f in files:
    num = os.path.basename(d).split('.')[0]
    for i, line in enumerate(open(f, encoding='utf-8')):
        try: r = json.loads(line)
        except Exception: continue
        t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or '')); tot += 1
        m = P.search(t)
        if m:
            n += 1; s = max(0, m.start()-200); e = min(len(t), m.end()+200)
            out.write(json.dumps({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d), 'rating': r.get('rating'), 'snip': t[s:e]}) + '\n')
print(tot, n)
