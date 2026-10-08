import json, re
rows = [json.loads(l) for l in open("kept.jsonl")]
order = {"A": 0, "P": 1, "N": 2}
rows.sort(key=lambda r: (order[r["store"]], int(r["app"].split(".")[0]), r["date"]))
with open("read.jsonl", "w") as f:
    for n, r in enumerate(rows): r["n"] = n; f.write(json.dumps(r, ensure_ascii=False) + "\n")
print(len(rows))
