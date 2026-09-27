"""Reminder-driven placement: evidence scan over every App Store + Play habit corpus."""
import json, re, glob, os, collections
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..'))
P = {
 # people who don't want reminders / notification fatigue
 'no_reminders': r"\b(too many|so many|annoying|constant|endless|spammy|spam) (push )?(notifications|reminders|notifs)\b|\bturn(ed|ing)? off (all )?(the |my )?(notifications|reminders)\b|\b(don'?t|do not|never) (want|need|use|like) (any |the |a )?(reminders?|notifications?)\b|\bwithout (any |a )?(reminders?|notifications?)\b|\bhate (the )?(reminders|notifications)\b",
 # reminder that repeats / nags for the same completion
 'nag': r"\bremind(s)? me again\b|\b(repeat(ing|ed)?|recurring|follow[- ]?up|persistent|nagging|second) (reminders?|notifications?|alerts?)\b|\bkeep(s)? reminding\b|\buntil (i|it'?s|it is|the habit is|i've|i have) (done|complete|completed|checked|marked|mark)\b|\bnag(s|ging)? me\b|\bsnooze\b",
 # several reminders a day
 'multi_reminders': r"\b(multiple|several|more than one|two|2|three|3|many|different) (daily )?(reminders|notifications|alarms)\b( (a|per|each) day| for (one|a|the same|each) habit)?",
 # time of day / section words
 'tod': r"\b(morning|afternoon|evening|night|bedtime|time of (the )?day|section|anytime)\b",
 'water': r"\b(water|hydrat\w*|drink)\b",
}
C = {k: re.compile(v, re.I) for k, v in P.items()}
hits = collections.defaultdict(list); n = 0
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); t = ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')).strip()
            if not re.search(r'[a-z]{3}', t): continue
            n += 1; rid = f'{store}{m.group(1)}#{i}'
            f = {k: bool(rx.search(t)) for k, rx in C.items()}
            row = (rid, r.get('rating') or r.get('score'), t[:700])
            if f['no_reminders']: hits['no_reminders'].append(row)
            if f['no_reminders'] and f['tod']: hits['no_reminders+tod'].append(row)
            if f['nag']: hits['nag'].append(row)
            if f['multi_reminders']: hits['multi_reminders'].append(row)
            if f['multi_reminders'] and f['water']: hits['multi_reminders+water'].append(row)
            if f['multi_reminders'] and f['tod']: hits['multi_reminders+tod'].append(row)
print('reviews scanned:', n)
for k, v in hits.items(): print(f'{k:28}{len(v)}')
json.dump(hits, open(f'{os.path.dirname(os.path.abspath(__file__))}/placement_hits.json', 'w'), ensure_ascii=False)
