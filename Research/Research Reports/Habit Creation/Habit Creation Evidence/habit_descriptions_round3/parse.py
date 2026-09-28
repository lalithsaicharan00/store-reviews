"""Slot parser: the grammar of 'how people say a habit'. parse(s) -> dict of slots.
Slots: dir (build/limit/quit), amt (number), unit, ufam (distance/steps/time/count/...), freq (list of forms),
per (period the amount belongs to), times (sessions per period), days, tod (time of day)."""
import re
W2N = {"a":1,"an":1,"one":1,"two":2,"three":3,"four":4,"five":5,"six":6,"seven":7,"eight":8,"nine":9,"ten":10,"eleven":11,"twelve":12,
       "fifteen":15,"twenty":20,"thirty":30,"forty":40,"fifty":50,"hundred":100,"a hundred":100,"half an":0.5,"half a":0.5,"once":1,"twice":2,"thrice":3}
NUM = r"(?:\d[\d,.]*\d|\d|half an?|a hundred|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|fifteen|twenty|thirty|forty|fifty|an?)"
UF = [("distance", r"k|km|kms|kilomet(?:er|re)s?|miles?|mi|laps"), ("steps", r"steps"),
      ("time", r"min(?:ute)?s?|mins|hours?|hrs?|h|seconds|secs"),
      ("count", r"pages?|chapters?|books?|glasses|glass|cups?|bottles?|oz|ounces|ml|liters?|litres?|l|reps|sets|push-?ups|pushups|sit-?ups|squats|pull-?ups|words|lessons?|sessions?|servings?|calories|kcal|cigarettes|cigs|drinks|beers|pills|tablets|verses|prayers|pomodoros?|coffees?|cans?|units|portions|meals|problems|questions|cards|flashcards|articles|poems|songs|pieces|fruits?|vegetables|veggies|eggs|chapters|surahs?|rakats?|juz|lines|sentences|photos|drawings|episodes"),
      ("weight", r"lbs?|pounds|kg|kilos?"), ("money", r"dollars|bucks|euros|pounds sterling")]
UNIT = "|".join("(?P<%s>%s)" % (n, p) for n, p in UF)
AMTRE = re.compile(r"\b(?P<num>" + NUM + r")\s?-?\s?(?:" + UNIT + r")\b", re.I)
DAYN = r"(?:mon|tue|tues|wed|thu|thur|thurs|fri|sat|sun)(?:day|nesday|sday|rsday|urday)?s?"
DAYSRE = re.compile(r"\b(?:on |every )?(?:" + DAYN + r")(?:\s*(?:,|/|&|and|or)\s*(?:" + DAYN + r"))+\b|\bevery (?:" + DAYN + r")\b|\bon (?:" + DAYN + r")\b|\b(?:week ?days|weekends|week-days|mwf|m/w/f|tth|t/th)\b", re.I)
PER = r"(?P<per>day|week|month|year|night|morning|fortnight)"
TIMES = re.compile(r"\b(?P<n>" + NUM + r"|once|twice|thrice|\d+)\s?(?:x|times?|days?|nights?|sessions?|workouts?|runs?|walks?|visits?)?\s*(?:a|per|each|every|/|in a|a single)\s?" + PER + r"\b", re.I)
TIMES2 = re.compile(r"\b(?P<n>once|twice|thrice|\d+\s?x|" + NUM + r" times)\b(?!\s*(?:a|per|each|every|/)\s?(?:day|week|month|year))", re.I)
INTERVAL = re.compile(r"\bevery (?:other|(?P<n>\d+|two|three|four|five|six|seven|ten|few|couple(?: of)?)) (?P<u>days?|weeks?|months?|years?)\b|\balternate days\b|\bbi-?weekly\b|\bfortnightly\b", re.I)
EVERY = re.compile(r"\b(?:every ?day|everyday|daily|each day|per day|a day|every (?:morning|night|evening)|each (?:morning|night|evening)|nightly|day by day)\b", re.I)
WEEKLY = re.compile(r"\b(?:weekly|every week|each week|a week|per week)\b", re.I)
MONTHLY = re.compile(r"\b(?:monthly|every month|each month|a month|per month)\b", re.I)
YEARLY = re.compile(r"\b(?:yearly|annually|every year|each year|a year|per year)\b", re.I)
TOD = re.compile(r"\b(?:in the (?:morning|evening|afternoon)|every (?:morning|night|evening)|each (?:morning|night|evening)|before bed|at night|at bedtime|after (?:breakfast|lunch|dinner|work|school|waking)|before (?:breakfast|lunch|dinner|work|school)|at \d{1,2}(?::\d\d)?\s?(?:am|pm)?|\d{1,2}(?::\d\d)?\s?(?:am|pm)|morning|evening|night|bedtime|nightly)\b", re.I)
LIMIT = re.compile(r"\b(?:no more than|not more than|less than|fewer than|under|at most|max(?:imum)?|limit(?:ing|ed)?|cut(?:ting)? (?:down|back)|only|reduc\w+|below|up to)\b", re.I)
QUIT = re.compile(r"\b(?:quit\w*|stop(?:ped|ping)?|no (?:smoking|alcohol|sugar|drinking|soda|junk|porn|social media|coffee|caffeine|vaping|fap)|nofap|don'?t|do not|avoid\w*|without|sober|abstain\w*|break(?:ing)? (?:the |a |my )?(?:habit|addiction)|bad habits?)\b", re.I)
ATLEAST = re.compile(r"\b(?:at least|minimum|min\.?|or more|\+)\b", re.I)
def num(x):
    x = x.lower().strip()
    if x in W2N: return W2N[x]
    if re.fullmatch(r"\d{1,3}(?:[.,]\d{3})+", x): x = re.sub(r"[.,]", "", x)
    x = x.replace(",", ".") if re.fullmatch(r"\d+,\d{1,2}", x) else x.replace(",", "")
    try: return float(x)
    except: return None
def parse(s):
    r = {"amt": None, "unit": None, "ufam": None, "freq": [], "per": None, "times": None, "days": None, "tod": None, "dir": "build", "atleast": False}
    m = AMTRE.search(s)
    if m and not (m.group("count") and m.group("count").lower() == "times"):
        r["amt"] = num(m.group("num")); r["unit"] = m.group(0).split()[-1] if " " in m.group(0) else m.group(0)
        r["ufam"] = next(n for n, _ in UF if m.group(n))
    t = TIMES.search(s)
    if t:
        n = t.group("n").lower().replace("x", "").strip()
        r["times"] = num(n.replace(" times", "")) ; r["per"] = t.group("per").lower()
        if r["per"] in ("night", "morning"): r["per"] = "day"
    iv = INTERVAL.search(s)
    if iv: r["freq"].append("interval:" + iv.group(0).lower())
    d = DAYSRE.search(s)
    if d: r["days"] = d.group(0)
    if EVERY.search(s): r["freq"].append("daily")
    if WEEKLY.search(s): r["freq"].append("weekly")
    if MONTHLY.search(s): r["freq"].append("monthly")
    if YEARLY.search(s): r["freq"].append("yearly")
    if not t and TIMES2.search(s): r["freq"].append("count:" + TIMES2.search(s).group(0).lower())
    tod = TOD.search(s)
    if tod: r["tod"] = tod.group(0).lower()
    if QUIT.search(s): r["dir"] = "quit?"
    if LIMIT.search(s) and (r["amt"] or r["times"]): r["dir"] = "limit?"
    if ATLEAST.search(s): r["atleast"] = True
    return r
def shape(r):
    p = {"day": "D", "week": "W", "month": "M", "year": "Y", "fortnight": "F"}
    iv = [f for f in r["freq"] if f.startswith("interval")]
    a = "A" if r["amt"] is not None else ""
    if r["dir"] == "quit?" and not a and not r["times"]: return "Q"
    if iv: return "I" + a
    if r["days"]: return "S" + a
    if r["times"] is not None:
        if r["per"] == "day" and r["times"] <= 1: return ("L" if r["dir"] == "limit?" else "") + "D" + a
        return ("L" if r["dir"] == "limit?" else "") + p.get(r["per"], "?") + "n" + a
    for f, c in (("daily", "D"), ("weekly", "W"), ("monthly", "M"), ("yearly", "Y")):
        if f in r["freq"]: return ("L" if r["dir"] == "limit?" else "") + c + (a if a else ("" if c == "D" else "1"))
    if a: return ("L" if r["dir"] == "limit?" else "") + "A"
    if any(f.startswith("count") for f in r["freq"]): return "C"
    if r["tod"]: return "T"
    return "X"
def short(r):
    out = []
    if r["dir"] != "build": out.append(r["dir"])
    if r["amt"] is not None: out.append("%g %s" % (r["amt"], r["unit"]))
    if r["times"] is not None: out.append("%gx/%s" % (r["times"], r["per"]))
    out += r["freq"]
    if r["days"]: out.append("days:" + r["days"])
    if r["tod"]: out.append("@" + r["tod"])
    if r["atleast"]: out.append("≥")
    return " · ".join(out)
if __name__ == "__main__":
    import sys, json
    for l in open(sys.argv[1]):
        d = json.loads(l); r = parse(d["s"]); print(d.get("k", d.get("n")), shape(r), "|", d["s"][:210], "‖", short(r))
