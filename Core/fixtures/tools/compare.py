#!/usr/bin/env python3
"""Compares two sets of recorded answers, every key, the screens under "full" included (Current Work 92, checkpoint 2).

    python3 Core/fixtures/tools/compare.py <answers dir A> <answers dir B>

A is the iPhone's own Swift rules (`-golden-record`), B the same cases through the shared rules (`-golden-shared`).
Numbers compare within one millionth. Prints each case that differs with its first differences, and exits 1 if any do.
"""
import gzip
import json
import os
import sys


def load(path):
    opener = gzip.open if path.endswith(".gz") else open
    with opener(path, "rt") as f:
        return json.load(f)["cases"]


def same_number(a, b):
    return abs(a - b) <= 1e-6 * max(1.0, abs(a), abs(b))


def compare(a, b, path, out):
    if len(out) > 20:
        return
    if isinstance(a, dict) and isinstance(b, dict):
        for k in sorted(set(a) | set(b)):
            if k not in a or k not in b:
                out.append(f"{path}.{k}: only in {'B' if k not in a else 'A'}")
            else:
                compare(a[k], b[k], f"{path}.{k}", out)
    elif isinstance(a, list) and isinstance(b, list):
        if len(a) != len(b):
            out.append(f"{path}: {len(a)} vs {len(b)} items")
        for i, (x, y) in enumerate(zip(a, b)):
            compare(x, y, f"{path}[{i}]", out)
    elif isinstance(a, bool) or isinstance(b, bool):
        if a != b:
            out.append(f"{path}: {a} vs {b}")
    elif isinstance(a, (int, float)) and isinstance(b, (int, float)):
        if not same_number(a, b):
            out.append(f"{path}: {a} vs {b}")
    elif a != b:
        out.append(f"{path}: {str(a)[:80]} vs {str(b)[:80]}")


def main():
    a_dir, b_dir = sys.argv[1], sys.argv[2]
    bad = 0
    total = 0
    for name in sorted(os.listdir(a_dir)):
        if not name.endswith((".json", ".json.gz")):
            continue
        other = os.path.join(b_dir, name)
        if not os.path.exists(other):
            print(f"{name}: not in {b_dir}")
            bad += 1
            continue
        for x, y in zip(load(os.path.join(a_dir, name)), load(other)):
            total += 1
            diffs = []
            compare(x, y, "", diffs)
            if diffs:
                bad += 1
                print(f"{x.get('name')}: " + "; ".join(diffs[:8]))
    print(f"{total} cases compared, {bad} differ")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
