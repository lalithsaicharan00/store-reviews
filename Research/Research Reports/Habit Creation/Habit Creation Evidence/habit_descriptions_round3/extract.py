"""Extract first-person habit descriptions (sentences) from every review. Output: Temp/mental-model/statements.jsonl"""
import json, glob, re, html
DAYS = r"(?:mon|tues?|wed(?:nes)?|thu(?:rs)?|fri|sat(?:ur)?|sun)(?:day)?s?"
F = re.compile(r"\b(?:every ?day|everyday|daily|each day|a day|per day|every (?:morning|night|evening|afternoon)|each (?:morning|night)|in the (?:morning|evening)|before bed|a week|per week|each week|weekly|a month|per month|monthly|a year|per year|yearly|annually|every other (?:day|week|month)|every \d+ (?:days|weeks|months)|every (?:two|three|four) (?:days|weeks)|weekdays|weekends|once|twice|\d+ ?(?:x|times)\b|(?:on )?" + DAYS + r"(?:,| and| &|/))", re.I)
UNITS = r"(?:k\b|km|kms|kilometers?|kilometres?|miles?|mi\b|steps|min(?:ute)?s?\b|hours?|hrs?\b|h\b|pages?|chapters?|books?|glasses|cups?|bottles?|oz\b|ounces|ml\b|liters?|litres?|l\b|reps|push-?ups|sit-?ups|squats|pull-?ups|laps|words|lessons?|sessions?|servings?|calories|kcal|cigarettes|drinks|beers|pills|tablets|times|lbs?|pounds|kg|verses|prayers|pomodoros?)"
A = re.compile(r"\b\d[\d,.]*\s?" + UNITS, re.I)
I = re.compile(r"\b(?:i want(?:ed)? to|i'?m trying to|i am trying to|i try to|trying to|my goal|goal (?:is|was|of|to)|i set|i'?ve set|i have set|set (?:a |my |up )?(?:goal|habit)|i track|i'?m tracking|i use (?:it|this|the app) (?:to|for)|i log|habit of|habits? (?:like|such as)|for example|for instance|e\.g\.|i need to|i'?d like to|i would like to|i'?m aiming|aim(?:ing)? (?:to|for)|remind(?:s|ed)? me to|i have (?:a|my) habit|i can (?:set|track)|able to (?:set|track)|like (?:\"|')|such as)", re.I)
out = open("Temp/mental-model/statements.jsonl", "w"); seen = set(); n = 0; total = 0
for f in glob.glob("*Store Reviews/*/reviews.jsonl"):
    store = f.split("/")[0].split()[0]
    for line in open(f, encoding="utf-8"):
        r = json.loads(line)
        if r.get("language") and r["language"] != "en": continue
        total += 1
        t = html.unescape((r.get("title") or "") + ". " + (r.get("body") or r.get("text") or ""))
        for s in re.split(r"(?<=[.!?])\s+|\n+", t):
            s = s.strip()
            if not (20 <= len(s) <= 320): continue
            if not I.search(s): continue
            if not (F.search(s) or A.search(s)): continue
            key = re.sub(r"\W+", " ", s.lower())
            if key in seen: continue
            seen.add(key); n += 1
            out.write(json.dumps({"id": r["review_id"], "store": store, "app": r["app_name"], "rating": r["rating"], "date": r["date"][:10], "s": s}, ensure_ascii=False) + "\n")
print("reviews", total, "statements", n)
