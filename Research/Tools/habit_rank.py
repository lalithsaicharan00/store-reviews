#!/usr/bin/env python3
"""
Rank habit / routine tracking apps by where they rank, not by how big they are.

Two ideas drive the score:

  1. Ranking #1 is worth far more than ranking #10. Position value is 1/rank,
     so #1 = 1.00, #2 = 0.50, #10 = 0.10.
  2. Ranking #1 in the US is worth more than ranking #1 in Zimbabwe. Each
     storefront carries a weight: high-revenue markets 3x, high-volume markets
     1.5x, everything else 0.4x.

  score = SUM over storefronts of ( market_weight / rank )

So an app at #1 across the rich markets beats an app at #1 across the long tail,
and both beat an app sitting at #20 everywhere. Audience size is reported but
deliberately does NOT feed the score -- a big app that ranks poorly for these
terms does not own this category.

Membership is curated, not automatic: see curation.json.
"""
from __future__ import annotations

import argparse
import glob
import json
import os
import statistics
import sys

import markets

W_RICH, W_VOLUME, W_TAIL = 3.0, 1.5, 0.4
RICH = set(markets.TIER1_REVENUE)
VOLUME = set(markets.TIER2_VOLUME)


def weight(cc):
    if cc in RICH:
        return W_RICH
    if cc in VOLUME:
        return W_VOLUME
    return W_TAIL


def load_scans(scandir):
    """{app_id: {cc: best_rank}} plus metadata, merged over every keyword file.

    An app's rank in a storefront is the BEST position it reaches on any of the
    search terms -- that is its standing in the category, not on one phrase.
    """
    ranks, meta, terms = {}, {}, []
    for path in sorted(glob.glob(os.path.join(scandir, "*-raw.json"))):
        term = os.path.basename(path)[:-9].replace("-", " ")
        terms.append(term)
        with open(path, encoding="utf-8") as f:
            cache = json.load(f)
        for cc, results in cache.items():
            for pos, r in enumerate(results, 1):
                aid = str(r.get("trackId"))
                cur = ranks.setdefault(aid, {})
                if cc not in cur or pos < cur[cc]:
                    cur[cc] = pos
                m = meta.setdefault(aid, {})
                m.setdefault("name", r.get("trackName"))
                m.setdefault("developer", r.get("sellerName"))
                m.setdefault("genre", r.get("primaryGenreName"))
                m.setdefault("terms", set())
                m["terms"].add(term)
    return ranks, meta, terms


def score_app(rank_map):
    total = 0.0
    for cc, rk in rank_map.items():
        total += weight(cc) / rk
    return total


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--scans", default="keyword_scans")
    ap.add_argument("--curation", default="curation.json")
    ap.add_argument("--ratings", default="keyword_scans/_ratings.json",
                    help="Optional {app_id: {cc: [ratings, avg]}} for audience columns")
    ap.add_argument("--out", default="habit_apps_ranked.json")
    args = ap.parse_args()

    ranks, meta, terms = load_scans(args.scans)
    with open(args.curation, encoding="utf-8") as f:
        cur = json.load(f)
    include = {a["app_id"]: a for a in cur["include"]}

    ratings = {}
    if os.path.exists(args.ratings):
        with open(args.ratings, encoding="utf-8") as f:
            ratings = json.load(f)

    rows = []
    for aid, rank_map in ranks.items():
        if aid not in include:
            continue
        info = include[aid]
        rr = ratings.get(aid, {})
        total_ratings = sum(v[0] for v in rr.values()) if rr else None
        avg = (round(sum(v[1] * v[0] for v in rr.values() if v[1]) / total_ratings, 2)
               if total_ratings else None)

        firsts = sorted([cc for cc, r in rank_map.items() if r == 1],
                        key=lambda c: (-weight(c), c))
        top3 = sorted([cc for cc, r in rank_map.items() if r <= 3],
                      key=lambda c: (-weight(c), c))
        stores = []
        for cc in sorted(rank_map, key=lambda c: (rank_map[c], -weight(c))):
            entry = {
                "country": cc,
                "country_name": markets.NAMES.get(cc, cc.upper()),
                "market_tier": ("rich" if cc in RICH else
                                "volume" if cc in VOLUME else "other"),
                "rank": rank_map[cc],
            }
            if cc in rr:
                entry["ratings"] = rr[cc][0]
                entry["avg_rating"] = round(rr[cc][1], 2) if rr[cc][1] else None
            stores.append(entry)

        rows.append({
            "app_id": aid,
            "name": info.get("name") or meta[aid]["name"],
            "developer": meta[aid].get("developer"),
            "category": info["category"],
            "why_included": info["why"],
            "score": round(score_app(rank_map), 2),
            "rank_1_count": len(firsts),
            "rank_1_rich_markets": [c for c in firsts if c in RICH],
            "rank_1_volume_markets": [c for c in firsts if c in VOLUME],
            "top3_count": len(top3),
            "storefronts_ranked": len(rank_map),
            "median_rank": statistics.median(rank_map.values()),
            "best_rank": min(rank_map.values()),
            "global_ratings": total_ratings,
            "global_avg_rating": avg,
            # Ranking strength with almost no audience usually means an
            # exact-match keyword name doing the work, not real traction.
            "audience": ("established" if (total_ratings or 0) >= 50000 else
                         "moderate" if (total_ratings or 0) >= 5000 else
                         "thin -- ranks well but very few ratings"),
            "matched_terms": sorted(meta[aid]["terms"]),
            "by_storefront": stores,
        })

    # Score first; ties break toward the app that ranks in more rich markets.
    rows.sort(key=lambda r: (-r["score"], -len(r["rank_1_rich_markets"]),
                             -r["rank_1_count"]))
    for i, r in enumerate(rows, 1):
        r["position"] = i

    missing = [a for a in include if a not in ranks]
    out = {
        "category": "habit & routine tracking",
        "search_terms": terms,
        "scoring": {
            "formula": "sum over storefronts of (market_weight / rank)",
            "market_weights": {"rich": W_RICH, "volume": W_VOLUME, "other": W_TAIL},
            "note": "audience size is reported but does not affect the score",
        },
        "curation": cur["method"],
        "apps": len(rows),
        "apps_with_5000plus_ratings": sum(1 for r in rows
                                          if (r["global_ratings"] or 0) >= 5000),
        "results": rows,
    }
    with open(args.out, "w", encoding="utf-8") as f:
        json.dump(out, f, indent=2, ensure_ascii=False)

    strong = [r for r in rows if (r["global_ratings"] or 0) >= 5000]
    print(f'{"#":>3}  {"score":>7} {"#1s":>4} {"rich":>5} {"ratings":>10}  {"cat":<16} app')
    for r in rows:
        flag = "" if (r["global_ratings"] or 0) >= 5000 else "  <- thin audience"
        print(f'{r["position"]:>3}  {r["score"]:>7.1f} {r["rank_1_count"]:>4} '
              f'{len(r["rank_1_rich_markets"]):>5} {(r["global_ratings"] or 0):>10,}  '
              f'{r["category"][:16]:<16} {r["name"][:34]}{flag}')
    print(f"\n{len(strong)} of {len(rows)} have 5,000+ global ratings", file=sys.stderr)
    if missing:
        print(f"\ncurated but never ranked: {missing}", file=sys.stderr)
    print(f"\n  {args.out}  ({len(rows)} apps)", file=sys.stderr)


if __name__ == "__main__":
    main()
