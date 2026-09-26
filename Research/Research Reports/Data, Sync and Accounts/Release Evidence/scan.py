"""Full-corpus screen for release safety (topic 8). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'UPDATE_WIPED': r"(update|updated|updating|new version)\b.{0,60}\b(lost|deleted|wiped|erased|gone|reset|disappeared|vanished)\b.{0,40}\b(data|habits?|progress|history|streaks?|everything|all)",
 'UPDATE_CRASH': r"(since|after) (the |this |last |latest |recent )?(update|new version)\b.{0,60}\b(crash\w*|won.?t open|doesn.?t open|can.?t open|freez\w*|black screen|white screen|unusable|stopped working)",
 'CRASH_LOOP': r"(crash\w*|closes) (on|at|upon|when i|every time i|immediately (on|after|when)) (launch|open\w*|start\w*)|won.?t (even )?(open|load|launch)\b|(can.?t|cannot) (even )?open (the|this|it)",
 'OS_UPDATE_BREAK': r"(ios|android|os|iphone|phone) (update|upgrade)\b.{0,50}\b(broke|broken|stopped|crash\w*|not working|doesn.?t work)|(ios|android) ?\d+(\.\d+)?\b.{0,40}\b(broke|crash\w*|not working|doesn.?t work)",
 'ROLLBACK_WANT': r"(go|going|roll|revert|switch) back to (the )?(old|previous|older|last) (version|design|layout|ui|app)|bring back (the )?(old|previous)|downgrade (to|the app)",
 'REDESIGN': r"(new|latest|recent) (design|ui|layout|interface|look|redesign)\b.{0,60}\b(hate|worse|terrible|awful|confus\w*|ruin\w*|bad|horrible)|redesign\w*\b.{0,40}\b(ruin\w*|worse|hate)",
 'FORCED_UPDATE': r"(forced|force[sd]?|have|had|must|required|requires) (me )?to update|update (is )?required|no longer supports? (my|older|ios|android)|older (phone|device|ios|version)s?\b.{0,30}\b(not supported|can.?t|won.?t)",
 'SUPPORT_NONE': r"(no|never (got|received|heard)|without) (any )?(response|reply|answer)|(emailed|contacted|wrote to|messaged) (them|support|the dev\w*)\b.{0,60}\b(no (response|reply|answer)|nothing|ignored|never)",
 'SUPPORT_GOOD': r"(support|developer|dev|team)\w*\b.{0,40}\b(responded|replied|fixed it|got back to me|helped me|quick(ly)? (response|reply|fix))",
 'COMMS': r"(no|without|zero) (warning|notice|announcement|communication|heads.?up|explanation)|(didn.?t|did not|never) (warn|tell|notify|inform) (us|me|users)",
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
