"""Full-corpus screen for account / identity topics (topic 1). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'APPLE_SIGNIN': r"sign(ed|ing)? ?(in|up) with apple|apple (id )?(sign[- ]?in|login|log in)|continue with apple|log(ged|ging)? ?in with apple|apple account (login|sign)",
 'HIDE_EMAIL': r"hide my e-?mail|private ?relay|privaterelay|relay (e-?mail|address)|hidden e-?mail",
 'GOOGLE_SIGNIN': r"sign(ed|ing)? ?(in|up) with google|google (sign[- ]?in|login|log in)|continue with google|log(ged|ging)? ?in with google",
 'FACEBOOK': r"facebook (login|log ?in|sign)|log(ged|ging)? ?in (with|via|through) facebook|sign(ed)? ?(in|up) with facebook",
 'GUEST': r"guest (mode|account|user|login)|as a guest|anonymous(ly)? (account|mode|user|login)",
 'EMAIL_VERIFY': r"verif\w* (e-?mail|mail|link|code)|confirmation (e-?mail|link|code)|magic link|(code|e-?mail|link) (never|didn.?t|doesn.?t|did not|not) (arriv|come|came|receiv|get sent|sent)|spam folder",
 'PASSWORD': r"(forg[eo]t|reset|change|recover)\w* (my )?password|password reset|wrong password|incorrect password|password (is|was) (wrong|incorrect)",
 'PHONE_LOGIN': r"(phone number|sms|otp|mobile number)\b.{0,20}\b(login|log ?in|sign|verif|code)",
 'TWO_ACCOUNTS': r"two accounts|2 accounts|second account|another account|different account|new account (was )?(created|made)|created a new account|merge (my )?accounts|duplicate accounts?|(link|connect|combine) (my )?(two |both )?accounts",
 'EMAIL_CHANGE': r"chang\w* (my )?e-?mail|new e-?mail (address)?|old e-?mail|lost access to (my )?e-?mail|e-?mail (no longer|doesn.?t) (exist|work)",
 'CHINA_LOGIN': r"wechat|微信|qq登[录陆]|登录不了|无法登录|登不上|登陆不了|注册不了|要vpn|需要vpn|翻墙",
 'SHARED_DEVICE': r"(my )?(kid|child|son|daughter|kids|children)('s)? (account|ipad|phone|tablet|profile)|multiple (users|profiles|people)|share (the|this|one|a|my) (device|phone|ipad|tablet)|family members? (use|using|account)",
 'LOGOUT': r"logs? me out|logged me out|keeps? (logging|signing) (me )?out|sign(s|ed)? me out|session expired|have to log ?in (again|every)",
 'ACCOUNT_LOST': r"account (disappeared|was deleted|got deleted|is gone|was gone|missing|not found|doesn.?t exist|never existed|was suspended|banned)|can.?t find my account|user not found|no account (found|with)",
 'SIGNUP_FAIL': r"(can.?t|cannot|unable to|won.?t let me|couldn.?t|could not) (sign ?up|register|create (an |my )?account)|registration (fail|error|doesn|isn|won)|sign ?up (fail|error|doesn|isn|won|button)",
 'LOGIN_FAIL_ML': r"no (puedo|me deja) (iniciar sesi[oó]n|entrar|acceder)|n[aã]o consigo (entrar|fazer login|logar|acessar)|kann mich nicht (mehr )?anmelden|anmeldung (geht|funktioniert) nicht|impossible de (me connecter|se connecter)|ログインでき|ログイン出来|로그인이? (안|되지)|не могу (войти|авторизоваться|зайти)|non riesco (ad? accedere|a fare il login)|giriş yapam",
 'WHY_ACCOUNT': r"(why|don.?t want to|not comfortable|shouldn.?t have to|no need to)\b.{0,30}\b(give|share|enter|create|make|sign ?up|log ?in|register)\b.{0,20}\b(e-?mail|account|personal)",
 'NO_ACCOUNT_PRAISE': r"(no|without( an?)?|don.?t need( an?)?|doesn.?t require( an?)?|not required to)\s?(account|sign ?up|log ?in|registration|e-?mail)\b.{0,40}\b(love|great|nice|appreciate|perfect|thank|best|awesome|privacy|private)|(love|great|nice|appreciate|perfect|best)\b.{0,40}\b(no|without( an?)?|don.?t need( an?)?|doesn.?t require( an?)?)\s?(account|sign ?up|log ?in|registration)",
}
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); total[store] += 1
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes: continue
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': r.get('rating'), 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'text': t})
            for k in modes:
                stats[k][r.get('rating')] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}')
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{OUT}/mode-stats.txt', 'w') as f:
    f.write(f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}\n\n{'mode':20}{'n':>6}{'apps':>5}{'A':>6}{'P':>6}{'N':>6}{'1★%':>6}{'mean':>6}\n")
    for k in sorted(stats, key=lambda k: -sum(stats[k][s] for s in 'APN')):
        c = stats[k]; n = sum(c[s] for s in 'APN'); mean = sum(c[s]*s for s in range(1, 6))/n
        f.write(f"{k:20}{n:6}{len(apps[k]):5}{c['A']:6}{c['P']:6}{c['N']:6}{100*c[1]/n:6.1f}{mean:6.2f}\n")
print(open(f'{OUT}/mode-stats.txt').read())
