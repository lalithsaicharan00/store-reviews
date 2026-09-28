"""describe.py — prototype of the "Describe it" parser in the Round 3 design.

describe(text) turns what someone types ("Read 2 chapters a week", "run 5k 3 times a week", "no more than 3 coffees a day")
into the New Habit rows: Do (do / at most / stop), How much (amount + unit, or none) and How often.
render(slots) prints the rows the way the form shows them.

It is a plain rule parser on purpose: the app can ship the same rules offline, and every rule here can be checked
against the hand codes (crosscheck.py). It is run on whole review sentences, which are far noisier than what a person
types into a name field, so its agreement with the hand codes is a floor, not a ceiling.
"""
import re

W2N = {"a": 1, "an": 1, "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9,
       "ten": 10, "eleven": 11, "twelve": 12, "fifteen": 15, "twenty": 20, "thirty": 30, "forty": 40, "fifty": 50,
       "sixty": 60, "hundred": 100, "a hundred": 100, "half an": 0.5, "half a": 0.5, "once": 1, "twice": 2, "thrice": 3}
NUM = (r"(?:\d{1,3}(?:[.,]\d{3})+|\d+(?:[.,]\d+)?|half an?|a hundred|one|two|three|four|five|six|seven|eight|nine|ten|"
       r"eleven|twelve|fifteen|twenty|thirty|forty|fifty|sixty|an?)")
UNITS = [("distance", r"k|km|kms|kilomet(?:er|re)s?|miles?|mi|laps|meters|metres|m"), ("steps", r"steps"),
         ("time", r"min(?:ute)?s?|mins|hours?|hrs?|h|seconds|secs"),
         ("volume", r"glass(?:es)?|cups?|bottles?|oz|ounces|ml|liters?|litres?|l|gallons?"),
         ("reading", r"pages?|chapters?|books?|verses|surahs?|juz|articles?|poems?"),
         ("reps", r"reps|sets|push-?ups|sit-?ups|squats|pull-?ups|burpees|crunches|planks?"),
         ("count", r"words|lessons?|sessions?|servings?|portions|meals|calories|kcal|cigarettes|cigs|smokes|drinks|beers|"
                   r"coffees?|sodas?|cans?|pills|tablets|prayers|rakats?|pomodoros?|units|problems|questions|cards|flashcards|"
                   r"songs|pieces|fruits?|vegetables|veggies|eggs|lines|photos|drawings|episodes|things|items|tasks|times"),
         ("weight", r"lbs?|pounds|kg|kilos?|grams|g"), ("money", r"dollars|bucks|euros|\$")]
UNIT = "|".join("(?P<%s>%s)" % (n, p) for n, p in UNITS)
AMT = re.compile(r"(?<![\w/:])(?P<num>" + NUM + r")\s?-?\s?(?:" + UNIT + r")\b(?!\s?(?:a|per|each|every|/)\s?(?:day|week|month|year)s?\b(?<=times a day))", re.I)
MONEY = re.compile(r"\$(?P<num>\d[\d,.]*)")
PERIOD = r"(?P<per>day|week|wk|month|year|night|morning|evening|fortnight)"
VAGUE = r"more than once|a number of|a few|a couple of|few|several|multiple|many|how many|so many|some|x|\d+\s?-\s?\d+|\d+/\d+"
TIMES = re.compile(r"\b(?P<n>" + VAGUE + "|" + NUM + r"|once|twice|thrice)\s?(?:x|times?|days?|nights?|sessions?|workouts?|runs?|walks?|visits?|doses?)?"
                   r"\s*(?:a|an|per|each|every|/|in a|this|a single|throughout the|during the|in the|in one)?\s?" + PERIOD + r"\b"
                   r"|\b(?P<n2>once|twice|thrice|several times|multiple times|(?:" + NUM + r")\s?(?:x|times))\s?(?P<per2>daily|weekly|monthly|yearly)\b"
                   r"|\b(?P<n3>twice|two times)-a-(?P<per3>day|week)\b", re.I)
TWICE_TOD = re.compile(r"\b(?:morning|am|a\.m\.) and (?:night|evening|pm|p\.m\.|bedtime)\b|\b(?:morning|breakfast), (?:lunch|noon)(?:,)? and (?:night|evening|dinner)\b", re.I)
UNITWORD = re.compile(r"\b(?P<u>steps|minutes|mins|hours|miles|kilometers|km|pages|chapters|books|glasses|cups|ounces|oz|ml|liters|litres|calories|"
                      r"words|push-?ups|pushups|reps|squats|servings|cigarettes|drinks|papers|amount of water|water intake)\b", re.I)
DAYN = r"(?:mon|tue|tues|wed|thu|thur|thurs|fri|sat|sun)(?:day|nesday|sday|rsday|urday)?s?"
DAYS = re.compile(r"\b(?:on |every )?" + DAYN + r"(?:\s*(?:,|/|&|and|or|-|through|to|thru)\s*" + DAYN + r")+\b|\bevery " + DAYN +
                  r"\b|\bon " + DAYN + r"\b|\b(?:week ?days|weekends|week-days|weeknights|mwf|m/w/f|tth|t/th)\b|\bexcept (?:on )?" + DAYN, re.I)
EVERY_N = re.compile(r"\bevery (?:other|second|(?P<n>\d+|two|three|four|five|six|seven|ten|few|couple(?: of)?)) (?P<u>days?|weeks?|months?|years?)\b|"
                     r"\balternate days\b|\bbi-?weekly\b|\bfortnightly\b|\bonce every (?:\d+|two|three|four) (?:days|weeks|months)\b", re.I)
HOURS = re.compile(r"\bevery (?:(?:\d+|two|three|four|half an?|couple(?: of)?) )?(?:hours?|hrs?|\d+ ?min(?:ute)?s)\b|\bhourly\b|\bonce an hour\b", re.I)
ANCHOR = re.compile(r"\b(?:the |on the |every )?(?:\d{1,2}(?:st|nd|rd|th)|first|second|third|fourth|last|1st|2nd|3rd|4th)"
                    r"(?: (?:day|" + DAYN + r"|business day|weekend))? of (?:the |every |each )?month\b|\b(?:on the|every) \d{1,2}(?:st|nd|rd|th)\b|"
                    r"\bend of (?:the |every |each )?month\b|\bevery (?:january|february|march|april|may|june|july|august|september|october|november|december)\b", re.I)
DAILY = re.compile(r"\b(?:every ?day|everyday|daily|each day|per day|a day|every (?:morning|night|evening|afternoon)|each (?:morning|night|evening)|nightly|a night)\b", re.I)
WEEKLY = re.compile(r"\b(?:this week|weekly|every week|each week|a week|per week|/week|/wk|a wk)\b", re.I)
MONTHLY = re.compile(r"\b(?:this month|monthly|every month|each month|a month|per month)\b", re.I)
YEARLY = re.compile(r"\b(?:this year|an year|in a year|yearly|annually|every year|each year|a year|per year)\b", re.I)
TOD = re.compile(r"\b(?:in the (?:morning|evening|afternoon)|every (?:morning|night|evening)|each (?:morning|night|evening)|before bed(?:time)?|"
                 r"at night|at bedtime|after (?:breakfast|lunch|dinner|work|school|waking(?: up)?|i wake up)|before (?:breakfast|lunch|dinner|work|school)|"
                 r"at \d{1,2}(?::\d\d)?\s?(?:am|pm|a\.m\.|p\.m\.)?|\d{1,2}(?::\d\d)?\s?(?:am|pm)|mornings?|evenings?|nights?|bedtime|nightly|when i wake up)\b", re.I)
LIMIT = re.compile(r"\b(?:no more than|not more than|less than|fewer than|under|at most|max(?:imum)?|limit(?:ing|ed)?(?: (?:myself|it|me))?(?: to)?|"
                   r"cut(?:ting)? (?:down|back)(?: to)?|reduc\w+(?: to)?|below|up to|keep (?:it )?under|stay (?:under|below))\b", re.I)
QUIT = re.compile(r"\b(?:quit\w*|stop(?:ped|ping)? (?:smoking|drinking|vaping|eating|biting|using|watching|scrolling)|no (?:smoking|alcohol|sugar|drinking|soda|junk|porn|"
                  r"social media|coffee|caffeine|vaping|fap|snacking|meat)|nofap|sober|abstain\w*|days? (?:without|free|clean|sober)|"
                  r"break(?:ing)? (?:the |a |my )?(?:habit|addiction)|give up|gave up|kick the habit)\b", re.I)
COUNT = re.compile(r"\b(?:how many (?:times|cigarettes|drinks|coffees)|count (?:how many|the number)|keep (?:a )?(?:count|tally)|just (?:count|track|log) (?:how many|the number))\b", re.I)


def num(x):
    x = x.lower().strip()
    if x in W2N: return W2N[x]
    if re.fullmatch(r"\d{1,3}(?:[.,]\d{3})+", x): x = re.sub(r"[.,]", "", x)
    x = x.replace(",", ".") if re.fullmatch(r"\d+,\d{1,2}", x) else x.replace(",", "")
    try: return float(x)
    except ValueError: return None


def first(*ms):
    ms = [m for m in ms if m]
    return min(ms, key=lambda m: m.start()) if ms else None


def describe(s):
    """Slots: do (do|at most|stop|count), amount, unit, ufam, often {kind, n, period, text}, each (amount is per time), when."""
    r = {"do": "do", "amount": None, "unit": None, "ufam": None, "often": None, "each": False, "when": None, "blank": False}
    t = TIMES.search(s)
    if t and t.group("n") and t.group("n").lower() in ("a", "an", "one") and t.group("per") and t.group(0).lower().split()[0] in ("a", "an") \
            and not re.search(r"\b(?:time|x)\b", t.group(0), re.I):
        t = None  # "a day" alone is not "N times a day"
    # How much: the first amount that is not the "N times" of How often.
    for m in AMT.finditer(s):
        if t and t.start() <= m.start() < t.end(): continue
        if m.group("count") and m.group("count").lower() == "times": continue
        if m.group("distance") and m.group("distance").lower() == "m" and not re.search(r"\d\s?m\b(?!in)", m.group(0)): continue
        n = num(m.group("num"))
        if m.group("num").lower() in ("a", "an") and m.group("count"): continue  # "miss a session", "a few things"
        if n is None or n == 0 and not re.search(r"\b0\b", m.group(0)): continue
        r["amount"], r["unit"] = n, re.sub(r"^" + NUM + r"\s?-?\s?", "", m.group(0), flags=re.I) or m.group(0)
        r["ufam"] = next(k for k, _ in UNITS if m.group(k))
        amt_end = m.end(); break
    else:
        mm = MONEY.search(s)
        if mm: r["amount"], r["unit"], r["ufam"], amt_end = num(mm.group("num")), "$", "money", mm.end()
        else:
            # "steps per day", "X minutes a week", "how many cigarettes": the unit is said, the number is left blank
            for u in UNITWORD.finditer(s):
                before, after = s[max(0, u.start() - 16):u.start()].lower(), s[u.end():u.end() + 40]
                if re.search(r"(?:how many|how much|\bx|number of|amount of|so many|many|more|\bn)\s*$", before) or \
                        re.match(r"\s*(?:(?:of|in|for|i) (?:[\w']+ ){0,4})?(?:a|per|each|every|/|in a)\s?(?:day|week|month|year)\b", after, re.I):
                    r["unit"], r["blank"], amt_end = u.group("u"), True, u.end(); break
    # How often, most specific first.
    h, iv, d, an = HOURS.search(s), EVERY_N.search(s), DAYS.search(s), ANCHOR.search(s)
    per_t = t and (t.group("per") or t.group("per2") or t.group("per3")).lower()
    if h and not (t and per_t in ("week", "month", "year", "weekly", "monthly", "yearly")):
        r["often"] = {"kind": "hours", "text": h.group(0)}
        if t and per_t in ("day", "daily"): r["often"]["n"] = num(re.sub(r"\s?(x|times?).*", "", (t.group("n") or t.group("n2") or t.group("n3")).lower()))
    elif iv:
        r["often"] = {"kind": "every", "text": iv.group(0)}
    elif t:
        raw = (t.group("n") or t.group("n2") or t.group("n3")).lower().strip()
        vague = bool(re.fullmatch(VAGUE, raw, re.I))
        n = None if vague else num(re.sub(r"\s?(x|times?|days?|nights?|sessions?|workouts?|runs?|walks?|visits?|doses?)$", "", raw))
        if raw == "two times": n = 2
        per = per_t
        per = {"wk": "week", "night": "day", "morning": "day", "evening": "day", "fortnight": "week", "daily": "day", "weekly": "week", "monthly": "month", "yearly": "year"}.get(per, per)
        if n is None and not vague: n = 1
        if per == "day" and n is not None and n <= 1: r["often"] = {"kind": "day"}
        else: r["often"] = {"kind": "times", "n": n, "period": per}
        if r["amount"] is not None or r["blank"]: r["each"] = per != "day" or n is None or n > 1
    elif an:
        r["often"] = {"kind": "date", "text": an.group(0)}
    elif d:
        r["often"] = {"kind": "days", "text": d.group(0)}
    elif TWICE_TOD.search(s):
        r["often"] = {"kind": "times", "n": 2 if " and " in TWICE_TOD.search(s).group(0) and "," not in TWICE_TOD.search(s).group(0) else 3, "period": "day"}
    else:
        # "2 chapters a week": a period right after the amount is a total for that period.
        has = r["amount"] is not None or r["blank"]
        after = s[amt_end:amt_end + 40] if has else ""
        pm = re.match(r"\s*(?:(?:of|in|for|i) (?:[\w']+ ){0,4})?(?:a|an|per|each|every|/|in a|this)\s?(day|week|month|year)\b", after, re.I)
        if pm:
            per = pm.group(1).lower()
            r["often"] = {"kind": "day"} if per == "day" else {"kind": "total", "period": per}
        elif DAILY.search(s): r["often"] = {"kind": "day"}
        elif WEEKLY.search(s): r["often"] = {"kind": "total", "period": "week"} if has else {"kind": "times", "n": 1, "period": "week"}
        elif MONTHLY.search(s): r["often"] = {"kind": "total", "period": "month"} if has else {"kind": "times", "n": 1, "period": "month"}
        elif YEARLY.search(s): r["often"] = {"kind": "total", "period": "year"} if has else {"kind": "times", "n": 1, "period": "year"}
    if d and r["often"] and r["often"]["kind"] in ("times",) and r["often"].get("period") == "day":
        r["often"]["days"] = d.group(0)  # "twice a day on weekdays"
    w = TOD.search(s)
    if w: r["when"] = w.group(0)
    if QUIT.search(s) and r["amount"] is None and not (r["often"] and r["often"]["kind"] == "times"): r["do"] = "stop"
    lm = LIMIT.search(s)
    if lm and (r["amount"] is not None or r["blank"] or (r["often"] and r["often"]["kind"] == "times")): r["do"] = "at most"
    elif COUNT.search(s) and r["amount"] is None and not r["blank"]: r["do"] = "count"
    return r


def family(r):
    """The hand-code family this parse falls in (same keys as families.py)."""
    o, a = r["often"], r["amount"] is not None or r["blank"]
    if o is None: return "F18 an amount, no period" if a or not r["when"] else "F17 time of day only"
    k = o["kind"]
    if k == "hours": return "F16 every N hours"
    if k == "every": return "F09 every N days, weeks or months"
    if k == "days": return "F08 on set weekdays"
    if k == "date": return "F10 once a month / monthly"
    if k == "day": return "F02 an amount per day" if a else "F01 every day"
    if k == "total": return {"week": "F06 an amount per week", "month": "F12 an amount per month", "year": "F15 an amount per year"}[o["period"]]
    n, p = o["n"], o["period"]
    if p == "day": return "F03 several times a day"
    many = n is None or n > 1 or r["do"] == "at most"  # "at most once a week" is a count of times, not a weekly habit
    if p == "week": return "F05 an amount each time, N times a week" if a else ("F04 N times a week, any days" if many else "F07 once a week / weekly")
    if p == "month": return "F11 N times a month" if many or a else "F10 once a month / monthly"
    if p == "year": return "F14 N times a year" if many or a else "F13 once a year / yearly"
    return "F19 other"


def g(x): return ("%g" % x) if x is not None else "?"


def render(r):
    """The rows as the New Habit form shows them."""
    how_much = (f"__ {r['unit']}" if r["blank"] else "Done or not") if r["amount"] is None else f"{g(r['amount'])}{'' if r['unit'].lower() == 'k' else ' '}{r['unit']}"
    if r["do"] == "at most": how_much = "At most " + (how_much if r["amount"] is not None or r["blank"] else f"{g((r['often'] or {}).get('n'))} times")
    if r["do"] == "stop": how_much = "Stop completely"
    if r["do"] == "count": how_much = "Count, no target"
    o = r["often"]
    if o is None: often = "Every day (default)"
    else:
        k = o["kind"]
        often = {"day": "Every day", "hours": "Every day · remind " + o.get("text", ""), "every": o.get("text", "").capitalize(),
                 "days": ("Every day " if o.get("text", "").lower().startswith("except") else "On ") + re.sub(r"^(?:on|every) ", "", o.get("text", ""), flags=re.I), "date": "On a date: " + o.get("text", "")}.get(k)
        if k == "total": often = f"A {o['period']} (in total)"
        if k == "times":
            n = o["n"]
            often = ("Once" if n == 1 else "Twice" if n == 2 else "__ times" if n is None else f"{g(n)} times") + f" a {o['period']}" + (" · " + o["days"] if o.get("days") else "")
            if r["each"] and (r["amount"] is not None or r["blank"]): how_much += " each time"
    return f"{how_much} | {often}" + (f" | When: {r['when']}" if r["when"] else "")


if __name__ == "__main__":
    import sys
    for line in (sys.argv[1:] or ["Read 2 chapters a week", "Run 5 km every day", "run 8k 3 times a week", "Drink 8 glasses of water a day",
                                   "no more than 3 coffees a day", "Meditate every morning", "Gym on Mon, Wed and Fri",
                                   "take my pills twice a day", "Water the plants every 3 days", "Pay rent on the 1st of the month",
                                   "Read 12 books a year", "quit smoking", "Walk 10,000 steps", "floss 5 times a week"]):
        r = describe(line); print(f"{line:40s} -> {render(r)}   [{family(r)[:3]}]")
