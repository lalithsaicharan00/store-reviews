"""Mood tracking and a note for the whole day in habit apps (16 Oct 2026). Every corpus."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
OUT = os.path.join(ROOT, 'Temp', 'mood-day')
P = {
 'mood': re.compile(r"\bmood(s| tracker| tracking| log| check[- ]?in| entries| entry| chart| graph| calendar)?\b(?! swings?)", re.I),
 'pixels': re.compile(r"\b(year in pixels|in pixels|pixel (chart|view|grid|calendar))\b", re.I),
 'daylio': re.compile(r"\bdaylio\b", re.I),
 'feeling': re.compile(r"\b(how (was|is) (my|your) day|rate (my|your|the) day|how i (felt|feel) (today|each day|that day)|emotions? (track|log))", re.I),
 'daynote': re.compile(r"\b(journal\w*|diary|daily (note|reflection|entry|entries)|note (for|about|on) (the|my|each|a) day|day'?s? note|reflect\w*)\b", re.I),
 'bloat': re.compile(r"\b(bloat\w*|too many features|just want (a )?(simple|basic)|don'?t need (a |the )?(journal|mood|diary)|unnecessary features|feature creep|cluttered with)\b", re.I),
}
files = []
for base, tag in [('App Store Reviews','A'),('Play Store Reviews','P'),('Native Store Reviews','N')]:
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d, 'reviews.jsonl')
        if os.path.exists(f): files.append((tag, d, f))
outs = {k: open(os.path.join(OUT, f'hits_{k}.jsonl'), 'w') for k in P}; cnt = {k: 0 for k in P}; tot = 0
for tag, d, f in files:
    num = os.path.basename(d).split('.')[0]
    for i, line in enumerate(open(f, encoding='utf-8')):
        try: r = json.loads(line)
        except Exception: continue
        t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or '')); tot += 1
        for k, rg in P.items():
            m = rg.search(t)
            if m:
                cnt[k] += 1; s = max(0, m.start()-220); e = min(len(t), m.end()+260)
                outs[k].write(json.dumps({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d), 'rating': r.get('rating'), 'snip': t[s:e]}) + '\n')
print(tot, cnt)
