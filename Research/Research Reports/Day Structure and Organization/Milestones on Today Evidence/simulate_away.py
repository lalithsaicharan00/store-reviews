"""How often a milestone happens while the person isn't on Today (17 Oct 2026), using the adopted ladders (A21).
Quit: days since a slip (1, 3, 7, 14, 30, 60, 90, 180, 270, 365) plus total clean days (100, 250); only first-time
values count (repeats stay in the row). Build habits: first-time in-a-row values (3, 7, 14, 30, 50, 100, 150, 200,
250, 365) and totals (10, 25, 50, 66, 100, 250); a share of logs made on the widget, watch or a notification."""
import random, statistics as st
QUIT={1,3,7,14,30,60,90,180,270,365}; QTOT={100,250}
DAYS={3,7,14,30,50,100,150,200,250,365}; TOT={10,25,50,66,100,250}
def quit_year(n,slip,seed):
    r=random.Random(seed); run=[0]*n; best=[0]*n; clean=[0]*n; days=0
    for d in range(365):
        hit=False
        for h in range(n):
            if r.random()<slip(d): run[h]=0; continue
            run[h]+=1; clean[h]+=1
            if (run[h] in QUIT and run[h]>best[h]) or clean[h] in QTOT: hit=True
            best[h]=max(best[h],run[h])
        days+=hit
    return days
def build(n,p,share,horizon,starts,seed):
    r=random.Random(seed); run=[0]*n; best=[0]*n; tot=[0]*n; away=0; any_=0
    for d in range(horizon):
        a=b=False
        for h in range(n):
            if d<starts[h]: continue
            if r.random()<p:
                run[h]+=1; tot[h]+=1
                if (run[h] in DAYS and run[h]>best[h]) or tot[h] in TOT:
                    b=True
                    if r.random()<share: a=True
                best[h]=max(best[h],run[h])
            else: run[h]=0
        away+=a; any_+=b
    return away,any_
S=2000
q1=[quit_year(1,lambda d:0.0,s) for s in range(1)]
q2=[quit_year(2,lambda d:0.03 if d<30 else 0.01,s) for s in range(S)]
print("Quit, 1 habit, no slip, year 1: days with a first-time milestone:",q1[0])
print("Quit, 2 habits, slips 3%/day in month 1 then 1%, year 1:",round(st.mean(q2),1),"days")
for share in (0.2,0.5):
    nb=[build(5,0.85,share,90,[0]*5,s) for s in range(S)]
    eb=[build(8,0.85,share,365,[random.Random(9000+s).randrange(0,180) for _ in range(8)],s) for s in range(S)]
    print(f"Logs outside the app {int(share*100)}%: new user (5 habits, 90 days) away days {round(st.mean([a for a,_ in nb]),1)} of {round(st.mean([b for _,b in nb]),1)} milestone days; established (8 habits, a year) {round(st.mean([a for a,_ in eb]),1)} of {round(st.mean([b for _,b in eb]),1)}")
