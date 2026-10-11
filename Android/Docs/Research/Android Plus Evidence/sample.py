"""Draw a seeded random sample of payer matches per store and write readable batches of 50.

Run from Research/:  python -I "../Android/Docs/Research/Android Plus Evidence/sample.py" <play|app> <n> <seed>
Writes read/<store>-<k>.txt (k = 1..) and sample-<store>.json (the cites, in order).
"""
import json, os, random, sys

OUT = os.path.join(os.getcwd(), "..", "Android", "Docs", "Research", "Android Plus Evidence")
store, n, seed = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
rows = [json.loads(l) for l in open(os.path.join(OUT, f"payers_{store}.jsonl"), encoding="utf-8")]
random.Random(seed).shuffle(rows)
rows = rows[:n]
os.makedirs(os.path.join(OUT, "read"), exist_ok=True)
json.dump([r["cite"] for r in rows], open(os.path.join(OUT, f"sample-{store}.json"), "w"))
for k in range(0, len(rows), 50):
    with open(os.path.join(OUT, "read", f"{store}-{k // 50 + 1}.txt"), "w", encoding="utf-8") as f:
        for r in rows[k:k + 50]:
            t = r["text"].replace("\n", " ")
            f.write(f"[{r['cite']}] {r['rating']}★ {r['date']} {r['lang']} | {r['app'][:30]}\n{t[:900]}\n\n")
print(len(rows))
