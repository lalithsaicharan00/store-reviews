"""Keep candidates where a real-life activity word sits within 8 words of an amount or frequency.
Writes habit_candidates.jsonl (renumbered 'k') and dropped3.jsonl."""
import json, re, sys
sys.path.insert(0, "Temp/mental-model")
from pats import AMT, FREQ
ACT = (r"(?:water|drink\w*|drank|read\w*|books?|pages?|chapters?|run\w*|ran|jog\w*|walk\w*|steps|gym|work ?out\w*|exercis\w*|meditat\w*|yoga|pray\w*|prayers?|bible|quran|salah|namaz|rosary|devotion\w*"
       r"|journal\w*|stud(?:y|ied|ying)|practi[cs]\w*|floss\w*|brush\w*|teeth|vitamins?|meds|medic\w*|pills?|supplements?|sleep\w*|bed(?:time)?|wak(?:e|ing) up|woke|get up|smok\w*|cigarettes?|vap\w*|alcohol|drinks|beers?|wine"
       r"|coffees?|caffeine|sugar|soda|junk food|snack\w*|eat\w*|ate|meals?|fruits?|veg\w*|protein|calories|push-?ups|pushups|sit-?ups|squats|pull-?ups|planks?|stretch\w*|clean\w*|laundry|dishes|vacuum\w*|trash|bins"
       r"|plants|call\w* (?:my )?(?:mom|mum|dad|parents|grandma|family)|spanish|french|german|japanese|korean|chinese|italian|language|duolingo|guitar|piano|violin|drums|instrument|cod(?:e|ing)|writ(?:e|ing)|wrote|words|draw\w*|paint\w*"
       r"|cook\w*|swim\w*|bik(?:e|ing)|cycl\w*|hik\w*|weigh\w*|fast(?:ing)?|social media|screen time|phone|instagram|tiktok|youtube|porn|nails?|shower\w*|skincare|skin care|sunscreen|lift\w*|weights|cardio|train(?:ing)?"
       r"|miles?|km|5k|10k|kilomet\w*|laps|reps|sets|lessons?|homework|podcast|affirmations?|gratitude|dog|cat|bills|budget|savings?|money|kids?|posture|mouthwash|contacts|insulin|blood pressure|glucose|period|dance|danc\w*|sport\w*|tennis|soccer|football|basketball|golf|climb\w*)")
NEAR = re.compile(r"\b" + ACT + r"\b(?:\W+\w+){0,8}?\W+(?:" + AMT + r"|" + FREQ + r")\b|\b(?:" + AMT + r"|" + FREQ + r")\b(?:\W+\w+){0,8}?\W+" + ACT + r"\b", re.I)
NOISE = re.compile(r"\b(?:spen[dt]\w* \w+ (?:minutes|hours) (?:trying|to)|subscri\w+|refund\w*|charg\w+|free trial|per month for|a month for|\$\d|£\d|€\d|crash\w*|sync\w*|log ?in|sign(?:ed)? in|password|account)\b", re.I)
k = 0; out = open("Temp/mental-model/habit_candidates.jsonl", "w"); dr = open("Temp/mental-model/dropped3.jsonl", "w"); nd = 0
for l in open("Temp/mental-model/candidates.jsonl"):
    d = json.loads(l); s = d["s"]
    if NEAR.search(s) and not NOISE.search(s):
        k += 1; d["k"] = k; out.write(json.dumps(d, ensure_ascii=False) + "\n")
    else:
        nd += 1; dr.write(l)
print("kept", k, "dropped", nd)
