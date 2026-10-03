"""Today's row text research (3 Oct 2026): what the line under a habit's name should show, clutter and uneven rows,
quit habits on the list, telling tasks from habits, and where notes are typed. Scans every review in the App Store,
Play Store and native corpora; writes hits per question to Research/Temp/rowtext/."""
import json, re, glob, os, collections
ROOT = '/home/user/store-reviews/Research'
HABIT = r'(habit|streak|routine|tracker|goal)'
W = r'(?:\w+\W+){0,6}'
Q = {
 # Wanting (or not wanting) a fact visible on the main list: progress, goal, streak, time, frequency, days left.
 'info': re.compile(r'\b(see|show|shows|showing|display\w*|view|visible|glance)\W+' + W + r'(streak|progress|count|goal|target|time|reminder time|frequency|schedule|how many|how much|remaining|left)\W+' + W + r'(main|home|today|front|first|list|overview|dashboard)\s*(screen|page|view|list|tab)?', re.I),
 'glance': re.compile(r'at a glance', re.I),
 # Clutter and messy rows/cards/text.
 'clutter': re.compile(r'\b(clutter\w*|busy|messy|crowded|cramped|overwhelm\w*|too much (text|info\w*|going on)|hard to read|squish\w*|squeez\w*)\b', re.I),
 # Text cut off or wrapping on rows.
 'wrap': re.compile(r'(cut off|truncat\w*|two lines|second line|wrap\w*|text (overlap\w*|overflow\w*)|names? (are |is )?(cut|too long))', re.I),
 # Quit / bad habits on the list: what number or text people want.
 'quit': re.compile(r'(quit\w*|bad habit|addiction|sobriety|sober|abstain\w*|relapse\w*|slip\w*|days? since|time since|clean for|counter)\W+' + W + r'(main|home|list|screen|show|see|display|counter|timer|clock)', re.I),
 # Tasks next to habits: telling them apart.
 'task': re.compile(r'(to-?dos?|tasks?)\W+(?:\w+\W+){0,5}(habits?)\W+(?:\w+\W+){0,8}(separat\w*|distinguish\w*|differen\w*|confus\w*|mix\w*|tell apart|same list|together|label\w*)|(separat\w*|distinguish\w*|mix\w*)\W+(?:\w+\W+){0,4}(tasks?|to-?dos?)\W+(?:\w+\W+){0,3}(and|from|with)\W+habits?', re.I),
 # Notes: where they're written.
 'note': re.compile(r'\b(notes?|journal\w*|comment\w*)\b\W+' + W + r'(keyboard|typ\w*|text ?box|text ?field|small|tiny|screen|pop-?up|full ?screen|save|saving|lost|disappear\w*)', re.I),
}
NEEDS_HABIT = {'clutter', 'wrap', 'glance', 'note', 'info'}
hits = collections.defaultdict(list)
def text_of(r):
    return ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')).strip()
files = glob.glob(ROOT + '/App Store Reviews/*/reviews.jsonl') + glob.glob(ROOT + '/Play Store Reviews/*/reviews.jsonl') + glob.glob(ROOT + '/Native Store Reviews/*/reviews.jsonl')
total = 0
seen = set()
for f in files:
    src = f.split('/Research/')[1].split('/')[0]
    with open(f) as fh:
        for line in fh:
            try: r = json.loads(line)
            except Exception: continue
            rid = r.get('review_id')
            if rid in seen: continue
            seen.add(rid); total += 1
            t = text_of(r)
            if len(t) < 25: continue
            for q, rx in Q.items():
                if not rx.search(t): continue
                if q in NEEDS_HABIT and src != 'Native Store Reviews' and not re.search(HABIT, t, re.I): continue
                hits[q].append({'id': rid, 'app': r.get('app_name'), 'src': src, 'rating': r.get('rating'), 'text': t})
os.makedirs(ROOT + '/Temp/rowtext', exist_ok=True)
for q, v in hits.items():
    json.dump(v, open(f'{ROOT}/Temp/rowtext/hits_{q}.json', 'w'), ensure_ascii=False)
print('reviews scanned:', total)
for q, v in sorted(hits.items()):
    print(q, len(v), 'apps', len({h["app"] for h in v}))
