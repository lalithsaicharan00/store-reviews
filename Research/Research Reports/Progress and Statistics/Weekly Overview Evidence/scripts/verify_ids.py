"""Check that every review ID cited in the report exists in the source corpora, and that every quoted fragment
attributed to a review appears in some read review's text (after HTML-unescaping and whitespace normalising)."""
import json, glob, re, html, os
ROOT = "/home/user/store-reviews/Research"
REPORT = os.path.join(ROOT, "Research Reports/Progress and Statistics/Weekly Overview Card — Which Numbers to Show.md")
text = open(REPORT).read()
ids = set(re.findall(r"`([0-9a-f]{8}-[0-9a-f-]{27}|\d{9,12})`", text))
found, texts = set(), []
for pat in ["App Store Reviews/*/reviews.jsonl", "Play Store Reviews/*/reviews.jsonl"]:
    for f in glob.glob(os.path.join(ROOT, pat)):
        for line in open(f):
            r = json.loads(line); rid = str(r["review_id"])
            if rid in ids:
                found.add(rid)
                texts.append(" ".join(html.unescape((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).split()))
print(f"cited IDs: {len(ids)}, found: {len(found)}, missing: {sorted(ids - found)}")
norm = lambda t: re.sub(r"[‘’'“”\"]", "'", " ".join(t.split())).lower()
corpus = [norm(t) for t in texts]
bad = 0
# Only quotes attributed to a review: "…" (App, n★ …)
for q in re.findall(r'"([^"]{12,}?)"\s*\(([^)]*★[^)]*)\)', text, re.S):
    q = q[0]
    for part in re.split(r"\s*(?:…|\.\.\.)\s*", q):
        part = norm(part).strip(" .")
        if len(part) < 12 or part.startswith("http"): continue
        if not any(part in c for c in corpus):
            bad += 1; print("NOT FOUND:", part[:90])
print("quote fragments not found:", bad)
