"""Full-corpus screen for phone migration topics (topic 4). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'MOVE_TOOL': r"move to ios|switch to android|smart ?switch|quick ?start|phone clone|mi mover|google one back ?up|transfer (tool|app)|data transfer",
 'NEW_PHONE_OK': r"(new|another|switched|changed|upgraded)\w* (phone|iphone|device|android|samsung|pixel)\b.{0,80}\b(everything|all (my )?(data|habits|progress|history|streaks?)|it)\b.{0,30}\b(was there|came (over|across|with)|transferred|restored|synced|carried over|still there|worked|seamless)",
 'NEW_PHONE_LOSS': r"(new|another|switched|changed|upgraded|replaced|broke|lost|stolen)\w* (my )?(phone|iphone|device|android|samsung|pixel|mobile|handy|celular|telefone|téléphone)\b.{0,100}\b(lost|gone|disappear\w*|start(ed)? (over|again|from scratch)|no (way|option) to (transfer|restore)|can.?t (transfer|restore|recover|get)|couldn.?t (transfer|restore|recover))",
 'XOS_SWITCH': r"(from|switched|moved|moving|changed|went|switching) (from )?(android|samsung|google pixel|iphone|ios|apple)\b.{0,15}\b(to|for) (an? )?(iphone|ios|apple|android|samsung|pixel)",
 'TRANSFER_REQ': r"(way|option|how|feature|able|ability) to (transfer|move|migrate|carry over)\b.{0,40}\b(data|habits|progress|history|account|streak|everything|to (my |a |the )?new)",
 'OLD_PHONE_GONE': r"(old|previous) (phone|device|iphone)\b.{0,50}\b(broke|broken|died|dead|lost|stolen|sold|traded|reset|wiped|gave)",
 'QR_TRANSFER': r"\bqr\b.{0,40}\b(code|scan|transfer|link|device)|scan\w* (a |the )?(code|qr)\b.{0,40}\b(phone|device|transfer|link)",
 'ML_NEWPHONE': r"(nuevo|nuevo celular|cambi[eé] de (celular|tel[eé]fono|m[oó]vil)|troquei de (celular|telefone|aparelho)|celular novo|neues (handy|telefon|smartphone)|handy gewechselt|nouveau (t[eé]l[eé]phone|portable)|chang[eé] de t[eé]l[eé]phone|nuovo (telefono|cellulare)|cambiato telefono|новый телефон|сменил телефон|поменял телефон|機種変|新しい(iphone|スマホ)|换手机|換手機|新手机|기기 ?변경|폰 ?바꾸|새 (폰|핸드폰)|yeni telefon|telefon değiştir|hp baru|ganti hp)",
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
