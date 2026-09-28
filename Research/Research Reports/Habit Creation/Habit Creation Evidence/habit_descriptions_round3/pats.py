"""Second pass, no intent marker needed: sentences where an activity verb is followed (within 6 words)
by an amount-with-unit or a frequency phrase. That is the literal shape of a habit said aloud:
"read 10 pages a day", "run 5K 3 times a week", "no more than 3 coffees a day".
Output: Temp/mental-model/statements2.jsonl (dedupes against statements.jsonl too)."""
import json, glob, re, html
DAYS = r"(?:mon|tues?|wed(?:nes)?|thu(?:rs)?|fri|sat(?:ur)?|sun)(?:day)?s?"
FREQ = (r"(?:every ?day|everyday|daily|each day|a day|per day|/day|every (?:morning|night|evening|afternoon|week|month|year)|each (?:morning|night|week|month)"
        r"|in the (?:morning|evening)|before bed|at night|a week|per week|/week|each week|weekly|a month|per month|monthly|a year|per year|yearly|annually"
        r"|every other (?:day|week|month)|every (?:\d+|two|three|four|five|six) (?:days|weeks|months)|on weekdays|on weekends|weekdays|weekends"
        r"|once|twice|\d+ ?(?:x|times)\b|(?:two|three|four|five|six|seven|ten) times|on " + DAYS + r")")
UNITS = r"(?:k\b|km|kms|kilometers?|kilometres?|miles?|mi\b|steps|min(?:ute)?s?\b|hours?|hrs?\b|h\b|pages?|chapters?|books?|glasses|cups?|bottles?|oz\b|ounces|ml\b|liters?|litres?|l\b|reps|push-?ups|pushups|sit-?ups|squats|pull-?ups|laps|words|lessons?|sessions?|servings?|calories|kcal|cigarettes|drinks|beers|pills|tablets|lbs?|pounds|kg|verses|prayers|pomodoros?|coffees?|cans?|units|portions|meals|times)"
NUM = r"(?:\d[\d,.]*|one|two|three|four|five|six|seven|eight|nine|ten|twelve|fifteen|twenty|thirty|forty|fifty|a hundred|half an?|an?)"
AMT = NUM + r"\s?-?" + UNITS
VERB = (r"(?:read(?:ing)?|run(?:ning)?|ran|walk(?:ing)?|jog(?:ging)?|drink(?:ing)?|meditat(?:e|ing|ion)|exercis(?:e|ing)|work(?:ing)? ?out|go(?:ing)? to (?:the )?gym|gym"
        r"|stud(?:y|ying)|practi[cs](?:e|ing)|pray(?:ing)?|journal(?:ing|ling)?|writ(?:e|ing)|floss(?:ing)?|brush(?:ing)?|stretch(?:ing)?|yoga|sleep(?:ing)?|wak(?:e|ing) up|get(?:ting)? up"
        r"|eat(?:ing)?|smok(?:e|ing)|vap(?:e|ing)|tak(?:e|ing) (?:my |a |the )?(?:vitamins?|meds|medications?|medicine|pills?|supplements?|walk|shower|cold shower)|learn(?:ing)?|clean(?:ing)?|water(?:ing)? (?:the |my )?plants"
        r"|call(?:ing)? (?:my )?(?:mom|mum|dad|parents|family|friend)|cook(?:ing)?|swim(?:ming)?|bik(?:e|ing)|cycl(?:e|ing)|lift(?:ing)?|train(?:ing)?|play(?:ing)? (?:the )?(?:guitar|piano|violin|drums)"
        r"|hik(?:e|ing)|danc(?:e|ing)|draw(?:ing)?|paint(?:ing)?|cod(?:e|ing)|memori[sz](?:e|ing)|recit(?:e|ing)|plank(?:ing)?|skip(?:ping)? rope|row(?:ing)?|shower(?:ing)?|weigh(?:ing)? (?:myself|in)"
        r"|push-?ups|pushups|sit-?ups|squats|pull-?ups|steps|water|fast(?:ing)?|limit(?:ing)?|cut(?:ting)? (?:down|back)|quit(?:ting)?|stop(?:ping)?|no more than|less than|fewer than|at most|max(?:imum)?|at least|up to"
        r"|laundry|vacuum(?:ing)?|mow(?:ing)?|sav(?:e|ing) \$?\d|spend(?:ing)?|budget|duolingo|bible|quran|rosary|piano|guitar|spanish|french|german|japanese|language|vitamins?|meds|medications?)")
PAT = re.compile(r"\b" + VERB + r"\b(?:\W+\w+){0,6}?\W+(?:" + AMT + r"|" + FREQ + r")\b", re.I)
PAT2 = re.compile(r"\b" + AMT + r"\b(?:\W+\w+){0,4}?\W+" + FREQ + r"\b", re.I)  # "8 glasses of water a day"
