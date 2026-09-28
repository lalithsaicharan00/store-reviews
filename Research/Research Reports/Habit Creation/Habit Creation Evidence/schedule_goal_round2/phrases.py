import json, glob, re, collections
N = r"(?:[1-9]|one|two|three|four|five|six|seven)"
P = {
 "N times a week": rf"\b{N}\s*(?:times|x)\s*(?:a|per|each)\s*week\b",
 "N days a week": rf"\b{N}\s*days?\s*(?:a|per|each)\s*week\b",
 "N days out of 7 / N of 7 days": rf"\b{N}\s*(?:out of|of|/)\s*7\s*days\b",
 "N times a month": rf"\b{N}\s*(?:times|x)\s*(?:a|per|each)\s*month\b",
 "N days a month": rf"\b{N}\s*days?\s*(?:a|per|each)\s*month\b",
 "N times a year": rf"\b{N}\s*(?:times|x)\s*(?:a|per|each)\s*year\b",
 "once a week": r"\bonce a week\b", "twice a week": r"\btwice a week\b",
 "one day a week": r"\b(?:one|1) day (?:a|per) week\b",
 "a week (after number)": rf"\b{N}\s*(?:times|x|days?)\s*a\s*week\b",
 "per week (after number)": rf"\b{N}\s*(?:times|x|days?)\s*per\s*week\b",
 "each week (after number)": rf"\b{N}\s*(?:times|x|days?)\s*each\s*week\b",
 "every other day": r"\bevery other day\b", "every 2/two days": r"\bevery (?:2|two) days\b",
 "every second day": r"\bevery (?:second|2nd) day\b",
 "every other week": r"\bevery other week\b", "every 2/two weeks": r"\bevery (?:2|two) weeks\b",
 "biweekly": r"\bbi-?weekly\b", "fortnight(ly)": r"\bfortnight(?:ly)?\b",
 "specific days": r"\bspecific days\b", "certain days": r"\bcertain days\b", "set days": r"\bset days\b",
 "particular days": r"\bparticular days\b", "chosen days": r"\bchosen days\b", "selected days": r"\bselected days\b",
 "weekdays": r"\bweekdays\b", "monday to/through friday": r"\bmon(?:day)?\s*(?:-|–|to|through|thru)\s*fri(?:day)?\b",
 "weekends": r"\bweekends\b",
 "any day(s)": r"\bany\s+(?:day|days)\b", "any N days": rf"\bany\s+{N}\s+days\b",
 "daily goal": r"\bdaily goals?\b", "weekly goal": r"\bweekly goals?\b", "monthly goal": r"\bmonthly goals?\b", "yearly/annual goal": r"\b(?:yearly|annual) goals?\b",
 "schedule (word)": r"\bschedul(?:e|es|ed|ing)\b", "frequency (word)": r"\bfrequenc(?:y|ies)\b", "repeat (word)": r"\brepeat(?:s|ed|ing)?\b", "recurr* (word)": r"\brecurr\w*\b",
 "how often": r"\bhow often\b",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
c = collections.Counter(); seen = set(); total = 0
for f in glob.glob("*Store Reviews/*/reviews.jsonl"):
    store = f.split("/")[0]
    for line in open(f, encoding="utf-8"):
        r = json.loads(line)
        if (store, r["review_id"]) in seen: continue
        seen.add((store, r["review_id"]))
        if r.get("language") and r["language"] != "en": continue
        t = (r.get("title") or "") + " " + (r.get("body") or r.get("text") or "")
        total += 1
        for k, rx in RX.items():
            if rx.search(t): c[k] += 1
print("reviews scanned (English or App/Native any language):", total)
for k in P: print(f"{c[k]:6d}  {k}")
