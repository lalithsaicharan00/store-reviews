"""Real habits through A21's milestone tracks (17 Oct 2026): how many milestones each gets in its first year,
and how often two tracks land within a few days of each other (a sign the tracks measure the same thing).

Each habit meets its goal on a random 85% of its planned days (seeded), with the goal amount each time.
Run: python3 -I simulate_real_habits.py
"""
import random, math

D = [3, 7, 14, 30, 50, 100, 150, 200, 250, 365, 500, 730, 1000]
T = [10, 25, 50, 66, 100, 250, 500, 750, 1000]
W = [2, 4, 8, 12, 26, 52, 78, 104]
M = [2, 3, 6, 9, 12, 18, 24, 36]

def series_from(start):
    """1-2.5-5 x 10^n values, from the first one >= start."""
    out, e = [], 0
    while len(out) < 12:
        for m in (1, 2.5, 5):
            v = m * 10 ** e
            if v >= start: out.append(v)
        e += 1
    return out

# (name, kind, period, goal, unit, planned days per week)
HABITS = [
    ("Stretch", "check", "day", 1, None, 7),
    ("Meds, 3 a day", "check", "day", 3, None, 7),
    ("Floss", "check", "day", 1, None, 7),
    ("Study, Mon/Wed/Fri", "check", "day", 1, None, 3),
    ("Water, 8 glasses", "amount", "day", 8, "glasses", 7),
    ("Water, 2,000 ml", "amount", "day", 2000, "ml", 7),
    ("Steps, 10,000", "amount", "day", 10000, "steps", 7),
    ("Push-ups, 50", "amount", "day", 50, "push-ups", 7),
    ("Read, 20 pages", "amount", "day", 20, "pages", 7),
    ("Save $5 a day", "amount", "day", 5, "$", 7),
    ("Run, 20 km a week", "amount", "week", 20, "km", None),
    ("Save $200 a month", "amount", "month", 200, "$", None),
    ("Meditate, 10 min", "time", "day", 10, "min", 7),
    ("Deep work, 4 h", "time", "day", 240, "min", 7),
    ("Guitar, 30 min", "time", "day", 30, "min", 7),
    ("Floss timer, 2 min", "time", "day", 2, "min", 7),
    ("Study, 5 h a week", "time", "week", 300, "min", None),
    ("Gym, 3 times a week", "times", "week", 3, None, None),
    ("Call family, 2 a month", "times", "month", 2, None, None),
]

def simulate(h, days=365, seed=1):
    rnd = random.Random(seed)
    name, kind, period, goal, unit, perweek = h
    ev = []  # (day, track, value)
    run = best = total_days = 0
    amount = 0.0
    U = None
    if kind in ("amount", "time"):
        g = goal / 60 if kind == "time" else goal  # time totals in hours
        U = series_from(max(10 * g, 1 if kind == "time" else 0))
    ui = di = ti = 0
    if period == "day":
        planned = [d for d in range(days) if perweek == 7 or (d % 7) in (0, 2, 4)]
        for d in planned:
            if rnd.random() < 0.85:
                run += 1; total_days += 1
                if kind in ("amount", "time"): amount += goal / 60 if kind == "time" else goal
                while di < len(D) and run >= D[di]: ev.append((d, "run", D[di])); di += 1
                while ti < len(T) and total_days >= T[ti]:
                    if not (T[ti] == 66 and perweek != 7): ev.append((d, "total", T[ti]))
                    ti += 1
                while U and ui < len(U) and amount >= U[ui]: ev.append((d, "unit", U[ui])); ui += 1
            else:
                run = 0
    else:
        plen = 7 if period == "week" else 30
        L = W if period == "week" else M
        li = 0
        for p in range(days // plen):
            if rnd.random() < 0.85:
                run += 1
                if kind == "times": total_days += goal
                else: amount += goal / 60 if kind == "time" else goal
                d = p * plen + plen - 1
                while li < len(L) and run >= L[li]: ev.append((d, "run", L[li])); li += 1
                while kind == "times" and ti < len(T) and total_days >= T[ti]:
                    if T[ti] != 66: ev.append((d, "total", T[ti]))
                    ti += 1
                while U and ui < len(U) and amount >= U[ui]: ev.append((d, "unit", U[ui])); ui += 1
            else:
                run = 0
    return ev, U

print(f"{'habit':26} {'run':>4} {'total':>5} {'unit':>4}  {'total & unit within 3 days':>26}  first unit rungs")
for h in HABITS:
    ev, U = simulate(h)
    c = {k: sum(1 for e in ev if e[1] == k) for k in ("run", "total", "unit")}
    tot = [e[0] for e in ev if e[1] == "total"]; un = [e[0] for e in ev if e[1] == "unit"]
    close = sum(1 for u in un if any(abs(u - t) <= 3 for t in tot))
    fmt = lambda v: (f"{v/1e6:g}M" if v >= 1e6 else f"{v/1e3:g}k" if v >= 1e3 else f"{v:g}")
    rungs = ", ".join(fmt(v) for v in (U or [])[:4])
    print(f"{h[0]:26} {c['run']:>4} {c['total']:>5} {c['unit']:>4}  {str(close) + ' of ' + str(len(un)) if un else '-':>26}  {rungs}")


# ---------- The simplified model (17 Oct 2026): one total per habit ----------
# check, checklist, times a period: times in total; amount and time: the unit total only (no "days the goal was met");
# cut down: days or weeks within the limit in total (never an amount); quit: clean days in total.
Q = [1, 3, 7, 14, 30, 60, 90, 180, 270, 365, 500, 730]
QT = [100, 250, 500, 1000]

def first_year_simplified(h):
    ev, U = simulate(h)
    kind = h[1]
    keep = [e for e in ev if not (kind in ("amount", "time") and e[1] == "total")]
    days = sorted(e[0] for e in keep)
    same_week = sum(1 for a, b in zip(days, days[1:]) if b - a <= 3)
    return len(keep) + 1, same_week  # + the first anniversary at day 365

def cut_down(period, seed=2):
    rnd = random.Random(seed); run = tot = 0; n = 0; L = D if period == "day" else W; li = ti = 0
    steps = 365 if period == "day" else 52
    for _ in range(steps):
        if rnd.random() < 0.8:
            run += 1; tot += 1
            while li < len(L) and run >= L[li]: n += 1; li += 1
            while ti < len(T) and tot >= T[ti]:
                if T[ti] != 66: n += 1
                ti += 1
        else:
            run = 0
    return n

def quit_year(slip_day=120):
    n = 0; clean = 0
    for start, end in ((0, slip_day), (slip_day + 1, 365)):
        length = end - start
        n += sum(1 for q in Q if q <= length and not (start > 0 and q <= slip_day))  # rungs already reached aren't repeated
    clean = 364
    n += sum(1 for q in QT if q <= clean)
    return n + 1  # + "your best run again" (the new run passes the old best of 120 days)

print("\nThe simplified model, first year:")
print(f"{'habit':26} {'milestones':>10} {'within 3 days of another':>26}")
for h in HABITS:
    n, close = first_year_simplified(h)
    print(f"{h[0]:26} {n:>10} {close:>26}")
print(f"{'Coffee, at most 2 a day':26} {cut_down('day'):>10}")
print(f"{'Drinks, at most 5 a week':26} {cut_down('week'):>10}")
print(f"{'Smoking, quit (a slip on day 120)':34} {quit_year():>2}")
