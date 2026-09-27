"""Before/after checks inside single apps whose free plan changed (dates from the reviews' own cap statements).
For each era: reviews, mean rating, 1★ share, cap mentions per 1k, widget-paywall mentions per 1k, 'I paid' share.
China is shown separately for app A1 because it ran a review-for-membership offer there ('评论可得3个月会员')."""
import json, glob, os, re, statistics, collections
HERE = os.path.dirname(os.path.abspath(__file__)); ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
C = {}
for l in open(f'{ROOT}/Temp/free-plan/candidates.jsonl', encoding='utf-8'):
    c = json.loads(l); C[c['key']] = c
STRICT = re.compile(r"\bi (have )?(paid|bought|purchased|subscribed|upgraded)|\bi'?m a (paying|premium|pro|plus|lifetime)|\bpaid (for|user|version|member)|lifetime (member|purchase|access|subscription)|\bpremium (user|member)", re.I)
def app_rows(store, num):
    base = 'App Store Reviews' if store == 'A' else 'Play Store Reviews'
    d = [p for p in glob.glob(f'{ROOT}/{base}/{num}. */reviews.jsonl')][0]
    for i, l in enumerate(open(d, encoding='utf-8')):
        if l.strip(): yield f'{store}{num}#{i}', json.loads(l)
CASES = [
 ('A1 Habit Tracker: free cap 3 → 5 → 6 (non-China)', 'A', 1, lambda r: r.get('country') != 'cn',
  [('cap 3 (2020–2022)', '2020-01', '2022-12'), ('cap 5 (2023–2024)', '2023-01', '2024-12'), ('cap 6 (2025–2026)', '2025-01', '2026-12')]),
 ('A1 Habit Tracker, China only (review-for-membership offer)', 'A', 1, lambda r: r.get('country') == 'cn',
  [('cap 3 (2020–2022)', '2020-01', '2022-12'), ('cap 5 (2023–2024)', '2023-01', '2024-12'), ('cap 6 (2025–2026)', '2025-01', '2026-12')]),
 ('A20 Habit: unlimited free → cap 3 + subscription (Feb 2021)', 'A', 20, lambda r: True,
  [('unlimited (2019–2020)', '2019-01', '2020-12'), ('cap 3 (2021-02 on)', '2021-02', '2026-12')]),
 ('A3 Days Since: widgets free → paid (mid-2025)', 'A', 3, lambda r: True,
  [('widgets free (2024-01 – 2025-06)', '2024-01', '2025-06'), ('widgets paid (2025-07 on)', '2025-07', '2026-12')]),
 ('A48 Strides: 10 → 7 → 3 free goals', 'A', 48, lambda r: True,
  [('10 free (to 2017)', '2014-01', '2017-12'), ('7 free (2018–2020)', '2018-01', '2020-12'), ('3 free (2021 on)', '2021-01', '2026-12')]),
]
out = []
for title, s, n, filt, eras in CASES:
    out += ['', title, f"{'era':34}{'reviews':>8}{'mean':>6}{'1star':>7}{'cap/1k':>8}{'wgpay/1k':>9}{'paid%':>7}"]
    rows = [(k, r) for k, r in app_rows(s, n) if filt(r)]
    for name, a, b in eras:
        rs = [(k, r) for k, r in rows if a <= (r.get('date') or '')[:7] <= b]
        if not rs: continue
        N = len(rs)
        cap = sum(1 for k, _ in rs if k in C and 'CAP' in C[k]['modes'])
        wg = sum(1 for k, _ in rs if k in C and 'WIDGET_PAY' in C[k]['modes'])
        paid = sum(1 for _, r in rs if STRICT.search((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')))
        out.append(f"{name:34}{N:8}{statistics.mean(r['rating'] for _, r in rs):6.2f}{100*sum(r['rating'] == 1 for _, r in rs)/N:6.1f}%"
                   f"{1000*cap/N:8.1f}{1000*wg/N:9.1f}{100*paid/N:6.2f}%")
open(f'{HERE}/eras.txt', 'w').write('\n'.join(out).strip() + '\n'); print('\n'.join(out))
