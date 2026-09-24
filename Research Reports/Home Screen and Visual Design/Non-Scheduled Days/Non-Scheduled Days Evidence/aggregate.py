"""Validate hand codes and aggregate -> agg.json + printed tables.
Full set = tiers A + O + B (every candidate read). Rs = random 300 of the 13,743 generic mentions."""
import json, glob, collections, re
rows=[json.loads(l) for l in open('candidates.jsonl')]
tiers=json.load(open('tiers.json'))
VALID=set(re.findall(r'^\| ([A-Z+\-]+) \|',open('codebook.md').read(),re.M))-{'Code'}
NONHABIT_PLAY=('84. Tasks','126. To Do List','97. To-do list','111. My Study Life','122. Hevy','129. TrackIt','131. Skincare','100. To Do List','121. Bordio','95. iTask','117. Tiimo','107. Lil Planner')
def ctx(r):
    if r['store']=='native': return 'native'
    if r['store']=='play' and r['folder'].startswith(NONHABIT_PLAY): return 'nonhabit'
    return 'habit'
codes={}
for f in sorted(glob.glob('codes/*.txt')):
    for ln in open(f):
        if not ln.strip(): continue
        p=ln.rstrip('\n').split('\t'); idx=int(p[0]); cs=p[1].split()
        assert idx not in codes, ('dup',idx,f)
        bad=[c for c in cs if c not in VALID]; assert not bad,(f,idx,bad)
        codes[idx]=(cs,p[2] if len(p)>2 else '')
full_ids=tiers['A']+tiers['O']+tiers['B']; samp=tiers['Rs']
for name,exp in [('full',full_ids),('Rs',samp)]:
    miss=set(exp)-set(codes); print(name,'expected',len(exp),'missing',len(miss)); assert not miss
extra=set(codes)-set(full_ids)-set(samp); print('unknown',len(extra)); assert not extra
def table(ids,label):
    agg=collections.defaultdict(lambda:{'n':0,'stars':[],'apps':set(),'ctx':collections.Counter(),'ids':[]})
    for i in ids:
        for c in set(codes[i][0]):
            a=agg[c]; r=rows[i]; a['n']+=1; a['stars'].append(r['rating'] or 0); a['apps'].add(r['folder']); a['ctx'][ctx(r)]+=1; a['ids'].append(i)
    res={}
    print(f'\n== {label} ({len(ids)}) ==')
    for c,a in sorted(agg.items(),key=lambda x:-x[1]['n']):
        res[c]={'n':a['n'],'mean_star':round(sum(a['stars'])/len(a['stars']),2),'apps':len(a['apps']),'ctx':dict(a['ctx']),
                'top_apps':collections.Counter(rows[i]['folder'] for i in a['ids']).most_common(5),'ids':a['ids']}
        print(f"{c:6} n={a['n']:4} ★{res[c]['mean_star']} apps={len(a['apps']):3} ctx={dict(a['ctx'])} top={[(t[0][:22],t[1]) for t in res[c]['top_apps'][:3]]}")
    return res
out={'full':table(full_ids,'full A+O+B, all read'),'Rs':table(samp,'random sample of generic tier')}
rel=[i for i in full_ids if set(codes[i][0])-{'X'}]
relh=[i for i in rel if ctx(rows[i])=='habit']
print('\nrelevant (non-X) in full:',len(rel),'habit-app relevant:',len(relh))
print('by store (full read):',collections.Counter(rows[i]['store'] for i in full_ids))
out['den']={'screened':1487223,'candidates':len(rows),'A':len(tiers['A']),'O':len(tiers['O']),'B':len(tiers['B']),'R':len(tiers['R']),'Rs':len(samp),
            'full':len(full_ids),'relevant':len(rel),'relevant_habit':len(relh),'Rs_relevant':sum(1 for i in samp if set(codes[i][0])-{'X'})}
json.dump(out,open('agg.json','w'),default=list,indent=1)
