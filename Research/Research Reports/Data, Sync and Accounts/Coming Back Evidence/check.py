import json,glob,collections,html
rows={json.loads(l)['key']:json.loads(l) for l in open('candidates.jsonl')}
codes=set(l.split()[0] for l in open('CODEBOOK.md') if l[:1].isupper() and not l.startswith('One') and ' ' in l)
seen=collections.Counter(); bad=[]
for f in sorted(glob.glob('cls/batch-*.txt')):
    for ln in open(f):
        ln=ln.rstrip('\n')
        if not ln: continue
        k,c,q=ln.split('|',2); seen[k]+=1
        if k not in rows: bad.append(('unknown',k)); continue
        if c not in codes: bad.append(('code',k,c))
        if c!='OFF':
            t=html.unescape(rows[k]['text']).lower()
            if not q or html.unescape(q).lower() not in t: bad.append(('quote',k,q[:50]))
dups=[k for k,v in seen.items() if v>1]
print('coded',len(seen),'of',len(rows),'dups',dups,'problems',bad[:20])
