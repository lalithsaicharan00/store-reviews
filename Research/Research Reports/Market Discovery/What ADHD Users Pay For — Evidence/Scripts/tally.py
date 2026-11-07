import json,re,collections,glob,os
pool=json.load(open('pool.json')); led=json.load(open('ledger.json'))
inv={v:k for k,v in led.items()}
L2=json.load(open('ledger2.json')); inv.update({v:k for k,v in L2.items()})
idx={f"{o['s']}|{o['app'].split('.')[0]}|{o['src']}|{o['id']}":o for o in pool}
P={};S=set();SUS={71,240,514,525};CH=set()
for f in sorted(glob.glob('codes/c*.py'),key=lambda x:int(re.search(r'c(\d+)',x).group(1))):
    g={};exec(open(f).read(),g)
    for k,v in g['P'].items():
        assert k not in P or P[k]==v,(k,f); P[k]=v
    S|=set(g.get('S',[]));SUS|=set(g.get('SUS',[]));CH|=set(g.get('CH',[]))
for f in sorted(glob.glob('codes2/w*.py')):
    g={};exec(open(f).read(),g)
    for k,v in g['P'].items():
        P[k]=(P[k]+' '+v) if k in P else v
    for k,v in g.get('CHP',{}).items(): P[k]=v; CH.add(k)
    S|=set(g.get('S',[]))
S-=set(P)
g={};exec(open('codes/bx.py').read(),g);BX={int(k):v.split() for k,v in g['BX'].items()}
rows=[]
for i,c in P.items():
    k=inv.get(i)
    if k is None or k not in idx: continue
    o=idx[k]; parts=c.split()
    st=parts[0]
    rows.append(dict(i=i,o=o,st=st,B=[p[2:] for p in parts if p.startswith('B:')]+BX.get(i,[]),H=[p[2:] for p in parts if p.startswith('H:')],M=[p[2:] for p in parts if p.startswith('M:')],sus=i in SUS,ch=i in CH))
AL=[('Tiimo','Tiimo'),('HabitNow','HabitNow'),('Habit Tracker - Goal Tracker','Habit Tracker: Goal Tracker & ADHD Planner'),('Fabulous','Fabulous'),('RoutineFlow','RoutineFlow'),('Routine Planner, Habit Tracker','Routinery'),('Routinery','Routinery'),('Goblin','Goblin Tools'),('Me+','Me+'),('Structured','Structured'),('Tiimo','Tiimo'),('Inflow','Inflow'),('Finch','Finch'),('Forest','Forest'),('Clarify','Clarify'),('Brain.fm','Brain.fm'),('Music for Focus','Brain.fm'),('neurolist','neurolist'),('dubbii','dubbii'),('HabitNow','HabitNow'),('TickTick','TickTick'),('Todoist','Todoist'),('Todoery','Todoery'),('Numo','Numo'),('Joon','Joon'),('Alarmy','Alarmy'),('Focus Friend','Focus Friend'),('Focus To-Do','Focus To-Do'),('Focus Keeper','Focus Keeper'),('Brili','Brili'),('Productive','Productive'),('Sectograph','Sectograph'),('Due ','Due'),('Things 3','Things 3'),('Engross','Engross'),('Tasks - To','Tasks'),('Habit Tracker','Habit Tracker (several)'),('EndeavorOTC','EndeavorOTC'),('TimeTune','TimeTune'),('LifeUp','LifeUp'),('Streaks','Streaks'),('Habitica','Habitica')]
def appname(o):
    n=re.sub(r'^\d+\.\s*','',o['app'])
    for a,b in AL:
        if a in n: return b
    return n[:24]
if __name__=='__main__':
    print('coded payers',len(P),'in pool',len(rows))
    print(collections.Counter(r['st'] for r in rows), 'sus',sum(r['sus'] for r in rows),'ch',sum(r['ch'] for r in rows))
    main=[r for r in rows if not r['sus'] and not r['ch']]
    print('main',len(main),collections.Counter(r['st'] for r in main),collections.Counter(r['o']['s'] for r in main))
    Sin=[i for i in S if inv.get(i) in idx]; print('S hand',len(Sin))
    for name,key in (('B','B'),('H','H'),('M','M')):
        c=collections.Counter(x for r in main for x in set(r[key]))
        print(name,c.most_common(45))
    any_=collections.Counter()
    for r in main:
        for x in set(r['B']+r['H']): any_[x]+=1
    print('B+H',any_.most_common(45))
    c=collections.Counter(appname(r['o'])[:24] for r in main); print(c.most_common(45))
    print(len(c),'apps')
