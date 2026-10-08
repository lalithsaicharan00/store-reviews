"""Decision 3: when the lock asks again. A lock/biometric word near a timing or switching word."""
import json, re, glob, os, html
L = re.compile(r"pass ?code|password|\bpin\b|face ?id|touch ?id|finger ?print|biometric|lock|unlock|密码|密碼|指纹|指紋|面容|ロック|パスコード|잠금|비밀번호|암호|парол|блокир|contraseña|bloqueo|huella|senha|bloqueio|mot de passe|verrouill|passwort|sperre|şifre|kilit", re.I)
T = re.compile(r"every (single )?time|each time|everytime|all the time|constantly|keeps? (asking|prompting|locking)|again and again|over and over|too often|so often|repeatedly|whenever i (switch|leave|go|come|open|return|minimi)|switch(ing)? (between )?apps?|multitask\w*|app switcher|in the background|background|minimi[sz]\w*|come back|coming back|go back to the app|return(ing)? to the app|leave the app|leaving the app|close the app|closing the app|time ?out|timer|after (\d+|a few|one|five|ten|x) (sec\w*|min\w*|hours?)|(\d+|one|five|ten|fifteen|thirty) ?(sec\w*|min\w*|hours?)|auto[- ]?lock|grace|idle|inactiv\w*|immediately|right away|stay(s)? (unlocked|open)|remember\w* (me|that i)|"
 r"每次|每一次|总是|反复|切换|后台|几分钟|分钟后|毎回|その都度|切り替え|バックグラウンド|分後|매번|백그라운드|다시 열|каждый раз|постоянно|фон|через \d+ мин|cada vez|siempre|segundo plano|minutos|toda vez|sempre|segundo plano|à chaque fois|arrière-plan|jedes mal|hintergrund|her seferinde|arka plan", re.I)
seen = {json.loads(l)["review_id"] for l in open("../read.jsonl")}
out = open("relock_candidates.jsonl", "w"); n = 0
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"../../../{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for line in open(f):
            r = json.loads(line)
            t = html.unescape((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or ""))
            hit = False
            for m in L.finditer(t):
                if T.search(t[max(0, m.start()-120): m.end()+120]): hit = True; break
            if not hit: continue
            n += 1
            out.write(json.dumps({"store": store, "app": app, "review_id": r["review_id"], "rating": r.get("rating"),
                "date": (r.get("date") or "")[:10], "seen": r["review_id"] in seen, "text": t}, ensure_ascii=False) + "\n")
print(n)
