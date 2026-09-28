"""Year-by-year view of the apps whose task / shared caps changed: total reviews, mean rating, coded cap
complaints per 1,000 reviews and the strict "I paid" share. Writes eras.txt."""
import json, re, os, glob, collections, statistics
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
coded = json.load(open(f'{HERE}/coded.json'))
STRICT = re.compile(r"\bi (have )?(paid|bought|purchased|subscribed|upgraded)|\bi'?m a (paying|premium|pro|plus|lifetime)|\bi have (the )?(premium|pro|plus|lifetime|paid)|\bpaid (for|user|version|member)|lifetime (member|purchase|license|licence|access|subscription)|\bpaying (user|customer|member)|premium (user|member)|買い切り|購入しました|課金しました|买了|购买了|已购买|付费了|결제했|구매했|ich habe .{0,20}(gekauft|bezahlt)|j'ai (payé|acheté)|compré|paguei|comprei|купил|оплатил", re.I)
APPS = [('A', 'App Store Reviews', '4. Me+'), ('P', 'Play Store Reviews', '4. Me+'), ('P', 'Play Store Reviews', '2. HabitNow'),
        ('A', 'App Store Reviews', '59. Tappsk'), ('P', 'Play Store Reviews', '98. Rabit'), ('P', 'Play Store Reviews', '126. To Do List'),
        ('P', 'Play Store Reviews', '84. Tasks'), ('A', 'App Store Reviews', '31. Do Habits')]
out = []
for store, base, prefix in APPS:
    d = [x for x in glob.glob(f'{ROOT}/{base}/*/') if os.path.basename(x.rstrip('/')).startswith(prefix)][0]
    num = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/'))).group(1)
    g = collections.defaultdict(lambda: {'n': 0, 'r': [], 'paid': 0, 'codes': collections.Counter()})
    for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
        if not l.strip(): continue
        r = json.loads(l); y = (r.get('date') or '')[:4]
        t = (r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')
        s = g[y]; s['n'] += 1; s['r'].append(r.get('rating') or 0); s['paid'] += bool(STRICT.search(t))
        k = f'{store}{num}#{i}'
        if k in coded:
            for c in set(coded[k]['codes']) & {'SHARED', 'TCAP', 'RECUR_PAID', 'TODO_PAID', 'TASK_FREE_PRAISE', 'ALLINONE', 'HCAP'}:
                s['codes'][c] += 1
    out.append(f'\n{store} {os.path.basename(d.rstrip("/"))}')
    out.append('year |    n | mean | I-paid% | per 1,000: SHARED TCAP RECUR_PAID TODO_PAID HCAP | TASK_FREE_PRAISE ALLINONE')
    for y in sorted(g):
        s = g[y]
        if s['n'] < 30: continue
        pk = lambda c: 1000 * s['codes'][c] / s['n']
        out.append(f"{y} | {s['n']:5} | {statistics.mean(s['r']):.2f} | {100*s['paid']/s['n']:5.1f} | "
                   f"{pk('SHARED'):6.1f} {pk('TCAP'):5.1f} {pk('RECUR_PAID'):5.1f} {pk('TODO_PAID'):5.1f} {pk('HCAP'):5.1f} | {pk('TASK_FREE_PRAISE'):5.1f} {pk('ALLINONE'):5.1f}")
open(f'{HERE}/eras.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
