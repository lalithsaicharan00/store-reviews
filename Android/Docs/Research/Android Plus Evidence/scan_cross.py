"""Reviews that mention the OTHER platform: Play reviews naming iPhone/iOS/iPad/Mac; App Store reviews naming Android.

Run from Research/:  python -I "../Android/Docs/Research/Android Plus Evidence/scan_cross.py"
Writes cross_play.jsonl, cross_app.jsonl, cross_counts.md and read/cross-<store>-<k>.txt (a seeded random 150 per
store, in batches of 50), all languages (the platform names are written the same way in most languages).
"""
import json, os, random, re
from collections import Counter

R = os.getcwd()
OUT = os.path.join(R, "..", "Android", "Docs", "Research", "Android Plus Evidence")
OTHER = {
    "P": re.compile(r"\b(iphone|i-phone|ios|ipad|app ?store|apple (watch|device|devices|version|user|users|phone|account|id)|"
                    r"macbook|mac ?os|imac|icloud)\b", re.I),
    "A": re.compile(r"\b(android|google play|play ?store|samsung|galaxy|pixel|xiaomi|huawei|oneplus|wear ?os)\b", re.I),
}
TOPIC = {
    "switch": r"switch(ed|ing)?|mov(ed|ing) (from|to)|changed (from|to)|new (phone|iphone)|got an? (iphone|android)|came from",
    "pay_again": r"pay(ing)? (again|twice)|purchase again|buy (it )?again|bought (it )?(on|for) (my )?(iphone|android|ios)|restore (my )?purchase|separate(ly)? (purchase|subscription)",
    "both": r"\bboth\b|and (my )?(iphone|ipad|android)|across (platforms|devices)|cross[- ]platform",
    "parity": r"(ios|iphone|android) version (has|is|doesn|does not|lacks|missing)|(available|exists?) (on|for) (ios|iphone|android)|only (on|for) (ios|iphone|android)|not (available )?(on|for) (ios|iphone|android)",
    "sync": r"sync",
}
TOPIC = {k: re.compile(v, re.I) for k, v in TOPIC.items()}

lines = ["| Topic words present | Play reviews naming Apple devices | App Store reviews naming Android |", "|---|---|---|"]
res = {}
for store, folder, name in (("P", "Play Store Reviews", "play"), ("A", "App Store Reviews", "app")):
    rows = []
    for d in os.listdir(os.path.join(R, folder)):
        p = os.path.join(R, folder, d, "reviews.jsonl")
        if not os.path.exists(p):
            continue
        num = d.split(".")[0]
        for i, l in enumerate(open(p, encoding="utf-8")):
            r = json.loads(l)
            t = (r.get("text") if store == "P" else (r.get("title") or "") + " — " + (r.get("body") or "")) or ""
            if not OTHER[store].search(t):
                continue
            rows.append({"cite": f"{store}{num}#{i}", "id": r["review_id"], "app": d, "rating": r.get("rating"),
                         "date": (r.get("date") or "")[:10], "lang": r.get("language") or r.get("country"),
                         "topics": [k for k, rx in TOPIC.items() if rx.search(t)], "text": t.replace("\n", " ")})
    res[store] = rows
    with open(os.path.join(OUT, f"cross_{name}.jsonl"), "w", encoding="utf-8") as f:
        for r in rows:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")
    pick = list(rows)
    random.Random(20261011).shuffle(pick)
    pick = pick[:150]
    for k in range(0, len(pick), 50):
        with open(os.path.join(OUT, "read", f"cross-{name}-{k // 50 + 1}.txt"), "w", encoding="utf-8") as f:
            for r in pick[k:k + 50]:
                f.write(f"[{r['cite']}] {r['rating']}★ {r['date'][:4]} {r['lang']} | {r['app'][:26]}\n{r['text'][:800]}\n\n")
cP, cA = Counter(t for r in res["P"] for t in r["topics"]), Counter(t for r in res["A"] for t in r["topics"])
for k in TOPIC:
    lines.append(f"| {k} | {cP[k]} | {cA[k]} |")
lines.append(f"| **all** | {len(res['P'])} | {len(res['A'])} |")
open(os.path.join(OUT, "cross_counts.md"), "w", encoding="utf-8").write("\n".join(lines) + "\n")
print("\n".join(lines))
