"""Every candidate coded exactly once, every code known, every quote found in its review."""
import json, glob, re, html, sys
rs = [json.loads(l) for l in open("../../../Temp/onboarding-returning/candidates.jsonl")]
known = set(re.findall(r"^\| ([A-Z_]+) \|", open("CODEBOOK.md").read(), re.M))
seen = {}; errs = []
for f in sorted(glob.glob("cls/*.txt")):
    for line in open(f):
        line = line.rstrip("\n")
        if not line.strip(): continue
        head, _, quote = line.partition(" | ")
        parts = head.split(); i = int(parts[0]); codes = parts[1:]
        if i in seen: errs.append(f"{f}: {i} coded twice")
        seen[i] = codes
        if not codes: errs.append(f"{f}: {i} no code")
        for c in codes:
            if c not in known: errs.append(f"{f}: {i} unknown code {c}")
        if quote:
            t = rs[i]["text"]
            if quote not in t and html.unescape(quote) not in html.unescape(t): errs.append(f"{f}: {i} quote not found: {quote[:60]}")
upto = int(sys.argv[1]) if len(sys.argv) > 1 else len(rs)
missing = [i for i in range(upto) if i not in seen]
print("coded", len(seen), "missing", missing[:20], len(missing)); print("\n".join(errs) or "no errors")
