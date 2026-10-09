"""58: second pass. Reviews naming two or more of backup / export / sync / restore-import together with a confusion or
expectation word; and 'where is my data' questions. Same app set as 58-backup-scan.py. Writes 58-confuse.json."""
import json, re, glob, os
ROOT = '/home/user/store-reviews/Research'
I = re.I
K = {'backup': re.compile(r"\bback ?-?ups?\b|\bbacking up\b|\bbacked up\b", I), 'export': re.compile(r"\bexport", I),
     'sync': re.compile(r"\bsync|synchroni[sz]", I), 'restore': re.compile(r"\brestor\w*|\bimport\w*", I)}
CONF = re.compile(r"confus|difference|unclear|don'?t understand|didn'?t understand|not sure (what|how|if|whether)|thought (it|this|the app|my|that|i)|expected|assumed|misleading|isn'?t (a |the same|real)|not (a |the same|real) (sync|backup)|instead of|rather than|same thing|which (one|is)|what('?s| is) the point", I)
WHERE = re.compile(r"where (is|does|are|do) (my|the|all|our) (data|habits|backup|progress|info\w*|records?)\b|where.{0,20}(data|backup)\w* (is |are )?(stored|saved|kept|go(es)?|backed)|(don'?t|doesn'?t|didn'?t) (know|say|tell|explain|realize|realise) (where|if|whether|that).{0,40}(backed up|saved|stored|synced|local)", I)
EXCL = ['To Do List','Tasks -','School Planner','Gym','Video Calls','Bordio','Skincare','Tiimo','Calendar - ','Reminders','Notes']
out = []
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        if any(x in d for x in EXCL) or not os.path.exists(d + 'reviews.jsonl'): continue
        n = os.path.basename(d.rstrip('/')).split('.')[0]; app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            r = json.loads(l); t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            ks = [k for k, rx in K.items() if rx.search(t)]
            modes = []
            if len(ks) >= 2 and CONF.search(t): modes.append('MIXED_CONF')
            if WHERE.search(t): modes.append('WHERE_DATA')
            if modes:
                out.append({'key': f'{store}{n}#{i}', 'app': app, 'review_id': r.get('review_id'), 'rating': r.get('rating'),
                            'date': (r.get('date') or '')[:10], 'modes': modes, 'kinds': ks, 'text': t})
json.dump(out, open(f'{ROOT}/Temp/58-confuse.json', 'w'), ensure_ascii=False)
print(len(out), sum('MIXED_CONF' in x['modes'] for x in out), sum('WHERE_DATA' in x['modes'] for x in out))
