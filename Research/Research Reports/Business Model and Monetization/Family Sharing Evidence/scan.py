"""Full-corpus screen for backlog #1: Apple Family Sharing for Plus. Does family sharing win sales or lose them?
Writes candidates.jsonl (to Research/Temp) and mode-stats.txt."""
import json, re, glob, os, collections
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../..'))
OUT = os.path.dirname(os.path.abspath(__file__))
TMP = os.path.join(ROOT, 'Temp', 'backlog1-family'); os.makedirs(TMP, exist_ok=True)
I = re.I
PEOPLE = r"(wife|husband|partner|spouse|girlfriend|boyfriend|son|daughter|kids?|children|child|mom|mum|dad|mother|father|family|sister|brother|parents?)"
M = {
 'FAMILY_SHARING': r"family.?shar\w*|share\w*.{0,25}with (my |the )?(whole )?family|家庭共享|家人共享|家族共有|ファミリー共有|가족 ?공유|familienfreigabe|partage familial|compartir en familia|compartid[oa] en familia|compartilhamento familiar|compartilhar com a fam[ií]lia|семейн\w* доступ|семейн\w* подписк|aile paylaş",
 'FAMILY_PLAN': r"family (plan|subscription|pack|package|license|licence|membership|tier|version|bundle|option|account)s?|household (plan|subscription|license)|家庭(套餐|会员|版|计划)|ファミリープラン|가족 ?(요금제|플랜|멤버십)|familien(abo|tarif|plan|lizenz)|plan famil|plano famil|abonnement famil",
 'BUY_AGAIN_PERSON': rf"{PEOPLE}\b.{{0,60}}\b(buy|pay|purchase|subscrib)\w*\b.{{0,25}}\b(again|twice|separately|another|their own|as well|too)\b|(buy|pay|purchas|subscrib)\w* (it |for it |again |twice |separately )*(for|with) (my |our )?{PEOPLE}\b",
 'SHARE_PURCHASE': rf"share (my |the |our |this )?(purchase|premium|subscription|pro|plus|lifetime|membership|upgrade|unlock)|(premium|subscription|purchase|lifetime|pro version|membership) (with|to) (my |our )?{PEOPLE}\b",
 'HOUSEHOLD_USE': r"(my )?(wife|husband|partner|spouse|girlfriend|boyfriend) and i (both |each )?(use|love|are using|have been using|started)|(whole|entire) family (uses|use|loves|is using|has)|we both use|my (kids|children|son|daughter|family) (use|uses|also use|love|loves) (it|this|the app)",
 'KID_PROFILES': r"(profiles?|accounts?|trackers?|users?) for (my |each |the )?(kids|children|son|daughter|family members?|child)|multiple (users|profiles|people|kids|children)|each (family member|child|kid)|(chores?|routines?) for (my )?(kids|children|son|daughter)",
}
PAID = re.compile(r"\bpaid|\bbought|purchas|premium|\bpro version|subscri|lifetime|付费|购买|会员|課金|購入|有料|결제|구매|유료|pagu[ée]|compr[ée]|gekauft|bezahl|achet[ée]|купил|оплатил|abonnement|suscrip|assinatura", I)
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
base_paid = collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); total[store] += 1
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            paid = bool(PAID.search(t)); base_paid[store] += paid
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes: continue
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': r.get('rating'), 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'paid': paid, 'text': t})
            for k in modes:
                stats[k][r.get('rating')] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}'); stats[k]['paid_' + store] += paid
with open(f'{TMP}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{OUT}/mode-stats.txt', 'w') as f:
    f.write(f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}\n")
    f.write("baseline paid-word rate: " + ', '.join(f"{s} {100*base_paid[s]/total[s]:.2f}%" for s in 'APN') + "\n\n")
    f.write(f"{'mode':18}{'n':>6}{'apps':>5}{'A':>6}{'P':>6}{'N':>6}{'1★%':>6}{'mean':>6}{'A paid%':>8}{'P paid%':>8}\n")
    for k in sorted(stats, key=lambda k: -sum(stats[k][s] for s in 'APN')):
        c = stats[k]; n = sum(c[s] for s in 'APN'); mean = sum(c[s]*s for s in range(1, 6))/n
        f.write(f"{k:18}{n:6}{len(apps[k]):5}{c['A']:6}{c['P']:6}{c['N']:6}{100*c[1]/n:6.1f}{mean:6.2f}{100*c['paid_A']/max(c['A'],1):8.1f}{100*c['paid_P']/max(c['P'],1):8.1f}\n")
print(open(f'{OUT}/mode-stats.txt').read())
