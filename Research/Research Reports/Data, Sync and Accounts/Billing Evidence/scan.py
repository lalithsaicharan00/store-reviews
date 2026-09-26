"""Full-corpus screen for billing / entitlement topics (topic 2). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'RESTORE': r"restor\w* (my |the )?(purchase|premium|subscription|membership|pro|plus|lifetime)|restore button|restore purchases?",
 'PAID_STILL_LOCKED': r"(paid|bought|purchased|subscribed|upgraded)\b.{0,60}\b(still|again|keeps?|asks?|asking|says?|shows?)\b.{0,30}\b(pay|premium|upgrade|subscribe|locked|free version|paywall)",
 'PREMIUM_LOST': r"(premium|pro|subscription|purchase|lifetime|plus|membership|full version)\b.{0,40}\b(disappeared|is gone|was gone|got lost|vanished|was removed|reset|revoked|not recogni[sz]ed|isn.?t recogni[sz]ed|no longer (active|valid|works?))",
 'LIFETIME_TO_SUB': r"(lifetime|one[- ]time|paid once|bought (it|the app|premium|pro))\b.{0,120}\b(subscription|subscribe|pay again|monthly|yearly|annual)",
 'CROSS_DEVICE': r"(ipad|mac|macbook|apple watch|tablet|other device|second device|another device|new phone|new iphone|new device)\b.{0,50}\b(premium|purchase|subscription|pro version|paid|pay again|buy again|restore)",
 'CROSS_OS': r"(android|google play|play store)\b.{0,80}\b(iphone|ios|app store|apple)\b.{0,60}\b(pay|purchase|premium|subscription|restore|transfer)|(iphone|ios|app store|apple)\b.{0,80}\b(android|google play|play store)\b.{0,60}\b(pay|purchase|premium|subscription|restore|transfer)",
 'FAMILY': r"family (sharing|plan|share|member)",
 'CHARGED_TWICE': r"charged (me )?(twice|two times|double|again)|double[- ]charged|duplicate (charge|payment)|paid twice|pay(ing)? twice",
 'TRIAL': r"(free )?trial\b.{0,80}\b(charged|charge me|cancel\w*|reminder|notif\w*|forgot|without warning|automatically)",
 'CANCEL_HARD': r"(can.?t|cannot|unable to|how (do i|to)|hard to|impossible to|no way to) cancel|cancel\w* (is|was) (hard|impossible|difficult)",
 'REFUND': r"\brefund",
 'PRICE_CHANGE': r"price (increase|hike|went up|doubled|tripled)|raised (the|their) price|(increased|doubled) the price",
 'ADS_AFTER_PAY': r"(paid|premium|pro|purchased|subscribed)\b.{0,50}\b(still|again)\b.{0,20}\b(ads|advert|commercials)",
 'PURCHASE_ERROR': r"(purchase|payment|transaction) (failed|error|didn.?t go through|did not go through|is pending|pending|declined|not (going|went) through)|(can.?t|cannot|unable to|won.?t let me) (buy|purchase|pay|upgrade|subscribe)",
 'PROMO': r"promo code|offer code|redeem|coupon|gift (code|card|premium|subscription)|discount code",
 'REGIONAL_PRICE': r"(price|expensive|cost)\b.{0,40}\b(my country|in india|in brazil|region|currency|local price|exchange rate|rupees|reais|pesos|lira)",
 'WEB_PURCHASE': r"(bought|paid|purchased|subscribed) (it )?(on|through|via|from) (the |their )?(website|web|browser)",
 'EXPIRED_LOCK': r"(subscription|premium|trial|membership)\b.{0,15}\b(expired|ended|lapsed|ran out)\b.{0,60}\b(lost|locked|can.?t|cannot|data|habits|history|access)",
 'UPGRADE_DOWNGRADE': r"(upgrad|downgrad|switch)\w* (from|to) (monthly|yearly|annual|lifetime)|(monthly|yearly|annual) to (yearly|annual|lifetime|monthly)",
 'NO_ONE_TIME': r"(no|wish|want|would pay|add|offer)\b.{0,30}\b(one[- ]time|lifetime|pay once)\b.{0,30}\b(option|purchase|payment|price|version)",
 'ML_PAID_LOCKED': r"(compr[eé]|pagu[eé]|comprei|paguei|gekauft|bezahlt|achet[eé]|pay[eé]|pagato|comprato|купил|оплатил|заплатил|購入した|課金した|구매했|결제했|satın aldım|ödedim)\w*.{0,80}(premium|prémium|pro|vitalic|lifetime|suscrip|assinatura|abo|abonnement|подписк|премиум|プレミアム|プロ|프리미엄|구독|abonelik).{0,80}(no (funciona|aparece|me deja|reconoce)|não (funciona|aparece|reconhece)|nicht|pas|non|не (работает|видит|восстанав|отображ|активир)|されない|できない|안 ?(됨|돼|되)|görünmüyor|çalışmıyor)",
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
