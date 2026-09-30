"""verify_ids.py <report.md> — run from Research/.

Checks the report against the source reviews.jsonl files:
 1. every review ID cited in `backticks` exists;
 2. every quote written as "…" (`id`) appears in that review (case, punctuation and spacing ignored;
    a quote with … is checked piece by piece);
 3. every review ID in Progress Evidence/coded_reviews.tsv exists.
Prints problems and exits 1 if any."""
import json, glob, re, sys, html, os, csv
text = {}
for f in glob.glob("*Store Reviews/*/reviews.jsonl"):
    for line in open(f, encoding="utf-8"):
        r = json.loads(line)
        text[r["review_id"]] = html.unescape((r.get("title") or "") + " " + (r.get("body") or r.get("text") or ""))
norm = lambda s: re.sub(r"[^\w]+", "", s.lower().replace("’", "'").replace("'", ""))
bad = []
tsv = "Research Reports/Progress and Statistics/Progress Evidence/coded_reviews.tsv"
rows = list(csv.DictReader(open(tsv, encoding="utf-8"), delimiter="\t"))
miss = [r["review_id"] for r in rows if r["review_id"] not in text]
print("coded rows:", len(rows), "unknown ids:", miss[:5]); bad += miss
ID = r"[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|\d{9,12}"
for rep in sys.argv[1:]:
    t = open(rep, encoding="utf-8").read()
    cited = set(re.findall(r"`(" + ID + r")`", t))
    unknown = sorted(c for c in cited if c not in text)
    checked = wrong = 0
    for q, rid in re.findall(r"\"([^\"\n]{6,400}?)\"[^\"\n`]{0,80}?`(" + ID + r")`", t):
        if rid not in text: continue
        checked += 1
        body = norm(text[rid])
        parts = [norm(p) for p in re.split(r"…|\.\.\.", q) if len(norm(p)) >= 4]
        if not all(p in body for p in parts):
            wrong += 1; bad.append((rid, q)); print("  quote not found:", rid, "|", q[:100])
    print(os.path.basename(rep), "- cited ids:", len(cited), "unknown:", unknown, "- quotes checked:", checked, "not found:", wrong)
    bad += unknown
sys.exit(1 if bad else 0)
