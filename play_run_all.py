#!/usr/bin/env python3
"""
Extract Play reviews for every app in play-habit-apps-ranked.json, in rank order.

Strictly one app at a time -- never stacks concurrent sweeps, so we don't invite
an IP block. Folder prefix is the app's rank. Safe to rerun: completed apps and
completed languages are skipped in milliseconds.

  python3 play_run_all.py              # all apps
  python3 play_run_all.py 1 2 3        # only these ranks
  python3 play_run_all.py --priority   # 20 biggest languages only (much faster)
"""
import json
import subprocess
import sys
import time

args = [a for a in sys.argv[1:]]
langs = "priority" if "--priority" in args else "all"
only = {a for a in args if a.isdigit()} or None

ranked = json.load(open("play-habit-apps-ranked.json", encoding="utf-8"))["results"]
t0 = time.time()
done = failed = 0

for r in ranked:
    pos, pkg, name = r["position"], r["package"], r["name"]
    if only and str(pos) not in only:
        continue
    print(f"\n{'='*72}\n[{pos}/{len(ranked)}] {name}  ({pkg})\n{'='*72}", flush=True)
    cmd = ["python3", "play_extract.py", pkg, "--languages", langs,
           "--workers", "4", "--number", str(pos)]
    try:
        p = subprocess.run(cmd, timeout=5400)
        if p.returncode == 0:
            done += 1
        else:
            failed += 1
            print(f"  !! rc={p.returncode} for {name}", flush=True)
    except subprocess.TimeoutExpired:
        failed += 1
        print(f"  !! timed out: {name}", flush=True)
    time.sleep(3)          # breathe between apps

print(f"\n{'='*72}")
print(f"finished {done} apps, {failed} failed, in {(time.time()-t0)/60:.1f} min")
