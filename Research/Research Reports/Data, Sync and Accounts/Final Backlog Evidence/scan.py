"""Screen for the final backlog questions: (1) moving data iPhone <-> Android and phone-to-phone transfer praise;
(2) Apple Health / Health Connect / Google Fit mentions. Writes candidates to Temp/final-backlog and counts."""
import json, re, glob, os, collections
HERE = os.path.dirname(os.path.abspath(__file__)); ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
OUT = os.path.join(ROOT, 'Temp', 'final-backlog'); os.makedirs(OUT, exist_ok=True)
I = re.I
IOS = r"(iphone|ios|apple)"; AND = r"(android|samsung|galaxy|pixel|google phone)"
SW = r"(switch|switched|switching|move|moved|moving|went|changed|chang(e|ing)|transfer\w*|migrat\w*|convert\w*)"
M = {
 'XOS_MOVE': re.compile(rf"{SW}.{{0,40}}(from )?{IOS}.{{0,25}}(to|→|->).{{0,15}}{AND}|{SW}.{{0,40}}(from )?{AND}.{{0,25}}(to|→|->).{{0,15}}{IOS}|(安卓|アンドロイド|안드로이드).{{0,20}}(苹果|iphone|アイフォン|아이폰)|(苹果|iphone|アイフォン|아이폰).{{0,20}}(安卓|アンドロイド|안드로이드)", I),
 'TRANSFER_PRAISE': re.compile(r"(transfer\w*|mov(ed|ing)|cop(y|ied)|migrat\w*).{0,40}(seamless\w*|easy|easily|smooth\w*|painless|flawless\w*|perfect\w*|in seconds|in a minute|without (any )?(hitch|problem|issue))|(qr code|bluetooth|nearby share).{0,40}(transfer|move|cop(y|ied)|migrat)", I),
 'HEALTH': re.compile(r"apple health|health ?kit|\bhealth app\b|health connect|google fit|samsung health|healthkit|ヘルスケア|건강 앱|健康app|健康应用|zdrowie app|app (salud|santé|saúde|gesundheit)", I),
}
PAID = re.compile(r"\bi (have )?(paid|bought|purchased|subscribed|upgraded)|\bi'?m a (paying|premium|pro|plus|lifetime)|\bi have (the )?(premium|pro|plus|lifetime|paid)|\bpaid (for|user|version|member)|lifetime (member|purchase|license|licence|access|subscription)|\bpaying (user|customer|member)|premium (user|member)|買い切り|購入しました|課金しました|买了|购买了|已购买|付费了|결제했|구매했|ich habe .{0,20}(gekauft|bezahlt)|j'ai (payé|acheté)|compré|paguei|comprei|купил|оплатил", I)
cands, stats, total, rt = [], collections.defaultdict(collections.Counter), 0, collections.Counter()
per_app = collections.defaultdict(collections.Counter)
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); total += 1
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes: continue
            paid = bool(PAID.search(t))
            for k in modes:
                stats[k]['n'] += 1; stats[k]['paid'] += paid; stats[k][f"r{r.get('rating')}"] += 1
                per_app[k][app] += 1
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': r.get('rating'), 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'paid': paid, 'text': t})
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
out = [f'screened {total} App Store + Play reviews']
for k, c in stats.items():
    n = c['n']; mean = sum(int(x[1:]) * v for x, v in c.items() if x.startswith('r') and x[1:].isdigit()) / n
    out.append(f"{k:16} n={n:5} apps={len(per_app[k]):3} per10k={1e4*n/total:5.1f} mean={mean:.2f} say-paid={100*c['paid']/n:4.1f}%  top apps: " +
               ', '.join(f'{a[:22]} {v}' for a, v in per_app[k].most_common(4)))
open(f'{HERE}/mode-stats.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
