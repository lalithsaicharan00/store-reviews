"""Write codes for one batch: python3 wc.py Q1_00 <<< 'idx|CODES|note' lines. Unlisted idx in the batch get X."""
import sys, re
b=sys.argv[1]; DEF=sys.argv[2] if len(sys.argv)>2 else "X"
idxs=[int(re.match(r'\[(\d+)\]',l).group(1)) for l in open(f'batches/{b}.txt') if l.startswith('[')]
given={}
for l in sys.stdin:
    l=l.strip()
    if not l: continue
    i,c,n=(l.split('|',2)+[''])[:3]
    i=int(i); assert i in idxs, f'{i} not in batch {b}'
    assert i not in given, f'dup {i}'
    given[i]=(c.strip(),n.strip())
with open(f'codes/{b}.txt','w') as f:
    for i in idxs:
        c,n=given.get(i,(DEF,""))
        f.write(f'{i}\t{c}\t{n}\n')
print(b, len(idxs),'lines', len(given),'coded non-default', sum(1 for v in given.values() if v[0]!='X'))
