# -*- coding: utf-8 -*-
"""Stage 3 merge for report 69 (Habit Tracker: TheFor, Siraj Hasanov)."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C288", "must-have", "A user who declined notifications at first run must have an in-app way back — detect the denied state, explain it, and deep-link to iOS Settings",
    "Report 69 (TheFor, 80 reviews): 'I unabled notificafions when I first downloaded the app and now I can not activate it on app or system notificafions' (tr, 4★) and 'I am unable to receive any notifications acb you help.? It's really annoying' (in, 1★ — the corpus's only bug-driven 1★); BUG_NOTIF 2 (2.50%, mean 2.50) — few, but each a failure of the whole feature: 'For a habit tracker, a user in this state has a reminder-less product'; F3: detect `denied` authorisation status, show an explanatory row, deep-link to UIApplication.openSettingsURLString — 'a standard, well-understood onboarding bug with a standard fix'. Related: [[C039]] (reminders fire reliably), [[C123]] (notification settings finely controllable).")

ext("C007", " Report 69 (TheFor): the ledger's clearest case of an uncapped free tier as the moat — PAY_FREE_UNLIMITED 10 (12.50%, mean 4.80) naming the competitor behaviour avoided ('a maioria dos apps permitem de 3 a 5 itens de lista e so liberam mais no premium, esse tem quantidade de hábitos ilimitados no plano free'; 'I've been looking for this 😭'); free-offer praise 19 (23.75%, mean 4.89, none below 4★) rising 5.0% → 23.3% → 47.1% of reviews across 2023 / 2024 / 2025–26 as, reviewers say, the category capped at 3–5 — 'The moat is getting more valuable, not less'; zero cap complaints in 3.5 years; M1: publicly commit to unlimited free habits.")
ext("C061", " Report 69 (TheFor): purchases are goodwill, not value exchange — the only stated purchase reason is the design ('clean simple UI loved it thats why purchased the pro plan'), intent is price- or support-led ('the price isn't too much even for my country, so I'll get it'; 'I'm sure to support you… worth every Thai bath'), and no review in 80 describes a single Pro feature — 'fragile in a specific way — it depends on the free tier staying good and the developer staying visible'.")
ext("C133", " Report 69 (TheFor): 'a product whose free tier is its moat has no obvious upgrade ladder that does not damage the moat' — M2: build Pro from additive capability the corpus asks for (sync free for one device / paid for multi-device, automatic backup, deep analytics, Face ID lock), never by removing free capability; a Pro buyer's only request (auto-backup) is not in Pro.")
ext("C001", " Report 69 (TheFor): stats, day history and back-fill reportedly moved behind a subscription in late 2024 — 'You prided yourself on offering a great app with absolutely no payment or prices for subscription for stats … Now you're just like everything else' (a multi-year user, 2★); not corroborated by later reviews, whose free-tier praise rose to 40.0%.")
ext("C234", " Report 69 (TheFor): the one monetization backlash in 80 reviews is a long-tenured user who lost free stats and 'see which days were tracked' to a subscription; the listing still advertises 'Comprehensive Weekly Overview' — M3: audit what is actually gated and reconcile with the listing.")
ext("C262", " Report 69 (TheFor): back-fill of forgotten days praised in 2023 ('you can edit habits from past dates!!') and reported gated in 2024 by a user who then left.")
ext("C013", " Report 69 (TheFor): sync_any 5 (6.25%, mean 4.20) — the corpus's only 3★ ('Love that the free version includes unlimited habits. And the paid version is a great price. However, needs to be able to sync across devices'), two 4★ iPhone ↔ iPad failures, two 5★ 'lack of iCloud sync… a notable drawback'; every one otherwise positive — 'the cheapest kind of rating to recover'; rising 0% → 7.0% → 11.8%; M2 / X1: sync is 'the classic additive premium feature' and Pro's first describable benefit.")
ext("C030", " Report 69 (TheFor): an account system exists but habit data does not follow it — 'i've tried logging on and off and deleting and reinstalling the app but nothing works :/'; 'не могу синхронизировать… iPhone и iPad' (BUG_SYNC 3, mean 3.67).")
ext("C033", " Report 69 (TheFor): 3 of 4 self-stated payers describe a failure (mean 2.75 vs 4.62 for non-payers) — 'I payed for an annual subscription but the app is still prompting me to pay. Hitting restore purchase does not help'; a reinstall that lost the purchase — 22 months apart on two storefronts, 'a persistent weakness in the receipt-validation / restore path'; F1: validate the receipt on launch, never paywall a Pro owner, show entitlement state in-app.")
ext("C034", " Report 69 (TheFor): 'Eu comprei o app. Desinstalei e na hora que fui instalar novamente, sumiu tudo o q estava lá e pediu novamente para comprar' — data and entitlement lost on reinstall (2★); F2: never lose local data on reinstall.")
ext("C153", " Report 69 (TheFor): a Pro purchaser: 'you have to back up you data in case your phone get lost … if auto backup option available on pro plan it wound be batter' — B4: automatic backup inside Pro closes the only paid-user request and mitigates reinstall data loss.")
ext("C065", " Report 69 (TheFor): 'the paid path is the only part of this product with a majority-failure account, and it is the part that generates revenue' (3 of 4 stated payers).")
ext("C038", " Report 69 (TheFor): 'Even though I completed around 75% of my test, only 20%. Why?' (3★, 2026 — the only open bug that year); F4: verify the completion percentage before deepening analytics — 'Deepening a view that computes the wrong number is the wrong order'.")
ext("C012", " Report 69 (TheFor): the heat map is 'quite gimmicky' — tapping a day should show which habits were completed that day (REQ_DAY_DETAIL).")
ext("C011", " Report 69 (TheFor): 'só sinto muita falta de análise de dados, gráficos dos hábitos, como no aplicativo concorrente Ripples' — the only named competitor, named for better charts.")
ext("C023", " Report 69 (TheFor): after the free widget shipped, the next ask (the most recent review, 2026-09-02) is interactive — 'a widget that allows me to see all my habits and their progress and allows me to check them off'; B2.")
ext("C040", " Report 69 (TheFor): widget won't launch the app unless it is already backgrounded, and doesn't show already-completed tasks (BUG_WIDGET 2) — refresh / state bugs on an asset praised at 5.00.")
ext("C009", " Report 69 (TheFor): 'having the free widget is awesome'; WID_GOOD 4 at a perfect 5.00.")
ext("C059", " Report 69 (TheFor): a widget requested by 20% of 2023 reviews shipped by Jan 2024 and requests fell to zero; 'I reported a bug and the developers responded quickly and resolved the bug soon after. A+ response'; 'the developer reacts quickly to feedback' — 'this developer reads reviews and acts on them'.")
ext("C036", " Report 69 (TheFor): the developer answers but cannot be found — 'Unable to contact developer on their website'; 'Let me know if I can email the suggestions'; a 1★ 'Phishing spam scam' demanding cancellation in public — 'a support-surface problem, not a support-quality problem'; F7: an email link in settings and a Manage-subscription row deep-linking to Apple.")
ext("C112", " Report 69 (TheFor): a subscriber used a public 1★ to ask to be unsubscribed and for written confirmation — an Apple-side action the developer cannot perform, but the missing Manage-subscription row is a surface the developer can add.")
ext("C006", " Report 69 (TheFor): design praise 39 (48.75%, mean 4.74), 25 of them for what the app lacks — 'No bloatware, no hassle'; 'No extra junk!'; 'ничего лишнего, только то, что нужно' — 'This is a defended position, not a compliment'; P1: every new capability behind a setting or inside an existing screen — 'nothing on this list should add a tab'.")
ext("C178", " Report 69 (TheFor): 19 reviewers (23.75%, mean 4.84) tried two to ten trackers first and kept this one — 'a habit-tracker refugee… looking for less product, not more'; P2: market relief from other apps, not 'Transform Your Life'.")
ext("C005", " Report 69 (TheFor): 'I've tried almost 10 apps'; 'it's better than so many of the other more expensive paid apps'; the only named competitor is Ripples, for charts.")
ext("C134", " Report 69 (TheFor): the three reasons behind almost every 5★ — it looks good, it has nothing extra, it beat the apps tried before; the listing leads with transformation instead.")
ext("C246", " Report 69 (TheFor): 'Es genial y no tiene anuncios'; zero reviewers report an ad in 80 reviews; M5: do not add ads — they would attack the two largest positive themes at once.")
ext("C093", " Report 69 (TheFor): 'Even better - there's no constant barrage of prompts asking you to upgrade!' — the restraint earns 5★.")
ext("C118", " Report 69 (TheFor): paid 'Routine' packs ($0.99–$2.99) and 'Routine AI' ($2.99) are listed, yet zero of 80 reviews mention buying one; the Explore surface is unfindable to one reviewer and empty to another — M4: make it findable and stocked, or remove it.")
ext("C142", " Report 69 (TheFor): 'I am struggling to find the section of exploring popular routines' (4★).")
ext("C056", " Report 69 (TheFor): a $2.99 'Routine AI' purchase is listed and zero reviews in 3.5 years mention AI in any form.")
ext("C027", " Report 69 (TheFor): English-only — 'No tiene en idioma español. No entiendo inglés.' (1★, the only 1★ with a cause the developer can remove entirely); 17 reviewers (21.25%) wrote in other languages and used it anyway — simplicity makes it usable without localisation; P3: Spanish, then Portuguese (12.5% of reviews).")
ext("C048", " Report 69 (TheFor): a numeric goal set by a scroll wheel capped at 10,000 — 'I want to be able to type the number for my goal instead of having to scroll for a minute'; 'Хотела выставить цель:12000 шагов - максимально выдает 10000' — two independent users two years apart; F6: 'a one-afternoon fix'.")
ext("C017", " Report 69 (TheFor): 'The only thing keeping me from 5 stars is the lack of a passcode and/or face id lock fuction' — one feature, one star, explicitly priced.")
ext("C071", " Report 69 (TheFor): no update for ~9 months (1.4.6, 2025-12-21) while reviews fell 43 → 13 → 4 per year; no reviewer yet calls it abandoned, but 'the corpus can no longer detect a new problem quickly'.")
ext("C231", " Report 69 (TheFor): a positive-skew corpus — 71.25% 5★, written 4.525 against ~4.87 US public on a 30% write rate; storefront inversions (za 2.50 vs 4.40; de 5.00 vs 4.13) each explained by one or two reviews; 29 probed storefronts with zero reviews read as absent distribution, not rejection.")
ext("C042", " Report 69 (TheFor): one ADHD reviewer ('Finding this app though CHANGED the game') on an app whose listing never mentions ADHD — 'do not build an ADHD strategy on a single review'.")
ext("C218", " Report 69 (TheFor): the subtitle leads with 'Journal' while the listing body never mentions journaling and one reviewer uses it — P4: make it visible or stop leading with it; 'Unlimited Habit Creation' is a listing promise the corpus confirms is kept.")
ext("C097", " Report 69 (TheFor): intent to buy framed as supporting the developer — 'I'm sure to support you, and I believe it's worth every Thai bath'.")

M = {
 "R69-001":["C218","C006"], "R69-002":["C231"], "R69-003":["C231","C065"], "R69-004":["C007","C061","C133"], "R69-005":["C013","C030","C141"],
 "R69-006":["C033","C034","C065","C153"], "R69-007":["C288","C039"], "R69-008":["C038","C012","C011","C234"], "R69-009":["C059","C023","C040","C009"], "R69-010":["C001","C234","C262","C133"],
 "R69-011":["C118","C142","C056"], "R69-012":["C178","C005","C006"], "R69-013":["C006","C134"], "R69-014":["C246","C093"], "R69-015":["C036","C112"],
 "R69-016":["C027"], "R69-017":["C006","C020","C171"], "R69-018":["C231"], "R69-019":["C231"], "R69-020":["C048"],
 "R69-021":["C017","C153","C048"], "R69-022":["C065","C031","C038"], "R69-023":["C061","C097","C133","C064"], "R69-024":["C153","C133","C017"], "R69-025":["C231"],
 "R69-026":["C231","C062"], "R69-027":["C071","C231"], "R69-028":["C071","C059"], "R69-029":["C042"], "R69-030":["C218"],
 "R69-031":["C033","C288","C013","C133"], "R69-032":["C133","C171"], "R69-033":["C007","C231"], "R69-034":["C059","C009"], "R69-035":["C001","C234"],
 "R69-036":["C133","C006","C001"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/69/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/69/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached: {null}")
print("unbacked:", [x["id"] for x in C.values() if "Report 69" in x["statement"] and not any(k.startswith("R69-") for k in x["cards"])])
