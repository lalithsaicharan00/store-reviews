"""Merge both passes into one candidate file: keep sentences with a habit clause
(activity verb near an amount/frequency, amount near a frequency, or goal + amount).
Writes Temp/mental-model/candidates.jsonl (numbered) and rejects.jsonl."""
import json, re, sys
sys.path.insert(0, "Temp/mental-model")
from pats import PAT, PAT2, AMT, FREQ, NUM
GOAL = re.compile(r"\b(?:goal|target|aim)\b(?:\W+\w+){0,6}?\W+(?:" + AMT + r"|" + FREQ + r"|" + NUM + r")\b", re.I)
EXAMPLE = re.compile(r"\b(?:e\.g\.|for example|for instance|such as|like)\b[^.]{0,80}\b(?:" + FREQ + r")", re.I)
cand = open("Temp/mental-model/candidates.jsonl", "w"); rej = open("Temp/mental-model/rejects.jsonl", "w")
n = r_ = 0
for fn in ("statements.jsonl", "statements2.jsonl"):
    for l in open("Temp/mental-model/" + fn):
        d = json.loads(l); s = d["s"]
        why = "verb" if PAT.search(s) else "amt" if PAT2.search(s) else "goal" if GOAL.search(s) else "example" if EXAMPLE.search(s) else None
        if why:
            n += 1; d["n"] = n; d["why"] = why; cand.write(json.dumps(d, ensure_ascii=False) + "\n")
        else:
            r_ += 1; rej.write(l)
print("candidates", n, "rejects", r_)
