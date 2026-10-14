"""Backups or restores in a different / second Google account than expected (14 Oct 2026)."""
import json, re, glob, os
ROOT="../.."
RX=re.compile(r"(back ?up\w*|restor\w*|google ?drive|drive)\W+(?:\w+\W+){0,14}(different|wrong|another|other|second|multiple|two|old|new|work|personal)\s+(google|gmail|e-?mail)?\s*(accounts?|ids?)"
              r"|(different|wrong|another|other|second|multiple|two|old|work|personal)\s+(google|gmail)\s+(accounts?|ids?)\W+(?:\w+\W+){0,14}(back ?up\w*|restor\w*|drive|data|habits|progress|history)"
              r"|which (google )?account (the |my |i |was |is )?(back ?up|backed)", re.I)
seen=set()
for l in open('../comeback/candidates.jsonl'): seen.add(json.loads(l)['review_id'])
for l in open('../onboarding-returning/candidates.jsonl'): seen.add(json.loads(l)['review_id'])
out=open('candidates.jsonl','w'); n=0; dup=0
for store,base in (("A","App Store Reviews"),("P","Play Store Reviews"),("N","Native Store Reviews")):
    for f in sorted(glob.glob(f"{ROOT}/{base}/*/reviews.jsonl")):
        app=os.path.basename(os.path.dirname(f))
        for i,line in enumerate(open(f)):
            r=json.loads(line); t=((r.get("title") or "")+" — "+(r.get("body") or r.get("text") or "")).strip(" —")
            if not RX.search(t): continue
            if r["review_id"] in seen: dup+=1; continue
            n+=1; out.write(json.dumps({"key":f"{store}{app.split('.')[0]}#{i}","app":app,"store":store,"review_id":r["review_id"],"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"text":t},ensure_ascii=False)+"\n")
print("new",n,"already read",dup)
