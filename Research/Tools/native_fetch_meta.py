#!/usr/bin/env python3
"""
Build native_ratings.json -- per-storefront rating counts for the native apps in
native_apps.json, in the same {app_id: {cc: [count, avg]}} shape as
keyword_scans/_ratings.json.

This is what lets native_run_all.py pass --no-probe: the extractor's probe phase
hits customerReviews, a more aggressively rate-limited endpoint, at three times
the worker count with no delay between requests. That is what triggers Apple's
throttling. The /lookup endpoint used here is far friendlier, batches every app
into ONE request per storefront, and only needs running once for the whole sweep.

  python3 native_fetch_meta.py
"""
from __future__ import annotations

import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed

import markets

HERE = os.path.dirname(os.path.abspath(__file__))
UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
OUT = os.path.join(HERE, "native_ratings.json")
WORKERS = 6
DELAY = 0.15          # a real gap between requests, not just reactive backoff


def fetch(ids, cc, tries=5):
    """Rating count + average for every id in one storefront. One request."""
    q = urllib.parse.urlencode({"id": ",".join(ids), "country": cc})
    for attempt in range(tries):
        try:
            time.sleep(DELAY)
            req = urllib.request.Request(f"https://itunes.apple.com/lookup?{q}",
                                         headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=45) as r:
                got = json.loads(r.read().decode("utf-8", "replace"))
            break
        except urllib.error.HTTPError as e:
            if e.code in (403, 429, 503):
                print(f"  ! {cc}: {e.code}, backing off", file=sys.stderr, flush=True)
                time.sleep(min(120, 20 * (attempt + 1)))
                continue
            return {}
        except Exception:
            time.sleep(2 * (attempt + 1))
    else:
        return {}

    out = {}
    for r in got.get("results", []):
        n = r.get("userRatingCount")
        if n:
            out[str(r.get("trackId"))] = [n, r.get("averageUserRating")]
    return out


def main():
    apps = json.load(open(os.path.join(HERE, "native_apps.json"),
                          encoding="utf-8"))["apps"]
    ids = [a["app_id"] for a in apps]
    ccs = markets.ALL
    print(f"{len(ids)} apps x {len(ccs)} storefronts "
          f"-- {len(ccs)} requests at {WORKERS} workers", file=sys.stderr)

    per, done = {}, 0
    with ThreadPoolExecutor(max_workers=WORKERS) as ex:
        futs = {ex.submit(fetch, ids, cc): cc for cc in ccs}
        for fut in as_completed(futs):
            cc = futs[fut]
            done += 1
            try:
                res = fut.result()
            except Exception:
                res = {}
            for aid, val in res.items():
                per.setdefault(aid, {})[cc] = val
            if done % 25 == 0 or done == len(ccs):
                print(f"  probed {done}/{len(ccs)} storefronts", file=sys.stderr, flush=True)

    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(per, f)

    print(f"\nwrote {os.path.basename(OUT)}", file=sys.stderr)
    by_pos = {a["app_id"]: a for a in apps}
    for aid in ids:
        a = by_pos[aid]
        sf = per.get(aid, {})
        total = sum(v[0] for v in sf.values())
        print(f"  {a['position']:>2}. {a['name'][:38]:<38} "
              f"{len(sf):>3} storefronts  {total:>10,} ratings", file=sys.stderr)


if __name__ == "__main__":
    main()
