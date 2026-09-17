# -*- coding: utf-8 -*-
"""Stage 3 merge for report 68 (Ultiself | Self-Improvement, Ultiself Corporation)."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C287", "dont", "Never answer a cancellation request with a retention offer — cancel first, confirm, stop billing; an offer may follow, never replace, the cancellation",
    "Report 68 (Ultiself, 4,511 reviews): SUP_RETENTION 85 (1.88%, mean 1.34) — 'Their support ignores cancellation requests and instead promotes paid upgrades' (ua); 'they kept replying with new offers'; 'Nick keeps giving me offers I simply don't want' (by, 1★); 'they will not honor your request immediately but instead apply pressure to get you to stay' (2022) — alongside SUP_NONE 352 (7.80%), email-only cancellation and web billing invisible to iOS, the offer-instead-of-cancel reply is what turns a cancellation into a card block or bank dispute (MON_ESCALATE 189, 4.19%) and a charge after cancelling (226, 5.01%: 'receiving confirmation from support that subscription was cancelled, they will continue charging my card'); in 2026 named agents who cancelled, refunded and sometimes gifted lifetime turned complainants into 5★ — §8.3: 'Process the request before making any retention offer… it should not depend on reaching a named agent'. Related: [[C112]] (in-app cancellation), [[C215]] (support faster than the deadline), [[C036]], [[C180]] (no 'wait, don't go' offers on the paywall).")

ext("C210", " Report 68 (Ultiself): the same chain across 87 storefronts — purchase on a website or in-funnel Apple Pay / PayPal / card → not in Apple's subscription list → the in-app 'Manage subscription' button opens Apple's list anyway (BUG_MANAGE_SUB 60, from 2025-03-14: 'button directs to the App Store, but the actual subscription is handled outside via their website, to which access is blocked') → email-only cancellation → retention offers or silence → the charge recurs; MON_WEB_BILLING 303 (6.72%), 26.3% of Belarus reviews (two of its reviews are the most-voted complaints: 'DOES NOT show their active subscription'); U_BILLING_COMPLAINT 1,434 (31.79%, mean 1.12) in 88.2% of 1–2★; the listing says only 'charged to your iTunes account… Monthly and Yearly'; §8.1: route Manage subscription to wherever the subscription is billed and add in-app cancellation for web subscriptions.")
ext("C112", " Report 68 (Ultiself): MON_CANCEL_HARD 592 (13.12%, mean 1.10) — 'you can't unsubscribe by your own, you have to email them' (kz); cancellation emails sent on time and ignored; 'Cela fait 2 mois que je demande l'annulation de mon abonnement'; a Manage-subscription button that leads nowhere for web buyers.")
ext("C285", " Report 68 (Ultiself): a small intro plan ($6–10) followed on the next screen by add-on charges — the number 57 appears in 60 reviews, 58 describing an unrequested extra charge ('along with the $9.92 charge, another $57 has been taken'; 'Кликнул на кнопку списало еще 57$ кликнул на другую кнопку еще 28$'; 'AUTOMATIQUEMENT vous venez d'acheter 3 PROGRAMMES SUPPLÉMENTAIRES, sans confirmation bancaire'); a decline button worded to shame — 'no I do not wish to improve my health'; 'Los botones estaban puestos de manera engañosa y confusa'; MON_ADDON lift 10.14× among purchasers; §8.2: no charge without an explicit second confirmation and a neutral 'No thanks'.")
ext("C054", " Report 68 (Ultiself): in 2026 named support agents ('Nick', 'Emma', 'Michael', 'Sam') resolved complaints with refunds and free lifetime access and asked for reviews — 14 of 45 E6 named-agent reviews report a refund or gift ('He canceled my subscription, issued a refund, and even upgraded me to lifetime access'); 'My feedback goes to Michael who asked me to write it'; 'Please post one review per day' inside a 5★; PR_SUPPORT rose from 9 reviews before 2025-10 to 62 of 1,238 after; §8.4: stop asking support contacts for reviews.")
ext("C076", " Report 68 (Ultiself): E5 (Apr–Sep 2025) holds 2,363 of 4,511 reviews (394 a month vs ~100 either side, mean 4.03 vs 2.23 before) with 230 of 238 generated author names ('nashayla*mogenot@1987qmnp'), 59 of 60 bodies using a look-alike letter 'ọ' to evade duplicate detection, most cross-author duplicate bodies (identical one-liners the same day in Mexico and Uzbekistan) and 1,544 of 1,885 very short 5★; Hebrew, Kazakh, Uzbek, Lithuanian and Latvian reviews almost all E5 one-liners; without E5 the corpus is 41.8% billing complaint and 47.3% praise (mean 3.02) — 'the public rating is not evidence of satisfaction'; earlier, three pairs of long identical US 5★ under different names in 2022-10 → 2023-01.")
ext("C231", " Report 68 (Ultiself): public exceeds corpus mean in 12 of 20 storefronts; kz 4.04 corpus mean but 2.38 outside E5, il 4.48 carried by 51 Hebrew 5★ one-liners, ng 4.98 all praise with 8 shared bodies and the 'post one review per day' text; the harm concentrates in ae (2.02, 72.0% billing), by (2.78, 26.3% web billing), ua (2.98) and cl (3.04 vs public 4.26) — the ua + kz + by group outside E5 is 61.5% billing against 29.9% for the US outside E5.")
ext("C029", " Report 68 (Ultiself): MON_EXTRA_CHARGE 632 (14.01%, 2021-02-28 → 2026-09-06, every era), MON_SCAM 747 (16.56%); MON_ESCALATE 189 (4.19%) — card blocks, chargebacks, reports to Apple, police, regulators and lawyers; reviewers teach each other to block the payment in their bank app (REV_TIP 5); 'Leaving is rarely the story; being unable to leave is' (deletion 8 vs escalation 189).")
ext("C109", " Report 68 (Ultiself): paid intro trials on the web that auto-convert (MON_RENEWAL_SHOCK 227, 5.03% — an intro plan becoming $39.95–$87 recurring; MON_TRIAL_CHARGED 19); §8.6: replace paid intro plans with a free trial that ends without charge unless confirmed, measuring chargebacks and 90-day retention.")
ext("C152", " Report 68 (Ultiself): no receipt or notice before charges (MON_RECEIPT 17); §8.2: show the renewal price and date on the intro-plan screen and in a receipt email.")
ext("C113", " Report 68 (Ultiself): MON_BAIT 55 (1.22%, mean 1.05) — 'Ofrecen 4 semanas a 0.35 usd la semana y resulta que cobran 9.92usd por 7 días'; 'Cada que entro a la app me da un costo diferente' (MON_PRICE_SHIFT 6); 'it takes forever to figure out how much it costs a month'.")
ext("C148", " Report 68 (Ultiself): addiction-themed Instagram / Facebook ads (drinking, smoking, vaping) leading to a general habit checklist — USE_ADDICTION 24, 23 in E6: 'This app advertises itself as a personalised program to help you reduce your drinking- it does nothing of the sort'; 'there was nothing about vaping'; a paid 'personal plan' never delivered ('No actual plan is provided'; MON_NOT_DELIVERED 17); NEG_NOT_AS_ADVERTISED 59; §8.5: addiction ads should lead to a product that addresses the addiction, or not run.")
ext("C103", " Report 68 (Ultiself): 'my first week of white knuckling sobriety, I found an ad for this app'; 'Instead of helping me to quit drinking it's making me feel like drinking even more' (OUT_HARM 2) — an addiction ad that sells a generic tracker to someone in early recovery.")
ext("C286", " Report 68 (Ultiself): 'Реклама була українською мовою' (the ad was in Ukrainian) while Ukrainian (261 reviews) and Kazakh (47) are not among the 12 declared languages although ua and kz are the second- and third-largest storefronts; interfaces in Russian or Spanish with videos and notifications in English (NEG_LANG 32); §8.5: do not advertise in a language the content is not in; declare and localise Ukrainian and Kazakh if targeted.")
ext("C214", " Report 68 (Ultiself): NEG_SIMPLE 97 (2.15%, mean 1.40) 'just a manual checklist' — thin union 137 (3.04%), 32 of them also objecting to price; lift 4.15× among purchasers.")
ext("C056", " Report 68 (Ultiself): 'I don't really see where the AI is supposed to be working' — personalisation that feels generic (NEG_AI_POOR 23); PR_AI 20 (15 in E6) against NEG_AI_CONTENT 8 (all E6); §8.7: test a demonstrably personal plan against the library.")
ext("C267", " Report 68 (Ultiself): objections to AI-made design and text appear only in 2026 (NEG_AI_CONTENT 8) — the same era the app adds AI-assisted plans.")
ext("C061", " Report 68 (Ultiself): the free tracker is what earns the praise — 'Free Version is Great' and 'Best habit tracker I've come across' (19 votes each, the most-voted reviews); 'I find the basic non-paid version to be plenty' (PR_FREE 26); only 2 of 408 purchasers mention liking the free version as the path to paying.")
ext("C134", " Report 68 (Ultiself): outside E5 47.3% praise something specific — ease of use (255), design (148), tracking (119), library with sources (90: 'large library of habits plus corresponding sources'), routines (78), reminders (68), insights (63); §8.9 keep them.")
ext("C095", " Report 68 (Ultiself): PR_GRACE 75 — 'doesn't make me feel bad when I mess up' — gentler than other trackers.")
ext("C127", " Report 68 (Ultiself): 'I bought a lifetime premium account but I don't get everything'; 'To do that, you have to pay yet another $40'; 'After subscribing, lets you PAY AGAIN' — MON_TIER_TRAP 24 (peak 4.6% in 2023), MON_UPSELL 80 predating the billing wave.")
ext("C089", " Report 68 (Ultiself): a 2022 Sweatcoin promotion for lifetime access brought users who were then asked to pay.")
ext("C065", " Report 68 (Ultiself): 331 of 392 deliberate purchasers (84.4%) carry a billing complaint and 26 (6.6%) rate 4–5★; refund requests 221 (4.90%): refused or ignored 120, received 27 (18 in 2026), partial 4 — 69.7% driven by a charge the reviewer did not expect, not dissatisfaction with the app.")
ext("C036", " Report 68 (Ultiself): SUP_NONE 352 (7.80%; 20.8% of the Dec 2024 → Mar 2025 era); replies that seem automated ('the bot responds with nonsense'); in 2026 fast named replies with refunds lifted PR_SUPPORT to 5.0% of reviews — refunds reported in 1★ reviews stayed 1★.")
ext("C059", " Report 68 (Ultiself): named agents answering within hours ('Nick responded within hours. He canceled my subscription, issued a refund…') converted complainants — but partly via gifts and review requests (see C054).")
ext("C031", " Report 68 (Ultiself): on 2023-01-04, 13 reviews in one day, 12 saying the app would not load ('App won't even open'; 'the app support link on the App Store also doesn't work'); BUG_LAUNCH 10.7% of that era.")
ext("C033", " Report 68 (Ultiself): paid access never unlocked (BUG_PURCHASE 18) and login failures often after a web purchase (BUG_LOGIN 41).")
ext("C085", " Report 68 (Ultiself): PRIV_DATA 18 treat the stored card as the risk — 'must delete your credit card after'.")
ext("C021", " Report 68 (Ultiself): Apple Health integration and automatic tracking are the long-term users' top asks (REQ_HEALTH 9, REQ_AUTO_TRACK 2); §8.8.")
ext("C073", " Report 68 (Ultiself): 'sort those habits chronologically' — REQ_REORDER 7.")
ext("C016", " Report 68 (Ultiself): 'flagging a day as sick day' (4★).")
ext("C182", " Report 68 (Ultiself): purchases are triggered by an ad and a cheap intro plan ('I signed up for this app via an instagram ad and paid £7 for one course'; MKT_AD lift 6.26× among purchasers) and by a problem the ad sold (add-ons 10.14×), rarely by the free tracker.")
ext("C187", " Report 68 (Ultiself): ad → web questionnaire → paid plan by card, Apple Pay or PayPal across 106 storefronts; billing complaints 63.0% of reviews in the Dec 2024 → Mar 2025 era as Ukraine, Belarus and Kazakhstan became major sources.")
ext("C062", " Report 68 (Ultiself): the US (724, 3.73; 3.39 outside E5; public 4.33) is 24.9% billing complaint against 48.1% in Ukraine and 56.8% in Belarus.")
ext("C002", " Report 68 (Ultiself): era means 3.34 → 2.42 (launch failure, tier traps) → 2.99 (web billing) → 2.23 (billing collapse) → 4.03 (five-star wave) → 3.34 (named agents) — the dips track billing mechanics and the peak tracks a review campaign.")
ext("C184", " Report 68 (Ultiself): 'not designed with women in mind at all' (NEG_INCLUSIVE 2) on a biohacker-branded app.")

M = {
 "R68-001":["C218","C210"], "R68-002":["C231"], "R68-003":["C076","C231"], "R68-004":["C210","C112","C029","C218"], "R68-005":["C285","C274"],
 "R68-006":["C109","C113","C152","C221"], "R68-007":["C029","C085"], "R68-008":["C054","C287","C036","C059"], "R68-009":["C148","C103"], "R68-010":["C061","C134","C095"],
 "R68-011":["C103","C134"], "R68-012":["C214","C056","C267","C148","C184"], "R68-013":["C286","C027"], "R68-014":["C031","C210","C033"], "R68-015":["C021","C073","C043","C016","C063"],
 "R68-016":["C231","C002"], "R68-017":["C127","C089","C003"], "R68-018":["C112","C029"], "R68-019":["C231","C076"], "R68-020":["C231","C094"],
 "R68-021":["C065","C182","C212","C148"], "R68-022":["C147","C063","C109","C113"], "R68-023":["C231","C062"],
 "R68-044":["C231","C062"], "R68-045":["C286","C076"], "R68-046":["C231","C076"], "R68-047":["C002","C104","C031","C076"], "R68-048":["C002","C029"],
 "R68-049":["C061","C134","C036"], "R68-050":["C231","C036"], "R68-051":["C231"], "R68-052":["C287","C036"], "R68-053":["C210","C152","C286"],
}
# storefront cards: 024 us, 025 ua, 026 kz, 027 gb, 028 fr, 029 de, 030 es, 031 ca, 032 pl, 033 mx, 034 it, 035 au, 036 co, 037 by, 038 il, 039 br, 040 ar, 041 cl, 042 ng, 043 ae
M.update({
 "R68-024":["C231","C062","C127"], "R68-025":["C231","C210","C286"], "R68-026":["C231","C076","C286"], "R68-027":["C231","C287"], "R68-028":["C231","C113"],
 "R68-029":["C231","C210"], "R68-030":["C231","C147"], "R68-031":["C231","C134"], "R68-032":["C231","C112"], "R68-033":["C231","C089","C094"],
 "R68-034":["C231","C109"], "R68-035":["C231","C214","C287"], "R68-036":["C231","C212"], "R68-037":["C231","C210"], "R68-038":["C231","C076"],
 "R68-039":["C231","C113"], "R68-040":["C231","C113"], "R68-041":["C231","C112","C285"], "R68-042":["C231","C076","C054"], "R68-043":["C231","C029","C187"],
})
cards = [json.loads(l) for l in open("Tools/prd_ledger/68/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/68/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached: {null}")
print("unbacked:", [x["id"] for x in C.values() if "Report 68" in x["statement"] and not any(k.startswith("R68-") for k in x["cards"])])
