#!/usr/bin/env python3
"""
Play Store keyword scan: which apps rank for a set of terms, per country.

Mirrors the App Store pipeline, with two differences forced by how Play works:
  - Search IS country-scoped (verified: only ~2/10 positions match across
    countries), so ranking is measured per `gl` exactly as on iOS.
  - Ratings are GLOBAL on Play -- one worldwide number per app, not per country.
    So audience is a single figure, fetched once per app rather than per market.

Results are cached per (term, country) so a rate-limit block never loses work.
"""
from __future__ import annotations

import argparse
import json
import os
import re
import sys
import threading
import time
import urllib.error
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed

import markets

UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
ID_RE = re.compile(r'/store/apps/details\?id=([A-Za-z0-9_.]+)')

_lock = threading.Lock()
_pace = threading.Lock()
_last = [0.0]


def log(m):
    with _lock:
        sys.stderr.write(m + "\n")
        sys.stderr.flush()


def paced(delay):
    with _pace:
        gap = time.time() - _last[0]
        if gap < delay:
            time.sleep(delay - gap)
        _last[0] = time.time()


def get(url, delay, tries=5):
    for attempt in range(tries):
        paced(delay)
        try:
            req = urllib.request.Request(url, headers={
                "User-Agent": UA, "Accept-Language": "en-US,en;q=0.9"})
            with urllib.request.urlopen(req, timeout=45) as r:
                return r.read().decode("utf-8", "replace")
        except urllib.error.HTTPError as e:
            if e.code in (429, 503):
                back = min(120, 20 * (attempt + 1))
                log(f"  ! HTTP {e.code} -- waiting {back}s")
                time.sleep(back)
                continue
            if e.code == 404:
                return None
        except Exception:
            time.sleep(2 * (attempt + 1))
    return None


def search(term, gl, hl, delay):
    """Package ids in Play's own ranking order for one country. None if unread."""
    url = "https://play.google.com/store/search?" + urllib.parse.urlencode(
        {"q": term, "c": "apps", "gl": gl, "hl": hl})
    h = get(url, delay)
    if h is None:
        return None
    return list(dict.fromkeys(ID_RE.findall(h)))


def details(pkg, delay, gl="US", hl="en"):
    """Title, developer, global rating count and description for one app."""
    url = "https://play.google.com/store/apps/details?" + urllib.parse.urlencode(
        {"id": pkg, "gl": gl, "hl": hl})
    h = get(url, delay)
    if not h:
        return None
    def grab(pat, cast=str):
        m = re.search(pat, h)
        if not m:
            return None
        try:
            return cast(m.group(1))
        except (ValueError, TypeError):
            return None
    title = grab(r'<title[^>]*>([^<]+?)(?:\s*-\s*Apps on Google Play)?</title>')
    # dev name sits inside a <span> after the developer link, not straight after ">"
    dev = (grab(r'/store/apps/developer\?id=[^"]*"[^>]*>\s*<span>([^<]{1,80})</span>')
           or grab(r'/store/apps/dev(?:eloper)?\?id[^>]{0,80}>\s*<span>([^<]{1,80})</span>')
           or grab(r'"name"\s*:\s*"([^"]{2,60})"\s*,\s*"@type"\s*:\s*"Organization"'))
    total_txt = grab(r'([\d.]+[KMB])\s*reviews')
    # The five star buckets are plain integers; a bucket under 1,000 has no comma,
    # so match any digit run -- an earlier {4,} silently dropped those.
    histo = [int(x.replace(",", ""))
             for x in re.findall(r'(\d[\d,]*)\s*reviews', h)[:5]]
    desc = grab(r'<meta itemprop="description" content="([^"]{20,})"')
    ratings = sum(histo) if len(histo) == 5 else None
    avg = (round(sum((5 - i) * v for i, v in enumerate(histo)) / ratings, 3)
           if ratings else None)
    return {"package": pkg, "title": (title or "").strip(), "developer": dev,
            "ratings_total": ratings, "ratings_shown": total_txt,
            "avg_rating": avg, "description": (desc or "")[:700]}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("terms", nargs="+")
    ap.add_argument("--markets", default="t1+t2")
    ap.add_argument("--workers", type=int, default=3)
    ap.add_argument("--delay", type=float, default=1.2)
    ap.add_argument("--out", default="play_scans")
    ap.add_argument("--details", action="store_true",
                    help="After scanning, fetch per-app details for curation")
    args = ap.parse_args()

    os.makedirs(args.out, exist_ok=True)
    ccs = markets.resolve(args.markets)
    cache_path = os.path.join(args.out, "_search.json")
    try:
        with open(cache_path, encoding="utf-8") as f:
            cache = json.load(f)
    except (OSError, json.JSONDecodeError):
        cache = {}

    jobs = [(t, cc) for t in args.terms for cc in ccs
            if f"{t}|{cc}" not in cache]
    log(f"{len(args.terms)} terms x {len(ccs)} countries = "
        f"{len(args.terms)*len(ccs)} cells; {len(jobs)} to fetch")

    done, failed = 0, 0
    if jobs:
        with ThreadPoolExecutor(max_workers=args.workers) as ex:
            futs = {ex.submit(search, t, cc, "en", args.delay): (t, cc)
                    for t, cc in jobs}
            for fut in as_completed(futs):
                t, cc = futs[fut]
                done += 1
                try:
                    res = fut.result()
                except Exception:
                    res = None
                if res is None:
                    failed += 1
                else:
                    cache[f"{t}|{cc}"] = res
                    with _lock:
                        with open(cache_path, "w", encoding="utf-8") as f:
                            json.dump(cache, f)
                if done % 25 == 0 or done == len(jobs):
                    log(f"  {done}/{len(jobs)} cells | {failed} failed")

    pkgs = sorted({p for v in cache.values() for p in v})
    log(f"\n{len(cache)} cells cached, {len(pkgs)} distinct apps")

    if args.details:
        dpath = os.path.join(args.out, "_details.json")
        try:
            with open(dpath, encoding="utf-8") as f:
                det = json.load(f)
        except (OSError, json.JSONDecodeError):
            det = {}
        todo = [p for p in pkgs if p not in det]
        log(f"fetching details for {len(todo)} apps...")
        n = 0
        with ThreadPoolExecutor(max_workers=args.workers) as ex:
            futs = {ex.submit(details, p, args.delay): p for p in todo}
            for fut in as_completed(futs):
                p = futs[fut]
                n += 1
                try:
                    d = fut.result()
                except Exception:
                    d = None
                if d:
                    det[p] = d
                    with _lock:
                        with open(dpath, "w", encoding="utf-8") as f:
                            json.dump(det, f, ensure_ascii=False)
                if n % 40 == 0 or n == len(todo):
                    log(f"  details {n}/{len(todo)}")
        log(f"details cached for {len(det)} apps")


if __name__ == "__main__":
    main()
