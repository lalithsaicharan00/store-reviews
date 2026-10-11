"""Day details on iPad (Current Work 86): reviews of Apple's Reminders and Calendar (and the other native apps) that talk
about how an item's details open — a popover / pop-up / info window / details panel. Run: python -I popover_scan.py"""
import json, re, glob, os
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../../../../Research'))
DET = re.compile(r"pop.?over|pop.?up (window|box|menu)|info (button|window|box|panel|screen)|\(i\)|details? (window|box|panel|pane|view|screen|page|popup|pop-up)|event details|tap(ping)? (on )?(an|the) (event|reminder)", re.I)
IPAD = re.compile(r"\bi-?pads?\b|ipados|tablet", re.I)
out = []
for d in sorted(glob.glob(f'{ROOT}/Native Store Reviews/*/')):
    n = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/\\'))).group(1)
    for i, line in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
        if not line.strip():
            continue
        r = json.loads(line)
        t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
        if DET.search(t):
            out.append((f'N{n}#{i}', r.get('rating'), (r.get('date') or '')[:10], bool(IPAD.search(t)), t))
with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'popover_hits.txt'), 'w', encoding='utf-8') as f:
    for k, rt, dt, ip, t in out:
        f.write(f"{k}\t{rt}\t{dt}\t{'IPAD' if ip else '-'}\t{t[:600]}\n")
print(len(out), sum(1 for o in out if o[3]))
