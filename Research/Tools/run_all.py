#!/usr/bin/env python3
"""
Extract reviews for every app in habit_apps_ranked.json, in rank order.

Strictly sequential -- one app at a time -- so we never stack concurrent sweeps
against Apple and risk an IP block. Each app's folder is prefixed with its rank.
Safe to re-run: finished apps are skipped in milliseconds.
"""
import json
import os
import subprocess
import sys
import time

ranked = json.load(open("habit_apps_ranked.json", encoding="utf-8"))["results"]
only = set(sys.argv[1:]) or None

t0 = time.time()
done = failed = 0
for r in ranked:
    pos, aid, name = r["position"], r["app_id"], r["name"]
    if only and str(pos) not in only:
        continue
    print(f"\n{'='*72}\n[{pos}/{len(ranked)}] {name}  (id {aid})\n{'='*72}", flush=True)
    cmd = ["python3", "extract_reviews.py", aid, "--markets", "all",
           "--no-probe", "--storefronts-from", "keyword_scans/_ratings.json",
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
    # Breathe between apps rather than hammering straight into the next sweep.
    time.sleep(3)

print(f"\n{'='*72}")
print(f"finished {done} apps, {failed} failed, in {(time.time()-t0)/60:.1f} min")
