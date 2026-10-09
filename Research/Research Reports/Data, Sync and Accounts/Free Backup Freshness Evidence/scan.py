"""Current Work 75 (9 Oct 2026): how fresh must a free account's backup be? Full-corpus screen for (1) restores that
came back missing the recent part, (2) complaints about backup frequency / wishes for real-time saving, (3) people who
had an account or backup and still lost data. Writes candidates.jsonl and stats.txt here; every match is read by hand."""
import json, re, glob, os, collections
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
I = re.I
N = r"(\d+|one|two|three|four|five|six|seven|few|couple(?: of)?|several|a)"
U = r"(days?|weeks?|months?|hours?|nights?)"
BK = r"(back ?-?ups?|backed up|backing up|sync\w*|cloud|restor\w*|icloud|google drive|account)"
M = {
 # restored / synced, but the recent part was missing
 'RECENT_MISSING': rf"(lost|lose|losing|missing|gone|wiped|erased|disappeared)\b.{{0,25}}(the |my )?(last|past|previous|recent|latest) {N} {U}"
                   rf"|(lost|missing|gone|disappeared)\b.{{0,30}}\b(yesterday'?s?|today'?s|the last day|last night'?s?|this week'?s)\b.{{0,20}}(data|progress|entries|check.?ins|logs|records|habits|ticks)?"
                   rf"|{BK}.{{0,40}}\b(was|is|were|only)\b.{{0,15}}(old|outdated|out of date|stale|not (up to date|current|the latest|recent))"
                   rf"|(restored|came back|got back|recovered|brought back)\b.{{0,40}}(from|up to|until|as of) .{{0,15}}({N} {U} ago|last (week|month)|(a|an) (old|older|earlier) (version|backup|copy))"
                   rf"|(restored|restore|backup)\b.{{0,60}}\bbut\b.{{0,60}}(missing|without) (the |my )?(last|recent|latest|newest)"
                   rf"|(lost|lose|losing|missing|wiped)\b.{{0,10}}\b{N} {U}'?s?( worth)? of (data|progress|entries|tracking|habits|check.?ins|logs|records|streaks?)"
                   rf"|(lost|missing|gone)\b.{{0,20}}\beverything (since|after|from) (the |my )?(last|yesterday|\d)"
                   rf"|(went|rolled|reverted|jumped) back (to|by) .{{0,20}}({N} {U}|yesterday|last (week|month)|an? (old|earlier) (version|state|backup))",
 # how often backup runs: too rarely, or wants it to save as it goes
 'FREQUENCY': rf"(back ?-?ups?|backs? up|sync\w*)\b.{{0,40}}\b(only )?(once (a|per) (day|week)|every (day|night|week|{N} (hours|days))|daily|nightly|weekly)\b.{{0,60}}(not enough|isn'?t enough|too (rare|infrequent|slow)|should|wish|lost|missing|instead)"
              rf"|(real.?time|instant\w*|immediate\w*|continuous\w*|every (change|time|entry|edit)|automatically)\b.{{0,20}}(back ?-?up|sav\w+|sync\w*) .{{0,25}}(cloud|server|account|online)"
              rf"|(not|isn'?t|aren'?t|wasn'?t|doesn'?t) (frequent|often) enough",
 # had an account / backup / sync and still lost data: what people assume an account means
 'ACCOUNT_STILL_LOST': rf"(made|created|have|had|signed up for|registered|logged in with|log in with|login with|sign(ed)? in with) (an |my |a )?(account|login|e-?mail|google|apple id)\b.{{0,120}}(lost|gone|nothing (was|is) there|empty|didn'?t (restore|sync|save|come back)|wasn'?t (saved|backed up)|not (saved|backed up|synced))"
                       rf"|(thought|assumed|believed|expected) .{{0,40}}(was|were|would be|is) (saved|backed up|synced|safe|in the cloud|stored)",
}
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
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
            rt = r.get('rating')
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': rt, 'date': (r.get('date') or '')[:10], 'modes': modes, 'text': t})
            for k in modes:
                stats[k][rt] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}')
with open(f'{HERE}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
lines = [f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}"]
for k in M:
    c = stats[k]; n = c['A'] + c['P']
    if n: lines.append(f"{k:20}{n:7}{len(apps[k]):6} A{c['A']:6} P{c['P']:6} mean {sum(c[s]*s for s in range(1,6))/n:.2f}")
open(f'{HERE}/stats.txt', 'w').write('\n'.join(lines) + '\n')
print('\n'.join(lines))
