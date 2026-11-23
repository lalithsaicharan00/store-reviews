#!/usr/bin/env python3
"""Show one review at a time, check each label, save it.

    python3 "Review Labels/Tools/label.py" claim  <App> --year YYYY [--count 25]
    python3 "Review Labels/Tools/label.py" next   <App> [--year YYYY] [--claim ID]
    python3 "Review Labels/Tools/label.py" save   <App> [--year YYYY] [--claim ID] [--replace]  < label.json
    python3 "Review Labels/Tools/label.py" check  <App>                            < label.json
    python3 "Review Labels/Tools/label.py" show   <App> <review_id>
    python3 "Review Labels/Tools/label.py" status <App>
    python3 "Review Labels/Tools/label.py" page    <App> [--year YYYY] [--count 25]
    python3 "Review Labels/Tools/label.py" checked <App> [--all]

claim   reserves the next 25 reviews with no label and no claim, for one labeller,
        and prints the claim's id. Two claims let two labellers work on one
        year at once without clashing. A claim closes when all its reviews
        have a label.
next    prints the next review that has no label yet (oldest year first, oldest
        review first), in full. With --year it stays inside that year; with
        --claim it stays inside that claim. Without --claim it skips claimed reviews.
save    reads the reader's label (JSON) on standard input, checks it, adds the
        facts copied from the review, appends it to <year>/labels.jsonl,
        updates <year>/progress.json, then prints the next review.
check   the same checks as save, without saving.
show    prints one review and its saved label, if any.
status  how far each year has got (labelled, and checked).
page    for the checker: the oldest saved labels not yet checked (25, or fewer when
        the reviews are long), each with its review in full and its label on one line.
checked marks the labels the last page showed as checked (<year>/checked.jsonl).
        --all marks every label saved so far; used once, for labels made before
        checking began.

The reader never writes to labels.jsonl or progress.json by hand.
"""
import json
import os
import re
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

SCHEMA = 1
PROMPT_VERSION = 2
LABELS_ROOT = Path(__file__).resolve().parent.parent

PAID = {"paid", "trial", "charged_unexpectedly", "refused", "free", "not_said"}
STILL_USING = {"using", "came_back", "about_to_quit", "quit", "not_said"}
PROBLEM_KINDS = {"broken", "missing", "dislike"}
LISTS = {  # field -> the key that holds the reader's own words
    "who": "label",
    "why_chose": "reason",
    "chose_for": "feature",
    "liked": "feature",
    "came_from": "app",
    "problems": "problem",
}
READER_KEYS = {"review_id", "language", "nothing_useful", "paid", "how_long_used",
               "still_using", "note", *LISTS}
MAX_WORDS_LABEL = 15
MAX_QUOTE_CHARS = 300


# ---------- loading ----------

def app_dir(app):
    d = LABELS_ROOT / app
    if not d.is_dir():
        sys.exit(f"No folder for {app!r} in {LABELS_ROOT}. Build it first with build_app.py.")
    return d


def years(app):
    return sorted(p.name for p in app_dir(app).iterdir() if p.is_dir() and re.fullmatch(r"\d{4}", p.name))


def read_jsonl(path):
    if not path.exists():
        return []
    return [json.loads(line) for line in path.open() if line.strip()]


def reviews(app, year):
    return read_jsonl(app_dir(app) / year / "reviews.jsonl")


def labelled_ids(app, year):
    return {l["review_id"] for l in read_jsonl(app_dir(app) / year / "labels.jsonl")}


def find_review(app, review_id):
    for y in years(app):
        for r in reviews(app, y):
            if r["review_id"] == review_id:
                return y, r
    return None, None


def next_review(app, only_year=None, claim=None):
    """The next review to label: within a claim if one is given, otherwise the first one
    that has no label and isn't reserved by an open claim."""
    if claim:
        y, ids = find_claim(app, claim)
        if y is None:
            return None, None
        done = labelled_ids(app, y)
        for r in reviews(app, y):
            if r["review_id"] in ids and r["review_id"] not in done:
                return y, r
        return None, None
    for y in years(app):
        if only_year and y != only_year:
            continue
        done = labelled_ids(app, y)
        reserved = {i for ids in read_claims(app, y).values() for i in ids}
        for r in reviews(app, y):
            if r["review_id"] not in done and r["review_id"] not in reserved:
                return y, r
    return None, None


# ---------- claims: two labellers on one year without clashing ----------

def read_claims(app, year):
    p = app_dir(app) / year / "claims.json"
    return json.loads(p.read_text()) if p.exists() else {}


def write_claims(app, year, claims):
    p = app_dir(app) / year / "claims.json"
    if claims:
        p.write_text(json.dumps(claims, indent=1) + "\n")
    elif p.exists():
        p.unlink()


def find_claim(app, claim):
    for y in years(app):
        c = read_claims(app, y)
        if claim in c:
            return y, set(c[claim])
    return None, None


def claim_left(app, year, claim):
    done = labelled_ids(app, year)
    return [i for i in read_claims(app, year).get(claim, []) if i not in done]


class Lock:
    """One writer at a time per year folder (two labellers save side by side)."""
    def __init__(self, folder):
        self.path = folder / ".lock"

    def __enter__(self):
        for _ in range(600):
            try:
                self.fd = os.open(self.path, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
                return self
            except FileExistsError:
                time.sleep(0.1)
        sys.exit(f"NOT SAVED. {self.path} has been held for a minute. If no other save is running, delete it and save again.")

    def __exit__(self, *exc):
        os.close(self.fd)
        os.remove(self.path)


# ---------- printing ----------

def counts(app):
    out = []
    for y in years(app):
        out.append((y, len(labelled_ids(app, y)), len(reviews(app, y))))
    return out


def print_review(app, year, r):
    c = counts(app)
    done_y, total_y = next((d, t) for yy, d, t in c if yy == year)
    left = sum(t - d for _, d, t in c)
    print(f"── {app} · {year}: {done_y:,} of {total_y:,} labelled · {left:,} left in the app ──")
    print(f"review_id: {r['review_id']}")
    where = (f"country {r['country']} ({r['country_name']})" if r["store"] == "appstore"
             else f"store_language {r['store_language']} ({r['store_language_name']})")
    extra = f" · version {r['app_version']}" if r.get("app_version") else ""
    print(f"store: {r['store']} · {r['date'][:10]} · {r['rating']}★ · {where}{extra} · helpful votes {r['helpful_votes']}")
    if r.get("duplicate_of"):
        print(f"NOTE: same author and words as review {r['duplicate_of']} (label it anyway)")
    print()
    if r.get("title"):
        print(f"TITLE: {r['title']}")
    print("TEXT:")
    print(r["text"] if r["text"].strip() else "(no text)")
    print("── end of review ──")


# ---------- checking ----------

QUOTE_MAP = str.maketrans({"’": "'", "‘": "'", "“": '"', "”": '"', "…": "...", " ": " "})


def flat(s):
    return re.sub(r"\s+", " ", (s or "").translate(QUOTE_MAP)).strip().casefold()


def check(app, lab, replace=False, only_year=None, claim=None):
    errs = []
    if not isinstance(lab, dict):
        return ["The label must be one JSON object."], None, None
    extra = set(lab) - READER_KEYS
    missing = READER_KEYS - set(lab)
    if extra:
        errs.append(f"Unknown fields: {sorted(extra)}. Copied facts (store, date, rating …) are added by the tool; leave them out.")
    if missing:
        errs.append(f"Missing fields: {sorted(missing)}.")
    if errs:
        return errs, None, None

    year, r = find_review(app, str(lab["review_id"]))
    if r is None:
        return [f"review_id {lab['review_id']!r} is not in {app}."], None, None
    if replace:
        if r["review_id"] not in labelled_ids(app, year):
            errs.append("--replace is only for correcting a review that already has a label.")
    elif r["review_id"] in labelled_ids(app, year):
        errs.append("This review already has a label. Use --replace only to correct one on purpose.")
    else:
        # Strictly in order: only the review `next` shows can be labelled.
        _, expected = next_review(app, only_year, claim)
        if expected is None or expected["review_id"] != r["review_id"]:
            want = expected["review_id"] if expected else "none (all done)"
            errs.append(f"Out of order. The next review to label is {want}. "
                        f"Run `next`{' --claim ' + claim if claim else ''} and label the review it shows.")
    source = flat((r.get("title") or "") + "\n" + r["text"])

    def quote_ok(where, q):
        if not isinstance(q, str) or not q.strip():
            errs.append(f"{where}: a quote is required.")
        elif len(q) > MAX_QUOTE_CHARS:
            errs.append(f"{where}: quote is {len(q)} characters; keep it under {MAX_QUOTE_CHARS} (the shortest part that proves it).")
        elif flat(q) not in source:
            errs.append(f"{where}: quote {q!r} is not word for word in the review's title or text. Copy it exactly, in the review's own language.")

    def words_ok(where, s):
        if not isinstance(s, str) or not s.strip():
            errs.append(f"{where}: needs plain words.")
        elif len(s.split()) > MAX_WORDS_LABEL:
            errs.append(f"{where}: {len(s.split())} words; keep it to {MAX_WORDS_LABEL} or fewer.")

    if not isinstance(lab["language"], str) or not re.fullmatch(r"[a-z]{2,3}(-[A-Za-z0-9]{2,4})?|und", lab["language"]):
        errs.append("language: a code like en, es, pt-BR, zh-TW, or und when it can't be told (emoji only).")
    if not isinstance(lab["nothing_useful"], bool):
        errs.append("nothing_useful: true or false.")

    for field, key in LISTS.items():
        items = lab[field]
        if not isinstance(items, list):
            errs.append(f"{field}: must be a list (use [] when the review says nothing).")
            continue
        for i, it in enumerate(items):
            where = f"{field}[{i}]"
            want = {key, "quote"} | ({"kind"} if field == "problems" else set())
            if not isinstance(it, dict) or set(it) != want:
                errs.append(f"{where}: must have exactly {sorted(want)}.")
                continue
            words_ok(where, it[key])
            quote_ok(where, it["quote"])
            if field == "problems" and it["kind"] not in PROBLEM_KINDS:
                errs.append(f"{where}.kind: one of {sorted(PROBLEM_KINDS)}.")

    p = lab["paid"]
    if not isinstance(p, dict) or set(p) != {"status", "why", "quote"}:
        errs.append('paid: {"status": …, "why": …, "quote": …}.')
    elif p["status"] not in PAID:
        errs.append(f"paid.status: one of {sorted(PAID)}.")
    elif p["status"] == "not_said":
        if p["why"] is not None or p["quote"] is not None:
            errs.append("paid: when not_said, why and quote are null.")
    else:
        quote_ok("paid", p["quote"])
        if p["why"] is not None:
            words_ok("paid.why", p["why"])

    h = lab["how_long_used"]
    if h is not None:
        if not isinstance(h, dict) or set(h) != {"value", "quote"}:
            errs.append('how_long_used: null, or {"value": …, "quote": …}.')
        else:
            words_ok("how_long_used.value", h["value"])
            quote_ok("how_long_used", h["quote"])

    s = lab["still_using"]
    if not isinstance(s, dict) or set(s) != {"status", "quote"}:
        errs.append('still_using: {"status": …, "quote": …}.')
    elif s["status"] not in STILL_USING:
        errs.append(f"still_using.status: one of {sorted(STILL_USING)}.")
    elif s["status"] == "not_said":
        if s["quote"] is not None:
            errs.append("still_using: when not_said, quote is null.")
    else:
        quote_ok("still_using", s["quote"])

    if lab["note"] is not None and not isinstance(lab["note"], str):
        errs.append("note: null or a short sentence.")

    if not errs:
        empty = (all(not lab[f] for f in LISTS) and lab["paid"]["status"] == "not_said"
                 and lab["how_long_used"] is None and lab["still_using"]["status"] == "not_said")
        if lab["nothing_useful"] and not empty:
            errs.append("nothing_useful is true but something was recorded. It is true only when every field is empty.")
        if not lab["nothing_useful"] and empty:
            errs.append("Nothing was recorded, so nothing_useful must be true.")
    return errs, year, r


def full_record(app, year, r, lab):
    return {
        "schema": SCHEMA,
        "prompt": PROMPT_VERSION,
        "app": app,
        "review_id": r["review_id"],
        "store": r["store"],
        "date": r["date"],
        "year": int(year),
        "rating": r["rating"],
        "country": r["country"],
        "store_language": r["store_language"],
        "app_version": r["app_version"],
        "helpful_votes": r["helpful_votes"],
        "developer_replied": bool(r.get("developer_reply")),
        "duplicate_of": r.get("duplicate_of"),
        "language": lab["language"],
        "nothing_useful": lab["nothing_useful"],
        "who": lab["who"],
        "why_chose": lab["why_chose"],
        "chose_for": lab["chose_for"],
        "liked": lab["liked"],
        "came_from": lab["came_from"],
        "paid": lab["paid"],
        "problems": lab["problems"],
        "how_long_used": lab["how_long_used"],
        "still_using": lab["still_using"],
        "note": lab["note"],
        "labelled_at": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
    }


def write_progress(app, year):
    d = app_dir(app) / year
    labels = read_jsonl(d / "labels.jsonl")
    order = {r["review_id"]: i for i, r in enumerate(reviews(app, year))}
    last = max(labels, key=lambda l: order.get(l["review_id"], -1))["review_id"] if labels else None
    total = len(order)
    (d / "progress.json").write_text(json.dumps({
        "app": app,
        "year": int(year),
        "reviews": total,
        "labelled": len(labels),
        "left": total - len(labels),
        "done": len(labels) == total,
        "last_labelled_in_order": last,
        "prompt_versions": sorted({l["prompt"] for l in labels}),
        "updated": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
    }, indent=2) + "\n")


def read_label_from_stdin():
    raw = sys.stdin.read()
    try:
        return json.loads(raw)
    except json.JSONDecodeError as e:
        sys.exit(f"NOT SAVED. The label isn't valid JSON: {e}")


# ---------- checking pages ----------

PAGE_COUNT = 25          # labels per check page (one Sonnet batch)
PAGE_MAX_CHARS = 20000   # a page stops early once its reviews' text passes this
LABEL_ORDER = ["review_id", "language", "nothing_useful", "who", "why_chose", "chose_for", "liked",
               "came_from", "paid", "problems", "how_long_used", "still_using", "note"]


def checked_ids(app, year):
    return {c["review_id"] for c in read_jsonl(app_dir(app) / year / "checked.jsonl")}


def unchecked_ids(app, year):
    return labelled_ids(app, year) - checked_ids(app, year)


def mark_checked(app, year, ids):
    if not ids:
        return
    now = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    with (app_dir(app) / year / "checked.jsonl").open("a") as out:
        for i in ids:
            out.write(json.dumps({"review_id": i, "checked_at": now}) + "\n")


def unchecked_page(app, only_year, count, max_chars):
    """The oldest saved labels not yet checked, in review order, within one year."""
    for y in years(app):
        if only_year and y != only_year:
            continue
        todo = unchecked_ids(app, y)
        if not todo:
            continue
        labels = {l["review_id"]: l for l in read_jsonl(app_dir(app) / y / "labels.jsonl")}
        shown, chars = [], 0
        for r in reviews(app, y):
            if r["review_id"] not in todo:
                continue
            size = len(r.get("title") or "") + len(r["text"])
            if shown and (len(shown) >= count or chars + size > max_chars):
                break
            shown.append((r, labels[r["review_id"]]))
            chars += size
        return shown, y
    return [], None


# ---------- commands ----------

def opt(args, name):
    if name in args:
        i = args.index(name)
        return args[i + 1]
    return None


def main():
    args = sys.argv[1:]
    if len(args) < 2:
        sys.exit(__doc__)
    cmd, app = args[0], args[1]
    only_year = opt(args, "--year")
    claim = opt(args, "--claim")
    if claim and find_claim(app, claim)[0] is None:
        sys.exit(f"No open claim {claim!r} in {app}. It may be finished: run status.")

    def done_message():
        if claim:
            return f"Claim {claim} done: all its reviews have a label. Stop here."
        return f"All done: every review{' in ' + only_year if only_year else ''} in {app} has a label."

    if cmd == "next":
        y, r = next_review(app, only_year, claim)
        if r is None:
            print(done_message())
            return
        print_review(app, y, r)

    elif cmd == "claim":
        count = int(opt(args, "--count") or 25)
        y, first = next_review(app, only_year)
        if first is None:
            print(f"Nothing to claim: every review{' in ' + only_year if only_year else ''} in {app} has a label or is claimed.")
            return
        with Lock(app_dir(app) / y):
            claims = read_claims(app, y)
            done = labelled_ids(app, y)
            reserved = {i for ids in claims.values() for i in ids}
            ids = [r["review_id"] for r in reviews(app, y)
                   if r["review_id"] not in done and r["review_id"] not in reserved][:count]
            cid = f"{y}-{datetime.now(timezone.utc).strftime('%H%M%S')}-{len(claims) + 1}"
            claims[cid] = ids
            write_claims(app, y, claims)
        print(f"Claimed {len(ids)} reviews in {y}: {cid}")

    elif cmd in ("save", "check"):
        lab = read_label_from_stdin()
        errs, year, r = check(app, lab, replace="--replace" in args, only_year=only_year, claim=claim)
        if errs:
            print("NOT SAVED. Fix these and send the label again:")
            for e in errs:
                print(" -", e)
            sys.exit(1)
        if cmd == "check":
            print("OK: this label would save.")
            return
        rec = full_record(app, year, r, lab)
        path = app_dir(app) / year / "labels.jsonl"
        with Lock(app_dir(app) / year):
            if "--replace" in args:
                rows = [l for l in read_jsonl(path) if l["review_id"] != r["review_id"]] + [rec]
                with path.open("w") as out:
                    for l in rows:
                        out.write(json.dumps(l, ensure_ascii=False) + "\n")
            else:
                with path.open("a") as out:
                    out.write(json.dumps(rec, ensure_ascii=False) + "\n")
            write_progress(app, year)
            if claim and not claim_left(app, year, claim):
                claims = read_claims(app, year)
                claims.pop(claim, None)
                write_claims(app, year, claims)
        print(f"Saved {r['review_id']}.\n")
        if claim and find_claim(app, claim)[0] is None:
            print(done_message())
            return
        y, nxt = next_review(app, only_year, claim)
        if nxt is None:
            print(done_message())
        else:
            print_review(app, y, nxt)

    elif cmd == "show":
        y, r = find_review(app, args[2])
        if r is None:
            sys.exit("No such review.")
        print_review(app, y, r)
        for l in read_jsonl(app_dir(app) / y / "labels.jsonl"):
            if l["review_id"] == r["review_id"]:
                print(json.dumps(l, ensure_ascii=False, indent=2))

    elif cmd == "page":
        count = int(opt(args, "--count") or PAGE_COUNT)
        max_chars = int(opt(args, "--max-chars") or PAGE_MAX_CHARS)
        shown, year = unchecked_page(app, only_year, count, max_chars)
        if not shown:
            print(f"Nothing to check: every saved label{' in ' + only_year if only_year else ''} in {app} is checked.")
            return
        (app_dir(app) / year / "page.json").write_text(json.dumps([r["review_id"] for r, _ in shown]) + "\n")
        left = sum(len(unchecked_ids(app, y)) for y in years(app) if not only_year or y == only_year)
        print(f"── {app} · {year}: checking {len(shown)} labels · {left:,} unchecked in all ──\n")
        for i, (r, l) in enumerate(shown, 1):
            where = r["country"] if r["store"] == "appstore" else r["store_language"]
            print(f"[{i}/{len(shown)}] {r['review_id']} · {r['store']} · {r['date'][:10]} · {r['rating']}★ · {where}")
            if r.get("title"):
                print(f"TITLE: {r['title']}")
            print(f"TEXT: {r['text'] if r['text'].strip() else '(no text)'}")
            print("LABEL: " + json.dumps({k: l[k] for k in LABEL_ORDER}, ensure_ascii=False))
            print()
        print("── end of page: correct any label with save --replace, then run checked ──")

    elif cmd == "checked":
        if "--all" in args:  # once, for labels made before checking began
            n = 0
            for y in years(app):
                if only_year and y != only_year:
                    continue
                ids = sorted(unchecked_ids(app, y))
                mark_checked(app, y, ids)
                n += len(ids)
            print(f"Marked {n:,} labels as checked.")
            return
        marked = 0
        for y in years(app):
            page = app_dir(app) / y / "page.json"
            if page.exists():
                ids = [i for i in json.loads(page.read_text()) if i in labelled_ids(app, y)]
                mark_checked(app, y, ids)
                marked += len(ids)
                page.unlink()
        print(f"Marked {marked} labels as checked." if marked else "No page to mark: run page first.")

    elif cmd == "status":
        total_d = total_t = total_c = 0
        for y, d, t in counts(app):
            c = d - len(unchecked_ids(app, y))
            total_d += d
            total_t += t
            total_c += c
            print(f"{y}: {d:>6,} of {t:>6,} labelled · {c:>6,} checked")
            for cid in read_claims(app, y):
                print(f"      open claim {cid}: {len(claim_left(app, y, cid))} reviews left to label")
        print(f"all : {total_d:>6,} of {total_t:>6,} labelled · {total_c:>6,} checked")

    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main()
