# -*- coding: utf-8 -*-
"""Stage 3 merge for report 75 (Habit Streak | Daily Tracker, Adrien Blanc)."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C293", "product-rule", "Raising a free habit cap by a couple of slots does not buy back sentiment — the objection re-forms at the new number; change what the cap gates or when it is hit, and instrument it",
    "Report 75 (Habit Streak, 41 reviews): v1.56.0 (2025-10-21) raised the free tier from 3 to 5 habits with the release note 'You asked, we listened' — the corpus confirms the change (three reviewers report 3 before it, two report 5 after, never both) and measures no benefit: money-negative share flat 33.3% → 35.3%, cap objections flat 2 → 2, mean rating 4.28 → 3.53, 1–3★ share 16.7% → 41.2%, and the tone hardened from 3–4★ with volunteered praise ('which is unfortunate… other than that, I would recommend!') to two 1★ ('se stupide'; 'Pff franchement c est soulant'); at n=17/18 the differences are not statistically separable, but 'the objection survived the concession in identical form, at the new number… Anyone proposing to move it to 7 should know that the last move bought nothing measurable'; the best-argued complaint asks to gate features, not habit count ('faite le gratuit ça et mettez des trucs premium en plus'); §8.2 do not raise the cap again as a sentiment fix. Related: [[C007]] (generous fixed cap), [[C133]] (gate on capability not quantity), [[C222]] (hard cap with a pressure valve), [[C270]] (earned capacity).")

ext("C007", " Report 75 (Habit Streak): a 3-habit free cap raised to 5 in Oct 2025 ('You asked, we listened') — cap objections stayed at 2 per era and turned from polite 3–4★ to hostile 1★ at the new number; 5 of 5 1★ reviews are about money and nothing else, four praising the product in the same sentence; a user reached a one-month streak on the free tier and called 3 'perfette per iniziare'.")
ext("C133", " Report 75 (Habit Streak): 'not one person names a premium capability other than more habits' in 41 reviews — 'the paywall is being read as a quantity gate rather than a value gate'; E1: A/B unlimited habits with premium features gated against the current cap; §8.1 #4 show what Premium unlocks besides more habits — 'if there are not, the offer is a quantity gate and reads as one'.")
ext("C147", " Report 75 (Habit Streak): the 'everything is paid' reactions (4, mean 2.50: 'Pretty useless unless you pay money'; deleted after ten minutes, titled 'Tư bản' — Capitalist) come from users who bounced within minutes although the free tier permits five habits — the cap 'is hit at setup, before value is felt'; hypothesis: 'the people most likely to pay are the ones who got value free first'; E2: enforce the cap at day 14 rather than at setup.")
ext("C236", " Report 75 (Habit Streak): the App Store description never states a habit-count limit, names only subscriptions, and omits the $79.99 lifetime — two reviewers say they were not warned ('il aurait pu prévenir que c'était payant'; 'man muss Geld ausgeben um die App zu benutzen, wenn nicht klärt mich bitte auf den die App wirkt perfekt' — a 2★ from a confused user calling the app perfect); §8.1 #1 'Track up to 5 habits free, forever' in the description and first onboarding screen — 'Zero engineering cost', addressing 8 of 11 low ratings; E3 disclose and measure the 1★ rate — 'the current listing makes the honest version of it impossible to test at all'.")
ext("C218", " Report 75 (Habit Streak): the description says 'Subscription options are: 1 month and 1 year with 7 days of free trial' while the IAP table sells a 'Premium Lifetime $79.99' — 'One of the two is wrong'; the cap the corpus complains about most appears on neither surface.")
ext("C177", " Report 75 (Habit Streak): nine SKUs from $1.99 to $79.99, six named only 'Premium' or 'Premium access' with no period — 'A shopper cannot tell from the listing whether Premium — $11.99 is a month, a year or forever'; §8.1 #2 rename them (no reviewer complains — an external observation).")
ext("C104", " Report 75 (Habit Streak): a free, ad-free app ('For a free app without adds, this is great', 2024-07-28) acquired a paywall by 2024-09-19 ('App payante désormais… dommage qu'elle soit devenue payante', 1★); money complaints went from 0 of 6 pre-paywall to roughly a third of every era since, the last review in the corpus (2026-07-15) being one — 'a steady state, not a spent event'.")
ext("C002", " Report 75 (Habit Streak): 36 of 41 (87.80%) praise the product, including 9 of 12 money complainers and 4 of 5 1★; means 4.50 → 4.28 → 3.53 across free → 3-cap → 5-cap eras while praise themes persist unchanged — 'the rating damage in this corpus is not being caused by the product'.")
ext("C064", " Report 75 (Habit Streak): price level (4, mean 3.50: 'like 11 Dollars… I would download it then delete it'; 'man muss zu viel bezahlen') vs structure (7, mean 2.29) — structure carries all the hostile language; one defends the price against 'apps that charge up to $70 a year'.")
ext("C023", " Report 75 (Habit Streak): three of the first six reviews asked for a widget; it shipped by May 2025; demand then moved up the stack — complete a habit from the widget ('aus dem Widget heraus… als erledigt markieren'), the streak on the Lock Screen ('el fuego con el numero de días… en la pantalla bloqueada'), milestone widget art at 7 / 30 / 60 / 90 days citing chess.com; 8 of 41 (19.51%, cohort mean 4.75) touch the widget — 'the retention surface'; what users want on it is the streak number itself.")
ext("C119", " Report 75 (Habit Streak): the v1.57.1 'fresh look' widget redesign (2025-10-26) drew a 5★ asking for the old one back — 'earlier version of widget was very attractive. light screen and fire icon can you please bring that back'; widget demand climbed back from 5.6% to 23.5% of reviews; §8.3 #1 restore the look or offer it as a style option.")
ext("C010", " Report 75 (Habit Streak): no backfill — 'j'ai commencé une habitude il y a une semaine et pour l'instant j'ai 0 % de réussite… j'ai pas la possibilité de marquer ce que j'ai fait avant… ça me décourage' (5★, the only helpful-voted review, asking twice for a reply) — 'the only request in the corpus that is demonstrably causing disengagement'; E5 measure D7 retention of users who backfill.")
ext("C038", " Report 75 (Habit Streak): 'Have a 6 day streak and it says day 4. Best streak says 5, current streak says 4… it just frustrates you instead of encourages you' (2★) — three mutually inconsistent numbers on the one metric the product exists to show, the highest-severity open defect; with the no-backfill 0% case: 'the app's record of what the user did disagrees with the user's own record, and the app wins'.")
ext("C031", " Report 75 (Habit Streak): a crash on launch four weeks after release from a user who had 'really loved the simple, easy design' — the only blocking defect; no later crash report; defects 1 → 3 → 1 by era, none since 2026-01-08.")
ext("C006", " Report 75 (Habit Streak): simplicity 11 (26.83%, 4.64) stated comparatively — 'What sets apart this habit tracker app from the rest is its simplicity'; 'simple y sin ruido'; 'J'ai testé plein d'apps… (atoms, etc…) et celle ci remplit mieux mes attentes que toutes les autres'; fit 9 (21.95%, 4.89: 'So eine App hat gefehlt!'); a social request is 'lowest confidence… it cuts against the simplicity that 11 reviewers praise'.")
ext("C070", " Report 75 (Habit Streak): two users independently arrived wanting 'Duolingo's streak, for anything' — 'Ho scoperto il concetto di strike con Duolingo… Per questo motivo cercavo un'app simile'; 'just like Duolingo, except super simple and you can use any habit you want' — 'a positioning gift'; chess.com's widget cited as a milestone-art model; §8.4 lead with it.")
ext("C005", " Report 75 (Habit Streak): competitors named — atoms, Duolingo (as the streak model), 'apps that charge up to $70 a year'; category fatigue in a 1★: 'Deçu comme tout les apps de routines'.")
ext("C101", " Report 75 (Habit Streak): streak-milestone visuals requested (background changes at 7, 30, 60, 90 days, citing chess.com) — reinforces the Duolingo mental model users arrive with.")
ext("C252", " Report 75 (Habit Streak): 'möchte ich aus dem Widget heraus meine Gewohnheiten als erledigt markieren' — completing from the widget 'removes an app-open from the daily loop — the highest-frequency interaction in the product'.")
ext("C059", " Report 75 (Habit Streak): three reviewers addressed the developer directly with no visible reply — a 2★ who calls the app 'perfekt' asks 'klärt mich bitte auf'; 'The 2★ one would very likely convert to a higher rating on a one-sentence answer'.")
ext("C231", " Report 75 (Habit Streak): 41 text reviews on 451 public ratings — ratings-weighted 4.67 vs corpus 4.00 (France −1.34: 3.40 vs 4.74); 4 of 25 5★ carry a monetization objection and two are wholly negative in substance ('Me gustaría que fuera gratuito', author handle 'Gratuito porfa') — 'Star rating is unreliable as a sentiment proxy in this corpus'; gb and jp rate but write nothing.")
ext("C062", " Report 75 (Habit Streak): money complaints are slightly more common in the high-spend group (31.0%) than the rest (25.0%) and the two most hostile cap complaints are French (France: 4 of 5 1★, the largest public base, the widest gap) — 'price sensitivity is an emerging-markets problem is not supported here'; the one affordability statement is from Somalia via the ST storefront (n=1).")
ext("C085", " Report 75 (Habit Streak): zero privacy, sync, account or data-loss complaints, consistent with 'stored securely on your device—no sign-ups or cloud storage required'.")
ext("C246", " Report 75 (Habit Streak): 'For a free app without adds, this is great' — the only ad mention is praise.")
ext("C027", " Report 75 (Habit Streak): 22 localisations and 24 of 41 non-English reviews, zero localisation complaints; 10 reviews written in English from non-English storefronts.")
ext("C065", " Report 75 (Habit Streak): zero self-identified purchasers in 41 reviews — 'this corpus cannot see the post-purchase funnel at all'; §8.6 instrument conversion, refunds and churn 'because the next version of this analysis should not have to say no purchase evidence exists'.")
ext("C172", " Report 75 (Habit Streak): a daily note / journal and completion timestamps requested by one 4★.")
ext("C011", " Report 75 (Habit Streak): more statistics requested (Apr 2025); an Insights screen with weekly / monthly / yearly views and a heatmap shipped in v1.57.1 six months later — no review mentions it.")
ext("C264", " Report 75 (Habit Streak): 'Porque deshabilitado la opción de pulsar para check el hábito' (5★, tap-to-check unavailable) and a request for an auto-check-with-undo mode — both about reducing the friction of the daily tick.")

M = {
 "R75-001":["C133","C177","C218"], "R75-002":["C231"], "R75-003":["C065","C231"], "R75-004":["C002","C007"], "R75-005":["C293","C007"],
 "R75-006":["C236","C218","C177"], "R75-007":["C064","C147","C133"], "R75-008":["C006","C070","C005"], "R75-009":["C007","C061","C147"], "R75-010":["C023","C119","C252","C101"],
 "R75-011":["C010","C038"], "R75-012":["C038","C031","C264"], "R75-013":["C177","C218","C133"], "R75-014":["C231"], "R75-015":["C231","C094"],
 "R75-016":["C085","C246","C027"], "R75-017":["C059","C005"], "R75-018":["C011","C172","C264","C202"], "R75-019":["C231","C002"], "R75-020":["C147","C133","C293"],
 "R75-021":["C062","C231"], "R75-022":["C104","C002","C031"], "R75-023":["C236","C177","C119","C038"], "R75-024":["C293"], "R75-025":["C065","C011"],
 "R75-026":["C134","C070","C006"], "R75-027":["C293","C059"], "R75-028":["C062","C025"], "R75-029":["C119","C023"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/75/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/75/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached: {null}")
print("unbacked:", [x["id"] for x in C.values() if "Report 75" in x["statement"] and not any(k.startswith("R75-") for k in x["cards"])])
