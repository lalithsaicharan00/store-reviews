"""Once a habit is done (16 Oct 2026): logging beyond the goal, and telling done from not done."""
import json, re, os, glob
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))
Q = {
 'beyond': re.compile(r"(go|went|going) (over|above|beyond) (my |the )?(goal|target)|exceed(ed|ing)? (my |the )?(goal|target)|above and beyond|more than (my|the) (goal|target)|past (my|the) (goal|target)|after (reaching|hitting|meeting|completing) (my |the )?(goal|target)|(can'?t|cannot|won'?t let me|unable to) (add|log|track|count|record) (more|any more|anymore|extra)|extra (glass|glasses|minutes|reps|times|cups|pages)|over ?achiev", re.I),
 'tell_done': re.compile(r"(hard|difficult|can'?t|cannot|unclear|confus\w*) (to )?(tell|see|know|distinguish)\w* (if|whether|which|what)\w* .{0,40}(done|complete|finished|checked)|looks? (like it'?s|as if it'?s|the same as) (not )?(done|complete)|(done|completed) (and|vs\.?|versus|from) (not done|undone|incomplete|uncompleted)|check ?mark (when|once|after) (it'?s |i'?m )?(done|complete|finished)|turns? (into )?a (check|tick)", re.I),
}
res = {k: [] for k in Q}
dirs = [('A','App Store Reviews'),('P','Play Store Reviews')]
for tag, base in dirs:
    for d in sorted(glob.glob(os.path.join(ROOT, base, '*'))):
        f = os.path.join(d, 'reviews.jsonl')
        if not os.path.exists(f): continue
        num = os.path.basename(d).split('.')[0]
        for i, line in enumerate(open(f, encoding='utf-8')):
            try: r = json.loads(line)
            except Exception: continue
            t = ((r.get('title') or '') + '. ' + (r.get('body') or r.get('text') or r.get('content') or '')).strip()
            for k, rx in Q.items():
                m = rx.search(t)
                if m: res[k].append({'cite': f'{tag}{num}#{i}', 'app': os.path.basename(d)[:20], 'c': m.start(), 'text': t[:2000]})
json.dump(res, open(os.path.join(ROOT,'Temp','done-state','q.json'),'w'))
print({k: len(v) for k, v in res.items()})
