"""Full-corpus screen for privacy and deletion (topic 9). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'PRIVACY': r"privacy|personal (data|information|info)|data (collection|harvest\w*|mining)|sell\w* (my|your|our|user) (data|info\w*)|third.part(y|ies)|spyware|tracking (me|users|you)",
 'DELETE_ACCOUNT': r"delet\w* (my |the |your )?(account|profile|all (my )?data|my data)|(can.?t|cannot|no way to|unable to|how (do|can) i) (delete|remove|close) (my |the )?(account|data|profile)",
 'EMAIL_SPAM': r"(spam\w*|marketing|promotional|constant|daily) e.?mails?|e.?mails? (me )?(every|constantly|daily)|unsubscrib\w*",
 'PERMISSIONS': r"(asks?|asking|requires?|wants?|need\w*) (for )?(access to |permission (to|for) )?(my )?(location|contacts|microphone|camera|photos|phone number|sms|call logs?)\b|too many permissions|unnecessary permissions",
 'ADS_TRACKING': r"(ad|ads|advert\w*) (tracking|trackers|network)|track\w* across|app tracking transparency|personali[sz]ed ads",
 'NO_ACCOUNT': r"(no|without|don.?t need|doesn.?t require|not requir\w*|no need (for|to)) (an? )?(account|sign.?up|sign.?in|login|log.?in|registration|email)|(local|offline)(ly)? (only|stored|storage)|data stays on",
 'APP_LOCK': r"(pass ?code|pin code|password protect\w*|face ?id|touch ?id|fingerprint|biometric|app lock|lock the app)",
 'SENSITIVE': r"(private|sensitive|personal|embarrass\w*)\b.{0,30}\b(habits?|journal|entries|mood|sobriety|addiction|health)|(someone|people|others|partner|parents?) (could|can|might) see",
 'LEGAL': r"\bgdpr\b|\bccpa\b|\bdsgvo\b|data protection|\bico\b|terms of (service|use)\b.{0,30}\b(data|privacy)",
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
