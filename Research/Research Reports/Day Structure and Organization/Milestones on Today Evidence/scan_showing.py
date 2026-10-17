"""Milestones on Today, second follow-up (17 Oct 2026): a milestone shown up front, milestones earned again, early wins."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
MS = r"(milestones?|streaks?|achievements?|badges?|awards?|trophies|trophy|medals?)"
Q = {
 'shown_liked': re.compile(r"\b(pop-?ups?|screens?|animations?|celebrat\w*|confetti|fireworks|congrat\w*|message)\b.{0,80}\b"+MS+r"\b.{0,80}\b(love|like|motivat\w*|encourag\w*|feel (so )?(good|great|proud)|proud|satisfying|exciting|fun|rewarding)\b|\b(love|like|motivat\w*|encourag\w*|proud|satisfying|exciting|rewarding)\b.{0,80}\b"+MS+r"\b.{0,80}\b(pop-?ups?|screens?|animations?|celebrat\w*|confetti|fireworks|congrat\w*)\b", re.I),
 'earned_again': re.compile(r"\b(again|every time|same|already|repeat\w*|reset)\b.{0,60}\b(badges?|milestones?|achievements?|awards?|trophies|trophy|medals?)\b|\b(badges?|milestones?|achievements?|awards?|trophies|trophy|medals?)\b.{0,60}\b(again|every time|same one|already (got|have|earned|reached)|repeat\w*|over and over)\b", re.I),
 'early_wins': re.compile(r"\b(first (week|few days|3 days|three days|day)|3 days|three days|7 days|seven days|one week|1 week|beginners?|just started|new user)\b.{0,80}\b(milestones?|badges?|celebrat\w*|congrat\w*|encourag\w*|motivat\w*|awards?|trophy|trophies)\b", re.I),
}
res={k:[] for k in Q}
for tag, base in (('A','App Store Reviews'),('P','Play Store Reviews')):
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f=os.path.join(d,'reviews.jsonl')
        if not os.path.exists(f): continue
        num=os.path.basename(d).split('.')[0]
        for i,line in enumerate(open(f,encoding='utf-8').read().split('\n')):
            if not line.strip(): continue
            try: r=json.loads(line)
            except Exception: continue
            t=((r.get('title') or '')+'. '+(r.get('body') or r.get('text') or r.get('content') or '')).strip()
            for k,rx in Q.items():
                m=rx.search(t)
                if m: res[k].append({'cite':f'{tag}{num}#{i}','app':os.path.basename(d)[:18],'rating':r.get('rating') or r.get('score'),'w':t[max(0,m.start()-140):m.end()+140]})
json.dump(res,open(os.path.join(ROOT,'Temp','milestone-today','showing.json'),'w')); print({k:len(v) for k,v in res.items()})
