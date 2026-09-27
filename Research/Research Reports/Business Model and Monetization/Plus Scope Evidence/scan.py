"""Full-corpus screen for the Plus scope question: why payers say they paid (lifetime vs features), and how users
react when iPad, Watch or multi-device use is paid-only. Writes candidates.jsonl (Temp/plus-scope) and reasons.txt."""
import json, re, glob, os, collections
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
OUT = os.path.join(ROOT, 'Temp', 'plus-scope'); os.makedirs(OUT, exist_ok=True)
I = re.I
STRICT = re.compile(r"\bi (have )?(paid|bought|purchased|subscribed|upgraded)|\bi'?m a (paying|premium|pro|plus|lifetime)|\bi have (the )?(premium|pro|plus|lifetime|paid)|\bpaid (for|user|version|member)|lifetime (member|purchase|license|licence|access|subscription)|\bpaying (user|customer|member)|premium (user|member)|買い切り|購入しました|課金しました|买了|购买了|已购买|付费了|결제했|구매했|ich habe .{0,20}(gekauft|bezahlt)|j'ai (payé|acheté)|compré|paguei|comprei|купил|оплатил", I)
REASON = {
 'LIFETIME': r"lifetime|one.?time|once and for all|no subscription|not a subscription|without (a )?subscription|pay once|single purchase|買い切り|一次性|买断|永久|평생|einmalig|une seule fois|pago único|única vez|навсегда|разов",
 'SYNC_DEVICES': r"\bsync|all (my )?devices|ipad|\bmac\b|multiple devices|across devices|同期|同步|동기화",
 'UNLIMITED_HABITS': r"unlimited|more (than \d+ )?habits|habit limit|more than (3|4|5|6) habits|无限|無制限",
 'WIDGETS': r"widget",
 'WATCH': r"\bwatch\b|wear ?os|apple watch",
 'THEMES': r"\btheme|colou?rs?|icons?\b|dark mode",
 'STATS': r"stat(istic)?s|analytics|charts?|report",
 'SUPPORT_DEV': r"support (the )?(dev|developer|creator|team)|deserve|worth (every|the) (penny|money)|happy to pay",
 'BACKUP': r"back ?up|backup",
}
REASON = {k: re.compile(v, I) for k, v in REASON.items()}
IPAD = r"(\bipad|아이패드|アイパッド|айпад|\btablet|タブレット|平板|태블릿)"
PAYW = r"(premium|\bpro\b|paid|pay|purchase|subscri|paywall|lock|plus|unlock|課金|有料|付费|会员|유료|결제|bezahl|kostenpflichtig|payant|pagar|pago|плат)"
WATCH = r"(apple watch|\bwatch app|\biwatch|wear ?os|galaxy watch|smartwatch|워치|ウォッチ|手表)"
MODES = {
 'IPAD_PAYWALL': re.compile(rf"{IPAD}.{{0,80}}{PAYW}|{PAYW}.{{0,80}}{IPAD}", I),
 'WATCH_PAYWALL': re.compile(rf"{WATCH}.{{0,80}}{PAYW}|{PAYW}.{{0,80}}{WATCH}", I),
}
payers, reason_n, cands = 0, collections.Counter(), []
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l)
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            paid = bool(STRICT.search(t))
            if paid:
                payers += 1
                for k, rx in REASON.items():
                    if rx.search(t): reason_n[k] += 1
            modes = [k for k, rx in MODES.items() if rx.search(t)]
            if paid and r.get('rating', 0) >= 4 and REASON['LIFETIME'].search(t): modes.append('PAYER_LIFETIME_POS')
            if not modes: continue
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': r.get('rating'), 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'paid': paid, 'text': t})
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
mc = collections.Counter(m for c in cands for m in c['modes'])
out = [f"reviews saying they paid (strict pattern): {payers}", "reason words co-occurring in those reviews (a review can count in several):"]
out += [f"  {k:18}{v:6}  {100*v/payers:5.1f}%" for k, v in reason_n.most_common()]
out += ["", "candidate modes: " + ', '.join(f'{k} {v}' for k, v in mc.items())]
open(f'{HERE}/reasons.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
