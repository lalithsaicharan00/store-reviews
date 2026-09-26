"""Full-corpus screen for server topics (topic 6). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'OUTAGE': r"server\w*\b.{0,30}\b(down|outage|offline|not (responding|working|available)|unavailable|error|issue|problem|crash\w*)|(can.?t|cannot|unable to|could not|couldn.?t) (connect|reach) (to )?(the )?server|(service|app) (was |is )?down (for|all)|outage",
 'NET_REQUIRED': r"(requires?|needs?|need) (an? )?(internet|wifi|wi-fi|data|connection|online)|(doesn.?t|won.?t|does not|can.?t|cannot) (work|open|load|use it) (without|offline|when offline)|no internet\b.{0,40}\b(can.?t|won.?t|nothing|error)",
 'LOADING': r"(loading|spinning|spinner|stuck on)\b.{0,30}\b(forever|minutes|always|every time|screen)|takes? (forever|ages|too long) to (load|open|start|sync)",
 'SHUTDOWN': r"(shut(ting)? down|discontinu\w*|no longer (supported|maintained|available)|end of life|sunset\w*|servers? (were |are )?(turned|shut) off|pulled the plug|went out of business|acquired by)",
 'BREACH': r"(data )?breach|hack(ed|ers?)\b.{0,40}\b(account|data|server)|leak\w* (my |our |user )?(data|emails?|information)|sold (my|our) data",
 'SERVER_MIGRATION': r"(new|migrat\w*|mov\w*|switch\w*) (to (a |the )?)?(new )?(server|backend|database|platform|cloud)\b.{0,60}\b(lost|gone|missing|wiped|reset|broke|deleted)",
 'MAINTENANCE': r"(maintenance|scheduled downtime|under maintenance|service unavailable|error 5\d\d|\b50[234]\b|bad gateway|internal server error)",
 'DATA_RECOVERED': r"(support|team|developer|dev)\w*\b.{0,60}\b(recovered|restored|got (it|my data|everything) back|brought back)",
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
