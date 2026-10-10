"""Writes the review index from codes.py and watch_app.json (Research/Temp/watch/, made by watch_scan.py).
Run from this folder: python3 make_index.py ../../../Temp/watch/watch_app.json"""
import json, sys
exec(open('codes.py').read())
d = json.load(open(sys.argv[1]))
assert len(CODES) == len(d) and set(CODES) == set(range(len(d))), "every review coded exactly once"
names = [('W','wants a Watch app (the app has none, or the person can\'t find it)'),('P','praises the Watch app'),('L','logging from the wrist is the point'),('O','works without the phone, or wants to'),('C','complication / watch-face widget'),('V','glance: progress or a count on the watch face'),('S','Watch and iPhone fall out of sync, slowly or never'),('B','Watch app broken: won\'t open, blank, loads for ever, crashes, gone after an update'),('X','Watch app incomplete: habit types, actions or screens missing'),('U','slow or awkward on the Watch'),('R','reminders on the Watch'),('T','timer on the Watch'),('A','amounts and numbers on the Watch'),('Q','a routine or timer on the Watch and the iPhone falls out of step'),('D','counted twice / duplicates'),('Z','data lost through the Watch'),('Y','can\'t undo / accidental tap on the Watch'),('M','the same gesture does different things on Watch and iPhone'),('J','the Watch shows or logs the wrong day'),('G','sign-in needed on the Watch'),('I','adding a new item (voice) on the Watch'),('K','a Watch timer recorded as exercise in Activity'),('$','paid for the Watch, or would pay'),('F','objects to the Watch being paid'),('H','Health data only, not the Watch app'),('N','not about a Watch app')]
out = ["# Apple Watch — Review Index", "",
 "Written by Claude (Claude Code), 10 October 2026. Companion to [Apple Watch App — What People Want, What Breaks, and How Ours Works](<../Apple Watch App — What People Want, What Breaks, and How Ours Works.md>).",
 f"Every App Store review naming a watch ({len(d):,}, from 337,331 reviews of 74 habit and routine apps), read one by one and coded by hand. Each entry: app, stars, review ID. A review can carry several codes. The map is `codes.py` (keyed by reading-list row); `make_index.py` checks every review was coded exactly once.", ""]
for c, label in names:
    ids = [i for i in sorted(CODES) if c in CODES[i]]
    out += [f"## {c} — {label} ({len(ids)})", "", "; ".join(f"{d[i]['app']} {d[i]['rating']}★ `{d[i]['id']}`" for i in ids), ""]
open('Apple Watch — Review Index.md', 'w').write("\n".join(out))
print("ok", len(d))
