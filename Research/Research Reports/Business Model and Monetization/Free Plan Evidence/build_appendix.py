"""Verify every citation in the report and build its appendix.
Checks: every `KEY` exists in the coded sample; every “quote” (`KEY`) occurs verbatim in that review."""
import json, re, os, html
OUT = os.path.dirname(os.path.abspath(__file__))
REPORT = os.path.join(OUT, '..', 'Free Plan Design — Habit Cap, Widgets and an Honest Listing.md')
C = {c['key']: c for c in (json.loads(l) for l in open(os.path.join(OUT, '../../../Temp/free-plan/candidates.jsonl'), encoding='utf-8'))}
coded = {r['key']: r for r in json.load(open(f'{OUT}/coded.json'))}
src = open(REPORT, encoding='utf-8').read()
body = src.split('<!-- APPENDIX -->')[0]
norm = lambda s: re.sub(r'\s+', ' ', html.unescape(s)).strip()
errs = []
for m in re.finditer(r'“([^”]+)”[^`\n]{0,120}?\(`([APN]\d+#\d+)`\)', body):
    q, k = m.group(1), m.group(2)
    if k not in coded: errs.append(f'not coded: {k}'); continue
    parts = [p for p in re.split(r'\s*\[…\]\s*', q) if p]
    if not all(norm(p) in norm(C[k]['text']) for p in parts): errs.append(f'quote not verbatim for {k}: {q[:70]}')
keys = list(dict.fromkeys(re.findall(r'`([APN]\d+#\d+)`', body)))
errs += [f'not coded: {k}' for k in keys if k not in coded]
print('citations', len(keys), 'errors', len(errs))
for e in errs: print(' ', e)
store = {'A': 'App Store', 'P': 'Play Store', 'N': 'App Store (native app)'}
rows = ['| Ref | Review ID | Store | App | Date | Stars | Codes |', '|---|---|---|---|---|---|---|']
for k in sorted(keys, key=lambda k: (k[0], int(k[1:].split('#')[0]), int(k.split('#')[1]))):
    r = coded[k]
    rows.append(f"| `{k}` | `{r['review_id']}` | {store[r['store']]} ({r['loc']}) | {r['app']} | {r['date']} | {r['rating']}★ | {', '.join(r['codes'])} |")
table = (f"## Appendix — reviews cited\n\n{len(keys)} reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + "
         f"line index in that app's `reviews.jsonl`.\n\n" + '\n'.join(rows) + '\n')
open(REPORT, 'w', encoding='utf-8').write(src.split('<!-- APPENDIX -->')[0] + '<!-- APPENDIX -->\n\n' + table)
