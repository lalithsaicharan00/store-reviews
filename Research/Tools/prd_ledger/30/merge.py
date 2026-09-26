"""Stage 3 merge for report 30."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C244","dont","Never seed the launch rating with templated or bought reviews — the rating decays and the markets they cover become unmeasurable","Report 30: 83 of 166 reviews (50%) matched a five-phrase list across languages ('I highly recommend it' / 'so simple, perfect' / 'the best one'…), all 5★, in two dated campaigns (EN Jul–Sep 2025, ES/NL Nov–Dec 2025), including a Dutch sentence concatenating all five phrases posted on the Russian storefront. When the campaigns stopped, the half-year mean fell 4.65 → 3.17 → 3.00 and the organic 1★ rate rose 12.5% → 44.4%; the US storefront (31 reviews, all 5★, 22 templated) and GB (nothing after the campaign) became commercially blind — the highest-spend markets yielded 8 substantive reviews averaging 3.50 against a 4.79 headline. The public rating is a decaying artefact, not an asset.")
add("C245","must-never-break","Every SKU delivers exactly what its label says — one clear shelf, a working monthly option, and 'lifetime' that is lifetime","Report 30: four SKUs (Monthly $5.99, Yearly $44.99, a second Yearly $29.99, Lifetime $59.99) and five of the six reviewers who reached payment had a bad outcome — charged with premium never unlocking (treated as a P0), the monthly plan unpurchasable ('it charges for a year'), 'Te dicen que es de por vida el plan y es solo para un año' (lifetime delivered as annual — 'Cuidado, engañan'), an annual charge with no trial, an accidental subscription with no refund route; all four purchase-flow defects are 2026 events. Collapse the shelf and audit entitlement delivery end to end.")

ext("C007", " Report 30: a 2-habit free cap (raised to 3 by Apr 2026) is the defining problem of a minimalist tracker — 15 reviews (9.04%, mean 2.00), 31.9% of substantive reviews, 8 of 19 one-stars and all three two-stars; 'if the app is about habits, allowing only 2 is too much'; 'it should be at least 5 free habit entry'; 'It would be smarter to create attractive features that persuade the user to pay rather than limiting tracking to a mere two'; the 2 → 3 raise changed nothing (same rate, same ratings) — an increment below the evaluability threshold does not help; the report's fix is at least 5 free and monetising depth instead of count.")
ext("C147", " Report 30: 'nobody forms a habit portfolio of two — the cap converts evaluation into rejection'; the cap, not price, is the top upgrade barrier (15), and the substantive rating of everyone with something specific to say is 2.87.")
ext("C133", " Report 30: 'Quer cobrar? Coloque algumas versões na versão pro. Não faz sentido deixar cadastrar 2 habitos' — users themselves ask to monetise depth (widget, sync, themes, history, stats) rather than habit count; a 2★ says the price is fine ('ce n'est pas cher') and still rates 2★ for the cap — the cleanest evidence the cap, not the price, produces low ratings.")
ext("C002", " Report 30: 16 of 19 one-star reviews (84%) are monetisation or billing and only 3 describe a defect — 'the app is rated down for its business model; engineering work will not move this rating, packaging will'; the organic 1★ rate rose 12.5% → 44.4% as complaints migrated from 'it's broken' (crashes gone after Jul 2025) to 'it's not worth paying for'.")
ext("C064", " Report 30: the price objection (5, mean 1.40) is price ÷ what you get free — 'Es un check list CARÍSIMO'; 'The price is too high for this quality'; 'para ser de pago es demasiado simple' — while three say the price itself is acceptable, two of them rating 1★/2★ for the cap; 'do not cut the price'.")
ext("C214", " Report 30: every reviewer calling the app 'too basic' also objects to paying — 'a value complaint wearing a feature costume'; do not add features in response.")
ext("C006", " Report 30: minimalism is the only attribute volunteered unprompted (23, 13.86%, mean 5.00; organic 14 — 'minimalist, no unnecessary junk'; 'Good app, minimalistic, effective'), and 'too basic' comes only from people objecting to price — add habit slots, not surface area.")
ext("C178", " Report 30: 'понятный и удобный интерфейс. Без заморочек' — a minimalist tracker's one proven strength; the thesis works and the packaging fails.")
ext("C040", " Report 30: the Home Screen widget is paywalled and a documented switch followed — 'I downloaded it only for the widget. Turned out it's a paid feature… competitors include it free — I went there'; the widget shown in the store screenshots is not the widget the app provides; the one user who has it is the happiest reviewer.")
ext("C107", " Report 30 (counter-evidence): a paid widget in a capped tracker lost a user to a competitor with a free widget and is the only named paid feature besides more habits; the report proposes testing widget free vs paid as an acquisition driver.")
ext("C218", " Report 30: the listing still says 'Track up to 2 habits' after the cap became 3, the advertised streak/interactive widget is not the shipped widget, and one reviewer says the IAP was not visible at the decision point — correct the listing to remove expectation-mismatch 1★.")
ext("C063", " Report 30: 'I paid the anual subscription… It doesn't have a trial version and it wasn't what I was looking for' (1★); 'before buying something you should be able to try it' (1★); one 3★ could not tell whether the app was paid or free — introduce a trial or a reversible first purchase.")
ext("C109", " Report 30: no trial at all, so an annual charge is the first real use.")
ext("C033", " Report 30: 'Списаны деньги за подписку, премиум функция не открылась' — charged with premium never unlocked — 'unambiguously a bug and should be treated as a P0 incident, not a review'; both billing failures are Russian, the only market with continuous purchase attempts.")
ext("C113", " Report 30: two yearly SKUs at different prices ($44.99 and $29.99) beside a $59.99 Lifetime produced 'they tell you the plan is for life and it's only for a year'; the monthly option could not be bought ('it charges for a year').")
ext("C112", " Report 30: an accidental subscription with no route to a refund (MX, 1★) — the reviewer blames the app even where the flow is Apple's.")
ext("C212", " Report 30: 'quise cancelar suscripción… no puedo recuperar el dinero' — a refund dead end for an accidental subscription.")
ext("C065", " Report 30: of the six reviewers who reached payment, five had a bad outcome and none describes a satisfactory purchase; the corpus cannot see quiet happy payers.")
ext("C043", " Report 30: non-daily scheduling (days of week, x per week, weekly, monthly) is the only feature gap with multi-market evidence — 4 storefronts, 4 languages — and the only build item the report supports.")
ext("C016", " Report 30: there is no habit end-date, so deleting a finished habit wipes its history, and Skip breaks the daily completion ring so users feel they failed a day they completed — one frequency + end-date feature closes both.")
ext("C041", " Report 30: the only way to stop a finished habit is to delete it, which destroys its history.")
ext("C142", " Report 30: edit / delete / pause exist and three reviewers in three countries could not find them ('how do you pause a habit? how do you edit? I've looked everywhere'), one rating 1★ — a discoverability defect, not a missing feature.")
ext("C228", " Report 30: the onboarding name field rejected Arabic input — 'it won't accept any name' — 2 of 3 Saudi reviews, both 1★; a hard block at first launch for an entire locale.")
ext("C031", " Report 30: two launch-week crashes (Jul 2025, 'It just doesn't open… on iOS 18.5 and on the iOS 26 beta') and none in the following 13 months.")
ext("C083", " Report 30: above ~10 habits the list jumps back to the top after every tick and rows cannot be made denser — a defect that only paying users hit; fix it before raising the cap.")
ext("C119", " Report 30: add a compact list density — rows too large once habit count grows.")
ext("C094", " Report 30: 83 templated 5★ reviews and a near-absence of 2–3★ (7 of 166) consistent with a prompt routing satisfied users to the store; the public 4.4★ is a decaying artefact.")
ext("C076", " Report 30: two dated phrase-bank campaigns seeded 50% of all reviews; when they stopped the rating fell toward 3.0★ and the organic 1★ rate tripled.")
ext("C062", " Report 30 (fifth corpus): the high-spend group (US, GB, FR, DE, JP, KR — 58 reviews) is 67% templated and yields 8 substantive reviews at mean 3.50 vs a 4.79 headline; volume and signal are inversely related — the long tail (36 reviews, 69% substantive) carries the real signal: 47.2% monetisation complaints at mean 3.19.")
ext("C231", " Report 30: Russia is the product's real market (only continuous 13-month stream, most purchase attempts, most nuanced feedback, substantive mean 3.20) and where the payment flow is visibly breaking; Spanish-language organic reviews (AR/MX/UY, 0/6 templated, mean 2.33) are the harshest in the corpus while ES/CL are 16/24 templated at 4.75.")
ext("C005", " Report 30: a user left for a competitor whose widget is free.")
ext("C059", " Report 30 (counter-evidence): the developer's response to the cap complaint — one more free habit — did not change the rate or the ratings.")
ext("C039", " Report 30: a user wants an alarm, not just a notification — 'receives an alarm from the app itself and doesn't need another alarm on the phone'.")
ext("C012", " Report 30: per-habit and per-day completion percentages requested; history editing works only within the current month.")
ext("C010", " Report 30: editing history works inside the current month but not for prior months (asked politely by a 5★).")
ext("C027", " Report 30: 13 languages functioning and one explicit localisation compliment from Chile; an Arabic onboarding blocker; 11 reviews in a language not matching their storefront.")
ext("C013", " Report 30: iCloud sync and colour themes are advertised paid features that no reviewer in any market or period mentions.")
ext("C104", " Report 30: the 2 → 3 cap change shipped without the listing being updated.")

M = {
 "R30-003":["C007","C147"], "R30-004":["C002"], "R30-005":["C245","C033","C113","C063"], "R30-006":["C006","C178"], "R30-007":["C064","C133"], "R30-008":["C040","C107","C218"],
 "R30-009":["C043","C016","C041"], "R30-010":["C244","C002"], "R30-011":["C244"], "R30-014":["C007","C040","C218"], "R30-015":["C039","C010","C142","C016","C043","C012"], "R30-016":["C027","C228","C013"],
 "R30-017":["C113","C245"], "R30-018":["C218","C245","C063"], "R30-019":["C244","C094"], "R30-020":["C244","C076"], "R30-021":["C244"], "R30-022":["C002"],
 "R30-024":["C002","C007"], "R30-025":["C031"], "R30-026":["C133","C147"], "R30-028":["C057"], "R30-029":["C214","C064"], "R30-030":["C064"], "R30-031":["C142"], "R30-032":["C063"], "R30-033":["C033","C245"],
 "R30-034":["C218"], "R30-035":["C031"], "R30-036":["C228"], "R30-038":["C006","C178"], "R30-040":["C006"], "R30-041":["C057","C027"], "R30-042":["C007","C147","C133"], "R30-043":["C133","C218"],
 "R30-044":["C214"], "R30-045":["C142"], "R30-046":["C245","C033","C065"], "R30-047":["C228"], "R30-048":["C031"], "R30-049":["C083","C119"], "R30-050":["C043","C016","C012","C010","C039"], "R30-051":["C016","C041"],
 "R30-053":["C006"], "R30-054":["C007","C245"], "R30-056":["C007","C133","C064"], "R30-057":["C002","C007","C245"],
 "R30-058":["C245","C065"], "R30-059":["C007","C107","C013"], "R30-060":["C147","C063","C245"], "R30-061":["C245","C112","C212","C218","C033"],
 "R30-064":["C231","C033"], "R30-065":["C062","C244"], "R30-066":["C062"], "R30-067":["C231"], "R30-068":["C228","C218"], "R30-069":["C062","C002"],
 "R30-070":["C244"], "R30-071":["C007","C059","C218","C104"], "R30-072":["C244","C094"], "R30-073":["C002","C245"], "R30-074":["C002"], "R30-075":["C228"], "R30-076":["C006","C007","C040","C013"],
 "R30-077":["C245","C033"], "R30-078":["C007","C133"], "R30-079":["C228"], "R30-080":["C142"], "R30-081":["C218"], "R30-082":["C063"], "R30-083":["C083","C119"], "R30-084":["C043","C016","C214"],
 "R30-085":["C007","C147"], "R30-086":["C040","C107","C005"], "R30-087":["C113","C245"], "R30-088":["C039"], "R30-090":["C006","C064","C214"],
 "R30-091":["C244","C076"], "R30-092":["C007","C059"],
}
# unattached (nuance register): 001-002 header/method, 011 monthly table, 012 coverage, 013 inventory table, 023 master table, 027 any request,
# 037 single-record rows, 039 convenience, 052 ratings table, 055 3★ band, 062 scope statement, 063 distribution, 089 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/30/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/30/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
