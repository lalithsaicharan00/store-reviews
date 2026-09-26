"""Validate the hand-coded sample: every key read, no unknown/duplicate keys, every quote verbatim in its review."""
import json, glob, os, re, html, collections
OUT = os.path.dirname(os.path.abspath(__file__))
TMP = os.path.abspath(os.path.join(OUT, '../../../Temp/backlog1-family'))
C = {c['key']: c for c in (json.loads(l) for l in open(f'{TMP}/candidates.jsonl', encoding='utf-8'))}
sample = [s['key'] for s in json.load(open(f'{OUT}/sample-index.json'))]
seen, errs, rows = set(), [], []
for f in sorted(glob.glob(f'{OUT}/cls/batch-*.txt')):
    for n, line in enumerate(open(f, encoding='utf-8'), 1):
        line = line.rstrip('\n')
        if not line: continue
        key, codes, quote = line.split('|', 2)
        if key not in C: errs.append(f'{f}:{n} unknown key {key}'); continue
        if key in seen: errs.append(f'{f}:{n} duplicate {key}')
        seen.add(key)
        codes = codes.split(',')
        if codes != ['NR'] and not quote: errs.append(f'{f}:{n} {key} coded without quote')
        q = quote.strip('"')
        if q:
            t = C[key]['text']
            if q not in t and html.unescape(q) not in html.unescape(t):
                errs.append(f'{f}:{n} {key} quote not found: {q[:60]}')
        rows.append({'key': key, 'codes': codes, 'quote': q, **{k: C[key][k] for k in ('store', 'app', 'review_id', 'rating', 'date', 'loc')}})
missing = [k for k in sample if k not in seen]
extra = [k for k in seen if k not in set(sample)]
print('coded', len(seen), 'of sample', len(sample), '| missing', len(missing), '| extra', len(extra), '| errors', len(errs))
for e in errs[:40]: print(' ', e)
if missing: print('missing:', missing[:20])
json.dump(rows, open(f'{OUT}/coded.json', 'w'), ensure_ascii=False, indent=0)
