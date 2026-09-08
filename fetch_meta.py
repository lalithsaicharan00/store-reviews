#!/usr/bin/env python3
"""
For every app seen in the keyword scans, fetch:
  - per-storefront ratings + average  -> keyword_scans/_ratings.json
  - name, genre, description          -> keyword_scans/_descriptions.json

Descriptions are what makes curation possible: you cannot tell a habit tracker
from a mood journal by its title alone. Lookups are batched by storefront.
"""
from __future__ import annotations

import glob
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed

import markets

UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
CHUNK = 100


def fetch(ids, cc, want_desc=False, tries=5):
    out = {}
    for i in range(0, len(ids), CHUNK):
        q = urllib.parse.urlencode({"id": ",".join(ids[i:i + CHUNK]), "country": cc})
        got = None
        for attempt in range(tries):
            try:
                req = urllib.request.Request(f"https://itunes.apple.com/lookup?{q}",
                                             headers={"User-Agent": UA})
                with urllib.request.urlopen(req, timeout=45) as r:
                    got = json.loads(r.read().decode("utf-8", "replace"))
                break
            except urllib.error.HTTPError as e:
                if e.code in (403, 429, 503):
                    time.sleep(min(120, 20 * (attempt + 1)))
                    continue
                break
            except Exception:
                time.sleep(2 * (attempt + 1))
        if got is None:
            return None
        for r in got.get("results", []):
            aid = str(r.get("trackId"))
            n = r.get("userRatingCount")
            if want_desc:
                out[aid] = {
                    "name": r.get("trackName"),
                    "developer": r.get("sellerName"),
                    "genre": r.get("primaryGenreName"),
                    "ratings_us": n,
                    "description": (r.get("description") or "")[:900],
                }
            elif n:
                out[aid] = [n, r.get("averageUserRating")]
    return out


def main():
    ids = set()
    for path in glob.glob("keyword_scans/*-raw.json"):
        with open(path, encoding="utf-8") as f:
            for results in json.load(f).values():
                for r in results:
                    ids.add(str(r.get("trackId")))
    ids = sorted(ids)
    print(f"{len(ids)} distinct apps across all keyword scans", file=sys.stderr)

    desc = fetch(ids, "us", want_desc=True) or {}
    missing = [a for a in ids if a not in desc]
    for cc in ("gb", "in", "jp", "de"):
        if not missing:
            break
        got = fetch(missing, cc, want_desc=True) or {}
        desc.update(got)
        missing = [a for a in missing if a not in desc]
    with open("keyword_scans/_descriptions.json", "w", encoding="utf-8") as f:
        json.dump(desc, f, indent=1, ensure_ascii=False)
    print(f"descriptions: {len(desc)}", file=sys.stderr)

    ccs = markets.ALL
    per = {}
    done = 0
    with ThreadPoolExecutor(max_workers=6) as ex:
        futs = {ex.submit(fetch, ids, cc): cc for cc in ccs}
        for fut in as_completed(futs):
            cc = futs[fut]
            done += 1
            try:
                res = fut.result()
            except Exception:
                res = None
            if res:
                for aid, val in res.items():
                    per.setdefault(aid, {})[cc] = val
            if done % 30 == 0 or done == len(ccs):
                print(f"  ratings {done}/{len(ccs)} storefronts", file=sys.stderr)
    with open("keyword_scans/_ratings.json", "w", encoding="utf-8") as f:
        json.dump(per, f)
    print(f"ratings for {len(per)} apps", file=sys.stderr)


if __name__ == "__main__":
    main()
