import json, re, glob, os, collections
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..'))
RX = {
 'coarse_over_exact': r"\b(rather than|instead of|without|not|no need for|don'?t (want|need|have)( to set)?|doesn'?t (require|force)|not tied to) (a |an )?(specific|exact|set|particular|strict|fixed) (time|hour|clock time)s?\b|\b(specific|exact|set|fixed) times? (is|are|feels?) (too )?(rigid|stressful|restrictive)\b",
 'forced_time': r"\b(forced|force[sd]?|have|has|must|required|requires|making me|makes me|need) to (set|choose|pick|enter|add|give) (a |an )?(time|reminder|notification|alarm)s?\b",
}
C = {k: re.compile(v, re.I) for k, v in RX.items()}
hits = collections.defaultdict(list)
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); t = ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')).strip()
            for k, rx in C.items():
                mm = rx.search(t)
                if mm: hits[k].append((f'{store}{m.group(1)}#{i}', r.get('rating') or r.get('score'), t[max(0,mm.start()-250):mm.end()+250]))
for k, v in hits.items(): print(k, len(v))
json.dump(hits, open(f'{os.path.dirname(os.path.abspath(__file__))}/placement_hits2.json', 'w'), ensure_ascii=False)
