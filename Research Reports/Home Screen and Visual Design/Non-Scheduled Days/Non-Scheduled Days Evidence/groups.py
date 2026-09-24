"""Outcome groups used in the report (unions of hand codes + hand-picked subsets). -> groups.json"""
import json,glob,collections
rows=[json.loads(l) for l in open('candidates.jsonl')]; tiers=json.load(open('tiers.json'))
codes={}
for f in glob.glob('codes/*.txt'):
    for ln in open(f):
        p=ln.rstrip('\n').split('\t'); codes[int(p[0])]=set(p[1].split())
full=set(tiers['A']+tiers['O']+tiers['B'])
exec(open('aggregate.py').read().split('codes={}')[0].split('rows=')[0])  # nothing
NONHABIT_PLAY=('84. Tasks','126. To Do List','97. To-do list','111. My Study Life','122. Hevy','129. TrackIt','131. Skincare','100. To Do List','121. Bordio','95. iTask','117. Tiimo','107. Lil Planner')
def ctx(r):
    if r['store']=='native': return 'native'
    if r['store']=='play' and r['folder'].startswith(NONHABIT_PLAY): return 'nonhabit'
    return 'habit'
def having(*cs): return {i for i in full if codes[i]&set(cs)}
G={}
G['penalised']=having('MISS-','STRK-','PCT-')
G['penalised_flex']={i for i in G['penalised'] if 'FLEX' in codes[i]}
G['penalised_fixed']=G['penalised']-G['penalised_flex']
G['distinct_mark']=having('GREYR','GREY+')
G['distinct_asked']=having('GREYR'); G['distinct_praised']=having('GREY+')
G['marker_bad']=having('GREY-')
G['grid_only_scheduled']={4028,4711,9267,9392,5889,5901,6216,6280,6365,14555,14556,15838}
G['grid_only_scheduled_habit']={4028,4711,9267,9392}
G['show_whole_week']={2173,2183,2196,2200,9191,9220,9335,9337,9447,11321}
G['xweek_which_days']={48,77,287,409,1992,2312,2975,3950,4952}
G['today_hide']=having('TODAY-','HIDER','HIDE+'); G['today_hide_praise']=having('HIDE+')
G['today_greyed_disliked']={2235,3039,2960,8577,9192}
G['see_plan']=having('SEE','SEE+'); G['extra_offday']=having('EXTRA'); G['no_tick_offday']=having('NOCHK')
G['off_plus']=having('OFF+'); G['skip_req']=having('SKIPR'); G['skip_praise']=having('SKIP+'); G['skip_against']=having('SKIP-')
G['calendar_offdays']=having('CALOFF'); G['flex']=having('FLEX'); G['sched_req']=having('SCHR'); G['sched_bug']=having('SCH-')
out={}
for k,s in G.items():
    s=sorted(s); st=[rows[i]['rating'] or 0 for i in s]
    out[k]={'n':len(s),'star':round(sum(st)/max(len(st),1),2),'apps':len({rows[i]['folder'] for i in s}),
            'ctx':dict(collections.Counter(ctx(rows[i]) for i in s)),'store':dict(collections.Counter(rows[i]['store'] for i in s)),'ids':s}
    print(f"{k:26} n={len(s):4} ★{out[k]['star']} apps={out[k]['apps']:3} ctx={out[k]['ctx']}")
json.dump(out,open('groups.json','w'),indent=1)
