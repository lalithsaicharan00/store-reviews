"""App Lock and widget privacy scan (item 58, 8 Oct 2026). Every review in the three corpora; writes candidates.jsonl."""
import json, re, glob, os, collections
ROOT = "../.."
P = {
 # a lock on the app: biometrics, passcode, pin
 'LOCK': r"pass ?code|pin ?code|\bpin\b(?! (it|the|to|this|a habit)|ned)|password[- ]?(protect\w*|lock\w*)|(add|set|put|need|want|wish)\w* (a |an )?(password|passcode|pin)|face ?id|touch ?id|optic ?id|fingerprint|finger ?print|biometric\w*|app ?lock|lock (the|this|my) app|lock(ed|ing)? (it|app|screen)? ?with|locks? (itself|automatically)|security lock|privacy lock|"
         r"huella|contraseña|código de (acceso|bloqueo)|bloqueo|bloquear la app|mot de passe|code (pin|secret)|verrouill\w*|empreinte|passwort|fingerabdruck|app.?sperre|gesperrt|senha|biometria|impressão digital|bloquear o app|impronta|codice (pin|di sblocco)|blocco app|пароль|отпечат\w*|блокировк\w*|пин.?код|parola|şifre|parmak izi|wachtwoord|vingerafdruk|hasło|odcisk|密码|密碼|指纹|指紋|面容|锁定|鎖定|应用锁|パスコード|パスワード|指紋認証|顔認証|ロック|비밀번호|암호|지문|잠금",
 # widgets showing what others shouldn't see
 'WIDGET_PRIV': r"widget.{0,80}(privacy|private|discreet|hid(e|den|ing)|anyone|someone|everyone|others|people|lock ?screen|embarrass|see (my|what|the)|show(s|ing)? (my|the|all) (habits?|names?|list))|(privacy|private|discreet|hid(e|den|ing)|embarrass).{0,80}widget",
 # others seeing your habits
 'OTHERS_SEE': r"(someone|anyone|people|others|family|partner|husband|wife|boyfriend|girlfriend|kids?|children|parents?|mom|mum|dad|roommate|friends?|boss|cowork\w*|colleague\w*|sibling\w*|brother|sister)\b.{0,40}\b(see|seeing|look(ing)? at|find|read|snoop\w*|nos(e|y|ing)|pick(s|ed)? up my phone|grab)\b.{0,60}\b(habits?|app|list|entries|journal|tracker|phone|screen|goals?)|over my shoulder|prying eyes|snoop\w*|discre(et|tion)|embarrass\w*.{0,60}(see|notification|widget|screen|show)|privacy (from|of) (others|my family)",
 # notifications revealing things
 'NOTIF_PRIV': r"notification\w*.{0,80}(privacy|private|discreet|embarrass\w*|anyone|everyone|someone|others|people|lock ?screen).{0,40}(see|read|show|display)|(privacy|private|discreet|embarrass\w*).{0,60}notification",
 # disguise / hide the app
 'DISGUISE': r"(hide|disguise|change|alternate|alternative|discreet|neutral|generic|secret)\w* (the |my |app )?(app )?icon|hide (the|this) app|hidden app|app switcher|multitask\w* (screen|view)|recent apps",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
out = open("candidates.jsonl", "w"); counts = collections.Counter(); total = 0; apps = collections.defaultdict(set)
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"{ROOT}/{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for i, line in enumerate(open(f)):
            r = json.loads(line); total += 1
            text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip(" —")
            hits = [k for k, rx in RX.items() if rx.search(text)]
            if not hits: continue
            for h in hits: counts[h] += 1; apps[h].add(app)
            out.write(json.dumps({"key": f"{store}{app.split('.')[0]}#{i}", "store": store, "app": app, "review_id": r["review_id"],
                                  "rating": r.get("rating"), "date": (r.get("date") or "")[:10],
                                  "loc": r.get("country") or r.get("language"), "hits": hits, "text": text}, ensure_ascii=False) + "\n")
print("reviews scanned", total)
for k in P: print(k, counts[k], "apps", len(apps[k]))
