"""Full-corpus screen for backlog #5: how big the iPad / multi-device segment is, and whether users resist
sending their data to our server. Writes candidates.jsonl, mode-stats.txt and segment-stats.txt."""
import json, re, glob, os, collections
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../..'))
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
SYNC = r"(sync|synch|link|connect|transfer|carr(y|ies) over|same account|both devices|同步|同期|동기화|연동|sincroni[zc]|synchroni|синхрон|senkron)"
IPAD = r"(\bipad|アイパッド|아이패드|айпад)"
M = {
 # --- segment ---
 'IPAD': IPAD,
 'TABLET_OTHER': r"\btablets?\b|\btableta|\btablette|タブレット|태블릿|планшет|平板",
 'IPAD_SYNC': rf"{IPAD}.{{0,80}}{SYNC}|{SYNC}.{{0,80}}{IPAD}",
 'IPAD_APP_REQ': rf"{IPAD}\s*(app|version|support|layout|optimi[sz]|interface|landscape)|(no|not available|doesn.?t work|not (optimi[sz]ed|supported)|isn.?t available|unavailable|won.?t (open|work|install)) (on|for) (the |my |an? )?{IPAD}|blown up|(landscape|split.?view|slide.?over)",
 'MAC': r"\bmac(book|os)?\b.{0,40}\b(app|version|sync)|\b(app|version) for (the )?mac\b",
 'MULTI_DEVICE': r"all (of )?my (apple )?devices|across (all )?(my )?devices|multiple devices|between (my )?devices|iphone (and|&|\+) (my )?ipad|ipad (and|&|\+) (my )?iphone|多设备|多端|複数(の)?(端末|デバイス)|여러 기기",
 # --- trust in our server ---
 'NO_ACCOUNT_PRAISE': r"(no|without( an?)?|don.?t (need|have) to( create)?( an?)?|doesn.?t (require|need|force)( you to (create|make))?( an?)?|not required to)\s?(account|sign ?-?up|sign ?-?in|log ?-?in|registration|registering|e-?mail)\b|sin (registro|cuenta|registrarse|iniciar sesi)|sem (cadastro|conta|login|registro)|ohne (anmeldung|registrierung|konto|account|login)|sans (compte|inscription|cr[ée]er de compte)|登録不要|アカウント不要|ログイン不要|登録なし|无需注册|不用注册|不需要注册|免注册|无需登录|不用登录|不需要登录|회원가입 없이|로그인 없이|가입 없이|без регистрации",
 'FORCED_ACCOUNT': r"(forc\w*|requir\w*|mandatory|compulsory|have to|had to|must)( you| me| us)? (to )?(create|make|sign ?up( for)?|register)( for)?( an?)? (account|profile|e-?mail)|can.?t (use|even open|try|access)\b.{0,25}\bwithout (an? )?(account|signing|logging|registering|creating|an e-?mail)|why (do|does|should|would) (i|you|we|one|anyone) (need|have) to (create|make|sign|register|log|give|provide)|(an? )?(account|sign ?-?up|registration|login|log ?-?in) (is )?(required|mandatory|compulsory|necessary) (to|before|just)|要求注册|必须注册|强制注册|必须登录|强制登录|要注册才|注册才能|登录才能|アカウント登録(が|を)?(必須|しないと|させ)|登録しないと使え|会員登録が必須|회원가입(을)? 해야|가입해야|가입을 강요|obligatorio (registrarse|crear|iniciar)|obligan a (registrar|crear)|obligatório (criar|cadastr|fazer login)|obriga (a )?(criar|fazer|cadastr)|obligatoire de (cr[ée]er|s.inscrire)|oblig[ée]e? de (cr[ée]er|s.inscrire)|zwingt?\b.{0,20}\b(konto|registr|anmeld)|muss (man )?(sich )?(ein )?(konto|registr|anmeld)|обязательн\w* регистрац",
 'SERVER_DISTRUST': r"(my|our|user|users.?|personal|private) (data|info\w*|habits|entries)\b.{0,40}\b(server|cloud|upload\w*|sent|send\w*|stor\w*|leav\w*)|\b(upload|send|sent|stor|sav)\w*\b.{0,30}\b(to|on|in) (your|their|the company.?s|the developer.?s|an? external|third.party|someone.?s|some) (server|cloud)|(don.?t|do not|never) (trust|want)\b.{0,40}\b(cloud|server|online|upload|third)|end.to.end|\be2ee\b|\bencrypt\w*|zero.knowledge",
 'LOCAL_ONLY': r"(stor|kept|keep|sav|stay)\w* (only |all )?(locally|on (my|the|your) (phone|device|iphone|ipad))|local(ly)?[- ]only|offline[- ]only|(no|without) (cloud|server|internet (connection )?(needed|required))|data (never )?leaves|doesn.?t (upload|send|collect) (my|any|your)|本地(存储|保存)|端末内|ローカル(保存|のみ|に保存)|기기에만|lokal (gespeichert|speicher)|stock\w* localement|(guard|almacen)\w* localmente|armazena\w* localmente",
 'ICLOUD': r"icloud|アイクラウド",
 'ICLOUD_PREF': r"icloud\b.{0,40}\b(instead|rather|prefer|only|option|please|would be|wish)|(instead of|rather than|prefer|why not|just use|please (add|use|support)|wish)\b.{0,40}\bicloud|(my own|own) (icloud|cloud|google drive|drive|dropbox|storage)|用icloud|iCloudで同期|iCloud(に|で)(保存|バックアップ|同期)",
 'PRIVACY_POS': r"(privacy|private)\b.{0,40}\b(love|great|appreciate|respect|focused|first|friendly|thank|conscious|matters)|(love|great|appreciate|respect\w*|thank\w*)\b.{0,40}\b(privacy|private)|no (tracking|data collection)|doesn.?t (track|collect) (me|my|any|your)|隐私|プライバシー|개인정보|datenschutz|privacidad|privacidade|confidentialit|конфиденциальн",
}
PAID = re.compile(r"\bpaid|\bbought|purchas|premium|\bpro version|\bpro\b|subscri|lifetime|付费|购买|会员|課金|購入|有料|결제|구매|유료|pagu[ée]|compr[ée]|pagando|gekauft|bezahl|achet[ée]|payant|купил|оплатил|abonnement|suscrip|assinatura|assinei", I)
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
base_rating, base_paid, per_app = collections.Counter(), collections.Counter(), collections.defaultdict(collections.Counter)
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
            per_app[f'{store}{m.group(1)}']['n'] += 1
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes: continue
            for k in modes: per_app[f'{store}{m.group(1)}'][k] += 1
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': rt, 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'paid': paid, 'text': t})
            for k in modes:
                stats[k][rt] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}')
                stats[k]['paid_' + store] += paid
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{OUT}/mode-stats.txt', 'w') as f:
    f.write(f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}\n")
    f.write(f"baseline paid-word rate: " + ', '.join(f"{s} {100*base_paid[s]/total[s]:.2f}%" for s in 'APN') + "\n")
    f.write("baseline mean rating: " + ', '.join(f"{s} {sum(k[1]*v for k, v in base_rating.items() if k[0]==s and k[1])/total[s]:.2f}" for s in 'APN') + "\n\n")
    f.write(f"{'mode':18}{'n':>6}{'apps':>5}{'A':>6}{'P':>6}{'N':>6}{'A per10k':>9}{'1★%':>6}{'mean':>6}{'A paid%':>8}\n")
    for k in sorted(stats, key=lambda k: -sum(stats[k][s] for s in 'APN')):
        c = stats[k]; n = sum(c[s] for s in 'APN'); mean = sum(c[s]*s for s in range(1, 6))/n
        f.write(f"{k:18}{n:6}{len(apps[k]):5}{c['A']:6}{c['P']:6}{c['N']:6}{1e4*c['A']/total['A']:9.1f}{100*c[1]/n:6.1f}{mean:6.2f}{100*c['paid_A']/max(c['A'],1):8.1f}\n")
json.dump({k: dict(v) for k, v in per_app.items()}, open(f'{OUT}/per-app.json', 'w'))
print(open(f'{OUT}/mode-stats.txt').read())
