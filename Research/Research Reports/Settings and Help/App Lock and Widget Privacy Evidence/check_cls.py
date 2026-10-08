"""Validate cls/b*.py against read.jsonl: every review coded once, known codes only, quotes found in the review."""
import json, glob, re, html, collections
rows = {json.loads(l)["n"]: json.loads(l) for l in open("read.jsonl")}
codes_ok = set(re.findall(r"(?:^|\s{2,})([A-Z][A-Z_]+)\s", open("CODEBOOK.md").read(), re.M)) | {"NR", "PAYWALL"}
allc, seen, bad = {}, collections.Counter(), []
for f in sorted(glob.glob("cls/b*.py")):
    ns = {}; exec(open(f).read(), ns)
    for n, v in ns["C"].items():
        seen[n] += 1
        codes, quote = (v, None) if isinstance(v, str) else v
        for c in codes.split():
            if c not in codes_ok: bad.append((f, n, "unknown code " + c))
        if quote:
            t = html.unescape(rows[n]["text"])
            norm = lambda s: re.sub(r"\s+", " ", s).strip().lower()
            if norm(quote) not in norm(t): bad.append((f, n, "quote not found: " + quote[:60]))
        allc[n] = codes.split()
missing = sorted(set(rows) - set(allc)); dup = [n for n, k in seen.items() if k > 1]; extra = sorted(set(allc) - set(rows))
print("coded", len(allc), "of", len(rows), "| missing", missing[:20], len(missing), "| dup", dup[:20], "| extra", extra[:10])
print("problems", len(bad)); [print(b) for b in bad[:60]]
json.dump(allc, open("coded.json", "w"))
