"""Scan every review for Schedule/Goal themes. Output: Temp/schedule-goal/hits.json {theme: [rec...]}"""
import json, os, re, glob, collections
NUM = r"(?:\d+|one|two|three|four|five|six|seven|once|twice|a few|few|several|x|n)"
THEMES = {
 # P2: dates of the month
 "month_dates": r"\b(?:(?:specific|certain|particular|chosen|select(?:ed)?|set)\s+dates?\b|dates? of (?:the|each|every) month|days? of the month|day of month|(?:1st|first|15th|fifteenth|last day)\s+(?:and|&)\s+(?:15th|16th|30th|last)|(?:on|every) the (?:\d{1,2}(?:st|nd|rd|th))\b|(?:\d{1,2}(?:st|nd|rd|th)) of (?:each|every|the) month|same (?:day|date) (?:each|every) month|monthly on|once a month on|(?:first|second|third|fourth|last) (?:monday|tuesday|wednesday|thursday|friday|saturday|sunday|weekend) of)",
 # P3/P4: times vs days a week
 "times_per": rf"\b{NUM}\s*(?:times?|x)\s*(?:a|per|each|every|/)\s*(?:week|month|year|wk)\b",
 "days_per": rf"\b{NUM}\s*days?\s*(?:a|per|each|every|/|of the)\s*(?:week|month|year|wk)\b",
 "same_day_twice": r"(?:twice|two times|2 times|multiple times|more than once|several times) (?:in|on) (?:the same|one|a single) day|same day (?:count|counts|counted)|(?:counts?|counted) as (?:two|2|one|1) (?:days?|times?)",
 # interval
 "every_n": r"\bevery (?:other|second|third|2nd|3rd|4th|\d+|two|three|four|few) (?:days?|weeks?|months?)\b|\bbi-?weekly\b|\bfortnight",
 # setup confusion around frequency/goal/schedule
 "confusing_setup": r"(?:confus\w*|complicated|unintuitive|not intuitive|counter-?intuitive|hard to (?:understand|figure|set)|makes? no sense|doesn'?t make sense|can'?t figure|couldn'?t figure|misleading)[^.!?\n]{0,120}(?:frequen\w*|schedul\w*|repeat\w*|goal|target|recurr\w*|per week|a week|times a)|(?:frequen\w*|schedul\w*|repeat\w*|goal|target|recurr\w*)[^.!?\n]{0,120}(?:confus\w*|complicated|unintuitive|not intuitive|counter-?intuitive|hard to (?:understand|figure)|makes? no sense|doesn'?t make sense)",
 # period goals
 "period_goal": r"\b(?:weekly|monthly|yearly|annual) (?:goals?|targets?|totals?)\b|\bgoals? (?:per|a|each) (?:week|month|year)\b",
 # ranges of weekdays in natural speech
 "weekday_range": r"\b(?:mon(?:day)?|sun(?:day)?|tue(?:sday)?|wed(?:nesday)?|thu(?:rsday)?|fri(?:day)?|sat(?:urday)?)\s*(?:-|–|to|through|thru)\s*(?:mon(?:day)?|sun(?:day)?|tue(?:sday)?|wed(?:nesday)?|thu(?:rsday)?|fri(?:day)?|sat(?:urday)?)\b|\bweekdays? only\b|\bwork ?days\b",
}
RX = {k: re.compile(v, re.I) for k, v in THEMES.items()}
hits = collections.defaultdict(list); seen=set(); total=0
for f in glob.glob("*Store Reviews/*/reviews.jsonl"):
    store = f.split("/")[0].split()[0]
    for line in open(f, encoding="utf-8"):
        r = json.loads(line); rid = r["review_id"]
        if (store, rid) in seen: continue
        seen.add((store, rid)); total += 1
        text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip()
        for k, rx in RX.items():
            m = rx.search(text)
            if m:
                hits[k].append({"id": rid, "store": store, "app": r["app_name"], "folder": f.split("/")[1], "rating": r["rating"], "date": r["date"][:10], "match": m.group(0), "text": text})
json.dump(hits, open("Temp/schedule-goal/hits.json", "w"), ensure_ascii=False)
print("reviews scanned:", total)
for k, v in hits.items(): print(k, len(v))
