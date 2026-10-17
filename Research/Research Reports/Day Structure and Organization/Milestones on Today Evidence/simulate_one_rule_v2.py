"""One rule for every habit, v2 (17 Oct 2026, the user: the run should count "how we are counting towards totals",
and handle several times a day).

One number series for everything: 1, 2, 5, 10, 20, 50, 100, 200, 500, 1,000 … (1-2-5 x 10^n).

  The run   counts its periods in a row whose goal was met, in the habit's own word:
            days (every day), times (some days: Mon/Wed/Fri, every 3 days), weeks, months, years (a period goal),
            days or weeks within the limit (cut down), days since a slip (quit).
            It starts at 5 for a day goal, 2 for a week, month or year goal, and 1 for quit.
  The total counts everything logged, whether or not the goal was met that day:
            each tick (checks, checklists, times a period), the amount (in the bigger unit), hours;
            cut down: the periods within the limit (never what was had); quit: the clean days.
            It starts at the first number that's at least 10 periods' worth of the goal (time: at least 1 h).
  Pop-up    at 10 x and 100 x where each track starts (and every 10 x after), and every anniversary.
  Bar       every other first time.  Row: anything reached before.

A total the run has already said (the same number, nothing missed yet) is skipped.

Several times a day (Meds 3 a day): the run needs all 3 for a day to count; the total counts every tick, from
10 x 3 = 30, so 50, 100, 200 … ticks. A day with 2 of 3 doesn't extend the run but still adds 2 to the total.
"""
import random

def series(start):
    out, e = [], 0
    while len(out) < 16:
        for m in (1, 2, 5):
            v = m * 10 ** e
            if v >= start - 1e-9: out.append(v)
        e += 1
    return out

def year(h, seed=1, days=365):
    name, counts, direction, period, goal, perweek, partial = h
    rnd = random.Random(seed)
    plen = {"day": 1, "week": 7, "month": 30}[period]
    run_start = 1 if direction == "quit" else (5 if period == "day" else 2)
    R = series(run_start)
    per_goal = (goal / 60 if counts == "hours" else goal) if direction == "build" else 1
    U = series(max(10 * per_goal, 1 if counts == "hours" else 0))
    pops_r = {R[0] * 10 ** k for k in (1, 2, 3)}; pops_u = {U[0] * 10 ** k for k in (1, 2, 3)}
    ev = []; run = best = 0; total = 0.0; ri = ui = 0
    step = plen if perweek in (None, 7) else 7 / perweek
    t = 0.0
    while t < days:
        r = rnd.random()
        met = r < 0.85 if direction != "quit" else int(t) != 120
        logged = per_goal if met else (per_goal * partial if direction == "build" and r < 0.95 else 0)
        if met:
            run += 1; best = max(best, run)
            while ri < len(R) and best >= R[ri]: ev.append((int(t), "run", R[ri], R[ri] in pops_r)); ri += 1
        else:
            run = 0
        total += logged if direction == "build" else (1 if met else 0)
        while ui < len(U) and total >= U[ui]:
            said = counts == "times" and per_goal == 1 and any(e[1] == "run" and e[2] == U[ui] for e in ev)
            if not said: ev.append((int(t), "total", U[ui], U[ui] in pops_u))
            ui += 1
        t += step
    ev.append((365, "anniversary", 1, True))
    d = sorted(e[0] for e in ev)
    close = sum(1 for a, b in zip(d, d[1:]) if b - a <= 3)
    pops = [f"{e[1]} {e[2]:g} (day {e[0]})" for e in ev if e[3]]
    first = min(ev)[0]
    return len(ev), close, first, pops, R[:6], U[:6]

HABITS = [
    # name, counts, direction, period, goal, perweek (some days), partial share logged on a missed day
    ("Stretch, every day", "times", "build", "day", 1, 7, 0),
    ("Meds, 3 a day", "times", "build", "day", 3, 7, 2/3),
    ("Water, 8 checks a day", "times", "build", "day", 8, 7, 0.6),
    ("Study, Mon/Wed/Fri", "times", "build", "day", 1, 3, 0),
    ("Water, 8 glasses", "unit", "build", "day", 8, 7, 0.6),
    ("Steps, 10,000", "unit", "build", "day", 10000, 7, 0.6),
    ("Meditate, 10 min", "hours", "build", "day", 10, 7, 0.5),
    ("Deep work, 4 h", "hours", "build", "day", 240, 7, 0.5),
    ("Run, 20 km a week", "unit", "build", "week", 20, None, 0.5),
    ("Gym, 3 times a week", "times", "build", "week", 3, None, 2/3),
    ("Save $200 a month", "unit", "build", "month", 200, None, 0.5),
    ("Coffee, at most 2 a day", "times", "cut", "day", 2, 7, 0),
    ("Drinks, at most 5 a week", "times", "cut", "week", 5, None, 0),
    ("Smoking, quit (a slip on day 120)", "times", "quit", "day", 1, 7, 0),
]
fmt = lambda v: (f"{v/1e6:g}M" if v >= 1e6 else f"{v/1e3:g}k" if v >= 1e3 else f"{v:g}")
print(f"{'habit':34} {'year 1':>6} {'≤3 days apart':>13} {'first':>5}  run starts / total starts   pop-ups in year 1")
for h in HABITS:
    n, c, first, pops, R, U = year(h)
    print(f"{h[0]:34} {n:>6} {c:>13} {('day ' + str(first)):>8}  {'/'.join(fmt(x) for x in R[:3])} | {'/'.join(fmt(x) for x in U[:3])}   {'; '.join(pops)}")
