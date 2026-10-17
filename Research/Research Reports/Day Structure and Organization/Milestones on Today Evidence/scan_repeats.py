"""Milestones on Today, follow-up (17 Oct 2026): several habits reaching milestones together; celebrations that repeat."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
CEL = r"(animations?|confetti|fireworks|celebrat\w*|congrat\w*|pop-?ups?|badges?|milestones?|achievements?|trophies|sounds?|chimes?)"
RX = re.compile(
  r"(every (single )?(time|habit|task|check|tick|one)|each (time|habit|task|one)|over and over|again and again|repeated(ly)?|back[- ]to[- ]back|one after (the )?another|multiple|so many|too many|all at once|at the same time|several)"
  r".{0,70}\b" + CEL + r"\b|\b" + CEL + r"\b.{0,70}"
  r"(every (single )?(time|habit|task|check|tick|one)|each (time|habit|task|one)|over and over|again and again|repeated(ly)?|back[- ]to[- ]back|one after (the )?another|multiple|so many|too many|all at once|at the same time|several)", re.I)
out = []
for tag, base in (('A','App Store Reviews'),('P','Play Store Reviews')):
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d, 'reviews.jsonl')
        if not os.path.exists(f): continue
        num = os.path.basename(d).split('.')[0]
        for i, line in enumerate(open(f, encoding='utf-8').read().split('\n')):
            if not line.strip(): continue
            try: r = json.loads(line)
            except Exception: continue
            t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip()
            m = RX.search(t)
            if m: out.append({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d)[:18], 'rating': r.get('rating') or r.get('score'), 'w': t[max(0,m.start()-160): m.end()+160]})
os.makedirs(os.path.join(ROOT,'Temp','milestone-today'), exist_ok=True)
json.dump(out, open(os.path.join(ROOT,'Temp','milestone-today','repeats.json'),'w')); print(len(out))
