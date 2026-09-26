"""Full-corpus screen for other surfaces (topic 7). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'WATCH': r"(apple ?watch|wear ?os|galaxy watch|smart ?watch|pixel watch|fitbit|garmin|watch app|watch version|on (my|the) watch)",
 'COMPLICATION': r"complication",
 'WIDGET': r"widget",
 'LOCK_LIVE': r"lock ?screen|live activit|dynamic island|always.on display",
 'NOTIF_ACTION': r"(from|in|via|on) (the )?notification\w*\b.{0,40}\b(mark|check|tick|complete|done|log)|(mark|check|tick|complete|log)\w*\b.{0,40}\b(from|in|via) (the )?notification",
 'SHORTCUTS': r"\bsiri\b|shortcuts? app|\bshortcuts?\b.{0,20}\b(action|automation|support)|google assistant|\balexa\b",
 'WEB': r"web ?(version|app|site|browser|interface)|website|(in|from|on) (a |the |my )?browser|online version",
 'DESKTOP': r"\b(mac|macbook|macos|windows|desktop|pc|laptop|computer)\b.{0,40}\b(app|version|client|sync|use|access)|(app|version|client) for (mac|windows|desktop|pc)",
 'TABLET': r"\bipad\b|\btablet\b|landscape",
}
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); total[store] += 1
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes: continue
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': r.get('rating'), 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'text': t})
            for k in modes:
                stats[k][r.get('rating')] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}')
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{OUT}/mode-stats.txt', 'w') as f:
    f.write(f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}\n\n{'mode':20}{'n':>6}{'apps':>5}{'A':>6}{'P':>6}{'N':>6}{'1★%':>6}{'mean':>6}\n")
    for k in sorted(stats, key=lambda k: -sum(stats[k][s] for s in 'APN')):
        c = stats[k]; n = sum(c[s] for s in 'APN'); mean = sum(c[s]*s for s in range(1, 6))/n
        f.write(f"{k:20}{n:6}{len(apps[k]):5}{c['A']:6}{c['P']:6}{c['N']:6}{100*c[1]/n:6.1f}{mean:6.2f}\n")
print(open(f'{OUT}/mode-stats.txt').read())
