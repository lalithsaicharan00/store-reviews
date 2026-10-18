"""Restore: replace or merge? (14 Oct 2026, Current Work 112). What people say happens when a restore replaces what's on
the phone, merges, duplicates, or loses what was logged since the backup. Run from Research/Temp/restore-mode."""
import json, re, glob, os, collections
ROOT = "../.."
P = {
 'OVERWRITE': r"restor\w*.{0,80}(overwr\w*|replac\w*|wip\w*|eras\w*|deleted|lost|gone).{0,60}(new|recent|current|since|today|latest|this week|days?)"
              r"|(overwr\w*|replac\w*|wip\w*).{0,60}(my )?(new|recent|current|latest) (data|entries|habits|progress|logs|records)",
 'MERGE': r"\bmerg\w*\b.{0,80}(backup|restor\w*|data|habits|import\w*)|(backup|restor\w*|import\w*).{0,80}\bmerg\w*",
 'DUPLICATE': r"(restor\w*|import\w*|sync\w*).{0,80}(duplicat\w*|double[ds]?|twice|two copies|copies of)",
 'OLD_BACKUP': r"restor\w*.{0,60}(old|older|wrong|earlier) (backup|version|data)|(old|older) backup.{0,60}(restor\w*|overwr\w*)",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
TOPIC = re.compile(r"habit|streak|track|log|backup|restor|data|record", re.I)
out = open("candidates.jsonl","w"); c = collections.Counter(); total = 0
for store, base in (("A","App Store Reviews"),("P","Play Store Reviews")):
    for f in sorted(glob.glob(f"{ROOT}/{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for i, line in enumerate(open(f)):
            r = json.loads(line); total += 1
            text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip(" —")
            hits = [k for k, rx in RX.items() if rx.search(text)]
            if not hits or not TOPIC.search(text): continue
            for h in hits: c[h] += 1
            out.write(json.dumps({"key": f"{store}{app.split('.')[0]}#{i}", "app": app, "review_id": r["review_id"], "rating": r.get("rating"), "date": (r.get("date") or "")[:10], "hits": hits, "text": text}, ensure_ascii=False) + "\n")
print(total, dict(c))
