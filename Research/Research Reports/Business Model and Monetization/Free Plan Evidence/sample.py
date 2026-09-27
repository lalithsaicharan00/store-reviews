"""Reading set for the free-plan question. Each mode is sampled with a per-app cap so no single app dominates.
LISTING_BETRAY is narrowed first to reviews that pair an expectation cue with a price or limit word."""
import json, random, collections, os, re
HERE = os.path.dirname(os.path.abspath(__file__)); WORK = os.path.join(HERE, '../../../Temp/free-plan')
rnd = random.Random(20260928)
C = [json.loads(l) for l in open(f'{WORK}/candidates.jsonl', encoding='utf-8')]
LIST2 = re.compile(r"(thought|expect|assum|advertis|descri|listing|screenshot|app store|play store|says? (it'?s )?free|free app|misleading|bait|deceiv|false|find out|found out|after (i )?download|should (say|mention|state|tell)|didn'?t (say|mention|tell)|upfront|up front|prévenir)"
                   r".{0,90}(free|pay|premium|subscri|limit|paywall|trial|cost|price|\$)|(free|pay|premium|subscri|limit|paywall|trial|cost|price).{0,90}(thought|expect|advertis|descri|listing|screenshot|misleading|bait|deceiv|false|find out|found out|should (say|mention|state)|upfront|up front)", re.I)
by = collections.defaultdict(list)
for c in C:
    for m in c['modes']:
        if m == 'LISTING_BETRAY' and not LIST2.search(c['text']): continue
        by[m].append(c)
def capped(pool, n, cap):
    pool = pool[:]; rnd.shuffle(pool); out, per = [], collections.Counter()
    for c in pool:
        if per[c['app']] < cap: out.append(c); per[c['app']] += 1
        if len(out) >= n: break
    return out
seen, order = set(), []
plan = [('CAP', 300, 8), ('WIDGET_PAY', 150, 6), ('LISTING_BETRAY', 170, 5), ('DISCLOSE_POS', 60, 6),
        ('UNLIMITED', 80, 6), ('SWITCH', 120, 4), ('FREE_ENOUGH', 100, 4)]
for m, n, cap in plan:
    for c in capped(by[m], n, cap):
        if c['key'] in seen: continue
        seen.add(c['key']); order.append((m, c))
os.makedirs(f'{WORK}/read', exist_ok=True)
for b in range(0, len(order), 70):
    with open(f'{WORK}/read/batch-{b//70+1:02d}.txt', 'w', encoding='utf-8') as f:
        for m, c in order[b:b+70]:
            t = c['text']; t = t if len(t) <= 600 else t[:600] + ' …'
            f.write(f"[{c['key']}] {m} | {c['rating']}★ {'PAID ' if c['paid'] else ''}{c['date']} {c['loc']} | {c['app'][:26]}\n{t}\n\n")
json.dump([{'key': c['key'], 'drawn': m} for m, c in order], open(f'{HERE}/sample-index.json', 'w'))
print(len(order), collections.Counter(m for m, _ in order), {m: len(v) for m, v in by.items()})
