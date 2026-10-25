import json, glob, re, os, sys, collections
ROOT = '/home/user/store-reviews/Research'
def load():
    for store, pat in (('A', 'App Store Reviews/*/reviews.jsonl'), ('P', 'Play Store Reviews/*/reviews.jsonl')):
        for f in glob.glob(os.path.join(ROOT, pat)):
            folder = os.path.basename(os.path.dirname(f))
            n = folder.split('.')[0]
            if not n.isdigit(): continue
            for line in open(f, encoding='utf-8'):
                r = json.loads(line)
                text = ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')).strip()
                yield dict(id=f"{store}{n}#{r['review_id']}", app=f"{store}{n}", name=folder, rating=r['rating'], date=r['date'][:10], text=text)
