"""Free-plan data protection: does free backup cost upgrades, and what happens when backup is paywalled?
Full-corpus screen of App Store + Play reviews. Writes candidates.jsonl and mode-stats.txt here."""
import json, re, glob, os, collections
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
I = re.I
BK = r"(back ?-?ups?|backing up|sync\w*|cloud|restor\w*|バックアップ|备份|백업|respaldo|copia de seguridad|sicherung|sauvegarde|резерв\w*|backup)"
PAYW = r"(premium|\bpro\b|paid|pay\b|paying|pay for|subscri\w*|upgrade\w*|paywall\w*|plus\b|gold\b|purchase|in.?app|会員|有料|课金|付费|会员|유료|pago|bezahl\w*|payant|платн\w*|kostenpflichtig)"
GATE = r"(only|behind|locked|lock|requires?|need(s|ed)? to|have to|must|unless|exclusive|unlock|just to|in order to)"
M = {
 # backup/sync/restore behind a paywall
 'BK_PAYWALL': rf"{BK}.{{0,60}}{GATE}.{{0,40}}{PAYW}|{PAYW}.{{0,40}}{GATE}.{{0,40}}{BK}|{GATE}.{{0,30}}{PAYW}.{{0,40}}{BK}|(pay|paying|charge\w*|subscri\w*) (to|for) (back ?up|backup|sync|restore|save|keep|export|get (back|my))\b",
 # hostage / ransom language about data
 'HOSTAGE': r"(hostage|ransom\w*|extort\w*|blackmail\w*|held captive|holding (my|your|our) data|holds? (my|your) data|人質|勒索|인질|geisel|otage|рэкет|шантаж)",
 # paid / upgraded because of backup or sync
 'PAID_FOR_BK': rf"(bought|paid|purchased|upgraded|subscribed|got (the )?(premium|pro|plus)|went (premium|pro)|購入|课金|买了|결제|gekauft|compr[ée]i?)\b.{{0,80}}(for|because|just|only|mainly|mostly|so|to).{{0,40}}{BK}|{BK}.{{0,60}}(worth (it|the|paying|every)|reason (i|to) (bought|paid|upgrade|buy|pay)|why i (bought|paid|upgraded))|(would|will|happy to|glad to|gladly|willing to) (pay|buy|subscribe|upgrade).{{0,60}}{BK}",
 # free stays free because backup is free / free version good enough because of backup
 'FREE_BK_PRAISE': rf"(free|without paying|no need to pay|for free)\b.{{0,50}}{BK}|{BK}.{{0,40}}(is|are|for|even in the|in the) free\b",
 # data loss stories
 'LOSS': r"(lost|lose|losing|wiped|erased|deleted|gone|disappeared|vanished|reset)\b.{0,40}(all|my|every|whole|entire|years?|months?)\b.{0,30}(data|progress|history|habits|streaks?|records?|entries|stats|tracking)|(data|progress|history|streaks?|records?)\b.{0,30}(is|are|was|were|got|all) (gone|lost|wiped|erased|deleted)|データ.{0,10}(消え|消失|なくな)|数据.{0,6}(丢失|没了|清空|消失)|데이터.{0,10}(사라|날아|삭제)|daten.{0,20}(weg|verloren|gelöscht)|perd\w* .{0,20}(datos|dados|données)|данные.{0,20}(пропал|удал|потер)",
}
LOSS_CAUSE = re.compile(r"reinstall|re-install|uninstall|new phone|new iphone|switch(ed)? phones?|changed? phones?|factory reset|phone (broke|died|was stolen|got stolen)|lost my phone|stolen|deleted the app|delete the app|offload|update|crash", I)
PAID = re.compile(r"\bpaid|\bbought|purchas|premium|\bpro version|\bpro\b|subscri|lifetime|付费|购买|会员|課金|購入|有料|결제|구매|유료|pagu[ée]|compr[ée]|pagando|gekauft|bezahl|achet[ée]|payant|купил|оплатил|abonnement|suscrip|assinatura|assinei", I)
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
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
            if modes == ['LOSS'] and not LOSS_CAUSE.search(t): continue
            paid = bool(PAID.search(t)); rt = r.get('rating')
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': rt, 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'paid': paid, 'text': t})
            for k in modes:
                stats[k][rt] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}'); stats[k]['paid'] += paid
with open(f'{HERE}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{HERE}/mode-stats.txt', 'w') as f:
    f.write(f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}\n")
    f.write(f"{'mode':16}{'n':>7}{'apps':>6}{'A':>7}{'P':>7}{'1★%':>7}{'mean':>6}{'paid%':>7}\n")
    for k in M:
        c = stats[k]; n = c['A'] + c['P']
        if not n: continue
        mean = sum(c[s]*s for s in range(1, 6))/n
        f.write(f"{k:16}{n:7}{len(apps[k]):6}{c['A']:7}{c['P']:7}{100*c[1]/n:7.1f}{mean:6.2f}{100*c['paid']/n:7.1f}\n")
print(open(f'{HERE}/mode-stats.txt').read())
