import json, re, collections
rows = [json.loads(l) for l in open("Temp/mental-model/coded.jsonl")]
UF = {"time (min/hours)": r"\b\d[\d.,]*\s?(?:-?\s?)(?:min(?:ute)?s?|mins|hours?|hrs?|h)\b|\b(?:an|one|half an?) hour\b|\b(?:ten|five|fifteen|twenty|thirty|forty|sixty) min",
      "water/drink volume (glasses, cups, bottles, oz, ml, litres)": r"\b(?:glass(?:es)?|cups?|bottles?|oz|ounces?|ml|mls|lit(?:re|er)s?|l|gallons?)\b",
      "reading (pages, chapters, books)": r"\b(?:pages?|chapters?|books?)\b",
      "steps": r"\bsteps\b", "distance (km, miles, 5K)": r"\b(?:km|kms|kilomet\w+|miles?|mi|\d+k)\b",
      "reps (push-ups, squats, sets, reps)": r"\b(?:push-?ups|pushups|sit-?ups|squats|pull-?ups|reps|sets|planks?)\b",
      "calories": r"\b(?:calories|kcal|cal)\b", "words / writing": r"\bwords\b", "servings / meals / fruit": r"\b(?:servings?|meals?|fruits?|veg\w*|portions?)\b",
      "cigarettes / drinks / coffees (limits)": r"\b(?:cigarettes?|smokes?|coffees?|cups of coffee|beers?|drinks|sodas?|desserts?)\b",
      "pomodoros / sessions": r"\b(?:pomodoros?|sessions?)\b", "money": r"\$\d|\bdollars?\b|\bsave\b"}
amt = [r for r in rows if any(re.search(r"A", c) for c in r["codes"])]
c = collections.Counter()
for r in amt:
    for k, p in UF.items():
        if re.search(p, r["s"], re.I): c[k] += 1
print("statements with an amount", len(amt))
for k, v in c.most_common(): print(f"{v:5d} {100*v/len(amt):5.1f}%  {k}")
P = {"'every day'/'everyday'/'each day'": r"\b(?:every ?day|each day)\b", "'daily'": r"\bdaily\b", "'a day'": r"\ba day\b", "'per day'": r"\bper day\b",
     "'every morning/night'": r"\bevery (?:morning|night|evening)\b", "'twice a day'/'2x a day'": r"\b(?:twice|2x|2 times|two times) (?:a|per) day\b|\btwice daily\b",
     "'N times a week'": r"\b(?:\d|one|two|three|four|five|six|seven)\s?(?:x|times) (?:a|per|each) week\b|\b\dx/?w(?:ee)?k\b", "'N days a week'": r"\b(?:\d|one|two|three|four|five|six|seven) days (?:a|per|each) week\b",
     "'once a week'/'weekly'": r"\bonce (?:a|per) week\b|\bweekly\b", "'a week' (amount per week)": r"\b\d[\d,.]*\s?\w+ (?:a|per) week\b",
     "'every other day'": r"\bevery (?:other|second) day\b", "'every N days/weeks'": r"\bevery (?:\d+|two|three|four|five) (?:days|weeks|months)\b",
     "'at least'": r"\bat least\b|\bminimum\b", "limit words (no more than / max / less than / under / limit)": r"\bno more than\b|\bmax(?:imum)?\b|\bless than\b|\bunder\b|\blimit\b|\bat most\b|\bcut (?:down|back)\b",
     "zero/none ('0 per day', 'no X')": r"\b0 (?:per|a) day\b|\bzero\b|\bnone\b", "range ('3-4 times', '7-8 hours')": r"\b\d+\s?(?:-|–|to)\s?\d+\s?(?:times|x|hours|hrs|min|days|cups|glasses|miles|km)\b",
     "time of day words": r"\bmorning|\bnight\b|\bevening|before bed|bedtime|\bam\b|\bpm\b", "'on Monday…' weekday names": r"\b(?:mon|tues|wednes|thurs|fri|satur|sun)day",
     "'a month'/'monthly'": r"\b(?:a|per|each) month\b|\bmonthly\b", "'a year'/'yearly'": r"\b(?:a|per|each) year\b|\byearly\b|\bannual"}
print()
for k, p in P.items():
    n = sum(1 for r in rows if re.search(p, r["s"], re.I)); print(f"{n:5d}  {k}")
