#!/usr/bin/env python3
"""
Rank curated Play Store habit/routine apps by where they rank, not by size.

Same model as the App Store list:
    score = SUM over countries of ( market_weight / rank )
with rich markets 3x, high-volume 1.5x, others 0.4x, and position value 1/rank.

Play difference: ratings are GLOBAL (one worldwide number per app), so there is
no per-country ratings array as there is on iOS -- only per-country RANK.
"""
from __future__ import annotations

import html
import json
import statistics
import sys

import markets

W_RICH, W_VOL, W_TAIL = 3.0, 1.5, 0.4
RICH = set(markets.TIER1_REVENUE)
VOL = set(markets.TIER2_VOLUME)


def weight(cc):
    return W_RICH if cc in RICH else W_VOL if cc in VOL else W_TAIL


def main():
    search = json.load(open("play_scans/_search.json", encoding="utf-8"))
    det = json.load(open("play_scans/_details.json", encoding="utf-8"))
    cur = json.load(open("play_curation.json", encoding="utf-8"))
    include = {a["package"]: a for a in cur["include"]}

    ranks, terms = {}, set()
    for key, ids in search.items():
        term, cc = key.split("|")
        terms.add(term)
        for pos, pkg in enumerate(ids, 1):
            m = ranks.setdefault(pkg, {})
            if cc not in m or pos < m[cc]:
                m[cc] = pos

    rows = []
    for pkg, m in ranks.items():
        if pkg not in include:
            continue
        info = include[pkg]
        d = det.get(pkg, {})
        firsts = sorted([c for c, r in m.items() if r == 1],
                        key=lambda c: (-weight(c), c))
        stores = [{"country": c,
                   "country_name": markets.NAMES.get(c, c.upper()),
                   "market_tier": ("rich" if c in RICH else
                                   "volume" if c in VOL else "other"),
                   "rank": m[c]}
                  for c in sorted(m, key=lambda c: (m[c], -weight(c)))]
        rows.append({
            "package": pkg,
            "name": info["title"],
            "developer": d.get("developer"),
            "category": info["category"],
            "why_included": html.unescape(info["why"]),
            "score": round(sum(weight(c) / r for c, r in m.items()), 2),
            "rank_1_count": len(firsts),
            "rank_1_rich_markets": [c for c in firsts if c in RICH],
            "rank_1_volume_markets": [c for c in firsts if c in VOL],
            "countries_ranked": len(m),
            "median_rank": statistics.median(m.values()),
            "best_rank": min(m.values()),
            "global_ratings": d.get("ratings_total"),
            "global_avg_rating": d.get("avg_rating"),
            "audience": ("established" if (d.get("ratings_total") or 0) >= 50000 else
                         "moderate" if (d.get("ratings_total") or 0) >= 5000 else
                         "thin -- ranks well but very few ratings"),
            "by_country": stores,
        })

    rows.sort(key=lambda r: (-r["score"], -len(r["rank_1_rich_markets"])))
    for i, r in enumerate(rows, 1):
        r["position"] = i

    out = {
        "store": "Google Play",
        "category": "habit & routine tracking",
        "search_terms": sorted(terms),
        "countries_searched": len({k.split("|")[1] for k in search}),
        "scoring": {"formula": "sum over countries of (market_weight / rank)",
                    "market_weights": {"rich": W_RICH, "volume": W_VOL, "other": W_TAIL},
                    "note": ("Play ratings are global, so audience is one worldwide "
                             "number and does not affect the score")},
        "curation": cur["method"],
        "apps": len(rows),
        "results": rows,
    }
    json.dump(out, open("play-habit-apps-ranked.json", "w", encoding="utf-8"),
              indent=2, ensure_ascii=False)

    md = ["# Habit & Routine Tracking Apps — Google Play Global Ranking", "",
          f"{len(rows)} apps, ranked by ranking strength across "
          f"{out['countries_searched']} Play markets.", "",
          "| # | Package ID | App |", "|---|---|---|"]
    md += [f"| {r['position']} | {r['package']} | {r['name']} |" for r in rows]
    open("play-habit-apps-ranked.md", "w", encoding="utf-8").write("\n".join(md) + "\n")

    print(f'{"#":>3} {"score":>7} {"#1s":>4} {"rich":>5} {"ratings":>11}  app')
    for r in rows[:30]:
        flag = "" if (r["global_ratings"] or 0) >= 5000 else "  <- thin"
        print(f'{r["position"]:>3} {r["score"]:>7.1f} {r["rank_1_count"]:>4} '
              f'{len(r["rank_1_rich_markets"]):>5} {(r["global_ratings"] or 0):>11,}  '
              f'{r["name"][:38]}{flag}')
    print(f"\n  play-habit-apps-ranked.json / .md  ({len(rows)} apps)", file=sys.stderr)


if __name__ == "__main__":
    main()
