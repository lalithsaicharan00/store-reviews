#!/usr/bin/env python3
"""
App Store review extractor -- full review history, every storefront.

Give it an app id, an App Store URL, or an app name. It finds every storefront
where the app has written reviews and pulls all of them, oldest to newest.

Source: itunes.apple.com/WebObjects/MZStore.woa/wa/userReviewsRow -- the legacy
iTunes client endpoint. Unlike the public web page (capped at 10 reviews) and the
RSS feed (dead), this one paginates to the end of an app's history and honours a
per-storefront `cc` parameter.

Designed to run unattended: checkpointed after every page, resumable, and it
backs off on its own if Apple starts pushing back.

  python3 extract_reviews.py 570060128
  python3 extract_reviews.py "Duolingo" --markets t1
  python3 extract_reviews.py 570060128 --markets all --probe-only
"""
from __future__ import annotations

import argparse
import json
import os
import random
import re
import signal
import sys
import threading
import time
import urllib.error
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed

import markets

STORE = "https://itunes.apple.com/WebObjects/MZStore.woa/wa"
UA = "iTunes/12.12 (Macintosh; OS X 10.15.7) AppleWebKit/605.1.15"
PAGE = 500            # reviews per request; the endpoint tolerates far more
KIND = 11             # displayable-kind for iOS software
SORT_RECENT = 4

_stop = threading.Event()
_print_lock = threading.Lock()


def log(msg):
    with _print_lock:
        sys.stderr.write(msg + "\n")
        sys.stderr.flush()


# --------------------------------------------------------------------------- #
# Throttle: shared across threads. Widens the gap on 429/5xx, narrows on success.
# --------------------------------------------------------------------------- #

class Throttle:
    def __init__(self, base_delay=0.0, max_delay=30.0):
        self.base = base_delay
        self.max = max_delay
        self.penalty = 0.0
        self.lock = threading.Lock()
        self.hits = 0

    def wait(self):
        with self.lock:
            d = self.base + self.penalty
        if d:
            time.sleep(d * random.uniform(0.7, 1.3))

    def punish(self):
        with self.lock:
            self.hits += 1
            self.penalty = min(self.max, max(1.0, self.penalty * 2))
            p = self.penalty
        log(f"  ! throttled by Apple -- backing off to {p:.1f}s between requests")

    def relax(self):
        with self.lock:
            if self.penalty:
                self.penalty = max(0.0, self.penalty * 0.85)
                if self.penalty < 0.05:
                    self.penalty = 0.0


THROTTLE = Throttle()


def get_json(url, tries=6, timeout=45):
    """GET returning parsed JSON, or None if it's permanently unavailable."""
    for attempt in range(tries):
        if _stop.is_set():
            return None
        THROTTLE.wait()
        # No X-Apple-Store-Front header on purpose: it outranks the `cc` query
        # parameter, and every request would silently come back as US.
        req = urllib.request.Request(url, headers={
            "User-Agent": UA,
            "Accept": "application/json",
        })
        try:
            with urllib.request.urlopen(req, timeout=timeout) as r:
                body = r.read()
            THROTTLE.relax()
            return json.loads(body.decode("utf-8", "replace"))
        except urllib.error.HTTPError as e:
            if e.code in (403, 429, 503):
                THROTTLE.punish()
                time.sleep(min(60, (2 ** attempt) + random.random() * 3))
                continue
            if e.code in (404, 410):
                return None
            time.sleep(1.5 * (attempt + 1))
        except json.JSONDecodeError:
            # Usually an HTML interstitial -> treat like a soft block.
            THROTTLE.punish()
            time.sleep(min(60, (2 ** attempt) + random.random() * 3))
        except Exception:
            time.sleep(min(20, 1.5 * (attempt + 1) + random.random()))
    return None


# --------------------------------------------------------------------------- #
# App resolution
# --------------------------------------------------------------------------- #

def resolve_app(token, country="us"):
    """Accept an id, an App Store URL, or a name. Returns (app_id, metadata)."""
    m = re.search(r"id(\d{5,})", token) or re.fullmatch(r"\s*(\d{5,})\s*", token)
    if m:
        app_id = m.group(1)
    else:
        q = urllib.parse.urlencode({"term": token, "country": country,
                                    "entity": "software", "limit": 5})
        res = get_json(f"https://itunes.apple.com/search?{q}") or {}
        hits = res.get("results") or []
        if not hits:
            raise SystemExit(f"No app found matching {token!r}")
        if len(hits) > 1:
            log(f"Matched {len(hits)} apps for {token!r}; using the first:")
            for h in hits:
                log(f"   {h['trackId']}  {h['trackName']} -- {h.get('sellerName')} "
                    f"({h.get('userRatingCount', 0):,} ratings)")
        app_id = str(hits[0]["trackId"])

    q = urllib.parse.urlencode({"id": app_id, "country": country})
    look = get_json(f"https://itunes.apple.com/lookup?{q}") or {}
    meta = (look.get("results") or [{}])[0]
    return app_id, meta


SSD_RE = re.compile(r'<script[^>]*id="serialized-server-data"[^>]*>(.*?)</script>', re.S)


def app_titles(app_id, meta, cc="us"):
    """(name, subtitle) as the App Store displays them.

    The lookup API has no subtitle field, so pull the product page and read the
    `lockup` node -- the one place the app's own subtitle lives (every other
    subtitle on that page belongs to some other app in a shelf).
    """
    name = (meta.get("trackName") or "").strip()
    subtitle = ""
    url = f"https://apps.apple.com/{cc}/app/id{app_id}"
    try:
        req = urllib.request.Request(url, headers={
            "User-Agent": ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                           "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36"),
            "Accept-Language": "en-US,en;q=0.9",
        })
        with urllib.request.urlopen(req, timeout=30) as r:
            html = r.read().decode("utf-8", "replace")
        m = SSD_RE.search(html)
        if m:
            # This node describes the page's own app, so no id check is possible
            # or needed -- its `id` is null here.
            page = json.loads(m.group(1))["data"][0]["data"]
            name = (page.get("title") or name).strip()
            subtitle = ((page.get("lockup") or {}).get("subtitle") or "").strip()
    except Exception:
        pass                      # a missing subtitle must never block extraction
    return name, subtitle


def safe_dirname(text):
    """Return a folder segment valid on both macOS and Windows."""
    text = re.sub(r'[<>:"/\\|?*\x00-\x1f]', "-", text)
    text = re.sub(r"\s+", " ", text).strip(" .")
    return text[:120]


def app_folder(outdir, app_id, name, subtitle, number=None):
    """`<n>. <App Name> - <Subtitle>`. Reuses this app's folder if it exists.

    `number` pins the prefix (e.g. the app's rank). An existing folder carrying a
    different prefix is renamed rather than duplicated.
    """
    os.makedirs(outdir, exist_ok=True)
    # Reuse this app's existing folder if one is already here. Check both the
    # state file and the manifest, since a folder written by an older version
    # may only carry the id in one of them.
    label = safe_dirname(name)
    if subtitle:
        label = f"{label} - {safe_dirname(subtitle)}"

    for entry in sorted(os.listdir(outdir)):
        path = os.path.join(outdir, entry)
        if not os.path.isdir(path):
            continue
        found = False
        for marker in ("_state.json", "manifest.json"):
            try:
                with open(os.path.join(path, marker), encoding="utf-8") as f:
                    if str(json.load(f).get("app_id")) == str(app_id):
                        found = True
                        break
            except (OSError, json.JSONDecodeError):
                continue
        if not found:
            continue
        if number is None:
            return path
        want = os.path.join(outdir, f"{number}. {label}")
        if os.path.abspath(path) != os.path.abspath(want) and not os.path.exists(want):
            os.rename(path, want)
            log(f"  renumbered: {entry}  ->  {number}. {label}")
            return want
        return path

    if number is None:
        used = set()
        for entry in os.listdir(outdir):
            m = re.match(r"(\d+)\.", entry)
            if m and os.path.isdir(os.path.join(outdir, entry)):
                used.add(int(m.group(1)))
        number = 1
        while number in used:
            number += 1

    path = os.path.join(outdir, f"{number}. {label}")
    os.makedirs(path, exist_ok=True)
    return path


class FolderLock:
    """Guards one app folder. Two extractors appending to the same JSONL files
    would each miss the other's writes and produce duplicates."""

    def __init__(self, folder):
        self.path = os.path.join(folder, ".lock")
        self.fd = None

    def __enter__(self):
        try:
            self.fd = os.open(self.path, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
            os.write(self.fd, f"pid={os.getpid()} started={time.strftime('%FT%TZ', time.gmtime())}\n".encode())
            return self
        except FileExistsError:
            try:
                with open(self.path) as f:
                    who = f.read().strip()
            except OSError:
                who = "unknown"
            m = re.search(r"pid=(\d+)", who)
            alive = True
            if m:
                try:
                    os.kill(int(m.group(1)), 0)
                except (ProcessLookupError, ValueError):
                    alive = False           # writer died (crash, kill, power loss)
                except PermissionError:
                    alive = True
            if not alive:
                # Nobody holds it. Clear it and carry on rather than making the
                # user run rm by hand.
                log(f"  clearing stale lock from dead process ({who})")
                try:
                    os.unlink(self.path)
                except OSError:
                    pass
                return self.__enter__()
            raise SystemExit(
                f"\nAnother extractor is already working on this app folder ({who})."
                f"\n  Running two at once creates duplicate reviews.\n")

    def __exit__(self, *exc):
        if self.fd is not None:
            os.close(self.fd)
        try:
            os.unlink(self.path)
        except OSError:
            pass


def dedupe_country_files(store, counts):
    """Drop repeated review_ids inside each per-country file, keeping the first.

    Belt and braces: the lock prevents the concurrent-writer case that caused
    this, but a half-written resume can also replay a page.
    """
    removed = 0
    on_disk = sorted(
        f[:-6] for f in os.listdir(os.path.join(store.dir, "by_country"))
        if f.endswith(".jsonl")
    )
    for cc in on_disk:
        path = store.path(cc)
        if not os.path.exists(path):
            continue
        seen, out, dropped = set(), [], 0
        with open(path, encoding="utf-8") as f:
            for line in f:
                if not line.strip():
                    continue
                try:
                    rid = json.loads(line)["review_id"]
                except (json.JSONDecodeError, KeyError):
                    continue
                if rid in seen:
                    dropped += 1
                    continue
                seen.add(rid)
                out.append(line if line.endswith("\n") else line + "\n")
        if dropped:
            tmp = path + ".tmp"
            with open(tmp, "w", encoding="utf-8") as f:
                f.writelines(out)
            os.replace(tmp, path)
            removed += dropped
        st = store.state["countries"].get(cc)
        if st is not None:
            st["collected"] = len(seen)
    if removed:
        store.save_state()
        log(f"  removed {removed:,} duplicate review records")
    return removed


def review_count(app_id, cc):
    """Written reviews available in one storefront. None if app isn't sold there."""
    q = urllib.parse.urlencode({"id": app_id, "displayable-kind": KIND,
                                "startIndex": 0, "endIndex": 1, "cc": cc})
    d = get_json(f"{STORE}/customerReviews?{q}")
    if not d:
        return None
    return d.get("totalNumberOfReviews")


def fetch_page(app_id, cc, start, end, sort=SORT_RECENT):
    q = urllib.parse.urlencode({"id": app_id, "displayable-kind": KIND,
                                "startIndex": start, "endIndex": end,
                                "sort": sort, "cc": cc})
    d = get_json(f"{STORE}/userReviewsRow?{q}")
    if not d:
        return None
    return d.get("userReviewList") or []


# --------------------------------------------------------------------------- #
# Normalisation
# --------------------------------------------------------------------------- #

def _int(v, default=0):
    try:
        return int(v)
    except (TypeError, ValueError):
        return default


def normalise(raw, cc, app_id, app_name):
    """One flat, stable record per review -- friendly to pandas/duckdb/LLMs."""
    return {
        "review_id": str(raw.get("userReviewId") or ""),
        "app_id": str(app_id),
        "app_name": app_name,
        "country": cc,
        "country_name": markets.NAMES.get(cc, cc.upper()),
        "rating": _int(raw.get("rating"), None),
        "title": (raw.get("title") or "").strip(),
        "body": (raw.get("body") or "").strip(),
        "author": (raw.get("name") or "").strip(),
        "date": raw.get("date"),
        "vote_count": _int(raw.get("voteCount")),
        "vote_sum": _int(raw.get("voteSum")),
        "is_edited": str(raw.get("isEdited", "")).lower() == "true",
    }


# --------------------------------------------------------------------------- #
# Per-storefront extraction
# --------------------------------------------------------------------------- #

class Store:
    """Append-only JSONL per storefront, plus a resumable cursor."""

    def __init__(self, folder, app_id):
        self.dir = folder
        os.makedirs(os.path.join(self.dir, "by_country"), exist_ok=True)
        self.state_path = os.path.join(self.dir, "_state.json")
        self.lock = threading.Lock()
        self.state = self._load()
        self.state["app_id"] = str(app_id)   # lets a rerun find this folder again
        self.save_state()

    def _load(self):
        try:
            with open(self.state_path, encoding="utf-8") as f:
                return json.load(f)
        except (FileNotFoundError, json.JSONDecodeError):
            return {"app_id": None, "countries": {}}

    def save_state(self):
        with self.lock:
            tmp = self.state_path + ".tmp"
            with open(tmp, "w", encoding="utf-8") as f:
                json.dump(self.state, f, indent=1)
            os.replace(tmp, self.state_path)

    def path(self, cc):
        return os.path.join(self.dir, "by_country", f"{cc}.jsonl")

    def seen_ids(self, cc):
        ids = set()
        try:
            with open(self.path(cc), encoding="utf-8") as f:
                for line in f:
                    line = line.strip()
                    if line:
                        try:
                            ids.add(json.loads(line)["review_id"])
                        except (json.JSONDecodeError, KeyError):
                            continue
        except FileNotFoundError:
            pass
        return ids

    def append(self, cc, rows):
        if not rows:
            return
        with open(self.path(cc), "a", encoding="utf-8") as f:
            for r in rows:
                f.write(json.dumps(r, ensure_ascii=False) + "\n")
            f.flush()
            os.fsync(f.fileno())


def harvest_country(app_id, app_name, cc, total, store, page_size):
    """Pull every review for one storefront. Resumes from the saved cursor."""
    st = store.state["countries"].setdefault(cc, {})
    if st.get("complete") and st.get("total") == total:
        return 0, st.get("collected", 0)

    seen = store.seen_ids(cc)
    start = st.get("cursor", 0)
    added = 0
    empty_streak = 0

    # total=None means we never probed for a count -- just paginate until Apple
    # stops returning rows. Saves one request per storefront per app, which is
    # what was tripping the rate limiter on the (separate) count endpoint.
    while (total is None or start < total) and not _stop.is_set():
        rows = fetch_page(app_id, cc, start, start + page_size)
        if rows is None:                      # hard failure; leave cursor for resume
            st["cursor"] = start
            store.save_state()
            return added, len(seen)
        if not rows:
            if total is None:
                break                     # unknown total: first empty page ends it
            empty_streak += 1
            if empty_streak >= 2:
                break
            start += page_size
            continue
        empty_streak = 0

        fresh = []
        for raw in rows:
            rec = normalise(raw, cc, app_id, app_name)
            if rec["review_id"] and rec["review_id"] not in seen:
                seen.add(rec["review_id"])
                fresh.append(rec)
        store.append(cc, fresh)
        added += len(fresh)

        start += len(rows)
        st["cursor"] = start
        st["collected"] = len(seen)
        st["total"] = total
        store.save_state()

    st["complete"] = not _stop.is_set()
    st["collected"] = len(seen)
    st["total"] = total if total is not None else len(seen)
    st["updated"] = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    store.save_state()
    return added, len(seen)


# --------------------------------------------------------------------------- #
# Merge
# --------------------------------------------------------------------------- #

def merge(store, app_id, meta, counts):
    """One combined JSONL plus a manifest describing the run."""
    outdir = store.dir
    merged = os.path.join(outdir, "reviews.jsonl")
    n, per_country, ratings = 0, {}, {}
    seen_ids = set()
    # Every storefront already on disk -- never just this run's --markets, or a
    # partial rerun would silently shrink the merged file.
    on_disk = sorted(
        f[:-6] for f in os.listdir(os.path.join(outdir, "by_country"))
        if f.endswith(".jsonl")
    )
    tmp = merged + ".tmp"
    with open(tmp, "w", encoding="utf-8") as out:
        for cc in on_disk:
            p = store.path(cc)
            if not os.path.exists(p):
                continue
            c = 0
            with open(p, encoding="utf-8") as f:
                for line in f:
                    if not line.strip():
                        continue
                    try:
                        rec = json.loads(line)
                    except json.JSONDecodeError:
                        continue
                    rid = rec.get("review_id")
                    if rid in seen_ids:
                        continue
                    seen_ids.add(rid)
                    out.write(line if line.endswith("\n") else line + "\n")
                    c += 1
                    r = rec.get("rating")
                    if r:
                        ratings[r] = ratings.get(r, 0) + 1
            if c:
                per_country[cc] = c
            n += c
    os.replace(tmp, merged)

    total_rated = sum(ratings.values())
    manifest = {
        "app_id": str(app_id),
        "app_name": meta.get("trackName"),
        "developer": meta.get("sellerName"),
        "bundle_id": meta.get("bundleId"),
        "extracted_at": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "source": "itunes MZStore userReviewsRow",
        "total_reviews": n,
        "storefronts_with_reviews": len(per_country),
        "reviews_per_country": dict(sorted(per_country.items(),
                                           key=lambda kv: -kv[1])),
        "rating_distribution": {str(k): ratings.get(k, 0) for k in (5, 4, 3, 2, 1)},
        "mean_rating": (round(sum(k * v for k, v in ratings.items()) / total_rated, 3)
                        if total_rated else None),
        "files": {"merged": "reviews.jsonl", "per_country": "by_country/<cc>.jsonl"},
    }
    with open(os.path.join(outdir, "manifest.json"), "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)
    return merged, manifest


# --------------------------------------------------------------------------- #

def main():
    ap = argparse.ArgumentParser(
        description="Extract all App Store reviews for an app, across storefronts.")
    ap.add_argument("app", help="App id, App Store URL, or app name")
    ap.add_argument("--markets", default="t1+t2",
                    help="t1 (high revenue), t2 (high volume), t1+t2 (default), "
                         "all (~176), or a list like us,gb,jp")
    ap.add_argument("--out", default="out", help="Output directory (default: out)")
    ap.add_argument("--number", type=int, default=None,
                    help="Folder prefix to use (e.g. the app's rank). Renames an "
                         "existing folder that carries a different prefix.")
    ap.add_argument("--workers", type=int, default=6,
                    help="Storefronts fetched in parallel (default 6)")
    ap.add_argument("--page-size", type=int, default=PAGE,
                    help=f"Reviews per request (default {PAGE})")
    ap.add_argument("--min-reviews", type=int, default=1,
                    help="Skip storefronts with fewer than this many reviews")
    ap.add_argument("--probe-only", action="store_true",
                    help="Only report review counts per storefront, extract nothing")
    ap.add_argument("--no-probe", action="store_true",
                    help="Skip the per-storefront count request (a separate, more "
                         "aggressively rate-limited endpoint) and just paginate until "
                         "each storefront runs dry")
    ap.add_argument("--storefronts-from", default=None,
                    help="JSON of {app_id: {cc: [...]}} naming the storefronts an app "
                         "is sold in, so --no-probe skips ones it was never in")
    ap.add_argument("--delay", type=float, default=0.0,
                    help="Extra seconds between requests if you want to be gentle")
    args = ap.parse_args()

    THROTTLE.base = args.delay

    def on_sigint(_sig, _frm):
        if _stop.is_set():
            log("\nForced exit.")
            os._exit(1)
        log("\nStopping after the current pages... progress is saved; rerun to resume.")
        _stop.set()
    signal.signal(signal.SIGINT, on_sigint)

    app_id, meta = resolve_app(args.app)
    name, subtitle = app_titles(app_id, meta)
    name = name or f"app {app_id}"
    log(f"\n{name}" + (f" -- {subtitle}" if subtitle else ""))
    log(f"id {app_id}  by {meta.get('sellerName')}")

    ccs = markets.resolve(args.markets)
    if not args.no_probe:
        log(f"Probing {len(ccs)} storefronts for review counts...")

    if args.no_probe:
        avail = None
        if args.storefronts_from:
            try:
                with open(args.storefronts_from, encoding="utf-8") as f:
                    avail = list((json.load(f).get(str(app_id)) or {}).keys())
            except (OSError, json.JSONDecodeError):
                avail = None
        picked = [c for c in ccs if not avail or c in avail]
        counts = {c: None for c in picked}
        log(f"  skipping the count probe; sweeping {len(picked)} storefronts directly")
        grand = 0
        ranked = [(c, None) for c in picked]
        store = Store(app_folder(args.out, app_id, name, subtitle, args.number), app_id)
        lock = FolderLock(store.dir).__enter__()
        log(f"\nWriting to  {store.dir}/")
        t0 = time.time()
        results, reviews, done = [], [], 0
        with ThreadPoolExecutor(max_workers=args.workers) as ex:
            futs = {ex.submit(harvest_country, app_id, name, cc, None, store,
                              args.page_size): cc for cc in picked}
            for fut in as_completed(futs):
                cc = futs[fut]
                done += 1
                try:
                    added, have = fut.result()
                except Exception as e:
                    log(f"  [{cc}] error: {e}")
                    continue
                if have:
                    reviews.append((cc, have))
                if done % 40 == 0 or done == len(picked):
                    log(f"  {done}/{len(picked)} storefronts | "
                        f"{sum(h for _, h in reviews):,} reviews")
        counts = {cc: h for cc, h in reviews}
        dedupe_country_files(store, counts)
        merged, manifest = merge(store, app_id, meta, counts)
        lock.__exit__()
        log(f"\nDone in {(time.time()-t0)/60:.1f} min -- "
            f"{manifest['total_reviews']:,} reviews across "
            f"{manifest['storefronts_with_reviews']} storefronts")
        log(f"  {merged}")
        return

    counts = {}
    with ThreadPoolExecutor(max_workers=min(16, args.workers * 3)) as ex:
        futs = {ex.submit(review_count, app_id, cc): cc for cc in ccs}
        done = 0
        for fut in as_completed(futs):
            cc = futs[fut]
            done += 1
            try:
                n = fut.result()
            except Exception:
                n = None
            if n and n >= args.min_reviews:
                counts[cc] = n
            if done % 25 == 0 or done == len(ccs):
                log(f"  probed {done}/{len(ccs)}")

    if not counts:
        raise SystemExit("No storefront has written reviews for this app.")

    grand = sum(counts.values())
    ranked = sorted(counts.items(), key=lambda kv: -kv[1])
    log(f"\n{grand:,} reviews across {len(counts)} storefronts")
    log(f"{'':2} {'store':<18} {'reviews':>10}   share")
    for cc, n in ranked[:20]:
        log(f"   {markets.NAMES.get(cc, cc.upper())[:17]:<18} {n:>10,}   {n/grand*100:5.1f}%")
    if len(ranked) > 20:
        log(f"   ...and {len(ranked)-20} more storefronts "
            f"({sum(n for _, n in ranked[20:]):,} reviews)")
    log(f"\nEstimated requests: ~{sum(-(-n // args.page_size) for n in counts.values()):,}")

    if args.probe_only:
        return

    folder = app_folder(args.out, app_id, name, subtitle, args.number)
    lock = FolderLock(folder).__enter__()
    store = Store(folder, app_id)
    log(f"\nWriting to  {folder}/")
    t0 = time.time()
    grand_added, grand_have, finished = 0, 0, 0

    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(harvest_country, app_id, name, cc, n, store, args.page_size): cc
                for cc, n in ranked}
        for fut in as_completed(futs):
            cc = futs[fut]
            finished += 1
            try:
                added, have = fut.result()
            except Exception as e:
                log(f"  [{finished:>3}/{len(ranked)}] {cc} FAILED: {e} "
                    f"-- rerun to retry this storefront")
                continue
            grand_added += added
            grand_have += have
            el = max(time.time() - t0, 0.1)
            overall = grand_have / grand * 100 if grand else 100
            eta = (grand - grand_have) / (grand_have / el) / 60 if grand_have else 0
            log(f"  [{finished:>3}/{len(ranked)}] {cc} {markets.NAMES.get(cc, cc.upper())[:15]:<15} "
                f"{have:>7,} reviews   "
                f"total {grand_have:>9,}/{grand:,} ({overall:4.1f}%)  "
                f"{grand_have/el:,.0f}/s  eta {eta:4.1f}m")

    el = time.time() - t0
    dedupe_country_files(store, counts)
    merged, manifest = merge(store, app_id, meta, counts)
    lock.__exit__()
    log(f"\nDone in {el/60:.1f} min -- {grand_added:,} new reviews this run")
    log(f"  {merged}  ({manifest['total_reviews']:,} reviews)")
    log(f"  {os.path.join(store.dir, 'manifest.json')}")
    log(f"  mean rating {manifest['mean_rating']}  "
        f"across {manifest['storefronts_with_reviews']} storefronts")
    if _stop.is_set():
        log("\nStopped early. Rerun the same command to resume where it left off.")


if __name__ == "__main__":
    main()
