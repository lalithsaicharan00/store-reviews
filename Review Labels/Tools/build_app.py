#!/usr/bin/env python3
"""Build (or top up) one app's year folders from the raw store files.

    python3 "Review Labels/Tools/build_app.py" Routinery

Reads Review Labels/<App>/sources.json, takes every review from each source
(App Store and Google Play alike), puts them in one shape, and writes
<App>/<year>/reviews.jsonl, oldest first. The year is the review's own date.

Safe to run again after collecting newer reviews: reviews already in a year
file are kept as they are, new ones are added, nothing is removed, and the
labels files are never touched.
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

LABELS_ROOT = Path(__file__).resolve().parent.parent
REPO_ROOT = LABELS_ROOT.parent


def normalise(raw, store):
    if store == "appstore":
        return {
            "review_id": str(raw["review_id"]),
            "store": "appstore",
            "date": raw["date"],
            "rating": raw["rating"],
            "title": (raw.get("title") or "").strip() or None,
            "text": raw.get("body") or "",
            "author": raw.get("author"),
            "country": raw.get("country"),
            "country_name": raw.get("country_name"),
            "store_language": None,
            "store_language_name": None,
            "app_version": None,
            "helpful_votes": raw.get("vote_sum", 0),
            "votes_total": raw.get("vote_count", 0),
            "developer_reply": None,
            "is_edited": raw.get("is_edited"),
            "duplicate_of": None,
        }
    if store == "play":
        return {
            "review_id": str(raw["review_id"]),
            "store": "play",
            "date": raw["date"],
            "rating": raw["rating"],
            "title": None,
            "text": raw.get("text") or "",
            "author": raw.get("author"),
            "country": None,
            "country_name": None,
            "store_language": raw.get("language"),
            "store_language_name": raw.get("language_name"),
            "app_version": raw.get("app_version"),
            "helpful_votes": raw.get("thumbs_up", 0),
            "votes_total": None,
            "developer_reply": raw.get("developer_reply"),
            "is_edited": None,
            "duplicate_of": None,
        }
    raise ValueError(f"unknown store {store!r}")


def dup_key(r):
    text = re.sub(r"\s+", " ", ((r["title"] or "") + " " + r["text"])).strip().lower()
    return (r["author"] or "", text) if text else None


def main():
    if len(sys.argv) != 2:
        sys.exit("usage: build_app.py <App>")
    app_dir = LABELS_ROOT / sys.argv[1]
    sources = json.loads((app_dir / "sources.json").read_text())

    # Everything already in the year files stays exactly as it is.
    existing = {}
    for f in sorted(app_dir.glob("*/reviews.jsonl")):
        for line in f.open():
            r = json.loads(line)
            existing[(r["store"], r["review_id"])] = r

    merged = dict(existing)
    added = 0
    for src in sources["sources"]:
        for line in (REPO_ROOT / src["path"]).open():
            r = normalise(json.loads(line), src["store"])
            key = (r["store"], r["review_id"])
            if key not in merged:
                merged[key] = r
                added += 1

    reviews = sorted(merged.values(), key=lambda r: (r["date"], r["store"], r["review_id"]))

    # The same author posting the same words twice: the later copy points at the first.
    first_seen = {}
    for r in reviews:
        k = dup_key(r)
        if k is None:
            continue
        if k in first_seen and r["duplicate_of"] is None:
            r["duplicate_of"] = first_seen[k]
        first_seen.setdefault(k, r["review_id"])

    by_year = defaultdict(list)
    for r in reviews:
        by_year[r["date"][:4]].append(r)
    for year, rows in sorted(by_year.items()):
        d = app_dir / year
        d.mkdir(exist_ok=True)
        with (d / "reviews.jsonl").open("w") as out:
            for r in rows:
                out.write(json.dumps(r, ensure_ascii=False) + "\n")
        print(f"{year}: {len(rows):>6,} reviews")
    print(f"total {len(reviews):,} (new this run: {added:,})")


if __name__ == "__main__":
    main()
