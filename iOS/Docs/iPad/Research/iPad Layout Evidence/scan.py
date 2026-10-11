"""iPad layout research (Current Work 86): every review that mentions the iPad, a tablet, or a big-screen layout word
(landscape, Split View, Slide Over, Stage Manager, multitasking, keyboard shortcuts, Pencil). Writes candidates.jsonl
and stats.txt next to this file. Run: python -I scan.py"""
import json, re, glob, os, collections

ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../../../../Research'))
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
    'IPAD': r"\bi-?pads?\b|ipados|アイパッド|아이패드|айпад",
    'TABLET': r"\btablets?\b|\btableta|\btablette|タブレット|태블릿|планшет|平板",
    'LAYOUT': r"landscape|split.?view|slide.?over|stage manager|multi.?task|keyboard shortcut|magic keyboard|"
              r"apple pencil|bigger screen|larger screen|big screen|horizontal (mode|view|orientation)|querformat|"
              r"mode paysage|en paysage|modo horizontal|横向き|横画面|横屏|가로 ?모드|альбомн",
}
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, total = [], collections.Counter(), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/\\')))
        if not m or not os.path.exists(d + 'reviews.jsonl'):
            continue
        app = os.path.basename(d.rstrip('/\\'))
        for i, line in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not line.strip():
                continue
            r = json.loads(line)
            total[store] += 1
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes:
                continue
            for k in modes:
                stats[(store, k)] += 1
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app,
                          'review_id': r.get('review_id'), 'rating': r.get('rating'),
                          'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'text': t})
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands:
        f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{OUT}/stats.txt', 'w', encoding='utf-8') as f:
    f.write(f"screened {dict(total)}; candidates {len(cands)}\n")
    for (s, k), n in sorted(stats.items()):
        f.write(f"{s} {k}: {n}\n")
print(open(f'{OUT}/stats.txt', encoding='utf-8').read())
