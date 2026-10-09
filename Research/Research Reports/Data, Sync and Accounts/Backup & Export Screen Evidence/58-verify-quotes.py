"""Check every review ID cited in 58-backup-review-evidence.md exists in the corpus and every quote on the same bullet
appears word for word (HTML-unescaped, whitespace-collapsed) in that review."""
import json, re, html, glob
ROOT = '/home/user/store-reviews/Research'
ids = {}
for base in ['App Store Reviews', 'Play Store Reviews']:
    for f in glob.glob(f'{ROOT}/{base}/*/reviews.jsonl'):
        for l in open(f, encoding='utf-8'):
            r = json.loads(l); t = (r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')
            ids[str(r['review_id'])] = re.sub(r'\s+', ' ', html.unescape(t))
md = open(f'{ROOT}/Temp/58-backup-review-evidence.md', encoding='utf-8').read()
# join bullets / table rows into units
units, cur = [], ''
for line in md.split('\n'):
    if re.match(r'\s*(- |\| |#|$)', line) and not line.startswith('    '):
        if cur: units.append(cur)
        cur = line
    else:
        cur += ' ' + line.strip()
units.append(cur)
idrx = re.compile(r'`(\d{9,11}|[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})(?:…)?`')
missing, bad, ok = [], [], 0
for u in units:
    found = idrx.findall(u)
    for i in found:
        if i not in ids: missing.append(i)
    quotes = re.findall(r'"([^"]{12,})"', u)
    if len(set(found)) == 1 and quotes:
        t = ids.get(found[0], '')
        for q in quotes:
            qn = re.sub(r'\s+', ' ', q.strip())
            if qn in t: ok += 1
            else: bad.append((found[0], qn[:90]))
    elif len(set(found)) > 1 and quotes:
        # pair each quote with the first id after it
        for m in re.finditer(r'"([^"]{12,})"', u):
            nxt = idrx.search(u, m.end())
            if not nxt: continue
            qn = re.sub(r'\s+', ' ', m.group(1).strip()); t = ids.get(nxt.group(1), '')
            if qn in t: ok += 1
            else: bad.append((nxt.group(1), qn[:90]))
print('ids cited', len(set(idrx.findall(md))), 'missing', missing)
print('quotes ok', ok, 'bad', len(bad))
for b in bad: print(b)
