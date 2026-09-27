"""Full-corpus screen for backlog #4 (sign-in prompts) and the backup guarantee: do repeated sign-in or backup
prompts annoy people, and how well do iCloud and Google Drive work for backup and multi-device sync?
Writes candidates.jsonl and mode-stats.txt to Research/Temp/backlog4-signin/."""
import json, re, glob, os, collections
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
OUT = os.path.join(ROOT, 'Temp', 'backlog4-signin'); os.makedirs(OUT, exist_ok=True)
I = re.I
ACCT = r"(sign(ing)? ?-?(in|up|on)|log(ging)? ?-?in|create an? account|creating an? account|make an? account|register(ing)?|registration|an account|my account|account creation|subscribe to (the )?newsletter)"
NAGW = r"(keeps? (asking|prompting|popping|bugging|nagging|pushing|telling|reminding|making|forcing)|constantly|repeatedly|every (single )?time|over and over|again and again|non.?stop|annoying|nag\w*|pester\w*|spam\w*|harass\w*|pushy|begging|persistent|incessant\w*)"
BACK = r"(back ?-?ups?|backing up|icloud|google drive|sync\w*)"
DRIVE = r"(google ?drive|\bg ?drive\b|google ?disk|googleドライブ|グーグルドライブ|구글 ?드라이브|谷歌云(盘|端硬盘)|google 云端硬盘|гугл ?диск|google ?диск|google ?unidad)"
FAILW = r"(fail\w*|didn.?t work|doesn.?t work|does not work|not work\w*|won.?t|can.?t|cannot|couldn.?t|lost|gone|empty|missing|disappear\w*|broken|error|stuck|never)"
M = {
 'SIGNIN_NAG': rf"{NAGW}.{{0,50}}{ACCT}|{ACCT}.{{0,40}}(pop.?ups?|prompts?|reminders?|screens?|banners?)\b.{{0,30}}{NAGW}|pop.?ups?\b.{{0,40}}{ACCT}|{ACCT}.{{0,40}}pop.?ups?|反复.{{0,6}}(登录|注册)|一直.{{0,6}}(登录|注册)|总是.{{0,6}}(登录|注册)|何度も.{{0,10}}(ログイン|登録|サインイン)|しつこ.{{0,20}}(ログイン|登録|アカウント)|(ログイン|登録|アカウント).{{0,20}}しつこ|계속.{{0,10}}(로그인|가입)|immer wieder.{{0,30}}(anmeld|registr|konto)|st[äa]ndig.{{0,30}}(anmeld|registr|konto)|constantemente.{{0,30}}(registr|iniciar sesi|cuenta|login)|toda hora.{{0,30}}(login|cadastr|conta)|sans cesse.{{0,30}}(compte|connect|inscri)|постоянно.{{0,30}}(регистр|вход|аккаунт)",
 'SIGNIN_NO_SKIP': rf"(can.?t|cannot|no way to|no option to|unable to|won.?t let me|doesn.?t let me|impossible to)\s(skip|dismiss|close|get past|bypass|turn off|disable|remove|get rid of)\b.{{0,50}}{ACCT}|{ACCT}.{{0,50}}(can.?t|cannot|no way to|no option to|unable to)\s(skip|dismiss|close|get past|bypass)",
 'BACKUP_NAG': rf"{NAGW}.{{0,40}}{BACK}|{BACK}.{{0,40}}(pop.?ups?|prompts?|reminders?|notifications?|banners?|warnings?)\b.{{0,30}}{NAGW}",
 'NO_NAG_PRAISE': r"(no|without|never|zero|doesn.?t|does not|isn.?t|not)\s(annoying |constant |intrusive )?(nag\w*|pester\w*|pushy|pop.?ups|upsell\w*|pressure)|(doesn.?t|does not|never) (force|push|bug|nag) (you|me)",
 'ICLOUD_SYNC': r"icloud.{0,60}(sync|synch|同期|同步|동기화|sincroni|synchroni|синхрон)|(sync|synch|同期|同步|동기화|sincroni|synchroni|синхрон)\w*.{0,60}icloud",
 'ICLOUD_BACKUP': r"icloud.{0,60}(back ?-?ups?|backing up|restor\w*|バックアップ|备份|백업|respaldo|copia de seguridad|sicherung|sauvegarde|резерв)|(back ?-?ups?|backing up|restor\w*|バックアップ|备份|백업|respaldo|copia de seguridad|sicherung|sauvegarde|резерв).{0,60}icloud",
 'DRIVE_SYNC': rf"{DRIVE}.{{0,60}}(sync|synch|同期|同步|동기화|sincroni|synchroni|синхрон)|(sync|synch|同期|同步|동기화|sincroni|synchroni|синхрон)\w*.{{0,60}}{DRIVE}",
 'DRIVE_BACKUP': rf"{DRIVE}.{{0,60}}(back ?-?ups?|backing up|restor\w*|バックアップ|备份|백업|respaldo|copia de seguridad|sicherung|sauvegarde|резерв|backup)|(back ?-?ups?|backing up|restor\w*|バックアップ|备份|백업|respaldo|copia de seguridad|sicherung|sauvegarde|резерв|backup).{{0,60}}{DRIVE}",
 'DRIVE_AUTH': rf"{DRIVE}.{{0,60}}(permission|sign.?in|log.?in|access|connect\w*|authori[sz]\w*|account|login)|(permission|sign.?in|log.?in|access|connect\w*|authori[sz]\w*|login)\b.{{0,40}}{DRIVE}",
 'CLOUD_BACKUP_FAIL': rf"(icloud|{DRIVE}|cloud).{{0,60}}(back ?-?ups?|restor\w*).{{0,60}}{FAILW}|(back ?-?ups?|restor\w*).{{0,40}}(icloud|{DRIVE}|cloud).{{0,60}}{FAILW}",
}
PAID = re.compile(r"\bpaid|\bbought|purchas|premium|\bpro version|\bpro\b|subscri|lifetime|付费|购买|会员|課金|購入|有料|결제|구매|유료|pagu[ée]|compr[ée]|pagando|gekauft|bezahl|achet[ée]|payant|купил|оплатил|abonnement|suscrip|assinatura|assinei", I)
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
base_rating, base_paid = collections.Counter(), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); total[store] += 1
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            paid = bool(PAID.search(t)); rt = r.get('rating')
            base_rating[(store, rt)] += 1; base_paid[store] += paid
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes: continue
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': rt, 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'paid': paid, 'text': t})
            for k in modes:
                stats[k][rt] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}')
                stats[k]['paid_' + store] += paid
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{HERE}/mode-stats.txt', 'w') as f:
    f.write(f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}\n")
    f.write("baseline paid-word rate: " + ', '.join(f"{s} {100*base_paid[s]/total[s]:.2f}%" for s in 'APN') + "\n")
    f.write("baseline mean rating: " + ', '.join(f"{s} {sum(k[1]*v for k, v in base_rating.items() if k[0]==s and k[1])/total[s]:.2f}" for s in 'APN') + "\n\n")
    f.write(f"{'mode':18}{'n':>6}{'apps':>5}{'A':>6}{'P':>6}{'N':>6}{'1★%':>6}{'mean':>6}{'paid%':>7}\n")
    for k in sorted(stats, key=lambda k: -sum(stats[k][s] for s in 'APN')):
        c = stats[k]; n = sum(c[s] for s in 'APN'); mean = sum(c[s]*s for s in range(1, 6))/n
        f.write(f"{k:18}{n:6}{len(apps[k]):5}{c['A']:6}{c['P']:6}{c['N']:6}{100*c[1]/n:6.1f}{mean:6.2f}{100*sum(c['paid_'+s] for s in 'APN')/n:7.1f}\n")
print(open(f'{HERE}/mode-stats.txt').read())
