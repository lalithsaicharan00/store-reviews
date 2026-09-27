"""App-level view: group apps by the free cap their reviewers name most often, and compare rating, cap-complaint
rate and the share of reviews saying they paid. Reads app-caps.txt (written by scan.py); writes app-buckets.txt.
Apps are assigned when one number is at least half of all cap numbers named and named 10+ times. Excluded by hand:
Hevy (gym routines), Streaks (a paid app whose cap is a design choice), Habit - Daily routine tracker (one goal by
design), Fabulous (habits per routine, not per app). Free-and-unlimited apps are listed by hand from UNLIMITED praise."""
import re, os, ast, collections
HERE = os.path.dirname(os.path.abspath(__file__))
EXCLUDE = {'P122', 'A23', 'A70', 'P12', 'A24'}
UNLIMITED = {'P3', 'P19', 'A69', 'A8', 'P101', 'P65', 'A29', 'P106'}
groups = collections.defaultdict(list)
for line in open(f'{HERE}/app-caps.txt', encoding='utf-8').read().splitlines()[1:]:
    m = re.match(r'(\S+)\s+(.{34})\s+(\d+)\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)\s+(\{.*?\})\s+(\d+)\s+(\d+)\s+(\d+)', line)
    if not m: continue
    k, name, n, mean, paid, cap10k, caps = m.group(1), m.group(2).strip(), int(m.group(3)), float(m.group(4)), float(m.group(5)), float(m.group(6)), ast.literal_eval(m.group(7))
    if k in EXCLUDE: continue
    if k in UNLIMITED: b = 'unlimited'
    else:
        tot = sum(caps.values())
        if not caps: continue
        top, c = max(caps.items(), key=lambda x: x[1])
        if c < 10 or c / tot < 0.5: continue
        b = '1' if top == 1 else '2' if top == 2 else '3' if top == 3 else '4' if top == 4 else '5' if top == 5 else '6-8' if top <= 8 else '10+'
    groups[b].append((k, name, n, mean, paid, cap10k))
out = ['free cap | apps | reviews | mean ★ (review-weighted) | cap mentions per 10k | say they paid % | apps']
for b in ['1', '2', '3', '4', '5', '6-8', '10+', 'unlimited']:
    g = groups.get(b)
    if not g: continue
    N = sum(x[2] for x in g)
    w = lambda i: sum(x[i] * x[2] for x in g) / N
    out.append(f"{b} | {len(g)} | {N} | {w(3):.2f} | {w(5):.0f} | {w(4):.2f} | " + ', '.join(f'{x[0]} {x[1][:18]}' for x in g))
open(f'{HERE}/app-buckets.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
