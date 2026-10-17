"""Milestones and celebrations in the top 20 App Store and top 20 Play Store habit apps' own reviews (17 Oct 2026)."""
import json, re, os, glob, sys
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".."))
MS = re.compile(r"\b(milestones?|badges?|troph(y|ies)|medals?|achievements?|awards?)\b", re.I)
CEL = re.compile(r"\b(confetti|fireworks?|celebrat\w*|congratulat\w*|animations?|cheer\w*)\b", re.I)
NOISE = re.compile(r"icon badge|badge (count|number|on the (app )?icon)|notification badge|app badge|red (dot|badge)|badge app icon", re.I)
out = {}
for tag, base, rng in (("A", "App Store Reviews", range(1, 21)), ("P", "Play Store Reviews", range(1, 21))):
    for n in rng:
        d = glob.glob(os.path.join(ROOT, base, f"{n}. *"))
        if not d: continue
        d = d[0]; f = os.path.join(d, "reviews.jsonl")
        name = os.path.basename(d)
        hits = {"ms": [], "cel": []}; total = 0
        for i, line in enumerate(open(f, encoding="utf-8")):
            total += 1
            try: r = json.loads(line)
            except Exception: continue
            t = ((r.get("title") or "") + ". " + (r.get("body") or r.get("text") or r.get("content") or "")).strip()
            if MS.search(t) and not NOISE.search(t): hits["ms"].append((i, t))
            if CEL.search(t): hits["cel"].append((i, t))
        out[f"{tag}{n}"] = {"name": name, "reviews": total, "ms": [h[0] for h in hits["ms"]], "cel": [h[0] for h in hits["cel"]]}
        for k, rx in (("ms", MS), ("cel", CEL)):
            print(f"=== {tag}{n} {name[:45]} | {k} {len(hits[k])} of {total}")
            for i, t in hits[k][:4]:
                m = rx.search(t); s = max(0, m.start() - 110)
                print(f"   {tag}{n}#{i}: …{t[s:m.end()+110].replace(chr(10), ' ')}…")
json.dump(out, open("scan_index.json", "w"))
