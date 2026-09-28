"""Scan every extracted sentence for how people expect to log progress. Writes Temp/mental-model/logging_hits.txt for hand reading."""
import json, re, collections
files = ["habit_candidates.jsonl", "dropped3.jsonl", "rejects.jsonl"]
P = {
 "L1 tick each one as I go": r"\b(?:check|tick|mark|tap|click|press|swipe)\w*(?: it)?(?: off)? (?:each|every|one|1|individual)\b(?! day)|\beach time i (?:drink|finish|do|have|eat|read)|\bone (?:glass|cup|bottle|liter|litre) at a time|\bas i go\b|\bchip away\b|\btally\b|\bcounter\b|\b\d+/\d+\b",
 "L2 type the actual amount": r"\b(?:enter|input|type|put in|put|log|record|add)\w* (?:in )?(?:the |my )?(?:exact |actual |specific )?(?:amount|number|value|how many|how much|minutes|pages|ounces|ml)\b",
 "L3 custom step size": r"\+\s?\d|\bincrements?\b|\bcustom (?:\+|amount|value|increment)|\b\d+ ?(?:ml|oz) (?:button|at a time|each)|\beach (?:bottle|glass|cup) (?:is|=)|\bquick add\b|\bpre-?set values?\b",
 "L4 timer": r"\btimer\b|\bstop ?watch\b",
 "L5 partial or over the goal": r"\bpartial\w*\b|\bpartly\b|\bover (?:my|the) goal\b|\bexceed\w*\b|\bmore than (?:my|the) goal\b|\boverachiev\w*|\bextra (?:credit|effort|time)\b|\bgo over\b",
 "L6 undo or decrement": r"\bundo\b|\bdecrement\b|\bminus\b|\bsubtract\b|\buncheck\b",
}
out = open("Temp/mental-model/logging_hits.txt", "w"); c = collections.Counter(); ids = collections.defaultdict(set)
seen = set()
for f in files:
    for l in open("Temp/mental-model/" + f):
        d = json.loads(l); s = d["s"]
        if s in seen: continue
        seen.add(s)
        hit = [k for k, p in P.items() if re.search(p, s, re.I)]
        if hit:
            for k in hit: c[k] += 1; ids[k].add(d["id"])
            out.write(f"{d['id']} | {','.join(h[:2] for h in hit)} | {s[:200]}\n")
for k in P: print(c[k], len(ids[k]), k)
