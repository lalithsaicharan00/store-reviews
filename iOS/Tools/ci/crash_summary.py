#!/usr/bin/env python3
"""Prints the app's crashes from this CI run, short enough for ci-results/latest.md.

A UI test that loses the app only says "Lost connection to the application"; the crash report says why. Reads the
simulator's crash reports (.ips: a JSON header line, then a JSON body) newer than the given file, and prints for each:
the exception, Swift's own message (e.g. "Fatal error: Index out of range") and the crashed thread's top frames.

Usage: crash_summary.py <newer-than file> [process name]
"""
import glob
import json
import os
import sys

since = os.path.getmtime(sys.argv[1]) if len(sys.argv) > 1 and os.path.exists(sys.argv[1]) else 0
name = sys.argv[2] if len(sys.argv) > 2 else "Habits"
paths = sorted(p for p in glob.glob(os.path.expanduser("~/Library/Logs/DiagnosticReports/*.ips"))
               if os.path.basename(p).startswith(name + "-") and os.path.getmtime(p) > since)
seen = set()
for path in paths[:6]:
    try:
        text = open(path, encoding="utf-8", errors="replace").read()
        header, _, body = text.partition("\n")
        report = json.loads(body)
    except Exception as error:  # an unreadable report is still worth naming
        print(f"{os.path.basename(path)}: unreadable ({error})")
        continue
    exception = report.get("exception", {})
    lines = [f"{exception.get('type', '?')} {exception.get('signal', '')}".strip()]
    for messages in (report.get("asi") or {}).values():
        lines += [m.strip() for m in messages if m.strip()]
    termination = report.get("termination", {}).get("indicator")
    if termination:
        lines.append(termination)
    images = report.get("usedImages", [])
    threads = report.get("threads", [])
    crashed = next((t for t in threads if t.get("triggered")), threads[0] if threads else {})
    for frame in crashed.get("frames", [])[:18]:
        image = images[frame["imageIndex"]].get("name", "?") if frame.get("imageIndex", -1) < len(images) else "?"
        symbol = frame.get("symbol", "?")
        where = f" ({frame['sourceFile']}:{frame.get('sourceLine', '?')})" if frame.get("sourceFile") else ""
        lines.append(f"  {image}: {symbol}{where}")
    key = "\n".join(lines[:6])
    if key in seen:
        continue
    seen.add(key)
    print(f"### {os.path.basename(path)}")
    print("\n".join(lines))
    print()
