import json, re
W = re.compile(open("scan_widget.py").read().split('W = re.compile(r"')[1].split('", re.I)')[0], re.I)
S = re.compile(r"privacy|private|privately|discreet|discretion|embarrass\w*|peep\w*|nosy|nosey|snoop\w*|prying|(anyone|someone|everyone|everybody|people|others|other people|family|parents?|partner|kids?|friends?|boss|coworkers?)\W+(\w+\W+){0,5}(see|seeing|saw|look|looks|looking|read|know|knows|notice|noticed|find out|ask)|hide|hidden|hiding|without (the|a|any|showing) (name|title|label|caption|text)|no (names?|titles?|labels?|captions?|text)|anonymous\w*|secret\w*|sensitive|expos\w*|confidential|personal (habits?|stuff|things|info\w*|goals?|data)|曝露|暴露|隐私|隱私|隐藏|隱藏|别人|別人|プライバシー|見られ|人に見|사생활|남이|숨기|приват|скры|кто-то|узна|чуж|privad|privé|privat|ocult|escond|nascond|gizli|alguien|nadie|quelqu|jemand", re.I)
rows = [json.loads(l) for l in open("widget_candidates.jsonl")]
rows = [r for r in rows if not r["seen"]]
keep = []
for i, r in enumerate(rows):
    t = r["text"]; ok = False
    for m in W.finditer(t):
        if S.search(t[max(0, m.start()-160): m.end()+160]): ok = True; break
    if ok: keep.append(i)
json.dump(keep, open("strict_keep.json", "w"))
print("kept", len(keep), "of", len(rows)); print("batch0 kept:", [i for i in keep if i < 200])
