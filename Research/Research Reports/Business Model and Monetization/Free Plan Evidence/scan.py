"""Full-corpus screen for the free-plan design question: does a habit cap convert or drive people away (and who complains),
how widget paywalls land, whether limits shown or hidden on the store listing cause 'I thought it was free' reviews,
and why people switch between apps. Writes Temp/free-plan/candidates.jsonl, mode-stats.txt and app-caps.txt."""
import json, re, glob, os, collections, statistics
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
OUT = os.path.join(ROOT, 'Temp', 'free-plan'); os.makedirs(OUT, exist_ok=True)
I = re.I
STRICT = re.compile(r"\bi (have )?(paid|bought|purchased|subscribed|upgraded)|\bi'?m a (paying|premium|pro|plus|lifetime)|\bi have (the )?(premium|pro|plus|lifetime|paid)|\bpaid (for|user|version|member)|lifetime (member|purchase|license|licence|access|subscription)|\bpaying (user|customer|member)|premium (user|member)|買い切り|購入しました|課金しました|买了|购买了|已购买|付费了|결제했|구매했|ich habe .{0,20}(gekauft|bezahlt)|j'ai (payé|acheté)|compré|paguei|comprei|купил|оплатил", I)
NUMW = {'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9, 'ten': 10, 'twelve': 12}
NUM = r"(\d{1,2}|one|two|three|four|five|six|seven|eight|nine|ten|twelve)"
UNIT = r"(?:habits?|goals?|streaks?|trackers?|routines?|tasks?|categories)"
PAYW = r"(premium|\bpro\b|paid|pay|purchase|subscri|paywall|locked|unlock|upgrade|課金|有料|付费|会员|유료|결제|bezahl|kostenpflichtig|payant|pagar|pago|плат)"
CAP = re.compile(
    rf"(?:limit(?:ed)?(?: (?:to|at|of))?|only(?: (?:allows?|lets? you|let's you|get|have|add|create|make|track))?|max(?:imum)?(?: of)?|up to|cap(?:ped)?(?: at)?|restricted to)\s+(?:(?:you|me|us|to|add|create|have|track|a|the|of)\s+){{0,3}}{NUM}\s+(?:free\s+|daily\s+|different\s+)?{UNIT}"
    rf"|{NUM}\s+(?:free\s+)?{UNIT}\s+(?:limit|max|only|for free|free|in the free|on the free|without (?:paying|premium|pro|subscri))"
    rf"|habit limit|limit (?:of|on) (?:the )?(?:number of )?habits|more than {NUM} {UNIT}"
    rf"|(?:nur|seulement|solo|sólo|apenas|только)\s+{NUM}\s+(?:gewohnheiten|habitudes|hábitos|привыч)|(\d)\s*(?:つ|個)(?:まで|しか)|(\d)\s*개(?:까지|밖에)|(\d)\s*个(?:习惯)?(?:以上|之后)?",
    I)
WIDGET = r"(widget|ウィジェット|위젯|小组件|小部件|виджет)"
MODES = {
 'CAP': CAP,
 'WIDGET_PAY': re.compile(rf"{WIDGET}.{{0,80}}{PAYW}|{PAYW}.{{0,80}}{WIDGET}", I),
 'LISTING_BETRAY': re.compile(
    r"thought (?:it|this|the app) (?:was|would be|is|were) free|(?:says|said|claims?|advertis\w*|listed|shows?) (?:as |to be |it'?s |its |it is |that it'?s )?(?:a )?free|not (?:actually|really|truly|completely) free|isn'?t (?:actually|really|truly) free|so.?called free|false(?:ly)? advertis|(?:misleading|deceptive|bait|bait and switch|clickbait)"
    r"|(?:didn'?t|doesn'?t|does not|did not|never) (?:say|mention|tell|state|disclose|warn)\w*.{0,60}(?:pay|premium|subscri|limit|free|cost)"
    r"|(?:should|could|would be nice to|please) (?:say|mention|state|disclose|warn|tell)\w*.{0,70}(?:description|store|listing|upfront|up front|beginning|before)"
    r"|after (?:i )?(?:download|install)\w*.{0,70}(?:pay|premium|subscri|paywall|limit)|only (?:to )?find out.{0,60}(?:pay|premium|subscri|limit)"
    r"|(?:description|listing|screenshots?|store page|app store page|ad|ads).{0,50}(?:free|pay|premium|limit|subscri)"
    r"|il aurait pu prévenir|pas gratuit|nicht kostenlos|kostenlos.{0,40}(?:aber|doch)|no es gratis|não é grat|无法免费|不是免费|免费.{0,15}(?:骗|假)|無料.{0,20}(?:詐欺|嘘|騙)", I),
 'DISCLOSE_POS': re.compile(r"(?:upfront|up front|up-front|transparent|clear(?:ly)? (?:about|stated?|says)|honest about|straightforward about|(?:description|listing) (?:says|said|states?|clearly|tells)).{0,60}(?:free|pay|premium|limit|price|cost|habits|subscri)", I),
 'SWITCH': re.compile(r"(?:switch(?:ed|ing)?|mov(?:ed|ing)|came|migrat\w+|chang(?:ed|ing)) (?:over )?(?:from|to) (?:\w+ ){0,3}(?:app|tracker|\w+)|better than (?:\w+ ){0,2}(?:app|other|every|all|any|\w+)|compared to|instead of (?:paying|\w+)|(?:tried|used|tested) (?:\d+|many|several|a lot of|lots of|so many|dozens of|a bunch of|countless|every|all the) (?:other )?(?:habit )?(?:apps|trackers)", I),
 'FREE_ENOUGH': re.compile(r"(?:free (?:version|plan|tier|app)|for free|without paying|no need to (?:pay|buy|upgrade)|don'?t (?:need|have) to (?:pay|upgrade|buy)|never (?:needed|had) to (?:pay|upgrade)).{0,80}(?:enough|generous|everything|all (?:i|you) need|plenty|sufficient|great|perfect|love|amazing|awesome|useful|fine)|(?:enough|generous|plenty|sufficient|everything (?:i|you) need).{0,60}(?:free (?:version|plan|tier)|for free|without paying)", I),
 'UNLIMITED': re.compile(r"unlimited (?:habits|free|number of habits|goals|trackers)|no (?:habit |)limits? (?:on|to) (?:the )?(?:number of )?habits|(?:habits|number of habits) (?:is |are )?unlimited|as many habits as", I),
}
def text(r): return ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
def capnum(t):
    ns = []
    for m in CAP.finditer(t):
        for g in m.groups():
            if g:
                g = g.lower(); ns.append(NUMW.get(g) or int(g) if g.isdigit() or g in NUMW else None)
    return [n for n in ns if n]
total, paidn = 0, 0
per_app = collections.defaultdict(lambda: {'n': 0, 'paid': 0, 'r': [], 'caps': collections.Counter(), 'capn': 0, 'unl': 0, 'widgetpay': 0, 'betray': 0})
cands, mstat = [], collections.defaultdict(lambda: {'n': 0, 'paid': 0, 'r': [], 'apps': collections.Counter()})
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/')); akey = f'{store}{m.group(1)}'
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); t = text(r); rt = r.get('rating') or 0
            total += 1; pa = per_app[(akey, app)]; pa['n'] += 1; pa['r'].append(rt)
            paid = bool(STRICT.search(t)); paidn += paid; pa['paid'] += paid
            modes = [k for k, rx in MODES.items() if rx.search(t)]
            if 'FREE_ENOUGH' in modes and rt < 4: modes.remove('FREE_ENOUGH')
            if 'SWITCH' in modes and not re.search(r"free|price|pay|premium|subscri|limit|widget|lifetime|one.?time|habits|cost|ads|sync", t, I): modes.remove('SWITCH')
            if not modes: continue
            if 'CAP' in modes:
                pa['capn'] += 1
                for n in capnum(t): pa['caps'][n] += 1
            pa['unl'] += 'UNLIMITED' in modes; pa['widgetpay'] += 'WIDGET_PAY' in modes; pa['betray'] += 'LISTING_BETRAY' in modes
            for k in modes:
                s = mstat[k]; s['n'] += 1; s['paid'] += paid; s['r'].append(rt); s['apps'][app] += 1
            cands.append({'key': f'{akey}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'), 'rating': rt,
                          'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'), 'modes': modes,
                          'paid': paid, 'capnums': capnum(t) if 'CAP' in modes else [], 'text': t})
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
out = [f'screened {total} App Store + Play reviews; strict "I paid" {paidn} ({100*paidn/total:.2f}%)']
for k, s in sorted(mstat.items(), key=lambda x: -x[1]['n']):
    out.append(f"{k:15} n={s['n']:6} apps={len(s['apps']):3} per10k={1e4*s['n']/total:6.1f} mean={statistics.mean(s['r']):.2f} "
               f"1star={100*sum(1 for x in s['r'] if x == 1)/s['n']:4.1f}% say-paid={100*s['paid']/s['n']:4.1f}%  top: " +
               ', '.join(f'{a[:22]} {v}' for a, v in s['apps'].most_common(4)))
open(f'{HERE}/mode-stats.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
rows = ['app | reviews | mean | say-paid% | cap-mentions/10k | modal cap numbers | unlimited mentions | widget-pay | betray']
for (k, a), p in sorted(per_app.items(), key=lambda x: -x[1]['n']):
    if p['n'] < 300: continue
    rows.append(f"{k:5} {a[:34]:34} {p['n']:6} {statistics.mean(p['r']):.2f} {100*p['paid']/p['n']:5.2f} {1e4*p['capn']/p['n']:6.1f} "
                f"{dict(p['caps'].most_common(3))} {p['unl']} {p['widgetpay']} {p['betray']}")
open(f'{HERE}/app-caps.txt', 'w').write('\n'.join(rows) + '\n')
