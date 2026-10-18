"""Mood widgets (16 Oct 2026): every review mentioning a widget near mood, emoji, feelings or a journal."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
W = re.compile(r'\bwidgets?\b', re.I)
M = re.compile(r'\b(mood|moods|emoji\w*|feel(ing|ings)?|emotion\w*|journal\w*|check-?in|how (was|is) (my|your) day|daylio|pixels?)\b', re.I)
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
            for m in W.finditer(t):
                if M.search(t[max(0,m.start()-100):m.end()+100]):
                    out.append({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d)[:18], 'c': m.start(), 'text': t[:2000]}); break
json.dump(out, open(os.path.join(ROOT,'Temp','mood-widget','hits.json'),'w')); print(len(out))
