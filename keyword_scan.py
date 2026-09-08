#!/usr/bin/env python3
"""
Find which apps rank for a keyword, across every App Store storefront.

Apple's search endpoint is storefront-scoped and relevance-ordered, so its result
order is a usable proxy for keyword ranking in that country. This sweeps all
storefronts, records each app's position, and aggregates.

The search API is rate-limited much harder than the reviews endpoint -- it starts
returning 403 after a modest burst -- so requests are paced globally and every
storefront is cached to disk as it lands. A block costs you time, never progress.

  python3 keyword_scan.py "habit tracker"
  python3 keyword_scan.py "habit tracker" --markets t1 --limit 30
"""
from __future__ import annotations

import argparse
import csv
import json
import os
import statistics
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

_out_lock = threading.Lock()
_pace_lock = threading.Lock()
_last_call = [0.0]


def log(m):
    with _out_lock:
        sys.stderr.write(m + "\n")
        sys.stderr.flush()


def _paced(delay):
    """One global spacing gate -- concurrency never outruns it."""
    with _pace_lock:
        gap = time.time() - _last_call[0]
        if gap < delay:
            time.sleep(delay - gap)
        _last_call[0] = time.time()


def search(term, cc, limit, delay=2.5, tries=6):
    """Top `limit` results in one storefront.

    Returns None (not []) when the storefront could not be read, so a rate-limit
    block is never mistaken for "nothing ranks here".
    """
    q = urllib.parse.urlencode({"term": term, "country": cc,
                                "entity": "software", "limit": limit})
    url = f"https://itunes.apple.com/search?{q}"
    for attempt in range(tries):
        _paced(delay)
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=30) as r:
                return json.loads(r.read().decode("utf-8", "replace")).get("results", [])
        except urllib.error.HTTPError as e:
            if e.code in (403, 429, 503):
                back = min(180, 30 * (attempt + 1))
                log(f"  ! {cc}: HTTP {e.code} rate limited -- waiting {back}s")
                time.sleep(back)
                continue
            return None
        except Exception:
            time.sleep(3 * (attempt + 1))
    return None


KEEP = ("trackId", "trackName", "sellerName", "bundleId",
        "primaryGenreName", "price", "userRatingCount")


def main():
    ap = argparse.ArgumentParser(description="Which apps rank for a keyword, worldwide.")
    ap.add_argument("term", help='Keyword, e.g. "habit tracker"')
    ap.add_argument("--markets", default="all", help="all | t1 | t2 | t1+t2 | us,gb,jp")
    ap.add_argument("--limit", type=int, default=50, help="Results per storefront (max 200)")
    ap.add_argument("--workers", type=int, default=2,
                    help="Parallel searches. Keep low; the API blocks bursts")
    ap.add_argument("--delay", type=float, default=2.5,
                    help="Minimum seconds between search requests (global)")
    ap.add_argument("--min-ratings", type=int, default=1000,
                    help="Cutoff: minimum ratings summed over storefronts")
    ap.add_argument("--min-reach", type=float, default=0.25,
                    help="Cutoff: fraction of storefronts the app must rank in")
    ap.add_argument("--max-median-rank", type=int, default=25,
                    help="Cutoff: worst acceptable median search position")
    ap.add_argument("--out", default="keyword_scans")
    args = ap.parse_args()

    ccs = markets.resolve(args.markets)
    os.makedirs(args.out, exist_ok=True)
    slug = "".join(c if c.isalnum() else "-" for c in args.term.lower()).strip("-")
    base = os.path.join(args.out, slug)
    cache_path = base + "-raw.json"

    try:
        with open(cache_path, encoding="utf-8") as f:
            cache = json.load(f)
    except (OSError, json.JSONDecodeError):
        cache = {}

    todo = [c for c in ccs if c not in cache]
    log(f'Searching "{args.term}" across {len(ccs)} storefronts (top {args.limit} each)')
    if cache:
        log(f"  resuming: {len(cache)} cached, {len(todo)} to fetch")

    done, failed = 0, []
    if todo:
        with ThreadPoolExecutor(max_workers=args.workers) as ex:
            futs = {ex.submit(search, args.term, cc, args.limit, args.delay): cc
                    for cc in todo}
            for fut in as_completed(futs):
                cc = futs[fut]
                done += 1
                try:
                    results = fut.result()
                except Exception:
                    results = None
                if results is None:
                    failed.append(cc)
                else:
                    cache[cc] = [{k: r.get(k) for k in KEEP} for r in results]
                    with _out_lock:
                        with open(cache_path, "w", encoding="utf-8") as f:
                            json.dump(cache, f)
                if done % 10 == 0 or done == len(todo):
                    log(f"  {done}/{len(todo)} fetched | {len(cache)} cached | "
                        f"{len(failed)} failed")

    if failed:
        log(f"  could not read: {' '.join(sorted(failed))}")
        log("  rerun the same command to retry only those")

    read = [c for c in ccs if c in cache]
    n_stores = len(read)
    if not n_stores:
        raise SystemExit("No storefronts could be read -- rate limited. Wait and rerun.")

    apps = {}
    for cc in read:
        for pos, r in enumerate(cache[cc], 1):
            aid = str(r.get("trackId"))
            a = apps.setdefault(aid, {
                "app_id": aid, "name": r.get("trackName"),
                "developer": r.get("sellerName"), "bundle_id": r.get("bundleId"),
                "genre": r.get("primaryGenreName"), "price": r.get("price"),
                "ranks": {}, "ratings": {},
            })
            a["ranks"][cc] = pos
            a["ratings"][cc] = r.get("userRatingCount") or 0
            if cc == "us" and r.get("trackName"):
                a["name"] = r["trackName"]

    rows = []
    for a in apps.values():
        ranks = list(a["ranks"].values())
        reach = len(ranks)
        top10 = sum(1 for r in ranks if r <= 10)
        rows.append({
            "app_id": a["app_id"], "name": a["name"], "developer": a["developer"],
            "genre": a["genre"], "price": a["price"], "bundle_id": a["bundle_id"],
            "storefronts": reach,
            "reach_pct": round(reach / n_stores * 100, 1),
            "median_rank": statistics.median(ranks),
            "best_rank": min(ranks),
            "top10_storefronts": top10,
            "ratings_total": sum(a["ratings"].values()),
            "ratings_max": max(a["ratings"].values()),
            # Rewards ranking high in many storefronts; the top-10 factor
            # separates apps that genuinely own the keyword from ones that
            # merely appear on page one everywhere.
            "score": round(sum(1.0 / r for r in ranks) * (1 + top10 / max(reach, 1)), 2),
        })
    rows.sort(key=lambda r: -r["score"])

    def is_top(r):
        return (r["storefronts"] >= n_stores * args.min_reach
                and r["median_rank"] <= args.max_median_rank
                and r["ratings_total"] >= args.min_ratings)

    top = [r for r in rows if is_top(r)]

    with open(base + "-all.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)
    with open(base + "-top.json", "w", encoding="utf-8") as f:
        json.dump({
            "term": args.term,
            "storefronts_searched": n_stores,
            "storefronts_requested": len(ccs),
            "results_per_storefront": args.limit,
            "cutoff": {
                "min_reach_pct": args.min_reach * 100,
                "max_median_rank": args.max_median_rank,
                "min_ratings_total": args.min_ratings,
            },
            "apps_found": len(rows),
            "apps_passing_cutoff": len(top),
            "top_apps": top,
        }, f, indent=2, ensure_ascii=False)

    log(f"\nRead {n_stores}/{len(ccs)} storefronts | {len(rows)} distinct apps | "
        f"{len(top)} clear the cutoff\n")
    print(f'{"#":>3}  {"app_id":<12} {"reach":>6} {"med":>4} {"ratings":>11}  app')
    for i, r in enumerate(top, 1):
        print(f'{i:>3}  {r["app_id"]:<12} {r["reach_pct"]:>5.0f}% {r["median_rank"]:>4.0f} '
              f'{r["ratings_total"]:>11,}  {(r["name"] or "")[:50]}')
    log(f"\n  {base}-top.json  ({len(top)} apps)")
    log(f"  {base}-all.csv   (all {len(rows)})")


if __name__ == "__main__":
    main()
