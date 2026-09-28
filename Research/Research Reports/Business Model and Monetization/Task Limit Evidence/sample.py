"""Reading set for the task-limit question. Every candidate from scan.py is read, except reviews whose only match is the
generic 'workaround / loophole' pattern with no paid, free, limit or habit word nearby (255 of 3,772; they were bug
workarounds in Calendar, Sheets, Notes and similar). Writes Temp/task-limit/keep.json and the reading batches
Temp/task-limit/batches/bNN.txt (about 26 KB each, sorted by store, app number, date)."""
import json, re, os
HERE = os.path.dirname(os.path.abspath(__file__))
T = os.path.abspath(os.path.join(HERE, '../../../Temp/task-limit'))
c = [json.loads(l) for l in open(f'{T}/candidates.jsonl')]
L = re.compile(r"limit|premium|\bpro\b|pay|paid|free|subscri|unlock|upgrade|habit", re.I)
keep = [r for r in c if not (r['modes'] == ['SHARED_OR_WORKAROUND'] and not L.search(r['text']))]
json.dump([r['key'] for r in keep], open(f'{T}/keep.json', 'w'))
keep.sort(key=lambda r: (r['store'], int(r['key'][1:].split('#')[0]), r['date']))
os.makedirs(f'{T}/batches', exist_ok=True)
b, cur, size = [], [], 0
for r in keep:
    t = re.sub(r'\s+', ' ', r['text']).strip()
    t = t[2:].strip() if t.startswith('||') else t
    line = f"{r['key']} | {r['app'][:24]} | {r['rating']}★ | {r['date'][:7]} | {r['loc']} | {t}"
    cur.append(line); size += len(line.encode())
    if size > 26000: b.append(cur); cur, size = [], 0
if cur: b.append(cur)
for i, x in enumerate(b, 1): open(f'{T}/batches/b{i:02d}.txt', 'w').write('\n'.join(x) + '\n')
print(len(c), 'candidates;', len(keep), 'read;', len(b), 'batches')
