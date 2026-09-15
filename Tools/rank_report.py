#!/usr/bin/env python3
"""
Turn a keyword scan into one global, ranked list.

Reads the cached search results from keyword_scan.py, then measures each
candidate's TRUE global audience by looking it up in every storefront -- not just
the ones where it happened to rank for the keyword. Lookups are batched (all
candidate ids in a single request per storefront), so this costs ~176 requests
rather than one per app per country.

  python3 rank_report.py "habit tracker" --min-global-ratings 5000
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
CHUNK = 100          # ids per lookup request
_lock = threading.Lock()


def log(m):
    with _lock:
        sys.stderr.write(m + "\n")
        sys.stderr.flush()


def lookup_batch(ids, cc, tries=5):
    """{app_id: (ratings, avg)} for one storefront. None if it can't be read."""
    out = {}
    for i in range(0, len(ids), CHUNK):
        chunk = ids[i:i + CHUNK]
        q = urllib.parse.urlencode({"id": ",".join(chunk), "country": cc})
        url = f"https://itunes.apple.com/lookup?{q}"
        got = None
        for attempt in range(tries):
            try:
                req = urllib.request.Request(url, headers={"User-Agent": UA})
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
            n = r.get("userRatingCount")
            if n:
                out[str(r.get("trackId"))] = (n, r.get("averageUserRating"),
                                              r.get("trackName"))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("term")
    ap.add_argument("--search-markets", default="t1+t2",
                    help="Storefronts the keyword ranking is measured in")
    ap.add_argument("--ratings-markets", default="all",
                    help="Storefronts the global audience is summed over")
    ap.add_argument("--min-global-ratings", type=int, default=5000)
    ap.add_argument("--prefilter", type=int, default=500,
                    help="Skip apps below this many search-visible ratings")
    ap.add_argument("--workers", type=int, default=6)
    ap.add_argument("--out", default="keyword_scans")
    args = ap.parse_args()

    slug = "".join(c if c.isalnum() else "-" for c in args.term.lower()).strip("-")
    base = os.path.join(args.out, slug)
    with open(base + "-raw.json", encoding="utf-8") as f:
        cache = json.load(f)

    search_ccs = [c for c in markets.resolve(args.search_markets) if c in cache]
    log(f"Keyword ranking measured across {len(search_ccs)} storefronts")

    apps = {}
    for cc in search_ccs:
        for pos, r in enumerate(cache[cc], 1):
            aid = str(r.get("trackId"))
            a = apps.setdefault(aid, {
                "app_id": aid, "name": r.get("trackName"),
                "developer": r.get("sellerName"), "genre": r.get("primaryGenreName"),
                "price": r.get("price"), "ranks": {}, "seen_ratings": {},
            })
            a["ranks"][cc] = pos
            a["seen_ratings"][cc] = r.get("userRatingCount") or 0
            if cc == "us" and r.get("trackName"):
                a["name"] = r["trackName"]

    candidates = [a for a in apps.values()
                  if sum(a["seen_ratings"].values()) >= args.prefilter]
    log(f"{len(apps)} distinct apps; {len(candidates)} above the {args.prefilter}-rating "
        f"prefilter go to the global sweep")

    ids = [a["app_id"] for a in candidates]
    rating_ccs = markets.resolve(args.ratings_markets)
    log(f"Summing global audience across {len(rating_ccs)} storefronts "
        f"(batched: ~{len(rating_ccs)} requests)...")

    per_store = {}
    done, failed = 0, []
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(lookup_batch, ids, cc): cc for cc in rating_ccs}
        for fut in as_completed(futs):
            cc = futs[fut]
            done += 1
            try:
                res = fut.result()
            except Exception:
                res = None
            if res is None:
                failed.append(cc)
            else:
                per_store[cc] = res
            if done % 25 == 0 or done == len(rating_ccs):
                log(f"  {done}/{len(rating_ccs)} storefronts")
    if failed:
        log(f"  unreadable: {' '.join(sorted(failed))}")

    # Prefer the US storefront's name: search may have first seen an app in a
    # storefront that localises its title.
    us_names = {aid: v[2] for aid, v in (per_store.get("us") or {}).items() if v[2]}

    rows = []
    for a in candidates:
        a["name"] = us_names.get(a["app_id"]) or a["name"]
        stores = []
        total, weighted = 0, 0.0
        for cc, res in per_store.items():
            hit = res.get(a["app_id"])
            if not hit:
                continue
            n, avg = hit[0], hit[1]
            total += n
            if avg:
                weighted += avg * n
            stores.append({
                "country": cc,
                "country_name": markets.NAMES.get(cc, cc.upper()),
                "keyword_rank": a["ranks"].get(cc),
                "ratings": n,
                "avg_rating": round(avg, 2) if avg else None,
            })
        if total < args.min_global_ratings:
            continue
        stores.sort(key=lambda s: -s["ratings"])
        ranked = [s["keyword_rank"] for s in stores if s["keyword_rank"]]
        rows.append({
            "app_id": a["app_id"], "name": a["name"], "developer": a["developer"],
            "genre": a["genre"], "price": a["price"],
            "global_ratings": total,
            "global_avg_rating": round(weighted / total, 2) if total else None,
            "storefronts_available": len(stores),
            "keyword_storefronts_ranked": len(ranked),
            "keyword_best_rank": min(ranked) if ranked else None,
            "keyword_median_rank": statistics.median(ranked) if ranked else None,
            "by_storefront": stores,
        })

    rows.sort(key=lambda r: -r["global_ratings"])
    for i, r in enumerate(rows, 1):
        r["position"] = i

    with open(base + "-global.json", "w", encoding="utf-8") as f:
        json.dump({
            "term": args.term,
            "generated": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
            "keyword_ranking_storefronts": len(search_ccs),
            "global_ratings_storefronts": len(per_store),
            "threshold": f"global_ratings >= {args.min_global_ratings:,}",
            "apps": len(rows),
            "results": rows,
        }, f, indent=2, ensure_ascii=False)

    flat = base + "-global.csv"
    with open(flat, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["position", "app_id", "name", "developer", "global_ratings",
                    "global_avg_rating", "storefronts_available",
                    "keyword_storefronts_ranked", "keyword_best_rank",
                    "keyword_median_rank"])
        for r in rows:
            w.writerow([r["position"], r["app_id"], r["name"], r["developer"],
                        r["global_ratings"], r["global_avg_rating"],
                        r["storefronts_available"], r["keyword_storefronts_ranked"],
                        r["keyword_best_rank"], r["keyword_median_rank"]])

    log(f"\n{len(rows)} apps at or above {args.min_global_ratings:,} global ratings\n")
    print(f'{"#":>3}  {"app_id":<12} {"global ratings":>15} {"avg":>5} {"kw rank":>8} '
          f'{"stores":>7}  app')
    for r in rows:
        kr = r["keyword_median_rank"]
        print(f'{r["position"]:>3}  {r["app_id"]:<12} {r["global_ratings"]:>15,} '
              f'{str(r["global_avg_rating"]):>5} {("#"+str(int(kr))) if kr else "-":>8} '
              f'{r["storefronts_available"]:>7}  {(r["name"] or "")[:44]}')
    log(f"\n  {base}-global.json   (full per-storefront detail)")
    log(f"  {flat}    (flat summary)")


if __name__ == "__main__":
    main()
