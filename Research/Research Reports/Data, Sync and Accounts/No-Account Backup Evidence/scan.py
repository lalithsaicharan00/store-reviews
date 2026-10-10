"""No-account backup study (10 Oct 2026): screens every review in the repo for the patterns below and writes the
matches, one JSON object per line, for hand reading. Run from Research/: python3 -I Temp/no-account-backup/scan.py"""
import json, re, os, sys, collections

ROOT = os.getcwd()
CORPORA = [("App", "App Store Reviews"), ("Play", "Play Store Reviews"), ("Native", "Native Store Reviews")]
NEAR = 160
P = {
    "icloud": r"\bi[\s-]?cloud\b|icloud",
    "gdrive": r"google[\s-]?drive|\bg[\s-]?drive\b|\bgdrive\b|back(ed|ing)?[\s-]?up to (my )?drive|drive back[\s-]?up",
    "acct_forced": r"(requir\w*|forc\w*|have to|has to|had to|must|mandatory|make[s]? you|ask(s|ed)? (you|me) to|want(s|ed)? (you|me) to|need(s|ed)? (you |me )?to)\W+(\w+\W+){0,3}?(create|make|sign[\s-]?up|sign[\s-]?in|log[\s-]?in|login|register)\W+(\w+\W+){0,3}?(an? )?(account|profile)|(account|sign[\s-]?up|log[\s-]?in|login|registration|sign[\s-]?in) (is |was )?(required|mandatory|needed|necessary|forced)|(can'?t|cannot|won'?t let (me|you)|unable to) (use|open|access|start|even use)\W+(\w+\W+){0,4}?without (an? )?(account|sign|log|login|regist|e-?mail)",
    "no_acct": r"\bno (account|sign[\s-]?ups?|sign[\s-]?ins?|log[\s-]?ins?|logins?|registration|registering)\b|without (\w+\W+){0,3}?(an? )?(account|sign(ing)?[\s-]?up|log(ging)?[\s-]?in|login|regist\w*|e-?mail address)|(don'?t|doesn'?t|didn'?t|do not|does not|never|no need to|not) (\w+\W+){0,2}?(need|require|have|ask|force|make)\w*\W+(\w+\W+){0,3}?(account|sign[\s-]?up|log[\s-]?in|login|register|registration)",
    "local": r"stor(ed|es|ing) (only )?(locally|on (my|the|your) (phone|device))|sav(ed|es) locally|local(ly)?[\s-](storage|only|data|backup)|stays? on (my|the|your) (phone|device)|on[\s-]device (only|storage)|never leaves? (my|the|your) (phone|device)|offline[\s-]only|data (is|stays) (local|private)",
}
LOSS_TRIGGER = r"new phone|new iphone|new device|changed phones|switched phones|switch(ed)? (to a )?(new )?phones?|upgraded? (my )?phone|lost my phone|phone (broke|died|was stolen|got stolen|crashed)|broke my phone|reset my phone|factory reset|reinstall\w*|re-install\w*|deleted the app|delete the app|uninstall\w*|redownload\w*|re-download\w*|offload\w*"
LOSS_RESULT = r"\blost\b|\blose\b|losing|\bgone\b|wiped|disappear\w*|erased|start(ed|ing)? (all )?over|from scratch|no way to (restore|recover|get)|can'?t (restore|recover|get (it|them|my))|couldn'?t (restore|recover)|all (my|of my) (data|progress|habits|streaks?|history) (is|was|are|were)"
REX = {k: re.compile(v, re.I) for k, v in P.items()}
TRIG, RES = re.compile(LOSS_TRIGGER, re.I), re.compile(LOSS_RESULT, re.I)

def loss(text):
    for m in TRIG.finditer(text):
        s, e = max(0, m.start() - NEAR), m.end() + NEAR
        if RES.search(text[s:e]): return True
    return False

out = open(os.path.join(ROOT, "Temp/no-account-backup/matches.jsonl"), "w")
counts = collections.Counter(); stars = collections.defaultdict(list); total = collections.Counter()
for store, folder in CORPORA:
    base = os.path.join(ROOT, folder)
    for app in sorted(os.listdir(base)):
        f = os.path.join(base, app, "reviews.jsonl")
        if not os.path.exists(f): continue
        num = app.split(".")[0]
        for line in open(f, encoding="utf-8"):
            r = json.loads(line)
            text = " ".join(x for x in (r.get("title"), r.get("body"), r.get("text")) if x)
            total[store] += 1
            tags = [k for k, rx in REX.items() if rx.search(text)]
            if loss(text): tags.append("loss_device")
            if not tags: continue
            for t in tags:
                counts[(store, t)] += 1; stars[(store, t)].append(r["rating"])
            out.write(json.dumps({"store": store, "n": num, "app": r.get("app_name"), "id": r["review_id"], "rating": r["rating"],
                                  "date": r["date"][:10], "lang": r.get("language") or r.get("country"), "tags": tags, "text": text}, ensure_ascii=False) + "\n")
print("reviews screened:", dict(total), sum(total.values()))
for (store, t), c in sorted(counts.items()):
    s = stars[(store, t)]; print(f"{store:6} {t:12} {c:6}  mean {sum(s)/len(s):.2f}")
