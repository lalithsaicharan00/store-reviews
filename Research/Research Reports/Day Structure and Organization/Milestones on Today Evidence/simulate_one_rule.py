"""One rule for every habit (17 Oct 2026, the user: "a predictable rule … scalable to any type of habit").

A habit is described by four settings, and its milestones follow from them:
  what it counts  : times (checks, checklists, times a period) | its unit (amounts) | hours (time)
  direction       : build | cut down | quit
  period          : day | week | month | year
  schedule        : every period | some days (Mon/Wed/Fri, every 3 days, set dates)

Three tracks, the same for every habit:
  1. The run: how long the run of met periods has lasted, on one ladder of time spans
       3 days, 1 week, 2 weeks, 1 month, 2 months, 3 months, 6 months, 9 months, 1 year, then every year
     keeping only spans of at least 2 periods; said in the period's own words (days, weeks, months).
     Cut down: periods within the limit. Quit: time since a slip (it also starts at 1 day).
  2. The total: one count, on the 1-2.5-5 x 10^n numbers, from the first that's at least 10 periods' worth
     of the goal. Checks count times; amounts their unit (bigger unit, k and M); time hours (at least 1 h);
     cut down the periods within the limit (never what was had); quit the clean days.
  3. Anniversaries: each year since the first log (since the quit for quit), unless the run says it that day.

Tiers: Pop-up for the run at 1 month, 6 months, 1 year and each year; totals at powers of ten; anniversaries.
Bar for every other first time. Row for anything reached before.
"""
import random

SPANS = [3, 7, 14, 30, 60, 90, 180, 270, 365, 730, 1095]   # in days

def series_from(start):
    out, e = [], 0
    while len(out) < 14:
        for m in (1, 2.5, 5):
            v = m * 10 ** e
            if v >= start: out.append(v)
        e += 1
    return out

def year(h, seed=1, days=365):
    name, counts, direction, period, goal, perweek = h
    rnd = random.Random(seed)
    plen = {"day": 1, "week": 7, "month": 30}[period]
    spans = [s for s in SPANS if s >= 2 * plen] if direction != "quit" else [1] + SPANS
    if period == "day" and perweek != 7: spans = [s for s in SPANS if s >= 7]
    per_goal = (goal / 60 if counts == "hours" else goal) if direction == "build" else 1
    total_rungs = series_from(max(10 * per_goal, 1 if counts == "hours" else 0))
    ev = []
    run_days = 0; total = 0.0; si = ti = 0
    step = plen if perweek in (None, 7) else 7 / perweek
    t = 0.0
    while t < days:
        ok = rnd.random() < (0.85 if direction != "quit" else 1.0)
        if direction == "quit" and int(t) == 120: ok = False
        if ok:
            run_days += step; total += per_goal if direction == "build" else (step if direction == "quit" else 1)
            while si < len(spans) and run_days >= spans[si]: ev.append((int(t), "run")); si += 1
            while ti < len(total_rungs) and total >= total_rungs[ti]: ev.append((int(t), "total")); ti += 1
        else:
            run_days = 0
            si = 0 if False else si   # a span already reached isn't given again
        t += step
    ev.append((365, "anniversary"))
    d = sorted(e[0] for e in ev)
    close = sum(1 for a, b in zip(d, d[1:]) if b - a <= 3)
    return len(ev), close

HABITS = [
    ("Stretch, every day", "times", "build", "day", 1, 7),
    ("Meds, 3 a day", "times", "build", "day", 1, 7),
    ("Study, Mon/Wed/Fri", "times", "build", "day", 1, 3),
    ("Water, 8 glasses", "unit", "build", "day", 8, 7),
    ("Steps, 10,000", "unit", "build", "day", 10000, 7),
    ("Read, 20 pages", "unit", "build", "day", 20, 7),
    ("Meditate, 10 min", "hours", "build", "day", 10, 7),
    ("Deep work, 4 h", "hours", "build", "day", 240, 7),
    ("Run, 20 km a week", "unit", "build", "week", 20, None),
    ("Gym, 3 times a week", "times", "build", "week", 3, None),
    ("Save $200 a month", "unit", "build", "month", 200, None),
    ("Coffee, at most 2 a day", "times", "cut", "day", 2, 7),
    ("Drinks, at most 5 a week", "times", "cut", "week", 5, None),
    ("Smoking, quit (a slip on day 120)", "times", "quit", "day", 1, 7),
]
print(f"{'habit':36} {'first year':>10} {'within 3 days':>14}")
for h in HABITS:
    n, c = year(h)
    print(f"{h[0]:36} {n:>10} {c:>14}")
