"""Find self-declared payers in both stores with the SAME patterns, and count what their reviews mention.

Run from Research/:  python -I "../Android/Docs/Research/Android Plus Evidence/scan_payers.py"
Writes payers_play.jsonl, payers_app.jsonl and comention.md.
Citation: P<app#>#<line> / A<app#>#<line>, line 0-based in that app's reviews.jsonl.
"""
import json, os, re, sys
from collections import Counter

ROOT = os.getcwd()
OUT = os.path.join(ROOT, "..", "Android", "Docs", "Research", "Android Plus Evidence")

PAYER = re.compile("|".join([
    # English, first person or explicit paid status
    r"\b(i|we)\s*(have|'ve|’ve|had|just|already|finally|actually|even|also)?\s*(paid|bought|purchased|subscribed|upgraded|unlocked)\b",
    r"\bpaid (for|the|a|\$|€|£|¥|₹|\d)",
    r"\b(bought|purchased|buying|got|get) (the |a |their )?(premium|pro|plus|full version|lifetime|paid version|subscription|upgrade|license|licence)\b",
    r"\b(premium|pro|paying|paid|lifetime|plus|gold) (user|member|subscriber|customer|account|version user)s?\b",
    r"\b(my|the) (premium|pro|lifetime|paid) (subscription|membership|purchase|license|licence|version|account)\b",
    r"\bworth (every penny|the money|paying|the price|the purchase|the cost)\b",
    r"\bi('m| am) (a )?(premium|pro|paying|paid|lifetime|plus)\b",
    # Other languages (first-person purchase verbs)
    r"\b(ich habe|hab|habe)\b[^.!?]{0,40}\b(gekauft|bezahlt|erworben|abonniert)\b", r"\bpremium[- ]?(nutzer|kunde|mitglied)\b",
    r"\b(pagu[ée]|compr[ée]|adquir[íi]|me suscrib[íi]|soy (usuario )?premium)\b",
    r"\bj'ai (pay[ée]|achet[ée]|pris l'abonnement|souscrit)\b",
    r"\b(paguei|comprei|assinei|sou premium)\b",
    r"\bho (pagato|acquistato|comprato)\b",
    r"\b(купил|купила|заплатил|заплатила|оплатил|оплатила|приобрел|приобрела)\b",
    r"課金し(た|まし)|購入し(た|まし)|買い切り(版)?を?(購入|買)|買いました|プレミアム(会員)?に(なり|登録)",
    r"결제했|구매했|결제 했|구매 했|유료 결제",
    r"付费了|购买了|买了(会员|永久|终身)|开了会员|充了会员|已付费",
    r"\b(betaald|gekocht)\b", r"\b(zapłaciłem|zapłaciłam|kupiłem|kupiłam)\b", r"\b(satın aldım|ödedim)\b",
]), re.I)

TOPICS = {
    "one-time / lifetime / no subscription": r"life ?time|one[- ]time|one[- ]off|onetime|pay once|paid once|buy once|single (payment|purchase)|no subscription|not a subscription|without (a )?subscription|instead of (a )?subscription|買い切り|einmal(ig|zahlung)|lebenslang|lebenslange|vitalici|de por vida|pago único|à vie|paiement unique|pagamento único|una tantum|навсегда|пожизненн|永久|终身|평생|영구",
    "no ads": r"\bads?\b|advert|werbung|anuncio|publicit|pubblicit|広告|광고|广告|реклам",
    "sync / other devices / tablet / computer": r"\bsync|synchron|tablet|\bipad|another device|other device|multiple devices|several devices|all (my )?devices|second phone|both (my )?(phones|devices)|cross[- ]?(device|platform)|\bmac\b|macbook|desktop|computer|\bpc\b|laptop|chromebook|web (version|app)|同期|동기화|同步|синхрон|планшет",
    "watch / Wear OS": r"smart ?watch|wear ?os|galaxy watch|apple watch|pixel watch|watch app|on (my|the) watch|watch face|complication|wearable|mi band|fitbit|garmin|ウォッチ|워치|手表|часы",
    "widgets": r"widget|ウィジェット|위젯|小组件|виджет",
    "backup / restore / export": r"back ?up|restore|google drive|icloud|\bexport|datensicherung|copia de seguridad|sauvegarde|バックアップ|백업|备份|резервн",
    "statistics / charts": r"\bstat(s|istic)|chart|graph|analytic|insight|report|statisti|統計|グラフ|통계|统计|статистик",
    "themes / colours / icons / customise": r"\btheme|colou?r|\bicons?\b|dark mode|customi[sz]|personali[sz]|テーマ|테마|主题|тем[аы]",
    "unlimited / more habits": r"unlimited|more than \d+ (habits|goals)|habit limit|limit of \d+|more habits|\d+ habits (limit|max)|unbegrenzt|ilimitad|illimit|無制限|무제한|无限|неогранич|безлимит",
    "support the developer": r"support (the |this |a |an )?(dev|developer|creator|team|indie|small)|deserve (the|my|your)? ?(money|support)|\btip\b|donat|unterstütz",
    "reminders / notifications": r"remind|notification|alarm|erinnerung|recordatorio|rappel|リマインド|通知|알림|提醒|напомин",
    "health / integrations": r"apple health|health ?kit|google fit|samsung health|health connect|shortcuts|\bsiri\b|zapier|calendar sync|strava",
}
TOPICS = {k: re.compile(v, re.I) for k, v in TOPICS.items()}


def text_of(store, r):
    if store == "P":
        return r.get("text") or ""
    return ((r.get("title") or "") + " — " + (r.get("body") or "")).strip(" —")


def scan(store, folder):
    out, n_reviews, n_apps = [], 0, 0
    base = os.path.join(ROOT, folder)
    for d in sorted(os.listdir(base), key=lambda s: int(s.split(".")[0]) if s.split(".")[0].isdigit() else 9999):
        p = os.path.join(base, d, "reviews.jsonl")
        if not os.path.exists(p):
            continue
        num = d.split(".")[0]
        n_apps += 1
        with open(p, encoding="utf-8") as f:
            for i, line in enumerate(f):
                try:
                    r = json.loads(line)
                except Exception:
                    continue
                n_reviews += 1
                t = text_of(store, r)
                if not PAYER.search(t):
                    continue
                topics = [k for k, rx in TOPICS.items() if rx.search(t)]
                out.append({
                    "cite": f"{store}{num}#{i}", "id": r["review_id"], "app": d, "rating": r.get("rating"),
                    "date": (r.get("date") or "")[:10],
                    "lang": r.get("language") or r.get("country"),
                    "topics": topics, "text": t,
                })
    return out, n_reviews, n_apps


def main():
    rows = {}
    for store, folder, name in (("P", "Play Store Reviews", "play"), ("A", "App Store Reviews", "app")):
        out, n, apps = scan(store, folder)
        rows[store] = (out, n, apps)
        with open(os.path.join(OUT, f"payers_{name}.jsonl"), "w", encoding="utf-8") as f:
            for o in out:
                f.write(json.dumps(o, ensure_ascii=False) + "\n")
        print(store, "apps", apps, "reviews", n, "payer matches", len(out), file=sys.stderr)

    lines = ["# Payer co-mentions, both stores, same patterns (machine count, not causes)", "",
             "| Mentions | Play payers | App Store payers |", "|---|---|---|"]
    tot = {s: len(rows[s][0]) for s in rows}
    cnt = {s: Counter(t for o in rows[s][0] for t in o["topics"]) for s in rows}
    for k in TOPICS:
        lines.append(f"| {k} | {cnt['P'][k]} ({100*cnt['P'][k]/tot['P']:.1f}%) | {cnt['A'][k]} ({100*cnt['A'][k]/tot['A']:.1f}%) |")
    lines.append(f"| **payer reviews (denominator)** | {tot['P']} of {rows['P'][1]} reviews, {rows['P'][2]} apps | {tot['A']} of {rows['A'][1]} reviews, {rows['A'][2]} apps |")
    with open(os.path.join(OUT, "comention.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
