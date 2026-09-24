"""resolve_cites.py -> cites.json: E-number -> review metadata, resolved by index (never typed by hand)."""
import json, re
I = [json.loads(l) for l in open("index.jsonl")]
C = {json.loads(l)["i"]: json.loads(l) for l in open("coded.jsonl")}
def app(folder):
    return re.sub(r"^\d+\.\s*", "", folder).split(" - ")[0].split(" – ")[0].strip()
out, groups, n, seen = {}, {}, 0, {}
for l in open("cites.txt"):
    key, *idx = l.split()
    groups[key] = []
    for s in idx:
        i = int(s)
        assert i in C, f"{i} not coded"
        if i not in seen:
            n += 1; seen[i] = f"E{n}"
            r = I[i]
            out[seen[i]] = {"i": i, "store": {"app": "App Store", "play": "Google Play"}[r["store"]], "folder": r["folder"],
                            "app": app(r["folder"]), "line": r["line"], "id": r["id"], "rating": r["rating"],
                            "date": r["date"][:10], "lang": r["lang"], "codes": C[i]["codes"]}
        groups[key].append(seen[i])
json.dump({"cites": out, "groups": groups}, open("cites.json", "w"), ensure_ascii=False, indent=1)
for k, v in groups.items(): print(k, " ".join(v))
print(len(out), "unique cited reviews")
