"""Sync complaints across both stores: duplicates / counted twice, missing on the other device, slow, overwritten,
can't tell if it synced. A sentence must name sync or another device AND a problem word.

Run from Research/:  python -I "../Android/Docs/Research/Android Plus Evidence/scan_synccomplaints.py"
Writes synccomp.jsonl, synccomp_counts.md, read/synccomp-<cat>.txt (seeded random 40 per category, both stores).
"""
import json, os, random, re
from collections import Counter, defaultdict

R = os.getcwd()
OUT = os.path.join(R, "..", "Android", "Docs", "Research", "Android Plus Evidence")
DEV = re.compile(r"\b(sync\w*|ipad|tablet|apple watch|watch|wear ?os|galaxy watch|other device|another device|"
                 r"both devices|second phone|computer|desktop|laptop|\bpc\b|\bmac\b|web ?(app|version)|icloud|google drive|cloud)\b", re.I)
CAT = {
    "duplicate": r"duplicat\w*|doubl(e|ed|es|ing)\b|twice|two of (each|every)|counted (it )?again|logged (it )?again|copies of|repeated (entries|habits)",
    "missing": r"(doesn'?t|does not|didn'?t|did not|won'?t|isn'?t|not) (show|appear|transfer|carry|come)\w*|missing|disappear\w*|not there|gone from",
    "slow": r"\bslow\w*|delay\w*|takes? (forever|ages|hours|minutes)|hours? later|not (in )?real[- ]?time|lag\w*|out of sync|behind",
    "overwrite": r"overwr\w*|over-?wr\w*|replac\w* (my|all|the)|wip(e|ed|es) (out|my|all)|erased|reset (all|my)|lost (all|my|everything)",
    "status": r"(no|any) way to (tell|know|see)|sync (indicator|status|icon|button)|last sync\w*|(is|was) (it )?synced\??|whether (it'?s|it is|it has) synced|force (a )?sync|manual(ly)? sync",
}
CAT = {k: re.compile(v, re.I) for k, v in CAT.items()}

hits = defaultdict(list)
totals = Counter()
for store, folder in (("P", "Play Store Reviews"), ("A", "App Store Reviews")):
    for d in os.listdir(os.path.join(R, folder)):
        p = os.path.join(R, folder, d, "reviews.jsonl")
        if not os.path.exists(p):
            continue
        num = d.split(".")[0]
        for i, l in enumerate(open(p, encoding="utf-8")):
            r = json.loads(l)
            t = (r.get("text") if store == "P" else (r.get("title") or "") + " — " + (r.get("body") or "")) or ""
            if not DEV.search(t):
                continue
            for s in re.split(r"(?<=[.!?\n])\s+", t):
                if not DEV.search(s):
                    continue
                for k, rx in CAT.items():
                    if rx.search(s) and not any(h["cite"] == f"{store}{num}#{i}" for h in hits[k][-3:]):
                        hits[k].append({"cite": f"{store}{num}#{i}", "id": r["review_id"], "app": d, "store": store,
                                        "rating": r.get("rating"), "date": (r.get("date") or "")[:10],
                                        "sent": s.strip()[:420]})
                        totals[(k, store)] += 1
with open(os.path.join(OUT, "synccomp.jsonl"), "w", encoding="utf-8") as f:
    for k, v in hits.items():
        for h in v:
            f.write(json.dumps(dict(h, cat=k), ensure_ascii=False) + "\n")
lines = ["| Category | Play | App Store |", "|---|---|---|"]
for k in CAT:
    lines.append(f"| {k} | {totals[(k, 'P')]} | {totals[(k, 'A')]} |")
    pick = list(hits[k]); random.Random(20261011).shuffle(pick); pick = pick[:40]
    with open(os.path.join(OUT, "read", f"synccomp-{k}.txt"), "w", encoding="utf-8") as f:
        f.write(f"# {k}: {len(hits[k])} matches, showing {len(pick)}\n\n")
        for h in pick:
            f.write(f"[{h['cite']}] {h['rating']}★ {h['date'][:4]} | {h['app'][:24]}\n  >> {h['sent']}\n\n")
open(os.path.join(OUT, "synccomp_counts.md"), "w", encoding="utf-8").write("\n".join(lines) + "\n")
print("\n".join(lines))
