"""Segment sizes and 'say they paid' shares (§2), from the Backlog 5 and Backlog 4 coded sets joined with review text."""
import json, re, os, glob, random
HERE = os.path.dirname(os.path.abspath(__file__)); R = os.path.abspath(os.path.join(HERE, '../../..'))
STRICT = re.compile(r"\bi (have )?(paid|bought|purchased|subscribed|upgraded)|\bi'?m a (paying|premium|pro|plus|lifetime)|\bi have (the )?(premium|pro|plus|lifetime|paid)|\bpaid (for|user|version|member)|lifetime (member|purchase|license|licence|access|subscription)|\bpaying (user|customer|member)|premium (user|member)|買い切り|購入しました|課金しました|买了|购买了|已购买|付费了|会员|결제했|구매했|ich habe .{0,20}(gekauft|bezahlt)|j'ai (payé|acheté)|compré|paguei|comprei|купил|оплатил", re.I)
def load(cand, coded):
    C = {json.loads(l)['key']: json.loads(l) for l in open(cand, encoding='utf-8')}
    rows = json.load(open(coded))
    for r in rows: r['strict'] = bool(STRICT.search(C[r['key']]['text'])) or 'X_PAYER' in r['codes']
    return rows
DS = f'{R}/Research Reports/Data, Sync and Accounts'
r5 = load(f'{R}/Temp/backlog5-ipad-trust/candidates.jsonl', f'{DS}/iPad and Server Trust Evidence/coded.json')
r4 = load(f'{R}/Temp/backlog4-signin/candidates.jsonl', f'{DS}/Sign-in and Backup Evidence/coded.json')
G = [('refuse server (#5)', r5, ['SERVER_DISTRUST','ACCT_FORCED_PRIVACY','LOCAL_WANTED','WANTS_E2EE','ICLOUD_OVER_SERVER','OWN_CLOUD_PREF','ICLOUD_AVOID']),
     ('refuse server (#4)', r4, ['SERVER_REFUSE','IC_PREF_OVER_ACCOUNT','OWN_CLOUD_PREF','OWN_CLOUD_CHOICE','IC_REFUSE','PRIVACY_CONCERN','CLOUD_REFUSE']),
     ('want Google Drive', r4, ['GD_WANT']), ('want iCloud', r4, ['IC_WANT']), ('no-account praise', r5, ['NOACCT_PRAISE']),
     ('want sync/multi/iPad sync', r5, ['WANTS_SYNC','SYNC_ANY_REQ','MULTI_SYNC_REQ','IPAD_SYNC_REQ','TABLET_SYNC_REQ']),
     ('iPad sync failed', r5, ['IPAD_SYNC_FAIL']), ('lost data, no account', r5, ['NOACCT_LOSS','LOCAL_LOSS'])]
for name, rows, codes in G:
    v = [r for r in rows if r['store'] in 'AP' and set(r['codes']) & set(codes)]
    print(f"{name:30} n={len(v):4} say they paid={sum(r['strict'] for r in v)}")
rnd = random.Random(1); n = s = 0
for base in ['App Store Reviews', 'Play Store Reviews']:
    for d in glob.glob(f'{R}/{base}/*/reviews.jsonl'):
        for l in open(d, encoding='utf-8'):
            if rnd.random() < 0.02:
                r = json.loads(l); n += 1; s += bool(STRICT.search((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')))
print(f'baseline (2% sample): {s}/{n} = {100*s/n:.2f}%')
