"""Narrows the broad hits to the ones about a row, card or the main list (3 Oct 2026). Writes narrowed_<q>.json."""
import json, re
T = '/home/user/store-reviews/Research/Temp/rowtext/'
SURF = r'(card|row|list|home ?screen|main screen|main page|main view|today|dashboard|layout|each habit|habit name|title|subtitle|text)'
NEG = re.compile(r'(un-?clutter\w*|not (too )?(cluttered|busy|messy|overwhelm\w*|crowded)|no clutter|clutter-?free|without (being )?(clutter|overwhelm)\w*|never (feels? )?(cluttered|overwhelm\w*)|isn.t (cluttered|busy|overwhelm\w*)|less clutter|nothing cluttered)', re.I)
def near(t, a, b, n=8):
    return re.search(a + r'\W+(?:\w+\W+){0,%d}' % n + b, t, re.I) or re.search(b + r'\W+(?:\w+\W+){0,%d}' % n + a, t, re.I)
out = {}
c = json.load(open(T + 'hits_clutter.json'))
CL = r'(clutter\w*|busy|messy|crowded|cramped|overwhelm\w*|too much (text|info\w*)|hard to read|squish\w*|squeez\w*)'
out['clutter'] = [h for h in c if near(h['text'], CL, SURF, 6) and not NEG.search(h['text']) and (h['rating'] or 5) <= 4]
n = json.load(open(T + 'hits_note.json'))
out['note'] = [h for h in n if re.search(r'\bnotes?\b', h['text'], re.I) and near(h['text'], r'notes?', r'(keyboard|text ?box|text ?field|small|tiny|full ?screen|pop-?up|typ\w*|lost|disappear\w*)', 5)]
g = json.load(open(T + 'hits_glance.json'))
out['glance'] = g
q = json.load(open(T + 'hits_quit.json'))
out['quit'] = [h for h in q if re.search(r'(quit|bad habit|addict|sober|sobriety|relapse|days? since|time since|abstain|clean for)', h['text'], re.I)]
for k in ('info', 'task', 'wrap'):
    out[k] = json.load(open(T + f'hits_{k}.json'))
for k, v in out.items():
    json.dump(v, open(T + f'narrowed_{k}.json', 'w'), ensure_ascii=False)
    print(k, len(v), 'apps', len({h['app'] for h in v}))
