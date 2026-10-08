"""Decision 2: why a separate code. Reviews about others knowing the phone's passcode, sharing biometrics, separate/own/second codes."""
import json, re, glob, os, html
P = re.compile(
 r"(know|knows|knew|has|have|got|gets|use|uses)\s+(my\s+)?(phone'?s?\s+|iphone'?s?\s+|lock ?screen\s+|screen\s+)?(pass ?code|password|pin|code|lock)\b"
 r"|(mom|mum|mother|dad|father|parents?|sister|brother|sibling|husband|wife|partner|boyfriend|girlfriend|bf|gf|spouse|kids?|son|daughter|family|friends?|roommate)\W+(\w+\W+){0,6}(pass ?code|password|pin|face ?id|finger ?prints?|touch ?id)"
 r"|(different|separate|seperate|own|second|another|extra|additional|unique|custom|personal|individual|independent)\s+(\w+\s+){0,2}(pass ?code|password|pin|code)\b"
 r"|(not|n't|instead of)\s+(\w+\s+){0,3}(the\s+)?(same\s+)?(as\s+)?(my\s+)?(phone|iphone|device|lock ?screen|screen)('s)?\s+(pass ?code|password|pin|code)"
 r"|(phone|iphone|device|lock ?screen)('s)?\s+(pass ?code|password|pin|code)\s+(\w+\s+){0,6}(open|access|get in|unlock|see|read)"
 r"|(added|add|register\w*|enrol\w*|set up)\s+(\w+\s+){0,3}(face|finger ?print|alternate appearance)"
 r"|alternate appearance|biometr\w* only|face ?id only|only (face ?id|touch ?id|finger ?print|biometric)"
 r"|锁屏密码|手机密码|手机解锁密码|独立.{0,4}密码|单独.{0,4}密码|另设|專屬密碼|獨立密碼|別のパスコード|専用のパスワード|별도.{0,4}(비밀번호|암호)|따로.{0,4}(비밀번호|암호)|отдельн\w* парол|свой парол|собственн\w* парол|contraseña propia|otra contraseña|contraseña diferente|senha (própria|diferente|separada)|outra senha|mot de passe (différent|propre|séparé)|eigenes? (passwort|pin)|anderes? (passwort|pin)|ayrı (bir )?şifre|farklı (bir )?şifre", re.I)
LOCKISH = re.compile(r"lock|app|note|private|privacy|hide|see|access|open|密码|密碼|ロック|パス|잠금|парол|contraseña|senha|passwort|mot de passe|şifre", re.I)
seen = {json.loads(l)["review_id"] for l in open("../read.jsonl")}
out = open("sep_candidates.jsonl", "w"); n = 0
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"../../../{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for line in open(f):
            r = json.loads(line)
            t = html.unescape((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or ""))
            m = P.search(t)
            if not m or not LOCKISH.search(t): continue
            n += 1
            out.write(json.dumps({"store": store, "app": app, "review_id": r["review_id"], "rating": r.get("rating"),
                "date": (r.get("date") or "")[:10], "seen": r["review_id"] in seen, "text": t}, ensure_ascii=False) + "\n")
print(n)
