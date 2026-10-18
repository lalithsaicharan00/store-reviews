"""Scan every review corpus for the five Today questions (16 Oct 2026). Writes hits_<topic>.jsonl."""
import json, re, os, glob, sys
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), *[".."]*4))
OUT = os.path.join(ROOT, "Temp", "today-best-ux")
P = {
 'place': [r"(anytime|any time|all[- ]day|untimed|no (set )?time)[^.!?\n]{0,60}\b(top|bottom|first|last|above|below|beginning|end of)\b",
           r"\b(at the top|on top|at the bottom|first|above|below)\b[^.!?\n]{0,40}(anytime|any time|all[- ]day)"],
 'quitplace': [r"(quit|counter|counters|addiction|bad habits?|vices?|sober|clean days?|days since)[^.!?\n]{0,60}(at the top|on top|at the bottom|pinned|front page|first thing|home screen|main screen|front)",
               r"(at the top|on top|at the bottom|pin|first thing)[^.!?\n]{0,40}(counter|counters|quit|addiction|bad habit)"],
 'newpos': [r"new (habit|habits|task|tasks|item|items|goal|goals)[^.!?\n]{0,60}\b(top|bottom|end|beginning|first|last)\b",
            r"\b(added|adds|appear|appears|goes|go|put|puts|placed)\b[^.!?\n]{0,25}\b(to|at|on) (the )?(top|bottom|end|beginning)\b"],
 'groupcolor': [r"\b(group|groups|category|categories|tag|tags|folder|folders|area|areas)\b[^.!?\n]{0,40}\bcolou?rs?\b",
                r"\bcolou?r[- ]?(code|coded|coding)\b[^.!?\n]{0,40}\b(group|groups|category|categories|tag|tags)\b"],
 'future': [r"\b(future|tomorrow|ahead of time|in advance|days ahead|upcoming days?)\b[^.!?\n]{0,50}\b(check|checked|mark|marked|log|logged|tick|ticked|complete|completed)\b",
            r"\b(check|checked|mark|marked|log|logged|tick|ticked|complete|completed)\b[^.!?\n]{0,40}\b(future|tomorrow|ahead of time|in advance)\b"],
 'arrange': [r"\b(reorder|re-order|rearrange|re-arrange|drag and drop|drag & drop|sort order|change the order|move (habits|tasks) (up|down))\b"],
}
C = {k:[re.compile(x, re.I) for x in v] for k,v in P.items()}
files = []
for base,tag in [('App Store Reviews','A'),('Play Store Reviews','P')]:
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d,'reviews.jsonl')
        if os.path.exists(f): files.append((tag, os.path.basename(d), f))
outs = {k: open(os.path.join(OUT, f'hits_{k}.jsonl'),'w') for k in P}
counts = {k:0 for k in P}; total=0
for tag, app, f in files:
    num = app.split('.')[0]
    with open(f, encoding='utf-8') as fh:
        for i, line in enumerate(fh):
            try: r = json.loads(line)
            except Exception: continue
            t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or '')).strip()
            if not t: continue
            total += 1
            for k, regs in C.items():
                m = next((m for rg in regs for m in [rg.search(t)] if m), None)
                if m:
                    s = max(0, m.start()-160); e = min(len(t), m.end()+160)
                    outs[k].write(json.dumps({'cite': f'{tag}{num}#{i}', 'app': app, 'id': r.get('review_id'), 'rating': r.get('rating'), 'snip': t[s:e]})+'\n')
                    counts[k]+=1
print('reviews scanned', total); print(counts)
