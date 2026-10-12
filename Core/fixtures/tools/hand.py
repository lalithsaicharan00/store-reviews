"""Hand-written golden cases, one or more per rule in Core/spec/ (named after the rule they test).

Unless a case says otherwise: London, "now" is Friday 25 September 2026 at 12:00, weeks start on Monday, days end at
midnight, and the days asked about are 14 September to 2 October.
"""
from fixturelib import Case, moment_ms

H = "2026-09-"


def d(n, month=9, year=2026):
    return f"{year:04d}-{month:02d}-{n:02d}"


def cases():
    out = []

    # ---------------------------------------------------------------- The day (spec/day.md)
    c = Case("DAY-1 a moment's day, midnight start", ["DAY-1", "DAY-5"])
    for h, m in [(0, 0), (0, 1), (11, 59), (23, 59)]:
        c.probe(d(25), h, m)
    c.probe(d(26), 0, 0)
    c.habit()
    out.append(c)

    for end in (1, 3, 6, 12):
        c = Case(f"DAY-2 day start at {end}", ["DAY-1", "DAY-2", "DAY-5"], day_end=end, now=(d(26), max(0, end - 1), 30))
        for h in sorted({0, end - 1, end, end + 1, 23}):
            if 0 <= h <= 23:
                c.probe(d(25), h, 0)
                c.probe(d(25), h, 59)
        h = c.habit(created=(d(1), 9))
        for day in (22, 23, 24, 25):
            c.log(h, d(day))
        c.log(h, d(25), hour=max(0, end - 1), minute=10)
        out.append(c)

    # Daylight saving: the day starts by the clock, both ways (Rulebook D7; Build Plan #61).
    for tz, spring, fall, ends in [("Europe/London", d(29, 3), d(25, 10), (0, 1, 2, 3)),
                                   ("America/New_York", d(8, 3), d(1, 11), (0, 1, 2, 3)),
                                   ("Australia/Lord_Howe", d(4, 10), d(5, 4), (0, 2, 3)),
                                   ("Australia/Sydney", d(4, 10), d(5, 4), (0, 2, 3))]:
        for which, change in (("spring", spring), ("fall", fall)):
            for end in ends:
                y, m, dd = (int(x) for x in change.split("-"))
                c = Case(f"DAY-3 {tz} {which} day start {end}", ["DAY-1", "DAY-3", "DAY-5", "DAY-11"], tz=tz, day_end=end,
                         now=(change, 12, 0), window=(d(dd - 3 if dd > 3 else 1, m, y), d(min(dd + 3, 28), m, y)))
                for h in range(0, 5):
                    for mm in (0, 30):
                        c.probe(change, h, mm)
                        c.probe(change, h, mm, fold=1)
                hab = c.habit(created=(d(1, m, y), 9))
                q = c.habit(kind="quit", created=(d(1, m, y), 9))
                c.log(q, change, hour=4)
                c.pause(hab, d(dd - 2 if dd > 2 else 1, m, y), d(dd - 1 if dd > 1 else 1, m, y))
                c.pause(q, change, change, paused_at=c.at(change, 6), resumed_at=c.at(change, 9))
                out.append(c)

    c = Case("DAY-4 a log keeps its day when travelling", ["DAY-4"], tz="America/Los_Angeles")
    h = c.habit(created=(d(1), 9))
    c.log(h, d(23), hour=23, tz="Asia/Tokyo")   # saved for the 23rd in Tokyo, the 23rd's morning in Los Angeles
    c.log(h, d(24), hour=1, tz="Europe/London")
    c.log(h, d(25), hour=8)
    out.append(c)

    for ws in (1, 2, 7):
        c = Case(f"DAY-6 weeks start on {ws}", ["DAY-6", "DAY-7", "G-5", "ST-3"], week_start=ws, window=(d(1), d(30)))
        w = c.habit(freq=("week", 3), goal=3, created=(d(1), 9))
        a = c.habit(kind="amount", unit="km", freq=("week", 1), goal=10, created=(d(1), 9))
        f = c.habit(freq=("flexible", "week", 2), created=(d(1), 9))
        for day in (5, 6, 7, 12, 13, 19, 20, 21, 24, 25):
            c.log(w, d(day))
            c.log(a, d(day), 2)
            c.log(f, d(day))
        out.append(c)

    c = Case("DAY-8 leap day and month ends", ["DAY-8", "S-2", "S-3"], now=(d(29, 2, 2028), 12),
             window=(d(20, 2, 2028), d(5, 3, 2028)))
    c.habit(freq=("dates", [29, 30, 31]), created=(d(1, 1, 2028), 9))
    c.habit(kind="check", freq=("calendar", {"unit": "year", "interval": 1, "month": 2, "day": 29, "useLastDay": True}),
            created=(d(1, 1, 2025), 9))
    c.habit(kind="check", freq=("calendar", {"unit": "year", "interval": 1, "month": 2, "day": 29, "useLastDay": False}),
            created=(d(1, 1, 2025), 9))
    c.habit(freq=("month", 2), goal=2, created=(d(1, 1, 2028), 9))
    out.append(c)

    c = Case("DAY-8 a non-leap February", ["DAY-8", "S-2", "S-3"], now=(d(28, 2, 2027), 12),
             window=(d(20, 2, 2027), d(5, 3, 2027)))
    c.habit(freq=("dates", [29, 30, 31]), created=(d(1, 1, 2027), 9))
    c.habit(freq=("calendar", {"unit": "month", "interval": 1, "dates": [30], "useLastDay": True}), created=(d(1, 1, 2027), 9))
    c.habit(freq=("calendar", {"unit": "month", "interval": 1, "dates": [30], "useLastDay": False}), created=(d(1, 1, 2027), 9))
    c.habit(freq=("calendar", {"unit": "year", "interval": 1, "month": 2, "day": 29, "useLastDay": True}), created=(d(1, 1, 2024), 9))
    out.append(c)

    c = Case("DAY-8 the year ends", ["DAY-6", "DAY-8"], now=(d(31, 12), 18), window=(d(20, 12), d(10, 1, 2027)), week_start=2)
    w = c.habit(freq=("week", 2), goal=2, created=(d(1, 11), 9))
    y = c.habit(freq=("year", 4), goal=4, created=(d(1, 1), 9))
    m = c.habit(kind="amount", unit="pages", freq=("month", 1), goal=100, created=(d(1, 11), 9))
    for day in (21, 22, 28, 29, 31):
        c.log(w, d(day, 12))
        c.log(y, d(day, 12))
        c.log(m, d(day, 12), 20)
    out.append(c)

    for tz in ("Pacific/Kiritimati", "Pacific/Pago_Pago", "Asia/Kathmandu", "America/St_Johns"):
        c = Case(f"DAY-9 start day in {tz}", ["DAY-9"], tz=tz, day_end=3)
        c.habit(created=(d(20), 0, 30))
        c.habit(created=(d(20), 2, 59))
        c.habit(created=(d(20), 3, 0))
        c.habit(created=moment_ms("UTC", d(20), 12))
        c.habit(created=(d(20), 9), starts=d(22))
        out.append(c)

    # ---------------------------------------------------------------- Schedules (spec/schedules.md)
    c = Case("S-2 fixed schedules", ["S-1", "S-2"], window=(d(1), d(30)))
    created = (d(3), 9)
    c.habit(freq="daily", created=created)
    c.habit(freq=("weekdays", [2, 4, 6]), created=created)
    c.habit(freq=("weekdays", [1, 2, 3, 4, 5, 6, 7]), created=created)
    c.habit(freq=("every", 3), created=created)
    c.habit(freq=("every", 1), created=created)
    c.habit(freq=("weeks", 2), created=created)
    c.habit(freq=("dates", [1, 15, 31]), created=created)
    out.append(c)

    c = Case("S-3 calendar rules", ["S-3"], window=(d(1), d(31, 10)))
    created = (d(2), 9)
    for cal in [{"unit": "day", "interval": 3},
                {"unit": "day", "interval": 1},
                {"unit": "week", "interval": 2, "weekdays": [2, 5], "anchorWeekStart": 2},
                {"unit": "week", "interval": 2, "weekdays": [1, 7], "anchorWeekStart": 1},
                {"unit": "week", "interval": 3, "weekdays": [4], "anchorWeekStart": 7},
                {"unit": "month", "interval": 1, "dates": [31], "useLastDay": True},
                {"unit": "month", "interval": 1, "dates": [31], "useLastDay": False},
                {"unit": "month", "interval": 2, "dates": [2, 20]},
                {"unit": "month", "interval": 1, "pattern": "Last day"},
                {"unit": "month", "interval": 1, "pattern": "Weekday", "ordinal": 2, "weekday": 3},
                {"unit": "month", "interval": 1, "pattern": "Weekday", "ordinal": -1, "weekday": 6},
                {"unit": "month", "interval": 1, "pattern": "Weekday", "ordinal": 5, "weekday": 5},
                {"unit": "year", "interval": 1, "month": 10, "day": 7},
                {"unit": "year", "interval": 2, "month": 9, "day": 30}]:
        c.habit(freq=("calendar", cal), created=created)
    out.append(c)

    c = Case("S-4 after it's done", ["S-4"], window=(d(1), d(31, 10)), now=(d(10, 10), 12))
    for n, unit in [(2, "day"), (1, "week"), (1, "month"), (1, "year")]:
        t = c.habit(kind="task", freq=("after", n, unit), created=(d(31, 8), 9))
        c.log(t, d(5))
        c.log(t, d(20))
    c.habit(kind="task", freq=("after", 3, "day"), created=(d(2), 9))
    t = c.habit(kind="check", freq=("after", 1, "month"), created=(d(1, 1), 9))
    c.log(t, d(31, 1))
    out.append(c)

    c = Case("S-1 start, end and archive", ["S-1", "S-7"])
    c.habit(created=(d(1), 9), starts=d(20))
    c.habit(created=(d(1), 9), starts=d(28))
    c.habit(created=(d(20), 9), starts=d(10))
    c.habit(created=(d(1), 9), ends=d(22))
    a = c.habit(created=(d(1), 9), archived=c.at(d(21), 10))
    c.log(a, d(15))
    c.log(a, d(18))
    b = c.habit(created=(d(1), 9), archived=c.at(d(21), 10))
    c.archived_on(b, d(20))
    c.log(b, d(19))
    e = c.habit(created=(d(16), 9), archived=c.at(d(21), 10))  # archived with nothing logged
    q = c.habit(kind="quit", created=(d(1), 9), ends=d(20))
    c.log(q, d(18), hour=20)
    out.append(c)

    c = Case("S-5 tasks", ["S-5"], window=(d(18), d(2, 10)))
    c.habit(kind="task", due=d(25), created=(d(20), 9))
    late = c.habit(kind="task", due=d(21), created=(d(20), 9))
    done_late = c.habit(kind="task", due=d(21), created=(d(20), 9))
    c.log(done_late, d(23))
    c.habit(kind="task", due=d(29), due_minute=18 * 60, created=(d(20), 9))
    done = c.habit(kind="task", due=d(25), created=(d(20), 9))
    c.log(done, d(25))
    rep = c.habit(kind="task", freq=("weekdays", [2, 4, 6]), created=(d(1), 9))
    c.log(rep, d(21))
    c.log(rep, d(23))
    c.move(rep, d(25), d(26))
    c.move(rep, d(30), d(2, 10))
    out.append(c)

    c = Case("S-6 goal history", ["S-6", "ST-2", "ST-3"], window=(d(1), d(2, 10)))
    a = c.habit(goal=3, created=(d(1), 9))
    c.rule(a, d(14), goal=1)
    for day in range(1, 26):
        c.log(a, d(day))
        if day >= 15 and day % 2:
            c.log(a, d(day))
            c.log(a, d(day))
    b = c.habit(freq=("week", 2), goal=2, created=(d(1), 9))
    c.rule(b, d(13), goal=1, freq="daily")
    for day in range(1, 26):
        c.log(b, d(day))
    k, steps = c.habit(kind="checklist", steps=3, created=(d(1), 9))
    c.rule(k, d(19), kind="checklist", steps=steps[:2])
    for day in range(1, 26):
        for s in steps[:2]:
            c.log(k, d(day), step=s)
    m = c.habit(kind="amount", unit="ml", increment=250, goal=2000, created=(d(1), 9))
    c.rule(m, d(10), kind="amount", unit="glasses", goal=8)
    c.rule(m, d(20), kind="amount", unit="ml", increment=250, goal=1500)
    for day in range(1, 26):
        c.log(m, d(day), 8 if day <= 10 else 1750)
    out.append(c)

    c = Case("S-7 skips and pauses", ["S-7", "ST-2", "ST-3", "G-9"], window=(d(1), d(10, 10)))
    a = c.habit(created=(d(1), 9))
    for day in range(1, 26):
        if day not in (8, 9, 10, 17):
            c.log(a, d(day))
    c.skip(a, d(17))
    c.pause(a, d(8), d(10))
    b = c.habit(freq=("week", 3), goal=3, created=(d(1), 9))
    for day in (1, 2, 3, 15, 22, 23, 24):
        c.log(b, d(day))
    c.pause(b, d(9), d(12))
    e = c.habit(created=(d(1), 9))
    for day in range(1, 23):
        c.log(e, d(day))
    c.pause(e, d(23))  # paused until turned back on
    f = c.habit(created=(d(1), 9))
    for day in range(1, 26):
        c.log(f, d(day))
    c.pause(f, d(28), d(3, 10))  # a trip booked ahead
    g = c.habit(freq=("flexible", "week", 2), created=(d(1), 9))
    for day in (1, 3, 8, 22, 24):
        c.log(g, d(day))
    c.skip(g, d(23))
    out.append(c)

    # ---------------------------------------------------------------- Goals (spec/goals.md)
    c = Case("G-1 every kind of goal", ["G-1", "G-2", "G-3", "G-6", "G-7", "G-8"])
    once = c.habit(created=(d(1), 9))
    thrice = c.habit(goal=3, created=(d(1), 9))
    glasses = c.habit(kind="amount", unit="glasses", goal=8, created=(d(1), 9))
    cups = c.habit(kind="amount", unit="cups", goal=2, at_most=True, created=(d(1), 9))
    minutes = c.habit(kind="duration", goal=30, created=(d(1), 9))
    lst, steps = c.habit(kind="checklist", steps=3, created=(d(1), 9))
    ticks = c.habit(freq=("week", 3), goal=3, created=(d(1), 9))
    total = c.habit(kind="amount", unit="pages", freq=("week", 1), goal=100, created=(d(1), 9))
    limit = c.habit(kind="amount", unit="drinks", freq=("week", 1), goal=5, at_most=True, created=(d(1), 9))
    days = c.habit(kind="amount", unit="km", freq=("flexible", "week", 3), goal=5, created=(d(1), 9))
    month = c.habit(freq=("month", 4), goal=4, created=(d(1), 9))
    yearly = c.habit(kind="duration", freq=("year", 1), goal=600, created=(d(1), 9))
    named = c.habit(goal=2, unit="glasses", created=(d(1), 9))
    for day in range(14, 26):
        if day % 3:
            c.log(once, d(day))
        for _ in range(day % 4):
            c.log(thrice, d(day))
            c.log(named, d(day))
        c.log(glasses, d(day), day % 9)
        c.log(cups, d(day), day % 4)
        c.log(minutes, d(day), 10 * (day % 5))
        for s in steps[: day % 4]:
            c.log(lst, d(day), step=s)
        if day % 2:
            c.log(ticks, d(day))
        c.log(total, d(day), 9)
        c.log(limit, d(day), day % 2)
        c.log(days, d(day), 2.5 * (day % 3))
        c.log(month, d(day))
        c.log(yearly, d(day), 25)
    out.append(c)

    c = Case("G-2 a running timer", ["G-2", "G-6"], now=(d(25), 12, 0))
    a = c.habit(kind="duration", goal=30, created=(d(1), 9))
    c.log(a, d(25), 10, hour=9)
    c.timer(a, c.at(d(25), 11, 45))
    b = c.habit(kind="duration", freq=("week", 1), goal=120, created=(d(1), 9))
    c.log(b, d(22), 60)
    c.timer(b, c.at(d(25), 11, 30))
    e = c.habit(kind="duration", goal=20, created=(d(1), 9))
    c.timer(e, c.at(d(24), 23, 50))  # started before midnight
    out.append(c)

    c = Case("G-2 times of day", ["G-2", "P-1", "P-2"])
    c.sections([{"id": "anytime", "name": "Anytime"}, {"id": "morning", "name": "Morning", "start": 360},
                {"id": "afternoon", "name": "Afternoon", "start": 720}, {"id": "evening", "name": "Evening", "start": 1080, "end": 1440}])
    two = c.habit(goal=2, part="morning,evening", reminders=[(8, 0), (20, 30)], created=(d(1), 9))
    c.log(two, d(24), slot="morning")
    c.log(two, d(24), slot="evening")
    c.log(two, d(25), slot="morning")
    c.log(two, d(23))
    c.habit(part="afternoon", reminders=[(13, 15)], created=(d(1), 9))
    c.habit(part="evening,morning,unknown", created=(d(1), 9))
    c.habit(reminders=[(23, 30), (1, 0), (7, 0)], part="morning", created=(d(1), 9))
    c.habit(kind="quit", part="morning", created=(d(1), 9))
    c.habit(kind="amount", unit="cups", goal=2, at_most=True, created=(d(1), 9))
    c.habit(kind="task", due=d(25), part="evening", created=(d(20), 9))
    c.card_order(["morning", "quitting", "anytime"])
    out.append(c)

    c = Case("P-2 times of day with a day start", ["P-1", "P-2"], day_end=3)
    c.sections([{"id": "anytime", "name": "Anytime"}, {"id": "morning", "name": "Morning", "start": 360},
                {"id": "night", "name": "Night", "start": 1320, "end": 1560}])
    c.habit(reminders=[(1, 30), (6, 30)], part="morning,night", created=(d(1), 9))
    c.habit(reminders=[(2, 0)], created=(d(1), 9))
    c.card_order(["night", "anytime"])
    out.append(c)

    # ---------------------------------------------------------------- Streaks (spec/streaks.md)
    c = Case("ST-1 daily streaks", ["ST-1", "ST-2", "ST-4"], window=(d(1), d(2, 10)))
    a = c.habit(created=(d(1), 9))
    for day in list(range(1, 6)) + list(range(8, 25)):
        c.log(a, d(day))
    b = c.habit(created=(d(1), 9))
    for day in range(1, 26):
        c.log(b, d(day))
    e = c.habit(freq=("weekdays", [2, 4, 6]), created=(d(1), 9))
    for day in (2, 4, 7, 9, 11, 14, 16, 18, 21, 23):
        c.log(e, d(day))
    f = c.habit(freq=("every", 2), created=(d(1), 9))
    for day in range(1, 26, 2):
        c.log(f, d(day))
    c.log(f, d(4))  # an extra day
    out.append(c)

    c = Case("ST-1 limits", ["ST-1", "ST-3", "G-9"], window=(d(1), d(2, 10)))
    a = c.habit(kind="amount", unit="cups", goal=2, at_most=True, created=(d(1), 9))
    for day in range(1, 26):
        c.log(a, d(day), 3 if day == 10 else 1)
    b = c.habit(kind="amount", unit="drinks", freq=("week", 1), goal=5, at_most=True, created=(d(1), 9))
    for day in range(1, 26):
        c.log(b, d(day), 1 if day < 15 else 0.5)
    e = c.habit(kind="amount", unit="euro", freq=("month", 1), goal=100, at_most=True, created=(d(1, 7), 9))
    c.log(e, d(10, 7), 120)
    c.log(e, d(10, 8), 80)
    c.log(e, d(10, 9), 40)
    out.append(c)

    c = Case("ST-3 period streaks", ["ST-3", "ST-4"], now=(d(25), 12), window=(d(1, 6), d(2, 10)))
    a = c.habit(freq=("week", 2), goal=2, created=(d(1, 6), 9))
    m = c.habit(freq=("flexible", "month", 3), created=(d(1, 6), 9))
    y = c.habit(kind="amount", unit="km", freq=("month", 1), goal=50, created=(d(1, 6), 9))
    for month in (6, 7, 8, 9):
        for day in (2, 3, 9, 10, 16, 17, 23, 24, 30):
            if month == 7 and day in (16, 17, 23):
                continue
            if month == 9 and day > 25:
                continue
            c.log(a, d(day, month))
            c.log(m, d(day, month))
            c.log(y, d(day, month), 6)
    c.pause(a, d(14, 7), d(27, 7))
    out.append(c)

    c = Case("ST-5 quit runs", ["ST-5"], window=(d(1), d(30)))
    q = c.habit(kind="quit", created=(d(1), 9))
    c.log(q, d(5), hour=21)
    c.log(q, d(12), hour=7, minute=30)
    c.log(q, d(12), hour=22)
    q2 = c.habit(kind="quit", created=(d(10), 9), quit_since=c.at(d(1), 0))
    c.log(q2, d(20), hour=12)
    q3 = c.habit(kind="quit", created=(d(1), 9), quit_since=c.at(d(15), 8))
    q4 = c.habit(kind="quit", created=(d(1), 9))
    c.pause(q4, d(10), d(14), paused_at=c.at(d(10), 18))
    c.pause(q4, d(20), None, paused_at=c.at(d(20), 7))
    q5 = c.habit(kind="quit", created=(d(1), 9))
    c.pause(q5, d(10), d(14), paused_at=c.at(d(10), 18), resumed_at=c.at(d(13), 20))
    c.log(q5, d(25), hour=13)  # a slip after "now" doesn't count yet
    out.append(c)

    c = Case("P-3 a day across habits", ["P-3", "G-9"], window=(d(14), d(2, 10)))
    for i in range(6):
        h = c.habit(created=(d(1), 9), freq="daily" if i % 2 else ("weekdays", [2, 3, 4, 5, 6]))
        for day in range(14, 26):
            if (day + i) % 3:
                c.log(h, d(day))
    c.habit(kind="task", due=d(25), created=(d(20), 9))
    arch = c.habit(created=(d(1), 9), archived=c.at(d(24), 9))
    c.archived_on(arch, d(24))
    c.habit(kind="quit", created=(d(1), 9))
    out.append(c)

    return out
