"""Reference implementation of the Round 3 habit copy (iOS/Habits/Model/HabitCopy.swift mirrors it rule for rule).

Used to (1) print every weekday combination, date pattern and habit shape for a read-through, and
(2) generate the golden cases that the Swift CopyCheck compares against, so the app's copy is tested on
the phone against the same outputs reviewed here. English, en_US dates ("October 1"), week names from
Sunday = 1 to Saturday = 7, as in Calendar.
"""
import itertools, math

FULL = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
SHORT = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
ORDINAL_WORD = {1: "first", 2: "second", 3: "third", 4: "fourth", 5: "fifth", -1: "last"}


def ordinal(n):
    if 10 <= n % 100 <= 20: suf = "th"
    else: suf = {1: "st", 2: "nd", 3: "rd"}.get(n % 10, "th")
    return f"{n}{suf}"


def join(items, comma_before_and=False):
    """"A", "A and B", "A, B and C"; with a range in the list, a comma before "and" keeps it readable."""
    if not items: return ""
    if len(items) == 1: return items[0]
    if len(items) == 2 and not comma_before_and: return f"{items[0]} and {items[1]}"
    return ", ".join(items[:-1]) + (", and " if comma_before_and else " and ") + items[-1]


def times(n):
    return "once" if n == 1 else "twice" if n == 2 else f"{n} times"


def every_n(n, unit):
    """every day / every other week / every 3 months"""
    if n <= 1: return f"every {unit}"
    if n == 2: return f"every other {unit}"
    return f"every {n} {unit}s"


# ---------- weekdays ----------

def day_runs(days, week_start):
    order = [(week_start - 1 + i) % 7 + 1 for i in range(7)]
    runs, cur = [], []
    for d in order:
        if d in days: cur.append(d)
        elif cur: runs.append(cur); cur = []
    if cur: runs.append(cur)
    # A run through the end of the week and on into its start ("Saturday to Monday") is one run, said first.
    if len(runs) > 1 and order[0] in days and order[-1] in days:
        runs = [runs[-1] + runs[0]] + runs[1:-1]
    return runs


def day_parts(days, week_start, short):
    names = SHORT if short else FULL
    parts, has_range = [], False
    for run in day_runs(days, week_start):
        if len(run) >= 3:
            parts.append(f"{names[run[0]-1]} to {names[run[-1]-1]}"); has_range = True
        else:
            parts += [names[d - 1] for d in run]
    return parts, has_range


def days_text(days, week_start=1, short=False):
    """The whole phrase, lead word included: every day / on weekdays / every Monday and Wednesday."""
    days = set(days)
    names = SHORT if short else FULL
    n = len(days)
    if n == 7: return "every day"
    if days == {2, 3, 4, 5, 6}: return "on weekdays"
    if days == {1, 7}: return "on weekends"
    missing = sorted(set(range(1, 8)) - days, key=lambda d: (d - week_start) % 7)
    if n == 6: return f"every day except {names[missing[0]-1]}"
    runs = day_runs(days, week_start)
    if len(runs) == 1 and len(runs[0]) >= 3:
        return f"every {names[runs[0][0]-1]} to {names[runs[0][-1]-1]}"
    if n == 5: return f"every day except {join([names[d-1] for d in missing])}"
    # Ranges only for one unbroken run: "Monday, Wednesday, Thursday and Friday" reads more clearly than
    # "Monday, and Wednesday to Friday".
    return "every " + join([names[d - 1] for run in runs for d in run])


def with_week_interval(n, days, week_start, short=False):
    """every other week on Monday and Wednesday / every 3 weeks, Sunday to Thursday"""
    lead = every_n(n, "week")
    body = days_text(days, week_start, short)
    if body == "every day": return f"every day, {lead}"
    if body.startswith("on "): return f"{lead} {body}"
    if body.startswith("every day except"): return f"{lead}, {body}"
    rest = body[len("every "):]
    return f"{lead}, {rest}" if " to " in rest else f"{lead} on {rest}"


# ---------- dates of the month ----------

ODD = set(range(1, 32, 2))
EVEN = set(range(2, 31, 2))
MANY = 6  # more separate dates than this read as "on 12 dates"


def date_parts(dates):
    s = sorted(dates)
    runs, cur = [], []
    for d in s:
        if cur and d == cur[-1] + 1: cur.append(d)
        else:
            if cur: runs.append(cur)
            cur = [d]
    if cur: runs.append(cur)
    parts, has_range = [], False
    for run in runs:
        if len(run) >= 3: parts.append(f"{ordinal(run[0])} to {ordinal(run[-1])}"); has_range = True
        else: parts += [ordinal(d) for d in run]
    return parts, has_range


def month_dates_text(dates, use_last_day=True, interval=1):
    dates = set(dates)
    months = every_n(interval, "month")
    if len(dates) == 31: return "every day" if interval == 1 else f"every day, {months}"
    if dates == ODD: return "on odd dates" if interval == 1 else f"on odd dates, {months}"
    if dates == EVEN: return "on even dates" if interval == 1 else f"on even dates, {months}"
    if dates == {31} and use_last_day: return month_tail("on the last day", interval)
    if len(dates) >= 28:
        # Nearly every date: say the few it isn't on ("every day except the 31st").
        missing = [d for d in range(1, 32) if d not in dates]
        text = "every day except the " + join([ordinal(d) for d in missing])
        return text if interval == 1 else f"{text}, {months}"
    parts, has_range = date_parts(dates)
    if len(parts) > MANY:
        return f"on {len(dates)} dates each month" if interval == 1 else f"on {len(dates)} dates, {months}"
    # With a range in it, each part gets its "the": "the 1st to 3rd and the 15th".
    listed = join(["the " + p for p in parts]) if has_range else "the " + join(parts)
    return month_tail("on " + listed, interval)


def month_tail(phrase, interval):
    return f"{phrase} of every month" if interval == 1 else f"{phrase}, {every_n(interval, 'month')}"


def month_weekday_text(ordinal_n, weekday, interval=1, short=False):
    names = SHORT if short else FULL
    return month_tail(f"on the {ORDINAL_WORD[ordinal_n]} {names[weekday-1]}", interval)


def year_text(month, day, interval=1):
    return f"{every_n(interval, 'year')} on {MONTHS[month-1]} {day}"


def calendar_text(rule, week_start=1, short=False):
    u, n = rule["unit"], rule.get("interval", 1)
    if u == "day": return every_n(n, "day")
    if u == "week":
        return days_text(rule["weekdays"], week_start, short) if n == 1 else with_week_interval(n, rule["weekdays"], week_start, short)
    if u == "month":
        p = rule.get("pattern", "dates")
        if p == "last": return month_tail("on the last day", n)
        if p == "weekday": return month_weekday_text(rule["ordinal"], rule["weekday"], n, short)
        return month_dates_text(rule["dates"], rule.get("useLastDay", True), n)
    return year_text(rule["month"], rule["day"], n)


# ---------- amounts and units ----------

SINGULAR = {"glasses": "glass", "lbs": "lb", "push-ups": "push-up", "pushups": "pushup", "sit-ups": "sit-up",
            "pull-ups": "pull-up", "coffees": "coffee", "series": "series", "news": "news"}
NO_PLURAL = {"ml", "l", "oz", "km", "kg", "g", "mg", "kcal", "cal", "mi", "m", "cl", "$", "€", "£", "₹"}


def unit_word(value, unit):
    """"1 glass", "2 glasses", "1 km": a count of one never reads "1 glasses"."""
    if value != 1 or not unit: return unit
    low = unit.lower()
    if low in NO_PLURAL: return unit
    if low in SINGULAR:
        one = SINGULAR[low]
        if unit == low: return one
        return one[0].upper() + one[1:] if unit[0].isupper() else unit
    if low.endswith(("ches", "shes", "sses", "xes")): return unit[:-2]
    if low.endswith("ies") and len(low) > 4: return unit[:-3] + "y"
    if low.endswith("s") and not low.endswith(("ss", "us", "is")) and len(low) > 2: return unit[:-1]
    return unit


def amount_num(v):
    """Sentences use the whole number, grouped, as people read it: "10,000 steps", "2,000 ml", "2.5"."""
    whole = f"{v:,.2f}".rstrip("0").rstrip(".")
    return whole


def amount_text(v, unit):
    """"8 glasses", "1 glass", "2.5 km", "10k steps", "8" (no unit), "$20"."""
    if unit in ("$", "€", "£", "₹"): return f"{unit}{amount_num(v)}"
    return amount_num(v) if not unit else f"{amount_num(v)} {unit_word(v, unit)}"


def minutes_text(v):
    t = int(round(v)); h, m = divmod(t, 60)
    if h == 0: return f"{m} min"
    return f"{h} h" if m == 0 else f"{h} h {m} min"


# ---------- the habit's rhythm and sentence ----------

def rhythm(f, week_start=1, short=False):
    """How often, alone: for set days and calendars (no counts)."""
    k = f[0]
    if k == "daily": return "every day"
    if k == "weekdays": return days_text(f[1], week_start, short)
    if k == "everyNDays": return every_n(f[1], "day")
    if k == "everyNWeeks": return every_n(f[1], "week")
    if k == "monthDates": return month_dates_text(f[1])
    if k == "calendar": return calendar_text(f[1], week_start, short)
    if k == "after": n, u = f[1], f[2]; return f"{n} {u if n == 1 else u + 's'} after it's done"
    return ""


def how_much(h):
    kind = h["kind"]
    if kind == "duration": return minutes_text(h["goal"])
    if kind == "amount": return amount_text(h["goal"], h.get("unit", ""))
    if kind == "check" and h.get("checkUnit"): return amount_text(h["goal"], h["checkUnit"])
    return None  # done or not


def plan_text(h, week_start=1, short=False):
    """What + how often, without the name: "2 chapters a week", "twice a day", "every Monday and Wednesday"."""
    f = h["frequency"]; k = f[0]
    amt = how_much(h)
    goal = h.get("goal", 1)
    if h.get("atMost"):
        per = {"daily": "a day", "perWeek": "a week", "perMonth": "a month", "perYear": "a year"}.get(k, "a day")
        return f"at most {amt} {per}"
    if k in ("perWeek", "perMonth", "perYear"):
        per = {"perWeek": "week", "perMonth": "month", "perYear": "year"}[k]
        if amt is not None: return f"{amt} a {per}"
        return f"{times(f[1])} a {per}"
    if k == "flexible":
        per, n = f[1], f[2]
        if n == 1: return f"{amt}, once a {per}" if amt is not None else f"once a {per}"
        days = f"{n} days a {per}"
        return f"{amt} on {days}" if amt is not None else days
    base = rhythm(f, week_start, short)
    if amt is not None:
        return f"{amt} a day" if k == "daily" else f"{amt} {base}"
    if h["kind"] == "check" and goal > 1:
        return f"{times(int(goal))} a day" if k == "daily" else f"{times(int(goal))} a day, {base}"
    return base


def names_unit(name, unit):
    """"Push-ups" with the unit push-ups: the name is the unit, so it isn't said twice."""
    n = name.strip().lower()
    return bool(unit) and n in (unit.lower(), unit_word(1, unit).lower())


def sentence(h, week_start=1):
    name = h["name"].strip()
    text = plan_text(h, week_start)
    unit = (h.get("unit") if h["kind"] == "amount" else h.get("checkUnit") if h["kind"] == "check" else "") or ""
    if not name or names_unit(name, unit): return text[0].upper() + text[1:]
    if h.get("atMost"): return f"{name}: {text}"
    return f"{name} {text}"


def caption(h, week_start=1):
    """Today's extra line: only the set-days rhythm, short, capitalised. Empty when the progress line says it."""
    f = h["frequency"]; k = f[0]
    if k in ("daily", "perWeek", "perMonth", "perYear", "flexible") or h.get("atMost"): return ""
    t = rhythm(f, week_start, short=True)
    return t[0].upper() + t[1:]


if __name__ == "__main__":
    # Every weekday combination, Monday and Sunday week starts.
    for ws in (2, 1):
        print(f"\n== weekday sets, week starts {FULL[ws-1]} ==")
        for r in range(1, 8):
            for combo in itertools.combinations(range(1, 8), r):
                print(f"{','.join(SHORT[d-1] for d in combo):28s} {days_text(set(combo), ws):58s} | {days_text(set(combo), ws, short=True)}")


def print_habits():
    from habits_cases import HABITS
    for h in HABITS:
        print(f"{sentence(h, 2):62s} | Today: {caption(h, 2)}")
