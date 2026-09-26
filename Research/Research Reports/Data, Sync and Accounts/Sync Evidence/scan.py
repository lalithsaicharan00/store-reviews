"""Full-corpus screen for sync engine topics (topic 5). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'SYNC_CONFLICT': r"\bsync\w*\b.{0,60}\b(undo|uncheck\w*|revert\w*|went back|overwr\w*|duplicat\w*|double\w*|disappear\w*|reappear\w*|came back|older|wrong)",
 'DUPLICATES': r"duplicat\w* (habits?|entries|checks?|tasks?|logs?|items?)|(habits?|entries|tasks?|items?) (were |got |are )?(duplicated|doubled|appear(ed)? twice)",
 'DELETED_BACK': r"(deleted|removed)\b.{0,40}\b(came back|reappear\w*|back again|keeps? coming back|still (there|shows?|showing))",
 'TIMEZONE': r"time ?zone|daylight saving|\bdst\b|(travel\w*|trip|flew|flight)\b.{0,60}\b(streak|habit|day|date|check)",
 'DAY_BOUNDARY': r"midnight|(after|past) 12 ?(am)?|day (starts?|ends?|resets?|rollover|changes?)|night shift|start of (the )?day|end of (the )?day\b.{0,40}\b(reset|streak|count)",
 'STREAK_CALC': r"streak\w*\b.{0,60}\b(wrong|incorrect|reset\w*|broke|broken|miscount\w*|off by|doesn.?t match|not match\w*|lost)\b",
 'EDIT_HISTORY': r"(chang|edit|modif|updat)\w* (the |a |my )?(habit|goal|frequency|schedule|target|reminder)\w*\b.{0,80}\b(history|past|previous|old|stats|streak|data|progress)\b.{0,40}\b(lost|gone|reset|changed|deleted|wrong|affected|erased)",
 'BACKFILL': r"(can.?t|cannot|unable to|no way to|won.?t let me|doesn.?t let me) (go back|edit|change|mark|check( off)?|log|fill in|update)\b.{0,40}\b(yesterday|previous|past|earlier|missed)",
 'COUNT_DOUBLE': r"(count|counted|logged|recorded|added)\w* (twice|double|two times)|double[- ]count\w*",
 'WEEK_START': r"week (starts?|start day|begins?) (on )?(monday|sunday|saturday)|(start|first day) of (the )?week",
 'RECURRING': r"(repeat\w*|recurring|recurrence)\b.{0,60}\b(wrong|broken|bug|doesn.?t|not working|disappear\w*|skip\w*)",
 'SYNC_SLOW': r"\bsync\w*\b.{0,30}\b(slow|takes (forever|long|minutes|hours)|delay\w*|lag\w*)",
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
