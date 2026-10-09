import json, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from classification import GAP, ACCOUNT_SAFE, FREQUENCY
C = {json.loads(l)['key']: json.loads(l) for l in open('candidates.jsonl')}
QUOTES = {
 "A10#30797": "it only restored my data from two weeks ago",
 "A23#4691": "I was able to restore data up until almost 2 weeks ago, so I only lost the data from the last 2 weeks",
 "A23#4531": "Automatic backups are not frequent enough",
 "A23#3883": "it also results in missing data for the past few days",
 "P98#600": "There is a back-up option however you usually lose a few days of progress",
 "A20#3400": "lost everything since my last back up",
 "A10#35429": "You cannot just log back into your account and have all of your stuff there",
 "P22#992": "why do you even have an option of creating an account if you can't backup the data",
 "P12#35599": "I thought journey progress was saved in the account?",
 "P12#29471": "when I logged in with my email all my progress was gone",
 "P2#22852": "I would expect the ability to instantly sync to the cloud for every change",
 "A10#30767": "She hadn’t backed up her iCloud data in two weeks",
}
bad = 0
for k, q in QUOTES.items():
    if q not in C[k]['text']: print("MISMATCH", k); bad += 1
for name, keys in [("GAP", GAP), ("ACCOUNT_SAFE", ACCOUNT_SAFE), ("FREQUENCY", FREQUENCY)]:
    missing = [k for k in keys if k not in C]
    assert not missing and len(set(keys)) == len(keys), (name, missing)
    r = [C[k]['rating'] for k in keys]
    apps = {k.split('#')[0] for k in keys}
    print(f"{name}: {len(keys)} reviews, {len(apps)} apps, mean {sum(r)/len(r):.2f}★, 1–2★ {sum(x<=2 for x in r)}")
for k in sorted(set(GAP + ACCOUNT_SAFE + FREQUENCY)):
    c = C[k]; print(f"| `{k}` | `{c['review_id']}` | {c['app']} | {c['date']} | {c['rating']}★ |")
print("quotes checked:", len(QUOTES), "mismatches:", bad)
