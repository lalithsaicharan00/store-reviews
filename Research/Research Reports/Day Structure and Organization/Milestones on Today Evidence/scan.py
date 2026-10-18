"""Milestones on Today (17 Oct 2026): how much celebration, and milestones reached while away."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
MS = re.compile(r"\b(milestones?|badges?|achievements?|trophies|trophy|medals?|celebrat\w*|confetti|fireworks|congrat\w*|(\d{2,4}(th)?|one hundred) days?)\b", re.I)
Q = {
 'away': re.compile(r"\b(missed|didn'?t (see|notice|know|get)|never (saw|knew|got)|while i was|when i (came back|opened|got back)|next time i open|wasn'?t (there|notified)|no (notification|alert)|notif(y|ied|ication)s?|alert(ed|s)?|surprise)\b", re.I),
 'amount': re.compile(r"\b(too much|too many|over the top|childish|annoying|every time|each time|tone (it )?down|turn (it )?off|can'?t (turn|skip|close)|subtle|small|little|just right|tasteful|satisfying|love the|cute)\b", re.I),
}
res = {k: [] for k in Q}
for tag, base in (('A','App Store Reviews'),('P','Play Store Reviews')):
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d, 'reviews.jsonl')
        if not os.path.exists(f): continue
        num = os.path.basename(d).split('.')[0]
        for i, line in enumerate(open(f, encoding='utf-8')):
            try: r = json.loads(line)
            except Exception: continue
            t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip()
            for m in MS.finditer(t):
                w = t[max(0,m.start()-110): m.end()+110]
                for k, rx in Q.items():
                    if rx.search(w) and not any(x['cite']==f'{tag}{num}#{i}' for x in res[k][-3:]):
                        res[k].append({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d)[:16], 'c': m.start(), 'text': t[:1800]})
                break
json.dump(res, open(os.path.join(ROOT,'Temp','milestone-today','q.json'),'w')); print({k: len(v) for k, v in res.items()})
