import json, html, glob
c = {x['key']: x for x in json.load(open('candidates.json'))}
Q = [
 ('P2#12079', "allows me to choose where to back up to (e.g. Drive)"),
 ('P110#1454', "You can let us set backup frequency like every night or weekly, and save it on any cloud. Local device can be lost or gone anytime."),
 ('P3#15260', "Why is there no Google account sign in and backup automatically."),
 ('P69#245', "Everyday Auto Backup (like WhatsApp)"),
 ('P3#2531', "(Like Dropbox, so the developer shouldn't waste his own money for servers)"),
 ('P3#6989', "they seems commited to make it fully accessible offline to keep user privacy (which is nice)"),
 ('A76#576', "I would need to go to the other device and restore that back up to the device each and every time. It’s really annoying so I just use one device."),
 ('P2#3087', "I backed up the wrong device and imported from cloud on the device with the last few days on it"),
 ('P70#174', "I am delighted that the app update across devices without having to backup and then import back on another device."),
 ('P3#10847', "the fast and seamless copy of data from old phone to my new phone via Bluetooth, without any hitch, and without the need to log in"),
 ('P3#20156', "I can not find the folder that is mentioned in the faqs."),
 ('P3#13435', "I tried for 45 minutes to figure out how to export the data and import it on my new phone."),
 ('P3#14530', "When I import the file I experienced from another phone, the app I import to still stays empty."),
 ('A1#53141', "how do i transfer my habits from phone to ipad"),
 ('P2#12061', "it would've been cool to Log into my Tablet with the Habits I created"),
 ('P3#10745', "Automatic sync between two devices would be nice. But I guess I can't ask it from the free app"),
 ('A10#39038', "An account should be created immediately created upon sign up!!!!"),
 ('P2#3497', "the shortest interval for automatic backups is two days"),
 ('A24#28960', "the application has no auto backup.  So I decided to no longer use this application."),
 ('P3#14335', "either connect to Google drive and automatically backup daily, or make an account with a cloud"),
 ('A10#29286', "you can set a reminder to do it manually but looking through some reviews you can see a lot of people didn’t know that was an option"),
]
bad = 0; out = []
for k, q in Q:
    x = c[k]; base = 'App Store Reviews' if k[0] == 'A' else 'Play Store Reviews'
    d = glob.glob(f"/home/user/store-reviews/Research/{base}/{k[1:].split('#')[0]}. */")
    d = [p for p in d if x['app'] in p][0]
    src = None
    for l in open(d + 'reviews.jsonl', encoding='utf-8'):
        r = json.loads(l)
        if r['review_id'] == x['review_id']: src = html.unescape((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' '); break
    if src is None or html.unescape(q) not in src: bad += 1; print('PROBLEM', k, q[:50])
    out.append({'key': k, 'review_id': x['review_id'], 'app': x['app'], 'date': x['date'], 'rating': x['rating'], 'loc': x['loc'], 'quote': q})
json.dump(out, open('quotes.json', 'w'), ensure_ascii=False, indent=1); print(len(Q), 'quotes', bad, 'problems')
