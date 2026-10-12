"""Step 2 sampling: 40 Play reviews (English, 40+ characters) per theme from theme_hits.jsonl, seed 20261012.
Run from this folder after scan_themes.py; writes read/<theme>.txt (check mode: compares IDs with existing files)."""
import json, random, re, sys
THEMES = ["reminders_unreliable", "battery_background", "widget_wanted", "widget_broken", "dark_mode_theme",
          "back_navigation", "free_open_source", "home_screen_shortcut"]
rows = {t: [] for t in THEMES}
for l in open("theme_hits.jsonl", encoding="utf-8"):
    r = json.loads(l)
    if r["theme"] in rows and r["cite"].startswith("P") and len(r["text"]) >= 40:
        rows[r["theme"]].append(r)
for t in THEMES:
    pool = rows[t]; s = pool[:]; random.Random(20261012).shuffle(s); s = s[:40]
    ids = [r["cite"] for r in s]
    old = re.findall(r"^\[(P\d+#\d+)\]", open(f"read/{t}.txt", encoding="utf-8").read(), re.M)
    print(t, len(pool), "same" if ids == old else "DIFFERENT")
