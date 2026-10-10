#!/usr/bin/env python3
"""Copies the Watch screenshot test's PNGs out of exported xcresult attachments, named by their attachment names
(`46mm-A1-today.png`), and makes small copies for committing (Apple Watch build prompt §6).

Usage: watch_shots.py <exported attachment folder>... <output folder>
"""
import json, pathlib, shutil, sys

*sources, out = sys.argv[1:]
out = pathlib.Path(out)
out.mkdir(parents=True, exist_ok=True)
count = 0
for source in map(pathlib.Path, sources):
    manifest = source / "manifest.json"
    if not manifest.exists():
        continue
    for test in json.loads(manifest.read_text()):
        for item in test.get("attachments", []):
            name = item.get("suggestedHumanReadableName") or item.get("exportedFileName")
            exported = source / item.get("exportedFileName", "")
            if not exported.exists() or exported.suffix.lower() != ".png":
                continue
            # Attachment names are "<size>-<picture>-<state>"; xcresult may add "_0_<uuid>" before the extension.
            stem = name.rsplit(".", 1)[0].split("_0_")[0]
            shutil.copyfile(exported, out / f"{stem}.png")
            count += 1
print(f"{count} screenshots")
