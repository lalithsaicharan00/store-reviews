"""Item 58 decision 1: widget + privacy, wider than scan.py. Pairs a widget/lock-screen word with a privacy word within 140 chars."""
import json, re, glob, os, html
W = re.compile(r"widget|lock ?screen|home ?screen|today view|notification cent|stand ?by|小组件|小部件|小工具|桌面|锁屏|鎖定畫面|ウィジェット|ロック画面|위젯|잠금 ?화면|виджет|экран\w* блокировк|pantalla de bloqueo|écran de verrouillage|sperrbildschirm|tela de bloqueio", re.I)
P = re.compile(r"privacy|private|privately|discreet|discretion|embarrass\w*|peep\w*|nosy|nosey|snoop\w*|prying|anyone|someone|everyone|everybody|other people|others (can|could|will|see)|people (can|could|would|will|see|around)|hide|hidden|hiding|without (the|a|any|showing) (name|title|label|caption|text)|no (names?|titles?|labels?|captions?)|anonymous\w*|secret\w*|sensitive|personal|expos\w*|confidential|曝露|暴露|隐私|隱私|隐藏|隱藏|别人|別人|プライバシー|見られ|人に見|사생활|남이|숨기|приват|скры|личн|чуж|privad|privé|privat|ocult|escond|nascond|gizli", re.I)
seen = {json.loads(l)["review_id"] for l in open("read.jsonl")}
out = open("widget_candidates.jsonl", "w"); n = 0; total = 0
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"../../{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for line in open(f):
            r = json.loads(line); total += 1
            t = html.unescape(((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")))
            hit = False
            for m in W.finditer(t):
                if P.search(t[max(0, m.start()-140): m.end()+140]): hit = True; break
            if not hit: continue
            n += 1
            out.write(json.dumps({"store": store, "app": app, "review_id": r["review_id"], "rating": r.get("rating"),
                "date": (r.get("date") or "")[:10], "seen": r["review_id"] in seen, "text": t}, ensure_ascii=False) + "\n")
print(total, "scanned;", n, "candidates")
