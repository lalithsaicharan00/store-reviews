"""Full-corpus screen for habit creation UX. Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'ONEOFF': r"one[- ]?(off|time) (task|to-?do|item|event|thing)s?|(to-?do|todo)s?\b.{0,40}\b(along|with|and|beside|together)\b.{0,20}\bhabits?|(non|not)[- ]recurring (task|item)|single (task|day) (task|item)|tasks? (that|which) (don.?t|do not) repeat",
 'CHECKLIST': r"check ?lists?\b|sub[- ]?tasks?|sub[- ]?habits?|(steps|items) (inside|within|in) (a|each|the) (habit|routine)",
 'TIMES_DAY': r"(multiple|several|two|three|\d+|many) times (a|per|each) day|twice a day|times? per day|per day (count|goal|target)",
 'FREQ': r"(\d+|x|n|two|three|few) (times|days) (a|per) week|specific days|every other day|every (\d+|two|three|few|n|x) (days|weeks)|(monthly|weekly) habits?|once a (week|month)|certain days",
 'LIMIT': r"(at most|no more than|less than|limit|maximum|cut (back|down)|reduce)\b.{0,40}\b(habit|goal|target|per day|a day|cups?|cigarettes?|drinks?)|bad habits?\b.{0,40}\b(count|limit|track)",
 'CREATE_UX': r"(creat|add|set)\w*( up)? (a |new |my )?(new )?habits?\b.{0,60}\b(confus\w*|complicat\w*|hard|difficult|tedious|annoying|too many|clunky|easy|simple|quick|intuitive|straightforward)",
 'ICON': r"icons?\b.{0,50}\b(choose|pick|select|limited|few|more|search|find|custom|suggest|match|options?|selection|variety)|(choose|pick|select|more|limited|custom)\b.{0,20}\bicons?",
 'UNITS_INPUT': r"(custom|choose|limited|own|different|more) units?|units? (of|like|such as)|(type|enter|input|typing) (in )?(a |the )?(number|amount|value)|number pad|keyboard\b.{0,40}\b(number|dismiss|hide|close|stuck|cover)",
 'REMINDER_EDIT': r"(delete|remove|edit|change|turn off|cancel) (a |the |my )?(reminder|notification) (time|times)?|reminders? (can.?t|cannot|won.?t) be (deleted|removed|changed|edited)|(multiple|several|more than one|second|two) reminders?",
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
