#!/usr/bin/env python3
"""Adds icons to website/src/icons.json: python3 website/fetch_icons.py check play_arrow.fill

Google's Material Symbols, Rounded, weight 400, 24 px, the same outlines the app draws (Symbols.kt). `name.fill` is the
filled one. They're kept in the repository, so a build never needs the network.
"""
import json
import re
import sys
import urllib.request
from pathlib import Path

FILE = Path(__file__).parent / "src" / "icons.json"
URL = "https://fonts.gstatic.com/s/i/short-term/release/materialsymbolsrounded/{name}/{style}/24px.svg"

icons = json.loads(FILE.read_text()) if FILE.exists() else {}
for icon in sys.argv[1:]:
    name, _, fill = icon.partition(".")
    with urllib.request.urlopen(URL.format(name=name, style="fill1" if fill else "default"), timeout=20) as response:
        icons[icon] = re.search(r' d="([^"]+)"', response.read().decode()).group(1)
FILE.write_text(json.dumps(icons, indent=0, sort_keys=True) + "\n")
print(f"{len(icons)} icons in {FILE}")
