import json, collections
exec(open('codes.py').read())
d = json.load(open('watch_app.json'))
names = {'W':'wants a Watch app','P':'praises one','L':'logging from the wrist','C':'complication','S':'sync fails','B':'broken/won\'t open','R':'reminders on Watch','A':'amounts','T':'timer','X':'incomplete','G':'sign-in','$':'paid/would pay','O':'without the phone','U':'slow/awkward UI','H':'Health only','N':'not about it','V':'glance on face','D':'double count','Z':'data lost','K':'timer as exercise','I':'add on Watch','Y':'undo/accidental','M':'differs Watch/iPhone','J':'wrong day','F':'objects to paid Watch','Q':'routine out of step'}
about = [i for i,c in CODES.items() if c not in ('N','H') and not set(c) <= {'N','H'}]
print('about the Watch app:', len(about), 'of', len(d))
apps = collections.Counter(d[i]['app'] for i in about)
print('apps with any:', len(apps))
for code,name in names.items():
    ids = [i for i in CODES if code in CODES[i]]
    if not ids: continue
    r = sum(d[i]['rating'] for i in ids)/len(ids)
    a = collections.Counter(d[i]['app'][:22] for i in ids).most_common(5)
    print(f"{code} {name:24} n={len(ids):4} {len(ids)/len(about)*100:5.1f}%  mean {r:.2f}  apps={len(set(d[i]['app'] for i in ids))}  {a}")
