#!/usr/bin/env python3
"""Writes the golden cases' inputs (Core/fixtures/README.md).

    python3 Core/fixtures/tools/generate.py            # every input, into Core/fixtures/inputs/
    python3 Core/fixtures/tools/generate.py --hashes   # and print each file's SHA-256

The hand-written cases are committed; the seeded ones, the year and the 15-year account are made again by this script
wherever they're needed (they're large), and each recorded answer file names the SHA-256 of the input it answered, so a
reader can tell they match.
"""
import datetime as dt
import hashlib
import os
import random
import sys

sys.path.insert(0, os.path.dirname(__file__))
from fixturelib import Case, write  # noqa: E402
import hand  # noqa: E402
import seeded  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
INPUTS = os.path.join(HERE, "..", "inputs")
SEEDED_FILES = 4
SEEDED_PER_FILE = 500


def year_case():
    """A year and a bit of history (450 days), every kind of habit: Today, Progress's Year and the Watch's 400 days."""
    rng = random.Random(2026)
    today = dt.date(2026, 10, 12)
    first = today - dt.timedelta(days=450)
    c = Case("year of history", ["year"], tz="Europe/London", now=(today.isoformat(), 12, 0), week_start=2,
             window=((today - dt.timedelta(days=40)).isoformat(), (today + dt.timedelta(days=7)).isoformat()), watch=True)
    created = (first.isoformat(), 8, 0)
    every = c.habit(name="Every day for 450 days", created=created)
    water = c.habit(kind="amount", unit="glasses", goal=8, created=created)
    walk = c.habit(kind="duration", goal=30, created=created)
    gym = c.habit(freq=("week", 3), goal=3, created=created)
    km = c.habit(kind="amount", unit="km", freq=("flexible", "week", 3), goal=5, created=created)
    coffee = c.habit(kind="amount", unit="cups", goal=2, at_most=True, created=created)
    lst, steps = c.habit(kind="checklist", steps=3, created=created)
    read = c.habit(freq=("weekdays", [2, 3, 4, 5, 6]), created=created)
    books = c.habit(kind="amount", unit="pages", freq=("month", 1), goal=300, created=created)
    smoke = c.habit(kind="quit", created=created)
    c.habit(kind="task", due=today.isoformat(), created=(today.isoformat(), 7))
    rent = c.habit(kind="task", freq=("calendar", {"unit": "month", "interval": 1, "dates": [1]}), created=created)
    day = first
    while day <= today:
        k = day.isoformat()
        c.log(every, k, hour=8)
        if rng.random() < 0.85:
            c.log(water, k, rng.choice([6, 8, 9, 10]))
        if rng.random() < 0.7:
            c.log(walk, k, rng.choice([20, 30, 45]))
        if day.weekday() in (0, 2, 4) and rng.random() < 0.9:
            c.log(gym, k)
        if rng.random() < 0.5:
            c.log(km, k, rng.choice([3, 5, 6]))
        c.log(coffee, k, rng.choice([1, 2, 2, 3]))
        for s in steps:
            if rng.random() < 0.8:
                c.log(lst, k, step=s)
        if day.weekday() < 5 and rng.random() < 0.8:
            c.log(read, k)
        c.log(books, k, rng.choice([5, 10, 15]))
        if rng.random() < 0.02:
            c.log(smoke, k, hour=21)
        if day.day == 1:
            c.log(rent, k)
        day += dt.timedelta(days=1)
    c.pause(walk, (today - dt.timedelta(days=100)).isoformat(), (today - dt.timedelta(days=90)).isoformat())
    c.skip(read, (today - dt.timedelta(days=3)).isoformat())
    c.rule(water, (today - dt.timedelta(days=200)).isoformat(), kind="amount", unit="glasses", goal=6)
    return c


def extreme_case(years=15, per_year=25_000):
    """The extreme account (Rulebook T1, Core's 15-year account): about 25,000 records a year for 15 years."""
    rng = random.Random(15)
    today = dt.date(2026, 10, 12)
    first = today - dt.timedelta(days=365 * years)
    c = Case("extreme account", ["extreme"], tz="Europe/London", now=(today.isoformat(), 12, 0), week_start=2,
             window=((today - dt.timedelta(days=14)).isoformat(), (today + dt.timedelta(days=3)).isoformat()), watch=True)
    created = (first.isoformat(), 8, 0)
    habits = []
    for i in range(40):
        kind = ["check", "amount", "duration", "check", "amount"][i % 5]
        freq = ["daily", ("week", 3), ("flexible", "week", 4), ("weekdays", [2, 4, 6]), ("month", 1)][(i // 5) % 5]
        goal = {"check": 3 if freq == ("week", 3) else 1, "amount": 8, "duration": 30}[kind]
        if freq == ("month", 1) and kind != "check":
            goal *= 20
        habits.append((c.habit(kind=kind, freq=freq, goal=goal, unit="glasses" if kind == "amount" else None,
                               at_most=(i == 9), created=created), kind))
    per_day = per_year / 365
    day = first
    while day <= today:
        k = day.isoformat()
        n = int(per_day) + (1 if rng.random() < per_day - int(per_day) else 0)
        for _ in range(n):
            hid, kind = habits[rng.randrange(len(habits))]
            c.log(hid, k, 1 if kind == "check" else rng.choice([1, 2, 5, 10]), hour=rng.randint(6, 22))
        day += dt.timedelta(days=1)
    return c


def sha(path):
    with open(path, "rb") as f:
        return hashlib.sha256(f.read()).hexdigest()


def main():
    os.makedirs(INPUTS, exist_ok=True)
    made = []
    path = os.path.join(INPUTS, "hand.json")
    write(path, hand.cases())
    made.append(path)
    for f in range(SEEDED_FILES):
        cases = []
        for i in range(SEEDED_PER_FILE):
            seed = f * SEEDED_PER_FILE + i + 1
            cases.append(seeded.seeded_case(seed, detail="full" if seed % 25 == 0 else "rules"))
        path = os.path.join(INPUTS, f"seeded-{f + 1}.json")
        write(path, cases)
        made.append(path)
    path = os.path.join(INPUTS, "year.json")
    write(path, [year_case()])
    made.append(path)
    if "--no-extreme" not in sys.argv:
        path = os.path.join(INPUTS, "zz-extreme.json")
        write(path, [extreme_case()])
        made.append(path)
    if "--hashes" in sys.argv:
        for p in made:
            print(sha(p), os.path.getsize(p), os.path.basename(p))


if __name__ == "__main__":
    main()
