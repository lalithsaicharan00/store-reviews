"""Tally coded_themes.CODED -> theme_tally.md. Checks every coded ID is in its read/<theme>.txt sample."""
import re, collections, io
from coded_themes import CODED
out = io.StringIO()
out.write("# Hand-coded Play samples: tallies (seed 20261012, 40 per theme, English, 40+ chars)\n\n")
for theme, m in CODED.items():
    sample = open(f"read/{theme}.txt", encoding="utf-8").read()
    ids = re.findall(r"^\[(P\d+#\d+)\]", sample, re.M)
    missing = [k for k in m if k not in ids]; uncoded = [i for i in ids if i not in m]
    assert not missing and not uncoded, (theme, missing, uncoded)
    c = collections.Counter(code for v in m.values() for code in v.split())
    on = sum(1 for v in m.values() if v != "NOISE")
    out.write(f"## {theme}: {len(m)} read, {on} on topic\n\n| Code | n | Example IDs |\n|---|---|---|\n")
    for code, n in c.most_common():
        ex = [k for k, v in m.items() if code in v.split()][:4]
        out.write(f"| {code} | {n} | {', '.join(ex)} |\n")
    out.write("\n")
open("theme_tally.md", "w", encoding="utf-8").write(out.getvalue())
print("ok")
