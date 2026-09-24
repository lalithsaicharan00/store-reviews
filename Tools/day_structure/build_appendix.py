"""build_appendix.py -> appendix_cited.md: the cited-review table, IDs pulled from cites.json (resolved by index)."""
import json
from gists import G
d = json.load(open("cites.json"))
rows = ["| Ref | App | Store | ★ | Date | Review ID | Codes | Gist (paraphrase) |", "|---|---|---|---|---|---|---|---|"]
for e, c in sorted(d["cites"].items(), key=lambda kv: int(kv[0][1:])):
    assert c["i"] in G, f"no gist for {c['i']}"
    rows.append(f'| {e} | {c["app"]} | {c["store"]} | {c["rating"]} | {c["date"]} | `{c["id"]}` | {" ".join(c["codes"])} | {G[c["i"]]} |')
open("appendix_cited.md", "w").write("\n".join(rows) + "\n")
print(len(rows) - 2, "rows")
