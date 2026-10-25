import re, json
from scan import load
have = {r['id'] for r in json.load(open('pass2.json'))}
p = re.compile(r"\bbars?\b|\b(swip|slid|drag)\w*", re.I)
extra = []
for r in load():
    if r['app'] in ('A1','A31') and r['id'] not in have and p.search(r['text']) and len(r['text'])>=15:
        r['keys']=['app-bar']; extra.append(r)
print(len(extra))
allr = json.load(open('pass2.json')) + extra
allr.sort(key=lambda r:(r['app'], r['id']))
json.dump(allr, open('pool.json','w'))
print(len(allr))
# write chunks
chunk, n, size = [], 0, 0
def flush():
    global chunk, n, size
    if chunk:
        open(f'read_{n:02d}.txt','w').write('\n'.join(chunk)); n += 1; chunk=[]; size=0
for r in allr:
    t = re.sub(r'\s+',' ', r['text'])
    line = f"{r['id']} [{r['rating']}★ {r['name'][:28]}] {t}"
    chunk.append(line); size += len(line)
    if size > 60000: flush()
flush()
print(n, 'chunks')
