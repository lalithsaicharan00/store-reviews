"""Checklist steps on a row (16 Oct 2026): how ticked steps, long lists and their progress should look."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
OUT = os.path.join(ROOT, 'Temp', 'checklist-look')
LIST = re.compile(r'\b(sub-?tasks?|sub-?habits?|check-?lists?|sub-?items?|sub-?steps?|steps)\b', re.I)
LOOK = re.compile(r'cross(ed)? (out|off)|strike|strikethrough|grey(ed)?|gray(ed)?|fade|collaps|expand|hide|hidden|long list|too long|scroll|progress bar|percent|%|partial|fill|bottom of the list|disappear|move(s|d)? (down|to the bottom)|check ?box|tick', re.I)
files = [(t, d) for t, base in (('A','App Store Reviews'),('P','Play Store Reviews'),('N','Native Store Reviews')) for d in sorted(glob.glob(os.path.join(ROOT, base, '*')))]
out = open(os.path.join(OUT, 'hits.jsonl'), 'w'); n = tot = 0
for tag, d in files:
    f = os.path.join(d, 'reviews.jsonl')
    if not os.path.exists(f): continue
    num = os.path.basename(d).split('.')[0]
    for i, line in enumerate(open(f, encoding='utf-8')):
        try: r = json.loads(line)
        except Exception: continue
        t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip(); tot += 1
        if LIST.search(t) and LOOK.search(t):
            n += 1; out.write(json.dumps({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d), 'text': t[:1500]}) + '\n')
print(tot, n)
