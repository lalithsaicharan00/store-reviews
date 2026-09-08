#!/usr/bin/env python3
"""
Google Play review extractor -- every written review, every language.

Play has no public reviews API. This uses the same internal RPC the Play web UI
calls (batchexecute / UsvDTd), paginating each language with its continuation
token until Play stops handing one back.

Two facts that shape the design, both verified rather than assumed:
  - Reviews partition by LANGUAGE, not country. Holding hl=en while varying gl
    across US/IN/JP/DE/BR/NG returned identical reviews; varying hl returned
    zero overlap. So we sweep ~76 languages, not storefronts.
  - Ratings are global on Play, so there is no per-country rating breakdown to
    collect -- only the reviews themselves.

Checkpointed after every page (continuation token included), so an interrupted
run resumes mid-language rather than restarting it.

  python3 play_extract.py org.isoron.uhabits
  python3 play_extract.py com.habitnow --languages priority --number 2
"""
from __future__ import annotations

import argparse
import html
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

import play_languages

UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
RPC = ("https://play.google.com/_/PlayStoreUi/data/batchexecute"
       "?rpcids=UsvDTd&source-path=/store/apps/details")
PAGE = 150
SORT_NEWEST = 2

_stop = threading.Event()
_out = threading.Lock()


def log(m):
    with _out:
        sys.stderr.write(m + "\n")
        sys.stderr.flush()


class Throttle:
    """Shared pacing. Widens on pushback, eases back on success."""

    def __init__(self, base=0.0, cap=30.0):
        self.base, self.cap, self.penalty = base, cap, 0.0
        self.lock = threading.Lock()

    def wait(self):
        with self.lock:
            d = self.base + self.penalty
        if d:
            time.sleep(d * random.uniform(0.7, 1.3))

    def punish(self):
        with self.lock:
            self.penalty = min(self.cap, max(1.0, self.penalty * 2))
            p = self.penalty
        log(f"  ! Play pushed back -- backing off to {p:.1f}s between requests")

    def relax(self):
        with self.lock:
            if self.penalty:
                self.penalty = max(0.0, self.penalty * 0.85)
                if self.penalty < 0.05:
                    self.penalty = 0.0


THROTTLE = Throttle()


def rpc(pkg, hl, count, token, tries=6):
    """One page. Returns (reviews, next_token) or None if unreadable."""
    inner = json.dumps([None, None,
                        [2, SORT_NEWEST, [count, None, token], None, []],
                        [pkg, 7]])
    body = urllib.parse.urlencode(
        {"f.req": json.dumps([[["UsvDTd", inner, None, "generic"]]])}).encode()
    url = f"{RPC}&hl={urllib.parse.quote(hl)}&gl=US"
    for attempt in range(tries):
        if _stop.is_set():
            return None
        THROTTLE.wait()
        try:
            req = urllib.request.Request(url, data=body, headers={
                "User-Agent": UA,
                "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"})
            with urllib.request.urlopen(req, timeout=60) as r:
                raw = r.read().decode("utf-8", "replace")
            THROTTLE.relax()
            for line in raw.split("\n"):
                line = line.strip()
                if not line.startswith("[["):
                    continue
                try:
                    env = json.loads(line)
                except json.JSONDecodeError:
                    continue
                for it in env:
                    if len(it) > 2 and it[0] == "wrb.fr" and it[1] == "UsvDTd" and it[2]:
                        payload = json.loads(it[2])
                        revs = payload[0] if payload else []
                        nxt = (payload[1][1]
                               if len(payload) > 1 and payload[1] and len(payload[1]) > 1
                               else None)
                        return revs or [], nxt
            return [], None            # valid response, nothing left
        except urllib.error.HTTPError as e:
            if e.code in (429, 503, 403):
                THROTTLE.punish()
                time.sleep(min(90, (2 ** attempt) * 3 + random.random() * 3))
                continue
            if e.code in (400, 404):
                return None
            time.sleep(2 * (attempt + 1))
        except Exception:
            time.sleep(min(25, 2 * (attempt + 1) + random.random()))
    return None


def normalise(r, hl, pkg, app_name):
    """Flat record. Field positions verified against a live response."""
    def at(i, default=None):
        return r[i] if len(r) > i and r[i] is not None else default
    ts = at(5) or [None]
    author = at(1) or [None]
    reply = at(7)
    return {
        "review_id": str(at(0) or ""),
        "package": pkg,
        "app_name": app_name,
        "language": hl,
        "language_name": play_languages.NAMES.get(hl, hl),
        "rating": at(2),
        "text": html.unescape(at(4) or "").strip(),
        "author": author[0] if author else None,
        "date": (time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime(ts[0]))
                 if ts and ts[0] else None),
        "thumbs_up": at(6, 0),
        "app_version": at(10),
        "developer_reply": (html.unescape(reply[1]) if reply and len(reply) > 1
                            and isinstance(reply[1], str) else None),
    }


class Store:
    def __init__(self, folder, pkg):
        self.dir = folder
        os.makedirs(os.path.join(self.dir, "by_language"), exist_ok=True)
        self.state_path = os.path.join(self.dir, "_state.json")
        self.lock = threading.Lock()
        try:
            with open(self.state_path, encoding="utf-8") as f:
                self.state = json.load(f)
        except (OSError, json.JSONDecodeError):
            self.state = {"package": pkg, "languages": {}}
        self.state["package"] = pkg
        self.save()

    def save(self):
        with self.lock:
            tmp = self.state_path + ".tmp"
            with open(tmp, "w", encoding="utf-8") as f:
                json.dump(self.state, f, indent=1)
            os.replace(tmp, self.state_path)

    def path(self, hl):
        return os.path.join(self.dir, "by_language", f"{hl}.jsonl")

    def seen(self, hl):
        ids = set()
        try:
            with open(self.path(hl), encoding="utf-8") as f:
                for line in f:
                    if line.strip():
                        try:
                            ids.add(json.loads(line)["review_id"])
                        except (json.JSONDecodeError, KeyError):
                            pass
        except FileNotFoundError:
            pass
        return ids

    def append(self, hl, rows):
        if not rows:
            return
        with open(self.path(hl), "a", encoding="utf-8") as f:
            for r in rows:
                f.write(json.dumps(r, ensure_ascii=False) + "\n")
            f.flush()
            os.fsync(f.fileno())


class FolderLock:
    def __init__(self, folder):
        self.path = os.path.join(folder, ".lock")
        self.fd = None

    def __enter__(self):
        try:
            self.fd = os.open(self.path, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
            os.write(self.fd, f"pid={os.getpid()}\n".encode())
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
                    alive = False
                except PermissionError:
                    alive = True
            if not alive:
                log(f"  clearing stale lock ({who})")
                try:
                    os.unlink(self.path)
                except OSError:
                    pass
                return self.__enter__()
            raise SystemExit(f"\nAnother extractor holds this folder ({who}).\n")

    def __exit__(self, *a):
        if self.fd is not None:
            os.close(self.fd)
        try:
            os.unlink(self.path)
        except OSError:
            pass


def harvest(pkg, app_name, hl, store, page_size, max_pages):
    """Every review in one language. Resumes from the saved continuation token."""
    st = store.state["languages"].setdefault(hl, {})
    if st.get("complete"):
        return 0, st.get("collected", 0)
    seen = store.seen(hl)
    token = st.get("token")
    pages = st.get("pages", 0)
    added = 0

    while not _stop.is_set() and pages < max_pages:
        got = rpc(pkg, hl, page_size, token)
        if got is None:
            st["token"] = token
            st["pages"] = pages
            st["collected"] = len(seen)
            store.save()
            return added, len(seen)
        rows, token = got
        pages += 1
        fresh = []
        for raw in rows:
            rec = normalise(raw, hl, pkg, app_name)
            if rec["review_id"] and rec["review_id"] not in seen:
                seen.add(rec["review_id"])
                fresh.append(rec)
        store.append(hl, fresh)
        added += len(fresh)
        st.update(token=token, pages=pages, collected=len(seen))
        store.save()
        if not token or not rows:
            break                       # Play handed back no continuation: done

    st["complete"] = (not token) and not _stop.is_set()
    st["collected"] = len(seen)
    store.save()
    return added, len(seen)


def safe_dirname(t):
    t = re.sub(r"[/\\\x00-\x1f]", "-", t or "")
    return re.sub(r"\s+", " ", t).strip(" .")[:120]


def app_folder(outdir, pkg, name, number=None):
    os.makedirs(outdir, exist_ok=True)
    label = safe_dirname(name) or pkg
    for entry in sorted(os.listdir(outdir)):
        path = os.path.join(outdir, entry)
        if not os.path.isdir(path):
            continue
        try:
            with open(os.path.join(path, "_state.json"), encoding="utf-8") as f:
                if json.load(f).get("package") != pkg:
                    continue
        except (OSError, json.JSONDecodeError):
            continue
        if number is None:
            return path
        want = os.path.join(outdir, f"{number}. {label}")
        if os.path.abspath(path) != os.path.abspath(want) and not os.path.exists(want):
            os.rename(path, want)
            log(f"  renumbered: {entry} -> {number}. {label}")
            return want
        return path
    if number is None:
        used = {int(m.group(1)) for e in os.listdir(outdir)
                for m in [re.match(r"(\d+)\.", e)]
                if m and os.path.isdir(os.path.join(outdir, e))}
        number = 1
        while number in used:
            number += 1
    path = os.path.join(outdir, f"{number}. {label}")
    os.makedirs(path, exist_ok=True)
    return path


def app_title(pkg):
    """Play listing title, for the folder name."""
    url = ("https://play.google.com/store/apps/details?"
           + urllib.parse.urlencode({"id": pkg, "gl": "US", "hl": "en"}))
    try:
        req = urllib.request.Request(url, headers={"User-Agent": UA})
        with urllib.request.urlopen(req, timeout=45) as r:
            h = r.read().decode("utf-8", "replace")
        m = re.search(r"<title[^>]*>([^<]+?)(?:\s*-\s*Apps on Google Play)?</title>", h)
        return html.unescape(m.group(1)).strip() if m else pkg
    except Exception:
        return pkg


def merge(store, pkg, app_name):
    outdir = store.dir
    merged = os.path.join(outdir, "reviews.jsonl")
    seen, per_lang, ratings = set(), {}, {}
    on_disk = sorted(f[:-6] for f in os.listdir(os.path.join(outdir, "by_language"))
                     if f.endswith(".jsonl"))
    tmp = merged + ".tmp"
    n = 0
    with open(tmp, "w", encoding="utf-8") as out:
        for hl in on_disk:
            c = 0
            with open(store.path(hl), encoding="utf-8") as f:
                for line in f:
                    if not line.strip():
                        continue
                    try:
                        rec = json.loads(line)
                    except json.JSONDecodeError:
                        continue
                    rid = rec.get("review_id")
                    if rid in seen:
                        continue
                    seen.add(rid)
                    out.write(line if line.endswith("\n") else line + "\n")
                    c += 1
                    r = rec.get("rating")
                    if r:
                        ratings[r] = ratings.get(r, 0) + 1
            if c:
                per_lang[hl] = c
            n += c
    os.replace(tmp, merged)
    tot = sum(ratings.values())
    manifest = {
        "store": "Google Play",
        "package": pkg,
        "app_name": app_name,
        "extracted_at": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "source": "play.google.com batchexecute UsvDTd",
        "total_reviews": n,
        "languages_with_reviews": len(per_lang),
        "reviews_per_language": dict(sorted(per_lang.items(), key=lambda kv: -kv[1])),
        "rating_distribution": {str(k): ratings.get(k, 0) for k in (5, 4, 3, 2, 1)},
        "mean_rating": (round(sum(k * v for k, v in ratings.items()) / tot, 3)
                        if tot else None),
        "note": ("Play exposes no total written-review count, so completeness means "
                 "every language was paginated until Play stopped returning a "
                 "continuation token."),
    }
    with open(os.path.join(outdir, "manifest.json"), "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)
    return merged, manifest


def main():
    ap = argparse.ArgumentParser(description="Extract all Play Store reviews for an app.")
    ap.add_argument("package", help="Play package id, e.g. org.isoron.uhabits")
    ap.add_argument("--languages", default="all", help="all | priority | en,es,ja")
    ap.add_argument("--out", default="play_out")
    ap.add_argument("--number", type=int, default=None, help="Folder prefix (rank)")
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--page-size", type=int, default=PAGE)
    ap.add_argument("--delay", type=float, default=0.0)
    ap.add_argument("--max-pages", type=int, default=400,
                    help="Safety cap on pages per language")
    args = ap.parse_args()
    THROTTLE.base = args.delay

    def on_sigint(*_):
        if _stop.is_set():
            os._exit(1)
        log("\nStopping after current pages... progress saved; rerun to resume.")
        _stop.set()
    signal.signal(signal.SIGINT, on_sigint)

    name = app_title(args.package)
    log(f"\n{name}  ({args.package})")
    langs = play_languages.resolve(args.languages)
    folder = app_folder(args.out, args.package, name, args.number)
    store = Store(folder, args.package)
    lock = FolderLock(folder).__enter__()
    log(f"Writing to  {folder}/")
    log(f"Sweeping {len(langs)} languages...")

    t0 = time.time()
    total_added = done = 0
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(harvest, args.package, name, hl, store,
                          args.page_size, args.max_pages): hl for hl in langs}
        for fut in as_completed(futs):
            hl = futs[fut]
            done += 1
            try:
                added, have = fut.result()
            except Exception as e:
                log(f"  [{hl}] error: {e}")
                continue
            total_added += added
            if have:
                log(f"  [{done:>2}/{len(langs)}] {hl:<6} "
                    f"{play_languages.NAMES.get(hl, '')[:14]:<15} {have:>7,} reviews")
            elif done % 15 == 0:
                log(f"  [{done:>2}/{len(langs)}] ...")

    merged, manifest = merge(store, args.package, name)
    lock.__exit__()
    log(f"\nDone in {(time.time()-t0)/60:.1f} min -- {total_added:,} new reviews")
    log(f"  {merged}  ({manifest['total_reviews']:,} reviews, "
        f"{manifest['languages_with_reviews']} languages, "
        f"mean {manifest['mean_rating']})")
    if _stop.is_set():
        log("\nStopped early -- rerun the same command to resume.")


if __name__ == "__main__":
    main()
