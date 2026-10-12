"""Step 3: what Android's best-rated habit trackers are praised for. Seeded (20261012) 12 per app of 5-star English
reviews, 120+ characters, 2023 or later, from the six habit trackers with the most English Play reviews.
Run from Research/: python -I Temp/android-research/sample_praise.py  -> read/praise_top_apps.txt"""
import json, os, random
APPS = ["3", "2", "24", "10", "65", "125"]
root = "Play Store Reviews"; out = []
for num in APPS:
    d = [x for x in os.listdir(root) if x.split(".")[0] == num][0]
    pool = []
    for i, l in enumerate(open(os.path.join(root, d, "reviews.jsonl"), encoding="utf-8")):
        r = json.loads(l)
        if r.get("language") == "en" and r["rating"] == 5 and len(r["text"] or "") >= 120 and r["date"] >= "2023":
            pool.append((i, r))
    random.Random(20261012).shuffle(pool)
    out.append(f"## P{num} {d}: {len(pool)} eligible, showing 12\n")
    for i, r in pool[:12]:
        out.append(f"[P{num}#{i}] {r['date'][:4]}\n{r['text']}\n")
open("Temp/android-research/read/praise_top_apps.txt", "w", encoding="utf-8").write("\n".join(out))
