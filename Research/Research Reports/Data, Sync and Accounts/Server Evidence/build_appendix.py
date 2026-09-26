"""Verify every citation in the Data Safety report and build Appendix A.
Checks: every `KEY` exists in the coded sample; every “quote” (`KEY`) occurs verbatim in that review."""
import json, re, os, html, collections
OUT = os.path.dirname(os.path.abspath(__file__))
REPORT = '/Users/lalith/Desktop/store reviews/Architecture/06. Server on Cloudflare.md'
C = {c['key']: c for f in (f'{OUT}/candidates.jsonl', f'{OUT}/../sync/candidates.jsonl', f'{OUT}/../migration/candidates.jsonl', f'{OUT}/../backup/candidates.jsonl', f'{OUT}/../billing/candidates.jsonl', f'{OUT}/../accounts/candidates.jsonl', f'{OUT}/../data-safety/candidates.jsonl') for c in (json.loads(l) for l in open(f, encoding='utf-8'))}
coded = {r['key']: r for r in json.load(open(f'{OUT}/coded-all.json'))}
src = open(REPORT, encoding='utf-8').read()
body = src.split('<!-- APPENDIX -->')[0]
norm = lambda s: re.sub(r'\s+', ' ', html.unescape(s)).strip()
errs, keys = [], []
for m in re.finditer(r'\(`([APN]\d+#\d+)`', body):
    k = m.group(1); keys.append(k)
    if k not in coded: errs.append(f'not in coded sample: {k}'); continue
    pre = body[max(0, m.start() - 500):m.start()].rstrip()
    if not pre.endswith('”'): continue          # reference without a quote
    pre = pre[:-1]
    text = norm(C[k]['text'])
    ok = any(norm(pre[i + 1:]) in text for i in [j for j, ch in enumerate(pre) if ch == '“'])
    if not ok: errs.append(f'quote not verbatim for {k}: …{pre[-70:]}')
keys += re.findall(r'`([APN]\d+#\d+)`', body)
errs += [f'not in coded sample: {k}' for k in set(keys) if k not in coded]
keys = list(dict.fromkeys(keys))
print('citations', len(keys), 'errors', len(errs))
for e in errs: print(' ', e)
store = {'A': 'App Store', 'P': 'Play Store', 'N': 'App Store (native app)'}
rows = ['| Ref | Review ID | Store | App | Date | Stars | Codes |', '|---|---|---|---|---|---|---|']
for k in sorted(keys, key=lambda k: (k[0], int(k[1:].split('#')[0]), int(k.split('#')[1]))):
    r = coded[k]
    rows.append(f"| `{k}` | `{r['review_id']}` | {store[r['store']]} ({r['loc']}) | {r['app']} | {r['date']} | {r['rating']}★ | {', '.join(r['codes'])} |")
table = f"{len(keys)} reviews cited. Ref = store letter + app number + line index in that app's `reviews.jsonl`.\n\n" + '\n'.join(rows) + '\n'
head, tail = src.split('<!-- APPENDIX -->')
tail = tail[tail.index('## Appendix B'):] if '## Appendix B' in tail else tail
open(REPORT, 'w', encoding='utf-8').write(head + '<!-- APPENDIX -->\n\n' + table + '\n' + tail)
