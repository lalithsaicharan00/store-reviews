"""Scan every review for natural-language entry: 'natural language', 'NLP', 'smart add', typed dates like Todoist,
and 'let me just type the habit'. Writes Temp/mental-model/nl_scan.txt (id | app | habit-app? | theme | excerpt)."""
import json, glob, re, collections, html
T = {"NL1 natural-language entry (NLP, natural language, parses what I type)": r"\bnatural[- ]language\b|\bNLP\b|\bsmart (?:add|input|parsing)\b|\bpars(?:es|ing) (?:the )?(?:text|dates?|what i type)\b|\bunderstands? (?:plain|natural|what i type)",
     "NL2 let me just type the habit / what I want": r"\bjust type (?:in )?(?:a |the |my |any )?(?:habit|goal|what)|\btype in (?:any|my own) habit\b|\btype (?:it )?(?:in )?(?:as|like) (?:i|you) (?:say|would say|talk)\b",
     "NL3 quick add sizes / preset amounts": r"\bquick[- ]add (?:sizes?|amounts?|buttons?|values?)\b|\bpre-?set (?:amounts?|values?|sizes?)\b"}
HAB = re.compile(r"habit|routine|streak|finch|fabulous|loop|atoms|tally|productive|me\+|ultiself|daily tracker", re.I)
out = open("Temp/mental-model/nl_scan.txt", "w"); c = collections.Counter(); ch = collections.Counter(); seen = set()
for f in glob.glob("*Store Reviews/*/reviews.jsonl"):
    for line in open(f, encoding="utf-8"):
        r = json.loads(line)
        if r.get("language") and r["language"] != "en": continue
        t = html.unescape((r.get("title") or "") + ". " + (r.get("body") or r.get("text") or ""))
        for k, p in T.items():
            m = re.search(p, t, re.I)
            if m and (r["review_id"], k) not in seen:
                seen.add((r["review_id"], k)); hab = bool(HAB.search(r["app_name"])); c[k] += 1; ch[k] += hab
                out.write(f"{r['review_id']} | {r['app_name']} | hab={hab} | {k[:3]} | {t[max(0, m.start()-150):m.end()+200]!r}\n")
for k in T: print(c[k], "reviews;", ch[k], "in habit/routine apps:", k)
