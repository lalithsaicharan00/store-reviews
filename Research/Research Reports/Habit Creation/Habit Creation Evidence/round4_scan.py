"""Round 4 screen: checklist uses and item words, streaks on non-daily habits, several-times-a-day habits,
weekly/monthly totals. One pass over every App Store + Play habit corpus. Writes round4_hits.json."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
CHECK = re.compile(r"\bcheck ?lists?\b|\bsub[- ]?tasks?\b|\bsub[- ]?habits?\b", re.I)
USES = {
 'exercise / workout': r"\b(work ?outs?|exercis\w*|gym|stretch\w*|yoga|push-?ups?|squats?)\b",
 'skincare': r"\bskin ?care|cleanser|serum|moisturi[sz]\w*|sunscreen|spf\b",
 'morning / night routine': r"\b(morning|night|evening|bedtime) routines?\b",
 'cleaning / chores': r"\b(clean\w*|chores?|laundry|dishes|tidy\w*|vacuum\w*)\b",
 'packing / leaving the house': r"\b(pack\w*|keys|wallet)\b",
 'medication / supplements': r"\b(meds|medication|medicines?|pills?|vitamins?|supplements?)\b",
 'study / work': r"\b(study\w*|homework|revision|work tasks?)\b",
 'meals / cooking': r"\b(meals?|cook\w*|recipes?|groceries|grocery)\b",
 'hygiene (teeth, shower)': r"\b(brush\w* (my )?teeth|floss\w*|shower\w*)\b",
}
WORDS = {
 'subtasks': r"\bsub[- ]?tasks?\b", 'sub-habits': r"\bsub[- ]?habits?\b", 'items': r"\b(checklist|list) items?\b|\bitems (in|on) (the |a |my )?(check ?)?list\b",
 'steps': r"\bsteps\b(?! ?(count|counter|tracker|goal))", 'tasks (in a checklist)': r"\btasks (in|within|inside) (a |the )?(habit|checklist)\b",
}
STREAK = re.compile(r"\bstreaks?\b", re.I)
NONDAILY = re.compile(r"\b(times a week|x a week|per week|weekly|specific days|certain days|every other day|rest days?|days off|skip(ped|ping)? days?|not every day|non-?daily|weekdays?|weekends?)\b", re.I)
MULTI = re.compile(r"\b(twice|two times|three times|3 times|2 times|several times|multiple times|many times|a few times) (a|per|each|every) day\b|\bmorning and (night|evening)\b|\bmorning,? (noon|afternoon),? and (night|evening)\b", re.I)
TOTAL = re.compile(r"\b(weekly|monthly) (goals?|targets?|totals?)\b|\b\d+ ?(km|miles|hours|pages|minutes|mins) (a|per|each) (week|month)\b", re.I)
C_USES = {k: re.compile(v, re.I) for k, v in USES.items()}; C_WORDS = {k: re.compile(v, re.I) for k, v in WORDS.items()}
uses, words = collections.Counter(), collections.Counter()
hits = collections.defaultdict(list); n = 0; nchk = 0
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); t = ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')).strip()
            if not re.search(r'[a-z]', t): continue
            n += 1; rid = f'{store}{m.group(1)}#{i}'
            if CHECK.search(t):
                nchk += 1
                for k, rx in C_USES.items():
                    if rx.search(t): uses[k] += 1
                for k, rx in C_WORDS.items():
                    if rx.search(t): words[k] += 1
                if any(rx.search(t) for rx in C_USES.values()): hits['checklist_use'].append((rid, t[:600]))
            if STREAK.search(t) and NONDAILY.search(t): hits['streak_nondaily'].append((rid, t[:600]))
            if MULTI.search(t): hits['multi_per_day'].append((rid, t[:600]))
            if TOTAL.search(t): hits['period_total'].append((rid, t[:600]))
print('reviews with Latin text:', n, '| mention checklist/subtasks/sub-habits:', nchk)
print('\nWhat checklists are used for (co-mentions):'); [print(f'  {k:32}{v:6}') for k, v in uses.most_common()]
print('\nWords for the things inside (in checklist reviews):'); [print(f'  {k:32}{v:6}') for k, v in words.most_common()]
for k, v in hits.items(): print(f'{k}: {len(v)} matches')
json.dump(hits, open('round4_hits.json', 'w'), ensure_ascii=False)
