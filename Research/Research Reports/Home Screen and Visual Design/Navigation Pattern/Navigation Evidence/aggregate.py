"""Validate hand codes and aggregate. Output: agg.json + printed tables."""
import json, glob, collections, re
rows=[json.loads(l) for l in open('candidates.jsonl')]
tiers=json.load(open('tiers.json')); ft=json.load(open('ftiers.json'))
VALID={'DR+','DR-','DRR','TB+','TB-','TBR','RD','HID','DEEP','REACH','ONE','NAV+','NAV-','NAVL','SWP','FAB','CLT','X','TABF','TABG','HIDS'}
NONHABIT_PLAY=('84. Tasks','126. To Do List','97. To-do list','111. My Study Life','122. Hevy','129. TrackIt','131. Skincare')
def ctx(r):
    if r['store']=='native': return 'native'
    if r['store']=='play' and r['folder'].startswith(NONHABIT_PLAY): return 'nonhabit'
    return 'habit'
def load(pattern):
    m={}
    for f in sorted(glob.glob(pattern)):
        for ln in open(f):
            if not ln.strip(): continue
            p=ln.rstrip('\n').split('\t')
            idx=int(p[0]); codes=p[1].split()
            assert idx not in m, f'dup {idx} in {f}'
            bad=[c for c in codes if c not in VALID]; assert not bad, (f,idx,bad)
            m[idx]=(codes, p[2] if len(p)>2 else '')
    return m
S=load('codes/S*.txt'); FC=load('codes/FC*.txt'); FR=load('codes/FR*.txt'); G=load('codes/G.txt')
# validation
for name,m,expect in [('S',S,tiers['S']),('FC',FC,ft['Fcore']),('FR',FR,ft['Frest_sample']),('G',G,json.load(open('g_sample.json')))]:
    miss=set(expect)-set(m); extra=set(m)-set(expect)
    print(f'{name}: coded {len(m)} / expected {len(expect)}; missing {len(miss)}; unknown {len(extra)}')
    assert not miss and not extra
full={**S,**FC}  # fully hand-read sets
out={}
def table(m,label):
    agg=collections.defaultdict(lambda: {'n':0,'stars':[], 'apps':set(),'ctx':collections.Counter(),'ids':[]})
    for idx,(codes,_) in m.items():
        r=rows[idx]
        for c in set(codes):
            a=agg[c]; a['n']+=1; a['stars'].append(r['rating'] or 0); a['apps'].add(r['folder']); a['ctx'][ctx(r)]+=1; a['ids'].append(idx)
    res={}
    for c,a in sorted(agg.items(), key=lambda x:-x[1]['n']):
        res[c]={'n':a['n'],'mean_star':round(sum(a['stars'])/len(a['stars']),2),'apps':len(a['apps']),'ctx':dict(a['ctx']),
                'top_apps':collections.Counter(rows[i]['folder'] for i in a['ids']).most_common(4),'ids':a['ids']}
    out[label]=res
    print(f'\n== {label} ==')
    for c,v in res.items():
        print(f"{c:6} n={v['n']:4} ★{v['mean_star']} apps={v['apps']:3} ctx={v['ctx']} top={[(t[0][:18],t[1]) for t in v['top_apps'][:3]]}")
table(full,'full (S + Fcore, all hand-read)')
table(FR,'Frest sample (200 of 1,539)')
table(G,'G sample (200 of 3,098)')
# relevant-set denominators
rel={i:v for i,v in full.items() if set(v[0])-{'X','TABF','TABG'}}
print('\nrelevant (non-X, non-TABF/TABG only) in full set:',len(rel))
out['denominators']={'screened':1487223,'S':len(S),'Fcore':len(FC),'full':len(full),'relevant_full':len(rel),'Frest':len(ft['Frest']),'G':len(tiers['G'])}
# Fabulous concentration
fab=sum(1 for i in rel if 'Fabulous' in rows[i]['folder'])
print('Fabulous share of relevant:',fab)
out['fabulous_relevant']=fab
json.dump(out,open('agg.json','w'),default=list,indent=1)
