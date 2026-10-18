import json, re, os, glob, sys
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
Q = {
 'done_look': (re.compile(r'strike ?through|struck|cross(ed|es)? (out|off|through)|line through|lines? through|greyed|grayed|faded|dimmed', re.I), re.compile(r'\b(items?|tasks?|sub-?tasks?|steps?|check(ed)? ?(box|list|off)|completed|done)\b', re.I), 80),
 'fold': (re.compile(r'collaps|expand|fold|hide (the )?(completed|sub)|show (the )?sub|drop-?down|minimi[sz]e', re.I), re.compile(r'\bsub-?(tasks?|habits?|items?|steps?)\b|check-?list', re.I), 80),
 'sub_progress': (re.compile(r'progress|percent|\d+ ?(of|/) ?\d+|partial|half|how many', re.I), re.compile(r'\bsub-?(tasks?|habits?|items?|steps?)\b', re.I), 80),
}
res = {k: [] for k in Q}
files = [(t, d) for t, base in (('A','App Store Reviews'),('P','Play Store Reviews'),('N','Native Store Reviews')) for d in sorted(glob.glob(os.path.join(ROOT, base, '*')))]
for tag, d in files:
    f = os.path.join(d, 'reviews.jsonl')
    if not os.path.exists(f): continue
    num = os.path.basename(d).split('.')[0]
    for i, line in enumerate(open(f, encoding='utf-8')):
        try: r = json.loads(line)
        except Exception: continue
        t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip()
        for k, (a, b, w) in Q.items():
            A = [m.start() for m in a.finditer(t)]
            if not A: continue
            B = [m.start() for m in b.finditer(t)]
            best = min((abs(x-y), x, y) for x in A for y in B) if B else None
            if best and best[0] < w:
                res[k].append({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d)[:22], 'c': (best[1]+best[2])//2, 'text': t[:2000]})
json.dump(res, open(os.path.join(ROOT,'Temp','checklist-look','q.json'),'w'))
print({k: len(v) for k, v in res.items()})
