"""Helpers: load candidates, citation ids, reading batches, code files."""
import json, re, random, os, glob
P = {'app':'A','play':'P','native':'N'}
NONHABIT_PLAY=('84. Tasks','126. To Do List','97. To-do list','111. My Study Life','122. Hevy','129. TrackIt','131. Skincare','100. To Do List','121. Bordio','95. iTask','117. Tiimo','107. Lil Planner')
def load(fam): return [json.loads(l) for l in open(f'cand/{fam}.jsonl')]
def cite(r): return f"{P[r['store']]}{r['folder'].split('.')[0]}#{r['line']-1}"
def ctx(r):
    if r['store']=='native': return 'native'
    if r['store']=='play' and r['folder'].startswith(NONHABIT_PLAY): return 'nonhabit'
    return 'habit'
def write_batches(rows, prefix, size=60, cap=1400):
    """rows: list of candidate dicts. Writes batches/<prefix>NN.txt; idx is position in rows."""
    n=0
    for b in range(0, len(rows), size):
        with open(f'batches/{prefix}{b//size:02d}.txt','w') as f:
            for i in range(b, min(b+size, len(rows))):
                r=rows[i]; t=r['text'].replace('\n',' ')
                if len(t)>cap: t=t[:cap]+' …'
                f.write(f"[{i}] {cite(r)} ★{r['rating']} {r['folder'][:22]} | {t}\n")
        n+=1
    return n
def read_codes(prefix):
    codes={}
    for f in sorted(glob.glob(f'codes/{prefix}*.txt')):
        for l in open(f):
            l=l.rstrip('\n')
            if not l.strip(): continue
            p=l.split('\t'); codes[int(p[0])]=(p[1].split(','), p[2] if len(p)>2 else '')
    return codes
def snippet(r, rx=None, w=420):
    """Short text: whole review if short, else a window around the match."""
    t=r['text'].replace('\n',' ')
    if len(t)<=2*w: return t
    import re as _re
    m=_re.search(_re.escape(r.get('m','')[:25]),t) if r.get('m') else None
    s=m.start() if m else 0
    a=max(0,s-w); b=min(len(t),s+w)
    return ('… ' if a>0 else '')+t[a:b]+(' …' if b<len(t) else '')
def write_idx_batches(rows, idxs, prefix, start=0, size=80, w=420):
    n=0
    for b in range(0,len(idxs),size):
        with open(f'batches/{prefix}{start+b//size:02d}.txt','w') as f:
            for i in idxs[b:b+size]:
                r=rows[i]; f.write(f"[{i}] {cite(r)} ★{r['rating']} {r['folder'][:22]} | {snippet(r,w=w)}\n")
        n+=1
    return n
