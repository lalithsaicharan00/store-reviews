"""A mood check-in on a new user's first days (16 Oct 2026)."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
MOOD = re.compile(r'\b(mood|how (i|you) feel|feelings?|check-?in|emotions?)\b', re.I)
FIRST = re.compile(r"\b(first (time|day|open|launch|week)|just (downloaded|started|installed)|new user|onboarding|when (i|you) (first )?open|right away|straight away|empty|blank|nothing (to do|there))\b", re.I)
out=[]
for tag, base in (('A','App Store Reviews'),('P','Play Store Reviews')):
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d, 'reviews.jsonl')
        if not os.path.exists(f): continue
        num = os.path.basename(d).split('.')[0]
        for i, line in enumerate(open(f, encoding='utf-8')):
            try: r = json.loads(line)
            except Exception: continue
            t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip()
            for m in MOOD.finditer(t):
                if FIRST.search(t[max(0,m.start()-120):m.end()+120]):
                    out.append({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d)[:16], 'c': m.start(), 'text': t[:1500]}); break
json.dump(out, open(os.path.join(ROOT,'Temp','first-mood','hits.json'),'w')); print(len(out))
