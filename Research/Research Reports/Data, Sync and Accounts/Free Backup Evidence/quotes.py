import json
c = {json.loads(l)['key']: json.loads(l) for l in open('candidates.jsonl')}
lo = sorted([x for x in c.values() if x['modes'] == ['LOSS']], key=lambda x: (x['app'], x['key']))
def LI(i): return lo[i]['key']
Q = [
 ('P106#678', "A subscription to backup & restore to my own Google Drive, no and uninstalled."),
 ('P106#854', "Gating my own (old) data on my own device behind a pay wall? That sounds borderline ransomware!"),
 ('P12#61966', "the longer I use the app, the more it's going to feel like my save is being held hostage by the subscription"),
 ('P12#61966', "If I could pay a one time fee to unlock backups, I would do it."),
 ('P130#295', "Shame on devs to hold data hostage in this manner. Uninstalling."),
 ('P84#9108', "Paying to get MY OWN data back is a big red no no flag for me."),
 ('P84#8976', "They do not tell you this when you make the backup, just so to blackmail you later."),
 ('P84#7935', "Switched phones and I have to pay to backup and restore my lists. Thanks for making me lose all my lists."),
 ('P12#17496', "the backup option is only for premium users, so it demotivates me to use it all over again"),
 ('A3#175', "Back up is literally PREMIUM? Back up should be apart of EVERY app for FREE."),
 ('P24#3426', "I've lost all my progress that I've been tracking from 300 days."),
 ('P12#49888', "I want to support you in the future when I have a job, now I'm just a student."),
 ('P84#54167', "По-моему это что-то на уровне шантажа"),
 ('P24#4502', "it is sad that you need to pay for back up, but it is understandable."),
 ('A48#2750', "Despite it requires an annual subscription to save your data, you can use 100% of their functions"),
 ('P84#1024', "Only backup needs a payed version. Thanks! I am thinking about buying the full version"),
 ('A1#55468', "I decided just to pay the $4.99 in case my data doesn’t back up in the cloud."),
 ('P15#350', "I’m only buying premium for automatic backup."),
 ('P84#12103', "I upgraded to premium app for the back up capabilities well worth it to me"),
 ('P2#5681', "I discovered none of my backups had actually occurred and over two years of habit tracking data had been lost."),
 ('P24#4874', "I paid for premium only for the back-up option, for it to dissappear now."),
 ('P12#46983', "I paid for Premium because it's supposed to back up progress. They didn't."),
 ('A1#53622', "Got premium on day 2 for sync to other devices"),
 ('P126#70222', "Purchased mainly for it's ability to sync across devices"),
 ('A1#2374', "I paid for premium mostly so that I can have the ability to Sync my habits on my devices."),
 ('A13#1921', "I love that the free version allows iCloud sync (unlike some of the other leading habit trackers) No account necessary and I don’t have to worry about my logs when I eventually upgrade my phone."),
 ('P97#2819', "it has auto backup for FREE!"),
 ('P69#252', "A major plus is that all the important features including backup are included in the free version"),
 ('A33#2107', "Habitify is completely free without any restrictions and also syncs perfectly with my phone so prefer it more now"),
 ('P24#7579', "Instead of limiting habits for free version, disable notifications or cloud storage or inter device sync"),
 ('A48#4112', "maybe the basic functionality should be free, if one doesn&#39;t care about syncing the data and using the web interface. There would still be plenty of people that would pay. I would."),
 ('A7#572', "This is not cloud based, it does not produce any costs."),
 ('A8#552', "I just wish it has icloud saving but I realize if something is free like this, the devs cant afford such"),
 ('A3#8946', "I do back up my phone. My data was gone when I restored the backup to my new phone."),
 (LI(226), "I assumed my data was backed up in iCloud. Big mistake."),
 (LI(73), "Literally every app I have backs up to my iCloud - daily and seamlessly."),
 (LI(136), "I dropped my phone and lost my progress. With the my new phone I've decided to try a new habit tracker"),
 (LI(504), "I've finally switched to another habit tracking app (Habitify)"),
 (LI(504), "it doesn't save your data to the cloud, even when you make an account"),
 (LI(180), "Was done my free trial and ready to subscribe. But I got a new phone and when I logged in with my email all my progress was gone."),
 (LI(121), "I am genuinely distraught over this and have zero motivation to start again."),
 (LI(502), "Would like to keep it and buy. But the reason I'll go to different app is there no option to save or export my progress"),
 (LI(306), "I was not on your paid subscription bit i guess that’s on me"),
 (LI(442), "Today i lost 2.5 years of data as i forgot to backup the file and hit factory reset."),
 (LI(77), "I did not save it to my cloud because I do not have space but did not know I would need to."),
 (LI(206), "All other apps restored the data, EXCEPT for this app. This app restored my lists from 3 years ago"),
 (LI(117), "I did not know there is no backup until I searched about it."),
 (LI(458), "many apps got uninstalled from my phone automatically due to some issue and Loop Habit tracker was also one of them."),
 (LI(354), "the company listed where to find backups in the app"),
 (LI(616), "I lost my data due to your stupid greedy system"),
]
import html
out, bad = [], 0
for k, q in Q:
    x = c[k]; t = html.unescape(x['text']); ok = html.unescape(q) in t
    if not ok: bad += 1; print('MISSING', k, q[:60])
    # confirm against source reviews.jsonl by review_id
    st = 'App Store Reviews' if k[0]=='A' else 'Play Store Reviews'
    found = False
    for l in open(f"../../../{st}/{x['app']}/reviews.jsonl", encoding='utf-8'):
        r = json.loads(l)
        if r.get('review_id') == x['review_id']:
            found = html.unescape(q) in html.unescape((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n',' '); break
    if not found: bad += 1; print('NOT IN SOURCE', k)
    out.append({'key': k, 'review_id': x['review_id'], 'app': x['app'], 'date': x['date'], 'rating': x['rating'], 'loc': x['loc'], 'quote': html.unescape(q)})
json.dump(out, open('quotes.json', 'w'), ensure_ascii=False, indent=1)
print(len(Q), 'quotes,', bad, 'problems')
