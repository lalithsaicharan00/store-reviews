"""Third pass: put back non-English lock hits from dropped.jsonl unless the only lock word is a lock-screen phrase."""
import json, re
FOREIGN = re.compile(r"huella|contraseña|código|bloque\w*|bloquear|mot de passe|code|verrouill\w*|empreinte|passwort|fingerabdruck|sperr\w*|senha|biometria|impressão digital|impronta|codice|blocco|пароль|отпечат\w*|блокир\w*|пин|parola|şifre\w*|parmak izi|kilit\w*|wachtwoord|vingerafdruk|hasło|odcisk|密码|密碼|指纹|指紋|面容|锁|鎖|パスコード|パスワード|ロック|비밀번호|암호|지문|잠금|\bpin\b", re.I)
LOCKSCREEN = re.compile(r"ロック画面|ロックスクリーン|잠금 ?화면|экран\w* блокировки|pantalla de bloqueo|écran de verrouillage|sperrbildschirm|tela de bloqueio|schermata di blocco|kilit ekran\w*|锁屏|鎖屏|锁定屏幕|lock ?screen", re.I)
ENG = re.compile(r"\b(the|and|this|is|it|to|app)\b", re.I)
back = 0
kept = open("kept.jsonl", "a"); rest = open("dropped2.jsonl", "w")
for l in open("dropped.jsonl"):
    r = json.loads(l); t = r["text"]
    if "LOCK" in r["hits"]:
        stripped = LOCKSCREEN.sub(" ", t)
        if FOREIGN.search(stripped) and not re.fullmatch(r"[\x00-\x7f’‘“”…—–]*", t):
            r["tags"] = ["LOCK?"]; kept.write(json.dumps(r, ensure_ascii=False) + "\n"); back += 1; continue
    rest.write(l)
print("put back", back)
