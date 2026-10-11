"""Validate coded_links.py against the read/link-*.txt files and estimate, per store and feature, how many reviews
(per 10,000 English reviews) say they PAID for it, would pay, or object to it being paid.

Run from Research/:  python -I "../Android/Docs/Research/Android Plus Evidence/tally_links.py"   → link_tally.md
Estimate = (share of the coded sample in a code) × (all matches for that feature). Denominators: English reviews
(Play 336,635 with language "en"; App Store 196,488 English-looking).
"""
import importlib.util, json, os, re
from collections import Counter

R = os.getcwd()
OUT = os.path.join(R, "..", "Android", "Docs", "Research", "Android Plus Evidence")
spec = importlib.util.spec_from_file_location("c", os.path.join(OUT, "coded_links.py"))
c = importlib.util.module_from_spec(spec); spec.loader.exec_module(c)
DEN = {"play": 336635, "app": 196488}
counts = {}
for line in open(os.path.join(OUT, "link_counts.md"), encoding="utf-8"):
    m = re.match(r"\| (\w+) \| (\d+) \| (\d+) \|", line)
    if m:
        counts[("play", m.group(1))] = int(m.group(2)); counts[("app", m.group(1))] = int(m.group(3))

rows = []
for key, codes in c.LINKS.items():
    store, feat = key.split("-")
    shown = re.findall(r"^\[([PA]\d+#\d+)\]", open(os.path.join(OUT, "read", f"link-{key}.txt"), encoding="utf-8").read(), re.M)
    assert sorted(shown) == sorted(codes), (key, set(shown) ^ set(codes))
    n = len(codes)
    cnt = Counter(t for v in codes.values() for t in v.split())
    total = counts[(store, feat)]
    def est(*tags):
        k = sum(cnt[t] for t in tags)
        return k, total * k / n, 10000 * total * k / n / DEN[store]
    rows.append((feat, store, n, total, est("PAIDFOR"), est("PAIDFOR", "PAIDBROKEN", "MISSING"), est("WOULD"),
                 est("WALL"), est("LOSTDEV"), cnt["CROSS"], cnt["FREEPRAISE"]))

L = ["# Payment linked to a feature — hand-coded samples, both stores", "",
     "Per 10k = estimated reviews per 10,000 English reviews of that store. 'Paid for it' = PAIDFOR; 'Paid, incl. broken/missing' adds",
     "PAIDBROKEN and MISSING (they paid with that feature as the reason). 'Objects' = WALL (it shouldn't be paid).", "",
     "| Feature | Store | Coded / matches | Paid for it (n · per 10k) | Paid incl. broken/missing (n · per 10k) | Would pay (n · per 10k) | Objects to paywall (n · per 10k) | Purchase didn't reach a device (n) | Cross-platform (n) | Praise for free/no ads (n) |",
     "|---|---|---|---|---|---|---|---|---|---|"]
for feat, store, n, total, pf, pb, wo, wa, ld, cr, fp in sorted(rows, key=lambda r: (r[0], r[1] != "play")):
    f = lambda e: f"{e[0]} · {e[2]:.1f}"
    L.append(f"| {feat} | {'Play' if store == 'play' else 'App Store'} | {n} / {total} | {f(pf)} | {f(pb)} | {f(wo)} | {f(wa)} | {ld[0]} | {cr} | {fp} |")
open(os.path.join(OUT, "link_tally.md"), "w", encoding="utf-8").write("\n".join(L) + "\n")
print("\n".join(L))
