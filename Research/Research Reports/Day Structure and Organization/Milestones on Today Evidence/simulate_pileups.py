"""Milestones on Today, second follow-up (17 Oct 2026): how often several habits reach a milestone on the same day.
Uses the app's ladders (iOS/Habits/Model/Milestones.swift): days 3, 7, 10, 14, 30, 50, 75, 100, 150, 200, 250, 365;
in total 10, 25, 50, 100, 250, 500. Daily habits only. One tap shows the bigger of a streak and an in-total milestone."""
import random, statistics as st
DAYS={3,7,10,14,30,50,75,100,150,200,250,365}; TOTAL={10,25,50,100,250,500}
def run(n_habits, p, horizon, starts, seed):
    rnd=random.Random(seed); streak=[0]*n_habits; total=[0]*n_habits
    per_day=[]
    for d in range(horizon):
        k=0
        for h in range(n_habits):
            if d<starts[h]: continue
            if rnd.random()<p(d-starts[h]):
                streak[h]+=1; total[h]+=1
                if streak[h] in DAYS or total[h] in TOTAL: k+=1
            else: streak[h]=0
        per_day.append(k)
    return per_day
def summary(name, n, p, horizon, starts_fn, sims=2000):
    days_any=[];days2=[];days3=[];events=[];maxk=[]
    first14_3plus=[]
    for s in range(sims):
        pd=run(n,p,horizon,starts_fn(s),s)
        events.append(sum(pd)); days_any.append(sum(1 for k in pd if k)); days2.append(sum(1 for k in pd if k>=2)); days3.append(sum(1 for k in pd if k>=3)); maxk.append(max(pd))
        first14_3plus.append(sum(1 for k in pd[:14] if k>=3))
    f=lambda xs: round(st.mean(xs),1)
    print(f"{name}: milestones {f(events)}, days with one or more {f(days_any)}, with 2+ {f(days2)}, with 3+ {f(days3)}, most in one day {f(maxk)}; days with 3+ in the first two weeks {f(first14_3plus)}")
# A new person: 5 daily habits added the same day, every one done every day
summary("A. 5 habits, same day, done every day, 90 days", 5, lambda t:1.0, 90, lambda s:[0]*5, sims=1)
# The same person, realistically: 90% in week 1, then 80%
summary("B. 5 habits, same day, 90% then 80%, 90 days", 5, lambda t:0.9 if t<7 else 0.8, 90, lambda s:[0]*5)
# An established person: 8 habits added over 6 months, 85% done, one year
summary("C. 8 habits added over 6 months, 85%, 1 year", 8, lambda t:0.85, 365, lambda s:[random.Random(1000+s).randrange(0,180) for _ in range(8)])
# The same, 95% done (a very consistent person)
summary("D. 8 habits added over 6 months, 95%, 1 year", 8, lambda t:0.95, 365, lambda s:[random.Random(1000+s).randrange(0,180) for _ in range(8)])

# The same people, counting a streak milestone only the first time the habit ever reaches it (a new best);
# in-total milestones count once anyway.
def run_new(n_habits, p, horizon, starts, seed):
    rnd=random.Random(seed); streak=[0]*n_habits; total=[0]*n_habits; best=[0]*n_habits; per_day=[]
    for d in range(horizon):
        k=0
        for h in range(n_habits):
            if d<starts[h]: continue
            if rnd.random()<p(d-starts[h]):
                streak[h]+=1; total[h]+=1
                new_streak = streak[h] in DAYS and streak[h]>best[h]
                best[h]=max(best[h],streak[h])
                if new_streak or total[h] in TOTAL: k+=1
            else: streak[h]=0
        per_day.append(k)
    return per_day
run=run_new
print("--- counting a streak milestone only when it's a new best for that habit ---")
summary("B'. 5 habits, same day, 90% then 80%, 90 days", 5, lambda t:0.9 if t<7 else 0.8, 90, lambda s:[0]*5)
summary("C'. 8 habits added over 6 months, 85%, 1 year", 8, lambda t:0.85, 365, lambda s:[random.Random(1000+s).randrange(0,180) for _ in range(8)])
summary("D'. 8 habits added over 6 months, 95%, 1 year", 8, lambda t:0.95, 365, lambda s:[random.Random(1000+s).randrange(0,180) for _ in range(8)])
