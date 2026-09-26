"""Full-corpus screen for data-safety failures: loss, backup, sync, account, entitlement, dates.
Writes candidates.jsonl (every review that matches any mode) and mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I

# ---- building blocks -------------------------------------------------------
LOSSV = r"(lost|lose|losing|loses|gone|disappear\w*|vanish\w*|deleted|erased|wiped|got wiped|reset|resets|resetted|cleared|missing|went away|back to (zero|0|day ?(1|one))|start(ed|ing)? (over|from scratch|from zero)|no longer there|isn.?t there|not there anymore|all over again)"
OBJ = r"(data|progress|history|habits?|streaks?|records?|entries|everything|all my|stats|statistics|journal|notes?|check-?ins?|calendar|days? of|months? of|years? of|achievements?|levels?|coins|pets?|trophies|tasks?)"
LOSS_EN = rf"\b{OBJ}\b.{{0,60}}\b{LOSSV}\b|\b{LOSSV}\b.{{0,60}}\b{OBJ}\b"
LOSS_ML = "|".join([
    r"(perd[íi]|perdí|se borr|borr[óo]|desapareci|se elimin|se reinici|reinici[óo])\w*.{0,50}(datos|progreso|h[áa]bitos|racha|historial|registros|todo)",
    r"(datos|progreso|h[áa]bitos|racha|historial|registros).{0,50}(perd|borr|desapareci|elimin|reinici)",
    r"(perdi|sumiu|sumiram|apag|desaparece|zer(ou|aram|ado))\w*.{0,50}(dados|progresso|h[áa]bitos|sequ[êe]ncia|hist[óo]rico|registros|tudo)",
    r"(dados|progresso|h[áa]bitos|sequ[êe]ncia|hist[óo]rico|registros).{0,50}(perd|sumi|apag|desaparec|zer)",
    r"(daten|fortschritt|gewohnheiten|verlauf|eintr[äa]ge|alles|streak).{0,50}(verloren|weg|gel[öo]scht|verschwunden|zur[üu]ckgesetzt)",
    r"(donn[ée]es|progr[eè]s|habitudes|historique|s[ée]rie|tout).{0,50}(perdu|disparu|effac|supprim|r[ée]initialis)",
    r"(perdu|disparu|effac[ée]|supprim[ée]).{0,50}(donn[ée]es|progr[eè]s|habitudes|historique)",
    r"(dati|progressi|abitudini|cronologia|tutto|serie).{0,50}(pers[io]|spari|cancellat|azzerat)",
    r"(потерял|потеряла|пропал|пропали|удалил|удалились|исчез|сброс|обнулил)\w*.{0,50}(данн|прогресс|привычк|истори|всё|все|серии)",
    r"(データ|記録|履歴|習慣|連続).{0,15}(消え|消失|なくな|無くな|リセット|消去|飛んだ|初期化)",
    r"(数据|数據|記錄|记录|打卡|习惯|習慣).{0,15}(丢失|丟失|丢了|没了|沒了|消失|清空|不见|不見|清零|归零)",
    r"(丢失|丟失|清空|清零).{0,10}(数据|数據|记录|記錄)",
    r"(데이터|기록|습관).{0,15}(날아|사라|삭제|초기화|없어)",
    r"(verilerim|veriler|ilerleme|alışkanlık|kayıt).{0,40}(silindi|kayboldu|gitti|sıfırlan)",
    r"(data|progres|kebiasaan|riwayat).{0,40}(hilang|terhapus|ke-?reset)",
])
LOSS = re.compile(f"{LOSS_EN}|{LOSS_ML}", I)

T = {  # triggers / contexts
 'UPDATE': r"\bupdat(e|ed|es|ing)\b|new version|latest version|actualiz|atualiz|\bupdate\b|mise [àa] jour|aggiorn|обновлени|アップデート|更新后|更新後|更新了|업데이트|güncelle|pembaruan",
 'OS_UPDATE': r"\bios ?1[0-9]|\bios update|iphone update|updat\w* (my )?(iphone|phone|ios)|android (1[0-9]|update)|software update|system update|one ?ui",
 'REINSTALL': r"re-?install|uninstall|delet\w* (the |this )?app|re-?download|desinstal|reinstal|neu (install|herunter)|réinstall|переустанов|再インストール|アンインストール|入れ直|重装|卸载|重新(安装|下载)|재설치|yeniden yükle|instal ulang|offload",
 'NEW_PHONE': r"new (phone|iphone|device|samsung|pixel|android|mobile|cell)|switch\w* (my )?(phone|device)s?|chang\w* (my )?(phone|device)|phone change|upgrad\w* (my |to a )?(phone|iphone)|factory reset|reset (my|the) phone|transfer\w* (\w+ )?(to|from) (my |a |the )?(new|old)|migrat\w*|nuevo (celular|tel[ée]fono|m[óo]vil)|cambi\w* de (celular|tel[ée]fono|m[óo]vil)|novo (celular|telefone|aparelho)|troc\w* de (celular|telefone|aparelho)|neue?s? (handy|telefon|iphone|smartphone|ger[äa]t)|nouveau (t[ée]l[ée]phone|portable|smartphone)|nuovo (telefono|cellulare)|новы\w* телефон|смен\w* телефон|機種変|新しい(iphone|スマホ|端末)|换手机|換手機|新手机|換機|换机|기기 ?변경|폰 ?바꾸|yeni telefon|hp baru|ganti hp",
 'LOGOUT': r"log(ged|ging)? ?(out|off)|sign(ed|ing)? ?out|logged (back )?in|signed (back )?in|log (back )?in|sign (back )?in|switch\w* accounts?",
 'CLEARDATA': r"clear\w* (the )?(app ?)?(cache|data|storage)|cleaner|storage (full|space)|offload",
 'PAYWALL_LOSS': r"(subscription|premium|trial|pro|membership|plus)\b.{0,50}\b(expir|ended|ends|cancel|lapse)",
 'CRASH_OPEN': r"(won.?t|doesn.?t|does not|can.?t|cannot|will not|refuses to) (even )?(open|load|start|launch)|crash\w* (on|at|when|upon) (open|launch|start)|stuck on (the )?(loading|splash)|black screen|white screen|corrupt",
}
T = {k: re.compile(v, I) for k, v in T.items()}

M = {  # standalone modes (not dependent on LOSS)
 'NO_BACKUP': r"(no|without|lack of|missing|needs?|wish|add|want|please|there.?s no|isn.?t (a|an)|doesn.?t have (a|an)?) ?.{0,25}\b(back ?up|backup|export|import)\b|\b(back ?up|export)\b.{0,30}\b(feature|option|function)\b",
 'RESTORE_FAIL': r"(restor\w*|import\w*|back ?up\w*)\b.{0,50}\b(fail\w*|doesn.?t work|didn.?t work|not work\w*|broken|error|won.?t|can.?t|cannot|unable|nothing|empty)|(fail\w*|unable|can.?t|cannot|couldn.?t|won.?t)\b.{0,30}\b(restor\w*|import\w*)\b",
 'CLOUD_BACKUP': r"google drive|icloud|dropbox|onedrive|cloud (backup|sync|save|storage)",
 'EXPORT_FMT': r"\b(csv|excel|xlsx|pdf|json|spreadsheet)\b.{0,40}\b(export|download|backup)|\b(export|download)\w*\b.{0,40}\b(csv|excel|xlsx|pdf|json|spreadsheet)\b",
 'SYNC_FAIL': r"\bsync\w*\b.{0,60}\b(not|doesn.?t|didn.?t|isn.?t|won.?t|never|fail\w*|broken|issue|problem|bug|stopped|wrong|slow|delay\w*|random\w*|lost|overwrit\w*|duplicat\w*)|\b(not|doesn.?t|didn.?t|won.?t|never|stopped|fail\w*)\b.{0,30}\bsync\w*|sincroniz\w*.{0,40}(no|falla|problema|erro)|synchronis\w*.{0,40}(nicht|funktioniert|fehler)|同期.{0,10}(できない|されない|しない|失敗)|同步.{0,10}(失败|不了|不上|有问题)",
 'SYNC_DUP': r"duplicat\w*|double(d)? (entries|check|habits)|overwrit\w*|conflict\w*|reverted?|rolled back|went back to (an )?(old|previous)",
 'MULTI_DEVICE': r"\b(ipad|tablet|apple watch|watch|mac|macbook|desktop|computer|pc|laptop|windows|web ?(app|version|site)|browser|chromebook|wear ?os|galaxy watch)\b.{0,50}\b(sync\w*|version|app|access|use|work|support)",
 'CROSS_PLATFORM': r"(android|google play|play store)\b.{0,60}\b(iphone|ios|apple|app store)|(iphone|ios|apple|app store)\b.{0,60}\b(android|google play|play store)",
 'WIDGET_STALE': r"widget\w*\b.{0,50}\b(not|doesn.?t|don.?t|won.?t|never|stopped|fail\w*)\b.{0,20}\b(updat\w*|refresh\w*|sync\w*|show\w*|match|reflect)|widget\w*\b.{0,40}\b(out of sync|wrong|old|stale|delay\w*|lag\w*)",
 'WATCH_SYNC': r"(apple watch|\bwatch\b|wear ?os|galaxy watch|fitbit|garmin)\b.{0,60}\b(sync\w*|not (updat|show|work)|doesn.?t (updat|show|work)|out of sync)",
 'FORCED_LOGIN': r"(forc\w*|requir\w*|have to|must|need to|make you|makes you|mandatory|compulsory)\b.{0,30}\b(sign ?up|sign ?in|log ?in|creat\w* (an )?account|register|registration|account|email)|(why|no).{0,20}(do i need|need) (an )?account|without (an )?(account|sign|log)",
 'LOGIN_FAIL': r"(can.?t|cannot|couldn.?t|unable to|won.?t let me|not able to|doesn.?t let me)\b.{0,20}\b(log ?in|sign ?in|login|access my account|verify|reset (my )?password)|(verification|confirmation|magic link|code|otp) (email|mail|link|code)?.{0,30}(never|not|didn.?t) (arriv|receiv|come|came|sent)|locked out|account (disappeared|deleted|gone|missing|not found|suspended|banned)",
 'NO_ACCOUNT': r"(no|there.?s no|without|doesn.?t have|lack of|need|needs|wish|add|please)\b.{0,15}\b(account|login|log ?in|sign ?in|user profile)\b.{0,40}\b(transfer|move|backup|restore|save|switch|new phone|sync|device)",
 'ACCOUNT_DELETE': r"(delet\w*|remov\w*|clos\w*|cancel\w*) (my |the )?account|account deletion|right to be forgotten|gdpr",
 'PURCHASE_RESTORE': r"restor\w* (my )?(purchase|premium|pro|subscription|membership|plus|lifetime)|(purchase|premium|pro|subscription|membership|lifetime|paid (version|features?)|full version)\b.{0,70}\b(lost|gone|disappear\w*|not (recogni[sz]ed|restor\w*|showing|working|transfer\w*|carry|unlock\w*)|doesn.?t (restor|transfer|carry|recogni[sz]|show|work|unlock)|reset|revok\w*|asks? me to (pay|buy|purchase)|wants me to pay)|(pay|buy|purchase|charged?)\w*\b.{0,15}\b(again|twice|second time|a second|two times)",
 'PAY_CROSS_OS': r"(android|google play|play store|iphone|ios|app store)\b.{0,80}\b(pay\w* again|buy\w* again|purchase\w* again|separately|not transfer|doesn.?t transfer|twice|pay for (it )?on)",
 'LIFETIME_REVOKED': r"(lifetime|one[- ]time|paid once|bought (it|the app)|lifelong)\b.{0,80}\b(now|suddenly)?\b.{0,20}\b(subscription|pay again|revok\w*|no longer|removed|lost|taken away|monthly|asks? (me )?to pay)",
 'CHARGED_NOT_UNLOCKED': r"(charged|paid|payment went through|bought|purchased)\b.{0,60}\b(but|and)\b.{0,40}\b(not|no|still|never|didn.?t|doesn.?t|haven.?t)\b.{0,25}\b(unlock\w*|premium|pro|access|activated?|work\w*|get|receive\w*|features?)",
 'AUTO_REFUND': r"(refunded|cancel\w*|revers\w*)\b.{0,40}\b(automatic\w*|by itself|after (\w+ )?(days|3 days|three days))|purchase (was )?(cancel\w*|refunded) (automatic|by)|pending (purchase|payment|transaction)|payment (is )?pending",
 'FAMILY': r"family (shar\w*|plan)|shared with (my )?(family|wife|husband|partner|kids)",
 'TIMEZONE': r"time ?zone|timezone|travel\w*\b.{0,40}\b(day|streak|habit|date|reset|broke|lost)|daylight saving|\bdst\b|zona horaria|fuso hor[áa]rio|zeitzone|fuseau horaire|時差|タイムゾーン|时区",
 'DATE_WRONG': r"(wrong|incorrect|off by one|previous|next) (day|date)|(day|date)\b.{0,20}\b(wrong|incorrect|shifted|off by)|marks? (it )?(for|as|on) (the )?(next|previous|wrong) day|(midnight|12 ?am|day (starts?|ends?|change|rollover))\b.{0,40}\b(reset|wrong|lost|broke|count|streak|previous)",
 'STREAK_WRONG': r"streak\w*\b.{0,50}\b(reset\w*|broke|broken|lost|wrong|incorrect|glitch\w*|bug\w*|disappear\w*|went (to|back to) (0|zero|1))\b.{0,60}\b(even though|although|but i|despite|for no reason|randomly|glitch|bug|without|didn.?t miss|never missed|did it|completed|checked)",
 'SLOW_WITH_DATA': r"(slow|lag\w*|sluggish|takes? forever|freez\w*|crash\w*)\b.{0,60}\b(many|lots of|more|too many|a lot of|large|years? of|months? of|history|habits|entries|data)|(many|lots of|more|too many|a lot of|years? of|months? of) (habits|entries|data|history)\b.{0,40}\b(slow|lag\w*|freez\w*|crash\w*)",
 'OFFLINE': r"(requires?|needs?|need|have to have|only works (with|online)|must be) (an |a )?(internet|wifi|wi-fi|connection|online|data connection)|(doesn.?t|does not|won.?t|can.?t|cannot) (work|open|load|use it|save)\b.{0,15}\b(offline|without (internet|wifi|wi-fi|connection|signal|data))|offline (mode|use|support)|\boffline\b",
 'PRIVACY': r"(sell\w*|sold|harvest\w*|collect\w*|share\w* with)\b.{0,30}\b(my |your |user |personal )(data|information|info)\b|privacy (policy|concern\w*|issue\w*|nightmare|invasi\w*)|invasi\w* of privacy|encrypt\w*|where (is )?(my )?data (is )?(stored|kept|go\w*)|data safety|(no|without) (tracking|ads and tracking)|stays? on (my )?(device|phone)|local[- ]only|stored locally",
 'POS_MIGRATE': r"(everything|all (of )?my (data|habits|progress|history|streaks?)|my (data|habits|progress|history|streaks?))\b.{0,20}\b(was|were|is|are|came|carried|transferred|synced|restored)\b.{0,20}\b(still )?(there|over|back|intact|perfectly|seamlessly)|restor\w* (perfectly|flawlessly|seamlessly|everything|all my)|sync\w* (perfectly|flawlessly|seamlessly|instantly|without (any )?(issue|problem))|(new phone|new iphone|switched phones?|reinstall\w*)\b.{0,60}\b(still (there|had)|didn.?t lose|did not lose|nothing (was )?lost|all there|came back|restored)",
 'DELETE_NO_UNDO': r"(accidental\w*|by mistake|mistakenly|accidentally|misclick\w*|fat[- ]finger\w*)\b.{0,50}\b(delet\w*|remov\w*|archiv\w*|reset\w*|swip\w*|uncheck\w*|clear\w*)|\bno undo\b|(can.?t|cannot|no way to|unable to) (undo|recover|restore|get (it|them) back)|confirm\w* (before|when) delet\w*",
 'ABANDONED': r"(no longer|stopped|isn.?t|not) (supported|maintained|being updated|updated)|abandon\w*|(server|servers|service)\b.{0,30}\b(shut ?down|down|offline|discontinued|closed)|(app|developer)\b.{0,20}\b(discontinu\w*|shut ?down|went away|gone)|removed from (the )?(app ?store|play ?store)",
}
M = {k: re.compile(v, I) for k, v in M.items()}

cands = []
stats = collections.defaultdict(lambda: collections.Counter())
apps_by_mode = collections.defaultdict(set)
total = collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'):
            continue
        app = os.path.basename(d.rstrip('/'))
        with open(d + 'reviews.jsonl', encoding='utf-8') as fh:
            for i, l in enumerate(fh):
                if not l.strip():
                    continue
                r = json.loads(l)
                total[store] += 1
                t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
                modes = []
                if LOSS.search(t):
                    modes.append('LOSS')
                    ctx = [k for k, rx in T.items() if rx.search(t)]
                    modes += ['LOSS+' + k for k in ctx] or ['LOSS+UNEXPLAINED']
                modes += [k for k, rx in M.items() if rx.search(t)]
                if not modes:
                    continue
                rec = {'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                       'rating': r.get('rating'), 'date': (r.get('date') or '')[:10],
                       'loc': r.get('country') or r.get('language'), 'ver': r.get('app_version'), 'modes': modes, 'text': t}
                cands.append(rec)
                for k in modes:
                    stats[k][r.get('rating')] += 1
                    stats[k][store] += 1
                    apps_by_mode[k].add(f'{store}{m.group(1)}')

with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands:
        f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{OUT}/mode-stats.txt', 'w') as f:
    f.write(f"total reviews screened: {dict(total)} = {sum(total.values())}\ncandidates: {len(cands)}\n\n")
    f.write(f"{'mode':28} {'n':>7} {'apps':>5} {'A':>6} {'P':>7} {'N':>6} {'1★%':>5} {'mean':>5}\n")
    for k in sorted(stats, key=lambda k: -sum(stats[k][s] for s in 'APN')):
        c = stats[k]; n = sum(c[s] for s in 'APN')
        mean = sum(c[s] * s for s in range(1, 6)) / max(1, sum(c[s] for s in range(1, 6)))
        f.write(f"{k:28} {n:7} {len(apps_by_mode[k]):5} {c['A']:6} {c['P']:7} {c['N']:6} {100*c[1]/n:5.1f} {mean:5.2f}\n")
print(open(f'{OUT}/mode-stats.txt').read())
