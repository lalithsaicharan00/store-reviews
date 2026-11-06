import re,collections,random,pickle
exec(open('lift.py').read().split("allen=[r")[0])
T={
'A companion/self-care pet':['Finch','TeddyCare','Roubit','Habit Rabbit','HabitYou','Dear Me','Eden','Mindway','Habit Hearts','Cozy','Meow Habits','Blossom'],
'B guided self-improvement':['Fabulous','Me+','Life Reset','Atoms','Wisey','Lasting Change','Ultiself','That Girl','Grit','Habio','GetHabit','Critique AI','Glowin','Micro Habits','Intelligent Change','Miracle Morning','Morning Habits','Book Morning','21 Days','Onrise','Not Boring','ShineDay'],
'C ADHD/routine planner':['RoutineFlow','Routine Planner, Habit','Tiimo','Lil Planner','RoutineWin','Rabit','Avocation','MyRoutine','Daily Routine - Organise','Routineday','PlanMe','Habit Hub','Bordio','Respawn','OneFlow','Habitude'],
'E gamified RPG':['Habitica','Habit Hunter','Habicat','Levla','HabitForge','Habit Fantasy','StreakUp','Fun Habit'],
'F quit/sobriety':['Days Since','Quit Bad Habits','Days Without'],
'G to-do lists':['126. To Do List','Tasks - To Do','To-do list','To Do List - Daily','iTask','Tappsk','Habit Tracker - To-Do List'],
'H niche other':['Skincare','Habit Hero','Habit Health','Study'],
}
def typ(name):
    for t,ks in T.items():
        if any(k in name for k in ks): return t
    return 'D generic tracker'
allen=[r for r in rows if r[4]]
st=collections.defaultdict(lambda:[0,0,0,0,0,set()]); allc=collections.Counter()
for r in rows: allc[typ(r[1])]+=1
hb=collections.defaultdict(list)
for r in allen:
    t=typ(r[1]); s=st[t]; s[0]+=1
    pp=r[3]>=4 and bool(PAID.search(r[5])); s[1]+=pp; s[2]+=bool(RESIST.search(r[5])); s[3]+=r[3]; s[4]+=bool(PAID.search(r[5])); s[5].add(r[1])
    if pp: hb[t].append(r)
for t in sorted(st):
    s=st[t]; print(f"{t:28} apps={len(s[5]):3} allReviews={allc[t]:7} en={s[0]:6} anyPaid={100*s[4]/s[0]:.2f}% happyBuyer={100*s[1]/s[0]:.2f}% resist={100*s[2]/s[0]:.2f}% ★{s[3]/s[0]:.2f}  happyN={len(hb[t])}")
random.seed(7)
samp={}
for t,L in hb.items():
    L=[r for r in L if 25<=len(r[5].split())<=180]
    samp[t]=random.sample(L,min(len(L),22))
pickle.dump(samp,open('sample.pkl','wb'))
with open('sample.txt','w') as f:
    for t,L in sorted(samp.items()):
        f.write(f"\n===== {t} =====\n")
        for r in L: f.write(f"[{r[0]} | {r[1]} | {r[2]} | {r[3]}★ | {r[6]}] {r[5]}\n")
