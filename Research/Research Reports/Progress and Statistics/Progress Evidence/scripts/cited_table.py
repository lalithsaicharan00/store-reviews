"""cited_table.py <report.md> — run from Research/. Rebuilds the 'Cited reviews' table at the end of the report."""
import json, glob, re, sys
f = sys.argv[1]; t = open(f, encoding="utf-8").read()
head, sep, _ = t.partition("### Cited reviews\n")
body = head
ID = r"[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|\d{9,12}"
secs = [(m.start(), m.group(1)) for m in re.finditer(r"^## (\d+)\. ", body, re.M)]
order, first = [], {}
for m in re.finditer(r"`(" + ID + r")`", body):
    i = m.group(1)
    if i in first: continue
    first[i] = max([s for s in secs if s[0] <= m.start()], default=(0, "0"))[1]; order.append(i)
want, info = set(order), {}
for fn in glob.glob("*Store Reviews/*/reviews.jsonl"):
    store = "App Store" if fn.startswith("App") else ("Play Store" if fn.startswith("Play") else "Native")
    folder = fn.split("/")[-2]
    for line in open(fn, encoding="utf-8"):
        r = json.loads(line)
        if r["review_id"] in want: info[r["review_id"]] = (store, folder, r.get("rating"), (r.get("date") or "")[:10])
rows = ["| Review ID | Store | App (folder) | ★ | Date | First cited in § |", "|---|---|---|---|---|---|"]
for i in order:
    s, fo, st, d = info[i]; rows.append(f"| `{i}` | {s} | {fo.replace('|', '/')} | {st} | {d} | {first[i]} |")
open(f, "w", encoding="utf-8").write(body + sep + f"{len(order)} reviews are cited, listed in the order they first appear.\n\n" + "\n".join(rows) + "\n")
print(len(order))
