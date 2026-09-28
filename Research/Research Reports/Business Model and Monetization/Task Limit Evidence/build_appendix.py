"""Verify every citation in the report and build its appendix.
Checks: every `KEY` resolves to that line of the app's reviews.jsonl with the same review ID, and is in the coded set;
every "quote" in a line is found verbatim (ellipses split it into fragments) in the review cited next after it."""
import json, re, os, glob, html
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
REPORT = os.path.join(HERE, '..', 'Tasks in the Free Plan — Limit, Count or Plus.md')
coded = json.load(open(f'{HERE}/coded.json', encoding='utf-8'))
BASES = {'A': 'App Store Reviews', 'P': 'Play Store Reviews', 'N': 'Native Store Reviews'}

def review(k):
    store, n, i = k[0], k[1:].split('#')[0], int(k.split('#')[1])
    d = [d for d in glob.glob(f'{ROOT}/{BASES[store]}/{n}. */') if os.path.exists(d + 'reviews.jsonl')][0]
    with open(d + 'reviews.jsonl', encoding='utf-8') as f:
        for j, l in enumerate(f):
            if j == i: return json.loads(l)

norm = lambda s: re.sub(r'\s+', ' ', html.unescape(s).replace('’', "'").replace('‘', "'").replace('“', '"').replace('”', '"')).strip().lower()
src = open(REPORT, encoding='utf-8').read()
body = src.split('<!-- APPENDIX -->')[0]
keys = list(dict.fromkeys(re.findall(r'`([APN]\d+#\d+)`', body)))
errs, texts = [], {}
for k in keys:
    r = review(k)
    if r is None: errs.append(f'missing in reviews.jsonl: {k}'); continue
    if k not in coded: errs.append(f'not coded: {k}'); continue
    if str(r.get('review_id') or r.get('id')) != coded[k]['review_id']: errs.append(f'review id mismatch: {k}')
    texts[k] = norm((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or ''))
nq = 0
for line in body.split('\n'):
    pos = 0
    for m in re.finditer(r'`([APN]\d+#\d+)`', line):
        seg, pos = line[pos:m.start()], m.end()
        for q in re.findall(r'"([^"]{6,})"', seg):
            nq += 1
            parts = [p for p in re.split(r'\s*(?:\[…\]|…|\.\.\.)\s*', q) if len(p.strip()) > 1]
            if m.group(1) in texts and not all(norm(p) in texts[m.group(1)] for p in parts):
                errs.append(f'quote not verbatim for {m.group(1)}: {q[:80]}')
print('citations', len(keys), 'quotes checked', nq, 'errors', len(errs))
for e in errs: print(' ', e)
if errs: raise SystemExit(1)
store = {'A': 'App Store', 'P': 'Play Store', 'N': 'App Store (native app)'}
rows = ['| Ref | Review ID | Store | App | Date | Stars | Codes |', '|---|---|---|---|---|---|---|']
for k in sorted(keys, key=lambda k: (k[0], int(k[1:].split('#')[0]), int(k.split('#')[1]))):
    r = coded[k]
    rows.append(f"| `{k}` | `{r['review_id']}` | {store[k[0]]} ({r['loc']}) | {r['app']} | {r['date']} | {r['rating']}★ | {', '.join(r['codes'])} |")
table = (f"## Appendix — reviews cited\n\n{len(keys)} reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + "
         f"line index in that app's `reviews.jsonl`. Codes are defined in `Task Limit Evidence/codebook.md`; every coded review is in "
         f"`Task Limit Evidence/coded.json`.\n\n" + '\n'.join(rows) + '\n')
open(REPORT, 'w', encoding='utf-8').write(body + '<!-- APPENDIX -->\n\n' + table)
