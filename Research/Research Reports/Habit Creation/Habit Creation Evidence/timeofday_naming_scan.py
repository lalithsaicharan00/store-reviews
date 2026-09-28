# What do reviewers call the parts of the day? Counts reviews (App Store + Play, all habit corpora)
# that mention morning/afternoon/evening/night AND one naming phrase.
import json, glob, re, collections
ROOT = "/Users/lalith/Desktop/store reviews/Research/"
files = glob.glob(ROOT + "App Store Reviews/*/reviews.jsonl") + glob.glob(ROOT + "Play Store Reviews/*/reviews.jsonl")
parts = re.compile(r"\b(morning|afternoon|evening|night)\b", re.I)
terms = {
    "time of (the) day": r"\btimes? of (the )?day\b",
    "part(s) of the day": r"\bparts? of (the |my )?day\b",
    "section(s)": r"\bsections?\b",
    "category/categories": r"\bcategor(y|ies)\b",
    "group(s)": r"\bgroups?\b",
    "routine(s)": r"\broutines?\b",
    "time block / block": r"\b(time ?blocks?|blocks)\b",
    "period(s)": r"\bperiods?\b",
    "daypart / day part": r"\bday ?parts?\b",
    "slot(s)": r"\b(time )?slots?\b",
}
counts = collections.Counter(); total = 0; hits = collections.defaultdict(list)
for f in files:
    for i, line in enumerate(open(f, encoding="utf-8")):
        r = json.loads(line)
        text = f"{r.get('title') or ''} {r.get('body') or r.get('content') or r.get('text') or ''}"
        if not parts.search(text): continue
        total += 1
        for name, pat in terms.items():
            if re.search(pat, text, re.I):
                counts[name] += 1
                if len(hits[name]) < 400: hits[name].append((f.split("Research/")[1].split("/reviews")[0], i, text[:400]))
print("reviews mentioning morning/afternoon/evening/night:", total)
for k, v in counts.most_common(): print(f"{v:6d}  {k}")
json.dump(hits, open("naming_hits.json", "w"), ensure_ascii=False, indent=0)
