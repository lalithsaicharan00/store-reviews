"""Hiding a card or feature from the main screen, and getting it back (16 Oct 2026)."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
HIDE = re.compile(r"\b(hid(e|den|ing)|unhid\w*|turn(ed|ing)? (it )?(off|back on)|disabl\w+|remov\w+|dismiss\w*|get (it )?back|bring (it )?back|restore|re-?enable|show (it )?again)\b", re.I)
WHAT = re.compile(r"\b(mood|journal\w*|reflection|check-?in|card|section|feature|banner|widget|quote|tips?|tab|panel|module|tracker)\b", re.I)
WHERE = re.compile(r"\b(home ?(screen|page)?|main (screen|page)|today|dashboard|front page|start screen|setting\w*|menu|edit|customi[sz]\w*)\b", re.I)
out = []
for tag, base in (('A','App Store Reviews'),('P','Play Store Reviews')):
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d, 'reviews.jsonl')
        if not os.path.exists(f): continue
        num = os.path.basename(d).split('.')[0]
        for i, line in enumerate(open(f, encoding='utf-8')):
            try: r = json.loads(line)
            except Exception: continue
            t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip()
            for m in HIDE.finditer(t):
                w = t[max(0, m.start()-90): m.end()+90]
                if WHAT.search(w) and WHERE.search(w):
                    out.append({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d)[:18], 'c': m.start(), 'text': t[:2000]}); break
json.dump(out, open(os.path.join(ROOT,'Temp','hide-card','hits.json'),'w')); print(len(out))
