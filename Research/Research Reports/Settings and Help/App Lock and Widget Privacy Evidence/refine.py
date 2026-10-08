"""Second pass over candidates.jsonl: keep a review only where the match is about locking the app, hiding it, or
others seeing it. Rules disclosed in the report. Writes kept.jsonl and dropped.jsonl (dropped is spot-checked)."""
import json, re, collections
I = re.I
STRONG = re.compile(r"pass ?code|face ?id|touch ?id|optic ?id|fingerprint|finger ?print|biometric|app ?lock|lock (the|this|my|your) app|"
    r"password[- ]?(protect\w*|lock\w*)|lock(ed|s|ing)? (it )?with (a )?(password|pin|code|face|touch|finger)|"
    r"pin ?code|(set|add|enter|use|create|put|with|forgot\w*|need|want)\w* (a |an |my |the )?(4.digit |numeric )?pin\b|\bpin (lock|number|protect\w*|to open|or (finger|face|touch|bio))|"
    r"huella|empreinte|fingerabdruck|impressão digital|biometria|impronta|отпечат\w*|parmak izi|vingerafdruk|odcisk|指纹|指紋|面容|指紋認証|顔認証|지문|"
    r"アプリ.?ロック|パスコード|ロック機能|앱 ?잠금|잠금 ?기능|应用锁|鎖定|锁定|"
    r"app.?sperre|bloquear (la|o) (app|aplica\w*)|bloqueo (de|con|por) (la )?(app|aplicaci\w*|huella|contraseña|código|pin)|code de verrouillage|verrouill\w* (l.app|l.application|par|avec)|"
    r"блокировк\w* (приложени\w*|паролем|по )|пин.?код", I)
PASSWORDISH = re.compile(r"password|passwort|mot de passe|contraseña|senha|пароль|密码|密碼|パスワード|비밀번호|암호|şifre|wachtwoord|hasło|parola", I)
LOCKCTX = re.compile(r"lock|protect|privac|private|secur|hide|hidden|open(ing)? the app|access the app|journal|diary|\bnotes?\b|"
    r"bloque|protege|privad|privé|verrouill|sperr|schütz|privat|bloqu|proteg|privacidade|блок|защит|приват|личн|锁|鎖|隐私|隱私|ロック|プライバシー|잠금|사생활|kilit|gizli", I)
WIDGET = re.compile(r"widget", I)
WIDGETPRIV = re.compile(r"privacy|private|discreet|discretion|embarrass\w*|nosy|prying|snoop|anyone (can|could|will)|someone (can|could|might|will)|everyone (can|could|will)|"
    r"hid(e|es|den|ing) (my |the |all )?(habit|name|content|detail|text|info|what)|(face|touch) ?id|pass ?code|password|lock(ed)? (the )?app|app lock", I)
OTHERS = re.compile(r"over my shoulder|prying eyes|snoop\w*|discre(et|tion)|(someone|anyone|people|others|family|partner|husband|wife|boyfriend|girlfriend|kids?|children|parents?|mom|mum|dad|roommate|friends?|boss|cowork\w*|colleague\w*|sibling\w*|brother|sister)\b.{0,40}\b(see|seeing|look(ing)? at|find|read|snoop\w*|nos(e|y|ing)|pick(s|ed)? up my phone|grab)\b", I)
DISG = re.compile(r"(hide|disguise|alternate|alternative|discreet|neutral|generic|secret|change)\w* (the |my |app )?(app )?icon|hide (the|this) app|hidden app|app switcher|multitask\w* (screen|view)|recent apps", I)
kept, dropped = open("kept.jsonl", "w"), open("dropped.jsonl", "w"); c = collections.Counter(); why = collections.Counter()
for l in open("candidates.jsonl"):
    r = json.loads(l); t = r["text"]; tags = []
    if STRONG.search(t): tags.append("LOCK")
    elif PASSWORDISH.search(t) and LOCKCTX.search(t):
        # the password word and a lock/privacy word within 120 characters of each other
        for m in PASSWORDISH.finditer(t):
            if LOCKCTX.search(t[max(0, m.start()-120): m.end()+120]): tags.append("PASSWORD"); break
    if WIDGET.search(t):
        for m in WIDGET.finditer(t):
            if WIDGETPRIV.search(t[max(0, m.start()-150): m.end()+150]): tags.append("WIDGET"); break
    if "NOTIF_PRIV" in r["hits"]: tags.append("NOTIF")
    if "OTHERS_SEE" in r["hits"] and OTHERS.search(t): tags.append("OTHERS")
    if DISG.search(t): tags.append("DISGUISE")
    r["tags"] = tags
    (kept if tags else dropped).write(json.dumps(r, ensure_ascii=False) + "\n")
    c["kept" if tags else "dropped"] += 1
    for x in tags: why[x] += 1
print(c, why)
