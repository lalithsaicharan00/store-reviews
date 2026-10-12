"""Builds golden-case inputs for the shared habit rules (Core/fixtures/README.md).

A case is the database's own rows (habit, step, reminder, entry and setting records, named as `Core`'s records name them),
plus the phone's time zone, a fixed "now", the days to ask about and some moments to place. Settings are written exactly
as the iPhone saves them (Swift's JSON for pauses, goal history and sections; "v2:" + base64 JSON for newer schedules), so
the same files test any reader of real data.
"""
import base64
import datetime as dt
import json
import uuid
from zoneinfo import ZoneInfo

APPLE_EPOCH = 978_307_200  # Swift's Date encodes seconds since 1 Jan 2001.


def day_key(d):
    return d.isoformat() if isinstance(d, dt.date) else d


def parse_day(s):
    return dt.date.fromisoformat(s) if isinstance(s, str) else s


def moment_ms(tz, day, hour=12, minute=0, second=0, fold=0):
    """Epoch milliseconds of a wall-clock time in a time zone (fold=1: the second of a repeated hour)."""
    d = parse_day(day)
    local = dt.datetime(d.year, d.month, d.day, hour, minute, second, fold=fold, tzinfo=ZoneInfo(tz))
    return int(local.timestamp() * 1000)


def ms_to_apple(ms):
    return ms / 1000 - APPLE_EPOCH


def local_day_json(d):
    d = parse_day(d)
    return {"year": d.year, "month": d.month, "day": d.day}


def frequency(f):
    """The database form of a schedule (`Frequency.storageKey`)."""
    if f is None or f == "daily":
        return "daily"
    kind = f[0]
    if kind == "weekdays":
        return "weekdays:" + ",".join(str(x) for x in sorted(f[1]))
    if kind == "every":
        return f"every:{f[1]}"
    if kind == "weeks":
        return f"weeks:{f[1]}"
    if kind == "dates":
        return "dates:" + ",".join(str(x) for x in sorted(f[1]))
    if kind in ("week", "month", "year"):
        return f"{kind}:{f[1]}"
    return "v2:" + base64.b64encode(json.dumps(frequency_json(f), separators=(",", ":")).encode()).decode()


def calendar_json(c):
    full = {"unit": "day", "interval": 2, "weekdays": [], "dates": [], "pattern": "Dates", "ordinal": 1, "weekday": 1,
            "month": 1, "day": 1, "useLastDay": True, "anchorWeekStart": 2}
    full.update(c)
    full["weekdays"] = sorted(full["weekdays"])
    full["dates"] = sorted(full["dates"])
    return full


def frequency_json(f):
    """Swift's synthesized JSON for `Frequency`, as saved in goal history and in "v2:" schedules."""
    if f is None or f == "daily":
        return {"daily": {}}
    kind = f[0]
    if kind == "weekdays":
        return {"weekdays": {"_0": sorted(f[1])}}
    if kind == "every":
        return {"everyNDays": {"_0": f[1]}}
    if kind == "weeks":
        return {"everyNWeeks": {"_0": f[1]}}
    if kind == "dates":
        return {"monthDates": {"_0": sorted(f[1])}}
    if kind == "week":
        return {"perWeek": {"_0": f[1]}}
    if kind == "month":
        return {"perMonth": {"_0": f[1]}}
    if kind == "year":
        return {"perYear": {"_0": f[1]}}
    if kind == "flexible":
        return {"flexible": {"_0": f[1], "_1": f[2]}}
    if kind == "calendar":
        return {"calendar": {"_0": calendar_json(f[1])}}
    if kind == "after":
        return {"afterCompletion": {"_0": f[1], "_1": f[2]}}
    raise ValueError(f)


def kind_json(kind, unit=None, increment=1.0):
    if kind == "amount":
        return {"amount": {"unit": unit or "", "increment": increment}}
    return {kind: {}}


class Case:
    def __init__(self, name, rules=(), tz="Europe/London", now=("2026-09-25", 12, 0), day_end=0, week_start=2,
                 window=("2026-09-14", "2026-10-02"), detail="full", watch=False):
        self.name = name
        self.rules = list(rules)
        self.tz = tz
        self.now_ms = moment_ms(tz, now[0], now[1], now[2] if len(now) > 2 else 0, fold=now[3] if len(now) > 3 else 0)
        self.window = [day_key(window[0]), day_key(window[1])]
        self.detail = detail
        self.watch = watch
        self.habits, self.steps, self.reminders, self.entries, self.settings = [], [], [], [], []
        self.probes = []
        self._n = 0
        self._pauses = {}
        self._rules = {}
        self._skips = {}
        self._moves = {}
        if day_end:
            self.setting("day_end_hour", str(day_end))
        self.setting("week_start", str(week_start))

    def uid(self, kind):
        self._n += 1
        return str(uuid.uuid5(uuid.NAMESPACE_URL, f"golden/{self.name}/{kind}/{self._n}")).upper()

    def setting(self, key, value):
        self.settings = [s for s in self.settings if s["key"] != key]
        self.settings.append({"key": key, "value": value})

    def at(self, day, hour=12, minute=0, tz=None, fold=0):
        return moment_ms(tz or self.tz, day, hour, minute, fold=fold)

    def habit(self, kind="check", freq="daily", goal=1, unit=None, increment=1.0, at_most=False,
              created=("2026-09-01", 9, 0), starts=None, ends=None, due=None, due_minute=None, part="anytime",
              reminders=(), steps=0, quit_since=None, archived=None, name=None):
        hid = self.uid("habit")
        created_ms = created if isinstance(created, int) else self.at(created[0], created[1], created[2] if len(created) > 2 else 0)
        row = {"id": hid, "name": name or f"Habit {len(self.habits) + 1}", "kind": kind, "goal": float(goal),
               "frequency": frequency(freq), "atMost": at_most, "createdAt": created_ms, "part": part,
               "position": len(self.habits)}
        if unit is not None:
            row["unit"] = unit
        row["increment"] = float(increment)
        if starts:
            row["startsOn"] = day_key(starts)
        if ends:
            row["endsOn"] = day_key(ends)
        if due:
            row["dueDay"] = day_key(due)
        if due_minute is not None:
            row["dueMinute"] = due_minute
        if quit_since is not None:
            row["quitSince"] = quit_since
        if archived is not None:
            row["archivedAt"] = archived if isinstance(archived, int) else self.now_ms
        self.habits.append(row)
        step_ids = []
        for i in range(steps):
            sid = self.uid("step")
            self.steps.append({"id": sid, "habitId": hid, "name": f"Step {i + 1}", "position": i})
            step_ids.append(sid)
        for hm in reminders:
            self.reminders.append({"id": self.uid("reminder"), "habitId": hid, "hour": hm[0], "minute": hm[1]})
        if steps:
            return hid, step_ids
        return hid

    def log(self, habit, day, value=1.0, hour=12, minute=0, tz=None, slot=None, step=None, at=None):
        eid = self.uid("entry")
        tz = tz or self.tz
        row = {"id": eid, "habitId": habit, "day": day_key(day), "value": float(value),
               "createdAt": at if at is not None else moment_ms(tz, day, hour, minute), "timeZone": tz}
        if slot:
            row["slot"] = slot
        if step:
            row["stepId"] = step
        self.entries.append(row)
        return eid

    def skip(self, habit, *days):
        self._skips.setdefault(habit, set()).update(day_key(d) for d in days)
        self.setting("skip." + habit, ",".join(sorted(self._skips[habit])))

    def move(self, habit, frm, to):
        self._moves.setdefault(habit, {})[day_key(frm)] = day_key(to)
        self.setting("move." + habit, ",".join(sorted(f"{a}>{b}" for a, b in self._moves[habit].items())))

    def pause(self, habit, frm, through=None, paused_at=None, resumed_at=None):
        p = {"from": local_day_json(frm), "pausedAt": ms_to_apple(paused_at if paused_at is not None else self.at(frm, 9))}
        if through:
            p["through"] = local_day_json(through)
        if resumed_at is not None:
            p["resumedAt"] = ms_to_apple(resumed_at)
        self._pauses.setdefault(habit, []).append(p)
        self.setting("pause." + habit, json.dumps(self._pauses[habit], separators=(",", ":")))

    def rule(self, habit, until, goal=1, freq="daily", kind="check", unit=None, increment=1.0, check_unit=None, steps=()):
        r = {"until": local_day_json(until), "goal": float(goal), "frequency": frequency_json(freq),
             "kind": kind_json(kind, unit, increment), "steps": [{"id": s, "name": "Step"} for s in steps]}
        if check_unit:
            r["checkUnit"] = check_unit
        self._rules.setdefault(habit, []).append(r)
        self.setting("rules." + habit, json.dumps(self._rules[habit], separators=(",", ":")))

    def archived_on(self, habit, day):
        self.setting("archived." + habit, day_key(day))

    def timer(self, habit, started_ms, slot=None):
        self.setting("timer." + habit, str(started_ms) + (f"|{slot}" if slot else ""))

    def sections(self, sections):
        self.setting("day_sections", json.dumps(sections, separators=(",", ":")))

    def card_order(self, cards):
        self.setting("today_order", json.dumps(cards, separators=(",", ":")))

    def probe(self, day, hour, minute=0, fold=0, tz=None):
        self.probes.append(moment_ms(tz or self.tz, day, hour, minute, fold=fold))

    def json(self):
        out = {"name": self.name, "rules": self.rules, "timeZone": self.tz, "nowMs": self.now_ms, "window": self.window,
               "detail": self.detail, "probes": self.probes,
               "snapshot": {"habits": self.habits, "steps": self.steps, "reminders": self.reminders,
                            "entries": self.entries, "settings": sorted(self.settings, key=lambda s: s["key"])}}
        if self.watch:
            out["watch"] = True
        return out


def write(path, cases):
    with open(path, "w") as f:
        json.dump({"cases": [c.json() for c in cases]}, f, separators=(",", ":"), sort_keys=True)
        f.write("\n")
