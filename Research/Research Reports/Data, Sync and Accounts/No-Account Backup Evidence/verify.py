"""Checks every quote in the report word for word against the review files (W2). Run from Research/."""
import json,os,html,sys
keys=json.load(open("Research Reports/Data, Sync and Accounts/No-Account Backup Evidence/keys.json")); keys.update(json.load(open("Research Reports/Data, Sync and Accounts/No-Account Backup Evidence/keys-native.json")))
Q=[
("IC207","Literally every app I have backs up to my iCloud - daily and seamlessly"),
("IC140","Every other app I use allows its data to be backed up automatically via iCloud"),
("IC769","This is literally the only app (out of 114 on my phone) that neither has automatic periodic backups nor iCloud sync support"),
("IC290","No account necessary and I don’t have to worry about my logs when I eventually upgrade my phone"),
("IC568","requires no account—your data is stored securely in iCloud"),
("IC532","I don’t get why developers should avoid implementing iCloud sync and push for extra account"),
("GD162","Why must I create another online account that can get hacked, instead of using the Google drive I already have?"),
("IC291","Changed devices and lost months worth of data, even though I had iCloud sync enabled"),
("IC115","An email login should be a non negotiable"),
("IC66","不然icloud没有空间做不到多设备同步"),
("AC41","i should have the option to simply keep the app local on my device"),
("NA4","I didn’t even get to try the app as I was required to sign in with a microsoft account before anything else"),
("NA26","I lost ALL my lists without any notice whatsoever of this app update"),
("LS608","There is a sync option in the app"),
("LS406","No Cloud Backup — Entire Year of Data Gone"),
("LS117","if you don’t backup your data either on the cloud or your device (it does not automatically do it) and accidentally delete the app, you will lose your finch"),
("NO200","I love that I do not need to create an account to use it"),
("GD115","please consider adding automatic daily backups to Google Drive, like Truecaller and WhatsApp"),
("LS140","unlike EVERY OTHER APP ON HERE, nothing is stored on the cloud"),
("IC472","iCloud sync is deplorable on every app where it’s used, including Apple’s own apps"),
("AC18","the app never tells you that there’s no backup"),
("NA139","NEVER store your notes on places OTHER THAN your iCloud account"),
]
files={}
base=os.getcwd()
for store,folder in (("App","App Store Reviews"),("Play","Play Store Reviews"),("Native","Native Store Reviews")):
    for app in os.listdir(os.path.join(base,folder)):
        f=os.path.join(base,folder,app,"reviews.jsonl")
        if os.path.exists(f): files[(store,app)]=f
want={keys[k] for k,_ in Q if k in keys}
found={}
for f in files.values():
    for line in open(f,encoding="utf-8"):
        r=json.loads(line)
        if r["review_id"] in want:
            found[r["review_id"]]=html.unescape(" ".join(x for x in (r.get("title"),r.get("body"),r.get("text")) if x))
ok=0
for k,q in Q:
    rid=keys[k]; t=found.get(rid,"")
    good=html.unescape(q) in t or html.unescape(q).replace("’","'") in t.replace("’","'")
    print("OK " if good else "BAD", k, rid, q[:60]); ok+=good
print(ok,"of",len(Q))
