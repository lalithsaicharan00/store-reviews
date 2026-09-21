#!/usr/bin/env python3
"""
Extract every App Store review for the native / first-party apps people use as
habit-tracking workarounds -- Apple Reminders, Calendar, Notes, Health, Fitness,
Google Tasks, Keep, Calendar, Sheets, Microsoft To Do, Samsung Health.

Same extractor, same output shape as the third-party sweep: each app gets its own
numbered folder with reviews.jsonl, by_country/*.jsonl, manifest.json and
_state.json. The only difference is the destination -- "Native Store Reviews"
instead of "App Store Reviews".

Strictly sequential, one app at a time, so we never stack concurrent sweeps
against Apple and risk an IP block.

Safe to re-run: finished storefronts are skipped in milliseconds, a part-done
storefront resumes mid-country, nothing is re-downloaded or duplicated.

Run native_fetch_meta.py once first -- it builds native_ratings.json, the
storefront map that lets this skip the extractor's probe phase. That phase hits a
more aggressively rate-limited endpoint at THREE TIMES the worker count with no
delay between requests, which is what makes Apple start throttling.

All 11 apps are extracted in full. Order is habit-relevant first; Google Sheets
is marked "defer" in native_apps.json and runs last, because at 7M ratings it is an
order of magnitude larger than anything else and would block the rest behind it.

  python3 native_fetch_meta.py          # once, builds native_ratings.json
  python3 native_run_all.py             # all 11 apps, every storefront

  python3 native_run_all.py 1           # just Reminders
  python3 native_run_all.py 6 7 8       # just the Google apps
  python3 native_run_all.py --workers 2 --delay 0.5   # gentler still
"""
import json
import os
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "..", "Native Store Reviews")
RATINGS = os.path.join(HERE, "native_ratings.json")


args = sys.argv[1:]
workers, delay, only = "4", "0.2", set()
i = 0
while i < len(args):
    a = args[i]
    if a in ("--workers", "--delay") and i + 1 < len(args):
        if a == "--workers":
            workers = args[i + 1]
        else:
            delay = args[i + 1]
        i += 2
    elif a.isdigit():
        only.add(a)
        i += 1
    else:
        sys.exit(f"unknown argument: {a}\n{__doc__}")
only = only or None

if not os.path.exists(RATINGS):
    sys.exit("native_ratings.json is missing -- run this first:\n"
             "    python3 native_fetch_meta.py")

apps = json.load(open(os.path.join(HERE, "native_apps.json"), encoding="utf-8"))["apps"]
# Deferred apps (Google Sheets) run LAST regardless of position: it carries 7M
# ratings, an order of magnitude past anything else, and would otherwise block
# every habit-relevant app behind it. Its folder number is unchanged.
todo = [a for a in apps if not only or str(a["position"]) in only]
todo.sort(key=lambda a: (bool(a.get("defer")), a["position"]))

if not todo:
    sys.exit(f"No apps matched {sorted(only)}. Positions are 1-{len(apps)}.")

os.makedirs(OUT, exist_ok=True)

t0 = time.time()
done = failed = 0
for n, a in enumerate(todo, 1):
    pos, aid, name, vendor = a["position"], a["app_id"], a["name"], a["vendor"]
    tag = "  [deferred -- the big one]" if a.get("defer") else ""
    print(f"\n{'='*72}\n[{n}/{len(todo)}]  {pos}. {name}  ({vendor}, id {aid}){tag}\n{'='*72}",
          flush=True)
    # --no-probe is the point: it skips the customerReviews count sweep, which
    # runs at workers*3 concurrency with no delay and is what draws the throttle.
    # native_ratings.json supplies the storefront list that probe would have found.
    cmd = ["python3", os.path.join(HERE, "extract_reviews.py"), aid,
           "--markets", "all", "--no-probe", "--storefronts-from", RATINGS,
           "--out", OUT, "--number", str(pos),
           "--workers", workers, "--delay", delay]
    try:
        p = subprocess.run(cmd, cwd=HERE, timeout=5400)
        if p.returncode == 0:
            done += 1
        else:
            failed += 1
            print(f"  !! rc={p.returncode} for {name}", flush=True)
    except subprocess.TimeoutExpired:
        failed += 1
        print(f"  !! timed out: {name}", flush=True)
    except KeyboardInterrupt:
        print("\nInterrupted. Rerun the same command to resume.", flush=True)
        break
    # Breathe between apps rather than hammering straight into the next sweep.
    time.sleep(3)

print(f"\n{'='*72}")
print(f"finished {done} apps, {failed} failed, in {(time.time()-t0)/60:.1f} min")
print(f"output: {os.path.normpath(OUT)}")
