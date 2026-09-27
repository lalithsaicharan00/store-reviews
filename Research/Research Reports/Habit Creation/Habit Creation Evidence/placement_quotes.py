import json, glob, os, re, sys
import os
ids = sys.argv[1].split(',')
want = {}
for i in ids:
    s, rest = i[0], i[1:]; app, line = rest.split('#'); want.setdefault((s, app), {})[int(line)] = i
base = {'A': 'App Store Reviews', 'P': 'Play Store Reviews'}
out = {}
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..'))
os.chdir(ROOT)
for (s, app), lines in want.items():
    d = [x for x in glob.glob(f'{base[s]}/*/') if re.match(rf'{app}\.', os.path.basename(x.rstrip('/')))][0]
    for n, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
        if n in lines:
            r = json.loads(l)
            out[lines[n]] = dict(app=r.get('app_name') or os.path.basename(d.rstrip('/')), id=r.get('review_id') or r.get('reviewId') or r.get('id'),
                                 rating=r.get('rating') or r.get('score'), date=(r.get('date') or r.get('at') or '')[:10],
                                 text=((r.get('title') or '') + ' — ' + (r.get('body') or r.get('text') or '')).strip())
for i in ids: print(i, '|', out[i]['app'][:40], '|', out[i]['id'], '|', out[i]['rating'], '|', out[i]['date'], '\n   ', out[i]['text'][:600].replace('\n', ' '), '\n')
