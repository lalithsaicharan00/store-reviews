"""Counts how habit-app reviewers name each kind of habit (App Store + Play habit corpora)."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
T = {
 'BINARY': {
   'yes/no': r"\byes ?(/|or) ?no\b", 'check off': r"\bcheck(ing|ed)? (it |them |things |habits? |tasks? )?off\b|\bcheck-?off\b",
   'tick off': r"\btick(ing|ed)? (it |them |things |habits? |tasks? )?off\b", 'checkbox': r"\bcheck ?box(es)?\b",
   'mark as done/complete': r"\bmark(ed|ing)? (it |them |habits? |tasks? )?(as )?(done|complete[d]?)\b",
   'done or not': r"\bdone or not\b|\bdid (it )?or (didn.?t|not)\b", 'binary': r"\bbinary\b", 'simple habits': r"\bsimple habits?\b",
 },
 'AMOUNT': {
   'count / counter': r"\bcount(er|ers|ing)? (habits?|feature|type|option)\b|\bcounters?\b", 'quantity': r"\bquantit(y|ies|ative)\b",
   'measurable': r"\bmeasurable\b", 'numeric / number habits': r"\bnumeric(al)?\b|\bnumber habits?\b", 'amount': r"\bamounts?\b",
   'units': r"\bunits?\b", 'target / goal amount': r"\b(daily )?target\b", 'track how many/much': r"\btrack(ing)? how (many|much)\b",
 },
 'TIME': {'timer': r"\btimers?\b", 'timed': r"\btimed\b", 'duration': r"\bdurations?\b", 'minutes': r"\bminutes\b"},
 'CHECKLIST': {'checklist': r"\bcheck ?lists?\b", 'subtasks': r"\bsub[- ]?tasks?\b", 'steps': r"\bsteps (in|of|within|inside)\b", 'sub-habits': r"\bsub[- ]?habits?\b"},
 'LIMIT': {'limit': r"\b(daily |a )?limit (habits?|goals?|of)\b|\blimit (my|how much|the number)\b", 'cut back': r"\bcut(ting)? back\b",
   'cut down': r"\bcut(ting)? down\b", 'reduce': r"\breduc(e|ing)\b", 'less / fewer': r"\b(drink|eat|smoke|spend) less\b|\bfewer\b",
   'bad habits': r"\bbad habits?\b", 'negative habits': r"\bnegative habits?\b", 'avoid': r"\bavoid(ing)? (habits?|things)\b"},
 'QUIT': {'quit': r"\bquit(ting)?\b", 'stop': r"\bstop(ping)? (smoking|drinking|vaping|biting)\b", 'break a habit': r"\bbreak(ing)? (a |bad |my )?habits?\b",
   'sober / sobriety': r"\bsober|sobriety\b", 'days since': r"\bdays since\b", 'abstain / clean': r"\babstain|\bclean (for|streak)\b", 'relapse': r"\brelaps"},
 'ONEOFF': {'to-do / todo': r"\bto-?dos?\b|\btodo list\b", 'one-off': r"\bone[- ]off\b", 'one-time': r"\bone[- ]time (task|event|thing|reminder)s?\b",
   'task(s)': r"\btasks?\b", 'reminder(s)': r"\breminders?\b", 'errand(s)': r"\berrands?\b", 'chores': r"\bchores?\b"},
}
C = {g: {k: re.compile(v, re.I) for k, v in d.items()} for g, d in T.items()}
cnt = {g: collections.Counter() for g in T}; apps = {g: collections.defaultdict(set) for g in T}; ex = collections.defaultdict(list)
n = 0
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); t = ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or ''))
            if not re.search(r'[a-z]', t): continue
            n += 1
            for g, d2 in C.items():
                for k, rx in d2.items():
                    mm = rx.search(t)
                    if mm:
                        cnt[g][k] += 1; apps[g][k].add(f'{store}{m.group(1)}')
                        if len(ex[(g, k)]) < 3 and len(t) < 260: ex[(g, k)].append((f'{store}{m.group(1)}#{i}', t.strip()[:200]))
print('habit-app reviews with Latin text:', n)
for g in T:
    print(f'\n== {g}')
    for k, v in cnt[g].most_common():
        print(f'  {k:26}{v:7}{len(apps[g][k]):5} apps')
json.dump({f'{g}|{k}': v for (g, k), v in ex.items()}, open('examples.json', 'w'), ensure_ascii=False, indent=1)
