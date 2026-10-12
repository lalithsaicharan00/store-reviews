"""Seeded random histories for the golden cases: every kind of habit and schedule, goal history, skips, pauses, archives,
timers, tasks, times of day, every week start and day start, and time zones with daylight saving. The same seed always
gives the same case (Python's `random.Random` is stable across versions for `random()`, `randint` and `choice`).
"""
import datetime as dt
import random

from fixturelib import Case

ZONES = ["Europe/London", "America/New_York", "America/Los_Angeles", "Asia/Kolkata", "Australia/Lord_Howe",
         "Pacific/Kiritimati", "Pacific/Pago_Pago", "Europe/Berlin", "America/Sao_Paulo", "Asia/Tokyo",
         "America/St_Johns", "Asia/Kathmandu", "Australia/Sydney", "UTC"]
# Days the clocks change in some of the zones above, so "now" often falls on one.
CHANGES = ["2026-03-08", "2026-03-29", "2026-10-25", "2026-11-01", "2026-10-04", "2026-04-05", "2027-03-14",
           "2027-03-28", "2027-10-31", "2027-11-07", "2027-10-03", "2027-04-04"]
UNITS = ["glasses", "ml", "km", "pages", "steps", "cups", "euro", "times", ""]


def k(day):
    return day.isoformat()


def random_frequency(rng, kind):
    roll = rng.random()
    if kind == "task":
        options = ["daily", ("weekdays", rng.sample(range(1, 8), rng.randint(1, 4))), ("every", rng.randint(2, 5)),
                   ("after", rng.randint(1, 3), rng.choice(["day", "week", "month"])),
                   ("calendar", {"unit": "week", "interval": rng.randint(1, 3), "weekdays": rng.sample(range(1, 8), 2),
                                 "anchorWeekStart": rng.randint(1, 7)})]
        return rng.choice(options)
    if roll < 0.25:
        return "daily"
    if roll < 0.37:
        return ("weekdays", rng.sample(range(1, 8), rng.randint(1, 6)))
    if roll < 0.43:
        return ("every", rng.randint(1, 6))
    if roll < 0.47:
        return ("weeks", rng.randint(1, 3))
    if roll < 0.51:
        return ("dates", rng.sample(range(1, 32), rng.randint(1, 3)))
    if roll < 0.63:
        return (rng.choice(["week", "week", "month", "year"]), rng.randint(1, 5))
    if roll < 0.78:
        return ("flexible", rng.choice(["week", "week", "month", "year"]), rng.randint(1, 5))
    if roll < 0.95:
        unit = rng.choice(["day", "week", "month", "year"])
        cal = {"unit": unit, "interval": rng.randint(1, 3), "anchorWeekStart": rng.randint(1, 7)}
        if unit == "week":
            cal["weekdays"] = rng.sample(range(1, 8), rng.randint(1, 3))
        elif unit == "month":
            pattern = rng.choice(["Dates", "Dates", "Last day", "Weekday"])
            cal["pattern"] = pattern
            cal["dates"] = rng.sample(range(1, 32), rng.randint(1, 3))
            cal["useLastDay"] = rng.random() < 0.6
            cal["ordinal"] = rng.choice([1, 2, 3, 4, 5, -1])
            cal["weekday"] = rng.randint(1, 7)
        elif unit == "year":
            cal["month"] = rng.randint(1, 12)
            cal["day"] = rng.randint(1, 31)
            cal["useLastDay"] = rng.random() < 0.6
        return ("calendar", cal)
    return ("after", rng.randint(1, 3), rng.choice(["day", "week", "month"]))


def seeded_case(seed, detail="rules"):
    rng = random.Random(seed)
    tz = rng.choice(ZONES)
    if rng.random() < 0.3:
        today = dt.date.fromisoformat(rng.choice(CHANGES)) + dt.timedelta(days=rng.randint(-1, 1))
    else:
        today = dt.date(2026, 1, 5) + dt.timedelta(days=rng.randint(0, 700))
    hour = rng.choice([0, 1, 2, 3, 6, 9, 12, 15, 18, 21, 23, rng.randint(0, 23)])
    day_end = 0 if rng.random() < 0.55 else rng.randint(1, 12)
    week_start = rng.randint(1, 7)
    # "Now" is a wall-clock time; the store works out which day it belongs to.
    c = Case(f"seeded-{seed}", ["seeded"], tz=tz, now=(k(today), hour, rng.randint(0, 59)), day_end=day_end,
             week_start=week_start, window=(k(today - dt.timedelta(days=20)), k(today + dt.timedelta(days=6))), detail=detail)
    history = rng.randint(20, 140)
    first = today - dt.timedelta(days=history)
    for _ in range(4):
        c.probe(k(today + dt.timedelta(days=rng.randint(-2, 1))), rng.randint(0, 23), rng.randint(0, 59))

    if rng.random() < 0.2:
        c.sections([{"id": "anytime", "name": "Anytime"}, {"id": "early", "name": "Early", "start": 300},
                     {"id": "midday", "name": "Midday", "start": 690}, {"id": "late", "name": "Late", "start": 1200, "end": 1500}])
        part_ids = ["anytime", "early", "midday", "late"]
    else:
        part_ids = ["anytime", "morning", "afternoon", "evening"]
    if rng.random() < 0.2:
        c.card_order(rng.sample(part_ids[1:] + ["anytime", "quitting"], 3))

    for _ in range(rng.randint(1, 6)):
        kind = rng.choices(["check", "amount", "duration", "checklist", "quit", "task"], [35, 20, 10, 10, 10, 15])[0]
        freq = random_frequency(rng, kind) if kind != "quit" else "daily"
        created_day = first + dt.timedelta(days=rng.randint(0, max(1, history // 3)))
        if rng.random() < 0.1:
            created_day = today - dt.timedelta(days=rng.randint(0, 5))
        created = (k(created_day), rng.randint(0, 23), rng.randint(0, 59))
        unit = None
        increment = 1.0
        at_most = False
        goal = 1
        steps = 0
        if kind == "check":
            goal = rng.choice([1, 1, 1, 2, 3])
            if freq[0] in ("week", "month", "year"):
                goal = freq[1]
            if rng.random() < 0.15:
                unit = rng.choice(["glasses", "times"])
            at_most = rng.random() < 0.03
        elif kind == "amount":
            unit = rng.choice(UNITS)
            goal = rng.choice([2, 5, 8, 10, 100, 2000, 1.5])
            increment = rng.choice([1, 0.5, 250, goal, 0])
            at_most = rng.random() < 0.25
        elif kind == "duration":
            goal = rng.choice([10, 20, 30, 45, 90, 600])
            at_most = rng.random() < 0.15
        elif kind == "checklist":
            steps = rng.randint(1, 4)
        parts = "anytime"
        reminders = []
        if kind != "task" and rng.random() < 0.35:
            parts = ",".join(rng.sample(part_ids[1:], rng.randint(1, 2)))
        if rng.random() < 0.3:
            reminders = [(rng.randint(0, 23), rng.choice([0, 15, 30, 45])) for _ in range(rng.randint(1, 3))]
        starts = ends = due = None
        if rng.random() < 0.15:
            starts = k(created_day + dt.timedelta(days=rng.randint(-10, 20)))
        if rng.random() < 0.1:
            ends = k(today + dt.timedelta(days=rng.randint(-25, 10)))
        if kind == "task" and rng.random() < 0.55:
            due = k(today + dt.timedelta(days=rng.randint(-8, 6)))
        archived = rng.random() < 0.08
        quit_since = None
        if kind == "quit" and rng.random() < 0.3:
            quit_since = c.at(k(created_day + dt.timedelta(days=rng.randint(-20, 10))), rng.randint(0, 23))
        made = c.habit(kind=kind, freq=freq, goal=goal, unit=unit, increment=increment, at_most=at_most, created=created,
                       starts=starts, ends=ends, due=due, part=parts, reminders=reminders, steps=steps,
                       quit_since=quit_since, archived=c.at(k(today - dt.timedelta(days=rng.randint(0, 15))), 10) if archived else None)
        hid, step_ids = made if steps else (made, [])
        if archived and rng.random() < 0.6:
            c.archived_on(hid, k(today - dt.timedelta(days=rng.randint(0, 20))))

        # Goal history: what the habit was judged by before an edit.
        if kind not in ("quit", "task") and rng.random() < 0.2:
            until = today - dt.timedelta(days=rng.randint(15, 40))
            for _ in range(rng.randint(1, 2)):
                old_kind = kind if rng.random() < 0.8 else rng.choice(["check", "amount"])
                c.rule(hid, k(until), goal=rng.choice([1, 2, 3, 5, 8]), freq=random_frequency(rng, old_kind),
                       kind=old_kind, unit=unit if old_kind == "amount" else None, steps=step_ids[:max(1, len(step_ids) - 1)])
                until += dt.timedelta(days=rng.randint(3, 12))
                if until >= today:
                    break

        # The logs, day by day.
        p = rng.choice([0.2, 0.5, 0.75, 0.9, 1.0])
        day = max(first, created_day - dt.timedelta(days=2))
        while day <= today:
            if kind == "quit":
                if rng.random() < 0.06:
                    c.log(hid, k(day), 1, hour=rng.randint(0, 23), minute=rng.randint(0, 59))
            elif kind == "task":
                if (due is None and rng.random() < p * 0.6) or (due is not None and day >= dt.date.fromisoformat(due) - dt.timedelta(days=1) and rng.random() < 0.3):
                    c.log(hid, k(day))
            elif rng.random() < p:
                tz_log = tz if rng.random() < 0.9 else rng.choice(ZONES)
                hour = rng.randint(0, 23)
                if kind == "check":
                    slot = rng.choice(parts.split(",")) if "," in parts and rng.random() < 0.5 else None
                    for _ in range(rng.choice([1, 1, 1, 2, 3])):
                        c.log(hid, k(day), 1, hour=hour, tz=tz_log, slot=slot)
                elif kind == "amount":
                    for _ in range(rng.randint(1, 3)):
                        c.log(hid, k(day), rng.choice([0.5, 1, 2, 3, 250, goal / 2, goal]), hour=hour, tz=tz_log)
                elif kind == "duration":
                    c.log(hid, k(day), rng.choice([5, 10, 15.5, 30, 60, goal]), hour=hour, tz=tz_log)
                elif kind == "checklist":
                    for s in rng.sample(step_ids, rng.randint(1, len(step_ids))):
                        c.log(hid, k(day), 1, hour=hour, tz=tz_log, step=s)
            day += dt.timedelta(days=1)

        if kind not in ("quit",) and rng.random() < 0.12:
            for _ in range(rng.randint(1, 3)):
                c.skip(hid, k(today - dt.timedelta(days=rng.randint(0, 25))))
        if kind != "task" or due is None:
            if rng.random() < 0.15:
                start = today - dt.timedelta(days=rng.randint(0, 40))
                through = None if rng.random() < 0.3 else start + dt.timedelta(days=rng.randint(0, 10))
                c.pause(hid, k(start), k(through) if through else None, paused_at=c.at(k(start), rng.randint(0, 23)),
                        resumed_at=c.at(k(through), rng.randint(0, 23)) if through and rng.random() < 0.3 else None)
            if rng.random() < 0.05:
                start = today + dt.timedelta(days=rng.randint(1, 5))
                c.pause(hid, k(start), k(start + dt.timedelta(days=rng.randint(0, 5))), paused_at=c.at(k(today), 8))
        if kind == "duration" and rng.random() < 0.25:
            c.timer(hid, c.now_ms - rng.randint(1, 240) * 60_000)
        if kind == "task" and due is None and rng.random() < 0.2:
            frm = today + dt.timedelta(days=rng.randint(-3, 3))
            c.move(hid, k(frm), k(frm + dt.timedelta(days=rng.randint(1, 3))))
    return c
