"""Payment linked to a feature: a payment verb and a feature word within ~70 characters, same sentence, English.

Run from Research/:  python -I "../Android/Docs/Research/Android Plus Evidence/scan_reasons.py"
Reads ALL reviews of both stores (not only the payer scan), so "would pay for X" is caught too; the hand reading
separates "paid for X" from "would pay for X" and from noise. Writes link_<store>.jsonl and
read/link-<store>-<feature>.txt (every match, or a seeded random 60 if more), counts in link_counts.md.
"""
import json, os, random, re
from collections import defaultdict

R = os.getcwd()
OUT = os.path.join(R, "..", "Android", "Docs", "Research", "Android Plus Evidence")
PAY = r"(paid|pay|paying|bought|buy|buying|purchased|purchase|upgraded|upgrade|subscribed|subscribe|premium|pro version|lifetime|unlock(ed)?)"
FEAT = {
    "devices": r"sync\w*|tablet|ipad|another device|other devices?|multiple devices|all (my |of my )?devices|second phone|\bmac\b|macbook|desktop|computer|\bpc\b|laptop|web (version|app)|chromebook",
    "watch": r"smart ?watch|wear ?os|galaxy watch|apple watch|pixel watch|watch app|(on|for|with) (my|the|your) watch|watch face|complication",
    "widget": r"widgets?",
    "unlimited": r"unlimited|more (than \w+ )?habits|more goals|habit limit|limit of \w+ habits|\w+ habits limit|more than (3|4|5|6|7|three|four|five|six|seven) (habits|goals|tasks)",
    "backup": r"back ?ups?|backed up|restore my data|google drive|icloud backup|export",
    "ads": r"\bads\b|\badvert\w*|ad[- ]free|no ads|remove ads",
    "themes": r"themes?|colou?rs?|icons?|dark mode|customi[sz]\w+",
    "stats": r"stat(s|istics)|charts?|graphs?|analytics|insights|reports?",
}
PAYRX = re.compile(r"\b" + PAY + r"\b", re.I)
FEATRX = {k: re.compile(r"\b(" + v + r")\b", re.I) for k, v in FEAT.items()}

def sentences(t):
    return re.split(r"(?<=[.!?\n])\s+", t)

def scan(store, folder):
    hits = defaultdict(list)
    base = os.path.join(R, folder)
    for d in os.listdir(base):
        p = os.path.join(base, d, "reviews.jsonl")
        if not os.path.exists(p):
            continue
        num = d.split(".")[0]
        for i, line in enumerate(open(p, encoding="utf-8")):
            r = json.loads(line)
            lang = r.get("language") or ""
            if store == "P" and lang != "en":
                continue
            t = (r.get("text") if store == "P" else (r.get("title") or "") + " — " + (r.get("body") or "")) or ""
            if store == "A" and not re.search(r"\b(the|and|for|with|app)\b", t, re.I):
                continue  # App Store has no language field: keep English-looking text only
            for s in sentences(t):
                pm = PAYRX.search(s)
                if not pm:
                    continue
                for k, rx in FEATRX.items():
                    for fm in rx.finditer(s):
                        if abs(fm.start() - pm.start()) <= 70:
                            hits[k].append({"cite": f"{store}{num}#{i}", "id": r["review_id"], "app": d,
                                            "rating": r.get("rating"), "date": (r.get("date") or "")[:10],
                                            "sent": s.strip()[:400], "text": t.replace("\n", " ")[:700]})
                            break
                    else:
                        continue
    # one hit per review per feature
    for k in hits:
        seen, uniq = set(), []
        for h in hits[k]:
            if h["cite"] not in seen:
                seen.add(h["cite"]); uniq.append(h)
        hits[k] = uniq
    return hits

counts = {}
for store, folder, name in (("P", "Play Store Reviews", "play"), ("A", "App Store Reviews", "app")):
    hits = scan(store, folder)
    counts[store] = {k: len(v) for k, v in hits.items()}
    with open(os.path.join(OUT, f"link_{name}.jsonl"), "w", encoding="utf-8") as f:
        for k, v in hits.items():
            for h in v:
                f.write(json.dumps(dict(h, feature=k), ensure_ascii=False) + "\n")
    for k, v in hits.items():
        pick = list(v)
        random.Random(20261011).shuffle(pick)
        pick = pick[:60]
        with open(os.path.join(OUT, "read", f"link-{name}-{k}.txt"), "w", encoding="utf-8") as f:
            f.write(f"# {name} {k}: {len(v)} matches, showing {len(pick)} (seed 20261011)\n\n")
            for h in pick:
                f.write(f"[{h['cite']}] {h['rating']}★ {h['date'][:4]} | {h['app'][:24]}\n  >> {h['sent']}\n\n")
lines = ["| Feature | Play (English) | App Store (English) |", "|---|---|---|"]
for k in FEAT:
    lines.append(f"| {k} | {counts['P'].get(k, 0)} | {counts['A'].get(k, 0)} |")
open(os.path.join(OUT, "link_counts.md"), "w", encoding="utf-8").write("\n".join(lines) + "\n")
print("\n".join(lines))
